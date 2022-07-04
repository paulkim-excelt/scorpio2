

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


'' @REGISTER : PCIE6__SGMIIPCIE_X1_refclksense_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mdio_RefclkSenseReqOvrdSel                 [14:14]          get_mdio_RefclkSenseReqOvrdSel
''                                                             set_mdio_RefclkSenseReqOvrdSel
''                                                             read_mdio_RefclkSenseReqOvrdSel
''                                                             write_mdio_RefclkSenseReqOvrdSel
''---------------------------------------------------------------------------------
'' mdio_RefclkSenseReqOvrdVal                 [13:13]          get_mdio_RefclkSenseReqOvrdVal
''                                                             set_mdio_RefclkSenseReqOvrdVal
''                                                             read_mdio_RefclkSenseReqOvrdVal
''                                                             write_mdio_RefclkSenseReqOvrdVal
''---------------------------------------------------------------------------------
'' mdio_RefclkSenseTimeoutSel                 [12:12]          get_mdio_RefclkSenseTimeoutSel
''                                                             set_mdio_RefclkSenseTimeoutSel
''                                                             read_mdio_RefclkSenseTimeoutSel
''                                                             write_mdio_RefclkSenseTimeoutSel
''---------------------------------------------------------------------------------
'' ssc_clock_divider_37p4MHz                  [11:8]           get_ssc_clock_divider_37p4MHz
''                                                             set_ssc_clock_divider_37p4MHz
''                                                             read_ssc_clock_divider_37p4MHz
''                                                             write_ssc_clock_divider_37p4MHz
''---------------------------------------------------------------------------------
'' ssc_limit_37p4MHz_1                        [7:5]            get_ssc_limit_37p4MHz_1
''                                                             set_ssc_limit_37p4MHz_1
''                                                             read_ssc_limit_37p4MHz_1
''                                                             write_ssc_limit_37p4MHz_1
''---------------------------------------------------------------------------------
'' MWA271OS                                   [4:4]            get_MWA271OS
''                                                             set_MWA271OS
''                                                             read_MWA271OS
''                                                             write_MWA271OS
''---------------------------------------------------------------------------------
'' MWA271OV                                   [3:3]            get_MWA271OV
''                                                             set_MWA271OV
''                                                             read_MWA271OV
''                                                             write_MWA271OV
''---------------------------------------------------------------------------------
'' mdio_RefclkSenseBypass                     [2:2]            get_mdio_RefclkSenseBypass
''                                                             set_mdio_RefclkSenseBypass
''                                                             read_mdio_RefclkSenseBypass
''                                                             write_mdio_RefclkSenseBypass
''---------------------------------------------------------------------------------
'' mdio_RefclkSense_onecomp                   [1:1]            get_mdio_RefclkSense_onecomp
''                                                             set_mdio_RefclkSense_onecomp
''                                                             read_mdio_RefclkSense_onecomp
''                                                             write_mdio_RefclkSense_onecomp
''---------------------------------------------------------------------------------
'' mdio_RefclkSenseEventClr                   [0:0]            get_mdio_RefclkSenseEventClr
''                                                             set_mdio_RefclkSenseEventClr
''                                                             read_mdio_RefclkSenseEventClr
''                                                             write_mdio_RefclkSenseEventClr
''---------------------------------------------------------------------------------
Class REGISTER_PCIE6__SGMIIPCIE_X1_refclksense_ctrl
    Private write_mdio_RefclkSenseReqOvrdSel_value
    Private read_mdio_RefclkSenseReqOvrdSel_value
    Private flag_mdio_RefclkSenseReqOvrdSel
    Private write_mdio_RefclkSenseReqOvrdVal_value
    Private read_mdio_RefclkSenseReqOvrdVal_value
    Private flag_mdio_RefclkSenseReqOvrdVal
    Private write_mdio_RefclkSenseTimeoutSel_value
    Private read_mdio_RefclkSenseTimeoutSel_value
    Private flag_mdio_RefclkSenseTimeoutSel
    Private write_ssc_clock_divider_37p4MHz_value
    Private read_ssc_clock_divider_37p4MHz_value
    Private flag_ssc_clock_divider_37p4MHz
    Private write_ssc_limit_37p4MHz_1_value
    Private read_ssc_limit_37p4MHz_1_value
    Private flag_ssc_limit_37p4MHz_1
    Private write_MWA271OS_value
    Private read_MWA271OS_value
    Private flag_MWA271OS
    Private write_MWA271OV_value
    Private read_MWA271OV_value
    Private flag_MWA271OV
    Private write_mdio_RefclkSenseBypass_value
    Private read_mdio_RefclkSenseBypass_value
    Private flag_mdio_RefclkSenseBypass
    Private write_mdio_RefclkSense_onecomp_value
    Private read_mdio_RefclkSense_onecomp_value
    Private flag_mdio_RefclkSense_onecomp
    Private write_mdio_RefclkSenseEventClr_value
    Private read_mdio_RefclkSenseEventClr_value
    Private flag_mdio_RefclkSenseEventClr

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

    Property Get get_mdio_RefclkSenseReqOvrdSel
        get_mdio_RefclkSenseReqOvrdSel = read_mdio_RefclkSenseReqOvrdSel_value
    End Property

    Property Let set_mdio_RefclkSenseReqOvrdSel(aData)
        write_mdio_RefclkSenseReqOvrdSel_value = aData
        flag_mdio_RefclkSenseReqOvrdSel        = &H1
    End Property

    Property Get read_mdio_RefclkSenseReqOvrdSel
        read
        read_mdio_RefclkSenseReqOvrdSel = read_mdio_RefclkSenseReqOvrdSel_value
    End Property

    Property Let write_mdio_RefclkSenseReqOvrdSel(aData)
        set_mdio_RefclkSenseReqOvrdSel = aData
        write
    End Property

    Property Get get_mdio_RefclkSenseReqOvrdVal
        get_mdio_RefclkSenseReqOvrdVal = read_mdio_RefclkSenseReqOvrdVal_value
    End Property

    Property Let set_mdio_RefclkSenseReqOvrdVal(aData)
        write_mdio_RefclkSenseReqOvrdVal_value = aData
        flag_mdio_RefclkSenseReqOvrdVal        = &H1
    End Property

    Property Get read_mdio_RefclkSenseReqOvrdVal
        read
        read_mdio_RefclkSenseReqOvrdVal = read_mdio_RefclkSenseReqOvrdVal_value
    End Property

    Property Let write_mdio_RefclkSenseReqOvrdVal(aData)
        set_mdio_RefclkSenseReqOvrdVal = aData
        write
    End Property

    Property Get get_mdio_RefclkSenseTimeoutSel
        get_mdio_RefclkSenseTimeoutSel = read_mdio_RefclkSenseTimeoutSel_value
    End Property

    Property Let set_mdio_RefclkSenseTimeoutSel(aData)
        write_mdio_RefclkSenseTimeoutSel_value = aData
        flag_mdio_RefclkSenseTimeoutSel        = &H1
    End Property

    Property Get read_mdio_RefclkSenseTimeoutSel
        read
        read_mdio_RefclkSenseTimeoutSel = read_mdio_RefclkSenseTimeoutSel_value
    End Property

    Property Let write_mdio_RefclkSenseTimeoutSel(aData)
        set_mdio_RefclkSenseTimeoutSel = aData
        write
    End Property

    Property Get get_ssc_clock_divider_37p4MHz
        get_ssc_clock_divider_37p4MHz = read_ssc_clock_divider_37p4MHz_value
    End Property

    Property Let set_ssc_clock_divider_37p4MHz(aData)
        write_ssc_clock_divider_37p4MHz_value = aData
        flag_ssc_clock_divider_37p4MHz        = &H1
    End Property

    Property Get read_ssc_clock_divider_37p4MHz
        read
        read_ssc_clock_divider_37p4MHz = read_ssc_clock_divider_37p4MHz_value
    End Property

    Property Let write_ssc_clock_divider_37p4MHz(aData)
        set_ssc_clock_divider_37p4MHz = aData
        write
    End Property

    Property Get get_ssc_limit_37p4MHz_1
        get_ssc_limit_37p4MHz_1 = read_ssc_limit_37p4MHz_1_value
    End Property

    Property Let set_ssc_limit_37p4MHz_1(aData)
        write_ssc_limit_37p4MHz_1_value = aData
        flag_ssc_limit_37p4MHz_1        = &H1
    End Property

    Property Get read_ssc_limit_37p4MHz_1
        read
        read_ssc_limit_37p4MHz_1 = read_ssc_limit_37p4MHz_1_value
    End Property

    Property Let write_ssc_limit_37p4MHz_1(aData)
        set_ssc_limit_37p4MHz_1 = aData
        write
    End Property

    Property Get get_MWA271OS
        get_MWA271OS = read_MWA271OS_value
    End Property

    Property Let set_MWA271OS(aData)
        write_MWA271OS_value = aData
        flag_MWA271OS        = &H1
    End Property

    Property Get read_MWA271OS
        read
        read_MWA271OS = read_MWA271OS_value
    End Property

    Property Let write_MWA271OS(aData)
        set_MWA271OS = aData
        write
    End Property

    Property Get get_MWA271OV
        get_MWA271OV = read_MWA271OV_value
    End Property

    Property Let set_MWA271OV(aData)
        write_MWA271OV_value = aData
        flag_MWA271OV        = &H1
    End Property

    Property Get read_MWA271OV
        read
        read_MWA271OV = read_MWA271OV_value
    End Property

    Property Let write_MWA271OV(aData)
        set_MWA271OV = aData
        write
    End Property

    Property Get get_mdio_RefclkSenseBypass
        get_mdio_RefclkSenseBypass = read_mdio_RefclkSenseBypass_value
    End Property

    Property Let set_mdio_RefclkSenseBypass(aData)
        write_mdio_RefclkSenseBypass_value = aData
        flag_mdio_RefclkSenseBypass        = &H1
    End Property

    Property Get read_mdio_RefclkSenseBypass
        read
        read_mdio_RefclkSenseBypass = read_mdio_RefclkSenseBypass_value
    End Property

    Property Let write_mdio_RefclkSenseBypass(aData)
        set_mdio_RefclkSenseBypass = aData
        write
    End Property

    Property Get get_mdio_RefclkSense_onecomp
        get_mdio_RefclkSense_onecomp = read_mdio_RefclkSense_onecomp_value
    End Property

    Property Let set_mdio_RefclkSense_onecomp(aData)
        write_mdio_RefclkSense_onecomp_value = aData
        flag_mdio_RefclkSense_onecomp        = &H1
    End Property

    Property Get read_mdio_RefclkSense_onecomp
        read
        read_mdio_RefclkSense_onecomp = read_mdio_RefclkSense_onecomp_value
    End Property

    Property Let write_mdio_RefclkSense_onecomp(aData)
        set_mdio_RefclkSense_onecomp = aData
        write
    End Property

    Property Get get_mdio_RefclkSenseEventClr
        get_mdio_RefclkSenseEventClr = read_mdio_RefclkSenseEventClr_value
    End Property

    Property Let set_mdio_RefclkSenseEventClr(aData)
        write_mdio_RefclkSenseEventClr_value = aData
        flag_mdio_RefclkSenseEventClr        = &H1
    End Property

    Property Get read_mdio_RefclkSenseEventClr
        read
        read_mdio_RefclkSenseEventClr = read_mdio_RefclkSenseEventClr_value
    End Property

    Property Let write_mdio_RefclkSenseEventClr(aData)
        set_mdio_RefclkSenseEventClr = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mdio_RefclkSenseReqOvrdSel_value = rightShift(data_low, 14) and &H1
        read_mdio_RefclkSenseReqOvrdVal_value = rightShift(data_low, 13) and &H1
        read_mdio_RefclkSenseTimeoutSel_value = rightShift(data_low, 12) and &H1
        read_ssc_clock_divider_37p4MHz_value = rightShift(data_low, 8) and &Hf
        read_ssc_limit_37p4MHz_1_value = rightShift(data_low, 5) and &H7
        read_MWA271OS_value = rightShift(data_low, 4) and &H1
        read_MWA271OV_value = rightShift(data_low, 3) and &H1
        read_mdio_RefclkSenseBypass_value = rightShift(data_low, 2) and &H1
        read_mdio_RefclkSense_onecomp_value = rightShift(data_low, 1) and &H1
        mdio_RefclkSenseEventClr_mask = &H1
        if data_low > LONG_MAX then
            if mdio_RefclkSenseEventClr_mask = mask then
                read_mdio_RefclkSenseEventClr_value = data_low
            else
                read_mdio_RefclkSenseEventClr_value = (data_low - H8000_0000) and mdio_RefclkSenseEventClr_mask
            end If
        else
            read_mdio_RefclkSenseEventClr_value = data_low and mdio_RefclkSenseEventClr_mask
        end If

    End Sub

    Sub write
        If flag_mdio_RefclkSenseReqOvrdSel = &H0 or flag_mdio_RefclkSenseReqOvrdVal = &H0 or flag_mdio_RefclkSenseTimeoutSel = &H0 or flag_ssc_clock_divider_37p4MHz = &H0 or flag_ssc_limit_37p4MHz_1 = &H0 or flag_MWA271OS = &H0 or flag_MWA271OV = &H0 or flag_mdio_RefclkSenseBypass = &H0 or flag_mdio_RefclkSense_onecomp = &H0 or flag_mdio_RefclkSenseEventClr = &H0 Then read
        If flag_mdio_RefclkSenseReqOvrdSel = &H0 Then write_mdio_RefclkSenseReqOvrdSel_value = get_mdio_RefclkSenseReqOvrdSel
        If flag_mdio_RefclkSenseReqOvrdVal = &H0 Then write_mdio_RefclkSenseReqOvrdVal_value = get_mdio_RefclkSenseReqOvrdVal
        If flag_mdio_RefclkSenseTimeoutSel = &H0 Then write_mdio_RefclkSenseTimeoutSel_value = get_mdio_RefclkSenseTimeoutSel
        If flag_ssc_clock_divider_37p4MHz = &H0 Then write_ssc_clock_divider_37p4MHz_value = get_ssc_clock_divider_37p4MHz
        If flag_ssc_limit_37p4MHz_1 = &H0 Then write_ssc_limit_37p4MHz_1_value = get_ssc_limit_37p4MHz_1
        If flag_MWA271OS = &H0 Then write_MWA271OS_value = get_MWA271OS
        If flag_MWA271OV = &H0 Then write_MWA271OV_value = get_MWA271OV
        If flag_mdio_RefclkSenseBypass = &H0 Then write_mdio_RefclkSenseBypass_value = get_mdio_RefclkSenseBypass
        If flag_mdio_RefclkSense_onecomp = &H0 Then write_mdio_RefclkSense_onecomp_value = get_mdio_RefclkSense_onecomp
        If flag_mdio_RefclkSenseEventClr = &H0 Then write_mdio_RefclkSenseEventClr_value = get_mdio_RefclkSenseEventClr

        regValue = leftShift((write_mdio_RefclkSenseReqOvrdSel_value and &H1), 14) + leftShift((write_mdio_RefclkSenseReqOvrdVal_value and &H1), 13) + leftShift((write_mdio_RefclkSenseTimeoutSel_value and &H1), 12) + leftShift((write_ssc_clock_divider_37p4MHz_value and &Hf), 8) + leftShift((write_ssc_limit_37p4MHz_1_value and &H7), 5) + leftShift((write_MWA271OS_value and &H1), 4) + leftShift((write_MWA271OV_value and &H1), 3) + leftShift((write_mdio_RefclkSenseBypass_value and &H1), 2) + leftShift((write_mdio_RefclkSense_onecomp_value and &H1), 1) + leftShift((write_mdio_RefclkSenseEventClr_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mdio_RefclkSenseReqOvrdSel_value = rightShift(data_low, 14) and &H1
        read_mdio_RefclkSenseReqOvrdVal_value = rightShift(data_low, 13) and &H1
        read_mdio_RefclkSenseTimeoutSel_value = rightShift(data_low, 12) and &H1
        read_ssc_clock_divider_37p4MHz_value = rightShift(data_low, 8) and &Hf
        read_ssc_limit_37p4MHz_1_value = rightShift(data_low, 5) and &H7
        read_MWA271OS_value = rightShift(data_low, 4) and &H1
        read_MWA271OV_value = rightShift(data_low, 3) and &H1
        read_mdio_RefclkSenseBypass_value = rightShift(data_low, 2) and &H1
        read_mdio_RefclkSense_onecomp_value = rightShift(data_low, 1) and &H1
        mdio_RefclkSenseEventClr_mask = &H1
        if data_low > LONG_MAX then
            if mdio_RefclkSenseEventClr_mask = mask then
                read_mdio_RefclkSenseEventClr_value = data_low
            else
                read_mdio_RefclkSenseEventClr_value = (data_low - H8000_0000) and mdio_RefclkSenseEventClr_mask
            end If
        else
            read_mdio_RefclkSenseEventClr_value = data_low and mdio_RefclkSenseEventClr_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mdio_RefclkSenseReqOvrdSel_value = &H0
        flag_mdio_RefclkSenseReqOvrdSel        = &H0
        write_mdio_RefclkSenseReqOvrdVal_value = &H0
        flag_mdio_RefclkSenseReqOvrdVal        = &H0
        write_mdio_RefclkSenseTimeoutSel_value = &H0
        flag_mdio_RefclkSenseTimeoutSel        = &H0
        write_ssc_clock_divider_37p4MHz_value = &H0
        flag_ssc_clock_divider_37p4MHz        = &H0
        write_ssc_limit_37p4MHz_1_value = &H0
        flag_ssc_limit_37p4MHz_1        = &H0
        write_MWA271OS_value = &H0
        flag_MWA271OS        = &H0
        write_MWA271OV_value = &H0
        flag_MWA271OV        = &H0
        write_mdio_RefclkSenseBypass_value = &H0
        flag_mdio_RefclkSenseBypass        = &H0
        write_mdio_RefclkSense_onecomp_value = &H0
        flag_mdio_RefclkSense_onecomp        = &H0
        write_mdio_RefclkSenseEventClr_value = &H0
        flag_mdio_RefclkSenseEventClr        = &H0
    End Sub
End Class


'' @REGISTER : PCIE6__SGMIIPCIE_X1_refclksense_m_50mhz
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mdio_RefclkSense_M_50MHz                   [15:0]           get_mdio_RefclkSense_M_50MHz
''                                                             set_mdio_RefclkSense_M_50MHz
''                                                             read_mdio_RefclkSense_M_50MHz
''                                                             write_mdio_RefclkSense_M_50MHz
''---------------------------------------------------------------------------------
Class REGISTER_PCIE6__SGMIIPCIE_X1_refclksense_m_50mhz
    Private write_mdio_RefclkSense_M_50MHz_value
    Private read_mdio_RefclkSense_M_50MHz_value
    Private flag_mdio_RefclkSense_M_50MHz

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

    Property Get get_mdio_RefclkSense_M_50MHz
        get_mdio_RefclkSense_M_50MHz = read_mdio_RefclkSense_M_50MHz_value
    End Property

    Property Let set_mdio_RefclkSense_M_50MHz(aData)
        write_mdio_RefclkSense_M_50MHz_value = aData
        flag_mdio_RefclkSense_M_50MHz        = &H1
    End Property

    Property Get read_mdio_RefclkSense_M_50MHz
        read
        read_mdio_RefclkSense_M_50MHz = read_mdio_RefclkSense_M_50MHz_value
    End Property

    Property Let write_mdio_RefclkSense_M_50MHz(aData)
        set_mdio_RefclkSense_M_50MHz = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mdio_RefclkSense_M_50MHz_mask = &Hffff
        if data_low > LONG_MAX then
            if mdio_RefclkSense_M_50MHz_mask = mask then
                read_mdio_RefclkSense_M_50MHz_value = data_low
            else
                read_mdio_RefclkSense_M_50MHz_value = (data_low - H8000_0000) and mdio_RefclkSense_M_50MHz_mask
            end If
        else
            read_mdio_RefclkSense_M_50MHz_value = data_low and mdio_RefclkSense_M_50MHz_mask
        end If

    End Sub

    Sub write
        If flag_mdio_RefclkSense_M_50MHz = &H0 Then read
        If flag_mdio_RefclkSense_M_50MHz = &H0 Then write_mdio_RefclkSense_M_50MHz_value = get_mdio_RefclkSense_M_50MHz

        regValue = leftShift((write_mdio_RefclkSense_M_50MHz_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mdio_RefclkSense_M_50MHz_mask = &Hffff
        if data_low > LONG_MAX then
            if mdio_RefclkSense_M_50MHz_mask = mask then
                read_mdio_RefclkSense_M_50MHz_value = data_low
            else
                read_mdio_RefclkSense_M_50MHz_value = (data_low - H8000_0000) and mdio_RefclkSense_M_50MHz_mask
            end If
        else
            read_mdio_RefclkSense_M_50MHz_value = data_low and mdio_RefclkSense_M_50MHz_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mdio_RefclkSense_M_50MHz_value = &H0
        flag_mdio_RefclkSense_M_50MHz        = &H0
    End Sub
End Class


'' @REGISTER : PCIE6__SGMIIPCIE_X1_refclksense_n_50mhz
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mdio_RefclkSense_N_50MHz                   [15:0]           get_mdio_RefclkSense_N_50MHz
''                                                             set_mdio_RefclkSense_N_50MHz
''                                                             read_mdio_RefclkSense_N_50MHz
''                                                             write_mdio_RefclkSense_N_50MHz
''---------------------------------------------------------------------------------
Class REGISTER_PCIE6__SGMIIPCIE_X1_refclksense_n_50mhz
    Private write_mdio_RefclkSense_N_50MHz_value
    Private read_mdio_RefclkSense_N_50MHz_value
    Private flag_mdio_RefclkSense_N_50MHz

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

    Property Get get_mdio_RefclkSense_N_50MHz
        get_mdio_RefclkSense_N_50MHz = read_mdio_RefclkSense_N_50MHz_value
    End Property

    Property Let set_mdio_RefclkSense_N_50MHz(aData)
        write_mdio_RefclkSense_N_50MHz_value = aData
        flag_mdio_RefclkSense_N_50MHz        = &H1
    End Property

    Property Get read_mdio_RefclkSense_N_50MHz
        read
        read_mdio_RefclkSense_N_50MHz = read_mdio_RefclkSense_N_50MHz_value
    End Property

    Property Let write_mdio_RefclkSense_N_50MHz(aData)
        set_mdio_RefclkSense_N_50MHz = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mdio_RefclkSense_N_50MHz_mask = &Hffff
        if data_low > LONG_MAX then
            if mdio_RefclkSense_N_50MHz_mask = mask then
                read_mdio_RefclkSense_N_50MHz_value = data_low
            else
                read_mdio_RefclkSense_N_50MHz_value = (data_low - H8000_0000) and mdio_RefclkSense_N_50MHz_mask
            end If
        else
            read_mdio_RefclkSense_N_50MHz_value = data_low and mdio_RefclkSense_N_50MHz_mask
        end If

    End Sub

    Sub write
        If flag_mdio_RefclkSense_N_50MHz = &H0 Then read
        If flag_mdio_RefclkSense_N_50MHz = &H0 Then write_mdio_RefclkSense_N_50MHz_value = get_mdio_RefclkSense_N_50MHz

        regValue = leftShift((write_mdio_RefclkSense_N_50MHz_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mdio_RefclkSense_N_50MHz_mask = &Hffff
        if data_low > LONG_MAX then
            if mdio_RefclkSense_N_50MHz_mask = mask then
                read_mdio_RefclkSense_N_50MHz_value = data_low
            else
                read_mdio_RefclkSense_N_50MHz_value = (data_low - H8000_0000) and mdio_RefclkSense_N_50MHz_mask
            end If
        else
            read_mdio_RefclkSense_N_50MHz_value = data_low and mdio_RefclkSense_N_50MHz_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mdio_RefclkSense_N_50MHz_value = &H0
        flag_mdio_RefclkSense_N_50MHz        = &H0
    End Sub
End Class


'' @REGISTER : PCIE6__SGMIIPCIE_X1_refclksense_m_52mhz
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mdio_RefclkSense_M_52MHz                   [15:0]           get_mdio_RefclkSense_M_52MHz
''                                                             set_mdio_RefclkSense_M_52MHz
''                                                             read_mdio_RefclkSense_M_52MHz
''                                                             write_mdio_RefclkSense_M_52MHz
''---------------------------------------------------------------------------------
Class REGISTER_PCIE6__SGMIIPCIE_X1_refclksense_m_52mhz
    Private write_mdio_RefclkSense_M_52MHz_value
    Private read_mdio_RefclkSense_M_52MHz_value
    Private flag_mdio_RefclkSense_M_52MHz

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

    Property Get get_mdio_RefclkSense_M_52MHz
        get_mdio_RefclkSense_M_52MHz = read_mdio_RefclkSense_M_52MHz_value
    End Property

    Property Let set_mdio_RefclkSense_M_52MHz(aData)
        write_mdio_RefclkSense_M_52MHz_value = aData
        flag_mdio_RefclkSense_M_52MHz        = &H1
    End Property

    Property Get read_mdio_RefclkSense_M_52MHz
        read
        read_mdio_RefclkSense_M_52MHz = read_mdio_RefclkSense_M_52MHz_value
    End Property

    Property Let write_mdio_RefclkSense_M_52MHz(aData)
        set_mdio_RefclkSense_M_52MHz = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mdio_RefclkSense_M_52MHz_mask = &Hffff
        if data_low > LONG_MAX then
            if mdio_RefclkSense_M_52MHz_mask = mask then
                read_mdio_RefclkSense_M_52MHz_value = data_low
            else
                read_mdio_RefclkSense_M_52MHz_value = (data_low - H8000_0000) and mdio_RefclkSense_M_52MHz_mask
            end If
        else
            read_mdio_RefclkSense_M_52MHz_value = data_low and mdio_RefclkSense_M_52MHz_mask
        end If

    End Sub

    Sub write
        If flag_mdio_RefclkSense_M_52MHz = &H0 Then read
        If flag_mdio_RefclkSense_M_52MHz = &H0 Then write_mdio_RefclkSense_M_52MHz_value = get_mdio_RefclkSense_M_52MHz

        regValue = leftShift((write_mdio_RefclkSense_M_52MHz_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mdio_RefclkSense_M_52MHz_mask = &Hffff
        if data_low > LONG_MAX then
            if mdio_RefclkSense_M_52MHz_mask = mask then
                read_mdio_RefclkSense_M_52MHz_value = data_low
            else
                read_mdio_RefclkSense_M_52MHz_value = (data_low - H8000_0000) and mdio_RefclkSense_M_52MHz_mask
            end If
        else
            read_mdio_RefclkSense_M_52MHz_value = data_low and mdio_RefclkSense_M_52MHz_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mdio_RefclkSense_M_52MHz_value = &H0
        flag_mdio_RefclkSense_M_52MHz        = &H0
    End Sub
End Class


'' @REGISTER : PCIE6__SGMIIPCIE_X1_refclksense_n_52mhz
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mdio_RefclkSense_N_52MHz                   [15:0]           get_mdio_RefclkSense_N_52MHz
''                                                             set_mdio_RefclkSense_N_52MHz
''                                                             read_mdio_RefclkSense_N_52MHz
''                                                             write_mdio_RefclkSense_N_52MHz
''---------------------------------------------------------------------------------
Class REGISTER_PCIE6__SGMIIPCIE_X1_refclksense_n_52mhz
    Private write_mdio_RefclkSense_N_52MHz_value
    Private read_mdio_RefclkSense_N_52MHz_value
    Private flag_mdio_RefclkSense_N_52MHz

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

    Property Get get_mdio_RefclkSense_N_52MHz
        get_mdio_RefclkSense_N_52MHz = read_mdio_RefclkSense_N_52MHz_value
    End Property

    Property Let set_mdio_RefclkSense_N_52MHz(aData)
        write_mdio_RefclkSense_N_52MHz_value = aData
        flag_mdio_RefclkSense_N_52MHz        = &H1
    End Property

    Property Get read_mdio_RefclkSense_N_52MHz
        read
        read_mdio_RefclkSense_N_52MHz = read_mdio_RefclkSense_N_52MHz_value
    End Property

    Property Let write_mdio_RefclkSense_N_52MHz(aData)
        set_mdio_RefclkSense_N_52MHz = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mdio_RefclkSense_N_52MHz_mask = &Hffff
        if data_low > LONG_MAX then
            if mdio_RefclkSense_N_52MHz_mask = mask then
                read_mdio_RefclkSense_N_52MHz_value = data_low
            else
                read_mdio_RefclkSense_N_52MHz_value = (data_low - H8000_0000) and mdio_RefclkSense_N_52MHz_mask
            end If
        else
            read_mdio_RefclkSense_N_52MHz_value = data_low and mdio_RefclkSense_N_52MHz_mask
        end If

    End Sub

    Sub write
        If flag_mdio_RefclkSense_N_52MHz = &H0 Then read
        If flag_mdio_RefclkSense_N_52MHz = &H0 Then write_mdio_RefclkSense_N_52MHz_value = get_mdio_RefclkSense_N_52MHz

        regValue = leftShift((write_mdio_RefclkSense_N_52MHz_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mdio_RefclkSense_N_52MHz_mask = &Hffff
        if data_low > LONG_MAX then
            if mdio_RefclkSense_N_52MHz_mask = mask then
                read_mdio_RefclkSense_N_52MHz_value = data_low
            else
                read_mdio_RefclkSense_N_52MHz_value = (data_low - H8000_0000) and mdio_RefclkSense_N_52MHz_mask
            end If
        else
            read_mdio_RefclkSense_N_52MHz_value = data_low and mdio_RefclkSense_N_52MHz_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mdio_RefclkSense_N_52MHz_value = &H0
        flag_mdio_RefclkSense_N_52MHz        = &H0
    End Sub
End Class


'' @REGISTER : PCIE6__SGMIIPCIE_X1_refclksense_m_54mhz
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mdio_RefclkSense_M_54MHz                   [15:0]           get_mdio_RefclkSense_M_54MHz
''                                                             set_mdio_RefclkSense_M_54MHz
''                                                             read_mdio_RefclkSense_M_54MHz
''                                                             write_mdio_RefclkSense_M_54MHz
''---------------------------------------------------------------------------------
Class REGISTER_PCIE6__SGMIIPCIE_X1_refclksense_m_54mhz
    Private write_mdio_RefclkSense_M_54MHz_value
    Private read_mdio_RefclkSense_M_54MHz_value
    Private flag_mdio_RefclkSense_M_54MHz

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

    Property Get get_mdio_RefclkSense_M_54MHz
        get_mdio_RefclkSense_M_54MHz = read_mdio_RefclkSense_M_54MHz_value
    End Property

    Property Let set_mdio_RefclkSense_M_54MHz(aData)
        write_mdio_RefclkSense_M_54MHz_value = aData
        flag_mdio_RefclkSense_M_54MHz        = &H1
    End Property

    Property Get read_mdio_RefclkSense_M_54MHz
        read
        read_mdio_RefclkSense_M_54MHz = read_mdio_RefclkSense_M_54MHz_value
    End Property

    Property Let write_mdio_RefclkSense_M_54MHz(aData)
        set_mdio_RefclkSense_M_54MHz = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mdio_RefclkSense_M_54MHz_mask = &Hffff
        if data_low > LONG_MAX then
            if mdio_RefclkSense_M_54MHz_mask = mask then
                read_mdio_RefclkSense_M_54MHz_value = data_low
            else
                read_mdio_RefclkSense_M_54MHz_value = (data_low - H8000_0000) and mdio_RefclkSense_M_54MHz_mask
            end If
        else
            read_mdio_RefclkSense_M_54MHz_value = data_low and mdio_RefclkSense_M_54MHz_mask
        end If

    End Sub

    Sub write
        If flag_mdio_RefclkSense_M_54MHz = &H0 Then read
        If flag_mdio_RefclkSense_M_54MHz = &H0 Then write_mdio_RefclkSense_M_54MHz_value = get_mdio_RefclkSense_M_54MHz

        regValue = leftShift((write_mdio_RefclkSense_M_54MHz_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mdio_RefclkSense_M_54MHz_mask = &Hffff
        if data_low > LONG_MAX then
            if mdio_RefclkSense_M_54MHz_mask = mask then
                read_mdio_RefclkSense_M_54MHz_value = data_low
            else
                read_mdio_RefclkSense_M_54MHz_value = (data_low - H8000_0000) and mdio_RefclkSense_M_54MHz_mask
            end If
        else
            read_mdio_RefclkSense_M_54MHz_value = data_low and mdio_RefclkSense_M_54MHz_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mdio_RefclkSense_M_54MHz_value = &H0
        flag_mdio_RefclkSense_M_54MHz        = &H0
    End Sub
End Class


'' @REGISTER : PCIE6__SGMIIPCIE_X1_refclksense_n_54mhz
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mdio_RefclkSense_N_54MHz                   [15:0]           get_mdio_RefclkSense_N_54MHz
''                                                             set_mdio_RefclkSense_N_54MHz
''                                                             read_mdio_RefclkSense_N_54MHz
''                                                             write_mdio_RefclkSense_N_54MHz
''---------------------------------------------------------------------------------
Class REGISTER_PCIE6__SGMIIPCIE_X1_refclksense_n_54mhz
    Private write_mdio_RefclkSense_N_54MHz_value
    Private read_mdio_RefclkSense_N_54MHz_value
    Private flag_mdio_RefclkSense_N_54MHz

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

    Property Get get_mdio_RefclkSense_N_54MHz
        get_mdio_RefclkSense_N_54MHz = read_mdio_RefclkSense_N_54MHz_value
    End Property

    Property Let set_mdio_RefclkSense_N_54MHz(aData)
        write_mdio_RefclkSense_N_54MHz_value = aData
        flag_mdio_RefclkSense_N_54MHz        = &H1
    End Property

    Property Get read_mdio_RefclkSense_N_54MHz
        read
        read_mdio_RefclkSense_N_54MHz = read_mdio_RefclkSense_N_54MHz_value
    End Property

    Property Let write_mdio_RefclkSense_N_54MHz(aData)
        set_mdio_RefclkSense_N_54MHz = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mdio_RefclkSense_N_54MHz_mask = &Hffff
        if data_low > LONG_MAX then
            if mdio_RefclkSense_N_54MHz_mask = mask then
                read_mdio_RefclkSense_N_54MHz_value = data_low
            else
                read_mdio_RefclkSense_N_54MHz_value = (data_low - H8000_0000) and mdio_RefclkSense_N_54MHz_mask
            end If
        else
            read_mdio_RefclkSense_N_54MHz_value = data_low and mdio_RefclkSense_N_54MHz_mask
        end If

    End Sub

    Sub write
        If flag_mdio_RefclkSense_N_54MHz = &H0 Then read
        If flag_mdio_RefclkSense_N_54MHz = &H0 Then write_mdio_RefclkSense_N_54MHz_value = get_mdio_RefclkSense_N_54MHz

        regValue = leftShift((write_mdio_RefclkSense_N_54MHz_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mdio_RefclkSense_N_54MHz_mask = &Hffff
        if data_low > LONG_MAX then
            if mdio_RefclkSense_N_54MHz_mask = mask then
                read_mdio_RefclkSense_N_54MHz_value = data_low
            else
                read_mdio_RefclkSense_N_54MHz_value = (data_low - H8000_0000) and mdio_RefclkSense_N_54MHz_mask
            end If
        else
            read_mdio_RefclkSense_N_54MHz_value = data_low and mdio_RefclkSense_N_54MHz_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mdio_RefclkSense_N_54MHz_value = &H0
        flag_mdio_RefclkSense_N_54MHz        = &H0
    End Sub
End Class


'' @REGISTER : PCIE6__SGMIIPCIE_X1_refclksense_stat
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mdio_RefclkSenseEventCnt                   [3:0]            get_mdio_RefclkSenseEventCnt
''                                                             set_mdio_RefclkSenseEventCnt
''                                                             read_mdio_RefclkSenseEventCnt
''                                                             write_mdio_RefclkSenseEventCnt
''---------------------------------------------------------------------------------
Class REGISTER_PCIE6__SGMIIPCIE_X1_refclksense_stat
    Private write_mdio_RefclkSenseEventCnt_value
    Private read_mdio_RefclkSenseEventCnt_value
    Private flag_mdio_RefclkSenseEventCnt

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

    Property Get get_mdio_RefclkSenseEventCnt
        get_mdio_RefclkSenseEventCnt = read_mdio_RefclkSenseEventCnt_value
    End Property

    Property Let set_mdio_RefclkSenseEventCnt(aData)
        write_mdio_RefclkSenseEventCnt_value = aData
        flag_mdio_RefclkSenseEventCnt        = &H1
    End Property

    Property Get read_mdio_RefclkSenseEventCnt
        read
        read_mdio_RefclkSenseEventCnt = read_mdio_RefclkSenseEventCnt_value
    End Property

    Property Let write_mdio_RefclkSenseEventCnt(aData)
        set_mdio_RefclkSenseEventCnt = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mdio_RefclkSenseEventCnt_mask = &Hf
        if data_low > LONG_MAX then
            if mdio_RefclkSenseEventCnt_mask = mask then
                read_mdio_RefclkSenseEventCnt_value = data_low
            else
                read_mdio_RefclkSenseEventCnt_value = (data_low - H8000_0000) and mdio_RefclkSenseEventCnt_mask
            end If
        else
            read_mdio_RefclkSenseEventCnt_value = data_low and mdio_RefclkSenseEventCnt_mask
        end If

    End Sub

    Sub write
        If flag_mdio_RefclkSenseEventCnt = &H0 Then read
        If flag_mdio_RefclkSenseEventCnt = &H0 Then write_mdio_RefclkSenseEventCnt_value = get_mdio_RefclkSenseEventCnt

        regValue = leftShift((write_mdio_RefclkSenseEventCnt_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mdio_RefclkSenseEventCnt_mask = &Hf
        if data_low > LONG_MAX then
            if mdio_RefclkSenseEventCnt_mask = mask then
                read_mdio_RefclkSenseEventCnt_value = data_low
            else
                read_mdio_RefclkSenseEventCnt_value = (data_low - H8000_0000) and mdio_RefclkSenseEventCnt_mask
            end If
        else
            read_mdio_RefclkSenseEventCnt_value = data_low and mdio_RefclkSenseEventCnt_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mdio_RefclkSenseEventCnt_value = &H0
        flag_mdio_RefclkSenseEventCnt        = &H0
    End Sub
End Class


'' @REGISTER : PCIE6__SGMIIPCIE_X1_refclksense_stat2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mdio_RefclkSenseCnt                        [15:0]           get_mdio_RefclkSenseCnt
''                                                             set_mdio_RefclkSenseCnt
''                                                             read_mdio_RefclkSenseCnt
''                                                             write_mdio_RefclkSenseCnt
''---------------------------------------------------------------------------------
Class REGISTER_PCIE6__SGMIIPCIE_X1_refclksense_stat2
    Private write_mdio_RefclkSenseCnt_value
    Private read_mdio_RefclkSenseCnt_value
    Private flag_mdio_RefclkSenseCnt

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

    Property Get get_mdio_RefclkSenseCnt
        get_mdio_RefclkSenseCnt = read_mdio_RefclkSenseCnt_value
    End Property

    Property Let set_mdio_RefclkSenseCnt(aData)
        write_mdio_RefclkSenseCnt_value = aData
        flag_mdio_RefclkSenseCnt        = &H1
    End Property

    Property Get read_mdio_RefclkSenseCnt
        read
        read_mdio_RefclkSenseCnt = read_mdio_RefclkSenseCnt_value
    End Property

    Property Let write_mdio_RefclkSenseCnt(aData)
        set_mdio_RefclkSenseCnt = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mdio_RefclkSenseCnt_mask = &Hffff
        if data_low > LONG_MAX then
            if mdio_RefclkSenseCnt_mask = mask then
                read_mdio_RefclkSenseCnt_value = data_low
            else
                read_mdio_RefclkSenseCnt_value = (data_low - H8000_0000) and mdio_RefclkSenseCnt_mask
            end If
        else
            read_mdio_RefclkSenseCnt_value = data_low and mdio_RefclkSenseCnt_mask
        end If

    End Sub

    Sub write
        If flag_mdio_RefclkSenseCnt = &H0 Then read
        If flag_mdio_RefclkSenseCnt = &H0 Then write_mdio_RefclkSenseCnt_value = get_mdio_RefclkSenseCnt

        regValue = leftShift((write_mdio_RefclkSenseCnt_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mdio_RefclkSenseCnt_mask = &Hffff
        if data_low > LONG_MAX then
            if mdio_RefclkSenseCnt_mask = mask then
                read_mdio_RefclkSenseCnt_value = data_low
            else
                read_mdio_RefclkSenseCnt_value = (data_low - H8000_0000) and mdio_RefclkSenseCnt_mask
            end If
        else
            read_mdio_RefclkSenseCnt_value = data_low and mdio_RefclkSenseCnt_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mdio_RefclkSenseCnt_value = &H0
        flag_mdio_RefclkSenseCnt        = &H0
    End Sub
End Class


'' @REGISTER : PCIE6__SGMIIPCIE_X1_refclksense_m_37p4mhz
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mdio_RefclkSense_M_37p4MHz                 [15:0]           get_mdio_RefclkSense_M_37p4MHz
''                                                             set_mdio_RefclkSense_M_37p4MHz
''                                                             read_mdio_RefclkSense_M_37p4MHz
''                                                             write_mdio_RefclkSense_M_37p4MHz
''---------------------------------------------------------------------------------
Class REGISTER_PCIE6__SGMIIPCIE_X1_refclksense_m_37p4mhz
    Private write_mdio_RefclkSense_M_37p4MHz_value
    Private read_mdio_RefclkSense_M_37p4MHz_value
    Private flag_mdio_RefclkSense_M_37p4MHz

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

    Property Get get_mdio_RefclkSense_M_37p4MHz
        get_mdio_RefclkSense_M_37p4MHz = read_mdio_RefclkSense_M_37p4MHz_value
    End Property

    Property Let set_mdio_RefclkSense_M_37p4MHz(aData)
        write_mdio_RefclkSense_M_37p4MHz_value = aData
        flag_mdio_RefclkSense_M_37p4MHz        = &H1
    End Property

    Property Get read_mdio_RefclkSense_M_37p4MHz
        read
        read_mdio_RefclkSense_M_37p4MHz = read_mdio_RefclkSense_M_37p4MHz_value
    End Property

    Property Let write_mdio_RefclkSense_M_37p4MHz(aData)
        set_mdio_RefclkSense_M_37p4MHz = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mdio_RefclkSense_M_37p4MHz_mask = &Hffff
        if data_low > LONG_MAX then
            if mdio_RefclkSense_M_37p4MHz_mask = mask then
                read_mdio_RefclkSense_M_37p4MHz_value = data_low
            else
                read_mdio_RefclkSense_M_37p4MHz_value = (data_low - H8000_0000) and mdio_RefclkSense_M_37p4MHz_mask
            end If
        else
            read_mdio_RefclkSense_M_37p4MHz_value = data_low and mdio_RefclkSense_M_37p4MHz_mask
        end If

    End Sub

    Sub write
        If flag_mdio_RefclkSense_M_37p4MHz = &H0 Then read
        If flag_mdio_RefclkSense_M_37p4MHz = &H0 Then write_mdio_RefclkSense_M_37p4MHz_value = get_mdio_RefclkSense_M_37p4MHz

        regValue = leftShift((write_mdio_RefclkSense_M_37p4MHz_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mdio_RefclkSense_M_37p4MHz_mask = &Hffff
        if data_low > LONG_MAX then
            if mdio_RefclkSense_M_37p4MHz_mask = mask then
                read_mdio_RefclkSense_M_37p4MHz_value = data_low
            else
                read_mdio_RefclkSense_M_37p4MHz_value = (data_low - H8000_0000) and mdio_RefclkSense_M_37p4MHz_mask
            end If
        else
            read_mdio_RefclkSense_M_37p4MHz_value = data_low and mdio_RefclkSense_M_37p4MHz_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mdio_RefclkSense_M_37p4MHz_value = &H0
        flag_mdio_RefclkSense_M_37p4MHz        = &H0
    End Sub
End Class


'' @REGISTER : PCIE6__SGMIIPCIE_X1_refclksense_n_37p4mhz
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mdio_RefclkSense_N_37p4MHz                 [15:0]           get_mdio_RefclkSense_N_37p4MHz
''                                                             set_mdio_RefclkSense_N_37p4MHz
''                                                             read_mdio_RefclkSense_N_37p4MHz
''                                                             write_mdio_RefclkSense_N_37p4MHz
''---------------------------------------------------------------------------------
Class REGISTER_PCIE6__SGMIIPCIE_X1_refclksense_n_37p4mhz
    Private write_mdio_RefclkSense_N_37p4MHz_value
    Private read_mdio_RefclkSense_N_37p4MHz_value
    Private flag_mdio_RefclkSense_N_37p4MHz

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

    Property Get get_mdio_RefclkSense_N_37p4MHz
        get_mdio_RefclkSense_N_37p4MHz = read_mdio_RefclkSense_N_37p4MHz_value
    End Property

    Property Let set_mdio_RefclkSense_N_37p4MHz(aData)
        write_mdio_RefclkSense_N_37p4MHz_value = aData
        flag_mdio_RefclkSense_N_37p4MHz        = &H1
    End Property

    Property Get read_mdio_RefclkSense_N_37p4MHz
        read
        read_mdio_RefclkSense_N_37p4MHz = read_mdio_RefclkSense_N_37p4MHz_value
    End Property

    Property Let write_mdio_RefclkSense_N_37p4MHz(aData)
        set_mdio_RefclkSense_N_37p4MHz = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mdio_RefclkSense_N_37p4MHz_mask = &Hffff
        if data_low > LONG_MAX then
            if mdio_RefclkSense_N_37p4MHz_mask = mask then
                read_mdio_RefclkSense_N_37p4MHz_value = data_low
            else
                read_mdio_RefclkSense_N_37p4MHz_value = (data_low - H8000_0000) and mdio_RefclkSense_N_37p4MHz_mask
            end If
        else
            read_mdio_RefclkSense_N_37p4MHz_value = data_low and mdio_RefclkSense_N_37p4MHz_mask
        end If

    End Sub

    Sub write
        If flag_mdio_RefclkSense_N_37p4MHz = &H0 Then read
        If flag_mdio_RefclkSense_N_37p4MHz = &H0 Then write_mdio_RefclkSense_N_37p4MHz_value = get_mdio_RefclkSense_N_37p4MHz

        regValue = leftShift((write_mdio_RefclkSense_N_37p4MHz_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mdio_RefclkSense_N_37p4MHz_mask = &Hffff
        if data_low > LONG_MAX then
            if mdio_RefclkSense_N_37p4MHz_mask = mask then
                read_mdio_RefclkSense_N_37p4MHz_value = data_low
            else
                read_mdio_RefclkSense_N_37p4MHz_value = (data_low - H8000_0000) and mdio_RefclkSense_N_37p4MHz_mask
            end If
        else
            read_mdio_RefclkSense_N_37p4MHz_value = data_low and mdio_RefclkSense_N_37p4MHz_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mdio_RefclkSense_N_37p4MHz_value = &H0
        flag_mdio_RefclkSense_N_37p4MHz        = &H0
    End Sub
End Class


'' @REGISTER : PCIE6__SGMIIPCIE_X1_refclksense_n_37p4mhz_27mhz_1mhz
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MRN374271                                  [15:0]           get_MRN374271
''                                                             set_MRN374271
''                                                             read_MRN374271
''                                                             write_MRN374271
''---------------------------------------------------------------------------------
Class REGISTER_PCIE6__SGMIIPCIE_X1_refclksense_n_37p4mhz_27mhz_1mhz
    Private write_MRN374271_value
    Private read_MRN374271_value
    Private flag_MRN374271

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

    Property Get get_MRN374271
        get_MRN374271 = read_MRN374271_value
    End Property

    Property Let set_MRN374271(aData)
        write_MRN374271_value = aData
        flag_MRN374271        = &H1
    End Property

    Property Get read_MRN374271
        read
        read_MRN374271 = read_MRN374271_value
    End Property

    Property Let write_MRN374271(aData)
        set_MRN374271 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MRN374271_mask = &Hffff
        if data_low > LONG_MAX then
            if MRN374271_mask = mask then
                read_MRN374271_value = data_low
            else
                read_MRN374271_value = (data_low - H8000_0000) and MRN374271_mask
            end If
        else
            read_MRN374271_value = data_low and MRN374271_mask
        end If

    End Sub

    Sub write
        If flag_MRN374271 = &H0 Then read
        If flag_MRN374271 = &H0 Then write_MRN374271_value = get_MRN374271

        regValue = leftShift((write_MRN374271_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MRN374271_mask = &Hffff
        if data_low > LONG_MAX then
            if MRN374271_mask = mask then
                read_MRN374271_value = data_low
            else
                read_MRN374271_value = (data_low - H8000_0000) and MRN374271_mask
            end If
        else
            read_MRN374271_value = data_low and MRN374271_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MRN374271_value = &H0
        flag_MRN374271        = &H0
    End Sub
End Class


'' @REGISTER : PCIE6__SGMIIPCIE_X1_refclksense_n_50mhz_27mhz_1mhz
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MRN50271                                   [15:0]           get_MRN50271
''                                                             set_MRN50271
''                                                             read_MRN50271
''                                                             write_MRN50271
''---------------------------------------------------------------------------------
Class REGISTER_PCIE6__SGMIIPCIE_X1_refclksense_n_50mhz_27mhz_1mhz
    Private write_MRN50271_value
    Private read_MRN50271_value
    Private flag_MRN50271

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

    Property Get get_MRN50271
        get_MRN50271 = read_MRN50271_value
    End Property

    Property Let set_MRN50271(aData)
        write_MRN50271_value = aData
        flag_MRN50271        = &H1
    End Property

    Property Get read_MRN50271
        read
        read_MRN50271 = read_MRN50271_value
    End Property

    Property Let write_MRN50271(aData)
        set_MRN50271 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MRN50271_mask = &Hffff
        if data_low > LONG_MAX then
            if MRN50271_mask = mask then
                read_MRN50271_value = data_low
            else
                read_MRN50271_value = (data_low - H8000_0000) and MRN50271_mask
            end If
        else
            read_MRN50271_value = data_low and MRN50271_mask
        end If

    End Sub

    Sub write
        If flag_MRN50271 = &H0 Then read
        If flag_MRN50271 = &H0 Then write_MRN50271_value = get_MRN50271

        regValue = leftShift((write_MRN50271_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MRN50271_mask = &Hffff
        if data_low > LONG_MAX then
            if MRN50271_mask = mask then
                read_MRN50271_value = data_low
            else
                read_MRN50271_value = (data_low - H8000_0000) and MRN50271_mask
            end If
        else
            read_MRN50271_value = data_low and MRN50271_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MRN50271_value = &H0
        flag_MRN50271        = &H0
    End Sub
End Class


'' @REGISTER : PCIE6__SGMIIPCIE_X1_ssc_limit_37p4mhz
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ssc_limit_37p4MHz_0                        [15:0]           get_ssc_limit_37p4MHz_0
''                                                             set_ssc_limit_37p4MHz_0
''                                                             read_ssc_limit_37p4MHz_0
''                                                             write_ssc_limit_37p4MHz_0
''---------------------------------------------------------------------------------
Class REGISTER_PCIE6__SGMIIPCIE_X1_ssc_limit_37p4mhz
    Private write_ssc_limit_37p4MHz_0_value
    Private read_ssc_limit_37p4MHz_0_value
    Private flag_ssc_limit_37p4MHz_0

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

    Property Get get_ssc_limit_37p4MHz_0
        get_ssc_limit_37p4MHz_0 = read_ssc_limit_37p4MHz_0_value
    End Property

    Property Let set_ssc_limit_37p4MHz_0(aData)
        write_ssc_limit_37p4MHz_0_value = aData
        flag_ssc_limit_37p4MHz_0        = &H1
    End Property

    Property Get read_ssc_limit_37p4MHz_0
        read
        read_ssc_limit_37p4MHz_0 = read_ssc_limit_37p4MHz_0_value
    End Property

    Property Let write_ssc_limit_37p4MHz_0(aData)
        set_ssc_limit_37p4MHz_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ssc_limit_37p4MHz_0_mask = &Hffff
        if data_low > LONG_MAX then
            if ssc_limit_37p4MHz_0_mask = mask then
                read_ssc_limit_37p4MHz_0_value = data_low
            else
                read_ssc_limit_37p4MHz_0_value = (data_low - H8000_0000) and ssc_limit_37p4MHz_0_mask
            end If
        else
            read_ssc_limit_37p4MHz_0_value = data_low and ssc_limit_37p4MHz_0_mask
        end If

    End Sub

    Sub write
        If flag_ssc_limit_37p4MHz_0 = &H0 Then read
        If flag_ssc_limit_37p4MHz_0 = &H0 Then write_ssc_limit_37p4MHz_0_value = get_ssc_limit_37p4MHz_0

        regValue = leftShift((write_ssc_limit_37p4MHz_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ssc_limit_37p4MHz_0_mask = &Hffff
        if data_low > LONG_MAX then
            if ssc_limit_37p4MHz_0_mask = mask then
                read_ssc_limit_37p4MHz_0_value = data_low
            else
                read_ssc_limit_37p4MHz_0_value = (data_low - H8000_0000) and ssc_limit_37p4MHz_0_mask
            end If
        else
            read_ssc_limit_37p4MHz_0_value = data_low and ssc_limit_37p4MHz_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ssc_limit_37p4MHz_0_value = &H0
        flag_ssc_limit_37p4MHz_0        = &H0
    End Sub
End Class


'' @REGISTER : PCIE6__SGMIIPCIE_X1_ssc_step_37p4mhz
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ssc_step_37p4MHz                           [15:0]           get_ssc_step_37p4MHz
''                                                             set_ssc_step_37p4MHz
''                                                             read_ssc_step_37p4MHz
''                                                             write_ssc_step_37p4MHz
''---------------------------------------------------------------------------------
Class REGISTER_PCIE6__SGMIIPCIE_X1_ssc_step_37p4mhz
    Private write_ssc_step_37p4MHz_value
    Private read_ssc_step_37p4MHz_value
    Private flag_ssc_step_37p4MHz

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

    Property Get get_ssc_step_37p4MHz
        get_ssc_step_37p4MHz = read_ssc_step_37p4MHz_value
    End Property

    Property Let set_ssc_step_37p4MHz(aData)
        write_ssc_step_37p4MHz_value = aData
        flag_ssc_step_37p4MHz        = &H1
    End Property

    Property Get read_ssc_step_37p4MHz
        read
        read_ssc_step_37p4MHz = read_ssc_step_37p4MHz_value
    End Property

    Property Let write_ssc_step_37p4MHz(aData)
        set_ssc_step_37p4MHz = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ssc_step_37p4MHz_mask = &Hffff
        if data_low > LONG_MAX then
            if ssc_step_37p4MHz_mask = mask then
                read_ssc_step_37p4MHz_value = data_low
            else
                read_ssc_step_37p4MHz_value = (data_low - H8000_0000) and ssc_step_37p4MHz_mask
            end If
        else
            read_ssc_step_37p4MHz_value = data_low and ssc_step_37p4MHz_mask
        end If

    End Sub

    Sub write
        If flag_ssc_step_37p4MHz = &H0 Then read
        If flag_ssc_step_37p4MHz = &H0 Then write_ssc_step_37p4MHz_value = get_ssc_step_37p4MHz

        regValue = leftShift((write_ssc_step_37p4MHz_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ssc_step_37p4MHz_mask = &Hffff
        if data_low > LONG_MAX then
            if ssc_step_37p4MHz_mask = mask then
                read_ssc_step_37p4MHz_value = data_low
            else
                read_ssc_step_37p4MHz_value = (data_low - H8000_0000) and ssc_step_37p4MHz_mask
            end If
        else
            read_ssc_step_37p4MHz_value = data_low and ssc_step_37p4MHz_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ssc_step_37p4MHz_value = &H0
        flag_ssc_step_37p4MHz        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class PCIE6__SGMIIPCIE_X1_INSTANCE

    Public refclksense_ctrl
    Public refclksense_m_50mhz
    Public refclksense_n_50mhz
    Public refclksense_m_52mhz
    Public refclksense_n_52mhz
    Public refclksense_m_54mhz
    Public refclksense_n_54mhz
    Public refclksense_stat
    Public refclksense_stat2
    Public refclksense_m_37p4mhz
    Public refclksense_n_37p4mhz
    Public refclksense_n_37p4mhz_27mhz_1mhz
    Public refclksense_n_50mhz_27mhz_1mhz
    Public ssc_limit_37p4mhz
    Public ssc_step_37p4mhz


    Public default function Init(aBaseAddr)
        Set refclksense_ctrl = (New REGISTER_PCIE6__SGMIIPCIE_X1_refclksense_ctrl)(aBaseAddr, 16)
        Set refclksense_m_50mhz = (New REGISTER_PCIE6__SGMIIPCIE_X1_refclksense_m_50mhz)(aBaseAddr, 16)
        Set refclksense_n_50mhz = (New REGISTER_PCIE6__SGMIIPCIE_X1_refclksense_n_50mhz)(aBaseAddr, 16)
        Set refclksense_m_52mhz = (New REGISTER_PCIE6__SGMIIPCIE_X1_refclksense_m_52mhz)(aBaseAddr, 16)
        Set refclksense_n_52mhz = (New REGISTER_PCIE6__SGMIIPCIE_X1_refclksense_n_52mhz)(aBaseAddr, 16)
        Set refclksense_m_54mhz = (New REGISTER_PCIE6__SGMIIPCIE_X1_refclksense_m_54mhz)(aBaseAddr, 16)
        Set refclksense_n_54mhz = (New REGISTER_PCIE6__SGMIIPCIE_X1_refclksense_n_54mhz)(aBaseAddr, 16)
        Set refclksense_stat = (New REGISTER_PCIE6__SGMIIPCIE_X1_refclksense_stat)(aBaseAddr, 16)
        Set refclksense_stat2 = (New REGISTER_PCIE6__SGMIIPCIE_X1_refclksense_stat2)(aBaseAddr, 16)
        Set refclksense_m_37p4mhz = (New REGISTER_PCIE6__SGMIIPCIE_X1_refclksense_m_37p4mhz)(aBaseAddr, 16)
        Set refclksense_n_37p4mhz = (New REGISTER_PCIE6__SGMIIPCIE_X1_refclksense_n_37p4mhz)(aBaseAddr, 16)
        Set refclksense_n_37p4mhz_27mhz_1mhz = (New REGISTER_PCIE6__SGMIIPCIE_X1_refclksense_n_37p4mhz_27mhz_1mhz)(aBaseAddr, 16)
        Set refclksense_n_50mhz_27mhz_1mhz = (New REGISTER_PCIE6__SGMIIPCIE_X1_refclksense_n_50mhz_27mhz_1mhz)(aBaseAddr, 16)
        Set ssc_limit_37p4mhz = (New REGISTER_PCIE6__SGMIIPCIE_X1_ssc_limit_37p4mhz)(aBaseAddr, 16)
        Set ssc_step_37p4mhz = (New REGISTER_PCIE6__SGMIIPCIE_X1_ssc_step_37p4mhz)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set PCIE6__SGMIIPCIE_X1 = CreateObject("System.Collections.ArrayList")
PCIE6__SGMIIPCIE_X1.Add ((New PCIE6__SGMIIPCIE_X1_INSTANCE)(&H4ade2c00))


