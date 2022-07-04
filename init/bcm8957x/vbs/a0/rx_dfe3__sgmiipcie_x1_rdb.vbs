

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


'' @REGISTER : RX_DFE3__SGMIIPCIE_X1_ctrl0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' cdrLockTimeAcqFst_S1_G1_SM                 [15:8]           get_cdrLockTimeAcqFst_S1_G1_SM
''                                                             set_cdrLockTimeAcqFst_S1_G1_SM
''                                                             read_cdrLockTimeAcqFst_S1_G1_SM
''                                                             write_cdrLockTimeAcqFst_S1_G1_SM
''---------------------------------------------------------------------------------
'' bwsel_prop_acq_fst_S1_G1_SM                [7:4]            get_bwsel_prop_acq_fst_S1_G1_SM
''                                                             set_bwsel_prop_acq_fst_S1_G1_SM
''                                                             read_bwsel_prop_acq_fst_S1_G1_SM
''                                                             write_bwsel_prop_acq_fst_S1_G1_SM
''---------------------------------------------------------------------------------
'' bwsel_integ_acq_fst_S1_G1_SM               [3:0]            get_bwsel_integ_acq_fst_S1_G1_SM
''                                                             set_bwsel_integ_acq_fst_S1_G1_SM
''                                                             read_bwsel_integ_acq_fst_S1_G1_SM
''                                                             write_bwsel_integ_acq_fst_S1_G1_SM
''---------------------------------------------------------------------------------
Class REGISTER_RX_DFE3__SGMIIPCIE_X1_ctrl0
    Private write_cdrLockTimeAcqFst_S1_G1_SM_value
    Private read_cdrLockTimeAcqFst_S1_G1_SM_value
    Private flag_cdrLockTimeAcqFst_S1_G1_SM
    Private write_bwsel_prop_acq_fst_S1_G1_SM_value
    Private read_bwsel_prop_acq_fst_S1_G1_SM_value
    Private flag_bwsel_prop_acq_fst_S1_G1_SM
    Private write_bwsel_integ_acq_fst_S1_G1_SM_value
    Private read_bwsel_integ_acq_fst_S1_G1_SM_value
    Private flag_bwsel_integ_acq_fst_S1_G1_SM

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

    Property Get get_cdrLockTimeAcqFst_S1_G1_SM
        get_cdrLockTimeAcqFst_S1_G1_SM = read_cdrLockTimeAcqFst_S1_G1_SM_value
    End Property

    Property Let set_cdrLockTimeAcqFst_S1_G1_SM(aData)
        write_cdrLockTimeAcqFst_S1_G1_SM_value = aData
        flag_cdrLockTimeAcqFst_S1_G1_SM        = &H1
    End Property

    Property Get read_cdrLockTimeAcqFst_S1_G1_SM
        read
        read_cdrLockTimeAcqFst_S1_G1_SM = read_cdrLockTimeAcqFst_S1_G1_SM_value
    End Property

    Property Let write_cdrLockTimeAcqFst_S1_G1_SM(aData)
        set_cdrLockTimeAcqFst_S1_G1_SM = aData
        write
    End Property

    Property Get get_bwsel_prop_acq_fst_S1_G1_SM
        get_bwsel_prop_acq_fst_S1_G1_SM = read_bwsel_prop_acq_fst_S1_G1_SM_value
    End Property

    Property Let set_bwsel_prop_acq_fst_S1_G1_SM(aData)
        write_bwsel_prop_acq_fst_S1_G1_SM_value = aData
        flag_bwsel_prop_acq_fst_S1_G1_SM        = &H1
    End Property

    Property Get read_bwsel_prop_acq_fst_S1_G1_SM
        read
        read_bwsel_prop_acq_fst_S1_G1_SM = read_bwsel_prop_acq_fst_S1_G1_SM_value
    End Property

    Property Let write_bwsel_prop_acq_fst_S1_G1_SM(aData)
        set_bwsel_prop_acq_fst_S1_G1_SM = aData
        write
    End Property

    Property Get get_bwsel_integ_acq_fst_S1_G1_SM
        get_bwsel_integ_acq_fst_S1_G1_SM = read_bwsel_integ_acq_fst_S1_G1_SM_value
    End Property

    Property Let set_bwsel_integ_acq_fst_S1_G1_SM(aData)
        write_bwsel_integ_acq_fst_S1_G1_SM_value = aData
        flag_bwsel_integ_acq_fst_S1_G1_SM        = &H1
    End Property

    Property Get read_bwsel_integ_acq_fst_S1_G1_SM
        read
        read_bwsel_integ_acq_fst_S1_G1_SM = read_bwsel_integ_acq_fst_S1_G1_SM_value
    End Property

    Property Let write_bwsel_integ_acq_fst_S1_G1_SM(aData)
        set_bwsel_integ_acq_fst_S1_G1_SM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_cdrLockTimeAcqFst_S1_G1_SM_value = rightShift(data_low, 8) and &Hff
        read_bwsel_prop_acq_fst_S1_G1_SM_value = rightShift(data_low, 4) and &Hf
        bwsel_integ_acq_fst_S1_G1_SM_mask = &Hf
        if data_low > LONG_MAX then
            if bwsel_integ_acq_fst_S1_G1_SM_mask = mask then
                read_bwsel_integ_acq_fst_S1_G1_SM_value = data_low
            else
                read_bwsel_integ_acq_fst_S1_G1_SM_value = (data_low - H8000_0000) and bwsel_integ_acq_fst_S1_G1_SM_mask
            end If
        else
            read_bwsel_integ_acq_fst_S1_G1_SM_value = data_low and bwsel_integ_acq_fst_S1_G1_SM_mask
        end If

    End Sub

    Sub write
        If flag_cdrLockTimeAcqFst_S1_G1_SM = &H0 or flag_bwsel_prop_acq_fst_S1_G1_SM = &H0 or flag_bwsel_integ_acq_fst_S1_G1_SM = &H0 Then read
        If flag_cdrLockTimeAcqFst_S1_G1_SM = &H0 Then write_cdrLockTimeAcqFst_S1_G1_SM_value = get_cdrLockTimeAcqFst_S1_G1_SM
        If flag_bwsel_prop_acq_fst_S1_G1_SM = &H0 Then write_bwsel_prop_acq_fst_S1_G1_SM_value = get_bwsel_prop_acq_fst_S1_G1_SM
        If flag_bwsel_integ_acq_fst_S1_G1_SM = &H0 Then write_bwsel_integ_acq_fst_S1_G1_SM_value = get_bwsel_integ_acq_fst_S1_G1_SM

        regValue = leftShift((write_cdrLockTimeAcqFst_S1_G1_SM_value and &Hff), 8) + leftShift((write_bwsel_prop_acq_fst_S1_G1_SM_value and &Hf), 4) + leftShift((write_bwsel_integ_acq_fst_S1_G1_SM_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_cdrLockTimeAcqFst_S1_G1_SM_value = rightShift(data_low, 8) and &Hff
        read_bwsel_prop_acq_fst_S1_G1_SM_value = rightShift(data_low, 4) and &Hf
        bwsel_integ_acq_fst_S1_G1_SM_mask = &Hf
        if data_low > LONG_MAX then
            if bwsel_integ_acq_fst_S1_G1_SM_mask = mask then
                read_bwsel_integ_acq_fst_S1_G1_SM_value = data_low
            else
                read_bwsel_integ_acq_fst_S1_G1_SM_value = (data_low - H8000_0000) and bwsel_integ_acq_fst_S1_G1_SM_mask
            end If
        else
            read_bwsel_integ_acq_fst_S1_G1_SM_value = data_low and bwsel_integ_acq_fst_S1_G1_SM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_cdrLockTimeAcqFst_S1_G1_SM_value = &H0
        flag_cdrLockTimeAcqFst_S1_G1_SM        = &H0
        write_bwsel_prop_acq_fst_S1_G1_SM_value = &H0
        flag_bwsel_prop_acq_fst_S1_G1_SM        = &H0
        write_bwsel_integ_acq_fst_S1_G1_SM_value = &H0
        flag_bwsel_integ_acq_fst_S1_G1_SM        = &H0
    End Sub
End Class


'' @REGISTER : RX_DFE3__SGMIIPCIE_X1_ctrl1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' cdrLockTimeAcqFst_S2_G1_SM                 [15:8]           get_cdrLockTimeAcqFst_S2_G1_SM
''                                                             set_cdrLockTimeAcqFst_S2_G1_SM
''                                                             read_cdrLockTimeAcqFst_S2_G1_SM
''                                                             write_cdrLockTimeAcqFst_S2_G1_SM
''---------------------------------------------------------------------------------
'' bwsel_prop_acq_fst_S2_G1_SM                [7:4]            get_bwsel_prop_acq_fst_S2_G1_SM
''                                                             set_bwsel_prop_acq_fst_S2_G1_SM
''                                                             read_bwsel_prop_acq_fst_S2_G1_SM
''                                                             write_bwsel_prop_acq_fst_S2_G1_SM
''---------------------------------------------------------------------------------
'' bwsel_integ_acq_fst_S2_G1_SM               [3:0]            get_bwsel_integ_acq_fst_S2_G1_SM
''                                                             set_bwsel_integ_acq_fst_S2_G1_SM
''                                                             read_bwsel_integ_acq_fst_S2_G1_SM
''                                                             write_bwsel_integ_acq_fst_S2_G1_SM
''---------------------------------------------------------------------------------
Class REGISTER_RX_DFE3__SGMIIPCIE_X1_ctrl1
    Private write_cdrLockTimeAcqFst_S2_G1_SM_value
    Private read_cdrLockTimeAcqFst_S2_G1_SM_value
    Private flag_cdrLockTimeAcqFst_S2_G1_SM
    Private write_bwsel_prop_acq_fst_S2_G1_SM_value
    Private read_bwsel_prop_acq_fst_S2_G1_SM_value
    Private flag_bwsel_prop_acq_fst_S2_G1_SM
    Private write_bwsel_integ_acq_fst_S2_G1_SM_value
    Private read_bwsel_integ_acq_fst_S2_G1_SM_value
    Private flag_bwsel_integ_acq_fst_S2_G1_SM

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

    Property Get get_cdrLockTimeAcqFst_S2_G1_SM
        get_cdrLockTimeAcqFst_S2_G1_SM = read_cdrLockTimeAcqFst_S2_G1_SM_value
    End Property

    Property Let set_cdrLockTimeAcqFst_S2_G1_SM(aData)
        write_cdrLockTimeAcqFst_S2_G1_SM_value = aData
        flag_cdrLockTimeAcqFst_S2_G1_SM        = &H1
    End Property

    Property Get read_cdrLockTimeAcqFst_S2_G1_SM
        read
        read_cdrLockTimeAcqFst_S2_G1_SM = read_cdrLockTimeAcqFst_S2_G1_SM_value
    End Property

    Property Let write_cdrLockTimeAcqFst_S2_G1_SM(aData)
        set_cdrLockTimeAcqFst_S2_G1_SM = aData
        write
    End Property

    Property Get get_bwsel_prop_acq_fst_S2_G1_SM
        get_bwsel_prop_acq_fst_S2_G1_SM = read_bwsel_prop_acq_fst_S2_G1_SM_value
    End Property

    Property Let set_bwsel_prop_acq_fst_S2_G1_SM(aData)
        write_bwsel_prop_acq_fst_S2_G1_SM_value = aData
        flag_bwsel_prop_acq_fst_S2_G1_SM        = &H1
    End Property

    Property Get read_bwsel_prop_acq_fst_S2_G1_SM
        read
        read_bwsel_prop_acq_fst_S2_G1_SM = read_bwsel_prop_acq_fst_S2_G1_SM_value
    End Property

    Property Let write_bwsel_prop_acq_fst_S2_G1_SM(aData)
        set_bwsel_prop_acq_fst_S2_G1_SM = aData
        write
    End Property

    Property Get get_bwsel_integ_acq_fst_S2_G1_SM
        get_bwsel_integ_acq_fst_S2_G1_SM = read_bwsel_integ_acq_fst_S2_G1_SM_value
    End Property

    Property Let set_bwsel_integ_acq_fst_S2_G1_SM(aData)
        write_bwsel_integ_acq_fst_S2_G1_SM_value = aData
        flag_bwsel_integ_acq_fst_S2_G1_SM        = &H1
    End Property

    Property Get read_bwsel_integ_acq_fst_S2_G1_SM
        read
        read_bwsel_integ_acq_fst_S2_G1_SM = read_bwsel_integ_acq_fst_S2_G1_SM_value
    End Property

    Property Let write_bwsel_integ_acq_fst_S2_G1_SM(aData)
        set_bwsel_integ_acq_fst_S2_G1_SM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_cdrLockTimeAcqFst_S2_G1_SM_value = rightShift(data_low, 8) and &Hff
        read_bwsel_prop_acq_fst_S2_G1_SM_value = rightShift(data_low, 4) and &Hf
        bwsel_integ_acq_fst_S2_G1_SM_mask = &Hf
        if data_low > LONG_MAX then
            if bwsel_integ_acq_fst_S2_G1_SM_mask = mask then
                read_bwsel_integ_acq_fst_S2_G1_SM_value = data_low
            else
                read_bwsel_integ_acq_fst_S2_G1_SM_value = (data_low - H8000_0000) and bwsel_integ_acq_fst_S2_G1_SM_mask
            end If
        else
            read_bwsel_integ_acq_fst_S2_G1_SM_value = data_low and bwsel_integ_acq_fst_S2_G1_SM_mask
        end If

    End Sub

    Sub write
        If flag_cdrLockTimeAcqFst_S2_G1_SM = &H0 or flag_bwsel_prop_acq_fst_S2_G1_SM = &H0 or flag_bwsel_integ_acq_fst_S2_G1_SM = &H0 Then read
        If flag_cdrLockTimeAcqFst_S2_G1_SM = &H0 Then write_cdrLockTimeAcqFst_S2_G1_SM_value = get_cdrLockTimeAcqFst_S2_G1_SM
        If flag_bwsel_prop_acq_fst_S2_G1_SM = &H0 Then write_bwsel_prop_acq_fst_S2_G1_SM_value = get_bwsel_prop_acq_fst_S2_G1_SM
        If flag_bwsel_integ_acq_fst_S2_G1_SM = &H0 Then write_bwsel_integ_acq_fst_S2_G1_SM_value = get_bwsel_integ_acq_fst_S2_G1_SM

        regValue = leftShift((write_cdrLockTimeAcqFst_S2_G1_SM_value and &Hff), 8) + leftShift((write_bwsel_prop_acq_fst_S2_G1_SM_value and &Hf), 4) + leftShift((write_bwsel_integ_acq_fst_S2_G1_SM_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_cdrLockTimeAcqFst_S2_G1_SM_value = rightShift(data_low, 8) and &Hff
        read_bwsel_prop_acq_fst_S2_G1_SM_value = rightShift(data_low, 4) and &Hf
        bwsel_integ_acq_fst_S2_G1_SM_mask = &Hf
        if data_low > LONG_MAX then
            if bwsel_integ_acq_fst_S2_G1_SM_mask = mask then
                read_bwsel_integ_acq_fst_S2_G1_SM_value = data_low
            else
                read_bwsel_integ_acq_fst_S2_G1_SM_value = (data_low - H8000_0000) and bwsel_integ_acq_fst_S2_G1_SM_mask
            end If
        else
            read_bwsel_integ_acq_fst_S2_G1_SM_value = data_low and bwsel_integ_acq_fst_S2_G1_SM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_cdrLockTimeAcqFst_S2_G1_SM_value = &H0
        flag_cdrLockTimeAcqFst_S2_G1_SM        = &H0
        write_bwsel_prop_acq_fst_S2_G1_SM_value = &H0
        flag_bwsel_prop_acq_fst_S2_G1_SM        = &H0
        write_bwsel_integ_acq_fst_S2_G1_SM_value = &H0
        flag_bwsel_integ_acq_fst_S2_G1_SM        = &H0
    End Sub
End Class


'' @REGISTER : RX_DFE3__SGMIIPCIE_X1_ctrl2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' cdrLockTimeAcqFst_S3_G1_SM                 [15:8]           get_cdrLockTimeAcqFst_S3_G1_SM
''                                                             set_cdrLockTimeAcqFst_S3_G1_SM
''                                                             read_cdrLockTimeAcqFst_S3_G1_SM
''                                                             write_cdrLockTimeAcqFst_S3_G1_SM
''---------------------------------------------------------------------------------
'' bwsel_prop_acq_fst_S3_G1_SM                [7:4]            get_bwsel_prop_acq_fst_S3_G1_SM
''                                                             set_bwsel_prop_acq_fst_S3_G1_SM
''                                                             read_bwsel_prop_acq_fst_S3_G1_SM
''                                                             write_bwsel_prop_acq_fst_S3_G1_SM
''---------------------------------------------------------------------------------
'' bwsel_integ_acq_fst_S3_G1_SM               [3:0]            get_bwsel_integ_acq_fst_S3_G1_SM
''                                                             set_bwsel_integ_acq_fst_S3_G1_SM
''                                                             read_bwsel_integ_acq_fst_S3_G1_SM
''                                                             write_bwsel_integ_acq_fst_S3_G1_SM
''---------------------------------------------------------------------------------
Class REGISTER_RX_DFE3__SGMIIPCIE_X1_ctrl2
    Private write_cdrLockTimeAcqFst_S3_G1_SM_value
    Private read_cdrLockTimeAcqFst_S3_G1_SM_value
    Private flag_cdrLockTimeAcqFst_S3_G1_SM
    Private write_bwsel_prop_acq_fst_S3_G1_SM_value
    Private read_bwsel_prop_acq_fst_S3_G1_SM_value
    Private flag_bwsel_prop_acq_fst_S3_G1_SM
    Private write_bwsel_integ_acq_fst_S3_G1_SM_value
    Private read_bwsel_integ_acq_fst_S3_G1_SM_value
    Private flag_bwsel_integ_acq_fst_S3_G1_SM

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

    Property Get get_cdrLockTimeAcqFst_S3_G1_SM
        get_cdrLockTimeAcqFst_S3_G1_SM = read_cdrLockTimeAcqFst_S3_G1_SM_value
    End Property

    Property Let set_cdrLockTimeAcqFst_S3_G1_SM(aData)
        write_cdrLockTimeAcqFst_S3_G1_SM_value = aData
        flag_cdrLockTimeAcqFst_S3_G1_SM        = &H1
    End Property

    Property Get read_cdrLockTimeAcqFst_S3_G1_SM
        read
        read_cdrLockTimeAcqFst_S3_G1_SM = read_cdrLockTimeAcqFst_S3_G1_SM_value
    End Property

    Property Let write_cdrLockTimeAcqFst_S3_G1_SM(aData)
        set_cdrLockTimeAcqFst_S3_G1_SM = aData
        write
    End Property

    Property Get get_bwsel_prop_acq_fst_S3_G1_SM
        get_bwsel_prop_acq_fst_S3_G1_SM = read_bwsel_prop_acq_fst_S3_G1_SM_value
    End Property

    Property Let set_bwsel_prop_acq_fst_S3_G1_SM(aData)
        write_bwsel_prop_acq_fst_S3_G1_SM_value = aData
        flag_bwsel_prop_acq_fst_S3_G1_SM        = &H1
    End Property

    Property Get read_bwsel_prop_acq_fst_S3_G1_SM
        read
        read_bwsel_prop_acq_fst_S3_G1_SM = read_bwsel_prop_acq_fst_S3_G1_SM_value
    End Property

    Property Let write_bwsel_prop_acq_fst_S3_G1_SM(aData)
        set_bwsel_prop_acq_fst_S3_G1_SM = aData
        write
    End Property

    Property Get get_bwsel_integ_acq_fst_S3_G1_SM
        get_bwsel_integ_acq_fst_S3_G1_SM = read_bwsel_integ_acq_fst_S3_G1_SM_value
    End Property

    Property Let set_bwsel_integ_acq_fst_S3_G1_SM(aData)
        write_bwsel_integ_acq_fst_S3_G1_SM_value = aData
        flag_bwsel_integ_acq_fst_S3_G1_SM        = &H1
    End Property

    Property Get read_bwsel_integ_acq_fst_S3_G1_SM
        read
        read_bwsel_integ_acq_fst_S3_G1_SM = read_bwsel_integ_acq_fst_S3_G1_SM_value
    End Property

    Property Let write_bwsel_integ_acq_fst_S3_G1_SM(aData)
        set_bwsel_integ_acq_fst_S3_G1_SM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_cdrLockTimeAcqFst_S3_G1_SM_value = rightShift(data_low, 8) and &Hff
        read_bwsel_prop_acq_fst_S3_G1_SM_value = rightShift(data_low, 4) and &Hf
        bwsel_integ_acq_fst_S3_G1_SM_mask = &Hf
        if data_low > LONG_MAX then
            if bwsel_integ_acq_fst_S3_G1_SM_mask = mask then
                read_bwsel_integ_acq_fst_S3_G1_SM_value = data_low
            else
                read_bwsel_integ_acq_fst_S3_G1_SM_value = (data_low - H8000_0000) and bwsel_integ_acq_fst_S3_G1_SM_mask
            end If
        else
            read_bwsel_integ_acq_fst_S3_G1_SM_value = data_low and bwsel_integ_acq_fst_S3_G1_SM_mask
        end If

    End Sub

    Sub write
        If flag_cdrLockTimeAcqFst_S3_G1_SM = &H0 or flag_bwsel_prop_acq_fst_S3_G1_SM = &H0 or flag_bwsel_integ_acq_fst_S3_G1_SM = &H0 Then read
        If flag_cdrLockTimeAcqFst_S3_G1_SM = &H0 Then write_cdrLockTimeAcqFst_S3_G1_SM_value = get_cdrLockTimeAcqFst_S3_G1_SM
        If flag_bwsel_prop_acq_fst_S3_G1_SM = &H0 Then write_bwsel_prop_acq_fst_S3_G1_SM_value = get_bwsel_prop_acq_fst_S3_G1_SM
        If flag_bwsel_integ_acq_fst_S3_G1_SM = &H0 Then write_bwsel_integ_acq_fst_S3_G1_SM_value = get_bwsel_integ_acq_fst_S3_G1_SM

        regValue = leftShift((write_cdrLockTimeAcqFst_S3_G1_SM_value and &Hff), 8) + leftShift((write_bwsel_prop_acq_fst_S3_G1_SM_value and &Hf), 4) + leftShift((write_bwsel_integ_acq_fst_S3_G1_SM_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_cdrLockTimeAcqFst_S3_G1_SM_value = rightShift(data_low, 8) and &Hff
        read_bwsel_prop_acq_fst_S3_G1_SM_value = rightShift(data_low, 4) and &Hf
        bwsel_integ_acq_fst_S3_G1_SM_mask = &Hf
        if data_low > LONG_MAX then
            if bwsel_integ_acq_fst_S3_G1_SM_mask = mask then
                read_bwsel_integ_acq_fst_S3_G1_SM_value = data_low
            else
                read_bwsel_integ_acq_fst_S3_G1_SM_value = (data_low - H8000_0000) and bwsel_integ_acq_fst_S3_G1_SM_mask
            end If
        else
            read_bwsel_integ_acq_fst_S3_G1_SM_value = data_low and bwsel_integ_acq_fst_S3_G1_SM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_cdrLockTimeAcqFst_S3_G1_SM_value = &H0
        flag_cdrLockTimeAcqFst_S3_G1_SM        = &H0
        write_bwsel_prop_acq_fst_S3_G1_SM_value = &H0
        flag_bwsel_prop_acq_fst_S3_G1_SM        = &H0
        write_bwsel_integ_acq_fst_S3_G1_SM_value = &H0
        flag_bwsel_integ_acq_fst_S3_G1_SM        = &H0
    End Sub
End Class


'' @REGISTER : RX_DFE3__SGMIIPCIE_X1_ctrl3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' cdrLockTimeTrckFst_G1_SM                   [15:8]           get_cdrLockTimeTrckFst_G1_SM
''                                                             set_cdrLockTimeTrckFst_G1_SM
''                                                             read_cdrLockTimeTrckFst_G1_SM
''                                                             write_cdrLockTimeTrckFst_G1_SM
''---------------------------------------------------------------------------------
'' bwsel_prop_trck_G1_SM                      [7:4]            get_bwsel_prop_trck_G1_SM
''                                                             set_bwsel_prop_trck_G1_SM
''                                                             read_bwsel_prop_trck_G1_SM
''                                                             write_bwsel_prop_trck_G1_SM
''---------------------------------------------------------------------------------
'' bwsel_integ_trck_G1_SM                     [3:0]            get_bwsel_integ_trck_G1_SM
''                                                             set_bwsel_integ_trck_G1_SM
''                                                             read_bwsel_integ_trck_G1_SM
''                                                             write_bwsel_integ_trck_G1_SM
''---------------------------------------------------------------------------------
Class REGISTER_RX_DFE3__SGMIIPCIE_X1_ctrl3
    Private write_cdrLockTimeTrckFst_G1_SM_value
    Private read_cdrLockTimeTrckFst_G1_SM_value
    Private flag_cdrLockTimeTrckFst_G1_SM
    Private write_bwsel_prop_trck_G1_SM_value
    Private read_bwsel_prop_trck_G1_SM_value
    Private flag_bwsel_prop_trck_G1_SM
    Private write_bwsel_integ_trck_G1_SM_value
    Private read_bwsel_integ_trck_G1_SM_value
    Private flag_bwsel_integ_trck_G1_SM

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

    Property Get get_cdrLockTimeTrckFst_G1_SM
        get_cdrLockTimeTrckFst_G1_SM = read_cdrLockTimeTrckFst_G1_SM_value
    End Property

    Property Let set_cdrLockTimeTrckFst_G1_SM(aData)
        write_cdrLockTimeTrckFst_G1_SM_value = aData
        flag_cdrLockTimeTrckFst_G1_SM        = &H1
    End Property

    Property Get read_cdrLockTimeTrckFst_G1_SM
        read
        read_cdrLockTimeTrckFst_G1_SM = read_cdrLockTimeTrckFst_G1_SM_value
    End Property

    Property Let write_cdrLockTimeTrckFst_G1_SM(aData)
        set_cdrLockTimeTrckFst_G1_SM = aData
        write
    End Property

    Property Get get_bwsel_prop_trck_G1_SM
        get_bwsel_prop_trck_G1_SM = read_bwsel_prop_trck_G1_SM_value
    End Property

    Property Let set_bwsel_prop_trck_G1_SM(aData)
        write_bwsel_prop_trck_G1_SM_value = aData
        flag_bwsel_prop_trck_G1_SM        = &H1
    End Property

    Property Get read_bwsel_prop_trck_G1_SM
        read
        read_bwsel_prop_trck_G1_SM = read_bwsel_prop_trck_G1_SM_value
    End Property

    Property Let write_bwsel_prop_trck_G1_SM(aData)
        set_bwsel_prop_trck_G1_SM = aData
        write
    End Property

    Property Get get_bwsel_integ_trck_G1_SM
        get_bwsel_integ_trck_G1_SM = read_bwsel_integ_trck_G1_SM_value
    End Property

    Property Let set_bwsel_integ_trck_G1_SM(aData)
        write_bwsel_integ_trck_G1_SM_value = aData
        flag_bwsel_integ_trck_G1_SM        = &H1
    End Property

    Property Get read_bwsel_integ_trck_G1_SM
        read
        read_bwsel_integ_trck_G1_SM = read_bwsel_integ_trck_G1_SM_value
    End Property

    Property Let write_bwsel_integ_trck_G1_SM(aData)
        set_bwsel_integ_trck_G1_SM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_cdrLockTimeTrckFst_G1_SM_value = rightShift(data_low, 8) and &Hff
        read_bwsel_prop_trck_G1_SM_value = rightShift(data_low, 4) and &Hf
        bwsel_integ_trck_G1_SM_mask = &Hf
        if data_low > LONG_MAX then
            if bwsel_integ_trck_G1_SM_mask = mask then
                read_bwsel_integ_trck_G1_SM_value = data_low
            else
                read_bwsel_integ_trck_G1_SM_value = (data_low - H8000_0000) and bwsel_integ_trck_G1_SM_mask
            end If
        else
            read_bwsel_integ_trck_G1_SM_value = data_low and bwsel_integ_trck_G1_SM_mask
        end If

    End Sub

    Sub write
        If flag_cdrLockTimeTrckFst_G1_SM = &H0 or flag_bwsel_prop_trck_G1_SM = &H0 or flag_bwsel_integ_trck_G1_SM = &H0 Then read
        If flag_cdrLockTimeTrckFst_G1_SM = &H0 Then write_cdrLockTimeTrckFst_G1_SM_value = get_cdrLockTimeTrckFst_G1_SM
        If flag_bwsel_prop_trck_G1_SM = &H0 Then write_bwsel_prop_trck_G1_SM_value = get_bwsel_prop_trck_G1_SM
        If flag_bwsel_integ_trck_G1_SM = &H0 Then write_bwsel_integ_trck_G1_SM_value = get_bwsel_integ_trck_G1_SM

        regValue = leftShift((write_cdrLockTimeTrckFst_G1_SM_value and &Hff), 8) + leftShift((write_bwsel_prop_trck_G1_SM_value and &Hf), 4) + leftShift((write_bwsel_integ_trck_G1_SM_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_cdrLockTimeTrckFst_G1_SM_value = rightShift(data_low, 8) and &Hff
        read_bwsel_prop_trck_G1_SM_value = rightShift(data_low, 4) and &Hf
        bwsel_integ_trck_G1_SM_mask = &Hf
        if data_low > LONG_MAX then
            if bwsel_integ_trck_G1_SM_mask = mask then
                read_bwsel_integ_trck_G1_SM_value = data_low
            else
                read_bwsel_integ_trck_G1_SM_value = (data_low - H8000_0000) and bwsel_integ_trck_G1_SM_mask
            end If
        else
            read_bwsel_integ_trck_G1_SM_value = data_low and bwsel_integ_trck_G1_SM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_cdrLockTimeTrckFst_G1_SM_value = &H0
        flag_cdrLockTimeTrckFst_G1_SM        = &H0
        write_bwsel_prop_trck_G1_SM_value = &H0
        flag_bwsel_prop_trck_G1_SM        = &H0
        write_bwsel_integ_trck_G1_SM_value = &H0
        flag_bwsel_integ_trck_G1_SM        = &H0
    End Sub
End Class


'' @REGISTER : RX_DFE3__SGMIIPCIE_X1_ctrl4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' cdrLockTimeAcqComClk_S1_G1_SM              [15:8]           get_cdrLockTimeAcqComClk_S1_G1_SM
''                                                             set_cdrLockTimeAcqComClk_S1_G1_SM
''                                                             read_cdrLockTimeAcqComClk_S1_G1_SM
''                                                             write_cdrLockTimeAcqComClk_S1_G1_SM
''---------------------------------------------------------------------------------
'' cdrLockTimeAcqComClk_S2_G1_SM              [7:0]            get_cdrLockTimeAcqComClk_S2_G1_SM
''                                                             set_cdrLockTimeAcqComClk_S2_G1_SM
''                                                             read_cdrLockTimeAcqComClk_S2_G1_SM
''                                                             write_cdrLockTimeAcqComClk_S2_G1_SM
''---------------------------------------------------------------------------------
Class REGISTER_RX_DFE3__SGMIIPCIE_X1_ctrl4
    Private write_cdrLockTimeAcqComClk_S1_G1_SM_value
    Private read_cdrLockTimeAcqComClk_S1_G1_SM_value
    Private flag_cdrLockTimeAcqComClk_S1_G1_SM
    Private write_cdrLockTimeAcqComClk_S2_G1_SM_value
    Private read_cdrLockTimeAcqComClk_S2_G1_SM_value
    Private flag_cdrLockTimeAcqComClk_S2_G1_SM

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

    Property Get get_cdrLockTimeAcqComClk_S1_G1_SM
        get_cdrLockTimeAcqComClk_S1_G1_SM = read_cdrLockTimeAcqComClk_S1_G1_SM_value
    End Property

    Property Let set_cdrLockTimeAcqComClk_S1_G1_SM(aData)
        write_cdrLockTimeAcqComClk_S1_G1_SM_value = aData
        flag_cdrLockTimeAcqComClk_S1_G1_SM        = &H1
    End Property

    Property Get read_cdrLockTimeAcqComClk_S1_G1_SM
        read
        read_cdrLockTimeAcqComClk_S1_G1_SM = read_cdrLockTimeAcqComClk_S1_G1_SM_value
    End Property

    Property Let write_cdrLockTimeAcqComClk_S1_G1_SM(aData)
        set_cdrLockTimeAcqComClk_S1_G1_SM = aData
        write
    End Property

    Property Get get_cdrLockTimeAcqComClk_S2_G1_SM
        get_cdrLockTimeAcqComClk_S2_G1_SM = read_cdrLockTimeAcqComClk_S2_G1_SM_value
    End Property

    Property Let set_cdrLockTimeAcqComClk_S2_G1_SM(aData)
        write_cdrLockTimeAcqComClk_S2_G1_SM_value = aData
        flag_cdrLockTimeAcqComClk_S2_G1_SM        = &H1
    End Property

    Property Get read_cdrLockTimeAcqComClk_S2_G1_SM
        read
        read_cdrLockTimeAcqComClk_S2_G1_SM = read_cdrLockTimeAcqComClk_S2_G1_SM_value
    End Property

    Property Let write_cdrLockTimeAcqComClk_S2_G1_SM(aData)
        set_cdrLockTimeAcqComClk_S2_G1_SM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_cdrLockTimeAcqComClk_S1_G1_SM_value = rightShift(data_low, 8) and &Hff
        cdrLockTimeAcqComClk_S2_G1_SM_mask = &Hff
        if data_low > LONG_MAX then
            if cdrLockTimeAcqComClk_S2_G1_SM_mask = mask then
                read_cdrLockTimeAcqComClk_S2_G1_SM_value = data_low
            else
                read_cdrLockTimeAcqComClk_S2_G1_SM_value = (data_low - H8000_0000) and cdrLockTimeAcqComClk_S2_G1_SM_mask
            end If
        else
            read_cdrLockTimeAcqComClk_S2_G1_SM_value = data_low and cdrLockTimeAcqComClk_S2_G1_SM_mask
        end If

    End Sub

    Sub write
        If flag_cdrLockTimeAcqComClk_S1_G1_SM = &H0 or flag_cdrLockTimeAcqComClk_S2_G1_SM = &H0 Then read
        If flag_cdrLockTimeAcqComClk_S1_G1_SM = &H0 Then write_cdrLockTimeAcqComClk_S1_G1_SM_value = get_cdrLockTimeAcqComClk_S1_G1_SM
        If flag_cdrLockTimeAcqComClk_S2_G1_SM = &H0 Then write_cdrLockTimeAcqComClk_S2_G1_SM_value = get_cdrLockTimeAcqComClk_S2_G1_SM

        regValue = leftShift((write_cdrLockTimeAcqComClk_S1_G1_SM_value and &Hff), 8) + leftShift((write_cdrLockTimeAcqComClk_S2_G1_SM_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_cdrLockTimeAcqComClk_S1_G1_SM_value = rightShift(data_low, 8) and &Hff
        cdrLockTimeAcqComClk_S2_G1_SM_mask = &Hff
        if data_low > LONG_MAX then
            if cdrLockTimeAcqComClk_S2_G1_SM_mask = mask then
                read_cdrLockTimeAcqComClk_S2_G1_SM_value = data_low
            else
                read_cdrLockTimeAcqComClk_S2_G1_SM_value = (data_low - H8000_0000) and cdrLockTimeAcqComClk_S2_G1_SM_mask
            end If
        else
            read_cdrLockTimeAcqComClk_S2_G1_SM_value = data_low and cdrLockTimeAcqComClk_S2_G1_SM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_cdrLockTimeAcqComClk_S1_G1_SM_value = &H0
        flag_cdrLockTimeAcqComClk_S1_G1_SM        = &H0
        write_cdrLockTimeAcqComClk_S2_G1_SM_value = &H0
        flag_cdrLockTimeAcqComClk_S2_G1_SM        = &H0
    End Sub
End Class


'' @REGISTER : RX_DFE3__SGMIIPCIE_X1_ctrl5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' cdrLockTimeAcqComClk_S3_G1_SM              [15:8]           get_cdrLockTimeAcqComClk_S3_G1_SM
''                                                             set_cdrLockTimeAcqComClk_S3_G1_SM
''                                                             read_cdrLockTimeAcqComClk_S3_G1_SM
''                                                             write_cdrLockTimeAcqComClk_S3_G1_SM
''---------------------------------------------------------------------------------
'' cdrLockTimeTrckComClk_G1_SM                [7:0]            get_cdrLockTimeTrckComClk_G1_SM
''                                                             set_cdrLockTimeTrckComClk_G1_SM
''                                                             read_cdrLockTimeTrckComClk_G1_SM
''                                                             write_cdrLockTimeTrckComClk_G1_SM
''---------------------------------------------------------------------------------
Class REGISTER_RX_DFE3__SGMIIPCIE_X1_ctrl5
    Private write_cdrLockTimeAcqComClk_S3_G1_SM_value
    Private read_cdrLockTimeAcqComClk_S3_G1_SM_value
    Private flag_cdrLockTimeAcqComClk_S3_G1_SM
    Private write_cdrLockTimeTrckComClk_G1_SM_value
    Private read_cdrLockTimeTrckComClk_G1_SM_value
    Private flag_cdrLockTimeTrckComClk_G1_SM

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

    Property Get get_cdrLockTimeAcqComClk_S3_G1_SM
        get_cdrLockTimeAcqComClk_S3_G1_SM = read_cdrLockTimeAcqComClk_S3_G1_SM_value
    End Property

    Property Let set_cdrLockTimeAcqComClk_S3_G1_SM(aData)
        write_cdrLockTimeAcqComClk_S3_G1_SM_value = aData
        flag_cdrLockTimeAcqComClk_S3_G1_SM        = &H1
    End Property

    Property Get read_cdrLockTimeAcqComClk_S3_G1_SM
        read
        read_cdrLockTimeAcqComClk_S3_G1_SM = read_cdrLockTimeAcqComClk_S3_G1_SM_value
    End Property

    Property Let write_cdrLockTimeAcqComClk_S3_G1_SM(aData)
        set_cdrLockTimeAcqComClk_S3_G1_SM = aData
        write
    End Property

    Property Get get_cdrLockTimeTrckComClk_G1_SM
        get_cdrLockTimeTrckComClk_G1_SM = read_cdrLockTimeTrckComClk_G1_SM_value
    End Property

    Property Let set_cdrLockTimeTrckComClk_G1_SM(aData)
        write_cdrLockTimeTrckComClk_G1_SM_value = aData
        flag_cdrLockTimeTrckComClk_G1_SM        = &H1
    End Property

    Property Get read_cdrLockTimeTrckComClk_G1_SM
        read
        read_cdrLockTimeTrckComClk_G1_SM = read_cdrLockTimeTrckComClk_G1_SM_value
    End Property

    Property Let write_cdrLockTimeTrckComClk_G1_SM(aData)
        set_cdrLockTimeTrckComClk_G1_SM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_cdrLockTimeAcqComClk_S3_G1_SM_value = rightShift(data_low, 8) and &Hff
        cdrLockTimeTrckComClk_G1_SM_mask = &Hff
        if data_low > LONG_MAX then
            if cdrLockTimeTrckComClk_G1_SM_mask = mask then
                read_cdrLockTimeTrckComClk_G1_SM_value = data_low
            else
                read_cdrLockTimeTrckComClk_G1_SM_value = (data_low - H8000_0000) and cdrLockTimeTrckComClk_G1_SM_mask
            end If
        else
            read_cdrLockTimeTrckComClk_G1_SM_value = data_low and cdrLockTimeTrckComClk_G1_SM_mask
        end If

    End Sub

    Sub write
        If flag_cdrLockTimeAcqComClk_S3_G1_SM = &H0 or flag_cdrLockTimeTrckComClk_G1_SM = &H0 Then read
        If flag_cdrLockTimeAcqComClk_S3_G1_SM = &H0 Then write_cdrLockTimeAcqComClk_S3_G1_SM_value = get_cdrLockTimeAcqComClk_S3_G1_SM
        If flag_cdrLockTimeTrckComClk_G1_SM = &H0 Then write_cdrLockTimeTrckComClk_G1_SM_value = get_cdrLockTimeTrckComClk_G1_SM

        regValue = leftShift((write_cdrLockTimeAcqComClk_S3_G1_SM_value and &Hff), 8) + leftShift((write_cdrLockTimeTrckComClk_G1_SM_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_cdrLockTimeAcqComClk_S3_G1_SM_value = rightShift(data_low, 8) and &Hff
        cdrLockTimeTrckComClk_G1_SM_mask = &Hff
        if data_low > LONG_MAX then
            if cdrLockTimeTrckComClk_G1_SM_mask = mask then
                read_cdrLockTimeTrckComClk_G1_SM_value = data_low
            else
                read_cdrLockTimeTrckComClk_G1_SM_value = (data_low - H8000_0000) and cdrLockTimeTrckComClk_G1_SM_mask
            end If
        else
            read_cdrLockTimeTrckComClk_G1_SM_value = data_low and cdrLockTimeTrckComClk_G1_SM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_cdrLockTimeAcqComClk_S3_G1_SM_value = &H0
        flag_cdrLockTimeAcqComClk_S3_G1_SM        = &H0
        write_cdrLockTimeTrckComClk_G1_SM_value = &H0
        flag_cdrLockTimeTrckComClk_G1_SM        = &H0
    End Sub
End Class


'' @REGISTER : RX_DFE3__SGMIIPCIE_X1_ctrl6
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' cdrLockTimeAcqFst_S1_G2_SM                 [15:8]           get_cdrLockTimeAcqFst_S1_G2_SM
''                                                             set_cdrLockTimeAcqFst_S1_G2_SM
''                                                             read_cdrLockTimeAcqFst_S1_G2_SM
''                                                             write_cdrLockTimeAcqFst_S1_G2_SM
''---------------------------------------------------------------------------------
'' bwsel_prop_acq_fst_S1_G2_SM                [7:4]            get_bwsel_prop_acq_fst_S1_G2_SM
''                                                             set_bwsel_prop_acq_fst_S1_G2_SM
''                                                             read_bwsel_prop_acq_fst_S1_G2_SM
''                                                             write_bwsel_prop_acq_fst_S1_G2_SM
''---------------------------------------------------------------------------------
'' bwsel_integ_acq_fst_S1_G2_SM               [3:0]            get_bwsel_integ_acq_fst_S1_G2_SM
''                                                             set_bwsel_integ_acq_fst_S1_G2_SM
''                                                             read_bwsel_integ_acq_fst_S1_G2_SM
''                                                             write_bwsel_integ_acq_fst_S1_G2_SM
''---------------------------------------------------------------------------------
Class REGISTER_RX_DFE3__SGMIIPCIE_X1_ctrl6
    Private write_cdrLockTimeAcqFst_S1_G2_SM_value
    Private read_cdrLockTimeAcqFst_S1_G2_SM_value
    Private flag_cdrLockTimeAcqFst_S1_G2_SM
    Private write_bwsel_prop_acq_fst_S1_G2_SM_value
    Private read_bwsel_prop_acq_fst_S1_G2_SM_value
    Private flag_bwsel_prop_acq_fst_S1_G2_SM
    Private write_bwsel_integ_acq_fst_S1_G2_SM_value
    Private read_bwsel_integ_acq_fst_S1_G2_SM_value
    Private flag_bwsel_integ_acq_fst_S1_G2_SM

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

    Property Get get_cdrLockTimeAcqFst_S1_G2_SM
        get_cdrLockTimeAcqFst_S1_G2_SM = read_cdrLockTimeAcqFst_S1_G2_SM_value
    End Property

    Property Let set_cdrLockTimeAcqFst_S1_G2_SM(aData)
        write_cdrLockTimeAcqFst_S1_G2_SM_value = aData
        flag_cdrLockTimeAcqFst_S1_G2_SM        = &H1
    End Property

    Property Get read_cdrLockTimeAcqFst_S1_G2_SM
        read
        read_cdrLockTimeAcqFst_S1_G2_SM = read_cdrLockTimeAcqFst_S1_G2_SM_value
    End Property

    Property Let write_cdrLockTimeAcqFst_S1_G2_SM(aData)
        set_cdrLockTimeAcqFst_S1_G2_SM = aData
        write
    End Property

    Property Get get_bwsel_prop_acq_fst_S1_G2_SM
        get_bwsel_prop_acq_fst_S1_G2_SM = read_bwsel_prop_acq_fst_S1_G2_SM_value
    End Property

    Property Let set_bwsel_prop_acq_fst_S1_G2_SM(aData)
        write_bwsel_prop_acq_fst_S1_G2_SM_value = aData
        flag_bwsel_prop_acq_fst_S1_G2_SM        = &H1
    End Property

    Property Get read_bwsel_prop_acq_fst_S1_G2_SM
        read
        read_bwsel_prop_acq_fst_S1_G2_SM = read_bwsel_prop_acq_fst_S1_G2_SM_value
    End Property

    Property Let write_bwsel_prop_acq_fst_S1_G2_SM(aData)
        set_bwsel_prop_acq_fst_S1_G2_SM = aData
        write
    End Property

    Property Get get_bwsel_integ_acq_fst_S1_G2_SM
        get_bwsel_integ_acq_fst_S1_G2_SM = read_bwsel_integ_acq_fst_S1_G2_SM_value
    End Property

    Property Let set_bwsel_integ_acq_fst_S1_G2_SM(aData)
        write_bwsel_integ_acq_fst_S1_G2_SM_value = aData
        flag_bwsel_integ_acq_fst_S1_G2_SM        = &H1
    End Property

    Property Get read_bwsel_integ_acq_fst_S1_G2_SM
        read
        read_bwsel_integ_acq_fst_S1_G2_SM = read_bwsel_integ_acq_fst_S1_G2_SM_value
    End Property

    Property Let write_bwsel_integ_acq_fst_S1_G2_SM(aData)
        set_bwsel_integ_acq_fst_S1_G2_SM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_cdrLockTimeAcqFst_S1_G2_SM_value = rightShift(data_low, 8) and &Hff
        read_bwsel_prop_acq_fst_S1_G2_SM_value = rightShift(data_low, 4) and &Hf
        bwsel_integ_acq_fst_S1_G2_SM_mask = &Hf
        if data_low > LONG_MAX then
            if bwsel_integ_acq_fst_S1_G2_SM_mask = mask then
                read_bwsel_integ_acq_fst_S1_G2_SM_value = data_low
            else
                read_bwsel_integ_acq_fst_S1_G2_SM_value = (data_low - H8000_0000) and bwsel_integ_acq_fst_S1_G2_SM_mask
            end If
        else
            read_bwsel_integ_acq_fst_S1_G2_SM_value = data_low and bwsel_integ_acq_fst_S1_G2_SM_mask
        end If

    End Sub

    Sub write
        If flag_cdrLockTimeAcqFst_S1_G2_SM = &H0 or flag_bwsel_prop_acq_fst_S1_G2_SM = &H0 or flag_bwsel_integ_acq_fst_S1_G2_SM = &H0 Then read
        If flag_cdrLockTimeAcqFst_S1_G2_SM = &H0 Then write_cdrLockTimeAcqFst_S1_G2_SM_value = get_cdrLockTimeAcqFst_S1_G2_SM
        If flag_bwsel_prop_acq_fst_S1_G2_SM = &H0 Then write_bwsel_prop_acq_fst_S1_G2_SM_value = get_bwsel_prop_acq_fst_S1_G2_SM
        If flag_bwsel_integ_acq_fst_S1_G2_SM = &H0 Then write_bwsel_integ_acq_fst_S1_G2_SM_value = get_bwsel_integ_acq_fst_S1_G2_SM

        regValue = leftShift((write_cdrLockTimeAcqFst_S1_G2_SM_value and &Hff), 8) + leftShift((write_bwsel_prop_acq_fst_S1_G2_SM_value and &Hf), 4) + leftShift((write_bwsel_integ_acq_fst_S1_G2_SM_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_cdrLockTimeAcqFst_S1_G2_SM_value = rightShift(data_low, 8) and &Hff
        read_bwsel_prop_acq_fst_S1_G2_SM_value = rightShift(data_low, 4) and &Hf
        bwsel_integ_acq_fst_S1_G2_SM_mask = &Hf
        if data_low > LONG_MAX then
            if bwsel_integ_acq_fst_S1_G2_SM_mask = mask then
                read_bwsel_integ_acq_fst_S1_G2_SM_value = data_low
            else
                read_bwsel_integ_acq_fst_S1_G2_SM_value = (data_low - H8000_0000) and bwsel_integ_acq_fst_S1_G2_SM_mask
            end If
        else
            read_bwsel_integ_acq_fst_S1_G2_SM_value = data_low and bwsel_integ_acq_fst_S1_G2_SM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_cdrLockTimeAcqFst_S1_G2_SM_value = &H0
        flag_cdrLockTimeAcqFst_S1_G2_SM        = &H0
        write_bwsel_prop_acq_fst_S1_G2_SM_value = &H0
        flag_bwsel_prop_acq_fst_S1_G2_SM        = &H0
        write_bwsel_integ_acq_fst_S1_G2_SM_value = &H0
        flag_bwsel_integ_acq_fst_S1_G2_SM        = &H0
    End Sub
End Class


'' @REGISTER : RX_DFE3__SGMIIPCIE_X1_ctrl7
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' cdrLockTimeAcqFst_S2_G2_SM                 [15:8]           get_cdrLockTimeAcqFst_S2_G2_SM
''                                                             set_cdrLockTimeAcqFst_S2_G2_SM
''                                                             read_cdrLockTimeAcqFst_S2_G2_SM
''                                                             write_cdrLockTimeAcqFst_S2_G2_SM
''---------------------------------------------------------------------------------
'' bwsel_prop_acq_fst_S2_G2_SM                [7:4]            get_bwsel_prop_acq_fst_S2_G2_SM
''                                                             set_bwsel_prop_acq_fst_S2_G2_SM
''                                                             read_bwsel_prop_acq_fst_S2_G2_SM
''                                                             write_bwsel_prop_acq_fst_S2_G2_SM
''---------------------------------------------------------------------------------
'' bwsel_integ_acq_fst_S2_G2_SM               [3:0]            get_bwsel_integ_acq_fst_S2_G2_SM
''                                                             set_bwsel_integ_acq_fst_S2_G2_SM
''                                                             read_bwsel_integ_acq_fst_S2_G2_SM
''                                                             write_bwsel_integ_acq_fst_S2_G2_SM
''---------------------------------------------------------------------------------
Class REGISTER_RX_DFE3__SGMIIPCIE_X1_ctrl7
    Private write_cdrLockTimeAcqFst_S2_G2_SM_value
    Private read_cdrLockTimeAcqFst_S2_G2_SM_value
    Private flag_cdrLockTimeAcqFst_S2_G2_SM
    Private write_bwsel_prop_acq_fst_S2_G2_SM_value
    Private read_bwsel_prop_acq_fst_S2_G2_SM_value
    Private flag_bwsel_prop_acq_fst_S2_G2_SM
    Private write_bwsel_integ_acq_fst_S2_G2_SM_value
    Private read_bwsel_integ_acq_fst_S2_G2_SM_value
    Private flag_bwsel_integ_acq_fst_S2_G2_SM

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

    Property Get get_cdrLockTimeAcqFst_S2_G2_SM
        get_cdrLockTimeAcqFst_S2_G2_SM = read_cdrLockTimeAcqFst_S2_G2_SM_value
    End Property

    Property Let set_cdrLockTimeAcqFst_S2_G2_SM(aData)
        write_cdrLockTimeAcqFst_S2_G2_SM_value = aData
        flag_cdrLockTimeAcqFst_S2_G2_SM        = &H1
    End Property

    Property Get read_cdrLockTimeAcqFst_S2_G2_SM
        read
        read_cdrLockTimeAcqFst_S2_G2_SM = read_cdrLockTimeAcqFst_S2_G2_SM_value
    End Property

    Property Let write_cdrLockTimeAcqFst_S2_G2_SM(aData)
        set_cdrLockTimeAcqFst_S2_G2_SM = aData
        write
    End Property

    Property Get get_bwsel_prop_acq_fst_S2_G2_SM
        get_bwsel_prop_acq_fst_S2_G2_SM = read_bwsel_prop_acq_fst_S2_G2_SM_value
    End Property

    Property Let set_bwsel_prop_acq_fst_S2_G2_SM(aData)
        write_bwsel_prop_acq_fst_S2_G2_SM_value = aData
        flag_bwsel_prop_acq_fst_S2_G2_SM        = &H1
    End Property

    Property Get read_bwsel_prop_acq_fst_S2_G2_SM
        read
        read_bwsel_prop_acq_fst_S2_G2_SM = read_bwsel_prop_acq_fst_S2_G2_SM_value
    End Property

    Property Let write_bwsel_prop_acq_fst_S2_G2_SM(aData)
        set_bwsel_prop_acq_fst_S2_G2_SM = aData
        write
    End Property

    Property Get get_bwsel_integ_acq_fst_S2_G2_SM
        get_bwsel_integ_acq_fst_S2_G2_SM = read_bwsel_integ_acq_fst_S2_G2_SM_value
    End Property

    Property Let set_bwsel_integ_acq_fst_S2_G2_SM(aData)
        write_bwsel_integ_acq_fst_S2_G2_SM_value = aData
        flag_bwsel_integ_acq_fst_S2_G2_SM        = &H1
    End Property

    Property Get read_bwsel_integ_acq_fst_S2_G2_SM
        read
        read_bwsel_integ_acq_fst_S2_G2_SM = read_bwsel_integ_acq_fst_S2_G2_SM_value
    End Property

    Property Let write_bwsel_integ_acq_fst_S2_G2_SM(aData)
        set_bwsel_integ_acq_fst_S2_G2_SM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_cdrLockTimeAcqFst_S2_G2_SM_value = rightShift(data_low, 8) and &Hff
        read_bwsel_prop_acq_fst_S2_G2_SM_value = rightShift(data_low, 4) and &Hf
        bwsel_integ_acq_fst_S2_G2_SM_mask = &Hf
        if data_low > LONG_MAX then
            if bwsel_integ_acq_fst_S2_G2_SM_mask = mask then
                read_bwsel_integ_acq_fst_S2_G2_SM_value = data_low
            else
                read_bwsel_integ_acq_fst_S2_G2_SM_value = (data_low - H8000_0000) and bwsel_integ_acq_fst_S2_G2_SM_mask
            end If
        else
            read_bwsel_integ_acq_fst_S2_G2_SM_value = data_low and bwsel_integ_acq_fst_S2_G2_SM_mask
        end If

    End Sub

    Sub write
        If flag_cdrLockTimeAcqFst_S2_G2_SM = &H0 or flag_bwsel_prop_acq_fst_S2_G2_SM = &H0 or flag_bwsel_integ_acq_fst_S2_G2_SM = &H0 Then read
        If flag_cdrLockTimeAcqFst_S2_G2_SM = &H0 Then write_cdrLockTimeAcqFst_S2_G2_SM_value = get_cdrLockTimeAcqFst_S2_G2_SM
        If flag_bwsel_prop_acq_fst_S2_G2_SM = &H0 Then write_bwsel_prop_acq_fst_S2_G2_SM_value = get_bwsel_prop_acq_fst_S2_G2_SM
        If flag_bwsel_integ_acq_fst_S2_G2_SM = &H0 Then write_bwsel_integ_acq_fst_S2_G2_SM_value = get_bwsel_integ_acq_fst_S2_G2_SM

        regValue = leftShift((write_cdrLockTimeAcqFst_S2_G2_SM_value and &Hff), 8) + leftShift((write_bwsel_prop_acq_fst_S2_G2_SM_value and &Hf), 4) + leftShift((write_bwsel_integ_acq_fst_S2_G2_SM_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_cdrLockTimeAcqFst_S2_G2_SM_value = rightShift(data_low, 8) and &Hff
        read_bwsel_prop_acq_fst_S2_G2_SM_value = rightShift(data_low, 4) and &Hf
        bwsel_integ_acq_fst_S2_G2_SM_mask = &Hf
        if data_low > LONG_MAX then
            if bwsel_integ_acq_fst_S2_G2_SM_mask = mask then
                read_bwsel_integ_acq_fst_S2_G2_SM_value = data_low
            else
                read_bwsel_integ_acq_fst_S2_G2_SM_value = (data_low - H8000_0000) and bwsel_integ_acq_fst_S2_G2_SM_mask
            end If
        else
            read_bwsel_integ_acq_fst_S2_G2_SM_value = data_low and bwsel_integ_acq_fst_S2_G2_SM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_cdrLockTimeAcqFst_S2_G2_SM_value = &H0
        flag_cdrLockTimeAcqFst_S2_G2_SM        = &H0
        write_bwsel_prop_acq_fst_S2_G2_SM_value = &H0
        flag_bwsel_prop_acq_fst_S2_G2_SM        = &H0
        write_bwsel_integ_acq_fst_S2_G2_SM_value = &H0
        flag_bwsel_integ_acq_fst_S2_G2_SM        = &H0
    End Sub
End Class


'' @REGISTER : RX_DFE3__SGMIIPCIE_X1_ctrl8
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' cdrLockTimeAcqFst_S3_G2_SM                 [15:8]           get_cdrLockTimeAcqFst_S3_G2_SM
''                                                             set_cdrLockTimeAcqFst_S3_G2_SM
''                                                             read_cdrLockTimeAcqFst_S3_G2_SM
''                                                             write_cdrLockTimeAcqFst_S3_G2_SM
''---------------------------------------------------------------------------------
'' bwsel_prop_acq_fst_S3_G2_SM                [7:4]            get_bwsel_prop_acq_fst_S3_G2_SM
''                                                             set_bwsel_prop_acq_fst_S3_G2_SM
''                                                             read_bwsel_prop_acq_fst_S3_G2_SM
''                                                             write_bwsel_prop_acq_fst_S3_G2_SM
''---------------------------------------------------------------------------------
'' bwsel_integ_acq_fst_S3_G2_SM               [3:0]            get_bwsel_integ_acq_fst_S3_G2_SM
''                                                             set_bwsel_integ_acq_fst_S3_G2_SM
''                                                             read_bwsel_integ_acq_fst_S3_G2_SM
''                                                             write_bwsel_integ_acq_fst_S3_G2_SM
''---------------------------------------------------------------------------------
Class REGISTER_RX_DFE3__SGMIIPCIE_X1_ctrl8
    Private write_cdrLockTimeAcqFst_S3_G2_SM_value
    Private read_cdrLockTimeAcqFst_S3_G2_SM_value
    Private flag_cdrLockTimeAcqFst_S3_G2_SM
    Private write_bwsel_prop_acq_fst_S3_G2_SM_value
    Private read_bwsel_prop_acq_fst_S3_G2_SM_value
    Private flag_bwsel_prop_acq_fst_S3_G2_SM
    Private write_bwsel_integ_acq_fst_S3_G2_SM_value
    Private read_bwsel_integ_acq_fst_S3_G2_SM_value
    Private flag_bwsel_integ_acq_fst_S3_G2_SM

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

    Property Get get_cdrLockTimeAcqFst_S3_G2_SM
        get_cdrLockTimeAcqFst_S3_G2_SM = read_cdrLockTimeAcqFst_S3_G2_SM_value
    End Property

    Property Let set_cdrLockTimeAcqFst_S3_G2_SM(aData)
        write_cdrLockTimeAcqFst_S3_G2_SM_value = aData
        flag_cdrLockTimeAcqFst_S3_G2_SM        = &H1
    End Property

    Property Get read_cdrLockTimeAcqFst_S3_G2_SM
        read
        read_cdrLockTimeAcqFst_S3_G2_SM = read_cdrLockTimeAcqFst_S3_G2_SM_value
    End Property

    Property Let write_cdrLockTimeAcqFst_S3_G2_SM(aData)
        set_cdrLockTimeAcqFst_S3_G2_SM = aData
        write
    End Property

    Property Get get_bwsel_prop_acq_fst_S3_G2_SM
        get_bwsel_prop_acq_fst_S3_G2_SM = read_bwsel_prop_acq_fst_S3_G2_SM_value
    End Property

    Property Let set_bwsel_prop_acq_fst_S3_G2_SM(aData)
        write_bwsel_prop_acq_fst_S3_G2_SM_value = aData
        flag_bwsel_prop_acq_fst_S3_G2_SM        = &H1
    End Property

    Property Get read_bwsel_prop_acq_fst_S3_G2_SM
        read
        read_bwsel_prop_acq_fst_S3_G2_SM = read_bwsel_prop_acq_fst_S3_G2_SM_value
    End Property

    Property Let write_bwsel_prop_acq_fst_S3_G2_SM(aData)
        set_bwsel_prop_acq_fst_S3_G2_SM = aData
        write
    End Property

    Property Get get_bwsel_integ_acq_fst_S3_G2_SM
        get_bwsel_integ_acq_fst_S3_G2_SM = read_bwsel_integ_acq_fst_S3_G2_SM_value
    End Property

    Property Let set_bwsel_integ_acq_fst_S3_G2_SM(aData)
        write_bwsel_integ_acq_fst_S3_G2_SM_value = aData
        flag_bwsel_integ_acq_fst_S3_G2_SM        = &H1
    End Property

    Property Get read_bwsel_integ_acq_fst_S3_G2_SM
        read
        read_bwsel_integ_acq_fst_S3_G2_SM = read_bwsel_integ_acq_fst_S3_G2_SM_value
    End Property

    Property Let write_bwsel_integ_acq_fst_S3_G2_SM(aData)
        set_bwsel_integ_acq_fst_S3_G2_SM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_cdrLockTimeAcqFst_S3_G2_SM_value = rightShift(data_low, 8) and &Hff
        read_bwsel_prop_acq_fst_S3_G2_SM_value = rightShift(data_low, 4) and &Hf
        bwsel_integ_acq_fst_S3_G2_SM_mask = &Hf
        if data_low > LONG_MAX then
            if bwsel_integ_acq_fst_S3_G2_SM_mask = mask then
                read_bwsel_integ_acq_fst_S3_G2_SM_value = data_low
            else
                read_bwsel_integ_acq_fst_S3_G2_SM_value = (data_low - H8000_0000) and bwsel_integ_acq_fst_S3_G2_SM_mask
            end If
        else
            read_bwsel_integ_acq_fst_S3_G2_SM_value = data_low and bwsel_integ_acq_fst_S3_G2_SM_mask
        end If

    End Sub

    Sub write
        If flag_cdrLockTimeAcqFst_S3_G2_SM = &H0 or flag_bwsel_prop_acq_fst_S3_G2_SM = &H0 or flag_bwsel_integ_acq_fst_S3_G2_SM = &H0 Then read
        If flag_cdrLockTimeAcqFst_S3_G2_SM = &H0 Then write_cdrLockTimeAcqFst_S3_G2_SM_value = get_cdrLockTimeAcqFst_S3_G2_SM
        If flag_bwsel_prop_acq_fst_S3_G2_SM = &H0 Then write_bwsel_prop_acq_fst_S3_G2_SM_value = get_bwsel_prop_acq_fst_S3_G2_SM
        If flag_bwsel_integ_acq_fst_S3_G2_SM = &H0 Then write_bwsel_integ_acq_fst_S3_G2_SM_value = get_bwsel_integ_acq_fst_S3_G2_SM

        regValue = leftShift((write_cdrLockTimeAcqFst_S3_G2_SM_value and &Hff), 8) + leftShift((write_bwsel_prop_acq_fst_S3_G2_SM_value and &Hf), 4) + leftShift((write_bwsel_integ_acq_fst_S3_G2_SM_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_cdrLockTimeAcqFst_S3_G2_SM_value = rightShift(data_low, 8) and &Hff
        read_bwsel_prop_acq_fst_S3_G2_SM_value = rightShift(data_low, 4) and &Hf
        bwsel_integ_acq_fst_S3_G2_SM_mask = &Hf
        if data_low > LONG_MAX then
            if bwsel_integ_acq_fst_S3_G2_SM_mask = mask then
                read_bwsel_integ_acq_fst_S3_G2_SM_value = data_low
            else
                read_bwsel_integ_acq_fst_S3_G2_SM_value = (data_low - H8000_0000) and bwsel_integ_acq_fst_S3_G2_SM_mask
            end If
        else
            read_bwsel_integ_acq_fst_S3_G2_SM_value = data_low and bwsel_integ_acq_fst_S3_G2_SM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_cdrLockTimeAcqFst_S3_G2_SM_value = &H0
        flag_cdrLockTimeAcqFst_S3_G2_SM        = &H0
        write_bwsel_prop_acq_fst_S3_G2_SM_value = &H0
        flag_bwsel_prop_acq_fst_S3_G2_SM        = &H0
        write_bwsel_integ_acq_fst_S3_G2_SM_value = &H0
        flag_bwsel_integ_acq_fst_S3_G2_SM        = &H0
    End Sub
End Class


'' @REGISTER : RX_DFE3__SGMIIPCIE_X1_ctrl9
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' cdrLockTimeTrckFst_G2_SM                   [15:8]           get_cdrLockTimeTrckFst_G2_SM
''                                                             set_cdrLockTimeTrckFst_G2_SM
''                                                             read_cdrLockTimeTrckFst_G2_SM
''                                                             write_cdrLockTimeTrckFst_G2_SM
''---------------------------------------------------------------------------------
'' bwsel_prop_trck_G2_SM                      [7:4]            get_bwsel_prop_trck_G2_SM
''                                                             set_bwsel_prop_trck_G2_SM
''                                                             read_bwsel_prop_trck_G2_SM
''                                                             write_bwsel_prop_trck_G2_SM
''---------------------------------------------------------------------------------
'' bwsel_integ_trck_G2_SM                     [3:0]            get_bwsel_integ_trck_G2_SM
''                                                             set_bwsel_integ_trck_G2_SM
''                                                             read_bwsel_integ_trck_G2_SM
''                                                             write_bwsel_integ_trck_G2_SM
''---------------------------------------------------------------------------------
Class REGISTER_RX_DFE3__SGMIIPCIE_X1_ctrl9
    Private write_cdrLockTimeTrckFst_G2_SM_value
    Private read_cdrLockTimeTrckFst_G2_SM_value
    Private flag_cdrLockTimeTrckFst_G2_SM
    Private write_bwsel_prop_trck_G2_SM_value
    Private read_bwsel_prop_trck_G2_SM_value
    Private flag_bwsel_prop_trck_G2_SM
    Private write_bwsel_integ_trck_G2_SM_value
    Private read_bwsel_integ_trck_G2_SM_value
    Private flag_bwsel_integ_trck_G2_SM

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

    Property Get get_cdrLockTimeTrckFst_G2_SM
        get_cdrLockTimeTrckFst_G2_SM = read_cdrLockTimeTrckFst_G2_SM_value
    End Property

    Property Let set_cdrLockTimeTrckFst_G2_SM(aData)
        write_cdrLockTimeTrckFst_G2_SM_value = aData
        flag_cdrLockTimeTrckFst_G2_SM        = &H1
    End Property

    Property Get read_cdrLockTimeTrckFst_G2_SM
        read
        read_cdrLockTimeTrckFst_G2_SM = read_cdrLockTimeTrckFst_G2_SM_value
    End Property

    Property Let write_cdrLockTimeTrckFst_G2_SM(aData)
        set_cdrLockTimeTrckFst_G2_SM = aData
        write
    End Property

    Property Get get_bwsel_prop_trck_G2_SM
        get_bwsel_prop_trck_G2_SM = read_bwsel_prop_trck_G2_SM_value
    End Property

    Property Let set_bwsel_prop_trck_G2_SM(aData)
        write_bwsel_prop_trck_G2_SM_value = aData
        flag_bwsel_prop_trck_G2_SM        = &H1
    End Property

    Property Get read_bwsel_prop_trck_G2_SM
        read
        read_bwsel_prop_trck_G2_SM = read_bwsel_prop_trck_G2_SM_value
    End Property

    Property Let write_bwsel_prop_trck_G2_SM(aData)
        set_bwsel_prop_trck_G2_SM = aData
        write
    End Property

    Property Get get_bwsel_integ_trck_G2_SM
        get_bwsel_integ_trck_G2_SM = read_bwsel_integ_trck_G2_SM_value
    End Property

    Property Let set_bwsel_integ_trck_G2_SM(aData)
        write_bwsel_integ_trck_G2_SM_value = aData
        flag_bwsel_integ_trck_G2_SM        = &H1
    End Property

    Property Get read_bwsel_integ_trck_G2_SM
        read
        read_bwsel_integ_trck_G2_SM = read_bwsel_integ_trck_G2_SM_value
    End Property

    Property Let write_bwsel_integ_trck_G2_SM(aData)
        set_bwsel_integ_trck_G2_SM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_cdrLockTimeTrckFst_G2_SM_value = rightShift(data_low, 8) and &Hff
        read_bwsel_prop_trck_G2_SM_value = rightShift(data_low, 4) and &Hf
        bwsel_integ_trck_G2_SM_mask = &Hf
        if data_low > LONG_MAX then
            if bwsel_integ_trck_G2_SM_mask = mask then
                read_bwsel_integ_trck_G2_SM_value = data_low
            else
                read_bwsel_integ_trck_G2_SM_value = (data_low - H8000_0000) and bwsel_integ_trck_G2_SM_mask
            end If
        else
            read_bwsel_integ_trck_G2_SM_value = data_low and bwsel_integ_trck_G2_SM_mask
        end If

    End Sub

    Sub write
        If flag_cdrLockTimeTrckFst_G2_SM = &H0 or flag_bwsel_prop_trck_G2_SM = &H0 or flag_bwsel_integ_trck_G2_SM = &H0 Then read
        If flag_cdrLockTimeTrckFst_G2_SM = &H0 Then write_cdrLockTimeTrckFst_G2_SM_value = get_cdrLockTimeTrckFst_G2_SM
        If flag_bwsel_prop_trck_G2_SM = &H0 Then write_bwsel_prop_trck_G2_SM_value = get_bwsel_prop_trck_G2_SM
        If flag_bwsel_integ_trck_G2_SM = &H0 Then write_bwsel_integ_trck_G2_SM_value = get_bwsel_integ_trck_G2_SM

        regValue = leftShift((write_cdrLockTimeTrckFst_G2_SM_value and &Hff), 8) + leftShift((write_bwsel_prop_trck_G2_SM_value and &Hf), 4) + leftShift((write_bwsel_integ_trck_G2_SM_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_cdrLockTimeTrckFst_G2_SM_value = rightShift(data_low, 8) and &Hff
        read_bwsel_prop_trck_G2_SM_value = rightShift(data_low, 4) and &Hf
        bwsel_integ_trck_G2_SM_mask = &Hf
        if data_low > LONG_MAX then
            if bwsel_integ_trck_G2_SM_mask = mask then
                read_bwsel_integ_trck_G2_SM_value = data_low
            else
                read_bwsel_integ_trck_G2_SM_value = (data_low - H8000_0000) and bwsel_integ_trck_G2_SM_mask
            end If
        else
            read_bwsel_integ_trck_G2_SM_value = data_low and bwsel_integ_trck_G2_SM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_cdrLockTimeTrckFst_G2_SM_value = &H0
        flag_cdrLockTimeTrckFst_G2_SM        = &H0
        write_bwsel_prop_trck_G2_SM_value = &H0
        flag_bwsel_prop_trck_G2_SM        = &H0
        write_bwsel_integ_trck_G2_SM_value = &H0
        flag_bwsel_integ_trck_G2_SM        = &H0
    End Sub
End Class


'' @REGISTER : RX_DFE3__SGMIIPCIE_X1_ctrla
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' cdrLockTimeAcqComClk_S1_G2_SM              [15:8]           get_cdrLockTimeAcqComClk_S1_G2_SM
''                                                             set_cdrLockTimeAcqComClk_S1_G2_SM
''                                                             read_cdrLockTimeAcqComClk_S1_G2_SM
''                                                             write_cdrLockTimeAcqComClk_S1_G2_SM
''---------------------------------------------------------------------------------
'' cdrLockTimeAcqComClk_S2_G2_SM              [7:0]            get_cdrLockTimeAcqComClk_S2_G2_SM
''                                                             set_cdrLockTimeAcqComClk_S2_G2_SM
''                                                             read_cdrLockTimeAcqComClk_S2_G2_SM
''                                                             write_cdrLockTimeAcqComClk_S2_G2_SM
''---------------------------------------------------------------------------------
Class REGISTER_RX_DFE3__SGMIIPCIE_X1_ctrla
    Private write_cdrLockTimeAcqComClk_S1_G2_SM_value
    Private read_cdrLockTimeAcqComClk_S1_G2_SM_value
    Private flag_cdrLockTimeAcqComClk_S1_G2_SM
    Private write_cdrLockTimeAcqComClk_S2_G2_SM_value
    Private read_cdrLockTimeAcqComClk_S2_G2_SM_value
    Private flag_cdrLockTimeAcqComClk_S2_G2_SM

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

    Property Get get_cdrLockTimeAcqComClk_S1_G2_SM
        get_cdrLockTimeAcqComClk_S1_G2_SM = read_cdrLockTimeAcqComClk_S1_G2_SM_value
    End Property

    Property Let set_cdrLockTimeAcqComClk_S1_G2_SM(aData)
        write_cdrLockTimeAcqComClk_S1_G2_SM_value = aData
        flag_cdrLockTimeAcqComClk_S1_G2_SM        = &H1
    End Property

    Property Get read_cdrLockTimeAcqComClk_S1_G2_SM
        read
        read_cdrLockTimeAcqComClk_S1_G2_SM = read_cdrLockTimeAcqComClk_S1_G2_SM_value
    End Property

    Property Let write_cdrLockTimeAcqComClk_S1_G2_SM(aData)
        set_cdrLockTimeAcqComClk_S1_G2_SM = aData
        write
    End Property

    Property Get get_cdrLockTimeAcqComClk_S2_G2_SM
        get_cdrLockTimeAcqComClk_S2_G2_SM = read_cdrLockTimeAcqComClk_S2_G2_SM_value
    End Property

    Property Let set_cdrLockTimeAcqComClk_S2_G2_SM(aData)
        write_cdrLockTimeAcqComClk_S2_G2_SM_value = aData
        flag_cdrLockTimeAcqComClk_S2_G2_SM        = &H1
    End Property

    Property Get read_cdrLockTimeAcqComClk_S2_G2_SM
        read
        read_cdrLockTimeAcqComClk_S2_G2_SM = read_cdrLockTimeAcqComClk_S2_G2_SM_value
    End Property

    Property Let write_cdrLockTimeAcqComClk_S2_G2_SM(aData)
        set_cdrLockTimeAcqComClk_S2_G2_SM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_cdrLockTimeAcqComClk_S1_G2_SM_value = rightShift(data_low, 8) and &Hff
        cdrLockTimeAcqComClk_S2_G2_SM_mask = &Hff
        if data_low > LONG_MAX then
            if cdrLockTimeAcqComClk_S2_G2_SM_mask = mask then
                read_cdrLockTimeAcqComClk_S2_G2_SM_value = data_low
            else
                read_cdrLockTimeAcqComClk_S2_G2_SM_value = (data_low - H8000_0000) and cdrLockTimeAcqComClk_S2_G2_SM_mask
            end If
        else
            read_cdrLockTimeAcqComClk_S2_G2_SM_value = data_low and cdrLockTimeAcqComClk_S2_G2_SM_mask
        end If

    End Sub

    Sub write
        If flag_cdrLockTimeAcqComClk_S1_G2_SM = &H0 or flag_cdrLockTimeAcqComClk_S2_G2_SM = &H0 Then read
        If flag_cdrLockTimeAcqComClk_S1_G2_SM = &H0 Then write_cdrLockTimeAcqComClk_S1_G2_SM_value = get_cdrLockTimeAcqComClk_S1_G2_SM
        If flag_cdrLockTimeAcqComClk_S2_G2_SM = &H0 Then write_cdrLockTimeAcqComClk_S2_G2_SM_value = get_cdrLockTimeAcqComClk_S2_G2_SM

        regValue = leftShift((write_cdrLockTimeAcqComClk_S1_G2_SM_value and &Hff), 8) + leftShift((write_cdrLockTimeAcqComClk_S2_G2_SM_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_cdrLockTimeAcqComClk_S1_G2_SM_value = rightShift(data_low, 8) and &Hff
        cdrLockTimeAcqComClk_S2_G2_SM_mask = &Hff
        if data_low > LONG_MAX then
            if cdrLockTimeAcqComClk_S2_G2_SM_mask = mask then
                read_cdrLockTimeAcqComClk_S2_G2_SM_value = data_low
            else
                read_cdrLockTimeAcqComClk_S2_G2_SM_value = (data_low - H8000_0000) and cdrLockTimeAcqComClk_S2_G2_SM_mask
            end If
        else
            read_cdrLockTimeAcqComClk_S2_G2_SM_value = data_low and cdrLockTimeAcqComClk_S2_G2_SM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_cdrLockTimeAcqComClk_S1_G2_SM_value = &H0
        flag_cdrLockTimeAcqComClk_S1_G2_SM        = &H0
        write_cdrLockTimeAcqComClk_S2_G2_SM_value = &H0
        flag_cdrLockTimeAcqComClk_S2_G2_SM        = &H0
    End Sub
End Class


'' @REGISTER : RX_DFE3__SGMIIPCIE_X1_ctrlb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' cdrLockTimeAcqComClk_S3_G2_SM              [15:8]           get_cdrLockTimeAcqComClk_S3_G2_SM
''                                                             set_cdrLockTimeAcqComClk_S3_G2_SM
''                                                             read_cdrLockTimeAcqComClk_S3_G2_SM
''                                                             write_cdrLockTimeAcqComClk_S3_G2_SM
''---------------------------------------------------------------------------------
'' cdrLockTimeTrckComClk_G2_SM                [7:0]            get_cdrLockTimeTrckComClk_G2_SM
''                                                             set_cdrLockTimeTrckComClk_G2_SM
''                                                             read_cdrLockTimeTrckComClk_G2_SM
''                                                             write_cdrLockTimeTrckComClk_G2_SM
''---------------------------------------------------------------------------------
Class REGISTER_RX_DFE3__SGMIIPCIE_X1_ctrlb
    Private write_cdrLockTimeAcqComClk_S3_G2_SM_value
    Private read_cdrLockTimeAcqComClk_S3_G2_SM_value
    Private flag_cdrLockTimeAcqComClk_S3_G2_SM
    Private write_cdrLockTimeTrckComClk_G2_SM_value
    Private read_cdrLockTimeTrckComClk_G2_SM_value
    Private flag_cdrLockTimeTrckComClk_G2_SM

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

    Property Get get_cdrLockTimeAcqComClk_S3_G2_SM
        get_cdrLockTimeAcqComClk_S3_G2_SM = read_cdrLockTimeAcqComClk_S3_G2_SM_value
    End Property

    Property Let set_cdrLockTimeAcqComClk_S3_G2_SM(aData)
        write_cdrLockTimeAcqComClk_S3_G2_SM_value = aData
        flag_cdrLockTimeAcqComClk_S3_G2_SM        = &H1
    End Property

    Property Get read_cdrLockTimeAcqComClk_S3_G2_SM
        read
        read_cdrLockTimeAcqComClk_S3_G2_SM = read_cdrLockTimeAcqComClk_S3_G2_SM_value
    End Property

    Property Let write_cdrLockTimeAcqComClk_S3_G2_SM(aData)
        set_cdrLockTimeAcqComClk_S3_G2_SM = aData
        write
    End Property

    Property Get get_cdrLockTimeTrckComClk_G2_SM
        get_cdrLockTimeTrckComClk_G2_SM = read_cdrLockTimeTrckComClk_G2_SM_value
    End Property

    Property Let set_cdrLockTimeTrckComClk_G2_SM(aData)
        write_cdrLockTimeTrckComClk_G2_SM_value = aData
        flag_cdrLockTimeTrckComClk_G2_SM        = &H1
    End Property

    Property Get read_cdrLockTimeTrckComClk_G2_SM
        read
        read_cdrLockTimeTrckComClk_G2_SM = read_cdrLockTimeTrckComClk_G2_SM_value
    End Property

    Property Let write_cdrLockTimeTrckComClk_G2_SM(aData)
        set_cdrLockTimeTrckComClk_G2_SM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_cdrLockTimeAcqComClk_S3_G2_SM_value = rightShift(data_low, 8) and &Hff
        cdrLockTimeTrckComClk_G2_SM_mask = &Hff
        if data_low > LONG_MAX then
            if cdrLockTimeTrckComClk_G2_SM_mask = mask then
                read_cdrLockTimeTrckComClk_G2_SM_value = data_low
            else
                read_cdrLockTimeTrckComClk_G2_SM_value = (data_low - H8000_0000) and cdrLockTimeTrckComClk_G2_SM_mask
            end If
        else
            read_cdrLockTimeTrckComClk_G2_SM_value = data_low and cdrLockTimeTrckComClk_G2_SM_mask
        end If

    End Sub

    Sub write
        If flag_cdrLockTimeAcqComClk_S3_G2_SM = &H0 or flag_cdrLockTimeTrckComClk_G2_SM = &H0 Then read
        If flag_cdrLockTimeAcqComClk_S3_G2_SM = &H0 Then write_cdrLockTimeAcqComClk_S3_G2_SM_value = get_cdrLockTimeAcqComClk_S3_G2_SM
        If flag_cdrLockTimeTrckComClk_G2_SM = &H0 Then write_cdrLockTimeTrckComClk_G2_SM_value = get_cdrLockTimeTrckComClk_G2_SM

        regValue = leftShift((write_cdrLockTimeAcqComClk_S3_G2_SM_value and &Hff), 8) + leftShift((write_cdrLockTimeTrckComClk_G2_SM_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_cdrLockTimeAcqComClk_S3_G2_SM_value = rightShift(data_low, 8) and &Hff
        cdrLockTimeTrckComClk_G2_SM_mask = &Hff
        if data_low > LONG_MAX then
            if cdrLockTimeTrckComClk_G2_SM_mask = mask then
                read_cdrLockTimeTrckComClk_G2_SM_value = data_low
            else
                read_cdrLockTimeTrckComClk_G2_SM_value = (data_low - H8000_0000) and cdrLockTimeTrckComClk_G2_SM_mask
            end If
        else
            read_cdrLockTimeTrckComClk_G2_SM_value = data_low and cdrLockTimeTrckComClk_G2_SM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_cdrLockTimeAcqComClk_S3_G2_SM_value = &H0
        flag_cdrLockTimeAcqComClk_S3_G2_SM        = &H0
        write_cdrLockTimeTrckComClk_G2_SM_value = &H0
        flag_cdrLockTimeTrckComClk_G2_SM        = &H0
    End Sub
End Class


'' @REGISTER : RX_DFE3__SGMIIPCIE_X1_ctrlc
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' cdrLockTimeAcqNrml_SM                      [15:8]           get_cdrLockTimeAcqNrml_SM
''                                                             set_cdrLockTimeAcqNrml_SM
''                                                             read_cdrLockTimeAcqNrml_SM
''                                                             write_cdrLockTimeAcqNrml_SM
''---------------------------------------------------------------------------------
'' cdrLockTimeTrckNrml_SM                     [7:0]            get_cdrLockTimeTrckNrml_SM
''                                                             set_cdrLockTimeTrckNrml_SM
''                                                             read_cdrLockTimeTrckNrml_SM
''                                                             write_cdrLockTimeTrckNrml_SM
''---------------------------------------------------------------------------------
Class REGISTER_RX_DFE3__SGMIIPCIE_X1_ctrlc
    Private write_cdrLockTimeAcqNrml_SM_value
    Private read_cdrLockTimeAcqNrml_SM_value
    Private flag_cdrLockTimeAcqNrml_SM
    Private write_cdrLockTimeTrckNrml_SM_value
    Private read_cdrLockTimeTrckNrml_SM_value
    Private flag_cdrLockTimeTrckNrml_SM

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

    Property Get get_cdrLockTimeAcqNrml_SM
        get_cdrLockTimeAcqNrml_SM = read_cdrLockTimeAcqNrml_SM_value
    End Property

    Property Let set_cdrLockTimeAcqNrml_SM(aData)
        write_cdrLockTimeAcqNrml_SM_value = aData
        flag_cdrLockTimeAcqNrml_SM        = &H1
    End Property

    Property Get read_cdrLockTimeAcqNrml_SM
        read
        read_cdrLockTimeAcqNrml_SM = read_cdrLockTimeAcqNrml_SM_value
    End Property

    Property Let write_cdrLockTimeAcqNrml_SM(aData)
        set_cdrLockTimeAcqNrml_SM = aData
        write
    End Property

    Property Get get_cdrLockTimeTrckNrml_SM
        get_cdrLockTimeTrckNrml_SM = read_cdrLockTimeTrckNrml_SM_value
    End Property

    Property Let set_cdrLockTimeTrckNrml_SM(aData)
        write_cdrLockTimeTrckNrml_SM_value = aData
        flag_cdrLockTimeTrckNrml_SM        = &H1
    End Property

    Property Get read_cdrLockTimeTrckNrml_SM
        read
        read_cdrLockTimeTrckNrml_SM = read_cdrLockTimeTrckNrml_SM_value
    End Property

    Property Let write_cdrLockTimeTrckNrml_SM(aData)
        set_cdrLockTimeTrckNrml_SM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_cdrLockTimeAcqNrml_SM_value = rightShift(data_low, 8) and &Hff
        cdrLockTimeTrckNrml_SM_mask = &Hff
        if data_low > LONG_MAX then
            if cdrLockTimeTrckNrml_SM_mask = mask then
                read_cdrLockTimeTrckNrml_SM_value = data_low
            else
                read_cdrLockTimeTrckNrml_SM_value = (data_low - H8000_0000) and cdrLockTimeTrckNrml_SM_mask
            end If
        else
            read_cdrLockTimeTrckNrml_SM_value = data_low and cdrLockTimeTrckNrml_SM_mask
        end If

    End Sub

    Sub write
        If flag_cdrLockTimeAcqNrml_SM = &H0 or flag_cdrLockTimeTrckNrml_SM = &H0 Then read
        If flag_cdrLockTimeAcqNrml_SM = &H0 Then write_cdrLockTimeAcqNrml_SM_value = get_cdrLockTimeAcqNrml_SM
        If flag_cdrLockTimeTrckNrml_SM = &H0 Then write_cdrLockTimeTrckNrml_SM_value = get_cdrLockTimeTrckNrml_SM

        regValue = leftShift((write_cdrLockTimeAcqNrml_SM_value and &Hff), 8) + leftShift((write_cdrLockTimeTrckNrml_SM_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_cdrLockTimeAcqNrml_SM_value = rightShift(data_low, 8) and &Hff
        cdrLockTimeTrckNrml_SM_mask = &Hff
        if data_low > LONG_MAX then
            if cdrLockTimeTrckNrml_SM_mask = mask then
                read_cdrLockTimeTrckNrml_SM_value = data_low
            else
                read_cdrLockTimeTrckNrml_SM_value = (data_low - H8000_0000) and cdrLockTimeTrckNrml_SM_mask
            end If
        else
            read_cdrLockTimeTrckNrml_SM_value = data_low and cdrLockTimeTrckNrml_SM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_cdrLockTimeAcqNrml_SM_value = &H0
        flag_cdrLockTimeAcqNrml_SM        = &H0
        write_cdrLockTimeTrckNrml_SM_value = &H0
        flag_cdrLockTimeTrckNrml_SM        = &H0
    End Sub
End Class


'' @REGISTER : RX_DFE3__SGMIIPCIE_X1_ctrld
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' bwsel_prop_acq_nrml_SM                     [15:12]          get_bwsel_prop_acq_nrml_SM
''                                                             set_bwsel_prop_acq_nrml_SM
''                                                             read_bwsel_prop_acq_nrml_SM
''                                                             write_bwsel_prop_acq_nrml_SM
''---------------------------------------------------------------------------------
'' bwsel_integ_acq_nrml_SM                    [11:8]           get_bwsel_integ_acq_nrml_SM
''                                                             set_bwsel_integ_acq_nrml_SM
''                                                             read_bwsel_integ_acq_nrml_SM
''                                                             write_bwsel_integ_acq_nrml_SM
''---------------------------------------------------------------------------------
'' cdr_rising_edge_SM1                        [7:7]            get_cdr_rising_edge_SM1
''                                                             set_cdr_rising_edge_SM1
''                                                             read_cdr_rising_edge_SM1
''                                                             write_cdr_rising_edge_SM1
''---------------------------------------------------------------------------------
'' cdr_falling_edge_SM1                       [6:6]            get_cdr_falling_edge_SM1
''                                                             set_cdr_falling_edge_SM1
''                                                             read_cdr_falling_edge_SM1
''                                                             write_cdr_falling_edge_SM1
''---------------------------------------------------------------------------------
'' cdr_rising_edge_SM0                        [5:5]            get_cdr_rising_edge_SM0
''                                                             set_cdr_rising_edge_SM0
''                                                             read_cdr_rising_edge_SM0
''                                                             write_cdr_rising_edge_SM0
''---------------------------------------------------------------------------------
'' cdr_falling_edge_SM0                       [4:4]            get_cdr_falling_edge_SM0
''                                                             set_cdr_falling_edge_SM0
''                                                             read_cdr_falling_edge_SM0
''                                                             write_cdr_falling_edge_SM0
''---------------------------------------------------------------------------------
'' cdr_phase_sat_ctrl_SM1                     [3:2]            get_cdr_phase_sat_ctrl_SM1
''                                                             set_cdr_phase_sat_ctrl_SM1
''                                                             read_cdr_phase_sat_ctrl_SM1
''                                                             write_cdr_phase_sat_ctrl_SM1
''---------------------------------------------------------------------------------
'' cdr_phase_sat_ctrl_SM0                     [1:0]            get_cdr_phase_sat_ctrl_SM0
''                                                             set_cdr_phase_sat_ctrl_SM0
''                                                             read_cdr_phase_sat_ctrl_SM0
''                                                             write_cdr_phase_sat_ctrl_SM0
''---------------------------------------------------------------------------------
Class REGISTER_RX_DFE3__SGMIIPCIE_X1_ctrld
    Private write_bwsel_prop_acq_nrml_SM_value
    Private read_bwsel_prop_acq_nrml_SM_value
    Private flag_bwsel_prop_acq_nrml_SM
    Private write_bwsel_integ_acq_nrml_SM_value
    Private read_bwsel_integ_acq_nrml_SM_value
    Private flag_bwsel_integ_acq_nrml_SM
    Private write_cdr_rising_edge_SM1_value
    Private read_cdr_rising_edge_SM1_value
    Private flag_cdr_rising_edge_SM1
    Private write_cdr_falling_edge_SM1_value
    Private read_cdr_falling_edge_SM1_value
    Private flag_cdr_falling_edge_SM1
    Private write_cdr_rising_edge_SM0_value
    Private read_cdr_rising_edge_SM0_value
    Private flag_cdr_rising_edge_SM0
    Private write_cdr_falling_edge_SM0_value
    Private read_cdr_falling_edge_SM0_value
    Private flag_cdr_falling_edge_SM0
    Private write_cdr_phase_sat_ctrl_SM1_value
    Private read_cdr_phase_sat_ctrl_SM1_value
    Private flag_cdr_phase_sat_ctrl_SM1
    Private write_cdr_phase_sat_ctrl_SM0_value
    Private read_cdr_phase_sat_ctrl_SM0_value
    Private flag_cdr_phase_sat_ctrl_SM0

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

    Property Get get_bwsel_prop_acq_nrml_SM
        get_bwsel_prop_acq_nrml_SM = read_bwsel_prop_acq_nrml_SM_value
    End Property

    Property Let set_bwsel_prop_acq_nrml_SM(aData)
        write_bwsel_prop_acq_nrml_SM_value = aData
        flag_bwsel_prop_acq_nrml_SM        = &H1
    End Property

    Property Get read_bwsel_prop_acq_nrml_SM
        read
        read_bwsel_prop_acq_nrml_SM = read_bwsel_prop_acq_nrml_SM_value
    End Property

    Property Let write_bwsel_prop_acq_nrml_SM(aData)
        set_bwsel_prop_acq_nrml_SM = aData
        write
    End Property

    Property Get get_bwsel_integ_acq_nrml_SM
        get_bwsel_integ_acq_nrml_SM = read_bwsel_integ_acq_nrml_SM_value
    End Property

    Property Let set_bwsel_integ_acq_nrml_SM(aData)
        write_bwsel_integ_acq_nrml_SM_value = aData
        flag_bwsel_integ_acq_nrml_SM        = &H1
    End Property

    Property Get read_bwsel_integ_acq_nrml_SM
        read
        read_bwsel_integ_acq_nrml_SM = read_bwsel_integ_acq_nrml_SM_value
    End Property

    Property Let write_bwsel_integ_acq_nrml_SM(aData)
        set_bwsel_integ_acq_nrml_SM = aData
        write
    End Property

    Property Get get_cdr_rising_edge_SM1
        get_cdr_rising_edge_SM1 = read_cdr_rising_edge_SM1_value
    End Property

    Property Let set_cdr_rising_edge_SM1(aData)
        write_cdr_rising_edge_SM1_value = aData
        flag_cdr_rising_edge_SM1        = &H1
    End Property

    Property Get read_cdr_rising_edge_SM1
        read
        read_cdr_rising_edge_SM1 = read_cdr_rising_edge_SM1_value
    End Property

    Property Let write_cdr_rising_edge_SM1(aData)
        set_cdr_rising_edge_SM1 = aData
        write
    End Property

    Property Get get_cdr_falling_edge_SM1
        get_cdr_falling_edge_SM1 = read_cdr_falling_edge_SM1_value
    End Property

    Property Let set_cdr_falling_edge_SM1(aData)
        write_cdr_falling_edge_SM1_value = aData
        flag_cdr_falling_edge_SM1        = &H1
    End Property

    Property Get read_cdr_falling_edge_SM1
        read
        read_cdr_falling_edge_SM1 = read_cdr_falling_edge_SM1_value
    End Property

    Property Let write_cdr_falling_edge_SM1(aData)
        set_cdr_falling_edge_SM1 = aData
        write
    End Property

    Property Get get_cdr_rising_edge_SM0
        get_cdr_rising_edge_SM0 = read_cdr_rising_edge_SM0_value
    End Property

    Property Let set_cdr_rising_edge_SM0(aData)
        write_cdr_rising_edge_SM0_value = aData
        flag_cdr_rising_edge_SM0        = &H1
    End Property

    Property Get read_cdr_rising_edge_SM0
        read
        read_cdr_rising_edge_SM0 = read_cdr_rising_edge_SM0_value
    End Property

    Property Let write_cdr_rising_edge_SM0(aData)
        set_cdr_rising_edge_SM0 = aData
        write
    End Property

    Property Get get_cdr_falling_edge_SM0
        get_cdr_falling_edge_SM0 = read_cdr_falling_edge_SM0_value
    End Property

    Property Let set_cdr_falling_edge_SM0(aData)
        write_cdr_falling_edge_SM0_value = aData
        flag_cdr_falling_edge_SM0        = &H1
    End Property

    Property Get read_cdr_falling_edge_SM0
        read
        read_cdr_falling_edge_SM0 = read_cdr_falling_edge_SM0_value
    End Property

    Property Let write_cdr_falling_edge_SM0(aData)
        set_cdr_falling_edge_SM0 = aData
        write
    End Property

    Property Get get_cdr_phase_sat_ctrl_SM1
        get_cdr_phase_sat_ctrl_SM1 = read_cdr_phase_sat_ctrl_SM1_value
    End Property

    Property Let set_cdr_phase_sat_ctrl_SM1(aData)
        write_cdr_phase_sat_ctrl_SM1_value = aData
        flag_cdr_phase_sat_ctrl_SM1        = &H1
    End Property

    Property Get read_cdr_phase_sat_ctrl_SM1
        read
        read_cdr_phase_sat_ctrl_SM1 = read_cdr_phase_sat_ctrl_SM1_value
    End Property

    Property Let write_cdr_phase_sat_ctrl_SM1(aData)
        set_cdr_phase_sat_ctrl_SM1 = aData
        write
    End Property

    Property Get get_cdr_phase_sat_ctrl_SM0
        get_cdr_phase_sat_ctrl_SM0 = read_cdr_phase_sat_ctrl_SM0_value
    End Property

    Property Let set_cdr_phase_sat_ctrl_SM0(aData)
        write_cdr_phase_sat_ctrl_SM0_value = aData
        flag_cdr_phase_sat_ctrl_SM0        = &H1
    End Property

    Property Get read_cdr_phase_sat_ctrl_SM0
        read
        read_cdr_phase_sat_ctrl_SM0 = read_cdr_phase_sat_ctrl_SM0_value
    End Property

    Property Let write_cdr_phase_sat_ctrl_SM0(aData)
        set_cdr_phase_sat_ctrl_SM0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_bwsel_prop_acq_nrml_SM_value = rightShift(data_low, 12) and &Hf
        read_bwsel_integ_acq_nrml_SM_value = rightShift(data_low, 8) and &Hf
        read_cdr_rising_edge_SM1_value = rightShift(data_low, 7) and &H1
        read_cdr_falling_edge_SM1_value = rightShift(data_low, 6) and &H1
        read_cdr_rising_edge_SM0_value = rightShift(data_low, 5) and &H1
        read_cdr_falling_edge_SM0_value = rightShift(data_low, 4) and &H1
        read_cdr_phase_sat_ctrl_SM1_value = rightShift(data_low, 2) and &H3
        cdr_phase_sat_ctrl_SM0_mask = &H3
        if data_low > LONG_MAX then
            if cdr_phase_sat_ctrl_SM0_mask = mask then
                read_cdr_phase_sat_ctrl_SM0_value = data_low
            else
                read_cdr_phase_sat_ctrl_SM0_value = (data_low - H8000_0000) and cdr_phase_sat_ctrl_SM0_mask
            end If
        else
            read_cdr_phase_sat_ctrl_SM0_value = data_low and cdr_phase_sat_ctrl_SM0_mask
        end If

    End Sub

    Sub write
        If flag_bwsel_prop_acq_nrml_SM = &H0 or flag_bwsel_integ_acq_nrml_SM = &H0 or flag_cdr_rising_edge_SM1 = &H0 or flag_cdr_falling_edge_SM1 = &H0 or flag_cdr_rising_edge_SM0 = &H0 or flag_cdr_falling_edge_SM0 = &H0 or flag_cdr_phase_sat_ctrl_SM1 = &H0 or flag_cdr_phase_sat_ctrl_SM0 = &H0 Then read
        If flag_bwsel_prop_acq_nrml_SM = &H0 Then write_bwsel_prop_acq_nrml_SM_value = get_bwsel_prop_acq_nrml_SM
        If flag_bwsel_integ_acq_nrml_SM = &H0 Then write_bwsel_integ_acq_nrml_SM_value = get_bwsel_integ_acq_nrml_SM
        If flag_cdr_rising_edge_SM1 = &H0 Then write_cdr_rising_edge_SM1_value = get_cdr_rising_edge_SM1
        If flag_cdr_falling_edge_SM1 = &H0 Then write_cdr_falling_edge_SM1_value = get_cdr_falling_edge_SM1
        If flag_cdr_rising_edge_SM0 = &H0 Then write_cdr_rising_edge_SM0_value = get_cdr_rising_edge_SM0
        If flag_cdr_falling_edge_SM0 = &H0 Then write_cdr_falling_edge_SM0_value = get_cdr_falling_edge_SM0
        If flag_cdr_phase_sat_ctrl_SM1 = &H0 Then write_cdr_phase_sat_ctrl_SM1_value = get_cdr_phase_sat_ctrl_SM1
        If flag_cdr_phase_sat_ctrl_SM0 = &H0 Then write_cdr_phase_sat_ctrl_SM0_value = get_cdr_phase_sat_ctrl_SM0

        regValue = leftShift((write_bwsel_prop_acq_nrml_SM_value and &Hf), 12) + leftShift((write_bwsel_integ_acq_nrml_SM_value and &Hf), 8) + leftShift((write_cdr_rising_edge_SM1_value and &H1), 7) + leftShift((write_cdr_falling_edge_SM1_value and &H1), 6) + leftShift((write_cdr_rising_edge_SM0_value and &H1), 5) + leftShift((write_cdr_falling_edge_SM0_value and &H1), 4) + leftShift((write_cdr_phase_sat_ctrl_SM1_value and &H3), 2) + leftShift((write_cdr_phase_sat_ctrl_SM0_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_bwsel_prop_acq_nrml_SM_value = rightShift(data_low, 12) and &Hf
        read_bwsel_integ_acq_nrml_SM_value = rightShift(data_low, 8) and &Hf
        read_cdr_rising_edge_SM1_value = rightShift(data_low, 7) and &H1
        read_cdr_falling_edge_SM1_value = rightShift(data_low, 6) and &H1
        read_cdr_rising_edge_SM0_value = rightShift(data_low, 5) and &H1
        read_cdr_falling_edge_SM0_value = rightShift(data_low, 4) and &H1
        read_cdr_phase_sat_ctrl_SM1_value = rightShift(data_low, 2) and &H3
        cdr_phase_sat_ctrl_SM0_mask = &H3
        if data_low > LONG_MAX then
            if cdr_phase_sat_ctrl_SM0_mask = mask then
                read_cdr_phase_sat_ctrl_SM0_value = data_low
            else
                read_cdr_phase_sat_ctrl_SM0_value = (data_low - H8000_0000) and cdr_phase_sat_ctrl_SM0_mask
            end If
        else
            read_cdr_phase_sat_ctrl_SM0_value = data_low and cdr_phase_sat_ctrl_SM0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_bwsel_prop_acq_nrml_SM_value = &H0
        flag_bwsel_prop_acq_nrml_SM        = &H0
        write_bwsel_integ_acq_nrml_SM_value = &H0
        flag_bwsel_integ_acq_nrml_SM        = &H0
        write_cdr_rising_edge_SM1_value = &H0
        flag_cdr_rising_edge_SM1        = &H0
        write_cdr_falling_edge_SM1_value = &H0
        flag_cdr_falling_edge_SM1        = &H0
        write_cdr_rising_edge_SM0_value = &H0
        flag_cdr_rising_edge_SM0        = &H0
        write_cdr_falling_edge_SM0_value = &H0
        flag_cdr_falling_edge_SM0        = &H0
        write_cdr_phase_sat_ctrl_SM1_value = &H0
        flag_cdr_phase_sat_ctrl_SM1        = &H0
        write_cdr_phase_sat_ctrl_SM0_value = &H0
        flag_cdr_phase_sat_ctrl_SM0        = &H0
    End Sub
End Class


'' @REGISTER : RX_DFE3__SGMIIPCIE_X1_ctrle
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mdio_ckcmp_mdio_rst                        [15:15]          get_mdio_ckcmp_mdio_rst
''                                                             set_mdio_ckcmp_mdio_rst
''                                                             read_mdio_ckcmp_mdio_rst
''                                                             write_mdio_ckcmp_mdio_rst
''---------------------------------------------------------------------------------
'' mdio_ckcmp_afrst_ptr_err_en                [14:14]          get_mdio_ckcmp_afrst_ptr_err_en
''                                                             set_mdio_ckcmp_afrst_ptr_err_en
''                                                             read_mdio_ckcmp_afrst_ptr_err_en
''                                                             write_mdio_ckcmp_afrst_ptr_err_en
''---------------------------------------------------------------------------------
'' MCAPEE                                     [12:12]          get_MCAPEE
''                                                             set_MCAPEE
''                                                             read_MCAPEE
''                                                             write_MCAPEE
''---------------------------------------------------------------------------------
'' mdio_ckcmp_phase_only_en                   [11:11]          get_mdio_ckcmp_phase_only_en
''                                                             set_mdio_ckcmp_phase_only_en
''                                                             read_mdio_ckcmp_phase_only_en
''                                                             write_mdio_ckcmp_phase_only_en
''---------------------------------------------------------------------------------
'' mdio_DisableOvUnFlow                       [10:10]          get_mdio_DisableOvUnFlow
''                                                             set_mdio_DisableOvUnFlow
''                                                             read_mdio_DisableOvUnFlow
''                                                             write_mdio_DisableOvUnFlow
''---------------------------------------------------------------------------------
'' dbg_fn_sel                                 [9:8]            get_dbg_fn_sel
''                                                             set_dbg_fn_sel
''                                                             read_dbg_fn_sel
''                                                             write_dbg_fn_sel
''---------------------------------------------------------------------------------
'' dbg_fn_clr                                 [7:7]            get_dbg_fn_clr
''                                                             set_dbg_fn_clr
''                                                             read_dbg_fn_clr
''                                                             write_dbg_fn_clr
''---------------------------------------------------------------------------------
'' dbg_fn_en                                  [6:6]            get_dbg_fn_en
''                                                             set_dbg_fn_en
''                                                             read_dbg_fn_en
''                                                             write_dbg_fn_en
''---------------------------------------------------------------------------------
'' cdr_freq_sel_SM1                           [1:1]            get_cdr_freq_sel_SM1
''                                                             set_cdr_freq_sel_SM1
''                                                             read_cdr_freq_sel_SM1
''                                                             write_cdr_freq_sel_SM1
''---------------------------------------------------------------------------------
'' cdr_freq_sel_SM0                           [0:0]            get_cdr_freq_sel_SM0
''                                                             set_cdr_freq_sel_SM0
''                                                             read_cdr_freq_sel_SM0
''                                                             write_cdr_freq_sel_SM0
''---------------------------------------------------------------------------------
Class REGISTER_RX_DFE3__SGMIIPCIE_X1_ctrle
    Private write_mdio_ckcmp_mdio_rst_value
    Private read_mdio_ckcmp_mdio_rst_value
    Private flag_mdio_ckcmp_mdio_rst
    Private write_mdio_ckcmp_afrst_ptr_err_en_value
    Private read_mdio_ckcmp_afrst_ptr_err_en_value
    Private flag_mdio_ckcmp_afrst_ptr_err_en
    Private write_MCAPEE_value
    Private read_MCAPEE_value
    Private flag_MCAPEE
    Private write_mdio_ckcmp_phase_only_en_value
    Private read_mdio_ckcmp_phase_only_en_value
    Private flag_mdio_ckcmp_phase_only_en
    Private write_mdio_DisableOvUnFlow_value
    Private read_mdio_DisableOvUnFlow_value
    Private flag_mdio_DisableOvUnFlow
    Private write_dbg_fn_sel_value
    Private read_dbg_fn_sel_value
    Private flag_dbg_fn_sel
    Private write_dbg_fn_clr_value
    Private read_dbg_fn_clr_value
    Private flag_dbg_fn_clr
    Private write_dbg_fn_en_value
    Private read_dbg_fn_en_value
    Private flag_dbg_fn_en
    Private write_cdr_freq_sel_SM1_value
    Private read_cdr_freq_sel_SM1_value
    Private flag_cdr_freq_sel_SM1
    Private write_cdr_freq_sel_SM0_value
    Private read_cdr_freq_sel_SM0_value
    Private flag_cdr_freq_sel_SM0

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

    Property Get get_mdio_ckcmp_mdio_rst
        get_mdio_ckcmp_mdio_rst = read_mdio_ckcmp_mdio_rst_value
    End Property

    Property Let set_mdio_ckcmp_mdio_rst(aData)
        write_mdio_ckcmp_mdio_rst_value = aData
        flag_mdio_ckcmp_mdio_rst        = &H1
    End Property

    Property Get read_mdio_ckcmp_mdio_rst
        read
        read_mdio_ckcmp_mdio_rst = read_mdio_ckcmp_mdio_rst_value
    End Property

    Property Let write_mdio_ckcmp_mdio_rst(aData)
        set_mdio_ckcmp_mdio_rst = aData
        write
    End Property

    Property Get get_mdio_ckcmp_afrst_ptr_err_en
        get_mdio_ckcmp_afrst_ptr_err_en = read_mdio_ckcmp_afrst_ptr_err_en_value
    End Property

    Property Let set_mdio_ckcmp_afrst_ptr_err_en(aData)
        write_mdio_ckcmp_afrst_ptr_err_en_value = aData
        flag_mdio_ckcmp_afrst_ptr_err_en        = &H1
    End Property

    Property Get read_mdio_ckcmp_afrst_ptr_err_en
        read
        read_mdio_ckcmp_afrst_ptr_err_en = read_mdio_ckcmp_afrst_ptr_err_en_value
    End Property

    Property Let write_mdio_ckcmp_afrst_ptr_err_en(aData)
        set_mdio_ckcmp_afrst_ptr_err_en = aData
        write
    End Property

    Property Get get_MCAPEE
        get_MCAPEE = read_MCAPEE_value
    End Property

    Property Let set_MCAPEE(aData)
        write_MCAPEE_value = aData
        flag_MCAPEE        = &H1
    End Property

    Property Get read_MCAPEE
        read
        read_MCAPEE = read_MCAPEE_value
    End Property

    Property Let write_MCAPEE(aData)
        set_MCAPEE = aData
        write
    End Property

    Property Get get_mdio_ckcmp_phase_only_en
        get_mdio_ckcmp_phase_only_en = read_mdio_ckcmp_phase_only_en_value
    End Property

    Property Let set_mdio_ckcmp_phase_only_en(aData)
        write_mdio_ckcmp_phase_only_en_value = aData
        flag_mdio_ckcmp_phase_only_en        = &H1
    End Property

    Property Get read_mdio_ckcmp_phase_only_en
        read
        read_mdio_ckcmp_phase_only_en = read_mdio_ckcmp_phase_only_en_value
    End Property

    Property Let write_mdio_ckcmp_phase_only_en(aData)
        set_mdio_ckcmp_phase_only_en = aData
        write
    End Property

    Property Get get_mdio_DisableOvUnFlow
        get_mdio_DisableOvUnFlow = read_mdio_DisableOvUnFlow_value
    End Property

    Property Let set_mdio_DisableOvUnFlow(aData)
        write_mdio_DisableOvUnFlow_value = aData
        flag_mdio_DisableOvUnFlow        = &H1
    End Property

    Property Get read_mdio_DisableOvUnFlow
        read
        read_mdio_DisableOvUnFlow = read_mdio_DisableOvUnFlow_value
    End Property

    Property Let write_mdio_DisableOvUnFlow(aData)
        set_mdio_DisableOvUnFlow = aData
        write
    End Property

    Property Get get_dbg_fn_sel
        get_dbg_fn_sel = read_dbg_fn_sel_value
    End Property

    Property Let set_dbg_fn_sel(aData)
        write_dbg_fn_sel_value = aData
        flag_dbg_fn_sel        = &H1
    End Property

    Property Get read_dbg_fn_sel
        read
        read_dbg_fn_sel = read_dbg_fn_sel_value
    End Property

    Property Let write_dbg_fn_sel(aData)
        set_dbg_fn_sel = aData
        write
    End Property

    Property Get get_dbg_fn_clr
        get_dbg_fn_clr = read_dbg_fn_clr_value
    End Property

    Property Let set_dbg_fn_clr(aData)
        write_dbg_fn_clr_value = aData
        flag_dbg_fn_clr        = &H1
    End Property

    Property Get read_dbg_fn_clr
        read
        read_dbg_fn_clr = read_dbg_fn_clr_value
    End Property

    Property Let write_dbg_fn_clr(aData)
        set_dbg_fn_clr = aData
        write
    End Property

    Property Get get_dbg_fn_en
        get_dbg_fn_en = read_dbg_fn_en_value
    End Property

    Property Let set_dbg_fn_en(aData)
        write_dbg_fn_en_value = aData
        flag_dbg_fn_en        = &H1
    End Property

    Property Get read_dbg_fn_en
        read
        read_dbg_fn_en = read_dbg_fn_en_value
    End Property

    Property Let write_dbg_fn_en(aData)
        set_dbg_fn_en = aData
        write
    End Property

    Property Get get_cdr_freq_sel_SM1
        get_cdr_freq_sel_SM1 = read_cdr_freq_sel_SM1_value
    End Property

    Property Let set_cdr_freq_sel_SM1(aData)
        write_cdr_freq_sel_SM1_value = aData
        flag_cdr_freq_sel_SM1        = &H1
    End Property

    Property Get read_cdr_freq_sel_SM1
        read
        read_cdr_freq_sel_SM1 = read_cdr_freq_sel_SM1_value
    End Property

    Property Let write_cdr_freq_sel_SM1(aData)
        set_cdr_freq_sel_SM1 = aData
        write
    End Property

    Property Get get_cdr_freq_sel_SM0
        get_cdr_freq_sel_SM0 = read_cdr_freq_sel_SM0_value
    End Property

    Property Let set_cdr_freq_sel_SM0(aData)
        write_cdr_freq_sel_SM0_value = aData
        flag_cdr_freq_sel_SM0        = &H1
    End Property

    Property Get read_cdr_freq_sel_SM0
        read
        read_cdr_freq_sel_SM0 = read_cdr_freq_sel_SM0_value
    End Property

    Property Let write_cdr_freq_sel_SM0(aData)
        set_cdr_freq_sel_SM0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mdio_ckcmp_mdio_rst_value = rightShift(data_low, 15) and &H1
        read_mdio_ckcmp_afrst_ptr_err_en_value = rightShift(data_low, 14) and &H1
        read_MCAPEE_value = rightShift(data_low, 12) and &H1
        read_mdio_ckcmp_phase_only_en_value = rightShift(data_low, 11) and &H1
        read_mdio_DisableOvUnFlow_value = rightShift(data_low, 10) and &H1
        read_dbg_fn_sel_value = rightShift(data_low, 8) and &H3
        read_dbg_fn_clr_value = rightShift(data_low, 7) and &H1
        read_dbg_fn_en_value = rightShift(data_low, 6) and &H1
        read_cdr_freq_sel_SM1_value = rightShift(data_low, 1) and &H1
        cdr_freq_sel_SM0_mask = &H1
        if data_low > LONG_MAX then
            if cdr_freq_sel_SM0_mask = mask then
                read_cdr_freq_sel_SM0_value = data_low
            else
                read_cdr_freq_sel_SM0_value = (data_low - H8000_0000) and cdr_freq_sel_SM0_mask
            end If
        else
            read_cdr_freq_sel_SM0_value = data_low and cdr_freq_sel_SM0_mask
        end If

    End Sub

    Sub write
        If flag_mdio_ckcmp_mdio_rst = &H0 or flag_mdio_ckcmp_afrst_ptr_err_en = &H0 or flag_MCAPEE = &H0 or flag_mdio_ckcmp_phase_only_en = &H0 or flag_mdio_DisableOvUnFlow = &H0 or flag_dbg_fn_sel = &H0 or flag_dbg_fn_clr = &H0 or flag_dbg_fn_en = &H0 or flag_cdr_freq_sel_SM1 = &H0 or flag_cdr_freq_sel_SM0 = &H0 Then read
        If flag_mdio_ckcmp_mdio_rst = &H0 Then write_mdio_ckcmp_mdio_rst_value = get_mdio_ckcmp_mdio_rst
        If flag_mdio_ckcmp_afrst_ptr_err_en = &H0 Then write_mdio_ckcmp_afrst_ptr_err_en_value = get_mdio_ckcmp_afrst_ptr_err_en
        If flag_MCAPEE = &H0 Then write_MCAPEE_value = get_MCAPEE
        If flag_mdio_ckcmp_phase_only_en = &H0 Then write_mdio_ckcmp_phase_only_en_value = get_mdio_ckcmp_phase_only_en
        If flag_mdio_DisableOvUnFlow = &H0 Then write_mdio_DisableOvUnFlow_value = get_mdio_DisableOvUnFlow
        If flag_dbg_fn_sel = &H0 Then write_dbg_fn_sel_value = get_dbg_fn_sel
        If flag_dbg_fn_clr = &H0 Then write_dbg_fn_clr_value = get_dbg_fn_clr
        If flag_dbg_fn_en = &H0 Then write_dbg_fn_en_value = get_dbg_fn_en
        If flag_cdr_freq_sel_SM1 = &H0 Then write_cdr_freq_sel_SM1_value = get_cdr_freq_sel_SM1
        If flag_cdr_freq_sel_SM0 = &H0 Then write_cdr_freq_sel_SM0_value = get_cdr_freq_sel_SM0

        regValue = leftShift((write_mdio_ckcmp_mdio_rst_value and &H1), 15) + leftShift((write_mdio_ckcmp_afrst_ptr_err_en_value and &H1), 14) + leftShift((write_MCAPEE_value and &H1), 12) + leftShift((write_mdio_ckcmp_phase_only_en_value and &H1), 11) + leftShift((write_mdio_DisableOvUnFlow_value and &H1), 10) + leftShift((write_dbg_fn_sel_value and &H3), 8) + leftShift((write_dbg_fn_clr_value and &H1), 7) + leftShift((write_dbg_fn_en_value and &H1), 6) + leftShift((write_cdr_freq_sel_SM1_value and &H1), 1) + leftShift((write_cdr_freq_sel_SM0_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mdio_ckcmp_mdio_rst_value = rightShift(data_low, 15) and &H1
        read_mdio_ckcmp_afrst_ptr_err_en_value = rightShift(data_low, 14) and &H1
        read_MCAPEE_value = rightShift(data_low, 12) and &H1
        read_mdio_ckcmp_phase_only_en_value = rightShift(data_low, 11) and &H1
        read_mdio_DisableOvUnFlow_value = rightShift(data_low, 10) and &H1
        read_dbg_fn_sel_value = rightShift(data_low, 8) and &H3
        read_dbg_fn_clr_value = rightShift(data_low, 7) and &H1
        read_dbg_fn_en_value = rightShift(data_low, 6) and &H1
        read_cdr_freq_sel_SM1_value = rightShift(data_low, 1) and &H1
        cdr_freq_sel_SM0_mask = &H1
        if data_low > LONG_MAX then
            if cdr_freq_sel_SM0_mask = mask then
                read_cdr_freq_sel_SM0_value = data_low
            else
                read_cdr_freq_sel_SM0_value = (data_low - H8000_0000) and cdr_freq_sel_SM0_mask
            end If
        else
            read_cdr_freq_sel_SM0_value = data_low and cdr_freq_sel_SM0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mdio_ckcmp_mdio_rst_value = &H0
        flag_mdio_ckcmp_mdio_rst        = &H0
        write_mdio_ckcmp_afrst_ptr_err_en_value = &H0
        flag_mdio_ckcmp_afrst_ptr_err_en        = &H0
        write_MCAPEE_value = &H0
        flag_MCAPEE        = &H0
        write_mdio_ckcmp_phase_only_en_value = &H0
        flag_mdio_ckcmp_phase_only_en        = &H0
        write_mdio_DisableOvUnFlow_value = &H0
        flag_mdio_DisableOvUnFlow        = &H0
        write_dbg_fn_sel_value = &H0
        flag_dbg_fn_sel        = &H0
        write_dbg_fn_clr_value = &H0
        flag_dbg_fn_clr        = &H0
        write_dbg_fn_en_value = &H0
        flag_dbg_fn_en        = &H0
        write_cdr_freq_sel_SM1_value = &H0
        flag_cdr_freq_sel_SM1        = &H0
        write_cdr_freq_sel_SM0_value = &H0
        flag_cdr_freq_sel_SM0        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class RX_DFE3__SGMIIPCIE_X1_INSTANCE

    Public ctrl0
    Public ctrl1
    Public ctrl2
    Public ctrl3
    Public ctrl4
    Public ctrl5
    Public ctrl6
    Public ctrl7
    Public ctrl8
    Public ctrl9
    Public ctrla
    Public ctrlb
    Public ctrlc
    Public ctrld
    Public ctrle


    Public default function Init(aBaseAddr)
        Set ctrl0 = (New REGISTER_RX_DFE3__SGMIIPCIE_X1_ctrl0)(aBaseAddr, 16)
        Set ctrl1 = (New REGISTER_RX_DFE3__SGMIIPCIE_X1_ctrl1)(aBaseAddr, 16)
        Set ctrl2 = (New REGISTER_RX_DFE3__SGMIIPCIE_X1_ctrl2)(aBaseAddr, 16)
        Set ctrl3 = (New REGISTER_RX_DFE3__SGMIIPCIE_X1_ctrl3)(aBaseAddr, 16)
        Set ctrl4 = (New REGISTER_RX_DFE3__SGMIIPCIE_X1_ctrl4)(aBaseAddr, 16)
        Set ctrl5 = (New REGISTER_RX_DFE3__SGMIIPCIE_X1_ctrl5)(aBaseAddr, 16)
        Set ctrl6 = (New REGISTER_RX_DFE3__SGMIIPCIE_X1_ctrl6)(aBaseAddr, 16)
        Set ctrl7 = (New REGISTER_RX_DFE3__SGMIIPCIE_X1_ctrl7)(aBaseAddr, 16)
        Set ctrl8 = (New REGISTER_RX_DFE3__SGMIIPCIE_X1_ctrl8)(aBaseAddr, 16)
        Set ctrl9 = (New REGISTER_RX_DFE3__SGMIIPCIE_X1_ctrl9)(aBaseAddr, 16)
        Set ctrla = (New REGISTER_RX_DFE3__SGMIIPCIE_X1_ctrla)(aBaseAddr, 16)
        Set ctrlb = (New REGISTER_RX_DFE3__SGMIIPCIE_X1_ctrlb)(aBaseAddr, 16)
        Set ctrlc = (New REGISTER_RX_DFE3__SGMIIPCIE_X1_ctrlc)(aBaseAddr, 16)
        Set ctrld = (New REGISTER_RX_DFE3__SGMIIPCIE_X1_ctrld)(aBaseAddr, 16)
        Set ctrle = (New REGISTER_RX_DFE3__SGMIIPCIE_X1_ctrle)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set RX_DFE3__SGMIIPCIE_X1 = CreateObject("System.Collections.ArrayList")
RX_DFE3__SGMIIPCIE_X1.Add ((New RX_DFE3__SGMIIPCIE_X1_INSTANCE)(&H4adee600))


