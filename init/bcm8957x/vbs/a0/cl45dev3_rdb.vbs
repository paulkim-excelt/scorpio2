

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


'' @REGISTER : CL45DEV3_pcs_ieee_ctl1
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
'' PCS_LPBK                                   [14:14]          get_PCS_LPBK
''                                                             set_PCS_LPBK
''                                                             read_PCS_LPBK
''                                                             write_PCS_LPBK
''---------------------------------------------------------------------------------
'' SPEED_SEL_1                                [13:13]          get_SPEED_SEL_1
''                                                             set_SPEED_SEL_1
''                                                             read_SPEED_SEL_1
''                                                             write_SPEED_SEL_1
''---------------------------------------------------------------------------------
'' LOW_PWR                                    [11:11]          get_LOW_PWR
''                                                             set_LOW_PWR
''                                                             read_LOW_PWR
''                                                             write_LOW_PWR
''---------------------------------------------------------------------------------
'' SPEED_SEL_0                                [6:6]            get_SPEED_SEL_0
''                                                             set_SPEED_SEL_0
''                                                             read_SPEED_SEL_0
''                                                             write_SPEED_SEL_0
''---------------------------------------------------------------------------------
'' SPEED_SEL_10G                              [5:2]            get_SPEED_SEL_10G
''                                                             set_SPEED_SEL_10G
''                                                             read_SPEED_SEL_10G
''                                                             write_SPEED_SEL_10G
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV3_pcs_ieee_ctl1
    Private write_RESET_value
    Private read_RESET_value
    Private flag_RESET
    Private write_PCS_LPBK_value
    Private read_PCS_LPBK_value
    Private flag_PCS_LPBK
    Private write_SPEED_SEL_1_value
    Private read_SPEED_SEL_1_value
    Private flag_SPEED_SEL_1
    Private write_LOW_PWR_value
    Private read_LOW_PWR_value
    Private flag_LOW_PWR
    Private write_SPEED_SEL_0_value
    Private read_SPEED_SEL_0_value
    Private flag_SPEED_SEL_0
    Private write_SPEED_SEL_10G_value
    Private read_SPEED_SEL_10G_value
    Private flag_SPEED_SEL_10G

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

    Property Get get_PCS_LPBK
        get_PCS_LPBK = read_PCS_LPBK_value
    End Property

    Property Let set_PCS_LPBK(aData)
        write_PCS_LPBK_value = aData
        flag_PCS_LPBK        = &H1
    End Property

    Property Get read_PCS_LPBK
        read
        read_PCS_LPBK = read_PCS_LPBK_value
    End Property

    Property Let write_PCS_LPBK(aData)
        set_PCS_LPBK = aData
        write
    End Property

    Property Get get_SPEED_SEL_1
        get_SPEED_SEL_1 = read_SPEED_SEL_1_value
    End Property

    Property Let set_SPEED_SEL_1(aData)
        write_SPEED_SEL_1_value = aData
        flag_SPEED_SEL_1        = &H1
    End Property

    Property Get read_SPEED_SEL_1
        read
        read_SPEED_SEL_1 = read_SPEED_SEL_1_value
    End Property

    Property Let write_SPEED_SEL_1(aData)
        set_SPEED_SEL_1 = aData
        write
    End Property

    Property Get get_LOW_PWR
        get_LOW_PWR = read_LOW_PWR_value
    End Property

    Property Let set_LOW_PWR(aData)
        write_LOW_PWR_value = aData
        flag_LOW_PWR        = &H1
    End Property

    Property Get read_LOW_PWR
        read
        read_LOW_PWR = read_LOW_PWR_value
    End Property

    Property Let write_LOW_PWR(aData)
        set_LOW_PWR = aData
        write
    End Property

    Property Get get_SPEED_SEL_0
        get_SPEED_SEL_0 = read_SPEED_SEL_0_value
    End Property

    Property Let set_SPEED_SEL_0(aData)
        write_SPEED_SEL_0_value = aData
        flag_SPEED_SEL_0        = &H1
    End Property

    Property Get read_SPEED_SEL_0
        read
        read_SPEED_SEL_0 = read_SPEED_SEL_0_value
    End Property

    Property Let write_SPEED_SEL_0(aData)
        set_SPEED_SEL_0 = aData
        write
    End Property

    Property Get get_SPEED_SEL_10G
        get_SPEED_SEL_10G = read_SPEED_SEL_10G_value
    End Property

    Property Let set_SPEED_SEL_10G(aData)
        write_SPEED_SEL_10G_value = aData
        flag_SPEED_SEL_10G        = &H1
    End Property

    Property Get read_SPEED_SEL_10G
        read
        read_SPEED_SEL_10G = read_SPEED_SEL_10G_value
    End Property

    Property Let write_SPEED_SEL_10G(aData)
        set_SPEED_SEL_10G = aData
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
        read_PCS_LPBK_value = rightShift(data_low, 14) and &H1
        read_SPEED_SEL_1_value = rightShift(data_low, 13) and &H1
        read_LOW_PWR_value = rightShift(data_low, 11) and &H1
        read_SPEED_SEL_0_value = rightShift(data_low, 6) and &H1
        read_SPEED_SEL_10G_value = rightShift(data_low, 2) and &Hf

    End Sub

    Sub write
        If flag_RESET = &H0 or flag_PCS_LPBK = &H0 or flag_SPEED_SEL_1 = &H0 or flag_LOW_PWR = &H0 or flag_SPEED_SEL_0 = &H0 or flag_SPEED_SEL_10G = &H0 Then read
        If flag_RESET = &H0 Then write_RESET_value = get_RESET
        If flag_PCS_LPBK = &H0 Then write_PCS_LPBK_value = get_PCS_LPBK
        If flag_SPEED_SEL_1 = &H0 Then write_SPEED_SEL_1_value = get_SPEED_SEL_1
        If flag_LOW_PWR = &H0 Then write_LOW_PWR_value = get_LOW_PWR
        If flag_SPEED_SEL_0 = &H0 Then write_SPEED_SEL_0_value = get_SPEED_SEL_0
        If flag_SPEED_SEL_10G = &H0 Then write_SPEED_SEL_10G_value = get_SPEED_SEL_10G

        regValue = leftShift((write_RESET_value and &H1), 15) + leftShift((write_PCS_LPBK_value and &H1), 14) + leftShift((write_SPEED_SEL_1_value and &H1), 13) + leftShift((write_LOW_PWR_value and &H1), 11) + leftShift((write_SPEED_SEL_0_value and &H1), 6) + leftShift((write_SPEED_SEL_10G_value and &Hf), 2)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RESET_value = rightShift(data_low, 15) and &H1
        read_PCS_LPBK_value = rightShift(data_low, 14) and &H1
        read_SPEED_SEL_1_value = rightShift(data_low, 13) and &H1
        read_LOW_PWR_value = rightShift(data_low, 11) and &H1
        read_SPEED_SEL_0_value = rightShift(data_low, 6) and &H1
        read_SPEED_SEL_10G_value = rightShift(data_low, 2) and &Hf

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RESET_value = &H0
        flag_RESET        = &H0
        write_PCS_LPBK_value = &H0
        flag_PCS_LPBK        = &H0
        write_SPEED_SEL_1_value = &H0
        flag_SPEED_SEL_1        = &H0
        write_LOW_PWR_value = &H0
        flag_LOW_PWR        = &H0
        write_SPEED_SEL_0_value = &H0
        flag_SPEED_SEL_0        = &H0
        write_SPEED_SEL_10G_value = &H0
        flag_SPEED_SEL_10G        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV3_pcs_ieee_st1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' FAULT                                      [7:7]            get_FAULT
''                                                             set_FAULT
''                                                             read_FAULT
''                                                             write_FAULT
''---------------------------------------------------------------------------------
'' CLOCK_STOP_CAPABLE                         [6:6]            get_CLOCK_STOP_CAPABLE
''                                                             set_CLOCK_STOP_CAPABLE
''                                                             read_CLOCK_STOP_CAPABLE
''                                                             write_CLOCK_STOP_CAPABLE
''---------------------------------------------------------------------------------
'' PCS_RCV_LINK_ST                            [2:2]            get_PCS_RCV_LINK_ST
''                                                             set_PCS_RCV_LINK_ST
''                                                             read_PCS_RCV_LINK_ST
''                                                             write_PCS_RCV_LINK_ST
''---------------------------------------------------------------------------------
'' LOW_PWR_AB                                 [1:1]            get_LOW_PWR_AB
''                                                             set_LOW_PWR_AB
''                                                             read_LOW_PWR_AB
''                                                             write_LOW_PWR_AB
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV3_pcs_ieee_st1
    Private write_FAULT_value
    Private read_FAULT_value
    Private flag_FAULT
    Private write_CLOCK_STOP_CAPABLE_value
    Private read_CLOCK_STOP_CAPABLE_value
    Private flag_CLOCK_STOP_CAPABLE
    Private write_PCS_RCV_LINK_ST_value
    Private read_PCS_RCV_LINK_ST_value
    Private flag_PCS_RCV_LINK_ST
    Private write_LOW_PWR_AB_value
    Private read_LOW_PWR_AB_value
    Private flag_LOW_PWR_AB

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

    Property Get get_FAULT
        get_FAULT = read_FAULT_value
    End Property

    Property Let set_FAULT(aData)
        write_FAULT_value = aData
        flag_FAULT        = &H1
    End Property

    Property Get read_FAULT
        read
        read_FAULT = read_FAULT_value
    End Property

    Property Let write_FAULT(aData)
        set_FAULT = aData
        write
    End Property

    Property Get get_CLOCK_STOP_CAPABLE
        get_CLOCK_STOP_CAPABLE = read_CLOCK_STOP_CAPABLE_value
    End Property

    Property Let set_CLOCK_STOP_CAPABLE(aData)
        write_CLOCK_STOP_CAPABLE_value = aData
        flag_CLOCK_STOP_CAPABLE        = &H1
    End Property

    Property Get read_CLOCK_STOP_CAPABLE
        read
        read_CLOCK_STOP_CAPABLE = read_CLOCK_STOP_CAPABLE_value
    End Property

    Property Let write_CLOCK_STOP_CAPABLE(aData)
        set_CLOCK_STOP_CAPABLE = aData
        write
    End Property

    Property Get get_PCS_RCV_LINK_ST
        get_PCS_RCV_LINK_ST = read_PCS_RCV_LINK_ST_value
    End Property

    Property Let set_PCS_RCV_LINK_ST(aData)
        write_PCS_RCV_LINK_ST_value = aData
        flag_PCS_RCV_LINK_ST        = &H1
    End Property

    Property Get read_PCS_RCV_LINK_ST
        read
        read_PCS_RCV_LINK_ST = read_PCS_RCV_LINK_ST_value
    End Property

    Property Let write_PCS_RCV_LINK_ST(aData)
        set_PCS_RCV_LINK_ST = aData
        write
    End Property

    Property Get get_LOW_PWR_AB
        get_LOW_PWR_AB = read_LOW_PWR_AB_value
    End Property

    Property Let set_LOW_PWR_AB(aData)
        write_LOW_PWR_AB_value = aData
        flag_LOW_PWR_AB        = &H1
    End Property

    Property Get read_LOW_PWR_AB
        read
        read_LOW_PWR_AB = read_LOW_PWR_AB_value
    End Property

    Property Let write_LOW_PWR_AB(aData)
        set_LOW_PWR_AB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_FAULT_value = rightShift(data_low, 7) and &H1
        read_CLOCK_STOP_CAPABLE_value = rightShift(data_low, 6) and &H1
        read_PCS_RCV_LINK_ST_value = rightShift(data_low, 2) and &H1
        read_LOW_PWR_AB_value = rightShift(data_low, 1) and &H1

    End Sub

    Sub write
        If flag_FAULT = &H0 or flag_CLOCK_STOP_CAPABLE = &H0 or flag_PCS_RCV_LINK_ST = &H0 or flag_LOW_PWR_AB = &H0 Then read
        If flag_FAULT = &H0 Then write_FAULT_value = get_FAULT
        If flag_CLOCK_STOP_CAPABLE = &H0 Then write_CLOCK_STOP_CAPABLE_value = get_CLOCK_STOP_CAPABLE
        If flag_PCS_RCV_LINK_ST = &H0 Then write_PCS_RCV_LINK_ST_value = get_PCS_RCV_LINK_ST
        If flag_LOW_PWR_AB = &H0 Then write_LOW_PWR_AB_value = get_LOW_PWR_AB

        regValue = leftShift((write_FAULT_value and &H1), 7) + leftShift((write_CLOCK_STOP_CAPABLE_value and &H1), 6) + leftShift((write_PCS_RCV_LINK_ST_value and &H1), 2) + leftShift((write_LOW_PWR_AB_value and &H1), 1)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_FAULT_value = rightShift(data_low, 7) and &H1
        read_CLOCK_STOP_CAPABLE_value = rightShift(data_low, 6) and &H1
        read_PCS_RCV_LINK_ST_value = rightShift(data_low, 2) and &H1
        read_LOW_PWR_AB_value = rightShift(data_low, 1) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_FAULT_value = &H0
        flag_FAULT        = &H0
        write_CLOCK_STOP_CAPABLE_value = &H0
        flag_CLOCK_STOP_CAPABLE        = &H0
        write_PCS_RCV_LINK_ST_value = &H0
        flag_PCS_RCV_LINK_ST        = &H0
        write_LOW_PWR_AB_value = &H0
        flag_LOW_PWR_AB        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV3_pcs_ieee_dev_id0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DEV_ID0                                    [15:0]           get_DEV_ID0
''                                                             set_DEV_ID0
''                                                             read_DEV_ID0
''                                                             write_DEV_ID0
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV3_pcs_ieee_dev_id0
    Private write_DEV_ID0_value
    Private read_DEV_ID0_value
    Private flag_DEV_ID0

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

    Property Get get_DEV_ID0
        get_DEV_ID0 = read_DEV_ID0_value
    End Property

    Property Let set_DEV_ID0(aData)
        write_DEV_ID0_value = aData
        flag_DEV_ID0        = &H1
    End Property

    Property Get read_DEV_ID0
        read
        read_DEV_ID0 = read_DEV_ID0_value
    End Property

    Property Let write_DEV_ID0(aData)
        set_DEV_ID0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DEV_ID0_mask = &Hffff
        if data_low > LONG_MAX then
            if DEV_ID0_mask = mask then
                read_DEV_ID0_value = data_low
            else
                read_DEV_ID0_value = (data_low - H8000_0000) and DEV_ID0_mask
            end If
        else
            read_DEV_ID0_value = data_low and DEV_ID0_mask
        end If

    End Sub

    Sub write
        If flag_DEV_ID0 = &H0 Then read
        If flag_DEV_ID0 = &H0 Then write_DEV_ID0_value = get_DEV_ID0

        regValue = leftShift((write_DEV_ID0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DEV_ID0_mask = &Hffff
        if data_low > LONG_MAX then
            if DEV_ID0_mask = mask then
                read_DEV_ID0_value = data_low
            else
                read_DEV_ID0_value = (data_low - H8000_0000) and DEV_ID0_mask
            end If
        else
            read_DEV_ID0_value = data_low and DEV_ID0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DEV_ID0_value = &H0
        flag_DEV_ID0        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV3_pcs_ieee_dev_id1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DEV_ID1                                    [15:0]           get_DEV_ID1
''                                                             set_DEV_ID1
''                                                             read_DEV_ID1
''                                                             write_DEV_ID1
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV3_pcs_ieee_dev_id1
    Private write_DEV_ID1_value
    Private read_DEV_ID1_value
    Private flag_DEV_ID1

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

    Property Get get_DEV_ID1
        get_DEV_ID1 = read_DEV_ID1_value
    End Property

    Property Let set_DEV_ID1(aData)
        write_DEV_ID1_value = aData
        flag_DEV_ID1        = &H1
    End Property

    Property Get read_DEV_ID1
        read
        read_DEV_ID1 = read_DEV_ID1_value
    End Property

    Property Let write_DEV_ID1(aData)
        set_DEV_ID1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DEV_ID1_mask = &Hffff
        if data_low > LONG_MAX then
            if DEV_ID1_mask = mask then
                read_DEV_ID1_value = data_low
            else
                read_DEV_ID1_value = (data_low - H8000_0000) and DEV_ID1_mask
            end If
        else
            read_DEV_ID1_value = data_low and DEV_ID1_mask
        end If

    End Sub

    Sub write
        If flag_DEV_ID1 = &H0 Then read
        If flag_DEV_ID1 = &H0 Then write_DEV_ID1_value = get_DEV_ID1

        regValue = leftShift((write_DEV_ID1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DEV_ID1_mask = &Hffff
        if data_low > LONG_MAX then
            if DEV_ID1_mask = mask then
                read_DEV_ID1_value = data_low
            else
                read_DEV_ID1_value = (data_low - H8000_0000) and DEV_ID1_mask
            end If
        else
            read_DEV_ID1_value = data_low and DEV_ID1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DEV_ID1_value = &H0
        flag_DEV_ID1        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV3_pcs_ieee_dev0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' AUTONEG_PRE                                [7:7]            get_AUTONEG_PRE
''                                                             set_AUTONEG_PRE
''                                                             read_AUTONEG_PRE
''                                                             write_AUTONEG_PRE
''---------------------------------------------------------------------------------
'' TC_PRE                                     [6:6]            get_TC_PRE
''                                                             set_TC_PRE
''                                                             read_TC_PRE
''                                                             write_TC_PRE
''---------------------------------------------------------------------------------
'' DTEXS_PRE                                  [5:5]            get_DTEXS_PRE
''                                                             set_DTEXS_PRE
''                                                             read_DTEXS_PRE
''                                                             write_DTEXS_PRE
''---------------------------------------------------------------------------------
'' PHYXS_PRE                                  [4:4]            get_PHYXS_PRE
''                                                             set_PHYXS_PRE
''                                                             read_PHYXS_PRE
''                                                             write_PHYXS_PRE
''---------------------------------------------------------------------------------
'' PCS_PRE                                    [3:3]            get_PCS_PRE
''                                                             set_PCS_PRE
''                                                             read_PCS_PRE
''                                                             write_PCS_PRE
''---------------------------------------------------------------------------------
'' WIS_PRE                                    [2:2]            get_WIS_PRE
''                                                             set_WIS_PRE
''                                                             read_WIS_PRE
''                                                             write_WIS_PRE
''---------------------------------------------------------------------------------
'' PMD_PRE                                    [1:1]            get_PMD_PRE
''                                                             set_PMD_PRE
''                                                             read_PMD_PRE
''                                                             write_PMD_PRE
''---------------------------------------------------------------------------------
'' CLA22_PRE                                  [0:0]            get_CLA22_PRE
''                                                             set_CLA22_PRE
''                                                             read_CLA22_PRE
''                                                             write_CLA22_PRE
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV3_pcs_ieee_dev0
    Private write_AUTONEG_PRE_value
    Private read_AUTONEG_PRE_value
    Private flag_AUTONEG_PRE
    Private write_TC_PRE_value
    Private read_TC_PRE_value
    Private flag_TC_PRE
    Private write_DTEXS_PRE_value
    Private read_DTEXS_PRE_value
    Private flag_DTEXS_PRE
    Private write_PHYXS_PRE_value
    Private read_PHYXS_PRE_value
    Private flag_PHYXS_PRE
    Private write_PCS_PRE_value
    Private read_PCS_PRE_value
    Private flag_PCS_PRE
    Private write_WIS_PRE_value
    Private read_WIS_PRE_value
    Private flag_WIS_PRE
    Private write_PMD_PRE_value
    Private read_PMD_PRE_value
    Private flag_PMD_PRE
    Private write_CLA22_PRE_value
    Private read_CLA22_PRE_value
    Private flag_CLA22_PRE

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

    Property Get get_AUTONEG_PRE
        get_AUTONEG_PRE = read_AUTONEG_PRE_value
    End Property

    Property Let set_AUTONEG_PRE(aData)
        write_AUTONEG_PRE_value = aData
        flag_AUTONEG_PRE        = &H1
    End Property

    Property Get read_AUTONEG_PRE
        read
        read_AUTONEG_PRE = read_AUTONEG_PRE_value
    End Property

    Property Let write_AUTONEG_PRE(aData)
        set_AUTONEG_PRE = aData
        write
    End Property

    Property Get get_TC_PRE
        get_TC_PRE = read_TC_PRE_value
    End Property

    Property Let set_TC_PRE(aData)
        write_TC_PRE_value = aData
        flag_TC_PRE        = &H1
    End Property

    Property Get read_TC_PRE
        read
        read_TC_PRE = read_TC_PRE_value
    End Property

    Property Let write_TC_PRE(aData)
        set_TC_PRE = aData
        write
    End Property

    Property Get get_DTEXS_PRE
        get_DTEXS_PRE = read_DTEXS_PRE_value
    End Property

    Property Let set_DTEXS_PRE(aData)
        write_DTEXS_PRE_value = aData
        flag_DTEXS_PRE        = &H1
    End Property

    Property Get read_DTEXS_PRE
        read
        read_DTEXS_PRE = read_DTEXS_PRE_value
    End Property

    Property Let write_DTEXS_PRE(aData)
        set_DTEXS_PRE = aData
        write
    End Property

    Property Get get_PHYXS_PRE
        get_PHYXS_PRE = read_PHYXS_PRE_value
    End Property

    Property Let set_PHYXS_PRE(aData)
        write_PHYXS_PRE_value = aData
        flag_PHYXS_PRE        = &H1
    End Property

    Property Get read_PHYXS_PRE
        read
        read_PHYXS_PRE = read_PHYXS_PRE_value
    End Property

    Property Let write_PHYXS_PRE(aData)
        set_PHYXS_PRE = aData
        write
    End Property

    Property Get get_PCS_PRE
        get_PCS_PRE = read_PCS_PRE_value
    End Property

    Property Let set_PCS_PRE(aData)
        write_PCS_PRE_value = aData
        flag_PCS_PRE        = &H1
    End Property

    Property Get read_PCS_PRE
        read
        read_PCS_PRE = read_PCS_PRE_value
    End Property

    Property Let write_PCS_PRE(aData)
        set_PCS_PRE = aData
        write
    End Property

    Property Get get_WIS_PRE
        get_WIS_PRE = read_WIS_PRE_value
    End Property

    Property Let set_WIS_PRE(aData)
        write_WIS_PRE_value = aData
        flag_WIS_PRE        = &H1
    End Property

    Property Get read_WIS_PRE
        read
        read_WIS_PRE = read_WIS_PRE_value
    End Property

    Property Let write_WIS_PRE(aData)
        set_WIS_PRE = aData
        write
    End Property

    Property Get get_PMD_PRE
        get_PMD_PRE = read_PMD_PRE_value
    End Property

    Property Let set_PMD_PRE(aData)
        write_PMD_PRE_value = aData
        flag_PMD_PRE        = &H1
    End Property

    Property Get read_PMD_PRE
        read
        read_PMD_PRE = read_PMD_PRE_value
    End Property

    Property Let write_PMD_PRE(aData)
        set_PMD_PRE = aData
        write
    End Property

    Property Get get_CLA22_PRE
        get_CLA22_PRE = read_CLA22_PRE_value
    End Property

    Property Let set_CLA22_PRE(aData)
        write_CLA22_PRE_value = aData
        flag_CLA22_PRE        = &H1
    End Property

    Property Get read_CLA22_PRE
        read
        read_CLA22_PRE = read_CLA22_PRE_value
    End Property

    Property Let write_CLA22_PRE(aData)
        set_CLA22_PRE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_AUTONEG_PRE_value = rightShift(data_low, 7) and &H1
        read_TC_PRE_value = rightShift(data_low, 6) and &H1
        read_DTEXS_PRE_value = rightShift(data_low, 5) and &H1
        read_PHYXS_PRE_value = rightShift(data_low, 4) and &H1
        read_PCS_PRE_value = rightShift(data_low, 3) and &H1
        read_WIS_PRE_value = rightShift(data_low, 2) and &H1
        read_PMD_PRE_value = rightShift(data_low, 1) and &H1
        CLA22_PRE_mask = &H1
        if data_low > LONG_MAX then
            if CLA22_PRE_mask = mask then
                read_CLA22_PRE_value = data_low
            else
                read_CLA22_PRE_value = (data_low - H8000_0000) and CLA22_PRE_mask
            end If
        else
            read_CLA22_PRE_value = data_low and CLA22_PRE_mask
        end If

    End Sub

    Sub write
        If flag_AUTONEG_PRE = &H0 or flag_TC_PRE = &H0 or flag_DTEXS_PRE = &H0 or flag_PHYXS_PRE = &H0 or flag_PCS_PRE = &H0 or flag_WIS_PRE = &H0 or flag_PMD_PRE = &H0 or flag_CLA22_PRE = &H0 Then read
        If flag_AUTONEG_PRE = &H0 Then write_AUTONEG_PRE_value = get_AUTONEG_PRE
        If flag_TC_PRE = &H0 Then write_TC_PRE_value = get_TC_PRE
        If flag_DTEXS_PRE = &H0 Then write_DTEXS_PRE_value = get_DTEXS_PRE
        If flag_PHYXS_PRE = &H0 Then write_PHYXS_PRE_value = get_PHYXS_PRE
        If flag_PCS_PRE = &H0 Then write_PCS_PRE_value = get_PCS_PRE
        If flag_WIS_PRE = &H0 Then write_WIS_PRE_value = get_WIS_PRE
        If flag_PMD_PRE = &H0 Then write_PMD_PRE_value = get_PMD_PRE
        If flag_CLA22_PRE = &H0 Then write_CLA22_PRE_value = get_CLA22_PRE

        regValue = leftShift((write_AUTONEG_PRE_value and &H1), 7) + leftShift((write_TC_PRE_value and &H1), 6) + leftShift((write_DTEXS_PRE_value and &H1), 5) + leftShift((write_PHYXS_PRE_value and &H1), 4) + leftShift((write_PCS_PRE_value and &H1), 3) + leftShift((write_WIS_PRE_value and &H1), 2) + leftShift((write_PMD_PRE_value and &H1), 1) + leftShift((write_CLA22_PRE_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_AUTONEG_PRE_value = rightShift(data_low, 7) and &H1
        read_TC_PRE_value = rightShift(data_low, 6) and &H1
        read_DTEXS_PRE_value = rightShift(data_low, 5) and &H1
        read_PHYXS_PRE_value = rightShift(data_low, 4) and &H1
        read_PCS_PRE_value = rightShift(data_low, 3) and &H1
        read_WIS_PRE_value = rightShift(data_low, 2) and &H1
        read_PMD_PRE_value = rightShift(data_low, 1) and &H1
        CLA22_PRE_mask = &H1
        if data_low > LONG_MAX then
            if CLA22_PRE_mask = mask then
                read_CLA22_PRE_value = data_low
            else
                read_CLA22_PRE_value = (data_low - H8000_0000) and CLA22_PRE_mask
            end If
        else
            read_CLA22_PRE_value = data_low and CLA22_PRE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_AUTONEG_PRE_value = &H0
        flag_AUTONEG_PRE        = &H0
        write_TC_PRE_value = &H0
        flag_TC_PRE        = &H0
        write_DTEXS_PRE_value = &H0
        flag_DTEXS_PRE        = &H0
        write_PHYXS_PRE_value = &H0
        flag_PHYXS_PRE        = &H0
        write_PCS_PRE_value = &H0
        flag_PCS_PRE        = &H0
        write_WIS_PRE_value = &H0
        flag_WIS_PRE        = &H0
        write_PMD_PRE_value = &H0
        flag_PMD_PRE        = &H0
        write_CLA22_PRE_value = &H0
        flag_CLA22_PRE        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV3_pcs_ieee_dev1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' VENSP_DEV2_PRE                             [15:15]          get_VENSP_DEV2_PRE
''                                                             set_VENSP_DEV2_PRE
''                                                             read_VENSP_DEV2_PRE
''                                                             write_VENSP_DEV2_PRE
''---------------------------------------------------------------------------------
'' VENSP_DEV1_PRE                             [14:14]          get_VENSP_DEV1_PRE
''                                                             set_VENSP_DEV1_PRE
''                                                             read_VENSP_DEV1_PRE
''                                                             write_VENSP_DEV1_PRE
''---------------------------------------------------------------------------------
'' CLA22_EXT_PRE                              [13:13]          get_CLA22_EXT_PRE
''                                                             set_CLA22_EXT_PRE
''                                                             read_CLA22_EXT_PRE
''                                                             write_CLA22_EXT_PRE
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV3_pcs_ieee_dev1
    Private write_VENSP_DEV2_PRE_value
    Private read_VENSP_DEV2_PRE_value
    Private flag_VENSP_DEV2_PRE
    Private write_VENSP_DEV1_PRE_value
    Private read_VENSP_DEV1_PRE_value
    Private flag_VENSP_DEV1_PRE
    Private write_CLA22_EXT_PRE_value
    Private read_CLA22_EXT_PRE_value
    Private flag_CLA22_EXT_PRE

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

    Property Get get_VENSP_DEV2_PRE
        get_VENSP_DEV2_PRE = read_VENSP_DEV2_PRE_value
    End Property

    Property Let set_VENSP_DEV2_PRE(aData)
        write_VENSP_DEV2_PRE_value = aData
        flag_VENSP_DEV2_PRE        = &H1
    End Property

    Property Get read_VENSP_DEV2_PRE
        read
        read_VENSP_DEV2_PRE = read_VENSP_DEV2_PRE_value
    End Property

    Property Let write_VENSP_DEV2_PRE(aData)
        set_VENSP_DEV2_PRE = aData
        write
    End Property

    Property Get get_VENSP_DEV1_PRE
        get_VENSP_DEV1_PRE = read_VENSP_DEV1_PRE_value
    End Property

    Property Let set_VENSP_DEV1_PRE(aData)
        write_VENSP_DEV1_PRE_value = aData
        flag_VENSP_DEV1_PRE        = &H1
    End Property

    Property Get read_VENSP_DEV1_PRE
        read
        read_VENSP_DEV1_PRE = read_VENSP_DEV1_PRE_value
    End Property

    Property Let write_VENSP_DEV1_PRE(aData)
        set_VENSP_DEV1_PRE = aData
        write
    End Property

    Property Get get_CLA22_EXT_PRE
        get_CLA22_EXT_PRE = read_CLA22_EXT_PRE_value
    End Property

    Property Let set_CLA22_EXT_PRE(aData)
        write_CLA22_EXT_PRE_value = aData
        flag_CLA22_EXT_PRE        = &H1
    End Property

    Property Get read_CLA22_EXT_PRE
        read
        read_CLA22_EXT_PRE = read_CLA22_EXT_PRE_value
    End Property

    Property Let write_CLA22_EXT_PRE(aData)
        set_CLA22_EXT_PRE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_VENSP_DEV2_PRE_value = rightShift(data_low, 15) and &H1
        read_VENSP_DEV1_PRE_value = rightShift(data_low, 14) and &H1
        read_CLA22_EXT_PRE_value = rightShift(data_low, 13) and &H1

    End Sub

    Sub write
        If flag_VENSP_DEV2_PRE = &H0 or flag_VENSP_DEV1_PRE = &H0 or flag_CLA22_EXT_PRE = &H0 Then read
        If flag_VENSP_DEV2_PRE = &H0 Then write_VENSP_DEV2_PRE_value = get_VENSP_DEV2_PRE
        If flag_VENSP_DEV1_PRE = &H0 Then write_VENSP_DEV1_PRE_value = get_VENSP_DEV1_PRE
        If flag_CLA22_EXT_PRE = &H0 Then write_CLA22_EXT_PRE_value = get_CLA22_EXT_PRE

        regValue = leftShift((write_VENSP_DEV2_PRE_value and &H1), 15) + leftShift((write_VENSP_DEV1_PRE_value and &H1), 14) + leftShift((write_CLA22_EXT_PRE_value and &H1), 13)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_VENSP_DEV2_PRE_value = rightShift(data_low, 15) and &H1
        read_VENSP_DEV1_PRE_value = rightShift(data_low, 14) and &H1
        read_CLA22_EXT_PRE_value = rightShift(data_low, 13) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_VENSP_DEV2_PRE_value = &H0
        flag_VENSP_DEV2_PRE        = &H0
        write_VENSP_DEV1_PRE_value = &H0
        flag_VENSP_DEV1_PRE        = &H0
        write_CLA22_EXT_PRE_value = &H0
        flag_CLA22_EXT_PRE        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV3_pcs_ieee_pkg_id0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PKG_ID_0                                   [15:0]           get_PKG_ID_0
''                                                             set_PKG_ID_0
''                                                             read_PKG_ID_0
''                                                             write_PKG_ID_0
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV3_pcs_ieee_pkg_id0
    Private write_PKG_ID_0_value
    Private read_PKG_ID_0_value
    Private flag_PKG_ID_0

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

    Property Get get_PKG_ID_0
        get_PKG_ID_0 = read_PKG_ID_0_value
    End Property

    Property Let set_PKG_ID_0(aData)
        write_PKG_ID_0_value = aData
        flag_PKG_ID_0        = &H1
    End Property

    Property Get read_PKG_ID_0
        read
        read_PKG_ID_0 = read_PKG_ID_0_value
    End Property

    Property Let write_PKG_ID_0(aData)
        set_PKG_ID_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PKG_ID_0_mask = &Hffff
        if data_low > LONG_MAX then
            if PKG_ID_0_mask = mask then
                read_PKG_ID_0_value = data_low
            else
                read_PKG_ID_0_value = (data_low - H8000_0000) and PKG_ID_0_mask
            end If
        else
            read_PKG_ID_0_value = data_low and PKG_ID_0_mask
        end If

    End Sub

    Sub write
        If flag_PKG_ID_0 = &H0 Then read
        If flag_PKG_ID_0 = &H0 Then write_PKG_ID_0_value = get_PKG_ID_0

        regValue = leftShift((write_PKG_ID_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PKG_ID_0_mask = &Hffff
        if data_low > LONG_MAX then
            if PKG_ID_0_mask = mask then
                read_PKG_ID_0_value = data_low
            else
                read_PKG_ID_0_value = (data_low - H8000_0000) and PKG_ID_0_mask
            end If
        else
            read_PKG_ID_0_value = data_low and PKG_ID_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PKG_ID_0_value = &H0
        flag_PKG_ID_0        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV3_pcs_ieee_pkg_id1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PKG_ID_1                                   [15:0]           get_PKG_ID_1
''                                                             set_PKG_ID_1
''                                                             read_PKG_ID_1
''                                                             write_PKG_ID_1
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV3_pcs_ieee_pkg_id1
    Private write_PKG_ID_1_value
    Private read_PKG_ID_1_value
    Private flag_PKG_ID_1

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

    Property Get get_PKG_ID_1
        get_PKG_ID_1 = read_PKG_ID_1_value
    End Property

    Property Let set_PKG_ID_1(aData)
        write_PKG_ID_1_value = aData
        flag_PKG_ID_1        = &H1
    End Property

    Property Get read_PKG_ID_1
        read
        read_PKG_ID_1 = read_PKG_ID_1_value
    End Property

    Property Let write_PKG_ID_1(aData)
        set_PKG_ID_1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PKG_ID_1_mask = &Hffff
        if data_low > LONG_MAX then
            if PKG_ID_1_mask = mask then
                read_PKG_ID_1_value = data_low
            else
                read_PKG_ID_1_value = (data_low - H8000_0000) and PKG_ID_1_mask
            end If
        else
            read_PKG_ID_1_value = data_low and PKG_ID_1_mask
        end If

    End Sub

    Sub write
        If flag_PKG_ID_1 = &H0 Then read
        If flag_PKG_ID_1 = &H0 Then write_PKG_ID_1_value = get_PKG_ID_1

        regValue = leftShift((write_PKG_ID_1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PKG_ID_1_mask = &Hffff
        if data_low > LONG_MAX then
            if PKG_ID_1_mask = mask then
                read_PKG_ID_1_value = data_low
            else
                read_PKG_ID_1_value = (data_low - H8000_0000) and PKG_ID_1_mask
            end If
        else
            read_PKG_ID_1_value = data_low and PKG_ID_1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PKG_ID_1_value = &H0
        flag_PKG_ID_1        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV3_pcs_eee_cap
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PHY_10GBASEKR_EEE                          [6:6]            get_PHY_10GBASEKR_EEE
''                                                             set_PHY_10GBASEKR_EEE
''                                                             read_PHY_10GBASEKR_EEE
''                                                             write_PHY_10GBASEKR_EEE
''---------------------------------------------------------------------------------
'' PHY_10GBASEKX4_EEE                         [5:5]            get_PHY_10GBASEKX4_EEE
''                                                             set_PHY_10GBASEKX4_EEE
''                                                             read_PHY_10GBASEKX4_EEE
''                                                             write_PHY_10GBASEKX4_EEE
''---------------------------------------------------------------------------------
'' PHY_1000BASEKX_EEE                         [4:4]            get_PHY_1000BASEKX_EEE
''                                                             set_PHY_1000BASEKX_EEE
''                                                             read_PHY_1000BASEKX_EEE
''                                                             write_PHY_1000BASEKX_EEE
''---------------------------------------------------------------------------------
'' PHY_10GBASET_EEE                           [3:3]            get_PHY_10GBASET_EEE
''                                                             set_PHY_10GBASET_EEE
''                                                             read_PHY_10GBASET_EEE
''                                                             write_PHY_10GBASET_EEE
''---------------------------------------------------------------------------------
'' PHY_1000BASET_EEE                          [2:2]            get_PHY_1000BASET_EEE
''                                                             set_PHY_1000BASET_EEE
''                                                             read_PHY_1000BASET_EEE
''                                                             write_PHY_1000BASET_EEE
''---------------------------------------------------------------------------------
'' PHY_100BASETX_EE                           [1:1]            get_PHY_100BASETX_EE
''                                                             set_PHY_100BASETX_EE
''                                                             read_PHY_100BASETX_EE
''                                                             write_PHY_100BASETX_EE
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV3_pcs_eee_cap
    Private write_PHY_10GBASEKR_EEE_value
    Private read_PHY_10GBASEKR_EEE_value
    Private flag_PHY_10GBASEKR_EEE
    Private write_PHY_10GBASEKX4_EEE_value
    Private read_PHY_10GBASEKX4_EEE_value
    Private flag_PHY_10GBASEKX4_EEE
    Private write_PHY_1000BASEKX_EEE_value
    Private read_PHY_1000BASEKX_EEE_value
    Private flag_PHY_1000BASEKX_EEE
    Private write_PHY_10GBASET_EEE_value
    Private read_PHY_10GBASET_EEE_value
    Private flag_PHY_10GBASET_EEE
    Private write_PHY_1000BASET_EEE_value
    Private read_PHY_1000BASET_EEE_value
    Private flag_PHY_1000BASET_EEE
    Private write_PHY_100BASETX_EE_value
    Private read_PHY_100BASETX_EE_value
    Private flag_PHY_100BASETX_EE

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

    Property Get get_PHY_10GBASEKR_EEE
        get_PHY_10GBASEKR_EEE = read_PHY_10GBASEKR_EEE_value
    End Property

    Property Let set_PHY_10GBASEKR_EEE(aData)
        write_PHY_10GBASEKR_EEE_value = aData
        flag_PHY_10GBASEKR_EEE        = &H1
    End Property

    Property Get read_PHY_10GBASEKR_EEE
        read
        read_PHY_10GBASEKR_EEE = read_PHY_10GBASEKR_EEE_value
    End Property

    Property Let write_PHY_10GBASEKR_EEE(aData)
        set_PHY_10GBASEKR_EEE = aData
        write
    End Property

    Property Get get_PHY_10GBASEKX4_EEE
        get_PHY_10GBASEKX4_EEE = read_PHY_10GBASEKX4_EEE_value
    End Property

    Property Let set_PHY_10GBASEKX4_EEE(aData)
        write_PHY_10GBASEKX4_EEE_value = aData
        flag_PHY_10GBASEKX4_EEE        = &H1
    End Property

    Property Get read_PHY_10GBASEKX4_EEE
        read
        read_PHY_10GBASEKX4_EEE = read_PHY_10GBASEKX4_EEE_value
    End Property

    Property Let write_PHY_10GBASEKX4_EEE(aData)
        set_PHY_10GBASEKX4_EEE = aData
        write
    End Property

    Property Get get_PHY_1000BASEKX_EEE
        get_PHY_1000BASEKX_EEE = read_PHY_1000BASEKX_EEE_value
    End Property

    Property Let set_PHY_1000BASEKX_EEE(aData)
        write_PHY_1000BASEKX_EEE_value = aData
        flag_PHY_1000BASEKX_EEE        = &H1
    End Property

    Property Get read_PHY_1000BASEKX_EEE
        read
        read_PHY_1000BASEKX_EEE = read_PHY_1000BASEKX_EEE_value
    End Property

    Property Let write_PHY_1000BASEKX_EEE(aData)
        set_PHY_1000BASEKX_EEE = aData
        write
    End Property

    Property Get get_PHY_10GBASET_EEE
        get_PHY_10GBASET_EEE = read_PHY_10GBASET_EEE_value
    End Property

    Property Let set_PHY_10GBASET_EEE(aData)
        write_PHY_10GBASET_EEE_value = aData
        flag_PHY_10GBASET_EEE        = &H1
    End Property

    Property Get read_PHY_10GBASET_EEE
        read
        read_PHY_10GBASET_EEE = read_PHY_10GBASET_EEE_value
    End Property

    Property Let write_PHY_10GBASET_EEE(aData)
        set_PHY_10GBASET_EEE = aData
        write
    End Property

    Property Get get_PHY_1000BASET_EEE
        get_PHY_1000BASET_EEE = read_PHY_1000BASET_EEE_value
    End Property

    Property Let set_PHY_1000BASET_EEE(aData)
        write_PHY_1000BASET_EEE_value = aData
        flag_PHY_1000BASET_EEE        = &H1
    End Property

    Property Get read_PHY_1000BASET_EEE
        read
        read_PHY_1000BASET_EEE = read_PHY_1000BASET_EEE_value
    End Property

    Property Let write_PHY_1000BASET_EEE(aData)
        set_PHY_1000BASET_EEE = aData
        write
    End Property

    Property Get get_PHY_100BASETX_EE
        get_PHY_100BASETX_EE = read_PHY_100BASETX_EE_value
    End Property

    Property Let set_PHY_100BASETX_EE(aData)
        write_PHY_100BASETX_EE_value = aData
        flag_PHY_100BASETX_EE        = &H1
    End Property

    Property Get read_PHY_100BASETX_EE
        read
        read_PHY_100BASETX_EE = read_PHY_100BASETX_EE_value
    End Property

    Property Let write_PHY_100BASETX_EE(aData)
        set_PHY_100BASETX_EE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PHY_10GBASEKR_EEE_value = rightShift(data_low, 6) and &H1
        read_PHY_10GBASEKX4_EEE_value = rightShift(data_low, 5) and &H1
        read_PHY_1000BASEKX_EEE_value = rightShift(data_low, 4) and &H1
        read_PHY_10GBASET_EEE_value = rightShift(data_low, 3) and &H1
        read_PHY_1000BASET_EEE_value = rightShift(data_low, 2) and &H1
        read_PHY_100BASETX_EE_value = rightShift(data_low, 1) and &H1

    End Sub

    Sub write
        If flag_PHY_10GBASEKR_EEE = &H0 or flag_PHY_10GBASEKX4_EEE = &H0 or flag_PHY_1000BASEKX_EEE = &H0 or flag_PHY_10GBASET_EEE = &H0 or flag_PHY_1000BASET_EEE = &H0 or flag_PHY_100BASETX_EE = &H0 Then read
        If flag_PHY_10GBASEKR_EEE = &H0 Then write_PHY_10GBASEKR_EEE_value = get_PHY_10GBASEKR_EEE
        If flag_PHY_10GBASEKX4_EEE = &H0 Then write_PHY_10GBASEKX4_EEE_value = get_PHY_10GBASEKX4_EEE
        If flag_PHY_1000BASEKX_EEE = &H0 Then write_PHY_1000BASEKX_EEE_value = get_PHY_1000BASEKX_EEE
        If flag_PHY_10GBASET_EEE = &H0 Then write_PHY_10GBASET_EEE_value = get_PHY_10GBASET_EEE
        If flag_PHY_1000BASET_EEE = &H0 Then write_PHY_1000BASET_EEE_value = get_PHY_1000BASET_EEE
        If flag_PHY_100BASETX_EE = &H0 Then write_PHY_100BASETX_EE_value = get_PHY_100BASETX_EE

        regValue = leftShift((write_PHY_10GBASEKR_EEE_value and &H1), 6) + leftShift((write_PHY_10GBASEKX4_EEE_value and &H1), 5) + leftShift((write_PHY_1000BASEKX_EEE_value and &H1), 4) + leftShift((write_PHY_10GBASET_EEE_value and &H1), 3) + leftShift((write_PHY_1000BASET_EEE_value and &H1), 2) + leftShift((write_PHY_100BASETX_EE_value and &H1), 1)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PHY_10GBASEKR_EEE_value = rightShift(data_low, 6) and &H1
        read_PHY_10GBASEKX4_EEE_value = rightShift(data_low, 5) and &H1
        read_PHY_1000BASEKX_EEE_value = rightShift(data_low, 4) and &H1
        read_PHY_10GBASET_EEE_value = rightShift(data_low, 3) and &H1
        read_PHY_1000BASET_EEE_value = rightShift(data_low, 2) and &H1
        read_PHY_100BASETX_EE_value = rightShift(data_low, 1) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PHY_10GBASEKR_EEE_value = &H0
        flag_PHY_10GBASEKR_EEE        = &H0
        write_PHY_10GBASEKX4_EEE_value = &H0
        flag_PHY_10GBASEKX4_EEE        = &H0
        write_PHY_1000BASEKX_EEE_value = &H0
        flag_PHY_1000BASEKX_EEE        = &H0
        write_PHY_10GBASET_EEE_value = &H0
        flag_PHY_10GBASET_EEE        = &H0
        write_PHY_1000BASET_EEE_value = &H0
        flag_PHY_1000BASET_EEE        = &H0
        write_PHY_100BASETX_EE_value = &H0
        flag_PHY_100BASETX_EE        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV3_pcs_eee_wake_err_cnt
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' cnt                                        [15:0]           get_cnt
''                                                             set_cnt
''                                                             read_cnt
''                                                             write_cnt
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV3_pcs_eee_wake_err_cnt
    Private write_cnt_value
    Private read_cnt_value
    Private flag_cnt

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

    Property Get get_cnt
        get_cnt = read_cnt_value
    End Property

    Property Let set_cnt(aData)
        write_cnt_value = aData
        flag_cnt        = &H1
    End Property

    Property Get read_cnt
        read
        read_cnt = read_cnt_value
    End Property

    Property Let write_cnt(aData)
        set_cnt = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cnt_mask = &Hffff
        if data_low > LONG_MAX then
            if cnt_mask = mask then
                read_cnt_value = data_low
            else
                read_cnt_value = (data_low - H8000_0000) and cnt_mask
            end If
        else
            read_cnt_value = data_low and cnt_mask
        end If

    End Sub

    Sub write
        If flag_cnt = &H0 Then read
        If flag_cnt = &H0 Then write_cnt_value = get_cnt

        regValue = leftShift((write_cnt_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        cnt_mask = &Hffff
        if data_low > LONG_MAX then
            if cnt_mask = mask then
                read_cnt_value = data_low
            else
                read_cnt_value = (data_low - H8000_0000) and cnt_mask
            end If
        else
            read_cnt_value = data_low and cnt_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_cnt_value = &H0
        flag_cnt        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV3_pcs_ieee_tsync_cap
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TX_PCS_TSYNC_EN                            [1:1]            get_TX_PCS_TSYNC_EN
''                                                             set_TX_PCS_TSYNC_EN
''                                                             read_TX_PCS_TSYNC_EN
''                                                             write_TX_PCS_TSYNC_EN
''---------------------------------------------------------------------------------
'' RX_PCS_TSYNC_EN                            [0:0]            get_RX_PCS_TSYNC_EN
''                                                             set_RX_PCS_TSYNC_EN
''                                                             read_RX_PCS_TSYNC_EN
''                                                             write_RX_PCS_TSYNC_EN
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV3_pcs_ieee_tsync_cap
    Private write_TX_PCS_TSYNC_EN_value
    Private read_TX_PCS_TSYNC_EN_value
    Private flag_TX_PCS_TSYNC_EN
    Private write_RX_PCS_TSYNC_EN_value
    Private read_RX_PCS_TSYNC_EN_value
    Private flag_RX_PCS_TSYNC_EN

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He10
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_TX_PCS_TSYNC_EN
        get_TX_PCS_TSYNC_EN = read_TX_PCS_TSYNC_EN_value
    End Property

    Property Let set_TX_PCS_TSYNC_EN(aData)
        write_TX_PCS_TSYNC_EN_value = aData
        flag_TX_PCS_TSYNC_EN        = &H1
    End Property

    Property Get read_TX_PCS_TSYNC_EN
        read
        read_TX_PCS_TSYNC_EN = read_TX_PCS_TSYNC_EN_value
    End Property

    Property Let write_TX_PCS_TSYNC_EN(aData)
        set_TX_PCS_TSYNC_EN = aData
        write
    End Property

    Property Get get_RX_PCS_TSYNC_EN
        get_RX_PCS_TSYNC_EN = read_RX_PCS_TSYNC_EN_value
    End Property

    Property Let set_RX_PCS_TSYNC_EN(aData)
        write_RX_PCS_TSYNC_EN_value = aData
        flag_RX_PCS_TSYNC_EN        = &H1
    End Property

    Property Get read_RX_PCS_TSYNC_EN
        read
        read_RX_PCS_TSYNC_EN = read_RX_PCS_TSYNC_EN_value
    End Property

    Property Let write_RX_PCS_TSYNC_EN(aData)
        set_RX_PCS_TSYNC_EN = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TX_PCS_TSYNC_EN_value = rightShift(data_low, 1) and &H1
        RX_PCS_TSYNC_EN_mask = &H1
        if data_low > LONG_MAX then
            if RX_PCS_TSYNC_EN_mask = mask then
                read_RX_PCS_TSYNC_EN_value = data_low
            else
                read_RX_PCS_TSYNC_EN_value = (data_low - H8000_0000) and RX_PCS_TSYNC_EN_mask
            end If
        else
            read_RX_PCS_TSYNC_EN_value = data_low and RX_PCS_TSYNC_EN_mask
        end If

    End Sub

    Sub write
        If flag_TX_PCS_TSYNC_EN = &H0 or flag_RX_PCS_TSYNC_EN = &H0 Then read
        If flag_TX_PCS_TSYNC_EN = &H0 Then write_TX_PCS_TSYNC_EN_value = get_TX_PCS_TSYNC_EN
        If flag_RX_PCS_TSYNC_EN = &H0 Then write_RX_PCS_TSYNC_EN_value = get_RX_PCS_TSYNC_EN

        regValue = leftShift((write_TX_PCS_TSYNC_EN_value and &H1), 1) + leftShift((write_RX_PCS_TSYNC_EN_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TX_PCS_TSYNC_EN_value = rightShift(data_low, 1) and &H1
        RX_PCS_TSYNC_EN_mask = &H1
        if data_low > LONG_MAX then
            if RX_PCS_TSYNC_EN_mask = mask then
                read_RX_PCS_TSYNC_EN_value = data_low
            else
                read_RX_PCS_TSYNC_EN_value = (data_low - H8000_0000) and RX_PCS_TSYNC_EN_mask
            end If
        else
            read_RX_PCS_TSYNC_EN_value = data_low and RX_PCS_TSYNC_EN_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TX_PCS_TSYNC_EN_value = &H0
        flag_TX_PCS_TSYNC_EN        = &H0
        write_RX_PCS_TSYNC_EN_value = &H0
        flag_RX_PCS_TSYNC_EN        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV3_pcs_ieee_tx_tsync_max_delay_lower
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TX_PCS_MAX_DLY_15_0                        [15:0]           get_TX_PCS_MAX_DLY_15_0
''                                                             set_TX_PCS_MAX_DLY_15_0
''                                                             read_TX_PCS_MAX_DLY_15_0
''                                                             write_TX_PCS_MAX_DLY_15_0
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV3_pcs_ieee_tx_tsync_max_delay_lower
    Private write_TX_PCS_MAX_DLY_15_0_value
    Private read_TX_PCS_MAX_DLY_15_0_value
    Private flag_TX_PCS_MAX_DLY_15_0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He12
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_TX_PCS_MAX_DLY_15_0
        get_TX_PCS_MAX_DLY_15_0 = read_TX_PCS_MAX_DLY_15_0_value
    End Property

    Property Let set_TX_PCS_MAX_DLY_15_0(aData)
        write_TX_PCS_MAX_DLY_15_0_value = aData
        flag_TX_PCS_MAX_DLY_15_0        = &H1
    End Property

    Property Get read_TX_PCS_MAX_DLY_15_0
        read
        read_TX_PCS_MAX_DLY_15_0 = read_TX_PCS_MAX_DLY_15_0_value
    End Property

    Property Let write_TX_PCS_MAX_DLY_15_0(aData)
        set_TX_PCS_MAX_DLY_15_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TX_PCS_MAX_DLY_15_0_mask = &Hffff
        if data_low > LONG_MAX then
            if TX_PCS_MAX_DLY_15_0_mask = mask then
                read_TX_PCS_MAX_DLY_15_0_value = data_low
            else
                read_TX_PCS_MAX_DLY_15_0_value = (data_low - H8000_0000) and TX_PCS_MAX_DLY_15_0_mask
            end If
        else
            read_TX_PCS_MAX_DLY_15_0_value = data_low and TX_PCS_MAX_DLY_15_0_mask
        end If

    End Sub

    Sub write
        If flag_TX_PCS_MAX_DLY_15_0 = &H0 Then read
        If flag_TX_PCS_MAX_DLY_15_0 = &H0 Then write_TX_PCS_MAX_DLY_15_0_value = get_TX_PCS_MAX_DLY_15_0

        regValue = leftShift((write_TX_PCS_MAX_DLY_15_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TX_PCS_MAX_DLY_15_0_mask = &Hffff
        if data_low > LONG_MAX then
            if TX_PCS_MAX_DLY_15_0_mask = mask then
                read_TX_PCS_MAX_DLY_15_0_value = data_low
            else
                read_TX_PCS_MAX_DLY_15_0_value = (data_low - H8000_0000) and TX_PCS_MAX_DLY_15_0_mask
            end If
        else
            read_TX_PCS_MAX_DLY_15_0_value = data_low and TX_PCS_MAX_DLY_15_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TX_PCS_MAX_DLY_15_0_value = &H0
        flag_TX_PCS_MAX_DLY_15_0        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV3_pcs_ieee_tx_tsync_max_delay_upper
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TX_PCS_MAX_DLY_31_16                       [15:0]           get_TX_PCS_MAX_DLY_31_16
''                                                             set_TX_PCS_MAX_DLY_31_16
''                                                             read_TX_PCS_MAX_DLY_31_16
''                                                             write_TX_PCS_MAX_DLY_31_16
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV3_pcs_ieee_tx_tsync_max_delay_upper
    Private write_TX_PCS_MAX_DLY_31_16_value
    Private read_TX_PCS_MAX_DLY_31_16_value
    Private flag_TX_PCS_MAX_DLY_31_16

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He14
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_TX_PCS_MAX_DLY_31_16
        get_TX_PCS_MAX_DLY_31_16 = read_TX_PCS_MAX_DLY_31_16_value
    End Property

    Property Let set_TX_PCS_MAX_DLY_31_16(aData)
        write_TX_PCS_MAX_DLY_31_16_value = aData
        flag_TX_PCS_MAX_DLY_31_16        = &H1
    End Property

    Property Get read_TX_PCS_MAX_DLY_31_16
        read
        read_TX_PCS_MAX_DLY_31_16 = read_TX_PCS_MAX_DLY_31_16_value
    End Property

    Property Let write_TX_PCS_MAX_DLY_31_16(aData)
        set_TX_PCS_MAX_DLY_31_16 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TX_PCS_MAX_DLY_31_16_mask = &Hffff
        if data_low > LONG_MAX then
            if TX_PCS_MAX_DLY_31_16_mask = mask then
                read_TX_PCS_MAX_DLY_31_16_value = data_low
            else
                read_TX_PCS_MAX_DLY_31_16_value = (data_low - H8000_0000) and TX_PCS_MAX_DLY_31_16_mask
            end If
        else
            read_TX_PCS_MAX_DLY_31_16_value = data_low and TX_PCS_MAX_DLY_31_16_mask
        end If

    End Sub

    Sub write
        If flag_TX_PCS_MAX_DLY_31_16 = &H0 Then read
        If flag_TX_PCS_MAX_DLY_31_16 = &H0 Then write_TX_PCS_MAX_DLY_31_16_value = get_TX_PCS_MAX_DLY_31_16

        regValue = leftShift((write_TX_PCS_MAX_DLY_31_16_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TX_PCS_MAX_DLY_31_16_mask = &Hffff
        if data_low > LONG_MAX then
            if TX_PCS_MAX_DLY_31_16_mask = mask then
                read_TX_PCS_MAX_DLY_31_16_value = data_low
            else
                read_TX_PCS_MAX_DLY_31_16_value = (data_low - H8000_0000) and TX_PCS_MAX_DLY_31_16_mask
            end If
        else
            read_TX_PCS_MAX_DLY_31_16_value = data_low and TX_PCS_MAX_DLY_31_16_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TX_PCS_MAX_DLY_31_16_value = &H0
        flag_TX_PCS_MAX_DLY_31_16        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV3_pcs_ieee_tx_tsync_min_delay_lower
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TX_PCS_MIN_DLY_15_0                        [15:0]           get_TX_PCS_MIN_DLY_15_0
''                                                             set_TX_PCS_MIN_DLY_15_0
''                                                             read_TX_PCS_MIN_DLY_15_0
''                                                             write_TX_PCS_MIN_DLY_15_0
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV3_pcs_ieee_tx_tsync_min_delay_lower
    Private write_TX_PCS_MIN_DLY_15_0_value
    Private read_TX_PCS_MIN_DLY_15_0_value
    Private flag_TX_PCS_MIN_DLY_15_0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He16
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_TX_PCS_MIN_DLY_15_0
        get_TX_PCS_MIN_DLY_15_0 = read_TX_PCS_MIN_DLY_15_0_value
    End Property

    Property Let set_TX_PCS_MIN_DLY_15_0(aData)
        write_TX_PCS_MIN_DLY_15_0_value = aData
        flag_TX_PCS_MIN_DLY_15_0        = &H1
    End Property

    Property Get read_TX_PCS_MIN_DLY_15_0
        read
        read_TX_PCS_MIN_DLY_15_0 = read_TX_PCS_MIN_DLY_15_0_value
    End Property

    Property Let write_TX_PCS_MIN_DLY_15_0(aData)
        set_TX_PCS_MIN_DLY_15_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TX_PCS_MIN_DLY_15_0_mask = &Hffff
        if data_low > LONG_MAX then
            if TX_PCS_MIN_DLY_15_0_mask = mask then
                read_TX_PCS_MIN_DLY_15_0_value = data_low
            else
                read_TX_PCS_MIN_DLY_15_0_value = (data_low - H8000_0000) and TX_PCS_MIN_DLY_15_0_mask
            end If
        else
            read_TX_PCS_MIN_DLY_15_0_value = data_low and TX_PCS_MIN_DLY_15_0_mask
        end If

    End Sub

    Sub write
        If flag_TX_PCS_MIN_DLY_15_0 = &H0 Then read
        If flag_TX_PCS_MIN_DLY_15_0 = &H0 Then write_TX_PCS_MIN_DLY_15_0_value = get_TX_PCS_MIN_DLY_15_0

        regValue = leftShift((write_TX_PCS_MIN_DLY_15_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TX_PCS_MIN_DLY_15_0_mask = &Hffff
        if data_low > LONG_MAX then
            if TX_PCS_MIN_DLY_15_0_mask = mask then
                read_TX_PCS_MIN_DLY_15_0_value = data_low
            else
                read_TX_PCS_MIN_DLY_15_0_value = (data_low - H8000_0000) and TX_PCS_MIN_DLY_15_0_mask
            end If
        else
            read_TX_PCS_MIN_DLY_15_0_value = data_low and TX_PCS_MIN_DLY_15_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TX_PCS_MIN_DLY_15_0_value = &H0
        flag_TX_PCS_MIN_DLY_15_0        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV3_pcs_ieee_tx_tsync_min_delay_upper
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TX_PCS_MIN_DLY_31_16                       [15:0]           get_TX_PCS_MIN_DLY_31_16
''                                                             set_TX_PCS_MIN_DLY_31_16
''                                                             read_TX_PCS_MIN_DLY_31_16
''                                                             write_TX_PCS_MIN_DLY_31_16
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV3_pcs_ieee_tx_tsync_min_delay_upper
    Private write_TX_PCS_MIN_DLY_31_16_value
    Private read_TX_PCS_MIN_DLY_31_16_value
    Private flag_TX_PCS_MIN_DLY_31_16

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He18
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_TX_PCS_MIN_DLY_31_16
        get_TX_PCS_MIN_DLY_31_16 = read_TX_PCS_MIN_DLY_31_16_value
    End Property

    Property Let set_TX_PCS_MIN_DLY_31_16(aData)
        write_TX_PCS_MIN_DLY_31_16_value = aData
        flag_TX_PCS_MIN_DLY_31_16        = &H1
    End Property

    Property Get read_TX_PCS_MIN_DLY_31_16
        read
        read_TX_PCS_MIN_DLY_31_16 = read_TX_PCS_MIN_DLY_31_16_value
    End Property

    Property Let write_TX_PCS_MIN_DLY_31_16(aData)
        set_TX_PCS_MIN_DLY_31_16 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TX_PCS_MIN_DLY_31_16_mask = &Hffff
        if data_low > LONG_MAX then
            if TX_PCS_MIN_DLY_31_16_mask = mask then
                read_TX_PCS_MIN_DLY_31_16_value = data_low
            else
                read_TX_PCS_MIN_DLY_31_16_value = (data_low - H8000_0000) and TX_PCS_MIN_DLY_31_16_mask
            end If
        else
            read_TX_PCS_MIN_DLY_31_16_value = data_low and TX_PCS_MIN_DLY_31_16_mask
        end If

    End Sub

    Sub write
        If flag_TX_PCS_MIN_DLY_31_16 = &H0 Then read
        If flag_TX_PCS_MIN_DLY_31_16 = &H0 Then write_TX_PCS_MIN_DLY_31_16_value = get_TX_PCS_MIN_DLY_31_16

        regValue = leftShift((write_TX_PCS_MIN_DLY_31_16_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TX_PCS_MIN_DLY_31_16_mask = &Hffff
        if data_low > LONG_MAX then
            if TX_PCS_MIN_DLY_31_16_mask = mask then
                read_TX_PCS_MIN_DLY_31_16_value = data_low
            else
                read_TX_PCS_MIN_DLY_31_16_value = (data_low - H8000_0000) and TX_PCS_MIN_DLY_31_16_mask
            end If
        else
            read_TX_PCS_MIN_DLY_31_16_value = data_low and TX_PCS_MIN_DLY_31_16_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TX_PCS_MIN_DLY_31_16_value = &H0
        flag_TX_PCS_MIN_DLY_31_16        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV3_pcs_ieee_rx_tsync_max_delay_lower
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RX_PCS_MAX_DLY_15_0                        [15:0]           get_RX_PCS_MAX_DLY_15_0
''                                                             set_RX_PCS_MAX_DLY_15_0
''                                                             read_RX_PCS_MAX_DLY_15_0
''                                                             write_RX_PCS_MAX_DLY_15_0
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV3_pcs_ieee_rx_tsync_max_delay_lower
    Private write_RX_PCS_MAX_DLY_15_0_value
    Private read_RX_PCS_MAX_DLY_15_0_value
    Private flag_RX_PCS_MAX_DLY_15_0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He1a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_RX_PCS_MAX_DLY_15_0
        get_RX_PCS_MAX_DLY_15_0 = read_RX_PCS_MAX_DLY_15_0_value
    End Property

    Property Let set_RX_PCS_MAX_DLY_15_0(aData)
        write_RX_PCS_MAX_DLY_15_0_value = aData
        flag_RX_PCS_MAX_DLY_15_0        = &H1
    End Property

    Property Get read_RX_PCS_MAX_DLY_15_0
        read
        read_RX_PCS_MAX_DLY_15_0 = read_RX_PCS_MAX_DLY_15_0_value
    End Property

    Property Let write_RX_PCS_MAX_DLY_15_0(aData)
        set_RX_PCS_MAX_DLY_15_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RX_PCS_MAX_DLY_15_0_mask = &Hffff
        if data_low > LONG_MAX then
            if RX_PCS_MAX_DLY_15_0_mask = mask then
                read_RX_PCS_MAX_DLY_15_0_value = data_low
            else
                read_RX_PCS_MAX_DLY_15_0_value = (data_low - H8000_0000) and RX_PCS_MAX_DLY_15_0_mask
            end If
        else
            read_RX_PCS_MAX_DLY_15_0_value = data_low and RX_PCS_MAX_DLY_15_0_mask
        end If

    End Sub

    Sub write
        If flag_RX_PCS_MAX_DLY_15_0 = &H0 Then read
        If flag_RX_PCS_MAX_DLY_15_0 = &H0 Then write_RX_PCS_MAX_DLY_15_0_value = get_RX_PCS_MAX_DLY_15_0

        regValue = leftShift((write_RX_PCS_MAX_DLY_15_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RX_PCS_MAX_DLY_15_0_mask = &Hffff
        if data_low > LONG_MAX then
            if RX_PCS_MAX_DLY_15_0_mask = mask then
                read_RX_PCS_MAX_DLY_15_0_value = data_low
            else
                read_RX_PCS_MAX_DLY_15_0_value = (data_low - H8000_0000) and RX_PCS_MAX_DLY_15_0_mask
            end If
        else
            read_RX_PCS_MAX_DLY_15_0_value = data_low and RX_PCS_MAX_DLY_15_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RX_PCS_MAX_DLY_15_0_value = &H0
        flag_RX_PCS_MAX_DLY_15_0        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV3_pcs_ieee_rx_tsync_max_delay_upper
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RX_PCS_MAX_DLY_31_16                       [15:0]           get_RX_PCS_MAX_DLY_31_16
''                                                             set_RX_PCS_MAX_DLY_31_16
''                                                             read_RX_PCS_MAX_DLY_31_16
''                                                             write_RX_PCS_MAX_DLY_31_16
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV3_pcs_ieee_rx_tsync_max_delay_upper
    Private write_RX_PCS_MAX_DLY_31_16_value
    Private read_RX_PCS_MAX_DLY_31_16_value
    Private flag_RX_PCS_MAX_DLY_31_16

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He1c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_RX_PCS_MAX_DLY_31_16
        get_RX_PCS_MAX_DLY_31_16 = read_RX_PCS_MAX_DLY_31_16_value
    End Property

    Property Let set_RX_PCS_MAX_DLY_31_16(aData)
        write_RX_PCS_MAX_DLY_31_16_value = aData
        flag_RX_PCS_MAX_DLY_31_16        = &H1
    End Property

    Property Get read_RX_PCS_MAX_DLY_31_16
        read
        read_RX_PCS_MAX_DLY_31_16 = read_RX_PCS_MAX_DLY_31_16_value
    End Property

    Property Let write_RX_PCS_MAX_DLY_31_16(aData)
        set_RX_PCS_MAX_DLY_31_16 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RX_PCS_MAX_DLY_31_16_mask = &Hffff
        if data_low > LONG_MAX then
            if RX_PCS_MAX_DLY_31_16_mask = mask then
                read_RX_PCS_MAX_DLY_31_16_value = data_low
            else
                read_RX_PCS_MAX_DLY_31_16_value = (data_low - H8000_0000) and RX_PCS_MAX_DLY_31_16_mask
            end If
        else
            read_RX_PCS_MAX_DLY_31_16_value = data_low and RX_PCS_MAX_DLY_31_16_mask
        end If

    End Sub

    Sub write
        If flag_RX_PCS_MAX_DLY_31_16 = &H0 Then read
        If flag_RX_PCS_MAX_DLY_31_16 = &H0 Then write_RX_PCS_MAX_DLY_31_16_value = get_RX_PCS_MAX_DLY_31_16

        regValue = leftShift((write_RX_PCS_MAX_DLY_31_16_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RX_PCS_MAX_DLY_31_16_mask = &Hffff
        if data_low > LONG_MAX then
            if RX_PCS_MAX_DLY_31_16_mask = mask then
                read_RX_PCS_MAX_DLY_31_16_value = data_low
            else
                read_RX_PCS_MAX_DLY_31_16_value = (data_low - H8000_0000) and RX_PCS_MAX_DLY_31_16_mask
            end If
        else
            read_RX_PCS_MAX_DLY_31_16_value = data_low and RX_PCS_MAX_DLY_31_16_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RX_PCS_MAX_DLY_31_16_value = &H0
        flag_RX_PCS_MAX_DLY_31_16        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV3_pcs_ieee_rx_tsync_min_delay_lower
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RX_PCS_MIN_DLY_15_0                        [15:0]           get_RX_PCS_MIN_DLY_15_0
''                                                             set_RX_PCS_MIN_DLY_15_0
''                                                             read_RX_PCS_MIN_DLY_15_0
''                                                             write_RX_PCS_MIN_DLY_15_0
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV3_pcs_ieee_rx_tsync_min_delay_lower
    Private write_RX_PCS_MIN_DLY_15_0_value
    Private read_RX_PCS_MIN_DLY_15_0_value
    Private flag_RX_PCS_MIN_DLY_15_0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He1e
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_RX_PCS_MIN_DLY_15_0
        get_RX_PCS_MIN_DLY_15_0 = read_RX_PCS_MIN_DLY_15_0_value
    End Property

    Property Let set_RX_PCS_MIN_DLY_15_0(aData)
        write_RX_PCS_MIN_DLY_15_0_value = aData
        flag_RX_PCS_MIN_DLY_15_0        = &H1
    End Property

    Property Get read_RX_PCS_MIN_DLY_15_0
        read
        read_RX_PCS_MIN_DLY_15_0 = read_RX_PCS_MIN_DLY_15_0_value
    End Property

    Property Let write_RX_PCS_MIN_DLY_15_0(aData)
        set_RX_PCS_MIN_DLY_15_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RX_PCS_MIN_DLY_15_0_mask = &Hffff
        if data_low > LONG_MAX then
            if RX_PCS_MIN_DLY_15_0_mask = mask then
                read_RX_PCS_MIN_DLY_15_0_value = data_low
            else
                read_RX_PCS_MIN_DLY_15_0_value = (data_low - H8000_0000) and RX_PCS_MIN_DLY_15_0_mask
            end If
        else
            read_RX_PCS_MIN_DLY_15_0_value = data_low and RX_PCS_MIN_DLY_15_0_mask
        end If

    End Sub

    Sub write
        If flag_RX_PCS_MIN_DLY_15_0 = &H0 Then read
        If flag_RX_PCS_MIN_DLY_15_0 = &H0 Then write_RX_PCS_MIN_DLY_15_0_value = get_RX_PCS_MIN_DLY_15_0

        regValue = leftShift((write_RX_PCS_MIN_DLY_15_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RX_PCS_MIN_DLY_15_0_mask = &Hffff
        if data_low > LONG_MAX then
            if RX_PCS_MIN_DLY_15_0_mask = mask then
                read_RX_PCS_MIN_DLY_15_0_value = data_low
            else
                read_RX_PCS_MIN_DLY_15_0_value = (data_low - H8000_0000) and RX_PCS_MIN_DLY_15_0_mask
            end If
        else
            read_RX_PCS_MIN_DLY_15_0_value = data_low and RX_PCS_MIN_DLY_15_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RX_PCS_MIN_DLY_15_0_value = &H0
        flag_RX_PCS_MIN_DLY_15_0        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV3_pcs_ieee_rx_tsync_min_delay_upper
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RX_PCS_MIN_DLY_31_16                       [15:0]           get_RX_PCS_MIN_DLY_31_16
''                                                             set_RX_PCS_MIN_DLY_31_16
''                                                             read_RX_PCS_MIN_DLY_31_16
''                                                             write_RX_PCS_MIN_DLY_31_16
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV3_pcs_ieee_rx_tsync_min_delay_upper
    Private write_RX_PCS_MIN_DLY_31_16_value
    Private read_RX_PCS_MIN_DLY_31_16_value
    Private flag_RX_PCS_MIN_DLY_31_16

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He20
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_RX_PCS_MIN_DLY_31_16
        get_RX_PCS_MIN_DLY_31_16 = read_RX_PCS_MIN_DLY_31_16_value
    End Property

    Property Let set_RX_PCS_MIN_DLY_31_16(aData)
        write_RX_PCS_MIN_DLY_31_16_value = aData
        flag_RX_PCS_MIN_DLY_31_16        = &H1
    End Property

    Property Get read_RX_PCS_MIN_DLY_31_16
        read
        read_RX_PCS_MIN_DLY_31_16 = read_RX_PCS_MIN_DLY_31_16_value
    End Property

    Property Let write_RX_PCS_MIN_DLY_31_16(aData)
        set_RX_PCS_MIN_DLY_31_16 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RX_PCS_MIN_DLY_31_16_mask = &Hffff
        if data_low > LONG_MAX then
            if RX_PCS_MIN_DLY_31_16_mask = mask then
                read_RX_PCS_MIN_DLY_31_16_value = data_low
            else
                read_RX_PCS_MIN_DLY_31_16_value = (data_low - H8000_0000) and RX_PCS_MIN_DLY_31_16_mask
            end If
        else
            read_RX_PCS_MIN_DLY_31_16_value = data_low and RX_PCS_MIN_DLY_31_16_mask
        end If

    End Sub

    Sub write
        If flag_RX_PCS_MIN_DLY_31_16 = &H0 Then read
        If flag_RX_PCS_MIN_DLY_31_16 = &H0 Then write_RX_PCS_MIN_DLY_31_16_value = get_RX_PCS_MIN_DLY_31_16

        regValue = leftShift((write_RX_PCS_MIN_DLY_31_16_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RX_PCS_MIN_DLY_31_16_mask = &Hffff
        if data_low > LONG_MAX then
            if RX_PCS_MIN_DLY_31_16_mask = mask then
                read_RX_PCS_MIN_DLY_31_16_value = data_low
            else
                read_RX_PCS_MIN_DLY_31_16_value = (data_low - H8000_0000) and RX_PCS_MIN_DLY_31_16_mask
            end If
        else
            read_RX_PCS_MIN_DLY_31_16_value = data_low and RX_PCS_MIN_DLY_31_16_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RX_PCS_MIN_DLY_31_16_value = &H0
        flag_RX_PCS_MIN_DLY_31_16        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class CL45DEV3_INSTANCE

    Public pcs_ieee_ctl1
    Public pcs_ieee_st1
    Public pcs_ieee_dev_id0
    Public pcs_ieee_dev_id1
    Public pcs_ieee_dev0
    Public pcs_ieee_dev1
    Public pcs_ieee_pkg_id0
    Public pcs_ieee_pkg_id1
    Public pcs_eee_cap
    Public pcs_eee_wake_err_cnt
    Public pcs_ieee_tsync_cap
    Public pcs_ieee_tx_tsync_max_delay_lower
    Public pcs_ieee_tx_tsync_max_delay_upper
    Public pcs_ieee_tx_tsync_min_delay_lower
    Public pcs_ieee_tx_tsync_min_delay_upper
    Public pcs_ieee_rx_tsync_max_delay_lower
    Public pcs_ieee_rx_tsync_max_delay_upper
    Public pcs_ieee_rx_tsync_min_delay_lower
    Public pcs_ieee_rx_tsync_min_delay_upper


    Public default function Init(aBaseAddr)
        Set pcs_ieee_ctl1 = (New REGISTER_CL45DEV3_pcs_ieee_ctl1)(aBaseAddr, 16)
        Set pcs_ieee_st1 = (New REGISTER_CL45DEV3_pcs_ieee_st1)(aBaseAddr, 16)
        Set pcs_ieee_dev_id0 = (New REGISTER_CL45DEV3_pcs_ieee_dev_id0)(aBaseAddr, 16)
        Set pcs_ieee_dev_id1 = (New REGISTER_CL45DEV3_pcs_ieee_dev_id1)(aBaseAddr, 16)
        Set pcs_ieee_dev0 = (New REGISTER_CL45DEV3_pcs_ieee_dev0)(aBaseAddr, 16)
        Set pcs_ieee_dev1 = (New REGISTER_CL45DEV3_pcs_ieee_dev1)(aBaseAddr, 16)
        Set pcs_ieee_pkg_id0 = (New REGISTER_CL45DEV3_pcs_ieee_pkg_id0)(aBaseAddr, 16)
        Set pcs_ieee_pkg_id1 = (New REGISTER_CL45DEV3_pcs_ieee_pkg_id1)(aBaseAddr, 16)
        Set pcs_eee_cap = (New REGISTER_CL45DEV3_pcs_eee_cap)(aBaseAddr, 16)
        Set pcs_eee_wake_err_cnt = (New REGISTER_CL45DEV3_pcs_eee_wake_err_cnt)(aBaseAddr, 16)
        Set pcs_ieee_tsync_cap = (New REGISTER_CL45DEV3_pcs_ieee_tsync_cap)(aBaseAddr, 16)
        Set pcs_ieee_tx_tsync_max_delay_lower = (New REGISTER_CL45DEV3_pcs_ieee_tx_tsync_max_delay_lower)(aBaseAddr, 16)
        Set pcs_ieee_tx_tsync_max_delay_upper = (New REGISTER_CL45DEV3_pcs_ieee_tx_tsync_max_delay_upper)(aBaseAddr, 16)
        Set pcs_ieee_tx_tsync_min_delay_lower = (New REGISTER_CL45DEV3_pcs_ieee_tx_tsync_min_delay_lower)(aBaseAddr, 16)
        Set pcs_ieee_tx_tsync_min_delay_upper = (New REGISTER_CL45DEV3_pcs_ieee_tx_tsync_min_delay_upper)(aBaseAddr, 16)
        Set pcs_ieee_rx_tsync_max_delay_lower = (New REGISTER_CL45DEV3_pcs_ieee_rx_tsync_max_delay_lower)(aBaseAddr, 16)
        Set pcs_ieee_rx_tsync_max_delay_upper = (New REGISTER_CL45DEV3_pcs_ieee_rx_tsync_max_delay_upper)(aBaseAddr, 16)
        Set pcs_ieee_rx_tsync_min_delay_lower = (New REGISTER_CL45DEV3_pcs_ieee_rx_tsync_min_delay_lower)(aBaseAddr, 16)
        Set pcs_ieee_rx_tsync_min_delay_upper = (New REGISTER_CL45DEV3_pcs_ieee_rx_tsync_min_delay_upper)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set CL45DEV3 = CreateObject("System.Collections.ArrayList")
CL45DEV3.Add ((New CL45DEV3_INSTANCE)(&H4a460000))
CL45DEV3.Add ((New CL45DEV3_INSTANCE)(&H49460000))
CL45DEV3.Add ((New CL45DEV3_INSTANCE)(&H49860000))
CL45DEV3.Add ((New CL45DEV3_INSTANCE)(&H49c60000))
CL45DEV3.Add ((New CL45DEV3_INSTANCE)(&H4a060000))


