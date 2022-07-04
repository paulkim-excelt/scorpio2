

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


'' @REGISTER : MDIO_MMDSEL_AER_COM_MDIO_BLK_ADDR_SGMIIPLUSR_X1_mdio_brcst_port_addr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MDIO_DRV_COMC                              [15:15]          get_MDIO_DRV_COMC
''                                                             set_MDIO_DRV_COMC
''                                                             read_MDIO_DRV_COMC
''                                                             write_MDIO_DRV_COMC
''---------------------------------------------------------------------------------
'' MBPA                                       [4:0]            get_MBPA
''                                                             set_MBPA
''                                                             read_MBPA
''                                                             write_MBPA
''---------------------------------------------------------------------------------
Class REGISTER_MDIO_MMDSEL_AER_COM_MDIO_BLK_ADDR_SGMIIPLUSR_X1_mdio_brcst_port_addr
    Private write_MDIO_DRV_COMC_value
    Private read_MDIO_DRV_COMC_value
    Private flag_MDIO_DRV_COMC
    Private write_MBPA_value
    Private read_MBPA_value
    Private flag_MBPA

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

    Property Get get_MDIO_DRV_COMC
        get_MDIO_DRV_COMC = read_MDIO_DRV_COMC_value
    End Property

    Property Let set_MDIO_DRV_COMC(aData)
        write_MDIO_DRV_COMC_value = aData
        flag_MDIO_DRV_COMC        = &H1
    End Property

    Property Get read_MDIO_DRV_COMC
        read
        read_MDIO_DRV_COMC = read_MDIO_DRV_COMC_value
    End Property

    Property Let write_MDIO_DRV_COMC(aData)
        set_MDIO_DRV_COMC = aData
        write
    End Property

    Property Get get_MBPA
        get_MBPA = read_MBPA_value
    End Property

    Property Let set_MBPA(aData)
        write_MBPA_value = aData
        flag_MBPA        = &H1
    End Property

    Property Get read_MBPA
        read
        read_MBPA = read_MBPA_value
    End Property

    Property Let write_MBPA(aData)
        set_MBPA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MDIO_DRV_COMC_value = rightShift(data_low, 15) and &H1
        MBPA_mask = &H1f
        if data_low > LONG_MAX then
            if MBPA_mask = mask then
                read_MBPA_value = data_low
            else
                read_MBPA_value = (data_low - H8000_0000) and MBPA_mask
            end If
        else
            read_MBPA_value = data_low and MBPA_mask
        end If

    End Sub

    Sub write
        If flag_MDIO_DRV_COMC = &H0 or flag_MBPA = &H0 Then read
        If flag_MDIO_DRV_COMC = &H0 Then write_MDIO_DRV_COMC_value = get_MDIO_DRV_COMC
        If flag_MBPA = &H0 Then write_MBPA_value = get_MBPA

        regValue = leftShift((write_MDIO_DRV_COMC_value and &H1), 15) + leftShift((write_MBPA_value and &H1f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MDIO_DRV_COMC_value = rightShift(data_low, 15) and &H1
        MBPA_mask = &H1f
        if data_low > LONG_MAX then
            if MBPA_mask = mask then
                read_MBPA_value = data_low
            else
                read_MBPA_value = (data_low - H8000_0000) and MBPA_mask
            end If
        else
            read_MBPA_value = data_low and MBPA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MDIO_DRV_COMC_value = &H0
        flag_MDIO_DRV_COMC        = &H0
        write_MBPA_value = &H0
        flag_MBPA        = &H0
    End Sub
End Class


'' @REGISTER : MDIO_MMDSEL_AER_COM_MDIO_BLK_ADDR_SGMIIPLUSR_X1_mdio_mmd_select
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MMPE                                       [15:15]          get_MMPE
''                                                             set_MMPE
''                                                             read_MMPE
''                                                             write_MMPE
''---------------------------------------------------------------------------------
'' MMME                                       [14:14]          get_MMME
''                                                             set_MMME
''                                                             read_MMME
''                                                             write_MMME
''---------------------------------------------------------------------------------
'' MDIO_DEV_PCS_EN                            [6:6]            get_MDIO_DEV_PCS_EN
''                                                             set_MDIO_DEV_PCS_EN
''                                                             read_MDIO_DEV_PCS_EN
''                                                             write_MDIO_DEV_PCS_EN
''---------------------------------------------------------------------------------
'' MDIO_DEV_DTE_EN                            [5:5]            get_MDIO_DEV_DTE_EN
''                                                             set_MDIO_DEV_DTE_EN
''                                                             read_MDIO_DEV_DTE_EN
''                                                             write_MDIO_DEV_DTE_EN
''---------------------------------------------------------------------------------
'' MDIO_DEV_PHY_EN                            [4:4]            get_MDIO_DEV_PHY_EN
''                                                             set_MDIO_DEV_PHY_EN
''                                                             read_MDIO_DEV_PHY_EN
''                                                             write_MDIO_DEV_PHY_EN
''---------------------------------------------------------------------------------
'' MDIO_DEV_AN_EN                             [3:3]            get_MDIO_DEV_AN_EN
''                                                             set_MDIO_DEV_AN_EN
''                                                             read_MDIO_DEV_AN_EN
''                                                             write_MDIO_DEV_AN_EN
''---------------------------------------------------------------------------------
'' MDIO_DEV_PMD_EN                            [2:2]            get_MDIO_DEV_PMD_EN
''                                                             set_MDIO_DEV_PMD_EN
''                                                             read_MDIO_DEV_PMD_EN
''                                                             write_MDIO_DEV_PMD_EN
''---------------------------------------------------------------------------------
'' MDIO_DEV_ID0_EN                            [0:0]            get_MDIO_DEV_ID0_EN
''                                                             set_MDIO_DEV_ID0_EN
''                                                             read_MDIO_DEV_ID0_EN
''                                                             write_MDIO_DEV_ID0_EN
''---------------------------------------------------------------------------------
Class REGISTER_MDIO_MMDSEL_AER_COM_MDIO_BLK_ADDR_SGMIIPLUSR_X1_mdio_mmd_select
    Private write_MMPE_value
    Private read_MMPE_value
    Private flag_MMPE
    Private write_MMME_value
    Private read_MMME_value
    Private flag_MMME
    Private write_MDIO_DEV_PCS_EN_value
    Private read_MDIO_DEV_PCS_EN_value
    Private flag_MDIO_DEV_PCS_EN
    Private write_MDIO_DEV_DTE_EN_value
    Private read_MDIO_DEV_DTE_EN_value
    Private flag_MDIO_DEV_DTE_EN
    Private write_MDIO_DEV_PHY_EN_value
    Private read_MDIO_DEV_PHY_EN_value
    Private flag_MDIO_DEV_PHY_EN
    Private write_MDIO_DEV_AN_EN_value
    Private read_MDIO_DEV_AN_EN_value
    Private flag_MDIO_DEV_AN_EN
    Private write_MDIO_DEV_PMD_EN_value
    Private read_MDIO_DEV_PMD_EN_value
    Private flag_MDIO_DEV_PMD_EN
    Private write_MDIO_DEV_ID0_EN_value
    Private read_MDIO_DEV_ID0_EN_value
    Private flag_MDIO_DEV_ID0_EN

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

    Property Get get_MMPE
        get_MMPE = read_MMPE_value
    End Property

    Property Let set_MMPE(aData)
        write_MMPE_value = aData
        flag_MMPE        = &H1
    End Property

    Property Get read_MMPE
        read
        read_MMPE = read_MMPE_value
    End Property

    Property Let write_MMPE(aData)
        set_MMPE = aData
        write
    End Property

    Property Get get_MMME
        get_MMME = read_MMME_value
    End Property

    Property Let set_MMME(aData)
        write_MMME_value = aData
        flag_MMME        = &H1
    End Property

    Property Get read_MMME
        read
        read_MMME = read_MMME_value
    End Property

    Property Let write_MMME(aData)
        set_MMME = aData
        write
    End Property

    Property Get get_MDIO_DEV_PCS_EN
        get_MDIO_DEV_PCS_EN = read_MDIO_DEV_PCS_EN_value
    End Property

    Property Let set_MDIO_DEV_PCS_EN(aData)
        write_MDIO_DEV_PCS_EN_value = aData
        flag_MDIO_DEV_PCS_EN        = &H1
    End Property

    Property Get read_MDIO_DEV_PCS_EN
        read
        read_MDIO_DEV_PCS_EN = read_MDIO_DEV_PCS_EN_value
    End Property

    Property Let write_MDIO_DEV_PCS_EN(aData)
        set_MDIO_DEV_PCS_EN = aData
        write
    End Property

    Property Get get_MDIO_DEV_DTE_EN
        get_MDIO_DEV_DTE_EN = read_MDIO_DEV_DTE_EN_value
    End Property

    Property Let set_MDIO_DEV_DTE_EN(aData)
        write_MDIO_DEV_DTE_EN_value = aData
        flag_MDIO_DEV_DTE_EN        = &H1
    End Property

    Property Get read_MDIO_DEV_DTE_EN
        read
        read_MDIO_DEV_DTE_EN = read_MDIO_DEV_DTE_EN_value
    End Property

    Property Let write_MDIO_DEV_DTE_EN(aData)
        set_MDIO_DEV_DTE_EN = aData
        write
    End Property

    Property Get get_MDIO_DEV_PHY_EN
        get_MDIO_DEV_PHY_EN = read_MDIO_DEV_PHY_EN_value
    End Property

    Property Let set_MDIO_DEV_PHY_EN(aData)
        write_MDIO_DEV_PHY_EN_value = aData
        flag_MDIO_DEV_PHY_EN        = &H1
    End Property

    Property Get read_MDIO_DEV_PHY_EN
        read
        read_MDIO_DEV_PHY_EN = read_MDIO_DEV_PHY_EN_value
    End Property

    Property Let write_MDIO_DEV_PHY_EN(aData)
        set_MDIO_DEV_PHY_EN = aData
        write
    End Property

    Property Get get_MDIO_DEV_AN_EN
        get_MDIO_DEV_AN_EN = read_MDIO_DEV_AN_EN_value
    End Property

    Property Let set_MDIO_DEV_AN_EN(aData)
        write_MDIO_DEV_AN_EN_value = aData
        flag_MDIO_DEV_AN_EN        = &H1
    End Property

    Property Get read_MDIO_DEV_AN_EN
        read
        read_MDIO_DEV_AN_EN = read_MDIO_DEV_AN_EN_value
    End Property

    Property Let write_MDIO_DEV_AN_EN(aData)
        set_MDIO_DEV_AN_EN = aData
        write
    End Property

    Property Get get_MDIO_DEV_PMD_EN
        get_MDIO_DEV_PMD_EN = read_MDIO_DEV_PMD_EN_value
    End Property

    Property Let set_MDIO_DEV_PMD_EN(aData)
        write_MDIO_DEV_PMD_EN_value = aData
        flag_MDIO_DEV_PMD_EN        = &H1
    End Property

    Property Get read_MDIO_DEV_PMD_EN
        read
        read_MDIO_DEV_PMD_EN = read_MDIO_DEV_PMD_EN_value
    End Property

    Property Let write_MDIO_DEV_PMD_EN(aData)
        set_MDIO_DEV_PMD_EN = aData
        write
    End Property

    Property Get get_MDIO_DEV_ID0_EN
        get_MDIO_DEV_ID0_EN = read_MDIO_DEV_ID0_EN_value
    End Property

    Property Let set_MDIO_DEV_ID0_EN(aData)
        write_MDIO_DEV_ID0_EN_value = aData
        flag_MDIO_DEV_ID0_EN        = &H1
    End Property

    Property Get read_MDIO_DEV_ID0_EN
        read
        read_MDIO_DEV_ID0_EN = read_MDIO_DEV_ID0_EN_value
    End Property

    Property Let write_MDIO_DEV_ID0_EN(aData)
        set_MDIO_DEV_ID0_EN = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MMPE_value = rightShift(data_low, 15) and &H1
        read_MMME_value = rightShift(data_low, 14) and &H1
        read_MDIO_DEV_PCS_EN_value = rightShift(data_low, 6) and &H1
        read_MDIO_DEV_DTE_EN_value = rightShift(data_low, 5) and &H1
        read_MDIO_DEV_PHY_EN_value = rightShift(data_low, 4) and &H1
        read_MDIO_DEV_AN_EN_value = rightShift(data_low, 3) and &H1
        read_MDIO_DEV_PMD_EN_value = rightShift(data_low, 2) and &H1
        MDIO_DEV_ID0_EN_mask = &H1
        if data_low > LONG_MAX then
            if MDIO_DEV_ID0_EN_mask = mask then
                read_MDIO_DEV_ID0_EN_value = data_low
            else
                read_MDIO_DEV_ID0_EN_value = (data_low - H8000_0000) and MDIO_DEV_ID0_EN_mask
            end If
        else
            read_MDIO_DEV_ID0_EN_value = data_low and MDIO_DEV_ID0_EN_mask
        end If

    End Sub

    Sub write
        If flag_MMPE = &H0 or flag_MMME = &H0 or flag_MDIO_DEV_PCS_EN = &H0 or flag_MDIO_DEV_DTE_EN = &H0 or flag_MDIO_DEV_PHY_EN = &H0 or flag_MDIO_DEV_AN_EN = &H0 or flag_MDIO_DEV_PMD_EN = &H0 or flag_MDIO_DEV_ID0_EN = &H0 Then read
        If flag_MMPE = &H0 Then write_MMPE_value = get_MMPE
        If flag_MMME = &H0 Then write_MMME_value = get_MMME
        If flag_MDIO_DEV_PCS_EN = &H0 Then write_MDIO_DEV_PCS_EN_value = get_MDIO_DEV_PCS_EN
        If flag_MDIO_DEV_DTE_EN = &H0 Then write_MDIO_DEV_DTE_EN_value = get_MDIO_DEV_DTE_EN
        If flag_MDIO_DEV_PHY_EN = &H0 Then write_MDIO_DEV_PHY_EN_value = get_MDIO_DEV_PHY_EN
        If flag_MDIO_DEV_AN_EN = &H0 Then write_MDIO_DEV_AN_EN_value = get_MDIO_DEV_AN_EN
        If flag_MDIO_DEV_PMD_EN = &H0 Then write_MDIO_DEV_PMD_EN_value = get_MDIO_DEV_PMD_EN
        If flag_MDIO_DEV_ID0_EN = &H0 Then write_MDIO_DEV_ID0_EN_value = get_MDIO_DEV_ID0_EN

        regValue = leftShift((write_MMPE_value and &H1), 15) + leftShift((write_MMME_value and &H1), 14) + leftShift((write_MDIO_DEV_PCS_EN_value and &H1), 6) + leftShift((write_MDIO_DEV_DTE_EN_value and &H1), 5) + leftShift((write_MDIO_DEV_PHY_EN_value and &H1), 4) + leftShift((write_MDIO_DEV_AN_EN_value and &H1), 3) + leftShift((write_MDIO_DEV_PMD_EN_value and &H1), 2) + leftShift((write_MDIO_DEV_ID0_EN_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MMPE_value = rightShift(data_low, 15) and &H1
        read_MMME_value = rightShift(data_low, 14) and &H1
        read_MDIO_DEV_PCS_EN_value = rightShift(data_low, 6) and &H1
        read_MDIO_DEV_DTE_EN_value = rightShift(data_low, 5) and &H1
        read_MDIO_DEV_PHY_EN_value = rightShift(data_low, 4) and &H1
        read_MDIO_DEV_AN_EN_value = rightShift(data_low, 3) and &H1
        read_MDIO_DEV_PMD_EN_value = rightShift(data_low, 2) and &H1
        MDIO_DEV_ID0_EN_mask = &H1
        if data_low > LONG_MAX then
            if MDIO_DEV_ID0_EN_mask = mask then
                read_MDIO_DEV_ID0_EN_value = data_low
            else
                read_MDIO_DEV_ID0_EN_value = (data_low - H8000_0000) and MDIO_DEV_ID0_EN_mask
            end If
        else
            read_MDIO_DEV_ID0_EN_value = data_low and MDIO_DEV_ID0_EN_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MMPE_value = &H0
        flag_MMPE        = &H0
        write_MMME_value = &H0
        flag_MMME        = &H0
        write_MDIO_DEV_PCS_EN_value = &H0
        flag_MDIO_DEV_PCS_EN        = &H0
        write_MDIO_DEV_DTE_EN_value = &H0
        flag_MDIO_DEV_DTE_EN        = &H0
        write_MDIO_DEV_PHY_EN_value = &H0
        flag_MDIO_DEV_PHY_EN        = &H0
        write_MDIO_DEV_AN_EN_value = &H0
        flag_MDIO_DEV_AN_EN        = &H0
        write_MDIO_DEV_PMD_EN_value = &H0
        flag_MDIO_DEV_PMD_EN        = &H0
        write_MDIO_DEV_ID0_EN_value = &H0
        flag_MDIO_DEV_ID0_EN        = &H0
    End Sub
End Class


'' @REGISTER : MDIO_MMDSEL_AER_COM_MDIO_BLK_ADDR_SGMIIPLUSR_X1_mdio_aer
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MDIO_AER                                   [15:0]           get_MDIO_AER
''                                                             set_MDIO_AER
''                                                             read_MDIO_AER
''                                                             write_MDIO_AER
''---------------------------------------------------------------------------------
Class REGISTER_MDIO_MMDSEL_AER_COM_MDIO_BLK_ADDR_SGMIIPLUSR_X1_mdio_aer
    Private write_MDIO_AER_value
    Private read_MDIO_AER_value
    Private flag_MDIO_AER

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

    Property Get get_MDIO_AER
        get_MDIO_AER = read_MDIO_AER_value
    End Property

    Property Let set_MDIO_AER(aData)
        write_MDIO_AER_value = aData
        flag_MDIO_AER        = &H1
    End Property

    Property Get read_MDIO_AER
        read
        read_MDIO_AER = read_MDIO_AER_value
    End Property

    Property Let write_MDIO_AER(aData)
        set_MDIO_AER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MDIO_AER_mask = &Hffff
        if data_low > LONG_MAX then
            if MDIO_AER_mask = mask then
                read_MDIO_AER_value = data_low
            else
                read_MDIO_AER_value = (data_low - H8000_0000) and MDIO_AER_mask
            end If
        else
            read_MDIO_AER_value = data_low and MDIO_AER_mask
        end If

    End Sub

    Sub write
        If flag_MDIO_AER = &H0 Then read
        If flag_MDIO_AER = &H0 Then write_MDIO_AER_value = get_MDIO_AER

        regValue = leftShift((write_MDIO_AER_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MDIO_AER_mask = &Hffff
        if data_low > LONG_MAX then
            if MDIO_AER_mask = mask then
                read_MDIO_AER_value = data_low
            else
                read_MDIO_AER_value = (data_low - H8000_0000) and MDIO_AER_mask
            end If
        else
            read_MDIO_AER_value = data_low and MDIO_AER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MDIO_AER_value = &H0
        flag_MDIO_AER        = &H0
    End Sub
End Class


'' @REGISTER : MDIO_MMDSEL_AER_COM_MDIO_BLK_ADDR_SGMIIPLUSR_X1_blk_addr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MDIO_BLK_ADDR                              [14:4]           get_MDIO_BLK_ADDR
''                                                             set_MDIO_BLK_ADDR
''                                                             read_MDIO_BLK_ADDR
''                                                             write_MDIO_BLK_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_MDIO_MMDSEL_AER_COM_MDIO_BLK_ADDR_SGMIIPLUSR_X1_blk_addr
    Private write_MDIO_BLK_ADDR_value
    Private read_MDIO_BLK_ADDR_value
    Private flag_MDIO_BLK_ADDR

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

    Property Get get_MDIO_BLK_ADDR
        get_MDIO_BLK_ADDR = read_MDIO_BLK_ADDR_value
    End Property

    Property Let set_MDIO_BLK_ADDR(aData)
        write_MDIO_BLK_ADDR_value = aData
        flag_MDIO_BLK_ADDR        = &H1
    End Property

    Property Get read_MDIO_BLK_ADDR
        read
        read_MDIO_BLK_ADDR = read_MDIO_BLK_ADDR_value
    End Property

    Property Let write_MDIO_BLK_ADDR(aData)
        set_MDIO_BLK_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MDIO_BLK_ADDR_value = rightShift(data_low, 4) and &H7ff

    End Sub

    Sub write
        If flag_MDIO_BLK_ADDR = &H0 Then read
        If flag_MDIO_BLK_ADDR = &H0 Then write_MDIO_BLK_ADDR_value = get_MDIO_BLK_ADDR

        regValue = leftShift((write_MDIO_BLK_ADDR_value and &H7ff), 4)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MDIO_BLK_ADDR_value = rightShift(data_low, 4) and &H7ff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MDIO_BLK_ADDR_value = &H0
        flag_MDIO_BLK_ADDR        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class MDIO_MMDSEL_AER_COM_MDIO_BLK_ADDR_SGMIIPLUSR_X1_INSTANCE

    Public mdio_brcst_port_addr
    Public mdio_mmd_select
    Public mdio_aer
    Public blk_addr


    Public default function Init(aBaseAddr)
        Set mdio_brcst_port_addr = (New REGISTER_MDIO_MMDSEL_AER_COM_MDIO_BLK_ADDR_SGMIIPLUSR_X1_mdio_brcst_port_addr)(aBaseAddr, 16)
        Set mdio_mmd_select = (New REGISTER_MDIO_MMDSEL_AER_COM_MDIO_BLK_ADDR_SGMIIPLUSR_X1_mdio_mmd_select)(aBaseAddr, 16)
        Set mdio_aer = (New REGISTER_MDIO_MMDSEL_AER_COM_MDIO_BLK_ADDR_SGMIIPLUSR_X1_mdio_aer)(aBaseAddr, 16)
        Set blk_addr = (New REGISTER_MDIO_MMDSEL_AER_COM_MDIO_BLK_ADDR_SGMIIPLUSR_X1_blk_addr)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set MDIO_MMDSEL_AER_COM_MDIO_BLK_ADDR_SGMIIPLUSR_X1 = CreateObject("System.Collections.ArrayList")
MDIO_MMDSEL_AER_COM_MDIO_BLK_ADDR_SGMIIPLUSR_X1.Add ((New MDIO_MMDSEL_AER_COM_MDIO_BLK_ADDR_SGMIIPLUSR_X1_INSTANCE)(&H4ae5ffa0))


