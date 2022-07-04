

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


'' @REGISTER : CL45DEV1_pmd_ieee_ctl1
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
'' SPEED_SEL_LSB                              [13:13]          get_SPEED_SEL_LSB
''                                                             set_SPEED_SEL_LSB
''                                                             read_SPEED_SEL_LSB
''                                                             write_SPEED_SEL_LSB
''---------------------------------------------------------------------------------
'' LOW_PWR                                    [11:11]          get_LOW_PWR
''                                                             set_LOW_PWR
''                                                             read_LOW_PWR
''                                                             write_LOW_PWR
''---------------------------------------------------------------------------------
'' SPEED_SEL_MSB                              [6:6]            get_SPEED_SEL_MSB
''                                                             set_SPEED_SEL_MSB
''                                                             read_SPEED_SEL_MSB
''                                                             write_SPEED_SEL_MSB
''---------------------------------------------------------------------------------
'' SPEED_SEL_10G                              [5:2]            get_SPEED_SEL_10G
''                                                             set_SPEED_SEL_10G
''                                                             read_SPEED_SEL_10G
''                                                             write_SPEED_SEL_10G
''---------------------------------------------------------------------------------
'' LPBK                                       [0:0]            get_LPBK
''                                                             set_LPBK
''                                                             read_LPBK
''                                                             write_LPBK
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV1_pmd_ieee_ctl1
    Private write_RESET_value
    Private read_RESET_value
    Private flag_RESET
    Private write_SPEED_SEL_LSB_value
    Private read_SPEED_SEL_LSB_value
    Private flag_SPEED_SEL_LSB
    Private write_LOW_PWR_value
    Private read_LOW_PWR_value
    Private flag_LOW_PWR
    Private write_SPEED_SEL_MSB_value
    Private read_SPEED_SEL_MSB_value
    Private flag_SPEED_SEL_MSB
    Private write_SPEED_SEL_10G_value
    Private read_SPEED_SEL_10G_value
    Private flag_SPEED_SEL_10G
    Private write_LPBK_value
    Private read_LPBK_value
    Private flag_LPBK

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

    Property Get get_SPEED_SEL_LSB
        get_SPEED_SEL_LSB = read_SPEED_SEL_LSB_value
    End Property

    Property Let set_SPEED_SEL_LSB(aData)
        write_SPEED_SEL_LSB_value = aData
        flag_SPEED_SEL_LSB        = &H1
    End Property

    Property Get read_SPEED_SEL_LSB
        read
        read_SPEED_SEL_LSB = read_SPEED_SEL_LSB_value
    End Property

    Property Let write_SPEED_SEL_LSB(aData)
        set_SPEED_SEL_LSB = aData
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

    Property Get get_SPEED_SEL_MSB
        get_SPEED_SEL_MSB = read_SPEED_SEL_MSB_value
    End Property

    Property Let set_SPEED_SEL_MSB(aData)
        write_SPEED_SEL_MSB_value = aData
        flag_SPEED_SEL_MSB        = &H1
    End Property

    Property Get read_SPEED_SEL_MSB
        read
        read_SPEED_SEL_MSB = read_SPEED_SEL_MSB_value
    End Property

    Property Let write_SPEED_SEL_MSB(aData)
        set_SPEED_SEL_MSB = aData
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

    Property Get get_LPBK
        get_LPBK = read_LPBK_value
    End Property

    Property Let set_LPBK(aData)
        write_LPBK_value = aData
        flag_LPBK        = &H1
    End Property

    Property Get read_LPBK
        read
        read_LPBK = read_LPBK_value
    End Property

    Property Let write_LPBK(aData)
        set_LPBK = aData
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
        read_SPEED_SEL_LSB_value = rightShift(data_low, 13) and &H1
        read_LOW_PWR_value = rightShift(data_low, 11) and &H1
        read_SPEED_SEL_MSB_value = rightShift(data_low, 6) and &H1
        read_SPEED_SEL_10G_value = rightShift(data_low, 2) and &Hf
        LPBK_mask = &H1
        if data_low > LONG_MAX then
            if LPBK_mask = mask then
                read_LPBK_value = data_low
            else
                read_LPBK_value = (data_low - H8000_0000) and LPBK_mask
            end If
        else
            read_LPBK_value = data_low and LPBK_mask
        end If

    End Sub

    Sub write
        If flag_RESET = &H0 or flag_SPEED_SEL_LSB = &H0 or flag_LOW_PWR = &H0 or flag_SPEED_SEL_MSB = &H0 or flag_SPEED_SEL_10G = &H0 or flag_LPBK = &H0 Then read
        If flag_RESET = &H0 Then write_RESET_value = get_RESET
        If flag_SPEED_SEL_LSB = &H0 Then write_SPEED_SEL_LSB_value = get_SPEED_SEL_LSB
        If flag_LOW_PWR = &H0 Then write_LOW_PWR_value = get_LOW_PWR
        If flag_SPEED_SEL_MSB = &H0 Then write_SPEED_SEL_MSB_value = get_SPEED_SEL_MSB
        If flag_SPEED_SEL_10G = &H0 Then write_SPEED_SEL_10G_value = get_SPEED_SEL_10G
        If flag_LPBK = &H0 Then write_LPBK_value = get_LPBK

        regValue = leftShift((write_RESET_value and &H1), 15) + leftShift((write_SPEED_SEL_LSB_value and &H1), 13) + leftShift((write_LOW_PWR_value and &H1), 11) + leftShift((write_SPEED_SEL_MSB_value and &H1), 6) + leftShift((write_SPEED_SEL_10G_value and &Hf), 2) + leftShift((write_LPBK_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RESET_value = rightShift(data_low, 15) and &H1
        read_SPEED_SEL_LSB_value = rightShift(data_low, 13) and &H1
        read_LOW_PWR_value = rightShift(data_low, 11) and &H1
        read_SPEED_SEL_MSB_value = rightShift(data_low, 6) and &H1
        read_SPEED_SEL_10G_value = rightShift(data_low, 2) and &Hf
        LPBK_mask = &H1
        if data_low > LONG_MAX then
            if LPBK_mask = mask then
                read_LPBK_value = data_low
            else
                read_LPBK_value = (data_low - H8000_0000) and LPBK_mask
            end If
        else
            read_LPBK_value = data_low and LPBK_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RESET_value = &H0
        flag_RESET        = &H0
        write_SPEED_SEL_LSB_value = &H0
        flag_SPEED_SEL_LSB        = &H0
        write_LOW_PWR_value = &H0
        flag_LOW_PWR        = &H0
        write_SPEED_SEL_MSB_value = &H0
        flag_SPEED_SEL_MSB        = &H0
        write_SPEED_SEL_10G_value = &H0
        flag_SPEED_SEL_10G        = &H0
        write_LPBK_value = &H0
        flag_LPBK        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV1_pmd_ieee_st1
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
'' RCV_LINK_ST                                [2:2]            get_RCV_LINK_ST
''                                                             set_RCV_LINK_ST
''                                                             read_RCV_LINK_ST
''                                                             write_RCV_LINK_ST
''---------------------------------------------------------------------------------
'' CAP_LOW_PWR                                [1:1]            get_CAP_LOW_PWR
''                                                             set_CAP_LOW_PWR
''                                                             read_CAP_LOW_PWR
''                                                             write_CAP_LOW_PWR
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV1_pmd_ieee_st1
    Private write_FAULT_value
    Private read_FAULT_value
    Private flag_FAULT
    Private write_RCV_LINK_ST_value
    Private read_RCV_LINK_ST_value
    Private flag_RCV_LINK_ST
    Private write_CAP_LOW_PWR_value
    Private read_CAP_LOW_PWR_value
    Private flag_CAP_LOW_PWR

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

    Property Get get_RCV_LINK_ST
        get_RCV_LINK_ST = read_RCV_LINK_ST_value
    End Property

    Property Let set_RCV_LINK_ST(aData)
        write_RCV_LINK_ST_value = aData
        flag_RCV_LINK_ST        = &H1
    End Property

    Property Get read_RCV_LINK_ST
        read
        read_RCV_LINK_ST = read_RCV_LINK_ST_value
    End Property

    Property Let write_RCV_LINK_ST(aData)
        set_RCV_LINK_ST = aData
        write
    End Property

    Property Get get_CAP_LOW_PWR
        get_CAP_LOW_PWR = read_CAP_LOW_PWR_value
    End Property

    Property Let set_CAP_LOW_PWR(aData)
        write_CAP_LOW_PWR_value = aData
        flag_CAP_LOW_PWR        = &H1
    End Property

    Property Get read_CAP_LOW_PWR
        read
        read_CAP_LOW_PWR = read_CAP_LOW_PWR_value
    End Property

    Property Let write_CAP_LOW_PWR(aData)
        set_CAP_LOW_PWR = aData
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
        read_RCV_LINK_ST_value = rightShift(data_low, 2) and &H1
        read_CAP_LOW_PWR_value = rightShift(data_low, 1) and &H1

    End Sub

    Sub write
        If flag_FAULT = &H0 or flag_RCV_LINK_ST = &H0 or flag_CAP_LOW_PWR = &H0 Then read
        If flag_FAULT = &H0 Then write_FAULT_value = get_FAULT
        If flag_RCV_LINK_ST = &H0 Then write_RCV_LINK_ST_value = get_RCV_LINK_ST
        If flag_CAP_LOW_PWR = &H0 Then write_CAP_LOW_PWR_value = get_CAP_LOW_PWR

        regValue = leftShift((write_FAULT_value and &H1), 7) + leftShift((write_RCV_LINK_ST_value and &H1), 2) + leftShift((write_CAP_LOW_PWR_value and &H1), 1)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_FAULT_value = rightShift(data_low, 7) and &H1
        read_RCV_LINK_ST_value = rightShift(data_low, 2) and &H1
        read_CAP_LOW_PWR_value = rightShift(data_low, 1) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_FAULT_value = &H0
        flag_FAULT        = &H0
        write_RCV_LINK_ST_value = &H0
        flag_RCV_LINK_ST        = &H0
        write_CAP_LOW_PWR_value = &H0
        flag_CAP_LOW_PWR        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV1_pmd_ieee_dev_id0
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
Class REGISTER_CL45DEV1_pmd_ieee_dev_id0
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


'' @REGISTER : CL45DEV1_pmd_ieee_dev_id1
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
Class REGISTER_CL45DEV1_pmd_ieee_dev_id1
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


'' @REGISTER : CL45DEV1_pmd_ieee_dev0
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
Class REGISTER_CL45DEV1_pmd_ieee_dev0
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


'' @REGISTER : CL45DEV1_pmd_ieee_dev1
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
Class REGISTER_CL45DEV1_pmd_ieee_dev1
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


'' @REGISTER : CL45DEV1_pmd_ieee_ctl2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PIASE_PMA                                  [9:9]            get_PIASE_PMA
''                                                             set_PIASE_PMA
''                                                             read_PIASE_PMA
''                                                             write_PIASE_PMA
''---------------------------------------------------------------------------------
'' PEASE_PMA                                  [8:8]            get_PEASE_PMA
''                                                             set_PEASE_PMA
''                                                             read_PEASE_PMA
''                                                             write_PEASE_PMA
''---------------------------------------------------------------------------------
'' PMA_PMD_TYPE_SEL                           [5:0]            get_PMA_PMD_TYPE_SEL
''                                                             set_PMA_PMD_TYPE_SEL
''                                                             read_PMA_PMD_TYPE_SEL
''                                                             write_PMA_PMD_TYPE_SEL
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV1_pmd_ieee_ctl2
    Private write_PIASE_PMA_value
    Private read_PIASE_PMA_value
    Private flag_PIASE_PMA
    Private write_PEASE_PMA_value
    Private read_PEASE_PMA_value
    Private flag_PEASE_PMA
    Private write_PMA_PMD_TYPE_SEL_value
    Private read_PMA_PMD_TYPE_SEL_value
    Private flag_PMA_PMD_TYPE_SEL

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

    Property Get get_PIASE_PMA
        get_PIASE_PMA = read_PIASE_PMA_value
    End Property

    Property Let set_PIASE_PMA(aData)
        write_PIASE_PMA_value = aData
        flag_PIASE_PMA        = &H1
    End Property

    Property Get read_PIASE_PMA
        read
        read_PIASE_PMA = read_PIASE_PMA_value
    End Property

    Property Let write_PIASE_PMA(aData)
        set_PIASE_PMA = aData
        write
    End Property

    Property Get get_PEASE_PMA
        get_PEASE_PMA = read_PEASE_PMA_value
    End Property

    Property Let set_PEASE_PMA(aData)
        write_PEASE_PMA_value = aData
        flag_PEASE_PMA        = &H1
    End Property

    Property Get read_PEASE_PMA
        read
        read_PEASE_PMA = read_PEASE_PMA_value
    End Property

    Property Let write_PEASE_PMA(aData)
        set_PEASE_PMA = aData
        write
    End Property

    Property Get get_PMA_PMD_TYPE_SEL
        get_PMA_PMD_TYPE_SEL = read_PMA_PMD_TYPE_SEL_value
    End Property

    Property Let set_PMA_PMD_TYPE_SEL(aData)
        write_PMA_PMD_TYPE_SEL_value = aData
        flag_PMA_PMD_TYPE_SEL        = &H1
    End Property

    Property Get read_PMA_PMD_TYPE_SEL
        read
        read_PMA_PMD_TYPE_SEL = read_PMA_PMD_TYPE_SEL_value
    End Property

    Property Let write_PMA_PMD_TYPE_SEL(aData)
        set_PMA_PMD_TYPE_SEL = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PIASE_PMA_value = rightShift(data_low, 9) and &H1
        read_PEASE_PMA_value = rightShift(data_low, 8) and &H1
        PMA_PMD_TYPE_SEL_mask = &H3f
        if data_low > LONG_MAX then
            if PMA_PMD_TYPE_SEL_mask = mask then
                read_PMA_PMD_TYPE_SEL_value = data_low
            else
                read_PMA_PMD_TYPE_SEL_value = (data_low - H8000_0000) and PMA_PMD_TYPE_SEL_mask
            end If
        else
            read_PMA_PMD_TYPE_SEL_value = data_low and PMA_PMD_TYPE_SEL_mask
        end If

    End Sub

    Sub write
        If flag_PIASE_PMA = &H0 or flag_PEASE_PMA = &H0 or flag_PMA_PMD_TYPE_SEL = &H0 Then read
        If flag_PIASE_PMA = &H0 Then write_PIASE_PMA_value = get_PIASE_PMA
        If flag_PEASE_PMA = &H0 Then write_PEASE_PMA_value = get_PEASE_PMA
        If flag_PMA_PMD_TYPE_SEL = &H0 Then write_PMA_PMD_TYPE_SEL_value = get_PMA_PMD_TYPE_SEL

        regValue = leftShift((write_PIASE_PMA_value and &H1), 9) + leftShift((write_PEASE_PMA_value and &H1), 8) + leftShift((write_PMA_PMD_TYPE_SEL_value and &H3f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PIASE_PMA_value = rightShift(data_low, 9) and &H1
        read_PEASE_PMA_value = rightShift(data_low, 8) and &H1
        PMA_PMD_TYPE_SEL_mask = &H3f
        if data_low > LONG_MAX then
            if PMA_PMD_TYPE_SEL_mask = mask then
                read_PMA_PMD_TYPE_SEL_value = data_low
            else
                read_PMA_PMD_TYPE_SEL_value = (data_low - H8000_0000) and PMA_PMD_TYPE_SEL_mask
            end If
        else
            read_PMA_PMD_TYPE_SEL_value = data_low and PMA_PMD_TYPE_SEL_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PIASE_PMA_value = &H0
        flag_PIASE_PMA        = &H0
        write_PEASE_PMA_value = &H0
        flag_PEASE_PMA        = &H0
        write_PMA_PMD_TYPE_SEL_value = &H0
        flag_PMA_PMD_TYPE_SEL        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV1_pmd_ieee_st2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DEVICE_PRESENT                             [15:14]          get_DEVICE_PRESENT
''                                                             set_DEVICE_PRESENT
''                                                             read_DEVICE_PRESENT
''                                                             write_DEVICE_PRESENT
''---------------------------------------------------------------------------------
'' TX_FAULT_ABILITY                           [13:13]          get_TX_FAULT_ABILITY
''                                                             set_TX_FAULT_ABILITY
''                                                             read_TX_FAULT_ABILITY
''                                                             write_TX_FAULT_ABILITY
''---------------------------------------------------------------------------------
'' RX_FAULT_ABILITY                           [12:12]          get_RX_FAULT_ABILITY
''                                                             set_RX_FAULT_ABILITY
''                                                             read_RX_FAULT_ABILITY
''                                                             write_RX_FAULT_ABILITY
''---------------------------------------------------------------------------------
'' TX_FAULT                                   [11:11]          get_TX_FAULT
''                                                             set_TX_FAULT
''                                                             read_TX_FAULT
''                                                             write_TX_FAULT
''---------------------------------------------------------------------------------
'' RX_FAULT                                   [10:10]          get_RX_FAULT
''                                                             set_RX_FAULT
''                                                             read_RX_FAULT
''                                                             write_RX_FAULT
''---------------------------------------------------------------------------------
'' EXTENDED_ABILITY                           [9:9]            get_EXTENDED_ABILITY
''                                                             set_EXTENDED_ABILITY
''                                                             read_EXTENDED_ABILITY
''                                                             write_EXTENDED_ABILITY
''---------------------------------------------------------------------------------
'' PMA_TX_DISABLE                             [8:8]            get_PMA_TX_DISABLE
''                                                             set_PMA_TX_DISABLE
''                                                             read_PMA_TX_DISABLE
''                                                             write_PMA_TX_DISABLE
''---------------------------------------------------------------------------------
'' PMA10GBASE_SR_ABILITY                      [7:7]            get_PMA10GBASE_SR_ABILITY
''                                                             set_PMA10GBASE_SR_ABILITY
''                                                             read_PMA10GBASE_SR_ABILITY
''                                                             write_PMA10GBASE_SR_ABILITY
''---------------------------------------------------------------------------------
'' PMA10GBASE_LR_ABILITY                      [6:6]            get_PMA10GBASE_LR_ABILITY
''                                                             set_PMA10GBASE_LR_ABILITY
''                                                             read_PMA10GBASE_LR_ABILITY
''                                                             write_PMA10GBASE_LR_ABILITY
''---------------------------------------------------------------------------------
'' PMA10GBASE_ER_ABILITY                      [5:5]            get_PMA10GBASE_ER_ABILITY
''                                                             set_PMA10GBASE_ER_ABILITY
''                                                             read_PMA10GBASE_ER_ABILITY
''                                                             write_PMA10GBASE_ER_ABILITY
''---------------------------------------------------------------------------------
'' PMA10GBASE_LX4_ABILITY                     [4:4]            get_PMA10GBASE_LX4_ABILITY
''                                                             set_PMA10GBASE_LX4_ABILITY
''                                                             read_PMA10GBASE_LX4_ABILITY
''                                                             write_PMA10GBASE_LX4_ABILITY
''---------------------------------------------------------------------------------
'' PMA10GBASE_SW_ABILITY                      [3:3]            get_PMA10GBASE_SW_ABILITY
''                                                             set_PMA10GBASE_SW_ABILITY
''                                                             read_PMA10GBASE_SW_ABILITY
''                                                             write_PMA10GBASE_SW_ABILITY
''---------------------------------------------------------------------------------
'' PMA10GBASE_LW_ABILITY                      [2:2]            get_PMA10GBASE_LW_ABILITY
''                                                             set_PMA10GBASE_LW_ABILITY
''                                                             read_PMA10GBASE_LW_ABILITY
''                                                             write_PMA10GBASE_LW_ABILITY
''---------------------------------------------------------------------------------
'' PMA10GBASE_EW_ABILITY                      [1:1]            get_PMA10GBASE_EW_ABILITY
''                                                             set_PMA10GBASE_EW_ABILITY
''                                                             read_PMA10GBASE_EW_ABILITY
''                                                             write_PMA10GBASE_EW_ABILITY
''---------------------------------------------------------------------------------
'' PMA_LOCAL_LOOPBACK                         [0:0]            get_PMA_LOCAL_LOOPBACK
''                                                             set_PMA_LOCAL_LOOPBACK
''                                                             read_PMA_LOCAL_LOOPBACK
''                                                             write_PMA_LOCAL_LOOPBACK
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV1_pmd_ieee_st2
    Private write_DEVICE_PRESENT_value
    Private read_DEVICE_PRESENT_value
    Private flag_DEVICE_PRESENT
    Private write_TX_FAULT_ABILITY_value
    Private read_TX_FAULT_ABILITY_value
    Private flag_TX_FAULT_ABILITY
    Private write_RX_FAULT_ABILITY_value
    Private read_RX_FAULT_ABILITY_value
    Private flag_RX_FAULT_ABILITY
    Private write_TX_FAULT_value
    Private read_TX_FAULT_value
    Private flag_TX_FAULT
    Private write_RX_FAULT_value
    Private read_RX_FAULT_value
    Private flag_RX_FAULT
    Private write_EXTENDED_ABILITY_value
    Private read_EXTENDED_ABILITY_value
    Private flag_EXTENDED_ABILITY
    Private write_PMA_TX_DISABLE_value
    Private read_PMA_TX_DISABLE_value
    Private flag_PMA_TX_DISABLE
    Private write_PMA10GBASE_SR_ABILITY_value
    Private read_PMA10GBASE_SR_ABILITY_value
    Private flag_PMA10GBASE_SR_ABILITY
    Private write_PMA10GBASE_LR_ABILITY_value
    Private read_PMA10GBASE_LR_ABILITY_value
    Private flag_PMA10GBASE_LR_ABILITY
    Private write_PMA10GBASE_ER_ABILITY_value
    Private read_PMA10GBASE_ER_ABILITY_value
    Private flag_PMA10GBASE_ER_ABILITY
    Private write_PMA10GBASE_LX4_ABILITY_value
    Private read_PMA10GBASE_LX4_ABILITY_value
    Private flag_PMA10GBASE_LX4_ABILITY
    Private write_PMA10GBASE_SW_ABILITY_value
    Private read_PMA10GBASE_SW_ABILITY_value
    Private flag_PMA10GBASE_SW_ABILITY
    Private write_PMA10GBASE_LW_ABILITY_value
    Private read_PMA10GBASE_LW_ABILITY_value
    Private flag_PMA10GBASE_LW_ABILITY
    Private write_PMA10GBASE_EW_ABILITY_value
    Private read_PMA10GBASE_EW_ABILITY_value
    Private flag_PMA10GBASE_EW_ABILITY
    Private write_PMA_LOCAL_LOOPBACK_value
    Private read_PMA_LOCAL_LOOPBACK_value
    Private flag_PMA_LOCAL_LOOPBACK

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

    Property Get get_DEVICE_PRESENT
        get_DEVICE_PRESENT = read_DEVICE_PRESENT_value
    End Property

    Property Let set_DEVICE_PRESENT(aData)
        write_DEVICE_PRESENT_value = aData
        flag_DEVICE_PRESENT        = &H1
    End Property

    Property Get read_DEVICE_PRESENT
        read
        read_DEVICE_PRESENT = read_DEVICE_PRESENT_value
    End Property

    Property Let write_DEVICE_PRESENT(aData)
        set_DEVICE_PRESENT = aData
        write
    End Property

    Property Get get_TX_FAULT_ABILITY
        get_TX_FAULT_ABILITY = read_TX_FAULT_ABILITY_value
    End Property

    Property Let set_TX_FAULT_ABILITY(aData)
        write_TX_FAULT_ABILITY_value = aData
        flag_TX_FAULT_ABILITY        = &H1
    End Property

    Property Get read_TX_FAULT_ABILITY
        read
        read_TX_FAULT_ABILITY = read_TX_FAULT_ABILITY_value
    End Property

    Property Let write_TX_FAULT_ABILITY(aData)
        set_TX_FAULT_ABILITY = aData
        write
    End Property

    Property Get get_RX_FAULT_ABILITY
        get_RX_FAULT_ABILITY = read_RX_FAULT_ABILITY_value
    End Property

    Property Let set_RX_FAULT_ABILITY(aData)
        write_RX_FAULT_ABILITY_value = aData
        flag_RX_FAULT_ABILITY        = &H1
    End Property

    Property Get read_RX_FAULT_ABILITY
        read
        read_RX_FAULT_ABILITY = read_RX_FAULT_ABILITY_value
    End Property

    Property Let write_RX_FAULT_ABILITY(aData)
        set_RX_FAULT_ABILITY = aData
        write
    End Property

    Property Get get_TX_FAULT
        get_TX_FAULT = read_TX_FAULT_value
    End Property

    Property Let set_TX_FAULT(aData)
        write_TX_FAULT_value = aData
        flag_TX_FAULT        = &H1
    End Property

    Property Get read_TX_FAULT
        read
        read_TX_FAULT = read_TX_FAULT_value
    End Property

    Property Let write_TX_FAULT(aData)
        set_TX_FAULT = aData
        write
    End Property

    Property Get get_RX_FAULT
        get_RX_FAULT = read_RX_FAULT_value
    End Property

    Property Let set_RX_FAULT(aData)
        write_RX_FAULT_value = aData
        flag_RX_FAULT        = &H1
    End Property

    Property Get read_RX_FAULT
        read
        read_RX_FAULT = read_RX_FAULT_value
    End Property

    Property Let write_RX_FAULT(aData)
        set_RX_FAULT = aData
        write
    End Property

    Property Get get_EXTENDED_ABILITY
        get_EXTENDED_ABILITY = read_EXTENDED_ABILITY_value
    End Property

    Property Let set_EXTENDED_ABILITY(aData)
        write_EXTENDED_ABILITY_value = aData
        flag_EXTENDED_ABILITY        = &H1
    End Property

    Property Get read_EXTENDED_ABILITY
        read
        read_EXTENDED_ABILITY = read_EXTENDED_ABILITY_value
    End Property

    Property Let write_EXTENDED_ABILITY(aData)
        set_EXTENDED_ABILITY = aData
        write
    End Property

    Property Get get_PMA_TX_DISABLE
        get_PMA_TX_DISABLE = read_PMA_TX_DISABLE_value
    End Property

    Property Let set_PMA_TX_DISABLE(aData)
        write_PMA_TX_DISABLE_value = aData
        flag_PMA_TX_DISABLE        = &H1
    End Property

    Property Get read_PMA_TX_DISABLE
        read
        read_PMA_TX_DISABLE = read_PMA_TX_DISABLE_value
    End Property

    Property Let write_PMA_TX_DISABLE(aData)
        set_PMA_TX_DISABLE = aData
        write
    End Property

    Property Get get_PMA10GBASE_SR_ABILITY
        get_PMA10GBASE_SR_ABILITY = read_PMA10GBASE_SR_ABILITY_value
    End Property

    Property Let set_PMA10GBASE_SR_ABILITY(aData)
        write_PMA10GBASE_SR_ABILITY_value = aData
        flag_PMA10GBASE_SR_ABILITY        = &H1
    End Property

    Property Get read_PMA10GBASE_SR_ABILITY
        read
        read_PMA10GBASE_SR_ABILITY = read_PMA10GBASE_SR_ABILITY_value
    End Property

    Property Let write_PMA10GBASE_SR_ABILITY(aData)
        set_PMA10GBASE_SR_ABILITY = aData
        write
    End Property

    Property Get get_PMA10GBASE_LR_ABILITY
        get_PMA10GBASE_LR_ABILITY = read_PMA10GBASE_LR_ABILITY_value
    End Property

    Property Let set_PMA10GBASE_LR_ABILITY(aData)
        write_PMA10GBASE_LR_ABILITY_value = aData
        flag_PMA10GBASE_LR_ABILITY        = &H1
    End Property

    Property Get read_PMA10GBASE_LR_ABILITY
        read
        read_PMA10GBASE_LR_ABILITY = read_PMA10GBASE_LR_ABILITY_value
    End Property

    Property Let write_PMA10GBASE_LR_ABILITY(aData)
        set_PMA10GBASE_LR_ABILITY = aData
        write
    End Property

    Property Get get_PMA10GBASE_ER_ABILITY
        get_PMA10GBASE_ER_ABILITY = read_PMA10GBASE_ER_ABILITY_value
    End Property

    Property Let set_PMA10GBASE_ER_ABILITY(aData)
        write_PMA10GBASE_ER_ABILITY_value = aData
        flag_PMA10GBASE_ER_ABILITY        = &H1
    End Property

    Property Get read_PMA10GBASE_ER_ABILITY
        read
        read_PMA10GBASE_ER_ABILITY = read_PMA10GBASE_ER_ABILITY_value
    End Property

    Property Let write_PMA10GBASE_ER_ABILITY(aData)
        set_PMA10GBASE_ER_ABILITY = aData
        write
    End Property

    Property Get get_PMA10GBASE_LX4_ABILITY
        get_PMA10GBASE_LX4_ABILITY = read_PMA10GBASE_LX4_ABILITY_value
    End Property

    Property Let set_PMA10GBASE_LX4_ABILITY(aData)
        write_PMA10GBASE_LX4_ABILITY_value = aData
        flag_PMA10GBASE_LX4_ABILITY        = &H1
    End Property

    Property Get read_PMA10GBASE_LX4_ABILITY
        read
        read_PMA10GBASE_LX4_ABILITY = read_PMA10GBASE_LX4_ABILITY_value
    End Property

    Property Let write_PMA10GBASE_LX4_ABILITY(aData)
        set_PMA10GBASE_LX4_ABILITY = aData
        write
    End Property

    Property Get get_PMA10GBASE_SW_ABILITY
        get_PMA10GBASE_SW_ABILITY = read_PMA10GBASE_SW_ABILITY_value
    End Property

    Property Let set_PMA10GBASE_SW_ABILITY(aData)
        write_PMA10GBASE_SW_ABILITY_value = aData
        flag_PMA10GBASE_SW_ABILITY        = &H1
    End Property

    Property Get read_PMA10GBASE_SW_ABILITY
        read
        read_PMA10GBASE_SW_ABILITY = read_PMA10GBASE_SW_ABILITY_value
    End Property

    Property Let write_PMA10GBASE_SW_ABILITY(aData)
        set_PMA10GBASE_SW_ABILITY = aData
        write
    End Property

    Property Get get_PMA10GBASE_LW_ABILITY
        get_PMA10GBASE_LW_ABILITY = read_PMA10GBASE_LW_ABILITY_value
    End Property

    Property Let set_PMA10GBASE_LW_ABILITY(aData)
        write_PMA10GBASE_LW_ABILITY_value = aData
        flag_PMA10GBASE_LW_ABILITY        = &H1
    End Property

    Property Get read_PMA10GBASE_LW_ABILITY
        read
        read_PMA10GBASE_LW_ABILITY = read_PMA10GBASE_LW_ABILITY_value
    End Property

    Property Let write_PMA10GBASE_LW_ABILITY(aData)
        set_PMA10GBASE_LW_ABILITY = aData
        write
    End Property

    Property Get get_PMA10GBASE_EW_ABILITY
        get_PMA10GBASE_EW_ABILITY = read_PMA10GBASE_EW_ABILITY_value
    End Property

    Property Let set_PMA10GBASE_EW_ABILITY(aData)
        write_PMA10GBASE_EW_ABILITY_value = aData
        flag_PMA10GBASE_EW_ABILITY        = &H1
    End Property

    Property Get read_PMA10GBASE_EW_ABILITY
        read
        read_PMA10GBASE_EW_ABILITY = read_PMA10GBASE_EW_ABILITY_value
    End Property

    Property Let write_PMA10GBASE_EW_ABILITY(aData)
        set_PMA10GBASE_EW_ABILITY = aData
        write
    End Property

    Property Get get_PMA_LOCAL_LOOPBACK
        get_PMA_LOCAL_LOOPBACK = read_PMA_LOCAL_LOOPBACK_value
    End Property

    Property Let set_PMA_LOCAL_LOOPBACK(aData)
        write_PMA_LOCAL_LOOPBACK_value = aData
        flag_PMA_LOCAL_LOOPBACK        = &H1
    End Property

    Property Get read_PMA_LOCAL_LOOPBACK
        read
        read_PMA_LOCAL_LOOPBACK = read_PMA_LOCAL_LOOPBACK_value
    End Property

    Property Let write_PMA_LOCAL_LOOPBACK(aData)
        set_PMA_LOCAL_LOOPBACK = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_DEVICE_PRESENT_value = rightShift(data_low, 14) and &H3
        read_TX_FAULT_ABILITY_value = rightShift(data_low, 13) and &H1
        read_RX_FAULT_ABILITY_value = rightShift(data_low, 12) and &H1
        read_TX_FAULT_value = rightShift(data_low, 11) and &H1
        read_RX_FAULT_value = rightShift(data_low, 10) and &H1
        read_EXTENDED_ABILITY_value = rightShift(data_low, 9) and &H1
        read_PMA_TX_DISABLE_value = rightShift(data_low, 8) and &H1
        read_PMA10GBASE_SR_ABILITY_value = rightShift(data_low, 7) and &H1
        read_PMA10GBASE_LR_ABILITY_value = rightShift(data_low, 6) and &H1
        read_PMA10GBASE_ER_ABILITY_value = rightShift(data_low, 5) and &H1
        read_PMA10GBASE_LX4_ABILITY_value = rightShift(data_low, 4) and &H1
        read_PMA10GBASE_SW_ABILITY_value = rightShift(data_low, 3) and &H1
        read_PMA10GBASE_LW_ABILITY_value = rightShift(data_low, 2) and &H1
        read_PMA10GBASE_EW_ABILITY_value = rightShift(data_low, 1) and &H1
        PMA_LOCAL_LOOPBACK_mask = &H1
        if data_low > LONG_MAX then
            if PMA_LOCAL_LOOPBACK_mask = mask then
                read_PMA_LOCAL_LOOPBACK_value = data_low
            else
                read_PMA_LOCAL_LOOPBACK_value = (data_low - H8000_0000) and PMA_LOCAL_LOOPBACK_mask
            end If
        else
            read_PMA_LOCAL_LOOPBACK_value = data_low and PMA_LOCAL_LOOPBACK_mask
        end If

    End Sub

    Sub write
        If flag_DEVICE_PRESENT = &H0 or flag_TX_FAULT_ABILITY = &H0 or flag_RX_FAULT_ABILITY = &H0 or flag_TX_FAULT = &H0 or flag_RX_FAULT = &H0 or flag_EXTENDED_ABILITY = &H0 or flag_PMA_TX_DISABLE = &H0 or flag_PMA10GBASE_SR_ABILITY = &H0 or flag_PMA10GBASE_LR_ABILITY = &H0 or flag_PMA10GBASE_ER_ABILITY = &H0 or flag_PMA10GBASE_LX4_ABILITY = &H0 or flag_PMA10GBASE_SW_ABILITY = &H0 or flag_PMA10GBASE_LW_ABILITY = &H0 or flag_PMA10GBASE_EW_ABILITY = &H0 or flag_PMA_LOCAL_LOOPBACK = &H0 Then read
        If flag_DEVICE_PRESENT = &H0 Then write_DEVICE_PRESENT_value = get_DEVICE_PRESENT
        If flag_TX_FAULT_ABILITY = &H0 Then write_TX_FAULT_ABILITY_value = get_TX_FAULT_ABILITY
        If flag_RX_FAULT_ABILITY = &H0 Then write_RX_FAULT_ABILITY_value = get_RX_FAULT_ABILITY
        If flag_TX_FAULT = &H0 Then write_TX_FAULT_value = get_TX_FAULT
        If flag_RX_FAULT = &H0 Then write_RX_FAULT_value = get_RX_FAULT
        If flag_EXTENDED_ABILITY = &H0 Then write_EXTENDED_ABILITY_value = get_EXTENDED_ABILITY
        If flag_PMA_TX_DISABLE = &H0 Then write_PMA_TX_DISABLE_value = get_PMA_TX_DISABLE
        If flag_PMA10GBASE_SR_ABILITY = &H0 Then write_PMA10GBASE_SR_ABILITY_value = get_PMA10GBASE_SR_ABILITY
        If flag_PMA10GBASE_LR_ABILITY = &H0 Then write_PMA10GBASE_LR_ABILITY_value = get_PMA10GBASE_LR_ABILITY
        If flag_PMA10GBASE_ER_ABILITY = &H0 Then write_PMA10GBASE_ER_ABILITY_value = get_PMA10GBASE_ER_ABILITY
        If flag_PMA10GBASE_LX4_ABILITY = &H0 Then write_PMA10GBASE_LX4_ABILITY_value = get_PMA10GBASE_LX4_ABILITY
        If flag_PMA10GBASE_SW_ABILITY = &H0 Then write_PMA10GBASE_SW_ABILITY_value = get_PMA10GBASE_SW_ABILITY
        If flag_PMA10GBASE_LW_ABILITY = &H0 Then write_PMA10GBASE_LW_ABILITY_value = get_PMA10GBASE_LW_ABILITY
        If flag_PMA10GBASE_EW_ABILITY = &H0 Then write_PMA10GBASE_EW_ABILITY_value = get_PMA10GBASE_EW_ABILITY
        If flag_PMA_LOCAL_LOOPBACK = &H0 Then write_PMA_LOCAL_LOOPBACK_value = get_PMA_LOCAL_LOOPBACK

        regValue = leftShift((write_DEVICE_PRESENT_value and &H3), 14) + leftShift((write_TX_FAULT_ABILITY_value and &H1), 13) + leftShift((write_RX_FAULT_ABILITY_value and &H1), 12) + leftShift((write_TX_FAULT_value and &H1), 11) + leftShift((write_RX_FAULT_value and &H1), 10) + leftShift((write_EXTENDED_ABILITY_value and &H1), 9) + leftShift((write_PMA_TX_DISABLE_value and &H1), 8) + leftShift((write_PMA10GBASE_SR_ABILITY_value and &H1), 7) + leftShift((write_PMA10GBASE_LR_ABILITY_value and &H1), 6) + leftShift((write_PMA10GBASE_ER_ABILITY_value and &H1), 5) + leftShift((write_PMA10GBASE_LX4_ABILITY_value and &H1), 4) + leftShift((write_PMA10GBASE_SW_ABILITY_value and &H1), 3) + leftShift((write_PMA10GBASE_LW_ABILITY_value and &H1), 2) + leftShift((write_PMA10GBASE_EW_ABILITY_value and &H1), 1) + leftShift((write_PMA_LOCAL_LOOPBACK_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_DEVICE_PRESENT_value = rightShift(data_low, 14) and &H3
        read_TX_FAULT_ABILITY_value = rightShift(data_low, 13) and &H1
        read_RX_FAULT_ABILITY_value = rightShift(data_low, 12) and &H1
        read_TX_FAULT_value = rightShift(data_low, 11) and &H1
        read_RX_FAULT_value = rightShift(data_low, 10) and &H1
        read_EXTENDED_ABILITY_value = rightShift(data_low, 9) and &H1
        read_PMA_TX_DISABLE_value = rightShift(data_low, 8) and &H1
        read_PMA10GBASE_SR_ABILITY_value = rightShift(data_low, 7) and &H1
        read_PMA10GBASE_LR_ABILITY_value = rightShift(data_low, 6) and &H1
        read_PMA10GBASE_ER_ABILITY_value = rightShift(data_low, 5) and &H1
        read_PMA10GBASE_LX4_ABILITY_value = rightShift(data_low, 4) and &H1
        read_PMA10GBASE_SW_ABILITY_value = rightShift(data_low, 3) and &H1
        read_PMA10GBASE_LW_ABILITY_value = rightShift(data_low, 2) and &H1
        read_PMA10GBASE_EW_ABILITY_value = rightShift(data_low, 1) and &H1
        PMA_LOCAL_LOOPBACK_mask = &H1
        if data_low > LONG_MAX then
            if PMA_LOCAL_LOOPBACK_mask = mask then
                read_PMA_LOCAL_LOOPBACK_value = data_low
            else
                read_PMA_LOCAL_LOOPBACK_value = (data_low - H8000_0000) and PMA_LOCAL_LOOPBACK_mask
            end If
        else
            read_PMA_LOCAL_LOOPBACK_value = data_low and PMA_LOCAL_LOOPBACK_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DEVICE_PRESENT_value = &H0
        flag_DEVICE_PRESENT        = &H0
        write_TX_FAULT_ABILITY_value = &H0
        flag_TX_FAULT_ABILITY        = &H0
        write_RX_FAULT_ABILITY_value = &H0
        flag_RX_FAULT_ABILITY        = &H0
        write_TX_FAULT_value = &H0
        flag_TX_FAULT        = &H0
        write_RX_FAULT_value = &H0
        flag_RX_FAULT        = &H0
        write_EXTENDED_ABILITY_value = &H0
        flag_EXTENDED_ABILITY        = &H0
        write_PMA_TX_DISABLE_value = &H0
        flag_PMA_TX_DISABLE        = &H0
        write_PMA10GBASE_SR_ABILITY_value = &H0
        flag_PMA10GBASE_SR_ABILITY        = &H0
        write_PMA10GBASE_LR_ABILITY_value = &H0
        flag_PMA10GBASE_LR_ABILITY        = &H0
        write_PMA10GBASE_ER_ABILITY_value = &H0
        flag_PMA10GBASE_ER_ABILITY        = &H0
        write_PMA10GBASE_LX4_ABILITY_value = &H0
        flag_PMA10GBASE_LX4_ABILITY        = &H0
        write_PMA10GBASE_SW_ABILITY_value = &H0
        flag_PMA10GBASE_SW_ABILITY        = &H0
        write_PMA10GBASE_LW_ABILITY_value = &H0
        flag_PMA10GBASE_LW_ABILITY        = &H0
        write_PMA10GBASE_EW_ABILITY_value = &H0
        flag_PMA10GBASE_EW_ABILITY        = &H0
        write_PMA_LOCAL_LOOPBACK_value = &H0
        flag_PMA_LOCAL_LOOPBACK        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV1_pmd_ieee_tx_disable
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Reserved                                   [15:11]          get_Reserved
''                                                             set_Reserved
''                                                             read_Reserved
''                                                             write_Reserved
''---------------------------------------------------------------------------------
'' PMA_TX_DISABLE_9                           [10:10]          get_PMA_TX_DISABLE_9
''                                                             set_PMA_TX_DISABLE_9
''                                                             read_PMA_TX_DISABLE_9
''                                                             write_PMA_TX_DISABLE_9
''---------------------------------------------------------------------------------
'' PMA_TX_DISABLE_8                           [9:9]            get_PMA_TX_DISABLE_8
''                                                             set_PMA_TX_DISABLE_8
''                                                             read_PMA_TX_DISABLE_8
''                                                             write_PMA_TX_DISABLE_8
''---------------------------------------------------------------------------------
'' PMA_TX_DISABLE_7                           [8:8]            get_PMA_TX_DISABLE_7
''                                                             set_PMA_TX_DISABLE_7
''                                                             read_PMA_TX_DISABLE_7
''                                                             write_PMA_TX_DISABLE_7
''---------------------------------------------------------------------------------
'' PMA_TX_DISABLE_6                           [7:7]            get_PMA_TX_DISABLE_6
''                                                             set_PMA_TX_DISABLE_6
''                                                             read_PMA_TX_DISABLE_6
''                                                             write_PMA_TX_DISABLE_6
''---------------------------------------------------------------------------------
'' PMA_TX_DISABLE_5                           [6:6]            get_PMA_TX_DISABLE_5
''                                                             set_PMA_TX_DISABLE_5
''                                                             read_PMA_TX_DISABLE_5
''                                                             write_PMA_TX_DISABLE_5
''---------------------------------------------------------------------------------
'' PMA_TX_DISABLE_4                           [5:5]            get_PMA_TX_DISABLE_4
''                                                             set_PMA_TX_DISABLE_4
''                                                             read_PMA_TX_DISABLE_4
''                                                             write_PMA_TX_DISABLE_4
''---------------------------------------------------------------------------------
'' PMA_TX_DISABLE_3                           [4:4]            get_PMA_TX_DISABLE_3
''                                                             set_PMA_TX_DISABLE_3
''                                                             read_PMA_TX_DISABLE_3
''                                                             write_PMA_TX_DISABLE_3
''---------------------------------------------------------------------------------
'' PMA_TX_DISABLE_2                           [3:3]            get_PMA_TX_DISABLE_2
''                                                             set_PMA_TX_DISABLE_2
''                                                             read_PMA_TX_DISABLE_2
''                                                             write_PMA_TX_DISABLE_2
''---------------------------------------------------------------------------------
'' PMA_TX_DISABLE_1                           [2:2]            get_PMA_TX_DISABLE_1
''                                                             set_PMA_TX_DISABLE_1
''                                                             read_PMA_TX_DISABLE_1
''                                                             write_PMA_TX_DISABLE_1
''---------------------------------------------------------------------------------
'' PMA_TX_DISABLE_0                           [1:1]            get_PMA_TX_DISABLE_0
''                                                             set_PMA_TX_DISABLE_0
''                                                             read_PMA_TX_DISABLE_0
''                                                             write_PMA_TX_DISABLE_0
''---------------------------------------------------------------------------------
'' PMA_TX_DISABLE_GLB                         [0:0]            get_PMA_TX_DISABLE_GLB
''                                                             set_PMA_TX_DISABLE_GLB
''                                                             read_PMA_TX_DISABLE_GLB
''                                                             write_PMA_TX_DISABLE_GLB
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV1_pmd_ieee_tx_disable
    Private write_Reserved_value
    Private read_Reserved_value
    Private flag_Reserved
    Private write_PMA_TX_DISABLE_9_value
    Private read_PMA_TX_DISABLE_9_value
    Private flag_PMA_TX_DISABLE_9
    Private write_PMA_TX_DISABLE_8_value
    Private read_PMA_TX_DISABLE_8_value
    Private flag_PMA_TX_DISABLE_8
    Private write_PMA_TX_DISABLE_7_value
    Private read_PMA_TX_DISABLE_7_value
    Private flag_PMA_TX_DISABLE_7
    Private write_PMA_TX_DISABLE_6_value
    Private read_PMA_TX_DISABLE_6_value
    Private flag_PMA_TX_DISABLE_6
    Private write_PMA_TX_DISABLE_5_value
    Private read_PMA_TX_DISABLE_5_value
    Private flag_PMA_TX_DISABLE_5
    Private write_PMA_TX_DISABLE_4_value
    Private read_PMA_TX_DISABLE_4_value
    Private flag_PMA_TX_DISABLE_4
    Private write_PMA_TX_DISABLE_3_value
    Private read_PMA_TX_DISABLE_3_value
    Private flag_PMA_TX_DISABLE_3
    Private write_PMA_TX_DISABLE_2_value
    Private read_PMA_TX_DISABLE_2_value
    Private flag_PMA_TX_DISABLE_2
    Private write_PMA_TX_DISABLE_1_value
    Private read_PMA_TX_DISABLE_1_value
    Private flag_PMA_TX_DISABLE_1
    Private write_PMA_TX_DISABLE_0_value
    Private read_PMA_TX_DISABLE_0_value
    Private flag_PMA_TX_DISABLE_0
    Private write_PMA_TX_DISABLE_GLB_value
    Private read_PMA_TX_DISABLE_GLB_value
    Private flag_PMA_TX_DISABLE_GLB

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

    Property Get get_Reserved
        get_Reserved = read_Reserved_value
    End Property

    Property Let set_Reserved(aData)
        write_Reserved_value = aData
        flag_Reserved        = &H1
    End Property

    Property Get read_Reserved
        read
        read_Reserved = read_Reserved_value
    End Property

    Property Let write_Reserved(aData)
        set_Reserved = aData
        write
    End Property

    Property Get get_PMA_TX_DISABLE_9
        get_PMA_TX_DISABLE_9 = read_PMA_TX_DISABLE_9_value
    End Property

    Property Let set_PMA_TX_DISABLE_9(aData)
        write_PMA_TX_DISABLE_9_value = aData
        flag_PMA_TX_DISABLE_9        = &H1
    End Property

    Property Get read_PMA_TX_DISABLE_9
        read
        read_PMA_TX_DISABLE_9 = read_PMA_TX_DISABLE_9_value
    End Property

    Property Let write_PMA_TX_DISABLE_9(aData)
        set_PMA_TX_DISABLE_9 = aData
        write
    End Property

    Property Get get_PMA_TX_DISABLE_8
        get_PMA_TX_DISABLE_8 = read_PMA_TX_DISABLE_8_value
    End Property

    Property Let set_PMA_TX_DISABLE_8(aData)
        write_PMA_TX_DISABLE_8_value = aData
        flag_PMA_TX_DISABLE_8        = &H1
    End Property

    Property Get read_PMA_TX_DISABLE_8
        read
        read_PMA_TX_DISABLE_8 = read_PMA_TX_DISABLE_8_value
    End Property

    Property Let write_PMA_TX_DISABLE_8(aData)
        set_PMA_TX_DISABLE_8 = aData
        write
    End Property

    Property Get get_PMA_TX_DISABLE_7
        get_PMA_TX_DISABLE_7 = read_PMA_TX_DISABLE_7_value
    End Property

    Property Let set_PMA_TX_DISABLE_7(aData)
        write_PMA_TX_DISABLE_7_value = aData
        flag_PMA_TX_DISABLE_7        = &H1
    End Property

    Property Get read_PMA_TX_DISABLE_7
        read
        read_PMA_TX_DISABLE_7 = read_PMA_TX_DISABLE_7_value
    End Property

    Property Let write_PMA_TX_DISABLE_7(aData)
        set_PMA_TX_DISABLE_7 = aData
        write
    End Property

    Property Get get_PMA_TX_DISABLE_6
        get_PMA_TX_DISABLE_6 = read_PMA_TX_DISABLE_6_value
    End Property

    Property Let set_PMA_TX_DISABLE_6(aData)
        write_PMA_TX_DISABLE_6_value = aData
        flag_PMA_TX_DISABLE_6        = &H1
    End Property

    Property Get read_PMA_TX_DISABLE_6
        read
        read_PMA_TX_DISABLE_6 = read_PMA_TX_DISABLE_6_value
    End Property

    Property Let write_PMA_TX_DISABLE_6(aData)
        set_PMA_TX_DISABLE_6 = aData
        write
    End Property

    Property Get get_PMA_TX_DISABLE_5
        get_PMA_TX_DISABLE_5 = read_PMA_TX_DISABLE_5_value
    End Property

    Property Let set_PMA_TX_DISABLE_5(aData)
        write_PMA_TX_DISABLE_5_value = aData
        flag_PMA_TX_DISABLE_5        = &H1
    End Property

    Property Get read_PMA_TX_DISABLE_5
        read
        read_PMA_TX_DISABLE_5 = read_PMA_TX_DISABLE_5_value
    End Property

    Property Let write_PMA_TX_DISABLE_5(aData)
        set_PMA_TX_DISABLE_5 = aData
        write
    End Property

    Property Get get_PMA_TX_DISABLE_4
        get_PMA_TX_DISABLE_4 = read_PMA_TX_DISABLE_4_value
    End Property

    Property Let set_PMA_TX_DISABLE_4(aData)
        write_PMA_TX_DISABLE_4_value = aData
        flag_PMA_TX_DISABLE_4        = &H1
    End Property

    Property Get read_PMA_TX_DISABLE_4
        read
        read_PMA_TX_DISABLE_4 = read_PMA_TX_DISABLE_4_value
    End Property

    Property Let write_PMA_TX_DISABLE_4(aData)
        set_PMA_TX_DISABLE_4 = aData
        write
    End Property

    Property Get get_PMA_TX_DISABLE_3
        get_PMA_TX_DISABLE_3 = read_PMA_TX_DISABLE_3_value
    End Property

    Property Let set_PMA_TX_DISABLE_3(aData)
        write_PMA_TX_DISABLE_3_value = aData
        flag_PMA_TX_DISABLE_3        = &H1
    End Property

    Property Get read_PMA_TX_DISABLE_3
        read
        read_PMA_TX_DISABLE_3 = read_PMA_TX_DISABLE_3_value
    End Property

    Property Let write_PMA_TX_DISABLE_3(aData)
        set_PMA_TX_DISABLE_3 = aData
        write
    End Property

    Property Get get_PMA_TX_DISABLE_2
        get_PMA_TX_DISABLE_2 = read_PMA_TX_DISABLE_2_value
    End Property

    Property Let set_PMA_TX_DISABLE_2(aData)
        write_PMA_TX_DISABLE_2_value = aData
        flag_PMA_TX_DISABLE_2        = &H1
    End Property

    Property Get read_PMA_TX_DISABLE_2
        read
        read_PMA_TX_DISABLE_2 = read_PMA_TX_DISABLE_2_value
    End Property

    Property Let write_PMA_TX_DISABLE_2(aData)
        set_PMA_TX_DISABLE_2 = aData
        write
    End Property

    Property Get get_PMA_TX_DISABLE_1
        get_PMA_TX_DISABLE_1 = read_PMA_TX_DISABLE_1_value
    End Property

    Property Let set_PMA_TX_DISABLE_1(aData)
        write_PMA_TX_DISABLE_1_value = aData
        flag_PMA_TX_DISABLE_1        = &H1
    End Property

    Property Get read_PMA_TX_DISABLE_1
        read
        read_PMA_TX_DISABLE_1 = read_PMA_TX_DISABLE_1_value
    End Property

    Property Let write_PMA_TX_DISABLE_1(aData)
        set_PMA_TX_DISABLE_1 = aData
        write
    End Property

    Property Get get_PMA_TX_DISABLE_0
        get_PMA_TX_DISABLE_0 = read_PMA_TX_DISABLE_0_value
    End Property

    Property Let set_PMA_TX_DISABLE_0(aData)
        write_PMA_TX_DISABLE_0_value = aData
        flag_PMA_TX_DISABLE_0        = &H1
    End Property

    Property Get read_PMA_TX_DISABLE_0
        read
        read_PMA_TX_DISABLE_0 = read_PMA_TX_DISABLE_0_value
    End Property

    Property Let write_PMA_TX_DISABLE_0(aData)
        set_PMA_TX_DISABLE_0 = aData
        write
    End Property

    Property Get get_PMA_TX_DISABLE_GLB
        get_PMA_TX_DISABLE_GLB = read_PMA_TX_DISABLE_GLB_value
    End Property

    Property Let set_PMA_TX_DISABLE_GLB(aData)
        write_PMA_TX_DISABLE_GLB_value = aData
        flag_PMA_TX_DISABLE_GLB        = &H1
    End Property

    Property Get read_PMA_TX_DISABLE_GLB
        read
        read_PMA_TX_DISABLE_GLB = read_PMA_TX_DISABLE_GLB_value
    End Property

    Property Let write_PMA_TX_DISABLE_GLB(aData)
        set_PMA_TX_DISABLE_GLB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Reserved_value = rightShift(data_low, 11) and &H1f
        read_PMA_TX_DISABLE_9_value = rightShift(data_low, 10) and &H1
        read_PMA_TX_DISABLE_8_value = rightShift(data_low, 9) and &H1
        read_PMA_TX_DISABLE_7_value = rightShift(data_low, 8) and &H1
        read_PMA_TX_DISABLE_6_value = rightShift(data_low, 7) and &H1
        read_PMA_TX_DISABLE_5_value = rightShift(data_low, 6) and &H1
        read_PMA_TX_DISABLE_4_value = rightShift(data_low, 5) and &H1
        read_PMA_TX_DISABLE_3_value = rightShift(data_low, 4) and &H1
        read_PMA_TX_DISABLE_2_value = rightShift(data_low, 3) and &H1
        read_PMA_TX_DISABLE_1_value = rightShift(data_low, 2) and &H1
        read_PMA_TX_DISABLE_0_value = rightShift(data_low, 1) and &H1
        PMA_TX_DISABLE_GLB_mask = &H1
        if data_low > LONG_MAX then
            if PMA_TX_DISABLE_GLB_mask = mask then
                read_PMA_TX_DISABLE_GLB_value = data_low
            else
                read_PMA_TX_DISABLE_GLB_value = (data_low - H8000_0000) and PMA_TX_DISABLE_GLB_mask
            end If
        else
            read_PMA_TX_DISABLE_GLB_value = data_low and PMA_TX_DISABLE_GLB_mask
        end If

    End Sub

    Sub write
        If flag_Reserved = &H0 or flag_PMA_TX_DISABLE_9 = &H0 or flag_PMA_TX_DISABLE_8 = &H0 or flag_PMA_TX_DISABLE_7 = &H0 or flag_PMA_TX_DISABLE_6 = &H0 or flag_PMA_TX_DISABLE_5 = &H0 or flag_PMA_TX_DISABLE_4 = &H0 or flag_PMA_TX_DISABLE_3 = &H0 or flag_PMA_TX_DISABLE_2 = &H0 or flag_PMA_TX_DISABLE_1 = &H0 or flag_PMA_TX_DISABLE_0 = &H0 or flag_PMA_TX_DISABLE_GLB = &H0 Then read
        If flag_Reserved = &H0 Then write_Reserved_value = get_Reserved
        If flag_PMA_TX_DISABLE_9 = &H0 Then write_PMA_TX_DISABLE_9_value = get_PMA_TX_DISABLE_9
        If flag_PMA_TX_DISABLE_8 = &H0 Then write_PMA_TX_DISABLE_8_value = get_PMA_TX_DISABLE_8
        If flag_PMA_TX_DISABLE_7 = &H0 Then write_PMA_TX_DISABLE_7_value = get_PMA_TX_DISABLE_7
        If flag_PMA_TX_DISABLE_6 = &H0 Then write_PMA_TX_DISABLE_6_value = get_PMA_TX_DISABLE_6
        If flag_PMA_TX_DISABLE_5 = &H0 Then write_PMA_TX_DISABLE_5_value = get_PMA_TX_DISABLE_5
        If flag_PMA_TX_DISABLE_4 = &H0 Then write_PMA_TX_DISABLE_4_value = get_PMA_TX_DISABLE_4
        If flag_PMA_TX_DISABLE_3 = &H0 Then write_PMA_TX_DISABLE_3_value = get_PMA_TX_DISABLE_3
        If flag_PMA_TX_DISABLE_2 = &H0 Then write_PMA_TX_DISABLE_2_value = get_PMA_TX_DISABLE_2
        If flag_PMA_TX_DISABLE_1 = &H0 Then write_PMA_TX_DISABLE_1_value = get_PMA_TX_DISABLE_1
        If flag_PMA_TX_DISABLE_0 = &H0 Then write_PMA_TX_DISABLE_0_value = get_PMA_TX_DISABLE_0
        If flag_PMA_TX_DISABLE_GLB = &H0 Then write_PMA_TX_DISABLE_GLB_value = get_PMA_TX_DISABLE_GLB

        regValue = leftShift((write_Reserved_value and &H1f), 11) + leftShift((write_PMA_TX_DISABLE_9_value and &H1), 10) + leftShift((write_PMA_TX_DISABLE_8_value and &H1), 9) + leftShift((write_PMA_TX_DISABLE_7_value and &H1), 8) + leftShift((write_PMA_TX_DISABLE_6_value and &H1), 7) + leftShift((write_PMA_TX_DISABLE_5_value and &H1), 6) + leftShift((write_PMA_TX_DISABLE_4_value and &H1), 5) + leftShift((write_PMA_TX_DISABLE_3_value and &H1), 4) + leftShift((write_PMA_TX_DISABLE_2_value and &H1), 3) + leftShift((write_PMA_TX_DISABLE_1_value and &H1), 2) + leftShift((write_PMA_TX_DISABLE_0_value and &H1), 1) + leftShift((write_PMA_TX_DISABLE_GLB_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Reserved_value = rightShift(data_low, 11) and &H1f
        read_PMA_TX_DISABLE_9_value = rightShift(data_low, 10) and &H1
        read_PMA_TX_DISABLE_8_value = rightShift(data_low, 9) and &H1
        read_PMA_TX_DISABLE_7_value = rightShift(data_low, 8) and &H1
        read_PMA_TX_DISABLE_6_value = rightShift(data_low, 7) and &H1
        read_PMA_TX_DISABLE_5_value = rightShift(data_low, 6) and &H1
        read_PMA_TX_DISABLE_4_value = rightShift(data_low, 5) and &H1
        read_PMA_TX_DISABLE_3_value = rightShift(data_low, 4) and &H1
        read_PMA_TX_DISABLE_2_value = rightShift(data_low, 3) and &H1
        read_PMA_TX_DISABLE_1_value = rightShift(data_low, 2) and &H1
        read_PMA_TX_DISABLE_0_value = rightShift(data_low, 1) and &H1
        PMA_TX_DISABLE_GLB_mask = &H1
        if data_low > LONG_MAX then
            if PMA_TX_DISABLE_GLB_mask = mask then
                read_PMA_TX_DISABLE_GLB_value = data_low
            else
                read_PMA_TX_DISABLE_GLB_value = (data_low - H8000_0000) and PMA_TX_DISABLE_GLB_mask
            end If
        else
            read_PMA_TX_DISABLE_GLB_value = data_low and PMA_TX_DISABLE_GLB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Reserved_value = &H0
        flag_Reserved        = &H0
        write_PMA_TX_DISABLE_9_value = &H0
        flag_PMA_TX_DISABLE_9        = &H0
        write_PMA_TX_DISABLE_8_value = &H0
        flag_PMA_TX_DISABLE_8        = &H0
        write_PMA_TX_DISABLE_7_value = &H0
        flag_PMA_TX_DISABLE_7        = &H0
        write_PMA_TX_DISABLE_6_value = &H0
        flag_PMA_TX_DISABLE_6        = &H0
        write_PMA_TX_DISABLE_5_value = &H0
        flag_PMA_TX_DISABLE_5        = &H0
        write_PMA_TX_DISABLE_4_value = &H0
        flag_PMA_TX_DISABLE_4        = &H0
        write_PMA_TX_DISABLE_3_value = &H0
        flag_PMA_TX_DISABLE_3        = &H0
        write_PMA_TX_DISABLE_2_value = &H0
        flag_PMA_TX_DISABLE_2        = &H0
        write_PMA_TX_DISABLE_1_value = &H0
        flag_PMA_TX_DISABLE_1        = &H0
        write_PMA_TX_DISABLE_0_value = &H0
        flag_PMA_TX_DISABLE_0        = &H0
        write_PMA_TX_DISABLE_GLB_value = &H0
        flag_PMA_TX_DISABLE_GLB        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV1_pmd_ieee_rx_sigdet
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Reserved                                   [15:11]          get_Reserved
''                                                             set_Reserved
''                                                             read_Reserved
''                                                             write_Reserved
''---------------------------------------------------------------------------------
'' PMD_RX_SIGDET_9                            [10:10]          get_PMD_RX_SIGDET_9
''                                                             set_PMD_RX_SIGDET_9
''                                                             read_PMD_RX_SIGDET_9
''                                                             write_PMD_RX_SIGDET_9
''---------------------------------------------------------------------------------
'' PMD_RX_SIGDET_8                            [9:9]            get_PMD_RX_SIGDET_8
''                                                             set_PMD_RX_SIGDET_8
''                                                             read_PMD_RX_SIGDET_8
''                                                             write_PMD_RX_SIGDET_8
''---------------------------------------------------------------------------------
'' PMD_RX_SIGDET_7                            [8:8]            get_PMD_RX_SIGDET_7
''                                                             set_PMD_RX_SIGDET_7
''                                                             read_PMD_RX_SIGDET_7
''                                                             write_PMD_RX_SIGDET_7
''---------------------------------------------------------------------------------
'' PMD_RX_SIGDET_6                            [7:7]            get_PMD_RX_SIGDET_6
''                                                             set_PMD_RX_SIGDET_6
''                                                             read_PMD_RX_SIGDET_6
''                                                             write_PMD_RX_SIGDET_6
''---------------------------------------------------------------------------------
'' PMD_RX_SIGDET_5                            [6:6]            get_PMD_RX_SIGDET_5
''                                                             set_PMD_RX_SIGDET_5
''                                                             read_PMD_RX_SIGDET_5
''                                                             write_PMD_RX_SIGDET_5
''---------------------------------------------------------------------------------
'' PMD_RX_SIGDET_4                            [5:5]            get_PMD_RX_SIGDET_4
''                                                             set_PMD_RX_SIGDET_4
''                                                             read_PMD_RX_SIGDET_4
''                                                             write_PMD_RX_SIGDET_4
''---------------------------------------------------------------------------------
'' PMD_RX_SIGDET_3                            [4:4]            get_PMD_RX_SIGDET_3
''                                                             set_PMD_RX_SIGDET_3
''                                                             read_PMD_RX_SIGDET_3
''                                                             write_PMD_RX_SIGDET_3
''---------------------------------------------------------------------------------
'' PMD_RX_SIGDET_2                            [3:3]            get_PMD_RX_SIGDET_2
''                                                             set_PMD_RX_SIGDET_2
''                                                             read_PMD_RX_SIGDET_2
''                                                             write_PMD_RX_SIGDET_2
''---------------------------------------------------------------------------------
'' PMD_RX_SIGDET_1                            [2:2]            get_PMD_RX_SIGDET_1
''                                                             set_PMD_RX_SIGDET_1
''                                                             read_PMD_RX_SIGDET_1
''                                                             write_PMD_RX_SIGDET_1
''---------------------------------------------------------------------------------
'' PMD_RX_SIGDET_0                            [1:1]            get_PMD_RX_SIGDET_0
''                                                             set_PMD_RX_SIGDET_0
''                                                             read_PMD_RX_SIGDET_0
''                                                             write_PMD_RX_SIGDET_0
''---------------------------------------------------------------------------------
'' PMD_RX_SIGDET_GLB                          [0:0]            get_PMD_RX_SIGDET_GLB
''                                                             set_PMD_RX_SIGDET_GLB
''                                                             read_PMD_RX_SIGDET_GLB
''                                                             write_PMD_RX_SIGDET_GLB
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV1_pmd_ieee_rx_sigdet
    Private write_Reserved_value
    Private read_Reserved_value
    Private flag_Reserved
    Private write_PMD_RX_SIGDET_9_value
    Private read_PMD_RX_SIGDET_9_value
    Private flag_PMD_RX_SIGDET_9
    Private write_PMD_RX_SIGDET_8_value
    Private read_PMD_RX_SIGDET_8_value
    Private flag_PMD_RX_SIGDET_8
    Private write_PMD_RX_SIGDET_7_value
    Private read_PMD_RX_SIGDET_7_value
    Private flag_PMD_RX_SIGDET_7
    Private write_PMD_RX_SIGDET_6_value
    Private read_PMD_RX_SIGDET_6_value
    Private flag_PMD_RX_SIGDET_6
    Private write_PMD_RX_SIGDET_5_value
    Private read_PMD_RX_SIGDET_5_value
    Private flag_PMD_RX_SIGDET_5
    Private write_PMD_RX_SIGDET_4_value
    Private read_PMD_RX_SIGDET_4_value
    Private flag_PMD_RX_SIGDET_4
    Private write_PMD_RX_SIGDET_3_value
    Private read_PMD_RX_SIGDET_3_value
    Private flag_PMD_RX_SIGDET_3
    Private write_PMD_RX_SIGDET_2_value
    Private read_PMD_RX_SIGDET_2_value
    Private flag_PMD_RX_SIGDET_2
    Private write_PMD_RX_SIGDET_1_value
    Private read_PMD_RX_SIGDET_1_value
    Private flag_PMD_RX_SIGDET_1
    Private write_PMD_RX_SIGDET_0_value
    Private read_PMD_RX_SIGDET_0_value
    Private flag_PMD_RX_SIGDET_0
    Private write_PMD_RX_SIGDET_GLB_value
    Private read_PMD_RX_SIGDET_GLB_value
    Private flag_PMD_RX_SIGDET_GLB

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

    Property Get get_Reserved
        get_Reserved = read_Reserved_value
    End Property

    Property Let set_Reserved(aData)
        write_Reserved_value = aData
        flag_Reserved        = &H1
    End Property

    Property Get read_Reserved
        read
        read_Reserved = read_Reserved_value
    End Property

    Property Let write_Reserved(aData)
        set_Reserved = aData
        write
    End Property

    Property Get get_PMD_RX_SIGDET_9
        get_PMD_RX_SIGDET_9 = read_PMD_RX_SIGDET_9_value
    End Property

    Property Let set_PMD_RX_SIGDET_9(aData)
        write_PMD_RX_SIGDET_9_value = aData
        flag_PMD_RX_SIGDET_9        = &H1
    End Property

    Property Get read_PMD_RX_SIGDET_9
        read
        read_PMD_RX_SIGDET_9 = read_PMD_RX_SIGDET_9_value
    End Property

    Property Let write_PMD_RX_SIGDET_9(aData)
        set_PMD_RX_SIGDET_9 = aData
        write
    End Property

    Property Get get_PMD_RX_SIGDET_8
        get_PMD_RX_SIGDET_8 = read_PMD_RX_SIGDET_8_value
    End Property

    Property Let set_PMD_RX_SIGDET_8(aData)
        write_PMD_RX_SIGDET_8_value = aData
        flag_PMD_RX_SIGDET_8        = &H1
    End Property

    Property Get read_PMD_RX_SIGDET_8
        read
        read_PMD_RX_SIGDET_8 = read_PMD_RX_SIGDET_8_value
    End Property

    Property Let write_PMD_RX_SIGDET_8(aData)
        set_PMD_RX_SIGDET_8 = aData
        write
    End Property

    Property Get get_PMD_RX_SIGDET_7
        get_PMD_RX_SIGDET_7 = read_PMD_RX_SIGDET_7_value
    End Property

    Property Let set_PMD_RX_SIGDET_7(aData)
        write_PMD_RX_SIGDET_7_value = aData
        flag_PMD_RX_SIGDET_7        = &H1
    End Property

    Property Get read_PMD_RX_SIGDET_7
        read
        read_PMD_RX_SIGDET_7 = read_PMD_RX_SIGDET_7_value
    End Property

    Property Let write_PMD_RX_SIGDET_7(aData)
        set_PMD_RX_SIGDET_7 = aData
        write
    End Property

    Property Get get_PMD_RX_SIGDET_6
        get_PMD_RX_SIGDET_6 = read_PMD_RX_SIGDET_6_value
    End Property

    Property Let set_PMD_RX_SIGDET_6(aData)
        write_PMD_RX_SIGDET_6_value = aData
        flag_PMD_RX_SIGDET_6        = &H1
    End Property

    Property Get read_PMD_RX_SIGDET_6
        read
        read_PMD_RX_SIGDET_6 = read_PMD_RX_SIGDET_6_value
    End Property

    Property Let write_PMD_RX_SIGDET_6(aData)
        set_PMD_RX_SIGDET_6 = aData
        write
    End Property

    Property Get get_PMD_RX_SIGDET_5
        get_PMD_RX_SIGDET_5 = read_PMD_RX_SIGDET_5_value
    End Property

    Property Let set_PMD_RX_SIGDET_5(aData)
        write_PMD_RX_SIGDET_5_value = aData
        flag_PMD_RX_SIGDET_5        = &H1
    End Property

    Property Get read_PMD_RX_SIGDET_5
        read
        read_PMD_RX_SIGDET_5 = read_PMD_RX_SIGDET_5_value
    End Property

    Property Let write_PMD_RX_SIGDET_5(aData)
        set_PMD_RX_SIGDET_5 = aData
        write
    End Property

    Property Get get_PMD_RX_SIGDET_4
        get_PMD_RX_SIGDET_4 = read_PMD_RX_SIGDET_4_value
    End Property

    Property Let set_PMD_RX_SIGDET_4(aData)
        write_PMD_RX_SIGDET_4_value = aData
        flag_PMD_RX_SIGDET_4        = &H1
    End Property

    Property Get read_PMD_RX_SIGDET_4
        read
        read_PMD_RX_SIGDET_4 = read_PMD_RX_SIGDET_4_value
    End Property

    Property Let write_PMD_RX_SIGDET_4(aData)
        set_PMD_RX_SIGDET_4 = aData
        write
    End Property

    Property Get get_PMD_RX_SIGDET_3
        get_PMD_RX_SIGDET_3 = read_PMD_RX_SIGDET_3_value
    End Property

    Property Let set_PMD_RX_SIGDET_3(aData)
        write_PMD_RX_SIGDET_3_value = aData
        flag_PMD_RX_SIGDET_3        = &H1
    End Property

    Property Get read_PMD_RX_SIGDET_3
        read
        read_PMD_RX_SIGDET_3 = read_PMD_RX_SIGDET_3_value
    End Property

    Property Let write_PMD_RX_SIGDET_3(aData)
        set_PMD_RX_SIGDET_3 = aData
        write
    End Property

    Property Get get_PMD_RX_SIGDET_2
        get_PMD_RX_SIGDET_2 = read_PMD_RX_SIGDET_2_value
    End Property

    Property Let set_PMD_RX_SIGDET_2(aData)
        write_PMD_RX_SIGDET_2_value = aData
        flag_PMD_RX_SIGDET_2        = &H1
    End Property

    Property Get read_PMD_RX_SIGDET_2
        read
        read_PMD_RX_SIGDET_2 = read_PMD_RX_SIGDET_2_value
    End Property

    Property Let write_PMD_RX_SIGDET_2(aData)
        set_PMD_RX_SIGDET_2 = aData
        write
    End Property

    Property Get get_PMD_RX_SIGDET_1
        get_PMD_RX_SIGDET_1 = read_PMD_RX_SIGDET_1_value
    End Property

    Property Let set_PMD_RX_SIGDET_1(aData)
        write_PMD_RX_SIGDET_1_value = aData
        flag_PMD_RX_SIGDET_1        = &H1
    End Property

    Property Get read_PMD_RX_SIGDET_1
        read
        read_PMD_RX_SIGDET_1 = read_PMD_RX_SIGDET_1_value
    End Property

    Property Let write_PMD_RX_SIGDET_1(aData)
        set_PMD_RX_SIGDET_1 = aData
        write
    End Property

    Property Get get_PMD_RX_SIGDET_0
        get_PMD_RX_SIGDET_0 = read_PMD_RX_SIGDET_0_value
    End Property

    Property Let set_PMD_RX_SIGDET_0(aData)
        write_PMD_RX_SIGDET_0_value = aData
        flag_PMD_RX_SIGDET_0        = &H1
    End Property

    Property Get read_PMD_RX_SIGDET_0
        read
        read_PMD_RX_SIGDET_0 = read_PMD_RX_SIGDET_0_value
    End Property

    Property Let write_PMD_RX_SIGDET_0(aData)
        set_PMD_RX_SIGDET_0 = aData
        write
    End Property

    Property Get get_PMD_RX_SIGDET_GLB
        get_PMD_RX_SIGDET_GLB = read_PMD_RX_SIGDET_GLB_value
    End Property

    Property Let set_PMD_RX_SIGDET_GLB(aData)
        write_PMD_RX_SIGDET_GLB_value = aData
        flag_PMD_RX_SIGDET_GLB        = &H1
    End Property

    Property Get read_PMD_RX_SIGDET_GLB
        read
        read_PMD_RX_SIGDET_GLB = read_PMD_RX_SIGDET_GLB_value
    End Property

    Property Let write_PMD_RX_SIGDET_GLB(aData)
        set_PMD_RX_SIGDET_GLB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Reserved_value = rightShift(data_low, 11) and &H1f
        read_PMD_RX_SIGDET_9_value = rightShift(data_low, 10) and &H1
        read_PMD_RX_SIGDET_8_value = rightShift(data_low, 9) and &H1
        read_PMD_RX_SIGDET_7_value = rightShift(data_low, 8) and &H1
        read_PMD_RX_SIGDET_6_value = rightShift(data_low, 7) and &H1
        read_PMD_RX_SIGDET_5_value = rightShift(data_low, 6) and &H1
        read_PMD_RX_SIGDET_4_value = rightShift(data_low, 5) and &H1
        read_PMD_RX_SIGDET_3_value = rightShift(data_low, 4) and &H1
        read_PMD_RX_SIGDET_2_value = rightShift(data_low, 3) and &H1
        read_PMD_RX_SIGDET_1_value = rightShift(data_low, 2) and &H1
        read_PMD_RX_SIGDET_0_value = rightShift(data_low, 1) and &H1
        PMD_RX_SIGDET_GLB_mask = &H1
        if data_low > LONG_MAX then
            if PMD_RX_SIGDET_GLB_mask = mask then
                read_PMD_RX_SIGDET_GLB_value = data_low
            else
                read_PMD_RX_SIGDET_GLB_value = (data_low - H8000_0000) and PMD_RX_SIGDET_GLB_mask
            end If
        else
            read_PMD_RX_SIGDET_GLB_value = data_low and PMD_RX_SIGDET_GLB_mask
        end If

    End Sub

    Sub write
        If flag_Reserved = &H0 or flag_PMD_RX_SIGDET_9 = &H0 or flag_PMD_RX_SIGDET_8 = &H0 or flag_PMD_RX_SIGDET_7 = &H0 or flag_PMD_RX_SIGDET_6 = &H0 or flag_PMD_RX_SIGDET_5 = &H0 or flag_PMD_RX_SIGDET_4 = &H0 or flag_PMD_RX_SIGDET_3 = &H0 or flag_PMD_RX_SIGDET_2 = &H0 or flag_PMD_RX_SIGDET_1 = &H0 or flag_PMD_RX_SIGDET_0 = &H0 or flag_PMD_RX_SIGDET_GLB = &H0 Then read
        If flag_Reserved = &H0 Then write_Reserved_value = get_Reserved
        If flag_PMD_RX_SIGDET_9 = &H0 Then write_PMD_RX_SIGDET_9_value = get_PMD_RX_SIGDET_9
        If flag_PMD_RX_SIGDET_8 = &H0 Then write_PMD_RX_SIGDET_8_value = get_PMD_RX_SIGDET_8
        If flag_PMD_RX_SIGDET_7 = &H0 Then write_PMD_RX_SIGDET_7_value = get_PMD_RX_SIGDET_7
        If flag_PMD_RX_SIGDET_6 = &H0 Then write_PMD_RX_SIGDET_6_value = get_PMD_RX_SIGDET_6
        If flag_PMD_RX_SIGDET_5 = &H0 Then write_PMD_RX_SIGDET_5_value = get_PMD_RX_SIGDET_5
        If flag_PMD_RX_SIGDET_4 = &H0 Then write_PMD_RX_SIGDET_4_value = get_PMD_RX_SIGDET_4
        If flag_PMD_RX_SIGDET_3 = &H0 Then write_PMD_RX_SIGDET_3_value = get_PMD_RX_SIGDET_3
        If flag_PMD_RX_SIGDET_2 = &H0 Then write_PMD_RX_SIGDET_2_value = get_PMD_RX_SIGDET_2
        If flag_PMD_RX_SIGDET_1 = &H0 Then write_PMD_RX_SIGDET_1_value = get_PMD_RX_SIGDET_1
        If flag_PMD_RX_SIGDET_0 = &H0 Then write_PMD_RX_SIGDET_0_value = get_PMD_RX_SIGDET_0
        If flag_PMD_RX_SIGDET_GLB = &H0 Then write_PMD_RX_SIGDET_GLB_value = get_PMD_RX_SIGDET_GLB

        regValue = leftShift((write_Reserved_value and &H1f), 11) + leftShift((write_PMD_RX_SIGDET_9_value and &H1), 10) + leftShift((write_PMD_RX_SIGDET_8_value and &H1), 9) + leftShift((write_PMD_RX_SIGDET_7_value and &H1), 8) + leftShift((write_PMD_RX_SIGDET_6_value and &H1), 7) + leftShift((write_PMD_RX_SIGDET_5_value and &H1), 6) + leftShift((write_PMD_RX_SIGDET_4_value and &H1), 5) + leftShift((write_PMD_RX_SIGDET_3_value and &H1), 4) + leftShift((write_PMD_RX_SIGDET_2_value and &H1), 3) + leftShift((write_PMD_RX_SIGDET_1_value and &H1), 2) + leftShift((write_PMD_RX_SIGDET_0_value and &H1), 1) + leftShift((write_PMD_RX_SIGDET_GLB_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Reserved_value = rightShift(data_low, 11) and &H1f
        read_PMD_RX_SIGDET_9_value = rightShift(data_low, 10) and &H1
        read_PMD_RX_SIGDET_8_value = rightShift(data_low, 9) and &H1
        read_PMD_RX_SIGDET_7_value = rightShift(data_low, 8) and &H1
        read_PMD_RX_SIGDET_6_value = rightShift(data_low, 7) and &H1
        read_PMD_RX_SIGDET_5_value = rightShift(data_low, 6) and &H1
        read_PMD_RX_SIGDET_4_value = rightShift(data_low, 5) and &H1
        read_PMD_RX_SIGDET_3_value = rightShift(data_low, 4) and &H1
        read_PMD_RX_SIGDET_2_value = rightShift(data_low, 3) and &H1
        read_PMD_RX_SIGDET_1_value = rightShift(data_low, 2) and &H1
        read_PMD_RX_SIGDET_0_value = rightShift(data_low, 1) and &H1
        PMD_RX_SIGDET_GLB_mask = &H1
        if data_low > LONG_MAX then
            if PMD_RX_SIGDET_GLB_mask = mask then
                read_PMD_RX_SIGDET_GLB_value = data_low
            else
                read_PMD_RX_SIGDET_GLB_value = (data_low - H8000_0000) and PMD_RX_SIGDET_GLB_mask
            end If
        else
            read_PMD_RX_SIGDET_GLB_value = data_low and PMD_RX_SIGDET_GLB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Reserved_value = &H0
        flag_Reserved        = &H0
        write_PMD_RX_SIGDET_9_value = &H0
        flag_PMD_RX_SIGDET_9        = &H0
        write_PMD_RX_SIGDET_8_value = &H0
        flag_PMD_RX_SIGDET_8        = &H0
        write_PMD_RX_SIGDET_7_value = &H0
        flag_PMD_RX_SIGDET_7        = &H0
        write_PMD_RX_SIGDET_6_value = &H0
        flag_PMD_RX_SIGDET_6        = &H0
        write_PMD_RX_SIGDET_5_value = &H0
        flag_PMD_RX_SIGDET_5        = &H0
        write_PMD_RX_SIGDET_4_value = &H0
        flag_PMD_RX_SIGDET_4        = &H0
        write_PMD_RX_SIGDET_3_value = &H0
        flag_PMD_RX_SIGDET_3        = &H0
        write_PMD_RX_SIGDET_2_value = &H0
        flag_PMD_RX_SIGDET_2        = &H0
        write_PMD_RX_SIGDET_1_value = &H0
        flag_PMD_RX_SIGDET_1        = &H0
        write_PMD_RX_SIGDET_0_value = &H0
        flag_PMD_RX_SIGDET_0        = &H0
        write_PMD_RX_SIGDET_GLB_value = &H0
        flag_PMD_RX_SIGDET_GLB        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV1_pmd_ieee_ext_ability
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Reserved                                   [15:11]          get_Reserved
''                                                             set_Reserved
''                                                             read_Reserved
''                                                             write_Reserved
''---------------------------------------------------------------------------------
'' PMA40G_100G_EXT_ABILITY                    [10:10]          get_PMA40G_100G_EXT_ABILITY
''                                                             set_PMA40G_100G_EXT_ABILITY
''                                                             read_PMA40G_100G_EXT_ABILITY
''                                                             write_PMA40G_100G_EXT_ABILITY
''---------------------------------------------------------------------------------
'' P2MP_ABILITY                               [9:9]            get_P2MP_ABILITY
''                                                             set_P2MP_ABILITY
''                                                             read_P2MP_ABILITY
''                                                             write_P2MP_ABILITY
''---------------------------------------------------------------------------------
'' PMA10BASE_T_ABILITY                        [8:8]            get_PMA10BASE_T_ABILITY
''                                                             set_PMA10BASE_T_ABILITY
''                                                             read_PMA10BASE_T_ABILITY
''                                                             write_PMA10BASE_T_ABILITY
''---------------------------------------------------------------------------------
'' PMA100BASE_TX_ABILITY                      [7:7]            get_PMA100BASE_TX_ABILITY
''                                                             set_PMA100BASE_TX_ABILITY
''                                                             read_PMA100BASE_TX_ABILITY
''                                                             write_PMA100BASE_TX_ABILITY
''---------------------------------------------------------------------------------
'' PMA1000BASE_KX_ABILITY                     [6:6]            get_PMA1000BASE_KX_ABILITY
''                                                             set_PMA1000BASE_KX_ABILITY
''                                                             read_PMA1000BASE_KX_ABILITY
''                                                             write_PMA1000BASE_KX_ABILITY
''---------------------------------------------------------------------------------
'' PMA1000BASE_T_ABILITY                      [5:5]            get_PMA1000BASE_T_ABILITY
''                                                             set_PMA1000BASE_T_ABILITY
''                                                             read_PMA1000BASE_T_ABILITY
''                                                             write_PMA1000BASE_T_ABILITY
''---------------------------------------------------------------------------------
'' PMA10GBASE_KR_ABILITY                      [4:4]            get_PMA10GBASE_KR_ABILITY
''                                                             set_PMA10GBASE_KR_ABILITY
''                                                             read_PMA10GBASE_KR_ABILITY
''                                                             write_PMA10GBASE_KR_ABILITY
''---------------------------------------------------------------------------------
'' PMA10GBASE_KX4_ABILITY                     [3:3]            get_PMA10GBASE_KX4_ABILITY
''                                                             set_PMA10GBASE_KX4_ABILITY
''                                                             read_PMA10GBASE_KX4_ABILITY
''                                                             write_PMA10GBASE_KX4_ABILITY
''---------------------------------------------------------------------------------
'' PMA10GBASE_T_ABILITY                       [2:2]            get_PMA10GBASE_T_ABILITY
''                                                             set_PMA10GBASE_T_ABILITY
''                                                             read_PMA10GBASE_T_ABILITY
''                                                             write_PMA10GBASE_T_ABILITY
''---------------------------------------------------------------------------------
'' PMA10GBASE_LRM_ABILITY                     [1:1]            get_PMA10GBASE_LRM_ABILITY
''                                                             set_PMA10GBASE_LRM_ABILITY
''                                                             read_PMA10GBASE_LRM_ABILITY
''                                                             write_PMA10GBASE_LRM_ABILITY
''---------------------------------------------------------------------------------
'' PMA10GBASE_CX4_ABILITY                     [0:0]            get_PMA10GBASE_CX4_ABILITY
''                                                             set_PMA10GBASE_CX4_ABILITY
''                                                             read_PMA10GBASE_CX4_ABILITY
''                                                             write_PMA10GBASE_CX4_ABILITY
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV1_pmd_ieee_ext_ability
    Private write_Reserved_value
    Private read_Reserved_value
    Private flag_Reserved
    Private write_PMA40G_100G_EXT_ABILITY_value
    Private read_PMA40G_100G_EXT_ABILITY_value
    Private flag_PMA40G_100G_EXT_ABILITY
    Private write_P2MP_ABILITY_value
    Private read_P2MP_ABILITY_value
    Private flag_P2MP_ABILITY
    Private write_PMA10BASE_T_ABILITY_value
    Private read_PMA10BASE_T_ABILITY_value
    Private flag_PMA10BASE_T_ABILITY
    Private write_PMA100BASE_TX_ABILITY_value
    Private read_PMA100BASE_TX_ABILITY_value
    Private flag_PMA100BASE_TX_ABILITY
    Private write_PMA1000BASE_KX_ABILITY_value
    Private read_PMA1000BASE_KX_ABILITY_value
    Private flag_PMA1000BASE_KX_ABILITY
    Private write_PMA1000BASE_T_ABILITY_value
    Private read_PMA1000BASE_T_ABILITY_value
    Private flag_PMA1000BASE_T_ABILITY
    Private write_PMA10GBASE_KR_ABILITY_value
    Private read_PMA10GBASE_KR_ABILITY_value
    Private flag_PMA10GBASE_KR_ABILITY
    Private write_PMA10GBASE_KX4_ABILITY_value
    Private read_PMA10GBASE_KX4_ABILITY_value
    Private flag_PMA10GBASE_KX4_ABILITY
    Private write_PMA10GBASE_T_ABILITY_value
    Private read_PMA10GBASE_T_ABILITY_value
    Private flag_PMA10GBASE_T_ABILITY
    Private write_PMA10GBASE_LRM_ABILITY_value
    Private read_PMA10GBASE_LRM_ABILITY_value
    Private flag_PMA10GBASE_LRM_ABILITY
    Private write_PMA10GBASE_CX4_ABILITY_value
    Private read_PMA10GBASE_CX4_ABILITY_value
    Private flag_PMA10GBASE_CX4_ABILITY

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

    Property Get get_Reserved
        get_Reserved = read_Reserved_value
    End Property

    Property Let set_Reserved(aData)
        write_Reserved_value = aData
        flag_Reserved        = &H1
    End Property

    Property Get read_Reserved
        read
        read_Reserved = read_Reserved_value
    End Property

    Property Let write_Reserved(aData)
        set_Reserved = aData
        write
    End Property

    Property Get get_PMA40G_100G_EXT_ABILITY
        get_PMA40G_100G_EXT_ABILITY = read_PMA40G_100G_EXT_ABILITY_value
    End Property

    Property Let set_PMA40G_100G_EXT_ABILITY(aData)
        write_PMA40G_100G_EXT_ABILITY_value = aData
        flag_PMA40G_100G_EXT_ABILITY        = &H1
    End Property

    Property Get read_PMA40G_100G_EXT_ABILITY
        read
        read_PMA40G_100G_EXT_ABILITY = read_PMA40G_100G_EXT_ABILITY_value
    End Property

    Property Let write_PMA40G_100G_EXT_ABILITY(aData)
        set_PMA40G_100G_EXT_ABILITY = aData
        write
    End Property

    Property Get get_P2MP_ABILITY
        get_P2MP_ABILITY = read_P2MP_ABILITY_value
    End Property

    Property Let set_P2MP_ABILITY(aData)
        write_P2MP_ABILITY_value = aData
        flag_P2MP_ABILITY        = &H1
    End Property

    Property Get read_P2MP_ABILITY
        read
        read_P2MP_ABILITY = read_P2MP_ABILITY_value
    End Property

    Property Let write_P2MP_ABILITY(aData)
        set_P2MP_ABILITY = aData
        write
    End Property

    Property Get get_PMA10BASE_T_ABILITY
        get_PMA10BASE_T_ABILITY = read_PMA10BASE_T_ABILITY_value
    End Property

    Property Let set_PMA10BASE_T_ABILITY(aData)
        write_PMA10BASE_T_ABILITY_value = aData
        flag_PMA10BASE_T_ABILITY        = &H1
    End Property

    Property Get read_PMA10BASE_T_ABILITY
        read
        read_PMA10BASE_T_ABILITY = read_PMA10BASE_T_ABILITY_value
    End Property

    Property Let write_PMA10BASE_T_ABILITY(aData)
        set_PMA10BASE_T_ABILITY = aData
        write
    End Property

    Property Get get_PMA100BASE_TX_ABILITY
        get_PMA100BASE_TX_ABILITY = read_PMA100BASE_TX_ABILITY_value
    End Property

    Property Let set_PMA100BASE_TX_ABILITY(aData)
        write_PMA100BASE_TX_ABILITY_value = aData
        flag_PMA100BASE_TX_ABILITY        = &H1
    End Property

    Property Get read_PMA100BASE_TX_ABILITY
        read
        read_PMA100BASE_TX_ABILITY = read_PMA100BASE_TX_ABILITY_value
    End Property

    Property Let write_PMA100BASE_TX_ABILITY(aData)
        set_PMA100BASE_TX_ABILITY = aData
        write
    End Property

    Property Get get_PMA1000BASE_KX_ABILITY
        get_PMA1000BASE_KX_ABILITY = read_PMA1000BASE_KX_ABILITY_value
    End Property

    Property Let set_PMA1000BASE_KX_ABILITY(aData)
        write_PMA1000BASE_KX_ABILITY_value = aData
        flag_PMA1000BASE_KX_ABILITY        = &H1
    End Property

    Property Get read_PMA1000BASE_KX_ABILITY
        read
        read_PMA1000BASE_KX_ABILITY = read_PMA1000BASE_KX_ABILITY_value
    End Property

    Property Let write_PMA1000BASE_KX_ABILITY(aData)
        set_PMA1000BASE_KX_ABILITY = aData
        write
    End Property

    Property Get get_PMA1000BASE_T_ABILITY
        get_PMA1000BASE_T_ABILITY = read_PMA1000BASE_T_ABILITY_value
    End Property

    Property Let set_PMA1000BASE_T_ABILITY(aData)
        write_PMA1000BASE_T_ABILITY_value = aData
        flag_PMA1000BASE_T_ABILITY        = &H1
    End Property

    Property Get read_PMA1000BASE_T_ABILITY
        read
        read_PMA1000BASE_T_ABILITY = read_PMA1000BASE_T_ABILITY_value
    End Property

    Property Let write_PMA1000BASE_T_ABILITY(aData)
        set_PMA1000BASE_T_ABILITY = aData
        write
    End Property

    Property Get get_PMA10GBASE_KR_ABILITY
        get_PMA10GBASE_KR_ABILITY = read_PMA10GBASE_KR_ABILITY_value
    End Property

    Property Let set_PMA10GBASE_KR_ABILITY(aData)
        write_PMA10GBASE_KR_ABILITY_value = aData
        flag_PMA10GBASE_KR_ABILITY        = &H1
    End Property

    Property Get read_PMA10GBASE_KR_ABILITY
        read
        read_PMA10GBASE_KR_ABILITY = read_PMA10GBASE_KR_ABILITY_value
    End Property

    Property Let write_PMA10GBASE_KR_ABILITY(aData)
        set_PMA10GBASE_KR_ABILITY = aData
        write
    End Property

    Property Get get_PMA10GBASE_KX4_ABILITY
        get_PMA10GBASE_KX4_ABILITY = read_PMA10GBASE_KX4_ABILITY_value
    End Property

    Property Let set_PMA10GBASE_KX4_ABILITY(aData)
        write_PMA10GBASE_KX4_ABILITY_value = aData
        flag_PMA10GBASE_KX4_ABILITY        = &H1
    End Property

    Property Get read_PMA10GBASE_KX4_ABILITY
        read
        read_PMA10GBASE_KX4_ABILITY = read_PMA10GBASE_KX4_ABILITY_value
    End Property

    Property Let write_PMA10GBASE_KX4_ABILITY(aData)
        set_PMA10GBASE_KX4_ABILITY = aData
        write
    End Property

    Property Get get_PMA10GBASE_T_ABILITY
        get_PMA10GBASE_T_ABILITY = read_PMA10GBASE_T_ABILITY_value
    End Property

    Property Let set_PMA10GBASE_T_ABILITY(aData)
        write_PMA10GBASE_T_ABILITY_value = aData
        flag_PMA10GBASE_T_ABILITY        = &H1
    End Property

    Property Get read_PMA10GBASE_T_ABILITY
        read
        read_PMA10GBASE_T_ABILITY = read_PMA10GBASE_T_ABILITY_value
    End Property

    Property Let write_PMA10GBASE_T_ABILITY(aData)
        set_PMA10GBASE_T_ABILITY = aData
        write
    End Property

    Property Get get_PMA10GBASE_LRM_ABILITY
        get_PMA10GBASE_LRM_ABILITY = read_PMA10GBASE_LRM_ABILITY_value
    End Property

    Property Let set_PMA10GBASE_LRM_ABILITY(aData)
        write_PMA10GBASE_LRM_ABILITY_value = aData
        flag_PMA10GBASE_LRM_ABILITY        = &H1
    End Property

    Property Get read_PMA10GBASE_LRM_ABILITY
        read
        read_PMA10GBASE_LRM_ABILITY = read_PMA10GBASE_LRM_ABILITY_value
    End Property

    Property Let write_PMA10GBASE_LRM_ABILITY(aData)
        set_PMA10GBASE_LRM_ABILITY = aData
        write
    End Property

    Property Get get_PMA10GBASE_CX4_ABILITY
        get_PMA10GBASE_CX4_ABILITY = read_PMA10GBASE_CX4_ABILITY_value
    End Property

    Property Let set_PMA10GBASE_CX4_ABILITY(aData)
        write_PMA10GBASE_CX4_ABILITY_value = aData
        flag_PMA10GBASE_CX4_ABILITY        = &H1
    End Property

    Property Get read_PMA10GBASE_CX4_ABILITY
        read
        read_PMA10GBASE_CX4_ABILITY = read_PMA10GBASE_CX4_ABILITY_value
    End Property

    Property Let write_PMA10GBASE_CX4_ABILITY(aData)
        set_PMA10GBASE_CX4_ABILITY = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Reserved_value = rightShift(data_low, 11) and &H1f
        read_PMA40G_100G_EXT_ABILITY_value = rightShift(data_low, 10) and &H1
        read_P2MP_ABILITY_value = rightShift(data_low, 9) and &H1
        read_PMA10BASE_T_ABILITY_value = rightShift(data_low, 8) and &H1
        read_PMA100BASE_TX_ABILITY_value = rightShift(data_low, 7) and &H1
        read_PMA1000BASE_KX_ABILITY_value = rightShift(data_low, 6) and &H1
        read_PMA1000BASE_T_ABILITY_value = rightShift(data_low, 5) and &H1
        read_PMA10GBASE_KR_ABILITY_value = rightShift(data_low, 4) and &H1
        read_PMA10GBASE_KX4_ABILITY_value = rightShift(data_low, 3) and &H1
        read_PMA10GBASE_T_ABILITY_value = rightShift(data_low, 2) and &H1
        read_PMA10GBASE_LRM_ABILITY_value = rightShift(data_low, 1) and &H1
        PMA10GBASE_CX4_ABILITY_mask = &H1
        if data_low > LONG_MAX then
            if PMA10GBASE_CX4_ABILITY_mask = mask then
                read_PMA10GBASE_CX4_ABILITY_value = data_low
            else
                read_PMA10GBASE_CX4_ABILITY_value = (data_low - H8000_0000) and PMA10GBASE_CX4_ABILITY_mask
            end If
        else
            read_PMA10GBASE_CX4_ABILITY_value = data_low and PMA10GBASE_CX4_ABILITY_mask
        end If

    End Sub

    Sub write
        If flag_Reserved = &H0 or flag_PMA40G_100G_EXT_ABILITY = &H0 or flag_P2MP_ABILITY = &H0 or flag_PMA10BASE_T_ABILITY = &H0 or flag_PMA100BASE_TX_ABILITY = &H0 or flag_PMA1000BASE_KX_ABILITY = &H0 or flag_PMA1000BASE_T_ABILITY = &H0 or flag_PMA10GBASE_KR_ABILITY = &H0 or flag_PMA10GBASE_KX4_ABILITY = &H0 or flag_PMA10GBASE_T_ABILITY = &H0 or flag_PMA10GBASE_LRM_ABILITY = &H0 or flag_PMA10GBASE_CX4_ABILITY = &H0 Then read
        If flag_Reserved = &H0 Then write_Reserved_value = get_Reserved
        If flag_PMA40G_100G_EXT_ABILITY = &H0 Then write_PMA40G_100G_EXT_ABILITY_value = get_PMA40G_100G_EXT_ABILITY
        If flag_P2MP_ABILITY = &H0 Then write_P2MP_ABILITY_value = get_P2MP_ABILITY
        If flag_PMA10BASE_T_ABILITY = &H0 Then write_PMA10BASE_T_ABILITY_value = get_PMA10BASE_T_ABILITY
        If flag_PMA100BASE_TX_ABILITY = &H0 Then write_PMA100BASE_TX_ABILITY_value = get_PMA100BASE_TX_ABILITY
        If flag_PMA1000BASE_KX_ABILITY = &H0 Then write_PMA1000BASE_KX_ABILITY_value = get_PMA1000BASE_KX_ABILITY
        If flag_PMA1000BASE_T_ABILITY = &H0 Then write_PMA1000BASE_T_ABILITY_value = get_PMA1000BASE_T_ABILITY
        If flag_PMA10GBASE_KR_ABILITY = &H0 Then write_PMA10GBASE_KR_ABILITY_value = get_PMA10GBASE_KR_ABILITY
        If flag_PMA10GBASE_KX4_ABILITY = &H0 Then write_PMA10GBASE_KX4_ABILITY_value = get_PMA10GBASE_KX4_ABILITY
        If flag_PMA10GBASE_T_ABILITY = &H0 Then write_PMA10GBASE_T_ABILITY_value = get_PMA10GBASE_T_ABILITY
        If flag_PMA10GBASE_LRM_ABILITY = &H0 Then write_PMA10GBASE_LRM_ABILITY_value = get_PMA10GBASE_LRM_ABILITY
        If flag_PMA10GBASE_CX4_ABILITY = &H0 Then write_PMA10GBASE_CX4_ABILITY_value = get_PMA10GBASE_CX4_ABILITY

        regValue = leftShift((write_Reserved_value and &H1f), 11) + leftShift((write_PMA40G_100G_EXT_ABILITY_value and &H1), 10) + leftShift((write_P2MP_ABILITY_value and &H1), 9) + leftShift((write_PMA10BASE_T_ABILITY_value and &H1), 8) + leftShift((write_PMA100BASE_TX_ABILITY_value and &H1), 7) + leftShift((write_PMA1000BASE_KX_ABILITY_value and &H1), 6) + leftShift((write_PMA1000BASE_T_ABILITY_value and &H1), 5) + leftShift((write_PMA10GBASE_KR_ABILITY_value and &H1), 4) + leftShift((write_PMA10GBASE_KX4_ABILITY_value and &H1), 3) + leftShift((write_PMA10GBASE_T_ABILITY_value and &H1), 2) + leftShift((write_PMA10GBASE_LRM_ABILITY_value and &H1), 1) + leftShift((write_PMA10GBASE_CX4_ABILITY_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Reserved_value = rightShift(data_low, 11) and &H1f
        read_PMA40G_100G_EXT_ABILITY_value = rightShift(data_low, 10) and &H1
        read_P2MP_ABILITY_value = rightShift(data_low, 9) and &H1
        read_PMA10BASE_T_ABILITY_value = rightShift(data_low, 8) and &H1
        read_PMA100BASE_TX_ABILITY_value = rightShift(data_low, 7) and &H1
        read_PMA1000BASE_KX_ABILITY_value = rightShift(data_low, 6) and &H1
        read_PMA1000BASE_T_ABILITY_value = rightShift(data_low, 5) and &H1
        read_PMA10GBASE_KR_ABILITY_value = rightShift(data_low, 4) and &H1
        read_PMA10GBASE_KX4_ABILITY_value = rightShift(data_low, 3) and &H1
        read_PMA10GBASE_T_ABILITY_value = rightShift(data_low, 2) and &H1
        read_PMA10GBASE_LRM_ABILITY_value = rightShift(data_low, 1) and &H1
        PMA10GBASE_CX4_ABILITY_mask = &H1
        if data_low > LONG_MAX then
            if PMA10GBASE_CX4_ABILITY_mask = mask then
                read_PMA10GBASE_CX4_ABILITY_value = data_low
            else
                read_PMA10GBASE_CX4_ABILITY_value = (data_low - H8000_0000) and PMA10GBASE_CX4_ABILITY_mask
            end If
        else
            read_PMA10GBASE_CX4_ABILITY_value = data_low and PMA10GBASE_CX4_ABILITY_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Reserved_value = &H0
        flag_Reserved        = &H0
        write_PMA40G_100G_EXT_ABILITY_value = &H0
        flag_PMA40G_100G_EXT_ABILITY        = &H0
        write_P2MP_ABILITY_value = &H0
        flag_P2MP_ABILITY        = &H0
        write_PMA10BASE_T_ABILITY_value = &H0
        flag_PMA10BASE_T_ABILITY        = &H0
        write_PMA100BASE_TX_ABILITY_value = &H0
        flag_PMA100BASE_TX_ABILITY        = &H0
        write_PMA1000BASE_KX_ABILITY_value = &H0
        flag_PMA1000BASE_KX_ABILITY        = &H0
        write_PMA1000BASE_T_ABILITY_value = &H0
        flag_PMA1000BASE_T_ABILITY        = &H0
        write_PMA10GBASE_KR_ABILITY_value = &H0
        flag_PMA10GBASE_KR_ABILITY        = &H0
        write_PMA10GBASE_KX4_ABILITY_value = &H0
        flag_PMA10GBASE_KX4_ABILITY        = &H0
        write_PMA10GBASE_T_ABILITY_value = &H0
        flag_PMA10GBASE_T_ABILITY        = &H0
        write_PMA10GBASE_LRM_ABILITY_value = &H0
        flag_PMA10GBASE_LRM_ABILITY        = &H0
        write_PMA10GBASE_CX4_ABILITY_value = &H0
        flag_PMA10GBASE_CX4_ABILITY        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV1_pmd_ieee_pkg_id0
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
Class REGISTER_CL45DEV1_pmd_ieee_pkg_id0
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


'' @REGISTER : CL45DEV1_pmd_ieee_pkg_id1
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
Class REGISTER_CL45DEV1_pmd_ieee_pkg_id1
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


'' @REGISTER : CL45DEV1_pmd_ieee_ext_ability_t1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Reserved                                   [15:1]           get_Reserved
''                                                             set_Reserved
''                                                             read_Reserved
''                                                             write_Reserved
''---------------------------------------------------------------------------------
'' PMA100BASE_T1_ABILITY                      [0:0]            get_PMA100BASE_T1_ABILITY
''                                                             set_PMA100BASE_T1_ABILITY
''                                                             read_PMA100BASE_T1_ABILITY
''                                                             write_PMA100BASE_T1_ABILITY
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV1_pmd_ieee_ext_ability_t1
    Private write_Reserved_value
    Private read_Reserved_value
    Private flag_Reserved
    Private write_PMA100BASE_T1_ABILITY_value
    Private read_PMA100BASE_T1_ABILITY_value
    Private flag_PMA100BASE_T1_ABILITY

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

    Property Get get_Reserved
        get_Reserved = read_Reserved_value
    End Property

    Property Let set_Reserved(aData)
        write_Reserved_value = aData
        flag_Reserved        = &H1
    End Property

    Property Get read_Reserved
        read
        read_Reserved = read_Reserved_value
    End Property

    Property Let write_Reserved(aData)
        set_Reserved = aData
        write
    End Property

    Property Get get_PMA100BASE_T1_ABILITY
        get_PMA100BASE_T1_ABILITY = read_PMA100BASE_T1_ABILITY_value
    End Property

    Property Let set_PMA100BASE_T1_ABILITY(aData)
        write_PMA100BASE_T1_ABILITY_value = aData
        flag_PMA100BASE_T1_ABILITY        = &H1
    End Property

    Property Get read_PMA100BASE_T1_ABILITY
        read
        read_PMA100BASE_T1_ABILITY = read_PMA100BASE_T1_ABILITY_value
    End Property

    Property Let write_PMA100BASE_T1_ABILITY(aData)
        set_PMA100BASE_T1_ABILITY = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Reserved_value = rightShift(data_low, 1) and &H7fff
        PMA100BASE_T1_ABILITY_mask = &H1
        if data_low > LONG_MAX then
            if PMA100BASE_T1_ABILITY_mask = mask then
                read_PMA100BASE_T1_ABILITY_value = data_low
            else
                read_PMA100BASE_T1_ABILITY_value = (data_low - H8000_0000) and PMA100BASE_T1_ABILITY_mask
            end If
        else
            read_PMA100BASE_T1_ABILITY_value = data_low and PMA100BASE_T1_ABILITY_mask
        end If

    End Sub

    Sub write
        If flag_Reserved = &H0 or flag_PMA100BASE_T1_ABILITY = &H0 Then read
        If flag_Reserved = &H0 Then write_Reserved_value = get_Reserved
        If flag_PMA100BASE_T1_ABILITY = &H0 Then write_PMA100BASE_T1_ABILITY_value = get_PMA100BASE_T1_ABILITY

        regValue = leftShift((write_Reserved_value and &H7fff), 1) + leftShift((write_PMA100BASE_T1_ABILITY_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Reserved_value = rightShift(data_low, 1) and &H7fff
        PMA100BASE_T1_ABILITY_mask = &H1
        if data_low > LONG_MAX then
            if PMA100BASE_T1_ABILITY_mask = mask then
                read_PMA100BASE_T1_ABILITY_value = data_low
            else
                read_PMA100BASE_T1_ABILITY_value = (data_low - H8000_0000) and PMA100BASE_T1_ABILITY_mask
            end If
        else
            read_PMA100BASE_T1_ABILITY_value = data_low and PMA100BASE_T1_ABILITY_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Reserved_value = &H0
        flag_Reserved        = &H0
        write_PMA100BASE_T1_ABILITY_value = &H0
        flag_PMA100BASE_T1_ABILITY        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV1_pmd_ieee_tsync_cap
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TX_PMD_TSYNC_EN                            [1:1]            get_TX_PMD_TSYNC_EN
''                                                             set_TX_PMD_TSYNC_EN
''                                                             read_TX_PMD_TSYNC_EN
''                                                             write_TX_PMD_TSYNC_EN
''---------------------------------------------------------------------------------
'' RX_PMD_TSYNC_EN                            [0:0]            get_RX_PMD_TSYNC_EN
''                                                             set_RX_PMD_TSYNC_EN
''                                                             read_RX_PMD_TSYNC_EN
''                                                             write_RX_PMD_TSYNC_EN
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV1_pmd_ieee_tsync_cap
    Private write_TX_PMD_TSYNC_EN_value
    Private read_TX_PMD_TSYNC_EN_value
    Private flag_TX_PMD_TSYNC_EN
    Private write_RX_PMD_TSYNC_EN_value
    Private read_RX_PMD_TSYNC_EN_value
    Private flag_RX_PMD_TSYNC_EN

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

    Property Get get_TX_PMD_TSYNC_EN
        get_TX_PMD_TSYNC_EN = read_TX_PMD_TSYNC_EN_value
    End Property

    Property Let set_TX_PMD_TSYNC_EN(aData)
        write_TX_PMD_TSYNC_EN_value = aData
        flag_TX_PMD_TSYNC_EN        = &H1
    End Property

    Property Get read_TX_PMD_TSYNC_EN
        read
        read_TX_PMD_TSYNC_EN = read_TX_PMD_TSYNC_EN_value
    End Property

    Property Let write_TX_PMD_TSYNC_EN(aData)
        set_TX_PMD_TSYNC_EN = aData
        write
    End Property

    Property Get get_RX_PMD_TSYNC_EN
        get_RX_PMD_TSYNC_EN = read_RX_PMD_TSYNC_EN_value
    End Property

    Property Let set_RX_PMD_TSYNC_EN(aData)
        write_RX_PMD_TSYNC_EN_value = aData
        flag_RX_PMD_TSYNC_EN        = &H1
    End Property

    Property Get read_RX_PMD_TSYNC_EN
        read
        read_RX_PMD_TSYNC_EN = read_RX_PMD_TSYNC_EN_value
    End Property

    Property Let write_RX_PMD_TSYNC_EN(aData)
        set_RX_PMD_TSYNC_EN = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TX_PMD_TSYNC_EN_value = rightShift(data_low, 1) and &H1
        RX_PMD_TSYNC_EN_mask = &H1
        if data_low > LONG_MAX then
            if RX_PMD_TSYNC_EN_mask = mask then
                read_RX_PMD_TSYNC_EN_value = data_low
            else
                read_RX_PMD_TSYNC_EN_value = (data_low - H8000_0000) and RX_PMD_TSYNC_EN_mask
            end If
        else
            read_RX_PMD_TSYNC_EN_value = data_low and RX_PMD_TSYNC_EN_mask
        end If

    End Sub

    Sub write
        If flag_TX_PMD_TSYNC_EN = &H0 or flag_RX_PMD_TSYNC_EN = &H0 Then read
        If flag_TX_PMD_TSYNC_EN = &H0 Then write_TX_PMD_TSYNC_EN_value = get_TX_PMD_TSYNC_EN
        If flag_RX_PMD_TSYNC_EN = &H0 Then write_RX_PMD_TSYNC_EN_value = get_RX_PMD_TSYNC_EN

        regValue = leftShift((write_TX_PMD_TSYNC_EN_value and &H1), 1) + leftShift((write_RX_PMD_TSYNC_EN_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TX_PMD_TSYNC_EN_value = rightShift(data_low, 1) and &H1
        RX_PMD_TSYNC_EN_mask = &H1
        if data_low > LONG_MAX then
            if RX_PMD_TSYNC_EN_mask = mask then
                read_RX_PMD_TSYNC_EN_value = data_low
            else
                read_RX_PMD_TSYNC_EN_value = (data_low - H8000_0000) and RX_PMD_TSYNC_EN_mask
            end If
        else
            read_RX_PMD_TSYNC_EN_value = data_low and RX_PMD_TSYNC_EN_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TX_PMD_TSYNC_EN_value = &H0
        flag_TX_PMD_TSYNC_EN        = &H0
        write_RX_PMD_TSYNC_EN_value = &H0
        flag_RX_PMD_TSYNC_EN        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV1_pmd_ieee_tx_tsync_max_delay_lower
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TX_PMD_MAX_DLY_15_0                        [15:0]           get_TX_PMD_MAX_DLY_15_0
''                                                             set_TX_PMD_MAX_DLY_15_0
''                                                             read_TX_PMD_MAX_DLY_15_0
''                                                             write_TX_PMD_MAX_DLY_15_0
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV1_pmd_ieee_tx_tsync_max_delay_lower
    Private write_TX_PMD_MAX_DLY_15_0_value
    Private read_TX_PMD_MAX_DLY_15_0_value
    Private flag_TX_PMD_MAX_DLY_15_0

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

    Property Get get_TX_PMD_MAX_DLY_15_0
        get_TX_PMD_MAX_DLY_15_0 = read_TX_PMD_MAX_DLY_15_0_value
    End Property

    Property Let set_TX_PMD_MAX_DLY_15_0(aData)
        write_TX_PMD_MAX_DLY_15_0_value = aData
        flag_TX_PMD_MAX_DLY_15_0        = &H1
    End Property

    Property Get read_TX_PMD_MAX_DLY_15_0
        read
        read_TX_PMD_MAX_DLY_15_0 = read_TX_PMD_MAX_DLY_15_0_value
    End Property

    Property Let write_TX_PMD_MAX_DLY_15_0(aData)
        set_TX_PMD_MAX_DLY_15_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TX_PMD_MAX_DLY_15_0_mask = &Hffff
        if data_low > LONG_MAX then
            if TX_PMD_MAX_DLY_15_0_mask = mask then
                read_TX_PMD_MAX_DLY_15_0_value = data_low
            else
                read_TX_PMD_MAX_DLY_15_0_value = (data_low - H8000_0000) and TX_PMD_MAX_DLY_15_0_mask
            end If
        else
            read_TX_PMD_MAX_DLY_15_0_value = data_low and TX_PMD_MAX_DLY_15_0_mask
        end If

    End Sub

    Sub write
        If flag_TX_PMD_MAX_DLY_15_0 = &H0 Then read
        If flag_TX_PMD_MAX_DLY_15_0 = &H0 Then write_TX_PMD_MAX_DLY_15_0_value = get_TX_PMD_MAX_DLY_15_0

        regValue = leftShift((write_TX_PMD_MAX_DLY_15_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TX_PMD_MAX_DLY_15_0_mask = &Hffff
        if data_low > LONG_MAX then
            if TX_PMD_MAX_DLY_15_0_mask = mask then
                read_TX_PMD_MAX_DLY_15_0_value = data_low
            else
                read_TX_PMD_MAX_DLY_15_0_value = (data_low - H8000_0000) and TX_PMD_MAX_DLY_15_0_mask
            end If
        else
            read_TX_PMD_MAX_DLY_15_0_value = data_low and TX_PMD_MAX_DLY_15_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TX_PMD_MAX_DLY_15_0_value = &H0
        flag_TX_PMD_MAX_DLY_15_0        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV1_pmd_ieee_tx_tsync_max_delay_upper
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TX_PMD_MAX_DLY_31_16                       [15:0]           get_TX_PMD_MAX_DLY_31_16
''                                                             set_TX_PMD_MAX_DLY_31_16
''                                                             read_TX_PMD_MAX_DLY_31_16
''                                                             write_TX_PMD_MAX_DLY_31_16
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV1_pmd_ieee_tx_tsync_max_delay_upper
    Private write_TX_PMD_MAX_DLY_31_16_value
    Private read_TX_PMD_MAX_DLY_31_16_value
    Private flag_TX_PMD_MAX_DLY_31_16

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

    Property Get get_TX_PMD_MAX_DLY_31_16
        get_TX_PMD_MAX_DLY_31_16 = read_TX_PMD_MAX_DLY_31_16_value
    End Property

    Property Let set_TX_PMD_MAX_DLY_31_16(aData)
        write_TX_PMD_MAX_DLY_31_16_value = aData
        flag_TX_PMD_MAX_DLY_31_16        = &H1
    End Property

    Property Get read_TX_PMD_MAX_DLY_31_16
        read
        read_TX_PMD_MAX_DLY_31_16 = read_TX_PMD_MAX_DLY_31_16_value
    End Property

    Property Let write_TX_PMD_MAX_DLY_31_16(aData)
        set_TX_PMD_MAX_DLY_31_16 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TX_PMD_MAX_DLY_31_16_mask = &Hffff
        if data_low > LONG_MAX then
            if TX_PMD_MAX_DLY_31_16_mask = mask then
                read_TX_PMD_MAX_DLY_31_16_value = data_low
            else
                read_TX_PMD_MAX_DLY_31_16_value = (data_low - H8000_0000) and TX_PMD_MAX_DLY_31_16_mask
            end If
        else
            read_TX_PMD_MAX_DLY_31_16_value = data_low and TX_PMD_MAX_DLY_31_16_mask
        end If

    End Sub

    Sub write
        If flag_TX_PMD_MAX_DLY_31_16 = &H0 Then read
        If flag_TX_PMD_MAX_DLY_31_16 = &H0 Then write_TX_PMD_MAX_DLY_31_16_value = get_TX_PMD_MAX_DLY_31_16

        regValue = leftShift((write_TX_PMD_MAX_DLY_31_16_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TX_PMD_MAX_DLY_31_16_mask = &Hffff
        if data_low > LONG_MAX then
            if TX_PMD_MAX_DLY_31_16_mask = mask then
                read_TX_PMD_MAX_DLY_31_16_value = data_low
            else
                read_TX_PMD_MAX_DLY_31_16_value = (data_low - H8000_0000) and TX_PMD_MAX_DLY_31_16_mask
            end If
        else
            read_TX_PMD_MAX_DLY_31_16_value = data_low and TX_PMD_MAX_DLY_31_16_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TX_PMD_MAX_DLY_31_16_value = &H0
        flag_TX_PMD_MAX_DLY_31_16        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV1_pmd_ieee_tx_tsync_min_delay_lower
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TX_PMD_MIN_DLY_15_0                        [15:0]           get_TX_PMD_MIN_DLY_15_0
''                                                             set_TX_PMD_MIN_DLY_15_0
''                                                             read_TX_PMD_MIN_DLY_15_0
''                                                             write_TX_PMD_MIN_DLY_15_0
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV1_pmd_ieee_tx_tsync_min_delay_lower
    Private write_TX_PMD_MIN_DLY_15_0_value
    Private read_TX_PMD_MIN_DLY_15_0_value
    Private flag_TX_PMD_MIN_DLY_15_0

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

    Property Get get_TX_PMD_MIN_DLY_15_0
        get_TX_PMD_MIN_DLY_15_0 = read_TX_PMD_MIN_DLY_15_0_value
    End Property

    Property Let set_TX_PMD_MIN_DLY_15_0(aData)
        write_TX_PMD_MIN_DLY_15_0_value = aData
        flag_TX_PMD_MIN_DLY_15_0        = &H1
    End Property

    Property Get read_TX_PMD_MIN_DLY_15_0
        read
        read_TX_PMD_MIN_DLY_15_0 = read_TX_PMD_MIN_DLY_15_0_value
    End Property

    Property Let write_TX_PMD_MIN_DLY_15_0(aData)
        set_TX_PMD_MIN_DLY_15_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TX_PMD_MIN_DLY_15_0_mask = &Hffff
        if data_low > LONG_MAX then
            if TX_PMD_MIN_DLY_15_0_mask = mask then
                read_TX_PMD_MIN_DLY_15_0_value = data_low
            else
                read_TX_PMD_MIN_DLY_15_0_value = (data_low - H8000_0000) and TX_PMD_MIN_DLY_15_0_mask
            end If
        else
            read_TX_PMD_MIN_DLY_15_0_value = data_low and TX_PMD_MIN_DLY_15_0_mask
        end If

    End Sub

    Sub write
        If flag_TX_PMD_MIN_DLY_15_0 = &H0 Then read
        If flag_TX_PMD_MIN_DLY_15_0 = &H0 Then write_TX_PMD_MIN_DLY_15_0_value = get_TX_PMD_MIN_DLY_15_0

        regValue = leftShift((write_TX_PMD_MIN_DLY_15_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TX_PMD_MIN_DLY_15_0_mask = &Hffff
        if data_low > LONG_MAX then
            if TX_PMD_MIN_DLY_15_0_mask = mask then
                read_TX_PMD_MIN_DLY_15_0_value = data_low
            else
                read_TX_PMD_MIN_DLY_15_0_value = (data_low - H8000_0000) and TX_PMD_MIN_DLY_15_0_mask
            end If
        else
            read_TX_PMD_MIN_DLY_15_0_value = data_low and TX_PMD_MIN_DLY_15_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TX_PMD_MIN_DLY_15_0_value = &H0
        flag_TX_PMD_MIN_DLY_15_0        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV1_pmd_ieee_tx_tsync_min_delay_upper
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TX_PMD_MIN_DLY_31_16                       [15:0]           get_TX_PMD_MIN_DLY_31_16
''                                                             set_TX_PMD_MIN_DLY_31_16
''                                                             read_TX_PMD_MIN_DLY_31_16
''                                                             write_TX_PMD_MIN_DLY_31_16
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV1_pmd_ieee_tx_tsync_min_delay_upper
    Private write_TX_PMD_MIN_DLY_31_16_value
    Private read_TX_PMD_MIN_DLY_31_16_value
    Private flag_TX_PMD_MIN_DLY_31_16

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

    Property Get get_TX_PMD_MIN_DLY_31_16
        get_TX_PMD_MIN_DLY_31_16 = read_TX_PMD_MIN_DLY_31_16_value
    End Property

    Property Let set_TX_PMD_MIN_DLY_31_16(aData)
        write_TX_PMD_MIN_DLY_31_16_value = aData
        flag_TX_PMD_MIN_DLY_31_16        = &H1
    End Property

    Property Get read_TX_PMD_MIN_DLY_31_16
        read
        read_TX_PMD_MIN_DLY_31_16 = read_TX_PMD_MIN_DLY_31_16_value
    End Property

    Property Let write_TX_PMD_MIN_DLY_31_16(aData)
        set_TX_PMD_MIN_DLY_31_16 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TX_PMD_MIN_DLY_31_16_mask = &Hffff
        if data_low > LONG_MAX then
            if TX_PMD_MIN_DLY_31_16_mask = mask then
                read_TX_PMD_MIN_DLY_31_16_value = data_low
            else
                read_TX_PMD_MIN_DLY_31_16_value = (data_low - H8000_0000) and TX_PMD_MIN_DLY_31_16_mask
            end If
        else
            read_TX_PMD_MIN_DLY_31_16_value = data_low and TX_PMD_MIN_DLY_31_16_mask
        end If

    End Sub

    Sub write
        If flag_TX_PMD_MIN_DLY_31_16 = &H0 Then read
        If flag_TX_PMD_MIN_DLY_31_16 = &H0 Then write_TX_PMD_MIN_DLY_31_16_value = get_TX_PMD_MIN_DLY_31_16

        regValue = leftShift((write_TX_PMD_MIN_DLY_31_16_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TX_PMD_MIN_DLY_31_16_mask = &Hffff
        if data_low > LONG_MAX then
            if TX_PMD_MIN_DLY_31_16_mask = mask then
                read_TX_PMD_MIN_DLY_31_16_value = data_low
            else
                read_TX_PMD_MIN_DLY_31_16_value = (data_low - H8000_0000) and TX_PMD_MIN_DLY_31_16_mask
            end If
        else
            read_TX_PMD_MIN_DLY_31_16_value = data_low and TX_PMD_MIN_DLY_31_16_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TX_PMD_MIN_DLY_31_16_value = &H0
        flag_TX_PMD_MIN_DLY_31_16        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV1_pmd_ieee_rx_tsync_max_delay_lower
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RX_PMD_MAX_DLY_15_0                        [15:0]           get_RX_PMD_MAX_DLY_15_0
''                                                             set_RX_PMD_MAX_DLY_15_0
''                                                             read_RX_PMD_MAX_DLY_15_0
''                                                             write_RX_PMD_MAX_DLY_15_0
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV1_pmd_ieee_rx_tsync_max_delay_lower
    Private write_RX_PMD_MAX_DLY_15_0_value
    Private read_RX_PMD_MAX_DLY_15_0_value
    Private flag_RX_PMD_MAX_DLY_15_0

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

    Property Get get_RX_PMD_MAX_DLY_15_0
        get_RX_PMD_MAX_DLY_15_0 = read_RX_PMD_MAX_DLY_15_0_value
    End Property

    Property Let set_RX_PMD_MAX_DLY_15_0(aData)
        write_RX_PMD_MAX_DLY_15_0_value = aData
        flag_RX_PMD_MAX_DLY_15_0        = &H1
    End Property

    Property Get read_RX_PMD_MAX_DLY_15_0
        read
        read_RX_PMD_MAX_DLY_15_0 = read_RX_PMD_MAX_DLY_15_0_value
    End Property

    Property Let write_RX_PMD_MAX_DLY_15_0(aData)
        set_RX_PMD_MAX_DLY_15_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RX_PMD_MAX_DLY_15_0_mask = &Hffff
        if data_low > LONG_MAX then
            if RX_PMD_MAX_DLY_15_0_mask = mask then
                read_RX_PMD_MAX_DLY_15_0_value = data_low
            else
                read_RX_PMD_MAX_DLY_15_0_value = (data_low - H8000_0000) and RX_PMD_MAX_DLY_15_0_mask
            end If
        else
            read_RX_PMD_MAX_DLY_15_0_value = data_low and RX_PMD_MAX_DLY_15_0_mask
        end If

    End Sub

    Sub write
        If flag_RX_PMD_MAX_DLY_15_0 = &H0 Then read
        If flag_RX_PMD_MAX_DLY_15_0 = &H0 Then write_RX_PMD_MAX_DLY_15_0_value = get_RX_PMD_MAX_DLY_15_0

        regValue = leftShift((write_RX_PMD_MAX_DLY_15_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RX_PMD_MAX_DLY_15_0_mask = &Hffff
        if data_low > LONG_MAX then
            if RX_PMD_MAX_DLY_15_0_mask = mask then
                read_RX_PMD_MAX_DLY_15_0_value = data_low
            else
                read_RX_PMD_MAX_DLY_15_0_value = (data_low - H8000_0000) and RX_PMD_MAX_DLY_15_0_mask
            end If
        else
            read_RX_PMD_MAX_DLY_15_0_value = data_low and RX_PMD_MAX_DLY_15_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RX_PMD_MAX_DLY_15_0_value = &H0
        flag_RX_PMD_MAX_DLY_15_0        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV1_pmd_ieee_rx_tsync_max_delay_upper
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RX_PMD_MAX_DLY_31_16                       [15:0]           get_RX_PMD_MAX_DLY_31_16
''                                                             set_RX_PMD_MAX_DLY_31_16
''                                                             read_RX_PMD_MAX_DLY_31_16
''                                                             write_RX_PMD_MAX_DLY_31_16
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV1_pmd_ieee_rx_tsync_max_delay_upper
    Private write_RX_PMD_MAX_DLY_31_16_value
    Private read_RX_PMD_MAX_DLY_31_16_value
    Private flag_RX_PMD_MAX_DLY_31_16

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

    Property Get get_RX_PMD_MAX_DLY_31_16
        get_RX_PMD_MAX_DLY_31_16 = read_RX_PMD_MAX_DLY_31_16_value
    End Property

    Property Let set_RX_PMD_MAX_DLY_31_16(aData)
        write_RX_PMD_MAX_DLY_31_16_value = aData
        flag_RX_PMD_MAX_DLY_31_16        = &H1
    End Property

    Property Get read_RX_PMD_MAX_DLY_31_16
        read
        read_RX_PMD_MAX_DLY_31_16 = read_RX_PMD_MAX_DLY_31_16_value
    End Property

    Property Let write_RX_PMD_MAX_DLY_31_16(aData)
        set_RX_PMD_MAX_DLY_31_16 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RX_PMD_MAX_DLY_31_16_mask = &Hffff
        if data_low > LONG_MAX then
            if RX_PMD_MAX_DLY_31_16_mask = mask then
                read_RX_PMD_MAX_DLY_31_16_value = data_low
            else
                read_RX_PMD_MAX_DLY_31_16_value = (data_low - H8000_0000) and RX_PMD_MAX_DLY_31_16_mask
            end If
        else
            read_RX_PMD_MAX_DLY_31_16_value = data_low and RX_PMD_MAX_DLY_31_16_mask
        end If

    End Sub

    Sub write
        If flag_RX_PMD_MAX_DLY_31_16 = &H0 Then read
        If flag_RX_PMD_MAX_DLY_31_16 = &H0 Then write_RX_PMD_MAX_DLY_31_16_value = get_RX_PMD_MAX_DLY_31_16

        regValue = leftShift((write_RX_PMD_MAX_DLY_31_16_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RX_PMD_MAX_DLY_31_16_mask = &Hffff
        if data_low > LONG_MAX then
            if RX_PMD_MAX_DLY_31_16_mask = mask then
                read_RX_PMD_MAX_DLY_31_16_value = data_low
            else
                read_RX_PMD_MAX_DLY_31_16_value = (data_low - H8000_0000) and RX_PMD_MAX_DLY_31_16_mask
            end If
        else
            read_RX_PMD_MAX_DLY_31_16_value = data_low and RX_PMD_MAX_DLY_31_16_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RX_PMD_MAX_DLY_31_16_value = &H0
        flag_RX_PMD_MAX_DLY_31_16        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV1_pmd_ieee_rx_tsync_min_delay_lower
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RX_PMD_MIN_DLY_15_0                        [15:0]           get_RX_PMD_MIN_DLY_15_0
''                                                             set_RX_PMD_MIN_DLY_15_0
''                                                             read_RX_PMD_MIN_DLY_15_0
''                                                             write_RX_PMD_MIN_DLY_15_0
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV1_pmd_ieee_rx_tsync_min_delay_lower
    Private write_RX_PMD_MIN_DLY_15_0_value
    Private read_RX_PMD_MIN_DLY_15_0_value
    Private flag_RX_PMD_MIN_DLY_15_0

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

    Property Get get_RX_PMD_MIN_DLY_15_0
        get_RX_PMD_MIN_DLY_15_0 = read_RX_PMD_MIN_DLY_15_0_value
    End Property

    Property Let set_RX_PMD_MIN_DLY_15_0(aData)
        write_RX_PMD_MIN_DLY_15_0_value = aData
        flag_RX_PMD_MIN_DLY_15_0        = &H1
    End Property

    Property Get read_RX_PMD_MIN_DLY_15_0
        read
        read_RX_PMD_MIN_DLY_15_0 = read_RX_PMD_MIN_DLY_15_0_value
    End Property

    Property Let write_RX_PMD_MIN_DLY_15_0(aData)
        set_RX_PMD_MIN_DLY_15_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RX_PMD_MIN_DLY_15_0_mask = &Hffff
        if data_low > LONG_MAX then
            if RX_PMD_MIN_DLY_15_0_mask = mask then
                read_RX_PMD_MIN_DLY_15_0_value = data_low
            else
                read_RX_PMD_MIN_DLY_15_0_value = (data_low - H8000_0000) and RX_PMD_MIN_DLY_15_0_mask
            end If
        else
            read_RX_PMD_MIN_DLY_15_0_value = data_low and RX_PMD_MIN_DLY_15_0_mask
        end If

    End Sub

    Sub write
        If flag_RX_PMD_MIN_DLY_15_0 = &H0 Then read
        If flag_RX_PMD_MIN_DLY_15_0 = &H0 Then write_RX_PMD_MIN_DLY_15_0_value = get_RX_PMD_MIN_DLY_15_0

        regValue = leftShift((write_RX_PMD_MIN_DLY_15_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RX_PMD_MIN_DLY_15_0_mask = &Hffff
        if data_low > LONG_MAX then
            if RX_PMD_MIN_DLY_15_0_mask = mask then
                read_RX_PMD_MIN_DLY_15_0_value = data_low
            else
                read_RX_PMD_MIN_DLY_15_0_value = (data_low - H8000_0000) and RX_PMD_MIN_DLY_15_0_mask
            end If
        else
            read_RX_PMD_MIN_DLY_15_0_value = data_low and RX_PMD_MIN_DLY_15_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RX_PMD_MIN_DLY_15_0_value = &H0
        flag_RX_PMD_MIN_DLY_15_0        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV1_pmd_ieee_rx_tsync_min_delay_upper
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RX_PMD_MIN_DLY_31_16                       [15:0]           get_RX_PMD_MIN_DLY_31_16
''                                                             set_RX_PMD_MIN_DLY_31_16
''                                                             read_RX_PMD_MIN_DLY_31_16
''                                                             write_RX_PMD_MIN_DLY_31_16
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV1_pmd_ieee_rx_tsync_min_delay_upper
    Private write_RX_PMD_MIN_DLY_31_16_value
    Private read_RX_PMD_MIN_DLY_31_16_value
    Private flag_RX_PMD_MIN_DLY_31_16

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

    Property Get get_RX_PMD_MIN_DLY_31_16
        get_RX_PMD_MIN_DLY_31_16 = read_RX_PMD_MIN_DLY_31_16_value
    End Property

    Property Let set_RX_PMD_MIN_DLY_31_16(aData)
        write_RX_PMD_MIN_DLY_31_16_value = aData
        flag_RX_PMD_MIN_DLY_31_16        = &H1
    End Property

    Property Get read_RX_PMD_MIN_DLY_31_16
        read
        read_RX_PMD_MIN_DLY_31_16 = read_RX_PMD_MIN_DLY_31_16_value
    End Property

    Property Let write_RX_PMD_MIN_DLY_31_16(aData)
        set_RX_PMD_MIN_DLY_31_16 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RX_PMD_MIN_DLY_31_16_mask = &Hffff
        if data_low > LONG_MAX then
            if RX_PMD_MIN_DLY_31_16_mask = mask then
                read_RX_PMD_MIN_DLY_31_16_value = data_low
            else
                read_RX_PMD_MIN_DLY_31_16_value = (data_low - H8000_0000) and RX_PMD_MIN_DLY_31_16_mask
            end If
        else
            read_RX_PMD_MIN_DLY_31_16_value = data_low and RX_PMD_MIN_DLY_31_16_mask
        end If

    End Sub

    Sub write
        If flag_RX_PMD_MIN_DLY_31_16 = &H0 Then read
        If flag_RX_PMD_MIN_DLY_31_16 = &H0 Then write_RX_PMD_MIN_DLY_31_16_value = get_RX_PMD_MIN_DLY_31_16

        regValue = leftShift((write_RX_PMD_MIN_DLY_31_16_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RX_PMD_MIN_DLY_31_16_mask = &Hffff
        if data_low > LONG_MAX then
            if RX_PMD_MIN_DLY_31_16_mask = mask then
                read_RX_PMD_MIN_DLY_31_16_value = data_low
            else
                read_RX_PMD_MIN_DLY_31_16_value = (data_low - H8000_0000) and RX_PMD_MIN_DLY_31_16_mask
            end If
        else
            read_RX_PMD_MIN_DLY_31_16_value = data_low and RX_PMD_MIN_DLY_31_16_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RX_PMD_MIN_DLY_31_16_value = &H0
        flag_RX_PMD_MIN_DLY_31_16        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV1_pmd_ieee_ctl_t1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PMD_IEEE_CTL_T1_BIT_15                     [15:15]          get_PMD_IEEE_CTL_T1_BIT_15
''                                                             set_PMD_IEEE_CTL_T1_BIT_15
''                                                             read_PMD_IEEE_CTL_T1_BIT_15
''                                                             write_PMD_IEEE_CTL_T1_BIT_15
''---------------------------------------------------------------------------------
'' MS_MAN_CFG_VAL                             [14:14]          get_MS_MAN_CFG_VAL
''                                                             set_MS_MAN_CFG_VAL
''                                                             read_MS_MAN_CFG_VAL
''                                                             write_MS_MAN_CFG_VAL
''---------------------------------------------------------------------------------
'' Reserved                                   [13:4]           get_Reserved
''                                                             set_Reserved
''                                                             read_Reserved
''                                                             write_Reserved
''---------------------------------------------------------------------------------
'' TYPE_SELECT                                [3:0]            get_TYPE_SELECT
''                                                             set_TYPE_SELECT
''                                                             read_TYPE_SELECT
''                                                             write_TYPE_SELECT
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV1_pmd_ieee_ctl_t1
    Private write_PMD_IEEE_CTL_T1_BIT_15_value
    Private read_PMD_IEEE_CTL_T1_BIT_15_value
    Private flag_PMD_IEEE_CTL_T1_BIT_15
    Private write_MS_MAN_CFG_VAL_value
    Private read_MS_MAN_CFG_VAL_value
    Private flag_MS_MAN_CFG_VAL
    Private write_Reserved_value
    Private read_Reserved_value
    Private flag_Reserved
    Private write_TYPE_SELECT_value
    Private read_TYPE_SELECT_value
    Private flag_TYPE_SELECT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1068
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PMD_IEEE_CTL_T1_BIT_15
        get_PMD_IEEE_CTL_T1_BIT_15 = read_PMD_IEEE_CTL_T1_BIT_15_value
    End Property

    Property Let set_PMD_IEEE_CTL_T1_BIT_15(aData)
        write_PMD_IEEE_CTL_T1_BIT_15_value = aData
        flag_PMD_IEEE_CTL_T1_BIT_15        = &H1
    End Property

    Property Get read_PMD_IEEE_CTL_T1_BIT_15
        read
        read_PMD_IEEE_CTL_T1_BIT_15 = read_PMD_IEEE_CTL_T1_BIT_15_value
    End Property

    Property Let write_PMD_IEEE_CTL_T1_BIT_15(aData)
        set_PMD_IEEE_CTL_T1_BIT_15 = aData
        write
    End Property

    Property Get get_MS_MAN_CFG_VAL
        get_MS_MAN_CFG_VAL = read_MS_MAN_CFG_VAL_value
    End Property

    Property Let set_MS_MAN_CFG_VAL(aData)
        write_MS_MAN_CFG_VAL_value = aData
        flag_MS_MAN_CFG_VAL        = &H1
    End Property

    Property Get read_MS_MAN_CFG_VAL
        read
        read_MS_MAN_CFG_VAL = read_MS_MAN_CFG_VAL_value
    End Property

    Property Let write_MS_MAN_CFG_VAL(aData)
        set_MS_MAN_CFG_VAL = aData
        write
    End Property

    Property Get get_Reserved
        get_Reserved = read_Reserved_value
    End Property

    Property Let set_Reserved(aData)
        write_Reserved_value = aData
        flag_Reserved        = &H1
    End Property

    Property Get read_Reserved
        read
        read_Reserved = read_Reserved_value
    End Property

    Property Let write_Reserved(aData)
        set_Reserved = aData
        write
    End Property

    Property Get get_TYPE_SELECT
        get_TYPE_SELECT = read_TYPE_SELECT_value
    End Property

    Property Let set_TYPE_SELECT(aData)
        write_TYPE_SELECT_value = aData
        flag_TYPE_SELECT        = &H1
    End Property

    Property Get read_TYPE_SELECT
        read
        read_TYPE_SELECT = read_TYPE_SELECT_value
    End Property

    Property Let write_TYPE_SELECT(aData)
        set_TYPE_SELECT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PMD_IEEE_CTL_T1_BIT_15_value = rightShift(data_low, 15) and &H1
        read_MS_MAN_CFG_VAL_value = rightShift(data_low, 14) and &H1
        read_Reserved_value = rightShift(data_low, 4) and &H3ff
        TYPE_SELECT_mask = &Hf
        if data_low > LONG_MAX then
            if TYPE_SELECT_mask = mask then
                read_TYPE_SELECT_value = data_low
            else
                read_TYPE_SELECT_value = (data_low - H8000_0000) and TYPE_SELECT_mask
            end If
        else
            read_TYPE_SELECT_value = data_low and TYPE_SELECT_mask
        end If

    End Sub

    Sub write
        If flag_PMD_IEEE_CTL_T1_BIT_15 = &H0 or flag_MS_MAN_CFG_VAL = &H0 or flag_Reserved = &H0 or flag_TYPE_SELECT = &H0 Then read
        If flag_PMD_IEEE_CTL_T1_BIT_15 = &H0 Then write_PMD_IEEE_CTL_T1_BIT_15_value = get_PMD_IEEE_CTL_T1_BIT_15
        If flag_MS_MAN_CFG_VAL = &H0 Then write_MS_MAN_CFG_VAL_value = get_MS_MAN_CFG_VAL
        If flag_Reserved = &H0 Then write_Reserved_value = get_Reserved
        If flag_TYPE_SELECT = &H0 Then write_TYPE_SELECT_value = get_TYPE_SELECT

        regValue = leftShift((write_PMD_IEEE_CTL_T1_BIT_15_value and &H1), 15) + leftShift((write_MS_MAN_CFG_VAL_value and &H1), 14) + leftShift((write_Reserved_value and &H3ff), 4) + leftShift((write_TYPE_SELECT_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PMD_IEEE_CTL_T1_BIT_15_value = rightShift(data_low, 15) and &H1
        read_MS_MAN_CFG_VAL_value = rightShift(data_low, 14) and &H1
        read_Reserved_value = rightShift(data_low, 4) and &H3ff
        TYPE_SELECT_mask = &Hf
        if data_low > LONG_MAX then
            if TYPE_SELECT_mask = mask then
                read_TYPE_SELECT_value = data_low
            else
                read_TYPE_SELECT_value = (data_low - H8000_0000) and TYPE_SELECT_mask
            end If
        else
            read_TYPE_SELECT_value = data_low and TYPE_SELECT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PMD_IEEE_CTL_T1_BIT_15_value = &H0
        flag_PMD_IEEE_CTL_T1_BIT_15        = &H0
        write_MS_MAN_CFG_VAL_value = &H0
        flag_MS_MAN_CFG_VAL        = &H0
        write_Reserved_value = &H0
        flag_Reserved        = &H0
        write_TYPE_SELECT_value = &H0
        flag_TYPE_SELECT        = &H0
    End Sub
End Class


'' @REGISTER : CL45DEV1_pmd_ieee_test_t1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PMA100BASET1_TEST_CTRL                     [15:13]          get_PMA100BASET1_TEST_CTRL
''                                                             set_PMA100BASET1_TEST_CTRL
''                                                             read_PMA100BASET1_TEST_CTRL
''                                                             write_PMA100BASET1_TEST_CTRL
''---------------------------------------------------------------------------------
'' Reserved                                   [12:0]           get_Reserved
''                                                             set_Reserved
''                                                             read_Reserved
''                                                             write_Reserved
''---------------------------------------------------------------------------------
Class REGISTER_CL45DEV1_pmd_ieee_test_t1
    Private write_PMA100BASET1_TEST_CTRL_value
    Private read_PMA100BASET1_TEST_CTRL_value
    Private flag_PMA100BASET1_TEST_CTRL
    Private write_Reserved_value
    Private read_Reserved_value
    Private flag_Reserved

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H106c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PMA100BASET1_TEST_CTRL
        get_PMA100BASET1_TEST_CTRL = read_PMA100BASET1_TEST_CTRL_value
    End Property

    Property Let set_PMA100BASET1_TEST_CTRL(aData)
        write_PMA100BASET1_TEST_CTRL_value = aData
        flag_PMA100BASET1_TEST_CTRL        = &H1
    End Property

    Property Get read_PMA100BASET1_TEST_CTRL
        read
        read_PMA100BASET1_TEST_CTRL = read_PMA100BASET1_TEST_CTRL_value
    End Property

    Property Let write_PMA100BASET1_TEST_CTRL(aData)
        set_PMA100BASET1_TEST_CTRL = aData
        write
    End Property

    Property Get get_Reserved
        get_Reserved = read_Reserved_value
    End Property

    Property Let set_Reserved(aData)
        write_Reserved_value = aData
        flag_Reserved        = &H1
    End Property

    Property Get read_Reserved
        read
        read_Reserved = read_Reserved_value
    End Property

    Property Let write_Reserved(aData)
        set_Reserved = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PMA100BASET1_TEST_CTRL_value = rightShift(data_low, 13) and &H7
        Reserved_mask = &H1fff
        if data_low > LONG_MAX then
            if Reserved_mask = mask then
                read_Reserved_value = data_low
            else
                read_Reserved_value = (data_low - H8000_0000) and Reserved_mask
            end If
        else
            read_Reserved_value = data_low and Reserved_mask
        end If

    End Sub

    Sub write
        If flag_PMA100BASET1_TEST_CTRL = &H0 or flag_Reserved = &H0 Then read
        If flag_PMA100BASET1_TEST_CTRL = &H0 Then write_PMA100BASET1_TEST_CTRL_value = get_PMA100BASET1_TEST_CTRL
        If flag_Reserved = &H0 Then write_Reserved_value = get_Reserved

        regValue = leftShift((write_PMA100BASET1_TEST_CTRL_value and &H7), 13) + leftShift((write_Reserved_value and &H1fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PMA100BASET1_TEST_CTRL_value = rightShift(data_low, 13) and &H7
        Reserved_mask = &H1fff
        if data_low > LONG_MAX then
            if Reserved_mask = mask then
                read_Reserved_value = data_low
            else
                read_Reserved_value = (data_low - H8000_0000) and Reserved_mask
            end If
        else
            read_Reserved_value = data_low and Reserved_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PMA100BASET1_TEST_CTRL_value = &H0
        flag_PMA100BASET1_TEST_CTRL        = &H0
        write_Reserved_value = &H0
        flag_Reserved        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class CL45DEV1_INSTANCE

    Public pmd_ieee_ctl1
    Public pmd_ieee_st1
    Public pmd_ieee_dev_id0
    Public pmd_ieee_dev_id1
    Public pmd_ieee_dev0
    Public pmd_ieee_dev1
    Public pmd_ieee_ctl2
    Public pmd_ieee_st2
    Public pmd_ieee_tx_disable
    Public pmd_ieee_rx_sigdet
    Public pmd_ieee_ext_ability
    Public pmd_ieee_pkg_id0
    Public pmd_ieee_pkg_id1
    Public pmd_ieee_ext_ability_t1
    Public pmd_ieee_tsync_cap
    Public pmd_ieee_tx_tsync_max_delay_lower
    Public pmd_ieee_tx_tsync_max_delay_upper
    Public pmd_ieee_tx_tsync_min_delay_lower
    Public pmd_ieee_tx_tsync_min_delay_upper
    Public pmd_ieee_rx_tsync_max_delay_lower
    Public pmd_ieee_rx_tsync_max_delay_upper
    Public pmd_ieee_rx_tsync_min_delay_lower
    Public pmd_ieee_rx_tsync_min_delay_upper
    Public pmd_ieee_ctl_t1
    Public pmd_ieee_test_t1


    Public default function Init(aBaseAddr)
        Set pmd_ieee_ctl1 = (New REGISTER_CL45DEV1_pmd_ieee_ctl1)(aBaseAddr, 16)
        Set pmd_ieee_st1 = (New REGISTER_CL45DEV1_pmd_ieee_st1)(aBaseAddr, 16)
        Set pmd_ieee_dev_id0 = (New REGISTER_CL45DEV1_pmd_ieee_dev_id0)(aBaseAddr, 16)
        Set pmd_ieee_dev_id1 = (New REGISTER_CL45DEV1_pmd_ieee_dev_id1)(aBaseAddr, 16)
        Set pmd_ieee_dev0 = (New REGISTER_CL45DEV1_pmd_ieee_dev0)(aBaseAddr, 16)
        Set pmd_ieee_dev1 = (New REGISTER_CL45DEV1_pmd_ieee_dev1)(aBaseAddr, 16)
        Set pmd_ieee_ctl2 = (New REGISTER_CL45DEV1_pmd_ieee_ctl2)(aBaseAddr, 16)
        Set pmd_ieee_st2 = (New REGISTER_CL45DEV1_pmd_ieee_st2)(aBaseAddr, 16)
        Set pmd_ieee_tx_disable = (New REGISTER_CL45DEV1_pmd_ieee_tx_disable)(aBaseAddr, 16)
        Set pmd_ieee_rx_sigdet = (New REGISTER_CL45DEV1_pmd_ieee_rx_sigdet)(aBaseAddr, 16)
        Set pmd_ieee_ext_ability = (New REGISTER_CL45DEV1_pmd_ieee_ext_ability)(aBaseAddr, 16)
        Set pmd_ieee_pkg_id0 = (New REGISTER_CL45DEV1_pmd_ieee_pkg_id0)(aBaseAddr, 16)
        Set pmd_ieee_pkg_id1 = (New REGISTER_CL45DEV1_pmd_ieee_pkg_id1)(aBaseAddr, 16)
        Set pmd_ieee_ext_ability_t1 = (New REGISTER_CL45DEV1_pmd_ieee_ext_ability_t1)(aBaseAddr, 16)
        Set pmd_ieee_tsync_cap = (New REGISTER_CL45DEV1_pmd_ieee_tsync_cap)(aBaseAddr, 16)
        Set pmd_ieee_tx_tsync_max_delay_lower = (New REGISTER_CL45DEV1_pmd_ieee_tx_tsync_max_delay_lower)(aBaseAddr, 16)
        Set pmd_ieee_tx_tsync_max_delay_upper = (New REGISTER_CL45DEV1_pmd_ieee_tx_tsync_max_delay_upper)(aBaseAddr, 16)
        Set pmd_ieee_tx_tsync_min_delay_lower = (New REGISTER_CL45DEV1_pmd_ieee_tx_tsync_min_delay_lower)(aBaseAddr, 16)
        Set pmd_ieee_tx_tsync_min_delay_upper = (New REGISTER_CL45DEV1_pmd_ieee_tx_tsync_min_delay_upper)(aBaseAddr, 16)
        Set pmd_ieee_rx_tsync_max_delay_lower = (New REGISTER_CL45DEV1_pmd_ieee_rx_tsync_max_delay_lower)(aBaseAddr, 16)
        Set pmd_ieee_rx_tsync_max_delay_upper = (New REGISTER_CL45DEV1_pmd_ieee_rx_tsync_max_delay_upper)(aBaseAddr, 16)
        Set pmd_ieee_rx_tsync_min_delay_lower = (New REGISTER_CL45DEV1_pmd_ieee_rx_tsync_min_delay_lower)(aBaseAddr, 16)
        Set pmd_ieee_rx_tsync_min_delay_upper = (New REGISTER_CL45DEV1_pmd_ieee_rx_tsync_min_delay_upper)(aBaseAddr, 16)
        Set pmd_ieee_ctl_t1 = (New REGISTER_CL45DEV1_pmd_ieee_ctl_t1)(aBaseAddr, 16)
        Set pmd_ieee_test_t1 = (New REGISTER_CL45DEV1_pmd_ieee_test_t1)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set CL45DEV1 = CreateObject("System.Collections.ArrayList")
CL45DEV1.Add ((New CL45DEV1_INSTANCE)(&H4a420000))
CL45DEV1.Add ((New CL45DEV1_INSTANCE)(&H49420000))
CL45DEV1.Add ((New CL45DEV1_INSTANCE)(&H49820000))
CL45DEV1.Add ((New CL45DEV1_INSTANCE)(&H49c20000))
CL45DEV1.Add ((New CL45DEV1_INSTANCE)(&H4a020000))


