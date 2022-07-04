

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


'' @REGISTER : AN_X4_HW_LP_PAGES_SGMIIPLUSR_X1_lp_mp5_up1_sgmiiplusr_x1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LM5U1SX1PD                                 [15:0]           get_LM5U1SX1PD
''                                                             set_LM5U1SX1PD
''                                                             read_LM5U1SX1PD
''                                                             write_LM5U1SX1PD
''---------------------------------------------------------------------------------
Class REGISTER_AN_X4_HW_LP_PAGES_SGMIIPLUSR_X1_lp_mp5_up1_sgmiiplusr_x1
    Private write_LM5U1SX1PD_value
    Private read_LM5U1SX1PD_value
    Private flag_LM5U1SX1PD

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

    Property Get get_LM5U1SX1PD
        get_LM5U1SX1PD = read_LM5U1SX1PD_value
    End Property

    Property Let set_LM5U1SX1PD(aData)
        write_LM5U1SX1PD_value = aData
        flag_LM5U1SX1PD        = &H1
    End Property

    Property Get read_LM5U1SX1PD
        read
        read_LM5U1SX1PD = read_LM5U1SX1PD_value
    End Property

    Property Let write_LM5U1SX1PD(aData)
        set_LM5U1SX1PD = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LM5U1SX1PD_mask = &Hffff
        if data_low > LONG_MAX then
            if LM5U1SX1PD_mask = mask then
                read_LM5U1SX1PD_value = data_low
            else
                read_LM5U1SX1PD_value = (data_low - H8000_0000) and LM5U1SX1PD_mask
            end If
        else
            read_LM5U1SX1PD_value = data_low and LM5U1SX1PD_mask
        end If

    End Sub

    Sub write
        If flag_LM5U1SX1PD = &H0 Then read
        If flag_LM5U1SX1PD = &H0 Then write_LM5U1SX1PD_value = get_LM5U1SX1PD

        regValue = leftShift((write_LM5U1SX1PD_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LM5U1SX1PD_mask = &Hffff
        if data_low > LONG_MAX then
            if LM5U1SX1PD_mask = mask then
                read_LM5U1SX1PD_value = data_low
            else
                read_LM5U1SX1PD_value = (data_low - H8000_0000) and LM5U1SX1PD_mask
            end If
        else
            read_LM5U1SX1PD_value = data_low and LM5U1SX1PD_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LM5U1SX1PD_value = &H0
        flag_LM5U1SX1PD        = &H0
    End Sub
End Class


'' @REGISTER : AN_X4_HW_LP_PAGES_SGMIIPLUSR_X1_lp_mp5_up2_sgmiiplusr_x1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LM5U2SX1PD                                 [15:0]           get_LM5U2SX1PD
''                                                             set_LM5U2SX1PD
''                                                             read_LM5U2SX1PD
''                                                             write_LM5U2SX1PD
''---------------------------------------------------------------------------------
Class REGISTER_AN_X4_HW_LP_PAGES_SGMIIPLUSR_X1_lp_mp5_up2_sgmiiplusr_x1
    Private write_LM5U2SX1PD_value
    Private read_LM5U2SX1PD_value
    Private flag_LM5U2SX1PD

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

    Property Get get_LM5U2SX1PD
        get_LM5U2SX1PD = read_LM5U2SX1PD_value
    End Property

    Property Let set_LM5U2SX1PD(aData)
        write_LM5U2SX1PD_value = aData
        flag_LM5U2SX1PD        = &H1
    End Property

    Property Get read_LM5U2SX1PD
        read
        read_LM5U2SX1PD = read_LM5U2SX1PD_value
    End Property

    Property Let write_LM5U2SX1PD(aData)
        set_LM5U2SX1PD = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LM5U2SX1PD_mask = &Hffff
        if data_low > LONG_MAX then
            if LM5U2SX1PD_mask = mask then
                read_LM5U2SX1PD_value = data_low
            else
                read_LM5U2SX1PD_value = (data_low - H8000_0000) and LM5U2SX1PD_mask
            end If
        else
            read_LM5U2SX1PD_value = data_low and LM5U2SX1PD_mask
        end If

    End Sub

    Sub write
        If flag_LM5U2SX1PD = &H0 Then read
        If flag_LM5U2SX1PD = &H0 Then write_LM5U2SX1PD_value = get_LM5U2SX1PD

        regValue = leftShift((write_LM5U2SX1PD_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LM5U2SX1PD_mask = &Hffff
        if data_low > LONG_MAX then
            if LM5U2SX1PD_mask = mask then
                read_LM5U2SX1PD_value = data_low
            else
                read_LM5U2SX1PD_value = (data_low - H8000_0000) and LM5U2SX1PD_mask
            end If
        else
            read_LM5U2SX1PD_value = data_low and LM5U2SX1PD_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LM5U2SX1PD_value = &H0
        flag_LM5U2SX1PD        = &H0
    End Sub
End Class


'' @REGISTER : AN_X4_HW_LP_PAGES_SGMIIPLUSR_X1_lp_mp5_up3_sgmiiplusr_x1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LM5U3SX1PD                                 [15:0]           get_LM5U3SX1PD
''                                                             set_LM5U3SX1PD
''                                                             read_LM5U3SX1PD
''                                                             write_LM5U3SX1PD
''---------------------------------------------------------------------------------
Class REGISTER_AN_X4_HW_LP_PAGES_SGMIIPLUSR_X1_lp_mp5_up3_sgmiiplusr_x1
    Private write_LM5U3SX1PD_value
    Private read_LM5U3SX1PD_value
    Private flag_LM5U3SX1PD

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

    Property Get get_LM5U3SX1PD
        get_LM5U3SX1PD = read_LM5U3SX1PD_value
    End Property

    Property Let set_LM5U3SX1PD(aData)
        write_LM5U3SX1PD_value = aData
        flag_LM5U3SX1PD        = &H1
    End Property

    Property Get read_LM5U3SX1PD
        read
        read_LM5U3SX1PD = read_LM5U3SX1PD_value
    End Property

    Property Let write_LM5U3SX1PD(aData)
        set_LM5U3SX1PD = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LM5U3SX1PD_mask = &Hffff
        if data_low > LONG_MAX then
            if LM5U3SX1PD_mask = mask then
                read_LM5U3SX1PD_value = data_low
            else
                read_LM5U3SX1PD_value = (data_low - H8000_0000) and LM5U3SX1PD_mask
            end If
        else
            read_LM5U3SX1PD_value = data_low and LM5U3SX1PD_mask
        end If

    End Sub

    Sub write
        If flag_LM5U3SX1PD = &H0 Then read
        If flag_LM5U3SX1PD = &H0 Then write_LM5U3SX1PD_value = get_LM5U3SX1PD

        regValue = leftShift((write_LM5U3SX1PD_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LM5U3SX1PD_mask = &Hffff
        if data_low > LONG_MAX then
            if LM5U3SX1PD_mask = mask then
                read_LM5U3SX1PD_value = data_low
            else
                read_LM5U3SX1PD_value = (data_low - H8000_0000) and LM5U3SX1PD_mask
            end If
        else
            read_LM5U3SX1PD_value = data_low and LM5U3SX1PD_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LM5U3SX1PD_value = &H0
        flag_LM5U3SX1PD        = &H0
    End Sub
End Class


'' @REGISTER : AN_X4_HW_LP_PAGES_SGMIIPLUSR_X1_lp_mp5_up4_sgmiiplusr_x1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LM5U4SX1PD                                 [15:0]           get_LM5U4SX1PD
''                                                             set_LM5U4SX1PD
''                                                             read_LM5U4SX1PD
''                                                             write_LM5U4SX1PD
''---------------------------------------------------------------------------------
Class REGISTER_AN_X4_HW_LP_PAGES_SGMIIPLUSR_X1_lp_mp5_up4_sgmiiplusr_x1
    Private write_LM5U4SX1PD_value
    Private read_LM5U4SX1PD_value
    Private flag_LM5U4SX1PD

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

    Property Get get_LM5U4SX1PD
        get_LM5U4SX1PD = read_LM5U4SX1PD_value
    End Property

    Property Let set_LM5U4SX1PD(aData)
        write_LM5U4SX1PD_value = aData
        flag_LM5U4SX1PD        = &H1
    End Property

    Property Get read_LM5U4SX1PD
        read
        read_LM5U4SX1PD = read_LM5U4SX1PD_value
    End Property

    Property Let write_LM5U4SX1PD(aData)
        set_LM5U4SX1PD = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LM5U4SX1PD_mask = &Hffff
        if data_low > LONG_MAX then
            if LM5U4SX1PD_mask = mask then
                read_LM5U4SX1PD_value = data_low
            else
                read_LM5U4SX1PD_value = (data_low - H8000_0000) and LM5U4SX1PD_mask
            end If
        else
            read_LM5U4SX1PD_value = data_low and LM5U4SX1PD_mask
        end If

    End Sub

    Sub write
        If flag_LM5U4SX1PD = &H0 Then read
        If flag_LM5U4SX1PD = &H0 Then write_LM5U4SX1PD_value = get_LM5U4SX1PD

        regValue = leftShift((write_LM5U4SX1PD_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LM5U4SX1PD_mask = &Hffff
        if data_low > LONG_MAX then
            if LM5U4SX1PD_mask = mask then
                read_LM5U4SX1PD_value = data_low
            else
                read_LM5U4SX1PD_value = (data_low - H8000_0000) and LM5U4SX1PD_mask
            end If
        else
            read_LM5U4SX1PD_value = data_low and LM5U4SX1PD_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LM5U4SX1PD_value = &H0
        flag_LM5U4SX1PD        = &H0
    End Sub
End Class


'' @REGISTER : AN_X4_HW_LP_PAGES_SGMIIPLUSR_X1_lp_mp1024_up1_sgmiiplusr_x1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LM1024U1SX1PD                              [15:0]           get_LM1024U1SX1PD
''                                                             set_LM1024U1SX1PD
''                                                             read_LM1024U1SX1PD
''                                                             write_LM1024U1SX1PD
''---------------------------------------------------------------------------------
Class REGISTER_AN_X4_HW_LP_PAGES_SGMIIPLUSR_X1_lp_mp1024_up1_sgmiiplusr_x1
    Private write_LM1024U1SX1PD_value
    Private read_LM1024U1SX1PD_value
    Private flag_LM1024U1SX1PD

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

    Property Get get_LM1024U1SX1PD
        get_LM1024U1SX1PD = read_LM1024U1SX1PD_value
    End Property

    Property Let set_LM1024U1SX1PD(aData)
        write_LM1024U1SX1PD_value = aData
        flag_LM1024U1SX1PD        = &H1
    End Property

    Property Get read_LM1024U1SX1PD
        read
        read_LM1024U1SX1PD = read_LM1024U1SX1PD_value
    End Property

    Property Let write_LM1024U1SX1PD(aData)
        set_LM1024U1SX1PD = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LM1024U1SX1PD_mask = &Hffff
        if data_low > LONG_MAX then
            if LM1024U1SX1PD_mask = mask then
                read_LM1024U1SX1PD_value = data_low
            else
                read_LM1024U1SX1PD_value = (data_low - H8000_0000) and LM1024U1SX1PD_mask
            end If
        else
            read_LM1024U1SX1PD_value = data_low and LM1024U1SX1PD_mask
        end If

    End Sub

    Sub write
        If flag_LM1024U1SX1PD = &H0 Then read
        If flag_LM1024U1SX1PD = &H0 Then write_LM1024U1SX1PD_value = get_LM1024U1SX1PD

        regValue = leftShift((write_LM1024U1SX1PD_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LM1024U1SX1PD_mask = &Hffff
        if data_low > LONG_MAX then
            if LM1024U1SX1PD_mask = mask then
                read_LM1024U1SX1PD_value = data_low
            else
                read_LM1024U1SX1PD_value = (data_low - H8000_0000) and LM1024U1SX1PD_mask
            end If
        else
            read_LM1024U1SX1PD_value = data_low and LM1024U1SX1PD_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LM1024U1SX1PD_value = &H0
        flag_LM1024U1SX1PD        = &H0
    End Sub
End Class


'' @REGISTER : AN_X4_HW_LP_PAGES_SGMIIPLUSR_X1_lp_mp1024_up2_sgmiiplusr_x1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LM1024U2SX1PD                              [15:0]           get_LM1024U2SX1PD
''                                                             set_LM1024U2SX1PD
''                                                             read_LM1024U2SX1PD
''                                                             write_LM1024U2SX1PD
''---------------------------------------------------------------------------------
Class REGISTER_AN_X4_HW_LP_PAGES_SGMIIPLUSR_X1_lp_mp1024_up2_sgmiiplusr_x1
    Private write_LM1024U2SX1PD_value
    Private read_LM1024U2SX1PD_value
    Private flag_LM1024U2SX1PD

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

    Property Get get_LM1024U2SX1PD
        get_LM1024U2SX1PD = read_LM1024U2SX1PD_value
    End Property

    Property Let set_LM1024U2SX1PD(aData)
        write_LM1024U2SX1PD_value = aData
        flag_LM1024U2SX1PD        = &H1
    End Property

    Property Get read_LM1024U2SX1PD
        read
        read_LM1024U2SX1PD = read_LM1024U2SX1PD_value
    End Property

    Property Let write_LM1024U2SX1PD(aData)
        set_LM1024U2SX1PD = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LM1024U2SX1PD_mask = &Hffff
        if data_low > LONG_MAX then
            if LM1024U2SX1PD_mask = mask then
                read_LM1024U2SX1PD_value = data_low
            else
                read_LM1024U2SX1PD_value = (data_low - H8000_0000) and LM1024U2SX1PD_mask
            end If
        else
            read_LM1024U2SX1PD_value = data_low and LM1024U2SX1PD_mask
        end If

    End Sub

    Sub write
        If flag_LM1024U2SX1PD = &H0 Then read
        If flag_LM1024U2SX1PD = &H0 Then write_LM1024U2SX1PD_value = get_LM1024U2SX1PD

        regValue = leftShift((write_LM1024U2SX1PD_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LM1024U2SX1PD_mask = &Hffff
        if data_low > LONG_MAX then
            if LM1024U2SX1PD_mask = mask then
                read_LM1024U2SX1PD_value = data_low
            else
                read_LM1024U2SX1PD_value = (data_low - H8000_0000) and LM1024U2SX1PD_mask
            end If
        else
            read_LM1024U2SX1PD_value = data_low and LM1024U2SX1PD_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LM1024U2SX1PD_value = &H0
        flag_LM1024U2SX1PD        = &H0
    End Sub
End Class


'' @REGISTER : AN_X4_HW_LP_PAGES_SGMIIPLUSR_X1_lp_mp1024_up3_sgmiiplusr_x1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LM1024U3SX1PD                              [15:0]           get_LM1024U3SX1PD
''                                                             set_LM1024U3SX1PD
''                                                             read_LM1024U3SX1PD
''                                                             write_LM1024U3SX1PD
''---------------------------------------------------------------------------------
Class REGISTER_AN_X4_HW_LP_PAGES_SGMIIPLUSR_X1_lp_mp1024_up3_sgmiiplusr_x1
    Private write_LM1024U3SX1PD_value
    Private read_LM1024U3SX1PD_value
    Private flag_LM1024U3SX1PD

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

    Property Get get_LM1024U3SX1PD
        get_LM1024U3SX1PD = read_LM1024U3SX1PD_value
    End Property

    Property Let set_LM1024U3SX1PD(aData)
        write_LM1024U3SX1PD_value = aData
        flag_LM1024U3SX1PD        = &H1
    End Property

    Property Get read_LM1024U3SX1PD
        read
        read_LM1024U3SX1PD = read_LM1024U3SX1PD_value
    End Property

    Property Let write_LM1024U3SX1PD(aData)
        set_LM1024U3SX1PD = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LM1024U3SX1PD_mask = &Hffff
        if data_low > LONG_MAX then
            if LM1024U3SX1PD_mask = mask then
                read_LM1024U3SX1PD_value = data_low
            else
                read_LM1024U3SX1PD_value = (data_low - H8000_0000) and LM1024U3SX1PD_mask
            end If
        else
            read_LM1024U3SX1PD_value = data_low and LM1024U3SX1PD_mask
        end If

    End Sub

    Sub write
        If flag_LM1024U3SX1PD = &H0 Then read
        If flag_LM1024U3SX1PD = &H0 Then write_LM1024U3SX1PD_value = get_LM1024U3SX1PD

        regValue = leftShift((write_LM1024U3SX1PD_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LM1024U3SX1PD_mask = &Hffff
        if data_low > LONG_MAX then
            if LM1024U3SX1PD_mask = mask then
                read_LM1024U3SX1PD_value = data_low
            else
                read_LM1024U3SX1PD_value = (data_low - H8000_0000) and LM1024U3SX1PD_mask
            end If
        else
            read_LM1024U3SX1PD_value = data_low and LM1024U3SX1PD_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LM1024U3SX1PD_value = &H0
        flag_LM1024U3SX1PD        = &H0
    End Sub
End Class


'' @REGISTER : AN_X4_HW_LP_PAGES_SGMIIPLUSR_X1_lp_mp1024_up4_sgmiiplusr_x1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LM1024U4SX1PD                              [15:0]           get_LM1024U4SX1PD
''                                                             set_LM1024U4SX1PD
''                                                             read_LM1024U4SX1PD
''                                                             write_LM1024U4SX1PD
''---------------------------------------------------------------------------------
Class REGISTER_AN_X4_HW_LP_PAGES_SGMIIPLUSR_X1_lp_mp1024_up4_sgmiiplusr_x1
    Private write_LM1024U4SX1PD_value
    Private read_LM1024U4SX1PD_value
    Private flag_LM1024U4SX1PD

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

    Property Get get_LM1024U4SX1PD
        get_LM1024U4SX1PD = read_LM1024U4SX1PD_value
    End Property

    Property Let set_LM1024U4SX1PD(aData)
        write_LM1024U4SX1PD_value = aData
        flag_LM1024U4SX1PD        = &H1
    End Property

    Property Get read_LM1024U4SX1PD
        read
        read_LM1024U4SX1PD = read_LM1024U4SX1PD_value
    End Property

    Property Let write_LM1024U4SX1PD(aData)
        set_LM1024U4SX1PD = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LM1024U4SX1PD_mask = &Hffff
        if data_low > LONG_MAX then
            if LM1024U4SX1PD_mask = mask then
                read_LM1024U4SX1PD_value = data_low
            else
                read_LM1024U4SX1PD_value = (data_low - H8000_0000) and LM1024U4SX1PD_mask
            end If
        else
            read_LM1024U4SX1PD_value = data_low and LM1024U4SX1PD_mask
        end If

    End Sub

    Sub write
        If flag_LM1024U4SX1PD = &H0 Then read
        If flag_LM1024U4SX1PD = &H0 Then write_LM1024U4SX1PD_value = get_LM1024U4SX1PD

        regValue = leftShift((write_LM1024U4SX1PD_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LM1024U4SX1PD_mask = &Hffff
        if data_low > LONG_MAX then
            if LM1024U4SX1PD_mask = mask then
                read_LM1024U4SX1PD_value = data_low
            else
                read_LM1024U4SX1PD_value = (data_low - H8000_0000) and LM1024U4SX1PD_mask
            end If
        else
            read_LM1024U4SX1PD_value = data_low and LM1024U4SX1PD_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LM1024U4SX1PD_value = &H0
        flag_LM1024U4SX1PD        = &H0
    End Sub
End Class


'' @REGISTER : AN_X4_HW_LP_PAGES_SGMIIPLUSR_X1_lp_base_page1_sgmiiplusr_x1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LBP1SX1PD                                  [15:0]           get_LBP1SX1PD
''                                                             set_LBP1SX1PD
''                                                             read_LBP1SX1PD
''                                                             write_LBP1SX1PD
''---------------------------------------------------------------------------------
Class REGISTER_AN_X4_HW_LP_PAGES_SGMIIPLUSR_X1_lp_base_page1_sgmiiplusr_x1
    Private write_LBP1SX1PD_value
    Private read_LBP1SX1PD_value
    Private flag_LBP1SX1PD

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

    Property Get get_LBP1SX1PD
        get_LBP1SX1PD = read_LBP1SX1PD_value
    End Property

    Property Let set_LBP1SX1PD(aData)
        write_LBP1SX1PD_value = aData
        flag_LBP1SX1PD        = &H1
    End Property

    Property Get read_LBP1SX1PD
        read
        read_LBP1SX1PD = read_LBP1SX1PD_value
    End Property

    Property Let write_LBP1SX1PD(aData)
        set_LBP1SX1PD = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LBP1SX1PD_mask = &Hffff
        if data_low > LONG_MAX then
            if LBP1SX1PD_mask = mask then
                read_LBP1SX1PD_value = data_low
            else
                read_LBP1SX1PD_value = (data_low - H8000_0000) and LBP1SX1PD_mask
            end If
        else
            read_LBP1SX1PD_value = data_low and LBP1SX1PD_mask
        end If

    End Sub

    Sub write
        If flag_LBP1SX1PD = &H0 Then read
        If flag_LBP1SX1PD = &H0 Then write_LBP1SX1PD_value = get_LBP1SX1PD

        regValue = leftShift((write_LBP1SX1PD_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LBP1SX1PD_mask = &Hffff
        if data_low > LONG_MAX then
            if LBP1SX1PD_mask = mask then
                read_LBP1SX1PD_value = data_low
            else
                read_LBP1SX1PD_value = (data_low - H8000_0000) and LBP1SX1PD_mask
            end If
        else
            read_LBP1SX1PD_value = data_low and LBP1SX1PD_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LBP1SX1PD_value = &H0
        flag_LBP1SX1PD        = &H0
    End Sub
End Class


'' @REGISTER : AN_X4_HW_LP_PAGES_SGMIIPLUSR_X1_lp_base_page2_sgmiiplusr_x1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LBP2SX1PD                                  [15:0]           get_LBP2SX1PD
''                                                             set_LBP2SX1PD
''                                                             read_LBP2SX1PD
''                                                             write_LBP2SX1PD
''---------------------------------------------------------------------------------
Class REGISTER_AN_X4_HW_LP_PAGES_SGMIIPLUSR_X1_lp_base_page2_sgmiiplusr_x1
    Private write_LBP2SX1PD_value
    Private read_LBP2SX1PD_value
    Private flag_LBP2SX1PD

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

    Property Get get_LBP2SX1PD
        get_LBP2SX1PD = read_LBP2SX1PD_value
    End Property

    Property Let set_LBP2SX1PD(aData)
        write_LBP2SX1PD_value = aData
        flag_LBP2SX1PD        = &H1
    End Property

    Property Get read_LBP2SX1PD
        read
        read_LBP2SX1PD = read_LBP2SX1PD_value
    End Property

    Property Let write_LBP2SX1PD(aData)
        set_LBP2SX1PD = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LBP2SX1PD_mask = &Hffff
        if data_low > LONG_MAX then
            if LBP2SX1PD_mask = mask then
                read_LBP2SX1PD_value = data_low
            else
                read_LBP2SX1PD_value = (data_low - H8000_0000) and LBP2SX1PD_mask
            end If
        else
            read_LBP2SX1PD_value = data_low and LBP2SX1PD_mask
        end If

    End Sub

    Sub write
        If flag_LBP2SX1PD = &H0 Then read
        If flag_LBP2SX1PD = &H0 Then write_LBP2SX1PD_value = get_LBP2SX1PD

        regValue = leftShift((write_LBP2SX1PD_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LBP2SX1PD_mask = &Hffff
        if data_low > LONG_MAX then
            if LBP2SX1PD_mask = mask then
                read_LBP2SX1PD_value = data_low
            else
                read_LBP2SX1PD_value = (data_low - H8000_0000) and LBP2SX1PD_mask
            end If
        else
            read_LBP2SX1PD_value = data_low and LBP2SX1PD_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LBP2SX1PD_value = &H0
        flag_LBP2SX1PD        = &H0
    End Sub
End Class


'' @REGISTER : AN_X4_HW_LP_PAGES_SGMIIPLUSR_X1_lp_base_page3_sgmiiplusr_x1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LBP3SX1PD                                  [15:0]           get_LBP3SX1PD
''                                                             set_LBP3SX1PD
''                                                             read_LBP3SX1PD
''                                                             write_LBP3SX1PD
''---------------------------------------------------------------------------------
Class REGISTER_AN_X4_HW_LP_PAGES_SGMIIPLUSR_X1_lp_base_page3_sgmiiplusr_x1
    Private write_LBP3SX1PD_value
    Private read_LBP3SX1PD_value
    Private flag_LBP3SX1PD

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

    Property Get get_LBP3SX1PD
        get_LBP3SX1PD = read_LBP3SX1PD_value
    End Property

    Property Let set_LBP3SX1PD(aData)
        write_LBP3SX1PD_value = aData
        flag_LBP3SX1PD        = &H1
    End Property

    Property Get read_LBP3SX1PD
        read
        read_LBP3SX1PD = read_LBP3SX1PD_value
    End Property

    Property Let write_LBP3SX1PD(aData)
        set_LBP3SX1PD = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LBP3SX1PD_mask = &Hffff
        if data_low > LONG_MAX then
            if LBP3SX1PD_mask = mask then
                read_LBP3SX1PD_value = data_low
            else
                read_LBP3SX1PD_value = (data_low - H8000_0000) and LBP3SX1PD_mask
            end If
        else
            read_LBP3SX1PD_value = data_low and LBP3SX1PD_mask
        end If

    End Sub

    Sub write
        If flag_LBP3SX1PD = &H0 Then read
        If flag_LBP3SX1PD = &H0 Then write_LBP3SX1PD_value = get_LBP3SX1PD

        regValue = leftShift((write_LBP3SX1PD_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LBP3SX1PD_mask = &Hffff
        if data_low > LONG_MAX then
            if LBP3SX1PD_mask = mask then
                read_LBP3SX1PD_value = data_low
            else
                read_LBP3SX1PD_value = (data_low - H8000_0000) and LBP3SX1PD_mask
            end If
        else
            read_LBP3SX1PD_value = data_low and LBP3SX1PD_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LBP3SX1PD_value = &H0
        flag_LBP3SX1PD        = &H0
    End Sub
End Class


'' @REGISTER : AN_X4_HW_LP_PAGES_SGMIIPLUSR_X1_blockaddress
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
Class REGISTER_AN_X4_HW_LP_PAGES_SGMIIPLUSR_X1_blockaddress
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

Class AN_X4_HW_LP_PAGES_SGMIIPLUSR_X1_INSTANCE

    Public lp_mp5_up1_sgmiiplusr_x1
    Public lp_mp5_up2_sgmiiplusr_x1
    Public lp_mp5_up3_sgmiiplusr_x1
    Public lp_mp5_up4_sgmiiplusr_x1
    Public lp_mp1024_up1_sgmiiplusr_x1
    Public lp_mp1024_up2_sgmiiplusr_x1
    Public lp_mp1024_up3_sgmiiplusr_x1
    Public lp_mp1024_up4_sgmiiplusr_x1
    Public lp_base_page1_sgmiiplusr_x1
    Public lp_base_page2_sgmiiplusr_x1
    Public lp_base_page3_sgmiiplusr_x1
    Public blockaddress


    Public default function Init(aBaseAddr)
        Set lp_mp5_up1_sgmiiplusr_x1 = (New REGISTER_AN_X4_HW_LP_PAGES_SGMIIPLUSR_X1_lp_mp5_up1_sgmiiplusr_x1)(aBaseAddr, 16)
        Set lp_mp5_up2_sgmiiplusr_x1 = (New REGISTER_AN_X4_HW_LP_PAGES_SGMIIPLUSR_X1_lp_mp5_up2_sgmiiplusr_x1)(aBaseAddr, 16)
        Set lp_mp5_up3_sgmiiplusr_x1 = (New REGISTER_AN_X4_HW_LP_PAGES_SGMIIPLUSR_X1_lp_mp5_up3_sgmiiplusr_x1)(aBaseAddr, 16)
        Set lp_mp5_up4_sgmiiplusr_x1 = (New REGISTER_AN_X4_HW_LP_PAGES_SGMIIPLUSR_X1_lp_mp5_up4_sgmiiplusr_x1)(aBaseAddr, 16)
        Set lp_mp1024_up1_sgmiiplusr_x1 = (New REGISTER_AN_X4_HW_LP_PAGES_SGMIIPLUSR_X1_lp_mp1024_up1_sgmiiplusr_x1)(aBaseAddr, 16)
        Set lp_mp1024_up2_sgmiiplusr_x1 = (New REGISTER_AN_X4_HW_LP_PAGES_SGMIIPLUSR_X1_lp_mp1024_up2_sgmiiplusr_x1)(aBaseAddr, 16)
        Set lp_mp1024_up3_sgmiiplusr_x1 = (New REGISTER_AN_X4_HW_LP_PAGES_SGMIIPLUSR_X1_lp_mp1024_up3_sgmiiplusr_x1)(aBaseAddr, 16)
        Set lp_mp1024_up4_sgmiiplusr_x1 = (New REGISTER_AN_X4_HW_LP_PAGES_SGMIIPLUSR_X1_lp_mp1024_up4_sgmiiplusr_x1)(aBaseAddr, 16)
        Set lp_base_page1_sgmiiplusr_x1 = (New REGISTER_AN_X4_HW_LP_PAGES_SGMIIPLUSR_X1_lp_base_page1_sgmiiplusr_x1)(aBaseAddr, 16)
        Set lp_base_page2_sgmiiplusr_x1 = (New REGISTER_AN_X4_HW_LP_PAGES_SGMIIPLUSR_X1_lp_base_page2_sgmiiplusr_x1)(aBaseAddr, 16)
        Set lp_base_page3_sgmiiplusr_x1 = (New REGISTER_AN_X4_HW_LP_PAGES_SGMIIPLUSR_X1_lp_base_page3_sgmiiplusr_x1)(aBaseAddr, 16)
        Set blockaddress = (New REGISTER_AN_X4_HW_LP_PAGES_SGMIIPLUSR_X1_blockaddress)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set AN_X4_HW_LP_PAGES_SGMIIPLUSR_X1 = CreateObject("System.Collections.ArrayList")
AN_X4_HW_LP_PAGES_SGMIIPLUSR_X1.Add ((New AN_X4_HW_LP_PAGES_SGMIIPLUSR_X1_INSTANCE)(&H4aed8920))


