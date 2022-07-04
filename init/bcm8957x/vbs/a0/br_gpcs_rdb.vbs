

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


'' @REGISTER : BR_GPCS_gmii_fifo_ctl0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' GMII_FIFO_Control                          [15:0]           get_GMII_FIFO_Control
''                                                             set_GMII_FIFO_Control
''                                                             read_GMII_FIFO_Control
''                                                             write_GMII_FIFO_Control
''---------------------------------------------------------------------------------
Class REGISTER_BR_GPCS_gmii_fifo_ctl0
    Private write_GMII_FIFO_Control_value
    Private read_GMII_FIFO_Control_value
    Private flag_GMII_FIFO_Control

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

    Property Get get_GMII_FIFO_Control
        get_GMII_FIFO_Control = read_GMII_FIFO_Control_value
    End Property

    Property Let set_GMII_FIFO_Control(aData)
        write_GMII_FIFO_Control_value = aData
        flag_GMII_FIFO_Control        = &H1
    End Property

    Property Get read_GMII_FIFO_Control
        read
        read_GMII_FIFO_Control = read_GMII_FIFO_Control_value
    End Property

    Property Let write_GMII_FIFO_Control(aData)
        set_GMII_FIFO_Control = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GMII_FIFO_Control_mask = &Hffff
        if data_low > LONG_MAX then
            if GMII_FIFO_Control_mask = mask then
                read_GMII_FIFO_Control_value = data_low
            else
                read_GMII_FIFO_Control_value = (data_low - H8000_0000) and GMII_FIFO_Control_mask
            end If
        else
            read_GMII_FIFO_Control_value = data_low and GMII_FIFO_Control_mask
        end If

    End Sub

    Sub write
        If flag_GMII_FIFO_Control = &H0 Then read
        If flag_GMII_FIFO_Control = &H0 Then write_GMII_FIFO_Control_value = get_GMII_FIFO_Control

        regValue = leftShift((write_GMII_FIFO_Control_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GMII_FIFO_Control_mask = &Hffff
        if data_low > LONG_MAX then
            if GMII_FIFO_Control_mask = mask then
                read_GMII_FIFO_Control_value = data_low
            else
                read_GMII_FIFO_Control_value = (data_low - H8000_0000) and GMII_FIFO_Control_mask
            end If
        else
            read_GMII_FIFO_Control_value = data_low and GMII_FIFO_Control_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_GMII_FIFO_Control_value = &H0
        flag_GMII_FIFO_Control        = &H0
    End Sub
End Class


'' @REGISTER : BR_GPCS_gmii_fifo_ctl1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' FIFO_BYPASS                                [2:2]            get_FIFO_BYPASS
''                                                             set_FIFO_BYPASS
''                                                             read_FIFO_BYPASS
''                                                             write_FIFO_BYPASS
''---------------------------------------------------------------------------------
'' GMII_FIFO_Elasticity_Mode                  [1:0]            get_GMII_FIFO_Elasticity_Mode
''                                                             set_GMII_FIFO_Elasticity_Mode
''                                                             read_GMII_FIFO_Elasticity_Mode
''                                                             write_GMII_FIFO_Elasticity_Mode
''---------------------------------------------------------------------------------
Class REGISTER_BR_GPCS_gmii_fifo_ctl1
    Private write_FIFO_BYPASS_value
    Private read_FIFO_BYPASS_value
    Private flag_FIFO_BYPASS
    Private write_GMII_FIFO_Elasticity_Mode_value
    Private read_GMII_FIFO_Elasticity_Mode_value
    Private flag_GMII_FIFO_Elasticity_Mode

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

    Property Get get_FIFO_BYPASS
        get_FIFO_BYPASS = read_FIFO_BYPASS_value
    End Property

    Property Let set_FIFO_BYPASS(aData)
        write_FIFO_BYPASS_value = aData
        flag_FIFO_BYPASS        = &H1
    End Property

    Property Get read_FIFO_BYPASS
        read
        read_FIFO_BYPASS = read_FIFO_BYPASS_value
    End Property

    Property Let write_FIFO_BYPASS(aData)
        set_FIFO_BYPASS = aData
        write
    End Property

    Property Get get_GMII_FIFO_Elasticity_Mode
        get_GMII_FIFO_Elasticity_Mode = read_GMII_FIFO_Elasticity_Mode_value
    End Property

    Property Let set_GMII_FIFO_Elasticity_Mode(aData)
        write_GMII_FIFO_Elasticity_Mode_value = aData
        flag_GMII_FIFO_Elasticity_Mode        = &H1
    End Property

    Property Get read_GMII_FIFO_Elasticity_Mode
        read
        read_GMII_FIFO_Elasticity_Mode = read_GMII_FIFO_Elasticity_Mode_value
    End Property

    Property Let write_GMII_FIFO_Elasticity_Mode(aData)
        set_GMII_FIFO_Elasticity_Mode = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_FIFO_BYPASS_value = rightShift(data_low, 2) and &H1
        GMII_FIFO_Elasticity_Mode_mask = &H3
        if data_low > LONG_MAX then
            if GMII_FIFO_Elasticity_Mode_mask = mask then
                read_GMII_FIFO_Elasticity_Mode_value = data_low
            else
                read_GMII_FIFO_Elasticity_Mode_value = (data_low - H8000_0000) and GMII_FIFO_Elasticity_Mode_mask
            end If
        else
            read_GMII_FIFO_Elasticity_Mode_value = data_low and GMII_FIFO_Elasticity_Mode_mask
        end If

    End Sub

    Sub write
        If flag_FIFO_BYPASS = &H0 or flag_GMII_FIFO_Elasticity_Mode = &H0 Then read
        If flag_FIFO_BYPASS = &H0 Then write_FIFO_BYPASS_value = get_FIFO_BYPASS
        If flag_GMII_FIFO_Elasticity_Mode = &H0 Then write_GMII_FIFO_Elasticity_Mode_value = get_GMII_FIFO_Elasticity_Mode

        regValue = leftShift((write_FIFO_BYPASS_value and &H1), 2) + leftShift((write_GMII_FIFO_Elasticity_Mode_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_FIFO_BYPASS_value = rightShift(data_low, 2) and &H1
        GMII_FIFO_Elasticity_Mode_mask = &H3
        if data_low > LONG_MAX then
            if GMII_FIFO_Elasticity_Mode_mask = mask then
                read_GMII_FIFO_Elasticity_Mode_value = data_low
            else
                read_GMII_FIFO_Elasticity_Mode_value = (data_low - H8000_0000) and GMII_FIFO_Elasticity_Mode_mask
            end If
        else
            read_GMII_FIFO_Elasticity_Mode_value = data_low and GMII_FIFO_Elasticity_Mode_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_FIFO_BYPASS_value = &H0
        flag_FIFO_BYPASS        = &H0
        write_GMII_FIFO_Elasticity_Mode_value = &H0
        flag_GMII_FIFO_Elasticity_Mode        = &H0
    End Sub
End Class


'' @REGISTER : BR_GPCS_data_sw_pfc_offset0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DataSwPFC24_offset0                        [15:0]           get_DataSwPFC24_offset0
''                                                             set_DataSwPFC24_offset0
''                                                             read_DataSwPFC24_offset0
''                                                             write_DataSwPFC24_offset0
''---------------------------------------------------------------------------------
Class REGISTER_BR_GPCS_data_sw_pfc_offset0
    Private write_DataSwPFC24_offset0_value
    Private read_DataSwPFC24_offset0_value
    Private flag_DataSwPFC24_offset0

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

    Property Get get_DataSwPFC24_offset0
        get_DataSwPFC24_offset0 = read_DataSwPFC24_offset0_value
    End Property

    Property Let set_DataSwPFC24_offset0(aData)
        write_DataSwPFC24_offset0_value = aData
        flag_DataSwPFC24_offset0        = &H1
    End Property

    Property Get read_DataSwPFC24_offset0
        read
        read_DataSwPFC24_offset0 = read_DataSwPFC24_offset0_value
    End Property

    Property Let write_DataSwPFC24_offset0(aData)
        set_DataSwPFC24_offset0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DataSwPFC24_offset0_mask = &Hffff
        if data_low > LONG_MAX then
            if DataSwPFC24_offset0_mask = mask then
                read_DataSwPFC24_offset0_value = data_low
            else
                read_DataSwPFC24_offset0_value = (data_low - H8000_0000) and DataSwPFC24_offset0_mask
            end If
        else
            read_DataSwPFC24_offset0_value = data_low and DataSwPFC24_offset0_mask
        end If

    End Sub

    Sub write
        If flag_DataSwPFC24_offset0 = &H0 Then read
        If flag_DataSwPFC24_offset0 = &H0 Then write_DataSwPFC24_offset0_value = get_DataSwPFC24_offset0

        regValue = leftShift((write_DataSwPFC24_offset0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DataSwPFC24_offset0_mask = &Hffff
        if data_low > LONG_MAX then
            if DataSwPFC24_offset0_mask = mask then
                read_DataSwPFC24_offset0_value = data_low
            else
                read_DataSwPFC24_offset0_value = (data_low - H8000_0000) and DataSwPFC24_offset0_mask
            end If
        else
            read_DataSwPFC24_offset0_value = data_low and DataSwPFC24_offset0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DataSwPFC24_offset0_value = &H0
        flag_DataSwPFC24_offset0        = &H0
    End Sub
End Class


'' @REGISTER : BR_GPCS_data_sw_pfc_offset1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DataSwPFC24_offset_ov                      [8:8]            get_DataSwPFC24_offset_ov
''                                                             set_DataSwPFC24_offset_ov
''                                                             read_DataSwPFC24_offset_ov
''                                                             write_DataSwPFC24_offset_ov
''---------------------------------------------------------------------------------
'' DataSwPFC24_offset1                        [7:0]            get_DataSwPFC24_offset1
''                                                             set_DataSwPFC24_offset1
''                                                             read_DataSwPFC24_offset1
''                                                             write_DataSwPFC24_offset1
''---------------------------------------------------------------------------------
Class REGISTER_BR_GPCS_data_sw_pfc_offset1
    Private write_DataSwPFC24_offset_ov_value
    Private read_DataSwPFC24_offset_ov_value
    Private flag_DataSwPFC24_offset_ov
    Private write_DataSwPFC24_offset1_value
    Private read_DataSwPFC24_offset1_value
    Private flag_DataSwPFC24_offset1

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

    Property Get get_DataSwPFC24_offset_ov
        get_DataSwPFC24_offset_ov = read_DataSwPFC24_offset_ov_value
    End Property

    Property Let set_DataSwPFC24_offset_ov(aData)
        write_DataSwPFC24_offset_ov_value = aData
        flag_DataSwPFC24_offset_ov        = &H1
    End Property

    Property Get read_DataSwPFC24_offset_ov
        read
        read_DataSwPFC24_offset_ov = read_DataSwPFC24_offset_ov_value
    End Property

    Property Let write_DataSwPFC24_offset_ov(aData)
        set_DataSwPFC24_offset_ov = aData
        write
    End Property

    Property Get get_DataSwPFC24_offset1
        get_DataSwPFC24_offset1 = read_DataSwPFC24_offset1_value
    End Property

    Property Let set_DataSwPFC24_offset1(aData)
        write_DataSwPFC24_offset1_value = aData
        flag_DataSwPFC24_offset1        = &H1
    End Property

    Property Get read_DataSwPFC24_offset1
        read
        read_DataSwPFC24_offset1 = read_DataSwPFC24_offset1_value
    End Property

    Property Let write_DataSwPFC24_offset1(aData)
        set_DataSwPFC24_offset1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_DataSwPFC24_offset_ov_value = rightShift(data_low, 8) and &H1
        DataSwPFC24_offset1_mask = &Hff
        if data_low > LONG_MAX then
            if DataSwPFC24_offset1_mask = mask then
                read_DataSwPFC24_offset1_value = data_low
            else
                read_DataSwPFC24_offset1_value = (data_low - H8000_0000) and DataSwPFC24_offset1_mask
            end If
        else
            read_DataSwPFC24_offset1_value = data_low and DataSwPFC24_offset1_mask
        end If

    End Sub

    Sub write
        If flag_DataSwPFC24_offset_ov = &H0 or flag_DataSwPFC24_offset1 = &H0 Then read
        If flag_DataSwPFC24_offset_ov = &H0 Then write_DataSwPFC24_offset_ov_value = get_DataSwPFC24_offset_ov
        If flag_DataSwPFC24_offset1 = &H0 Then write_DataSwPFC24_offset1_value = get_DataSwPFC24_offset1

        regValue = leftShift((write_DataSwPFC24_offset_ov_value and &H1), 8) + leftShift((write_DataSwPFC24_offset1_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_DataSwPFC24_offset_ov_value = rightShift(data_low, 8) and &H1
        DataSwPFC24_offset1_mask = &Hff
        if data_low > LONG_MAX then
            if DataSwPFC24_offset1_mask = mask then
                read_DataSwPFC24_offset1_value = data_low
            else
                read_DataSwPFC24_offset1_value = (data_low - H8000_0000) and DataSwPFC24_offset1_mask
            end If
        else
            read_DataSwPFC24_offset1_value = data_low and DataSwPFC24_offset1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DataSwPFC24_offset_ov_value = &H0
        flag_DataSwPFC24_offset_ov        = &H0
        write_DataSwPFC24_offset1_value = &H0
        flag_DataSwPFC24_offset1        = &H0
    End Sub
End Class


'' @REGISTER : BR_GPCS_scrambler_ctl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Invert_TX_Polarity                         [4:4]            get_Invert_TX_Polarity
''                                                             set_Invert_TX_Polarity
''                                                             read_Invert_TX_Polarity
''                                                             write_Invert_TX_Polarity
''---------------------------------------------------------------------------------
'' bypass_data_scrambler                      [3:3]            get_bypass_data_scrambler
''                                                             set_bypass_data_scrambler
''                                                             read_bypass_data_scrambler
''                                                             write_bypass_data_scrambler
''---------------------------------------------------------------------------------
'' bypass_descrambler                         [2:2]            get_bypass_descrambler
''                                                             set_bypass_descrambler
''                                                             read_bypass_descrambler
''                                                             write_bypass_descrambler
''---------------------------------------------------------------------------------
'' bypass_training_scrambler                  [1:1]            get_bypass_training_scrambler
''                                                             set_bypass_training_scrambler
''                                                             read_bypass_training_scrambler
''                                                             write_bypass_training_scrambler
''---------------------------------------------------------------------------------
'' bypass_training_descrambler                [0:0]            get_bypass_training_descrambler
''                                                             set_bypass_training_descrambler
''                                                             read_bypass_training_descrambler
''                                                             write_bypass_training_descrambler
''---------------------------------------------------------------------------------
Class REGISTER_BR_GPCS_scrambler_ctl
    Private write_Invert_TX_Polarity_value
    Private read_Invert_TX_Polarity_value
    Private flag_Invert_TX_Polarity
    Private write_bypass_data_scrambler_value
    Private read_bypass_data_scrambler_value
    Private flag_bypass_data_scrambler
    Private write_bypass_descrambler_value
    Private read_bypass_descrambler_value
    Private flag_bypass_descrambler
    Private write_bypass_training_scrambler_value
    Private read_bypass_training_scrambler_value
    Private flag_bypass_training_scrambler
    Private write_bypass_training_descrambler_value
    Private read_bypass_training_descrambler_value
    Private flag_bypass_training_descrambler

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

    Property Get get_Invert_TX_Polarity
        get_Invert_TX_Polarity = read_Invert_TX_Polarity_value
    End Property

    Property Let set_Invert_TX_Polarity(aData)
        write_Invert_TX_Polarity_value = aData
        flag_Invert_TX_Polarity        = &H1
    End Property

    Property Get read_Invert_TX_Polarity
        read
        read_Invert_TX_Polarity = read_Invert_TX_Polarity_value
    End Property

    Property Let write_Invert_TX_Polarity(aData)
        set_Invert_TX_Polarity = aData
        write
    End Property

    Property Get get_bypass_data_scrambler
        get_bypass_data_scrambler = read_bypass_data_scrambler_value
    End Property

    Property Let set_bypass_data_scrambler(aData)
        write_bypass_data_scrambler_value = aData
        flag_bypass_data_scrambler        = &H1
    End Property

    Property Get read_bypass_data_scrambler
        read
        read_bypass_data_scrambler = read_bypass_data_scrambler_value
    End Property

    Property Let write_bypass_data_scrambler(aData)
        set_bypass_data_scrambler = aData
        write
    End Property

    Property Get get_bypass_descrambler
        get_bypass_descrambler = read_bypass_descrambler_value
    End Property

    Property Let set_bypass_descrambler(aData)
        write_bypass_descrambler_value = aData
        flag_bypass_descrambler        = &H1
    End Property

    Property Get read_bypass_descrambler
        read
        read_bypass_descrambler = read_bypass_descrambler_value
    End Property

    Property Let write_bypass_descrambler(aData)
        set_bypass_descrambler = aData
        write
    End Property

    Property Get get_bypass_training_scrambler
        get_bypass_training_scrambler = read_bypass_training_scrambler_value
    End Property

    Property Let set_bypass_training_scrambler(aData)
        write_bypass_training_scrambler_value = aData
        flag_bypass_training_scrambler        = &H1
    End Property

    Property Get read_bypass_training_scrambler
        read
        read_bypass_training_scrambler = read_bypass_training_scrambler_value
    End Property

    Property Let write_bypass_training_scrambler(aData)
        set_bypass_training_scrambler = aData
        write
    End Property

    Property Get get_bypass_training_descrambler
        get_bypass_training_descrambler = read_bypass_training_descrambler_value
    End Property

    Property Let set_bypass_training_descrambler(aData)
        write_bypass_training_descrambler_value = aData
        flag_bypass_training_descrambler        = &H1
    End Property

    Property Get read_bypass_training_descrambler
        read
        read_bypass_training_descrambler = read_bypass_training_descrambler_value
    End Property

    Property Let write_bypass_training_descrambler(aData)
        set_bypass_training_descrambler = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Invert_TX_Polarity_value = rightShift(data_low, 4) and &H1
        read_bypass_data_scrambler_value = rightShift(data_low, 3) and &H1
        read_bypass_descrambler_value = rightShift(data_low, 2) and &H1
        read_bypass_training_scrambler_value = rightShift(data_low, 1) and &H1
        bypass_training_descrambler_mask = &H1
        if data_low > LONG_MAX then
            if bypass_training_descrambler_mask = mask then
                read_bypass_training_descrambler_value = data_low
            else
                read_bypass_training_descrambler_value = (data_low - H8000_0000) and bypass_training_descrambler_mask
            end If
        else
            read_bypass_training_descrambler_value = data_low and bypass_training_descrambler_mask
        end If

    End Sub

    Sub write
        If flag_Invert_TX_Polarity = &H0 or flag_bypass_data_scrambler = &H0 or flag_bypass_descrambler = &H0 or flag_bypass_training_scrambler = &H0 or flag_bypass_training_descrambler = &H0 Then read
        If flag_Invert_TX_Polarity = &H0 Then write_Invert_TX_Polarity_value = get_Invert_TX_Polarity
        If flag_bypass_data_scrambler = &H0 Then write_bypass_data_scrambler_value = get_bypass_data_scrambler
        If flag_bypass_descrambler = &H0 Then write_bypass_descrambler_value = get_bypass_descrambler
        If flag_bypass_training_scrambler = &H0 Then write_bypass_training_scrambler_value = get_bypass_training_scrambler
        If flag_bypass_training_descrambler = &H0 Then write_bypass_training_descrambler_value = get_bypass_training_descrambler

        regValue = leftShift((write_Invert_TX_Polarity_value and &H1), 4) + leftShift((write_bypass_data_scrambler_value and &H1), 3) + leftShift((write_bypass_descrambler_value and &H1), 2) + leftShift((write_bypass_training_scrambler_value and &H1), 1) + leftShift((write_bypass_training_descrambler_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Invert_TX_Polarity_value = rightShift(data_low, 4) and &H1
        read_bypass_data_scrambler_value = rightShift(data_low, 3) and &H1
        read_bypass_descrambler_value = rightShift(data_low, 2) and &H1
        read_bypass_training_scrambler_value = rightShift(data_low, 1) and &H1
        bypass_training_descrambler_mask = &H1
        if data_low > LONG_MAX then
            if bypass_training_descrambler_mask = mask then
                read_bypass_training_descrambler_value = data_low
            else
                read_bypass_training_descrambler_value = (data_low - H8000_0000) and bypass_training_descrambler_mask
            end If
        else
            read_bypass_training_descrambler_value = data_low and bypass_training_descrambler_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Invert_TX_Polarity_value = &H0
        flag_Invert_TX_Polarity        = &H0
        write_bypass_data_scrambler_value = &H0
        flag_bypass_data_scrambler        = &H0
        write_bypass_descrambler_value = &H0
        flag_bypass_descrambler        = &H0
        write_bypass_training_scrambler_value = &H0
        flag_bypass_training_scrambler        = &H0
        write_bypass_training_descrambler_value = &H0
        flag_bypass_training_descrambler        = &H0
    End Sub
End Class


'' @REGISTER : BR_GPCS_txpcs_seed_ctl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' txpcs_seed_set                             [15:15]          get_txpcs_seed_set
''                                                             set_txpcs_seed_set
''                                                             read_txpcs_seed_set
''                                                             write_txpcs_seed_set
''---------------------------------------------------------------------------------
'' txpcs_scrambler_seed_for_data_mode         [14:0]           get_txpcs_scrambler_seed_for_data_mode
''                                                             set_txpcs_scrambler_seed_for_data_mode
''                                                             read_txpcs_scrambler_seed_for_data_mode
''                                                             write_txpcs_scrambler_seed_for_data_mode
''---------------------------------------------------------------------------------
Class REGISTER_BR_GPCS_txpcs_seed_ctl
    Private write_txpcs_seed_set_value
    Private read_txpcs_seed_set_value
    Private flag_txpcs_seed_set
    Private write_txpcs_scrambler_seed_for_data_mode_value
    Private read_txpcs_scrambler_seed_for_data_mode_value
    Private flag_txpcs_scrambler_seed_for_data_mode

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

    Property Get get_txpcs_seed_set
        get_txpcs_seed_set = read_txpcs_seed_set_value
    End Property

    Property Let set_txpcs_seed_set(aData)
        write_txpcs_seed_set_value = aData
        flag_txpcs_seed_set        = &H1
    End Property

    Property Get read_txpcs_seed_set
        read
        read_txpcs_seed_set = read_txpcs_seed_set_value
    End Property

    Property Let write_txpcs_seed_set(aData)
        set_txpcs_seed_set = aData
        write
    End Property

    Property Get get_txpcs_scrambler_seed_for_data_mode
        get_txpcs_scrambler_seed_for_data_mode = read_txpcs_scrambler_seed_for_data_mode_value
    End Property

    Property Let set_txpcs_scrambler_seed_for_data_mode(aData)
        write_txpcs_scrambler_seed_for_data_mode_value = aData
        flag_txpcs_scrambler_seed_for_data_mode        = &H1
    End Property

    Property Get read_txpcs_scrambler_seed_for_data_mode
        read
        read_txpcs_scrambler_seed_for_data_mode = read_txpcs_scrambler_seed_for_data_mode_value
    End Property

    Property Let write_txpcs_scrambler_seed_for_data_mode(aData)
        set_txpcs_scrambler_seed_for_data_mode = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_txpcs_seed_set_value = rightShift(data_low, 15) and &H1
        txpcs_scrambler_seed_for_data_mode_mask = &H7fff
        if data_low > LONG_MAX then
            if txpcs_scrambler_seed_for_data_mode_mask = mask then
                read_txpcs_scrambler_seed_for_data_mode_value = data_low
            else
                read_txpcs_scrambler_seed_for_data_mode_value = (data_low - H8000_0000) and txpcs_scrambler_seed_for_data_mode_mask
            end If
        else
            read_txpcs_scrambler_seed_for_data_mode_value = data_low and txpcs_scrambler_seed_for_data_mode_mask
        end If

    End Sub

    Sub write
        If flag_txpcs_seed_set = &H0 or flag_txpcs_scrambler_seed_for_data_mode = &H0 Then read
        If flag_txpcs_seed_set = &H0 Then write_txpcs_seed_set_value = get_txpcs_seed_set
        If flag_txpcs_scrambler_seed_for_data_mode = &H0 Then write_txpcs_scrambler_seed_for_data_mode_value = get_txpcs_scrambler_seed_for_data_mode

        regValue = leftShift((write_txpcs_seed_set_value and &H1), 15) + leftShift((write_txpcs_scrambler_seed_for_data_mode_value and &H7fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_txpcs_seed_set_value = rightShift(data_low, 15) and &H1
        txpcs_scrambler_seed_for_data_mode_mask = &H7fff
        if data_low > LONG_MAX then
            if txpcs_scrambler_seed_for_data_mode_mask = mask then
                read_txpcs_scrambler_seed_for_data_mode_value = data_low
            else
                read_txpcs_scrambler_seed_for_data_mode_value = (data_low - H8000_0000) and txpcs_scrambler_seed_for_data_mode_mask
            end If
        else
            read_txpcs_scrambler_seed_for_data_mode_value = data_low and txpcs_scrambler_seed_for_data_mode_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_txpcs_seed_set_value = &H0
        flag_txpcs_seed_set        = &H0
        write_txpcs_scrambler_seed_for_data_mode_value = &H0
        flag_txpcs_scrambler_seed_for_data_mode        = &H0
    End Sub
End Class


'' @REGISTER : BR_GPCS_pam3_ctl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pam3_125_wait_override_at_txclk125         [12:12]          get_pam3_125_wait_override_at_txclk125
''                                                             set_pam3_125_wait_override_at_txclk125
''                                                             read_pam3_125_wait_override_at_txclk125
''                                                             write_pam3_125_wait_override_at_txclk125
''---------------------------------------------------------------------------------
'' CP3SPWCAT125                               [11:3]           get_CP3SPWCAT125
''                                                             set_CP3SPWCAT125
''                                                             read_CP3SPWCAT125
''                                                             write_CP3SPWCAT125
''---------------------------------------------------------------------------------
'' pam3_375_dly_override_at_txclk375          [2:2]            get_pam3_375_dly_override_at_txclk375
''                                                             set_pam3_375_dly_override_at_txclk375
''                                                             read_pam3_375_dly_override_at_txclk375
''                                                             write_pam3_375_dly_override_at_txclk375
''---------------------------------------------------------------------------------
'' PP3DCAT375                                 [1:0]            get_PP3DCAT375
''                                                             set_PP3DCAT375
''                                                             read_PP3DCAT375
''                                                             write_PP3DCAT375
''---------------------------------------------------------------------------------
Class REGISTER_BR_GPCS_pam3_ctl
    Private write_pam3_125_wait_override_at_txclk125_value
    Private read_pam3_125_wait_override_at_txclk125_value
    Private flag_pam3_125_wait_override_at_txclk125
    Private write_CP3SPWCAT125_value
    Private read_CP3SPWCAT125_value
    Private flag_CP3SPWCAT125
    Private write_pam3_375_dly_override_at_txclk375_value
    Private read_pam3_375_dly_override_at_txclk375_value
    Private flag_pam3_375_dly_override_at_txclk375
    Private write_PP3DCAT375_value
    Private read_PP3DCAT375_value
    Private flag_PP3DCAT375

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

    Property Get get_pam3_125_wait_override_at_txclk125
        get_pam3_125_wait_override_at_txclk125 = read_pam3_125_wait_override_at_txclk125_value
    End Property

    Property Let set_pam3_125_wait_override_at_txclk125(aData)
        write_pam3_125_wait_override_at_txclk125_value = aData
        flag_pam3_125_wait_override_at_txclk125        = &H1
    End Property

    Property Get read_pam3_125_wait_override_at_txclk125
        read
        read_pam3_125_wait_override_at_txclk125 = read_pam3_125_wait_override_at_txclk125_value
    End Property

    Property Let write_pam3_125_wait_override_at_txclk125(aData)
        set_pam3_125_wait_override_at_txclk125 = aData
        write
    End Property

    Property Get get_CP3SPWCAT125
        get_CP3SPWCAT125 = read_CP3SPWCAT125_value
    End Property

    Property Let set_CP3SPWCAT125(aData)
        write_CP3SPWCAT125_value = aData
        flag_CP3SPWCAT125        = &H1
    End Property

    Property Get read_CP3SPWCAT125
        read
        read_CP3SPWCAT125 = read_CP3SPWCAT125_value
    End Property

    Property Let write_CP3SPWCAT125(aData)
        set_CP3SPWCAT125 = aData
        write
    End Property

    Property Get get_pam3_375_dly_override_at_txclk375
        get_pam3_375_dly_override_at_txclk375 = read_pam3_375_dly_override_at_txclk375_value
    End Property

    Property Let set_pam3_375_dly_override_at_txclk375(aData)
        write_pam3_375_dly_override_at_txclk375_value = aData
        flag_pam3_375_dly_override_at_txclk375        = &H1
    End Property

    Property Get read_pam3_375_dly_override_at_txclk375
        read
        read_pam3_375_dly_override_at_txclk375 = read_pam3_375_dly_override_at_txclk375_value
    End Property

    Property Let write_pam3_375_dly_override_at_txclk375(aData)
        set_pam3_375_dly_override_at_txclk375 = aData
        write
    End Property

    Property Get get_PP3DCAT375
        get_PP3DCAT375 = read_PP3DCAT375_value
    End Property

    Property Let set_PP3DCAT375(aData)
        write_PP3DCAT375_value = aData
        flag_PP3DCAT375        = &H1
    End Property

    Property Get read_PP3DCAT375
        read
        read_PP3DCAT375 = read_PP3DCAT375_value
    End Property

    Property Let write_PP3DCAT375(aData)
        set_PP3DCAT375 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_pam3_125_wait_override_at_txclk125_value = rightShift(data_low, 12) and &H1
        read_CP3SPWCAT125_value = rightShift(data_low, 3) and &H1ff
        read_pam3_375_dly_override_at_txclk375_value = rightShift(data_low, 2) and &H1
        PP3DCAT375_mask = &H3
        if data_low > LONG_MAX then
            if PP3DCAT375_mask = mask then
                read_PP3DCAT375_value = data_low
            else
                read_PP3DCAT375_value = (data_low - H8000_0000) and PP3DCAT375_mask
            end If
        else
            read_PP3DCAT375_value = data_low and PP3DCAT375_mask
        end If

    End Sub

    Sub write
        If flag_pam3_125_wait_override_at_txclk125 = &H0 or flag_CP3SPWCAT125 = &H0 or flag_pam3_375_dly_override_at_txclk375 = &H0 or flag_PP3DCAT375 = &H0 Then read
        If flag_pam3_125_wait_override_at_txclk125 = &H0 Then write_pam3_125_wait_override_at_txclk125_value = get_pam3_125_wait_override_at_txclk125
        If flag_CP3SPWCAT125 = &H0 Then write_CP3SPWCAT125_value = get_CP3SPWCAT125
        If flag_pam3_375_dly_override_at_txclk375 = &H0 Then write_pam3_375_dly_override_at_txclk375_value = get_pam3_375_dly_override_at_txclk375
        If flag_PP3DCAT375 = &H0 Then write_PP3DCAT375_value = get_PP3DCAT375

        regValue = leftShift((write_pam3_125_wait_override_at_txclk125_value and &H1), 12) + leftShift((write_CP3SPWCAT125_value and &H1ff), 3) + leftShift((write_pam3_375_dly_override_at_txclk375_value and &H1), 2) + leftShift((write_PP3DCAT375_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_pam3_125_wait_override_at_txclk125_value = rightShift(data_low, 12) and &H1
        read_CP3SPWCAT125_value = rightShift(data_low, 3) and &H1ff
        read_pam3_375_dly_override_at_txclk375_value = rightShift(data_low, 2) and &H1
        PP3DCAT375_mask = &H3
        if data_low > LONG_MAX then
            if PP3DCAT375_mask = mask then
                read_PP3DCAT375_value = data_low
            else
                read_PP3DCAT375_value = (data_low - H8000_0000) and PP3DCAT375_mask
            end If
        else
            read_PP3DCAT375_value = data_low and PP3DCAT375_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pam3_125_wait_override_at_txclk125_value = &H0
        flag_pam3_125_wait_override_at_txclk125        = &H0
        write_CP3SPWCAT125_value = &H0
        flag_CP3SPWCAT125        = &H0
        write_pam3_375_dly_override_at_txclk375_value = &H0
        flag_pam3_375_dly_override_at_txclk375        = &H0
        write_PP3DCAT375_value = &H0
        flag_PP3DCAT375        = &H0
    End Sub
End Class


'' @REGISTER : BR_GPCS_oam_ctl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rx_oamcrc_byp                              [4:4]            get_rx_oamcrc_byp
''                                                             set_rx_oamcrc_byp
''                                                             read_rx_oamcrc_byp
''                                                             write_rx_oamcrc_byp
''---------------------------------------------------------------------------------
'' rx_fecerr_byp                              [3:3]            get_rx_fecerr_byp
''                                                             set_rx_fecerr_byp
''                                                             read_rx_fecerr_byp
''                                                             write_rx_fecerr_byp
''---------------------------------------------------------------------------------
'' rx_parity_err_byp                          [2:2]            get_rx_parity_err_byp
''                                                             set_rx_parity_err_byp
''                                                             read_rx_parity_err_byp
''                                                             write_rx_parity_err_byp
''---------------------------------------------------------------------------------
'' tx_oamsym_swap                             [1:1]            get_tx_oamsym_swap
''                                                             set_tx_oamsym_swap
''                                                             read_tx_oamsym_swap
''                                                             write_tx_oamsym_swap
''---------------------------------------------------------------------------------
'' rx_oamsym_swap                             [0:0]            get_rx_oamsym_swap
''                                                             set_rx_oamsym_swap
''                                                             read_rx_oamsym_swap
''                                                             write_rx_oamsym_swap
''---------------------------------------------------------------------------------
Class REGISTER_BR_GPCS_oam_ctl
    Private write_rx_oamcrc_byp_value
    Private read_rx_oamcrc_byp_value
    Private flag_rx_oamcrc_byp
    Private write_rx_fecerr_byp_value
    Private read_rx_fecerr_byp_value
    Private flag_rx_fecerr_byp
    Private write_rx_parity_err_byp_value
    Private read_rx_parity_err_byp_value
    Private flag_rx_parity_err_byp
    Private write_tx_oamsym_swap_value
    Private read_tx_oamsym_swap_value
    Private flag_tx_oamsym_swap
    Private write_rx_oamsym_swap_value
    Private read_rx_oamsym_swap_value
    Private flag_rx_oamsym_swap

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

    Property Get get_rx_oamcrc_byp
        get_rx_oamcrc_byp = read_rx_oamcrc_byp_value
    End Property

    Property Let set_rx_oamcrc_byp(aData)
        write_rx_oamcrc_byp_value = aData
        flag_rx_oamcrc_byp        = &H1
    End Property

    Property Get read_rx_oamcrc_byp
        read
        read_rx_oamcrc_byp = read_rx_oamcrc_byp_value
    End Property

    Property Let write_rx_oamcrc_byp(aData)
        set_rx_oamcrc_byp = aData
        write
    End Property

    Property Get get_rx_fecerr_byp
        get_rx_fecerr_byp = read_rx_fecerr_byp_value
    End Property

    Property Let set_rx_fecerr_byp(aData)
        write_rx_fecerr_byp_value = aData
        flag_rx_fecerr_byp        = &H1
    End Property

    Property Get read_rx_fecerr_byp
        read
        read_rx_fecerr_byp = read_rx_fecerr_byp_value
    End Property

    Property Let write_rx_fecerr_byp(aData)
        set_rx_fecerr_byp = aData
        write
    End Property

    Property Get get_rx_parity_err_byp
        get_rx_parity_err_byp = read_rx_parity_err_byp_value
    End Property

    Property Let set_rx_parity_err_byp(aData)
        write_rx_parity_err_byp_value = aData
        flag_rx_parity_err_byp        = &H1
    End Property

    Property Get read_rx_parity_err_byp
        read
        read_rx_parity_err_byp = read_rx_parity_err_byp_value
    End Property

    Property Let write_rx_parity_err_byp(aData)
        set_rx_parity_err_byp = aData
        write
    End Property

    Property Get get_tx_oamsym_swap
        get_tx_oamsym_swap = read_tx_oamsym_swap_value
    End Property

    Property Let set_tx_oamsym_swap(aData)
        write_tx_oamsym_swap_value = aData
        flag_tx_oamsym_swap        = &H1
    End Property

    Property Get read_tx_oamsym_swap
        read
        read_tx_oamsym_swap = read_tx_oamsym_swap_value
    End Property

    Property Let write_tx_oamsym_swap(aData)
        set_tx_oamsym_swap = aData
        write
    End Property

    Property Get get_rx_oamsym_swap
        get_rx_oamsym_swap = read_rx_oamsym_swap_value
    End Property

    Property Let set_rx_oamsym_swap(aData)
        write_rx_oamsym_swap_value = aData
        flag_rx_oamsym_swap        = &H1
    End Property

    Property Get read_rx_oamsym_swap
        read
        read_rx_oamsym_swap = read_rx_oamsym_swap_value
    End Property

    Property Let write_rx_oamsym_swap(aData)
        set_rx_oamsym_swap = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rx_oamcrc_byp_value = rightShift(data_low, 4) and &H1
        read_rx_fecerr_byp_value = rightShift(data_low, 3) and &H1
        read_rx_parity_err_byp_value = rightShift(data_low, 2) and &H1
        read_tx_oamsym_swap_value = rightShift(data_low, 1) and &H1
        rx_oamsym_swap_mask = &H1
        if data_low > LONG_MAX then
            if rx_oamsym_swap_mask = mask then
                read_rx_oamsym_swap_value = data_low
            else
                read_rx_oamsym_swap_value = (data_low - H8000_0000) and rx_oamsym_swap_mask
            end If
        else
            read_rx_oamsym_swap_value = data_low and rx_oamsym_swap_mask
        end If

    End Sub

    Sub write
        If flag_rx_oamcrc_byp = &H0 or flag_rx_fecerr_byp = &H0 or flag_rx_parity_err_byp = &H0 or flag_tx_oamsym_swap = &H0 or flag_rx_oamsym_swap = &H0 Then read
        If flag_rx_oamcrc_byp = &H0 Then write_rx_oamcrc_byp_value = get_rx_oamcrc_byp
        If flag_rx_fecerr_byp = &H0 Then write_rx_fecerr_byp_value = get_rx_fecerr_byp
        If flag_rx_parity_err_byp = &H0 Then write_rx_parity_err_byp_value = get_rx_parity_err_byp
        If flag_tx_oamsym_swap = &H0 Then write_tx_oamsym_swap_value = get_tx_oamsym_swap
        If flag_rx_oamsym_swap = &H0 Then write_rx_oamsym_swap_value = get_rx_oamsym_swap

        regValue = leftShift((write_rx_oamcrc_byp_value and &H1), 4) + leftShift((write_rx_fecerr_byp_value and &H1), 3) + leftShift((write_rx_parity_err_byp_value and &H1), 2) + leftShift((write_tx_oamsym_swap_value and &H1), 1) + leftShift((write_rx_oamsym_swap_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rx_oamcrc_byp_value = rightShift(data_low, 4) and &H1
        read_rx_fecerr_byp_value = rightShift(data_low, 3) and &H1
        read_rx_parity_err_byp_value = rightShift(data_low, 2) and &H1
        read_tx_oamsym_swap_value = rightShift(data_low, 1) and &H1
        rx_oamsym_swap_mask = &H1
        if data_low > LONG_MAX then
            if rx_oamsym_swap_mask = mask then
                read_rx_oamsym_swap_value = data_low
            else
                read_rx_oamsym_swap_value = (data_low - H8000_0000) and rx_oamsym_swap_mask
            end If
        else
            read_rx_oamsym_swap_value = data_low and rx_oamsym_swap_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rx_oamcrc_byp_value = &H0
        flag_rx_oamcrc_byp        = &H0
        write_rx_fecerr_byp_value = &H0
        flag_rx_fecerr_byp        = &H0
        write_rx_parity_err_byp_value = &H0
        flag_rx_parity_err_byp        = &H0
        write_tx_oamsym_swap_value = &H0
        flag_tx_oamsym_swap        = &H0
        write_rx_oamsym_swap_value = &H0
        flag_rx_oamsym_swap        = &H0
    End Sub
End Class


'' @REGISTER : BR_GPCS_oam_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' oam_sym_par_disord                         [3:3]            get_oam_sym_par_disord
''                                                             set_oam_sym_par_disord
''                                                             read_oam_sym_par_disord
''                                                             write_oam_sym_par_disord
''---------------------------------------------------------------------------------
'' oam_incorrect_parity                       [2:2]            get_oam_incorrect_parity
''                                                             set_oam_incorrect_parity
''                                                             read_oam_incorrect_parity
''                                                             write_oam_incorrect_parity
''---------------------------------------------------------------------------------
'' dec_out_err                                [1:1]            get_dec_out_err
''                                                             set_dec_out_err
''                                                             read_dec_out_err
''                                                             write_dec_out_err
''---------------------------------------------------------------------------------
'' oam_frame_crc_status                       [0:0]            get_oam_frame_crc_status
''                                                             set_oam_frame_crc_status
''                                                             read_oam_frame_crc_status
''                                                             write_oam_frame_crc_status
''---------------------------------------------------------------------------------
Class REGISTER_BR_GPCS_oam_status
    Private write_oam_sym_par_disord_value
    Private read_oam_sym_par_disord_value
    Private flag_oam_sym_par_disord
    Private write_oam_incorrect_parity_value
    Private read_oam_incorrect_parity_value
    Private flag_oam_incorrect_parity
    Private write_dec_out_err_value
    Private read_dec_out_err_value
    Private flag_dec_out_err
    Private write_oam_frame_crc_status_value
    Private read_oam_frame_crc_status_value
    Private flag_oam_frame_crc_status

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

    Property Get get_oam_sym_par_disord
        get_oam_sym_par_disord = read_oam_sym_par_disord_value
    End Property

    Property Let set_oam_sym_par_disord(aData)
        write_oam_sym_par_disord_value = aData
        flag_oam_sym_par_disord        = &H1
    End Property

    Property Get read_oam_sym_par_disord
        read
        read_oam_sym_par_disord = read_oam_sym_par_disord_value
    End Property

    Property Let write_oam_sym_par_disord(aData)
        set_oam_sym_par_disord = aData
        write
    End Property

    Property Get get_oam_incorrect_parity
        get_oam_incorrect_parity = read_oam_incorrect_parity_value
    End Property

    Property Let set_oam_incorrect_parity(aData)
        write_oam_incorrect_parity_value = aData
        flag_oam_incorrect_parity        = &H1
    End Property

    Property Get read_oam_incorrect_parity
        read
        read_oam_incorrect_parity = read_oam_incorrect_parity_value
    End Property

    Property Let write_oam_incorrect_parity(aData)
        set_oam_incorrect_parity = aData
        write
    End Property

    Property Get get_dec_out_err
        get_dec_out_err = read_dec_out_err_value
    End Property

    Property Let set_dec_out_err(aData)
        write_dec_out_err_value = aData
        flag_dec_out_err        = &H1
    End Property

    Property Get read_dec_out_err
        read
        read_dec_out_err = read_dec_out_err_value
    End Property

    Property Let write_dec_out_err(aData)
        set_dec_out_err = aData
        write
    End Property

    Property Get get_oam_frame_crc_status
        get_oam_frame_crc_status = read_oam_frame_crc_status_value
    End Property

    Property Let set_oam_frame_crc_status(aData)
        write_oam_frame_crc_status_value = aData
        flag_oam_frame_crc_status        = &H1
    End Property

    Property Get read_oam_frame_crc_status
        read
        read_oam_frame_crc_status = read_oam_frame_crc_status_value
    End Property

    Property Let write_oam_frame_crc_status(aData)
        set_oam_frame_crc_status = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_oam_sym_par_disord_value = rightShift(data_low, 3) and &H1
        read_oam_incorrect_parity_value = rightShift(data_low, 2) and &H1
        read_dec_out_err_value = rightShift(data_low, 1) and &H1
        oam_frame_crc_status_mask = &H1
        if data_low > LONG_MAX then
            if oam_frame_crc_status_mask = mask then
                read_oam_frame_crc_status_value = data_low
            else
                read_oam_frame_crc_status_value = (data_low - H8000_0000) and oam_frame_crc_status_mask
            end If
        else
            read_oam_frame_crc_status_value = data_low and oam_frame_crc_status_mask
        end If

    End Sub

    Sub write
        If flag_oam_sym_par_disord = &H0 or flag_oam_incorrect_parity = &H0 or flag_dec_out_err = &H0 or flag_oam_frame_crc_status = &H0 Then read
        If flag_oam_sym_par_disord = &H0 Then write_oam_sym_par_disord_value = get_oam_sym_par_disord
        If flag_oam_incorrect_parity = &H0 Then write_oam_incorrect_parity_value = get_oam_incorrect_parity
        If flag_dec_out_err = &H0 Then write_dec_out_err_value = get_dec_out_err
        If flag_oam_frame_crc_status = &H0 Then write_oam_frame_crc_status_value = get_oam_frame_crc_status

        regValue = leftShift((write_oam_sym_par_disord_value and &H1), 3) + leftShift((write_oam_incorrect_parity_value and &H1), 2) + leftShift((write_dec_out_err_value and &H1), 1) + leftShift((write_oam_frame_crc_status_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_oam_sym_par_disord_value = rightShift(data_low, 3) and &H1
        read_oam_incorrect_parity_value = rightShift(data_low, 2) and &H1
        read_dec_out_err_value = rightShift(data_low, 1) and &H1
        oam_frame_crc_status_mask = &H1
        if data_low > LONG_MAX then
            if oam_frame_crc_status_mask = mask then
                read_oam_frame_crc_status_value = data_low
            else
                read_oam_frame_crc_status_value = (data_low - H8000_0000) and oam_frame_crc_status_mask
            end If
        else
            read_oam_frame_crc_status_value = data_low and oam_frame_crc_status_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_oam_sym_par_disord_value = &H0
        flag_oam_sym_par_disord        = &H0
        write_oam_incorrect_parity_value = &H0
        flag_oam_incorrect_parity        = &H0
        write_dec_out_err_value = &H0
        flag_dec_out_err        = &H0
        write_oam_frame_crc_status_value = &H0
        flag_oam_frame_crc_status        = &H0
    End Sub
End Class


'' @REGISTER : BR_GPCS_rxpcs_seed_ctl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rxpcs_seed_set                             [15:15]          get_rxpcs_seed_set
''                                                             set_rxpcs_seed_set
''                                                             read_rxpcs_seed_set
''                                                             write_rxpcs_seed_set
''---------------------------------------------------------------------------------
'' rxpcs_scrambler_seed_for_data_mode         [14:0]           get_rxpcs_scrambler_seed_for_data_mode
''                                                             set_rxpcs_scrambler_seed_for_data_mode
''                                                             read_rxpcs_scrambler_seed_for_data_mode
''                                                             write_rxpcs_scrambler_seed_for_data_mode
''---------------------------------------------------------------------------------
Class REGISTER_BR_GPCS_rxpcs_seed_ctl
    Private write_rxpcs_seed_set_value
    Private read_rxpcs_seed_set_value
    Private flag_rxpcs_seed_set
    Private write_rxpcs_scrambler_seed_for_data_mode_value
    Private read_rxpcs_scrambler_seed_for_data_mode_value
    Private flag_rxpcs_scrambler_seed_for_data_mode

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

    Property Get get_rxpcs_seed_set
        get_rxpcs_seed_set = read_rxpcs_seed_set_value
    End Property

    Property Let set_rxpcs_seed_set(aData)
        write_rxpcs_seed_set_value = aData
        flag_rxpcs_seed_set        = &H1
    End Property

    Property Get read_rxpcs_seed_set
        read
        read_rxpcs_seed_set = read_rxpcs_seed_set_value
    End Property

    Property Let write_rxpcs_seed_set(aData)
        set_rxpcs_seed_set = aData
        write
    End Property

    Property Get get_rxpcs_scrambler_seed_for_data_mode
        get_rxpcs_scrambler_seed_for_data_mode = read_rxpcs_scrambler_seed_for_data_mode_value
    End Property

    Property Let set_rxpcs_scrambler_seed_for_data_mode(aData)
        write_rxpcs_scrambler_seed_for_data_mode_value = aData
        flag_rxpcs_scrambler_seed_for_data_mode        = &H1
    End Property

    Property Get read_rxpcs_scrambler_seed_for_data_mode
        read
        read_rxpcs_scrambler_seed_for_data_mode = read_rxpcs_scrambler_seed_for_data_mode_value
    End Property

    Property Let write_rxpcs_scrambler_seed_for_data_mode(aData)
        set_rxpcs_scrambler_seed_for_data_mode = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rxpcs_seed_set_value = rightShift(data_low, 15) and &H1
        rxpcs_scrambler_seed_for_data_mode_mask = &H7fff
        if data_low > LONG_MAX then
            if rxpcs_scrambler_seed_for_data_mode_mask = mask then
                read_rxpcs_scrambler_seed_for_data_mode_value = data_low
            else
                read_rxpcs_scrambler_seed_for_data_mode_value = (data_low - H8000_0000) and rxpcs_scrambler_seed_for_data_mode_mask
            end If
        else
            read_rxpcs_scrambler_seed_for_data_mode_value = data_low and rxpcs_scrambler_seed_for_data_mode_mask
        end If

    End Sub

    Sub write
        If flag_rxpcs_seed_set = &H0 or flag_rxpcs_scrambler_seed_for_data_mode = &H0 Then read
        If flag_rxpcs_seed_set = &H0 Then write_rxpcs_seed_set_value = get_rxpcs_seed_set
        If flag_rxpcs_scrambler_seed_for_data_mode = &H0 Then write_rxpcs_scrambler_seed_for_data_mode_value = get_rxpcs_scrambler_seed_for_data_mode

        regValue = leftShift((write_rxpcs_seed_set_value and &H1), 15) + leftShift((write_rxpcs_scrambler_seed_for_data_mode_value and &H7fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rxpcs_seed_set_value = rightShift(data_low, 15) and &H1
        rxpcs_scrambler_seed_for_data_mode_mask = &H7fff
        if data_low > LONG_MAX then
            if rxpcs_scrambler_seed_for_data_mode_mask = mask then
                read_rxpcs_scrambler_seed_for_data_mode_value = data_low
            else
                read_rxpcs_scrambler_seed_for_data_mode_value = (data_low - H8000_0000) and rxpcs_scrambler_seed_for_data_mode_mask
            end If
        else
            read_rxpcs_scrambler_seed_for_data_mode_value = data_low and rxpcs_scrambler_seed_for_data_mode_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rxpcs_seed_set_value = &H0
        flag_rxpcs_seed_set        = &H0
        write_rxpcs_scrambler_seed_for_data_mode_value = &H0
        flag_rxpcs_scrambler_seed_for_data_mode        = &H0
    End Sub
End Class


'' @REGISTER : BR_GPCS_fifo_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' txfifo_udrun_flag                          [7:7]            get_txfifo_udrun_flag
''                                                             set_txfifo_udrun_flag
''                                                             read_txfifo_udrun_flag
''                                                             write_txfifo_udrun_flag
''---------------------------------------------------------------------------------
'' txfifo_empty_flag                          [6:6]            get_txfifo_empty_flag
''                                                             set_txfifo_empty_flag
''                                                             read_txfifo_empty_flag
''                                                             write_txfifo_empty_flag
''---------------------------------------------------------------------------------
'' txfifo_ovrun_flag                          [5:5]            get_txfifo_ovrun_flag
''                                                             set_txfifo_ovrun_flag
''                                                             read_txfifo_ovrun_flag
''                                                             write_txfifo_ovrun_flag
''---------------------------------------------------------------------------------
'' txfifo_full_flag                           [4:4]            get_txfifo_full_flag
''                                                             set_txfifo_full_flag
''                                                             read_txfifo_full_flag
''                                                             write_txfifo_full_flag
''---------------------------------------------------------------------------------
'' rxfifo_udrun_flag                          [3:3]            get_rxfifo_udrun_flag
''                                                             set_rxfifo_udrun_flag
''                                                             read_rxfifo_udrun_flag
''                                                             write_rxfifo_udrun_flag
''---------------------------------------------------------------------------------
'' rxfifo_empty_flag                          [2:2]            get_rxfifo_empty_flag
''                                                             set_rxfifo_empty_flag
''                                                             read_rxfifo_empty_flag
''                                                             write_rxfifo_empty_flag
''---------------------------------------------------------------------------------
'' rxfifo_ovrun_flag                          [1:1]            get_rxfifo_ovrun_flag
''                                                             set_rxfifo_ovrun_flag
''                                                             read_rxfifo_ovrun_flag
''                                                             write_rxfifo_ovrun_flag
''---------------------------------------------------------------------------------
'' rxfifo_full_flag                           [0:0]            get_rxfifo_full_flag
''                                                             set_rxfifo_full_flag
''                                                             read_rxfifo_full_flag
''                                                             write_rxfifo_full_flag
''---------------------------------------------------------------------------------
Class REGISTER_BR_GPCS_fifo_status
    Private write_txfifo_udrun_flag_value
    Private read_txfifo_udrun_flag_value
    Private flag_txfifo_udrun_flag
    Private write_txfifo_empty_flag_value
    Private read_txfifo_empty_flag_value
    Private flag_txfifo_empty_flag
    Private write_txfifo_ovrun_flag_value
    Private read_txfifo_ovrun_flag_value
    Private flag_txfifo_ovrun_flag
    Private write_txfifo_full_flag_value
    Private read_txfifo_full_flag_value
    Private flag_txfifo_full_flag
    Private write_rxfifo_udrun_flag_value
    Private read_rxfifo_udrun_flag_value
    Private flag_rxfifo_udrun_flag
    Private write_rxfifo_empty_flag_value
    Private read_rxfifo_empty_flag_value
    Private flag_rxfifo_empty_flag
    Private write_rxfifo_ovrun_flag_value
    Private read_rxfifo_ovrun_flag_value
    Private flag_rxfifo_ovrun_flag
    Private write_rxfifo_full_flag_value
    Private read_rxfifo_full_flag_value
    Private flag_rxfifo_full_flag

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

    Property Get get_txfifo_udrun_flag
        get_txfifo_udrun_flag = read_txfifo_udrun_flag_value
    End Property

    Property Let set_txfifo_udrun_flag(aData)
        write_txfifo_udrun_flag_value = aData
        flag_txfifo_udrun_flag        = &H1
    End Property

    Property Get read_txfifo_udrun_flag
        read
        read_txfifo_udrun_flag = read_txfifo_udrun_flag_value
    End Property

    Property Let write_txfifo_udrun_flag(aData)
        set_txfifo_udrun_flag = aData
        write
    End Property

    Property Get get_txfifo_empty_flag
        get_txfifo_empty_flag = read_txfifo_empty_flag_value
    End Property

    Property Let set_txfifo_empty_flag(aData)
        write_txfifo_empty_flag_value = aData
        flag_txfifo_empty_flag        = &H1
    End Property

    Property Get read_txfifo_empty_flag
        read
        read_txfifo_empty_flag = read_txfifo_empty_flag_value
    End Property

    Property Let write_txfifo_empty_flag(aData)
        set_txfifo_empty_flag = aData
        write
    End Property

    Property Get get_txfifo_ovrun_flag
        get_txfifo_ovrun_flag = read_txfifo_ovrun_flag_value
    End Property

    Property Let set_txfifo_ovrun_flag(aData)
        write_txfifo_ovrun_flag_value = aData
        flag_txfifo_ovrun_flag        = &H1
    End Property

    Property Get read_txfifo_ovrun_flag
        read
        read_txfifo_ovrun_flag = read_txfifo_ovrun_flag_value
    End Property

    Property Let write_txfifo_ovrun_flag(aData)
        set_txfifo_ovrun_flag = aData
        write
    End Property

    Property Get get_txfifo_full_flag
        get_txfifo_full_flag = read_txfifo_full_flag_value
    End Property

    Property Let set_txfifo_full_flag(aData)
        write_txfifo_full_flag_value = aData
        flag_txfifo_full_flag        = &H1
    End Property

    Property Get read_txfifo_full_flag
        read
        read_txfifo_full_flag = read_txfifo_full_flag_value
    End Property

    Property Let write_txfifo_full_flag(aData)
        set_txfifo_full_flag = aData
        write
    End Property

    Property Get get_rxfifo_udrun_flag
        get_rxfifo_udrun_flag = read_rxfifo_udrun_flag_value
    End Property

    Property Let set_rxfifo_udrun_flag(aData)
        write_rxfifo_udrun_flag_value = aData
        flag_rxfifo_udrun_flag        = &H1
    End Property

    Property Get read_rxfifo_udrun_flag
        read
        read_rxfifo_udrun_flag = read_rxfifo_udrun_flag_value
    End Property

    Property Let write_rxfifo_udrun_flag(aData)
        set_rxfifo_udrun_flag = aData
        write
    End Property

    Property Get get_rxfifo_empty_flag
        get_rxfifo_empty_flag = read_rxfifo_empty_flag_value
    End Property

    Property Let set_rxfifo_empty_flag(aData)
        write_rxfifo_empty_flag_value = aData
        flag_rxfifo_empty_flag        = &H1
    End Property

    Property Get read_rxfifo_empty_flag
        read
        read_rxfifo_empty_flag = read_rxfifo_empty_flag_value
    End Property

    Property Let write_rxfifo_empty_flag(aData)
        set_rxfifo_empty_flag = aData
        write
    End Property

    Property Get get_rxfifo_ovrun_flag
        get_rxfifo_ovrun_flag = read_rxfifo_ovrun_flag_value
    End Property

    Property Let set_rxfifo_ovrun_flag(aData)
        write_rxfifo_ovrun_flag_value = aData
        flag_rxfifo_ovrun_flag        = &H1
    End Property

    Property Get read_rxfifo_ovrun_flag
        read
        read_rxfifo_ovrun_flag = read_rxfifo_ovrun_flag_value
    End Property

    Property Let write_rxfifo_ovrun_flag(aData)
        set_rxfifo_ovrun_flag = aData
        write
    End Property

    Property Get get_rxfifo_full_flag
        get_rxfifo_full_flag = read_rxfifo_full_flag_value
    End Property

    Property Let set_rxfifo_full_flag(aData)
        write_rxfifo_full_flag_value = aData
        flag_rxfifo_full_flag        = &H1
    End Property

    Property Get read_rxfifo_full_flag
        read
        read_rxfifo_full_flag = read_rxfifo_full_flag_value
    End Property

    Property Let write_rxfifo_full_flag(aData)
        set_rxfifo_full_flag = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_txfifo_udrun_flag_value = rightShift(data_low, 7) and &H1
        read_txfifo_empty_flag_value = rightShift(data_low, 6) and &H1
        read_txfifo_ovrun_flag_value = rightShift(data_low, 5) and &H1
        read_txfifo_full_flag_value = rightShift(data_low, 4) and &H1
        read_rxfifo_udrun_flag_value = rightShift(data_low, 3) and &H1
        read_rxfifo_empty_flag_value = rightShift(data_low, 2) and &H1
        read_rxfifo_ovrun_flag_value = rightShift(data_low, 1) and &H1
        rxfifo_full_flag_mask = &H1
        if data_low > LONG_MAX then
            if rxfifo_full_flag_mask = mask then
                read_rxfifo_full_flag_value = data_low
            else
                read_rxfifo_full_flag_value = (data_low - H8000_0000) and rxfifo_full_flag_mask
            end If
        else
            read_rxfifo_full_flag_value = data_low and rxfifo_full_flag_mask
        end If

    End Sub

    Sub write
        If flag_txfifo_udrun_flag = &H0 or flag_txfifo_empty_flag = &H0 or flag_txfifo_ovrun_flag = &H0 or flag_txfifo_full_flag = &H0 or flag_rxfifo_udrun_flag = &H0 or flag_rxfifo_empty_flag = &H0 or flag_rxfifo_ovrun_flag = &H0 or flag_rxfifo_full_flag = &H0 Then read
        If flag_txfifo_udrun_flag = &H0 Then write_txfifo_udrun_flag_value = get_txfifo_udrun_flag
        If flag_txfifo_empty_flag = &H0 Then write_txfifo_empty_flag_value = get_txfifo_empty_flag
        If flag_txfifo_ovrun_flag = &H0 Then write_txfifo_ovrun_flag_value = get_txfifo_ovrun_flag
        If flag_txfifo_full_flag = &H0 Then write_txfifo_full_flag_value = get_txfifo_full_flag
        If flag_rxfifo_udrun_flag = &H0 Then write_rxfifo_udrun_flag_value = get_rxfifo_udrun_flag
        If flag_rxfifo_empty_flag = &H0 Then write_rxfifo_empty_flag_value = get_rxfifo_empty_flag
        If flag_rxfifo_ovrun_flag = &H0 Then write_rxfifo_ovrun_flag_value = get_rxfifo_ovrun_flag
        If flag_rxfifo_full_flag = &H0 Then write_rxfifo_full_flag_value = get_rxfifo_full_flag

        regValue = leftShift((write_txfifo_udrun_flag_value and &H1), 7) + leftShift((write_txfifo_empty_flag_value and &H1), 6) + leftShift((write_txfifo_ovrun_flag_value and &H1), 5) + leftShift((write_txfifo_full_flag_value and &H1), 4) + leftShift((write_rxfifo_udrun_flag_value and &H1), 3) + leftShift((write_rxfifo_empty_flag_value and &H1), 2) + leftShift((write_rxfifo_ovrun_flag_value and &H1), 1) + leftShift((write_rxfifo_full_flag_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_txfifo_udrun_flag_value = rightShift(data_low, 7) and &H1
        read_txfifo_empty_flag_value = rightShift(data_low, 6) and &H1
        read_txfifo_ovrun_flag_value = rightShift(data_low, 5) and &H1
        read_txfifo_full_flag_value = rightShift(data_low, 4) and &H1
        read_rxfifo_udrun_flag_value = rightShift(data_low, 3) and &H1
        read_rxfifo_empty_flag_value = rightShift(data_low, 2) and &H1
        read_rxfifo_ovrun_flag_value = rightShift(data_low, 1) and &H1
        rxfifo_full_flag_mask = &H1
        if data_low > LONG_MAX then
            if rxfifo_full_flag_mask = mask then
                read_rxfifo_full_flag_value = data_low
            else
                read_rxfifo_full_flag_value = (data_low - H8000_0000) and rxfifo_full_flag_mask
            end If
        else
            read_rxfifo_full_flag_value = data_low and rxfifo_full_flag_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_txfifo_udrun_flag_value = &H0
        flag_txfifo_udrun_flag        = &H0
        write_txfifo_empty_flag_value = &H0
        flag_txfifo_empty_flag        = &H0
        write_txfifo_ovrun_flag_value = &H0
        flag_txfifo_ovrun_flag        = &H0
        write_txfifo_full_flag_value = &H0
        flag_txfifo_full_flag        = &H0
        write_rxfifo_udrun_flag_value = &H0
        flag_rxfifo_udrun_flag        = &H0
        write_rxfifo_empty_flag_value = &H0
        flag_rxfifo_empty_flag        = &H0
        write_rxfifo_ovrun_flag_value = &H0
        flag_rxfifo_ovrun_flag        = &H0
        write_rxfifo_full_flag_value = &H0
        flag_rxfifo_full_flag        = &H0
    End Sub
End Class


'' @REGISTER : BR_GPCS_rxtrain_seed_ctl2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rxtrain_seed_32                            [1:1]            get_rxtrain_seed_32
''                                                             set_rxtrain_seed_32
''                                                             read_rxtrain_seed_32
''                                                             write_rxtrain_seed_32
''---------------------------------------------------------------------------------
'' rxtrain_seed_set                           [0:0]            get_rxtrain_seed_set
''                                                             set_rxtrain_seed_set
''                                                             read_rxtrain_seed_set
''                                                             write_rxtrain_seed_set
''---------------------------------------------------------------------------------
Class REGISTER_BR_GPCS_rxtrain_seed_ctl2
    Private write_rxtrain_seed_32_value
    Private read_rxtrain_seed_32_value
    Private flag_rxtrain_seed_32
    Private write_rxtrain_seed_set_value
    Private read_rxtrain_seed_set_value
    Private flag_rxtrain_seed_set

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

    Property Get get_rxtrain_seed_32
        get_rxtrain_seed_32 = read_rxtrain_seed_32_value
    End Property

    Property Let set_rxtrain_seed_32(aData)
        write_rxtrain_seed_32_value = aData
        flag_rxtrain_seed_32        = &H1
    End Property

    Property Get read_rxtrain_seed_32
        read
        read_rxtrain_seed_32 = read_rxtrain_seed_32_value
    End Property

    Property Let write_rxtrain_seed_32(aData)
        set_rxtrain_seed_32 = aData
        write
    End Property

    Property Get get_rxtrain_seed_set
        get_rxtrain_seed_set = read_rxtrain_seed_set_value
    End Property

    Property Let set_rxtrain_seed_set(aData)
        write_rxtrain_seed_set_value = aData
        flag_rxtrain_seed_set        = &H1
    End Property

    Property Get read_rxtrain_seed_set
        read
        read_rxtrain_seed_set = read_rxtrain_seed_set_value
    End Property

    Property Let write_rxtrain_seed_set(aData)
        set_rxtrain_seed_set = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rxtrain_seed_32_value = rightShift(data_low, 1) and &H1
        rxtrain_seed_set_mask = &H1
        if data_low > LONG_MAX then
            if rxtrain_seed_set_mask = mask then
                read_rxtrain_seed_set_value = data_low
            else
                read_rxtrain_seed_set_value = (data_low - H8000_0000) and rxtrain_seed_set_mask
            end If
        else
            read_rxtrain_seed_set_value = data_low and rxtrain_seed_set_mask
        end If

    End Sub

    Sub write
        If flag_rxtrain_seed_32 = &H0 or flag_rxtrain_seed_set = &H0 Then read
        If flag_rxtrain_seed_32 = &H0 Then write_rxtrain_seed_32_value = get_rxtrain_seed_32
        If flag_rxtrain_seed_set = &H0 Then write_rxtrain_seed_set_value = get_rxtrain_seed_set

        regValue = leftShift((write_rxtrain_seed_32_value and &H1), 1) + leftShift((write_rxtrain_seed_set_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rxtrain_seed_32_value = rightShift(data_low, 1) and &H1
        rxtrain_seed_set_mask = &H1
        if data_low > LONG_MAX then
            if rxtrain_seed_set_mask = mask then
                read_rxtrain_seed_set_value = data_low
            else
                read_rxtrain_seed_set_value = (data_low - H8000_0000) and rxtrain_seed_set_mask
            end If
        else
            read_rxtrain_seed_set_value = data_low and rxtrain_seed_set_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rxtrain_seed_32_value = &H0
        flag_rxtrain_seed_32        = &H0
        write_rxtrain_seed_set_value = &H0
        flag_rxtrain_seed_set        = &H0
    End Sub
End Class


'' @REGISTER : BR_GPCS_rxtrain_seed_ctl1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rxtrain_seed_31_16                         [15:0]           get_rxtrain_seed_31_16
''                                                             set_rxtrain_seed_31_16
''                                                             read_rxtrain_seed_31_16
''                                                             write_rxtrain_seed_31_16
''---------------------------------------------------------------------------------
Class REGISTER_BR_GPCS_rxtrain_seed_ctl1
    Private write_rxtrain_seed_31_16_value
    Private read_rxtrain_seed_31_16_value
    Private flag_rxtrain_seed_31_16

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

    Property Get get_rxtrain_seed_31_16
        get_rxtrain_seed_31_16 = read_rxtrain_seed_31_16_value
    End Property

    Property Let set_rxtrain_seed_31_16(aData)
        write_rxtrain_seed_31_16_value = aData
        flag_rxtrain_seed_31_16        = &H1
    End Property

    Property Get read_rxtrain_seed_31_16
        read
        read_rxtrain_seed_31_16 = read_rxtrain_seed_31_16_value
    End Property

    Property Let write_rxtrain_seed_31_16(aData)
        set_rxtrain_seed_31_16 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxtrain_seed_31_16_mask = &Hffff
        if data_low > LONG_MAX then
            if rxtrain_seed_31_16_mask = mask then
                read_rxtrain_seed_31_16_value = data_low
            else
                read_rxtrain_seed_31_16_value = (data_low - H8000_0000) and rxtrain_seed_31_16_mask
            end If
        else
            read_rxtrain_seed_31_16_value = data_low and rxtrain_seed_31_16_mask
        end If

    End Sub

    Sub write
        If flag_rxtrain_seed_31_16 = &H0 Then read
        If flag_rxtrain_seed_31_16 = &H0 Then write_rxtrain_seed_31_16_value = get_rxtrain_seed_31_16

        regValue = leftShift((write_rxtrain_seed_31_16_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxtrain_seed_31_16_mask = &Hffff
        if data_low > LONG_MAX then
            if rxtrain_seed_31_16_mask = mask then
                read_rxtrain_seed_31_16_value = data_low
            else
                read_rxtrain_seed_31_16_value = (data_low - H8000_0000) and rxtrain_seed_31_16_mask
            end If
        else
            read_rxtrain_seed_31_16_value = data_low and rxtrain_seed_31_16_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rxtrain_seed_31_16_value = &H0
        flag_rxtrain_seed_31_16        = &H0
    End Sub
End Class


'' @REGISTER : BR_GPCS_rxtrain_seed_ctl0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rxtrain_seed_15_0                          [15:0]           get_rxtrain_seed_15_0
''                                                             set_rxtrain_seed_15_0
''                                                             read_rxtrain_seed_15_0
''                                                             write_rxtrain_seed_15_0
''---------------------------------------------------------------------------------
Class REGISTER_BR_GPCS_rxtrain_seed_ctl0
    Private write_rxtrain_seed_15_0_value
    Private read_rxtrain_seed_15_0_value
    Private flag_rxtrain_seed_15_0

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

    Property Get get_rxtrain_seed_15_0
        get_rxtrain_seed_15_0 = read_rxtrain_seed_15_0_value
    End Property

    Property Let set_rxtrain_seed_15_0(aData)
        write_rxtrain_seed_15_0_value = aData
        flag_rxtrain_seed_15_0        = &H1
    End Property

    Property Get read_rxtrain_seed_15_0
        read
        read_rxtrain_seed_15_0 = read_rxtrain_seed_15_0_value
    End Property

    Property Let write_rxtrain_seed_15_0(aData)
        set_rxtrain_seed_15_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxtrain_seed_15_0_mask = &Hffff
        if data_low > LONG_MAX then
            if rxtrain_seed_15_0_mask = mask then
                read_rxtrain_seed_15_0_value = data_low
            else
                read_rxtrain_seed_15_0_value = (data_low - H8000_0000) and rxtrain_seed_15_0_mask
            end If
        else
            read_rxtrain_seed_15_0_value = data_low and rxtrain_seed_15_0_mask
        end If

    End Sub

    Sub write
        If flag_rxtrain_seed_15_0 = &H0 Then read
        If flag_rxtrain_seed_15_0 = &H0 Then write_rxtrain_seed_15_0_value = get_rxtrain_seed_15_0

        regValue = leftShift((write_rxtrain_seed_15_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rxtrain_seed_15_0_mask = &Hffff
        if data_low > LONG_MAX then
            if rxtrain_seed_15_0_mask = mask then
                read_rxtrain_seed_15_0_value = data_low
            else
                read_rxtrain_seed_15_0_value = (data_low - H8000_0000) and rxtrain_seed_15_0_mask
            end If
        else
            read_rxtrain_seed_15_0_value = data_low and rxtrain_seed_15_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rxtrain_seed_15_0_value = &H0
        flag_rxtrain_seed_15_0        = &H0
    End Sub
End Class


'' @REGISTER : BR_GPCS_txtrain_seed_ctl2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' fec_rnderr_bit_set                         [15:15]          get_fec_rnderr_bit_set
''                                                             set_fec_rnderr_bit_set
''                                                             read_fec_rnderr_bit_set
''                                                             write_fec_rnderr_bit_set
''---------------------------------------------------------------------------------
'' fec_rnderr_sym_set                         [14:14]          get_fec_rnderr_sym_set
''                                                             set_fec_rnderr_sym_set
''                                                             read_fec_rnderr_sym_set
''                                                             write_fec_rnderr_sym_set
''---------------------------------------------------------------------------------
'' fec_rnderr_bit_typ                         [13:13]          get_fec_rnderr_bit_typ
''                                                             set_fec_rnderr_bit_typ
''                                                             read_fec_rnderr_bit_typ
''                                                             write_fec_rnderr_bit_typ
''---------------------------------------------------------------------------------
'' fec_rnderr_sym_typ                         [12:12]          get_fec_rnderr_sym_typ
''                                                             set_fec_rnderr_sym_typ
''                                                             read_fec_rnderr_sym_typ
''                                                             write_fec_rnderr_sym_typ
''---------------------------------------------------------------------------------
'' txtrain_seed_32                            [1:1]            get_txtrain_seed_32
''                                                             set_txtrain_seed_32
''                                                             read_txtrain_seed_32
''                                                             write_txtrain_seed_32
''---------------------------------------------------------------------------------
'' txtrain_seed_set                           [0:0]            get_txtrain_seed_set
''                                                             set_txtrain_seed_set
''                                                             read_txtrain_seed_set
''                                                             write_txtrain_seed_set
''---------------------------------------------------------------------------------
Class REGISTER_BR_GPCS_txtrain_seed_ctl2
    Private write_fec_rnderr_bit_set_value
    Private read_fec_rnderr_bit_set_value
    Private flag_fec_rnderr_bit_set
    Private write_fec_rnderr_sym_set_value
    Private read_fec_rnderr_sym_set_value
    Private flag_fec_rnderr_sym_set
    Private write_fec_rnderr_bit_typ_value
    Private read_fec_rnderr_bit_typ_value
    Private flag_fec_rnderr_bit_typ
    Private write_fec_rnderr_sym_typ_value
    Private read_fec_rnderr_sym_typ_value
    Private flag_fec_rnderr_sym_typ
    Private write_txtrain_seed_32_value
    Private read_txtrain_seed_32_value
    Private flag_txtrain_seed_32
    Private write_txtrain_seed_set_value
    Private read_txtrain_seed_set_value
    Private flag_txtrain_seed_set

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

    Property Get get_fec_rnderr_bit_set
        get_fec_rnderr_bit_set = read_fec_rnderr_bit_set_value
    End Property

    Property Let set_fec_rnderr_bit_set(aData)
        write_fec_rnderr_bit_set_value = aData
        flag_fec_rnderr_bit_set        = &H1
    End Property

    Property Get read_fec_rnderr_bit_set
        read
        read_fec_rnderr_bit_set = read_fec_rnderr_bit_set_value
    End Property

    Property Let write_fec_rnderr_bit_set(aData)
        set_fec_rnderr_bit_set = aData
        write
    End Property

    Property Get get_fec_rnderr_sym_set
        get_fec_rnderr_sym_set = read_fec_rnderr_sym_set_value
    End Property

    Property Let set_fec_rnderr_sym_set(aData)
        write_fec_rnderr_sym_set_value = aData
        flag_fec_rnderr_sym_set        = &H1
    End Property

    Property Get read_fec_rnderr_sym_set
        read
        read_fec_rnderr_sym_set = read_fec_rnderr_sym_set_value
    End Property

    Property Let write_fec_rnderr_sym_set(aData)
        set_fec_rnderr_sym_set = aData
        write
    End Property

    Property Get get_fec_rnderr_bit_typ
        get_fec_rnderr_bit_typ = read_fec_rnderr_bit_typ_value
    End Property

    Property Let set_fec_rnderr_bit_typ(aData)
        write_fec_rnderr_bit_typ_value = aData
        flag_fec_rnderr_bit_typ        = &H1
    End Property

    Property Get read_fec_rnderr_bit_typ
        read
        read_fec_rnderr_bit_typ = read_fec_rnderr_bit_typ_value
    End Property

    Property Let write_fec_rnderr_bit_typ(aData)
        set_fec_rnderr_bit_typ = aData
        write
    End Property

    Property Get get_fec_rnderr_sym_typ
        get_fec_rnderr_sym_typ = read_fec_rnderr_sym_typ_value
    End Property

    Property Let set_fec_rnderr_sym_typ(aData)
        write_fec_rnderr_sym_typ_value = aData
        flag_fec_rnderr_sym_typ        = &H1
    End Property

    Property Get read_fec_rnderr_sym_typ
        read
        read_fec_rnderr_sym_typ = read_fec_rnderr_sym_typ_value
    End Property

    Property Let write_fec_rnderr_sym_typ(aData)
        set_fec_rnderr_sym_typ = aData
        write
    End Property

    Property Get get_txtrain_seed_32
        get_txtrain_seed_32 = read_txtrain_seed_32_value
    End Property

    Property Let set_txtrain_seed_32(aData)
        write_txtrain_seed_32_value = aData
        flag_txtrain_seed_32        = &H1
    End Property

    Property Get read_txtrain_seed_32
        read
        read_txtrain_seed_32 = read_txtrain_seed_32_value
    End Property

    Property Let write_txtrain_seed_32(aData)
        set_txtrain_seed_32 = aData
        write
    End Property

    Property Get get_txtrain_seed_set
        get_txtrain_seed_set = read_txtrain_seed_set_value
    End Property

    Property Let set_txtrain_seed_set(aData)
        write_txtrain_seed_set_value = aData
        flag_txtrain_seed_set        = &H1
    End Property

    Property Get read_txtrain_seed_set
        read
        read_txtrain_seed_set = read_txtrain_seed_set_value
    End Property

    Property Let write_txtrain_seed_set(aData)
        set_txtrain_seed_set = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_fec_rnderr_bit_set_value = rightShift(data_low, 15) and &H1
        read_fec_rnderr_sym_set_value = rightShift(data_low, 14) and &H1
        read_fec_rnderr_bit_typ_value = rightShift(data_low, 13) and &H1
        read_fec_rnderr_sym_typ_value = rightShift(data_low, 12) and &H1
        read_txtrain_seed_32_value = rightShift(data_low, 1) and &H1
        txtrain_seed_set_mask = &H1
        if data_low > LONG_MAX then
            if txtrain_seed_set_mask = mask then
                read_txtrain_seed_set_value = data_low
            else
                read_txtrain_seed_set_value = (data_low - H8000_0000) and txtrain_seed_set_mask
            end If
        else
            read_txtrain_seed_set_value = data_low and txtrain_seed_set_mask
        end If

    End Sub

    Sub write
        If flag_fec_rnderr_bit_set = &H0 or flag_fec_rnderr_sym_set = &H0 or flag_fec_rnderr_bit_typ = &H0 or flag_fec_rnderr_sym_typ = &H0 or flag_txtrain_seed_32 = &H0 or flag_txtrain_seed_set = &H0 Then read
        If flag_fec_rnderr_bit_set = &H0 Then write_fec_rnderr_bit_set_value = get_fec_rnderr_bit_set
        If flag_fec_rnderr_sym_set = &H0 Then write_fec_rnderr_sym_set_value = get_fec_rnderr_sym_set
        If flag_fec_rnderr_bit_typ = &H0 Then write_fec_rnderr_bit_typ_value = get_fec_rnderr_bit_typ
        If flag_fec_rnderr_sym_typ = &H0 Then write_fec_rnderr_sym_typ_value = get_fec_rnderr_sym_typ
        If flag_txtrain_seed_32 = &H0 Then write_txtrain_seed_32_value = get_txtrain_seed_32
        If flag_txtrain_seed_set = &H0 Then write_txtrain_seed_set_value = get_txtrain_seed_set

        regValue = leftShift((write_fec_rnderr_bit_set_value and &H1), 15) + leftShift((write_fec_rnderr_sym_set_value and &H1), 14) + leftShift((write_fec_rnderr_bit_typ_value and &H1), 13) + leftShift((write_fec_rnderr_sym_typ_value and &H1), 12) + leftShift((write_txtrain_seed_32_value and &H1), 1) + leftShift((write_txtrain_seed_set_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_fec_rnderr_bit_set_value = rightShift(data_low, 15) and &H1
        read_fec_rnderr_sym_set_value = rightShift(data_low, 14) and &H1
        read_fec_rnderr_bit_typ_value = rightShift(data_low, 13) and &H1
        read_fec_rnderr_sym_typ_value = rightShift(data_low, 12) and &H1
        read_txtrain_seed_32_value = rightShift(data_low, 1) and &H1
        txtrain_seed_set_mask = &H1
        if data_low > LONG_MAX then
            if txtrain_seed_set_mask = mask then
                read_txtrain_seed_set_value = data_low
            else
                read_txtrain_seed_set_value = (data_low - H8000_0000) and txtrain_seed_set_mask
            end If
        else
            read_txtrain_seed_set_value = data_low and txtrain_seed_set_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_fec_rnderr_bit_set_value = &H0
        flag_fec_rnderr_bit_set        = &H0
        write_fec_rnderr_sym_set_value = &H0
        flag_fec_rnderr_sym_set        = &H0
        write_fec_rnderr_bit_typ_value = &H0
        flag_fec_rnderr_bit_typ        = &H0
        write_fec_rnderr_sym_typ_value = &H0
        flag_fec_rnderr_sym_typ        = &H0
        write_txtrain_seed_32_value = &H0
        flag_txtrain_seed_32        = &H0
        write_txtrain_seed_set_value = &H0
        flag_txtrain_seed_set        = &H0
    End Sub
End Class


'' @REGISTER : BR_GPCS_txtrain_seed_ctl1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' txtrain_seed_31_16                         [15:0]           get_txtrain_seed_31_16
''                                                             set_txtrain_seed_31_16
''                                                             read_txtrain_seed_31_16
''                                                             write_txtrain_seed_31_16
''---------------------------------------------------------------------------------
Class REGISTER_BR_GPCS_txtrain_seed_ctl1
    Private write_txtrain_seed_31_16_value
    Private read_txtrain_seed_31_16_value
    Private flag_txtrain_seed_31_16

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

    Property Get get_txtrain_seed_31_16
        get_txtrain_seed_31_16 = read_txtrain_seed_31_16_value
    End Property

    Property Let set_txtrain_seed_31_16(aData)
        write_txtrain_seed_31_16_value = aData
        flag_txtrain_seed_31_16        = &H1
    End Property

    Property Get read_txtrain_seed_31_16
        read
        read_txtrain_seed_31_16 = read_txtrain_seed_31_16_value
    End Property

    Property Let write_txtrain_seed_31_16(aData)
        set_txtrain_seed_31_16 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        txtrain_seed_31_16_mask = &Hffff
        if data_low > LONG_MAX then
            if txtrain_seed_31_16_mask = mask then
                read_txtrain_seed_31_16_value = data_low
            else
                read_txtrain_seed_31_16_value = (data_low - H8000_0000) and txtrain_seed_31_16_mask
            end If
        else
            read_txtrain_seed_31_16_value = data_low and txtrain_seed_31_16_mask
        end If

    End Sub

    Sub write
        If flag_txtrain_seed_31_16 = &H0 Then read
        If flag_txtrain_seed_31_16 = &H0 Then write_txtrain_seed_31_16_value = get_txtrain_seed_31_16

        regValue = leftShift((write_txtrain_seed_31_16_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        txtrain_seed_31_16_mask = &Hffff
        if data_low > LONG_MAX then
            if txtrain_seed_31_16_mask = mask then
                read_txtrain_seed_31_16_value = data_low
            else
                read_txtrain_seed_31_16_value = (data_low - H8000_0000) and txtrain_seed_31_16_mask
            end If
        else
            read_txtrain_seed_31_16_value = data_low and txtrain_seed_31_16_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_txtrain_seed_31_16_value = &H0
        flag_txtrain_seed_31_16        = &H0
    End Sub
End Class


'' @REGISTER : BR_GPCS_txtrain_seed_ctl0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' txtrain_seed_15_0                          [15:0]           get_txtrain_seed_15_0
''                                                             set_txtrain_seed_15_0
''                                                             read_txtrain_seed_15_0
''                                                             write_txtrain_seed_15_0
''---------------------------------------------------------------------------------
Class REGISTER_BR_GPCS_txtrain_seed_ctl0
    Private write_txtrain_seed_15_0_value
    Private read_txtrain_seed_15_0_value
    Private flag_txtrain_seed_15_0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H20
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_txtrain_seed_15_0
        get_txtrain_seed_15_0 = read_txtrain_seed_15_0_value
    End Property

    Property Let set_txtrain_seed_15_0(aData)
        write_txtrain_seed_15_0_value = aData
        flag_txtrain_seed_15_0        = &H1
    End Property

    Property Get read_txtrain_seed_15_0
        read
        read_txtrain_seed_15_0 = read_txtrain_seed_15_0_value
    End Property

    Property Let write_txtrain_seed_15_0(aData)
        set_txtrain_seed_15_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        txtrain_seed_15_0_mask = &Hffff
        if data_low > LONG_MAX then
            if txtrain_seed_15_0_mask = mask then
                read_txtrain_seed_15_0_value = data_low
            else
                read_txtrain_seed_15_0_value = (data_low - H8000_0000) and txtrain_seed_15_0_mask
            end If
        else
            read_txtrain_seed_15_0_value = data_low and txtrain_seed_15_0_mask
        end If

    End Sub

    Sub write
        If flag_txtrain_seed_15_0 = &H0 Then read
        If flag_txtrain_seed_15_0 = &H0 Then write_txtrain_seed_15_0_value = get_txtrain_seed_15_0

        regValue = leftShift((write_txtrain_seed_15_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        txtrain_seed_15_0_mask = &Hffff
        if data_low > LONG_MAX then
            if txtrain_seed_15_0_mask = mask then
                read_txtrain_seed_15_0_value = data_low
            else
                read_txtrain_seed_15_0_value = (data_low - H8000_0000) and txtrain_seed_15_0_mask
            end If
        else
            read_txtrain_seed_15_0_value = data_low and txtrain_seed_15_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_txtrain_seed_15_0_value = &H0
        flag_txtrain_seed_15_0        = &H0
    End Sub
End Class


'' @REGISTER : BR_GPCS_rxtrain_ctl0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' byp_block_lock_mon                         [15:15]          get_byp_block_lock_mon
''                                                             set_byp_block_lock_mon
''                                                             read_byp_block_lock_mon
''                                                             write_byp_block_lock_mon
''---------------------------------------------------------------------------------
'' byp_nonidle_mon                            [14:14]          get_byp_nonidle_mon
''                                                             set_byp_nonidle_mon
''                                                             read_byp_nonidle_mon
''                                                             write_byp_nonidle_mon
''---------------------------------------------------------------------------------
'' byp_crc_mon                                [13:13]          get_byp_crc_mon
''                                                             set_byp_crc_mon
''                                                             read_byp_crc_mon
''                                                             write_byp_crc_mon
''---------------------------------------------------------------------------------
'' pam3_frame_dly                             [12:11]          get_pam3_frame_dly
''                                                             set_pam3_frame_dly
''                                                             read_pam3_frame_dly
''                                                             write_pam3_frame_dly
''---------------------------------------------------------------------------------
'' rx_pam3_dly                                [10:8]           get_rx_pam3_dly
''                                                             set_rx_pam3_dly
''                                                             read_rx_pam3_dly
''                                                             write_rx_pam3_dly
''---------------------------------------------------------------------------------
'' s2_chk_T0                                  [7:7]            get_s2_chk_T0
''                                                             set_s2_chk_T0
''                                                             read_s2_chk_T0
''                                                             write_s2_chk_T0
''---------------------------------------------------------------------------------
'' s4_chk2fec                                 [6:6]            get_s4_chk2fec
''                                                             set_s4_chk2fec
''                                                             read_s4_chk2fec
''                                                             write_s4_chk2fec
''---------------------------------------------------------------------------------
'' chkcrc_thresh                              [5:4]            get_chkcrc_thresh
''                                                             set_chkcrc_thresh
''                                                             read_chkcrc_thresh
''                                                             write_chkcrc_thresh
''---------------------------------------------------------------------------------
'' nonidle_thresh                             [3:2]            get_nonidle_thresh
''                                                             set_nonidle_thresh
''                                                             read_nonidle_thresh
''                                                             write_nonidle_thresh
''---------------------------------------------------------------------------------
'' info_qual                                  [1:0]            get_info_qual
''                                                             set_info_qual
''                                                             read_info_qual
''                                                             write_info_qual
''---------------------------------------------------------------------------------
Class REGISTER_BR_GPCS_rxtrain_ctl0
    Private write_byp_block_lock_mon_value
    Private read_byp_block_lock_mon_value
    Private flag_byp_block_lock_mon
    Private write_byp_nonidle_mon_value
    Private read_byp_nonidle_mon_value
    Private flag_byp_nonidle_mon
    Private write_byp_crc_mon_value
    Private read_byp_crc_mon_value
    Private flag_byp_crc_mon
    Private write_pam3_frame_dly_value
    Private read_pam3_frame_dly_value
    Private flag_pam3_frame_dly
    Private write_rx_pam3_dly_value
    Private read_rx_pam3_dly_value
    Private flag_rx_pam3_dly
    Private write_s2_chk_T0_value
    Private read_s2_chk_T0_value
    Private flag_s2_chk_T0
    Private write_s4_chk2fec_value
    Private read_s4_chk2fec_value
    Private flag_s4_chk2fec
    Private write_chkcrc_thresh_value
    Private read_chkcrc_thresh_value
    Private flag_chkcrc_thresh
    Private write_nonidle_thresh_value
    Private read_nonidle_thresh_value
    Private flag_nonidle_thresh
    Private write_info_qual_value
    Private read_info_qual_value
    Private flag_info_qual

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H22
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_byp_block_lock_mon
        get_byp_block_lock_mon = read_byp_block_lock_mon_value
    End Property

    Property Let set_byp_block_lock_mon(aData)
        write_byp_block_lock_mon_value = aData
        flag_byp_block_lock_mon        = &H1
    End Property

    Property Get read_byp_block_lock_mon
        read
        read_byp_block_lock_mon = read_byp_block_lock_mon_value
    End Property

    Property Let write_byp_block_lock_mon(aData)
        set_byp_block_lock_mon = aData
        write
    End Property

    Property Get get_byp_nonidle_mon
        get_byp_nonidle_mon = read_byp_nonidle_mon_value
    End Property

    Property Let set_byp_nonidle_mon(aData)
        write_byp_nonidle_mon_value = aData
        flag_byp_nonidle_mon        = &H1
    End Property

    Property Get read_byp_nonidle_mon
        read
        read_byp_nonidle_mon = read_byp_nonidle_mon_value
    End Property

    Property Let write_byp_nonidle_mon(aData)
        set_byp_nonidle_mon = aData
        write
    End Property

    Property Get get_byp_crc_mon
        get_byp_crc_mon = read_byp_crc_mon_value
    End Property

    Property Let set_byp_crc_mon(aData)
        write_byp_crc_mon_value = aData
        flag_byp_crc_mon        = &H1
    End Property

    Property Get read_byp_crc_mon
        read
        read_byp_crc_mon = read_byp_crc_mon_value
    End Property

    Property Let write_byp_crc_mon(aData)
        set_byp_crc_mon = aData
        write
    End Property

    Property Get get_pam3_frame_dly
        get_pam3_frame_dly = read_pam3_frame_dly_value
    End Property

    Property Let set_pam3_frame_dly(aData)
        write_pam3_frame_dly_value = aData
        flag_pam3_frame_dly        = &H1
    End Property

    Property Get read_pam3_frame_dly
        read
        read_pam3_frame_dly = read_pam3_frame_dly_value
    End Property

    Property Let write_pam3_frame_dly(aData)
        set_pam3_frame_dly = aData
        write
    End Property

    Property Get get_rx_pam3_dly
        get_rx_pam3_dly = read_rx_pam3_dly_value
    End Property

    Property Let set_rx_pam3_dly(aData)
        write_rx_pam3_dly_value = aData
        flag_rx_pam3_dly        = &H1
    End Property

    Property Get read_rx_pam3_dly
        read
        read_rx_pam3_dly = read_rx_pam3_dly_value
    End Property

    Property Let write_rx_pam3_dly(aData)
        set_rx_pam3_dly = aData
        write
    End Property

    Property Get get_s2_chk_T0
        get_s2_chk_T0 = read_s2_chk_T0_value
    End Property

    Property Let set_s2_chk_T0(aData)
        write_s2_chk_T0_value = aData
        flag_s2_chk_T0        = &H1
    End Property

    Property Get read_s2_chk_T0
        read
        read_s2_chk_T0 = read_s2_chk_T0_value
    End Property

    Property Let write_s2_chk_T0(aData)
        set_s2_chk_T0 = aData
        write
    End Property

    Property Get get_s4_chk2fec
        get_s4_chk2fec = read_s4_chk2fec_value
    End Property

    Property Let set_s4_chk2fec(aData)
        write_s4_chk2fec_value = aData
        flag_s4_chk2fec        = &H1
    End Property

    Property Get read_s4_chk2fec
        read
        read_s4_chk2fec = read_s4_chk2fec_value
    End Property

    Property Let write_s4_chk2fec(aData)
        set_s4_chk2fec = aData
        write
    End Property

    Property Get get_chkcrc_thresh
        get_chkcrc_thresh = read_chkcrc_thresh_value
    End Property

    Property Let set_chkcrc_thresh(aData)
        write_chkcrc_thresh_value = aData
        flag_chkcrc_thresh        = &H1
    End Property

    Property Get read_chkcrc_thresh
        read
        read_chkcrc_thresh = read_chkcrc_thresh_value
    End Property

    Property Let write_chkcrc_thresh(aData)
        set_chkcrc_thresh = aData
        write
    End Property

    Property Get get_nonidle_thresh
        get_nonidle_thresh = read_nonidle_thresh_value
    End Property

    Property Let set_nonidle_thresh(aData)
        write_nonidle_thresh_value = aData
        flag_nonidle_thresh        = &H1
    End Property

    Property Get read_nonidle_thresh
        read
        read_nonidle_thresh = read_nonidle_thresh_value
    End Property

    Property Let write_nonidle_thresh(aData)
        set_nonidle_thresh = aData
        write
    End Property

    Property Get get_info_qual
        get_info_qual = read_info_qual_value
    End Property

    Property Let set_info_qual(aData)
        write_info_qual_value = aData
        flag_info_qual        = &H1
    End Property

    Property Get read_info_qual
        read
        read_info_qual = read_info_qual_value
    End Property

    Property Let write_info_qual(aData)
        set_info_qual = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_byp_block_lock_mon_value = rightShift(data_low, 15) and &H1
        read_byp_nonidle_mon_value = rightShift(data_low, 14) and &H1
        read_byp_crc_mon_value = rightShift(data_low, 13) and &H1
        read_pam3_frame_dly_value = rightShift(data_low, 11) and &H3
        read_rx_pam3_dly_value = rightShift(data_low, 8) and &H7
        read_s2_chk_T0_value = rightShift(data_low, 7) and &H1
        read_s4_chk2fec_value = rightShift(data_low, 6) and &H1
        read_chkcrc_thresh_value = rightShift(data_low, 4) and &H3
        read_nonidle_thresh_value = rightShift(data_low, 2) and &H3
        info_qual_mask = &H3
        if data_low > LONG_MAX then
            if info_qual_mask = mask then
                read_info_qual_value = data_low
            else
                read_info_qual_value = (data_low - H8000_0000) and info_qual_mask
            end If
        else
            read_info_qual_value = data_low and info_qual_mask
        end If

    End Sub

    Sub write
        If flag_byp_block_lock_mon = &H0 or flag_byp_nonidle_mon = &H0 or flag_byp_crc_mon = &H0 or flag_pam3_frame_dly = &H0 or flag_rx_pam3_dly = &H0 or flag_s2_chk_T0 = &H0 or flag_s4_chk2fec = &H0 or flag_chkcrc_thresh = &H0 or flag_nonidle_thresh = &H0 or flag_info_qual = &H0 Then read
        If flag_byp_block_lock_mon = &H0 Then write_byp_block_lock_mon_value = get_byp_block_lock_mon
        If flag_byp_nonidle_mon = &H0 Then write_byp_nonidle_mon_value = get_byp_nonidle_mon
        If flag_byp_crc_mon = &H0 Then write_byp_crc_mon_value = get_byp_crc_mon
        If flag_pam3_frame_dly = &H0 Then write_pam3_frame_dly_value = get_pam3_frame_dly
        If flag_rx_pam3_dly = &H0 Then write_rx_pam3_dly_value = get_rx_pam3_dly
        If flag_s2_chk_T0 = &H0 Then write_s2_chk_T0_value = get_s2_chk_T0
        If flag_s4_chk2fec = &H0 Then write_s4_chk2fec_value = get_s4_chk2fec
        If flag_chkcrc_thresh = &H0 Then write_chkcrc_thresh_value = get_chkcrc_thresh
        If flag_nonidle_thresh = &H0 Then write_nonidle_thresh_value = get_nonidle_thresh
        If flag_info_qual = &H0 Then write_info_qual_value = get_info_qual

        regValue = leftShift((write_byp_block_lock_mon_value and &H1), 15) + leftShift((write_byp_nonidle_mon_value and &H1), 14) + leftShift((write_byp_crc_mon_value and &H1), 13) + leftShift((write_pam3_frame_dly_value and &H3), 11) + leftShift((write_rx_pam3_dly_value and &H7), 8) + leftShift((write_s2_chk_T0_value and &H1), 7) + leftShift((write_s4_chk2fec_value and &H1), 6) + leftShift((write_chkcrc_thresh_value and &H3), 4) + leftShift((write_nonidle_thresh_value and &H3), 2) + leftShift((write_info_qual_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_byp_block_lock_mon_value = rightShift(data_low, 15) and &H1
        read_byp_nonidle_mon_value = rightShift(data_low, 14) and &H1
        read_byp_crc_mon_value = rightShift(data_low, 13) and &H1
        read_pam3_frame_dly_value = rightShift(data_low, 11) and &H3
        read_rx_pam3_dly_value = rightShift(data_low, 8) and &H7
        read_s2_chk_T0_value = rightShift(data_low, 7) and &H1
        read_s4_chk2fec_value = rightShift(data_low, 6) and &H1
        read_chkcrc_thresh_value = rightShift(data_low, 4) and &H3
        read_nonidle_thresh_value = rightShift(data_low, 2) and &H3
        info_qual_mask = &H3
        if data_low > LONG_MAX then
            if info_qual_mask = mask then
                read_info_qual_value = data_low
            else
                read_info_qual_value = (data_low - H8000_0000) and info_qual_mask
            end If
        else
            read_info_qual_value = data_low and info_qual_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_byp_block_lock_mon_value = &H0
        flag_byp_block_lock_mon        = &H0
        write_byp_nonidle_mon_value = &H0
        flag_byp_nonidle_mon        = &H0
        write_byp_crc_mon_value = &H0
        flag_byp_crc_mon        = &H0
        write_pam3_frame_dly_value = &H0
        flag_pam3_frame_dly        = &H0
        write_rx_pam3_dly_value = &H0
        flag_rx_pam3_dly        = &H0
        write_s2_chk_T0_value = &H0
        flag_s2_chk_T0        = &H0
        write_s4_chk2fec_value = &H0
        flag_s4_chk2fec        = &H0
        write_chkcrc_thresh_value = &H0
        flag_chkcrc_thresh        = &H0
        write_nonidle_thresh_value = &H0
        flag_nonidle_thresh        = &H0
        write_info_qual_value = &H0
        flag_info_qual        = &H0
    End Sub
End Class


'' @REGISTER : BR_GPCS_misc_status0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pam_err_o_is0                              [12:12]          get_pam_err_o_is0
''                                                             set_pam_err_o_is0
''                                                             read_pam_err_o_is0
''                                                             write_pam_err_o_is0
''---------------------------------------------------------------------------------
'' pam_err_o_isp1                             [11:11]          get_pam_err_o_isp1
''                                                             set_pam_err_o_isp1
''                                                             read_pam_err_o_isp1
''                                                             write_pam_err_o_isp1
''---------------------------------------------------------------------------------
'' pam_err_o_isn1                             [10:10]          get_pam_err_o_isn1
''                                                             set_pam_err_o_isn1
''                                                             read_pam_err_o_isn1
''                                                             write_pam_err_o_isn1
''---------------------------------------------------------------------------------
'' pam_err_e_is0                              [9:9]            get_pam_err_e_is0
''                                                             set_pam_err_e_is0
''                                                             read_pam_err_e_is0
''                                                             write_pam_err_e_is0
''---------------------------------------------------------------------------------
'' pam_err_e_isp1                             [8:8]            get_pam_err_e_isp1
''                                                             set_pam_err_e_isp1
''                                                             read_pam_err_e_isp1
''                                                             write_pam_err_e_isp1
''---------------------------------------------------------------------------------
'' pam_err_e_isn1                             [7:7]            get_pam_err_e_isn1
''                                                             set_pam_err_e_isn1
''                                                             read_pam_err_e_isn1
''                                                             write_pam_err_e_isn1
''---------------------------------------------------------------------------------
'' ptr_undef                                  [6:6]            get_ptr_undef
''                                                             set_ptr_undef
''                                                             read_ptr_undef
''                                                             write_ptr_undef
''---------------------------------------------------------------------------------
'' ptr_outorder                               [5:5]            get_ptr_outorder
''                                                             set_ptr_outorder
''                                                             read_ptr_outorder
''                                                             write_ptr_outorder
''---------------------------------------------------------------------------------
'' ptr_miss_n                                 [4:4]            get_ptr_miss_n
''                                                             set_ptr_miss_n
''                                                             read_ptr_miss_n
''                                                             write_ptr_miss_n
''---------------------------------------------------------------------------------
'' blk_fecerr                                 [3:3]            get_blk_fecerr
''                                                             set_blk_fecerr
''                                                             read_blk_fecerr
''                                                             write_blk_fecerr
''---------------------------------------------------------------------------------
'' udef_ctrlcode                              [2:2]            get_udef_ctrlcode
''                                                             set_udef_ctrlcode
''                                                             read_udef_ctrlcode
''                                                             write_udef_ctrlcode
''---------------------------------------------------------------------------------
'' rcv_lpidle                                 [1:1]            get_rcv_lpidle
''                                                             set_rcv_lpidle
''                                                             read_rcv_lpidle
''                                                             write_rcv_lpidle
''---------------------------------------------------------------------------------
'' rx_evenOddAdj                              [0:0]            get_rx_evenOddAdj
''                                                             set_rx_evenOddAdj
''                                                             read_rx_evenOddAdj
''                                                             write_rx_evenOddAdj
''---------------------------------------------------------------------------------
Class REGISTER_BR_GPCS_misc_status0
    Private write_pam_err_o_is0_value
    Private read_pam_err_o_is0_value
    Private flag_pam_err_o_is0
    Private write_pam_err_o_isp1_value
    Private read_pam_err_o_isp1_value
    Private flag_pam_err_o_isp1
    Private write_pam_err_o_isn1_value
    Private read_pam_err_o_isn1_value
    Private flag_pam_err_o_isn1
    Private write_pam_err_e_is0_value
    Private read_pam_err_e_is0_value
    Private flag_pam_err_e_is0
    Private write_pam_err_e_isp1_value
    Private read_pam_err_e_isp1_value
    Private flag_pam_err_e_isp1
    Private write_pam_err_e_isn1_value
    Private read_pam_err_e_isn1_value
    Private flag_pam_err_e_isn1
    Private write_ptr_undef_value
    Private read_ptr_undef_value
    Private flag_ptr_undef
    Private write_ptr_outorder_value
    Private read_ptr_outorder_value
    Private flag_ptr_outorder
    Private write_ptr_miss_n_value
    Private read_ptr_miss_n_value
    Private flag_ptr_miss_n
    Private write_blk_fecerr_value
    Private read_blk_fecerr_value
    Private flag_blk_fecerr
    Private write_udef_ctrlcode_value
    Private read_udef_ctrlcode_value
    Private flag_udef_ctrlcode
    Private write_rcv_lpidle_value
    Private read_rcv_lpidle_value
    Private flag_rcv_lpidle
    Private write_rx_evenOddAdj_value
    Private read_rx_evenOddAdj_value
    Private flag_rx_evenOddAdj

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

    Property Get get_pam_err_o_is0
        get_pam_err_o_is0 = read_pam_err_o_is0_value
    End Property

    Property Let set_pam_err_o_is0(aData)
        write_pam_err_o_is0_value = aData
        flag_pam_err_o_is0        = &H1
    End Property

    Property Get read_pam_err_o_is0
        read
        read_pam_err_o_is0 = read_pam_err_o_is0_value
    End Property

    Property Let write_pam_err_o_is0(aData)
        set_pam_err_o_is0 = aData
        write
    End Property

    Property Get get_pam_err_o_isp1
        get_pam_err_o_isp1 = read_pam_err_o_isp1_value
    End Property

    Property Let set_pam_err_o_isp1(aData)
        write_pam_err_o_isp1_value = aData
        flag_pam_err_o_isp1        = &H1
    End Property

    Property Get read_pam_err_o_isp1
        read
        read_pam_err_o_isp1 = read_pam_err_o_isp1_value
    End Property

    Property Let write_pam_err_o_isp1(aData)
        set_pam_err_o_isp1 = aData
        write
    End Property

    Property Get get_pam_err_o_isn1
        get_pam_err_o_isn1 = read_pam_err_o_isn1_value
    End Property

    Property Let set_pam_err_o_isn1(aData)
        write_pam_err_o_isn1_value = aData
        flag_pam_err_o_isn1        = &H1
    End Property

    Property Get read_pam_err_o_isn1
        read
        read_pam_err_o_isn1 = read_pam_err_o_isn1_value
    End Property

    Property Let write_pam_err_o_isn1(aData)
        set_pam_err_o_isn1 = aData
        write
    End Property

    Property Get get_pam_err_e_is0
        get_pam_err_e_is0 = read_pam_err_e_is0_value
    End Property

    Property Let set_pam_err_e_is0(aData)
        write_pam_err_e_is0_value = aData
        flag_pam_err_e_is0        = &H1
    End Property

    Property Get read_pam_err_e_is0
        read
        read_pam_err_e_is0 = read_pam_err_e_is0_value
    End Property

    Property Let write_pam_err_e_is0(aData)
        set_pam_err_e_is0 = aData
        write
    End Property

    Property Get get_pam_err_e_isp1
        get_pam_err_e_isp1 = read_pam_err_e_isp1_value
    End Property

    Property Let set_pam_err_e_isp1(aData)
        write_pam_err_e_isp1_value = aData
        flag_pam_err_e_isp1        = &H1
    End Property

    Property Get read_pam_err_e_isp1
        read
        read_pam_err_e_isp1 = read_pam_err_e_isp1_value
    End Property

    Property Let write_pam_err_e_isp1(aData)
        set_pam_err_e_isp1 = aData
        write
    End Property

    Property Get get_pam_err_e_isn1
        get_pam_err_e_isn1 = read_pam_err_e_isn1_value
    End Property

    Property Let set_pam_err_e_isn1(aData)
        write_pam_err_e_isn1_value = aData
        flag_pam_err_e_isn1        = &H1
    End Property

    Property Get read_pam_err_e_isn1
        read
        read_pam_err_e_isn1 = read_pam_err_e_isn1_value
    End Property

    Property Let write_pam_err_e_isn1(aData)
        set_pam_err_e_isn1 = aData
        write
    End Property

    Property Get get_ptr_undef
        get_ptr_undef = read_ptr_undef_value
    End Property

    Property Let set_ptr_undef(aData)
        write_ptr_undef_value = aData
        flag_ptr_undef        = &H1
    End Property

    Property Get read_ptr_undef
        read
        read_ptr_undef = read_ptr_undef_value
    End Property

    Property Let write_ptr_undef(aData)
        set_ptr_undef = aData
        write
    End Property

    Property Get get_ptr_outorder
        get_ptr_outorder = read_ptr_outorder_value
    End Property

    Property Let set_ptr_outorder(aData)
        write_ptr_outorder_value = aData
        flag_ptr_outorder        = &H1
    End Property

    Property Get read_ptr_outorder
        read
        read_ptr_outorder = read_ptr_outorder_value
    End Property

    Property Let write_ptr_outorder(aData)
        set_ptr_outorder = aData
        write
    End Property

    Property Get get_ptr_miss_n
        get_ptr_miss_n = read_ptr_miss_n_value
    End Property

    Property Let set_ptr_miss_n(aData)
        write_ptr_miss_n_value = aData
        flag_ptr_miss_n        = &H1
    End Property

    Property Get read_ptr_miss_n
        read
        read_ptr_miss_n = read_ptr_miss_n_value
    End Property

    Property Let write_ptr_miss_n(aData)
        set_ptr_miss_n = aData
        write
    End Property

    Property Get get_blk_fecerr
        get_blk_fecerr = read_blk_fecerr_value
    End Property

    Property Let set_blk_fecerr(aData)
        write_blk_fecerr_value = aData
        flag_blk_fecerr        = &H1
    End Property

    Property Get read_blk_fecerr
        read
        read_blk_fecerr = read_blk_fecerr_value
    End Property

    Property Let write_blk_fecerr(aData)
        set_blk_fecerr = aData
        write
    End Property

    Property Get get_udef_ctrlcode
        get_udef_ctrlcode = read_udef_ctrlcode_value
    End Property

    Property Let set_udef_ctrlcode(aData)
        write_udef_ctrlcode_value = aData
        flag_udef_ctrlcode        = &H1
    End Property

    Property Get read_udef_ctrlcode
        read
        read_udef_ctrlcode = read_udef_ctrlcode_value
    End Property

    Property Let write_udef_ctrlcode(aData)
        set_udef_ctrlcode = aData
        write
    End Property

    Property Get get_rcv_lpidle
        get_rcv_lpidle = read_rcv_lpidle_value
    End Property

    Property Let set_rcv_lpidle(aData)
        write_rcv_lpidle_value = aData
        flag_rcv_lpidle        = &H1
    End Property

    Property Get read_rcv_lpidle
        read
        read_rcv_lpidle = read_rcv_lpidle_value
    End Property

    Property Let write_rcv_lpidle(aData)
        set_rcv_lpidle = aData
        write
    End Property

    Property Get get_rx_evenOddAdj
        get_rx_evenOddAdj = read_rx_evenOddAdj_value
    End Property

    Property Let set_rx_evenOddAdj(aData)
        write_rx_evenOddAdj_value = aData
        flag_rx_evenOddAdj        = &H1
    End Property

    Property Get read_rx_evenOddAdj
        read
        read_rx_evenOddAdj = read_rx_evenOddAdj_value
    End Property

    Property Let write_rx_evenOddAdj(aData)
        set_rx_evenOddAdj = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_pam_err_o_is0_value = rightShift(data_low, 12) and &H1
        read_pam_err_o_isp1_value = rightShift(data_low, 11) and &H1
        read_pam_err_o_isn1_value = rightShift(data_low, 10) and &H1
        read_pam_err_e_is0_value = rightShift(data_low, 9) and &H1
        read_pam_err_e_isp1_value = rightShift(data_low, 8) and &H1
        read_pam_err_e_isn1_value = rightShift(data_low, 7) and &H1
        read_ptr_undef_value = rightShift(data_low, 6) and &H1
        read_ptr_outorder_value = rightShift(data_low, 5) and &H1
        read_ptr_miss_n_value = rightShift(data_low, 4) and &H1
        read_blk_fecerr_value = rightShift(data_low, 3) and &H1
        read_udef_ctrlcode_value = rightShift(data_low, 2) and &H1
        read_rcv_lpidle_value = rightShift(data_low, 1) and &H1
        rx_evenOddAdj_mask = &H1
        if data_low > LONG_MAX then
            if rx_evenOddAdj_mask = mask then
                read_rx_evenOddAdj_value = data_low
            else
                read_rx_evenOddAdj_value = (data_low - H8000_0000) and rx_evenOddAdj_mask
            end If
        else
            read_rx_evenOddAdj_value = data_low and rx_evenOddAdj_mask
        end If

    End Sub

    Sub write
        If flag_pam_err_o_is0 = &H0 or flag_pam_err_o_isp1 = &H0 or flag_pam_err_o_isn1 = &H0 or flag_pam_err_e_is0 = &H0 or flag_pam_err_e_isp1 = &H0 or flag_pam_err_e_isn1 = &H0 or flag_ptr_undef = &H0 or flag_ptr_outorder = &H0 or flag_ptr_miss_n = &H0 or flag_blk_fecerr = &H0 or flag_udef_ctrlcode = &H0 or flag_rcv_lpidle = &H0 or flag_rx_evenOddAdj = &H0 Then read
        If flag_pam_err_o_is0 = &H0 Then write_pam_err_o_is0_value = get_pam_err_o_is0
        If flag_pam_err_o_isp1 = &H0 Then write_pam_err_o_isp1_value = get_pam_err_o_isp1
        If flag_pam_err_o_isn1 = &H0 Then write_pam_err_o_isn1_value = get_pam_err_o_isn1
        If flag_pam_err_e_is0 = &H0 Then write_pam_err_e_is0_value = get_pam_err_e_is0
        If flag_pam_err_e_isp1 = &H0 Then write_pam_err_e_isp1_value = get_pam_err_e_isp1
        If flag_pam_err_e_isn1 = &H0 Then write_pam_err_e_isn1_value = get_pam_err_e_isn1
        If flag_ptr_undef = &H0 Then write_ptr_undef_value = get_ptr_undef
        If flag_ptr_outorder = &H0 Then write_ptr_outorder_value = get_ptr_outorder
        If flag_ptr_miss_n = &H0 Then write_ptr_miss_n_value = get_ptr_miss_n
        If flag_blk_fecerr = &H0 Then write_blk_fecerr_value = get_blk_fecerr
        If flag_udef_ctrlcode = &H0 Then write_udef_ctrlcode_value = get_udef_ctrlcode
        If flag_rcv_lpidle = &H0 Then write_rcv_lpidle_value = get_rcv_lpidle
        If flag_rx_evenOddAdj = &H0 Then write_rx_evenOddAdj_value = get_rx_evenOddAdj

        regValue = leftShift((write_pam_err_o_is0_value and &H1), 12) + leftShift((write_pam_err_o_isp1_value and &H1), 11) + leftShift((write_pam_err_o_isn1_value and &H1), 10) + leftShift((write_pam_err_e_is0_value and &H1), 9) + leftShift((write_pam_err_e_isp1_value and &H1), 8) + leftShift((write_pam_err_e_isn1_value and &H1), 7) + leftShift((write_ptr_undef_value and &H1), 6) + leftShift((write_ptr_outorder_value and &H1), 5) + leftShift((write_ptr_miss_n_value and &H1), 4) + leftShift((write_blk_fecerr_value and &H1), 3) + leftShift((write_udef_ctrlcode_value and &H1), 2) + leftShift((write_rcv_lpidle_value and &H1), 1) + leftShift((write_rx_evenOddAdj_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_pam_err_o_is0_value = rightShift(data_low, 12) and &H1
        read_pam_err_o_isp1_value = rightShift(data_low, 11) and &H1
        read_pam_err_o_isn1_value = rightShift(data_low, 10) and &H1
        read_pam_err_e_is0_value = rightShift(data_low, 9) and &H1
        read_pam_err_e_isp1_value = rightShift(data_low, 8) and &H1
        read_pam_err_e_isn1_value = rightShift(data_low, 7) and &H1
        read_ptr_undef_value = rightShift(data_low, 6) and &H1
        read_ptr_outorder_value = rightShift(data_low, 5) and &H1
        read_ptr_miss_n_value = rightShift(data_low, 4) and &H1
        read_blk_fecerr_value = rightShift(data_low, 3) and &H1
        read_udef_ctrlcode_value = rightShift(data_low, 2) and &H1
        read_rcv_lpidle_value = rightShift(data_low, 1) and &H1
        rx_evenOddAdj_mask = &H1
        if data_low > LONG_MAX then
            if rx_evenOddAdj_mask = mask then
                read_rx_evenOddAdj_value = data_low
            else
                read_rx_evenOddAdj_value = (data_low - H8000_0000) and rx_evenOddAdj_mask
            end If
        else
            read_rx_evenOddAdj_value = data_low and rx_evenOddAdj_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pam_err_o_is0_value = &H0
        flag_pam_err_o_is0        = &H0
        write_pam_err_o_isp1_value = &H0
        flag_pam_err_o_isp1        = &H0
        write_pam_err_o_isn1_value = &H0
        flag_pam_err_o_isn1        = &H0
        write_pam_err_e_is0_value = &H0
        flag_pam_err_e_is0        = &H0
        write_pam_err_e_isp1_value = &H0
        flag_pam_err_e_isp1        = &H0
        write_pam_err_e_isn1_value = &H0
        flag_pam_err_e_isn1        = &H0
        write_ptr_undef_value = &H0
        flag_ptr_undef        = &H0
        write_ptr_outorder_value = &H0
        flag_ptr_outorder        = &H0
        write_ptr_miss_n_value = &H0
        flag_ptr_miss_n        = &H0
        write_blk_fecerr_value = &H0
        flag_blk_fecerr        = &H0
        write_udef_ctrlcode_value = &H0
        flag_udef_ctrlcode        = &H0
        write_rcv_lpidle_value = &H0
        flag_rcv_lpidle        = &H0
        write_rx_evenOddAdj_value = &H0
        flag_rx_evenOddAdj        = &H0
    End Sub
End Class


'' @REGISTER : BR_GPCS_misc_status1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' link_status                                [15:15]          get_link_status
''                                                             set_link_status
''                                                             read_link_status
''                                                             write_link_status
''---------------------------------------------------------------------------------
'' loc_rcvr_status                            [14:14]          get_loc_rcvr_status
''                                                             set_loc_rcvr_status
''                                                             read_loc_rcvr_status
''                                                             write_loc_rcvr_status
''---------------------------------------------------------------------------------
'' loc_phy_ready                              [13:13]          get_loc_phy_ready
''                                                             set_loc_phy_ready
''                                                             read_loc_phy_ready
''                                                             write_loc_phy_ready
''---------------------------------------------------------------------------------
'' rem_rcvr_status                            [12:12]          get_rem_rcvr_status
''                                                             set_rem_rcvr_status
''                                                             read_rem_rcvr_status
''                                                             write_rem_rcvr_status
''---------------------------------------------------------------------------------
'' rem_phy_ready                              [11:11]          get_rem_phy_ready
''                                                             set_rem_phy_ready
''                                                             read_rem_phy_ready
''                                                             write_rem_phy_ready
''---------------------------------------------------------------------------------
'' pcs_rx_fault                               [10:10]          get_pcs_rx_fault
''                                                             set_pcs_rx_fault
''                                                             read_pcs_rx_fault
''                                                             write_pcs_rx_fault
''---------------------------------------------------------------------------------
'' rem_timing_lock_OK                         [9:9]            get_rem_timing_lock_OK
''                                                             set_rem_timing_lock_OK
''                                                             read_rem_timing_lock_OK
''                                                             write_rem_timing_lock_OK
''---------------------------------------------------------------------------------
'' timing_lock_OK                             [8:8]            get_timing_lock_OK
''                                                             set_timing_lock_OK
''                                                             read_timing_lock_OK
''                                                             write_timing_lock_OK
''---------------------------------------------------------------------------------
'' en_slave_tx                                [7:7]            get_en_slave_tx
''                                                             set_en_slave_tx
''                                                             read_en_slave_tx
''                                                             write_en_slave_tx
''---------------------------------------------------------------------------------
'' block_lock_drop                            [6:6]            get_block_lock_drop
''                                                             set_block_lock_drop
''                                                             read_block_lock_drop
''                                                             write_block_lock_drop
''---------------------------------------------------------------------------------
'' non_idle_ovfl                              [5:5]            get_non_idle_ovfl
''                                                             set_non_idle_ovfl
''                                                             read_non_idle_ovfl
''                                                             write_non_idle_ovfl
''---------------------------------------------------------------------------------
'' bad_crc_ovfl                               [4:4]            get_bad_crc_ovfl
''                                                             set_bad_crc_ovfl
''                                                             read_bad_crc_ovfl
''                                                             write_bad_crc_ovfl
''---------------------------------------------------------------------------------
'' pam_neg_one_err                            [3:3]            get_pam_neg_one_err
''                                                             set_pam_neg_one_err
''                                                             read_pam_neg_one_err
''                                                             write_pam_neg_one_err
''---------------------------------------------------------------------------------
'' pam_pos_one_err                            [2:2]            get_pam_pos_one_err
''                                                             set_pam_pos_one_err
''                                                             read_pam_pos_one_err
''                                                             write_pam_pos_one_err
''---------------------------------------------------------------------------------
'' pam_zero_err                               [1:1]            get_pam_zero_err
''                                                             set_pam_zero_err
''                                                             read_pam_zero_err
''                                                             write_pam_zero_err
''---------------------------------------------------------------------------------
'' scr_status                                 [0:0]            get_scr_status
''                                                             set_scr_status
''                                                             read_scr_status
''                                                             write_scr_status
''---------------------------------------------------------------------------------
Class REGISTER_BR_GPCS_misc_status1
    Private write_link_status_value
    Private read_link_status_value
    Private flag_link_status
    Private write_loc_rcvr_status_value
    Private read_loc_rcvr_status_value
    Private flag_loc_rcvr_status
    Private write_loc_phy_ready_value
    Private read_loc_phy_ready_value
    Private flag_loc_phy_ready
    Private write_rem_rcvr_status_value
    Private read_rem_rcvr_status_value
    Private flag_rem_rcvr_status
    Private write_rem_phy_ready_value
    Private read_rem_phy_ready_value
    Private flag_rem_phy_ready
    Private write_pcs_rx_fault_value
    Private read_pcs_rx_fault_value
    Private flag_pcs_rx_fault
    Private write_rem_timing_lock_OK_value
    Private read_rem_timing_lock_OK_value
    Private flag_rem_timing_lock_OK
    Private write_timing_lock_OK_value
    Private read_timing_lock_OK_value
    Private flag_timing_lock_OK
    Private write_en_slave_tx_value
    Private read_en_slave_tx_value
    Private flag_en_slave_tx
    Private write_block_lock_drop_value
    Private read_block_lock_drop_value
    Private flag_block_lock_drop
    Private write_non_idle_ovfl_value
    Private read_non_idle_ovfl_value
    Private flag_non_idle_ovfl
    Private write_bad_crc_ovfl_value
    Private read_bad_crc_ovfl_value
    Private flag_bad_crc_ovfl
    Private write_pam_neg_one_err_value
    Private read_pam_neg_one_err_value
    Private flag_pam_neg_one_err
    Private write_pam_pos_one_err_value
    Private read_pam_pos_one_err_value
    Private flag_pam_pos_one_err
    Private write_pam_zero_err_value
    Private read_pam_zero_err_value
    Private flag_pam_zero_err
    Private write_scr_status_value
    Private read_scr_status_value
    Private flag_scr_status

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H26
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_link_status
        get_link_status = read_link_status_value
    End Property

    Property Let set_link_status(aData)
        write_link_status_value = aData
        flag_link_status        = &H1
    End Property

    Property Get read_link_status
        read
        read_link_status = read_link_status_value
    End Property

    Property Let write_link_status(aData)
        set_link_status = aData
        write
    End Property

    Property Get get_loc_rcvr_status
        get_loc_rcvr_status = read_loc_rcvr_status_value
    End Property

    Property Let set_loc_rcvr_status(aData)
        write_loc_rcvr_status_value = aData
        flag_loc_rcvr_status        = &H1
    End Property

    Property Get read_loc_rcvr_status
        read
        read_loc_rcvr_status = read_loc_rcvr_status_value
    End Property

    Property Let write_loc_rcvr_status(aData)
        set_loc_rcvr_status = aData
        write
    End Property

    Property Get get_loc_phy_ready
        get_loc_phy_ready = read_loc_phy_ready_value
    End Property

    Property Let set_loc_phy_ready(aData)
        write_loc_phy_ready_value = aData
        flag_loc_phy_ready        = &H1
    End Property

    Property Get read_loc_phy_ready
        read
        read_loc_phy_ready = read_loc_phy_ready_value
    End Property

    Property Let write_loc_phy_ready(aData)
        set_loc_phy_ready = aData
        write
    End Property

    Property Get get_rem_rcvr_status
        get_rem_rcvr_status = read_rem_rcvr_status_value
    End Property

    Property Let set_rem_rcvr_status(aData)
        write_rem_rcvr_status_value = aData
        flag_rem_rcvr_status        = &H1
    End Property

    Property Get read_rem_rcvr_status
        read
        read_rem_rcvr_status = read_rem_rcvr_status_value
    End Property

    Property Let write_rem_rcvr_status(aData)
        set_rem_rcvr_status = aData
        write
    End Property

    Property Get get_rem_phy_ready
        get_rem_phy_ready = read_rem_phy_ready_value
    End Property

    Property Let set_rem_phy_ready(aData)
        write_rem_phy_ready_value = aData
        flag_rem_phy_ready        = &H1
    End Property

    Property Get read_rem_phy_ready
        read
        read_rem_phy_ready = read_rem_phy_ready_value
    End Property

    Property Let write_rem_phy_ready(aData)
        set_rem_phy_ready = aData
        write
    End Property

    Property Get get_pcs_rx_fault
        get_pcs_rx_fault = read_pcs_rx_fault_value
    End Property

    Property Let set_pcs_rx_fault(aData)
        write_pcs_rx_fault_value = aData
        flag_pcs_rx_fault        = &H1
    End Property

    Property Get read_pcs_rx_fault
        read
        read_pcs_rx_fault = read_pcs_rx_fault_value
    End Property

    Property Let write_pcs_rx_fault(aData)
        set_pcs_rx_fault = aData
        write
    End Property

    Property Get get_rem_timing_lock_OK
        get_rem_timing_lock_OK = read_rem_timing_lock_OK_value
    End Property

    Property Let set_rem_timing_lock_OK(aData)
        write_rem_timing_lock_OK_value = aData
        flag_rem_timing_lock_OK        = &H1
    End Property

    Property Get read_rem_timing_lock_OK
        read
        read_rem_timing_lock_OK = read_rem_timing_lock_OK_value
    End Property

    Property Let write_rem_timing_lock_OK(aData)
        set_rem_timing_lock_OK = aData
        write
    End Property

    Property Get get_timing_lock_OK
        get_timing_lock_OK = read_timing_lock_OK_value
    End Property

    Property Let set_timing_lock_OK(aData)
        write_timing_lock_OK_value = aData
        flag_timing_lock_OK        = &H1
    End Property

    Property Get read_timing_lock_OK
        read
        read_timing_lock_OK = read_timing_lock_OK_value
    End Property

    Property Let write_timing_lock_OK(aData)
        set_timing_lock_OK = aData
        write
    End Property

    Property Get get_en_slave_tx
        get_en_slave_tx = read_en_slave_tx_value
    End Property

    Property Let set_en_slave_tx(aData)
        write_en_slave_tx_value = aData
        flag_en_slave_tx        = &H1
    End Property

    Property Get read_en_slave_tx
        read
        read_en_slave_tx = read_en_slave_tx_value
    End Property

    Property Let write_en_slave_tx(aData)
        set_en_slave_tx = aData
        write
    End Property

    Property Get get_block_lock_drop
        get_block_lock_drop = read_block_lock_drop_value
    End Property

    Property Let set_block_lock_drop(aData)
        write_block_lock_drop_value = aData
        flag_block_lock_drop        = &H1
    End Property

    Property Get read_block_lock_drop
        read
        read_block_lock_drop = read_block_lock_drop_value
    End Property

    Property Let write_block_lock_drop(aData)
        set_block_lock_drop = aData
        write
    End Property

    Property Get get_non_idle_ovfl
        get_non_idle_ovfl = read_non_idle_ovfl_value
    End Property

    Property Let set_non_idle_ovfl(aData)
        write_non_idle_ovfl_value = aData
        flag_non_idle_ovfl        = &H1
    End Property

    Property Get read_non_idle_ovfl
        read
        read_non_idle_ovfl = read_non_idle_ovfl_value
    End Property

    Property Let write_non_idle_ovfl(aData)
        set_non_idle_ovfl = aData
        write
    End Property

    Property Get get_bad_crc_ovfl
        get_bad_crc_ovfl = read_bad_crc_ovfl_value
    End Property

    Property Let set_bad_crc_ovfl(aData)
        write_bad_crc_ovfl_value = aData
        flag_bad_crc_ovfl        = &H1
    End Property

    Property Get read_bad_crc_ovfl
        read
        read_bad_crc_ovfl = read_bad_crc_ovfl_value
    End Property

    Property Let write_bad_crc_ovfl(aData)
        set_bad_crc_ovfl = aData
        write
    End Property

    Property Get get_pam_neg_one_err
        get_pam_neg_one_err = read_pam_neg_one_err_value
    End Property

    Property Let set_pam_neg_one_err(aData)
        write_pam_neg_one_err_value = aData
        flag_pam_neg_one_err        = &H1
    End Property

    Property Get read_pam_neg_one_err
        read
        read_pam_neg_one_err = read_pam_neg_one_err_value
    End Property

    Property Let write_pam_neg_one_err(aData)
        set_pam_neg_one_err = aData
        write
    End Property

    Property Get get_pam_pos_one_err
        get_pam_pos_one_err = read_pam_pos_one_err_value
    End Property

    Property Let set_pam_pos_one_err(aData)
        write_pam_pos_one_err_value = aData
        flag_pam_pos_one_err        = &H1
    End Property

    Property Get read_pam_pos_one_err
        read
        read_pam_pos_one_err = read_pam_pos_one_err_value
    End Property

    Property Let write_pam_pos_one_err(aData)
        set_pam_pos_one_err = aData
        write
    End Property

    Property Get get_pam_zero_err
        get_pam_zero_err = read_pam_zero_err_value
    End Property

    Property Let set_pam_zero_err(aData)
        write_pam_zero_err_value = aData
        flag_pam_zero_err        = &H1
    End Property

    Property Get read_pam_zero_err
        read
        read_pam_zero_err = read_pam_zero_err_value
    End Property

    Property Let write_pam_zero_err(aData)
        set_pam_zero_err = aData
        write
    End Property

    Property Get get_scr_status
        get_scr_status = read_scr_status_value
    End Property

    Property Let set_scr_status(aData)
        write_scr_status_value = aData
        flag_scr_status        = &H1
    End Property

    Property Get read_scr_status
        read
        read_scr_status = read_scr_status_value
    End Property

    Property Let write_scr_status(aData)
        set_scr_status = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_link_status_value = rightShift(data_low, 15) and &H1
        read_loc_rcvr_status_value = rightShift(data_low, 14) and &H1
        read_loc_phy_ready_value = rightShift(data_low, 13) and &H1
        read_rem_rcvr_status_value = rightShift(data_low, 12) and &H1
        read_rem_phy_ready_value = rightShift(data_low, 11) and &H1
        read_pcs_rx_fault_value = rightShift(data_low, 10) and &H1
        read_rem_timing_lock_OK_value = rightShift(data_low, 9) and &H1
        read_timing_lock_OK_value = rightShift(data_low, 8) and &H1
        read_en_slave_tx_value = rightShift(data_low, 7) and &H1
        read_block_lock_drop_value = rightShift(data_low, 6) and &H1
        read_non_idle_ovfl_value = rightShift(data_low, 5) and &H1
        read_bad_crc_ovfl_value = rightShift(data_low, 4) and &H1
        read_pam_neg_one_err_value = rightShift(data_low, 3) and &H1
        read_pam_pos_one_err_value = rightShift(data_low, 2) and &H1
        read_pam_zero_err_value = rightShift(data_low, 1) and &H1
        scr_status_mask = &H1
        if data_low > LONG_MAX then
            if scr_status_mask = mask then
                read_scr_status_value = data_low
            else
                read_scr_status_value = (data_low - H8000_0000) and scr_status_mask
            end If
        else
            read_scr_status_value = data_low and scr_status_mask
        end If

    End Sub

    Sub write
        If flag_link_status = &H0 or flag_loc_rcvr_status = &H0 or flag_loc_phy_ready = &H0 or flag_rem_rcvr_status = &H0 or flag_rem_phy_ready = &H0 or flag_pcs_rx_fault = &H0 or flag_rem_timing_lock_OK = &H0 or flag_timing_lock_OK = &H0 or flag_en_slave_tx = &H0 or flag_block_lock_drop = &H0 or flag_non_idle_ovfl = &H0 or flag_bad_crc_ovfl = &H0 or flag_pam_neg_one_err = &H0 or flag_pam_pos_one_err = &H0 or flag_pam_zero_err = &H0 or flag_scr_status = &H0 Then read
        If flag_link_status = &H0 Then write_link_status_value = get_link_status
        If flag_loc_rcvr_status = &H0 Then write_loc_rcvr_status_value = get_loc_rcvr_status
        If flag_loc_phy_ready = &H0 Then write_loc_phy_ready_value = get_loc_phy_ready
        If flag_rem_rcvr_status = &H0 Then write_rem_rcvr_status_value = get_rem_rcvr_status
        If flag_rem_phy_ready = &H0 Then write_rem_phy_ready_value = get_rem_phy_ready
        If flag_pcs_rx_fault = &H0 Then write_pcs_rx_fault_value = get_pcs_rx_fault
        If flag_rem_timing_lock_OK = &H0 Then write_rem_timing_lock_OK_value = get_rem_timing_lock_OK
        If flag_timing_lock_OK = &H0 Then write_timing_lock_OK_value = get_timing_lock_OK
        If flag_en_slave_tx = &H0 Then write_en_slave_tx_value = get_en_slave_tx
        If flag_block_lock_drop = &H0 Then write_block_lock_drop_value = get_block_lock_drop
        If flag_non_idle_ovfl = &H0 Then write_non_idle_ovfl_value = get_non_idle_ovfl
        If flag_bad_crc_ovfl = &H0 Then write_bad_crc_ovfl_value = get_bad_crc_ovfl
        If flag_pam_neg_one_err = &H0 Then write_pam_neg_one_err_value = get_pam_neg_one_err
        If flag_pam_pos_one_err = &H0 Then write_pam_pos_one_err_value = get_pam_pos_one_err
        If flag_pam_zero_err = &H0 Then write_pam_zero_err_value = get_pam_zero_err
        If flag_scr_status = &H0 Then write_scr_status_value = get_scr_status

        regValue = leftShift((write_link_status_value and &H1), 15) + leftShift((write_loc_rcvr_status_value and &H1), 14) + leftShift((write_loc_phy_ready_value and &H1), 13) + leftShift((write_rem_rcvr_status_value and &H1), 12) + leftShift((write_rem_phy_ready_value and &H1), 11) + leftShift((write_pcs_rx_fault_value and &H1), 10) + leftShift((write_rem_timing_lock_OK_value and &H1), 9) + leftShift((write_timing_lock_OK_value and &H1), 8) + leftShift((write_en_slave_tx_value and &H1), 7) + leftShift((write_block_lock_drop_value and &H1), 6) + leftShift((write_non_idle_ovfl_value and &H1), 5) + leftShift((write_bad_crc_ovfl_value and &H1), 4) + leftShift((write_pam_neg_one_err_value and &H1), 3) + leftShift((write_pam_pos_one_err_value and &H1), 2) + leftShift((write_pam_zero_err_value and &H1), 1) + leftShift((write_scr_status_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_link_status_value = rightShift(data_low, 15) and &H1
        read_loc_rcvr_status_value = rightShift(data_low, 14) and &H1
        read_loc_phy_ready_value = rightShift(data_low, 13) and &H1
        read_rem_rcvr_status_value = rightShift(data_low, 12) and &H1
        read_rem_phy_ready_value = rightShift(data_low, 11) and &H1
        read_pcs_rx_fault_value = rightShift(data_low, 10) and &H1
        read_rem_timing_lock_OK_value = rightShift(data_low, 9) and &H1
        read_timing_lock_OK_value = rightShift(data_low, 8) and &H1
        read_en_slave_tx_value = rightShift(data_low, 7) and &H1
        read_block_lock_drop_value = rightShift(data_low, 6) and &H1
        read_non_idle_ovfl_value = rightShift(data_low, 5) and &H1
        read_bad_crc_ovfl_value = rightShift(data_low, 4) and &H1
        read_pam_neg_one_err_value = rightShift(data_low, 3) and &H1
        read_pam_pos_one_err_value = rightShift(data_low, 2) and &H1
        read_pam_zero_err_value = rightShift(data_low, 1) and &H1
        scr_status_mask = &H1
        if data_low > LONG_MAX then
            if scr_status_mask = mask then
                read_scr_status_value = data_low
            else
                read_scr_status_value = (data_low - H8000_0000) and scr_status_mask
            end If
        else
            read_scr_status_value = data_low and scr_status_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_link_status_value = &H0
        flag_link_status        = &H0
        write_loc_rcvr_status_value = &H0
        flag_loc_rcvr_status        = &H0
        write_loc_phy_ready_value = &H0
        flag_loc_phy_ready        = &H0
        write_rem_rcvr_status_value = &H0
        flag_rem_rcvr_status        = &H0
        write_rem_phy_ready_value = &H0
        flag_rem_phy_ready        = &H0
        write_pcs_rx_fault_value = &H0
        flag_pcs_rx_fault        = &H0
        write_rem_timing_lock_OK_value = &H0
        flag_rem_timing_lock_OK        = &H0
        write_timing_lock_OK_value = &H0
        flag_timing_lock_OK        = &H0
        write_en_slave_tx_value = &H0
        flag_en_slave_tx        = &H0
        write_block_lock_drop_value = &H0
        flag_block_lock_drop        = &H0
        write_non_idle_ovfl_value = &H0
        flag_non_idle_ovfl        = &H0
        write_bad_crc_ovfl_value = &H0
        flag_bad_crc_ovfl        = &H0
        write_pam_neg_one_err_value = &H0
        flag_pam_neg_one_err        = &H0
        write_pam_pos_one_err_value = &H0
        flag_pam_pos_one_err        = &H0
        write_pam_zero_err_value = &H0
        flag_pam_zero_err        = &H0
        write_scr_status_value = &H0
        flag_scr_status        = &H0
    End Sub
End Class


'' @REGISTER : BR_GPCS_misc_status2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' bad_crc16_cnt                              [15:0]           get_bad_crc16_cnt
''                                                             set_bad_crc16_cnt
''                                                             read_bad_crc16_cnt
''                                                             write_bad_crc16_cnt
''---------------------------------------------------------------------------------
Class REGISTER_BR_GPCS_misc_status2
    Private write_bad_crc16_cnt_value
    Private read_bad_crc16_cnt_value
    Private flag_bad_crc16_cnt

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

    Property Get get_bad_crc16_cnt
        get_bad_crc16_cnt = read_bad_crc16_cnt_value
    End Property

    Property Let set_bad_crc16_cnt(aData)
        write_bad_crc16_cnt_value = aData
        flag_bad_crc16_cnt        = &H1
    End Property

    Property Get read_bad_crc16_cnt
        read
        read_bad_crc16_cnt = read_bad_crc16_cnt_value
    End Property

    Property Let write_bad_crc16_cnt(aData)
        set_bad_crc16_cnt = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        bad_crc16_cnt_mask = &Hffff
        if data_low > LONG_MAX then
            if bad_crc16_cnt_mask = mask then
                read_bad_crc16_cnt_value = data_low
            else
                read_bad_crc16_cnt_value = (data_low - H8000_0000) and bad_crc16_cnt_mask
            end If
        else
            read_bad_crc16_cnt_value = data_low and bad_crc16_cnt_mask
        end If

    End Sub

    Sub write
        If flag_bad_crc16_cnt = &H0 Then read
        If flag_bad_crc16_cnt = &H0 Then write_bad_crc16_cnt_value = get_bad_crc16_cnt

        regValue = leftShift((write_bad_crc16_cnt_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        bad_crc16_cnt_mask = &Hffff
        if data_low > LONG_MAX then
            if bad_crc16_cnt_mask = mask then
                read_bad_crc16_cnt_value = data_low
            else
                read_bad_crc16_cnt_value = (data_low - H8000_0000) and bad_crc16_cnt_mask
            end If
        else
            read_bad_crc16_cnt_value = data_low and bad_crc16_cnt_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_bad_crc16_cnt_value = &H0
        flag_bad_crc16_cnt        = &H0
    End Sub
End Class


'' @REGISTER : BR_GPCS_pcs_misc_ctl0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' soft_reset_pcs                             [15:15]          get_soft_reset_pcs
''                                                             set_soft_reset_pcs
''                                                             read_soft_reset_pcs
''                                                             write_soft_reset_pcs
''---------------------------------------------------------------------------------
'' soft_reset_txpcs                           [14:14]          get_soft_reset_txpcs
''                                                             set_soft_reset_txpcs
''                                                             read_soft_reset_txpcs
''                                                             write_soft_reset_txpcs
''---------------------------------------------------------------------------------
'' soft_reset_rxpcs                           [13:13]          get_soft_reset_rxpcs
''                                                             set_soft_reset_rxpcs
''                                                             read_soft_reset_rxpcs
''                                                             write_soft_reset_rxpcs
''---------------------------------------------------------------------------------
'' byp_fec_syndr                              [12:12]          get_byp_fec_syndr
''                                                             set_byp_fec_syndr
''                                                             read_byp_fec_syndr
''                                                             write_byp_fec_syndr
''---------------------------------------------------------------------------------
'' soft_rstn_fecdec                           [11:11]          get_soft_rstn_fecdec
''                                                             set_soft_rstn_fecdec
''                                                             read_soft_rstn_fecdec
''                                                             write_soft_rstn_fecdec
''---------------------------------------------------------------------------------
'' soft_rstn_fecenc                           [10:10]          get_soft_rstn_fecenc
''                                                             set_soft_rstn_fecenc
''                                                             read_soft_rstn_fecenc
''                                                             write_soft_rstn_fecenc
''---------------------------------------------------------------------------------
'' byp_fec_dec_syndr                          [9:9]            get_byp_fec_dec_syndr
''                                                             set_byp_fec_dec_syndr
''                                                             read_byp_fec_dec_syndr
''                                                             write_byp_fec_dec_syndr
''---------------------------------------------------------------------------------
'' byp_fec_enc_syndr                          [8:8]            get_byp_fec_enc_syndr
''                                                             set_byp_fec_enc_syndr
''                                                             read_byp_fec_enc_syndr
''                                                             write_byp_fec_enc_syndr
''---------------------------------------------------------------------------------
'' pcs_rx_fault_dis                           [7:7]            get_pcs_rx_fault_dis
''                                                             set_pcs_rx_fault_dis
''                                                             read_pcs_rx_fault_dis
''                                                             write_pcs_rx_fault_dis
''---------------------------------------------------------------------------------
'' byp_pam_chk                                [6:6]            get_byp_pam_chk
''                                                             set_byp_pam_chk
''                                                             read_byp_pam_chk
''                                                             write_byp_pam_chk
''---------------------------------------------------------------------------------
'' countdown_crc_en                           [5:5]            get_countdown_crc_en
''                                                             set_countdown_crc_en
''                                                             read_countdown_crc_en
''                                                             write_countdown_crc_en
''---------------------------------------------------------------------------------
'' dec81_rpt_en                               [4:4]            get_dec81_rpt_en
''                                                             set_dec81_rpt_en
''                                                             read_dec81_rpt_en
''                                                             write_dec81_rpt_en
''---------------------------------------------------------------------------------
'' drv_pma_dis                                [3:3]            get_drv_pma_dis
''                                                             set_drv_pma_dis
''                                                             read_drv_pma_dis
''                                                             write_drv_pma_dis
''---------------------------------------------------------------------------------
'' fec_dec_bypass_en                          [2:2]            get_fec_dec_bypass_en
''                                                             set_fec_dec_bypass_en
''                                                             read_fec_dec_bypass_en
''                                                             write_fec_dec_bypass_en
''---------------------------------------------------------------------------------
'' fec_enc_bypass_en                          [1:1]            get_fec_enc_bypass_en
''                                                             set_fec_enc_bypass_en
''                                                             read_fec_enc_bypass_en
''                                                             write_fec_enc_bypass_en
''---------------------------------------------------------------------------------
'' patch_rxstate_en                           [0:0]            get_patch_rxstate_en
''                                                             set_patch_rxstate_en
''                                                             read_patch_rxstate_en
''                                                             write_patch_rxstate_en
''---------------------------------------------------------------------------------
Class REGISTER_BR_GPCS_pcs_misc_ctl0
    Private write_soft_reset_pcs_value
    Private read_soft_reset_pcs_value
    Private flag_soft_reset_pcs
    Private write_soft_reset_txpcs_value
    Private read_soft_reset_txpcs_value
    Private flag_soft_reset_txpcs
    Private write_soft_reset_rxpcs_value
    Private read_soft_reset_rxpcs_value
    Private flag_soft_reset_rxpcs
    Private write_byp_fec_syndr_value
    Private read_byp_fec_syndr_value
    Private flag_byp_fec_syndr
    Private write_soft_rstn_fecdec_value
    Private read_soft_rstn_fecdec_value
    Private flag_soft_rstn_fecdec
    Private write_soft_rstn_fecenc_value
    Private read_soft_rstn_fecenc_value
    Private flag_soft_rstn_fecenc
    Private write_byp_fec_dec_syndr_value
    Private read_byp_fec_dec_syndr_value
    Private flag_byp_fec_dec_syndr
    Private write_byp_fec_enc_syndr_value
    Private read_byp_fec_enc_syndr_value
    Private flag_byp_fec_enc_syndr
    Private write_pcs_rx_fault_dis_value
    Private read_pcs_rx_fault_dis_value
    Private flag_pcs_rx_fault_dis
    Private write_byp_pam_chk_value
    Private read_byp_pam_chk_value
    Private flag_byp_pam_chk
    Private write_countdown_crc_en_value
    Private read_countdown_crc_en_value
    Private flag_countdown_crc_en
    Private write_dec81_rpt_en_value
    Private read_dec81_rpt_en_value
    Private flag_dec81_rpt_en
    Private write_drv_pma_dis_value
    Private read_drv_pma_dis_value
    Private flag_drv_pma_dis
    Private write_fec_dec_bypass_en_value
    Private read_fec_dec_bypass_en_value
    Private flag_fec_dec_bypass_en
    Private write_fec_enc_bypass_en_value
    Private read_fec_enc_bypass_en_value
    Private flag_fec_enc_bypass_en
    Private write_patch_rxstate_en_value
    Private read_patch_rxstate_en_value
    Private flag_patch_rxstate_en

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H40
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_soft_reset_pcs
        get_soft_reset_pcs = read_soft_reset_pcs_value
    End Property

    Property Let set_soft_reset_pcs(aData)
        write_soft_reset_pcs_value = aData
        flag_soft_reset_pcs        = &H1
    End Property

    Property Get read_soft_reset_pcs
        read
        read_soft_reset_pcs = read_soft_reset_pcs_value
    End Property

    Property Let write_soft_reset_pcs(aData)
        set_soft_reset_pcs = aData
        write
    End Property

    Property Get get_soft_reset_txpcs
        get_soft_reset_txpcs = read_soft_reset_txpcs_value
    End Property

    Property Let set_soft_reset_txpcs(aData)
        write_soft_reset_txpcs_value = aData
        flag_soft_reset_txpcs        = &H1
    End Property

    Property Get read_soft_reset_txpcs
        read
        read_soft_reset_txpcs = read_soft_reset_txpcs_value
    End Property

    Property Let write_soft_reset_txpcs(aData)
        set_soft_reset_txpcs = aData
        write
    End Property

    Property Get get_soft_reset_rxpcs
        get_soft_reset_rxpcs = read_soft_reset_rxpcs_value
    End Property

    Property Let set_soft_reset_rxpcs(aData)
        write_soft_reset_rxpcs_value = aData
        flag_soft_reset_rxpcs        = &H1
    End Property

    Property Get read_soft_reset_rxpcs
        read
        read_soft_reset_rxpcs = read_soft_reset_rxpcs_value
    End Property

    Property Let write_soft_reset_rxpcs(aData)
        set_soft_reset_rxpcs = aData
        write
    End Property

    Property Get get_byp_fec_syndr
        get_byp_fec_syndr = read_byp_fec_syndr_value
    End Property

    Property Let set_byp_fec_syndr(aData)
        write_byp_fec_syndr_value = aData
        flag_byp_fec_syndr        = &H1
    End Property

    Property Get read_byp_fec_syndr
        read
        read_byp_fec_syndr = read_byp_fec_syndr_value
    End Property

    Property Let write_byp_fec_syndr(aData)
        set_byp_fec_syndr = aData
        write
    End Property

    Property Get get_soft_rstn_fecdec
        get_soft_rstn_fecdec = read_soft_rstn_fecdec_value
    End Property

    Property Let set_soft_rstn_fecdec(aData)
        write_soft_rstn_fecdec_value = aData
        flag_soft_rstn_fecdec        = &H1
    End Property

    Property Get read_soft_rstn_fecdec
        read
        read_soft_rstn_fecdec = read_soft_rstn_fecdec_value
    End Property

    Property Let write_soft_rstn_fecdec(aData)
        set_soft_rstn_fecdec = aData
        write
    End Property

    Property Get get_soft_rstn_fecenc
        get_soft_rstn_fecenc = read_soft_rstn_fecenc_value
    End Property

    Property Let set_soft_rstn_fecenc(aData)
        write_soft_rstn_fecenc_value = aData
        flag_soft_rstn_fecenc        = &H1
    End Property

    Property Get read_soft_rstn_fecenc
        read
        read_soft_rstn_fecenc = read_soft_rstn_fecenc_value
    End Property

    Property Let write_soft_rstn_fecenc(aData)
        set_soft_rstn_fecenc = aData
        write
    End Property

    Property Get get_byp_fec_dec_syndr
        get_byp_fec_dec_syndr = read_byp_fec_dec_syndr_value
    End Property

    Property Let set_byp_fec_dec_syndr(aData)
        write_byp_fec_dec_syndr_value = aData
        flag_byp_fec_dec_syndr        = &H1
    End Property

    Property Get read_byp_fec_dec_syndr
        read
        read_byp_fec_dec_syndr = read_byp_fec_dec_syndr_value
    End Property

    Property Let write_byp_fec_dec_syndr(aData)
        set_byp_fec_dec_syndr = aData
        write
    End Property

    Property Get get_byp_fec_enc_syndr
        get_byp_fec_enc_syndr = read_byp_fec_enc_syndr_value
    End Property

    Property Let set_byp_fec_enc_syndr(aData)
        write_byp_fec_enc_syndr_value = aData
        flag_byp_fec_enc_syndr        = &H1
    End Property

    Property Get read_byp_fec_enc_syndr
        read
        read_byp_fec_enc_syndr = read_byp_fec_enc_syndr_value
    End Property

    Property Let write_byp_fec_enc_syndr(aData)
        set_byp_fec_enc_syndr = aData
        write
    End Property

    Property Get get_pcs_rx_fault_dis
        get_pcs_rx_fault_dis = read_pcs_rx_fault_dis_value
    End Property

    Property Let set_pcs_rx_fault_dis(aData)
        write_pcs_rx_fault_dis_value = aData
        flag_pcs_rx_fault_dis        = &H1
    End Property

    Property Get read_pcs_rx_fault_dis
        read
        read_pcs_rx_fault_dis = read_pcs_rx_fault_dis_value
    End Property

    Property Let write_pcs_rx_fault_dis(aData)
        set_pcs_rx_fault_dis = aData
        write
    End Property

    Property Get get_byp_pam_chk
        get_byp_pam_chk = read_byp_pam_chk_value
    End Property

    Property Let set_byp_pam_chk(aData)
        write_byp_pam_chk_value = aData
        flag_byp_pam_chk        = &H1
    End Property

    Property Get read_byp_pam_chk
        read
        read_byp_pam_chk = read_byp_pam_chk_value
    End Property

    Property Let write_byp_pam_chk(aData)
        set_byp_pam_chk = aData
        write
    End Property

    Property Get get_countdown_crc_en
        get_countdown_crc_en = read_countdown_crc_en_value
    End Property

    Property Let set_countdown_crc_en(aData)
        write_countdown_crc_en_value = aData
        flag_countdown_crc_en        = &H1
    End Property

    Property Get read_countdown_crc_en
        read
        read_countdown_crc_en = read_countdown_crc_en_value
    End Property

    Property Let write_countdown_crc_en(aData)
        set_countdown_crc_en = aData
        write
    End Property

    Property Get get_dec81_rpt_en
        get_dec81_rpt_en = read_dec81_rpt_en_value
    End Property

    Property Let set_dec81_rpt_en(aData)
        write_dec81_rpt_en_value = aData
        flag_dec81_rpt_en        = &H1
    End Property

    Property Get read_dec81_rpt_en
        read
        read_dec81_rpt_en = read_dec81_rpt_en_value
    End Property

    Property Let write_dec81_rpt_en(aData)
        set_dec81_rpt_en = aData
        write
    End Property

    Property Get get_drv_pma_dis
        get_drv_pma_dis = read_drv_pma_dis_value
    End Property

    Property Let set_drv_pma_dis(aData)
        write_drv_pma_dis_value = aData
        flag_drv_pma_dis        = &H1
    End Property

    Property Get read_drv_pma_dis
        read
        read_drv_pma_dis = read_drv_pma_dis_value
    End Property

    Property Let write_drv_pma_dis(aData)
        set_drv_pma_dis = aData
        write
    End Property

    Property Get get_fec_dec_bypass_en
        get_fec_dec_bypass_en = read_fec_dec_bypass_en_value
    End Property

    Property Let set_fec_dec_bypass_en(aData)
        write_fec_dec_bypass_en_value = aData
        flag_fec_dec_bypass_en        = &H1
    End Property

    Property Get read_fec_dec_bypass_en
        read
        read_fec_dec_bypass_en = read_fec_dec_bypass_en_value
    End Property

    Property Let write_fec_dec_bypass_en(aData)
        set_fec_dec_bypass_en = aData
        write
    End Property

    Property Get get_fec_enc_bypass_en
        get_fec_enc_bypass_en = read_fec_enc_bypass_en_value
    End Property

    Property Let set_fec_enc_bypass_en(aData)
        write_fec_enc_bypass_en_value = aData
        flag_fec_enc_bypass_en        = &H1
    End Property

    Property Get read_fec_enc_bypass_en
        read
        read_fec_enc_bypass_en = read_fec_enc_bypass_en_value
    End Property

    Property Let write_fec_enc_bypass_en(aData)
        set_fec_enc_bypass_en = aData
        write
    End Property

    Property Get get_patch_rxstate_en
        get_patch_rxstate_en = read_patch_rxstate_en_value
    End Property

    Property Let set_patch_rxstate_en(aData)
        write_patch_rxstate_en_value = aData
        flag_patch_rxstate_en        = &H1
    End Property

    Property Get read_patch_rxstate_en
        read
        read_patch_rxstate_en = read_patch_rxstate_en_value
    End Property

    Property Let write_patch_rxstate_en(aData)
        set_patch_rxstate_en = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_soft_reset_pcs_value = rightShift(data_low, 15) and &H1
        read_soft_reset_txpcs_value = rightShift(data_low, 14) and &H1
        read_soft_reset_rxpcs_value = rightShift(data_low, 13) and &H1
        read_byp_fec_syndr_value = rightShift(data_low, 12) and &H1
        read_soft_rstn_fecdec_value = rightShift(data_low, 11) and &H1
        read_soft_rstn_fecenc_value = rightShift(data_low, 10) and &H1
        read_byp_fec_dec_syndr_value = rightShift(data_low, 9) and &H1
        read_byp_fec_enc_syndr_value = rightShift(data_low, 8) and &H1
        read_pcs_rx_fault_dis_value = rightShift(data_low, 7) and &H1
        read_byp_pam_chk_value = rightShift(data_low, 6) and &H1
        read_countdown_crc_en_value = rightShift(data_low, 5) and &H1
        read_dec81_rpt_en_value = rightShift(data_low, 4) and &H1
        read_drv_pma_dis_value = rightShift(data_low, 3) and &H1
        read_fec_dec_bypass_en_value = rightShift(data_low, 2) and &H1
        read_fec_enc_bypass_en_value = rightShift(data_low, 1) and &H1
        patch_rxstate_en_mask = &H1
        if data_low > LONG_MAX then
            if patch_rxstate_en_mask = mask then
                read_patch_rxstate_en_value = data_low
            else
                read_patch_rxstate_en_value = (data_low - H8000_0000) and patch_rxstate_en_mask
            end If
        else
            read_patch_rxstate_en_value = data_low and patch_rxstate_en_mask
        end If

    End Sub

    Sub write
        If flag_soft_reset_pcs = &H0 or flag_soft_reset_txpcs = &H0 or flag_soft_reset_rxpcs = &H0 or flag_byp_fec_syndr = &H0 or flag_soft_rstn_fecdec = &H0 or flag_soft_rstn_fecenc = &H0 or flag_byp_fec_dec_syndr = &H0 or flag_byp_fec_enc_syndr = &H0 or flag_pcs_rx_fault_dis = &H0 or flag_byp_pam_chk = &H0 or flag_countdown_crc_en = &H0 or flag_dec81_rpt_en = &H0 or flag_drv_pma_dis = &H0 or flag_fec_dec_bypass_en = &H0 or flag_fec_enc_bypass_en = &H0 or flag_patch_rxstate_en = &H0 Then read
        If flag_soft_reset_pcs = &H0 Then write_soft_reset_pcs_value = get_soft_reset_pcs
        If flag_soft_reset_txpcs = &H0 Then write_soft_reset_txpcs_value = get_soft_reset_txpcs
        If flag_soft_reset_rxpcs = &H0 Then write_soft_reset_rxpcs_value = get_soft_reset_rxpcs
        If flag_byp_fec_syndr = &H0 Then write_byp_fec_syndr_value = get_byp_fec_syndr
        If flag_soft_rstn_fecdec = &H0 Then write_soft_rstn_fecdec_value = get_soft_rstn_fecdec
        If flag_soft_rstn_fecenc = &H0 Then write_soft_rstn_fecenc_value = get_soft_rstn_fecenc
        If flag_byp_fec_dec_syndr = &H0 Then write_byp_fec_dec_syndr_value = get_byp_fec_dec_syndr
        If flag_byp_fec_enc_syndr = &H0 Then write_byp_fec_enc_syndr_value = get_byp_fec_enc_syndr
        If flag_pcs_rx_fault_dis = &H0 Then write_pcs_rx_fault_dis_value = get_pcs_rx_fault_dis
        If flag_byp_pam_chk = &H0 Then write_byp_pam_chk_value = get_byp_pam_chk
        If flag_countdown_crc_en = &H0 Then write_countdown_crc_en_value = get_countdown_crc_en
        If flag_dec81_rpt_en = &H0 Then write_dec81_rpt_en_value = get_dec81_rpt_en
        If flag_drv_pma_dis = &H0 Then write_drv_pma_dis_value = get_drv_pma_dis
        If flag_fec_dec_bypass_en = &H0 Then write_fec_dec_bypass_en_value = get_fec_dec_bypass_en
        If flag_fec_enc_bypass_en = &H0 Then write_fec_enc_bypass_en_value = get_fec_enc_bypass_en
        If flag_patch_rxstate_en = &H0 Then write_patch_rxstate_en_value = get_patch_rxstate_en

        regValue = leftShift((write_soft_reset_pcs_value and &H1), 15) + leftShift((write_soft_reset_txpcs_value and &H1), 14) + leftShift((write_soft_reset_rxpcs_value and &H1), 13) + leftShift((write_byp_fec_syndr_value and &H1), 12) + leftShift((write_soft_rstn_fecdec_value and &H1), 11) + leftShift((write_soft_rstn_fecenc_value and &H1), 10) + leftShift((write_byp_fec_dec_syndr_value and &H1), 9) + leftShift((write_byp_fec_enc_syndr_value and &H1), 8) + leftShift((write_pcs_rx_fault_dis_value and &H1), 7) + leftShift((write_byp_pam_chk_value and &H1), 6) + leftShift((write_countdown_crc_en_value and &H1), 5) + leftShift((write_dec81_rpt_en_value and &H1), 4) + leftShift((write_drv_pma_dis_value and &H1), 3) + leftShift((write_fec_dec_bypass_en_value and &H1), 2) + leftShift((write_fec_enc_bypass_en_value and &H1), 1) + leftShift((write_patch_rxstate_en_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_soft_reset_pcs_value = rightShift(data_low, 15) and &H1
        read_soft_reset_txpcs_value = rightShift(data_low, 14) and &H1
        read_soft_reset_rxpcs_value = rightShift(data_low, 13) and &H1
        read_byp_fec_syndr_value = rightShift(data_low, 12) and &H1
        read_soft_rstn_fecdec_value = rightShift(data_low, 11) and &H1
        read_soft_rstn_fecenc_value = rightShift(data_low, 10) and &H1
        read_byp_fec_dec_syndr_value = rightShift(data_low, 9) and &H1
        read_byp_fec_enc_syndr_value = rightShift(data_low, 8) and &H1
        read_pcs_rx_fault_dis_value = rightShift(data_low, 7) and &H1
        read_byp_pam_chk_value = rightShift(data_low, 6) and &H1
        read_countdown_crc_en_value = rightShift(data_low, 5) and &H1
        read_dec81_rpt_en_value = rightShift(data_low, 4) and &H1
        read_drv_pma_dis_value = rightShift(data_low, 3) and &H1
        read_fec_dec_bypass_en_value = rightShift(data_low, 2) and &H1
        read_fec_enc_bypass_en_value = rightShift(data_low, 1) and &H1
        patch_rxstate_en_mask = &H1
        if data_low > LONG_MAX then
            if patch_rxstate_en_mask = mask then
                read_patch_rxstate_en_value = data_low
            else
                read_patch_rxstate_en_value = (data_low - H8000_0000) and patch_rxstate_en_mask
            end If
        else
            read_patch_rxstate_en_value = data_low and patch_rxstate_en_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_soft_reset_pcs_value = &H0
        flag_soft_reset_pcs        = &H0
        write_soft_reset_txpcs_value = &H0
        flag_soft_reset_txpcs        = &H0
        write_soft_reset_rxpcs_value = &H0
        flag_soft_reset_rxpcs        = &H0
        write_byp_fec_syndr_value = &H0
        flag_byp_fec_syndr        = &H0
        write_soft_rstn_fecdec_value = &H0
        flag_soft_rstn_fecdec        = &H0
        write_soft_rstn_fecenc_value = &H0
        flag_soft_rstn_fecenc        = &H0
        write_byp_fec_dec_syndr_value = &H0
        flag_byp_fec_dec_syndr        = &H0
        write_byp_fec_enc_syndr_value = &H0
        flag_byp_fec_enc_syndr        = &H0
        write_pcs_rx_fault_dis_value = &H0
        flag_pcs_rx_fault_dis        = &H0
        write_byp_pam_chk_value = &H0
        flag_byp_pam_chk        = &H0
        write_countdown_crc_en_value = &H0
        flag_countdown_crc_en        = &H0
        write_dec81_rpt_en_value = &H0
        flag_dec81_rpt_en        = &H0
        write_drv_pma_dis_value = &H0
        flag_drv_pma_dis        = &H0
        write_fec_dec_bypass_en_value = &H0
        flag_fec_dec_bypass_en        = &H0
        write_fec_enc_bypass_en_value = &H0
        flag_fec_enc_bypass_en        = &H0
        write_patch_rxstate_en_value = &H0
        flag_patch_rxstate_en        = &H0
    End Sub
End Class


'' @REGISTER : BR_GPCS_txfifo_ramctl0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' tx_lvm                                     [14:14]          get_tx_lvm
''                                                             set_tx_lvm
''                                                             read_tx_lvm
''                                                             write_tx_lvm
''---------------------------------------------------------------------------------
'' tx_rds                                     [13:13]          get_tx_rds
''                                                             set_tx_rds
''                                                             read_tx_rds
''                                                             write_tx_rds
''---------------------------------------------------------------------------------
'' tx_ram_byp                                 [12:12]          get_tx_ram_byp
''                                                             set_tx_ram_byp
''                                                             read_tx_ram_byp
''                                                             write_tx_ram_byp
''---------------------------------------------------------------------------------
'' tx_tm                                      [11:0]           get_tx_tm
''                                                             set_tx_tm
''                                                             read_tx_tm
''                                                             write_tx_tm
''---------------------------------------------------------------------------------
Class REGISTER_BR_GPCS_txfifo_ramctl0
    Private write_tx_lvm_value
    Private read_tx_lvm_value
    Private flag_tx_lvm
    Private write_tx_rds_value
    Private read_tx_rds_value
    Private flag_tx_rds
    Private write_tx_ram_byp_value
    Private read_tx_ram_byp_value
    Private flag_tx_ram_byp
    Private write_tx_tm_value
    Private read_tx_tm_value
    Private flag_tx_tm

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H42
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_tx_lvm
        get_tx_lvm = read_tx_lvm_value
    End Property

    Property Let set_tx_lvm(aData)
        write_tx_lvm_value = aData
        flag_tx_lvm        = &H1
    End Property

    Property Get read_tx_lvm
        read
        read_tx_lvm = read_tx_lvm_value
    End Property

    Property Let write_tx_lvm(aData)
        set_tx_lvm = aData
        write
    End Property

    Property Get get_tx_rds
        get_tx_rds = read_tx_rds_value
    End Property

    Property Let set_tx_rds(aData)
        write_tx_rds_value = aData
        flag_tx_rds        = &H1
    End Property

    Property Get read_tx_rds
        read
        read_tx_rds = read_tx_rds_value
    End Property

    Property Let write_tx_rds(aData)
        set_tx_rds = aData
        write
    End Property

    Property Get get_tx_ram_byp
        get_tx_ram_byp = read_tx_ram_byp_value
    End Property

    Property Let set_tx_ram_byp(aData)
        write_tx_ram_byp_value = aData
        flag_tx_ram_byp        = &H1
    End Property

    Property Get read_tx_ram_byp
        read
        read_tx_ram_byp = read_tx_ram_byp_value
    End Property

    Property Let write_tx_ram_byp(aData)
        set_tx_ram_byp = aData
        write
    End Property

    Property Get get_tx_tm
        get_tx_tm = read_tx_tm_value
    End Property

    Property Let set_tx_tm(aData)
        write_tx_tm_value = aData
        flag_tx_tm        = &H1
    End Property

    Property Get read_tx_tm
        read
        read_tx_tm = read_tx_tm_value
    End Property

    Property Let write_tx_tm(aData)
        set_tx_tm = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_tx_lvm_value = rightShift(data_low, 14) and &H1
        read_tx_rds_value = rightShift(data_low, 13) and &H1
        read_tx_ram_byp_value = rightShift(data_low, 12) and &H1
        tx_tm_mask = &Hfff
        if data_low > LONG_MAX then
            if tx_tm_mask = mask then
                read_tx_tm_value = data_low
            else
                read_tx_tm_value = (data_low - H8000_0000) and tx_tm_mask
            end If
        else
            read_tx_tm_value = data_low and tx_tm_mask
        end If

    End Sub

    Sub write
        If flag_tx_lvm = &H0 or flag_tx_rds = &H0 or flag_tx_ram_byp = &H0 or flag_tx_tm = &H0 Then read
        If flag_tx_lvm = &H0 Then write_tx_lvm_value = get_tx_lvm
        If flag_tx_rds = &H0 Then write_tx_rds_value = get_tx_rds
        If flag_tx_ram_byp = &H0 Then write_tx_ram_byp_value = get_tx_ram_byp
        If flag_tx_tm = &H0 Then write_tx_tm_value = get_tx_tm

        regValue = leftShift((write_tx_lvm_value and &H1), 14) + leftShift((write_tx_rds_value and &H1), 13) + leftShift((write_tx_ram_byp_value and &H1), 12) + leftShift((write_tx_tm_value and &Hfff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_tx_lvm_value = rightShift(data_low, 14) and &H1
        read_tx_rds_value = rightShift(data_low, 13) and &H1
        read_tx_ram_byp_value = rightShift(data_low, 12) and &H1
        tx_tm_mask = &Hfff
        if data_low > LONG_MAX then
            if tx_tm_mask = mask then
                read_tx_tm_value = data_low
            else
                read_tx_tm_value = (data_low - H8000_0000) and tx_tm_mask
            end If
        else
            read_tx_tm_value = data_low and tx_tm_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_tx_lvm_value = &H0
        flag_tx_lvm        = &H0
        write_tx_rds_value = &H0
        flag_tx_rds        = &H0
        write_tx_ram_byp_value = &H0
        flag_tx_ram_byp        = &H0
        write_tx_tm_value = &H0
        flag_tx_tm        = &H0
    End Sub
End Class


'' @REGISTER : BR_GPCS_rxfifo_ramctl0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rx_lvm                                     [14:14]          get_rx_lvm
''                                                             set_rx_lvm
''                                                             read_rx_lvm
''                                                             write_rx_lvm
''---------------------------------------------------------------------------------
'' rx_rds                                     [13:13]          get_rx_rds
''                                                             set_rx_rds
''                                                             read_rx_rds
''                                                             write_rx_rds
''---------------------------------------------------------------------------------
'' rx_ram_byp                                 [12:12]          get_rx_ram_byp
''                                                             set_rx_ram_byp
''                                                             read_rx_ram_byp
''                                                             write_rx_ram_byp
''---------------------------------------------------------------------------------
'' rx_tm                                      [11:0]           get_rx_tm
''                                                             set_rx_tm
''                                                             read_rx_tm
''                                                             write_rx_tm
''---------------------------------------------------------------------------------
Class REGISTER_BR_GPCS_rxfifo_ramctl0
    Private write_rx_lvm_value
    Private read_rx_lvm_value
    Private flag_rx_lvm
    Private write_rx_rds_value
    Private read_rx_rds_value
    Private flag_rx_rds
    Private write_rx_ram_byp_value
    Private read_rx_ram_byp_value
    Private flag_rx_ram_byp
    Private write_rx_tm_value
    Private read_rx_tm_value
    Private flag_rx_tm

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H44
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_rx_lvm
        get_rx_lvm = read_rx_lvm_value
    End Property

    Property Let set_rx_lvm(aData)
        write_rx_lvm_value = aData
        flag_rx_lvm        = &H1
    End Property

    Property Get read_rx_lvm
        read
        read_rx_lvm = read_rx_lvm_value
    End Property

    Property Let write_rx_lvm(aData)
        set_rx_lvm = aData
        write
    End Property

    Property Get get_rx_rds
        get_rx_rds = read_rx_rds_value
    End Property

    Property Let set_rx_rds(aData)
        write_rx_rds_value = aData
        flag_rx_rds        = &H1
    End Property

    Property Get read_rx_rds
        read
        read_rx_rds = read_rx_rds_value
    End Property

    Property Let write_rx_rds(aData)
        set_rx_rds = aData
        write
    End Property

    Property Get get_rx_ram_byp
        get_rx_ram_byp = read_rx_ram_byp_value
    End Property

    Property Let set_rx_ram_byp(aData)
        write_rx_ram_byp_value = aData
        flag_rx_ram_byp        = &H1
    End Property

    Property Get read_rx_ram_byp
        read
        read_rx_ram_byp = read_rx_ram_byp_value
    End Property

    Property Let write_rx_ram_byp(aData)
        set_rx_ram_byp = aData
        write
    End Property

    Property Get get_rx_tm
        get_rx_tm = read_rx_tm_value
    End Property

    Property Let set_rx_tm(aData)
        write_rx_tm_value = aData
        flag_rx_tm        = &H1
    End Property

    Property Get read_rx_tm
        read
        read_rx_tm = read_rx_tm_value
    End Property

    Property Let write_rx_tm(aData)
        set_rx_tm = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rx_lvm_value = rightShift(data_low, 14) and &H1
        read_rx_rds_value = rightShift(data_low, 13) and &H1
        read_rx_ram_byp_value = rightShift(data_low, 12) and &H1
        rx_tm_mask = &Hfff
        if data_low > LONG_MAX then
            if rx_tm_mask = mask then
                read_rx_tm_value = data_low
            else
                read_rx_tm_value = (data_low - H8000_0000) and rx_tm_mask
            end If
        else
            read_rx_tm_value = data_low and rx_tm_mask
        end If

    End Sub

    Sub write
        If flag_rx_lvm = &H0 or flag_rx_rds = &H0 or flag_rx_ram_byp = &H0 or flag_rx_tm = &H0 Then read
        If flag_rx_lvm = &H0 Then write_rx_lvm_value = get_rx_lvm
        If flag_rx_rds = &H0 Then write_rx_rds_value = get_rx_rds
        If flag_rx_ram_byp = &H0 Then write_rx_ram_byp_value = get_rx_ram_byp
        If flag_rx_tm = &H0 Then write_rx_tm_value = get_rx_tm

        regValue = leftShift((write_rx_lvm_value and &H1), 14) + leftShift((write_rx_rds_value and &H1), 13) + leftShift((write_rx_ram_byp_value and &H1), 12) + leftShift((write_rx_tm_value and &Hfff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rx_lvm_value = rightShift(data_low, 14) and &H1
        read_rx_rds_value = rightShift(data_low, 13) and &H1
        read_rx_ram_byp_value = rightShift(data_low, 12) and &H1
        rx_tm_mask = &Hfff
        if data_low > LONG_MAX then
            if rx_tm_mask = mask then
                read_rx_tm_value = data_low
            else
                read_rx_tm_value = (data_low - H8000_0000) and rx_tm_mask
            end If
        else
            read_rx_tm_value = data_low and rx_tm_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rx_lvm_value = &H0
        flag_rx_lvm        = &H0
        write_rx_rds_value = &H0
        flag_rx_rds        = &H0
        write_rx_ram_byp_value = &H0
        flag_rx_ram_byp        = &H0
        write_rx_tm_value = &H0
        flag_rx_tm        = &H0
    End Sub
End Class


'' @REGISTER : BR_GPCS_ram_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' tx_sec_flag                                [3:3]            get_tx_sec_flag
''                                                             set_tx_sec_flag
''                                                             read_tx_sec_flag
''                                                             write_tx_sec_flag
''---------------------------------------------------------------------------------
'' tx_ded_flag                                [2:2]            get_tx_ded_flag
''                                                             set_tx_ded_flag
''                                                             read_tx_ded_flag
''                                                             write_tx_ded_flag
''---------------------------------------------------------------------------------
'' rx_sec_flag                                [1:1]            get_rx_sec_flag
''                                                             set_rx_sec_flag
''                                                             read_rx_sec_flag
''                                                             write_rx_sec_flag
''---------------------------------------------------------------------------------
'' rx_ded_flag                                [0:0]            get_rx_ded_flag
''                                                             set_rx_ded_flag
''                                                             read_rx_ded_flag
''                                                             write_rx_ded_flag
''---------------------------------------------------------------------------------
Class REGISTER_BR_GPCS_ram_status
    Private write_tx_sec_flag_value
    Private read_tx_sec_flag_value
    Private flag_tx_sec_flag
    Private write_tx_ded_flag_value
    Private read_tx_ded_flag_value
    Private flag_tx_ded_flag
    Private write_rx_sec_flag_value
    Private read_rx_sec_flag_value
    Private flag_rx_sec_flag
    Private write_rx_ded_flag_value
    Private read_rx_ded_flag_value
    Private flag_rx_ded_flag

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H46
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_tx_sec_flag
        get_tx_sec_flag = read_tx_sec_flag_value
    End Property

    Property Let set_tx_sec_flag(aData)
        write_tx_sec_flag_value = aData
        flag_tx_sec_flag        = &H1
    End Property

    Property Get read_tx_sec_flag
        read
        read_tx_sec_flag = read_tx_sec_flag_value
    End Property

    Property Let write_tx_sec_flag(aData)
        set_tx_sec_flag = aData
        write
    End Property

    Property Get get_tx_ded_flag
        get_tx_ded_flag = read_tx_ded_flag_value
    End Property

    Property Let set_tx_ded_flag(aData)
        write_tx_ded_flag_value = aData
        flag_tx_ded_flag        = &H1
    End Property

    Property Get read_tx_ded_flag
        read
        read_tx_ded_flag = read_tx_ded_flag_value
    End Property

    Property Let write_tx_ded_flag(aData)
        set_tx_ded_flag = aData
        write
    End Property

    Property Get get_rx_sec_flag
        get_rx_sec_flag = read_rx_sec_flag_value
    End Property

    Property Let set_rx_sec_flag(aData)
        write_rx_sec_flag_value = aData
        flag_rx_sec_flag        = &H1
    End Property

    Property Get read_rx_sec_flag
        read
        read_rx_sec_flag = read_rx_sec_flag_value
    End Property

    Property Let write_rx_sec_flag(aData)
        set_rx_sec_flag = aData
        write
    End Property

    Property Get get_rx_ded_flag
        get_rx_ded_flag = read_rx_ded_flag_value
    End Property

    Property Let set_rx_ded_flag(aData)
        write_rx_ded_flag_value = aData
        flag_rx_ded_flag        = &H1
    End Property

    Property Get read_rx_ded_flag
        read
        read_rx_ded_flag = read_rx_ded_flag_value
    End Property

    Property Let write_rx_ded_flag(aData)
        set_rx_ded_flag = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_tx_sec_flag_value = rightShift(data_low, 3) and &H1
        read_tx_ded_flag_value = rightShift(data_low, 2) and &H1
        read_rx_sec_flag_value = rightShift(data_low, 1) and &H1
        rx_ded_flag_mask = &H1
        if data_low > LONG_MAX then
            if rx_ded_flag_mask = mask then
                read_rx_ded_flag_value = data_low
            else
                read_rx_ded_flag_value = (data_low - H8000_0000) and rx_ded_flag_mask
            end If
        else
            read_rx_ded_flag_value = data_low and rx_ded_flag_mask
        end If

    End Sub

    Sub write
        If flag_tx_sec_flag = &H0 or flag_tx_ded_flag = &H0 or flag_rx_sec_flag = &H0 or flag_rx_ded_flag = &H0 Then read
        If flag_tx_sec_flag = &H0 Then write_tx_sec_flag_value = get_tx_sec_flag
        If flag_tx_ded_flag = &H0 Then write_tx_ded_flag_value = get_tx_ded_flag
        If flag_rx_sec_flag = &H0 Then write_rx_sec_flag_value = get_rx_sec_flag
        If flag_rx_ded_flag = &H0 Then write_rx_ded_flag_value = get_rx_ded_flag

        regValue = leftShift((write_tx_sec_flag_value and &H1), 3) + leftShift((write_tx_ded_flag_value and &H1), 2) + leftShift((write_rx_sec_flag_value and &H1), 1) + leftShift((write_rx_ded_flag_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_tx_sec_flag_value = rightShift(data_low, 3) and &H1
        read_tx_ded_flag_value = rightShift(data_low, 2) and &H1
        read_rx_sec_flag_value = rightShift(data_low, 1) and &H1
        rx_ded_flag_mask = &H1
        if data_low > LONG_MAX then
            if rx_ded_flag_mask = mask then
                read_rx_ded_flag_value = data_low
            else
                read_rx_ded_flag_value = (data_low - H8000_0000) and rx_ded_flag_mask
            end If
        else
            read_rx_ded_flag_value = data_low and rx_ded_flag_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_tx_sec_flag_value = &H0
        flag_tx_sec_flag        = &H0
        write_tx_ded_flag_value = &H0
        flag_tx_ded_flag        = &H0
        write_rx_sec_flag_value = &H0
        flag_rx_sec_flag        = &H0
        write_rx_ded_flag_value = &H0
        flag_rx_ded_flag        = &H0
    End Sub
End Class


'' @REGISTER : BR_GPCS_pcs_misc_ctl1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' spare_15                                   [15:15]          get_spare_15
''                                                             set_spare_15
''                                                             read_spare_15
''                                                             write_spare_15
''---------------------------------------------------------------------------------
'' emi_protect_en                             [14:14]          get_emi_protect_en
''                                                             set_emi_protect_en
''                                                             read_emi_protect_en
''                                                             write_emi_protect_en
''---------------------------------------------------------------------------------
'' blklock_limit                              [13:12]          get_blklock_limit
''                                                             set_blklock_limit
''                                                             read_blklock_limit
''                                                             write_blklock_limit
''---------------------------------------------------------------------------------
'' byp_sd_transit_mon                         [11:11]          get_byp_sd_transit_mon
''                                                             set_byp_sd_transit_mon
''                                                             read_byp_sd_transit_mon
''                                                             write_byp_sd_transit_mon
''---------------------------------------------------------------------------------
'' pfc_limit                                  [10:9]           get_pfc_limit
''                                                             set_pfc_limit
''                                                             read_pfc_limit
''                                                             write_pfc_limit
''---------------------------------------------------------------------------------
'' align_crc_en                               [8:8]            get_align_crc_en
''                                                             set_align_crc_en
''                                                             read_align_crc_en
''                                                             write_align_crc_en
''---------------------------------------------------------------------------------
'' srch_limit_dis                             [7:7]            get_srch_limit_dis
''                                                             set_srch_limit_dis
''                                                             read_srch_limit_dis
''                                                             write_srch_limit_dis
''---------------------------------------------------------------------------------
'' align_crc_limit                            [6:4]            get_align_crc_limit
''                                                             set_align_crc_limit
''                                                             read_align_crc_limit
''                                                             write_align_crc_limit
''---------------------------------------------------------------------------------
'' emi_hold                                   [3:3]            get_emi_hold
''                                                             set_emi_hold
''                                                             read_emi_hold
''                                                             write_emi_hold
''---------------------------------------------------------------------------------
'' brcm_tm_1011                               [2:2]            get_brcm_tm_1011
''                                                             set_brcm_tm_1011
''                                                             read_brcm_tm_1011
''                                                             write_brcm_tm_1011
''---------------------------------------------------------------------------------
'' brcm_tm_1001                               [1:1]            get_brcm_tm_1001
''                                                             set_brcm_tm_1001
''                                                             read_brcm_tm_1001
''                                                             write_brcm_tm_1001
''---------------------------------------------------------------------------------
'' wait_aligndrop_rpt                         [0:0]            get_wait_aligndrop_rpt
''                                                             set_wait_aligndrop_rpt
''                                                             read_wait_aligndrop_rpt
''                                                             write_wait_aligndrop_rpt
''---------------------------------------------------------------------------------
Class REGISTER_BR_GPCS_pcs_misc_ctl1
    Private write_spare_15_value
    Private read_spare_15_value
    Private flag_spare_15
    Private write_emi_protect_en_value
    Private read_emi_protect_en_value
    Private flag_emi_protect_en
    Private write_blklock_limit_value
    Private read_blklock_limit_value
    Private flag_blklock_limit
    Private write_byp_sd_transit_mon_value
    Private read_byp_sd_transit_mon_value
    Private flag_byp_sd_transit_mon
    Private write_pfc_limit_value
    Private read_pfc_limit_value
    Private flag_pfc_limit
    Private write_align_crc_en_value
    Private read_align_crc_en_value
    Private flag_align_crc_en
    Private write_srch_limit_dis_value
    Private read_srch_limit_dis_value
    Private flag_srch_limit_dis
    Private write_align_crc_limit_value
    Private read_align_crc_limit_value
    Private flag_align_crc_limit
    Private write_emi_hold_value
    Private read_emi_hold_value
    Private flag_emi_hold
    Private write_brcm_tm_1011_value
    Private read_brcm_tm_1011_value
    Private flag_brcm_tm_1011
    Private write_brcm_tm_1001_value
    Private read_brcm_tm_1001_value
    Private flag_brcm_tm_1001
    Private write_wait_aligndrop_rpt_value
    Private read_wait_aligndrop_rpt_value
    Private flag_wait_aligndrop_rpt

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H48
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_spare_15
        get_spare_15 = read_spare_15_value
    End Property

    Property Let set_spare_15(aData)
        write_spare_15_value = aData
        flag_spare_15        = &H1
    End Property

    Property Get read_spare_15
        read
        read_spare_15 = read_spare_15_value
    End Property

    Property Let write_spare_15(aData)
        set_spare_15 = aData
        write
    End Property

    Property Get get_emi_protect_en
        get_emi_protect_en = read_emi_protect_en_value
    End Property

    Property Let set_emi_protect_en(aData)
        write_emi_protect_en_value = aData
        flag_emi_protect_en        = &H1
    End Property

    Property Get read_emi_protect_en
        read
        read_emi_protect_en = read_emi_protect_en_value
    End Property

    Property Let write_emi_protect_en(aData)
        set_emi_protect_en = aData
        write
    End Property

    Property Get get_blklock_limit
        get_blklock_limit = read_blklock_limit_value
    End Property

    Property Let set_blklock_limit(aData)
        write_blklock_limit_value = aData
        flag_blklock_limit        = &H1
    End Property

    Property Get read_blklock_limit
        read
        read_blklock_limit = read_blklock_limit_value
    End Property

    Property Let write_blklock_limit(aData)
        set_blklock_limit = aData
        write
    End Property

    Property Get get_byp_sd_transit_mon
        get_byp_sd_transit_mon = read_byp_sd_transit_mon_value
    End Property

    Property Let set_byp_sd_transit_mon(aData)
        write_byp_sd_transit_mon_value = aData
        flag_byp_sd_transit_mon        = &H1
    End Property

    Property Get read_byp_sd_transit_mon
        read
        read_byp_sd_transit_mon = read_byp_sd_transit_mon_value
    End Property

    Property Let write_byp_sd_transit_mon(aData)
        set_byp_sd_transit_mon = aData
        write
    End Property

    Property Get get_pfc_limit
        get_pfc_limit = read_pfc_limit_value
    End Property

    Property Let set_pfc_limit(aData)
        write_pfc_limit_value = aData
        flag_pfc_limit        = &H1
    End Property

    Property Get read_pfc_limit
        read
        read_pfc_limit = read_pfc_limit_value
    End Property

    Property Let write_pfc_limit(aData)
        set_pfc_limit = aData
        write
    End Property

    Property Get get_align_crc_en
        get_align_crc_en = read_align_crc_en_value
    End Property

    Property Let set_align_crc_en(aData)
        write_align_crc_en_value = aData
        flag_align_crc_en        = &H1
    End Property

    Property Get read_align_crc_en
        read
        read_align_crc_en = read_align_crc_en_value
    End Property

    Property Let write_align_crc_en(aData)
        set_align_crc_en = aData
        write
    End Property

    Property Get get_srch_limit_dis
        get_srch_limit_dis = read_srch_limit_dis_value
    End Property

    Property Let set_srch_limit_dis(aData)
        write_srch_limit_dis_value = aData
        flag_srch_limit_dis        = &H1
    End Property

    Property Get read_srch_limit_dis
        read
        read_srch_limit_dis = read_srch_limit_dis_value
    End Property

    Property Let write_srch_limit_dis(aData)
        set_srch_limit_dis = aData
        write
    End Property

    Property Get get_align_crc_limit
        get_align_crc_limit = read_align_crc_limit_value
    End Property

    Property Let set_align_crc_limit(aData)
        write_align_crc_limit_value = aData
        flag_align_crc_limit        = &H1
    End Property

    Property Get read_align_crc_limit
        read
        read_align_crc_limit = read_align_crc_limit_value
    End Property

    Property Let write_align_crc_limit(aData)
        set_align_crc_limit = aData
        write
    End Property

    Property Get get_emi_hold
        get_emi_hold = read_emi_hold_value
    End Property

    Property Let set_emi_hold(aData)
        write_emi_hold_value = aData
        flag_emi_hold        = &H1
    End Property

    Property Get read_emi_hold
        read
        read_emi_hold = read_emi_hold_value
    End Property

    Property Let write_emi_hold(aData)
        set_emi_hold = aData
        write
    End Property

    Property Get get_brcm_tm_1011
        get_brcm_tm_1011 = read_brcm_tm_1011_value
    End Property

    Property Let set_brcm_tm_1011(aData)
        write_brcm_tm_1011_value = aData
        flag_brcm_tm_1011        = &H1
    End Property

    Property Get read_brcm_tm_1011
        read
        read_brcm_tm_1011 = read_brcm_tm_1011_value
    End Property

    Property Let write_brcm_tm_1011(aData)
        set_brcm_tm_1011 = aData
        write
    End Property

    Property Get get_brcm_tm_1001
        get_brcm_tm_1001 = read_brcm_tm_1001_value
    End Property

    Property Let set_brcm_tm_1001(aData)
        write_brcm_tm_1001_value = aData
        flag_brcm_tm_1001        = &H1
    End Property

    Property Get read_brcm_tm_1001
        read
        read_brcm_tm_1001 = read_brcm_tm_1001_value
    End Property

    Property Let write_brcm_tm_1001(aData)
        set_brcm_tm_1001 = aData
        write
    End Property

    Property Get get_wait_aligndrop_rpt
        get_wait_aligndrop_rpt = read_wait_aligndrop_rpt_value
    End Property

    Property Let set_wait_aligndrop_rpt(aData)
        write_wait_aligndrop_rpt_value = aData
        flag_wait_aligndrop_rpt        = &H1
    End Property

    Property Get read_wait_aligndrop_rpt
        read
        read_wait_aligndrop_rpt = read_wait_aligndrop_rpt_value
    End Property

    Property Let write_wait_aligndrop_rpt(aData)
        set_wait_aligndrop_rpt = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_spare_15_value = rightShift(data_low, 15) and &H1
        read_emi_protect_en_value = rightShift(data_low, 14) and &H1
        read_blklock_limit_value = rightShift(data_low, 12) and &H3
        read_byp_sd_transit_mon_value = rightShift(data_low, 11) and &H1
        read_pfc_limit_value = rightShift(data_low, 9) and &H3
        read_align_crc_en_value = rightShift(data_low, 8) and &H1
        read_srch_limit_dis_value = rightShift(data_low, 7) and &H1
        read_align_crc_limit_value = rightShift(data_low, 4) and &H7
        read_emi_hold_value = rightShift(data_low, 3) and &H1
        read_brcm_tm_1011_value = rightShift(data_low, 2) and &H1
        read_brcm_tm_1001_value = rightShift(data_low, 1) and &H1
        wait_aligndrop_rpt_mask = &H1
        if data_low > LONG_MAX then
            if wait_aligndrop_rpt_mask = mask then
                read_wait_aligndrop_rpt_value = data_low
            else
                read_wait_aligndrop_rpt_value = (data_low - H8000_0000) and wait_aligndrop_rpt_mask
            end If
        else
            read_wait_aligndrop_rpt_value = data_low and wait_aligndrop_rpt_mask
        end If

    End Sub

    Sub write
        If flag_spare_15 = &H0 or flag_emi_protect_en = &H0 or flag_blklock_limit = &H0 or flag_byp_sd_transit_mon = &H0 or flag_pfc_limit = &H0 or flag_align_crc_en = &H0 or flag_srch_limit_dis = &H0 or flag_align_crc_limit = &H0 or flag_emi_hold = &H0 or flag_brcm_tm_1011 = &H0 or flag_brcm_tm_1001 = &H0 or flag_wait_aligndrop_rpt = &H0 Then read
        If flag_spare_15 = &H0 Then write_spare_15_value = get_spare_15
        If flag_emi_protect_en = &H0 Then write_emi_protect_en_value = get_emi_protect_en
        If flag_blklock_limit = &H0 Then write_blklock_limit_value = get_blklock_limit
        If flag_byp_sd_transit_mon = &H0 Then write_byp_sd_transit_mon_value = get_byp_sd_transit_mon
        If flag_pfc_limit = &H0 Then write_pfc_limit_value = get_pfc_limit
        If flag_align_crc_en = &H0 Then write_align_crc_en_value = get_align_crc_en
        If flag_srch_limit_dis = &H0 Then write_srch_limit_dis_value = get_srch_limit_dis
        If flag_align_crc_limit = &H0 Then write_align_crc_limit_value = get_align_crc_limit
        If flag_emi_hold = &H0 Then write_emi_hold_value = get_emi_hold
        If flag_brcm_tm_1011 = &H0 Then write_brcm_tm_1011_value = get_brcm_tm_1011
        If flag_brcm_tm_1001 = &H0 Then write_brcm_tm_1001_value = get_brcm_tm_1001
        If flag_wait_aligndrop_rpt = &H0 Then write_wait_aligndrop_rpt_value = get_wait_aligndrop_rpt

        regValue = leftShift((write_spare_15_value and &H1), 15) + leftShift((write_emi_protect_en_value and &H1), 14) + leftShift((write_blklock_limit_value and &H3), 12) + leftShift((write_byp_sd_transit_mon_value and &H1), 11) + leftShift((write_pfc_limit_value and &H3), 9) + leftShift((write_align_crc_en_value and &H1), 8) + leftShift((write_srch_limit_dis_value and &H1), 7) + leftShift((write_align_crc_limit_value and &H7), 4) + leftShift((write_emi_hold_value and &H1), 3) + leftShift((write_brcm_tm_1011_value and &H1), 2) + leftShift((write_brcm_tm_1001_value and &H1), 1) + leftShift((write_wait_aligndrop_rpt_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_spare_15_value = rightShift(data_low, 15) and &H1
        read_emi_protect_en_value = rightShift(data_low, 14) and &H1
        read_blklock_limit_value = rightShift(data_low, 12) and &H3
        read_byp_sd_transit_mon_value = rightShift(data_low, 11) and &H1
        read_pfc_limit_value = rightShift(data_low, 9) and &H3
        read_align_crc_en_value = rightShift(data_low, 8) and &H1
        read_srch_limit_dis_value = rightShift(data_low, 7) and &H1
        read_align_crc_limit_value = rightShift(data_low, 4) and &H7
        read_emi_hold_value = rightShift(data_low, 3) and &H1
        read_brcm_tm_1011_value = rightShift(data_low, 2) and &H1
        read_brcm_tm_1001_value = rightShift(data_low, 1) and &H1
        wait_aligndrop_rpt_mask = &H1
        if data_low > LONG_MAX then
            if wait_aligndrop_rpt_mask = mask then
                read_wait_aligndrop_rpt_value = data_low
            else
                read_wait_aligndrop_rpt_value = (data_low - H8000_0000) and wait_aligndrop_rpt_mask
            end If
        else
            read_wait_aligndrop_rpt_value = data_low and wait_aligndrop_rpt_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_spare_15_value = &H0
        flag_spare_15        = &H0
        write_emi_protect_en_value = &H0
        flag_emi_protect_en        = &H0
        write_blklock_limit_value = &H0
        flag_blklock_limit        = &H0
        write_byp_sd_transit_mon_value = &H0
        flag_byp_sd_transit_mon        = &H0
        write_pfc_limit_value = &H0
        flag_pfc_limit        = &H0
        write_align_crc_en_value = &H0
        flag_align_crc_en        = &H0
        write_srch_limit_dis_value = &H0
        flag_srch_limit_dis        = &H0
        write_align_crc_limit_value = &H0
        flag_align_crc_limit        = &H0
        write_emi_hold_value = &H0
        flag_emi_hold        = &H0
        write_brcm_tm_1011_value = &H0
        flag_brcm_tm_1011        = &H0
        write_brcm_tm_1001_value = &H0
        flag_brcm_tm_1001        = &H0
        write_wait_aligndrop_rpt_value = &H0
        flag_wait_aligndrop_rpt        = &H0
    End Sub
End Class


'' @REGISTER : BR_GPCS_pcs_misc_ctl2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rx_ov_ctrl_0                               [15:0]           get_rx_ov_ctrl_0
''                                                             set_rx_ov_ctrl_0
''                                                             read_rx_ov_ctrl_0
''                                                             write_rx_ov_ctrl_0
''---------------------------------------------------------------------------------
Class REGISTER_BR_GPCS_pcs_misc_ctl2
    Private write_rx_ov_ctrl_0_value
    Private read_rx_ov_ctrl_0_value
    Private flag_rx_ov_ctrl_0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_rx_ov_ctrl_0
        get_rx_ov_ctrl_0 = read_rx_ov_ctrl_0_value
    End Property

    Property Let set_rx_ov_ctrl_0(aData)
        write_rx_ov_ctrl_0_value = aData
        flag_rx_ov_ctrl_0        = &H1
    End Property

    Property Get read_rx_ov_ctrl_0
        read
        read_rx_ov_ctrl_0 = read_rx_ov_ctrl_0_value
    End Property

    Property Let write_rx_ov_ctrl_0(aData)
        set_rx_ov_ctrl_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rx_ov_ctrl_0_mask = &Hffff
        if data_low > LONG_MAX then
            if rx_ov_ctrl_0_mask = mask then
                read_rx_ov_ctrl_0_value = data_low
            else
                read_rx_ov_ctrl_0_value = (data_low - H8000_0000) and rx_ov_ctrl_0_mask
            end If
        else
            read_rx_ov_ctrl_0_value = data_low and rx_ov_ctrl_0_mask
        end If

    End Sub

    Sub write
        If flag_rx_ov_ctrl_0 = &H0 Then read
        If flag_rx_ov_ctrl_0 = &H0 Then write_rx_ov_ctrl_0_value = get_rx_ov_ctrl_0

        regValue = leftShift((write_rx_ov_ctrl_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rx_ov_ctrl_0_mask = &Hffff
        if data_low > LONG_MAX then
            if rx_ov_ctrl_0_mask = mask then
                read_rx_ov_ctrl_0_value = data_low
            else
                read_rx_ov_ctrl_0_value = (data_low - H8000_0000) and rx_ov_ctrl_0_mask
            end If
        else
            read_rx_ov_ctrl_0_value = data_low and rx_ov_ctrl_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rx_ov_ctrl_0_value = &H0
        flag_rx_ov_ctrl_0        = &H0
    End Sub
End Class


'' @REGISTER : BR_GPCS_pcs_misc_ctl3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' block_lock_val                             [15:15]          get_block_lock_val
''                                                             set_block_lock_val
''                                                             read_block_lock_val
''                                                             write_block_lock_val
''---------------------------------------------------------------------------------
'' hi_rfer_val                                [14:14]          get_hi_rfer_val
''                                                             set_hi_rfer_val
''                                                             read_hi_rfer_val
''                                                             write_hi_rfer_val
''---------------------------------------------------------------------------------
'' alignmentState_val                         [13:10]          get_alignmentState_val
''                                                             set_alignmentState_val
''                                                             read_alignmentState_val
''                                                             write_alignmentState_val
''---------------------------------------------------------------------------------
'' polarityA_val                              [9:9]            get_polarityA_val
''                                                             set_polarityA_val
''                                                             read_polarityA_val
''                                                             write_polarityA_val
''---------------------------------------------------------------------------------
'' evenOddAdj_val                             [8:8]            get_evenOddAdj_val
''                                                             set_evenOddAdj_val
''                                                             read_evenOddAdj_val
''                                                             write_evenOddAdj_val
''---------------------------------------------------------------------------------
'' alignmentComplete_val                      [7:7]            get_alignmentComplete_val
''                                                             set_alignmentComplete_val
''                                                             read_alignmentComplete_val
''                                                             write_alignmentComplete_val
''---------------------------------------------------------------------------------
'' errorCount_val                             [6:4]            get_errorCount_val
''                                                             set_errorCount_val
''                                                             read_errorCount_val
''                                                             write_errorCount_val
''---------------------------------------------------------------------------------
'' scramblerMode_val                          [3:2]            get_scramblerMode_val
''                                                             set_scramblerMode_val
''                                                             read_scramblerMode_val
''                                                             write_scramblerMode_val
''---------------------------------------------------------------------------------
'' Enable_PF_Bit_Cnt_val                      [1:1]            get_Enable_PF_Bit_Cnt_val
''                                                             set_Enable_PF_Bit_Cnt_val
''                                                             read_Enable_PF_Bit_Cnt_val
''                                                             write_Enable_PF_Bit_Cnt_val
''---------------------------------------------------------------------------------
'' second_load_val                            [0:0]            get_second_load_val
''                                                             set_second_load_val
''                                                             read_second_load_val
''                                                             write_second_load_val
''---------------------------------------------------------------------------------
Class REGISTER_BR_GPCS_pcs_misc_ctl3
    Private write_block_lock_val_value
    Private read_block_lock_val_value
    Private flag_block_lock_val
    Private write_hi_rfer_val_value
    Private read_hi_rfer_val_value
    Private flag_hi_rfer_val
    Private write_alignmentState_val_value
    Private read_alignmentState_val_value
    Private flag_alignmentState_val
    Private write_polarityA_val_value
    Private read_polarityA_val_value
    Private flag_polarityA_val
    Private write_evenOddAdj_val_value
    Private read_evenOddAdj_val_value
    Private flag_evenOddAdj_val
    Private write_alignmentComplete_val_value
    Private read_alignmentComplete_val_value
    Private flag_alignmentComplete_val
    Private write_errorCount_val_value
    Private read_errorCount_val_value
    Private flag_errorCount_val
    Private write_scramblerMode_val_value
    Private read_scramblerMode_val_value
    Private flag_scramblerMode_val
    Private write_Enable_PF_Bit_Cnt_val_value
    Private read_Enable_PF_Bit_Cnt_val_value
    Private flag_Enable_PF_Bit_Cnt_val
    Private write_second_load_val_value
    Private read_second_load_val_value
    Private flag_second_load_val

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_block_lock_val
        get_block_lock_val = read_block_lock_val_value
    End Property

    Property Let set_block_lock_val(aData)
        write_block_lock_val_value = aData
        flag_block_lock_val        = &H1
    End Property

    Property Get read_block_lock_val
        read
        read_block_lock_val = read_block_lock_val_value
    End Property

    Property Let write_block_lock_val(aData)
        set_block_lock_val = aData
        write
    End Property

    Property Get get_hi_rfer_val
        get_hi_rfer_val = read_hi_rfer_val_value
    End Property

    Property Let set_hi_rfer_val(aData)
        write_hi_rfer_val_value = aData
        flag_hi_rfer_val        = &H1
    End Property

    Property Get read_hi_rfer_val
        read
        read_hi_rfer_val = read_hi_rfer_val_value
    End Property

    Property Let write_hi_rfer_val(aData)
        set_hi_rfer_val = aData
        write
    End Property

    Property Get get_alignmentState_val
        get_alignmentState_val = read_alignmentState_val_value
    End Property

    Property Let set_alignmentState_val(aData)
        write_alignmentState_val_value = aData
        flag_alignmentState_val        = &H1
    End Property

    Property Get read_alignmentState_val
        read
        read_alignmentState_val = read_alignmentState_val_value
    End Property

    Property Let write_alignmentState_val(aData)
        set_alignmentState_val = aData
        write
    End Property

    Property Get get_polarityA_val
        get_polarityA_val = read_polarityA_val_value
    End Property

    Property Let set_polarityA_val(aData)
        write_polarityA_val_value = aData
        flag_polarityA_val        = &H1
    End Property

    Property Get read_polarityA_val
        read
        read_polarityA_val = read_polarityA_val_value
    End Property

    Property Let write_polarityA_val(aData)
        set_polarityA_val = aData
        write
    End Property

    Property Get get_evenOddAdj_val
        get_evenOddAdj_val = read_evenOddAdj_val_value
    End Property

    Property Let set_evenOddAdj_val(aData)
        write_evenOddAdj_val_value = aData
        flag_evenOddAdj_val        = &H1
    End Property

    Property Get read_evenOddAdj_val
        read
        read_evenOddAdj_val = read_evenOddAdj_val_value
    End Property

    Property Let write_evenOddAdj_val(aData)
        set_evenOddAdj_val = aData
        write
    End Property

    Property Get get_alignmentComplete_val
        get_alignmentComplete_val = read_alignmentComplete_val_value
    End Property

    Property Let set_alignmentComplete_val(aData)
        write_alignmentComplete_val_value = aData
        flag_alignmentComplete_val        = &H1
    End Property

    Property Get read_alignmentComplete_val
        read
        read_alignmentComplete_val = read_alignmentComplete_val_value
    End Property

    Property Let write_alignmentComplete_val(aData)
        set_alignmentComplete_val = aData
        write
    End Property

    Property Get get_errorCount_val
        get_errorCount_val = read_errorCount_val_value
    End Property

    Property Let set_errorCount_val(aData)
        write_errorCount_val_value = aData
        flag_errorCount_val        = &H1
    End Property

    Property Get read_errorCount_val
        read
        read_errorCount_val = read_errorCount_val_value
    End Property

    Property Let write_errorCount_val(aData)
        set_errorCount_val = aData
        write
    End Property

    Property Get get_scramblerMode_val
        get_scramblerMode_val = read_scramblerMode_val_value
    End Property

    Property Let set_scramblerMode_val(aData)
        write_scramblerMode_val_value = aData
        flag_scramblerMode_val        = &H1
    End Property

    Property Get read_scramblerMode_val
        read
        read_scramblerMode_val = read_scramblerMode_val_value
    End Property

    Property Let write_scramblerMode_val(aData)
        set_scramblerMode_val = aData
        write
    End Property

    Property Get get_Enable_PF_Bit_Cnt_val
        get_Enable_PF_Bit_Cnt_val = read_Enable_PF_Bit_Cnt_val_value
    End Property

    Property Let set_Enable_PF_Bit_Cnt_val(aData)
        write_Enable_PF_Bit_Cnt_val_value = aData
        flag_Enable_PF_Bit_Cnt_val        = &H1
    End Property

    Property Get read_Enable_PF_Bit_Cnt_val
        read
        read_Enable_PF_Bit_Cnt_val = read_Enable_PF_Bit_Cnt_val_value
    End Property

    Property Let write_Enable_PF_Bit_Cnt_val(aData)
        set_Enable_PF_Bit_Cnt_val = aData
        write
    End Property

    Property Get get_second_load_val
        get_second_load_val = read_second_load_val_value
    End Property

    Property Let set_second_load_val(aData)
        write_second_load_val_value = aData
        flag_second_load_val        = &H1
    End Property

    Property Get read_second_load_val
        read
        read_second_load_val = read_second_load_val_value
    End Property

    Property Let write_second_load_val(aData)
        set_second_load_val = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_block_lock_val_value = rightShift(data_low, 15) and &H1
        read_hi_rfer_val_value = rightShift(data_low, 14) and &H1
        read_alignmentState_val_value = rightShift(data_low, 10) and &Hf
        read_polarityA_val_value = rightShift(data_low, 9) and &H1
        read_evenOddAdj_val_value = rightShift(data_low, 8) and &H1
        read_alignmentComplete_val_value = rightShift(data_low, 7) and &H1
        read_errorCount_val_value = rightShift(data_low, 4) and &H7
        read_scramblerMode_val_value = rightShift(data_low, 2) and &H3
        read_Enable_PF_Bit_Cnt_val_value = rightShift(data_low, 1) and &H1
        second_load_val_mask = &H1
        if data_low > LONG_MAX then
            if second_load_val_mask = mask then
                read_second_load_val_value = data_low
            else
                read_second_load_val_value = (data_low - H8000_0000) and second_load_val_mask
            end If
        else
            read_second_load_val_value = data_low and second_load_val_mask
        end If

    End Sub

    Sub write
        If flag_block_lock_val = &H0 or flag_hi_rfer_val = &H0 or flag_alignmentState_val = &H0 or flag_polarityA_val = &H0 or flag_evenOddAdj_val = &H0 or flag_alignmentComplete_val = &H0 or flag_errorCount_val = &H0 or flag_scramblerMode_val = &H0 or flag_Enable_PF_Bit_Cnt_val = &H0 or flag_second_load_val = &H0 Then read
        If flag_block_lock_val = &H0 Then write_block_lock_val_value = get_block_lock_val
        If flag_hi_rfer_val = &H0 Then write_hi_rfer_val_value = get_hi_rfer_val
        If flag_alignmentState_val = &H0 Then write_alignmentState_val_value = get_alignmentState_val
        If flag_polarityA_val = &H0 Then write_polarityA_val_value = get_polarityA_val
        If flag_evenOddAdj_val = &H0 Then write_evenOddAdj_val_value = get_evenOddAdj_val
        If flag_alignmentComplete_val = &H0 Then write_alignmentComplete_val_value = get_alignmentComplete_val
        If flag_errorCount_val = &H0 Then write_errorCount_val_value = get_errorCount_val
        If flag_scramblerMode_val = &H0 Then write_scramblerMode_val_value = get_scramblerMode_val
        If flag_Enable_PF_Bit_Cnt_val = &H0 Then write_Enable_PF_Bit_Cnt_val_value = get_Enable_PF_Bit_Cnt_val
        If flag_second_load_val = &H0 Then write_second_load_val_value = get_second_load_val

        regValue = leftShift((write_block_lock_val_value and &H1), 15) + leftShift((write_hi_rfer_val_value and &H1), 14) + leftShift((write_alignmentState_val_value and &Hf), 10) + leftShift((write_polarityA_val_value and &H1), 9) + leftShift((write_evenOddAdj_val_value and &H1), 8) + leftShift((write_alignmentComplete_val_value and &H1), 7) + leftShift((write_errorCount_val_value and &H7), 4) + leftShift((write_scramblerMode_val_value and &H3), 2) + leftShift((write_Enable_PF_Bit_Cnt_val_value and &H1), 1) + leftShift((write_second_load_val_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_block_lock_val_value = rightShift(data_low, 15) and &H1
        read_hi_rfer_val_value = rightShift(data_low, 14) and &H1
        read_alignmentState_val_value = rightShift(data_low, 10) and &Hf
        read_polarityA_val_value = rightShift(data_low, 9) and &H1
        read_evenOddAdj_val_value = rightShift(data_low, 8) and &H1
        read_alignmentComplete_val_value = rightShift(data_low, 7) and &H1
        read_errorCount_val_value = rightShift(data_low, 4) and &H7
        read_scramblerMode_val_value = rightShift(data_low, 2) and &H3
        read_Enable_PF_Bit_Cnt_val_value = rightShift(data_low, 1) and &H1
        second_load_val_mask = &H1
        if data_low > LONG_MAX then
            if second_load_val_mask = mask then
                read_second_load_val_value = data_low
            else
                read_second_load_val_value = (data_low - H8000_0000) and second_load_val_mask
            end If
        else
            read_second_load_val_value = data_low and second_load_val_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_block_lock_val_value = &H0
        flag_block_lock_val        = &H0
        write_hi_rfer_val_value = &H0
        flag_hi_rfer_val        = &H0
        write_alignmentState_val_value = &H0
        flag_alignmentState_val        = &H0
        write_polarityA_val_value = &H0
        flag_polarityA_val        = &H0
        write_evenOddAdj_val_value = &H0
        flag_evenOddAdj_val        = &H0
        write_alignmentComplete_val_value = &H0
        flag_alignmentComplete_val        = &H0
        write_errorCount_val_value = &H0
        flag_errorCount_val        = &H0
        write_scramblerMode_val_value = &H0
        flag_scramblerMode_val        = &H0
        write_Enable_PF_Bit_Cnt_val_value = &H0
        flag_Enable_PF_Bit_Cnt_val        = &H0
        write_second_load_val_value = &H0
        flag_second_load_val        = &H0
    End Sub
End Class


'' @REGISTER : BR_GPCS_pcs_misc_ctl4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Bit_Inv_Cnt_val                            [15:12]          get_Bit_Inv_Cnt_val
''                                                             set_Bit_Inv_Cnt_val
''                                                             read_Bit_Inv_Cnt_val
''                                                             write_Bit_Inv_Cnt_val
''---------------------------------------------------------------------------------
'' timerA_val                                 [11:0]           get_timerA_val
''                                                             set_timerA_val
''                                                             read_timerA_val
''                                                             write_timerA_val
''---------------------------------------------------------------------------------
Class REGISTER_BR_GPCS_pcs_misc_ctl4
    Private write_Bit_Inv_Cnt_val_value
    Private read_Bit_Inv_Cnt_val_value
    Private flag_Bit_Inv_Cnt_val
    Private write_timerA_val_value
    Private read_timerA_val_value
    Private flag_timerA_val

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4e
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_Bit_Inv_Cnt_val
        get_Bit_Inv_Cnt_val = read_Bit_Inv_Cnt_val_value
    End Property

    Property Let set_Bit_Inv_Cnt_val(aData)
        write_Bit_Inv_Cnt_val_value = aData
        flag_Bit_Inv_Cnt_val        = &H1
    End Property

    Property Get read_Bit_Inv_Cnt_val
        read
        read_Bit_Inv_Cnt_val = read_Bit_Inv_Cnt_val_value
    End Property

    Property Let write_Bit_Inv_Cnt_val(aData)
        set_Bit_Inv_Cnt_val = aData
        write
    End Property

    Property Get get_timerA_val
        get_timerA_val = read_timerA_val_value
    End Property

    Property Let set_timerA_val(aData)
        write_timerA_val_value = aData
        flag_timerA_val        = &H1
    End Property

    Property Get read_timerA_val
        read
        read_timerA_val = read_timerA_val_value
    End Property

    Property Let write_timerA_val(aData)
        set_timerA_val = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Bit_Inv_Cnt_val_value = rightShift(data_low, 12) and &Hf
        timerA_val_mask = &Hfff
        if data_low > LONG_MAX then
            if timerA_val_mask = mask then
                read_timerA_val_value = data_low
            else
                read_timerA_val_value = (data_low - H8000_0000) and timerA_val_mask
            end If
        else
            read_timerA_val_value = data_low and timerA_val_mask
        end If

    End Sub

    Sub write
        If flag_Bit_Inv_Cnt_val = &H0 or flag_timerA_val = &H0 Then read
        If flag_Bit_Inv_Cnt_val = &H0 Then write_Bit_Inv_Cnt_val_value = get_Bit_Inv_Cnt_val
        If flag_timerA_val = &H0 Then write_timerA_val_value = get_timerA_val

        regValue = leftShift((write_Bit_Inv_Cnt_val_value and &Hf), 12) + leftShift((write_timerA_val_value and &Hfff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Bit_Inv_Cnt_val_value = rightShift(data_low, 12) and &Hf
        timerA_val_mask = &Hfff
        if data_low > LONG_MAX then
            if timerA_val_mask = mask then
                read_timerA_val_value = data_low
            else
                read_timerA_val_value = (data_low - H8000_0000) and timerA_val_mask
            end If
        else
            read_timerA_val_value = data_low and timerA_val_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Bit_Inv_Cnt_val_value = &H0
        flag_Bit_Inv_Cnt_val        = &H0
        write_timerA_val_value = &H0
        flag_timerA_val        = &H0
    End Sub
End Class


'' @REGISTER : BR_GPCS_pcs_misc_ctl5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rcvd_pattern_val                           [15:0]           get_rcvd_pattern_val
''                                                             set_rcvd_pattern_val
''                                                             read_rcvd_pattern_val
''                                                             write_rcvd_pattern_val
''---------------------------------------------------------------------------------
Class REGISTER_BR_GPCS_pcs_misc_ctl5
    Private write_rcvd_pattern_val_value
    Private read_rcvd_pattern_val_value
    Private flag_rcvd_pattern_val

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H50
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_rcvd_pattern_val
        get_rcvd_pattern_val = read_rcvd_pattern_val_value
    End Property

    Property Let set_rcvd_pattern_val(aData)
        write_rcvd_pattern_val_value = aData
        flag_rcvd_pattern_val        = &H1
    End Property

    Property Get read_rcvd_pattern_val
        read
        read_rcvd_pattern_val = read_rcvd_pattern_val_value
    End Property

    Property Let write_rcvd_pattern_val(aData)
        set_rcvd_pattern_val = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rcvd_pattern_val_mask = &Hffff
        if data_low > LONG_MAX then
            if rcvd_pattern_val_mask = mask then
                read_rcvd_pattern_val_value = data_low
            else
                read_rcvd_pattern_val_value = (data_low - H8000_0000) and rcvd_pattern_val_mask
            end If
        else
            read_rcvd_pattern_val_value = data_low and rcvd_pattern_val_mask
        end If

    End Sub

    Sub write
        If flag_rcvd_pattern_val = &H0 Then read
        If flag_rcvd_pattern_val = &H0 Then write_rcvd_pattern_val_value = get_rcvd_pattern_val

        regValue = leftShift((write_rcvd_pattern_val_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rcvd_pattern_val_mask = &Hffff
        if data_low > LONG_MAX then
            if rcvd_pattern_val_mask = mask then
                read_rcvd_pattern_val_value = data_low
            else
                read_rcvd_pattern_val_value = (data_low - H8000_0000) and rcvd_pattern_val_mask
            end If
        else
            read_rcvd_pattern_val_value = data_low and rcvd_pattern_val_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rcvd_pattern_val_value = &H0
        flag_rcvd_pattern_val        = &H0
    End Sub
End Class


'' @REGISTER : BR_GPCS_pcs_misc_ctl6
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' spare_15_10                                [15:10]          get_spare_15_10
''                                                             set_spare_15_10
''                                                             read_spare_15_10
''                                                             write_spare_15_10
''---------------------------------------------------------------------------------
'' PCS_status_val                             [9:9]            get_PCS_status_val
''                                                             set_PCS_status_val
''                                                             read_PCS_status_val
''                                                             write_PCS_status_val
''---------------------------------------------------------------------------------
'' info_srch_val                              [8:8]            get_info_srch_val
''                                                             set_info_srch_val
''                                                             read_info_srch_val
''                                                             write_info_srch_val
''---------------------------------------------------------------------------------
'' rcvd_pattern_val                           [7:0]            get_rcvd_pattern_val
''                                                             set_rcvd_pattern_val
''                                                             read_rcvd_pattern_val
''                                                             write_rcvd_pattern_val
''---------------------------------------------------------------------------------
Class REGISTER_BR_GPCS_pcs_misc_ctl6
    Private write_spare_15_10_value
    Private read_spare_15_10_value
    Private flag_spare_15_10
    Private write_PCS_status_val_value
    Private read_PCS_status_val_value
    Private flag_PCS_status_val
    Private write_info_srch_val_value
    Private read_info_srch_val_value
    Private flag_info_srch_val
    Private write_rcvd_pattern_val_value
    Private read_rcvd_pattern_val_value
    Private flag_rcvd_pattern_val

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H52
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_spare_15_10
        get_spare_15_10 = read_spare_15_10_value
    End Property

    Property Let set_spare_15_10(aData)
        write_spare_15_10_value = aData
        flag_spare_15_10        = &H1
    End Property

    Property Get read_spare_15_10
        read
        read_spare_15_10 = read_spare_15_10_value
    End Property

    Property Let write_spare_15_10(aData)
        set_spare_15_10 = aData
        write
    End Property

    Property Get get_PCS_status_val
        get_PCS_status_val = read_PCS_status_val_value
    End Property

    Property Let set_PCS_status_val(aData)
        write_PCS_status_val_value = aData
        flag_PCS_status_val        = &H1
    End Property

    Property Get read_PCS_status_val
        read
        read_PCS_status_val = read_PCS_status_val_value
    End Property

    Property Let write_PCS_status_val(aData)
        set_PCS_status_val = aData
        write
    End Property

    Property Get get_info_srch_val
        get_info_srch_val = read_info_srch_val_value
    End Property

    Property Let set_info_srch_val(aData)
        write_info_srch_val_value = aData
        flag_info_srch_val        = &H1
    End Property

    Property Get read_info_srch_val
        read
        read_info_srch_val = read_info_srch_val_value
    End Property

    Property Let write_info_srch_val(aData)
        set_info_srch_val = aData
        write
    End Property

    Property Get get_rcvd_pattern_val
        get_rcvd_pattern_val = read_rcvd_pattern_val_value
    End Property

    Property Let set_rcvd_pattern_val(aData)
        write_rcvd_pattern_val_value = aData
        flag_rcvd_pattern_val        = &H1
    End Property

    Property Get read_rcvd_pattern_val
        read
        read_rcvd_pattern_val = read_rcvd_pattern_val_value
    End Property

    Property Let write_rcvd_pattern_val(aData)
        set_rcvd_pattern_val = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_spare_15_10_value = rightShift(data_low, 10) and &H3f
        read_PCS_status_val_value = rightShift(data_low, 9) and &H1
        read_info_srch_val_value = rightShift(data_low, 8) and &H1
        rcvd_pattern_val_mask = &Hff
        if data_low > LONG_MAX then
            if rcvd_pattern_val_mask = mask then
                read_rcvd_pattern_val_value = data_low
            else
                read_rcvd_pattern_val_value = (data_low - H8000_0000) and rcvd_pattern_val_mask
            end If
        else
            read_rcvd_pattern_val_value = data_low and rcvd_pattern_val_mask
        end If

    End Sub

    Sub write
        If flag_spare_15_10 = &H0 or flag_PCS_status_val = &H0 or flag_info_srch_val = &H0 or flag_rcvd_pattern_val = &H0 Then read
        If flag_spare_15_10 = &H0 Then write_spare_15_10_value = get_spare_15_10
        If flag_PCS_status_val = &H0 Then write_PCS_status_val_value = get_PCS_status_val
        If flag_info_srch_val = &H0 Then write_info_srch_val_value = get_info_srch_val
        If flag_rcvd_pattern_val = &H0 Then write_rcvd_pattern_val_value = get_rcvd_pattern_val

        regValue = leftShift((write_spare_15_10_value and &H3f), 10) + leftShift((write_PCS_status_val_value and &H1), 9) + leftShift((write_info_srch_val_value and &H1), 8) + leftShift((write_rcvd_pattern_val_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_spare_15_10_value = rightShift(data_low, 10) and &H3f
        read_PCS_status_val_value = rightShift(data_low, 9) and &H1
        read_info_srch_val_value = rightShift(data_low, 8) and &H1
        rcvd_pattern_val_mask = &Hff
        if data_low > LONG_MAX then
            if rcvd_pattern_val_mask = mask then
                read_rcvd_pattern_val_value = data_low
            else
                read_rcvd_pattern_val_value = (data_low - H8000_0000) and rcvd_pattern_val_mask
            end If
        else
            read_rcvd_pattern_val_value = data_low and rcvd_pattern_val_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_spare_15_10_value = &H0
        flag_spare_15_10        = &H0
        write_PCS_status_val_value = &H0
        flag_PCS_status_val        = &H0
        write_info_srch_val_value = &H0
        flag_info_srch_val        = &H0
        write_rcvd_pattern_val_value = &H0
        flag_rcvd_pattern_val        = &H0
    End Sub
End Class


'' @REGISTER : BR_GPCS_pcs_misc_ctl7
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rx_ov_ctrl_1                               [15:0]           get_rx_ov_ctrl_1
''                                                             set_rx_ov_ctrl_1
''                                                             read_rx_ov_ctrl_1
''                                                             write_rx_ov_ctrl_1
''---------------------------------------------------------------------------------
Class REGISTER_BR_GPCS_pcs_misc_ctl7
    Private write_rx_ov_ctrl_1_value
    Private read_rx_ov_ctrl_1_value
    Private flag_rx_ov_ctrl_1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H54
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_rx_ov_ctrl_1
        get_rx_ov_ctrl_1 = read_rx_ov_ctrl_1_value
    End Property

    Property Let set_rx_ov_ctrl_1(aData)
        write_rx_ov_ctrl_1_value = aData
        flag_rx_ov_ctrl_1        = &H1
    End Property

    Property Get read_rx_ov_ctrl_1
        read
        read_rx_ov_ctrl_1 = read_rx_ov_ctrl_1_value
    End Property

    Property Let write_rx_ov_ctrl_1(aData)
        set_rx_ov_ctrl_1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rx_ov_ctrl_1_mask = &Hffff
        if data_low > LONG_MAX then
            if rx_ov_ctrl_1_mask = mask then
                read_rx_ov_ctrl_1_value = data_low
            else
                read_rx_ov_ctrl_1_value = (data_low - H8000_0000) and rx_ov_ctrl_1_mask
            end If
        else
            read_rx_ov_ctrl_1_value = data_low and rx_ov_ctrl_1_mask
        end If

    End Sub

    Sub write
        If flag_rx_ov_ctrl_1 = &H0 Then read
        If flag_rx_ov_ctrl_1 = &H0 Then write_rx_ov_ctrl_1_value = get_rx_ov_ctrl_1

        regValue = leftShift((write_rx_ov_ctrl_1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rx_ov_ctrl_1_mask = &Hffff
        if data_low > LONG_MAX then
            if rx_ov_ctrl_1_mask = mask then
                read_rx_ov_ctrl_1_value = data_low
            else
                read_rx_ov_ctrl_1_value = (data_low - H8000_0000) and rx_ov_ctrl_1_mask
            end If
        else
            read_rx_ov_ctrl_1_value = data_low and rx_ov_ctrl_1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rx_ov_ctrl_1_value = &H0
        flag_rx_ov_ctrl_1        = &H0
    End Sub
End Class


'' @REGISTER : BR_GPCS_pcs_misc_ctl8
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LP_OAMen_val                               [14:14]          get_LP_OAMen_val
''                                                             set_LP_OAMen_val
''                                                             read_LP_OAMen_val
''                                                             write_LP_OAMen_val
''---------------------------------------------------------------------------------
'' ALIGN_OK_val                               [13:13]          get_ALIGN_OK_val
''                                                             set_ALIGN_OK_val
''                                                             read_ALIGN_OK_val
''                                                             write_ALIGN_OK_val
''---------------------------------------------------------------------------------
'' Enable_Scr15_val                           [12:12]          get_Enable_Scr15_val
''                                                             set_Enable_Scr15_val
''                                                             read_Enable_Scr15_val
''                                                             write_Enable_Scr15_val
''---------------------------------------------------------------------------------
'' en_fdx_detect_val                          [11:11]          get_en_fdx_detect_val
''                                                             set_en_fdx_detect_val
''                                                             read_en_fdx_detect_val
''                                                             write_en_fdx_detect_val
''---------------------------------------------------------------------------------
'' rem_rcvr_status_val                        [10:10]          get_rem_rcvr_status_val
''                                                             set_rem_rcvr_status_val
''                                                             read_rem_rcvr_status_val
''                                                             write_rem_rcvr_status_val
''---------------------------------------------------------------------------------
'' pcs_scr_start_val                          [9:9]            get_pcs_scr_start_val
''                                                             set_pcs_scr_start_val
''                                                             read_pcs_scr_start_val
''                                                             write_pcs_scr_start_val
''---------------------------------------------------------------------------------
'' dec_out_err_val                            [8:8]            get_dec_out_err_val
''                                                             set_dec_out_err_val
''                                                             read_dec_out_err_val
''                                                             write_dec_out_err_val
''---------------------------------------------------------------------------------
'' id_idle_good_val                           [7:7]            get_id_idle_good_val
''                                                             set_id_idle_good_val
''                                                             read_id_idle_good_val
''                                                             write_id_idle_good_val
''---------------------------------------------------------------------------------
'' rem_countdown_done_val                     [6:6]            get_rem_countdown_done_val
''                                                             set_rem_countdown_done_val
''                                                             read_rem_countdown_done_val
''                                                             write_rem_countdown_done_val
''---------------------------------------------------------------------------------
'' RX_AGGREGATE_val                           [5:5]            get_RX_AGGREGATE_val
''                                                             set_RX_AGGREGATE_val
''                                                             read_RX_AGGREGATE_val
''                                                             write_RX_AGGREGATE_val
''---------------------------------------------------------------------------------
'' RX_STATE_val                               [4:4]            get_RX_STATE_val
''                                                             set_RX_STATE_val
''                                                             read_RX_STATE_val
''                                                             write_RX_STATE_val
''---------------------------------------------------------------------------------
'' false_ptr_1_val                            [3:3]            get_false_ptr_1_val
''                                                             set_false_ptr_1_val
''                                                             read_false_ptr_1_val
''                                                             write_false_ptr_1_val
''---------------------------------------------------------------------------------
'' false_ptr_2_val                            [2:2]            get_false_ptr_2_val
''                                                             set_false_ptr_2_val
''                                                             read_false_ptr_2_val
''                                                             write_false_ptr_2_val
''---------------------------------------------------------------------------------
'' false_ptr_3_val                            [1:1]            get_false_ptr_3_val
''                                                             set_false_ptr_3_val
''                                                             read_false_ptr_3_val
''                                                             write_false_ptr_3_val
''---------------------------------------------------------------------------------
'' rem_phy_ready_val                          [0:0]            get_rem_phy_ready_val
''                                                             set_rem_phy_ready_val
''                                                             read_rem_phy_ready_val
''                                                             write_rem_phy_ready_val
''---------------------------------------------------------------------------------
Class REGISTER_BR_GPCS_pcs_misc_ctl8
    Private write_LP_OAMen_val_value
    Private read_LP_OAMen_val_value
    Private flag_LP_OAMen_val
    Private write_ALIGN_OK_val_value
    Private read_ALIGN_OK_val_value
    Private flag_ALIGN_OK_val
    Private write_Enable_Scr15_val_value
    Private read_Enable_Scr15_val_value
    Private flag_Enable_Scr15_val
    Private write_en_fdx_detect_val_value
    Private read_en_fdx_detect_val_value
    Private flag_en_fdx_detect_val
    Private write_rem_rcvr_status_val_value
    Private read_rem_rcvr_status_val_value
    Private flag_rem_rcvr_status_val
    Private write_pcs_scr_start_val_value
    Private read_pcs_scr_start_val_value
    Private flag_pcs_scr_start_val
    Private write_dec_out_err_val_value
    Private read_dec_out_err_val_value
    Private flag_dec_out_err_val
    Private write_id_idle_good_val_value
    Private read_id_idle_good_val_value
    Private flag_id_idle_good_val
    Private write_rem_countdown_done_val_value
    Private read_rem_countdown_done_val_value
    Private flag_rem_countdown_done_val
    Private write_RX_AGGREGATE_val_value
    Private read_RX_AGGREGATE_val_value
    Private flag_RX_AGGREGATE_val
    Private write_RX_STATE_val_value
    Private read_RX_STATE_val_value
    Private flag_RX_STATE_val
    Private write_false_ptr_1_val_value
    Private read_false_ptr_1_val_value
    Private flag_false_ptr_1_val
    Private write_false_ptr_2_val_value
    Private read_false_ptr_2_val_value
    Private flag_false_ptr_2_val
    Private write_false_ptr_3_val_value
    Private read_false_ptr_3_val_value
    Private flag_false_ptr_3_val
    Private write_rem_phy_ready_val_value
    Private read_rem_phy_ready_val_value
    Private flag_rem_phy_ready_val

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H56
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_LP_OAMen_val
        get_LP_OAMen_val = read_LP_OAMen_val_value
    End Property

    Property Let set_LP_OAMen_val(aData)
        write_LP_OAMen_val_value = aData
        flag_LP_OAMen_val        = &H1
    End Property

    Property Get read_LP_OAMen_val
        read
        read_LP_OAMen_val = read_LP_OAMen_val_value
    End Property

    Property Let write_LP_OAMen_val(aData)
        set_LP_OAMen_val = aData
        write
    End Property

    Property Get get_ALIGN_OK_val
        get_ALIGN_OK_val = read_ALIGN_OK_val_value
    End Property

    Property Let set_ALIGN_OK_val(aData)
        write_ALIGN_OK_val_value = aData
        flag_ALIGN_OK_val        = &H1
    End Property

    Property Get read_ALIGN_OK_val
        read
        read_ALIGN_OK_val = read_ALIGN_OK_val_value
    End Property

    Property Let write_ALIGN_OK_val(aData)
        set_ALIGN_OK_val = aData
        write
    End Property

    Property Get get_Enable_Scr15_val
        get_Enable_Scr15_val = read_Enable_Scr15_val_value
    End Property

    Property Let set_Enable_Scr15_val(aData)
        write_Enable_Scr15_val_value = aData
        flag_Enable_Scr15_val        = &H1
    End Property

    Property Get read_Enable_Scr15_val
        read
        read_Enable_Scr15_val = read_Enable_Scr15_val_value
    End Property

    Property Let write_Enable_Scr15_val(aData)
        set_Enable_Scr15_val = aData
        write
    End Property

    Property Get get_en_fdx_detect_val
        get_en_fdx_detect_val = read_en_fdx_detect_val_value
    End Property

    Property Let set_en_fdx_detect_val(aData)
        write_en_fdx_detect_val_value = aData
        flag_en_fdx_detect_val        = &H1
    End Property

    Property Get read_en_fdx_detect_val
        read
        read_en_fdx_detect_val = read_en_fdx_detect_val_value
    End Property

    Property Let write_en_fdx_detect_val(aData)
        set_en_fdx_detect_val = aData
        write
    End Property

    Property Get get_rem_rcvr_status_val
        get_rem_rcvr_status_val = read_rem_rcvr_status_val_value
    End Property

    Property Let set_rem_rcvr_status_val(aData)
        write_rem_rcvr_status_val_value = aData
        flag_rem_rcvr_status_val        = &H1
    End Property

    Property Get read_rem_rcvr_status_val
        read
        read_rem_rcvr_status_val = read_rem_rcvr_status_val_value
    End Property

    Property Let write_rem_rcvr_status_val(aData)
        set_rem_rcvr_status_val = aData
        write
    End Property

    Property Get get_pcs_scr_start_val
        get_pcs_scr_start_val = read_pcs_scr_start_val_value
    End Property

    Property Let set_pcs_scr_start_val(aData)
        write_pcs_scr_start_val_value = aData
        flag_pcs_scr_start_val        = &H1
    End Property

    Property Get read_pcs_scr_start_val
        read
        read_pcs_scr_start_val = read_pcs_scr_start_val_value
    End Property

    Property Let write_pcs_scr_start_val(aData)
        set_pcs_scr_start_val = aData
        write
    End Property

    Property Get get_dec_out_err_val
        get_dec_out_err_val = read_dec_out_err_val_value
    End Property

    Property Let set_dec_out_err_val(aData)
        write_dec_out_err_val_value = aData
        flag_dec_out_err_val        = &H1
    End Property

    Property Get read_dec_out_err_val
        read
        read_dec_out_err_val = read_dec_out_err_val_value
    End Property

    Property Let write_dec_out_err_val(aData)
        set_dec_out_err_val = aData
        write
    End Property

    Property Get get_id_idle_good_val
        get_id_idle_good_val = read_id_idle_good_val_value
    End Property

    Property Let set_id_idle_good_val(aData)
        write_id_idle_good_val_value = aData
        flag_id_idle_good_val        = &H1
    End Property

    Property Get read_id_idle_good_val
        read
        read_id_idle_good_val = read_id_idle_good_val_value
    End Property

    Property Let write_id_idle_good_val(aData)
        set_id_idle_good_val = aData
        write
    End Property

    Property Get get_rem_countdown_done_val
        get_rem_countdown_done_val = read_rem_countdown_done_val_value
    End Property

    Property Let set_rem_countdown_done_val(aData)
        write_rem_countdown_done_val_value = aData
        flag_rem_countdown_done_val        = &H1
    End Property

    Property Get read_rem_countdown_done_val
        read
        read_rem_countdown_done_val = read_rem_countdown_done_val_value
    End Property

    Property Let write_rem_countdown_done_val(aData)
        set_rem_countdown_done_val = aData
        write
    End Property

    Property Get get_RX_AGGREGATE_val
        get_RX_AGGREGATE_val = read_RX_AGGREGATE_val_value
    End Property

    Property Let set_RX_AGGREGATE_val(aData)
        write_RX_AGGREGATE_val_value = aData
        flag_RX_AGGREGATE_val        = &H1
    End Property

    Property Get read_RX_AGGREGATE_val
        read
        read_RX_AGGREGATE_val = read_RX_AGGREGATE_val_value
    End Property

    Property Let write_RX_AGGREGATE_val(aData)
        set_RX_AGGREGATE_val = aData
        write
    End Property

    Property Get get_RX_STATE_val
        get_RX_STATE_val = read_RX_STATE_val_value
    End Property

    Property Let set_RX_STATE_val(aData)
        write_RX_STATE_val_value = aData
        flag_RX_STATE_val        = &H1
    End Property

    Property Get read_RX_STATE_val
        read
        read_RX_STATE_val = read_RX_STATE_val_value
    End Property

    Property Let write_RX_STATE_val(aData)
        set_RX_STATE_val = aData
        write
    End Property

    Property Get get_false_ptr_1_val
        get_false_ptr_1_val = read_false_ptr_1_val_value
    End Property

    Property Let set_false_ptr_1_val(aData)
        write_false_ptr_1_val_value = aData
        flag_false_ptr_1_val        = &H1
    End Property

    Property Get read_false_ptr_1_val
        read
        read_false_ptr_1_val = read_false_ptr_1_val_value
    End Property

    Property Let write_false_ptr_1_val(aData)
        set_false_ptr_1_val = aData
        write
    End Property

    Property Get get_false_ptr_2_val
        get_false_ptr_2_val = read_false_ptr_2_val_value
    End Property

    Property Let set_false_ptr_2_val(aData)
        write_false_ptr_2_val_value = aData
        flag_false_ptr_2_val        = &H1
    End Property

    Property Get read_false_ptr_2_val
        read
        read_false_ptr_2_val = read_false_ptr_2_val_value
    End Property

    Property Let write_false_ptr_2_val(aData)
        set_false_ptr_2_val = aData
        write
    End Property

    Property Get get_false_ptr_3_val
        get_false_ptr_3_val = read_false_ptr_3_val_value
    End Property

    Property Let set_false_ptr_3_val(aData)
        write_false_ptr_3_val_value = aData
        flag_false_ptr_3_val        = &H1
    End Property

    Property Get read_false_ptr_3_val
        read
        read_false_ptr_3_val = read_false_ptr_3_val_value
    End Property

    Property Let write_false_ptr_3_val(aData)
        set_false_ptr_3_val = aData
        write
    End Property

    Property Get get_rem_phy_ready_val
        get_rem_phy_ready_val = read_rem_phy_ready_val_value
    End Property

    Property Let set_rem_phy_ready_val(aData)
        write_rem_phy_ready_val_value = aData
        flag_rem_phy_ready_val        = &H1
    End Property

    Property Get read_rem_phy_ready_val
        read
        read_rem_phy_ready_val = read_rem_phy_ready_val_value
    End Property

    Property Let write_rem_phy_ready_val(aData)
        set_rem_phy_ready_val = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LP_OAMen_val_value = rightShift(data_low, 14) and &H1
        read_ALIGN_OK_val_value = rightShift(data_low, 13) and &H1
        read_Enable_Scr15_val_value = rightShift(data_low, 12) and &H1
        read_en_fdx_detect_val_value = rightShift(data_low, 11) and &H1
        read_rem_rcvr_status_val_value = rightShift(data_low, 10) and &H1
        read_pcs_scr_start_val_value = rightShift(data_low, 9) and &H1
        read_dec_out_err_val_value = rightShift(data_low, 8) and &H1
        read_id_idle_good_val_value = rightShift(data_low, 7) and &H1
        read_rem_countdown_done_val_value = rightShift(data_low, 6) and &H1
        read_RX_AGGREGATE_val_value = rightShift(data_low, 5) and &H1
        read_RX_STATE_val_value = rightShift(data_low, 4) and &H1
        read_false_ptr_1_val_value = rightShift(data_low, 3) and &H1
        read_false_ptr_2_val_value = rightShift(data_low, 2) and &H1
        read_false_ptr_3_val_value = rightShift(data_low, 1) and &H1
        rem_phy_ready_val_mask = &H1
        if data_low > LONG_MAX then
            if rem_phy_ready_val_mask = mask then
                read_rem_phy_ready_val_value = data_low
            else
                read_rem_phy_ready_val_value = (data_low - H8000_0000) and rem_phy_ready_val_mask
            end If
        else
            read_rem_phy_ready_val_value = data_low and rem_phy_ready_val_mask
        end If

    End Sub

    Sub write
        If flag_LP_OAMen_val = &H0 or flag_ALIGN_OK_val = &H0 or flag_Enable_Scr15_val = &H0 or flag_en_fdx_detect_val = &H0 or flag_rem_rcvr_status_val = &H0 or flag_pcs_scr_start_val = &H0 or flag_dec_out_err_val = &H0 or flag_id_idle_good_val = &H0 or flag_rem_countdown_done_val = &H0 or flag_RX_AGGREGATE_val = &H0 or flag_RX_STATE_val = &H0 or flag_false_ptr_1_val = &H0 or flag_false_ptr_2_val = &H0 or flag_false_ptr_3_val = &H0 or flag_rem_phy_ready_val = &H0 Then read
        If flag_LP_OAMen_val = &H0 Then write_LP_OAMen_val_value = get_LP_OAMen_val
        If flag_ALIGN_OK_val = &H0 Then write_ALIGN_OK_val_value = get_ALIGN_OK_val
        If flag_Enable_Scr15_val = &H0 Then write_Enable_Scr15_val_value = get_Enable_Scr15_val
        If flag_en_fdx_detect_val = &H0 Then write_en_fdx_detect_val_value = get_en_fdx_detect_val
        If flag_rem_rcvr_status_val = &H0 Then write_rem_rcvr_status_val_value = get_rem_rcvr_status_val
        If flag_pcs_scr_start_val = &H0 Then write_pcs_scr_start_val_value = get_pcs_scr_start_val
        If flag_dec_out_err_val = &H0 Then write_dec_out_err_val_value = get_dec_out_err_val
        If flag_id_idle_good_val = &H0 Then write_id_idle_good_val_value = get_id_idle_good_val
        If flag_rem_countdown_done_val = &H0 Then write_rem_countdown_done_val_value = get_rem_countdown_done_val
        If flag_RX_AGGREGATE_val = &H0 Then write_RX_AGGREGATE_val_value = get_RX_AGGREGATE_val
        If flag_RX_STATE_val = &H0 Then write_RX_STATE_val_value = get_RX_STATE_val
        If flag_false_ptr_1_val = &H0 Then write_false_ptr_1_val_value = get_false_ptr_1_val
        If flag_false_ptr_2_val = &H0 Then write_false_ptr_2_val_value = get_false_ptr_2_val
        If flag_false_ptr_3_val = &H0 Then write_false_ptr_3_val_value = get_false_ptr_3_val
        If flag_rem_phy_ready_val = &H0 Then write_rem_phy_ready_val_value = get_rem_phy_ready_val

        regValue = leftShift((write_LP_OAMen_val_value and &H1), 14) + leftShift((write_ALIGN_OK_val_value and &H1), 13) + leftShift((write_Enable_Scr15_val_value and &H1), 12) + leftShift((write_en_fdx_detect_val_value and &H1), 11) + leftShift((write_rem_rcvr_status_val_value and &H1), 10) + leftShift((write_pcs_scr_start_val_value and &H1), 9) + leftShift((write_dec_out_err_val_value and &H1), 8) + leftShift((write_id_idle_good_val_value and &H1), 7) + leftShift((write_rem_countdown_done_val_value and &H1), 6) + leftShift((write_RX_AGGREGATE_val_value and &H1), 5) + leftShift((write_RX_STATE_val_value and &H1), 4) + leftShift((write_false_ptr_1_val_value and &H1), 3) + leftShift((write_false_ptr_2_val_value and &H1), 2) + leftShift((write_false_ptr_3_val_value and &H1), 1) + leftShift((write_rem_phy_ready_val_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LP_OAMen_val_value = rightShift(data_low, 14) and &H1
        read_ALIGN_OK_val_value = rightShift(data_low, 13) and &H1
        read_Enable_Scr15_val_value = rightShift(data_low, 12) and &H1
        read_en_fdx_detect_val_value = rightShift(data_low, 11) and &H1
        read_rem_rcvr_status_val_value = rightShift(data_low, 10) and &H1
        read_pcs_scr_start_val_value = rightShift(data_low, 9) and &H1
        read_dec_out_err_val_value = rightShift(data_low, 8) and &H1
        read_id_idle_good_val_value = rightShift(data_low, 7) and &H1
        read_rem_countdown_done_val_value = rightShift(data_low, 6) and &H1
        read_RX_AGGREGATE_val_value = rightShift(data_low, 5) and &H1
        read_RX_STATE_val_value = rightShift(data_low, 4) and &H1
        read_false_ptr_1_val_value = rightShift(data_low, 3) and &H1
        read_false_ptr_2_val_value = rightShift(data_low, 2) and &H1
        read_false_ptr_3_val_value = rightShift(data_low, 1) and &H1
        rem_phy_ready_val_mask = &H1
        if data_low > LONG_MAX then
            if rem_phy_ready_val_mask = mask then
                read_rem_phy_ready_val_value = data_low
            else
                read_rem_phy_ready_val_value = (data_low - H8000_0000) and rem_phy_ready_val_mask
            end If
        else
            read_rem_phy_ready_val_value = data_low and rem_phy_ready_val_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LP_OAMen_val_value = &H0
        flag_LP_OAMen_val        = &H0
        write_ALIGN_OK_val_value = &H0
        flag_ALIGN_OK_val        = &H0
        write_Enable_Scr15_val_value = &H0
        flag_Enable_Scr15_val        = &H0
        write_en_fdx_detect_val_value = &H0
        flag_en_fdx_detect_val        = &H0
        write_rem_rcvr_status_val_value = &H0
        flag_rem_rcvr_status_val        = &H0
        write_pcs_scr_start_val_value = &H0
        flag_pcs_scr_start_val        = &H0
        write_dec_out_err_val_value = &H0
        flag_dec_out_err_val        = &H0
        write_id_idle_good_val_value = &H0
        flag_id_idle_good_val        = &H0
        write_rem_countdown_done_val_value = &H0
        flag_rem_countdown_done_val        = &H0
        write_RX_AGGREGATE_val_value = &H0
        flag_RX_AGGREGATE_val        = &H0
        write_RX_STATE_val_value = &H0
        flag_RX_STATE_val        = &H0
        write_false_ptr_1_val_value = &H0
        flag_false_ptr_1_val        = &H0
        write_false_ptr_2_val_value = &H0
        flag_false_ptr_2_val        = &H0
        write_false_ptr_3_val_value = &H0
        flag_false_ptr_3_val        = &H0
        write_rem_phy_ready_val_value = &H0
        flag_rem_phy_ready_val        = &H0
    End Sub
End Class


'' @REGISTER : BR_GPCS_pcs_misc_ctl9
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' spare_15_3                                 [15:3]           get_spare_15_3
''                                                             set_spare_15_3
''                                                             read_spare_15_3
''                                                             write_spare_15_3
''---------------------------------------------------------------------------------
'' invalid_block_sel                          [2:2]            get_invalid_block_sel
''                                                             set_invalid_block_sel
''                                                             read_invalid_block_sel
''                                                             write_invalid_block_sel
''---------------------------------------------------------------------------------
'' txlpi_conv_en                              [1:1]            get_txlpi_conv_en
''                                                             set_txlpi_conv_en
''                                                             read_txlpi_conv_en
''                                                             write_txlpi_conv_en
''---------------------------------------------------------------------------------
'' rxlpi_conv_en                              [0:0]            get_rxlpi_conv_en
''                                                             set_rxlpi_conv_en
''                                                             read_rxlpi_conv_en
''                                                             write_rxlpi_conv_en
''---------------------------------------------------------------------------------
Class REGISTER_BR_GPCS_pcs_misc_ctl9
    Private write_spare_15_3_value
    Private read_spare_15_3_value
    Private flag_spare_15_3
    Private write_invalid_block_sel_value
    Private read_invalid_block_sel_value
    Private flag_invalid_block_sel
    Private write_txlpi_conv_en_value
    Private read_txlpi_conv_en_value
    Private flag_txlpi_conv_en
    Private write_rxlpi_conv_en_value
    Private read_rxlpi_conv_en_value
    Private flag_rxlpi_conv_en

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H58
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_spare_15_3
        get_spare_15_3 = read_spare_15_3_value
    End Property

    Property Let set_spare_15_3(aData)
        write_spare_15_3_value = aData
        flag_spare_15_3        = &H1
    End Property

    Property Get read_spare_15_3
        read
        read_spare_15_3 = read_spare_15_3_value
    End Property

    Property Let write_spare_15_3(aData)
        set_spare_15_3 = aData
        write
    End Property

    Property Get get_invalid_block_sel
        get_invalid_block_sel = read_invalid_block_sel_value
    End Property

    Property Let set_invalid_block_sel(aData)
        write_invalid_block_sel_value = aData
        flag_invalid_block_sel        = &H1
    End Property

    Property Get read_invalid_block_sel
        read
        read_invalid_block_sel = read_invalid_block_sel_value
    End Property

    Property Let write_invalid_block_sel(aData)
        set_invalid_block_sel = aData
        write
    End Property

    Property Get get_txlpi_conv_en
        get_txlpi_conv_en = read_txlpi_conv_en_value
    End Property

    Property Let set_txlpi_conv_en(aData)
        write_txlpi_conv_en_value = aData
        flag_txlpi_conv_en        = &H1
    End Property

    Property Get read_txlpi_conv_en
        read
        read_txlpi_conv_en = read_txlpi_conv_en_value
    End Property

    Property Let write_txlpi_conv_en(aData)
        set_txlpi_conv_en = aData
        write
    End Property

    Property Get get_rxlpi_conv_en
        get_rxlpi_conv_en = read_rxlpi_conv_en_value
    End Property

    Property Let set_rxlpi_conv_en(aData)
        write_rxlpi_conv_en_value = aData
        flag_rxlpi_conv_en        = &H1
    End Property

    Property Get read_rxlpi_conv_en
        read
        read_rxlpi_conv_en = read_rxlpi_conv_en_value
    End Property

    Property Let write_rxlpi_conv_en(aData)
        set_rxlpi_conv_en = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_spare_15_3_value = rightShift(data_low, 3) and &H1fff
        read_invalid_block_sel_value = rightShift(data_low, 2) and &H1
        read_txlpi_conv_en_value = rightShift(data_low, 1) and &H1
        rxlpi_conv_en_mask = &H1
        if data_low > LONG_MAX then
            if rxlpi_conv_en_mask = mask then
                read_rxlpi_conv_en_value = data_low
            else
                read_rxlpi_conv_en_value = (data_low - H8000_0000) and rxlpi_conv_en_mask
            end If
        else
            read_rxlpi_conv_en_value = data_low and rxlpi_conv_en_mask
        end If

    End Sub

    Sub write
        If flag_spare_15_3 = &H0 or flag_invalid_block_sel = &H0 or flag_txlpi_conv_en = &H0 or flag_rxlpi_conv_en = &H0 Then read
        If flag_spare_15_3 = &H0 Then write_spare_15_3_value = get_spare_15_3
        If flag_invalid_block_sel = &H0 Then write_invalid_block_sel_value = get_invalid_block_sel
        If flag_txlpi_conv_en = &H0 Then write_txlpi_conv_en_value = get_txlpi_conv_en
        If flag_rxlpi_conv_en = &H0 Then write_rxlpi_conv_en_value = get_rxlpi_conv_en

        regValue = leftShift((write_spare_15_3_value and &H1fff), 3) + leftShift((write_invalid_block_sel_value and &H1), 2) + leftShift((write_txlpi_conv_en_value and &H1), 1) + leftShift((write_rxlpi_conv_en_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_spare_15_3_value = rightShift(data_low, 3) and &H1fff
        read_invalid_block_sel_value = rightShift(data_low, 2) and &H1
        read_txlpi_conv_en_value = rightShift(data_low, 1) and &H1
        rxlpi_conv_en_mask = &H1
        if data_low > LONG_MAX then
            if rxlpi_conv_en_mask = mask then
                read_rxlpi_conv_en_value = data_low
            else
                read_rxlpi_conv_en_value = (data_low - H8000_0000) and rxlpi_conv_en_mask
            end If
        else
            read_rxlpi_conv_en_value = data_low and rxlpi_conv_en_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_spare_15_3_value = &H0
        flag_spare_15_3        = &H0
        write_invalid_block_sel_value = &H0
        flag_invalid_block_sel        = &H0
        write_txlpi_conv_en_value = &H0
        flag_txlpi_conv_en        = &H0
        write_rxlpi_conv_en_value = &H0
        flag_rxlpi_conv_en        = &H0
    End Sub
End Class


'' @REGISTER : BR_GPCS_pcs_misc_ctl10
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' spare_15                                   [15:15]          get_spare_15
''                                                             set_spare_15
''                                                             read_spare_15
''                                                             write_spare_15
''---------------------------------------------------------------------------------
'' ptr_nflag_ov                               [14:14]          get_ptr_nflag_ov
''                                                             set_ptr_nflag_ov
''                                                             read_ptr_nflag_ov
''                                                             write_ptr_nflag_ov
''---------------------------------------------------------------------------------
'' ptr_nflag_val                              [13:13]          get_ptr_nflag_val
''                                                             set_ptr_nflag_val
''                                                             read_ptr_nflag_val
''                                                             write_ptr_nflag_val
''---------------------------------------------------------------------------------
'' byte_loc_val                               [12:9]           get_byte_loc_val
''                                                             set_byte_loc_val
''                                                             read_byte_loc_val
''                                                             write_byte_loc_val
''---------------------------------------------------------------------------------
'' ptr_cnt_ov                                 [8:8]            get_ptr_cnt_ov
''                                                             set_ptr_cnt_ov
''                                                             read_ptr_cnt_ov
''                                                             write_ptr_cnt_ov
''---------------------------------------------------------------------------------
'' undef_ptr_val                              [7:4]            get_undef_ptr_val
''                                                             set_undef_ptr_val
''                                                             read_undef_ptr_val
''                                                             write_undef_ptr_val
''---------------------------------------------------------------------------------
'' ctrlcode_ov                                [3:3]            get_ctrlcode_ov
''                                                             set_ctrlcode_ov
''                                                             read_ctrlcode_ov
''                                                             write_ctrlcode_ov
''---------------------------------------------------------------------------------
'' undef_ctrl_val                             [2:0]            get_undef_ctrl_val
''                                                             set_undef_ctrl_val
''                                                             read_undef_ctrl_val
''                                                             write_undef_ctrl_val
''---------------------------------------------------------------------------------
Class REGISTER_BR_GPCS_pcs_misc_ctl10
    Private write_spare_15_value
    Private read_spare_15_value
    Private flag_spare_15
    Private write_ptr_nflag_ov_value
    Private read_ptr_nflag_ov_value
    Private flag_ptr_nflag_ov
    Private write_ptr_nflag_val_value
    Private read_ptr_nflag_val_value
    Private flag_ptr_nflag_val
    Private write_byte_loc_val_value
    Private read_byte_loc_val_value
    Private flag_byte_loc_val
    Private write_ptr_cnt_ov_value
    Private read_ptr_cnt_ov_value
    Private flag_ptr_cnt_ov
    Private write_undef_ptr_val_value
    Private read_undef_ptr_val_value
    Private flag_undef_ptr_val
    Private write_ctrlcode_ov_value
    Private read_ctrlcode_ov_value
    Private flag_ctrlcode_ov
    Private write_undef_ctrl_val_value
    Private read_undef_ctrl_val_value
    Private flag_undef_ctrl_val

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H5a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_spare_15
        get_spare_15 = read_spare_15_value
    End Property

    Property Let set_spare_15(aData)
        write_spare_15_value = aData
        flag_spare_15        = &H1
    End Property

    Property Get read_spare_15
        read
        read_spare_15 = read_spare_15_value
    End Property

    Property Let write_spare_15(aData)
        set_spare_15 = aData
        write
    End Property

    Property Get get_ptr_nflag_ov
        get_ptr_nflag_ov = read_ptr_nflag_ov_value
    End Property

    Property Let set_ptr_nflag_ov(aData)
        write_ptr_nflag_ov_value = aData
        flag_ptr_nflag_ov        = &H1
    End Property

    Property Get read_ptr_nflag_ov
        read
        read_ptr_nflag_ov = read_ptr_nflag_ov_value
    End Property

    Property Let write_ptr_nflag_ov(aData)
        set_ptr_nflag_ov = aData
        write
    End Property

    Property Get get_ptr_nflag_val
        get_ptr_nflag_val = read_ptr_nflag_val_value
    End Property

    Property Let set_ptr_nflag_val(aData)
        write_ptr_nflag_val_value = aData
        flag_ptr_nflag_val        = &H1
    End Property

    Property Get read_ptr_nflag_val
        read
        read_ptr_nflag_val = read_ptr_nflag_val_value
    End Property

    Property Let write_ptr_nflag_val(aData)
        set_ptr_nflag_val = aData
        write
    End Property

    Property Get get_byte_loc_val
        get_byte_loc_val = read_byte_loc_val_value
    End Property

    Property Let set_byte_loc_val(aData)
        write_byte_loc_val_value = aData
        flag_byte_loc_val        = &H1
    End Property

    Property Get read_byte_loc_val
        read
        read_byte_loc_val = read_byte_loc_val_value
    End Property

    Property Let write_byte_loc_val(aData)
        set_byte_loc_val = aData
        write
    End Property

    Property Get get_ptr_cnt_ov
        get_ptr_cnt_ov = read_ptr_cnt_ov_value
    End Property

    Property Let set_ptr_cnt_ov(aData)
        write_ptr_cnt_ov_value = aData
        flag_ptr_cnt_ov        = &H1
    End Property

    Property Get read_ptr_cnt_ov
        read
        read_ptr_cnt_ov = read_ptr_cnt_ov_value
    End Property

    Property Let write_ptr_cnt_ov(aData)
        set_ptr_cnt_ov = aData
        write
    End Property

    Property Get get_undef_ptr_val
        get_undef_ptr_val = read_undef_ptr_val_value
    End Property

    Property Let set_undef_ptr_val(aData)
        write_undef_ptr_val_value = aData
        flag_undef_ptr_val        = &H1
    End Property

    Property Get read_undef_ptr_val
        read
        read_undef_ptr_val = read_undef_ptr_val_value
    End Property

    Property Let write_undef_ptr_val(aData)
        set_undef_ptr_val = aData
        write
    End Property

    Property Get get_ctrlcode_ov
        get_ctrlcode_ov = read_ctrlcode_ov_value
    End Property

    Property Let set_ctrlcode_ov(aData)
        write_ctrlcode_ov_value = aData
        flag_ctrlcode_ov        = &H1
    End Property

    Property Get read_ctrlcode_ov
        read
        read_ctrlcode_ov = read_ctrlcode_ov_value
    End Property

    Property Let write_ctrlcode_ov(aData)
        set_ctrlcode_ov = aData
        write
    End Property

    Property Get get_undef_ctrl_val
        get_undef_ctrl_val = read_undef_ctrl_val_value
    End Property

    Property Let set_undef_ctrl_val(aData)
        write_undef_ctrl_val_value = aData
        flag_undef_ctrl_val        = &H1
    End Property

    Property Get read_undef_ctrl_val
        read
        read_undef_ctrl_val = read_undef_ctrl_val_value
    End Property

    Property Let write_undef_ctrl_val(aData)
        set_undef_ctrl_val = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_spare_15_value = rightShift(data_low, 15) and &H1
        read_ptr_nflag_ov_value = rightShift(data_low, 14) and &H1
        read_ptr_nflag_val_value = rightShift(data_low, 13) and &H1
        read_byte_loc_val_value = rightShift(data_low, 9) and &Hf
        read_ptr_cnt_ov_value = rightShift(data_low, 8) and &H1
        read_undef_ptr_val_value = rightShift(data_low, 4) and &Hf
        read_ctrlcode_ov_value = rightShift(data_low, 3) and &H1
        undef_ctrl_val_mask = &H7
        if data_low > LONG_MAX then
            if undef_ctrl_val_mask = mask then
                read_undef_ctrl_val_value = data_low
            else
                read_undef_ctrl_val_value = (data_low - H8000_0000) and undef_ctrl_val_mask
            end If
        else
            read_undef_ctrl_val_value = data_low and undef_ctrl_val_mask
        end If

    End Sub

    Sub write
        If flag_spare_15 = &H0 or flag_ptr_nflag_ov = &H0 or flag_ptr_nflag_val = &H0 or flag_byte_loc_val = &H0 or flag_ptr_cnt_ov = &H0 or flag_undef_ptr_val = &H0 or flag_ctrlcode_ov = &H0 or flag_undef_ctrl_val = &H0 Then read
        If flag_spare_15 = &H0 Then write_spare_15_value = get_spare_15
        If flag_ptr_nflag_ov = &H0 Then write_ptr_nflag_ov_value = get_ptr_nflag_ov
        If flag_ptr_nflag_val = &H0 Then write_ptr_nflag_val_value = get_ptr_nflag_val
        If flag_byte_loc_val = &H0 Then write_byte_loc_val_value = get_byte_loc_val
        If flag_ptr_cnt_ov = &H0 Then write_ptr_cnt_ov_value = get_ptr_cnt_ov
        If flag_undef_ptr_val = &H0 Then write_undef_ptr_val_value = get_undef_ptr_val
        If flag_ctrlcode_ov = &H0 Then write_ctrlcode_ov_value = get_ctrlcode_ov
        If flag_undef_ctrl_val = &H0 Then write_undef_ctrl_val_value = get_undef_ctrl_val

        regValue = leftShift((write_spare_15_value and &H1), 15) + leftShift((write_ptr_nflag_ov_value and &H1), 14) + leftShift((write_ptr_nflag_val_value and &H1), 13) + leftShift((write_byte_loc_val_value and &Hf), 9) + leftShift((write_ptr_cnt_ov_value and &H1), 8) + leftShift((write_undef_ptr_val_value and &Hf), 4) + leftShift((write_ctrlcode_ov_value and &H1), 3) + leftShift((write_undef_ctrl_val_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_spare_15_value = rightShift(data_low, 15) and &H1
        read_ptr_nflag_ov_value = rightShift(data_low, 14) and &H1
        read_ptr_nflag_val_value = rightShift(data_low, 13) and &H1
        read_byte_loc_val_value = rightShift(data_low, 9) and &Hf
        read_ptr_cnt_ov_value = rightShift(data_low, 8) and &H1
        read_undef_ptr_val_value = rightShift(data_low, 4) and &Hf
        read_ctrlcode_ov_value = rightShift(data_low, 3) and &H1
        undef_ctrl_val_mask = &H7
        if data_low > LONG_MAX then
            if undef_ctrl_val_mask = mask then
                read_undef_ctrl_val_value = data_low
            else
                read_undef_ctrl_val_value = (data_low - H8000_0000) and undef_ctrl_val_mask
            end If
        else
            read_undef_ctrl_val_value = data_low and undef_ctrl_val_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_spare_15_value = &H0
        flag_spare_15        = &H0
        write_ptr_nflag_ov_value = &H0
        flag_ptr_nflag_ov        = &H0
        write_ptr_nflag_val_value = &H0
        flag_ptr_nflag_val        = &H0
        write_byte_loc_val_value = &H0
        flag_byte_loc_val        = &H0
        write_ptr_cnt_ov_value = &H0
        flag_ptr_cnt_ov        = &H0
        write_undef_ptr_val_value = &H0
        flag_undef_ptr_val        = &H0
        write_ctrlcode_ov_value = &H0
        flag_ctrlcode_ov        = &H0
        write_undef_ctrl_val_value = &H0
        flag_undef_ctrl_val        = &H0
    End Sub
End Class


'' @REGISTER : BR_GPCS_pcs_misc_ctl11
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' fec_err_inj_en                             [14:14]          get_fec_err_inj_en
''                                                             set_fec_err_inj_en
''                                                             read_fec_err_inj_en
''                                                             write_fec_err_inj_en
''---------------------------------------------------------------------------------
'' fec_err_frame                              [13:9]           get_fec_err_frame
''                                                             set_fec_err_frame
''                                                             read_fec_err_frame
''                                                             write_fec_err_frame
''---------------------------------------------------------------------------------
'' fec_err_ptr                                [8:0]            get_fec_err_ptr
''                                                             set_fec_err_ptr
''                                                             read_fec_err_ptr
''                                                             write_fec_err_ptr
''---------------------------------------------------------------------------------
Class REGISTER_BR_GPCS_pcs_misc_ctl11
    Private write_fec_err_inj_en_value
    Private read_fec_err_inj_en_value
    Private flag_fec_err_inj_en
    Private write_fec_err_frame_value
    Private read_fec_err_frame_value
    Private flag_fec_err_frame
    Private write_fec_err_ptr_value
    Private read_fec_err_ptr_value
    Private flag_fec_err_ptr

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H5c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_fec_err_inj_en
        get_fec_err_inj_en = read_fec_err_inj_en_value
    End Property

    Property Let set_fec_err_inj_en(aData)
        write_fec_err_inj_en_value = aData
        flag_fec_err_inj_en        = &H1
    End Property

    Property Get read_fec_err_inj_en
        read
        read_fec_err_inj_en = read_fec_err_inj_en_value
    End Property

    Property Let write_fec_err_inj_en(aData)
        set_fec_err_inj_en = aData
        write
    End Property

    Property Get get_fec_err_frame
        get_fec_err_frame = read_fec_err_frame_value
    End Property

    Property Let set_fec_err_frame(aData)
        write_fec_err_frame_value = aData
        flag_fec_err_frame        = &H1
    End Property

    Property Get read_fec_err_frame
        read
        read_fec_err_frame = read_fec_err_frame_value
    End Property

    Property Let write_fec_err_frame(aData)
        set_fec_err_frame = aData
        write
    End Property

    Property Get get_fec_err_ptr
        get_fec_err_ptr = read_fec_err_ptr_value
    End Property

    Property Let set_fec_err_ptr(aData)
        write_fec_err_ptr_value = aData
        flag_fec_err_ptr        = &H1
    End Property

    Property Get read_fec_err_ptr
        read
        read_fec_err_ptr = read_fec_err_ptr_value
    End Property

    Property Let write_fec_err_ptr(aData)
        set_fec_err_ptr = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_fec_err_inj_en_value = rightShift(data_low, 14) and &H1
        read_fec_err_frame_value = rightShift(data_low, 9) and &H1f
        fec_err_ptr_mask = &H1ff
        if data_low > LONG_MAX then
            if fec_err_ptr_mask = mask then
                read_fec_err_ptr_value = data_low
            else
                read_fec_err_ptr_value = (data_low - H8000_0000) and fec_err_ptr_mask
            end If
        else
            read_fec_err_ptr_value = data_low and fec_err_ptr_mask
        end If

    End Sub

    Sub write
        If flag_fec_err_inj_en = &H0 or flag_fec_err_frame = &H0 or flag_fec_err_ptr = &H0 Then read
        If flag_fec_err_inj_en = &H0 Then write_fec_err_inj_en_value = get_fec_err_inj_en
        If flag_fec_err_frame = &H0 Then write_fec_err_frame_value = get_fec_err_frame
        If flag_fec_err_ptr = &H0 Then write_fec_err_ptr_value = get_fec_err_ptr

        regValue = leftShift((write_fec_err_inj_en_value and &H1), 14) + leftShift((write_fec_err_frame_value and &H1f), 9) + leftShift((write_fec_err_ptr_value and &H1ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_fec_err_inj_en_value = rightShift(data_low, 14) and &H1
        read_fec_err_frame_value = rightShift(data_low, 9) and &H1f
        fec_err_ptr_mask = &H1ff
        if data_low > LONG_MAX then
            if fec_err_ptr_mask = mask then
                read_fec_err_ptr_value = data_low
            else
                read_fec_err_ptr_value = (data_low - H8000_0000) and fec_err_ptr_mask
            end If
        else
            read_fec_err_ptr_value = data_low and fec_err_ptr_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_fec_err_inj_en_value = &H0
        flag_fec_err_inj_en        = &H0
        write_fec_err_frame_value = &H0
        flag_fec_err_frame        = &H0
        write_fec_err_ptr_value = &H0
        flag_fec_err_ptr        = &H0
    End Sub
End Class


'' @REGISTER : BR_GPCS_pcs_misc_ctl12
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' tx_pam2_pol_inv                            [15:15]          get_tx_pam2_pol_inv
''                                                             set_tx_pam2_pol_inv
''                                                             read_tx_pam2_pol_inv
''                                                             write_tx_pam2_pol_inv
''---------------------------------------------------------------------------------
'' rx_pam2_pol_inv                            [14:14]          get_rx_pam2_pol_inv
''                                                             set_rx_pam2_pol_inv
''                                                             read_rx_pam2_pol_inv
''                                                             write_rx_pam2_pol_inv
''---------------------------------------------------------------------------------
'' tx_pcs_seed_swap                           [13:13]          get_tx_pcs_seed_swap
''                                                             set_tx_pcs_seed_swap
''                                                             read_tx_pcs_seed_swap
''                                                             write_tx_pcs_seed_swap
''---------------------------------------------------------------------------------
'' rx_pcs_seed_swap                           [12:12]          get_rx_pcs_seed_swap
''                                                             set_rx_pcs_seed_swap
''                                                             read_rx_pcs_seed_swap
''                                                             write_rx_pcs_seed_swap
''---------------------------------------------------------------------------------
'' tx_pam3_half_dly                           [11:11]          get_tx_pam3_half_dly
''                                                             set_tx_pam3_half_dly
''                                                             read_tx_pam3_half_dly
''                                                             write_tx_pam3_half_dly
''---------------------------------------------------------------------------------
'' rx_pam3_half_dly                           [10:10]          get_rx_pam3_half_dly
''                                                             set_rx_pam3_half_dly
''                                                             read_rx_pam3_half_dly
''                                                             write_rx_pam3_half_dly
''---------------------------------------------------------------------------------
'' fec_err_bit_typ                            [9:9]            get_fec_err_bit_typ
''                                                             set_fec_err_bit_typ
''                                                             read_fec_err_bit_typ
''                                                             write_fec_err_bit_typ
''---------------------------------------------------------------------------------
'' fec_err_bitmap                             [8:0]            get_fec_err_bitmap
''                                                             set_fec_err_bitmap
''                                                             read_fec_err_bitmap
''                                                             write_fec_err_bitmap
''---------------------------------------------------------------------------------
Class REGISTER_BR_GPCS_pcs_misc_ctl12
    Private write_tx_pam2_pol_inv_value
    Private read_tx_pam2_pol_inv_value
    Private flag_tx_pam2_pol_inv
    Private write_rx_pam2_pol_inv_value
    Private read_rx_pam2_pol_inv_value
    Private flag_rx_pam2_pol_inv
    Private write_tx_pcs_seed_swap_value
    Private read_tx_pcs_seed_swap_value
    Private flag_tx_pcs_seed_swap
    Private write_rx_pcs_seed_swap_value
    Private read_rx_pcs_seed_swap_value
    Private flag_rx_pcs_seed_swap
    Private write_tx_pam3_half_dly_value
    Private read_tx_pam3_half_dly_value
    Private flag_tx_pam3_half_dly
    Private write_rx_pam3_half_dly_value
    Private read_rx_pam3_half_dly_value
    Private flag_rx_pam3_half_dly
    Private write_fec_err_bit_typ_value
    Private read_fec_err_bit_typ_value
    Private flag_fec_err_bit_typ
    Private write_fec_err_bitmap_value
    Private read_fec_err_bitmap_value
    Private flag_fec_err_bitmap

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H5e
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_tx_pam2_pol_inv
        get_tx_pam2_pol_inv = read_tx_pam2_pol_inv_value
    End Property

    Property Let set_tx_pam2_pol_inv(aData)
        write_tx_pam2_pol_inv_value = aData
        flag_tx_pam2_pol_inv        = &H1
    End Property

    Property Get read_tx_pam2_pol_inv
        read
        read_tx_pam2_pol_inv = read_tx_pam2_pol_inv_value
    End Property

    Property Let write_tx_pam2_pol_inv(aData)
        set_tx_pam2_pol_inv = aData
        write
    End Property

    Property Get get_rx_pam2_pol_inv
        get_rx_pam2_pol_inv = read_rx_pam2_pol_inv_value
    End Property

    Property Let set_rx_pam2_pol_inv(aData)
        write_rx_pam2_pol_inv_value = aData
        flag_rx_pam2_pol_inv        = &H1
    End Property

    Property Get read_rx_pam2_pol_inv
        read
        read_rx_pam2_pol_inv = read_rx_pam2_pol_inv_value
    End Property

    Property Let write_rx_pam2_pol_inv(aData)
        set_rx_pam2_pol_inv = aData
        write
    End Property

    Property Get get_tx_pcs_seed_swap
        get_tx_pcs_seed_swap = read_tx_pcs_seed_swap_value
    End Property

    Property Let set_tx_pcs_seed_swap(aData)
        write_tx_pcs_seed_swap_value = aData
        flag_tx_pcs_seed_swap        = &H1
    End Property

    Property Get read_tx_pcs_seed_swap
        read
        read_tx_pcs_seed_swap = read_tx_pcs_seed_swap_value
    End Property

    Property Let write_tx_pcs_seed_swap(aData)
        set_tx_pcs_seed_swap = aData
        write
    End Property

    Property Get get_rx_pcs_seed_swap
        get_rx_pcs_seed_swap = read_rx_pcs_seed_swap_value
    End Property

    Property Let set_rx_pcs_seed_swap(aData)
        write_rx_pcs_seed_swap_value = aData
        flag_rx_pcs_seed_swap        = &H1
    End Property

    Property Get read_rx_pcs_seed_swap
        read
        read_rx_pcs_seed_swap = read_rx_pcs_seed_swap_value
    End Property

    Property Let write_rx_pcs_seed_swap(aData)
        set_rx_pcs_seed_swap = aData
        write
    End Property

    Property Get get_tx_pam3_half_dly
        get_tx_pam3_half_dly = read_tx_pam3_half_dly_value
    End Property

    Property Let set_tx_pam3_half_dly(aData)
        write_tx_pam3_half_dly_value = aData
        flag_tx_pam3_half_dly        = &H1
    End Property

    Property Get read_tx_pam3_half_dly
        read
        read_tx_pam3_half_dly = read_tx_pam3_half_dly_value
    End Property

    Property Let write_tx_pam3_half_dly(aData)
        set_tx_pam3_half_dly = aData
        write
    End Property

    Property Get get_rx_pam3_half_dly
        get_rx_pam3_half_dly = read_rx_pam3_half_dly_value
    End Property

    Property Let set_rx_pam3_half_dly(aData)
        write_rx_pam3_half_dly_value = aData
        flag_rx_pam3_half_dly        = &H1
    End Property

    Property Get read_rx_pam3_half_dly
        read
        read_rx_pam3_half_dly = read_rx_pam3_half_dly_value
    End Property

    Property Let write_rx_pam3_half_dly(aData)
        set_rx_pam3_half_dly = aData
        write
    End Property

    Property Get get_fec_err_bit_typ
        get_fec_err_bit_typ = read_fec_err_bit_typ_value
    End Property

    Property Let set_fec_err_bit_typ(aData)
        write_fec_err_bit_typ_value = aData
        flag_fec_err_bit_typ        = &H1
    End Property

    Property Get read_fec_err_bit_typ
        read
        read_fec_err_bit_typ = read_fec_err_bit_typ_value
    End Property

    Property Let write_fec_err_bit_typ(aData)
        set_fec_err_bit_typ = aData
        write
    End Property

    Property Get get_fec_err_bitmap
        get_fec_err_bitmap = read_fec_err_bitmap_value
    End Property

    Property Let set_fec_err_bitmap(aData)
        write_fec_err_bitmap_value = aData
        flag_fec_err_bitmap        = &H1
    End Property

    Property Get read_fec_err_bitmap
        read
        read_fec_err_bitmap = read_fec_err_bitmap_value
    End Property

    Property Let write_fec_err_bitmap(aData)
        set_fec_err_bitmap = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_tx_pam2_pol_inv_value = rightShift(data_low, 15) and &H1
        read_rx_pam2_pol_inv_value = rightShift(data_low, 14) and &H1
        read_tx_pcs_seed_swap_value = rightShift(data_low, 13) and &H1
        read_rx_pcs_seed_swap_value = rightShift(data_low, 12) and &H1
        read_tx_pam3_half_dly_value = rightShift(data_low, 11) and &H1
        read_rx_pam3_half_dly_value = rightShift(data_low, 10) and &H1
        read_fec_err_bit_typ_value = rightShift(data_low, 9) and &H1
        fec_err_bitmap_mask = &H1ff
        if data_low > LONG_MAX then
            if fec_err_bitmap_mask = mask then
                read_fec_err_bitmap_value = data_low
            else
                read_fec_err_bitmap_value = (data_low - H8000_0000) and fec_err_bitmap_mask
            end If
        else
            read_fec_err_bitmap_value = data_low and fec_err_bitmap_mask
        end If

    End Sub

    Sub write
        If flag_tx_pam2_pol_inv = &H0 or flag_rx_pam2_pol_inv = &H0 or flag_tx_pcs_seed_swap = &H0 or flag_rx_pcs_seed_swap = &H0 or flag_tx_pam3_half_dly = &H0 or flag_rx_pam3_half_dly = &H0 or flag_fec_err_bit_typ = &H0 or flag_fec_err_bitmap = &H0 Then read
        If flag_tx_pam2_pol_inv = &H0 Then write_tx_pam2_pol_inv_value = get_tx_pam2_pol_inv
        If flag_rx_pam2_pol_inv = &H0 Then write_rx_pam2_pol_inv_value = get_rx_pam2_pol_inv
        If flag_tx_pcs_seed_swap = &H0 Then write_tx_pcs_seed_swap_value = get_tx_pcs_seed_swap
        If flag_rx_pcs_seed_swap = &H0 Then write_rx_pcs_seed_swap_value = get_rx_pcs_seed_swap
        If flag_tx_pam3_half_dly = &H0 Then write_tx_pam3_half_dly_value = get_tx_pam3_half_dly
        If flag_rx_pam3_half_dly = &H0 Then write_rx_pam3_half_dly_value = get_rx_pam3_half_dly
        If flag_fec_err_bit_typ = &H0 Then write_fec_err_bit_typ_value = get_fec_err_bit_typ
        If flag_fec_err_bitmap = &H0 Then write_fec_err_bitmap_value = get_fec_err_bitmap

        regValue = leftShift((write_tx_pam2_pol_inv_value and &H1), 15) + leftShift((write_rx_pam2_pol_inv_value and &H1), 14) + leftShift((write_tx_pcs_seed_swap_value and &H1), 13) + leftShift((write_rx_pcs_seed_swap_value and &H1), 12) + leftShift((write_tx_pam3_half_dly_value and &H1), 11) + leftShift((write_rx_pam3_half_dly_value and &H1), 10) + leftShift((write_fec_err_bit_typ_value and &H1), 9) + leftShift((write_fec_err_bitmap_value and &H1ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_tx_pam2_pol_inv_value = rightShift(data_low, 15) and &H1
        read_rx_pam2_pol_inv_value = rightShift(data_low, 14) and &H1
        read_tx_pcs_seed_swap_value = rightShift(data_low, 13) and &H1
        read_rx_pcs_seed_swap_value = rightShift(data_low, 12) and &H1
        read_tx_pam3_half_dly_value = rightShift(data_low, 11) and &H1
        read_rx_pam3_half_dly_value = rightShift(data_low, 10) and &H1
        read_fec_err_bit_typ_value = rightShift(data_low, 9) and &H1
        fec_err_bitmap_mask = &H1ff
        if data_low > LONG_MAX then
            if fec_err_bitmap_mask = mask then
                read_fec_err_bitmap_value = data_low
            else
                read_fec_err_bitmap_value = (data_low - H8000_0000) and fec_err_bitmap_mask
            end If
        else
            read_fec_err_bitmap_value = data_low and fec_err_bitmap_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_tx_pam2_pol_inv_value = &H0
        flag_tx_pam2_pol_inv        = &H0
        write_rx_pam2_pol_inv_value = &H0
        flag_rx_pam2_pol_inv        = &H0
        write_tx_pcs_seed_swap_value = &H0
        flag_tx_pcs_seed_swap        = &H0
        write_rx_pcs_seed_swap_value = &H0
        flag_rx_pcs_seed_swap        = &H0
        write_tx_pam3_half_dly_value = &H0
        flag_tx_pam3_half_dly        = &H0
        write_rx_pam3_half_dly_value = &H0
        flag_rx_pam3_half_dly        = &H0
        write_fec_err_bit_typ_value = &H0
        flag_fec_err_bit_typ        = &H0
        write_fec_err_bitmap_value = &H0
        flag_fec_err_bitmap        = &H0
    End Sub
End Class


'' @REGISTER : BR_GPCS_pcs_misc_ctl13
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' tx_state_test1                             [15:15]          get_tx_state_test1
''                                                             set_tx_state_test1
''                                                             read_tx_state_test1
''                                                             write_tx_state_test1
''---------------------------------------------------------------------------------
'' tx_state_test2                             [14:14]          get_tx_state_test2
''                                                             set_tx_state_test2
''                                                             read_tx_state_test2
''                                                             write_tx_state_test2
''---------------------------------------------------------------------------------
'' pcs_scr_opsel                              [12:12]          get_pcs_scr_opsel
''                                                             set_pcs_scr_opsel
''                                                             read_pcs_scr_opsel
''                                                             write_pcs_scr_opsel
''---------------------------------------------------------------------------------
'' tx_pam3_pol_inv                            [11:11]          get_tx_pam3_pol_inv
''                                                             set_tx_pam3_pol_inv
''                                                             read_tx_pam3_pol_inv
''                                                             write_tx_pam3_pol_inv
''---------------------------------------------------------------------------------
'' rx_pam3_pol_inv                            [10:10]          get_rx_pam3_pol_inv
''                                                             set_rx_pam3_pol_inv
''                                                             read_rx_pam3_pol_inv
''                                                             write_rx_pam3_pol_inv
''---------------------------------------------------------------------------------
'' fec_err_sym_typ                            [9:9]            get_fec_err_sym_typ
''                                                             set_fec_err_sym_typ
''                                                             read_fec_err_sym_typ
''                                                             write_fec_err_sym_typ
''---------------------------------------------------------------------------------
'' fec_err_symnum                             [8:0]            get_fec_err_symnum
''                                                             set_fec_err_symnum
''                                                             read_fec_err_symnum
''                                                             write_fec_err_symnum
''---------------------------------------------------------------------------------
Class REGISTER_BR_GPCS_pcs_misc_ctl13
    Private write_tx_state_test1_value
    Private read_tx_state_test1_value
    Private flag_tx_state_test1
    Private write_tx_state_test2_value
    Private read_tx_state_test2_value
    Private flag_tx_state_test2
    Private write_pcs_scr_opsel_value
    Private read_pcs_scr_opsel_value
    Private flag_pcs_scr_opsel
    Private write_tx_pam3_pol_inv_value
    Private read_tx_pam3_pol_inv_value
    Private flag_tx_pam3_pol_inv
    Private write_rx_pam3_pol_inv_value
    Private read_rx_pam3_pol_inv_value
    Private flag_rx_pam3_pol_inv
    Private write_fec_err_sym_typ_value
    Private read_fec_err_sym_typ_value
    Private flag_fec_err_sym_typ
    Private write_fec_err_symnum_value
    Private read_fec_err_symnum_value
    Private flag_fec_err_symnum

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H60
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_tx_state_test1
        get_tx_state_test1 = read_tx_state_test1_value
    End Property

    Property Let set_tx_state_test1(aData)
        write_tx_state_test1_value = aData
        flag_tx_state_test1        = &H1
    End Property

    Property Get read_tx_state_test1
        read
        read_tx_state_test1 = read_tx_state_test1_value
    End Property

    Property Let write_tx_state_test1(aData)
        set_tx_state_test1 = aData
        write
    End Property

    Property Get get_tx_state_test2
        get_tx_state_test2 = read_tx_state_test2_value
    End Property

    Property Let set_tx_state_test2(aData)
        write_tx_state_test2_value = aData
        flag_tx_state_test2        = &H1
    End Property

    Property Get read_tx_state_test2
        read
        read_tx_state_test2 = read_tx_state_test2_value
    End Property

    Property Let write_tx_state_test2(aData)
        set_tx_state_test2 = aData
        write
    End Property

    Property Get get_pcs_scr_opsel
        get_pcs_scr_opsel = read_pcs_scr_opsel_value
    End Property

    Property Let set_pcs_scr_opsel(aData)
        write_pcs_scr_opsel_value = aData
        flag_pcs_scr_opsel        = &H1
    End Property

    Property Get read_pcs_scr_opsel
        read
        read_pcs_scr_opsel = read_pcs_scr_opsel_value
    End Property

    Property Let write_pcs_scr_opsel(aData)
        set_pcs_scr_opsel = aData
        write
    End Property

    Property Get get_tx_pam3_pol_inv
        get_tx_pam3_pol_inv = read_tx_pam3_pol_inv_value
    End Property

    Property Let set_tx_pam3_pol_inv(aData)
        write_tx_pam3_pol_inv_value = aData
        flag_tx_pam3_pol_inv        = &H1
    End Property

    Property Get read_tx_pam3_pol_inv
        read
        read_tx_pam3_pol_inv = read_tx_pam3_pol_inv_value
    End Property

    Property Let write_tx_pam3_pol_inv(aData)
        set_tx_pam3_pol_inv = aData
        write
    End Property

    Property Get get_rx_pam3_pol_inv
        get_rx_pam3_pol_inv = read_rx_pam3_pol_inv_value
    End Property

    Property Let set_rx_pam3_pol_inv(aData)
        write_rx_pam3_pol_inv_value = aData
        flag_rx_pam3_pol_inv        = &H1
    End Property

    Property Get read_rx_pam3_pol_inv
        read
        read_rx_pam3_pol_inv = read_rx_pam3_pol_inv_value
    End Property

    Property Let write_rx_pam3_pol_inv(aData)
        set_rx_pam3_pol_inv = aData
        write
    End Property

    Property Get get_fec_err_sym_typ
        get_fec_err_sym_typ = read_fec_err_sym_typ_value
    End Property

    Property Let set_fec_err_sym_typ(aData)
        write_fec_err_sym_typ_value = aData
        flag_fec_err_sym_typ        = &H1
    End Property

    Property Get read_fec_err_sym_typ
        read
        read_fec_err_sym_typ = read_fec_err_sym_typ_value
    End Property

    Property Let write_fec_err_sym_typ(aData)
        set_fec_err_sym_typ = aData
        write
    End Property

    Property Get get_fec_err_symnum
        get_fec_err_symnum = read_fec_err_symnum_value
    End Property

    Property Let set_fec_err_symnum(aData)
        write_fec_err_symnum_value = aData
        flag_fec_err_symnum        = &H1
    End Property

    Property Get read_fec_err_symnum
        read
        read_fec_err_symnum = read_fec_err_symnum_value
    End Property

    Property Let write_fec_err_symnum(aData)
        set_fec_err_symnum = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_tx_state_test1_value = rightShift(data_low, 15) and &H1
        read_tx_state_test2_value = rightShift(data_low, 14) and &H1
        read_pcs_scr_opsel_value = rightShift(data_low, 12) and &H1
        read_tx_pam3_pol_inv_value = rightShift(data_low, 11) and &H1
        read_rx_pam3_pol_inv_value = rightShift(data_low, 10) and &H1
        read_fec_err_sym_typ_value = rightShift(data_low, 9) and &H1
        fec_err_symnum_mask = &H1ff
        if data_low > LONG_MAX then
            if fec_err_symnum_mask = mask then
                read_fec_err_symnum_value = data_low
            else
                read_fec_err_symnum_value = (data_low - H8000_0000) and fec_err_symnum_mask
            end If
        else
            read_fec_err_symnum_value = data_low and fec_err_symnum_mask
        end If

    End Sub

    Sub write
        If flag_tx_state_test1 = &H0 or flag_tx_state_test2 = &H0 or flag_pcs_scr_opsel = &H0 or flag_tx_pam3_pol_inv = &H0 or flag_rx_pam3_pol_inv = &H0 or flag_fec_err_sym_typ = &H0 or flag_fec_err_symnum = &H0 Then read
        If flag_tx_state_test1 = &H0 Then write_tx_state_test1_value = get_tx_state_test1
        If flag_tx_state_test2 = &H0 Then write_tx_state_test2_value = get_tx_state_test2
        If flag_pcs_scr_opsel = &H0 Then write_pcs_scr_opsel_value = get_pcs_scr_opsel
        If flag_tx_pam3_pol_inv = &H0 Then write_tx_pam3_pol_inv_value = get_tx_pam3_pol_inv
        If flag_rx_pam3_pol_inv = &H0 Then write_rx_pam3_pol_inv_value = get_rx_pam3_pol_inv
        If flag_fec_err_sym_typ = &H0 Then write_fec_err_sym_typ_value = get_fec_err_sym_typ
        If flag_fec_err_symnum = &H0 Then write_fec_err_symnum_value = get_fec_err_symnum

        regValue = leftShift((write_tx_state_test1_value and &H1), 15) + leftShift((write_tx_state_test2_value and &H1), 14) + leftShift((write_pcs_scr_opsel_value and &H1), 12) + leftShift((write_tx_pam3_pol_inv_value and &H1), 11) + leftShift((write_rx_pam3_pol_inv_value and &H1), 10) + leftShift((write_fec_err_sym_typ_value and &H1), 9) + leftShift((write_fec_err_symnum_value and &H1ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_tx_state_test1_value = rightShift(data_low, 15) and &H1
        read_tx_state_test2_value = rightShift(data_low, 14) and &H1
        read_pcs_scr_opsel_value = rightShift(data_low, 12) and &H1
        read_tx_pam3_pol_inv_value = rightShift(data_low, 11) and &H1
        read_rx_pam3_pol_inv_value = rightShift(data_low, 10) and &H1
        read_fec_err_sym_typ_value = rightShift(data_low, 9) and &H1
        fec_err_symnum_mask = &H1ff
        if data_low > LONG_MAX then
            if fec_err_symnum_mask = mask then
                read_fec_err_symnum_value = data_low
            else
                read_fec_err_symnum_value = (data_low - H8000_0000) and fec_err_symnum_mask
            end If
        else
            read_fec_err_symnum_value = data_low and fec_err_symnum_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_tx_state_test1_value = &H0
        flag_tx_state_test1        = &H0
        write_tx_state_test2_value = &H0
        flag_tx_state_test2        = &H0
        write_pcs_scr_opsel_value = &H0
        flag_pcs_scr_opsel        = &H0
        write_tx_pam3_pol_inv_value = &H0
        flag_tx_pam3_pol_inv        = &H0
        write_rx_pam3_pol_inv_value = &H0
        flag_rx_pam3_pol_inv        = &H0
        write_fec_err_sym_typ_value = &H0
        flag_fec_err_sym_typ        = &H0
        write_fec_err_symnum_value = &H0
        flag_fec_err_symnum        = &H0
    End Sub
End Class


'' @REGISTER : BR_GPCS_pcs_misc_ctl14
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' spare_15_2                                 [15:2]           get_spare_15_2
''                                                             set_spare_15_2
''                                                             read_spare_15_2
''                                                             write_spare_15_2
''---------------------------------------------------------------------------------
'' spare_1                                    [1:1]            get_spare_1
''                                                             set_spare_1
''                                                             read_spare_1
''                                                             write_spare_1
''---------------------------------------------------------------------------------
'' fake_txer_ov                               [0:0]            get_fake_txer_ov
''                                                             set_fake_txer_ov
''                                                             read_fake_txer_ov
''                                                             write_fake_txer_ov
''---------------------------------------------------------------------------------
Class REGISTER_BR_GPCS_pcs_misc_ctl14
    Private write_spare_15_2_value
    Private read_spare_15_2_value
    Private flag_spare_15_2
    Private write_spare_1_value
    Private read_spare_1_value
    Private flag_spare_1
    Private write_fake_txer_ov_value
    Private read_fake_txer_ov_value
    Private flag_fake_txer_ov

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H62
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_spare_15_2
        get_spare_15_2 = read_spare_15_2_value
    End Property

    Property Let set_spare_15_2(aData)
        write_spare_15_2_value = aData
        flag_spare_15_2        = &H1
    End Property

    Property Get read_spare_15_2
        read
        read_spare_15_2 = read_spare_15_2_value
    End Property

    Property Let write_spare_15_2(aData)
        set_spare_15_2 = aData
        write
    End Property

    Property Get get_spare_1
        get_spare_1 = read_spare_1_value
    End Property

    Property Let set_spare_1(aData)
        write_spare_1_value = aData
        flag_spare_1        = &H1
    End Property

    Property Get read_spare_1
        read
        read_spare_1 = read_spare_1_value
    End Property

    Property Let write_spare_1(aData)
        set_spare_1 = aData
        write
    End Property

    Property Get get_fake_txer_ov
        get_fake_txer_ov = read_fake_txer_ov_value
    End Property

    Property Let set_fake_txer_ov(aData)
        write_fake_txer_ov_value = aData
        flag_fake_txer_ov        = &H1
    End Property

    Property Get read_fake_txer_ov
        read
        read_fake_txer_ov = read_fake_txer_ov_value
    End Property

    Property Let write_fake_txer_ov(aData)
        set_fake_txer_ov = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_spare_15_2_value = rightShift(data_low, 2) and &H3fff
        read_spare_1_value = rightShift(data_low, 1) and &H1
        fake_txer_ov_mask = &H1
        if data_low > LONG_MAX then
            if fake_txer_ov_mask = mask then
                read_fake_txer_ov_value = data_low
            else
                read_fake_txer_ov_value = (data_low - H8000_0000) and fake_txer_ov_mask
            end If
        else
            read_fake_txer_ov_value = data_low and fake_txer_ov_mask
        end If

    End Sub

    Sub write
        If flag_spare_15_2 = &H0 or flag_spare_1 = &H0 or flag_fake_txer_ov = &H0 Then read
        If flag_spare_15_2 = &H0 Then write_spare_15_2_value = get_spare_15_2
        If flag_spare_1 = &H0 Then write_spare_1_value = get_spare_1
        If flag_fake_txer_ov = &H0 Then write_fake_txer_ov_value = get_fake_txer_ov

        regValue = leftShift((write_spare_15_2_value and &H3fff), 2) + leftShift((write_spare_1_value and &H1), 1) + leftShift((write_fake_txer_ov_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_spare_15_2_value = rightShift(data_low, 2) and &H3fff
        read_spare_1_value = rightShift(data_low, 1) and &H1
        fake_txer_ov_mask = &H1
        if data_low > LONG_MAX then
            if fake_txer_ov_mask = mask then
                read_fake_txer_ov_value = data_low
            else
                read_fake_txer_ov_value = (data_low - H8000_0000) and fake_txer_ov_mask
            end If
        else
            read_fake_txer_ov_value = data_low and fake_txer_ov_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_spare_15_2_value = &H0
        flag_spare_15_2        = &H0
        write_spare_1_value = &H0
        flag_spare_1        = &H0
        write_fake_txer_ov_value = &H0
        flag_fake_txer_ov        = &H0
    End Sub
End Class


'' @REGISTER : BR_GPCS_rxprobe0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rx_debug_0                                 [15:0]           get_rx_debug_0
''                                                             set_rx_debug_0
''                                                             read_rx_debug_0
''                                                             write_rx_debug_0
''---------------------------------------------------------------------------------
Class REGISTER_BR_GPCS_rxprobe0
    Private write_rx_debug_0_value
    Private read_rx_debug_0_value
    Private flag_rx_debug_0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Ha0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_rx_debug_0
        get_rx_debug_0 = read_rx_debug_0_value
    End Property

    Property Let set_rx_debug_0(aData)
        write_rx_debug_0_value = aData
        flag_rx_debug_0        = &H1
    End Property

    Property Get read_rx_debug_0
        read
        read_rx_debug_0 = read_rx_debug_0_value
    End Property

    Property Let write_rx_debug_0(aData)
        set_rx_debug_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rx_debug_0_mask = &Hffff
        if data_low > LONG_MAX then
            if rx_debug_0_mask = mask then
                read_rx_debug_0_value = data_low
            else
                read_rx_debug_0_value = (data_low - H8000_0000) and rx_debug_0_mask
            end If
        else
            read_rx_debug_0_value = data_low and rx_debug_0_mask
        end If

    End Sub

    Sub write
        If flag_rx_debug_0 = &H0 Then read
        If flag_rx_debug_0 = &H0 Then write_rx_debug_0_value = get_rx_debug_0

        regValue = leftShift((write_rx_debug_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rx_debug_0_mask = &Hffff
        if data_low > LONG_MAX then
            if rx_debug_0_mask = mask then
                read_rx_debug_0_value = data_low
            else
                read_rx_debug_0_value = (data_low - H8000_0000) and rx_debug_0_mask
            end If
        else
            read_rx_debug_0_value = data_low and rx_debug_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rx_debug_0_value = &H0
        flag_rx_debug_0        = &H0
    End Sub
End Class


'' @REGISTER : BR_GPCS_rxprobe1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rx_debug_1                                 [15:0]           get_rx_debug_1
''                                                             set_rx_debug_1
''                                                             read_rx_debug_1
''                                                             write_rx_debug_1
''---------------------------------------------------------------------------------
Class REGISTER_BR_GPCS_rxprobe1
    Private write_rx_debug_1_value
    Private read_rx_debug_1_value
    Private flag_rx_debug_1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Ha2
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_rx_debug_1
        get_rx_debug_1 = read_rx_debug_1_value
    End Property

    Property Let set_rx_debug_1(aData)
        write_rx_debug_1_value = aData
        flag_rx_debug_1        = &H1
    End Property

    Property Get read_rx_debug_1
        read
        read_rx_debug_1 = read_rx_debug_1_value
    End Property

    Property Let write_rx_debug_1(aData)
        set_rx_debug_1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rx_debug_1_mask = &Hffff
        if data_low > LONG_MAX then
            if rx_debug_1_mask = mask then
                read_rx_debug_1_value = data_low
            else
                read_rx_debug_1_value = (data_low - H8000_0000) and rx_debug_1_mask
            end If
        else
            read_rx_debug_1_value = data_low and rx_debug_1_mask
        end If

    End Sub

    Sub write
        If flag_rx_debug_1 = &H0 Then read
        If flag_rx_debug_1 = &H0 Then write_rx_debug_1_value = get_rx_debug_1

        regValue = leftShift((write_rx_debug_1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rx_debug_1_mask = &Hffff
        if data_low > LONG_MAX then
            if rx_debug_1_mask = mask then
                read_rx_debug_1_value = data_low
            else
                read_rx_debug_1_value = (data_low - H8000_0000) and rx_debug_1_mask
            end If
        else
            read_rx_debug_1_value = data_low and rx_debug_1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rx_debug_1_value = &H0
        flag_rx_debug_1        = &H0
    End Sub
End Class


'' @REGISTER : BR_GPCS_rxprobe2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rx_debug_2                                 [15:0]           get_rx_debug_2
''                                                             set_rx_debug_2
''                                                             read_rx_debug_2
''                                                             write_rx_debug_2
''---------------------------------------------------------------------------------
Class REGISTER_BR_GPCS_rxprobe2
    Private write_rx_debug_2_value
    Private read_rx_debug_2_value
    Private flag_rx_debug_2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Ha4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_rx_debug_2
        get_rx_debug_2 = read_rx_debug_2_value
    End Property

    Property Let set_rx_debug_2(aData)
        write_rx_debug_2_value = aData
        flag_rx_debug_2        = &H1
    End Property

    Property Get read_rx_debug_2
        read
        read_rx_debug_2 = read_rx_debug_2_value
    End Property

    Property Let write_rx_debug_2(aData)
        set_rx_debug_2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rx_debug_2_mask = &Hffff
        if data_low > LONG_MAX then
            if rx_debug_2_mask = mask then
                read_rx_debug_2_value = data_low
            else
                read_rx_debug_2_value = (data_low - H8000_0000) and rx_debug_2_mask
            end If
        else
            read_rx_debug_2_value = data_low and rx_debug_2_mask
        end If

    End Sub

    Sub write
        If flag_rx_debug_2 = &H0 Then read
        If flag_rx_debug_2 = &H0 Then write_rx_debug_2_value = get_rx_debug_2

        regValue = leftShift((write_rx_debug_2_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rx_debug_2_mask = &Hffff
        if data_low > LONG_MAX then
            if rx_debug_2_mask = mask then
                read_rx_debug_2_value = data_low
            else
                read_rx_debug_2_value = (data_low - H8000_0000) and rx_debug_2_mask
            end If
        else
            read_rx_debug_2_value = data_low and rx_debug_2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rx_debug_2_value = &H0
        flag_rx_debug_2        = &H0
    End Sub
End Class


'' @REGISTER : BR_GPCS_rxprobe3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rx_debug_3                                 [15:0]           get_rx_debug_3
''                                                             set_rx_debug_3
''                                                             read_rx_debug_3
''                                                             write_rx_debug_3
''---------------------------------------------------------------------------------
Class REGISTER_BR_GPCS_rxprobe3
    Private write_rx_debug_3_value
    Private read_rx_debug_3_value
    Private flag_rx_debug_3

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Ha6
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_rx_debug_3
        get_rx_debug_3 = read_rx_debug_3_value
    End Property

    Property Let set_rx_debug_3(aData)
        write_rx_debug_3_value = aData
        flag_rx_debug_3        = &H1
    End Property

    Property Get read_rx_debug_3
        read
        read_rx_debug_3 = read_rx_debug_3_value
    End Property

    Property Let write_rx_debug_3(aData)
        set_rx_debug_3 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rx_debug_3_mask = &Hffff
        if data_low > LONG_MAX then
            if rx_debug_3_mask = mask then
                read_rx_debug_3_value = data_low
            else
                read_rx_debug_3_value = (data_low - H8000_0000) and rx_debug_3_mask
            end If
        else
            read_rx_debug_3_value = data_low and rx_debug_3_mask
        end If

    End Sub

    Sub write
        If flag_rx_debug_3 = &H0 Then read
        If flag_rx_debug_3 = &H0 Then write_rx_debug_3_value = get_rx_debug_3

        regValue = leftShift((write_rx_debug_3_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rx_debug_3_mask = &Hffff
        if data_low > LONG_MAX then
            if rx_debug_3_mask = mask then
                read_rx_debug_3_value = data_low
            else
                read_rx_debug_3_value = (data_low - H8000_0000) and rx_debug_3_mask
            end If
        else
            read_rx_debug_3_value = data_low and rx_debug_3_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rx_debug_3_value = &H0
        flag_rx_debug_3        = &H0
    End Sub
End Class


'' @REGISTER : BR_GPCS_rxprobe4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rx_debug_4                                 [15:0]           get_rx_debug_4
''                                                             set_rx_debug_4
''                                                             read_rx_debug_4
''                                                             write_rx_debug_4
''---------------------------------------------------------------------------------
Class REGISTER_BR_GPCS_rxprobe4
    Private write_rx_debug_4_value
    Private read_rx_debug_4_value
    Private flag_rx_debug_4

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Ha8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_rx_debug_4
        get_rx_debug_4 = read_rx_debug_4_value
    End Property

    Property Let set_rx_debug_4(aData)
        write_rx_debug_4_value = aData
        flag_rx_debug_4        = &H1
    End Property

    Property Get read_rx_debug_4
        read
        read_rx_debug_4 = read_rx_debug_4_value
    End Property

    Property Let write_rx_debug_4(aData)
        set_rx_debug_4 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rx_debug_4_mask = &Hffff
        if data_low > LONG_MAX then
            if rx_debug_4_mask = mask then
                read_rx_debug_4_value = data_low
            else
                read_rx_debug_4_value = (data_low - H8000_0000) and rx_debug_4_mask
            end If
        else
            read_rx_debug_4_value = data_low and rx_debug_4_mask
        end If

    End Sub

    Sub write
        If flag_rx_debug_4 = &H0 Then read
        If flag_rx_debug_4 = &H0 Then write_rx_debug_4_value = get_rx_debug_4

        regValue = leftShift((write_rx_debug_4_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rx_debug_4_mask = &Hffff
        if data_low > LONG_MAX then
            if rx_debug_4_mask = mask then
                read_rx_debug_4_value = data_low
            else
                read_rx_debug_4_value = (data_low - H8000_0000) and rx_debug_4_mask
            end If
        else
            read_rx_debug_4_value = data_low and rx_debug_4_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rx_debug_4_value = &H0
        flag_rx_debug_4        = &H0
    End Sub
End Class


'' @REGISTER : BR_GPCS_rxprobe5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rx_debug_5                                 [15:0]           get_rx_debug_5
''                                                             set_rx_debug_5
''                                                             read_rx_debug_5
''                                                             write_rx_debug_5
''---------------------------------------------------------------------------------
Class REGISTER_BR_GPCS_rxprobe5
    Private write_rx_debug_5_value
    Private read_rx_debug_5_value
    Private flag_rx_debug_5

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Haa
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_rx_debug_5
        get_rx_debug_5 = read_rx_debug_5_value
    End Property

    Property Let set_rx_debug_5(aData)
        write_rx_debug_5_value = aData
        flag_rx_debug_5        = &H1
    End Property

    Property Get read_rx_debug_5
        read
        read_rx_debug_5 = read_rx_debug_5_value
    End Property

    Property Let write_rx_debug_5(aData)
        set_rx_debug_5 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rx_debug_5_mask = &Hffff
        if data_low > LONG_MAX then
            if rx_debug_5_mask = mask then
                read_rx_debug_5_value = data_low
            else
                read_rx_debug_5_value = (data_low - H8000_0000) and rx_debug_5_mask
            end If
        else
            read_rx_debug_5_value = data_low and rx_debug_5_mask
        end If

    End Sub

    Sub write
        If flag_rx_debug_5 = &H0 Then read
        If flag_rx_debug_5 = &H0 Then write_rx_debug_5_value = get_rx_debug_5

        regValue = leftShift((write_rx_debug_5_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rx_debug_5_mask = &Hffff
        if data_low > LONG_MAX then
            if rx_debug_5_mask = mask then
                read_rx_debug_5_value = data_low
            else
                read_rx_debug_5_value = (data_low - H8000_0000) and rx_debug_5_mask
            end If
        else
            read_rx_debug_5_value = data_low and rx_debug_5_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rx_debug_5_value = &H0
        flag_rx_debug_5        = &H0
    End Sub
End Class


'' @REGISTER : BR_GPCS_rxprobe6
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rx_debug_6                                 [15:0]           get_rx_debug_6
''                                                             set_rx_debug_6
''                                                             read_rx_debug_6
''                                                             write_rx_debug_6
''---------------------------------------------------------------------------------
Class REGISTER_BR_GPCS_rxprobe6
    Private write_rx_debug_6_value
    Private read_rx_debug_6_value
    Private flag_rx_debug_6

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hac
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_rx_debug_6
        get_rx_debug_6 = read_rx_debug_6_value
    End Property

    Property Let set_rx_debug_6(aData)
        write_rx_debug_6_value = aData
        flag_rx_debug_6        = &H1
    End Property

    Property Get read_rx_debug_6
        read
        read_rx_debug_6 = read_rx_debug_6_value
    End Property

    Property Let write_rx_debug_6(aData)
        set_rx_debug_6 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rx_debug_6_mask = &Hffff
        if data_low > LONG_MAX then
            if rx_debug_6_mask = mask then
                read_rx_debug_6_value = data_low
            else
                read_rx_debug_6_value = (data_low - H8000_0000) and rx_debug_6_mask
            end If
        else
            read_rx_debug_6_value = data_low and rx_debug_6_mask
        end If

    End Sub

    Sub write
        If flag_rx_debug_6 = &H0 Then read
        If flag_rx_debug_6 = &H0 Then write_rx_debug_6_value = get_rx_debug_6

        regValue = leftShift((write_rx_debug_6_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rx_debug_6_mask = &Hffff
        if data_low > LONG_MAX then
            if rx_debug_6_mask = mask then
                read_rx_debug_6_value = data_low
            else
                read_rx_debug_6_value = (data_low - H8000_0000) and rx_debug_6_mask
            end If
        else
            read_rx_debug_6_value = data_low and rx_debug_6_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rx_debug_6_value = &H0
        flag_rx_debug_6        = &H0
    End Sub
End Class


'' @REGISTER : BR_GPCS_txprobe0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' tx_debug_0                                 [15:0]           get_tx_debug_0
''                                                             set_tx_debug_0
''                                                             read_tx_debug_0
''                                                             write_tx_debug_0
''---------------------------------------------------------------------------------
Class REGISTER_BR_GPCS_txprobe0
    Private write_tx_debug_0_value
    Private read_tx_debug_0_value
    Private flag_tx_debug_0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hc0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_tx_debug_0
        get_tx_debug_0 = read_tx_debug_0_value
    End Property

    Property Let set_tx_debug_0(aData)
        write_tx_debug_0_value = aData
        flag_tx_debug_0        = &H1
    End Property

    Property Get read_tx_debug_0
        read
        read_tx_debug_0 = read_tx_debug_0_value
    End Property

    Property Let write_tx_debug_0(aData)
        set_tx_debug_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        tx_debug_0_mask = &Hffff
        if data_low > LONG_MAX then
            if tx_debug_0_mask = mask then
                read_tx_debug_0_value = data_low
            else
                read_tx_debug_0_value = (data_low - H8000_0000) and tx_debug_0_mask
            end If
        else
            read_tx_debug_0_value = data_low and tx_debug_0_mask
        end If

    End Sub

    Sub write
        If flag_tx_debug_0 = &H0 Then read
        If flag_tx_debug_0 = &H0 Then write_tx_debug_0_value = get_tx_debug_0

        regValue = leftShift((write_tx_debug_0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        tx_debug_0_mask = &Hffff
        if data_low > LONG_MAX then
            if tx_debug_0_mask = mask then
                read_tx_debug_0_value = data_low
            else
                read_tx_debug_0_value = (data_low - H8000_0000) and tx_debug_0_mask
            end If
        else
            read_tx_debug_0_value = data_low and tx_debug_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_tx_debug_0_value = &H0
        flag_tx_debug_0        = &H0
    End Sub
End Class


'' @REGISTER : BR_GPCS_txprobe1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' tx_debug_1                                 [15:0]           get_tx_debug_1
''                                                             set_tx_debug_1
''                                                             read_tx_debug_1
''                                                             write_tx_debug_1
''---------------------------------------------------------------------------------
Class REGISTER_BR_GPCS_txprobe1
    Private write_tx_debug_1_value
    Private read_tx_debug_1_value
    Private flag_tx_debug_1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hc2
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_tx_debug_1
        get_tx_debug_1 = read_tx_debug_1_value
    End Property

    Property Let set_tx_debug_1(aData)
        write_tx_debug_1_value = aData
        flag_tx_debug_1        = &H1
    End Property

    Property Get read_tx_debug_1
        read
        read_tx_debug_1 = read_tx_debug_1_value
    End Property

    Property Let write_tx_debug_1(aData)
        set_tx_debug_1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        tx_debug_1_mask = &Hffff
        if data_low > LONG_MAX then
            if tx_debug_1_mask = mask then
                read_tx_debug_1_value = data_low
            else
                read_tx_debug_1_value = (data_low - H8000_0000) and tx_debug_1_mask
            end If
        else
            read_tx_debug_1_value = data_low and tx_debug_1_mask
        end If

    End Sub

    Sub write
        If flag_tx_debug_1 = &H0 Then read
        If flag_tx_debug_1 = &H0 Then write_tx_debug_1_value = get_tx_debug_1

        regValue = leftShift((write_tx_debug_1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        tx_debug_1_mask = &Hffff
        if data_low > LONG_MAX then
            if tx_debug_1_mask = mask then
                read_tx_debug_1_value = data_low
            else
                read_tx_debug_1_value = (data_low - H8000_0000) and tx_debug_1_mask
            end If
        else
            read_tx_debug_1_value = data_low and tx_debug_1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_tx_debug_1_value = &H0
        flag_tx_debug_1        = &H0
    End Sub
End Class


'' @REGISTER : BR_GPCS_txprobe2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' tx_debug_2                                 [15:0]           get_tx_debug_2
''                                                             set_tx_debug_2
''                                                             read_tx_debug_2
''                                                             write_tx_debug_2
''---------------------------------------------------------------------------------
Class REGISTER_BR_GPCS_txprobe2
    Private write_tx_debug_2_value
    Private read_tx_debug_2_value
    Private flag_tx_debug_2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hc4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_tx_debug_2
        get_tx_debug_2 = read_tx_debug_2_value
    End Property

    Property Let set_tx_debug_2(aData)
        write_tx_debug_2_value = aData
        flag_tx_debug_2        = &H1
    End Property

    Property Get read_tx_debug_2
        read
        read_tx_debug_2 = read_tx_debug_2_value
    End Property

    Property Let write_tx_debug_2(aData)
        set_tx_debug_2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        tx_debug_2_mask = &Hffff
        if data_low > LONG_MAX then
            if tx_debug_2_mask = mask then
                read_tx_debug_2_value = data_low
            else
                read_tx_debug_2_value = (data_low - H8000_0000) and tx_debug_2_mask
            end If
        else
            read_tx_debug_2_value = data_low and tx_debug_2_mask
        end If

    End Sub

    Sub write
        If flag_tx_debug_2 = &H0 Then read
        If flag_tx_debug_2 = &H0 Then write_tx_debug_2_value = get_tx_debug_2

        regValue = leftShift((write_tx_debug_2_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        tx_debug_2_mask = &Hffff
        if data_low > LONG_MAX then
            if tx_debug_2_mask = mask then
                read_tx_debug_2_value = data_low
            else
                read_tx_debug_2_value = (data_low - H8000_0000) and tx_debug_2_mask
            end If
        else
            read_tx_debug_2_value = data_low and tx_debug_2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_tx_debug_2_value = &H0
        flag_tx_debug_2        = &H0
    End Sub
End Class


'' @REGISTER : BR_GPCS_txprobe3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' tx_debug_3                                 [15:0]           get_tx_debug_3
''                                                             set_tx_debug_3
''                                                             read_tx_debug_3
''                                                             write_tx_debug_3
''---------------------------------------------------------------------------------
Class REGISTER_BR_GPCS_txprobe3
    Private write_tx_debug_3_value
    Private read_tx_debug_3_value
    Private flag_tx_debug_3

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hc6
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_tx_debug_3
        get_tx_debug_3 = read_tx_debug_3_value
    End Property

    Property Let set_tx_debug_3(aData)
        write_tx_debug_3_value = aData
        flag_tx_debug_3        = &H1
    End Property

    Property Get read_tx_debug_3
        read
        read_tx_debug_3 = read_tx_debug_3_value
    End Property

    Property Let write_tx_debug_3(aData)
        set_tx_debug_3 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        tx_debug_3_mask = &Hffff
        if data_low > LONG_MAX then
            if tx_debug_3_mask = mask then
                read_tx_debug_3_value = data_low
            else
                read_tx_debug_3_value = (data_low - H8000_0000) and tx_debug_3_mask
            end If
        else
            read_tx_debug_3_value = data_low and tx_debug_3_mask
        end If

    End Sub

    Sub write
        If flag_tx_debug_3 = &H0 Then read
        If flag_tx_debug_3 = &H0 Then write_tx_debug_3_value = get_tx_debug_3

        regValue = leftShift((write_tx_debug_3_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        tx_debug_3_mask = &Hffff
        if data_low > LONG_MAX then
            if tx_debug_3_mask = mask then
                read_tx_debug_3_value = data_low
            else
                read_tx_debug_3_value = (data_low - H8000_0000) and tx_debug_3_mask
            end If
        else
            read_tx_debug_3_value = data_low and tx_debug_3_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_tx_debug_3_value = &H0
        flag_tx_debug_3        = &H0
    End Sub
End Class


'' @REGISTER : BR_GPCS_txprobe4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' tx_debug_4                                 [15:0]           get_tx_debug_4
''                                                             set_tx_debug_4
''                                                             read_tx_debug_4
''                                                             write_tx_debug_4
''---------------------------------------------------------------------------------
Class REGISTER_BR_GPCS_txprobe4
    Private write_tx_debug_4_value
    Private read_tx_debug_4_value
    Private flag_tx_debug_4

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hc8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_tx_debug_4
        get_tx_debug_4 = read_tx_debug_4_value
    End Property

    Property Let set_tx_debug_4(aData)
        write_tx_debug_4_value = aData
        flag_tx_debug_4        = &H1
    End Property

    Property Get read_tx_debug_4
        read
        read_tx_debug_4 = read_tx_debug_4_value
    End Property

    Property Let write_tx_debug_4(aData)
        set_tx_debug_4 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        tx_debug_4_mask = &Hffff
        if data_low > LONG_MAX then
            if tx_debug_4_mask = mask then
                read_tx_debug_4_value = data_low
            else
                read_tx_debug_4_value = (data_low - H8000_0000) and tx_debug_4_mask
            end If
        else
            read_tx_debug_4_value = data_low and tx_debug_4_mask
        end If

    End Sub

    Sub write
        If flag_tx_debug_4 = &H0 Then read
        If flag_tx_debug_4 = &H0 Then write_tx_debug_4_value = get_tx_debug_4

        regValue = leftShift((write_tx_debug_4_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        tx_debug_4_mask = &Hffff
        if data_low > LONG_MAX then
            if tx_debug_4_mask = mask then
                read_tx_debug_4_value = data_low
            else
                read_tx_debug_4_value = (data_low - H8000_0000) and tx_debug_4_mask
            end If
        else
            read_tx_debug_4_value = data_low and tx_debug_4_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_tx_debug_4_value = &H0
        flag_tx_debug_4        = &H0
    End Sub
End Class


'' @REGISTER : BR_GPCS_txprobe5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' tx_debug_5                                 [15:0]           get_tx_debug_5
''                                                             set_tx_debug_5
''                                                             read_tx_debug_5
''                                                             write_tx_debug_5
''---------------------------------------------------------------------------------
Class REGISTER_BR_GPCS_txprobe5
    Private write_tx_debug_5_value
    Private read_tx_debug_5_value
    Private flag_tx_debug_5

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hca
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_tx_debug_5
        get_tx_debug_5 = read_tx_debug_5_value
    End Property

    Property Let set_tx_debug_5(aData)
        write_tx_debug_5_value = aData
        flag_tx_debug_5        = &H1
    End Property

    Property Get read_tx_debug_5
        read
        read_tx_debug_5 = read_tx_debug_5_value
    End Property

    Property Let write_tx_debug_5(aData)
        set_tx_debug_5 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        tx_debug_5_mask = &Hffff
        if data_low > LONG_MAX then
            if tx_debug_5_mask = mask then
                read_tx_debug_5_value = data_low
            else
                read_tx_debug_5_value = (data_low - H8000_0000) and tx_debug_5_mask
            end If
        else
            read_tx_debug_5_value = data_low and tx_debug_5_mask
        end If

    End Sub

    Sub write
        If flag_tx_debug_5 = &H0 Then read
        If flag_tx_debug_5 = &H0 Then write_tx_debug_5_value = get_tx_debug_5

        regValue = leftShift((write_tx_debug_5_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        tx_debug_5_mask = &Hffff
        if data_low > LONG_MAX then
            if tx_debug_5_mask = mask then
                read_tx_debug_5_value = data_low
            else
                read_tx_debug_5_value = (data_low - H8000_0000) and tx_debug_5_mask
            end If
        else
            read_tx_debug_5_value = data_low and tx_debug_5_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_tx_debug_5_value = &H0
        flag_tx_debug_5        = &H0
    End Sub
End Class


'' @REGISTER : BR_GPCS_rxprobe7
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rx_debug_7                                 [15:0]           get_rx_debug_7
''                                                             set_rx_debug_7
''                                                             read_rx_debug_7
''                                                             write_rx_debug_7
''---------------------------------------------------------------------------------
Class REGISTER_BR_GPCS_rxprobe7
    Private write_rx_debug_7_value
    Private read_rx_debug_7_value
    Private flag_rx_debug_7

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hcc
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_rx_debug_7
        get_rx_debug_7 = read_rx_debug_7_value
    End Property

    Property Let set_rx_debug_7(aData)
        write_rx_debug_7_value = aData
        flag_rx_debug_7        = &H1
    End Property

    Property Get read_rx_debug_7
        read
        read_rx_debug_7 = read_rx_debug_7_value
    End Property

    Property Let write_rx_debug_7(aData)
        set_rx_debug_7 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rx_debug_7_mask = &Hffff
        if data_low > LONG_MAX then
            if rx_debug_7_mask = mask then
                read_rx_debug_7_value = data_low
            else
                read_rx_debug_7_value = (data_low - H8000_0000) and rx_debug_7_mask
            end If
        else
            read_rx_debug_7_value = data_low and rx_debug_7_mask
        end If

    End Sub

    Sub write
        If flag_rx_debug_7 = &H0 Then read
        If flag_rx_debug_7 = &H0 Then write_rx_debug_7_value = get_rx_debug_7

        regValue = leftShift((write_rx_debug_7_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rx_debug_7_mask = &Hffff
        if data_low > LONG_MAX then
            if rx_debug_7_mask = mask then
                read_rx_debug_7_value = data_low
            else
                read_rx_debug_7_value = (data_low - H8000_0000) and rx_debug_7_mask
            end If
        else
            read_rx_debug_7_value = data_low and rx_debug_7_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rx_debug_7_value = &H0
        flag_rx_debug_7        = &H0
    End Sub
End Class


'' @REGISTER : BR_GPCS_rfer_mon_limit
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rfer_limit_ov                              [15:15]          get_rfer_limit_ov
''                                                             set_rfer_limit_ov
''                                                             read_rfer_limit_ov
''                                                             write_rfer_limit_ov
''---------------------------------------------------------------------------------
'' rfer_cnt_limit                             [14:8]           get_rfer_cnt_limit
''                                                             set_rfer_cnt_limit
''                                                             read_rfer_cnt_limit
''                                                             write_rfer_cnt_limit
''---------------------------------------------------------------------------------
'' rfrx_cnt_limit                             [6:0]            get_rfrx_cnt_limit
''                                                             set_rfrx_cnt_limit
''                                                             read_rfrx_cnt_limit
''                                                             write_rfrx_cnt_limit
''---------------------------------------------------------------------------------
Class REGISTER_BR_GPCS_rfer_mon_limit
    Private write_rfer_limit_ov_value
    Private read_rfer_limit_ov_value
    Private flag_rfer_limit_ov
    Private write_rfer_cnt_limit_value
    Private read_rfer_cnt_limit_value
    Private flag_rfer_cnt_limit
    Private write_rfrx_cnt_limit_value
    Private read_rfrx_cnt_limit_value
    Private flag_rfrx_cnt_limit

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hce
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_rfer_limit_ov
        get_rfer_limit_ov = read_rfer_limit_ov_value
    End Property

    Property Let set_rfer_limit_ov(aData)
        write_rfer_limit_ov_value = aData
        flag_rfer_limit_ov        = &H1
    End Property

    Property Get read_rfer_limit_ov
        read
        read_rfer_limit_ov = read_rfer_limit_ov_value
    End Property

    Property Let write_rfer_limit_ov(aData)
        set_rfer_limit_ov = aData
        write
    End Property

    Property Get get_rfer_cnt_limit
        get_rfer_cnt_limit = read_rfer_cnt_limit_value
    End Property

    Property Let set_rfer_cnt_limit(aData)
        write_rfer_cnt_limit_value = aData
        flag_rfer_cnt_limit        = &H1
    End Property

    Property Get read_rfer_cnt_limit
        read
        read_rfer_cnt_limit = read_rfer_cnt_limit_value
    End Property

    Property Let write_rfer_cnt_limit(aData)
        set_rfer_cnt_limit = aData
        write
    End Property

    Property Get get_rfrx_cnt_limit
        get_rfrx_cnt_limit = read_rfrx_cnt_limit_value
    End Property

    Property Let set_rfrx_cnt_limit(aData)
        write_rfrx_cnt_limit_value = aData
        flag_rfrx_cnt_limit        = &H1
    End Property

    Property Get read_rfrx_cnt_limit
        read
        read_rfrx_cnt_limit = read_rfrx_cnt_limit_value
    End Property

    Property Let write_rfrx_cnt_limit(aData)
        set_rfrx_cnt_limit = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rfer_limit_ov_value = rightShift(data_low, 15) and &H1
        read_rfer_cnt_limit_value = rightShift(data_low, 8) and &H7f
        rfrx_cnt_limit_mask = &H7f
        if data_low > LONG_MAX then
            if rfrx_cnt_limit_mask = mask then
                read_rfrx_cnt_limit_value = data_low
            else
                read_rfrx_cnt_limit_value = (data_low - H8000_0000) and rfrx_cnt_limit_mask
            end If
        else
            read_rfrx_cnt_limit_value = data_low and rfrx_cnt_limit_mask
        end If

    End Sub

    Sub write
        If flag_rfer_limit_ov = &H0 or flag_rfer_cnt_limit = &H0 or flag_rfrx_cnt_limit = &H0 Then read
        If flag_rfer_limit_ov = &H0 Then write_rfer_limit_ov_value = get_rfer_limit_ov
        If flag_rfer_cnt_limit = &H0 Then write_rfer_cnt_limit_value = get_rfer_cnt_limit
        If flag_rfrx_cnt_limit = &H0 Then write_rfrx_cnt_limit_value = get_rfrx_cnt_limit

        regValue = leftShift((write_rfer_limit_ov_value and &H1), 15) + leftShift((write_rfer_cnt_limit_value and &H7f), 8) + leftShift((write_rfrx_cnt_limit_value and &H7f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rfer_limit_ov_value = rightShift(data_low, 15) and &H1
        read_rfer_cnt_limit_value = rightShift(data_low, 8) and &H7f
        rfrx_cnt_limit_mask = &H7f
        if data_low > LONG_MAX then
            if rfrx_cnt_limit_mask = mask then
                read_rfrx_cnt_limit_value = data_low
            else
                read_rfrx_cnt_limit_value = (data_low - H8000_0000) and rfrx_cnt_limit_mask
            end If
        else
            read_rfrx_cnt_limit_value = data_low and rfrx_cnt_limit_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rfer_limit_ov_value = &H0
        flag_rfer_limit_ov        = &H0
        write_rfer_cnt_limit_value = &H0
        flag_rfer_cnt_limit        = &H0
        write_rfrx_cnt_limit_value = &H0
        flag_rfrx_cnt_limit        = &H0
    End Sub
End Class


'' @REGISTER : BR_GPCS_rfer_cnt_raw
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rfer_cnt_raw                               [14:8]           get_rfer_cnt_raw
''                                                             set_rfer_cnt_raw
''                                                             read_rfer_cnt_raw
''                                                             write_rfer_cnt_raw
''---------------------------------------------------------------------------------
'' rfrx_cnt_raw                               [6:0]            get_rfrx_cnt_raw
''                                                             set_rfrx_cnt_raw
''                                                             read_rfrx_cnt_raw
''                                                             write_rfrx_cnt_raw
''---------------------------------------------------------------------------------
Class REGISTER_BR_GPCS_rfer_cnt_raw
    Private write_rfer_cnt_raw_value
    Private read_rfer_cnt_raw_value
    Private flag_rfer_cnt_raw
    Private write_rfrx_cnt_raw_value
    Private read_rfrx_cnt_raw_value
    Private flag_rfrx_cnt_raw

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hd0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_rfer_cnt_raw
        get_rfer_cnt_raw = read_rfer_cnt_raw_value
    End Property

    Property Let set_rfer_cnt_raw(aData)
        write_rfer_cnt_raw_value = aData
        flag_rfer_cnt_raw        = &H1
    End Property

    Property Get read_rfer_cnt_raw
        read
        read_rfer_cnt_raw = read_rfer_cnt_raw_value
    End Property

    Property Let write_rfer_cnt_raw(aData)
        set_rfer_cnt_raw = aData
        write
    End Property

    Property Get get_rfrx_cnt_raw
        get_rfrx_cnt_raw = read_rfrx_cnt_raw_value
    End Property

    Property Let set_rfrx_cnt_raw(aData)
        write_rfrx_cnt_raw_value = aData
        flag_rfrx_cnt_raw        = &H1
    End Property

    Property Get read_rfrx_cnt_raw
        read
        read_rfrx_cnt_raw = read_rfrx_cnt_raw_value
    End Property

    Property Let write_rfrx_cnt_raw(aData)
        set_rfrx_cnt_raw = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rfer_cnt_raw_value = rightShift(data_low, 8) and &H7f
        rfrx_cnt_raw_mask = &H7f
        if data_low > LONG_MAX then
            if rfrx_cnt_raw_mask = mask then
                read_rfrx_cnt_raw_value = data_low
            else
                read_rfrx_cnt_raw_value = (data_low - H8000_0000) and rfrx_cnt_raw_mask
            end If
        else
            read_rfrx_cnt_raw_value = data_low and rfrx_cnt_raw_mask
        end If

    End Sub

    Sub write
        If flag_rfer_cnt_raw = &H0 or flag_rfrx_cnt_raw = &H0 Then read
        If flag_rfer_cnt_raw = &H0 Then write_rfer_cnt_raw_value = get_rfer_cnt_raw
        If flag_rfrx_cnt_raw = &H0 Then write_rfrx_cnt_raw_value = get_rfrx_cnt_raw

        regValue = leftShift((write_rfer_cnt_raw_value and &H7f), 8) + leftShift((write_rfrx_cnt_raw_value and &H7f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rfer_cnt_raw_value = rightShift(data_low, 8) and &H7f
        rfrx_cnt_raw_mask = &H7f
        if data_low > LONG_MAX then
            if rfrx_cnt_raw_mask = mask then
                read_rfrx_cnt_raw_value = data_low
            else
                read_rfrx_cnt_raw_value = (data_low - H8000_0000) and rfrx_cnt_raw_mask
            end If
        else
            read_rfrx_cnt_raw_value = data_low and rfrx_cnt_raw_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rfer_cnt_raw_value = &H0
        flag_rfer_cnt_raw        = &H0
        write_rfrx_cnt_raw_value = &H0
        flag_rfrx_cnt_raw        = &H0
    End Sub
End Class


'' @REGISTER : BR_GPCS_rfer_mon_test
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' reg_reset_mon                              [15:15]          get_reg_reset_mon
''                                                             set_reg_reset_mon
''                                                             read_reg_reset_mon
''                                                             write_reg_reset_mon
''---------------------------------------------------------------------------------
'' rfer_state_m4                              [14:12]          get_rfer_state_m4
''                                                             set_rfer_state_m4
''                                                             read_rfer_state_m4
''                                                             write_rfer_state_m4
''---------------------------------------------------------------------------------
'' rfer_state_m3                              [11:9]           get_rfer_state_m3
''                                                             set_rfer_state_m3
''                                                             read_rfer_state_m3
''                                                             write_rfer_state_m3
''---------------------------------------------------------------------------------
'' rfer_state_m2                              [8:6]            get_rfer_state_m2
''                                                             set_rfer_state_m2
''                                                             read_rfer_state_m2
''                                                             write_rfer_state_m2
''---------------------------------------------------------------------------------
'' rfer_state_m1                              [5:3]            get_rfer_state_m1
''                                                             set_rfer_state_m1
''                                                             read_rfer_state_m1
''                                                             write_rfer_state_m1
''---------------------------------------------------------------------------------
'' rfer_state                                 [2:0]            get_rfer_state
''                                                             set_rfer_state
''                                                             read_rfer_state
''                                                             write_rfer_state
''---------------------------------------------------------------------------------
Class REGISTER_BR_GPCS_rfer_mon_test
    Private write_reg_reset_mon_value
    Private read_reg_reset_mon_value
    Private flag_reg_reset_mon
    Private write_rfer_state_m4_value
    Private read_rfer_state_m4_value
    Private flag_rfer_state_m4
    Private write_rfer_state_m3_value
    Private read_rfer_state_m3_value
    Private flag_rfer_state_m3
    Private write_rfer_state_m2_value
    Private read_rfer_state_m2_value
    Private flag_rfer_state_m2
    Private write_rfer_state_m1_value
    Private read_rfer_state_m1_value
    Private flag_rfer_state_m1
    Private write_rfer_state_value
    Private read_rfer_state_value
    Private flag_rfer_state

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hd2
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_reg_reset_mon
        get_reg_reset_mon = read_reg_reset_mon_value
    End Property

    Property Let set_reg_reset_mon(aData)
        write_reg_reset_mon_value = aData
        flag_reg_reset_mon        = &H1
    End Property

    Property Get read_reg_reset_mon
        read
        read_reg_reset_mon = read_reg_reset_mon_value
    End Property

    Property Let write_reg_reset_mon(aData)
        set_reg_reset_mon = aData
        write
    End Property

    Property Get get_rfer_state_m4
        get_rfer_state_m4 = read_rfer_state_m4_value
    End Property

    Property Let set_rfer_state_m4(aData)
        write_rfer_state_m4_value = aData
        flag_rfer_state_m4        = &H1
    End Property

    Property Get read_rfer_state_m4
        read
        read_rfer_state_m4 = read_rfer_state_m4_value
    End Property

    Property Let write_rfer_state_m4(aData)
        set_rfer_state_m4 = aData
        write
    End Property

    Property Get get_rfer_state_m3
        get_rfer_state_m3 = read_rfer_state_m3_value
    End Property

    Property Let set_rfer_state_m3(aData)
        write_rfer_state_m3_value = aData
        flag_rfer_state_m3        = &H1
    End Property

    Property Get read_rfer_state_m3
        read
        read_rfer_state_m3 = read_rfer_state_m3_value
    End Property

    Property Let write_rfer_state_m3(aData)
        set_rfer_state_m3 = aData
        write
    End Property

    Property Get get_rfer_state_m2
        get_rfer_state_m2 = read_rfer_state_m2_value
    End Property

    Property Let set_rfer_state_m2(aData)
        write_rfer_state_m2_value = aData
        flag_rfer_state_m2        = &H1
    End Property

    Property Get read_rfer_state_m2
        read
        read_rfer_state_m2 = read_rfer_state_m2_value
    End Property

    Property Let write_rfer_state_m2(aData)
        set_rfer_state_m2 = aData
        write
    End Property

    Property Get get_rfer_state_m1
        get_rfer_state_m1 = read_rfer_state_m1_value
    End Property

    Property Let set_rfer_state_m1(aData)
        write_rfer_state_m1_value = aData
        flag_rfer_state_m1        = &H1
    End Property

    Property Get read_rfer_state_m1
        read
        read_rfer_state_m1 = read_rfer_state_m1_value
    End Property

    Property Let write_rfer_state_m1(aData)
        set_rfer_state_m1 = aData
        write
    End Property

    Property Get get_rfer_state
        get_rfer_state = read_rfer_state_value
    End Property

    Property Let set_rfer_state(aData)
        write_rfer_state_value = aData
        flag_rfer_state        = &H1
    End Property

    Property Get read_rfer_state
        read
        read_rfer_state = read_rfer_state_value
    End Property

    Property Let write_rfer_state(aData)
        set_rfer_state = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_reg_reset_mon_value = rightShift(data_low, 15) and &H1
        read_rfer_state_m4_value = rightShift(data_low, 12) and &H7
        read_rfer_state_m3_value = rightShift(data_low, 9) and &H7
        read_rfer_state_m2_value = rightShift(data_low, 6) and &H7
        read_rfer_state_m1_value = rightShift(data_low, 3) and &H7
        rfer_state_mask = &H7
        if data_low > LONG_MAX then
            if rfer_state_mask = mask then
                read_rfer_state_value = data_low
            else
                read_rfer_state_value = (data_low - H8000_0000) and rfer_state_mask
            end If
        else
            read_rfer_state_value = data_low and rfer_state_mask
        end If

    End Sub

    Sub write
        If flag_reg_reset_mon = &H0 or flag_rfer_state_m4 = &H0 or flag_rfer_state_m3 = &H0 or flag_rfer_state_m2 = &H0 or flag_rfer_state_m1 = &H0 or flag_rfer_state = &H0 Then read
        If flag_reg_reset_mon = &H0 Then write_reg_reset_mon_value = get_reg_reset_mon
        If flag_rfer_state_m4 = &H0 Then write_rfer_state_m4_value = get_rfer_state_m4
        If flag_rfer_state_m3 = &H0 Then write_rfer_state_m3_value = get_rfer_state_m3
        If flag_rfer_state_m2 = &H0 Then write_rfer_state_m2_value = get_rfer_state_m2
        If flag_rfer_state_m1 = &H0 Then write_rfer_state_m1_value = get_rfer_state_m1
        If flag_rfer_state = &H0 Then write_rfer_state_value = get_rfer_state

        regValue = leftShift((write_reg_reset_mon_value and &H1), 15) + leftShift((write_rfer_state_m4_value and &H7), 12) + leftShift((write_rfer_state_m3_value and &H7), 9) + leftShift((write_rfer_state_m2_value and &H7), 6) + leftShift((write_rfer_state_m1_value and &H7), 3) + leftShift((write_rfer_state_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_reg_reset_mon_value = rightShift(data_low, 15) and &H1
        read_rfer_state_m4_value = rightShift(data_low, 12) and &H7
        read_rfer_state_m3_value = rightShift(data_low, 9) and &H7
        read_rfer_state_m2_value = rightShift(data_low, 6) and &H7
        read_rfer_state_m1_value = rightShift(data_low, 3) and &H7
        rfer_state_mask = &H7
        if data_low > LONG_MAX then
            if rfer_state_mask = mask then
                read_rfer_state_value = data_low
            else
                read_rfer_state_value = (data_low - H8000_0000) and rfer_state_mask
            end If
        else
            read_rfer_state_value = data_low and rfer_state_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_reg_reset_mon_value = &H0
        flag_reg_reset_mon        = &H0
        write_rfer_state_m4_value = &H0
        flag_rfer_state_m4        = &H0
        write_rfer_state_m3_value = &H0
        flag_rfer_state_m3        = &H0
        write_rfer_state_m2_value = &H0
        flag_rfer_state_m2        = &H0
        write_rfer_state_m1_value = &H0
        flag_rfer_state_m1        = &H0
        write_rfer_state_value = &H0
        flag_rfer_state        = &H0
    End Sub
End Class


'' @REGISTER : BR_GPCS_table35_1_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Normal_inter_frame                         [9:9]            get_Normal_inter_frame
''                                                             set_Normal_inter_frame
''                                                             read_Normal_inter_frame
''                                                             write_Normal_inter_frame
''---------------------------------------------------------------------------------
'' Reserved_0                                 [8:8]            get_Reserved_0
''                                                             set_Reserved_0
''                                                             read_Reserved_0
''                                                             write_Reserved_0
''---------------------------------------------------------------------------------
'' Assert_LPI                                 [7:7]            get_Assert_LPI
''                                                             set_Assert_LPI
''                                                             read_Assert_LPI
''                                                             write_Assert_LPI
''---------------------------------------------------------------------------------
'' Reserved_1                                 [6:6]            get_Reserved_1
''                                                             set_Reserved_1
''                                                             read_Reserved_1
''                                                             write_Reserved_1
''---------------------------------------------------------------------------------
'' Carrier_Extend                             [5:5]            get_Carrier_Extend
''                                                             set_Carrier_Extend
''                                                             read_Carrier_Extend
''                                                             write_Carrier_Extend
''---------------------------------------------------------------------------------
'' Reserved_2                                 [4:4]            get_Reserved_2
''                                                             set_Reserved_2
''                                                             read_Reserved_2
''                                                             write_Reserved_2
''---------------------------------------------------------------------------------
'' Carrier_Extend_Error                       [3:3]            get_Carrier_Extend_Error
''                                                             set_Carrier_Extend_Error
''                                                             read_Carrier_Extend_Error
''                                                             write_Carrier_Extend_Error
''---------------------------------------------------------------------------------
'' Reserved_3                                 [2:2]            get_Reserved_3
''                                                             set_Reserved_3
''                                                             read_Reserved_3
''                                                             write_Reserved_3
''---------------------------------------------------------------------------------
'' Normal_data_transmission                   [1:1]            get_Normal_data_transmission
''                                                             set_Normal_data_transmission
''                                                             read_Normal_data_transmission
''                                                             write_Normal_data_transmission
''---------------------------------------------------------------------------------
'' Transmit_error_propagation                 [0:0]            get_Transmit_error_propagation
''                                                             set_Transmit_error_propagation
''                                                             read_Transmit_error_propagation
''                                                             write_Transmit_error_propagation
''---------------------------------------------------------------------------------
Class REGISTER_BR_GPCS_table35_1_status
    Private write_Normal_inter_frame_value
    Private read_Normal_inter_frame_value
    Private flag_Normal_inter_frame
    Private write_Reserved_0_value
    Private read_Reserved_0_value
    Private flag_Reserved_0
    Private write_Assert_LPI_value
    Private read_Assert_LPI_value
    Private flag_Assert_LPI
    Private write_Reserved_1_value
    Private read_Reserved_1_value
    Private flag_Reserved_1
    Private write_Carrier_Extend_value
    Private read_Carrier_Extend_value
    Private flag_Carrier_Extend
    Private write_Reserved_2_value
    Private read_Reserved_2_value
    Private flag_Reserved_2
    Private write_Carrier_Extend_Error_value
    Private read_Carrier_Extend_Error_value
    Private flag_Carrier_Extend_Error
    Private write_Reserved_3_value
    Private read_Reserved_3_value
    Private flag_Reserved_3
    Private write_Normal_data_transmission_value
    Private read_Normal_data_transmission_value
    Private flag_Normal_data_transmission
    Private write_Transmit_error_propagation_value
    Private read_Transmit_error_propagation_value
    Private flag_Transmit_error_propagation

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He2
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_Normal_inter_frame
        get_Normal_inter_frame = read_Normal_inter_frame_value
    End Property

    Property Let set_Normal_inter_frame(aData)
        write_Normal_inter_frame_value = aData
        flag_Normal_inter_frame        = &H1
    End Property

    Property Get read_Normal_inter_frame
        read
        read_Normal_inter_frame = read_Normal_inter_frame_value
    End Property

    Property Let write_Normal_inter_frame(aData)
        set_Normal_inter_frame = aData
        write
    End Property

    Property Get get_Reserved_0
        get_Reserved_0 = read_Reserved_0_value
    End Property

    Property Let set_Reserved_0(aData)
        write_Reserved_0_value = aData
        flag_Reserved_0        = &H1
    End Property

    Property Get read_Reserved_0
        read
        read_Reserved_0 = read_Reserved_0_value
    End Property

    Property Let write_Reserved_0(aData)
        set_Reserved_0 = aData
        write
    End Property

    Property Get get_Assert_LPI
        get_Assert_LPI = read_Assert_LPI_value
    End Property

    Property Let set_Assert_LPI(aData)
        write_Assert_LPI_value = aData
        flag_Assert_LPI        = &H1
    End Property

    Property Get read_Assert_LPI
        read
        read_Assert_LPI = read_Assert_LPI_value
    End Property

    Property Let write_Assert_LPI(aData)
        set_Assert_LPI = aData
        write
    End Property

    Property Get get_Reserved_1
        get_Reserved_1 = read_Reserved_1_value
    End Property

    Property Let set_Reserved_1(aData)
        write_Reserved_1_value = aData
        flag_Reserved_1        = &H1
    End Property

    Property Get read_Reserved_1
        read
        read_Reserved_1 = read_Reserved_1_value
    End Property

    Property Let write_Reserved_1(aData)
        set_Reserved_1 = aData
        write
    End Property

    Property Get get_Carrier_Extend
        get_Carrier_Extend = read_Carrier_Extend_value
    End Property

    Property Let set_Carrier_Extend(aData)
        write_Carrier_Extend_value = aData
        flag_Carrier_Extend        = &H1
    End Property

    Property Get read_Carrier_Extend
        read
        read_Carrier_Extend = read_Carrier_Extend_value
    End Property

    Property Let write_Carrier_Extend(aData)
        set_Carrier_Extend = aData
        write
    End Property

    Property Get get_Reserved_2
        get_Reserved_2 = read_Reserved_2_value
    End Property

    Property Let set_Reserved_2(aData)
        write_Reserved_2_value = aData
        flag_Reserved_2        = &H1
    End Property

    Property Get read_Reserved_2
        read
        read_Reserved_2 = read_Reserved_2_value
    End Property

    Property Let write_Reserved_2(aData)
        set_Reserved_2 = aData
        write
    End Property

    Property Get get_Carrier_Extend_Error
        get_Carrier_Extend_Error = read_Carrier_Extend_Error_value
    End Property

    Property Let set_Carrier_Extend_Error(aData)
        write_Carrier_Extend_Error_value = aData
        flag_Carrier_Extend_Error        = &H1
    End Property

    Property Get read_Carrier_Extend_Error
        read
        read_Carrier_Extend_Error = read_Carrier_Extend_Error_value
    End Property

    Property Let write_Carrier_Extend_Error(aData)
        set_Carrier_Extend_Error = aData
        write
    End Property

    Property Get get_Reserved_3
        get_Reserved_3 = read_Reserved_3_value
    End Property

    Property Let set_Reserved_3(aData)
        write_Reserved_3_value = aData
        flag_Reserved_3        = &H1
    End Property

    Property Get read_Reserved_3
        read
        read_Reserved_3 = read_Reserved_3_value
    End Property

    Property Let write_Reserved_3(aData)
        set_Reserved_3 = aData
        write
    End Property

    Property Get get_Normal_data_transmission
        get_Normal_data_transmission = read_Normal_data_transmission_value
    End Property

    Property Let set_Normal_data_transmission(aData)
        write_Normal_data_transmission_value = aData
        flag_Normal_data_transmission        = &H1
    End Property

    Property Get read_Normal_data_transmission
        read
        read_Normal_data_transmission = read_Normal_data_transmission_value
    End Property

    Property Let write_Normal_data_transmission(aData)
        set_Normal_data_transmission = aData
        write
    End Property

    Property Get get_Transmit_error_propagation
        get_Transmit_error_propagation = read_Transmit_error_propagation_value
    End Property

    Property Let set_Transmit_error_propagation(aData)
        write_Transmit_error_propagation_value = aData
        flag_Transmit_error_propagation        = &H1
    End Property

    Property Get read_Transmit_error_propagation
        read
        read_Transmit_error_propagation = read_Transmit_error_propagation_value
    End Property

    Property Let write_Transmit_error_propagation(aData)
        set_Transmit_error_propagation = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Normal_inter_frame_value = rightShift(data_low, 9) and &H1
        read_Reserved_0_value = rightShift(data_low, 8) and &H1
        read_Assert_LPI_value = rightShift(data_low, 7) and &H1
        read_Reserved_1_value = rightShift(data_low, 6) and &H1
        read_Carrier_Extend_value = rightShift(data_low, 5) and &H1
        read_Reserved_2_value = rightShift(data_low, 4) and &H1
        read_Carrier_Extend_Error_value = rightShift(data_low, 3) and &H1
        read_Reserved_3_value = rightShift(data_low, 2) and &H1
        read_Normal_data_transmission_value = rightShift(data_low, 1) and &H1
        Transmit_error_propagation_mask = &H1
        if data_low > LONG_MAX then
            if Transmit_error_propagation_mask = mask then
                read_Transmit_error_propagation_value = data_low
            else
                read_Transmit_error_propagation_value = (data_low - H8000_0000) and Transmit_error_propagation_mask
            end If
        else
            read_Transmit_error_propagation_value = data_low and Transmit_error_propagation_mask
        end If

    End Sub

    Sub write
        If flag_Normal_inter_frame = &H0 or flag_Reserved_0 = &H0 or flag_Assert_LPI = &H0 or flag_Reserved_1 = &H0 or flag_Carrier_Extend = &H0 or flag_Reserved_2 = &H0 or flag_Carrier_Extend_Error = &H0 or flag_Reserved_3 = &H0 or flag_Normal_data_transmission = &H0 or flag_Transmit_error_propagation = &H0 Then read
        If flag_Normal_inter_frame = &H0 Then write_Normal_inter_frame_value = get_Normal_inter_frame
        If flag_Reserved_0 = &H0 Then write_Reserved_0_value = get_Reserved_0
        If flag_Assert_LPI = &H0 Then write_Assert_LPI_value = get_Assert_LPI
        If flag_Reserved_1 = &H0 Then write_Reserved_1_value = get_Reserved_1
        If flag_Carrier_Extend = &H0 Then write_Carrier_Extend_value = get_Carrier_Extend
        If flag_Reserved_2 = &H0 Then write_Reserved_2_value = get_Reserved_2
        If flag_Carrier_Extend_Error = &H0 Then write_Carrier_Extend_Error_value = get_Carrier_Extend_Error
        If flag_Reserved_3 = &H0 Then write_Reserved_3_value = get_Reserved_3
        If flag_Normal_data_transmission = &H0 Then write_Normal_data_transmission_value = get_Normal_data_transmission
        If flag_Transmit_error_propagation = &H0 Then write_Transmit_error_propagation_value = get_Transmit_error_propagation

        regValue = leftShift((write_Normal_inter_frame_value and &H1), 9) + leftShift((write_Reserved_0_value and &H1), 8) + leftShift((write_Assert_LPI_value and &H1), 7) + leftShift((write_Reserved_1_value and &H1), 6) + leftShift((write_Carrier_Extend_value and &H1), 5) + leftShift((write_Reserved_2_value and &H1), 4) + leftShift((write_Carrier_Extend_Error_value and &H1), 3) + leftShift((write_Reserved_3_value and &H1), 2) + leftShift((write_Normal_data_transmission_value and &H1), 1) + leftShift((write_Transmit_error_propagation_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Normal_inter_frame_value = rightShift(data_low, 9) and &H1
        read_Reserved_0_value = rightShift(data_low, 8) and &H1
        read_Assert_LPI_value = rightShift(data_low, 7) and &H1
        read_Reserved_1_value = rightShift(data_low, 6) and &H1
        read_Carrier_Extend_value = rightShift(data_low, 5) and &H1
        read_Reserved_2_value = rightShift(data_low, 4) and &H1
        read_Carrier_Extend_Error_value = rightShift(data_low, 3) and &H1
        read_Reserved_3_value = rightShift(data_low, 2) and &H1
        read_Normal_data_transmission_value = rightShift(data_low, 1) and &H1
        Transmit_error_propagation_mask = &H1
        if data_low > LONG_MAX then
            if Transmit_error_propagation_mask = mask then
                read_Transmit_error_propagation_value = data_low
            else
                read_Transmit_error_propagation_value = (data_low - H8000_0000) and Transmit_error_propagation_mask
            end If
        else
            read_Transmit_error_propagation_value = data_low and Transmit_error_propagation_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Normal_inter_frame_value = &H0
        flag_Normal_inter_frame        = &H0
        write_Reserved_0_value = &H0
        flag_Reserved_0        = &H0
        write_Assert_LPI_value = &H0
        flag_Assert_LPI        = &H0
        write_Reserved_1_value = &H0
        flag_Reserved_1        = &H0
        write_Carrier_Extend_value = &H0
        flag_Carrier_Extend        = &H0
        write_Reserved_2_value = &H0
        flag_Reserved_2        = &H0
        write_Carrier_Extend_Error_value = &H0
        flag_Carrier_Extend_Error        = &H0
        write_Reserved_3_value = &H0
        flag_Reserved_3        = &H0
        write_Normal_data_transmission_value = &H0
        flag_Normal_data_transmission        = &H0
        write_Transmit_error_propagation_value = &H0
        flag_Transmit_error_propagation        = &H0
    End Sub
End Class


'' @REGISTER : BR_GPCS_spare_end_addr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SPARE_END_ADDR                             [15:0]           get_SPARE_END_ADDR
''                                                             set_SPARE_END_ADDR
''                                                             read_SPARE_END_ADDR
''                                                             write_SPARE_END_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_BR_GPCS_spare_end_addr
    Private write_SPARE_END_ADDR_value
    Private read_SPARE_END_ADDR_value
    Private flag_SPARE_END_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2fe
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SPARE_END_ADDR
        get_SPARE_END_ADDR = read_SPARE_END_ADDR_value
    End Property

    Property Let set_SPARE_END_ADDR(aData)
        write_SPARE_END_ADDR_value = aData
        flag_SPARE_END_ADDR        = &H1
    End Property

    Property Get read_SPARE_END_ADDR
        read
        read_SPARE_END_ADDR = read_SPARE_END_ADDR_value
    End Property

    Property Let write_SPARE_END_ADDR(aData)
        set_SPARE_END_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SPARE_END_ADDR_mask = &Hffff
        if data_low > LONG_MAX then
            if SPARE_END_ADDR_mask = mask then
                read_SPARE_END_ADDR_value = data_low
            else
                read_SPARE_END_ADDR_value = (data_low - H8000_0000) and SPARE_END_ADDR_mask
            end If
        else
            read_SPARE_END_ADDR_value = data_low and SPARE_END_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_SPARE_END_ADDR = &H0 Then read
        If flag_SPARE_END_ADDR = &H0 Then write_SPARE_END_ADDR_value = get_SPARE_END_ADDR

        regValue = leftShift((write_SPARE_END_ADDR_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SPARE_END_ADDR_mask = &Hffff
        if data_low > LONG_MAX then
            if SPARE_END_ADDR_mask = mask then
                read_SPARE_END_ADDR_value = data_low
            else
                read_SPARE_END_ADDR_value = (data_low - H8000_0000) and SPARE_END_ADDR_mask
            end If
        else
            read_SPARE_END_ADDR_value = data_low and SPARE_END_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SPARE_END_ADDR_value = &H0
        flag_SPARE_END_ADDR        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class BR_GPCS_INSTANCE

    Public gmii_fifo_ctl0
    Public gmii_fifo_ctl1
    Public data_sw_pfc_offset0
    Public data_sw_pfc_offset1
    Public scrambler_ctl
    Public txpcs_seed_ctl
    Public pam3_ctl
    Public oam_ctl
    Public oam_status
    Public rxpcs_seed_ctl
    Public fifo_status
    Public rxtrain_seed_ctl2
    Public rxtrain_seed_ctl1
    Public rxtrain_seed_ctl0
    Public txtrain_seed_ctl2
    Public txtrain_seed_ctl1
    Public txtrain_seed_ctl0
    Public rxtrain_ctl0
    Public misc_status0
    Public misc_status1
    Public misc_status2
    Public pcs_misc_ctl0
    Public txfifo_ramctl0
    Public rxfifo_ramctl0
    Public ram_status
    Public pcs_misc_ctl1
    Public pcs_misc_ctl2
    Public pcs_misc_ctl3
    Public pcs_misc_ctl4
    Public pcs_misc_ctl5
    Public pcs_misc_ctl6
    Public pcs_misc_ctl7
    Public pcs_misc_ctl8
    Public pcs_misc_ctl9
    Public pcs_misc_ctl10
    Public pcs_misc_ctl11
    Public pcs_misc_ctl12
    Public pcs_misc_ctl13
    Public pcs_misc_ctl14
    Public rxprobe0
    Public rxprobe1
    Public rxprobe2
    Public rxprobe3
    Public rxprobe4
    Public rxprobe5
    Public rxprobe6
    Public txprobe0
    Public txprobe1
    Public txprobe2
    Public txprobe3
    Public txprobe4
    Public txprobe5
    Public rxprobe7
    Public rfer_mon_limit
    Public rfer_cnt_raw
    Public rfer_mon_test
    Public table35_1_status
    Public spare_end_addr


    Public default function Init(aBaseAddr)
        Set gmii_fifo_ctl0 = (New REGISTER_BR_GPCS_gmii_fifo_ctl0)(aBaseAddr, 16)
        Set gmii_fifo_ctl1 = (New REGISTER_BR_GPCS_gmii_fifo_ctl1)(aBaseAddr, 16)
        Set data_sw_pfc_offset0 = (New REGISTER_BR_GPCS_data_sw_pfc_offset0)(aBaseAddr, 16)
        Set data_sw_pfc_offset1 = (New REGISTER_BR_GPCS_data_sw_pfc_offset1)(aBaseAddr, 16)
        Set scrambler_ctl = (New REGISTER_BR_GPCS_scrambler_ctl)(aBaseAddr, 16)
        Set txpcs_seed_ctl = (New REGISTER_BR_GPCS_txpcs_seed_ctl)(aBaseAddr, 16)
        Set pam3_ctl = (New REGISTER_BR_GPCS_pam3_ctl)(aBaseAddr, 16)
        Set oam_ctl = (New REGISTER_BR_GPCS_oam_ctl)(aBaseAddr, 16)
        Set oam_status = (New REGISTER_BR_GPCS_oam_status)(aBaseAddr, 16)
        Set rxpcs_seed_ctl = (New REGISTER_BR_GPCS_rxpcs_seed_ctl)(aBaseAddr, 16)
        Set fifo_status = (New REGISTER_BR_GPCS_fifo_status)(aBaseAddr, 16)
        Set rxtrain_seed_ctl2 = (New REGISTER_BR_GPCS_rxtrain_seed_ctl2)(aBaseAddr, 16)
        Set rxtrain_seed_ctl1 = (New REGISTER_BR_GPCS_rxtrain_seed_ctl1)(aBaseAddr, 16)
        Set rxtrain_seed_ctl0 = (New REGISTER_BR_GPCS_rxtrain_seed_ctl0)(aBaseAddr, 16)
        Set txtrain_seed_ctl2 = (New REGISTER_BR_GPCS_txtrain_seed_ctl2)(aBaseAddr, 16)
        Set txtrain_seed_ctl1 = (New REGISTER_BR_GPCS_txtrain_seed_ctl1)(aBaseAddr, 16)
        Set txtrain_seed_ctl0 = (New REGISTER_BR_GPCS_txtrain_seed_ctl0)(aBaseAddr, 16)
        Set rxtrain_ctl0 = (New REGISTER_BR_GPCS_rxtrain_ctl0)(aBaseAddr, 16)
        Set misc_status0 = (New REGISTER_BR_GPCS_misc_status0)(aBaseAddr, 16)
        Set misc_status1 = (New REGISTER_BR_GPCS_misc_status1)(aBaseAddr, 16)
        Set misc_status2 = (New REGISTER_BR_GPCS_misc_status2)(aBaseAddr, 16)
        Set pcs_misc_ctl0 = (New REGISTER_BR_GPCS_pcs_misc_ctl0)(aBaseAddr, 16)
        Set txfifo_ramctl0 = (New REGISTER_BR_GPCS_txfifo_ramctl0)(aBaseAddr, 16)
        Set rxfifo_ramctl0 = (New REGISTER_BR_GPCS_rxfifo_ramctl0)(aBaseAddr, 16)
        Set ram_status = (New REGISTER_BR_GPCS_ram_status)(aBaseAddr, 16)
        Set pcs_misc_ctl1 = (New REGISTER_BR_GPCS_pcs_misc_ctl1)(aBaseAddr, 16)
        Set pcs_misc_ctl2 = (New REGISTER_BR_GPCS_pcs_misc_ctl2)(aBaseAddr, 16)
        Set pcs_misc_ctl3 = (New REGISTER_BR_GPCS_pcs_misc_ctl3)(aBaseAddr, 16)
        Set pcs_misc_ctl4 = (New REGISTER_BR_GPCS_pcs_misc_ctl4)(aBaseAddr, 16)
        Set pcs_misc_ctl5 = (New REGISTER_BR_GPCS_pcs_misc_ctl5)(aBaseAddr, 16)
        Set pcs_misc_ctl6 = (New REGISTER_BR_GPCS_pcs_misc_ctl6)(aBaseAddr, 16)
        Set pcs_misc_ctl7 = (New REGISTER_BR_GPCS_pcs_misc_ctl7)(aBaseAddr, 16)
        Set pcs_misc_ctl8 = (New REGISTER_BR_GPCS_pcs_misc_ctl8)(aBaseAddr, 16)
        Set pcs_misc_ctl9 = (New REGISTER_BR_GPCS_pcs_misc_ctl9)(aBaseAddr, 16)
        Set pcs_misc_ctl10 = (New REGISTER_BR_GPCS_pcs_misc_ctl10)(aBaseAddr, 16)
        Set pcs_misc_ctl11 = (New REGISTER_BR_GPCS_pcs_misc_ctl11)(aBaseAddr, 16)
        Set pcs_misc_ctl12 = (New REGISTER_BR_GPCS_pcs_misc_ctl12)(aBaseAddr, 16)
        Set pcs_misc_ctl13 = (New REGISTER_BR_GPCS_pcs_misc_ctl13)(aBaseAddr, 16)
        Set pcs_misc_ctl14 = (New REGISTER_BR_GPCS_pcs_misc_ctl14)(aBaseAddr, 16)
        Set rxprobe0 = (New REGISTER_BR_GPCS_rxprobe0)(aBaseAddr, 16)
        Set rxprobe1 = (New REGISTER_BR_GPCS_rxprobe1)(aBaseAddr, 16)
        Set rxprobe2 = (New REGISTER_BR_GPCS_rxprobe2)(aBaseAddr, 16)
        Set rxprobe3 = (New REGISTER_BR_GPCS_rxprobe3)(aBaseAddr, 16)
        Set rxprobe4 = (New REGISTER_BR_GPCS_rxprobe4)(aBaseAddr, 16)
        Set rxprobe5 = (New REGISTER_BR_GPCS_rxprobe5)(aBaseAddr, 16)
        Set rxprobe6 = (New REGISTER_BR_GPCS_rxprobe6)(aBaseAddr, 16)
        Set txprobe0 = (New REGISTER_BR_GPCS_txprobe0)(aBaseAddr, 16)
        Set txprobe1 = (New REGISTER_BR_GPCS_txprobe1)(aBaseAddr, 16)
        Set txprobe2 = (New REGISTER_BR_GPCS_txprobe2)(aBaseAddr, 16)
        Set txprobe3 = (New REGISTER_BR_GPCS_txprobe3)(aBaseAddr, 16)
        Set txprobe4 = (New REGISTER_BR_GPCS_txprobe4)(aBaseAddr, 16)
        Set txprobe5 = (New REGISTER_BR_GPCS_txprobe5)(aBaseAddr, 16)
        Set rxprobe7 = (New REGISTER_BR_GPCS_rxprobe7)(aBaseAddr, 16)
        Set rfer_mon_limit = (New REGISTER_BR_GPCS_rfer_mon_limit)(aBaseAddr, 16)
        Set rfer_cnt_raw = (New REGISTER_BR_GPCS_rfer_cnt_raw)(aBaseAddr, 16)
        Set rfer_mon_test = (New REGISTER_BR_GPCS_rfer_mon_test)(aBaseAddr, 16)
        Set table35_1_status = (New REGISTER_BR_GPCS_table35_1_status)(aBaseAddr, 16)
        Set spare_end_addr = (New REGISTER_BR_GPCS_spare_end_addr)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set BR_GPCS = CreateObject("System.Collections.ArrayList")
BR_GPCS.Add ((New BR_GPCS_INSTANCE)(&H49031800))


