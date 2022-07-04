

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


'' @REGISTER : AN_X4_SW_MANAGEMENT_SGMIIPLUSR_X1_ld_page_2_sgmiiplusr_x1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LP2SX1PD                                   [15:0]           get_LP2SX1PD
''                                                             set_LP2SX1PD
''                                                             read_LP2SX1PD
''                                                             write_LP2SX1PD
''---------------------------------------------------------------------------------
Class REGISTER_AN_X4_SW_MANAGEMENT_SGMIIPLUSR_X1_ld_page_2_sgmiiplusr_x1
    Private write_LP2SX1PD_value
    Private read_LP2SX1PD_value
    Private flag_LP2SX1PD

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

    Property Get get_LP2SX1PD
        get_LP2SX1PD = read_LP2SX1PD_value
    End Property

    Property Let set_LP2SX1PD(aData)
        write_LP2SX1PD_value = aData
        flag_LP2SX1PD        = &H1
    End Property

    Property Get read_LP2SX1PD
        read
        read_LP2SX1PD = read_LP2SX1PD_value
    End Property

    Property Let write_LP2SX1PD(aData)
        set_LP2SX1PD = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LP2SX1PD_mask = &Hffff
        if data_low > LONG_MAX then
            if LP2SX1PD_mask = mask then
                read_LP2SX1PD_value = data_low
            else
                read_LP2SX1PD_value = (data_low - H8000_0000) and LP2SX1PD_mask
            end If
        else
            read_LP2SX1PD_value = data_low and LP2SX1PD_mask
        end If

    End Sub

    Sub write
        If flag_LP2SX1PD = &H0 Then read
        If flag_LP2SX1PD = &H0 Then write_LP2SX1PD_value = get_LP2SX1PD

        regValue = leftShift((write_LP2SX1PD_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LP2SX1PD_mask = &Hffff
        if data_low > LONG_MAX then
            if LP2SX1PD_mask = mask then
                read_LP2SX1PD_value = data_low
            else
                read_LP2SX1PD_value = (data_low - H8000_0000) and LP2SX1PD_mask
            end If
        else
            read_LP2SX1PD_value = data_low and LP2SX1PD_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LP2SX1PD_value = &H0
        flag_LP2SX1PD        = &H0
    End Sub
End Class


'' @REGISTER : AN_X4_SW_MANAGEMENT_SGMIIPLUSR_X1_ld_page_1_sgmiiplusr_x1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LP1SX1PD                                   [15:0]           get_LP1SX1PD
''                                                             set_LP1SX1PD
''                                                             read_LP1SX1PD
''                                                             write_LP1SX1PD
''---------------------------------------------------------------------------------
Class REGISTER_AN_X4_SW_MANAGEMENT_SGMIIPLUSR_X1_ld_page_1_sgmiiplusr_x1
    Private write_LP1SX1PD_value
    Private read_LP1SX1PD_value
    Private flag_LP1SX1PD

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

    Property Get get_LP1SX1PD
        get_LP1SX1PD = read_LP1SX1PD_value
    End Property

    Property Let set_LP1SX1PD(aData)
        write_LP1SX1PD_value = aData
        flag_LP1SX1PD        = &H1
    End Property

    Property Get read_LP1SX1PD
        read
        read_LP1SX1PD = read_LP1SX1PD_value
    End Property

    Property Let write_LP1SX1PD(aData)
        set_LP1SX1PD = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LP1SX1PD_mask = &Hffff
        if data_low > LONG_MAX then
            if LP1SX1PD_mask = mask then
                read_LP1SX1PD_value = data_low
            else
                read_LP1SX1PD_value = (data_low - H8000_0000) and LP1SX1PD_mask
            end If
        else
            read_LP1SX1PD_value = data_low and LP1SX1PD_mask
        end If

    End Sub

    Sub write
        If flag_LP1SX1PD = &H0 Then read
        If flag_LP1SX1PD = &H0 Then write_LP1SX1PD_value = get_LP1SX1PD

        regValue = leftShift((write_LP1SX1PD_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LP1SX1PD_mask = &Hffff
        if data_low > LONG_MAX then
            if LP1SX1PD_mask = mask then
                read_LP1SX1PD_value = data_low
            else
                read_LP1SX1PD_value = (data_low - H8000_0000) and LP1SX1PD_mask
            end If
        else
            read_LP1SX1PD_value = data_low and LP1SX1PD_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LP1SX1PD_value = &H0
        flag_LP1SX1PD        = &H0
    End Sub
End Class


'' @REGISTER : AN_X4_SW_MANAGEMENT_SGMIIPLUSR_X1_ld_page_0_sgmiiplusr_x1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LP0SX1PD                                   [15:0]           get_LP0SX1PD
''                                                             set_LP0SX1PD
''                                                             read_LP0SX1PD
''                                                             write_LP0SX1PD
''---------------------------------------------------------------------------------
Class REGISTER_AN_X4_SW_MANAGEMENT_SGMIIPLUSR_X1_ld_page_0_sgmiiplusr_x1
    Private write_LP0SX1PD_value
    Private read_LP0SX1PD_value
    Private flag_LP0SX1PD

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

    Property Get get_LP0SX1PD
        get_LP0SX1PD = read_LP0SX1PD_value
    End Property

    Property Let set_LP0SX1PD(aData)
        write_LP0SX1PD_value = aData
        flag_LP0SX1PD        = &H1
    End Property

    Property Get read_LP0SX1PD
        read
        read_LP0SX1PD = read_LP0SX1PD_value
    End Property

    Property Let write_LP0SX1PD(aData)
        set_LP0SX1PD = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LP0SX1PD_mask = &Hffff
        if data_low > LONG_MAX then
            if LP0SX1PD_mask = mask then
                read_LP0SX1PD_value = data_low
            else
                read_LP0SX1PD_value = (data_low - H8000_0000) and LP0SX1PD_mask
            end If
        else
            read_LP0SX1PD_value = data_low and LP0SX1PD_mask
        end If

    End Sub

    Sub write
        If flag_LP0SX1PD = &H0 Then read
        If flag_LP0SX1PD = &H0 Then write_LP0SX1PD_value = get_LP0SX1PD

        regValue = leftShift((write_LP0SX1PD_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LP0SX1PD_mask = &Hffff
        if data_low > LONG_MAX then
            if LP0SX1PD_mask = mask then
                read_LP0SX1PD_value = data_low
            else
                read_LP0SX1PD_value = (data_low - H8000_0000) and LP0SX1PD_mask
            end If
        else
            read_LP0SX1PD_value = data_low and LP0SX1PD_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LP0SX1PD_value = &H0
        flag_LP0SX1PD        = &H0
    End Sub
End Class


'' @REGISTER : AN_X4_SW_MANAGEMENT_SGMIIPLUSR_X1_lp_page_2_sgmiiplusr_x1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LP2SX1PD                                   [15:0]           get_LP2SX1PD
''                                                             set_LP2SX1PD
''                                                             read_LP2SX1PD
''                                                             write_LP2SX1PD
''---------------------------------------------------------------------------------
Class REGISTER_AN_X4_SW_MANAGEMENT_SGMIIPLUSR_X1_lp_page_2_sgmiiplusr_x1
    Private write_LP2SX1PD_value
    Private read_LP2SX1PD_value
    Private flag_LP2SX1PD

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

    Property Get get_LP2SX1PD
        get_LP2SX1PD = read_LP2SX1PD_value
    End Property

    Property Let set_LP2SX1PD(aData)
        write_LP2SX1PD_value = aData
        flag_LP2SX1PD        = &H1
    End Property

    Property Get read_LP2SX1PD
        read
        read_LP2SX1PD = read_LP2SX1PD_value
    End Property

    Property Let write_LP2SX1PD(aData)
        set_LP2SX1PD = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LP2SX1PD_mask = &Hffff
        if data_low > LONG_MAX then
            if LP2SX1PD_mask = mask then
                read_LP2SX1PD_value = data_low
            else
                read_LP2SX1PD_value = (data_low - H8000_0000) and LP2SX1PD_mask
            end If
        else
            read_LP2SX1PD_value = data_low and LP2SX1PD_mask
        end If

    End Sub

    Sub write
        If flag_LP2SX1PD = &H0 Then read
        If flag_LP2SX1PD = &H0 Then write_LP2SX1PD_value = get_LP2SX1PD

        regValue = leftShift((write_LP2SX1PD_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LP2SX1PD_mask = &Hffff
        if data_low > LONG_MAX then
            if LP2SX1PD_mask = mask then
                read_LP2SX1PD_value = data_low
            else
                read_LP2SX1PD_value = (data_low - H8000_0000) and LP2SX1PD_mask
            end If
        else
            read_LP2SX1PD_value = data_low and LP2SX1PD_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LP2SX1PD_value = &H0
        flag_LP2SX1PD        = &H0
    End Sub
End Class


'' @REGISTER : AN_X4_SW_MANAGEMENT_SGMIIPLUSR_X1_lp_page_1_sgmiiplusr_x1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LP1SX1PD                                   [15:0]           get_LP1SX1PD
''                                                             set_LP1SX1PD
''                                                             read_LP1SX1PD
''                                                             write_LP1SX1PD
''---------------------------------------------------------------------------------
Class REGISTER_AN_X4_SW_MANAGEMENT_SGMIIPLUSR_X1_lp_page_1_sgmiiplusr_x1
    Private write_LP1SX1PD_value
    Private read_LP1SX1PD_value
    Private flag_LP1SX1PD

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

    Property Get get_LP1SX1PD
        get_LP1SX1PD = read_LP1SX1PD_value
    End Property

    Property Let set_LP1SX1PD(aData)
        write_LP1SX1PD_value = aData
        flag_LP1SX1PD        = &H1
    End Property

    Property Get read_LP1SX1PD
        read
        read_LP1SX1PD = read_LP1SX1PD_value
    End Property

    Property Let write_LP1SX1PD(aData)
        set_LP1SX1PD = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LP1SX1PD_mask = &Hffff
        if data_low > LONG_MAX then
            if LP1SX1PD_mask = mask then
                read_LP1SX1PD_value = data_low
            else
                read_LP1SX1PD_value = (data_low - H8000_0000) and LP1SX1PD_mask
            end If
        else
            read_LP1SX1PD_value = data_low and LP1SX1PD_mask
        end If

    End Sub

    Sub write
        If flag_LP1SX1PD = &H0 Then read
        If flag_LP1SX1PD = &H0 Then write_LP1SX1PD_value = get_LP1SX1PD

        regValue = leftShift((write_LP1SX1PD_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LP1SX1PD_mask = &Hffff
        if data_low > LONG_MAX then
            if LP1SX1PD_mask = mask then
                read_LP1SX1PD_value = data_low
            else
                read_LP1SX1PD_value = (data_low - H8000_0000) and LP1SX1PD_mask
            end If
        else
            read_LP1SX1PD_value = data_low and LP1SX1PD_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LP1SX1PD_value = &H0
        flag_LP1SX1PD        = &H0
    End Sub
End Class


'' @REGISTER : AN_X4_SW_MANAGEMENT_SGMIIPLUSR_X1_lp_page_0_sgmiiplusr_x1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LP0SX1PD                                   [15:0]           get_LP0SX1PD
''                                                             set_LP0SX1PD
''                                                             read_LP0SX1PD
''                                                             write_LP0SX1PD
''---------------------------------------------------------------------------------
Class REGISTER_AN_X4_SW_MANAGEMENT_SGMIIPLUSR_X1_lp_page_0_sgmiiplusr_x1
    Private write_LP0SX1PD_value
    Private read_LP0SX1PD_value
    Private flag_LP0SX1PD

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

    Property Get get_LP0SX1PD
        get_LP0SX1PD = read_LP0SX1PD_value
    End Property

    Property Let set_LP0SX1PD(aData)
        write_LP0SX1PD_value = aData
        flag_LP0SX1PD        = &H1
    End Property

    Property Get read_LP0SX1PD
        read
        read_LP0SX1PD = read_LP0SX1PD_value
    End Property

    Property Let write_LP0SX1PD(aData)
        set_LP0SX1PD = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LP0SX1PD_mask = &Hffff
        if data_low > LONG_MAX then
            if LP0SX1PD_mask = mask then
                read_LP0SX1PD_value = data_low
            else
                read_LP0SX1PD_value = (data_low - H8000_0000) and LP0SX1PD_mask
            end If
        else
            read_LP0SX1PD_value = data_low and LP0SX1PD_mask
        end If

    End Sub

    Sub write
        If flag_LP0SX1PD = &H0 Then read
        If flag_LP0SX1PD = &H0 Then write_LP0SX1PD_value = get_LP0SX1PD

        regValue = leftShift((write_LP0SX1PD_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LP0SX1PD_mask = &Hffff
        if data_low > LONG_MAX then
            if LP0SX1PD_mask = mask then
                read_LP0SX1PD_value = data_low
            else
                read_LP0SX1PD_value = (data_low - H8000_0000) and LP0SX1PD_mask
            end If
        else
            read_LP0SX1PD_value = data_low and LP0SX1PD_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LP0SX1PD_value = &H0
        flag_LP0SX1PD        = &H0
    End Sub
End Class


'' @REGISTER : AN_X4_SW_MANAGEMENT_SGMIIPLUSR_X1_sw_control_status_sgmiiplusr_x1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' an_completed_sw                            [2:2]            get_an_completed_sw
''                                                             set_an_completed_sw
''                                                             read_an_completed_sw
''                                                             write_an_completed_sw
''---------------------------------------------------------------------------------
'' LCSX1V                                     [1:1]            get_LCSX1V
''                                                             set_LCSX1V
''                                                             read_LCSX1V
''                                                             write_LCSX1V
''---------------------------------------------------------------------------------
'' lp_status_valid                            [0:0]            get_lp_status_valid
''                                                             set_lp_status_valid
''                                                             read_lp_status_valid
''                                                             write_lp_status_valid
''---------------------------------------------------------------------------------
Class REGISTER_AN_X4_SW_MANAGEMENT_SGMIIPLUSR_X1_sw_control_status_sgmiiplusr_x1
    Private write_an_completed_sw_value
    Private read_an_completed_sw_value
    Private flag_an_completed_sw
    Private write_LCSX1V_value
    Private read_LCSX1V_value
    Private flag_LCSX1V
    Private write_lp_status_valid_value
    Private read_lp_status_valid_value
    Private flag_lp_status_valid

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

    Property Get get_an_completed_sw
        get_an_completed_sw = read_an_completed_sw_value
    End Property

    Property Let set_an_completed_sw(aData)
        write_an_completed_sw_value = aData
        flag_an_completed_sw        = &H1
    End Property

    Property Get read_an_completed_sw
        read
        read_an_completed_sw = read_an_completed_sw_value
    End Property

    Property Let write_an_completed_sw(aData)
        set_an_completed_sw = aData
        write
    End Property

    Property Get get_LCSX1V
        get_LCSX1V = read_LCSX1V_value
    End Property

    Property Let set_LCSX1V(aData)
        write_LCSX1V_value = aData
        flag_LCSX1V        = &H1
    End Property

    Property Get read_LCSX1V
        read
        read_LCSX1V = read_LCSX1V_value
    End Property

    Property Let write_LCSX1V(aData)
        set_LCSX1V = aData
        write
    End Property

    Property Get get_lp_status_valid
        get_lp_status_valid = read_lp_status_valid_value
    End Property

    Property Let set_lp_status_valid(aData)
        write_lp_status_valid_value = aData
        flag_lp_status_valid        = &H1
    End Property

    Property Get read_lp_status_valid
        read
        read_lp_status_valid = read_lp_status_valid_value
    End Property

    Property Let write_lp_status_valid(aData)
        set_lp_status_valid = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_an_completed_sw_value = rightShift(data_low, 2) and &H1
        read_LCSX1V_value = rightShift(data_low, 1) and &H1
        lp_status_valid_mask = &H1
        if data_low > LONG_MAX then
            if lp_status_valid_mask = mask then
                read_lp_status_valid_value = data_low
            else
                read_lp_status_valid_value = (data_low - H8000_0000) and lp_status_valid_mask
            end If
        else
            read_lp_status_valid_value = data_low and lp_status_valid_mask
        end If

    End Sub

    Sub write
        If flag_an_completed_sw = &H0 or flag_LCSX1V = &H0 or flag_lp_status_valid = &H0 Then read
        If flag_an_completed_sw = &H0 Then write_an_completed_sw_value = get_an_completed_sw
        If flag_LCSX1V = &H0 Then write_LCSX1V_value = get_LCSX1V
        If flag_lp_status_valid = &H0 Then write_lp_status_valid_value = get_lp_status_valid

        regValue = leftShift((write_an_completed_sw_value and &H1), 2) + leftShift((write_LCSX1V_value and &H1), 1) + leftShift((write_lp_status_valid_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_an_completed_sw_value = rightShift(data_low, 2) and &H1
        read_LCSX1V_value = rightShift(data_low, 1) and &H1
        lp_status_valid_mask = &H1
        if data_low > LONG_MAX then
            if lp_status_valid_mask = mask then
                read_lp_status_valid_value = data_low
            else
                read_lp_status_valid_value = (data_low - H8000_0000) and lp_status_valid_mask
            end If
        else
            read_lp_status_valid_value = data_low and lp_status_valid_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_an_completed_sw_value = &H0
        flag_an_completed_sw        = &H0
        write_LCSX1V_value = &H0
        flag_LCSX1V        = &H0
        write_lp_status_valid_value = &H0
        flag_lp_status_valid        = &H0
    End Sub
End Class


'' @REGISTER : AN_X4_SW_MANAGEMENT_SGMIIPLUSR_X1_ld_control_sgmiiplusr_x1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SW_AN                                      [1:1]            get_SW_AN
''                                                             set_SW_AN
''                                                             read_SW_AN
''                                                             write_SW_AN
''---------------------------------------------------------------------------------
'' SW_HCD                                     [0:0]            get_SW_HCD
''                                                             set_SW_HCD
''                                                             read_SW_HCD
''                                                             write_SW_HCD
''---------------------------------------------------------------------------------
Class REGISTER_AN_X4_SW_MANAGEMENT_SGMIIPLUSR_X1_ld_control_sgmiiplusr_x1
    Private write_SW_AN_value
    Private read_SW_AN_value
    Private flag_SW_AN
    Private write_SW_HCD_value
    Private read_SW_HCD_value
    Private flag_SW_HCD

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

    Property Get get_SW_AN
        get_SW_AN = read_SW_AN_value
    End Property

    Property Let set_SW_AN(aData)
        write_SW_AN_value = aData
        flag_SW_AN        = &H1
    End Property

    Property Get read_SW_AN
        read
        read_SW_AN = read_SW_AN_value
    End Property

    Property Let write_SW_AN(aData)
        set_SW_AN = aData
        write
    End Property

    Property Get get_SW_HCD
        get_SW_HCD = read_SW_HCD_value
    End Property

    Property Let set_SW_HCD(aData)
        write_SW_HCD_value = aData
        flag_SW_HCD        = &H1
    End Property

    Property Get read_SW_HCD
        read
        read_SW_HCD = read_SW_HCD_value
    End Property

    Property Let write_SW_HCD(aData)
        set_SW_HCD = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_SW_AN_value = rightShift(data_low, 1) and &H1
        SW_HCD_mask = &H1
        if data_low > LONG_MAX then
            if SW_HCD_mask = mask then
                read_SW_HCD_value = data_low
            else
                read_SW_HCD_value = (data_low - H8000_0000) and SW_HCD_mask
            end If
        else
            read_SW_HCD_value = data_low and SW_HCD_mask
        end If

    End Sub

    Sub write
        If flag_SW_AN = &H0 or flag_SW_HCD = &H0 Then read
        If flag_SW_AN = &H0 Then write_SW_AN_value = get_SW_AN
        If flag_SW_HCD = &H0 Then write_SW_HCD_value = get_SW_HCD

        regValue = leftShift((write_SW_AN_value and &H1), 1) + leftShift((write_SW_HCD_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_SW_AN_value = rightShift(data_low, 1) and &H1
        SW_HCD_mask = &H1
        if data_low > LONG_MAX then
            if SW_HCD_mask = mask then
                read_SW_HCD_value = data_low
            else
                read_SW_HCD_value = (data_low - H8000_0000) and SW_HCD_mask
            end If
        else
            read_SW_HCD_value = data_low and SW_HCD_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SW_AN_value = &H0
        flag_SW_AN        = &H0
        write_SW_HCD_value = &H0
        flag_SW_HCD        = &H0
    End Sub
End Class


'' @REGISTER : AN_X4_SW_MANAGEMENT_SGMIIPLUSR_X1_an_page_sequencer_status_sgmiiplusr_x1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ASSM                                       [15:15]          get_ASSM
''                                                             set_ASSM
''                                                             read_ASSM
''                                                             write_ASSM
''---------------------------------------------------------------------------------
'' an_st_hp_mode                              [14:14]          get_an_st_hp_mode
''                                                             set_an_st_hp_mode
''                                                             read_an_st_hp_mode
''                                                             write_an_st_hp_mode
''---------------------------------------------------------------------------------
'' ASRSM                                      [13:13]          get_ASRSM
''                                                             set_ASRSM
''                                                             read_ASRSM
''                                                             write_ASRSM
''---------------------------------------------------------------------------------
'' an_st_rx_bp                                [12:12]          get_an_st_rx_bp
''                                                             set_an_st_rx_bp
''                                                             read_an_st_rx_bp
''                                                             write_an_st_rx_bp
''---------------------------------------------------------------------------------
'' an_st_rx_np                                [11:11]          get_an_st_rx_np
''                                                             set_an_st_rx_np
''                                                             read_an_st_rx_np
''                                                             write_an_st_rx_np
''---------------------------------------------------------------------------------
'' ASRMN                                      [10:10]          get_ASRMN
''                                                             set_ASRMN
''                                                             read_ASRMN
''                                                             write_ASRMN
''---------------------------------------------------------------------------------
'' an_st_rx_mp_oui                            [9:9]            get_an_st_rx_mp_oui
''                                                             set_an_st_rx_mp_oui
''                                                             read_an_st_rx_mp_oui
''                                                             write_an_st_rx_mp_oui
''---------------------------------------------------------------------------------
'' ASRMO1                                     [8:8]            get_ASRMO1
''                                                             set_ASRMO1
''                                                             read_ASRMO1
''                                                             write_ASRMO1
''---------------------------------------------------------------------------------
'' ASRMM                                      [7:7]            get_ASRMM
''                                                             set_ASRMM
''                                                             read_ASRMM
''                                                             write_ASRMM
''---------------------------------------------------------------------------------
'' an_st_rx_up_3                              [6:6]            get_an_st_rx_up_3
''                                                             set_an_st_rx_up_3
''                                                             read_an_st_rx_up_3
''                                                             write_an_st_rx_up_3
''---------------------------------------------------------------------------------
'' ASRUOM                                     [5:5]            get_ASRUOM
''                                                             set_ASRUOM
''                                                             read_ASRUOM
''                                                             write_ASRUOM
''---------------------------------------------------------------------------------
'' ASRUOM1                                    [4:4]            get_ASRUOM1
''                                                             set_ASRUOM1
''                                                             read_ASRUOM1
''                                                             write_ASRUOM1
''---------------------------------------------------------------------------------
'' ASRIS                                      [3:3]            get_ASRIS
''                                                             set_ASRIS
''                                                             read_ASRIS
''                                                             write_ASRIS
''---------------------------------------------------------------------------------
'' ASRNTE                                     [2:2]            get_ASRNTE
''                                                             set_ASRNTE
''                                                             read_ASRNTE
''                                                             write_ASRNTE
''---------------------------------------------------------------------------------
'' ASC37C                                     [1:1]            get_ASC37C
''                                                             set_ASC37C
''                                                             read_ASC37C
''                                                             write_ASC37C
''---------------------------------------------------------------------------------
'' ASC73C                                     [0:0]            get_ASC73C
''                                                             set_ASC73C
''                                                             read_ASC73C
''                                                             write_ASC73C
''---------------------------------------------------------------------------------
Class REGISTER_AN_X4_SW_MANAGEMENT_SGMIIPLUSR_X1_an_page_sequencer_status_sgmiiplusr_x1
    Private write_ASSM_value
    Private read_ASSM_value
    Private flag_ASSM
    Private write_an_st_hp_mode_value
    Private read_an_st_hp_mode_value
    Private flag_an_st_hp_mode
    Private write_ASRSM_value
    Private read_ASRSM_value
    Private flag_ASRSM
    Private write_an_st_rx_bp_value
    Private read_an_st_rx_bp_value
    Private flag_an_st_rx_bp
    Private write_an_st_rx_np_value
    Private read_an_st_rx_np_value
    Private flag_an_st_rx_np
    Private write_ASRMN_value
    Private read_ASRMN_value
    Private flag_ASRMN
    Private write_an_st_rx_mp_oui_value
    Private read_an_st_rx_mp_oui_value
    Private flag_an_st_rx_mp_oui
    Private write_ASRMO1_value
    Private read_ASRMO1_value
    Private flag_ASRMO1
    Private write_ASRMM_value
    Private read_ASRMM_value
    Private flag_ASRMM
    Private write_an_st_rx_up_3_value
    Private read_an_st_rx_up_3_value
    Private flag_an_st_rx_up_3
    Private write_ASRUOM_value
    Private read_ASRUOM_value
    Private flag_ASRUOM
    Private write_ASRUOM1_value
    Private read_ASRUOM1_value
    Private flag_ASRUOM1
    Private write_ASRIS_value
    Private read_ASRIS_value
    Private flag_ASRIS
    Private write_ASRNTE_value
    Private read_ASRNTE_value
    Private flag_ASRNTE
    Private write_ASC37C_value
    Private read_ASC37C_value
    Private flag_ASC37C
    Private write_ASC73C_value
    Private read_ASC73C_value
    Private flag_ASC73C

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

    Property Get get_ASSM
        get_ASSM = read_ASSM_value
    End Property

    Property Let set_ASSM(aData)
        write_ASSM_value = aData
        flag_ASSM        = &H1
    End Property

    Property Get read_ASSM
        read
        read_ASSM = read_ASSM_value
    End Property

    Property Let write_ASSM(aData)
        set_ASSM = aData
        write
    End Property

    Property Get get_an_st_hp_mode
        get_an_st_hp_mode = read_an_st_hp_mode_value
    End Property

    Property Let set_an_st_hp_mode(aData)
        write_an_st_hp_mode_value = aData
        flag_an_st_hp_mode        = &H1
    End Property

    Property Get read_an_st_hp_mode
        read
        read_an_st_hp_mode = read_an_st_hp_mode_value
    End Property

    Property Let write_an_st_hp_mode(aData)
        set_an_st_hp_mode = aData
        write
    End Property

    Property Get get_ASRSM
        get_ASRSM = read_ASRSM_value
    End Property

    Property Let set_ASRSM(aData)
        write_ASRSM_value = aData
        flag_ASRSM        = &H1
    End Property

    Property Get read_ASRSM
        read
        read_ASRSM = read_ASRSM_value
    End Property

    Property Let write_ASRSM(aData)
        set_ASRSM = aData
        write
    End Property

    Property Get get_an_st_rx_bp
        get_an_st_rx_bp = read_an_st_rx_bp_value
    End Property

    Property Let set_an_st_rx_bp(aData)
        write_an_st_rx_bp_value = aData
        flag_an_st_rx_bp        = &H1
    End Property

    Property Get read_an_st_rx_bp
        read
        read_an_st_rx_bp = read_an_st_rx_bp_value
    End Property

    Property Let write_an_st_rx_bp(aData)
        set_an_st_rx_bp = aData
        write
    End Property

    Property Get get_an_st_rx_np
        get_an_st_rx_np = read_an_st_rx_np_value
    End Property

    Property Let set_an_st_rx_np(aData)
        write_an_st_rx_np_value = aData
        flag_an_st_rx_np        = &H1
    End Property

    Property Get read_an_st_rx_np
        read
        read_an_st_rx_np = read_an_st_rx_np_value
    End Property

    Property Let write_an_st_rx_np(aData)
        set_an_st_rx_np = aData
        write
    End Property

    Property Get get_ASRMN
        get_ASRMN = read_ASRMN_value
    End Property

    Property Let set_ASRMN(aData)
        write_ASRMN_value = aData
        flag_ASRMN        = &H1
    End Property

    Property Get read_ASRMN
        read
        read_ASRMN = read_ASRMN_value
    End Property

    Property Let write_ASRMN(aData)
        set_ASRMN = aData
        write
    End Property

    Property Get get_an_st_rx_mp_oui
        get_an_st_rx_mp_oui = read_an_st_rx_mp_oui_value
    End Property

    Property Let set_an_st_rx_mp_oui(aData)
        write_an_st_rx_mp_oui_value = aData
        flag_an_st_rx_mp_oui        = &H1
    End Property

    Property Get read_an_st_rx_mp_oui
        read
        read_an_st_rx_mp_oui = read_an_st_rx_mp_oui_value
    End Property

    Property Let write_an_st_rx_mp_oui(aData)
        set_an_st_rx_mp_oui = aData
        write
    End Property

    Property Get get_ASRMO1
        get_ASRMO1 = read_ASRMO1_value
    End Property

    Property Let set_ASRMO1(aData)
        write_ASRMO1_value = aData
        flag_ASRMO1        = &H1
    End Property

    Property Get read_ASRMO1
        read
        read_ASRMO1 = read_ASRMO1_value
    End Property

    Property Let write_ASRMO1(aData)
        set_ASRMO1 = aData
        write
    End Property

    Property Get get_ASRMM
        get_ASRMM = read_ASRMM_value
    End Property

    Property Let set_ASRMM(aData)
        write_ASRMM_value = aData
        flag_ASRMM        = &H1
    End Property

    Property Get read_ASRMM
        read
        read_ASRMM = read_ASRMM_value
    End Property

    Property Let write_ASRMM(aData)
        set_ASRMM = aData
        write
    End Property

    Property Get get_an_st_rx_up_3
        get_an_st_rx_up_3 = read_an_st_rx_up_3_value
    End Property

    Property Let set_an_st_rx_up_3(aData)
        write_an_st_rx_up_3_value = aData
        flag_an_st_rx_up_3        = &H1
    End Property

    Property Get read_an_st_rx_up_3
        read
        read_an_st_rx_up_3 = read_an_st_rx_up_3_value
    End Property

    Property Let write_an_st_rx_up_3(aData)
        set_an_st_rx_up_3 = aData
        write
    End Property

    Property Get get_ASRUOM
        get_ASRUOM = read_ASRUOM_value
    End Property

    Property Let set_ASRUOM(aData)
        write_ASRUOM_value = aData
        flag_ASRUOM        = &H1
    End Property

    Property Get read_ASRUOM
        read
        read_ASRUOM = read_ASRUOM_value
    End Property

    Property Let write_ASRUOM(aData)
        set_ASRUOM = aData
        write
    End Property

    Property Get get_ASRUOM1
        get_ASRUOM1 = read_ASRUOM1_value
    End Property

    Property Let set_ASRUOM1(aData)
        write_ASRUOM1_value = aData
        flag_ASRUOM1        = &H1
    End Property

    Property Get read_ASRUOM1
        read
        read_ASRUOM1 = read_ASRUOM1_value
    End Property

    Property Let write_ASRUOM1(aData)
        set_ASRUOM1 = aData
        write
    End Property

    Property Get get_ASRIS
        get_ASRIS = read_ASRIS_value
    End Property

    Property Let set_ASRIS(aData)
        write_ASRIS_value = aData
        flag_ASRIS        = &H1
    End Property

    Property Get read_ASRIS
        read
        read_ASRIS = read_ASRIS_value
    End Property

    Property Let write_ASRIS(aData)
        set_ASRIS = aData
        write
    End Property

    Property Get get_ASRNTE
        get_ASRNTE = read_ASRNTE_value
    End Property

    Property Let set_ASRNTE(aData)
        write_ASRNTE_value = aData
        flag_ASRNTE        = &H1
    End Property

    Property Get read_ASRNTE
        read
        read_ASRNTE = read_ASRNTE_value
    End Property

    Property Let write_ASRNTE(aData)
        set_ASRNTE = aData
        write
    End Property

    Property Get get_ASC37C
        get_ASC37C = read_ASC37C_value
    End Property

    Property Let set_ASC37C(aData)
        write_ASC37C_value = aData
        flag_ASC37C        = &H1
    End Property

    Property Get read_ASC37C
        read
        read_ASC37C = read_ASC37C_value
    End Property

    Property Let write_ASC37C(aData)
        set_ASC37C = aData
        write
    End Property

    Property Get get_ASC73C
        get_ASC73C = read_ASC73C_value
    End Property

    Property Let set_ASC73C(aData)
        write_ASC73C_value = aData
        flag_ASC73C        = &H1
    End Property

    Property Get read_ASC73C
        read
        read_ASC73C = read_ASC73C_value
    End Property

    Property Let write_ASC73C(aData)
        set_ASC73C = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ASSM_value = rightShift(data_low, 15) and &H1
        read_an_st_hp_mode_value = rightShift(data_low, 14) and &H1
        read_ASRSM_value = rightShift(data_low, 13) and &H1
        read_an_st_rx_bp_value = rightShift(data_low, 12) and &H1
        read_an_st_rx_np_value = rightShift(data_low, 11) and &H1
        read_ASRMN_value = rightShift(data_low, 10) and &H1
        read_an_st_rx_mp_oui_value = rightShift(data_low, 9) and &H1
        read_ASRMO1_value = rightShift(data_low, 8) and &H1
        read_ASRMM_value = rightShift(data_low, 7) and &H1
        read_an_st_rx_up_3_value = rightShift(data_low, 6) and &H1
        read_ASRUOM_value = rightShift(data_low, 5) and &H1
        read_ASRUOM1_value = rightShift(data_low, 4) and &H1
        read_ASRIS_value = rightShift(data_low, 3) and &H1
        read_ASRNTE_value = rightShift(data_low, 2) and &H1
        read_ASC37C_value = rightShift(data_low, 1) and &H1
        ASC73C_mask = &H1
        if data_low > LONG_MAX then
            if ASC73C_mask = mask then
                read_ASC73C_value = data_low
            else
                read_ASC73C_value = (data_low - H8000_0000) and ASC73C_mask
            end If
        else
            read_ASC73C_value = data_low and ASC73C_mask
        end If

    End Sub

    Sub write
        If flag_ASSM = &H0 or flag_an_st_hp_mode = &H0 or flag_ASRSM = &H0 or flag_an_st_rx_bp = &H0 or flag_an_st_rx_np = &H0 or flag_ASRMN = &H0 or flag_an_st_rx_mp_oui = &H0 or flag_ASRMO1 = &H0 or flag_ASRMM = &H0 or flag_an_st_rx_up_3 = &H0 or flag_ASRUOM = &H0 or flag_ASRUOM1 = &H0 or flag_ASRIS = &H0 or flag_ASRNTE = &H0 or flag_ASC37C = &H0 or flag_ASC73C = &H0 Then read
        If flag_ASSM = &H0 Then write_ASSM_value = get_ASSM
        If flag_an_st_hp_mode = &H0 Then write_an_st_hp_mode_value = get_an_st_hp_mode
        If flag_ASRSM = &H0 Then write_ASRSM_value = get_ASRSM
        If flag_an_st_rx_bp = &H0 Then write_an_st_rx_bp_value = get_an_st_rx_bp
        If flag_an_st_rx_np = &H0 Then write_an_st_rx_np_value = get_an_st_rx_np
        If flag_ASRMN = &H0 Then write_ASRMN_value = get_ASRMN
        If flag_an_st_rx_mp_oui = &H0 Then write_an_st_rx_mp_oui_value = get_an_st_rx_mp_oui
        If flag_ASRMO1 = &H0 Then write_ASRMO1_value = get_ASRMO1
        If flag_ASRMM = &H0 Then write_ASRMM_value = get_ASRMM
        If flag_an_st_rx_up_3 = &H0 Then write_an_st_rx_up_3_value = get_an_st_rx_up_3
        If flag_ASRUOM = &H0 Then write_ASRUOM_value = get_ASRUOM
        If flag_ASRUOM1 = &H0 Then write_ASRUOM1_value = get_ASRUOM1
        If flag_ASRIS = &H0 Then write_ASRIS_value = get_ASRIS
        If flag_ASRNTE = &H0 Then write_ASRNTE_value = get_ASRNTE
        If flag_ASC37C = &H0 Then write_ASC37C_value = get_ASC37C
        If flag_ASC73C = &H0 Then write_ASC73C_value = get_ASC73C

        regValue = leftShift((write_ASSM_value and &H1), 15) + leftShift((write_an_st_hp_mode_value and &H1), 14) + leftShift((write_ASRSM_value and &H1), 13) + leftShift((write_an_st_rx_bp_value and &H1), 12) + leftShift((write_an_st_rx_np_value and &H1), 11) + leftShift((write_ASRMN_value and &H1), 10) + leftShift((write_an_st_rx_mp_oui_value and &H1), 9) + leftShift((write_ASRMO1_value and &H1), 8) + leftShift((write_ASRMM_value and &H1), 7) + leftShift((write_an_st_rx_up_3_value and &H1), 6) + leftShift((write_ASRUOM_value and &H1), 5) + leftShift((write_ASRUOM1_value and &H1), 4) + leftShift((write_ASRIS_value and &H1), 3) + leftShift((write_ASRNTE_value and &H1), 2) + leftShift((write_ASC37C_value and &H1), 1) + leftShift((write_ASC73C_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ASSM_value = rightShift(data_low, 15) and &H1
        read_an_st_hp_mode_value = rightShift(data_low, 14) and &H1
        read_ASRSM_value = rightShift(data_low, 13) and &H1
        read_an_st_rx_bp_value = rightShift(data_low, 12) and &H1
        read_an_st_rx_np_value = rightShift(data_low, 11) and &H1
        read_ASRMN_value = rightShift(data_low, 10) and &H1
        read_an_st_rx_mp_oui_value = rightShift(data_low, 9) and &H1
        read_ASRMO1_value = rightShift(data_low, 8) and &H1
        read_ASRMM_value = rightShift(data_low, 7) and &H1
        read_an_st_rx_up_3_value = rightShift(data_low, 6) and &H1
        read_ASRUOM_value = rightShift(data_low, 5) and &H1
        read_ASRUOM1_value = rightShift(data_low, 4) and &H1
        read_ASRIS_value = rightShift(data_low, 3) and &H1
        read_ASRNTE_value = rightShift(data_low, 2) and &H1
        read_ASC37C_value = rightShift(data_low, 1) and &H1
        ASC73C_mask = &H1
        if data_low > LONG_MAX then
            if ASC73C_mask = mask then
                read_ASC73C_value = data_low
            else
                read_ASC73C_value = (data_low - H8000_0000) and ASC73C_mask
            end If
        else
            read_ASC73C_value = data_low and ASC73C_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ASSM_value = &H0
        flag_ASSM        = &H0
        write_an_st_hp_mode_value = &H0
        flag_an_st_hp_mode        = &H0
        write_ASRSM_value = &H0
        flag_ASRSM        = &H0
        write_an_st_rx_bp_value = &H0
        flag_an_st_rx_bp        = &H0
        write_an_st_rx_np_value = &H0
        flag_an_st_rx_np        = &H0
        write_ASRMN_value = &H0
        flag_ASRMN        = &H0
        write_an_st_rx_mp_oui_value = &H0
        flag_an_st_rx_mp_oui        = &H0
        write_ASRMO1_value = &H0
        flag_ASRMO1        = &H0
        write_ASRMM_value = &H0
        flag_ASRMM        = &H0
        write_an_st_rx_up_3_value = &H0
        flag_an_st_rx_up_3        = &H0
        write_ASRUOM_value = &H0
        flag_ASRUOM        = &H0
        write_ASRUOM1_value = &H0
        flag_ASRUOM1        = &H0
        write_ASRIS_value = &H0
        flag_ASRIS        = &H0
        write_ASRNTE_value = &H0
        flag_ASRNTE        = &H0
        write_ASC37C_value = &H0
        flag_ASC37C        = &H0
        write_ASC73C_value = &H0
        flag_ASC73C        = &H0
    End Sub
End Class


'' @REGISTER : AN_X4_SW_MANAGEMENT_SGMIIPLUSR_X1_an_page_exchangeer_status_sgmiiplusr_x1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ASNPW                                      [13:13]          get_ASNPW
''                                                             set_ASNPW
''                                                             read_ASNPW
''                                                             write_ASNPW
''---------------------------------------------------------------------------------
'' an_st_link_ok                              [12:12]          get_an_st_link_ok
''                                                             set_an_st_link_ok
''                                                             read_an_st_link_ok
''                                                             write_an_st_link_ok
''---------------------------------------------------------------------------------
'' ASAGC                                      [11:11]          get_ASAGC
''                                                             set_ASAGC
''                                                             read_ASAGC
''                                                             write_ASAGC
''---------------------------------------------------------------------------------
'' an_st_restart                              [10:10]          get_an_st_restart
''                                                             set_an_st_restart
''                                                             read_an_st_restart
''                                                             write_an_st_restart
''---------------------------------------------------------------------------------
'' ASCN                                       [9:9]            get_ASCN
''                                                             set_ASCN
''                                                             read_ASCN
''                                                             write_ASCN
''---------------------------------------------------------------------------------
'' ASCM                                       [8:8]            get_ASCM
''                                                             set_ASCM
''                                                             read_ASCM
''                                                             write_ASCM
''---------------------------------------------------------------------------------
'' ASCA                                       [7:7]            get_ASCA
''                                                             set_ASCA
''                                                             read_ASCA
''                                                             write_ASCA
''---------------------------------------------------------------------------------
'' ASAD                                       [6:6]            get_ASAD
''                                                             set_ASAD
''                                                             read_ASAD
''                                                             write_ASAD
''---------------------------------------------------------------------------------
'' ASAD1                                      [5:5]            get_ASAD1
''                                                             set_ASAD1
''                                                             read_ASAD1
''                                                             write_ASAD1
''---------------------------------------------------------------------------------
'' an_st_an_enable                            [4:4]            get_an_st_an_enable
''                                                             set_an_st_an_enable
''                                                             read_an_st_an_enable
''                                                             write_an_st_an_enable
''---------------------------------------------------------------------------------
'' ASES                                       [3:3]            get_ASES
''                                                             set_ASES
''                                                             read_ASES
''                                                             write_ASES
''---------------------------------------------------------------------------------
'' ASDL                                       [2:2]            get_ASDL
''                                                             set_ASDL
''                                                             read_ASDL
''                                                             write_ASDL
''---------------------------------------------------------------------------------
'' ASID                                       [1:1]            get_ASID
''                                                             set_ASID
''                                                             read_ASID
''                                                             write_ASID
''---------------------------------------------------------------------------------
'' ASCR                                       [0:0]            get_ASCR
''                                                             set_ASCR
''                                                             read_ASCR
''                                                             write_ASCR
''---------------------------------------------------------------------------------
Class REGISTER_AN_X4_SW_MANAGEMENT_SGMIIPLUSR_X1_an_page_exchangeer_status_sgmiiplusr_x1
    Private write_ASNPW_value
    Private read_ASNPW_value
    Private flag_ASNPW
    Private write_an_st_link_ok_value
    Private read_an_st_link_ok_value
    Private flag_an_st_link_ok
    Private write_ASAGC_value
    Private read_ASAGC_value
    Private flag_ASAGC
    Private write_an_st_restart_value
    Private read_an_st_restart_value
    Private flag_an_st_restart
    Private write_ASCN_value
    Private read_ASCN_value
    Private flag_ASCN
    Private write_ASCM_value
    Private read_ASCM_value
    Private flag_ASCM
    Private write_ASCA_value
    Private read_ASCA_value
    Private flag_ASCA
    Private write_ASAD_value
    Private read_ASAD_value
    Private flag_ASAD
    Private write_ASAD1_value
    Private read_ASAD1_value
    Private flag_ASAD1
    Private write_an_st_an_enable_value
    Private read_an_st_an_enable_value
    Private flag_an_st_an_enable
    Private write_ASES_value
    Private read_ASES_value
    Private flag_ASES
    Private write_ASDL_value
    Private read_ASDL_value
    Private flag_ASDL
    Private write_ASID_value
    Private read_ASID_value
    Private flag_ASID
    Private write_ASCR_value
    Private read_ASCR_value
    Private flag_ASCR

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

    Property Get get_ASNPW
        get_ASNPW = read_ASNPW_value
    End Property

    Property Let set_ASNPW(aData)
        write_ASNPW_value = aData
        flag_ASNPW        = &H1
    End Property

    Property Get read_ASNPW
        read
        read_ASNPW = read_ASNPW_value
    End Property

    Property Let write_ASNPW(aData)
        set_ASNPW = aData
        write
    End Property

    Property Get get_an_st_link_ok
        get_an_st_link_ok = read_an_st_link_ok_value
    End Property

    Property Let set_an_st_link_ok(aData)
        write_an_st_link_ok_value = aData
        flag_an_st_link_ok        = &H1
    End Property

    Property Get read_an_st_link_ok
        read
        read_an_st_link_ok = read_an_st_link_ok_value
    End Property

    Property Let write_an_st_link_ok(aData)
        set_an_st_link_ok = aData
        write
    End Property

    Property Get get_ASAGC
        get_ASAGC = read_ASAGC_value
    End Property

    Property Let set_ASAGC(aData)
        write_ASAGC_value = aData
        flag_ASAGC        = &H1
    End Property

    Property Get read_ASAGC
        read
        read_ASAGC = read_ASAGC_value
    End Property

    Property Let write_ASAGC(aData)
        set_ASAGC = aData
        write
    End Property

    Property Get get_an_st_restart
        get_an_st_restart = read_an_st_restart_value
    End Property

    Property Let set_an_st_restart(aData)
        write_an_st_restart_value = aData
        flag_an_st_restart        = &H1
    End Property

    Property Get read_an_st_restart
        read
        read_an_st_restart = read_an_st_restart_value
    End Property

    Property Let write_an_st_restart(aData)
        set_an_st_restart = aData
        write
    End Property

    Property Get get_ASCN
        get_ASCN = read_ASCN_value
    End Property

    Property Let set_ASCN(aData)
        write_ASCN_value = aData
        flag_ASCN        = &H1
    End Property

    Property Get read_ASCN
        read
        read_ASCN = read_ASCN_value
    End Property

    Property Let write_ASCN(aData)
        set_ASCN = aData
        write
    End Property

    Property Get get_ASCM
        get_ASCM = read_ASCM_value
    End Property

    Property Let set_ASCM(aData)
        write_ASCM_value = aData
        flag_ASCM        = &H1
    End Property

    Property Get read_ASCM
        read
        read_ASCM = read_ASCM_value
    End Property

    Property Let write_ASCM(aData)
        set_ASCM = aData
        write
    End Property

    Property Get get_ASCA
        get_ASCA = read_ASCA_value
    End Property

    Property Let set_ASCA(aData)
        write_ASCA_value = aData
        flag_ASCA        = &H1
    End Property

    Property Get read_ASCA
        read
        read_ASCA = read_ASCA_value
    End Property

    Property Let write_ASCA(aData)
        set_ASCA = aData
        write
    End Property

    Property Get get_ASAD
        get_ASAD = read_ASAD_value
    End Property

    Property Let set_ASAD(aData)
        write_ASAD_value = aData
        flag_ASAD        = &H1
    End Property

    Property Get read_ASAD
        read
        read_ASAD = read_ASAD_value
    End Property

    Property Let write_ASAD(aData)
        set_ASAD = aData
        write
    End Property

    Property Get get_ASAD1
        get_ASAD1 = read_ASAD1_value
    End Property

    Property Let set_ASAD1(aData)
        write_ASAD1_value = aData
        flag_ASAD1        = &H1
    End Property

    Property Get read_ASAD1
        read
        read_ASAD1 = read_ASAD1_value
    End Property

    Property Let write_ASAD1(aData)
        set_ASAD1 = aData
        write
    End Property

    Property Get get_an_st_an_enable
        get_an_st_an_enable = read_an_st_an_enable_value
    End Property

    Property Let set_an_st_an_enable(aData)
        write_an_st_an_enable_value = aData
        flag_an_st_an_enable        = &H1
    End Property

    Property Get read_an_st_an_enable
        read
        read_an_st_an_enable = read_an_st_an_enable_value
    End Property

    Property Let write_an_st_an_enable(aData)
        set_an_st_an_enable = aData
        write
    End Property

    Property Get get_ASES
        get_ASES = read_ASES_value
    End Property

    Property Let set_ASES(aData)
        write_ASES_value = aData
        flag_ASES        = &H1
    End Property

    Property Get read_ASES
        read
        read_ASES = read_ASES_value
    End Property

    Property Let write_ASES(aData)
        set_ASES = aData
        write
    End Property

    Property Get get_ASDL
        get_ASDL = read_ASDL_value
    End Property

    Property Let set_ASDL(aData)
        write_ASDL_value = aData
        flag_ASDL        = &H1
    End Property

    Property Get read_ASDL
        read
        read_ASDL = read_ASDL_value
    End Property

    Property Let write_ASDL(aData)
        set_ASDL = aData
        write
    End Property

    Property Get get_ASID
        get_ASID = read_ASID_value
    End Property

    Property Let set_ASID(aData)
        write_ASID_value = aData
        flag_ASID        = &H1
    End Property

    Property Get read_ASID
        read
        read_ASID = read_ASID_value
    End Property

    Property Let write_ASID(aData)
        set_ASID = aData
        write
    End Property

    Property Get get_ASCR
        get_ASCR = read_ASCR_value
    End Property

    Property Let set_ASCR(aData)
        write_ASCR_value = aData
        flag_ASCR        = &H1
    End Property

    Property Get read_ASCR
        read
        read_ASCR = read_ASCR_value
    End Property

    Property Let write_ASCR(aData)
        set_ASCR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ASNPW_value = rightShift(data_low, 13) and &H1
        read_an_st_link_ok_value = rightShift(data_low, 12) and &H1
        read_ASAGC_value = rightShift(data_low, 11) and &H1
        read_an_st_restart_value = rightShift(data_low, 10) and &H1
        read_ASCN_value = rightShift(data_low, 9) and &H1
        read_ASCM_value = rightShift(data_low, 8) and &H1
        read_ASCA_value = rightShift(data_low, 7) and &H1
        read_ASAD_value = rightShift(data_low, 6) and &H1
        read_ASAD1_value = rightShift(data_low, 5) and &H1
        read_an_st_an_enable_value = rightShift(data_low, 4) and &H1
        read_ASES_value = rightShift(data_low, 3) and &H1
        read_ASDL_value = rightShift(data_low, 2) and &H1
        read_ASID_value = rightShift(data_low, 1) and &H1
        ASCR_mask = &H1
        if data_low > LONG_MAX then
            if ASCR_mask = mask then
                read_ASCR_value = data_low
            else
                read_ASCR_value = (data_low - H8000_0000) and ASCR_mask
            end If
        else
            read_ASCR_value = data_low and ASCR_mask
        end If

    End Sub

    Sub write
        If flag_ASNPW = &H0 or flag_an_st_link_ok = &H0 or flag_ASAGC = &H0 or flag_an_st_restart = &H0 or flag_ASCN = &H0 or flag_ASCM = &H0 or flag_ASCA = &H0 or flag_ASAD = &H0 or flag_ASAD1 = &H0 or flag_an_st_an_enable = &H0 or flag_ASES = &H0 or flag_ASDL = &H0 or flag_ASID = &H0 or flag_ASCR = &H0 Then read
        If flag_ASNPW = &H0 Then write_ASNPW_value = get_ASNPW
        If flag_an_st_link_ok = &H0 Then write_an_st_link_ok_value = get_an_st_link_ok
        If flag_ASAGC = &H0 Then write_ASAGC_value = get_ASAGC
        If flag_an_st_restart = &H0 Then write_an_st_restart_value = get_an_st_restart
        If flag_ASCN = &H0 Then write_ASCN_value = get_ASCN
        If flag_ASCM = &H0 Then write_ASCM_value = get_ASCM
        If flag_ASCA = &H0 Then write_ASCA_value = get_ASCA
        If flag_ASAD = &H0 Then write_ASAD_value = get_ASAD
        If flag_ASAD1 = &H0 Then write_ASAD1_value = get_ASAD1
        If flag_an_st_an_enable = &H0 Then write_an_st_an_enable_value = get_an_st_an_enable
        If flag_ASES = &H0 Then write_ASES_value = get_ASES
        If flag_ASDL = &H0 Then write_ASDL_value = get_ASDL
        If flag_ASID = &H0 Then write_ASID_value = get_ASID
        If flag_ASCR = &H0 Then write_ASCR_value = get_ASCR

        regValue = leftShift((write_ASNPW_value and &H1), 13) + leftShift((write_an_st_link_ok_value and &H1), 12) + leftShift((write_ASAGC_value and &H1), 11) + leftShift((write_an_st_restart_value and &H1), 10) + leftShift((write_ASCN_value and &H1), 9) + leftShift((write_ASCM_value and &H1), 8) + leftShift((write_ASCA_value and &H1), 7) + leftShift((write_ASAD_value and &H1), 6) + leftShift((write_ASAD1_value and &H1), 5) + leftShift((write_an_st_an_enable_value and &H1), 4) + leftShift((write_ASES_value and &H1), 3) + leftShift((write_ASDL_value and &H1), 2) + leftShift((write_ASID_value and &H1), 1) + leftShift((write_ASCR_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ASNPW_value = rightShift(data_low, 13) and &H1
        read_an_st_link_ok_value = rightShift(data_low, 12) and &H1
        read_ASAGC_value = rightShift(data_low, 11) and &H1
        read_an_st_restart_value = rightShift(data_low, 10) and &H1
        read_ASCN_value = rightShift(data_low, 9) and &H1
        read_ASCM_value = rightShift(data_low, 8) and &H1
        read_ASCA_value = rightShift(data_low, 7) and &H1
        read_ASAD_value = rightShift(data_low, 6) and &H1
        read_ASAD1_value = rightShift(data_low, 5) and &H1
        read_an_st_an_enable_value = rightShift(data_low, 4) and &H1
        read_ASES_value = rightShift(data_low, 3) and &H1
        read_ASDL_value = rightShift(data_low, 2) and &H1
        read_ASID_value = rightShift(data_low, 1) and &H1
        ASCR_mask = &H1
        if data_low > LONG_MAX then
            if ASCR_mask = mask then
                read_ASCR_value = data_low
            else
                read_ASCR_value = (data_low - H8000_0000) and ASCR_mask
            end If
        else
            read_ASCR_value = data_low and ASCR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ASNPW_value = &H0
        flag_ASNPW        = &H0
        write_an_st_link_ok_value = &H0
        flag_an_st_link_ok        = &H0
        write_ASAGC_value = &H0
        flag_ASAGC        = &H0
        write_an_st_restart_value = &H0
        flag_an_st_restart        = &H0
        write_ASCN_value = &H0
        flag_ASCN        = &H0
        write_ASCM_value = &H0
        flag_ASCM        = &H0
        write_ASCA_value = &H0
        flag_ASCA        = &H0
        write_ASAD_value = &H0
        flag_ASAD        = &H0
        write_ASAD1_value = &H0
        flag_ASAD1        = &H0
        write_an_st_an_enable_value = &H0
        flag_an_st_an_enable        = &H0
        write_ASES_value = &H0
        flag_ASES        = &H0
        write_ASDL_value = &H0
        flag_ASDL        = &H0
        write_ASID_value = &H0
        flag_ASID        = &H0
        write_ASCR_value = &H0
        flag_ASCR        = &H0
    End Sub
End Class


'' @REGISTER : AN_X4_SW_MANAGEMENT_SGMIIPLUSR_X1_an_page_decoder_status_sgmiiplusr_x1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ARSPTM                                     [12:12]          get_ARSPTM
''                                                             set_ARSPTM
''                                                             read_ARSPTM
''                                                             write_ARSPTM
''---------------------------------------------------------------------------------
'' ARSPTS                                     [11:11]          get_ARSPTS
''                                                             set_ARSPTS
''                                                             read_ARSPTS
''                                                             write_ARSPTS
''---------------------------------------------------------------------------------
'' ARSPTL                                     [10:10]          get_ARSPTL
''                                                             set_ARSPTL
''                                                             read_ARSPTL
''                                                             write_ARSPTL
''---------------------------------------------------------------------------------
'' ARSPTS1                                    [9:9]            get_ARSPTS1
''                                                             set_ARSPTS1
''                                                             read_ARSPTS1
''                                                             write_ARSPTS1
''---------------------------------------------------------------------------------
'' ARSPTL1                                    [8:8]            get_ARSPTL1
''                                                             set_ARSPTL1
''                                                             read_ARSPTL1
''                                                             write_ARSPTL1
''---------------------------------------------------------------------------------
'' ARSCTM                                     [7:7]            get_ARSCTM
''                                                             set_ARSCTM
''                                                             read_ARSCTM
''                                                             write_ARSCTM
''---------------------------------------------------------------------------------
'' ARSMP                                      [6:6]            get_ARSMP
''                                                             set_ARSMP
''                                                             read_ARSMP
''                                                             write_ARSMP
''---------------------------------------------------------------------------------
'' an_rx_st_page                              [5:5]            get_an_rx_st_page
''                                                             set_an_rx_st_page
''                                                             read_an_rx_st_page
''                                                             write_an_rx_st_page
''---------------------------------------------------------------------------------
'' ARSRI                                      [4:4]            get_ARSRI
''                                                             set_ARSRI
''                                                             read_ARSRI
''                                                             write_ARSRI
''---------------------------------------------------------------------------------
'' ARSRC                                      [3:3]            get_ARSRC
''                                                             set_ARSRC
''                                                             read_ARSRC
''                                                             write_ARSRC
''---------------------------------------------------------------------------------
'' ARSRI1                                     [2:2]            get_ARSRI1
''                                                             set_ARSRI1
''                                                             read_ARSRI1
''                                                             write_ARSRI1
''---------------------------------------------------------------------------------
'' an_rx_st_state                             [1:0]            get_an_rx_st_state
''                                                             set_an_rx_st_state
''                                                             read_an_rx_st_state
''                                                             write_an_rx_st_state
''---------------------------------------------------------------------------------
Class REGISTER_AN_X4_SW_MANAGEMENT_SGMIIPLUSR_X1_an_page_decoder_status_sgmiiplusr_x1
    Private write_ARSPTM_value
    Private read_ARSPTM_value
    Private flag_ARSPTM
    Private write_ARSPTS_value
    Private read_ARSPTS_value
    Private flag_ARSPTS
    Private write_ARSPTL_value
    Private read_ARSPTL_value
    Private flag_ARSPTL
    Private write_ARSPTS1_value
    Private read_ARSPTS1_value
    Private flag_ARSPTS1
    Private write_ARSPTL1_value
    Private read_ARSPTL1_value
    Private flag_ARSPTL1
    Private write_ARSCTM_value
    Private read_ARSCTM_value
    Private flag_ARSCTM
    Private write_ARSMP_value
    Private read_ARSMP_value
    Private flag_ARSMP
    Private write_an_rx_st_page_value
    Private read_an_rx_st_page_value
    Private flag_an_rx_st_page
    Private write_ARSRI_value
    Private read_ARSRI_value
    Private flag_ARSRI
    Private write_ARSRC_value
    Private read_ARSRC_value
    Private flag_ARSRC
    Private write_ARSRI1_value
    Private read_ARSRI1_value
    Private flag_ARSRI1
    Private write_an_rx_st_state_value
    Private read_an_rx_st_state_value
    Private flag_an_rx_st_state

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

    Property Get get_ARSPTM
        get_ARSPTM = read_ARSPTM_value
    End Property

    Property Let set_ARSPTM(aData)
        write_ARSPTM_value = aData
        flag_ARSPTM        = &H1
    End Property

    Property Get read_ARSPTM
        read
        read_ARSPTM = read_ARSPTM_value
    End Property

    Property Let write_ARSPTM(aData)
        set_ARSPTM = aData
        write
    End Property

    Property Get get_ARSPTS
        get_ARSPTS = read_ARSPTS_value
    End Property

    Property Let set_ARSPTS(aData)
        write_ARSPTS_value = aData
        flag_ARSPTS        = &H1
    End Property

    Property Get read_ARSPTS
        read
        read_ARSPTS = read_ARSPTS_value
    End Property

    Property Let write_ARSPTS(aData)
        set_ARSPTS = aData
        write
    End Property

    Property Get get_ARSPTL
        get_ARSPTL = read_ARSPTL_value
    End Property

    Property Let set_ARSPTL(aData)
        write_ARSPTL_value = aData
        flag_ARSPTL        = &H1
    End Property

    Property Get read_ARSPTL
        read
        read_ARSPTL = read_ARSPTL_value
    End Property

    Property Let write_ARSPTL(aData)
        set_ARSPTL = aData
        write
    End Property

    Property Get get_ARSPTS1
        get_ARSPTS1 = read_ARSPTS1_value
    End Property

    Property Let set_ARSPTS1(aData)
        write_ARSPTS1_value = aData
        flag_ARSPTS1        = &H1
    End Property

    Property Get read_ARSPTS1
        read
        read_ARSPTS1 = read_ARSPTS1_value
    End Property

    Property Let write_ARSPTS1(aData)
        set_ARSPTS1 = aData
        write
    End Property

    Property Get get_ARSPTL1
        get_ARSPTL1 = read_ARSPTL1_value
    End Property

    Property Let set_ARSPTL1(aData)
        write_ARSPTL1_value = aData
        flag_ARSPTL1        = &H1
    End Property

    Property Get read_ARSPTL1
        read
        read_ARSPTL1 = read_ARSPTL1_value
    End Property

    Property Let write_ARSPTL1(aData)
        set_ARSPTL1 = aData
        write
    End Property

    Property Get get_ARSCTM
        get_ARSCTM = read_ARSCTM_value
    End Property

    Property Let set_ARSCTM(aData)
        write_ARSCTM_value = aData
        flag_ARSCTM        = &H1
    End Property

    Property Get read_ARSCTM
        read
        read_ARSCTM = read_ARSCTM_value
    End Property

    Property Let write_ARSCTM(aData)
        set_ARSCTM = aData
        write
    End Property

    Property Get get_ARSMP
        get_ARSMP = read_ARSMP_value
    End Property

    Property Let set_ARSMP(aData)
        write_ARSMP_value = aData
        flag_ARSMP        = &H1
    End Property

    Property Get read_ARSMP
        read
        read_ARSMP = read_ARSMP_value
    End Property

    Property Let write_ARSMP(aData)
        set_ARSMP = aData
        write
    End Property

    Property Get get_an_rx_st_page
        get_an_rx_st_page = read_an_rx_st_page_value
    End Property

    Property Let set_an_rx_st_page(aData)
        write_an_rx_st_page_value = aData
        flag_an_rx_st_page        = &H1
    End Property

    Property Get read_an_rx_st_page
        read
        read_an_rx_st_page = read_an_rx_st_page_value
    End Property

    Property Let write_an_rx_st_page(aData)
        set_an_rx_st_page = aData
        write
    End Property

    Property Get get_ARSRI
        get_ARSRI = read_ARSRI_value
    End Property

    Property Let set_ARSRI(aData)
        write_ARSRI_value = aData
        flag_ARSRI        = &H1
    End Property

    Property Get read_ARSRI
        read
        read_ARSRI = read_ARSRI_value
    End Property

    Property Let write_ARSRI(aData)
        set_ARSRI = aData
        write
    End Property

    Property Get get_ARSRC
        get_ARSRC = read_ARSRC_value
    End Property

    Property Let set_ARSRC(aData)
        write_ARSRC_value = aData
        flag_ARSRC        = &H1
    End Property

    Property Get read_ARSRC
        read
        read_ARSRC = read_ARSRC_value
    End Property

    Property Let write_ARSRC(aData)
        set_ARSRC = aData
        write
    End Property

    Property Get get_ARSRI1
        get_ARSRI1 = read_ARSRI1_value
    End Property

    Property Let set_ARSRI1(aData)
        write_ARSRI1_value = aData
        flag_ARSRI1        = &H1
    End Property

    Property Get read_ARSRI1
        read
        read_ARSRI1 = read_ARSRI1_value
    End Property

    Property Let write_ARSRI1(aData)
        set_ARSRI1 = aData
        write
    End Property

    Property Get get_an_rx_st_state
        get_an_rx_st_state = read_an_rx_st_state_value
    End Property

    Property Let set_an_rx_st_state(aData)
        write_an_rx_st_state_value = aData
        flag_an_rx_st_state        = &H1
    End Property

    Property Get read_an_rx_st_state
        read
        read_an_rx_st_state = read_an_rx_st_state_value
    End Property

    Property Let write_an_rx_st_state(aData)
        set_an_rx_st_state = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ARSPTM_value = rightShift(data_low, 12) and &H1
        read_ARSPTS_value = rightShift(data_low, 11) and &H1
        read_ARSPTL_value = rightShift(data_low, 10) and &H1
        read_ARSPTS1_value = rightShift(data_low, 9) and &H1
        read_ARSPTL1_value = rightShift(data_low, 8) and &H1
        read_ARSCTM_value = rightShift(data_low, 7) and &H1
        read_ARSMP_value = rightShift(data_low, 6) and &H1
        read_an_rx_st_page_value = rightShift(data_low, 5) and &H1
        read_ARSRI_value = rightShift(data_low, 4) and &H1
        read_ARSRC_value = rightShift(data_low, 3) and &H1
        read_ARSRI1_value = rightShift(data_low, 2) and &H1
        an_rx_st_state_mask = &H3
        if data_low > LONG_MAX then
            if an_rx_st_state_mask = mask then
                read_an_rx_st_state_value = data_low
            else
                read_an_rx_st_state_value = (data_low - H8000_0000) and an_rx_st_state_mask
            end If
        else
            read_an_rx_st_state_value = data_low and an_rx_st_state_mask
        end If

    End Sub

    Sub write
        If flag_ARSPTM = &H0 or flag_ARSPTS = &H0 or flag_ARSPTL = &H0 or flag_ARSPTS1 = &H0 or flag_ARSPTL1 = &H0 or flag_ARSCTM = &H0 or flag_ARSMP = &H0 or flag_an_rx_st_page = &H0 or flag_ARSRI = &H0 or flag_ARSRC = &H0 or flag_ARSRI1 = &H0 or flag_an_rx_st_state = &H0 Then read
        If flag_ARSPTM = &H0 Then write_ARSPTM_value = get_ARSPTM
        If flag_ARSPTS = &H0 Then write_ARSPTS_value = get_ARSPTS
        If flag_ARSPTL = &H0 Then write_ARSPTL_value = get_ARSPTL
        If flag_ARSPTS1 = &H0 Then write_ARSPTS1_value = get_ARSPTS1
        If flag_ARSPTL1 = &H0 Then write_ARSPTL1_value = get_ARSPTL1
        If flag_ARSCTM = &H0 Then write_ARSCTM_value = get_ARSCTM
        If flag_ARSMP = &H0 Then write_ARSMP_value = get_ARSMP
        If flag_an_rx_st_page = &H0 Then write_an_rx_st_page_value = get_an_rx_st_page
        If flag_ARSRI = &H0 Then write_ARSRI_value = get_ARSRI
        If flag_ARSRC = &H0 Then write_ARSRC_value = get_ARSRC
        If flag_ARSRI1 = &H0 Then write_ARSRI1_value = get_ARSRI1
        If flag_an_rx_st_state = &H0 Then write_an_rx_st_state_value = get_an_rx_st_state

        regValue = leftShift((write_ARSPTM_value and &H1), 12) + leftShift((write_ARSPTS_value and &H1), 11) + leftShift((write_ARSPTL_value and &H1), 10) + leftShift((write_ARSPTS1_value and &H1), 9) + leftShift((write_ARSPTL1_value and &H1), 8) + leftShift((write_ARSCTM_value and &H1), 7) + leftShift((write_ARSMP_value and &H1), 6) + leftShift((write_an_rx_st_page_value and &H1), 5) + leftShift((write_ARSRI_value and &H1), 4) + leftShift((write_ARSRC_value and &H1), 3) + leftShift((write_ARSRI1_value and &H1), 2) + leftShift((write_an_rx_st_state_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ARSPTM_value = rightShift(data_low, 12) and &H1
        read_ARSPTS_value = rightShift(data_low, 11) and &H1
        read_ARSPTL_value = rightShift(data_low, 10) and &H1
        read_ARSPTS1_value = rightShift(data_low, 9) and &H1
        read_ARSPTL1_value = rightShift(data_low, 8) and &H1
        read_ARSCTM_value = rightShift(data_low, 7) and &H1
        read_ARSMP_value = rightShift(data_low, 6) and &H1
        read_an_rx_st_page_value = rightShift(data_low, 5) and &H1
        read_ARSRI_value = rightShift(data_low, 4) and &H1
        read_ARSRC_value = rightShift(data_low, 3) and &H1
        read_ARSRI1_value = rightShift(data_low, 2) and &H1
        an_rx_st_state_mask = &H3
        if data_low > LONG_MAX then
            if an_rx_st_state_mask = mask then
                read_an_rx_st_state_value = data_low
            else
                read_an_rx_st_state_value = (data_low - H8000_0000) and an_rx_st_state_mask
            end If
        else
            read_an_rx_st_state_value = data_low and an_rx_st_state_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ARSPTM_value = &H0
        flag_ARSPTM        = &H0
        write_ARSPTS_value = &H0
        flag_ARSPTS        = &H0
        write_ARSPTL_value = &H0
        flag_ARSPTL        = &H0
        write_ARSPTS1_value = &H0
        flag_ARSPTS1        = &H0
        write_ARSPTL1_value = &H0
        flag_ARSPTL1        = &H0
        write_ARSCTM_value = &H0
        flag_ARSCTM        = &H0
        write_ARSMP_value = &H0
        flag_ARSMP        = &H0
        write_an_rx_st_page_value = &H0
        flag_an_rx_st_page        = &H0
        write_ARSRI_value = &H0
        flag_ARSRI        = &H0
        write_ARSRC_value = &H0
        flag_ARSRC        = &H0
        write_ARSRI1_value = &H0
        flag_ARSRI1        = &H0
        write_an_rx_st_state_value = &H0
        flag_an_rx_st_state        = &H0
    End Sub
End Class


'' @REGISTER : AN_X4_SW_MANAGEMENT_SGMIIPLUSR_X1_an_ability_resolution_status_sgmiiplusr_x1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ASRE                                       [13:13]          get_ASRE
''                                                             set_ASRE
''                                                             read_ASRE
''                                                             write_ASRE
''---------------------------------------------------------------------------------
'' an_hcd_duplex                              [12:12]          get_an_hcd_duplex
''                                                             set_an_hcd_duplex
''                                                             read_an_hcd_duplex
''                                                             write_an_hcd_duplex
''---------------------------------------------------------------------------------
'' an_hcd_pause                               [11:10]          get_an_hcd_pause
''                                                             set_an_hcd_pause
''                                                             read_an_hcd_pause
''                                                             write_an_hcd_pause
''---------------------------------------------------------------------------------
'' an_hcd_speed                               [9:4]            get_an_hcd_speed
''                                                             set_an_hcd_speed
''                                                             read_an_hcd_speed
''                                                             write_an_hcd_speed
''---------------------------------------------------------------------------------
'' an_hcd_fec                                 [3:3]            get_an_hcd_fec
''                                                             set_an_hcd_fec
''                                                             read_an_hcd_fec
''                                                             write_an_hcd_fec
''---------------------------------------------------------------------------------
'' an_hcd_cl72                                [2:2]            get_an_hcd_cl72
''                                                             set_an_hcd_cl72
''                                                             read_an_hcd_cl72
''                                                             write_an_hcd_cl72
''---------------------------------------------------------------------------------
'' an_hcd_higig2                              [1:1]            get_an_hcd_higig2
''                                                             set_an_hcd_higig2
''                                                             read_an_hcd_higig2
''                                                             write_an_hcd_higig2
''---------------------------------------------------------------------------------
'' AHSTC37                                    [0:0]            get_AHSTC37
''                                                             set_AHSTC37
''                                                             read_AHSTC37
''                                                             write_AHSTC37
''---------------------------------------------------------------------------------
Class REGISTER_AN_X4_SW_MANAGEMENT_SGMIIPLUSR_X1_an_ability_resolution_status_sgmiiplusr_x1
    Private write_ASRE_value
    Private read_ASRE_value
    Private flag_ASRE
    Private write_an_hcd_duplex_value
    Private read_an_hcd_duplex_value
    Private flag_an_hcd_duplex
    Private write_an_hcd_pause_value
    Private read_an_hcd_pause_value
    Private flag_an_hcd_pause
    Private write_an_hcd_speed_value
    Private read_an_hcd_speed_value
    Private flag_an_hcd_speed
    Private write_an_hcd_fec_value
    Private read_an_hcd_fec_value
    Private flag_an_hcd_fec
    Private write_an_hcd_cl72_value
    Private read_an_hcd_cl72_value
    Private flag_an_hcd_cl72
    Private write_an_hcd_higig2_value
    Private read_an_hcd_higig2_value
    Private flag_an_hcd_higig2
    Private write_AHSTC37_value
    Private read_AHSTC37_value
    Private flag_AHSTC37

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

    Property Get get_ASRE
        get_ASRE = read_ASRE_value
    End Property

    Property Let set_ASRE(aData)
        write_ASRE_value = aData
        flag_ASRE        = &H1
    End Property

    Property Get read_ASRE
        read
        read_ASRE = read_ASRE_value
    End Property

    Property Let write_ASRE(aData)
        set_ASRE = aData
        write
    End Property

    Property Get get_an_hcd_duplex
        get_an_hcd_duplex = read_an_hcd_duplex_value
    End Property

    Property Let set_an_hcd_duplex(aData)
        write_an_hcd_duplex_value = aData
        flag_an_hcd_duplex        = &H1
    End Property

    Property Get read_an_hcd_duplex
        read
        read_an_hcd_duplex = read_an_hcd_duplex_value
    End Property

    Property Let write_an_hcd_duplex(aData)
        set_an_hcd_duplex = aData
        write
    End Property

    Property Get get_an_hcd_pause
        get_an_hcd_pause = read_an_hcd_pause_value
    End Property

    Property Let set_an_hcd_pause(aData)
        write_an_hcd_pause_value = aData
        flag_an_hcd_pause        = &H1
    End Property

    Property Get read_an_hcd_pause
        read
        read_an_hcd_pause = read_an_hcd_pause_value
    End Property

    Property Let write_an_hcd_pause(aData)
        set_an_hcd_pause = aData
        write
    End Property

    Property Get get_an_hcd_speed
        get_an_hcd_speed = read_an_hcd_speed_value
    End Property

    Property Let set_an_hcd_speed(aData)
        write_an_hcd_speed_value = aData
        flag_an_hcd_speed        = &H1
    End Property

    Property Get read_an_hcd_speed
        read
        read_an_hcd_speed = read_an_hcd_speed_value
    End Property

    Property Let write_an_hcd_speed(aData)
        set_an_hcd_speed = aData
        write
    End Property

    Property Get get_an_hcd_fec
        get_an_hcd_fec = read_an_hcd_fec_value
    End Property

    Property Let set_an_hcd_fec(aData)
        write_an_hcd_fec_value = aData
        flag_an_hcd_fec        = &H1
    End Property

    Property Get read_an_hcd_fec
        read
        read_an_hcd_fec = read_an_hcd_fec_value
    End Property

    Property Let write_an_hcd_fec(aData)
        set_an_hcd_fec = aData
        write
    End Property

    Property Get get_an_hcd_cl72
        get_an_hcd_cl72 = read_an_hcd_cl72_value
    End Property

    Property Let set_an_hcd_cl72(aData)
        write_an_hcd_cl72_value = aData
        flag_an_hcd_cl72        = &H1
    End Property

    Property Get read_an_hcd_cl72
        read
        read_an_hcd_cl72 = read_an_hcd_cl72_value
    End Property

    Property Let write_an_hcd_cl72(aData)
        set_an_hcd_cl72 = aData
        write
    End Property

    Property Get get_an_hcd_higig2
        get_an_hcd_higig2 = read_an_hcd_higig2_value
    End Property

    Property Let set_an_hcd_higig2(aData)
        write_an_hcd_higig2_value = aData
        flag_an_hcd_higig2        = &H1
    End Property

    Property Get read_an_hcd_higig2
        read
        read_an_hcd_higig2 = read_an_hcd_higig2_value
    End Property

    Property Let write_an_hcd_higig2(aData)
        set_an_hcd_higig2 = aData
        write
    End Property

    Property Get get_AHSTC37
        get_AHSTC37 = read_AHSTC37_value
    End Property

    Property Let set_AHSTC37(aData)
        write_AHSTC37_value = aData
        flag_AHSTC37        = &H1
    End Property

    Property Get read_AHSTC37
        read
        read_AHSTC37 = read_AHSTC37_value
    End Property

    Property Let write_AHSTC37(aData)
        set_AHSTC37 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ASRE_value = rightShift(data_low, 13) and &H1
        read_an_hcd_duplex_value = rightShift(data_low, 12) and &H1
        read_an_hcd_pause_value = rightShift(data_low, 10) and &H3
        read_an_hcd_speed_value = rightShift(data_low, 4) and &H3f
        read_an_hcd_fec_value = rightShift(data_low, 3) and &H1
        read_an_hcd_cl72_value = rightShift(data_low, 2) and &H1
        read_an_hcd_higig2_value = rightShift(data_low, 1) and &H1
        AHSTC37_mask = &H1
        if data_low > LONG_MAX then
            if AHSTC37_mask = mask then
                read_AHSTC37_value = data_low
            else
                read_AHSTC37_value = (data_low - H8000_0000) and AHSTC37_mask
            end If
        else
            read_AHSTC37_value = data_low and AHSTC37_mask
        end If

    End Sub

    Sub write
        If flag_ASRE = &H0 or flag_an_hcd_duplex = &H0 or flag_an_hcd_pause = &H0 or flag_an_hcd_speed = &H0 or flag_an_hcd_fec = &H0 or flag_an_hcd_cl72 = &H0 or flag_an_hcd_higig2 = &H0 or flag_AHSTC37 = &H0 Then read
        If flag_ASRE = &H0 Then write_ASRE_value = get_ASRE
        If flag_an_hcd_duplex = &H0 Then write_an_hcd_duplex_value = get_an_hcd_duplex
        If flag_an_hcd_pause = &H0 Then write_an_hcd_pause_value = get_an_hcd_pause
        If flag_an_hcd_speed = &H0 Then write_an_hcd_speed_value = get_an_hcd_speed
        If flag_an_hcd_fec = &H0 Then write_an_hcd_fec_value = get_an_hcd_fec
        If flag_an_hcd_cl72 = &H0 Then write_an_hcd_cl72_value = get_an_hcd_cl72
        If flag_an_hcd_higig2 = &H0 Then write_an_hcd_higig2_value = get_an_hcd_higig2
        If flag_AHSTC37 = &H0 Then write_AHSTC37_value = get_AHSTC37

        regValue = leftShift((write_ASRE_value and &H1), 13) + leftShift((write_an_hcd_duplex_value and &H1), 12) + leftShift((write_an_hcd_pause_value and &H3), 10) + leftShift((write_an_hcd_speed_value and &H3f), 4) + leftShift((write_an_hcd_fec_value and &H1), 3) + leftShift((write_an_hcd_cl72_value and &H1), 2) + leftShift((write_an_hcd_higig2_value and &H1), 1) + leftShift((write_AHSTC37_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ASRE_value = rightShift(data_low, 13) and &H1
        read_an_hcd_duplex_value = rightShift(data_low, 12) and &H1
        read_an_hcd_pause_value = rightShift(data_low, 10) and &H3
        read_an_hcd_speed_value = rightShift(data_low, 4) and &H3f
        read_an_hcd_fec_value = rightShift(data_low, 3) and &H1
        read_an_hcd_cl72_value = rightShift(data_low, 2) and &H1
        read_an_hcd_higig2_value = rightShift(data_low, 1) and &H1
        AHSTC37_mask = &H1
        if data_low > LONG_MAX then
            if AHSTC37_mask = mask then
                read_AHSTC37_value = data_low
            else
                read_AHSTC37_value = (data_low - H8000_0000) and AHSTC37_mask
            end If
        else
            read_AHSTC37_value = data_low and AHSTC37_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ASRE_value = &H0
        flag_ASRE        = &H0
        write_an_hcd_duplex_value = &H0
        flag_an_hcd_duplex        = &H0
        write_an_hcd_pause_value = &H0
        flag_an_hcd_pause        = &H0
        write_an_hcd_speed_value = &H0
        flag_an_hcd_speed        = &H0
        write_an_hcd_fec_value = &H0
        flag_an_hcd_fec        = &H0
        write_an_hcd_cl72_value = &H0
        flag_an_hcd_cl72        = &H0
        write_an_hcd_higig2_value = &H0
        flag_an_hcd_higig2        = &H0
        write_AHSTC37_value = &H0
        flag_AHSTC37        = &H0
    End Sub
End Class


'' @REGISTER : AN_X4_SW_MANAGEMENT_SGMIIPLUSR_X1_an_misc_status_sgmiiplusr_x1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' an_complete                                [15:15]          get_an_complete
''                                                             set_an_complete
''                                                             read_an_complete
''                                                             write_an_complete
''---------------------------------------------------------------------------------
'' an_retry_count                             [14:9]           get_an_retry_count
''                                                             set_an_retry_count
''                                                             read_an_retry_count
''                                                             write_an_retry_count
''---------------------------------------------------------------------------------
'' RFIBP                                      [8:8]            get_RFIBP
''                                                             set_RFIBP
''                                                             read_RFIBP
''                                                             write_RFIBP
''---------------------------------------------------------------------------------
'' pd_completed                               [7:7]            get_pd_completed
''                                                             set_pd_completed
''                                                             read_pd_completed
''                                                             write_pd_completed
''---------------------------------------------------------------------------------
'' an_active                                  [6:6]            get_an_active
''                                                             set_an_active
''                                                             read_an_active
''                                                             write_an_active
''---------------------------------------------------------------------------------
'' an_fail_count                              [5:2]            get_an_fail_count
''                                                             set_an_fail_count
''                                                             read_an_fail_count
''                                                             write_an_fail_count
''---------------------------------------------------------------------------------
'' pd_in_progress                             [1:1]            get_pd_in_progress
''                                                             set_pd_in_progress
''                                                             read_pd_in_progress
''                                                             write_pd_in_progress
''---------------------------------------------------------------------------------
'' pd_hcd_kx4_or_kx                           [0:0]            get_pd_hcd_kx4_or_kx
''                                                             set_pd_hcd_kx4_or_kx
''                                                             read_pd_hcd_kx4_or_kx
''                                                             write_pd_hcd_kx4_or_kx
''---------------------------------------------------------------------------------
Class REGISTER_AN_X4_SW_MANAGEMENT_SGMIIPLUSR_X1_an_misc_status_sgmiiplusr_x1
    Private write_an_complete_value
    Private read_an_complete_value
    Private flag_an_complete
    Private write_an_retry_count_value
    Private read_an_retry_count_value
    Private flag_an_retry_count
    Private write_RFIBP_value
    Private read_RFIBP_value
    Private flag_RFIBP
    Private write_pd_completed_value
    Private read_pd_completed_value
    Private flag_pd_completed
    Private write_an_active_value
    Private read_an_active_value
    Private flag_an_active
    Private write_an_fail_count_value
    Private read_an_fail_count_value
    Private flag_an_fail_count
    Private write_pd_in_progress_value
    Private read_pd_in_progress_value
    Private flag_pd_in_progress
    Private write_pd_hcd_kx4_or_kx_value
    Private read_pd_hcd_kx4_or_kx_value
    Private flag_pd_hcd_kx4_or_kx

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

    Property Get get_an_complete
        get_an_complete = read_an_complete_value
    End Property

    Property Let set_an_complete(aData)
        write_an_complete_value = aData
        flag_an_complete        = &H1
    End Property

    Property Get read_an_complete
        read
        read_an_complete = read_an_complete_value
    End Property

    Property Let write_an_complete(aData)
        set_an_complete = aData
        write
    End Property

    Property Get get_an_retry_count
        get_an_retry_count = read_an_retry_count_value
    End Property

    Property Let set_an_retry_count(aData)
        write_an_retry_count_value = aData
        flag_an_retry_count        = &H1
    End Property

    Property Get read_an_retry_count
        read
        read_an_retry_count = read_an_retry_count_value
    End Property

    Property Let write_an_retry_count(aData)
        set_an_retry_count = aData
        write
    End Property

    Property Get get_RFIBP
        get_RFIBP = read_RFIBP_value
    End Property

    Property Let set_RFIBP(aData)
        write_RFIBP_value = aData
        flag_RFIBP        = &H1
    End Property

    Property Get read_RFIBP
        read
        read_RFIBP = read_RFIBP_value
    End Property

    Property Let write_RFIBP(aData)
        set_RFIBP = aData
        write
    End Property

    Property Get get_pd_completed
        get_pd_completed = read_pd_completed_value
    End Property

    Property Let set_pd_completed(aData)
        write_pd_completed_value = aData
        flag_pd_completed        = &H1
    End Property

    Property Get read_pd_completed
        read
        read_pd_completed = read_pd_completed_value
    End Property

    Property Let write_pd_completed(aData)
        set_pd_completed = aData
        write
    End Property

    Property Get get_an_active
        get_an_active = read_an_active_value
    End Property

    Property Let set_an_active(aData)
        write_an_active_value = aData
        flag_an_active        = &H1
    End Property

    Property Get read_an_active
        read
        read_an_active = read_an_active_value
    End Property

    Property Let write_an_active(aData)
        set_an_active = aData
        write
    End Property

    Property Get get_an_fail_count
        get_an_fail_count = read_an_fail_count_value
    End Property

    Property Let set_an_fail_count(aData)
        write_an_fail_count_value = aData
        flag_an_fail_count        = &H1
    End Property

    Property Get read_an_fail_count
        read
        read_an_fail_count = read_an_fail_count_value
    End Property

    Property Let write_an_fail_count(aData)
        set_an_fail_count = aData
        write
    End Property

    Property Get get_pd_in_progress
        get_pd_in_progress = read_pd_in_progress_value
    End Property

    Property Let set_pd_in_progress(aData)
        write_pd_in_progress_value = aData
        flag_pd_in_progress        = &H1
    End Property

    Property Get read_pd_in_progress
        read
        read_pd_in_progress = read_pd_in_progress_value
    End Property

    Property Let write_pd_in_progress(aData)
        set_pd_in_progress = aData
        write
    End Property

    Property Get get_pd_hcd_kx4_or_kx
        get_pd_hcd_kx4_or_kx = read_pd_hcd_kx4_or_kx_value
    End Property

    Property Let set_pd_hcd_kx4_or_kx(aData)
        write_pd_hcd_kx4_or_kx_value = aData
        flag_pd_hcd_kx4_or_kx        = &H1
    End Property

    Property Get read_pd_hcd_kx4_or_kx
        read
        read_pd_hcd_kx4_or_kx = read_pd_hcd_kx4_or_kx_value
    End Property

    Property Let write_pd_hcd_kx4_or_kx(aData)
        set_pd_hcd_kx4_or_kx = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_an_complete_value = rightShift(data_low, 15) and &H1
        read_an_retry_count_value = rightShift(data_low, 9) and &H3f
        read_RFIBP_value = rightShift(data_low, 8) and &H1
        read_pd_completed_value = rightShift(data_low, 7) and &H1
        read_an_active_value = rightShift(data_low, 6) and &H1
        read_an_fail_count_value = rightShift(data_low, 2) and &Hf
        read_pd_in_progress_value = rightShift(data_low, 1) and &H1
        pd_hcd_kx4_or_kx_mask = &H1
        if data_low > LONG_MAX then
            if pd_hcd_kx4_or_kx_mask = mask then
                read_pd_hcd_kx4_or_kx_value = data_low
            else
                read_pd_hcd_kx4_or_kx_value = (data_low - H8000_0000) and pd_hcd_kx4_or_kx_mask
            end If
        else
            read_pd_hcd_kx4_or_kx_value = data_low and pd_hcd_kx4_or_kx_mask
        end If

    End Sub

    Sub write
        If flag_an_complete = &H0 or flag_an_retry_count = &H0 or flag_RFIBP = &H0 or flag_pd_completed = &H0 or flag_an_active = &H0 or flag_an_fail_count = &H0 or flag_pd_in_progress = &H0 or flag_pd_hcd_kx4_or_kx = &H0 Then read
        If flag_an_complete = &H0 Then write_an_complete_value = get_an_complete
        If flag_an_retry_count = &H0 Then write_an_retry_count_value = get_an_retry_count
        If flag_RFIBP = &H0 Then write_RFIBP_value = get_RFIBP
        If flag_pd_completed = &H0 Then write_pd_completed_value = get_pd_completed
        If flag_an_active = &H0 Then write_an_active_value = get_an_active
        If flag_an_fail_count = &H0 Then write_an_fail_count_value = get_an_fail_count
        If flag_pd_in_progress = &H0 Then write_pd_in_progress_value = get_pd_in_progress
        If flag_pd_hcd_kx4_or_kx = &H0 Then write_pd_hcd_kx4_or_kx_value = get_pd_hcd_kx4_or_kx

        regValue = leftShift((write_an_complete_value and &H1), 15) + leftShift((write_an_retry_count_value and &H3f), 9) + leftShift((write_RFIBP_value and &H1), 8) + leftShift((write_pd_completed_value and &H1), 7) + leftShift((write_an_active_value and &H1), 6) + leftShift((write_an_fail_count_value and &Hf), 2) + leftShift((write_pd_in_progress_value and &H1), 1) + leftShift((write_pd_hcd_kx4_or_kx_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_an_complete_value = rightShift(data_low, 15) and &H1
        read_an_retry_count_value = rightShift(data_low, 9) and &H3f
        read_RFIBP_value = rightShift(data_low, 8) and &H1
        read_pd_completed_value = rightShift(data_low, 7) and &H1
        read_an_active_value = rightShift(data_low, 6) and &H1
        read_an_fail_count_value = rightShift(data_low, 2) and &Hf
        read_pd_in_progress_value = rightShift(data_low, 1) and &H1
        pd_hcd_kx4_or_kx_mask = &H1
        if data_low > LONG_MAX then
            if pd_hcd_kx4_or_kx_mask = mask then
                read_pd_hcd_kx4_or_kx_value = data_low
            else
                read_pd_hcd_kx4_or_kx_value = (data_low - H8000_0000) and pd_hcd_kx4_or_kx_mask
            end If
        else
            read_pd_hcd_kx4_or_kx_value = data_low and pd_hcd_kx4_or_kx_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_an_complete_value = &H0
        flag_an_complete        = &H0
        write_an_retry_count_value = &H0
        flag_an_retry_count        = &H0
        write_RFIBP_value = &H0
        flag_RFIBP        = &H0
        write_pd_completed_value = &H0
        flag_pd_completed        = &H0
        write_an_active_value = &H0
        flag_an_active        = &H0
        write_an_fail_count_value = &H0
        flag_an_fail_count        = &H0
        write_pd_in_progress_value = &H0
        flag_pd_in_progress        = &H0
        write_pd_hcd_kx4_or_kx_value = &H0
        flag_pd_hcd_kx4_or_kx        = &H0
    End Sub
End Class


'' @REGISTER : AN_X4_SW_MANAGEMENT_SGMIIPLUSR_X1_tla_sequencer_status_sgmiiplusr_x1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TLSFS                                      [10:0]           get_TLSFS
''                                                             set_TLSFS
''                                                             read_TLSFS
''                                                             write_TLSFS
''---------------------------------------------------------------------------------
Class REGISTER_AN_X4_SW_MANAGEMENT_SGMIIPLUSR_X1_tla_sequencer_status_sgmiiplusr_x1
    Private write_TLSFS_value
    Private read_TLSFS_value
    Private flag_TLSFS

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

    Property Get get_TLSFS
        get_TLSFS = read_TLSFS_value
    End Property

    Property Let set_TLSFS(aData)
        write_TLSFS_value = aData
        flag_TLSFS        = &H1
    End Property

    Property Get read_TLSFS
        read
        read_TLSFS = read_TLSFS_value
    End Property

    Property Let write_TLSFS(aData)
        set_TLSFS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TLSFS_mask = &H7ff
        if data_low > LONG_MAX then
            if TLSFS_mask = mask then
                read_TLSFS_value = data_low
            else
                read_TLSFS_value = (data_low - H8000_0000) and TLSFS_mask
            end If
        else
            read_TLSFS_value = data_low and TLSFS_mask
        end If

    End Sub

    Sub write
        If flag_TLSFS = &H0 Then read
        If flag_TLSFS = &H0 Then write_TLSFS_value = get_TLSFS

        regValue = leftShift((write_TLSFS_value and &H7ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TLSFS_mask = &H7ff
        if data_low > LONG_MAX then
            if TLSFS_mask = mask then
                read_TLSFS_value = data_low
            else
                read_TLSFS_value = (data_low - H8000_0000) and TLSFS_mask
            end If
        else
            read_TLSFS_value = data_low and TLSFS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TLSFS_value = &H0
        flag_TLSFS        = &H0
    End Sub
End Class


'' @REGISTER : AN_X4_SW_MANAGEMENT_SGMIIPLUSR_X1_an_seq_unexpected_page_sgmiiplusr_x1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SUP                                        [15:0]           get_SUP
''                                                             set_SUP
''                                                             read_SUP
''                                                             write_SUP
''---------------------------------------------------------------------------------
Class REGISTER_AN_X4_SW_MANAGEMENT_SGMIIPLUSR_X1_an_seq_unexpected_page_sgmiiplusr_x1
    Private write_SUP_value
    Private read_SUP_value
    Private flag_SUP

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

    Property Get get_SUP
        get_SUP = read_SUP_value
    End Property

    Property Let set_SUP(aData)
        write_SUP_value = aData
        flag_SUP        = &H1
    End Property

    Property Get read_SUP
        read
        read_SUP = read_SUP_value
    End Property

    Property Let write_SUP(aData)
        set_SUP = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SUP_mask = &Hffff
        if data_low > LONG_MAX then
            if SUP_mask = mask then
                read_SUP_value = data_low
            else
                read_SUP_value = (data_low - H8000_0000) and SUP_mask
            end If
        else
            read_SUP_value = data_low and SUP_mask
        end If

    End Sub

    Sub write
        If flag_SUP = &H0 Then read
        If flag_SUP = &H0 Then write_SUP_value = get_SUP

        regValue = leftShift((write_SUP_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SUP_mask = &Hffff
        if data_low > LONG_MAX then
            if SUP_mask = mask then
                read_SUP_value = data_low
            else
                read_SUP_value = (data_low - H8000_0000) and SUP_mask
            end If
        else
            read_SUP_value = data_low and SUP_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SUP_value = &H0
        flag_SUP        = &H0
    End Sub
End Class


'' @REGISTER : AN_X4_SW_MANAGEMENT_SGMIIPLUSR_X1_blockaddress
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
Class REGISTER_AN_X4_SW_MANAGEMENT_SGMIIPLUSR_X1_blockaddress
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

Class AN_X4_SW_MANAGEMENT_SGMIIPLUSR_X1_INSTANCE

    Public ld_page_2_sgmiiplusr_x1
    Public ld_page_1_sgmiiplusr_x1
    Public ld_page_0_sgmiiplusr_x1
    Public lp_page_2_sgmiiplusr_x1
    Public lp_page_1_sgmiiplusr_x1
    Public lp_page_0_sgmiiplusr_x1
    Public sw_control_status_sgmiiplusr_x1
    Public ld_control_sgmiiplusr_x1
    Public an_page_sequencer_status_sgmiiplusr_x1
    Public an_page_exchangeer_status_sgmiiplusr_x1
    Public an_page_decoder_status_sgmiiplusr_x1
    Public an_ability_resolution_status_sgmiiplusr_x1
    Public an_misc_status_sgmiiplusr_x1
    Public tla_sequencer_status_sgmiiplusr_x1
    Public an_seq_unexpected_page_sgmiiplusr_x1
    Public blockaddress


    Public default function Init(aBaseAddr)
        Set ld_page_2_sgmiiplusr_x1 = (New REGISTER_AN_X4_SW_MANAGEMENT_SGMIIPLUSR_X1_ld_page_2_sgmiiplusr_x1)(aBaseAddr, 16)
        Set ld_page_1_sgmiiplusr_x1 = (New REGISTER_AN_X4_SW_MANAGEMENT_SGMIIPLUSR_X1_ld_page_1_sgmiiplusr_x1)(aBaseAddr, 16)
        Set ld_page_0_sgmiiplusr_x1 = (New REGISTER_AN_X4_SW_MANAGEMENT_SGMIIPLUSR_X1_ld_page_0_sgmiiplusr_x1)(aBaseAddr, 16)
        Set lp_page_2_sgmiiplusr_x1 = (New REGISTER_AN_X4_SW_MANAGEMENT_SGMIIPLUSR_X1_lp_page_2_sgmiiplusr_x1)(aBaseAddr, 16)
        Set lp_page_1_sgmiiplusr_x1 = (New REGISTER_AN_X4_SW_MANAGEMENT_SGMIIPLUSR_X1_lp_page_1_sgmiiplusr_x1)(aBaseAddr, 16)
        Set lp_page_0_sgmiiplusr_x1 = (New REGISTER_AN_X4_SW_MANAGEMENT_SGMIIPLUSR_X1_lp_page_0_sgmiiplusr_x1)(aBaseAddr, 16)
        Set sw_control_status_sgmiiplusr_x1 = (New REGISTER_AN_X4_SW_MANAGEMENT_SGMIIPLUSR_X1_sw_control_status_sgmiiplusr_x1)(aBaseAddr, 16)
        Set ld_control_sgmiiplusr_x1 = (New REGISTER_AN_X4_SW_MANAGEMENT_SGMIIPLUSR_X1_ld_control_sgmiiplusr_x1)(aBaseAddr, 16)
        Set an_page_sequencer_status_sgmiiplusr_x1 = (New REGISTER_AN_X4_SW_MANAGEMENT_SGMIIPLUSR_X1_an_page_sequencer_status_sgmiiplusr_x1)(aBaseAddr, 16)
        Set an_page_exchangeer_status_sgmiiplusr_x1 = (New REGISTER_AN_X4_SW_MANAGEMENT_SGMIIPLUSR_X1_an_page_exchangeer_status_sgmiiplusr_x1)(aBaseAddr, 16)
        Set an_page_decoder_status_sgmiiplusr_x1 = (New REGISTER_AN_X4_SW_MANAGEMENT_SGMIIPLUSR_X1_an_page_decoder_status_sgmiiplusr_x1)(aBaseAddr, 16)
        Set an_ability_resolution_status_sgmiiplusr_x1 = (New REGISTER_AN_X4_SW_MANAGEMENT_SGMIIPLUSR_X1_an_ability_resolution_status_sgmiiplusr_x1)(aBaseAddr, 16)
        Set an_misc_status_sgmiiplusr_x1 = (New REGISTER_AN_X4_SW_MANAGEMENT_SGMIIPLUSR_X1_an_misc_status_sgmiiplusr_x1)(aBaseAddr, 16)
        Set tla_sequencer_status_sgmiiplusr_x1 = (New REGISTER_AN_X4_SW_MANAGEMENT_SGMIIPLUSR_X1_tla_sequencer_status_sgmiiplusr_x1)(aBaseAddr, 16)
        Set an_seq_unexpected_page_sgmiiplusr_x1 = (New REGISTER_AN_X4_SW_MANAGEMENT_SGMIIPLUSR_X1_an_seq_unexpected_page_sgmiiplusr_x1)(aBaseAddr, 16)
        Set blockaddress = (New REGISTER_AN_X4_SW_MANAGEMENT_SGMIIPLUSR_X1_blockaddress)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set AN_X4_SW_MANAGEMENT_SGMIIPLUSR_X1 = CreateObject("System.Collections.ArrayList")
AN_X4_SW_MANAGEMENT_SGMIIPLUSR_X1.Add ((New AN_X4_SW_MANAGEMENT_SGMIIPLUSR_X1_INSTANCE)(&H4aed8940))


