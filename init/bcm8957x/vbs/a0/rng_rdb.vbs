

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


'' @REGISTER : RNG_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RNG_COMBLK2_OSC_DIS                        [27:22]          get_RNG_COMBLK2_OSC_DIS
''                                                             set_RNG_COMBLK2_OSC_DIS
''                                                             read_RNG_COMBLK2_OSC_DIS
''                                                             write_RNG_COMBLK2_OSC_DIS
''---------------------------------------------------------------------------------
'' RNG_COMBLK1_OSC_DIS                        [21:16]          get_RNG_COMBLK1_OSC_DIS
''                                                             set_RNG_COMBLK1_OSC_DIS
''                                                             read_RNG_COMBLK1_OSC_DIS
''                                                             write_RNG_COMBLK1_OSC_DIS
''---------------------------------------------------------------------------------
'' RNG_JCLK_BYP_DIV_CNT                       [15:8]           get_RNG_JCLK_BYP_DIV_CNT
''                                                             set_RNG_JCLK_BYP_DIV_CNT
''                                                             read_RNG_JCLK_BYP_DIV_CNT
''                                                             write_RNG_JCLK_BYP_DIV_CNT
''---------------------------------------------------------------------------------
'' RNG_JCLK_BYP_SEL                           [4:4]            get_RNG_JCLK_BYP_SEL
''                                                             set_RNG_JCLK_BYP_SEL
''                                                             read_RNG_JCLK_BYP_SEL
''                                                             write_RNG_JCLK_BYP_SEL
''---------------------------------------------------------------------------------
'' RBG_DIV                                    [2:1]            get_RBG_DIV
''                                                             set_RBG_DIV
''                                                             read_RBG_DIV
''                                                             write_RBG_DIV
''---------------------------------------------------------------------------------
'' RBG_EN                                     [0:0]            get_RBG_EN
''                                                             set_RBG_EN
''                                                             read_RBG_EN
''                                                             write_RBG_EN
''---------------------------------------------------------------------------------
Class REGISTER_RNG_ctrl
    Private write_RNG_COMBLK2_OSC_DIS_value
    Private read_RNG_COMBLK2_OSC_DIS_value
    Private flag_RNG_COMBLK2_OSC_DIS
    Private write_RNG_COMBLK1_OSC_DIS_value
    Private read_RNG_COMBLK1_OSC_DIS_value
    Private flag_RNG_COMBLK1_OSC_DIS
    Private write_RNG_JCLK_BYP_DIV_CNT_value
    Private read_RNG_JCLK_BYP_DIV_CNT_value
    Private flag_RNG_JCLK_BYP_DIV_CNT
    Private write_RNG_JCLK_BYP_SEL_value
    Private read_RNG_JCLK_BYP_SEL_value
    Private flag_RNG_JCLK_BYP_SEL
    Private write_RBG_DIV_value
    Private read_RBG_DIV_value
    Private flag_RBG_DIV
    Private write_RBG_EN_value
    Private read_RBG_EN_value
    Private flag_RBG_EN

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

    Property Get get_RNG_COMBLK2_OSC_DIS
        get_RNG_COMBLK2_OSC_DIS = read_RNG_COMBLK2_OSC_DIS_value
    End Property

    Property Let set_RNG_COMBLK2_OSC_DIS(aData)
        write_RNG_COMBLK2_OSC_DIS_value = aData
        flag_RNG_COMBLK2_OSC_DIS        = &H1
    End Property

    Property Get read_RNG_COMBLK2_OSC_DIS
        read
        read_RNG_COMBLK2_OSC_DIS = read_RNG_COMBLK2_OSC_DIS_value
    End Property

    Property Let write_RNG_COMBLK2_OSC_DIS(aData)
        set_RNG_COMBLK2_OSC_DIS = aData
        write
    End Property

    Property Get get_RNG_COMBLK1_OSC_DIS
        get_RNG_COMBLK1_OSC_DIS = read_RNG_COMBLK1_OSC_DIS_value
    End Property

    Property Let set_RNG_COMBLK1_OSC_DIS(aData)
        write_RNG_COMBLK1_OSC_DIS_value = aData
        flag_RNG_COMBLK1_OSC_DIS        = &H1
    End Property

    Property Get read_RNG_COMBLK1_OSC_DIS
        read
        read_RNG_COMBLK1_OSC_DIS = read_RNG_COMBLK1_OSC_DIS_value
    End Property

    Property Let write_RNG_COMBLK1_OSC_DIS(aData)
        set_RNG_COMBLK1_OSC_DIS = aData
        write
    End Property

    Property Get get_RNG_JCLK_BYP_DIV_CNT
        get_RNG_JCLK_BYP_DIV_CNT = read_RNG_JCLK_BYP_DIV_CNT_value
    End Property

    Property Let set_RNG_JCLK_BYP_DIV_CNT(aData)
        write_RNG_JCLK_BYP_DIV_CNT_value = aData
        flag_RNG_JCLK_BYP_DIV_CNT        = &H1
    End Property

    Property Get read_RNG_JCLK_BYP_DIV_CNT
        read
        read_RNG_JCLK_BYP_DIV_CNT = read_RNG_JCLK_BYP_DIV_CNT_value
    End Property

    Property Let write_RNG_JCLK_BYP_DIV_CNT(aData)
        set_RNG_JCLK_BYP_DIV_CNT = aData
        write
    End Property

    Property Get get_RNG_JCLK_BYP_SEL
        get_RNG_JCLK_BYP_SEL = read_RNG_JCLK_BYP_SEL_value
    End Property

    Property Let set_RNG_JCLK_BYP_SEL(aData)
        write_RNG_JCLK_BYP_SEL_value = aData
        flag_RNG_JCLK_BYP_SEL        = &H1
    End Property

    Property Get read_RNG_JCLK_BYP_SEL
        read
        read_RNG_JCLK_BYP_SEL = read_RNG_JCLK_BYP_SEL_value
    End Property

    Property Let write_RNG_JCLK_BYP_SEL(aData)
        set_RNG_JCLK_BYP_SEL = aData
        write
    End Property

    Property Get get_RBG_DIV
        get_RBG_DIV = read_RBG_DIV_value
    End Property

    Property Let set_RBG_DIV(aData)
        write_RBG_DIV_value = aData
        flag_RBG_DIV        = &H1
    End Property

    Property Get read_RBG_DIV
        read
        read_RBG_DIV = read_RBG_DIV_value
    End Property

    Property Let write_RBG_DIV(aData)
        set_RBG_DIV = aData
        write
    End Property

    Property Get get_RBG_EN
        get_RBG_EN = read_RBG_EN_value
    End Property

    Property Let set_RBG_EN(aData)
        write_RBG_EN_value = aData
        flag_RBG_EN        = &H1
    End Property

    Property Get read_RBG_EN
        read
        read_RBG_EN = read_RBG_EN_value
    End Property

    Property Let write_RBG_EN(aData)
        set_RBG_EN = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RNG_COMBLK2_OSC_DIS_value = rightShift(data_low, 22) and &H3f
        read_RNG_COMBLK1_OSC_DIS_value = rightShift(data_low, 16) and &H3f
        read_RNG_JCLK_BYP_DIV_CNT_value = rightShift(data_low, 8) and &Hff
        read_RNG_JCLK_BYP_SEL_value = rightShift(data_low, 4) and &H1
        read_RBG_DIV_value = rightShift(data_low, 1) and &H3
        RBG_EN_mask = &H1
        if data_low > LONG_MAX then
            if RBG_EN_mask = mask then
                read_RBG_EN_value = data_low
            else
                read_RBG_EN_value = (data_low - H8000_0000) and RBG_EN_mask
            end If
        else
            read_RBG_EN_value = data_low and RBG_EN_mask
        end If

    End Sub

    Sub write
        If flag_RNG_COMBLK2_OSC_DIS = &H0 or flag_RNG_COMBLK1_OSC_DIS = &H0 or flag_RNG_JCLK_BYP_DIV_CNT = &H0 or flag_RNG_JCLK_BYP_SEL = &H0 or flag_RBG_DIV = &H0 or flag_RBG_EN = &H0 Then read
        If flag_RNG_COMBLK2_OSC_DIS = &H0 Then write_RNG_COMBLK2_OSC_DIS_value = get_RNG_COMBLK2_OSC_DIS
        If flag_RNG_COMBLK1_OSC_DIS = &H0 Then write_RNG_COMBLK1_OSC_DIS_value = get_RNG_COMBLK1_OSC_DIS
        If flag_RNG_JCLK_BYP_DIV_CNT = &H0 Then write_RNG_JCLK_BYP_DIV_CNT_value = get_RNG_JCLK_BYP_DIV_CNT
        If flag_RNG_JCLK_BYP_SEL = &H0 Then write_RNG_JCLK_BYP_SEL_value = get_RNG_JCLK_BYP_SEL
        If flag_RBG_DIV = &H0 Then write_RBG_DIV_value = get_RBG_DIV
        If flag_RBG_EN = &H0 Then write_RBG_EN_value = get_RBG_EN

        regValue = leftShift((write_RNG_COMBLK2_OSC_DIS_value and &H3f), 22) + leftShift((write_RNG_COMBLK1_OSC_DIS_value and &H3f), 16) + leftShift((write_RNG_JCLK_BYP_DIV_CNT_value and &Hff), 8) + leftShift((write_RNG_JCLK_BYP_SEL_value and &H1), 4) + leftShift((write_RBG_DIV_value and &H3), 1) + leftShift((write_RBG_EN_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RNG_COMBLK2_OSC_DIS_value = rightShift(data_low, 22) and &H3f
        read_RNG_COMBLK1_OSC_DIS_value = rightShift(data_low, 16) and &H3f
        read_RNG_JCLK_BYP_DIV_CNT_value = rightShift(data_low, 8) and &Hff
        read_RNG_JCLK_BYP_SEL_value = rightShift(data_low, 4) and &H1
        read_RBG_DIV_value = rightShift(data_low, 1) and &H3
        RBG_EN_mask = &H1
        if data_low > LONG_MAX then
            if RBG_EN_mask = mask then
                read_RBG_EN_value = data_low
            else
                read_RBG_EN_value = (data_low - H8000_0000) and RBG_EN_mask
            end If
        else
            read_RBG_EN_value = data_low and RBG_EN_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RNG_COMBLK2_OSC_DIS_value = &H0
        flag_RNG_COMBLK2_OSC_DIS        = &H0
        write_RNG_COMBLK1_OSC_DIS_value = &H0
        flag_RNG_COMBLK1_OSC_DIS        = &H0
        write_RNG_JCLK_BYP_DIV_CNT_value = &H0
        flag_RNG_JCLK_BYP_DIV_CNT        = &H0
        write_RNG_JCLK_BYP_SEL_value = &H0
        flag_RNG_JCLK_BYP_SEL        = &H0
        write_RBG_DIV_value = &H0
        flag_RBG_DIV        = &H0
        write_RBG_EN_value = &H0
        flag_RBG_EN        = &H0
    End Sub
End Class


'' @REGISTER : RNG_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RNG_VAL                                    [31:24]          get_RNG_VAL
''                                                             set_RNG_VAL
''                                                             read_RNG_VAL
''                                                             write_RNG_VAL
''---------------------------------------------------------------------------------
'' RNG_WARM_CNT                               [19:0]           get_RNG_WARM_CNT
''                                                             set_RNG_WARM_CNT
''                                                             read_RNG_WARM_CNT
''                                                             write_RNG_WARM_CNT
''---------------------------------------------------------------------------------
Class REGISTER_RNG_status
    Private write_RNG_VAL_value
    Private read_RNG_VAL_value
    Private flag_RNG_VAL
    Private write_RNG_WARM_CNT_value
    Private read_RNG_WARM_CNT_value
    Private flag_RNG_WARM_CNT

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

    Property Get get_RNG_VAL
        get_RNG_VAL = read_RNG_VAL_value
    End Property

    Property Let set_RNG_VAL(aData)
        write_RNG_VAL_value = aData
        flag_RNG_VAL        = &H1
    End Property

    Property Get read_RNG_VAL
        read
        read_RNG_VAL = read_RNG_VAL_value
    End Property

    Property Let write_RNG_VAL(aData)
        set_RNG_VAL = aData
        write
    End Property

    Property Get get_RNG_WARM_CNT
        get_RNG_WARM_CNT = read_RNG_WARM_CNT_value
    End Property

    Property Let set_RNG_WARM_CNT(aData)
        write_RNG_WARM_CNT_value = aData
        flag_RNG_WARM_CNT        = &H1
    End Property

    Property Get read_RNG_WARM_CNT
        read
        read_RNG_WARM_CNT = read_RNG_WARM_CNT_value
    End Property

    Property Let write_RNG_WARM_CNT(aData)
        set_RNG_WARM_CNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RNG_VAL_value = rightShift(data_low, 24) and &Hff
        RNG_WARM_CNT_mask = &Hfffff
        if data_low > LONG_MAX then
            if RNG_WARM_CNT_mask = mask then
                read_RNG_WARM_CNT_value = data_low
            else
                read_RNG_WARM_CNT_value = (data_low - H8000_0000) and RNG_WARM_CNT_mask
            end If
        else
            read_RNG_WARM_CNT_value = data_low and RNG_WARM_CNT_mask
        end If

    End Sub

    Sub write
        If flag_RNG_VAL = &H0 or flag_RNG_WARM_CNT = &H0 Then read
        If flag_RNG_VAL = &H0 Then write_RNG_VAL_value = get_RNG_VAL
        If flag_RNG_WARM_CNT = &H0 Then write_RNG_WARM_CNT_value = get_RNG_WARM_CNT

        regValue = leftShift((write_RNG_VAL_value and &Hff), 24) + leftShift((write_RNG_WARM_CNT_value and &Hfffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RNG_VAL_value = rightShift(data_low, 24) and &Hff
        RNG_WARM_CNT_mask = &Hfffff
        if data_low > LONG_MAX then
            if RNG_WARM_CNT_mask = mask then
                read_RNG_WARM_CNT_value = data_low
            else
                read_RNG_WARM_CNT_value = (data_low - H8000_0000) and RNG_WARM_CNT_mask
            end If
        else
            read_RNG_WARM_CNT_value = data_low and RNG_WARM_CNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RNG_VAL_value = &H0
        flag_RNG_VAL        = &H0
        write_RNG_WARM_CNT_value = &H0
        flag_RNG_WARM_CNT        = &H0
    End Sub
End Class


'' @REGISTER : RNG_data
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RNG_NUM                                    [31:0]           get_RNG_NUM
''                                                             set_RNG_NUM
''                                                             read_RNG_NUM
''                                                             write_RNG_NUM
''---------------------------------------------------------------------------------
Class REGISTER_RNG_data
    Private write_RNG_NUM_value
    Private read_RNG_NUM_value
    Private flag_RNG_NUM

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

    Property Get get_RNG_NUM
        get_RNG_NUM = read_RNG_NUM_value
    End Property

    Property Let set_RNG_NUM(aData)
        write_RNG_NUM_value = aData
        flag_RNG_NUM        = &H1
    End Property

    Property Get read_RNG_NUM
        read
        read_RNG_NUM = read_RNG_NUM_value
    End Property

    Property Let write_RNG_NUM(aData)
        set_RNG_NUM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RNG_NUM_mask = &Hffffffff
        if data_low > LONG_MAX then
            if RNG_NUM_mask = mask then
                read_RNG_NUM_value = data_low
            else
                read_RNG_NUM_value = (data_low - H8000_0000) and RNG_NUM_mask
            end If
        else
            read_RNG_NUM_value = data_low and RNG_NUM_mask
        end If

    End Sub

    Sub write
        If flag_RNG_NUM = &H0 Then read
        If flag_RNG_NUM = &H0 Then write_RNG_NUM_value = get_RNG_NUM

        regValue = leftShift(write_RNG_NUM_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RNG_NUM_mask = &Hffffffff
        if data_low > LONG_MAX then
            if RNG_NUM_mask = mask then
                read_RNG_NUM_value = data_low
            else
                read_RNG_NUM_value = (data_low - H8000_0000) and RNG_NUM_mask
            end If
        else
            read_RNG_NUM_value = data_low and RNG_NUM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RNG_NUM_value = &H0
        flag_RNG_NUM        = &H0
    End Sub
End Class


'' @REGISTER : RNG_ff_thres
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RNG_FF_THRESH                              [4:0]            get_RNG_FF_THRESH
''                                                             set_RNG_FF_THRESH
''                                                             read_RNG_FF_THRESH
''                                                             write_RNG_FF_THRESH
''---------------------------------------------------------------------------------
Class REGISTER_RNG_ff_thres
    Private write_RNG_FF_THRESH_value
    Private read_RNG_FF_THRESH_value
    Private flag_RNG_FF_THRESH

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

    Property Get get_RNG_FF_THRESH
        get_RNG_FF_THRESH = read_RNG_FF_THRESH_value
    End Property

    Property Let set_RNG_FF_THRESH(aData)
        write_RNG_FF_THRESH_value = aData
        flag_RNG_FF_THRESH        = &H1
    End Property

    Property Get read_RNG_FF_THRESH
        read
        read_RNG_FF_THRESH = read_RNG_FF_THRESH_value
    End Property

    Property Let write_RNG_FF_THRESH(aData)
        set_RNG_FF_THRESH = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RNG_FF_THRESH_mask = &H1f
        if data_low > LONG_MAX then
            if RNG_FF_THRESH_mask = mask then
                read_RNG_FF_THRESH_value = data_low
            else
                read_RNG_FF_THRESH_value = (data_low - H8000_0000) and RNG_FF_THRESH_mask
            end If
        else
            read_RNG_FF_THRESH_value = data_low and RNG_FF_THRESH_mask
        end If

    End Sub

    Sub write
        If flag_RNG_FF_THRESH = &H0 Then read
        If flag_RNG_FF_THRESH = &H0 Then write_RNG_FF_THRESH_value = get_RNG_FF_THRESH

        regValue = leftShift((write_RNG_FF_THRESH_value and &H1f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RNG_FF_THRESH_mask = &H1f
        if data_low > LONG_MAX then
            if RNG_FF_THRESH_mask = mask then
                read_RNG_FF_THRESH_value = data_low
            else
                read_RNG_FF_THRESH_value = (data_low - H8000_0000) and RNG_FF_THRESH_mask
            end If
        else
            read_RNG_FF_THRESH_value = data_low and RNG_FF_THRESH_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RNG_FF_THRESH_value = &H0
        flag_RNG_FF_THRESH        = &H0
    End Sub
End Class


'' @REGISTER : RNG_int_mask
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RNG_INT_OFF                                [0:0]            get_RNG_INT_OFF
''                                                             set_RNG_INT_OFF
''                                                             read_RNG_INT_OFF
''                                                             write_RNG_INT_OFF
''---------------------------------------------------------------------------------
Class REGISTER_RNG_int_mask
    Private write_RNG_INT_OFF_value
    Private read_RNG_INT_OFF_value
    Private flag_RNG_INT_OFF

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

    Property Get get_RNG_INT_OFF
        get_RNG_INT_OFF = read_RNG_INT_OFF_value
    End Property

    Property Let set_RNG_INT_OFF(aData)
        write_RNG_INT_OFF_value = aData
        flag_RNG_INT_OFF        = &H1
    End Property

    Property Get read_RNG_INT_OFF
        read
        read_RNG_INT_OFF = read_RNG_INT_OFF_value
    End Property

    Property Let write_RNG_INT_OFF(aData)
        set_RNG_INT_OFF = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RNG_INT_OFF_mask = &H1
        if data_low > LONG_MAX then
            if RNG_INT_OFF_mask = mask then
                read_RNG_INT_OFF_value = data_low
            else
                read_RNG_INT_OFF_value = (data_low - H8000_0000) and RNG_INT_OFF_mask
            end If
        else
            read_RNG_INT_OFF_value = data_low and RNG_INT_OFF_mask
        end If

    End Sub

    Sub write
        If flag_RNG_INT_OFF = &H0 Then read
        If flag_RNG_INT_OFF = &H0 Then write_RNG_INT_OFF_value = get_RNG_INT_OFF

        regValue = leftShift((write_RNG_INT_OFF_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RNG_INT_OFF_mask = &H1
        if data_low > LONG_MAX then
            if RNG_INT_OFF_mask = mask then
                read_RNG_INT_OFF_value = data_low
            else
                read_RNG_INT_OFF_value = (data_low - H8000_0000) and RNG_INT_OFF_mask
            end If
        else
            read_RNG_INT_OFF_value = data_low and RNG_INT_OFF_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RNG_INT_OFF_value = &H0
        flag_RNG_INT_OFF        = &H0
    End Sub
End Class


'' @REGISTER : RNG_ring_tune_1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RING_TUNE_1F                               [23:20]          get_RING_TUNE_1F
''                                                             set_RING_TUNE_1F
''                                                             read_RING_TUNE_1F
''                                                             write_RING_TUNE_1F
''---------------------------------------------------------------------------------
'' RING_TUNE_1E                               [19:16]          get_RING_TUNE_1E
''                                                             set_RING_TUNE_1E
''                                                             read_RING_TUNE_1E
''                                                             write_RING_TUNE_1E
''---------------------------------------------------------------------------------
'' RING_TUNE_1D                               [15:12]          get_RING_TUNE_1D
''                                                             set_RING_TUNE_1D
''                                                             read_RING_TUNE_1D
''                                                             write_RING_TUNE_1D
''---------------------------------------------------------------------------------
'' RING_TUNE_1C                               [11:8]           get_RING_TUNE_1C
''                                                             set_RING_TUNE_1C
''                                                             read_RING_TUNE_1C
''                                                             write_RING_TUNE_1C
''---------------------------------------------------------------------------------
'' RING_TUNE_1B                               [7:4]            get_RING_TUNE_1B
''                                                             set_RING_TUNE_1B
''                                                             read_RING_TUNE_1B
''                                                             write_RING_TUNE_1B
''---------------------------------------------------------------------------------
'' RING_TUNE_1A                               [3:0]            get_RING_TUNE_1A
''                                                             set_RING_TUNE_1A
''                                                             read_RING_TUNE_1A
''                                                             write_RING_TUNE_1A
''---------------------------------------------------------------------------------
Class REGISTER_RNG_ring_tune_1
    Private write_RING_TUNE_1F_value
    Private read_RING_TUNE_1F_value
    Private flag_RING_TUNE_1F
    Private write_RING_TUNE_1E_value
    Private read_RING_TUNE_1E_value
    Private flag_RING_TUNE_1E
    Private write_RING_TUNE_1D_value
    Private read_RING_TUNE_1D_value
    Private flag_RING_TUNE_1D
    Private write_RING_TUNE_1C_value
    Private read_RING_TUNE_1C_value
    Private flag_RING_TUNE_1C
    Private write_RING_TUNE_1B_value
    Private read_RING_TUNE_1B_value
    Private flag_RING_TUNE_1B
    Private write_RING_TUNE_1A_value
    Private read_RING_TUNE_1A_value
    Private flag_RING_TUNE_1A

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

    Property Get get_RING_TUNE_1F
        get_RING_TUNE_1F = read_RING_TUNE_1F_value
    End Property

    Property Let set_RING_TUNE_1F(aData)
        write_RING_TUNE_1F_value = aData
        flag_RING_TUNE_1F        = &H1
    End Property

    Property Get read_RING_TUNE_1F
        read
        read_RING_TUNE_1F = read_RING_TUNE_1F_value
    End Property

    Property Let write_RING_TUNE_1F(aData)
        set_RING_TUNE_1F = aData
        write
    End Property

    Property Get get_RING_TUNE_1E
        get_RING_TUNE_1E = read_RING_TUNE_1E_value
    End Property

    Property Let set_RING_TUNE_1E(aData)
        write_RING_TUNE_1E_value = aData
        flag_RING_TUNE_1E        = &H1
    End Property

    Property Get read_RING_TUNE_1E
        read
        read_RING_TUNE_1E = read_RING_TUNE_1E_value
    End Property

    Property Let write_RING_TUNE_1E(aData)
        set_RING_TUNE_1E = aData
        write
    End Property

    Property Get get_RING_TUNE_1D
        get_RING_TUNE_1D = read_RING_TUNE_1D_value
    End Property

    Property Let set_RING_TUNE_1D(aData)
        write_RING_TUNE_1D_value = aData
        flag_RING_TUNE_1D        = &H1
    End Property

    Property Get read_RING_TUNE_1D
        read
        read_RING_TUNE_1D = read_RING_TUNE_1D_value
    End Property

    Property Let write_RING_TUNE_1D(aData)
        set_RING_TUNE_1D = aData
        write
    End Property

    Property Get get_RING_TUNE_1C
        get_RING_TUNE_1C = read_RING_TUNE_1C_value
    End Property

    Property Let set_RING_TUNE_1C(aData)
        write_RING_TUNE_1C_value = aData
        flag_RING_TUNE_1C        = &H1
    End Property

    Property Get read_RING_TUNE_1C
        read
        read_RING_TUNE_1C = read_RING_TUNE_1C_value
    End Property

    Property Let write_RING_TUNE_1C(aData)
        set_RING_TUNE_1C = aData
        write
    End Property

    Property Get get_RING_TUNE_1B
        get_RING_TUNE_1B = read_RING_TUNE_1B_value
    End Property

    Property Let set_RING_TUNE_1B(aData)
        write_RING_TUNE_1B_value = aData
        flag_RING_TUNE_1B        = &H1
    End Property

    Property Get read_RING_TUNE_1B
        read
        read_RING_TUNE_1B = read_RING_TUNE_1B_value
    End Property

    Property Let write_RING_TUNE_1B(aData)
        set_RING_TUNE_1B = aData
        write
    End Property

    Property Get get_RING_TUNE_1A
        get_RING_TUNE_1A = read_RING_TUNE_1A_value
    End Property

    Property Let set_RING_TUNE_1A(aData)
        write_RING_TUNE_1A_value = aData
        flag_RING_TUNE_1A        = &H1
    End Property

    Property Get read_RING_TUNE_1A
        read
        read_RING_TUNE_1A = read_RING_TUNE_1A_value
    End Property

    Property Let write_RING_TUNE_1A(aData)
        set_RING_TUNE_1A = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RING_TUNE_1F_value = rightShift(data_low, 20) and &Hf
        read_RING_TUNE_1E_value = rightShift(data_low, 16) and &Hf
        read_RING_TUNE_1D_value = rightShift(data_low, 12) and &Hf
        read_RING_TUNE_1C_value = rightShift(data_low, 8) and &Hf
        read_RING_TUNE_1B_value = rightShift(data_low, 4) and &Hf
        RING_TUNE_1A_mask = &Hf
        if data_low > LONG_MAX then
            if RING_TUNE_1A_mask = mask then
                read_RING_TUNE_1A_value = data_low
            else
                read_RING_TUNE_1A_value = (data_low - H8000_0000) and RING_TUNE_1A_mask
            end If
        else
            read_RING_TUNE_1A_value = data_low and RING_TUNE_1A_mask
        end If

    End Sub

    Sub write
        If flag_RING_TUNE_1F = &H0 or flag_RING_TUNE_1E = &H0 or flag_RING_TUNE_1D = &H0 or flag_RING_TUNE_1C = &H0 or flag_RING_TUNE_1B = &H0 or flag_RING_TUNE_1A = &H0 Then read
        If flag_RING_TUNE_1F = &H0 Then write_RING_TUNE_1F_value = get_RING_TUNE_1F
        If flag_RING_TUNE_1E = &H0 Then write_RING_TUNE_1E_value = get_RING_TUNE_1E
        If flag_RING_TUNE_1D = &H0 Then write_RING_TUNE_1D_value = get_RING_TUNE_1D
        If flag_RING_TUNE_1C = &H0 Then write_RING_TUNE_1C_value = get_RING_TUNE_1C
        If flag_RING_TUNE_1B = &H0 Then write_RING_TUNE_1B_value = get_RING_TUNE_1B
        If flag_RING_TUNE_1A = &H0 Then write_RING_TUNE_1A_value = get_RING_TUNE_1A

        regValue = leftShift((write_RING_TUNE_1F_value and &Hf), 20) + leftShift((write_RING_TUNE_1E_value and &Hf), 16) + leftShift((write_RING_TUNE_1D_value and &Hf), 12) + leftShift((write_RING_TUNE_1C_value and &Hf), 8) + leftShift((write_RING_TUNE_1B_value and &Hf), 4) + leftShift((write_RING_TUNE_1A_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RING_TUNE_1F_value = rightShift(data_low, 20) and &Hf
        read_RING_TUNE_1E_value = rightShift(data_low, 16) and &Hf
        read_RING_TUNE_1D_value = rightShift(data_low, 12) and &Hf
        read_RING_TUNE_1C_value = rightShift(data_low, 8) and &Hf
        read_RING_TUNE_1B_value = rightShift(data_low, 4) and &Hf
        RING_TUNE_1A_mask = &Hf
        if data_low > LONG_MAX then
            if RING_TUNE_1A_mask = mask then
                read_RING_TUNE_1A_value = data_low
            else
                read_RING_TUNE_1A_value = (data_low - H8000_0000) and RING_TUNE_1A_mask
            end If
        else
            read_RING_TUNE_1A_value = data_low and RING_TUNE_1A_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RING_TUNE_1F_value = &H0
        flag_RING_TUNE_1F        = &H0
        write_RING_TUNE_1E_value = &H0
        flag_RING_TUNE_1E        = &H0
        write_RING_TUNE_1D_value = &H0
        flag_RING_TUNE_1D        = &H0
        write_RING_TUNE_1C_value = &H0
        flag_RING_TUNE_1C        = &H0
        write_RING_TUNE_1B_value = &H0
        flag_RING_TUNE_1B        = &H0
        write_RING_TUNE_1A_value = &H0
        flag_RING_TUNE_1A        = &H0
    End Sub
End Class


'' @REGISTER : RNG_ring_tune_2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RING_TUNE_2F                               [23:20]          get_RING_TUNE_2F
''                                                             set_RING_TUNE_2F
''                                                             read_RING_TUNE_2F
''                                                             write_RING_TUNE_2F
''---------------------------------------------------------------------------------
'' RING_TUNE_2E                               [19:16]          get_RING_TUNE_2E
''                                                             set_RING_TUNE_2E
''                                                             read_RING_TUNE_2E
''                                                             write_RING_TUNE_2E
''---------------------------------------------------------------------------------
'' RING_TUNE_2D                               [15:12]          get_RING_TUNE_2D
''                                                             set_RING_TUNE_2D
''                                                             read_RING_TUNE_2D
''                                                             write_RING_TUNE_2D
''---------------------------------------------------------------------------------
'' RING_TUNE_2C                               [11:8]           get_RING_TUNE_2C
''                                                             set_RING_TUNE_2C
''                                                             read_RING_TUNE_2C
''                                                             write_RING_TUNE_2C
''---------------------------------------------------------------------------------
'' RING_TUNE_2B                               [7:4]            get_RING_TUNE_2B
''                                                             set_RING_TUNE_2B
''                                                             read_RING_TUNE_2B
''                                                             write_RING_TUNE_2B
''---------------------------------------------------------------------------------
'' RING_TUNE_2A                               [3:0]            get_RING_TUNE_2A
''                                                             set_RING_TUNE_2A
''                                                             read_RING_TUNE_2A
''                                                             write_RING_TUNE_2A
''---------------------------------------------------------------------------------
Class REGISTER_RNG_ring_tune_2
    Private write_RING_TUNE_2F_value
    Private read_RING_TUNE_2F_value
    Private flag_RING_TUNE_2F
    Private write_RING_TUNE_2E_value
    Private read_RING_TUNE_2E_value
    Private flag_RING_TUNE_2E
    Private write_RING_TUNE_2D_value
    Private read_RING_TUNE_2D_value
    Private flag_RING_TUNE_2D
    Private write_RING_TUNE_2C_value
    Private read_RING_TUNE_2C_value
    Private flag_RING_TUNE_2C
    Private write_RING_TUNE_2B_value
    Private read_RING_TUNE_2B_value
    Private flag_RING_TUNE_2B
    Private write_RING_TUNE_2A_value
    Private read_RING_TUNE_2A_value
    Private flag_RING_TUNE_2A

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

    Property Get get_RING_TUNE_2F
        get_RING_TUNE_2F = read_RING_TUNE_2F_value
    End Property

    Property Let set_RING_TUNE_2F(aData)
        write_RING_TUNE_2F_value = aData
        flag_RING_TUNE_2F        = &H1
    End Property

    Property Get read_RING_TUNE_2F
        read
        read_RING_TUNE_2F = read_RING_TUNE_2F_value
    End Property

    Property Let write_RING_TUNE_2F(aData)
        set_RING_TUNE_2F = aData
        write
    End Property

    Property Get get_RING_TUNE_2E
        get_RING_TUNE_2E = read_RING_TUNE_2E_value
    End Property

    Property Let set_RING_TUNE_2E(aData)
        write_RING_TUNE_2E_value = aData
        flag_RING_TUNE_2E        = &H1
    End Property

    Property Get read_RING_TUNE_2E
        read
        read_RING_TUNE_2E = read_RING_TUNE_2E_value
    End Property

    Property Let write_RING_TUNE_2E(aData)
        set_RING_TUNE_2E = aData
        write
    End Property

    Property Get get_RING_TUNE_2D
        get_RING_TUNE_2D = read_RING_TUNE_2D_value
    End Property

    Property Let set_RING_TUNE_2D(aData)
        write_RING_TUNE_2D_value = aData
        flag_RING_TUNE_2D        = &H1
    End Property

    Property Get read_RING_TUNE_2D
        read
        read_RING_TUNE_2D = read_RING_TUNE_2D_value
    End Property

    Property Let write_RING_TUNE_2D(aData)
        set_RING_TUNE_2D = aData
        write
    End Property

    Property Get get_RING_TUNE_2C
        get_RING_TUNE_2C = read_RING_TUNE_2C_value
    End Property

    Property Let set_RING_TUNE_2C(aData)
        write_RING_TUNE_2C_value = aData
        flag_RING_TUNE_2C        = &H1
    End Property

    Property Get read_RING_TUNE_2C
        read
        read_RING_TUNE_2C = read_RING_TUNE_2C_value
    End Property

    Property Let write_RING_TUNE_2C(aData)
        set_RING_TUNE_2C = aData
        write
    End Property

    Property Get get_RING_TUNE_2B
        get_RING_TUNE_2B = read_RING_TUNE_2B_value
    End Property

    Property Let set_RING_TUNE_2B(aData)
        write_RING_TUNE_2B_value = aData
        flag_RING_TUNE_2B        = &H1
    End Property

    Property Get read_RING_TUNE_2B
        read
        read_RING_TUNE_2B = read_RING_TUNE_2B_value
    End Property

    Property Let write_RING_TUNE_2B(aData)
        set_RING_TUNE_2B = aData
        write
    End Property

    Property Get get_RING_TUNE_2A
        get_RING_TUNE_2A = read_RING_TUNE_2A_value
    End Property

    Property Let set_RING_TUNE_2A(aData)
        write_RING_TUNE_2A_value = aData
        flag_RING_TUNE_2A        = &H1
    End Property

    Property Get read_RING_TUNE_2A
        read
        read_RING_TUNE_2A = read_RING_TUNE_2A_value
    End Property

    Property Let write_RING_TUNE_2A(aData)
        set_RING_TUNE_2A = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RING_TUNE_2F_value = rightShift(data_low, 20) and &Hf
        read_RING_TUNE_2E_value = rightShift(data_low, 16) and &Hf
        read_RING_TUNE_2D_value = rightShift(data_low, 12) and &Hf
        read_RING_TUNE_2C_value = rightShift(data_low, 8) and &Hf
        read_RING_TUNE_2B_value = rightShift(data_low, 4) and &Hf
        RING_TUNE_2A_mask = &Hf
        if data_low > LONG_MAX then
            if RING_TUNE_2A_mask = mask then
                read_RING_TUNE_2A_value = data_low
            else
                read_RING_TUNE_2A_value = (data_low - H8000_0000) and RING_TUNE_2A_mask
            end If
        else
            read_RING_TUNE_2A_value = data_low and RING_TUNE_2A_mask
        end If

    End Sub

    Sub write
        If flag_RING_TUNE_2F = &H0 or flag_RING_TUNE_2E = &H0 or flag_RING_TUNE_2D = &H0 or flag_RING_TUNE_2C = &H0 or flag_RING_TUNE_2B = &H0 or flag_RING_TUNE_2A = &H0 Then read
        If flag_RING_TUNE_2F = &H0 Then write_RING_TUNE_2F_value = get_RING_TUNE_2F
        If flag_RING_TUNE_2E = &H0 Then write_RING_TUNE_2E_value = get_RING_TUNE_2E
        If flag_RING_TUNE_2D = &H0 Then write_RING_TUNE_2D_value = get_RING_TUNE_2D
        If flag_RING_TUNE_2C = &H0 Then write_RING_TUNE_2C_value = get_RING_TUNE_2C
        If flag_RING_TUNE_2B = &H0 Then write_RING_TUNE_2B_value = get_RING_TUNE_2B
        If flag_RING_TUNE_2A = &H0 Then write_RING_TUNE_2A_value = get_RING_TUNE_2A

        regValue = leftShift((write_RING_TUNE_2F_value and &Hf), 20) + leftShift((write_RING_TUNE_2E_value and &Hf), 16) + leftShift((write_RING_TUNE_2D_value and &Hf), 12) + leftShift((write_RING_TUNE_2C_value and &Hf), 8) + leftShift((write_RING_TUNE_2B_value and &Hf), 4) + leftShift((write_RING_TUNE_2A_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RING_TUNE_2F_value = rightShift(data_low, 20) and &Hf
        read_RING_TUNE_2E_value = rightShift(data_low, 16) and &Hf
        read_RING_TUNE_2D_value = rightShift(data_low, 12) and &Hf
        read_RING_TUNE_2C_value = rightShift(data_low, 8) and &Hf
        read_RING_TUNE_2B_value = rightShift(data_low, 4) and &Hf
        RING_TUNE_2A_mask = &Hf
        if data_low > LONG_MAX then
            if RING_TUNE_2A_mask = mask then
                read_RING_TUNE_2A_value = data_low
            else
                read_RING_TUNE_2A_value = (data_low - H8000_0000) and RING_TUNE_2A_mask
            end If
        else
            read_RING_TUNE_2A_value = data_low and RING_TUNE_2A_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RING_TUNE_2F_value = &H0
        flag_RING_TUNE_2F        = &H0
        write_RING_TUNE_2E_value = &H0
        flag_RING_TUNE_2E        = &H0
        write_RING_TUNE_2D_value = &H0
        flag_RING_TUNE_2D        = &H0
        write_RING_TUNE_2C_value = &H0
        flag_RING_TUNE_2C        = &H0
        write_RING_TUNE_2B_value = &H0
        flag_RING_TUNE_2B        = &H0
        write_RING_TUNE_2A_value = &H0
        flag_RING_TUNE_2A        = &H0
    End Sub
End Class


'' @REGISTER : RNG_lock
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RNG_COMBLK_OSC_DIS_LOCK                    [3:3]            get_RNG_COMBLK_OSC_DIS_LOCK
''                                                             set_RNG_COMBLK_OSC_DIS_LOCK
''                                                             read_RNG_COMBLK_OSC_DIS_LOCK
''                                                             write_RNG_COMBLK_OSC_DIS_LOCK
''---------------------------------------------------------------------------------
'' RNG_JCLK_BYP_SEL_LOCK                      [2:2]            get_RNG_JCLK_BYP_SEL_LOCK
''                                                             set_RNG_JCLK_BYP_SEL_LOCK
''                                                             read_RNG_JCLK_BYP_SEL_LOCK
''                                                             write_RNG_JCLK_BYP_SEL_LOCK
''---------------------------------------------------------------------------------
'' RING_TUNE_2_LOCK                           [1:1]            get_RING_TUNE_2_LOCK
''                                                             set_RING_TUNE_2_LOCK
''                                                             read_RING_TUNE_2_LOCK
''                                                             write_RING_TUNE_2_LOCK
''---------------------------------------------------------------------------------
'' RING_TUNE_1_LOCK                           [0:0]            get_RING_TUNE_1_LOCK
''                                                             set_RING_TUNE_1_LOCK
''                                                             read_RING_TUNE_1_LOCK
''                                                             write_RING_TUNE_1_LOCK
''---------------------------------------------------------------------------------
Class REGISTER_RNG_lock
    Private write_RNG_COMBLK_OSC_DIS_LOCK_value
    Private read_RNG_COMBLK_OSC_DIS_LOCK_value
    Private flag_RNG_COMBLK_OSC_DIS_LOCK
    Private write_RNG_JCLK_BYP_SEL_LOCK_value
    Private read_RNG_JCLK_BYP_SEL_LOCK_value
    Private flag_RNG_JCLK_BYP_SEL_LOCK
    Private write_RING_TUNE_2_LOCK_value
    Private read_RING_TUNE_2_LOCK_value
    Private flag_RING_TUNE_2_LOCK
    Private write_RING_TUNE_1_LOCK_value
    Private read_RING_TUNE_1_LOCK_value
    Private flag_RING_TUNE_1_LOCK

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

    Property Get get_RNG_COMBLK_OSC_DIS_LOCK
        get_RNG_COMBLK_OSC_DIS_LOCK = read_RNG_COMBLK_OSC_DIS_LOCK_value
    End Property

    Property Let set_RNG_COMBLK_OSC_DIS_LOCK(aData)
        write_RNG_COMBLK_OSC_DIS_LOCK_value = aData
        flag_RNG_COMBLK_OSC_DIS_LOCK        = &H1
    End Property

    Property Get read_RNG_COMBLK_OSC_DIS_LOCK
        read
        read_RNG_COMBLK_OSC_DIS_LOCK = read_RNG_COMBLK_OSC_DIS_LOCK_value
    End Property

    Property Let write_RNG_COMBLK_OSC_DIS_LOCK(aData)
        set_RNG_COMBLK_OSC_DIS_LOCK = aData
        write
    End Property

    Property Get get_RNG_JCLK_BYP_SEL_LOCK
        get_RNG_JCLK_BYP_SEL_LOCK = read_RNG_JCLK_BYP_SEL_LOCK_value
    End Property

    Property Let set_RNG_JCLK_BYP_SEL_LOCK(aData)
        write_RNG_JCLK_BYP_SEL_LOCK_value = aData
        flag_RNG_JCLK_BYP_SEL_LOCK        = &H1
    End Property

    Property Get read_RNG_JCLK_BYP_SEL_LOCK
        read
        read_RNG_JCLK_BYP_SEL_LOCK = read_RNG_JCLK_BYP_SEL_LOCK_value
    End Property

    Property Let write_RNG_JCLK_BYP_SEL_LOCK(aData)
        set_RNG_JCLK_BYP_SEL_LOCK = aData
        write
    End Property

    Property Get get_RING_TUNE_2_LOCK
        get_RING_TUNE_2_LOCK = read_RING_TUNE_2_LOCK_value
    End Property

    Property Let set_RING_TUNE_2_LOCK(aData)
        write_RING_TUNE_2_LOCK_value = aData
        flag_RING_TUNE_2_LOCK        = &H1
    End Property

    Property Get read_RING_TUNE_2_LOCK
        read
        read_RING_TUNE_2_LOCK = read_RING_TUNE_2_LOCK_value
    End Property

    Property Let write_RING_TUNE_2_LOCK(aData)
        set_RING_TUNE_2_LOCK = aData
        write
    End Property

    Property Get get_RING_TUNE_1_LOCK
        get_RING_TUNE_1_LOCK = read_RING_TUNE_1_LOCK_value
    End Property

    Property Let set_RING_TUNE_1_LOCK(aData)
        write_RING_TUNE_1_LOCK_value = aData
        flag_RING_TUNE_1_LOCK        = &H1
    End Property

    Property Get read_RING_TUNE_1_LOCK
        read
        read_RING_TUNE_1_LOCK = read_RING_TUNE_1_LOCK_value
    End Property

    Property Let write_RING_TUNE_1_LOCK(aData)
        set_RING_TUNE_1_LOCK = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RNG_COMBLK_OSC_DIS_LOCK_value = rightShift(data_low, 3) and &H1
        read_RNG_JCLK_BYP_SEL_LOCK_value = rightShift(data_low, 2) and &H1
        read_RING_TUNE_2_LOCK_value = rightShift(data_low, 1) and &H1
        RING_TUNE_1_LOCK_mask = &H1
        if data_low > LONG_MAX then
            if RING_TUNE_1_LOCK_mask = mask then
                read_RING_TUNE_1_LOCK_value = data_low
            else
                read_RING_TUNE_1_LOCK_value = (data_low - H8000_0000) and RING_TUNE_1_LOCK_mask
            end If
        else
            read_RING_TUNE_1_LOCK_value = data_low and RING_TUNE_1_LOCK_mask
        end If

    End Sub

    Sub write
        If flag_RNG_COMBLK_OSC_DIS_LOCK = &H0 or flag_RNG_JCLK_BYP_SEL_LOCK = &H0 or flag_RING_TUNE_2_LOCK = &H0 or flag_RING_TUNE_1_LOCK = &H0 Then read
        If flag_RNG_COMBLK_OSC_DIS_LOCK = &H0 Then write_RNG_COMBLK_OSC_DIS_LOCK_value = get_RNG_COMBLK_OSC_DIS_LOCK
        If flag_RNG_JCLK_BYP_SEL_LOCK = &H0 Then write_RNG_JCLK_BYP_SEL_LOCK_value = get_RNG_JCLK_BYP_SEL_LOCK
        If flag_RING_TUNE_2_LOCK = &H0 Then write_RING_TUNE_2_LOCK_value = get_RING_TUNE_2_LOCK
        If flag_RING_TUNE_1_LOCK = &H0 Then write_RING_TUNE_1_LOCK_value = get_RING_TUNE_1_LOCK

        regValue = leftShift((write_RNG_COMBLK_OSC_DIS_LOCK_value and &H1), 3) + leftShift((write_RNG_JCLK_BYP_SEL_LOCK_value and &H1), 2) + leftShift((write_RING_TUNE_2_LOCK_value and &H1), 1) + leftShift((write_RING_TUNE_1_LOCK_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RNG_COMBLK_OSC_DIS_LOCK_value = rightShift(data_low, 3) and &H1
        read_RNG_JCLK_BYP_SEL_LOCK_value = rightShift(data_low, 2) and &H1
        read_RING_TUNE_2_LOCK_value = rightShift(data_low, 1) and &H1
        RING_TUNE_1_LOCK_mask = &H1
        if data_low > LONG_MAX then
            if RING_TUNE_1_LOCK_mask = mask then
                read_RING_TUNE_1_LOCK_value = data_low
            else
                read_RING_TUNE_1_LOCK_value = (data_low - H8000_0000) and RING_TUNE_1_LOCK_mask
            end If
        else
            read_RING_TUNE_1_LOCK_value = data_low and RING_TUNE_1_LOCK_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RNG_COMBLK_OSC_DIS_LOCK_value = &H0
        flag_RNG_COMBLK_OSC_DIS_LOCK        = &H0
        write_RNG_JCLK_BYP_SEL_LOCK_value = &H0
        flag_RNG_JCLK_BYP_SEL_LOCK        = &H0
        write_RING_TUNE_2_LOCK_value = &H0
        flag_RING_TUNE_2_LOCK        = &H0
        write_RING_TUNE_1_LOCK_value = &H0
        flag_RING_TUNE_1_LOCK        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class RNG_INSTANCE

    Public ctrl
    Public status
    Public data
    Public ff_thres
    Public int_mask
    Public ring_tune_1
    Public ring_tune_2
    Public lock


    Public default function Init(aBaseAddr)
        Set ctrl = (New REGISTER_RNG_ctrl)(aBaseAddr, 32)
        Set status = (New REGISTER_RNG_status)(aBaseAddr, 32)
        Set data = (New REGISTER_RNG_data)(aBaseAddr, 32)
        Set ff_thres = (New REGISTER_RNG_ff_thres)(aBaseAddr, 32)
        Set int_mask = (New REGISTER_RNG_int_mask)(aBaseAddr, 32)
        Set ring_tune_1 = (New REGISTER_RNG_ring_tune_1)(aBaseAddr, 32)
        Set ring_tune_2 = (New REGISTER_RNG_ring_tune_2)(aBaseAddr, 32)
        Set lock = (New REGISTER_RNG_lock)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set RNG = CreateObject("System.Collections.ArrayList")
RNG.Add ((New RNG_INSTANCE)(&H4c011000))


