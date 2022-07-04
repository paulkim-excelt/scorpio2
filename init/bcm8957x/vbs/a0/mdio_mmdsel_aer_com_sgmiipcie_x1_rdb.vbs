

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


'' @REGISTER : MDIO_MMDSEL_AER_COM_SGMIIPCIE_X1_mdio_brcst_port_addr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mdio_drv_comclk                            [15:15]          get_mdio_drv_comclk
''                                                             set_mdio_drv_comclk
''                                                             read_mdio_drv_comclk
''                                                             write_mdio_drv_comclk
''---------------------------------------------------------------------------------
'' MBPA                                       [4:0]            get_MBPA
''                                                             set_MBPA
''                                                             read_MBPA
''                                                             write_MBPA
''---------------------------------------------------------------------------------
Class REGISTER_MDIO_MMDSEL_AER_COM_SGMIIPCIE_X1_mdio_brcst_port_addr
    Private write_mdio_drv_comclk_value
    Private read_mdio_drv_comclk_value
    Private flag_mdio_drv_comclk
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

    Property Get get_mdio_drv_comclk
        get_mdio_drv_comclk = read_mdio_drv_comclk_value
    End Property

    Property Let set_mdio_drv_comclk(aData)
        write_mdio_drv_comclk_value = aData
        flag_mdio_drv_comclk        = &H1
    End Property

    Property Get read_mdio_drv_comclk
        read
        read_mdio_drv_comclk = read_mdio_drv_comclk_value
    End Property

    Property Let write_mdio_drv_comclk(aData)
        set_mdio_drv_comclk = aData
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
        read_mdio_drv_comclk_value = rightShift(data_low, 15) and &H1
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
        If flag_mdio_drv_comclk = &H0 or flag_MBPA = &H0 Then read
        If flag_mdio_drv_comclk = &H0 Then write_mdio_drv_comclk_value = get_mdio_drv_comclk
        If flag_MBPA = &H0 Then write_MBPA_value = get_MBPA

        regValue = leftShift((write_mdio_drv_comclk_value and &H1), 15) + leftShift((write_MBPA_value and &H1f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mdio_drv_comclk_value = rightShift(data_low, 15) and &H1
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
        write_mdio_drv_comclk_value = &H0
        flag_mdio_drv_comclk        = &H0
        write_MBPA_value = &H0
        flag_MBPA        = &H0
    End Sub
End Class


'' @REGISTER : MDIO_MMDSEL_AER_COM_SGMIIPCIE_X1_mdio_mmd_select
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mdio_multi_prts_en                         [15:15]          get_mdio_multi_prts_en
''                                                             set_mdio_multi_prts_en
''                                                             read_mdio_multi_prts_en
''                                                             write_mdio_multi_prts_en
''---------------------------------------------------------------------------------
'' mdio_multi_mmds_en                         [14:14]          get_mdio_multi_mmds_en
''                                                             set_mdio_multi_mmds_en
''                                                             read_mdio_multi_mmds_en
''                                                             write_mdio_multi_mmds_en
''---------------------------------------------------------------------------------
'' mdio_dev_pcs_en                            [6:6]            get_mdio_dev_pcs_en
''                                                             set_mdio_dev_pcs_en
''                                                             read_mdio_dev_pcs_en
''                                                             write_mdio_dev_pcs_en
''---------------------------------------------------------------------------------
'' mdio_dev_dte_en                            [5:5]            get_mdio_dev_dte_en
''                                                             set_mdio_dev_dte_en
''                                                             read_mdio_dev_dte_en
''                                                             write_mdio_dev_dte_en
''---------------------------------------------------------------------------------
'' mdio_dev_phy_en                            [4:4]            get_mdio_dev_phy_en
''                                                             set_mdio_dev_phy_en
''                                                             read_mdio_dev_phy_en
''                                                             write_mdio_dev_phy_en
''---------------------------------------------------------------------------------
'' mdio_dev_an_en                             [3:3]            get_mdio_dev_an_en
''                                                             set_mdio_dev_an_en
''                                                             read_mdio_dev_an_en
''                                                             write_mdio_dev_an_en
''---------------------------------------------------------------------------------
'' mdio_dev_pmd_en                            [2:2]            get_mdio_dev_pmd_en
''                                                             set_mdio_dev_pmd_en
''                                                             read_mdio_dev_pmd_en
''                                                             write_mdio_dev_pmd_en
''---------------------------------------------------------------------------------
'' mdio_dev_id0_en                            [0:0]            get_mdio_dev_id0_en
''                                                             set_mdio_dev_id0_en
''                                                             read_mdio_dev_id0_en
''                                                             write_mdio_dev_id0_en
''---------------------------------------------------------------------------------
Class REGISTER_MDIO_MMDSEL_AER_COM_SGMIIPCIE_X1_mdio_mmd_select
    Private write_mdio_multi_prts_en_value
    Private read_mdio_multi_prts_en_value
    Private flag_mdio_multi_prts_en
    Private write_mdio_multi_mmds_en_value
    Private read_mdio_multi_mmds_en_value
    Private flag_mdio_multi_mmds_en
    Private write_mdio_dev_pcs_en_value
    Private read_mdio_dev_pcs_en_value
    Private flag_mdio_dev_pcs_en
    Private write_mdio_dev_dte_en_value
    Private read_mdio_dev_dte_en_value
    Private flag_mdio_dev_dte_en
    Private write_mdio_dev_phy_en_value
    Private read_mdio_dev_phy_en_value
    Private flag_mdio_dev_phy_en
    Private write_mdio_dev_an_en_value
    Private read_mdio_dev_an_en_value
    Private flag_mdio_dev_an_en
    Private write_mdio_dev_pmd_en_value
    Private read_mdio_dev_pmd_en_value
    Private flag_mdio_dev_pmd_en
    Private write_mdio_dev_id0_en_value
    Private read_mdio_dev_id0_en_value
    Private flag_mdio_dev_id0_en

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

    Property Get get_mdio_multi_prts_en
        get_mdio_multi_prts_en = read_mdio_multi_prts_en_value
    End Property

    Property Let set_mdio_multi_prts_en(aData)
        write_mdio_multi_prts_en_value = aData
        flag_mdio_multi_prts_en        = &H1
    End Property

    Property Get read_mdio_multi_prts_en
        read
        read_mdio_multi_prts_en = read_mdio_multi_prts_en_value
    End Property

    Property Let write_mdio_multi_prts_en(aData)
        set_mdio_multi_prts_en = aData
        write
    End Property

    Property Get get_mdio_multi_mmds_en
        get_mdio_multi_mmds_en = read_mdio_multi_mmds_en_value
    End Property

    Property Let set_mdio_multi_mmds_en(aData)
        write_mdio_multi_mmds_en_value = aData
        flag_mdio_multi_mmds_en        = &H1
    End Property

    Property Get read_mdio_multi_mmds_en
        read
        read_mdio_multi_mmds_en = read_mdio_multi_mmds_en_value
    End Property

    Property Let write_mdio_multi_mmds_en(aData)
        set_mdio_multi_mmds_en = aData
        write
    End Property

    Property Get get_mdio_dev_pcs_en
        get_mdio_dev_pcs_en = read_mdio_dev_pcs_en_value
    End Property

    Property Let set_mdio_dev_pcs_en(aData)
        write_mdio_dev_pcs_en_value = aData
        flag_mdio_dev_pcs_en        = &H1
    End Property

    Property Get read_mdio_dev_pcs_en
        read
        read_mdio_dev_pcs_en = read_mdio_dev_pcs_en_value
    End Property

    Property Let write_mdio_dev_pcs_en(aData)
        set_mdio_dev_pcs_en = aData
        write
    End Property

    Property Get get_mdio_dev_dte_en
        get_mdio_dev_dte_en = read_mdio_dev_dte_en_value
    End Property

    Property Let set_mdio_dev_dte_en(aData)
        write_mdio_dev_dte_en_value = aData
        flag_mdio_dev_dte_en        = &H1
    End Property

    Property Get read_mdio_dev_dte_en
        read
        read_mdio_dev_dte_en = read_mdio_dev_dte_en_value
    End Property

    Property Let write_mdio_dev_dte_en(aData)
        set_mdio_dev_dte_en = aData
        write
    End Property

    Property Get get_mdio_dev_phy_en
        get_mdio_dev_phy_en = read_mdio_dev_phy_en_value
    End Property

    Property Let set_mdio_dev_phy_en(aData)
        write_mdio_dev_phy_en_value = aData
        flag_mdio_dev_phy_en        = &H1
    End Property

    Property Get read_mdio_dev_phy_en
        read
        read_mdio_dev_phy_en = read_mdio_dev_phy_en_value
    End Property

    Property Let write_mdio_dev_phy_en(aData)
        set_mdio_dev_phy_en = aData
        write
    End Property

    Property Get get_mdio_dev_an_en
        get_mdio_dev_an_en = read_mdio_dev_an_en_value
    End Property

    Property Let set_mdio_dev_an_en(aData)
        write_mdio_dev_an_en_value = aData
        flag_mdio_dev_an_en        = &H1
    End Property

    Property Get read_mdio_dev_an_en
        read
        read_mdio_dev_an_en = read_mdio_dev_an_en_value
    End Property

    Property Let write_mdio_dev_an_en(aData)
        set_mdio_dev_an_en = aData
        write
    End Property

    Property Get get_mdio_dev_pmd_en
        get_mdio_dev_pmd_en = read_mdio_dev_pmd_en_value
    End Property

    Property Let set_mdio_dev_pmd_en(aData)
        write_mdio_dev_pmd_en_value = aData
        flag_mdio_dev_pmd_en        = &H1
    End Property

    Property Get read_mdio_dev_pmd_en
        read
        read_mdio_dev_pmd_en = read_mdio_dev_pmd_en_value
    End Property

    Property Let write_mdio_dev_pmd_en(aData)
        set_mdio_dev_pmd_en = aData
        write
    End Property

    Property Get get_mdio_dev_id0_en
        get_mdio_dev_id0_en = read_mdio_dev_id0_en_value
    End Property

    Property Let set_mdio_dev_id0_en(aData)
        write_mdio_dev_id0_en_value = aData
        flag_mdio_dev_id0_en        = &H1
    End Property

    Property Get read_mdio_dev_id0_en
        read
        read_mdio_dev_id0_en = read_mdio_dev_id0_en_value
    End Property

    Property Let write_mdio_dev_id0_en(aData)
        set_mdio_dev_id0_en = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mdio_multi_prts_en_value = rightShift(data_low, 15) and &H1
        read_mdio_multi_mmds_en_value = rightShift(data_low, 14) and &H1
        read_mdio_dev_pcs_en_value = rightShift(data_low, 6) and &H1
        read_mdio_dev_dte_en_value = rightShift(data_low, 5) and &H1
        read_mdio_dev_phy_en_value = rightShift(data_low, 4) and &H1
        read_mdio_dev_an_en_value = rightShift(data_low, 3) and &H1
        read_mdio_dev_pmd_en_value = rightShift(data_low, 2) and &H1
        mdio_dev_id0_en_mask = &H1
        if data_low > LONG_MAX then
            if mdio_dev_id0_en_mask = mask then
                read_mdio_dev_id0_en_value = data_low
            else
                read_mdio_dev_id0_en_value = (data_low - H8000_0000) and mdio_dev_id0_en_mask
            end If
        else
            read_mdio_dev_id0_en_value = data_low and mdio_dev_id0_en_mask
        end If

    End Sub

    Sub write
        If flag_mdio_multi_prts_en = &H0 or flag_mdio_multi_mmds_en = &H0 or flag_mdio_dev_pcs_en = &H0 or flag_mdio_dev_dte_en = &H0 or flag_mdio_dev_phy_en = &H0 or flag_mdio_dev_an_en = &H0 or flag_mdio_dev_pmd_en = &H0 or flag_mdio_dev_id0_en = &H0 Then read
        If flag_mdio_multi_prts_en = &H0 Then write_mdio_multi_prts_en_value = get_mdio_multi_prts_en
        If flag_mdio_multi_mmds_en = &H0 Then write_mdio_multi_mmds_en_value = get_mdio_multi_mmds_en
        If flag_mdio_dev_pcs_en = &H0 Then write_mdio_dev_pcs_en_value = get_mdio_dev_pcs_en
        If flag_mdio_dev_dte_en = &H0 Then write_mdio_dev_dte_en_value = get_mdio_dev_dte_en
        If flag_mdio_dev_phy_en = &H0 Then write_mdio_dev_phy_en_value = get_mdio_dev_phy_en
        If flag_mdio_dev_an_en = &H0 Then write_mdio_dev_an_en_value = get_mdio_dev_an_en
        If flag_mdio_dev_pmd_en = &H0 Then write_mdio_dev_pmd_en_value = get_mdio_dev_pmd_en
        If flag_mdio_dev_id0_en = &H0 Then write_mdio_dev_id0_en_value = get_mdio_dev_id0_en

        regValue = leftShift((write_mdio_multi_prts_en_value and &H1), 15) + leftShift((write_mdio_multi_mmds_en_value and &H1), 14) + leftShift((write_mdio_dev_pcs_en_value and &H1), 6) + leftShift((write_mdio_dev_dte_en_value and &H1), 5) + leftShift((write_mdio_dev_phy_en_value and &H1), 4) + leftShift((write_mdio_dev_an_en_value and &H1), 3) + leftShift((write_mdio_dev_pmd_en_value and &H1), 2) + leftShift((write_mdio_dev_id0_en_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mdio_multi_prts_en_value = rightShift(data_low, 15) and &H1
        read_mdio_multi_mmds_en_value = rightShift(data_low, 14) and &H1
        read_mdio_dev_pcs_en_value = rightShift(data_low, 6) and &H1
        read_mdio_dev_dte_en_value = rightShift(data_low, 5) and &H1
        read_mdio_dev_phy_en_value = rightShift(data_low, 4) and &H1
        read_mdio_dev_an_en_value = rightShift(data_low, 3) and &H1
        read_mdio_dev_pmd_en_value = rightShift(data_low, 2) and &H1
        mdio_dev_id0_en_mask = &H1
        if data_low > LONG_MAX then
            if mdio_dev_id0_en_mask = mask then
                read_mdio_dev_id0_en_value = data_low
            else
                read_mdio_dev_id0_en_value = (data_low - H8000_0000) and mdio_dev_id0_en_mask
            end If
        else
            read_mdio_dev_id0_en_value = data_low and mdio_dev_id0_en_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mdio_multi_prts_en_value = &H0
        flag_mdio_multi_prts_en        = &H0
        write_mdio_multi_mmds_en_value = &H0
        flag_mdio_multi_mmds_en        = &H0
        write_mdio_dev_pcs_en_value = &H0
        flag_mdio_dev_pcs_en        = &H0
        write_mdio_dev_dte_en_value = &H0
        flag_mdio_dev_dte_en        = &H0
        write_mdio_dev_phy_en_value = &H0
        flag_mdio_dev_phy_en        = &H0
        write_mdio_dev_an_en_value = &H0
        flag_mdio_dev_an_en        = &H0
        write_mdio_dev_pmd_en_value = &H0
        flag_mdio_dev_pmd_en        = &H0
        write_mdio_dev_id0_en_value = &H0
        flag_mdio_dev_id0_en        = &H0
    End Sub
End Class


'' @REGISTER : MDIO_MMDSEL_AER_COM_SGMIIPCIE_X1_mdio_aer
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mdio_aer                                   [15:0]           get_mdio_aer
''                                                             set_mdio_aer
''                                                             read_mdio_aer
''                                                             write_mdio_aer
''---------------------------------------------------------------------------------
Class REGISTER_MDIO_MMDSEL_AER_COM_SGMIIPCIE_X1_mdio_aer
    Private write_mdio_aer_value
    Private read_mdio_aer_value
    Private flag_mdio_aer

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

    Property Get get_mdio_aer
        get_mdio_aer = read_mdio_aer_value
    End Property

    Property Let set_mdio_aer(aData)
        write_mdio_aer_value = aData
        flag_mdio_aer        = &H1
    End Property

    Property Get read_mdio_aer
        read
        read_mdio_aer = read_mdio_aer_value
    End Property

    Property Let write_mdio_aer(aData)
        set_mdio_aer = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mdio_aer_mask = &Hffff
        if data_low > LONG_MAX then
            if mdio_aer_mask = mask then
                read_mdio_aer_value = data_low
            else
                read_mdio_aer_value = (data_low - H8000_0000) and mdio_aer_mask
            end If
        else
            read_mdio_aer_value = data_low and mdio_aer_mask
        end If

    End Sub

    Sub write
        If flag_mdio_aer = &H0 Then read
        If flag_mdio_aer = &H0 Then write_mdio_aer_value = get_mdio_aer

        regValue = leftShift((write_mdio_aer_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mdio_aer_mask = &Hffff
        if data_low > LONG_MAX then
            if mdio_aer_mask = mask then
                read_mdio_aer_value = data_low
            else
                read_mdio_aer_value = (data_low - H8000_0000) and mdio_aer_mask
            end If
        else
            read_mdio_aer_value = data_low and mdio_aer_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mdio_aer_value = &H0
        flag_mdio_aer        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class MDIO_MMDSEL_AER_COM_SGMIIPCIE_X1_INSTANCE

    Public mdio_brcst_port_addr
    Public mdio_mmd_select
    Public mdio_aer


    Public default function Init(aBaseAddr)
        Set mdio_brcst_port_addr = (New REGISTER_MDIO_MMDSEL_AER_COM_SGMIIPCIE_X1_mdio_brcst_port_addr)(aBaseAddr, 16)
        Set mdio_mmd_select = (New REGISTER_MDIO_MMDSEL_AER_COM_SGMIIPCIE_X1_mdio_mmd_select)(aBaseAddr, 16)
        Set mdio_aer = (New REGISTER_MDIO_MMDSEL_AER_COM_SGMIIPCIE_X1_mdio_aer)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set MDIO_MMDSEL_AER_COM_SGMIIPCIE_X1 = CreateObject("System.Collections.ArrayList")
MDIO_MMDSEL_AER_COM_SGMIIPCIE_X1.Add ((New MDIO_MMDSEL_AER_COM_SGMIIPCIE_X1_INSTANCE)(&H4ad5ffa0))


