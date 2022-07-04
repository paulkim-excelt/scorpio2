

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


'' @REGISTER : DSP_TOP_dagc_status_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DAGC_ACCUM                                 [15:0]           get_DAGC_ACCUM
''                                                             set_DAGC_ACCUM
''                                                             read_DAGC_ACCUM
''                                                             write_DAGC_ACCUM
''---------------------------------------------------------------------------------
Class REGISTER_DSP_TOP_dagc_status_0
    Private write_DAGC_ACCUM_value
    Private read_DAGC_ACCUM_value
    Private flag_DAGC_ACCUM

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

    Property Get get_DAGC_ACCUM
        get_DAGC_ACCUM = read_DAGC_ACCUM_value
    End Property

    Property Let set_DAGC_ACCUM(aData)
        write_DAGC_ACCUM_value = aData
        flag_DAGC_ACCUM        = &H1
    End Property

    Property Get read_DAGC_ACCUM
        read
        read_DAGC_ACCUM = read_DAGC_ACCUM_value
    End Property

    Property Let write_DAGC_ACCUM(aData)
        set_DAGC_ACCUM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DAGC_ACCUM_mask = &Hffff
        if data_low > LONG_MAX then
            if DAGC_ACCUM_mask = mask then
                read_DAGC_ACCUM_value = data_low
            else
                read_DAGC_ACCUM_value = (data_low - H8000_0000) and DAGC_ACCUM_mask
            end If
        else
            read_DAGC_ACCUM_value = data_low and DAGC_ACCUM_mask
        end If

    End Sub

    Sub write
        If flag_DAGC_ACCUM = &H0 Then read
        If flag_DAGC_ACCUM = &H0 Then write_DAGC_ACCUM_value = get_DAGC_ACCUM

        regValue = leftShift((write_DAGC_ACCUM_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DAGC_ACCUM_mask = &Hffff
        if data_low > LONG_MAX then
            if DAGC_ACCUM_mask = mask then
                read_DAGC_ACCUM_value = data_low
            else
                read_DAGC_ACCUM_value = (data_low - H8000_0000) and DAGC_ACCUM_mask
            end If
        else
            read_DAGC_ACCUM_value = data_low and DAGC_ACCUM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DAGC_ACCUM_value = &H0
        flag_DAGC_ACCUM        = &H0
    End Sub
End Class


'' @REGISTER : DSP_TOP_dagc_status_1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DAGC_ACCUM_RND                             [8:0]            get_DAGC_ACCUM_RND
''                                                             set_DAGC_ACCUM_RND
''                                                             read_DAGC_ACCUM_RND
''                                                             write_DAGC_ACCUM_RND
''---------------------------------------------------------------------------------
Class REGISTER_DSP_TOP_dagc_status_1
    Private write_DAGC_ACCUM_RND_value
    Private read_DAGC_ACCUM_RND_value
    Private flag_DAGC_ACCUM_RND

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

    Property Get get_DAGC_ACCUM_RND
        get_DAGC_ACCUM_RND = read_DAGC_ACCUM_RND_value
    End Property

    Property Let set_DAGC_ACCUM_RND(aData)
        write_DAGC_ACCUM_RND_value = aData
        flag_DAGC_ACCUM_RND        = &H1
    End Property

    Property Get read_DAGC_ACCUM_RND
        read
        read_DAGC_ACCUM_RND = read_DAGC_ACCUM_RND_value
    End Property

    Property Let write_DAGC_ACCUM_RND(aData)
        set_DAGC_ACCUM_RND = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DAGC_ACCUM_RND_mask = &H1ff
        if data_low > LONG_MAX then
            if DAGC_ACCUM_RND_mask = mask then
                read_DAGC_ACCUM_RND_value = data_low
            else
                read_DAGC_ACCUM_RND_value = (data_low - H8000_0000) and DAGC_ACCUM_RND_mask
            end If
        else
            read_DAGC_ACCUM_RND_value = data_low and DAGC_ACCUM_RND_mask
        end If

    End Sub

    Sub write
        If flag_DAGC_ACCUM_RND = &H0 Then read
        If flag_DAGC_ACCUM_RND = &H0 Then write_DAGC_ACCUM_RND_value = get_DAGC_ACCUM_RND

        regValue = leftShift((write_DAGC_ACCUM_RND_value and &H1ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DAGC_ACCUM_RND_mask = &H1ff
        if data_low > LONG_MAX then
            if DAGC_ACCUM_RND_mask = mask then
                read_DAGC_ACCUM_RND_value = data_low
            else
                read_DAGC_ACCUM_RND_value = (data_low - H8000_0000) and DAGC_ACCUM_RND_mask
            end If
        else
            read_DAGC_ACCUM_RND_value = data_low and DAGC_ACCUM_RND_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DAGC_ACCUM_RND_value = &H0
        flag_DAGC_ACCUM_RND        = &H0
    End Sub
End Class


'' @REGISTER : DSP_TOP_soft_decision_even
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SOFT_DECISION                              [15:0]           get_SOFT_DECISION
''                                                             set_SOFT_DECISION
''                                                             read_SOFT_DECISION
''                                                             write_SOFT_DECISION
''---------------------------------------------------------------------------------
Class REGISTER_DSP_TOP_soft_decision_even
    Private write_SOFT_DECISION_value
    Private read_SOFT_DECISION_value
    Private flag_SOFT_DECISION

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

    Property Get get_SOFT_DECISION
        get_SOFT_DECISION = read_SOFT_DECISION_value
    End Property

    Property Let set_SOFT_DECISION(aData)
        write_SOFT_DECISION_value = aData
        flag_SOFT_DECISION        = &H1
    End Property

    Property Get read_SOFT_DECISION
        read
        read_SOFT_DECISION = read_SOFT_DECISION_value
    End Property

    Property Let write_SOFT_DECISION(aData)
        set_SOFT_DECISION = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SOFT_DECISION_mask = &Hffff
        if data_low > LONG_MAX then
            if SOFT_DECISION_mask = mask then
                read_SOFT_DECISION_value = data_low
            else
                read_SOFT_DECISION_value = (data_low - H8000_0000) and SOFT_DECISION_mask
            end If
        else
            read_SOFT_DECISION_value = data_low and SOFT_DECISION_mask
        end If

    End Sub

    Sub write
        If flag_SOFT_DECISION = &H0 Then read
        If flag_SOFT_DECISION = &H0 Then write_SOFT_DECISION_value = get_SOFT_DECISION

        regValue = leftShift((write_SOFT_DECISION_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SOFT_DECISION_mask = &Hffff
        if data_low > LONG_MAX then
            if SOFT_DECISION_mask = mask then
                read_SOFT_DECISION_value = data_low
            else
                read_SOFT_DECISION_value = (data_low - H8000_0000) and SOFT_DECISION_mask
            end If
        else
            read_SOFT_DECISION_value = data_low and SOFT_DECISION_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SOFT_DECISION_value = &H0
        flag_SOFT_DECISION        = &H0
    End Sub
End Class


'' @REGISTER : DSP_TOP_soft_decision_odd
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SOFT_DECISION                              [15:0]           get_SOFT_DECISION
''                                                             set_SOFT_DECISION
''                                                             read_SOFT_DECISION
''                                                             write_SOFT_DECISION
''---------------------------------------------------------------------------------
Class REGISTER_DSP_TOP_soft_decision_odd
    Private write_SOFT_DECISION_value
    Private read_SOFT_DECISION_value
    Private flag_SOFT_DECISION

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

    Property Get get_SOFT_DECISION
        get_SOFT_DECISION = read_SOFT_DECISION_value
    End Property

    Property Let set_SOFT_DECISION(aData)
        write_SOFT_DECISION_value = aData
        flag_SOFT_DECISION        = &H1
    End Property

    Property Get read_SOFT_DECISION
        read
        read_SOFT_DECISION = read_SOFT_DECISION_value
    End Property

    Property Let write_SOFT_DECISION(aData)
        set_SOFT_DECISION = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SOFT_DECISION_mask = &Hffff
        if data_low > LONG_MAX then
            if SOFT_DECISION_mask = mask then
                read_SOFT_DECISION_value = data_low
            else
                read_SOFT_DECISION_value = (data_low - H8000_0000) and SOFT_DECISION_mask
            end If
        else
            read_SOFT_DECISION_value = data_low and SOFT_DECISION_mask
        end If

    End Sub

    Sub write
        If flag_SOFT_DECISION = &H0 Then read
        If flag_SOFT_DECISION = &H0 Then write_SOFT_DECISION_value = get_SOFT_DECISION

        regValue = leftShift((write_SOFT_DECISION_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SOFT_DECISION_mask = &Hffff
        if data_low > LONG_MAX then
            if SOFT_DECISION_mask = mask then
                read_SOFT_DECISION_value = data_low
            else
                read_SOFT_DECISION_value = (data_low - H8000_0000) and SOFT_DECISION_mask
            end If
        else
            read_SOFT_DECISION_value = data_low and SOFT_DECISION_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SOFT_DECISION_value = &H0
        flag_SOFT_DECISION        = &H0
    End Sub
End Class


'' @REGISTER : DSP_TOP_agc_ref_lvl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' AGC_REF_LVL                                [8:0]            get_AGC_REF_LVL
''                                                             set_AGC_REF_LVL
''                                                             read_AGC_REF_LVL
''                                                             write_AGC_REF_LVL
''---------------------------------------------------------------------------------
Class REGISTER_DSP_TOP_agc_ref_lvl
    Private write_AGC_REF_LVL_value
    Private read_AGC_REF_LVL_value
    Private flag_AGC_REF_LVL

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

    Property Get get_AGC_REF_LVL
        get_AGC_REF_LVL = read_AGC_REF_LVL_value
    End Property

    Property Let set_AGC_REF_LVL(aData)
        write_AGC_REF_LVL_value = aData
        flag_AGC_REF_LVL        = &H1
    End Property

    Property Get read_AGC_REF_LVL
        read
        read_AGC_REF_LVL = read_AGC_REF_LVL_value
    End Property

    Property Let write_AGC_REF_LVL(aData)
        set_AGC_REF_LVL = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        AGC_REF_LVL_mask = &H1ff
        if data_low > LONG_MAX then
            if AGC_REF_LVL_mask = mask then
                read_AGC_REF_LVL_value = data_low
            else
                read_AGC_REF_LVL_value = (data_low - H8000_0000) and AGC_REF_LVL_mask
            end If
        else
            read_AGC_REF_LVL_value = data_low and AGC_REF_LVL_mask
        end If

    End Sub

    Sub write
        If flag_AGC_REF_LVL = &H0 Then read
        If flag_AGC_REF_LVL = &H0 Then write_AGC_REF_LVL_value = get_AGC_REF_LVL

        regValue = leftShift((write_AGC_REF_LVL_value and &H1ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        AGC_REF_LVL_mask = &H1ff
        if data_low > LONG_MAX then
            if AGC_REF_LVL_mask = mask then
                read_AGC_REF_LVL_value = data_low
            else
                read_AGC_REF_LVL_value = (data_low - H8000_0000) and AGC_REF_LVL_mask
            end If
        else
            read_AGC_REF_LVL_value = data_low and AGC_REF_LVL_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_AGC_REF_LVL_value = &H0
        flag_AGC_REF_LVL        = &H0
    End Sub
End Class


'' @REGISTER : DSP_TOP_agc_override_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' FAGC_SKIP_DIS                              [14:14]          get_FAGC_SKIP_DIS
''                                                             set_FAGC_SKIP_DIS
''                                                             read_FAGC_SKIP_DIS
''                                                             write_FAGC_SKIP_DIS
''---------------------------------------------------------------------------------
'' FAGC_ERR_MULT                              [13:12]          get_FAGC_ERR_MULT
''                                                             set_FAGC_ERR_MULT
''                                                             read_FAGC_ERR_MULT
''                                                             write_FAGC_ERR_MULT
''---------------------------------------------------------------------------------
'' FAGCHIGEAR_OVR_VAL                         [11:11]          get_FAGCHIGEAR_OVR_VAL
''                                                             set_FAGCHIGEAR_OVR_VAL
''                                                             read_FAGCHIGEAR_OVR_VAL
''                                                             write_FAGCHIGEAR_OVR_VAL
''---------------------------------------------------------------------------------
'' FAGCHIGEAR_OVR                             [10:10]          get_FAGCHIGEAR_OVR
''                                                             set_FAGCHIGEAR_OVR
''                                                             read_FAGCHIGEAR_OVR
''                                                             write_FAGCHIGEAR_OVR
''---------------------------------------------------------------------------------
'' CAGCHIGEAR_OVR_VAL                         [9:9]            get_CAGCHIGEAR_OVR_VAL
''                                                             set_CAGCHIGEAR_OVR_VAL
''                                                             read_CAGCHIGEAR_OVR_VAL
''                                                             write_CAGCHIGEAR_OVR_VAL
''---------------------------------------------------------------------------------
'' CAGCHIGEAR_OVR                             [8:8]            get_CAGCHIGEAR_OVR
''                                                             set_CAGCHIGEAR_OVR
''                                                             read_CAGCHIGEAR_OVR
''                                                             write_CAGCHIGEAR_OVR
''---------------------------------------------------------------------------------
'' CAGCFRZ_OVR_VAL                            [7:7]            get_CAGCFRZ_OVR_VAL
''                                                             set_CAGCFRZ_OVR_VAL
''                                                             read_CAGCFRZ_OVR_VAL
''                                                             write_CAGCFRZ_OVR_VAL
''---------------------------------------------------------------------------------
'' CAGCFRZ_OVR                                [6:6]            get_CAGCFRZ_OVR
''                                                             set_CAGCFRZ_OVR
''                                                             read_CAGCFRZ_OVR
''                                                             write_CAGCFRZ_OVR
''---------------------------------------------------------------------------------
'' CAGCRST_OVR_VAL                            [5:5]            get_CAGCRST_OVR_VAL
''                                                             set_CAGCRST_OVR_VAL
''                                                             read_CAGCRST_OVR_VAL
''                                                             write_CAGCRST_OVR_VAL
''---------------------------------------------------------------------------------
'' CAGCRST_OVR                                [4:4]            get_CAGCRST_OVR
''                                                             set_CAGCRST_OVR
''                                                             read_CAGCRST_OVR
''                                                             write_CAGCRST_OVR
''---------------------------------------------------------------------------------
'' FAGCFRZ_OVR_VAL                            [3:3]            get_FAGCFRZ_OVR_VAL
''                                                             set_FAGCFRZ_OVR_VAL
''                                                             read_FAGCFRZ_OVR_VAL
''                                                             write_FAGCFRZ_OVR_VAL
''---------------------------------------------------------------------------------
'' FAGCFRZ_OVR                                [2:2]            get_FAGCFRZ_OVR
''                                                             set_FAGCFRZ_OVR
''                                                             read_FAGCFRZ_OVR
''                                                             write_FAGCFRZ_OVR
''---------------------------------------------------------------------------------
'' FAGCRST_OVR_VAL                            [1:1]            get_FAGCRST_OVR_VAL
''                                                             set_FAGCRST_OVR_VAL
''                                                             read_FAGCRST_OVR_VAL
''                                                             write_FAGCRST_OVR_VAL
''---------------------------------------------------------------------------------
'' FAGCRST_OVR                                [0:0]            get_FAGCRST_OVR
''                                                             set_FAGCRST_OVR
''                                                             read_FAGCRST_OVR
''                                                             write_FAGCRST_OVR
''---------------------------------------------------------------------------------
Class REGISTER_DSP_TOP_agc_override_0
    Private write_FAGC_SKIP_DIS_value
    Private read_FAGC_SKIP_DIS_value
    Private flag_FAGC_SKIP_DIS
    Private write_FAGC_ERR_MULT_value
    Private read_FAGC_ERR_MULT_value
    Private flag_FAGC_ERR_MULT
    Private write_FAGCHIGEAR_OVR_VAL_value
    Private read_FAGCHIGEAR_OVR_VAL_value
    Private flag_FAGCHIGEAR_OVR_VAL
    Private write_FAGCHIGEAR_OVR_value
    Private read_FAGCHIGEAR_OVR_value
    Private flag_FAGCHIGEAR_OVR
    Private write_CAGCHIGEAR_OVR_VAL_value
    Private read_CAGCHIGEAR_OVR_VAL_value
    Private flag_CAGCHIGEAR_OVR_VAL
    Private write_CAGCHIGEAR_OVR_value
    Private read_CAGCHIGEAR_OVR_value
    Private flag_CAGCHIGEAR_OVR
    Private write_CAGCFRZ_OVR_VAL_value
    Private read_CAGCFRZ_OVR_VAL_value
    Private flag_CAGCFRZ_OVR_VAL
    Private write_CAGCFRZ_OVR_value
    Private read_CAGCFRZ_OVR_value
    Private flag_CAGCFRZ_OVR
    Private write_CAGCRST_OVR_VAL_value
    Private read_CAGCRST_OVR_VAL_value
    Private flag_CAGCRST_OVR_VAL
    Private write_CAGCRST_OVR_value
    Private read_CAGCRST_OVR_value
    Private flag_CAGCRST_OVR
    Private write_FAGCFRZ_OVR_VAL_value
    Private read_FAGCFRZ_OVR_VAL_value
    Private flag_FAGCFRZ_OVR_VAL
    Private write_FAGCFRZ_OVR_value
    Private read_FAGCFRZ_OVR_value
    Private flag_FAGCFRZ_OVR
    Private write_FAGCRST_OVR_VAL_value
    Private read_FAGCRST_OVR_VAL_value
    Private flag_FAGCRST_OVR_VAL
    Private write_FAGCRST_OVR_value
    Private read_FAGCRST_OVR_value
    Private flag_FAGCRST_OVR

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

    Property Get get_FAGC_SKIP_DIS
        get_FAGC_SKIP_DIS = read_FAGC_SKIP_DIS_value
    End Property

    Property Let set_FAGC_SKIP_DIS(aData)
        write_FAGC_SKIP_DIS_value = aData
        flag_FAGC_SKIP_DIS        = &H1
    End Property

    Property Get read_FAGC_SKIP_DIS
        read
        read_FAGC_SKIP_DIS = read_FAGC_SKIP_DIS_value
    End Property

    Property Let write_FAGC_SKIP_DIS(aData)
        set_FAGC_SKIP_DIS = aData
        write
    End Property

    Property Get get_FAGC_ERR_MULT
        get_FAGC_ERR_MULT = read_FAGC_ERR_MULT_value
    End Property

    Property Let set_FAGC_ERR_MULT(aData)
        write_FAGC_ERR_MULT_value = aData
        flag_FAGC_ERR_MULT        = &H1
    End Property

    Property Get read_FAGC_ERR_MULT
        read
        read_FAGC_ERR_MULT = read_FAGC_ERR_MULT_value
    End Property

    Property Let write_FAGC_ERR_MULT(aData)
        set_FAGC_ERR_MULT = aData
        write
    End Property

    Property Get get_FAGCHIGEAR_OVR_VAL
        get_FAGCHIGEAR_OVR_VAL = read_FAGCHIGEAR_OVR_VAL_value
    End Property

    Property Let set_FAGCHIGEAR_OVR_VAL(aData)
        write_FAGCHIGEAR_OVR_VAL_value = aData
        flag_FAGCHIGEAR_OVR_VAL        = &H1
    End Property

    Property Get read_FAGCHIGEAR_OVR_VAL
        read
        read_FAGCHIGEAR_OVR_VAL = read_FAGCHIGEAR_OVR_VAL_value
    End Property

    Property Let write_FAGCHIGEAR_OVR_VAL(aData)
        set_FAGCHIGEAR_OVR_VAL = aData
        write
    End Property

    Property Get get_FAGCHIGEAR_OVR
        get_FAGCHIGEAR_OVR = read_FAGCHIGEAR_OVR_value
    End Property

    Property Let set_FAGCHIGEAR_OVR(aData)
        write_FAGCHIGEAR_OVR_value = aData
        flag_FAGCHIGEAR_OVR        = &H1
    End Property

    Property Get read_FAGCHIGEAR_OVR
        read
        read_FAGCHIGEAR_OVR = read_FAGCHIGEAR_OVR_value
    End Property

    Property Let write_FAGCHIGEAR_OVR(aData)
        set_FAGCHIGEAR_OVR = aData
        write
    End Property

    Property Get get_CAGCHIGEAR_OVR_VAL
        get_CAGCHIGEAR_OVR_VAL = read_CAGCHIGEAR_OVR_VAL_value
    End Property

    Property Let set_CAGCHIGEAR_OVR_VAL(aData)
        write_CAGCHIGEAR_OVR_VAL_value = aData
        flag_CAGCHIGEAR_OVR_VAL        = &H1
    End Property

    Property Get read_CAGCHIGEAR_OVR_VAL
        read
        read_CAGCHIGEAR_OVR_VAL = read_CAGCHIGEAR_OVR_VAL_value
    End Property

    Property Let write_CAGCHIGEAR_OVR_VAL(aData)
        set_CAGCHIGEAR_OVR_VAL = aData
        write
    End Property

    Property Get get_CAGCHIGEAR_OVR
        get_CAGCHIGEAR_OVR = read_CAGCHIGEAR_OVR_value
    End Property

    Property Let set_CAGCHIGEAR_OVR(aData)
        write_CAGCHIGEAR_OVR_value = aData
        flag_CAGCHIGEAR_OVR        = &H1
    End Property

    Property Get read_CAGCHIGEAR_OVR
        read
        read_CAGCHIGEAR_OVR = read_CAGCHIGEAR_OVR_value
    End Property

    Property Let write_CAGCHIGEAR_OVR(aData)
        set_CAGCHIGEAR_OVR = aData
        write
    End Property

    Property Get get_CAGCFRZ_OVR_VAL
        get_CAGCFRZ_OVR_VAL = read_CAGCFRZ_OVR_VAL_value
    End Property

    Property Let set_CAGCFRZ_OVR_VAL(aData)
        write_CAGCFRZ_OVR_VAL_value = aData
        flag_CAGCFRZ_OVR_VAL        = &H1
    End Property

    Property Get read_CAGCFRZ_OVR_VAL
        read
        read_CAGCFRZ_OVR_VAL = read_CAGCFRZ_OVR_VAL_value
    End Property

    Property Let write_CAGCFRZ_OVR_VAL(aData)
        set_CAGCFRZ_OVR_VAL = aData
        write
    End Property

    Property Get get_CAGCFRZ_OVR
        get_CAGCFRZ_OVR = read_CAGCFRZ_OVR_value
    End Property

    Property Let set_CAGCFRZ_OVR(aData)
        write_CAGCFRZ_OVR_value = aData
        flag_CAGCFRZ_OVR        = &H1
    End Property

    Property Get read_CAGCFRZ_OVR
        read
        read_CAGCFRZ_OVR = read_CAGCFRZ_OVR_value
    End Property

    Property Let write_CAGCFRZ_OVR(aData)
        set_CAGCFRZ_OVR = aData
        write
    End Property

    Property Get get_CAGCRST_OVR_VAL
        get_CAGCRST_OVR_VAL = read_CAGCRST_OVR_VAL_value
    End Property

    Property Let set_CAGCRST_OVR_VAL(aData)
        write_CAGCRST_OVR_VAL_value = aData
        flag_CAGCRST_OVR_VAL        = &H1
    End Property

    Property Get read_CAGCRST_OVR_VAL
        read
        read_CAGCRST_OVR_VAL = read_CAGCRST_OVR_VAL_value
    End Property

    Property Let write_CAGCRST_OVR_VAL(aData)
        set_CAGCRST_OVR_VAL = aData
        write
    End Property

    Property Get get_CAGCRST_OVR
        get_CAGCRST_OVR = read_CAGCRST_OVR_value
    End Property

    Property Let set_CAGCRST_OVR(aData)
        write_CAGCRST_OVR_value = aData
        flag_CAGCRST_OVR        = &H1
    End Property

    Property Get read_CAGCRST_OVR
        read
        read_CAGCRST_OVR = read_CAGCRST_OVR_value
    End Property

    Property Let write_CAGCRST_OVR(aData)
        set_CAGCRST_OVR = aData
        write
    End Property

    Property Get get_FAGCFRZ_OVR_VAL
        get_FAGCFRZ_OVR_VAL = read_FAGCFRZ_OVR_VAL_value
    End Property

    Property Let set_FAGCFRZ_OVR_VAL(aData)
        write_FAGCFRZ_OVR_VAL_value = aData
        flag_FAGCFRZ_OVR_VAL        = &H1
    End Property

    Property Get read_FAGCFRZ_OVR_VAL
        read
        read_FAGCFRZ_OVR_VAL = read_FAGCFRZ_OVR_VAL_value
    End Property

    Property Let write_FAGCFRZ_OVR_VAL(aData)
        set_FAGCFRZ_OVR_VAL = aData
        write
    End Property

    Property Get get_FAGCFRZ_OVR
        get_FAGCFRZ_OVR = read_FAGCFRZ_OVR_value
    End Property

    Property Let set_FAGCFRZ_OVR(aData)
        write_FAGCFRZ_OVR_value = aData
        flag_FAGCFRZ_OVR        = &H1
    End Property

    Property Get read_FAGCFRZ_OVR
        read
        read_FAGCFRZ_OVR = read_FAGCFRZ_OVR_value
    End Property

    Property Let write_FAGCFRZ_OVR(aData)
        set_FAGCFRZ_OVR = aData
        write
    End Property

    Property Get get_FAGCRST_OVR_VAL
        get_FAGCRST_OVR_VAL = read_FAGCRST_OVR_VAL_value
    End Property

    Property Let set_FAGCRST_OVR_VAL(aData)
        write_FAGCRST_OVR_VAL_value = aData
        flag_FAGCRST_OVR_VAL        = &H1
    End Property

    Property Get read_FAGCRST_OVR_VAL
        read
        read_FAGCRST_OVR_VAL = read_FAGCRST_OVR_VAL_value
    End Property

    Property Let write_FAGCRST_OVR_VAL(aData)
        set_FAGCRST_OVR_VAL = aData
        write
    End Property

    Property Get get_FAGCRST_OVR
        get_FAGCRST_OVR = read_FAGCRST_OVR_value
    End Property

    Property Let set_FAGCRST_OVR(aData)
        write_FAGCRST_OVR_value = aData
        flag_FAGCRST_OVR        = &H1
    End Property

    Property Get read_FAGCRST_OVR
        read
        read_FAGCRST_OVR = read_FAGCRST_OVR_value
    End Property

    Property Let write_FAGCRST_OVR(aData)
        set_FAGCRST_OVR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_FAGC_SKIP_DIS_value = rightShift(data_low, 14) and &H1
        read_FAGC_ERR_MULT_value = rightShift(data_low, 12) and &H3
        read_FAGCHIGEAR_OVR_VAL_value = rightShift(data_low, 11) and &H1
        read_FAGCHIGEAR_OVR_value = rightShift(data_low, 10) and &H1
        read_CAGCHIGEAR_OVR_VAL_value = rightShift(data_low, 9) and &H1
        read_CAGCHIGEAR_OVR_value = rightShift(data_low, 8) and &H1
        read_CAGCFRZ_OVR_VAL_value = rightShift(data_low, 7) and &H1
        read_CAGCFRZ_OVR_value = rightShift(data_low, 6) and &H1
        read_CAGCRST_OVR_VAL_value = rightShift(data_low, 5) and &H1
        read_CAGCRST_OVR_value = rightShift(data_low, 4) and &H1
        read_FAGCFRZ_OVR_VAL_value = rightShift(data_low, 3) and &H1
        read_FAGCFRZ_OVR_value = rightShift(data_low, 2) and &H1
        read_FAGCRST_OVR_VAL_value = rightShift(data_low, 1) and &H1
        FAGCRST_OVR_mask = &H1
        if data_low > LONG_MAX then
            if FAGCRST_OVR_mask = mask then
                read_FAGCRST_OVR_value = data_low
            else
                read_FAGCRST_OVR_value = (data_low - H8000_0000) and FAGCRST_OVR_mask
            end If
        else
            read_FAGCRST_OVR_value = data_low and FAGCRST_OVR_mask
        end If

    End Sub

    Sub write
        If flag_FAGC_SKIP_DIS = &H0 or flag_FAGC_ERR_MULT = &H0 or flag_FAGCHIGEAR_OVR_VAL = &H0 or flag_FAGCHIGEAR_OVR = &H0 or flag_CAGCHIGEAR_OVR_VAL = &H0 or flag_CAGCHIGEAR_OVR = &H0 or flag_CAGCFRZ_OVR_VAL = &H0 or flag_CAGCFRZ_OVR = &H0 or flag_CAGCRST_OVR_VAL = &H0 or flag_CAGCRST_OVR = &H0 or flag_FAGCFRZ_OVR_VAL = &H0 or flag_FAGCFRZ_OVR = &H0 or flag_FAGCRST_OVR_VAL = &H0 or flag_FAGCRST_OVR = &H0 Then read
        If flag_FAGC_SKIP_DIS = &H0 Then write_FAGC_SKIP_DIS_value = get_FAGC_SKIP_DIS
        If flag_FAGC_ERR_MULT = &H0 Then write_FAGC_ERR_MULT_value = get_FAGC_ERR_MULT
        If flag_FAGCHIGEAR_OVR_VAL = &H0 Then write_FAGCHIGEAR_OVR_VAL_value = get_FAGCHIGEAR_OVR_VAL
        If flag_FAGCHIGEAR_OVR = &H0 Then write_FAGCHIGEAR_OVR_value = get_FAGCHIGEAR_OVR
        If flag_CAGCHIGEAR_OVR_VAL = &H0 Then write_CAGCHIGEAR_OVR_VAL_value = get_CAGCHIGEAR_OVR_VAL
        If flag_CAGCHIGEAR_OVR = &H0 Then write_CAGCHIGEAR_OVR_value = get_CAGCHIGEAR_OVR
        If flag_CAGCFRZ_OVR_VAL = &H0 Then write_CAGCFRZ_OVR_VAL_value = get_CAGCFRZ_OVR_VAL
        If flag_CAGCFRZ_OVR = &H0 Then write_CAGCFRZ_OVR_value = get_CAGCFRZ_OVR
        If flag_CAGCRST_OVR_VAL = &H0 Then write_CAGCRST_OVR_VAL_value = get_CAGCRST_OVR_VAL
        If flag_CAGCRST_OVR = &H0 Then write_CAGCRST_OVR_value = get_CAGCRST_OVR
        If flag_FAGCFRZ_OVR_VAL = &H0 Then write_FAGCFRZ_OVR_VAL_value = get_FAGCFRZ_OVR_VAL
        If flag_FAGCFRZ_OVR = &H0 Then write_FAGCFRZ_OVR_value = get_FAGCFRZ_OVR
        If flag_FAGCRST_OVR_VAL = &H0 Then write_FAGCRST_OVR_VAL_value = get_FAGCRST_OVR_VAL
        If flag_FAGCRST_OVR = &H0 Then write_FAGCRST_OVR_value = get_FAGCRST_OVR

        regValue = leftShift((write_FAGC_SKIP_DIS_value and &H1), 14) + leftShift((write_FAGC_ERR_MULT_value and &H3), 12) + leftShift((write_FAGCHIGEAR_OVR_VAL_value and &H1), 11) + leftShift((write_FAGCHIGEAR_OVR_value and &H1), 10) + leftShift((write_CAGCHIGEAR_OVR_VAL_value and &H1), 9) + leftShift((write_CAGCHIGEAR_OVR_value and &H1), 8) + leftShift((write_CAGCFRZ_OVR_VAL_value and &H1), 7) + leftShift((write_CAGCFRZ_OVR_value and &H1), 6) + leftShift((write_CAGCRST_OVR_VAL_value and &H1), 5) + leftShift((write_CAGCRST_OVR_value and &H1), 4) + leftShift((write_FAGCFRZ_OVR_VAL_value and &H1), 3) + leftShift((write_FAGCFRZ_OVR_value and &H1), 2) + leftShift((write_FAGCRST_OVR_VAL_value and &H1), 1) + leftShift((write_FAGCRST_OVR_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_FAGC_SKIP_DIS_value = rightShift(data_low, 14) and &H1
        read_FAGC_ERR_MULT_value = rightShift(data_low, 12) and &H3
        read_FAGCHIGEAR_OVR_VAL_value = rightShift(data_low, 11) and &H1
        read_FAGCHIGEAR_OVR_value = rightShift(data_low, 10) and &H1
        read_CAGCHIGEAR_OVR_VAL_value = rightShift(data_low, 9) and &H1
        read_CAGCHIGEAR_OVR_value = rightShift(data_low, 8) and &H1
        read_CAGCFRZ_OVR_VAL_value = rightShift(data_low, 7) and &H1
        read_CAGCFRZ_OVR_value = rightShift(data_low, 6) and &H1
        read_CAGCRST_OVR_VAL_value = rightShift(data_low, 5) and &H1
        read_CAGCRST_OVR_value = rightShift(data_low, 4) and &H1
        read_FAGCFRZ_OVR_VAL_value = rightShift(data_low, 3) and &H1
        read_FAGCFRZ_OVR_value = rightShift(data_low, 2) and &H1
        read_FAGCRST_OVR_VAL_value = rightShift(data_low, 1) and &H1
        FAGCRST_OVR_mask = &H1
        if data_low > LONG_MAX then
            if FAGCRST_OVR_mask = mask then
                read_FAGCRST_OVR_value = data_low
            else
                read_FAGCRST_OVR_value = (data_low - H8000_0000) and FAGCRST_OVR_mask
            end If
        else
            read_FAGCRST_OVR_value = data_low and FAGCRST_OVR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_FAGC_SKIP_DIS_value = &H0
        flag_FAGC_SKIP_DIS        = &H0
        write_FAGC_ERR_MULT_value = &H0
        flag_FAGC_ERR_MULT        = &H0
        write_FAGCHIGEAR_OVR_VAL_value = &H0
        flag_FAGCHIGEAR_OVR_VAL        = &H0
        write_FAGCHIGEAR_OVR_value = &H0
        flag_FAGCHIGEAR_OVR        = &H0
        write_CAGCHIGEAR_OVR_VAL_value = &H0
        flag_CAGCHIGEAR_OVR_VAL        = &H0
        write_CAGCHIGEAR_OVR_value = &H0
        flag_CAGCHIGEAR_OVR        = &H0
        write_CAGCFRZ_OVR_VAL_value = &H0
        flag_CAGCFRZ_OVR_VAL        = &H0
        write_CAGCFRZ_OVR_value = &H0
        flag_CAGCFRZ_OVR        = &H0
        write_CAGCRST_OVR_VAL_value = &H0
        flag_CAGCRST_OVR_VAL        = &H0
        write_CAGCRST_OVR_value = &H0
        flag_CAGCRST_OVR        = &H0
        write_FAGCFRZ_OVR_VAL_value = &H0
        flag_FAGCFRZ_OVR_VAL        = &H0
        write_FAGCFRZ_OVR_value = &H0
        flag_FAGCFRZ_OVR        = &H0
        write_FAGCRST_OVR_VAL_value = &H0
        flag_FAGCRST_OVR_VAL        = &H0
        write_FAGCRST_OVR_value = &H0
        flag_FAGCRST_OVR        = &H0
    End Sub
End Class


'' @REGISTER : DSP_TOP_agc_override_1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COARSE_GAIN_CTL_OVR_VAL                    [12:8]           get_COARSE_GAIN_CTL_OVR_VAL
''                                                             set_COARSE_GAIN_CTL_OVR_VAL
''                                                             read_COARSE_GAIN_CTL_OVR_VAL
''                                                             write_COARSE_GAIN_CTL_OVR_VAL
''---------------------------------------------------------------------------------
'' COARSE_GAIN_CTL_OVR                        [7:7]            get_COARSE_GAIN_CTL_OVR
''                                                             set_COARSE_GAIN_CTL_OVR
''                                                             read_COARSE_GAIN_CTL_OVR
''                                                             write_COARSE_GAIN_CTL_OVR
''---------------------------------------------------------------------------------
'' FINE_GAIN_CTL_OVR_VAL                      [6:1]            get_FINE_GAIN_CTL_OVR_VAL
''                                                             set_FINE_GAIN_CTL_OVR_VAL
''                                                             read_FINE_GAIN_CTL_OVR_VAL
''                                                             write_FINE_GAIN_CTL_OVR_VAL
''---------------------------------------------------------------------------------
'' FINE_GAIN_CTL_OVR                          [0:0]            get_FINE_GAIN_CTL_OVR
''                                                             set_FINE_GAIN_CTL_OVR
''                                                             read_FINE_GAIN_CTL_OVR
''                                                             write_FINE_GAIN_CTL_OVR
''---------------------------------------------------------------------------------
Class REGISTER_DSP_TOP_agc_override_1
    Private write_COARSE_GAIN_CTL_OVR_VAL_value
    Private read_COARSE_GAIN_CTL_OVR_VAL_value
    Private flag_COARSE_GAIN_CTL_OVR_VAL
    Private write_COARSE_GAIN_CTL_OVR_value
    Private read_COARSE_GAIN_CTL_OVR_value
    Private flag_COARSE_GAIN_CTL_OVR
    Private write_FINE_GAIN_CTL_OVR_VAL_value
    Private read_FINE_GAIN_CTL_OVR_VAL_value
    Private flag_FINE_GAIN_CTL_OVR_VAL
    Private write_FINE_GAIN_CTL_OVR_value
    Private read_FINE_GAIN_CTL_OVR_value
    Private flag_FINE_GAIN_CTL_OVR

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

    Property Get get_COARSE_GAIN_CTL_OVR_VAL
        get_COARSE_GAIN_CTL_OVR_VAL = read_COARSE_GAIN_CTL_OVR_VAL_value
    End Property

    Property Let set_COARSE_GAIN_CTL_OVR_VAL(aData)
        write_COARSE_GAIN_CTL_OVR_VAL_value = aData
        flag_COARSE_GAIN_CTL_OVR_VAL        = &H1
    End Property

    Property Get read_COARSE_GAIN_CTL_OVR_VAL
        read
        read_COARSE_GAIN_CTL_OVR_VAL = read_COARSE_GAIN_CTL_OVR_VAL_value
    End Property

    Property Let write_COARSE_GAIN_CTL_OVR_VAL(aData)
        set_COARSE_GAIN_CTL_OVR_VAL = aData
        write
    End Property

    Property Get get_COARSE_GAIN_CTL_OVR
        get_COARSE_GAIN_CTL_OVR = read_COARSE_GAIN_CTL_OVR_value
    End Property

    Property Let set_COARSE_GAIN_CTL_OVR(aData)
        write_COARSE_GAIN_CTL_OVR_value = aData
        flag_COARSE_GAIN_CTL_OVR        = &H1
    End Property

    Property Get read_COARSE_GAIN_CTL_OVR
        read
        read_COARSE_GAIN_CTL_OVR = read_COARSE_GAIN_CTL_OVR_value
    End Property

    Property Let write_COARSE_GAIN_CTL_OVR(aData)
        set_COARSE_GAIN_CTL_OVR = aData
        write
    End Property

    Property Get get_FINE_GAIN_CTL_OVR_VAL
        get_FINE_GAIN_CTL_OVR_VAL = read_FINE_GAIN_CTL_OVR_VAL_value
    End Property

    Property Let set_FINE_GAIN_CTL_OVR_VAL(aData)
        write_FINE_GAIN_CTL_OVR_VAL_value = aData
        flag_FINE_GAIN_CTL_OVR_VAL        = &H1
    End Property

    Property Get read_FINE_GAIN_CTL_OVR_VAL
        read
        read_FINE_GAIN_CTL_OVR_VAL = read_FINE_GAIN_CTL_OVR_VAL_value
    End Property

    Property Let write_FINE_GAIN_CTL_OVR_VAL(aData)
        set_FINE_GAIN_CTL_OVR_VAL = aData
        write
    End Property

    Property Get get_FINE_GAIN_CTL_OVR
        get_FINE_GAIN_CTL_OVR = read_FINE_GAIN_CTL_OVR_value
    End Property

    Property Let set_FINE_GAIN_CTL_OVR(aData)
        write_FINE_GAIN_CTL_OVR_value = aData
        flag_FINE_GAIN_CTL_OVR        = &H1
    End Property

    Property Get read_FINE_GAIN_CTL_OVR
        read
        read_FINE_GAIN_CTL_OVR = read_FINE_GAIN_CTL_OVR_value
    End Property

    Property Let write_FINE_GAIN_CTL_OVR(aData)
        set_FINE_GAIN_CTL_OVR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_COARSE_GAIN_CTL_OVR_VAL_value = rightShift(data_low, 8) and &H1f
        read_COARSE_GAIN_CTL_OVR_value = rightShift(data_low, 7) and &H1
        read_FINE_GAIN_CTL_OVR_VAL_value = rightShift(data_low, 1) and &H3f
        FINE_GAIN_CTL_OVR_mask = &H1
        if data_low > LONG_MAX then
            if FINE_GAIN_CTL_OVR_mask = mask then
                read_FINE_GAIN_CTL_OVR_value = data_low
            else
                read_FINE_GAIN_CTL_OVR_value = (data_low - H8000_0000) and FINE_GAIN_CTL_OVR_mask
            end If
        else
            read_FINE_GAIN_CTL_OVR_value = data_low and FINE_GAIN_CTL_OVR_mask
        end If

    End Sub

    Sub write
        If flag_COARSE_GAIN_CTL_OVR_VAL = &H0 or flag_COARSE_GAIN_CTL_OVR = &H0 or flag_FINE_GAIN_CTL_OVR_VAL = &H0 or flag_FINE_GAIN_CTL_OVR = &H0 Then read
        If flag_COARSE_GAIN_CTL_OVR_VAL = &H0 Then write_COARSE_GAIN_CTL_OVR_VAL_value = get_COARSE_GAIN_CTL_OVR_VAL
        If flag_COARSE_GAIN_CTL_OVR = &H0 Then write_COARSE_GAIN_CTL_OVR_value = get_COARSE_GAIN_CTL_OVR
        If flag_FINE_GAIN_CTL_OVR_VAL = &H0 Then write_FINE_GAIN_CTL_OVR_VAL_value = get_FINE_GAIN_CTL_OVR_VAL
        If flag_FINE_GAIN_CTL_OVR = &H0 Then write_FINE_GAIN_CTL_OVR_value = get_FINE_GAIN_CTL_OVR

        regValue = leftShift((write_COARSE_GAIN_CTL_OVR_VAL_value and &H1f), 8) + leftShift((write_COARSE_GAIN_CTL_OVR_value and &H1), 7) + leftShift((write_FINE_GAIN_CTL_OVR_VAL_value and &H3f), 1) + leftShift((write_FINE_GAIN_CTL_OVR_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_COARSE_GAIN_CTL_OVR_VAL_value = rightShift(data_low, 8) and &H1f
        read_COARSE_GAIN_CTL_OVR_value = rightShift(data_low, 7) and &H1
        read_FINE_GAIN_CTL_OVR_VAL_value = rightShift(data_low, 1) and &H3f
        FINE_GAIN_CTL_OVR_mask = &H1
        if data_low > LONG_MAX then
            if FINE_GAIN_CTL_OVR_mask = mask then
                read_FINE_GAIN_CTL_OVR_value = data_low
            else
                read_FINE_GAIN_CTL_OVR_value = (data_low - H8000_0000) and FINE_GAIN_CTL_OVR_mask
            end If
        else
            read_FINE_GAIN_CTL_OVR_value = data_low and FINE_GAIN_CTL_OVR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COARSE_GAIN_CTL_OVR_VAL_value = &H0
        flag_COARSE_GAIN_CTL_OVR_VAL        = &H0
        write_COARSE_GAIN_CTL_OVR_value = &H0
        flag_COARSE_GAIN_CTL_OVR        = &H0
        write_FINE_GAIN_CTL_OVR_VAL_value = &H0
        flag_FINE_GAIN_CTL_OVR_VAL        = &H0
        write_FINE_GAIN_CTL_OVR_value = &H0
        flag_FINE_GAIN_CTL_OVR        = &H0
    End Sub
End Class


'' @REGISTER : DSP_TOP_dsp_test0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DAGC_INIT_OPT                              [12:12]          get_DAGC_INIT_OPT
''                                                             set_DAGC_INIT_OPT
''                                                             read_DAGC_INIT_OPT
''                                                             write_DAGC_INIT_OPT
''---------------------------------------------------------------------------------
'' SDCORSTN_FORCE_DEASSERT                    [11:11]          get_SDCORSTN_FORCE_DEASSERT
''                                                             set_SDCORSTN_FORCE_DEASSERT
''                                                             read_SDCORSTN_FORCE_DEASSERT
''                                                             write_SDCORSTN_FORCE_DEASSERT
''---------------------------------------------------------------------------------
'' SDCORSTN_FORCE_ASSERT                      [10:10]          get_SDCORSTN_FORCE_ASSERT
''                                                             set_SDCORSTN_FORCE_ASSERT
''                                                             read_SDCORSTN_FORCE_ASSERT
''                                                             write_SDCORSTN_FORCE_ASSERT
''---------------------------------------------------------------------------------
'' DAGCRSTN_FORCE_DEASSERT                    [9:9]            get_DAGCRSTN_FORCE_DEASSERT
''                                                             set_DAGCRSTN_FORCE_DEASSERT
''                                                             read_DAGCRSTN_FORCE_DEASSERT
''                                                             write_DAGCRSTN_FORCE_DEASSERT
''---------------------------------------------------------------------------------
'' DAGCRSTN_FORCE_ASSERT                      [8:8]            get_DAGCRSTN_FORCE_ASSERT
''                                                             set_DAGCRSTN_FORCE_ASSERT
''                                                             read_DAGCRSTN_FORCE_ASSERT
''                                                             write_DAGCRSTN_FORCE_ASSERT
''---------------------------------------------------------------------------------
'' SDCO_FREEZE_FORCE_DEASSERT                 [7:7]            get_SDCO_FREEZE_FORCE_DEASSERT
''                                                             set_SDCO_FREEZE_FORCE_DEASSERT
''                                                             read_SDCO_FREEZE_FORCE_DEASSERT
''                                                             write_SDCO_FREEZE_FORCE_DEASSERT
''---------------------------------------------------------------------------------
'' SDCO_FREEZE_FORCE_ASSERT                   [6:6]            get_SDCO_FREEZE_FORCE_ASSERT
''                                                             set_SDCO_FREEZE_FORCE_ASSERT
''                                                             read_SDCO_FREEZE_FORCE_ASSERT
''                                                             write_SDCO_FREEZE_FORCE_ASSERT
''---------------------------------------------------------------------------------
'' DAGC_MU_CONTROL                            [5:4]            get_DAGC_MU_CONTROL
''                                                             set_DAGC_MU_CONTROL
''                                                             read_DAGC_MU_CONTROL
''                                                             write_DAGC_MU_CONTROL
''---------------------------------------------------------------------------------
'' DAGC_FREEZE_FORCE_DEASSERT                 [3:3]            get_DAGC_FREEZE_FORCE_DEASSERT
''                                                             set_DAGC_FREEZE_FORCE_DEASSERT
''                                                             read_DAGC_FREEZE_FORCE_DEASSERT
''                                                             write_DAGC_FREEZE_FORCE_DEASSERT
''---------------------------------------------------------------------------------
'' DAGC_FREEZE_FORCE_ASSERT                   [2:2]            get_DAGC_FREEZE_FORCE_ASSERT
''                                                             set_DAGC_FREEZE_FORCE_ASSERT
''                                                             read_DAGC_FREEZE_FORCE_ASSERT
''                                                             write_DAGC_FREEZE_FORCE_ASSERT
''---------------------------------------------------------------------------------
'' ALT_DSP_DIG_LPBK                           [1:1]            get_ALT_DSP_DIG_LPBK
''                                                             set_ALT_DSP_DIG_LPBK
''                                                             read_ALT_DSP_DIG_LPBK
''                                                             write_ALT_DSP_DIG_LPBK
''---------------------------------------------------------------------------------
'' DSP_DIG_LPBK_EN                            [0:0]            get_DSP_DIG_LPBK_EN
''                                                             set_DSP_DIG_LPBK_EN
''                                                             read_DSP_DIG_LPBK_EN
''                                                             write_DSP_DIG_LPBK_EN
''---------------------------------------------------------------------------------
Class REGISTER_DSP_TOP_dsp_test0
    Private write_DAGC_INIT_OPT_value
    Private read_DAGC_INIT_OPT_value
    Private flag_DAGC_INIT_OPT
    Private write_SDCORSTN_FORCE_DEASSERT_value
    Private read_SDCORSTN_FORCE_DEASSERT_value
    Private flag_SDCORSTN_FORCE_DEASSERT
    Private write_SDCORSTN_FORCE_ASSERT_value
    Private read_SDCORSTN_FORCE_ASSERT_value
    Private flag_SDCORSTN_FORCE_ASSERT
    Private write_DAGCRSTN_FORCE_DEASSERT_value
    Private read_DAGCRSTN_FORCE_DEASSERT_value
    Private flag_DAGCRSTN_FORCE_DEASSERT
    Private write_DAGCRSTN_FORCE_ASSERT_value
    Private read_DAGCRSTN_FORCE_ASSERT_value
    Private flag_DAGCRSTN_FORCE_ASSERT
    Private write_SDCO_FREEZE_FORCE_DEASSERT_value
    Private read_SDCO_FREEZE_FORCE_DEASSERT_value
    Private flag_SDCO_FREEZE_FORCE_DEASSERT
    Private write_SDCO_FREEZE_FORCE_ASSERT_value
    Private read_SDCO_FREEZE_FORCE_ASSERT_value
    Private flag_SDCO_FREEZE_FORCE_ASSERT
    Private write_DAGC_MU_CONTROL_value
    Private read_DAGC_MU_CONTROL_value
    Private flag_DAGC_MU_CONTROL
    Private write_DAGC_FREEZE_FORCE_DEASSERT_value
    Private read_DAGC_FREEZE_FORCE_DEASSERT_value
    Private flag_DAGC_FREEZE_FORCE_DEASSERT
    Private write_DAGC_FREEZE_FORCE_ASSERT_value
    Private read_DAGC_FREEZE_FORCE_ASSERT_value
    Private flag_DAGC_FREEZE_FORCE_ASSERT
    Private write_ALT_DSP_DIG_LPBK_value
    Private read_ALT_DSP_DIG_LPBK_value
    Private flag_ALT_DSP_DIG_LPBK
    Private write_DSP_DIG_LPBK_EN_value
    Private read_DSP_DIG_LPBK_EN_value
    Private flag_DSP_DIG_LPBK_EN

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

    Property Get get_DAGC_INIT_OPT
        get_DAGC_INIT_OPT = read_DAGC_INIT_OPT_value
    End Property

    Property Let set_DAGC_INIT_OPT(aData)
        write_DAGC_INIT_OPT_value = aData
        flag_DAGC_INIT_OPT        = &H1
    End Property

    Property Get read_DAGC_INIT_OPT
        read
        read_DAGC_INIT_OPT = read_DAGC_INIT_OPT_value
    End Property

    Property Let write_DAGC_INIT_OPT(aData)
        set_DAGC_INIT_OPT = aData
        write
    End Property

    Property Get get_SDCORSTN_FORCE_DEASSERT
        get_SDCORSTN_FORCE_DEASSERT = read_SDCORSTN_FORCE_DEASSERT_value
    End Property

    Property Let set_SDCORSTN_FORCE_DEASSERT(aData)
        write_SDCORSTN_FORCE_DEASSERT_value = aData
        flag_SDCORSTN_FORCE_DEASSERT        = &H1
    End Property

    Property Get read_SDCORSTN_FORCE_DEASSERT
        read
        read_SDCORSTN_FORCE_DEASSERT = read_SDCORSTN_FORCE_DEASSERT_value
    End Property

    Property Let write_SDCORSTN_FORCE_DEASSERT(aData)
        set_SDCORSTN_FORCE_DEASSERT = aData
        write
    End Property

    Property Get get_SDCORSTN_FORCE_ASSERT
        get_SDCORSTN_FORCE_ASSERT = read_SDCORSTN_FORCE_ASSERT_value
    End Property

    Property Let set_SDCORSTN_FORCE_ASSERT(aData)
        write_SDCORSTN_FORCE_ASSERT_value = aData
        flag_SDCORSTN_FORCE_ASSERT        = &H1
    End Property

    Property Get read_SDCORSTN_FORCE_ASSERT
        read
        read_SDCORSTN_FORCE_ASSERT = read_SDCORSTN_FORCE_ASSERT_value
    End Property

    Property Let write_SDCORSTN_FORCE_ASSERT(aData)
        set_SDCORSTN_FORCE_ASSERT = aData
        write
    End Property

    Property Get get_DAGCRSTN_FORCE_DEASSERT
        get_DAGCRSTN_FORCE_DEASSERT = read_DAGCRSTN_FORCE_DEASSERT_value
    End Property

    Property Let set_DAGCRSTN_FORCE_DEASSERT(aData)
        write_DAGCRSTN_FORCE_DEASSERT_value = aData
        flag_DAGCRSTN_FORCE_DEASSERT        = &H1
    End Property

    Property Get read_DAGCRSTN_FORCE_DEASSERT
        read
        read_DAGCRSTN_FORCE_DEASSERT = read_DAGCRSTN_FORCE_DEASSERT_value
    End Property

    Property Let write_DAGCRSTN_FORCE_DEASSERT(aData)
        set_DAGCRSTN_FORCE_DEASSERT = aData
        write
    End Property

    Property Get get_DAGCRSTN_FORCE_ASSERT
        get_DAGCRSTN_FORCE_ASSERT = read_DAGCRSTN_FORCE_ASSERT_value
    End Property

    Property Let set_DAGCRSTN_FORCE_ASSERT(aData)
        write_DAGCRSTN_FORCE_ASSERT_value = aData
        flag_DAGCRSTN_FORCE_ASSERT        = &H1
    End Property

    Property Get read_DAGCRSTN_FORCE_ASSERT
        read
        read_DAGCRSTN_FORCE_ASSERT = read_DAGCRSTN_FORCE_ASSERT_value
    End Property

    Property Let write_DAGCRSTN_FORCE_ASSERT(aData)
        set_DAGCRSTN_FORCE_ASSERT = aData
        write
    End Property

    Property Get get_SDCO_FREEZE_FORCE_DEASSERT
        get_SDCO_FREEZE_FORCE_DEASSERT = read_SDCO_FREEZE_FORCE_DEASSERT_value
    End Property

    Property Let set_SDCO_FREEZE_FORCE_DEASSERT(aData)
        write_SDCO_FREEZE_FORCE_DEASSERT_value = aData
        flag_SDCO_FREEZE_FORCE_DEASSERT        = &H1
    End Property

    Property Get read_SDCO_FREEZE_FORCE_DEASSERT
        read
        read_SDCO_FREEZE_FORCE_DEASSERT = read_SDCO_FREEZE_FORCE_DEASSERT_value
    End Property

    Property Let write_SDCO_FREEZE_FORCE_DEASSERT(aData)
        set_SDCO_FREEZE_FORCE_DEASSERT = aData
        write
    End Property

    Property Get get_SDCO_FREEZE_FORCE_ASSERT
        get_SDCO_FREEZE_FORCE_ASSERT = read_SDCO_FREEZE_FORCE_ASSERT_value
    End Property

    Property Let set_SDCO_FREEZE_FORCE_ASSERT(aData)
        write_SDCO_FREEZE_FORCE_ASSERT_value = aData
        flag_SDCO_FREEZE_FORCE_ASSERT        = &H1
    End Property

    Property Get read_SDCO_FREEZE_FORCE_ASSERT
        read
        read_SDCO_FREEZE_FORCE_ASSERT = read_SDCO_FREEZE_FORCE_ASSERT_value
    End Property

    Property Let write_SDCO_FREEZE_FORCE_ASSERT(aData)
        set_SDCO_FREEZE_FORCE_ASSERT = aData
        write
    End Property

    Property Get get_DAGC_MU_CONTROL
        get_DAGC_MU_CONTROL = read_DAGC_MU_CONTROL_value
    End Property

    Property Let set_DAGC_MU_CONTROL(aData)
        write_DAGC_MU_CONTROL_value = aData
        flag_DAGC_MU_CONTROL        = &H1
    End Property

    Property Get read_DAGC_MU_CONTROL
        read
        read_DAGC_MU_CONTROL = read_DAGC_MU_CONTROL_value
    End Property

    Property Let write_DAGC_MU_CONTROL(aData)
        set_DAGC_MU_CONTROL = aData
        write
    End Property

    Property Get get_DAGC_FREEZE_FORCE_DEASSERT
        get_DAGC_FREEZE_FORCE_DEASSERT = read_DAGC_FREEZE_FORCE_DEASSERT_value
    End Property

    Property Let set_DAGC_FREEZE_FORCE_DEASSERT(aData)
        write_DAGC_FREEZE_FORCE_DEASSERT_value = aData
        flag_DAGC_FREEZE_FORCE_DEASSERT        = &H1
    End Property

    Property Get read_DAGC_FREEZE_FORCE_DEASSERT
        read
        read_DAGC_FREEZE_FORCE_DEASSERT = read_DAGC_FREEZE_FORCE_DEASSERT_value
    End Property

    Property Let write_DAGC_FREEZE_FORCE_DEASSERT(aData)
        set_DAGC_FREEZE_FORCE_DEASSERT = aData
        write
    End Property

    Property Get get_DAGC_FREEZE_FORCE_ASSERT
        get_DAGC_FREEZE_FORCE_ASSERT = read_DAGC_FREEZE_FORCE_ASSERT_value
    End Property

    Property Let set_DAGC_FREEZE_FORCE_ASSERT(aData)
        write_DAGC_FREEZE_FORCE_ASSERT_value = aData
        flag_DAGC_FREEZE_FORCE_ASSERT        = &H1
    End Property

    Property Get read_DAGC_FREEZE_FORCE_ASSERT
        read
        read_DAGC_FREEZE_FORCE_ASSERT = read_DAGC_FREEZE_FORCE_ASSERT_value
    End Property

    Property Let write_DAGC_FREEZE_FORCE_ASSERT(aData)
        set_DAGC_FREEZE_FORCE_ASSERT = aData
        write
    End Property

    Property Get get_ALT_DSP_DIG_LPBK
        get_ALT_DSP_DIG_LPBK = read_ALT_DSP_DIG_LPBK_value
    End Property

    Property Let set_ALT_DSP_DIG_LPBK(aData)
        write_ALT_DSP_DIG_LPBK_value = aData
        flag_ALT_DSP_DIG_LPBK        = &H1
    End Property

    Property Get read_ALT_DSP_DIG_LPBK
        read
        read_ALT_DSP_DIG_LPBK = read_ALT_DSP_DIG_LPBK_value
    End Property

    Property Let write_ALT_DSP_DIG_LPBK(aData)
        set_ALT_DSP_DIG_LPBK = aData
        write
    End Property

    Property Get get_DSP_DIG_LPBK_EN
        get_DSP_DIG_LPBK_EN = read_DSP_DIG_LPBK_EN_value
    End Property

    Property Let set_DSP_DIG_LPBK_EN(aData)
        write_DSP_DIG_LPBK_EN_value = aData
        flag_DSP_DIG_LPBK_EN        = &H1
    End Property

    Property Get read_DSP_DIG_LPBK_EN
        read
        read_DSP_DIG_LPBK_EN = read_DSP_DIG_LPBK_EN_value
    End Property

    Property Let write_DSP_DIG_LPBK_EN(aData)
        set_DSP_DIG_LPBK_EN = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_DAGC_INIT_OPT_value = rightShift(data_low, 12) and &H1
        read_SDCORSTN_FORCE_DEASSERT_value = rightShift(data_low, 11) and &H1
        read_SDCORSTN_FORCE_ASSERT_value = rightShift(data_low, 10) and &H1
        read_DAGCRSTN_FORCE_DEASSERT_value = rightShift(data_low, 9) and &H1
        read_DAGCRSTN_FORCE_ASSERT_value = rightShift(data_low, 8) and &H1
        read_SDCO_FREEZE_FORCE_DEASSERT_value = rightShift(data_low, 7) and &H1
        read_SDCO_FREEZE_FORCE_ASSERT_value = rightShift(data_low, 6) and &H1
        read_DAGC_MU_CONTROL_value = rightShift(data_low, 4) and &H3
        read_DAGC_FREEZE_FORCE_DEASSERT_value = rightShift(data_low, 3) and &H1
        read_DAGC_FREEZE_FORCE_ASSERT_value = rightShift(data_low, 2) and &H1
        read_ALT_DSP_DIG_LPBK_value = rightShift(data_low, 1) and &H1
        DSP_DIG_LPBK_EN_mask = &H1
        if data_low > LONG_MAX then
            if DSP_DIG_LPBK_EN_mask = mask then
                read_DSP_DIG_LPBK_EN_value = data_low
            else
                read_DSP_DIG_LPBK_EN_value = (data_low - H8000_0000) and DSP_DIG_LPBK_EN_mask
            end If
        else
            read_DSP_DIG_LPBK_EN_value = data_low and DSP_DIG_LPBK_EN_mask
        end If

    End Sub

    Sub write
        If flag_DAGC_INIT_OPT = &H0 or flag_SDCORSTN_FORCE_DEASSERT = &H0 or flag_SDCORSTN_FORCE_ASSERT = &H0 or flag_DAGCRSTN_FORCE_DEASSERT = &H0 or flag_DAGCRSTN_FORCE_ASSERT = &H0 or flag_SDCO_FREEZE_FORCE_DEASSERT = &H0 or flag_SDCO_FREEZE_FORCE_ASSERT = &H0 or flag_DAGC_MU_CONTROL = &H0 or flag_DAGC_FREEZE_FORCE_DEASSERT = &H0 or flag_DAGC_FREEZE_FORCE_ASSERT = &H0 or flag_ALT_DSP_DIG_LPBK = &H0 or flag_DSP_DIG_LPBK_EN = &H0 Then read
        If flag_DAGC_INIT_OPT = &H0 Then write_DAGC_INIT_OPT_value = get_DAGC_INIT_OPT
        If flag_SDCORSTN_FORCE_DEASSERT = &H0 Then write_SDCORSTN_FORCE_DEASSERT_value = get_SDCORSTN_FORCE_DEASSERT
        If flag_SDCORSTN_FORCE_ASSERT = &H0 Then write_SDCORSTN_FORCE_ASSERT_value = get_SDCORSTN_FORCE_ASSERT
        If flag_DAGCRSTN_FORCE_DEASSERT = &H0 Then write_DAGCRSTN_FORCE_DEASSERT_value = get_DAGCRSTN_FORCE_DEASSERT
        If flag_DAGCRSTN_FORCE_ASSERT = &H0 Then write_DAGCRSTN_FORCE_ASSERT_value = get_DAGCRSTN_FORCE_ASSERT
        If flag_SDCO_FREEZE_FORCE_DEASSERT = &H0 Then write_SDCO_FREEZE_FORCE_DEASSERT_value = get_SDCO_FREEZE_FORCE_DEASSERT
        If flag_SDCO_FREEZE_FORCE_ASSERT = &H0 Then write_SDCO_FREEZE_FORCE_ASSERT_value = get_SDCO_FREEZE_FORCE_ASSERT
        If flag_DAGC_MU_CONTROL = &H0 Then write_DAGC_MU_CONTROL_value = get_DAGC_MU_CONTROL
        If flag_DAGC_FREEZE_FORCE_DEASSERT = &H0 Then write_DAGC_FREEZE_FORCE_DEASSERT_value = get_DAGC_FREEZE_FORCE_DEASSERT
        If flag_DAGC_FREEZE_FORCE_ASSERT = &H0 Then write_DAGC_FREEZE_FORCE_ASSERT_value = get_DAGC_FREEZE_FORCE_ASSERT
        If flag_ALT_DSP_DIG_LPBK = &H0 Then write_ALT_DSP_DIG_LPBK_value = get_ALT_DSP_DIG_LPBK
        If flag_DSP_DIG_LPBK_EN = &H0 Then write_DSP_DIG_LPBK_EN_value = get_DSP_DIG_LPBK_EN

        regValue = leftShift((write_DAGC_INIT_OPT_value and &H1), 12) + leftShift((write_SDCORSTN_FORCE_DEASSERT_value and &H1), 11) + leftShift((write_SDCORSTN_FORCE_ASSERT_value and &H1), 10) + leftShift((write_DAGCRSTN_FORCE_DEASSERT_value and &H1), 9) + leftShift((write_DAGCRSTN_FORCE_ASSERT_value and &H1), 8) + leftShift((write_SDCO_FREEZE_FORCE_DEASSERT_value and &H1), 7) + leftShift((write_SDCO_FREEZE_FORCE_ASSERT_value and &H1), 6) + leftShift((write_DAGC_MU_CONTROL_value and &H3), 4) + leftShift((write_DAGC_FREEZE_FORCE_DEASSERT_value and &H1), 3) + leftShift((write_DAGC_FREEZE_FORCE_ASSERT_value and &H1), 2) + leftShift((write_ALT_DSP_DIG_LPBK_value and &H1), 1) + leftShift((write_DSP_DIG_LPBK_EN_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_DAGC_INIT_OPT_value = rightShift(data_low, 12) and &H1
        read_SDCORSTN_FORCE_DEASSERT_value = rightShift(data_low, 11) and &H1
        read_SDCORSTN_FORCE_ASSERT_value = rightShift(data_low, 10) and &H1
        read_DAGCRSTN_FORCE_DEASSERT_value = rightShift(data_low, 9) and &H1
        read_DAGCRSTN_FORCE_ASSERT_value = rightShift(data_low, 8) and &H1
        read_SDCO_FREEZE_FORCE_DEASSERT_value = rightShift(data_low, 7) and &H1
        read_SDCO_FREEZE_FORCE_ASSERT_value = rightShift(data_low, 6) and &H1
        read_DAGC_MU_CONTROL_value = rightShift(data_low, 4) and &H3
        read_DAGC_FREEZE_FORCE_DEASSERT_value = rightShift(data_low, 3) and &H1
        read_DAGC_FREEZE_FORCE_ASSERT_value = rightShift(data_low, 2) and &H1
        read_ALT_DSP_DIG_LPBK_value = rightShift(data_low, 1) and &H1
        DSP_DIG_LPBK_EN_mask = &H1
        if data_low > LONG_MAX then
            if DSP_DIG_LPBK_EN_mask = mask then
                read_DSP_DIG_LPBK_EN_value = data_low
            else
                read_DSP_DIG_LPBK_EN_value = (data_low - H8000_0000) and DSP_DIG_LPBK_EN_mask
            end If
        else
            read_DSP_DIG_LPBK_EN_value = data_low and DSP_DIG_LPBK_EN_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DAGC_INIT_OPT_value = &H0
        flag_DAGC_INIT_OPT        = &H0
        write_SDCORSTN_FORCE_DEASSERT_value = &H0
        flag_SDCORSTN_FORCE_DEASSERT        = &H0
        write_SDCORSTN_FORCE_ASSERT_value = &H0
        flag_SDCORSTN_FORCE_ASSERT        = &H0
        write_DAGCRSTN_FORCE_DEASSERT_value = &H0
        flag_DAGCRSTN_FORCE_DEASSERT        = &H0
        write_DAGCRSTN_FORCE_ASSERT_value = &H0
        flag_DAGCRSTN_FORCE_ASSERT        = &H0
        write_SDCO_FREEZE_FORCE_DEASSERT_value = &H0
        flag_SDCO_FREEZE_FORCE_DEASSERT        = &H0
        write_SDCO_FREEZE_FORCE_ASSERT_value = &H0
        flag_SDCO_FREEZE_FORCE_ASSERT        = &H0
        write_DAGC_MU_CONTROL_value = &H0
        flag_DAGC_MU_CONTROL        = &H0
        write_DAGC_FREEZE_FORCE_DEASSERT_value = &H0
        flag_DAGC_FREEZE_FORCE_DEASSERT        = &H0
        write_DAGC_FREEZE_FORCE_ASSERT_value = &H0
        flag_DAGC_FREEZE_FORCE_ASSERT        = &H0
        write_ALT_DSP_DIG_LPBK_value = &H0
        flag_ALT_DSP_DIG_LPBK        = &H0
        write_DSP_DIG_LPBK_EN_value = &H0
        flag_DSP_DIG_LPBK_EN        = &H0
    End Sub
End Class


'' @REGISTER : DSP_TOP_dsp_test1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' EN_FFE_TE_FORCE_DEASSERT                   [6:6]            get_EN_FFE_TE_FORCE_DEASSERT
''                                                             set_EN_FFE_TE_FORCE_DEASSERT
''                                                             read_EN_FFE_TE_FORCE_DEASSERT
''                                                             write_EN_FFE_TE_FORCE_DEASSERT
''---------------------------------------------------------------------------------
'' EN_FFE_TE_FORCE_ASSERT                     [5:5]            get_EN_FFE_TE_FORCE_ASSERT
''                                                             set_EN_FFE_TE_FORCE_ASSERT
''                                                             read_EN_FFE_TE_FORCE_ASSERT
''                                                             write_EN_FFE_TE_FORCE_ASSERT
''---------------------------------------------------------------------------------
'' LOC_TRAIN_FORCE_DEASSERT                   [4:4]            get_LOC_TRAIN_FORCE_DEASSERT
''                                                             set_LOC_TRAIN_FORCE_DEASSERT
''                                                             read_LOC_TRAIN_FORCE_DEASSERT
''                                                             write_LOC_TRAIN_FORCE_DEASSERT
''---------------------------------------------------------------------------------
'' LOC_TRAIN_FORCE_ASSERT                     [3:3]            get_LOC_TRAIN_FORCE_ASSERT
''                                                             set_LOC_TRAIN_FORCE_ASSERT
''                                                             read_LOC_TRAIN_FORCE_ASSERT
''                                                             write_LOC_TRAIN_FORCE_ASSERT
''---------------------------------------------------------------------------------
'' SLCTL_OVERRIDE                             [2:2]            get_SLCTL_OVERRIDE
''                                                             set_SLCTL_OVERRIDE
''                                                             read_SLCTL_OVERRIDE
''                                                             write_SLCTL_OVERRIDE
''---------------------------------------------------------------------------------
'' SLICER_CTL                                 [1:0]            get_SLICER_CTL
''                                                             set_SLICER_CTL
''                                                             read_SLICER_CTL
''                                                             write_SLICER_CTL
''---------------------------------------------------------------------------------
Class REGISTER_DSP_TOP_dsp_test1
    Private write_EN_FFE_TE_FORCE_DEASSERT_value
    Private read_EN_FFE_TE_FORCE_DEASSERT_value
    Private flag_EN_FFE_TE_FORCE_DEASSERT
    Private write_EN_FFE_TE_FORCE_ASSERT_value
    Private read_EN_FFE_TE_FORCE_ASSERT_value
    Private flag_EN_FFE_TE_FORCE_ASSERT
    Private write_LOC_TRAIN_FORCE_DEASSERT_value
    Private read_LOC_TRAIN_FORCE_DEASSERT_value
    Private flag_LOC_TRAIN_FORCE_DEASSERT
    Private write_LOC_TRAIN_FORCE_ASSERT_value
    Private read_LOC_TRAIN_FORCE_ASSERT_value
    Private flag_LOC_TRAIN_FORCE_ASSERT
    Private write_SLCTL_OVERRIDE_value
    Private read_SLCTL_OVERRIDE_value
    Private flag_SLCTL_OVERRIDE
    Private write_SLICER_CTL_value
    Private read_SLICER_CTL_value
    Private flag_SLICER_CTL

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

    Property Get get_EN_FFE_TE_FORCE_DEASSERT
        get_EN_FFE_TE_FORCE_DEASSERT = read_EN_FFE_TE_FORCE_DEASSERT_value
    End Property

    Property Let set_EN_FFE_TE_FORCE_DEASSERT(aData)
        write_EN_FFE_TE_FORCE_DEASSERT_value = aData
        flag_EN_FFE_TE_FORCE_DEASSERT        = &H1
    End Property

    Property Get read_EN_FFE_TE_FORCE_DEASSERT
        read
        read_EN_FFE_TE_FORCE_DEASSERT = read_EN_FFE_TE_FORCE_DEASSERT_value
    End Property

    Property Let write_EN_FFE_TE_FORCE_DEASSERT(aData)
        set_EN_FFE_TE_FORCE_DEASSERT = aData
        write
    End Property

    Property Get get_EN_FFE_TE_FORCE_ASSERT
        get_EN_FFE_TE_FORCE_ASSERT = read_EN_FFE_TE_FORCE_ASSERT_value
    End Property

    Property Let set_EN_FFE_TE_FORCE_ASSERT(aData)
        write_EN_FFE_TE_FORCE_ASSERT_value = aData
        flag_EN_FFE_TE_FORCE_ASSERT        = &H1
    End Property

    Property Get read_EN_FFE_TE_FORCE_ASSERT
        read
        read_EN_FFE_TE_FORCE_ASSERT = read_EN_FFE_TE_FORCE_ASSERT_value
    End Property

    Property Let write_EN_FFE_TE_FORCE_ASSERT(aData)
        set_EN_FFE_TE_FORCE_ASSERT = aData
        write
    End Property

    Property Get get_LOC_TRAIN_FORCE_DEASSERT
        get_LOC_TRAIN_FORCE_DEASSERT = read_LOC_TRAIN_FORCE_DEASSERT_value
    End Property

    Property Let set_LOC_TRAIN_FORCE_DEASSERT(aData)
        write_LOC_TRAIN_FORCE_DEASSERT_value = aData
        flag_LOC_TRAIN_FORCE_DEASSERT        = &H1
    End Property

    Property Get read_LOC_TRAIN_FORCE_DEASSERT
        read
        read_LOC_TRAIN_FORCE_DEASSERT = read_LOC_TRAIN_FORCE_DEASSERT_value
    End Property

    Property Let write_LOC_TRAIN_FORCE_DEASSERT(aData)
        set_LOC_TRAIN_FORCE_DEASSERT = aData
        write
    End Property

    Property Get get_LOC_TRAIN_FORCE_ASSERT
        get_LOC_TRAIN_FORCE_ASSERT = read_LOC_TRAIN_FORCE_ASSERT_value
    End Property

    Property Let set_LOC_TRAIN_FORCE_ASSERT(aData)
        write_LOC_TRAIN_FORCE_ASSERT_value = aData
        flag_LOC_TRAIN_FORCE_ASSERT        = &H1
    End Property

    Property Get read_LOC_TRAIN_FORCE_ASSERT
        read
        read_LOC_TRAIN_FORCE_ASSERT = read_LOC_TRAIN_FORCE_ASSERT_value
    End Property

    Property Let write_LOC_TRAIN_FORCE_ASSERT(aData)
        set_LOC_TRAIN_FORCE_ASSERT = aData
        write
    End Property

    Property Get get_SLCTL_OVERRIDE
        get_SLCTL_OVERRIDE = read_SLCTL_OVERRIDE_value
    End Property

    Property Let set_SLCTL_OVERRIDE(aData)
        write_SLCTL_OVERRIDE_value = aData
        flag_SLCTL_OVERRIDE        = &H1
    End Property

    Property Get read_SLCTL_OVERRIDE
        read
        read_SLCTL_OVERRIDE = read_SLCTL_OVERRIDE_value
    End Property

    Property Let write_SLCTL_OVERRIDE(aData)
        set_SLCTL_OVERRIDE = aData
        write
    End Property

    Property Get get_SLICER_CTL
        get_SLICER_CTL = read_SLICER_CTL_value
    End Property

    Property Let set_SLICER_CTL(aData)
        write_SLICER_CTL_value = aData
        flag_SLICER_CTL        = &H1
    End Property

    Property Get read_SLICER_CTL
        read
        read_SLICER_CTL = read_SLICER_CTL_value
    End Property

    Property Let write_SLICER_CTL(aData)
        set_SLICER_CTL = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_EN_FFE_TE_FORCE_DEASSERT_value = rightShift(data_low, 6) and &H1
        read_EN_FFE_TE_FORCE_ASSERT_value = rightShift(data_low, 5) and &H1
        read_LOC_TRAIN_FORCE_DEASSERT_value = rightShift(data_low, 4) and &H1
        read_LOC_TRAIN_FORCE_ASSERT_value = rightShift(data_low, 3) and &H1
        read_SLCTL_OVERRIDE_value = rightShift(data_low, 2) and &H1
        SLICER_CTL_mask = &H3
        if data_low > LONG_MAX then
            if SLICER_CTL_mask = mask then
                read_SLICER_CTL_value = data_low
            else
                read_SLICER_CTL_value = (data_low - H8000_0000) and SLICER_CTL_mask
            end If
        else
            read_SLICER_CTL_value = data_low and SLICER_CTL_mask
        end If

    End Sub

    Sub write
        If flag_EN_FFE_TE_FORCE_DEASSERT = &H0 or flag_EN_FFE_TE_FORCE_ASSERT = &H0 or flag_LOC_TRAIN_FORCE_DEASSERT = &H0 or flag_LOC_TRAIN_FORCE_ASSERT = &H0 or flag_SLCTL_OVERRIDE = &H0 or flag_SLICER_CTL = &H0 Then read
        If flag_EN_FFE_TE_FORCE_DEASSERT = &H0 Then write_EN_FFE_TE_FORCE_DEASSERT_value = get_EN_FFE_TE_FORCE_DEASSERT
        If flag_EN_FFE_TE_FORCE_ASSERT = &H0 Then write_EN_FFE_TE_FORCE_ASSERT_value = get_EN_FFE_TE_FORCE_ASSERT
        If flag_LOC_TRAIN_FORCE_DEASSERT = &H0 Then write_LOC_TRAIN_FORCE_DEASSERT_value = get_LOC_TRAIN_FORCE_DEASSERT
        If flag_LOC_TRAIN_FORCE_ASSERT = &H0 Then write_LOC_TRAIN_FORCE_ASSERT_value = get_LOC_TRAIN_FORCE_ASSERT
        If flag_SLCTL_OVERRIDE = &H0 Then write_SLCTL_OVERRIDE_value = get_SLCTL_OVERRIDE
        If flag_SLICER_CTL = &H0 Then write_SLICER_CTL_value = get_SLICER_CTL

        regValue = leftShift((write_EN_FFE_TE_FORCE_DEASSERT_value and &H1), 6) + leftShift((write_EN_FFE_TE_FORCE_ASSERT_value and &H1), 5) + leftShift((write_LOC_TRAIN_FORCE_DEASSERT_value and &H1), 4) + leftShift((write_LOC_TRAIN_FORCE_ASSERT_value and &H1), 3) + leftShift((write_SLCTL_OVERRIDE_value and &H1), 2) + leftShift((write_SLICER_CTL_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_EN_FFE_TE_FORCE_DEASSERT_value = rightShift(data_low, 6) and &H1
        read_EN_FFE_TE_FORCE_ASSERT_value = rightShift(data_low, 5) and &H1
        read_LOC_TRAIN_FORCE_DEASSERT_value = rightShift(data_low, 4) and &H1
        read_LOC_TRAIN_FORCE_ASSERT_value = rightShift(data_low, 3) and &H1
        read_SLCTL_OVERRIDE_value = rightShift(data_low, 2) and &H1
        SLICER_CTL_mask = &H3
        if data_low > LONG_MAX then
            if SLICER_CTL_mask = mask then
                read_SLICER_CTL_value = data_low
            else
                read_SLICER_CTL_value = (data_low - H8000_0000) and SLICER_CTL_mask
            end If
        else
            read_SLICER_CTL_value = data_low and SLICER_CTL_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_EN_FFE_TE_FORCE_DEASSERT_value = &H0
        flag_EN_FFE_TE_FORCE_DEASSERT        = &H0
        write_EN_FFE_TE_FORCE_ASSERT_value = &H0
        flag_EN_FFE_TE_FORCE_ASSERT        = &H0
        write_LOC_TRAIN_FORCE_DEASSERT_value = &H0
        flag_LOC_TRAIN_FORCE_DEASSERT        = &H0
        write_LOC_TRAIN_FORCE_ASSERT_value = &H0
        flag_LOC_TRAIN_FORCE_ASSERT        = &H0
        write_SLCTL_OVERRIDE_value = &H0
        flag_SLCTL_OVERRIDE        = &H0
        write_SLICER_CTL_value = &H0
        flag_SLICER_CTL        = &H0
    End Sub
End Class


'' @REGISTER : DSP_TOP_agc_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PGA_1GBT_COARSE                            [10:6]           get_PGA_1GBT_COARSE
''                                                             set_PGA_1GBT_COARSE
''                                                             read_PGA_1GBT_COARSE
''                                                             write_PGA_1GBT_COARSE
''---------------------------------------------------------------------------------
'' PGA_1GBT_FINE                              [5:0]            get_PGA_1GBT_FINE
''                                                             set_PGA_1GBT_FINE
''                                                             read_PGA_1GBT_FINE
''                                                             write_PGA_1GBT_FINE
''---------------------------------------------------------------------------------
Class REGISTER_DSP_TOP_agc_status
    Private write_PGA_1GBT_COARSE_value
    Private read_PGA_1GBT_COARSE_value
    Private flag_PGA_1GBT_COARSE
    Private write_PGA_1GBT_FINE_value
    Private read_PGA_1GBT_FINE_value
    Private flag_PGA_1GBT_FINE

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

    Property Get get_PGA_1GBT_COARSE
        get_PGA_1GBT_COARSE = read_PGA_1GBT_COARSE_value
    End Property

    Property Let set_PGA_1GBT_COARSE(aData)
        write_PGA_1GBT_COARSE_value = aData
        flag_PGA_1GBT_COARSE        = &H1
    End Property

    Property Get read_PGA_1GBT_COARSE
        read
        read_PGA_1GBT_COARSE = read_PGA_1GBT_COARSE_value
    End Property

    Property Let write_PGA_1GBT_COARSE(aData)
        set_PGA_1GBT_COARSE = aData
        write
    End Property

    Property Get get_PGA_1GBT_FINE
        get_PGA_1GBT_FINE = read_PGA_1GBT_FINE_value
    End Property

    Property Let set_PGA_1GBT_FINE(aData)
        write_PGA_1GBT_FINE_value = aData
        flag_PGA_1GBT_FINE        = &H1
    End Property

    Property Get read_PGA_1GBT_FINE
        read
        read_PGA_1GBT_FINE = read_PGA_1GBT_FINE_value
    End Property

    Property Let write_PGA_1GBT_FINE(aData)
        set_PGA_1GBT_FINE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PGA_1GBT_COARSE_value = rightShift(data_low, 6) and &H1f
        PGA_1GBT_FINE_mask = &H3f
        if data_low > LONG_MAX then
            if PGA_1GBT_FINE_mask = mask then
                read_PGA_1GBT_FINE_value = data_low
            else
                read_PGA_1GBT_FINE_value = (data_low - H8000_0000) and PGA_1GBT_FINE_mask
            end If
        else
            read_PGA_1GBT_FINE_value = data_low and PGA_1GBT_FINE_mask
        end If

    End Sub

    Sub write
        If flag_PGA_1GBT_COARSE = &H0 or flag_PGA_1GBT_FINE = &H0 Then read
        If flag_PGA_1GBT_COARSE = &H0 Then write_PGA_1GBT_COARSE_value = get_PGA_1GBT_COARSE
        If flag_PGA_1GBT_FINE = &H0 Then write_PGA_1GBT_FINE_value = get_PGA_1GBT_FINE

        regValue = leftShift((write_PGA_1GBT_COARSE_value and &H1f), 6) + leftShift((write_PGA_1GBT_FINE_value and &H3f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PGA_1GBT_COARSE_value = rightShift(data_low, 6) and &H1f
        PGA_1GBT_FINE_mask = &H3f
        if data_low > LONG_MAX then
            if PGA_1GBT_FINE_mask = mask then
                read_PGA_1GBT_FINE_value = data_low
            else
                read_PGA_1GBT_FINE_value = (data_low - H8000_0000) and PGA_1GBT_FINE_mask
            end If
        else
            read_PGA_1GBT_FINE_value = data_low and PGA_1GBT_FINE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PGA_1GBT_COARSE_value = &H0
        flag_PGA_1GBT_COARSE        = &H0
        write_PGA_1GBT_FINE_value = &H0
        flag_PGA_1GBT_FINE        = &H0
    End Sub
End Class


'' @REGISTER : DSP_TOP_phshft_control
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MAN_OFFSET_CONTINUOUS                      [11:11]          get_MAN_OFFSET_CONTINUOUS
''                                                             set_MAN_OFFSET_CONTINUOUS
''                                                             read_MAN_OFFSET_CONTINUOUS
''                                                             write_MAN_OFFSET_CONTINUOUS
''---------------------------------------------------------------------------------
'' PHSHFT_PEND_REQ_DIS                        [10:10]          get_PHSHFT_PEND_REQ_DIS
''                                                             set_PHSHFT_PEND_REQ_DIS
''                                                             read_PHSHFT_PEND_REQ_DIS
''                                                             write_PHSHFT_PEND_REQ_DIS
''---------------------------------------------------------------------------------
'' PHSHFT_1000_SLOW_RATE                      [9:9]            get_PHSHFT_1000_SLOW_RATE
''                                                             set_PHSHFT_1000_SLOW_RATE
''                                                             read_PHSHFT_1000_SLOW_RATE
''                                                             write_PHSHFT_1000_SLOW_RATE
''---------------------------------------------------------------------------------
'' PHSHFT_DIR_POL_100                         [8:8]            get_PHSHFT_DIR_POL_100
''                                                             set_PHSHFT_DIR_POL_100
''                                                             read_PHSHFT_DIR_POL_100
''                                                             write_PHSHFT_DIR_POL_100
''---------------------------------------------------------------------------------
'' PHSHFT_DIR_POL                             [7:7]            get_PHSHFT_DIR_POL
''                                                             set_PHSHFT_DIR_POL
''                                                             read_PHSHFT_DIR_POL
''                                                             write_PHSHFT_DIR_POL
''---------------------------------------------------------------------------------
'' PHSHFT_MAN_MODE                            [6:6]            get_PHSHFT_MAN_MODE
''                                                             set_PHSHFT_MAN_MODE
''                                                             read_PHSHFT_MAN_MODE
''                                                             write_PHSHFT_MAN_MODE
''---------------------------------------------------------------------------------
'' MAN_OFFSET_REQ                             [5:5]            get_MAN_OFFSET_REQ
''                                                             set_MAN_OFFSET_REQ
''                                                             read_MAN_OFFSET_REQ
''                                                             write_MAN_OFFSET_REQ
''---------------------------------------------------------------------------------
'' MAN_OFFSET_DIR                             [4:4]            get_MAN_OFFSET_DIR
''                                                             set_MAN_OFFSET_DIR
''                                                             read_MAN_OFFSET_DIR
''                                                             write_MAN_OFFSET_DIR
''---------------------------------------------------------------------------------
'' MAN_OFFSET_VAL                             [3:0]            get_MAN_OFFSET_VAL
''                                                             set_MAN_OFFSET_VAL
''                                                             read_MAN_OFFSET_VAL
''                                                             write_MAN_OFFSET_VAL
''---------------------------------------------------------------------------------
Class REGISTER_DSP_TOP_phshft_control
    Private write_MAN_OFFSET_CONTINUOUS_value
    Private read_MAN_OFFSET_CONTINUOUS_value
    Private flag_MAN_OFFSET_CONTINUOUS
    Private write_PHSHFT_PEND_REQ_DIS_value
    Private read_PHSHFT_PEND_REQ_DIS_value
    Private flag_PHSHFT_PEND_REQ_DIS
    Private write_PHSHFT_1000_SLOW_RATE_value
    Private read_PHSHFT_1000_SLOW_RATE_value
    Private flag_PHSHFT_1000_SLOW_RATE
    Private write_PHSHFT_DIR_POL_100_value
    Private read_PHSHFT_DIR_POL_100_value
    Private flag_PHSHFT_DIR_POL_100
    Private write_PHSHFT_DIR_POL_value
    Private read_PHSHFT_DIR_POL_value
    Private flag_PHSHFT_DIR_POL
    Private write_PHSHFT_MAN_MODE_value
    Private read_PHSHFT_MAN_MODE_value
    Private flag_PHSHFT_MAN_MODE
    Private write_MAN_OFFSET_REQ_value
    Private read_MAN_OFFSET_REQ_value
    Private flag_MAN_OFFSET_REQ
    Private write_MAN_OFFSET_DIR_value
    Private read_MAN_OFFSET_DIR_value
    Private flag_MAN_OFFSET_DIR
    Private write_MAN_OFFSET_VAL_value
    Private read_MAN_OFFSET_VAL_value
    Private flag_MAN_OFFSET_VAL

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

    Property Get get_MAN_OFFSET_CONTINUOUS
        get_MAN_OFFSET_CONTINUOUS = read_MAN_OFFSET_CONTINUOUS_value
    End Property

    Property Let set_MAN_OFFSET_CONTINUOUS(aData)
        write_MAN_OFFSET_CONTINUOUS_value = aData
        flag_MAN_OFFSET_CONTINUOUS        = &H1
    End Property

    Property Get read_MAN_OFFSET_CONTINUOUS
        read
        read_MAN_OFFSET_CONTINUOUS = read_MAN_OFFSET_CONTINUOUS_value
    End Property

    Property Let write_MAN_OFFSET_CONTINUOUS(aData)
        set_MAN_OFFSET_CONTINUOUS = aData
        write
    End Property

    Property Get get_PHSHFT_PEND_REQ_DIS
        get_PHSHFT_PEND_REQ_DIS = read_PHSHFT_PEND_REQ_DIS_value
    End Property

    Property Let set_PHSHFT_PEND_REQ_DIS(aData)
        write_PHSHFT_PEND_REQ_DIS_value = aData
        flag_PHSHFT_PEND_REQ_DIS        = &H1
    End Property

    Property Get read_PHSHFT_PEND_REQ_DIS
        read
        read_PHSHFT_PEND_REQ_DIS = read_PHSHFT_PEND_REQ_DIS_value
    End Property

    Property Let write_PHSHFT_PEND_REQ_DIS(aData)
        set_PHSHFT_PEND_REQ_DIS = aData
        write
    End Property

    Property Get get_PHSHFT_1000_SLOW_RATE
        get_PHSHFT_1000_SLOW_RATE = read_PHSHFT_1000_SLOW_RATE_value
    End Property

    Property Let set_PHSHFT_1000_SLOW_RATE(aData)
        write_PHSHFT_1000_SLOW_RATE_value = aData
        flag_PHSHFT_1000_SLOW_RATE        = &H1
    End Property

    Property Get read_PHSHFT_1000_SLOW_RATE
        read
        read_PHSHFT_1000_SLOW_RATE = read_PHSHFT_1000_SLOW_RATE_value
    End Property

    Property Let write_PHSHFT_1000_SLOW_RATE(aData)
        set_PHSHFT_1000_SLOW_RATE = aData
        write
    End Property

    Property Get get_PHSHFT_DIR_POL_100
        get_PHSHFT_DIR_POL_100 = read_PHSHFT_DIR_POL_100_value
    End Property

    Property Let set_PHSHFT_DIR_POL_100(aData)
        write_PHSHFT_DIR_POL_100_value = aData
        flag_PHSHFT_DIR_POL_100        = &H1
    End Property

    Property Get read_PHSHFT_DIR_POL_100
        read
        read_PHSHFT_DIR_POL_100 = read_PHSHFT_DIR_POL_100_value
    End Property

    Property Let write_PHSHFT_DIR_POL_100(aData)
        set_PHSHFT_DIR_POL_100 = aData
        write
    End Property

    Property Get get_PHSHFT_DIR_POL
        get_PHSHFT_DIR_POL = read_PHSHFT_DIR_POL_value
    End Property

    Property Let set_PHSHFT_DIR_POL(aData)
        write_PHSHFT_DIR_POL_value = aData
        flag_PHSHFT_DIR_POL        = &H1
    End Property

    Property Get read_PHSHFT_DIR_POL
        read
        read_PHSHFT_DIR_POL = read_PHSHFT_DIR_POL_value
    End Property

    Property Let write_PHSHFT_DIR_POL(aData)
        set_PHSHFT_DIR_POL = aData
        write
    End Property

    Property Get get_PHSHFT_MAN_MODE
        get_PHSHFT_MAN_MODE = read_PHSHFT_MAN_MODE_value
    End Property

    Property Let set_PHSHFT_MAN_MODE(aData)
        write_PHSHFT_MAN_MODE_value = aData
        flag_PHSHFT_MAN_MODE        = &H1
    End Property

    Property Get read_PHSHFT_MAN_MODE
        read
        read_PHSHFT_MAN_MODE = read_PHSHFT_MAN_MODE_value
    End Property

    Property Let write_PHSHFT_MAN_MODE(aData)
        set_PHSHFT_MAN_MODE = aData
        write
    End Property

    Property Get get_MAN_OFFSET_REQ
        get_MAN_OFFSET_REQ = read_MAN_OFFSET_REQ_value
    End Property

    Property Let set_MAN_OFFSET_REQ(aData)
        write_MAN_OFFSET_REQ_value = aData
        flag_MAN_OFFSET_REQ        = &H1
    End Property

    Property Get read_MAN_OFFSET_REQ
        read
        read_MAN_OFFSET_REQ = read_MAN_OFFSET_REQ_value
    End Property

    Property Let write_MAN_OFFSET_REQ(aData)
        set_MAN_OFFSET_REQ = aData
        write
    End Property

    Property Get get_MAN_OFFSET_DIR
        get_MAN_OFFSET_DIR = read_MAN_OFFSET_DIR_value
    End Property

    Property Let set_MAN_OFFSET_DIR(aData)
        write_MAN_OFFSET_DIR_value = aData
        flag_MAN_OFFSET_DIR        = &H1
    End Property

    Property Get read_MAN_OFFSET_DIR
        read
        read_MAN_OFFSET_DIR = read_MAN_OFFSET_DIR_value
    End Property

    Property Let write_MAN_OFFSET_DIR(aData)
        set_MAN_OFFSET_DIR = aData
        write
    End Property

    Property Get get_MAN_OFFSET_VAL
        get_MAN_OFFSET_VAL = read_MAN_OFFSET_VAL_value
    End Property

    Property Let set_MAN_OFFSET_VAL(aData)
        write_MAN_OFFSET_VAL_value = aData
        flag_MAN_OFFSET_VAL        = &H1
    End Property

    Property Get read_MAN_OFFSET_VAL
        read
        read_MAN_OFFSET_VAL = read_MAN_OFFSET_VAL_value
    End Property

    Property Let write_MAN_OFFSET_VAL(aData)
        set_MAN_OFFSET_VAL = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MAN_OFFSET_CONTINUOUS_value = rightShift(data_low, 11) and &H1
        read_PHSHFT_PEND_REQ_DIS_value = rightShift(data_low, 10) and &H1
        read_PHSHFT_1000_SLOW_RATE_value = rightShift(data_low, 9) and &H1
        read_PHSHFT_DIR_POL_100_value = rightShift(data_low, 8) and &H1
        read_PHSHFT_DIR_POL_value = rightShift(data_low, 7) and &H1
        read_PHSHFT_MAN_MODE_value = rightShift(data_low, 6) and &H1
        read_MAN_OFFSET_REQ_value = rightShift(data_low, 5) and &H1
        read_MAN_OFFSET_DIR_value = rightShift(data_low, 4) and &H1
        MAN_OFFSET_VAL_mask = &Hf
        if data_low > LONG_MAX then
            if MAN_OFFSET_VAL_mask = mask then
                read_MAN_OFFSET_VAL_value = data_low
            else
                read_MAN_OFFSET_VAL_value = (data_low - H8000_0000) and MAN_OFFSET_VAL_mask
            end If
        else
            read_MAN_OFFSET_VAL_value = data_low and MAN_OFFSET_VAL_mask
        end If

    End Sub

    Sub write
        If flag_MAN_OFFSET_CONTINUOUS = &H0 or flag_PHSHFT_PEND_REQ_DIS = &H0 or flag_PHSHFT_1000_SLOW_RATE = &H0 or flag_PHSHFT_DIR_POL_100 = &H0 or flag_PHSHFT_DIR_POL = &H0 or flag_PHSHFT_MAN_MODE = &H0 or flag_MAN_OFFSET_REQ = &H0 or flag_MAN_OFFSET_DIR = &H0 or flag_MAN_OFFSET_VAL = &H0 Then read
        If flag_MAN_OFFSET_CONTINUOUS = &H0 Then write_MAN_OFFSET_CONTINUOUS_value = get_MAN_OFFSET_CONTINUOUS
        If flag_PHSHFT_PEND_REQ_DIS = &H0 Then write_PHSHFT_PEND_REQ_DIS_value = get_PHSHFT_PEND_REQ_DIS
        If flag_PHSHFT_1000_SLOW_RATE = &H0 Then write_PHSHFT_1000_SLOW_RATE_value = get_PHSHFT_1000_SLOW_RATE
        If flag_PHSHFT_DIR_POL_100 = &H0 Then write_PHSHFT_DIR_POL_100_value = get_PHSHFT_DIR_POL_100
        If flag_PHSHFT_DIR_POL = &H0 Then write_PHSHFT_DIR_POL_value = get_PHSHFT_DIR_POL
        If flag_PHSHFT_MAN_MODE = &H0 Then write_PHSHFT_MAN_MODE_value = get_PHSHFT_MAN_MODE
        If flag_MAN_OFFSET_REQ = &H0 Then write_MAN_OFFSET_REQ_value = get_MAN_OFFSET_REQ
        If flag_MAN_OFFSET_DIR = &H0 Then write_MAN_OFFSET_DIR_value = get_MAN_OFFSET_DIR
        If flag_MAN_OFFSET_VAL = &H0 Then write_MAN_OFFSET_VAL_value = get_MAN_OFFSET_VAL

        regValue = leftShift((write_MAN_OFFSET_CONTINUOUS_value and &H1), 11) + leftShift((write_PHSHFT_PEND_REQ_DIS_value and &H1), 10) + leftShift((write_PHSHFT_1000_SLOW_RATE_value and &H1), 9) + leftShift((write_PHSHFT_DIR_POL_100_value and &H1), 8) + leftShift((write_PHSHFT_DIR_POL_value and &H1), 7) + leftShift((write_PHSHFT_MAN_MODE_value and &H1), 6) + leftShift((write_MAN_OFFSET_REQ_value and &H1), 5) + leftShift((write_MAN_OFFSET_DIR_value and &H1), 4) + leftShift((write_MAN_OFFSET_VAL_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MAN_OFFSET_CONTINUOUS_value = rightShift(data_low, 11) and &H1
        read_PHSHFT_PEND_REQ_DIS_value = rightShift(data_low, 10) and &H1
        read_PHSHFT_1000_SLOW_RATE_value = rightShift(data_low, 9) and &H1
        read_PHSHFT_DIR_POL_100_value = rightShift(data_low, 8) and &H1
        read_PHSHFT_DIR_POL_value = rightShift(data_low, 7) and &H1
        read_PHSHFT_MAN_MODE_value = rightShift(data_low, 6) and &H1
        read_MAN_OFFSET_REQ_value = rightShift(data_low, 5) and &H1
        read_MAN_OFFSET_DIR_value = rightShift(data_low, 4) and &H1
        MAN_OFFSET_VAL_mask = &Hf
        if data_low > LONG_MAX then
            if MAN_OFFSET_VAL_mask = mask then
                read_MAN_OFFSET_VAL_value = data_low
            else
                read_MAN_OFFSET_VAL_value = (data_low - H8000_0000) and MAN_OFFSET_VAL_mask
            end If
        else
            read_MAN_OFFSET_VAL_value = data_low and MAN_OFFSET_VAL_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MAN_OFFSET_CONTINUOUS_value = &H0
        flag_MAN_OFFSET_CONTINUOUS        = &H0
        write_PHSHFT_PEND_REQ_DIS_value = &H0
        flag_PHSHFT_PEND_REQ_DIS        = &H0
        write_PHSHFT_1000_SLOW_RATE_value = &H0
        flag_PHSHFT_1000_SLOW_RATE        = &H0
        write_PHSHFT_DIR_POL_100_value = &H0
        flag_PHSHFT_DIR_POL_100        = &H0
        write_PHSHFT_DIR_POL_value = &H0
        flag_PHSHFT_DIR_POL        = &H0
        write_PHSHFT_MAN_MODE_value = &H0
        flag_PHSHFT_MAN_MODE        = &H0
        write_MAN_OFFSET_REQ_value = &H0
        flag_MAN_OFFSET_REQ        = &H0
        write_MAN_OFFSET_DIR_value = &H0
        flag_MAN_OFFSET_DIR        = &H0
        write_MAN_OFFSET_VAL_value = &H0
        flag_MAN_OFFSET_VAL        = &H0
    End Sub
End Class


'' @REGISTER : DSP_TOP_ted_dpll_control
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ZF_MM_EN                                   [13:13]          get_ZF_MM_EN
''                                                             set_ZF_MM_EN
''                                                             read_ZF_MM_EN
''                                                             write_ZF_MM_EN
''---------------------------------------------------------------------------------
'' CE_TERR_SCALE                              [12:10]          get_CE_TERR_SCALE
''                                                             set_CE_TERR_SCALE
''                                                             read_CE_TERR_SCALE
''                                                             write_CE_TERR_SCALE
''---------------------------------------------------------------------------------
'' BW_CNTL1                                   [9:8]            get_BW_CNTL1
''                                                             set_BW_CNTL1
''                                                             read_BW_CNTL1
''                                                             write_BW_CNTL1
''---------------------------------------------------------------------------------
'' BW_CNTL0                                   [7:6]            get_BW_CNTL0
''                                                             set_BW_CNTL0
''                                                             read_BW_CNTL0
''                                                             write_BW_CNTL0
''---------------------------------------------------------------------------------
'' DPLL_KP                                    [5:4]            get_DPLL_KP
''                                                             set_DPLL_KP
''                                                             read_DPLL_KP
''                                                             write_DPLL_KP
''---------------------------------------------------------------------------------
'' DPLL_G1                                    [2:2]            get_DPLL_G1
''                                                             set_DPLL_G1
''                                                             read_DPLL_G1
''                                                             write_DPLL_G1
''---------------------------------------------------------------------------------
'' DPLL_G2                                    [1:0]            get_DPLL_G2
''                                                             set_DPLL_G2
''                                                             read_DPLL_G2
''                                                             write_DPLL_G2
''---------------------------------------------------------------------------------
Class REGISTER_DSP_TOP_ted_dpll_control
    Private write_ZF_MM_EN_value
    Private read_ZF_MM_EN_value
    Private flag_ZF_MM_EN
    Private write_CE_TERR_SCALE_value
    Private read_CE_TERR_SCALE_value
    Private flag_CE_TERR_SCALE
    Private write_BW_CNTL1_value
    Private read_BW_CNTL1_value
    Private flag_BW_CNTL1
    Private write_BW_CNTL0_value
    Private read_BW_CNTL0_value
    Private flag_BW_CNTL0
    Private write_DPLL_KP_value
    Private read_DPLL_KP_value
    Private flag_DPLL_KP
    Private write_DPLL_G1_value
    Private read_DPLL_G1_value
    Private flag_DPLL_G1
    Private write_DPLL_G2_value
    Private read_DPLL_G2_value
    Private flag_DPLL_G2

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

    Property Get get_ZF_MM_EN
        get_ZF_MM_EN = read_ZF_MM_EN_value
    End Property

    Property Let set_ZF_MM_EN(aData)
        write_ZF_MM_EN_value = aData
        flag_ZF_MM_EN        = &H1
    End Property

    Property Get read_ZF_MM_EN
        read
        read_ZF_MM_EN = read_ZF_MM_EN_value
    End Property

    Property Let write_ZF_MM_EN(aData)
        set_ZF_MM_EN = aData
        write
    End Property

    Property Get get_CE_TERR_SCALE
        get_CE_TERR_SCALE = read_CE_TERR_SCALE_value
    End Property

    Property Let set_CE_TERR_SCALE(aData)
        write_CE_TERR_SCALE_value = aData
        flag_CE_TERR_SCALE        = &H1
    End Property

    Property Get read_CE_TERR_SCALE
        read
        read_CE_TERR_SCALE = read_CE_TERR_SCALE_value
    End Property

    Property Let write_CE_TERR_SCALE(aData)
        set_CE_TERR_SCALE = aData
        write
    End Property

    Property Get get_BW_CNTL1
        get_BW_CNTL1 = read_BW_CNTL1_value
    End Property

    Property Let set_BW_CNTL1(aData)
        write_BW_CNTL1_value = aData
        flag_BW_CNTL1        = &H1
    End Property

    Property Get read_BW_CNTL1
        read
        read_BW_CNTL1 = read_BW_CNTL1_value
    End Property

    Property Let write_BW_CNTL1(aData)
        set_BW_CNTL1 = aData
        write
    End Property

    Property Get get_BW_CNTL0
        get_BW_CNTL0 = read_BW_CNTL0_value
    End Property

    Property Let set_BW_CNTL0(aData)
        write_BW_CNTL0_value = aData
        flag_BW_CNTL0        = &H1
    End Property

    Property Get read_BW_CNTL0
        read
        read_BW_CNTL0 = read_BW_CNTL0_value
    End Property

    Property Let write_BW_CNTL0(aData)
        set_BW_CNTL0 = aData
        write
    End Property

    Property Get get_DPLL_KP
        get_DPLL_KP = read_DPLL_KP_value
    End Property

    Property Let set_DPLL_KP(aData)
        write_DPLL_KP_value = aData
        flag_DPLL_KP        = &H1
    End Property

    Property Get read_DPLL_KP
        read
        read_DPLL_KP = read_DPLL_KP_value
    End Property

    Property Let write_DPLL_KP(aData)
        set_DPLL_KP = aData
        write
    End Property

    Property Get get_DPLL_G1
        get_DPLL_G1 = read_DPLL_G1_value
    End Property

    Property Let set_DPLL_G1(aData)
        write_DPLL_G1_value = aData
        flag_DPLL_G1        = &H1
    End Property

    Property Get read_DPLL_G1
        read
        read_DPLL_G1 = read_DPLL_G1_value
    End Property

    Property Let write_DPLL_G1(aData)
        set_DPLL_G1 = aData
        write
    End Property

    Property Get get_DPLL_G2
        get_DPLL_G2 = read_DPLL_G2_value
    End Property

    Property Let set_DPLL_G2(aData)
        write_DPLL_G2_value = aData
        flag_DPLL_G2        = &H1
    End Property

    Property Get read_DPLL_G2
        read
        read_DPLL_G2 = read_DPLL_G2_value
    End Property

    Property Let write_DPLL_G2(aData)
        set_DPLL_G2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ZF_MM_EN_value = rightShift(data_low, 13) and &H1
        read_CE_TERR_SCALE_value = rightShift(data_low, 10) and &H7
        read_BW_CNTL1_value = rightShift(data_low, 8) and &H3
        read_BW_CNTL0_value = rightShift(data_low, 6) and &H3
        read_DPLL_KP_value = rightShift(data_low, 4) and &H3
        read_DPLL_G1_value = rightShift(data_low, 2) and &H1
        DPLL_G2_mask = &H3
        if data_low > LONG_MAX then
            if DPLL_G2_mask = mask then
                read_DPLL_G2_value = data_low
            else
                read_DPLL_G2_value = (data_low - H8000_0000) and DPLL_G2_mask
            end If
        else
            read_DPLL_G2_value = data_low and DPLL_G2_mask
        end If

    End Sub

    Sub write
        If flag_ZF_MM_EN = &H0 or flag_CE_TERR_SCALE = &H0 or flag_BW_CNTL1 = &H0 or flag_BW_CNTL0 = &H0 or flag_DPLL_KP = &H0 or flag_DPLL_G1 = &H0 or flag_DPLL_G2 = &H0 Then read
        If flag_ZF_MM_EN = &H0 Then write_ZF_MM_EN_value = get_ZF_MM_EN
        If flag_CE_TERR_SCALE = &H0 Then write_CE_TERR_SCALE_value = get_CE_TERR_SCALE
        If flag_BW_CNTL1 = &H0 Then write_BW_CNTL1_value = get_BW_CNTL1
        If flag_BW_CNTL0 = &H0 Then write_BW_CNTL0_value = get_BW_CNTL0
        If flag_DPLL_KP = &H0 Then write_DPLL_KP_value = get_DPLL_KP
        If flag_DPLL_G1 = &H0 Then write_DPLL_G1_value = get_DPLL_G1
        If flag_DPLL_G2 = &H0 Then write_DPLL_G2_value = get_DPLL_G2

        regValue = leftShift((write_ZF_MM_EN_value and &H1), 13) + leftShift((write_CE_TERR_SCALE_value and &H7), 10) + leftShift((write_BW_CNTL1_value and &H3), 8) + leftShift((write_BW_CNTL0_value and &H3), 6) + leftShift((write_DPLL_KP_value and &H3), 4) + leftShift((write_DPLL_G1_value and &H1), 2) + leftShift((write_DPLL_G2_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ZF_MM_EN_value = rightShift(data_low, 13) and &H1
        read_CE_TERR_SCALE_value = rightShift(data_low, 10) and &H7
        read_BW_CNTL1_value = rightShift(data_low, 8) and &H3
        read_BW_CNTL0_value = rightShift(data_low, 6) and &H3
        read_DPLL_KP_value = rightShift(data_low, 4) and &H3
        read_DPLL_G1_value = rightShift(data_low, 2) and &H1
        DPLL_G2_mask = &H3
        if data_low > LONG_MAX then
            if DPLL_G2_mask = mask then
                read_DPLL_G2_value = data_low
            else
                read_DPLL_G2_value = (data_low - H8000_0000) and DPLL_G2_mask
            end If
        else
            read_DPLL_G2_value = data_low and DPLL_G2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ZF_MM_EN_value = &H0
        flag_ZF_MM_EN        = &H0
        write_CE_TERR_SCALE_value = &H0
        flag_CE_TERR_SCALE        = &H0
        write_BW_CNTL1_value = &H0
        flag_BW_CNTL1        = &H0
        write_BW_CNTL0_value = &H0
        flag_BW_CNTL0        = &H0
        write_DPLL_KP_value = &H0
        flag_DPLL_KP        = &H0
        write_DPLL_G1_value = &H0
        flag_DPLL_G1        = &H0
        write_DPLL_G2_value = &H0
        flag_DPLL_G2        = &H0
    End Sub
End Class


'' @REGISTER : DSP_TOP_agc_100_ref_lvl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' AGC_100_REF_LVL                            [6:0]            get_AGC_100_REF_LVL
''                                                             set_AGC_100_REF_LVL
''                                                             read_AGC_100_REF_LVL
''                                                             write_AGC_100_REF_LVL
''---------------------------------------------------------------------------------
Class REGISTER_DSP_TOP_agc_100_ref_lvl
    Private write_AGC_100_REF_LVL_value
    Private read_AGC_100_REF_LVL_value
    Private flag_AGC_100_REF_LVL

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

    Property Get get_AGC_100_REF_LVL
        get_AGC_100_REF_LVL = read_AGC_100_REF_LVL_value
    End Property

    Property Let set_AGC_100_REF_LVL(aData)
        write_AGC_100_REF_LVL_value = aData
        flag_AGC_100_REF_LVL        = &H1
    End Property

    Property Get read_AGC_100_REF_LVL
        read
        read_AGC_100_REF_LVL = read_AGC_100_REF_LVL_value
    End Property

    Property Let write_AGC_100_REF_LVL(aData)
        set_AGC_100_REF_LVL = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        AGC_100_REF_LVL_mask = &H7f
        if data_low > LONG_MAX then
            if AGC_100_REF_LVL_mask = mask then
                read_AGC_100_REF_LVL_value = data_low
            else
                read_AGC_100_REF_LVL_value = (data_low - H8000_0000) and AGC_100_REF_LVL_mask
            end If
        else
            read_AGC_100_REF_LVL_value = data_low and AGC_100_REF_LVL_mask
        end If

    End Sub

    Sub write
        If flag_AGC_100_REF_LVL = &H0 Then read
        If flag_AGC_100_REF_LVL = &H0 Then write_AGC_100_REF_LVL_value = get_AGC_100_REF_LVL

        regValue = leftShift((write_AGC_100_REF_LVL_value and &H7f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        AGC_100_REF_LVL_mask = &H7f
        if data_low > LONG_MAX then
            if AGC_100_REF_LVL_mask = mask then
                read_AGC_100_REF_LVL_value = data_low
            else
                read_AGC_100_REF_LVL_value = (data_low - H8000_0000) and AGC_100_REF_LVL_mask
            end If
        else
            read_AGC_100_REF_LVL_value = data_low and AGC_100_REF_LVL_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_AGC_100_REF_LVL_value = &H0
        flag_AGC_100_REF_LVL        = &H0
    End Sub
End Class


'' @REGISTER : DSP_TOP_agc_100_override_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' FAGCSCALE_100                              [13:12]          get_FAGCSCALE_100
''                                                             set_FAGCSCALE_100
''                                                             read_FAGCSCALE_100
''                                                             write_FAGCSCALE_100
''---------------------------------------------------------------------------------
'' AGC_PWRSAVE_DIS_100                        [10:10]          get_AGC_PWRSAVE_DIS_100
''                                                             set_AGC_PWRSAVE_DIS_100
''                                                             read_AGC_PWRSAVE_DIS_100
''                                                             write_AGC_PWRSAVE_DIS_100
''---------------------------------------------------------------------------------
'' CAGCHIGEAR_OVR_VAL_100                     [9:9]            get_CAGCHIGEAR_OVR_VAL_100
''                                                             set_CAGCHIGEAR_OVR_VAL_100
''                                                             read_CAGCHIGEAR_OVR_VAL_100
''                                                             write_CAGCHIGEAR_OVR_VAL_100
''---------------------------------------------------------------------------------
'' CAGCHIGEAR_OVR_100                         [8:8]            get_CAGCHIGEAR_OVR_100
''                                                             set_CAGCHIGEAR_OVR_100
''                                                             read_CAGCHIGEAR_OVR_100
''                                                             write_CAGCHIGEAR_OVR_100
''---------------------------------------------------------------------------------
'' CAGCFRZ_OVR_VAL_100                        [7:7]            get_CAGCFRZ_OVR_VAL_100
''                                                             set_CAGCFRZ_OVR_VAL_100
''                                                             read_CAGCFRZ_OVR_VAL_100
''                                                             write_CAGCFRZ_OVR_VAL_100
''---------------------------------------------------------------------------------
'' CAGCFRZ_OVR_100                            [6:6]            get_CAGCFRZ_OVR_100
''                                                             set_CAGCFRZ_OVR_100
''                                                             read_CAGCFRZ_OVR_100
''                                                             write_CAGCFRZ_OVR_100
''---------------------------------------------------------------------------------
'' CAGCRST_OVR_VAL_100                        [5:5]            get_CAGCRST_OVR_VAL_100
''                                                             set_CAGCRST_OVR_VAL_100
''                                                             read_CAGCRST_OVR_VAL_100
''                                                             write_CAGCRST_OVR_VAL_100
''---------------------------------------------------------------------------------
'' CAGCRST_OVR_100                            [4:4]            get_CAGCRST_OVR_100
''                                                             set_CAGCRST_OVR_100
''                                                             read_CAGCRST_OVR_100
''                                                             write_CAGCRST_OVR_100
''---------------------------------------------------------------------------------
'' FAGCFRZ_OVR_VAL_100                        [3:3]            get_FAGCFRZ_OVR_VAL_100
''                                                             set_FAGCFRZ_OVR_VAL_100
''                                                             read_FAGCFRZ_OVR_VAL_100
''                                                             write_FAGCFRZ_OVR_VAL_100
''---------------------------------------------------------------------------------
'' FAGCFRZ_OVR_100                            [2:2]            get_FAGCFRZ_OVR_100
''                                                             set_FAGCFRZ_OVR_100
''                                                             read_FAGCFRZ_OVR_100
''                                                             write_FAGCFRZ_OVR_100
''---------------------------------------------------------------------------------
'' FAGCRST_OVR_VAL_100                        [1:1]            get_FAGCRST_OVR_VAL_100
''                                                             set_FAGCRST_OVR_VAL_100
''                                                             read_FAGCRST_OVR_VAL_100
''                                                             write_FAGCRST_OVR_VAL_100
''---------------------------------------------------------------------------------
'' FAGCRST_OVR_100                            [0:0]            get_FAGCRST_OVR_100
''                                                             set_FAGCRST_OVR_100
''                                                             read_FAGCRST_OVR_100
''                                                             write_FAGCRST_OVR_100
''---------------------------------------------------------------------------------
Class REGISTER_DSP_TOP_agc_100_override_0
    Private write_FAGCSCALE_100_value
    Private read_FAGCSCALE_100_value
    Private flag_FAGCSCALE_100
    Private write_AGC_PWRSAVE_DIS_100_value
    Private read_AGC_PWRSAVE_DIS_100_value
    Private flag_AGC_PWRSAVE_DIS_100
    Private write_CAGCHIGEAR_OVR_VAL_100_value
    Private read_CAGCHIGEAR_OVR_VAL_100_value
    Private flag_CAGCHIGEAR_OVR_VAL_100
    Private write_CAGCHIGEAR_OVR_100_value
    Private read_CAGCHIGEAR_OVR_100_value
    Private flag_CAGCHIGEAR_OVR_100
    Private write_CAGCFRZ_OVR_VAL_100_value
    Private read_CAGCFRZ_OVR_VAL_100_value
    Private flag_CAGCFRZ_OVR_VAL_100
    Private write_CAGCFRZ_OVR_100_value
    Private read_CAGCFRZ_OVR_100_value
    Private flag_CAGCFRZ_OVR_100
    Private write_CAGCRST_OVR_VAL_100_value
    Private read_CAGCRST_OVR_VAL_100_value
    Private flag_CAGCRST_OVR_VAL_100
    Private write_CAGCRST_OVR_100_value
    Private read_CAGCRST_OVR_100_value
    Private flag_CAGCRST_OVR_100
    Private write_FAGCFRZ_OVR_VAL_100_value
    Private read_FAGCFRZ_OVR_VAL_100_value
    Private flag_FAGCFRZ_OVR_VAL_100
    Private write_FAGCFRZ_OVR_100_value
    Private read_FAGCFRZ_OVR_100_value
    Private flag_FAGCFRZ_OVR_100
    Private write_FAGCRST_OVR_VAL_100_value
    Private read_FAGCRST_OVR_VAL_100_value
    Private flag_FAGCRST_OVR_VAL_100
    Private write_FAGCRST_OVR_100_value
    Private read_FAGCRST_OVR_100_value
    Private flag_FAGCRST_OVR_100

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

    Property Get get_FAGCSCALE_100
        get_FAGCSCALE_100 = read_FAGCSCALE_100_value
    End Property

    Property Let set_FAGCSCALE_100(aData)
        write_FAGCSCALE_100_value = aData
        flag_FAGCSCALE_100        = &H1
    End Property

    Property Get read_FAGCSCALE_100
        read
        read_FAGCSCALE_100 = read_FAGCSCALE_100_value
    End Property

    Property Let write_FAGCSCALE_100(aData)
        set_FAGCSCALE_100 = aData
        write
    End Property

    Property Get get_AGC_PWRSAVE_DIS_100
        get_AGC_PWRSAVE_DIS_100 = read_AGC_PWRSAVE_DIS_100_value
    End Property

    Property Let set_AGC_PWRSAVE_DIS_100(aData)
        write_AGC_PWRSAVE_DIS_100_value = aData
        flag_AGC_PWRSAVE_DIS_100        = &H1
    End Property

    Property Get read_AGC_PWRSAVE_DIS_100
        read
        read_AGC_PWRSAVE_DIS_100 = read_AGC_PWRSAVE_DIS_100_value
    End Property

    Property Let write_AGC_PWRSAVE_DIS_100(aData)
        set_AGC_PWRSAVE_DIS_100 = aData
        write
    End Property

    Property Get get_CAGCHIGEAR_OVR_VAL_100
        get_CAGCHIGEAR_OVR_VAL_100 = read_CAGCHIGEAR_OVR_VAL_100_value
    End Property

    Property Let set_CAGCHIGEAR_OVR_VAL_100(aData)
        write_CAGCHIGEAR_OVR_VAL_100_value = aData
        flag_CAGCHIGEAR_OVR_VAL_100        = &H1
    End Property

    Property Get read_CAGCHIGEAR_OVR_VAL_100
        read
        read_CAGCHIGEAR_OVR_VAL_100 = read_CAGCHIGEAR_OVR_VAL_100_value
    End Property

    Property Let write_CAGCHIGEAR_OVR_VAL_100(aData)
        set_CAGCHIGEAR_OVR_VAL_100 = aData
        write
    End Property

    Property Get get_CAGCHIGEAR_OVR_100
        get_CAGCHIGEAR_OVR_100 = read_CAGCHIGEAR_OVR_100_value
    End Property

    Property Let set_CAGCHIGEAR_OVR_100(aData)
        write_CAGCHIGEAR_OVR_100_value = aData
        flag_CAGCHIGEAR_OVR_100        = &H1
    End Property

    Property Get read_CAGCHIGEAR_OVR_100
        read
        read_CAGCHIGEAR_OVR_100 = read_CAGCHIGEAR_OVR_100_value
    End Property

    Property Let write_CAGCHIGEAR_OVR_100(aData)
        set_CAGCHIGEAR_OVR_100 = aData
        write
    End Property

    Property Get get_CAGCFRZ_OVR_VAL_100
        get_CAGCFRZ_OVR_VAL_100 = read_CAGCFRZ_OVR_VAL_100_value
    End Property

    Property Let set_CAGCFRZ_OVR_VAL_100(aData)
        write_CAGCFRZ_OVR_VAL_100_value = aData
        flag_CAGCFRZ_OVR_VAL_100        = &H1
    End Property

    Property Get read_CAGCFRZ_OVR_VAL_100
        read
        read_CAGCFRZ_OVR_VAL_100 = read_CAGCFRZ_OVR_VAL_100_value
    End Property

    Property Let write_CAGCFRZ_OVR_VAL_100(aData)
        set_CAGCFRZ_OVR_VAL_100 = aData
        write
    End Property

    Property Get get_CAGCFRZ_OVR_100
        get_CAGCFRZ_OVR_100 = read_CAGCFRZ_OVR_100_value
    End Property

    Property Let set_CAGCFRZ_OVR_100(aData)
        write_CAGCFRZ_OVR_100_value = aData
        flag_CAGCFRZ_OVR_100        = &H1
    End Property

    Property Get read_CAGCFRZ_OVR_100
        read
        read_CAGCFRZ_OVR_100 = read_CAGCFRZ_OVR_100_value
    End Property

    Property Let write_CAGCFRZ_OVR_100(aData)
        set_CAGCFRZ_OVR_100 = aData
        write
    End Property

    Property Get get_CAGCRST_OVR_VAL_100
        get_CAGCRST_OVR_VAL_100 = read_CAGCRST_OVR_VAL_100_value
    End Property

    Property Let set_CAGCRST_OVR_VAL_100(aData)
        write_CAGCRST_OVR_VAL_100_value = aData
        flag_CAGCRST_OVR_VAL_100        = &H1
    End Property

    Property Get read_CAGCRST_OVR_VAL_100
        read
        read_CAGCRST_OVR_VAL_100 = read_CAGCRST_OVR_VAL_100_value
    End Property

    Property Let write_CAGCRST_OVR_VAL_100(aData)
        set_CAGCRST_OVR_VAL_100 = aData
        write
    End Property

    Property Get get_CAGCRST_OVR_100
        get_CAGCRST_OVR_100 = read_CAGCRST_OVR_100_value
    End Property

    Property Let set_CAGCRST_OVR_100(aData)
        write_CAGCRST_OVR_100_value = aData
        flag_CAGCRST_OVR_100        = &H1
    End Property

    Property Get read_CAGCRST_OVR_100
        read
        read_CAGCRST_OVR_100 = read_CAGCRST_OVR_100_value
    End Property

    Property Let write_CAGCRST_OVR_100(aData)
        set_CAGCRST_OVR_100 = aData
        write
    End Property

    Property Get get_FAGCFRZ_OVR_VAL_100
        get_FAGCFRZ_OVR_VAL_100 = read_FAGCFRZ_OVR_VAL_100_value
    End Property

    Property Let set_FAGCFRZ_OVR_VAL_100(aData)
        write_FAGCFRZ_OVR_VAL_100_value = aData
        flag_FAGCFRZ_OVR_VAL_100        = &H1
    End Property

    Property Get read_FAGCFRZ_OVR_VAL_100
        read
        read_FAGCFRZ_OVR_VAL_100 = read_FAGCFRZ_OVR_VAL_100_value
    End Property

    Property Let write_FAGCFRZ_OVR_VAL_100(aData)
        set_FAGCFRZ_OVR_VAL_100 = aData
        write
    End Property

    Property Get get_FAGCFRZ_OVR_100
        get_FAGCFRZ_OVR_100 = read_FAGCFRZ_OVR_100_value
    End Property

    Property Let set_FAGCFRZ_OVR_100(aData)
        write_FAGCFRZ_OVR_100_value = aData
        flag_FAGCFRZ_OVR_100        = &H1
    End Property

    Property Get read_FAGCFRZ_OVR_100
        read
        read_FAGCFRZ_OVR_100 = read_FAGCFRZ_OVR_100_value
    End Property

    Property Let write_FAGCFRZ_OVR_100(aData)
        set_FAGCFRZ_OVR_100 = aData
        write
    End Property

    Property Get get_FAGCRST_OVR_VAL_100
        get_FAGCRST_OVR_VAL_100 = read_FAGCRST_OVR_VAL_100_value
    End Property

    Property Let set_FAGCRST_OVR_VAL_100(aData)
        write_FAGCRST_OVR_VAL_100_value = aData
        flag_FAGCRST_OVR_VAL_100        = &H1
    End Property

    Property Get read_FAGCRST_OVR_VAL_100
        read
        read_FAGCRST_OVR_VAL_100 = read_FAGCRST_OVR_VAL_100_value
    End Property

    Property Let write_FAGCRST_OVR_VAL_100(aData)
        set_FAGCRST_OVR_VAL_100 = aData
        write
    End Property

    Property Get get_FAGCRST_OVR_100
        get_FAGCRST_OVR_100 = read_FAGCRST_OVR_100_value
    End Property

    Property Let set_FAGCRST_OVR_100(aData)
        write_FAGCRST_OVR_100_value = aData
        flag_FAGCRST_OVR_100        = &H1
    End Property

    Property Get read_FAGCRST_OVR_100
        read
        read_FAGCRST_OVR_100 = read_FAGCRST_OVR_100_value
    End Property

    Property Let write_FAGCRST_OVR_100(aData)
        set_FAGCRST_OVR_100 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_FAGCSCALE_100_value = rightShift(data_low, 12) and &H3
        read_AGC_PWRSAVE_DIS_100_value = rightShift(data_low, 10) and &H1
        read_CAGCHIGEAR_OVR_VAL_100_value = rightShift(data_low, 9) and &H1
        read_CAGCHIGEAR_OVR_100_value = rightShift(data_low, 8) and &H1
        read_CAGCFRZ_OVR_VAL_100_value = rightShift(data_low, 7) and &H1
        read_CAGCFRZ_OVR_100_value = rightShift(data_low, 6) and &H1
        read_CAGCRST_OVR_VAL_100_value = rightShift(data_low, 5) and &H1
        read_CAGCRST_OVR_100_value = rightShift(data_low, 4) and &H1
        read_FAGCFRZ_OVR_VAL_100_value = rightShift(data_low, 3) and &H1
        read_FAGCFRZ_OVR_100_value = rightShift(data_low, 2) and &H1
        read_FAGCRST_OVR_VAL_100_value = rightShift(data_low, 1) and &H1
        FAGCRST_OVR_100_mask = &H1
        if data_low > LONG_MAX then
            if FAGCRST_OVR_100_mask = mask then
                read_FAGCRST_OVR_100_value = data_low
            else
                read_FAGCRST_OVR_100_value = (data_low - H8000_0000) and FAGCRST_OVR_100_mask
            end If
        else
            read_FAGCRST_OVR_100_value = data_low and FAGCRST_OVR_100_mask
        end If

    End Sub

    Sub write
        If flag_FAGCSCALE_100 = &H0 or flag_AGC_PWRSAVE_DIS_100 = &H0 or flag_CAGCHIGEAR_OVR_VAL_100 = &H0 or flag_CAGCHIGEAR_OVR_100 = &H0 or flag_CAGCFRZ_OVR_VAL_100 = &H0 or flag_CAGCFRZ_OVR_100 = &H0 or flag_CAGCRST_OVR_VAL_100 = &H0 or flag_CAGCRST_OVR_100 = &H0 or flag_FAGCFRZ_OVR_VAL_100 = &H0 or flag_FAGCFRZ_OVR_100 = &H0 or flag_FAGCRST_OVR_VAL_100 = &H0 or flag_FAGCRST_OVR_100 = &H0 Then read
        If flag_FAGCSCALE_100 = &H0 Then write_FAGCSCALE_100_value = get_FAGCSCALE_100
        If flag_AGC_PWRSAVE_DIS_100 = &H0 Then write_AGC_PWRSAVE_DIS_100_value = get_AGC_PWRSAVE_DIS_100
        If flag_CAGCHIGEAR_OVR_VAL_100 = &H0 Then write_CAGCHIGEAR_OVR_VAL_100_value = get_CAGCHIGEAR_OVR_VAL_100
        If flag_CAGCHIGEAR_OVR_100 = &H0 Then write_CAGCHIGEAR_OVR_100_value = get_CAGCHIGEAR_OVR_100
        If flag_CAGCFRZ_OVR_VAL_100 = &H0 Then write_CAGCFRZ_OVR_VAL_100_value = get_CAGCFRZ_OVR_VAL_100
        If flag_CAGCFRZ_OVR_100 = &H0 Then write_CAGCFRZ_OVR_100_value = get_CAGCFRZ_OVR_100
        If flag_CAGCRST_OVR_VAL_100 = &H0 Then write_CAGCRST_OVR_VAL_100_value = get_CAGCRST_OVR_VAL_100
        If flag_CAGCRST_OVR_100 = &H0 Then write_CAGCRST_OVR_100_value = get_CAGCRST_OVR_100
        If flag_FAGCFRZ_OVR_VAL_100 = &H0 Then write_FAGCFRZ_OVR_VAL_100_value = get_FAGCFRZ_OVR_VAL_100
        If flag_FAGCFRZ_OVR_100 = &H0 Then write_FAGCFRZ_OVR_100_value = get_FAGCFRZ_OVR_100
        If flag_FAGCRST_OVR_VAL_100 = &H0 Then write_FAGCRST_OVR_VAL_100_value = get_FAGCRST_OVR_VAL_100
        If flag_FAGCRST_OVR_100 = &H0 Then write_FAGCRST_OVR_100_value = get_FAGCRST_OVR_100

        regValue = leftShift((write_FAGCSCALE_100_value and &H3), 12) + leftShift((write_AGC_PWRSAVE_DIS_100_value and &H1), 10) + leftShift((write_CAGCHIGEAR_OVR_VAL_100_value and &H1), 9) + leftShift((write_CAGCHIGEAR_OVR_100_value and &H1), 8) + leftShift((write_CAGCFRZ_OVR_VAL_100_value and &H1), 7) + leftShift((write_CAGCFRZ_OVR_100_value and &H1), 6) + leftShift((write_CAGCRST_OVR_VAL_100_value and &H1), 5) + leftShift((write_CAGCRST_OVR_100_value and &H1), 4) + leftShift((write_FAGCFRZ_OVR_VAL_100_value and &H1), 3) + leftShift((write_FAGCFRZ_OVR_100_value and &H1), 2) + leftShift((write_FAGCRST_OVR_VAL_100_value and &H1), 1) + leftShift((write_FAGCRST_OVR_100_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_FAGCSCALE_100_value = rightShift(data_low, 12) and &H3
        read_AGC_PWRSAVE_DIS_100_value = rightShift(data_low, 10) and &H1
        read_CAGCHIGEAR_OVR_VAL_100_value = rightShift(data_low, 9) and &H1
        read_CAGCHIGEAR_OVR_100_value = rightShift(data_low, 8) and &H1
        read_CAGCFRZ_OVR_VAL_100_value = rightShift(data_low, 7) and &H1
        read_CAGCFRZ_OVR_100_value = rightShift(data_low, 6) and &H1
        read_CAGCRST_OVR_VAL_100_value = rightShift(data_low, 5) and &H1
        read_CAGCRST_OVR_100_value = rightShift(data_low, 4) and &H1
        read_FAGCFRZ_OVR_VAL_100_value = rightShift(data_low, 3) and &H1
        read_FAGCFRZ_OVR_100_value = rightShift(data_low, 2) and &H1
        read_FAGCRST_OVR_VAL_100_value = rightShift(data_low, 1) and &H1
        FAGCRST_OVR_100_mask = &H1
        if data_low > LONG_MAX then
            if FAGCRST_OVR_100_mask = mask then
                read_FAGCRST_OVR_100_value = data_low
            else
                read_FAGCRST_OVR_100_value = (data_low - H8000_0000) and FAGCRST_OVR_100_mask
            end If
        else
            read_FAGCRST_OVR_100_value = data_low and FAGCRST_OVR_100_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_FAGCSCALE_100_value = &H0
        flag_FAGCSCALE_100        = &H0
        write_AGC_PWRSAVE_DIS_100_value = &H0
        flag_AGC_PWRSAVE_DIS_100        = &H0
        write_CAGCHIGEAR_OVR_VAL_100_value = &H0
        flag_CAGCHIGEAR_OVR_VAL_100        = &H0
        write_CAGCHIGEAR_OVR_100_value = &H0
        flag_CAGCHIGEAR_OVR_100        = &H0
        write_CAGCFRZ_OVR_VAL_100_value = &H0
        flag_CAGCFRZ_OVR_VAL_100        = &H0
        write_CAGCFRZ_OVR_100_value = &H0
        flag_CAGCFRZ_OVR_100        = &H0
        write_CAGCRST_OVR_VAL_100_value = &H0
        flag_CAGCRST_OVR_VAL_100        = &H0
        write_CAGCRST_OVR_100_value = &H0
        flag_CAGCRST_OVR_100        = &H0
        write_FAGCFRZ_OVR_VAL_100_value = &H0
        flag_FAGCFRZ_OVR_VAL_100        = &H0
        write_FAGCFRZ_OVR_100_value = &H0
        flag_FAGCFRZ_OVR_100        = &H0
        write_FAGCRST_OVR_VAL_100_value = &H0
        flag_FAGCRST_OVR_VAL_100        = &H0
        write_FAGCRST_OVR_100_value = &H0
        flag_FAGCRST_OVR_100        = &H0
    End Sub
End Class


'' @REGISTER : DSP_TOP_agc_100_override_1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COARSE_GAIN_CTL_OVR_VAL_100                [7:1]            get_COARSE_GAIN_CTL_OVR_VAL_100
''                                                             set_COARSE_GAIN_CTL_OVR_VAL_100
''                                                             read_COARSE_GAIN_CTL_OVR_VAL_100
''                                                             write_COARSE_GAIN_CTL_OVR_VAL_100
''---------------------------------------------------------------------------------
'' COARSE_GAIN_CTL_OVR_100                    [0:0]            get_COARSE_GAIN_CTL_OVR_100
''                                                             set_COARSE_GAIN_CTL_OVR_100
''                                                             read_COARSE_GAIN_CTL_OVR_100
''                                                             write_COARSE_GAIN_CTL_OVR_100
''---------------------------------------------------------------------------------
Class REGISTER_DSP_TOP_agc_100_override_1
    Private write_COARSE_GAIN_CTL_OVR_VAL_100_value
    Private read_COARSE_GAIN_CTL_OVR_VAL_100_value
    Private flag_COARSE_GAIN_CTL_OVR_VAL_100
    Private write_COARSE_GAIN_CTL_OVR_100_value
    Private read_COARSE_GAIN_CTL_OVR_100_value
    Private flag_COARSE_GAIN_CTL_OVR_100

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

    Property Get get_COARSE_GAIN_CTL_OVR_VAL_100
        get_COARSE_GAIN_CTL_OVR_VAL_100 = read_COARSE_GAIN_CTL_OVR_VAL_100_value
    End Property

    Property Let set_COARSE_GAIN_CTL_OVR_VAL_100(aData)
        write_COARSE_GAIN_CTL_OVR_VAL_100_value = aData
        flag_COARSE_GAIN_CTL_OVR_VAL_100        = &H1
    End Property

    Property Get read_COARSE_GAIN_CTL_OVR_VAL_100
        read
        read_COARSE_GAIN_CTL_OVR_VAL_100 = read_COARSE_GAIN_CTL_OVR_VAL_100_value
    End Property

    Property Let write_COARSE_GAIN_CTL_OVR_VAL_100(aData)
        set_COARSE_GAIN_CTL_OVR_VAL_100 = aData
        write
    End Property

    Property Get get_COARSE_GAIN_CTL_OVR_100
        get_COARSE_GAIN_CTL_OVR_100 = read_COARSE_GAIN_CTL_OVR_100_value
    End Property

    Property Let set_COARSE_GAIN_CTL_OVR_100(aData)
        write_COARSE_GAIN_CTL_OVR_100_value = aData
        flag_COARSE_GAIN_CTL_OVR_100        = &H1
    End Property

    Property Get read_COARSE_GAIN_CTL_OVR_100
        read
        read_COARSE_GAIN_CTL_OVR_100 = read_COARSE_GAIN_CTL_OVR_100_value
    End Property

    Property Let write_COARSE_GAIN_CTL_OVR_100(aData)
        set_COARSE_GAIN_CTL_OVR_100 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_COARSE_GAIN_CTL_OVR_VAL_100_value = rightShift(data_low, 1) and &H7f
        COARSE_GAIN_CTL_OVR_100_mask = &H1
        if data_low > LONG_MAX then
            if COARSE_GAIN_CTL_OVR_100_mask = mask then
                read_COARSE_GAIN_CTL_OVR_100_value = data_low
            else
                read_COARSE_GAIN_CTL_OVR_100_value = (data_low - H8000_0000) and COARSE_GAIN_CTL_OVR_100_mask
            end If
        else
            read_COARSE_GAIN_CTL_OVR_100_value = data_low and COARSE_GAIN_CTL_OVR_100_mask
        end If

    End Sub

    Sub write
        If flag_COARSE_GAIN_CTL_OVR_VAL_100 = &H0 or flag_COARSE_GAIN_CTL_OVR_100 = &H0 Then read
        If flag_COARSE_GAIN_CTL_OVR_VAL_100 = &H0 Then write_COARSE_GAIN_CTL_OVR_VAL_100_value = get_COARSE_GAIN_CTL_OVR_VAL_100
        If flag_COARSE_GAIN_CTL_OVR_100 = &H0 Then write_COARSE_GAIN_CTL_OVR_100_value = get_COARSE_GAIN_CTL_OVR_100

        regValue = leftShift((write_COARSE_GAIN_CTL_OVR_VAL_100_value and &H7f), 1) + leftShift((write_COARSE_GAIN_CTL_OVR_100_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_COARSE_GAIN_CTL_OVR_VAL_100_value = rightShift(data_low, 1) and &H7f
        COARSE_GAIN_CTL_OVR_100_mask = &H1
        if data_low > LONG_MAX then
            if COARSE_GAIN_CTL_OVR_100_mask = mask then
                read_COARSE_GAIN_CTL_OVR_100_value = data_low
            else
                read_COARSE_GAIN_CTL_OVR_100_value = (data_low - H8000_0000) and COARSE_GAIN_CTL_OVR_100_mask
            end If
        else
            read_COARSE_GAIN_CTL_OVR_100_value = data_low and COARSE_GAIN_CTL_OVR_100_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COARSE_GAIN_CTL_OVR_VAL_100_value = &H0
        flag_COARSE_GAIN_CTL_OVR_VAL_100        = &H0
        write_COARSE_GAIN_CTL_OVR_100_value = &H0
        flag_COARSE_GAIN_CTL_OVR_100        = &H0
    End Sub
End Class


'' @REGISTER : DSP_TOP_agc_100_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COARSE_FREEZE_SMPC_100                     [8:8]            get_COARSE_FREEZE_SMPC_100
''                                                             set_COARSE_FREEZE_SMPC_100
''                                                             read_COARSE_FREEZE_SMPC_100
''                                                             write_COARSE_FREEZE_SMPC_100
''---------------------------------------------------------------------------------
'' AGC_OVERFLOW_100                           [7:7]            get_AGC_OVERFLOW_100
''                                                             set_AGC_OVERFLOW_100
''                                                             read_AGC_OVERFLOW_100
''                                                             write_AGC_OVERFLOW_100
''---------------------------------------------------------------------------------
'' PGA_100BT                                  [6:0]            get_PGA_100BT
''                                                             set_PGA_100BT
''                                                             read_PGA_100BT
''                                                             write_PGA_100BT
''---------------------------------------------------------------------------------
Class REGISTER_DSP_TOP_agc_100_status
    Private write_COARSE_FREEZE_SMPC_100_value
    Private read_COARSE_FREEZE_SMPC_100_value
    Private flag_COARSE_FREEZE_SMPC_100
    Private write_AGC_OVERFLOW_100_value
    Private read_AGC_OVERFLOW_100_value
    Private flag_AGC_OVERFLOW_100
    Private write_PGA_100BT_value
    Private read_PGA_100BT_value
    Private flag_PGA_100BT

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

    Property Get get_COARSE_FREEZE_SMPC_100
        get_COARSE_FREEZE_SMPC_100 = read_COARSE_FREEZE_SMPC_100_value
    End Property

    Property Let set_COARSE_FREEZE_SMPC_100(aData)
        write_COARSE_FREEZE_SMPC_100_value = aData
        flag_COARSE_FREEZE_SMPC_100        = &H1
    End Property

    Property Get read_COARSE_FREEZE_SMPC_100
        read
        read_COARSE_FREEZE_SMPC_100 = read_COARSE_FREEZE_SMPC_100_value
    End Property

    Property Let write_COARSE_FREEZE_SMPC_100(aData)
        set_COARSE_FREEZE_SMPC_100 = aData
        write
    End Property

    Property Get get_AGC_OVERFLOW_100
        get_AGC_OVERFLOW_100 = read_AGC_OVERFLOW_100_value
    End Property

    Property Let set_AGC_OVERFLOW_100(aData)
        write_AGC_OVERFLOW_100_value = aData
        flag_AGC_OVERFLOW_100        = &H1
    End Property

    Property Get read_AGC_OVERFLOW_100
        read
        read_AGC_OVERFLOW_100 = read_AGC_OVERFLOW_100_value
    End Property

    Property Let write_AGC_OVERFLOW_100(aData)
        set_AGC_OVERFLOW_100 = aData
        write
    End Property

    Property Get get_PGA_100BT
        get_PGA_100BT = read_PGA_100BT_value
    End Property

    Property Let set_PGA_100BT(aData)
        write_PGA_100BT_value = aData
        flag_PGA_100BT        = &H1
    End Property

    Property Get read_PGA_100BT
        read
        read_PGA_100BT = read_PGA_100BT_value
    End Property

    Property Let write_PGA_100BT(aData)
        set_PGA_100BT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_COARSE_FREEZE_SMPC_100_value = rightShift(data_low, 8) and &H1
        read_AGC_OVERFLOW_100_value = rightShift(data_low, 7) and &H1
        PGA_100BT_mask = &H7f
        if data_low > LONG_MAX then
            if PGA_100BT_mask = mask then
                read_PGA_100BT_value = data_low
            else
                read_PGA_100BT_value = (data_low - H8000_0000) and PGA_100BT_mask
            end If
        else
            read_PGA_100BT_value = data_low and PGA_100BT_mask
        end If

    End Sub

    Sub write
        If flag_COARSE_FREEZE_SMPC_100 = &H0 or flag_AGC_OVERFLOW_100 = &H0 or flag_PGA_100BT = &H0 Then read
        If flag_COARSE_FREEZE_SMPC_100 = &H0 Then write_COARSE_FREEZE_SMPC_100_value = get_COARSE_FREEZE_SMPC_100
        If flag_AGC_OVERFLOW_100 = &H0 Then write_AGC_OVERFLOW_100_value = get_AGC_OVERFLOW_100
        If flag_PGA_100BT = &H0 Then write_PGA_100BT_value = get_PGA_100BT

        regValue = leftShift((write_COARSE_FREEZE_SMPC_100_value and &H1), 8) + leftShift((write_AGC_OVERFLOW_100_value and &H1), 7) + leftShift((write_PGA_100BT_value and &H7f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_COARSE_FREEZE_SMPC_100_value = rightShift(data_low, 8) and &H1
        read_AGC_OVERFLOW_100_value = rightShift(data_low, 7) and &H1
        PGA_100BT_mask = &H7f
        if data_low > LONG_MAX then
            if PGA_100BT_mask = mask then
                read_PGA_100BT_value = data_low
            else
                read_PGA_100BT_value = (data_low - H8000_0000) and PGA_100BT_mask
            end If
        else
            read_PGA_100BT_value = data_low and PGA_100BT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COARSE_FREEZE_SMPC_100_value = &H0
        flag_COARSE_FREEZE_SMPC_100        = &H0
        write_AGC_OVERFLOW_100_value = &H0
        flag_AGC_OVERFLOW_100        = &H0
        write_PGA_100BT_value = &H0
        flag_PGA_100BT        = &H0
    End Sub
End Class


'' @REGISTER : DSP_TOP_agc_100_ctrl_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' AGC_LEGACY_CTRL_100                        [14:2]           get_AGC_LEGACY_CTRL_100
''                                                             set_AGC_LEGACY_CTRL_100
''                                                             read_AGC_LEGACY_CTRL_100
''                                                             write_AGC_LEGACY_CTRL_100
''---------------------------------------------------------------------------------
'' AGC_RST_VAL_100                            [1:0]            get_AGC_RST_VAL_100
''                                                             set_AGC_RST_VAL_100
''                                                             read_AGC_RST_VAL_100
''                                                             write_AGC_RST_VAL_100
''---------------------------------------------------------------------------------
Class REGISTER_DSP_TOP_agc_100_ctrl_0
    Private write_AGC_LEGACY_CTRL_100_value
    Private read_AGC_LEGACY_CTRL_100_value
    Private flag_AGC_LEGACY_CTRL_100
    Private write_AGC_RST_VAL_100_value
    Private read_AGC_RST_VAL_100_value
    Private flag_AGC_RST_VAL_100

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

    Property Get get_AGC_LEGACY_CTRL_100
        get_AGC_LEGACY_CTRL_100 = read_AGC_LEGACY_CTRL_100_value
    End Property

    Property Let set_AGC_LEGACY_CTRL_100(aData)
        write_AGC_LEGACY_CTRL_100_value = aData
        flag_AGC_LEGACY_CTRL_100        = &H1
    End Property

    Property Get read_AGC_LEGACY_CTRL_100
        read
        read_AGC_LEGACY_CTRL_100 = read_AGC_LEGACY_CTRL_100_value
    End Property

    Property Let write_AGC_LEGACY_CTRL_100(aData)
        set_AGC_LEGACY_CTRL_100 = aData
        write
    End Property

    Property Get get_AGC_RST_VAL_100
        get_AGC_RST_VAL_100 = read_AGC_RST_VAL_100_value
    End Property

    Property Let set_AGC_RST_VAL_100(aData)
        write_AGC_RST_VAL_100_value = aData
        flag_AGC_RST_VAL_100        = &H1
    End Property

    Property Get read_AGC_RST_VAL_100
        read
        read_AGC_RST_VAL_100 = read_AGC_RST_VAL_100_value
    End Property

    Property Let write_AGC_RST_VAL_100(aData)
        set_AGC_RST_VAL_100 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_AGC_LEGACY_CTRL_100_value = rightShift(data_low, 2) and &H1fff
        AGC_RST_VAL_100_mask = &H3
        if data_low > LONG_MAX then
            if AGC_RST_VAL_100_mask = mask then
                read_AGC_RST_VAL_100_value = data_low
            else
                read_AGC_RST_VAL_100_value = (data_low - H8000_0000) and AGC_RST_VAL_100_mask
            end If
        else
            read_AGC_RST_VAL_100_value = data_low and AGC_RST_VAL_100_mask
        end If

    End Sub

    Sub write
        If flag_AGC_LEGACY_CTRL_100 = &H0 or flag_AGC_RST_VAL_100 = &H0 Then read
        If flag_AGC_LEGACY_CTRL_100 = &H0 Then write_AGC_LEGACY_CTRL_100_value = get_AGC_LEGACY_CTRL_100
        If flag_AGC_RST_VAL_100 = &H0 Then write_AGC_RST_VAL_100_value = get_AGC_RST_VAL_100

        regValue = leftShift((write_AGC_LEGACY_CTRL_100_value and &H1fff), 2) + leftShift((write_AGC_RST_VAL_100_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_AGC_LEGACY_CTRL_100_value = rightShift(data_low, 2) and &H1fff
        AGC_RST_VAL_100_mask = &H3
        if data_low > LONG_MAX then
            if AGC_RST_VAL_100_mask = mask then
                read_AGC_RST_VAL_100_value = data_low
            else
                read_AGC_RST_VAL_100_value = (data_low - H8000_0000) and AGC_RST_VAL_100_mask
            end If
        else
            read_AGC_RST_VAL_100_value = data_low and AGC_RST_VAL_100_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_AGC_LEGACY_CTRL_100_value = &H0
        flag_AGC_LEGACY_CTRL_100        = &H0
        write_AGC_RST_VAL_100_value = &H0
        flag_AGC_RST_VAL_100        = &H0
    End Sub
End Class


'' @REGISTER : DSP_TOP_dcoffset_accum_lsb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DCOFFSET_ACCUM_LSB                         [15:0]           get_DCOFFSET_ACCUM_LSB
''                                                             set_DCOFFSET_ACCUM_LSB
''                                                             read_DCOFFSET_ACCUM_LSB
''                                                             write_DCOFFSET_ACCUM_LSB
''---------------------------------------------------------------------------------
Class REGISTER_DSP_TOP_dcoffset_accum_lsb
    Private write_DCOFFSET_ACCUM_LSB_value
    Private read_DCOFFSET_ACCUM_LSB_value
    Private flag_DCOFFSET_ACCUM_LSB

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

    Property Get get_DCOFFSET_ACCUM_LSB
        get_DCOFFSET_ACCUM_LSB = read_DCOFFSET_ACCUM_LSB_value
    End Property

    Property Let set_DCOFFSET_ACCUM_LSB(aData)
        write_DCOFFSET_ACCUM_LSB_value = aData
        flag_DCOFFSET_ACCUM_LSB        = &H1
    End Property

    Property Get read_DCOFFSET_ACCUM_LSB
        read
        read_DCOFFSET_ACCUM_LSB = read_DCOFFSET_ACCUM_LSB_value
    End Property

    Property Let write_DCOFFSET_ACCUM_LSB(aData)
        set_DCOFFSET_ACCUM_LSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DCOFFSET_ACCUM_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if DCOFFSET_ACCUM_LSB_mask = mask then
                read_DCOFFSET_ACCUM_LSB_value = data_low
            else
                read_DCOFFSET_ACCUM_LSB_value = (data_low - H8000_0000) and DCOFFSET_ACCUM_LSB_mask
            end If
        else
            read_DCOFFSET_ACCUM_LSB_value = data_low and DCOFFSET_ACCUM_LSB_mask
        end If

    End Sub

    Sub write
        If flag_DCOFFSET_ACCUM_LSB = &H0 Then read
        If flag_DCOFFSET_ACCUM_LSB = &H0 Then write_DCOFFSET_ACCUM_LSB_value = get_DCOFFSET_ACCUM_LSB

        regValue = leftShift((write_DCOFFSET_ACCUM_LSB_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DCOFFSET_ACCUM_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if DCOFFSET_ACCUM_LSB_mask = mask then
                read_DCOFFSET_ACCUM_LSB_value = data_low
            else
                read_DCOFFSET_ACCUM_LSB_value = (data_low - H8000_0000) and DCOFFSET_ACCUM_LSB_mask
            end If
        else
            read_DCOFFSET_ACCUM_LSB_value = data_low and DCOFFSET_ACCUM_LSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DCOFFSET_ACCUM_LSB_value = &H0
        flag_DCOFFSET_ACCUM_LSB        = &H0
    End Sub
End Class


'' @REGISTER : DSP_TOP_dcoffset_accum_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DCOFFSET_ACCUM_MSB                         [3:0]            get_DCOFFSET_ACCUM_MSB
''                                                             set_DCOFFSET_ACCUM_MSB
''                                                             read_DCOFFSET_ACCUM_MSB
''                                                             write_DCOFFSET_ACCUM_MSB
''---------------------------------------------------------------------------------
Class REGISTER_DSP_TOP_dcoffset_accum_msb
    Private write_DCOFFSET_ACCUM_MSB_value
    Private read_DCOFFSET_ACCUM_MSB_value
    Private flag_DCOFFSET_ACCUM_MSB

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

    Property Get get_DCOFFSET_ACCUM_MSB
        get_DCOFFSET_ACCUM_MSB = read_DCOFFSET_ACCUM_MSB_value
    End Property

    Property Let set_DCOFFSET_ACCUM_MSB(aData)
        write_DCOFFSET_ACCUM_MSB_value = aData
        flag_DCOFFSET_ACCUM_MSB        = &H1
    End Property

    Property Get read_DCOFFSET_ACCUM_MSB
        read
        read_DCOFFSET_ACCUM_MSB = read_DCOFFSET_ACCUM_MSB_value
    End Property

    Property Let write_DCOFFSET_ACCUM_MSB(aData)
        set_DCOFFSET_ACCUM_MSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DCOFFSET_ACCUM_MSB_mask = &Hf
        if data_low > LONG_MAX then
            if DCOFFSET_ACCUM_MSB_mask = mask then
                read_DCOFFSET_ACCUM_MSB_value = data_low
            else
                read_DCOFFSET_ACCUM_MSB_value = (data_low - H8000_0000) and DCOFFSET_ACCUM_MSB_mask
            end If
        else
            read_DCOFFSET_ACCUM_MSB_value = data_low and DCOFFSET_ACCUM_MSB_mask
        end If

    End Sub

    Sub write
        If flag_DCOFFSET_ACCUM_MSB = &H0 Then read
        If flag_DCOFFSET_ACCUM_MSB = &H0 Then write_DCOFFSET_ACCUM_MSB_value = get_DCOFFSET_ACCUM_MSB

        regValue = leftShift((write_DCOFFSET_ACCUM_MSB_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DCOFFSET_ACCUM_MSB_mask = &Hf
        if data_low > LONG_MAX then
            if DCOFFSET_ACCUM_MSB_mask = mask then
                read_DCOFFSET_ACCUM_MSB_value = data_low
            else
                read_DCOFFSET_ACCUM_MSB_value = (data_low - H8000_0000) and DCOFFSET_ACCUM_MSB_mask
            end If
        else
            read_DCOFFSET_ACCUM_MSB_value = data_low and DCOFFSET_ACCUM_MSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DCOFFSET_ACCUM_MSB_value = &H0
        flag_DCOFFSET_ACCUM_MSB        = &H0
    End Sub
End Class


'' @REGISTER : DSP_TOP_dagc_accum_lsb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DAGC_ACCUM_LSB                             [15:0]           get_DAGC_ACCUM_LSB
''                                                             set_DAGC_ACCUM_LSB
''                                                             read_DAGC_ACCUM_LSB
''                                                             write_DAGC_ACCUM_LSB
''---------------------------------------------------------------------------------
Class REGISTER_DSP_TOP_dagc_accum_lsb
    Private write_DAGC_ACCUM_LSB_value
    Private read_DAGC_ACCUM_LSB_value
    Private flag_DAGC_ACCUM_LSB

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

    Property Get get_DAGC_ACCUM_LSB
        get_DAGC_ACCUM_LSB = read_DAGC_ACCUM_LSB_value
    End Property

    Property Let set_DAGC_ACCUM_LSB(aData)
        write_DAGC_ACCUM_LSB_value = aData
        flag_DAGC_ACCUM_LSB        = &H1
    End Property

    Property Get read_DAGC_ACCUM_LSB
        read
        read_DAGC_ACCUM_LSB = read_DAGC_ACCUM_LSB_value
    End Property

    Property Let write_DAGC_ACCUM_LSB(aData)
        set_DAGC_ACCUM_LSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DAGC_ACCUM_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if DAGC_ACCUM_LSB_mask = mask then
                read_DAGC_ACCUM_LSB_value = data_low
            else
                read_DAGC_ACCUM_LSB_value = (data_low - H8000_0000) and DAGC_ACCUM_LSB_mask
            end If
        else
            read_DAGC_ACCUM_LSB_value = data_low and DAGC_ACCUM_LSB_mask
        end If

    End Sub

    Sub write
        If flag_DAGC_ACCUM_LSB = &H0 Then read
        If flag_DAGC_ACCUM_LSB = &H0 Then write_DAGC_ACCUM_LSB_value = get_DAGC_ACCUM_LSB

        regValue = leftShift((write_DAGC_ACCUM_LSB_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DAGC_ACCUM_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if DAGC_ACCUM_LSB_mask = mask then
                read_DAGC_ACCUM_LSB_value = data_low
            else
                read_DAGC_ACCUM_LSB_value = (data_low - H8000_0000) and DAGC_ACCUM_LSB_mask
            end If
        else
            read_DAGC_ACCUM_LSB_value = data_low and DAGC_ACCUM_LSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DAGC_ACCUM_LSB_value = &H0
        flag_DAGC_ACCUM_LSB        = &H0
    End Sub
End Class


'' @REGISTER : DSP_TOP_dagc_accum_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DAGC_ACCUM_MSB                             [6:0]            get_DAGC_ACCUM_MSB
''                                                             set_DAGC_ACCUM_MSB
''                                                             read_DAGC_ACCUM_MSB
''                                                             write_DAGC_ACCUM_MSB
''---------------------------------------------------------------------------------
Class REGISTER_DSP_TOP_dagc_accum_msb
    Private write_DAGC_ACCUM_MSB_value
    Private read_DAGC_ACCUM_MSB_value
    Private flag_DAGC_ACCUM_MSB

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

    Property Get get_DAGC_ACCUM_MSB
        get_DAGC_ACCUM_MSB = read_DAGC_ACCUM_MSB_value
    End Property

    Property Let set_DAGC_ACCUM_MSB(aData)
        write_DAGC_ACCUM_MSB_value = aData
        flag_DAGC_ACCUM_MSB        = &H1
    End Property

    Property Get read_DAGC_ACCUM_MSB
        read
        read_DAGC_ACCUM_MSB = read_DAGC_ACCUM_MSB_value
    End Property

    Property Let write_DAGC_ACCUM_MSB(aData)
        set_DAGC_ACCUM_MSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DAGC_ACCUM_MSB_mask = &H7f
        if data_low > LONG_MAX then
            if DAGC_ACCUM_MSB_mask = mask then
                read_DAGC_ACCUM_MSB_value = data_low
            else
                read_DAGC_ACCUM_MSB_value = (data_low - H8000_0000) and DAGC_ACCUM_MSB_mask
            end If
        else
            read_DAGC_ACCUM_MSB_value = data_low and DAGC_ACCUM_MSB_mask
        end If

    End Sub

    Sub write
        If flag_DAGC_ACCUM_MSB = &H0 Then read
        If flag_DAGC_ACCUM_MSB = &H0 Then write_DAGC_ACCUM_MSB_value = get_DAGC_ACCUM_MSB

        regValue = leftShift((write_DAGC_ACCUM_MSB_value and &H7f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DAGC_ACCUM_MSB_mask = &H7f
        if data_low > LONG_MAX then
            if DAGC_ACCUM_MSB_mask = mask then
                read_DAGC_ACCUM_MSB_value = data_low
            else
                read_DAGC_ACCUM_MSB_value = (data_low - H8000_0000) and DAGC_ACCUM_MSB_mask
            end If
        else
            read_DAGC_ACCUM_MSB_value = data_low and DAGC_ACCUM_MSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DAGC_ACCUM_MSB_value = &H0
        flag_DAGC_ACCUM_MSB        = &H0
    End Sub
End Class


'' @REGISTER : DSP_TOP_dpll_frz_bw_control
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DPLL_FRZ_FORCE_DEASSERT                    [8:8]            get_DPLL_FRZ_FORCE_DEASSERT
''                                                             set_DPLL_FRZ_FORCE_DEASSERT
''                                                             read_DPLL_FRZ_FORCE_DEASSERT
''                                                             write_DPLL_FRZ_FORCE_DEASSERT
''---------------------------------------------------------------------------------
'' DPLL_FRZ_FORCE_ASSERT                      [7:7]            get_DPLL_FRZ_FORCE_ASSERT
''                                                             set_DPLL_FRZ_FORCE_ASSERT
''                                                             read_DPLL_FRZ_FORCE_ASSERT
''                                                             write_DPLL_FRZ_FORCE_ASSERT
''---------------------------------------------------------------------------------
'' DPLL_ILPFRZ_FORCE_DEASSERT                 [6:6]            get_DPLL_ILPFRZ_FORCE_DEASSERT
''                                                             set_DPLL_ILPFRZ_FORCE_DEASSERT
''                                                             read_DPLL_ILPFRZ_FORCE_DEASSERT
''                                                             write_DPLL_ILPFRZ_FORCE_DEASSERT
''---------------------------------------------------------------------------------
'' DPLL_ILPFRZ_FORCE_ASSERT                   [5:5]            get_DPLL_ILPFRZ_FORCE_ASSERT
''                                                             set_DPLL_ILPFRZ_FORCE_ASSERT
''                                                             read_DPLL_ILPFRZ_FORCE_ASSERT
''                                                             write_DPLL_ILPFRZ_FORCE_ASSERT
''---------------------------------------------------------------------------------
'' DPLL_HIBW_OVERRIDE                         [4:4]            get_DPLL_HIBW_OVERRIDE
''                                                             set_DPLL_HIBW_OVERRIDE
''                                                             read_DPLL_HIBW_OVERRIDE
''                                                             write_DPLL_HIBW_OVERRIDE
''---------------------------------------------------------------------------------
'' DPLL_HIBW                                  [3:3]            get_DPLL_HIBW
''                                                             set_DPLL_HIBW
''                                                             read_DPLL_HIBW
''                                                             write_DPLL_HIBW
''---------------------------------------------------------------------------------
'' DPLL_ILPBW_OVERRIDE                        [2:2]            get_DPLL_ILPBW_OVERRIDE
''                                                             set_DPLL_ILPBW_OVERRIDE
''                                                             read_DPLL_ILPBW_OVERRIDE
''                                                             write_DPLL_ILPBW_OVERRIDE
''---------------------------------------------------------------------------------
'' DPLL_ILPBW                                 [1:0]            get_DPLL_ILPBW
''                                                             set_DPLL_ILPBW
''                                                             read_DPLL_ILPBW
''                                                             write_DPLL_ILPBW
''---------------------------------------------------------------------------------
Class REGISTER_DSP_TOP_dpll_frz_bw_control
    Private write_DPLL_FRZ_FORCE_DEASSERT_value
    Private read_DPLL_FRZ_FORCE_DEASSERT_value
    Private flag_DPLL_FRZ_FORCE_DEASSERT
    Private write_DPLL_FRZ_FORCE_ASSERT_value
    Private read_DPLL_FRZ_FORCE_ASSERT_value
    Private flag_DPLL_FRZ_FORCE_ASSERT
    Private write_DPLL_ILPFRZ_FORCE_DEASSERT_value
    Private read_DPLL_ILPFRZ_FORCE_DEASSERT_value
    Private flag_DPLL_ILPFRZ_FORCE_DEASSERT
    Private write_DPLL_ILPFRZ_FORCE_ASSERT_value
    Private read_DPLL_ILPFRZ_FORCE_ASSERT_value
    Private flag_DPLL_ILPFRZ_FORCE_ASSERT
    Private write_DPLL_HIBW_OVERRIDE_value
    Private read_DPLL_HIBW_OVERRIDE_value
    Private flag_DPLL_HIBW_OVERRIDE
    Private write_DPLL_HIBW_value
    Private read_DPLL_HIBW_value
    Private flag_DPLL_HIBW
    Private write_DPLL_ILPBW_OVERRIDE_value
    Private read_DPLL_ILPBW_OVERRIDE_value
    Private flag_DPLL_ILPBW_OVERRIDE
    Private write_DPLL_ILPBW_value
    Private read_DPLL_ILPBW_value
    Private flag_DPLL_ILPBW

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_DPLL_FRZ_FORCE_DEASSERT
        get_DPLL_FRZ_FORCE_DEASSERT = read_DPLL_FRZ_FORCE_DEASSERT_value
    End Property

    Property Let set_DPLL_FRZ_FORCE_DEASSERT(aData)
        write_DPLL_FRZ_FORCE_DEASSERT_value = aData
        flag_DPLL_FRZ_FORCE_DEASSERT        = &H1
    End Property

    Property Get read_DPLL_FRZ_FORCE_DEASSERT
        read
        read_DPLL_FRZ_FORCE_DEASSERT = read_DPLL_FRZ_FORCE_DEASSERT_value
    End Property

    Property Let write_DPLL_FRZ_FORCE_DEASSERT(aData)
        set_DPLL_FRZ_FORCE_DEASSERT = aData
        write
    End Property

    Property Get get_DPLL_FRZ_FORCE_ASSERT
        get_DPLL_FRZ_FORCE_ASSERT = read_DPLL_FRZ_FORCE_ASSERT_value
    End Property

    Property Let set_DPLL_FRZ_FORCE_ASSERT(aData)
        write_DPLL_FRZ_FORCE_ASSERT_value = aData
        flag_DPLL_FRZ_FORCE_ASSERT        = &H1
    End Property

    Property Get read_DPLL_FRZ_FORCE_ASSERT
        read
        read_DPLL_FRZ_FORCE_ASSERT = read_DPLL_FRZ_FORCE_ASSERT_value
    End Property

    Property Let write_DPLL_FRZ_FORCE_ASSERT(aData)
        set_DPLL_FRZ_FORCE_ASSERT = aData
        write
    End Property

    Property Get get_DPLL_ILPFRZ_FORCE_DEASSERT
        get_DPLL_ILPFRZ_FORCE_DEASSERT = read_DPLL_ILPFRZ_FORCE_DEASSERT_value
    End Property

    Property Let set_DPLL_ILPFRZ_FORCE_DEASSERT(aData)
        write_DPLL_ILPFRZ_FORCE_DEASSERT_value = aData
        flag_DPLL_ILPFRZ_FORCE_DEASSERT        = &H1
    End Property

    Property Get read_DPLL_ILPFRZ_FORCE_DEASSERT
        read
        read_DPLL_ILPFRZ_FORCE_DEASSERT = read_DPLL_ILPFRZ_FORCE_DEASSERT_value
    End Property

    Property Let write_DPLL_ILPFRZ_FORCE_DEASSERT(aData)
        set_DPLL_ILPFRZ_FORCE_DEASSERT = aData
        write
    End Property

    Property Get get_DPLL_ILPFRZ_FORCE_ASSERT
        get_DPLL_ILPFRZ_FORCE_ASSERT = read_DPLL_ILPFRZ_FORCE_ASSERT_value
    End Property

    Property Let set_DPLL_ILPFRZ_FORCE_ASSERT(aData)
        write_DPLL_ILPFRZ_FORCE_ASSERT_value = aData
        flag_DPLL_ILPFRZ_FORCE_ASSERT        = &H1
    End Property

    Property Get read_DPLL_ILPFRZ_FORCE_ASSERT
        read
        read_DPLL_ILPFRZ_FORCE_ASSERT = read_DPLL_ILPFRZ_FORCE_ASSERT_value
    End Property

    Property Let write_DPLL_ILPFRZ_FORCE_ASSERT(aData)
        set_DPLL_ILPFRZ_FORCE_ASSERT = aData
        write
    End Property

    Property Get get_DPLL_HIBW_OVERRIDE
        get_DPLL_HIBW_OVERRIDE = read_DPLL_HIBW_OVERRIDE_value
    End Property

    Property Let set_DPLL_HIBW_OVERRIDE(aData)
        write_DPLL_HIBW_OVERRIDE_value = aData
        flag_DPLL_HIBW_OVERRIDE        = &H1
    End Property

    Property Get read_DPLL_HIBW_OVERRIDE
        read
        read_DPLL_HIBW_OVERRIDE = read_DPLL_HIBW_OVERRIDE_value
    End Property

    Property Let write_DPLL_HIBW_OVERRIDE(aData)
        set_DPLL_HIBW_OVERRIDE = aData
        write
    End Property

    Property Get get_DPLL_HIBW
        get_DPLL_HIBW = read_DPLL_HIBW_value
    End Property

    Property Let set_DPLL_HIBW(aData)
        write_DPLL_HIBW_value = aData
        flag_DPLL_HIBW        = &H1
    End Property

    Property Get read_DPLL_HIBW
        read
        read_DPLL_HIBW = read_DPLL_HIBW_value
    End Property

    Property Let write_DPLL_HIBW(aData)
        set_DPLL_HIBW = aData
        write
    End Property

    Property Get get_DPLL_ILPBW_OVERRIDE
        get_DPLL_ILPBW_OVERRIDE = read_DPLL_ILPBW_OVERRIDE_value
    End Property

    Property Let set_DPLL_ILPBW_OVERRIDE(aData)
        write_DPLL_ILPBW_OVERRIDE_value = aData
        flag_DPLL_ILPBW_OVERRIDE        = &H1
    End Property

    Property Get read_DPLL_ILPBW_OVERRIDE
        read
        read_DPLL_ILPBW_OVERRIDE = read_DPLL_ILPBW_OVERRIDE_value
    End Property

    Property Let write_DPLL_ILPBW_OVERRIDE(aData)
        set_DPLL_ILPBW_OVERRIDE = aData
        write
    End Property

    Property Get get_DPLL_ILPBW
        get_DPLL_ILPBW = read_DPLL_ILPBW_value
    End Property

    Property Let set_DPLL_ILPBW(aData)
        write_DPLL_ILPBW_value = aData
        flag_DPLL_ILPBW        = &H1
    End Property

    Property Get read_DPLL_ILPBW
        read
        read_DPLL_ILPBW = read_DPLL_ILPBW_value
    End Property

    Property Let write_DPLL_ILPBW(aData)
        set_DPLL_ILPBW = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_DPLL_FRZ_FORCE_DEASSERT_value = rightShift(data_low, 8) and &H1
        read_DPLL_FRZ_FORCE_ASSERT_value = rightShift(data_low, 7) and &H1
        read_DPLL_ILPFRZ_FORCE_DEASSERT_value = rightShift(data_low, 6) and &H1
        read_DPLL_ILPFRZ_FORCE_ASSERT_value = rightShift(data_low, 5) and &H1
        read_DPLL_HIBW_OVERRIDE_value = rightShift(data_low, 4) and &H1
        read_DPLL_HIBW_value = rightShift(data_low, 3) and &H1
        read_DPLL_ILPBW_OVERRIDE_value = rightShift(data_low, 2) and &H1
        DPLL_ILPBW_mask = &H3
        if data_low > LONG_MAX then
            if DPLL_ILPBW_mask = mask then
                read_DPLL_ILPBW_value = data_low
            else
                read_DPLL_ILPBW_value = (data_low - H8000_0000) and DPLL_ILPBW_mask
            end If
        else
            read_DPLL_ILPBW_value = data_low and DPLL_ILPBW_mask
        end If

    End Sub

    Sub write
        If flag_DPLL_FRZ_FORCE_DEASSERT = &H0 or flag_DPLL_FRZ_FORCE_ASSERT = &H0 or flag_DPLL_ILPFRZ_FORCE_DEASSERT = &H0 or flag_DPLL_ILPFRZ_FORCE_ASSERT = &H0 or flag_DPLL_HIBW_OVERRIDE = &H0 or flag_DPLL_HIBW = &H0 or flag_DPLL_ILPBW_OVERRIDE = &H0 or flag_DPLL_ILPBW = &H0 Then read
        If flag_DPLL_FRZ_FORCE_DEASSERT = &H0 Then write_DPLL_FRZ_FORCE_DEASSERT_value = get_DPLL_FRZ_FORCE_DEASSERT
        If flag_DPLL_FRZ_FORCE_ASSERT = &H0 Then write_DPLL_FRZ_FORCE_ASSERT_value = get_DPLL_FRZ_FORCE_ASSERT
        If flag_DPLL_ILPFRZ_FORCE_DEASSERT = &H0 Then write_DPLL_ILPFRZ_FORCE_DEASSERT_value = get_DPLL_ILPFRZ_FORCE_DEASSERT
        If flag_DPLL_ILPFRZ_FORCE_ASSERT = &H0 Then write_DPLL_ILPFRZ_FORCE_ASSERT_value = get_DPLL_ILPFRZ_FORCE_ASSERT
        If flag_DPLL_HIBW_OVERRIDE = &H0 Then write_DPLL_HIBW_OVERRIDE_value = get_DPLL_HIBW_OVERRIDE
        If flag_DPLL_HIBW = &H0 Then write_DPLL_HIBW_value = get_DPLL_HIBW
        If flag_DPLL_ILPBW_OVERRIDE = &H0 Then write_DPLL_ILPBW_OVERRIDE_value = get_DPLL_ILPBW_OVERRIDE
        If flag_DPLL_ILPBW = &H0 Then write_DPLL_ILPBW_value = get_DPLL_ILPBW

        regValue = leftShift((write_DPLL_FRZ_FORCE_DEASSERT_value and &H1), 8) + leftShift((write_DPLL_FRZ_FORCE_ASSERT_value and &H1), 7) + leftShift((write_DPLL_ILPFRZ_FORCE_DEASSERT_value and &H1), 6) + leftShift((write_DPLL_ILPFRZ_FORCE_ASSERT_value and &H1), 5) + leftShift((write_DPLL_HIBW_OVERRIDE_value and &H1), 4) + leftShift((write_DPLL_HIBW_value and &H1), 3) + leftShift((write_DPLL_ILPBW_OVERRIDE_value and &H1), 2) + leftShift((write_DPLL_ILPBW_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_DPLL_FRZ_FORCE_DEASSERT_value = rightShift(data_low, 8) and &H1
        read_DPLL_FRZ_FORCE_ASSERT_value = rightShift(data_low, 7) and &H1
        read_DPLL_ILPFRZ_FORCE_DEASSERT_value = rightShift(data_low, 6) and &H1
        read_DPLL_ILPFRZ_FORCE_ASSERT_value = rightShift(data_low, 5) and &H1
        read_DPLL_HIBW_OVERRIDE_value = rightShift(data_low, 4) and &H1
        read_DPLL_HIBW_value = rightShift(data_low, 3) and &H1
        read_DPLL_ILPBW_OVERRIDE_value = rightShift(data_low, 2) and &H1
        DPLL_ILPBW_mask = &H3
        if data_low > LONG_MAX then
            if DPLL_ILPBW_mask = mask then
                read_DPLL_ILPBW_value = data_low
            else
                read_DPLL_ILPBW_value = (data_low - H8000_0000) and DPLL_ILPBW_mask
            end If
        else
            read_DPLL_ILPBW_value = data_low and DPLL_ILPBW_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DPLL_FRZ_FORCE_DEASSERT_value = &H0
        flag_DPLL_FRZ_FORCE_DEASSERT        = &H0
        write_DPLL_FRZ_FORCE_ASSERT_value = &H0
        flag_DPLL_FRZ_FORCE_ASSERT        = &H0
        write_DPLL_ILPFRZ_FORCE_DEASSERT_value = &H0
        flag_DPLL_ILPFRZ_FORCE_DEASSERT        = &H0
        write_DPLL_ILPFRZ_FORCE_ASSERT_value = &H0
        flag_DPLL_ILPFRZ_FORCE_ASSERT        = &H0
        write_DPLL_HIBW_OVERRIDE_value = &H0
        flag_DPLL_HIBW_OVERRIDE        = &H0
        write_DPLL_HIBW_value = &H0
        flag_DPLL_HIBW        = &H0
        write_DPLL_ILPBW_OVERRIDE_value = &H0
        flag_DPLL_ILPBW_OVERRIDE        = &H0
        write_DPLL_ILPBW_value = &H0
        flag_DPLL_ILPBW        = &H0
    End Sub
End Class


'' @REGISTER : DSP_TOP_dpll_frst_pramp_control
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DPLL_FVAL_OVERRIDE                         [4:4]            get_DPLL_FVAL_OVERRIDE
''                                                             set_DPLL_FVAL_OVERRIDE
''                                                             read_DPLL_FVAL_OVERRIDE
''                                                             write_DPLL_FVAL_OVERRIDE
''---------------------------------------------------------------------------------
'' DPLL_FRST_FORCE_DEASSERT                   [3:3]            get_DPLL_FRST_FORCE_DEASSERT
''                                                             set_DPLL_FRST_FORCE_DEASSERT
''                                                             read_DPLL_FRST_FORCE_DEASSERT
''                                                             write_DPLL_FRST_FORCE_DEASSERT
''---------------------------------------------------------------------------------
'' DPLL_FRST_FORCE_ASSERT                     [2:2]            get_DPLL_FRST_FORCE_ASSERT
''                                                             set_DPLL_FRST_FORCE_ASSERT
''                                                             read_DPLL_FRST_FORCE_ASSERT
''                                                             write_DPLL_FRST_FORCE_ASSERT
''---------------------------------------------------------------------------------
'' DPLL_PRAMP_FORCE_DEASSERT                  [1:1]            get_DPLL_PRAMP_FORCE_DEASSERT
''                                                             set_DPLL_PRAMP_FORCE_DEASSERT
''                                                             read_DPLL_PRAMP_FORCE_DEASSERT
''                                                             write_DPLL_PRAMP_FORCE_DEASSERT
''---------------------------------------------------------------------------------
'' DPLL_PRAMP_FORCE_ASSERT                    [0:0]            get_DPLL_PRAMP_FORCE_ASSERT
''                                                             set_DPLL_PRAMP_FORCE_ASSERT
''                                                             read_DPLL_PRAMP_FORCE_ASSERT
''                                                             write_DPLL_PRAMP_FORCE_ASSERT
''---------------------------------------------------------------------------------
Class REGISTER_DSP_TOP_dpll_frst_pramp_control
    Private write_DPLL_FVAL_OVERRIDE_value
    Private read_DPLL_FVAL_OVERRIDE_value
    Private flag_DPLL_FVAL_OVERRIDE
    Private write_DPLL_FRST_FORCE_DEASSERT_value
    Private read_DPLL_FRST_FORCE_DEASSERT_value
    Private flag_DPLL_FRST_FORCE_DEASSERT
    Private write_DPLL_FRST_FORCE_ASSERT_value
    Private read_DPLL_FRST_FORCE_ASSERT_value
    Private flag_DPLL_FRST_FORCE_ASSERT
    Private write_DPLL_PRAMP_FORCE_DEASSERT_value
    Private read_DPLL_PRAMP_FORCE_DEASSERT_value
    Private flag_DPLL_PRAMP_FORCE_DEASSERT
    Private write_DPLL_PRAMP_FORCE_ASSERT_value
    Private read_DPLL_PRAMP_FORCE_ASSERT_value
    Private flag_DPLL_PRAMP_FORCE_ASSERT

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

    Property Get get_DPLL_FVAL_OVERRIDE
        get_DPLL_FVAL_OVERRIDE = read_DPLL_FVAL_OVERRIDE_value
    End Property

    Property Let set_DPLL_FVAL_OVERRIDE(aData)
        write_DPLL_FVAL_OVERRIDE_value = aData
        flag_DPLL_FVAL_OVERRIDE        = &H1
    End Property

    Property Get read_DPLL_FVAL_OVERRIDE
        read
        read_DPLL_FVAL_OVERRIDE = read_DPLL_FVAL_OVERRIDE_value
    End Property

    Property Let write_DPLL_FVAL_OVERRIDE(aData)
        set_DPLL_FVAL_OVERRIDE = aData
        write
    End Property

    Property Get get_DPLL_FRST_FORCE_DEASSERT
        get_DPLL_FRST_FORCE_DEASSERT = read_DPLL_FRST_FORCE_DEASSERT_value
    End Property

    Property Let set_DPLL_FRST_FORCE_DEASSERT(aData)
        write_DPLL_FRST_FORCE_DEASSERT_value = aData
        flag_DPLL_FRST_FORCE_DEASSERT        = &H1
    End Property

    Property Get read_DPLL_FRST_FORCE_DEASSERT
        read
        read_DPLL_FRST_FORCE_DEASSERT = read_DPLL_FRST_FORCE_DEASSERT_value
    End Property

    Property Let write_DPLL_FRST_FORCE_DEASSERT(aData)
        set_DPLL_FRST_FORCE_DEASSERT = aData
        write
    End Property

    Property Get get_DPLL_FRST_FORCE_ASSERT
        get_DPLL_FRST_FORCE_ASSERT = read_DPLL_FRST_FORCE_ASSERT_value
    End Property

    Property Let set_DPLL_FRST_FORCE_ASSERT(aData)
        write_DPLL_FRST_FORCE_ASSERT_value = aData
        flag_DPLL_FRST_FORCE_ASSERT        = &H1
    End Property

    Property Get read_DPLL_FRST_FORCE_ASSERT
        read
        read_DPLL_FRST_FORCE_ASSERT = read_DPLL_FRST_FORCE_ASSERT_value
    End Property

    Property Let write_DPLL_FRST_FORCE_ASSERT(aData)
        set_DPLL_FRST_FORCE_ASSERT = aData
        write
    End Property

    Property Get get_DPLL_PRAMP_FORCE_DEASSERT
        get_DPLL_PRAMP_FORCE_DEASSERT = read_DPLL_PRAMP_FORCE_DEASSERT_value
    End Property

    Property Let set_DPLL_PRAMP_FORCE_DEASSERT(aData)
        write_DPLL_PRAMP_FORCE_DEASSERT_value = aData
        flag_DPLL_PRAMP_FORCE_DEASSERT        = &H1
    End Property

    Property Get read_DPLL_PRAMP_FORCE_DEASSERT
        read
        read_DPLL_PRAMP_FORCE_DEASSERT = read_DPLL_PRAMP_FORCE_DEASSERT_value
    End Property

    Property Let write_DPLL_PRAMP_FORCE_DEASSERT(aData)
        set_DPLL_PRAMP_FORCE_DEASSERT = aData
        write
    End Property

    Property Get get_DPLL_PRAMP_FORCE_ASSERT
        get_DPLL_PRAMP_FORCE_ASSERT = read_DPLL_PRAMP_FORCE_ASSERT_value
    End Property

    Property Let set_DPLL_PRAMP_FORCE_ASSERT(aData)
        write_DPLL_PRAMP_FORCE_ASSERT_value = aData
        flag_DPLL_PRAMP_FORCE_ASSERT        = &H1
    End Property

    Property Get read_DPLL_PRAMP_FORCE_ASSERT
        read
        read_DPLL_PRAMP_FORCE_ASSERT = read_DPLL_PRAMP_FORCE_ASSERT_value
    End Property

    Property Let write_DPLL_PRAMP_FORCE_ASSERT(aData)
        set_DPLL_PRAMP_FORCE_ASSERT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_DPLL_FVAL_OVERRIDE_value = rightShift(data_low, 4) and &H1
        read_DPLL_FRST_FORCE_DEASSERT_value = rightShift(data_low, 3) and &H1
        read_DPLL_FRST_FORCE_ASSERT_value = rightShift(data_low, 2) and &H1
        read_DPLL_PRAMP_FORCE_DEASSERT_value = rightShift(data_low, 1) and &H1
        DPLL_PRAMP_FORCE_ASSERT_mask = &H1
        if data_low > LONG_MAX then
            if DPLL_PRAMP_FORCE_ASSERT_mask = mask then
                read_DPLL_PRAMP_FORCE_ASSERT_value = data_low
            else
                read_DPLL_PRAMP_FORCE_ASSERT_value = (data_low - H8000_0000) and DPLL_PRAMP_FORCE_ASSERT_mask
            end If
        else
            read_DPLL_PRAMP_FORCE_ASSERT_value = data_low and DPLL_PRAMP_FORCE_ASSERT_mask
        end If

    End Sub

    Sub write
        If flag_DPLL_FVAL_OVERRIDE = &H0 or flag_DPLL_FRST_FORCE_DEASSERT = &H0 or flag_DPLL_FRST_FORCE_ASSERT = &H0 or flag_DPLL_PRAMP_FORCE_DEASSERT = &H0 or flag_DPLL_PRAMP_FORCE_ASSERT = &H0 Then read
        If flag_DPLL_FVAL_OVERRIDE = &H0 Then write_DPLL_FVAL_OVERRIDE_value = get_DPLL_FVAL_OVERRIDE
        If flag_DPLL_FRST_FORCE_DEASSERT = &H0 Then write_DPLL_FRST_FORCE_DEASSERT_value = get_DPLL_FRST_FORCE_DEASSERT
        If flag_DPLL_FRST_FORCE_ASSERT = &H0 Then write_DPLL_FRST_FORCE_ASSERT_value = get_DPLL_FRST_FORCE_ASSERT
        If flag_DPLL_PRAMP_FORCE_DEASSERT = &H0 Then write_DPLL_PRAMP_FORCE_DEASSERT_value = get_DPLL_PRAMP_FORCE_DEASSERT
        If flag_DPLL_PRAMP_FORCE_ASSERT = &H0 Then write_DPLL_PRAMP_FORCE_ASSERT_value = get_DPLL_PRAMP_FORCE_ASSERT

        regValue = leftShift((write_DPLL_FVAL_OVERRIDE_value and &H1), 4) + leftShift((write_DPLL_FRST_FORCE_DEASSERT_value and &H1), 3) + leftShift((write_DPLL_FRST_FORCE_ASSERT_value and &H1), 2) + leftShift((write_DPLL_PRAMP_FORCE_DEASSERT_value and &H1), 1) + leftShift((write_DPLL_PRAMP_FORCE_ASSERT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_DPLL_FVAL_OVERRIDE_value = rightShift(data_low, 4) and &H1
        read_DPLL_FRST_FORCE_DEASSERT_value = rightShift(data_low, 3) and &H1
        read_DPLL_FRST_FORCE_ASSERT_value = rightShift(data_low, 2) and &H1
        read_DPLL_PRAMP_FORCE_DEASSERT_value = rightShift(data_low, 1) and &H1
        DPLL_PRAMP_FORCE_ASSERT_mask = &H1
        if data_low > LONG_MAX then
            if DPLL_PRAMP_FORCE_ASSERT_mask = mask then
                read_DPLL_PRAMP_FORCE_ASSERT_value = data_low
            else
                read_DPLL_PRAMP_FORCE_ASSERT_value = (data_low - H8000_0000) and DPLL_PRAMP_FORCE_ASSERT_mask
            end If
        else
            read_DPLL_PRAMP_FORCE_ASSERT_value = data_low and DPLL_PRAMP_FORCE_ASSERT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DPLL_FVAL_OVERRIDE_value = &H0
        flag_DPLL_FVAL_OVERRIDE        = &H0
        write_DPLL_FRST_FORCE_DEASSERT_value = &H0
        flag_DPLL_FRST_FORCE_DEASSERT        = &H0
        write_DPLL_FRST_FORCE_ASSERT_value = &H0
        flag_DPLL_FRST_FORCE_ASSERT        = &H0
        write_DPLL_PRAMP_FORCE_DEASSERT_value = &H0
        flag_DPLL_PRAMP_FORCE_DEASSERT        = &H0
        write_DPLL_PRAMP_FORCE_ASSERT_value = &H0
        flag_DPLL_PRAMP_FORCE_ASSERT        = &H0
    End Sub
End Class


'' @REGISTER : DSP_TOP_dpll_fval_lsb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DAGC_ACCUM_LSB                             [15:0]           get_DAGC_ACCUM_LSB
''                                                             set_DAGC_ACCUM_LSB
''                                                             read_DAGC_ACCUM_LSB
''                                                             write_DAGC_ACCUM_LSB
''---------------------------------------------------------------------------------
Class REGISTER_DSP_TOP_dpll_fval_lsb
    Private write_DAGC_ACCUM_LSB_value
    Private read_DAGC_ACCUM_LSB_value
    Private flag_DAGC_ACCUM_LSB

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2e
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_DAGC_ACCUM_LSB
        get_DAGC_ACCUM_LSB = read_DAGC_ACCUM_LSB_value
    End Property

    Property Let set_DAGC_ACCUM_LSB(aData)
        write_DAGC_ACCUM_LSB_value = aData
        flag_DAGC_ACCUM_LSB        = &H1
    End Property

    Property Get read_DAGC_ACCUM_LSB
        read
        read_DAGC_ACCUM_LSB = read_DAGC_ACCUM_LSB_value
    End Property

    Property Let write_DAGC_ACCUM_LSB(aData)
        set_DAGC_ACCUM_LSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DAGC_ACCUM_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if DAGC_ACCUM_LSB_mask = mask then
                read_DAGC_ACCUM_LSB_value = data_low
            else
                read_DAGC_ACCUM_LSB_value = (data_low - H8000_0000) and DAGC_ACCUM_LSB_mask
            end If
        else
            read_DAGC_ACCUM_LSB_value = data_low and DAGC_ACCUM_LSB_mask
        end If

    End Sub

    Sub write
        If flag_DAGC_ACCUM_LSB = &H0 Then read
        If flag_DAGC_ACCUM_LSB = &H0 Then write_DAGC_ACCUM_LSB_value = get_DAGC_ACCUM_LSB

        regValue = leftShift((write_DAGC_ACCUM_LSB_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DAGC_ACCUM_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if DAGC_ACCUM_LSB_mask = mask then
                read_DAGC_ACCUM_LSB_value = data_low
            else
                read_DAGC_ACCUM_LSB_value = (data_low - H8000_0000) and DAGC_ACCUM_LSB_mask
            end If
        else
            read_DAGC_ACCUM_LSB_value = data_low and DAGC_ACCUM_LSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DAGC_ACCUM_LSB_value = &H0
        flag_DAGC_ACCUM_LSB        = &H0
    End Sub
End Class


'' @REGISTER : DSP_TOP_dpll_fval_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DAGC_ACCUM_MSB                             [11:0]           get_DAGC_ACCUM_MSB
''                                                             set_DAGC_ACCUM_MSB
''                                                             read_DAGC_ACCUM_MSB
''                                                             write_DAGC_ACCUM_MSB
''---------------------------------------------------------------------------------
Class REGISTER_DSP_TOP_dpll_fval_msb
    Private write_DAGC_ACCUM_MSB_value
    Private read_DAGC_ACCUM_MSB_value
    Private flag_DAGC_ACCUM_MSB

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H30
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_DAGC_ACCUM_MSB
        get_DAGC_ACCUM_MSB = read_DAGC_ACCUM_MSB_value
    End Property

    Property Let set_DAGC_ACCUM_MSB(aData)
        write_DAGC_ACCUM_MSB_value = aData
        flag_DAGC_ACCUM_MSB        = &H1
    End Property

    Property Get read_DAGC_ACCUM_MSB
        read
        read_DAGC_ACCUM_MSB = read_DAGC_ACCUM_MSB_value
    End Property

    Property Let write_DAGC_ACCUM_MSB(aData)
        set_DAGC_ACCUM_MSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DAGC_ACCUM_MSB_mask = &Hfff
        if data_low > LONG_MAX then
            if DAGC_ACCUM_MSB_mask = mask then
                read_DAGC_ACCUM_MSB_value = data_low
            else
                read_DAGC_ACCUM_MSB_value = (data_low - H8000_0000) and DAGC_ACCUM_MSB_mask
            end If
        else
            read_DAGC_ACCUM_MSB_value = data_low and DAGC_ACCUM_MSB_mask
        end If

    End Sub

    Sub write
        If flag_DAGC_ACCUM_MSB = &H0 Then read
        If flag_DAGC_ACCUM_MSB = &H0 Then write_DAGC_ACCUM_MSB_value = get_DAGC_ACCUM_MSB

        regValue = leftShift((write_DAGC_ACCUM_MSB_value and &Hfff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DAGC_ACCUM_MSB_mask = &Hfff
        if data_low > LONG_MAX then
            if DAGC_ACCUM_MSB_mask = mask then
                read_DAGC_ACCUM_MSB_value = data_low
            else
                read_DAGC_ACCUM_MSB_value = (data_low - H8000_0000) and DAGC_ACCUM_MSB_mask
            end If
        else
            read_DAGC_ACCUM_MSB_value = data_low and DAGC_ACCUM_MSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DAGC_ACCUM_MSB_value = &H0
        flag_DAGC_ACCUM_MSB        = &H0
    End Sub
End Class


'' @REGISTER : DSP_TOP_ce_timing_error
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CE_TIMING_ERROR                            [11:0]           get_CE_TIMING_ERROR
''                                                             set_CE_TIMING_ERROR
''                                                             read_CE_TIMING_ERROR
''                                                             write_CE_TIMING_ERROR
''---------------------------------------------------------------------------------
Class REGISTER_DSP_TOP_ce_timing_error
    Private write_CE_TIMING_ERROR_value
    Private read_CE_TIMING_ERROR_value
    Private flag_CE_TIMING_ERROR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H32
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_CE_TIMING_ERROR
        get_CE_TIMING_ERROR = read_CE_TIMING_ERROR_value
    End Property

    Property Let set_CE_TIMING_ERROR(aData)
        write_CE_TIMING_ERROR_value = aData
        flag_CE_TIMING_ERROR        = &H1
    End Property

    Property Get read_CE_TIMING_ERROR
        read
        read_CE_TIMING_ERROR = read_CE_TIMING_ERROR_value
    End Property

    Property Let write_CE_TIMING_ERROR(aData)
        set_CE_TIMING_ERROR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CE_TIMING_ERROR_mask = &Hfff
        if data_low > LONG_MAX then
            if CE_TIMING_ERROR_mask = mask then
                read_CE_TIMING_ERROR_value = data_low
            else
                read_CE_TIMING_ERROR_value = (data_low - H8000_0000) and CE_TIMING_ERROR_mask
            end If
        else
            read_CE_TIMING_ERROR_value = data_low and CE_TIMING_ERROR_mask
        end If

    End Sub

    Sub write
        If flag_CE_TIMING_ERROR = &H0 Then read
        If flag_CE_TIMING_ERROR = &H0 Then write_CE_TIMING_ERROR_value = get_CE_TIMING_ERROR

        regValue = leftShift((write_CE_TIMING_ERROR_value and &Hfff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CE_TIMING_ERROR_mask = &Hfff
        if data_low > LONG_MAX then
            if CE_TIMING_ERROR_mask = mask then
                read_CE_TIMING_ERROR_value = data_low
            else
                read_CE_TIMING_ERROR_value = (data_low - H8000_0000) and CE_TIMING_ERROR_mask
            end If
        else
            read_CE_TIMING_ERROR_value = data_low and CE_TIMING_ERROR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CE_TIMING_ERROR_value = &H0
        flag_CE_TIMING_ERROR        = &H0
    End Sub
End Class


'' @REGISTER : DSP_TOP_pherr_accum_s1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PHERR_ACCUM_S1                             [13:0]           get_PHERR_ACCUM_S1
''                                                             set_PHERR_ACCUM_S1
''                                                             read_PHERR_ACCUM_S1
''                                                             write_PHERR_ACCUM_S1
''---------------------------------------------------------------------------------
Class REGISTER_DSP_TOP_pherr_accum_s1
    Private write_PHERR_ACCUM_S1_value
    Private read_PHERR_ACCUM_S1_value
    Private flag_PHERR_ACCUM_S1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H34
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PHERR_ACCUM_S1
        get_PHERR_ACCUM_S1 = read_PHERR_ACCUM_S1_value
    End Property

    Property Let set_PHERR_ACCUM_S1(aData)
        write_PHERR_ACCUM_S1_value = aData
        flag_PHERR_ACCUM_S1        = &H1
    End Property

    Property Get read_PHERR_ACCUM_S1
        read
        read_PHERR_ACCUM_S1 = read_PHERR_ACCUM_S1_value
    End Property

    Property Let write_PHERR_ACCUM_S1(aData)
        set_PHERR_ACCUM_S1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PHERR_ACCUM_S1_mask = &H3fff
        if data_low > LONG_MAX then
            if PHERR_ACCUM_S1_mask = mask then
                read_PHERR_ACCUM_S1_value = data_low
            else
                read_PHERR_ACCUM_S1_value = (data_low - H8000_0000) and PHERR_ACCUM_S1_mask
            end If
        else
            read_PHERR_ACCUM_S1_value = data_low and PHERR_ACCUM_S1_mask
        end If

    End Sub

    Sub write
        If flag_PHERR_ACCUM_S1 = &H0 Then read
        If flag_PHERR_ACCUM_S1 = &H0 Then write_PHERR_ACCUM_S1_value = get_PHERR_ACCUM_S1

        regValue = leftShift((write_PHERR_ACCUM_S1_value and &H3fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PHERR_ACCUM_S1_mask = &H3fff
        if data_low > LONG_MAX then
            if PHERR_ACCUM_S1_mask = mask then
                read_PHERR_ACCUM_S1_value = data_low
            else
                read_PHERR_ACCUM_S1_value = (data_low - H8000_0000) and PHERR_ACCUM_S1_mask
            end If
        else
            read_PHERR_ACCUM_S1_value = data_low and PHERR_ACCUM_S1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PHERR_ACCUM_S1_value = &H0
        flag_PHERR_ACCUM_S1        = &H0
    End Sub
End Class


'' @REGISTER : DSP_TOP_pherr_accum_s2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PHERR_ACCUM_S2                             [13:0]           get_PHERR_ACCUM_S2
''                                                             set_PHERR_ACCUM_S2
''                                                             read_PHERR_ACCUM_S2
''                                                             write_PHERR_ACCUM_S2
''---------------------------------------------------------------------------------
Class REGISTER_DSP_TOP_pherr_accum_s2
    Private write_PHERR_ACCUM_S2_value
    Private read_PHERR_ACCUM_S2_value
    Private flag_PHERR_ACCUM_S2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H36
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PHERR_ACCUM_S2
        get_PHERR_ACCUM_S2 = read_PHERR_ACCUM_S2_value
    End Property

    Property Let set_PHERR_ACCUM_S2(aData)
        write_PHERR_ACCUM_S2_value = aData
        flag_PHERR_ACCUM_S2        = &H1
    End Property

    Property Get read_PHERR_ACCUM_S2
        read
        read_PHERR_ACCUM_S2 = read_PHERR_ACCUM_S2_value
    End Property

    Property Let write_PHERR_ACCUM_S2(aData)
        set_PHERR_ACCUM_S2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PHERR_ACCUM_S2_mask = &H3fff
        if data_low > LONG_MAX then
            if PHERR_ACCUM_S2_mask = mask then
                read_PHERR_ACCUM_S2_value = data_low
            else
                read_PHERR_ACCUM_S2_value = (data_low - H8000_0000) and PHERR_ACCUM_S2_mask
            end If
        else
            read_PHERR_ACCUM_S2_value = data_low and PHERR_ACCUM_S2_mask
        end If

    End Sub

    Sub write
        If flag_PHERR_ACCUM_S2 = &H0 Then read
        If flag_PHERR_ACCUM_S2 = &H0 Then write_PHERR_ACCUM_S2_value = get_PHERR_ACCUM_S2

        regValue = leftShift((write_PHERR_ACCUM_S2_value and &H3fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PHERR_ACCUM_S2_mask = &H3fff
        if data_low > LONG_MAX then
            if PHERR_ACCUM_S2_mask = mask then
                read_PHERR_ACCUM_S2_value = data_low
            else
                read_PHERR_ACCUM_S2_value = (data_low - H8000_0000) and PHERR_ACCUM_S2_mask
            end If
        else
            read_PHERR_ACCUM_S2_value = data_low and PHERR_ACCUM_S2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PHERR_ACCUM_S2_value = &H0
        flag_PHERR_ACCUM_S2        = &H0
    End Sub
End Class


'' @REGISTER : DSP_TOP_phase_error
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PHASE_ERROR                                [13:0]           get_PHASE_ERROR
''                                                             set_PHASE_ERROR
''                                                             read_PHASE_ERROR
''                                                             write_PHASE_ERROR
''---------------------------------------------------------------------------------
Class REGISTER_DSP_TOP_phase_error
    Private write_PHASE_ERROR_value
    Private read_PHASE_ERROR_value
    Private flag_PHASE_ERROR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H38
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PHASE_ERROR
        get_PHASE_ERROR = read_PHASE_ERROR_value
    End Property

    Property Let set_PHASE_ERROR(aData)
        write_PHASE_ERROR_value = aData
        flag_PHASE_ERROR        = &H1
    End Property

    Property Get read_PHASE_ERROR
        read
        read_PHASE_ERROR = read_PHASE_ERROR_value
    End Property

    Property Let write_PHASE_ERROR(aData)
        set_PHASE_ERROR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PHASE_ERROR_mask = &H3fff
        if data_low > LONG_MAX then
            if PHASE_ERROR_mask = mask then
                read_PHASE_ERROR_value = data_low
            else
                read_PHASE_ERROR_value = (data_low - H8000_0000) and PHASE_ERROR_mask
            end If
        else
            read_PHASE_ERROR_value = data_low and PHASE_ERROR_mask
        end If

    End Sub

    Sub write
        If flag_PHASE_ERROR = &H0 Then read
        If flag_PHASE_ERROR = &H0 Then write_PHASE_ERROR_value = get_PHASE_ERROR

        regValue = leftShift((write_PHASE_ERROR_value and &H3fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PHASE_ERROR_mask = &H3fff
        if data_low > LONG_MAX then
            if PHASE_ERROR_mask = mask then
                read_PHASE_ERROR_value = data_low
            else
                read_PHASE_ERROR_value = (data_low - H8000_0000) and PHASE_ERROR_mask
            end If
        else
            read_PHASE_ERROR_value = data_low and PHASE_ERROR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PHASE_ERROR_value = &H0
        flag_PHASE_ERROR        = &H0
    End Sub
End Class


'' @REGISTER : DSP_TOP_integral_error_lsb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' INTEGRAL_ERROR_LSB                         [15:0]           get_INTEGRAL_ERROR_LSB
''                                                             set_INTEGRAL_ERROR_LSB
''                                                             read_INTEGRAL_ERROR_LSB
''                                                             write_INTEGRAL_ERROR_LSB
''---------------------------------------------------------------------------------
Class REGISTER_DSP_TOP_integral_error_lsb
    Private write_INTEGRAL_ERROR_LSB_value
    Private read_INTEGRAL_ERROR_LSB_value
    Private flag_INTEGRAL_ERROR_LSB

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_INTEGRAL_ERROR_LSB
        get_INTEGRAL_ERROR_LSB = read_INTEGRAL_ERROR_LSB_value
    End Property

    Property Let set_INTEGRAL_ERROR_LSB(aData)
        write_INTEGRAL_ERROR_LSB_value = aData
        flag_INTEGRAL_ERROR_LSB        = &H1
    End Property

    Property Get read_INTEGRAL_ERROR_LSB
        read
        read_INTEGRAL_ERROR_LSB = read_INTEGRAL_ERROR_LSB_value
    End Property

    Property Let write_INTEGRAL_ERROR_LSB(aData)
        set_INTEGRAL_ERROR_LSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        INTEGRAL_ERROR_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if INTEGRAL_ERROR_LSB_mask = mask then
                read_INTEGRAL_ERROR_LSB_value = data_low
            else
                read_INTEGRAL_ERROR_LSB_value = (data_low - H8000_0000) and INTEGRAL_ERROR_LSB_mask
            end If
        else
            read_INTEGRAL_ERROR_LSB_value = data_low and INTEGRAL_ERROR_LSB_mask
        end If

    End Sub

    Sub write
        If flag_INTEGRAL_ERROR_LSB = &H0 Then read
        If flag_INTEGRAL_ERROR_LSB = &H0 Then write_INTEGRAL_ERROR_LSB_value = get_INTEGRAL_ERROR_LSB

        regValue = leftShift((write_INTEGRAL_ERROR_LSB_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        INTEGRAL_ERROR_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if INTEGRAL_ERROR_LSB_mask = mask then
                read_INTEGRAL_ERROR_LSB_value = data_low
            else
                read_INTEGRAL_ERROR_LSB_value = (data_low - H8000_0000) and INTEGRAL_ERROR_LSB_mask
            end If
        else
            read_INTEGRAL_ERROR_LSB_value = data_low and INTEGRAL_ERROR_LSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_INTEGRAL_ERROR_LSB_value = &H0
        flag_INTEGRAL_ERROR_LSB        = &H0
    End Sub
End Class


'' @REGISTER : DSP_TOP_integral_error_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' INTEGRAL_ERROR_MSB                         [11:0]           get_INTEGRAL_ERROR_MSB
''                                                             set_INTEGRAL_ERROR_MSB
''                                                             read_INTEGRAL_ERROR_MSB
''                                                             write_INTEGRAL_ERROR_MSB
''---------------------------------------------------------------------------------
Class REGISTER_DSP_TOP_integral_error_msb
    Private write_INTEGRAL_ERROR_MSB_value
    Private read_INTEGRAL_ERROR_MSB_value
    Private flag_INTEGRAL_ERROR_MSB

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_INTEGRAL_ERROR_MSB
        get_INTEGRAL_ERROR_MSB = read_INTEGRAL_ERROR_MSB_value
    End Property

    Property Let set_INTEGRAL_ERROR_MSB(aData)
        write_INTEGRAL_ERROR_MSB_value = aData
        flag_INTEGRAL_ERROR_MSB        = &H1
    End Property

    Property Get read_INTEGRAL_ERROR_MSB
        read
        read_INTEGRAL_ERROR_MSB = read_INTEGRAL_ERROR_MSB_value
    End Property

    Property Let write_INTEGRAL_ERROR_MSB(aData)
        set_INTEGRAL_ERROR_MSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        INTEGRAL_ERROR_MSB_mask = &Hfff
        if data_low > LONG_MAX then
            if INTEGRAL_ERROR_MSB_mask = mask then
                read_INTEGRAL_ERROR_MSB_value = data_low
            else
                read_INTEGRAL_ERROR_MSB_value = (data_low - H8000_0000) and INTEGRAL_ERROR_MSB_mask
            end If
        else
            read_INTEGRAL_ERROR_MSB_value = data_low and INTEGRAL_ERROR_MSB_mask
        end If

    End Sub

    Sub write
        If flag_INTEGRAL_ERROR_MSB = &H0 Then read
        If flag_INTEGRAL_ERROR_MSB = &H0 Then write_INTEGRAL_ERROR_MSB_value = get_INTEGRAL_ERROR_MSB

        regValue = leftShift((write_INTEGRAL_ERROR_MSB_value and &Hfff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        INTEGRAL_ERROR_MSB_mask = &Hfff
        if data_low > LONG_MAX then
            if INTEGRAL_ERROR_MSB_mask = mask then
                read_INTEGRAL_ERROR_MSB_value = data_low
            else
                read_INTEGRAL_ERROR_MSB_value = (data_low - H8000_0000) and INTEGRAL_ERROR_MSB_mask
            end If
        else
            read_INTEGRAL_ERROR_MSB_value = data_low and INTEGRAL_ERROR_MSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_INTEGRAL_ERROR_MSB_value = &H0
        flag_INTEGRAL_ERROR_MSB        = &H0
    End Sub
End Class


'' @REGISTER : DSP_TOP_nco_accum_lsb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' NCO_ACCUM_LSB                              [15:0]           get_NCO_ACCUM_LSB
''                                                             set_NCO_ACCUM_LSB
''                                                             read_NCO_ACCUM_LSB
''                                                             write_NCO_ACCUM_LSB
''---------------------------------------------------------------------------------
Class REGISTER_DSP_TOP_nco_accum_lsb
    Private write_NCO_ACCUM_LSB_value
    Private read_NCO_ACCUM_LSB_value
    Private flag_NCO_ACCUM_LSB

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3e
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_NCO_ACCUM_LSB
        get_NCO_ACCUM_LSB = read_NCO_ACCUM_LSB_value
    End Property

    Property Let set_NCO_ACCUM_LSB(aData)
        write_NCO_ACCUM_LSB_value = aData
        flag_NCO_ACCUM_LSB        = &H1
    End Property

    Property Get read_NCO_ACCUM_LSB
        read
        read_NCO_ACCUM_LSB = read_NCO_ACCUM_LSB_value
    End Property

    Property Let write_NCO_ACCUM_LSB(aData)
        set_NCO_ACCUM_LSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        NCO_ACCUM_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if NCO_ACCUM_LSB_mask = mask then
                read_NCO_ACCUM_LSB_value = data_low
            else
                read_NCO_ACCUM_LSB_value = (data_low - H8000_0000) and NCO_ACCUM_LSB_mask
            end If
        else
            read_NCO_ACCUM_LSB_value = data_low and NCO_ACCUM_LSB_mask
        end If

    End Sub

    Sub write
        If flag_NCO_ACCUM_LSB = &H0 Then read
        If flag_NCO_ACCUM_LSB = &H0 Then write_NCO_ACCUM_LSB_value = get_NCO_ACCUM_LSB

        regValue = leftShift((write_NCO_ACCUM_LSB_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        NCO_ACCUM_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if NCO_ACCUM_LSB_mask = mask then
                read_NCO_ACCUM_LSB_value = data_low
            else
                read_NCO_ACCUM_LSB_value = (data_low - H8000_0000) and NCO_ACCUM_LSB_mask
            end If
        else
            read_NCO_ACCUM_LSB_value = data_low and NCO_ACCUM_LSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_NCO_ACCUM_LSB_value = &H0
        flag_NCO_ACCUM_LSB        = &H0
    End Sub
End Class


'' @REGISTER : DSP_TOP_nco_accum_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' NCO_ACCUM_MSB                              [4:0]            get_NCO_ACCUM_MSB
''                                                             set_NCO_ACCUM_MSB
''                                                             read_NCO_ACCUM_MSB
''                                                             write_NCO_ACCUM_MSB
''---------------------------------------------------------------------------------
Class REGISTER_DSP_TOP_nco_accum_msb
    Private write_NCO_ACCUM_MSB_value
    Private read_NCO_ACCUM_MSB_value
    Private flag_NCO_ACCUM_MSB

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

    Property Get get_NCO_ACCUM_MSB
        get_NCO_ACCUM_MSB = read_NCO_ACCUM_MSB_value
    End Property

    Property Let set_NCO_ACCUM_MSB(aData)
        write_NCO_ACCUM_MSB_value = aData
        flag_NCO_ACCUM_MSB        = &H1
    End Property

    Property Get read_NCO_ACCUM_MSB
        read
        read_NCO_ACCUM_MSB = read_NCO_ACCUM_MSB_value
    End Property

    Property Let write_NCO_ACCUM_MSB(aData)
        set_NCO_ACCUM_MSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        NCO_ACCUM_MSB_mask = &H1f
        if data_low > LONG_MAX then
            if NCO_ACCUM_MSB_mask = mask then
                read_NCO_ACCUM_MSB_value = data_low
            else
                read_NCO_ACCUM_MSB_value = (data_low - H8000_0000) and NCO_ACCUM_MSB_mask
            end If
        else
            read_NCO_ACCUM_MSB_value = data_low and NCO_ACCUM_MSB_mask
        end If

    End Sub

    Sub write
        If flag_NCO_ACCUM_MSB = &H0 Then read
        If flag_NCO_ACCUM_MSB = &H0 Then write_NCO_ACCUM_MSB_value = get_NCO_ACCUM_MSB

        regValue = leftShift((write_NCO_ACCUM_MSB_value and &H1f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        NCO_ACCUM_MSB_mask = &H1f
        if data_low > LONG_MAX then
            if NCO_ACCUM_MSB_mask = mask then
                read_NCO_ACCUM_MSB_value = data_low
            else
                read_NCO_ACCUM_MSB_value = (data_low - H8000_0000) and NCO_ACCUM_MSB_mask
            end If
        else
            read_NCO_ACCUM_MSB_value = data_low and NCO_ACCUM_MSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_NCO_ACCUM_MSB_value = &H0
        flag_NCO_ACCUM_MSB        = &H0
    End Sub
End Class


'' @REGISTER : DSP_TOP_phase_control
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PHASE_CONTROL                              [3:0]            get_PHASE_CONTROL
''                                                             set_PHASE_CONTROL
''                                                             read_PHASE_CONTROL
''                                                             write_PHASE_CONTROL
''---------------------------------------------------------------------------------
Class REGISTER_DSP_TOP_phase_control
    Private write_PHASE_CONTROL_value
    Private read_PHASE_CONTROL_value
    Private flag_PHASE_CONTROL

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

    Property Get get_PHASE_CONTROL
        get_PHASE_CONTROL = read_PHASE_CONTROL_value
    End Property

    Property Let set_PHASE_CONTROL(aData)
        write_PHASE_CONTROL_value = aData
        flag_PHASE_CONTROL        = &H1
    End Property

    Property Get read_PHASE_CONTROL
        read
        read_PHASE_CONTROL = read_PHASE_CONTROL_value
    End Property

    Property Let write_PHASE_CONTROL(aData)
        set_PHASE_CONTROL = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PHASE_CONTROL_mask = &Hf
        if data_low > LONG_MAX then
            if PHASE_CONTROL_mask = mask then
                read_PHASE_CONTROL_value = data_low
            else
                read_PHASE_CONTROL_value = (data_low - H8000_0000) and PHASE_CONTROL_mask
            end If
        else
            read_PHASE_CONTROL_value = data_low and PHASE_CONTROL_mask
        end If

    End Sub

    Sub write
        If flag_PHASE_CONTROL = &H0 Then read
        If flag_PHASE_CONTROL = &H0 Then write_PHASE_CONTROL_value = get_PHASE_CONTROL

        regValue = leftShift((write_PHASE_CONTROL_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PHASE_CONTROL_mask = &Hf
        if data_low > LONG_MAX then
            if PHASE_CONTROL_mask = mask then
                read_PHASE_CONTROL_value = data_low
            else
                read_PHASE_CONTROL_value = (data_low - H8000_0000) and PHASE_CONTROL_mask
            end If
        else
            read_PHASE_CONTROL_value = data_low and PHASE_CONTROL_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PHASE_CONTROL_value = &H0
        flag_PHASE_CONTROL        = &H0
    End Sub
End Class


'' @REGISTER : DSP_TOP_first_ce_precursor_lsb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' FIRST_CE_PRECURSOR_LSB                     [15:0]           get_FIRST_CE_PRECURSOR_LSB
''                                                             set_FIRST_CE_PRECURSOR_LSB
''                                                             read_FIRST_CE_PRECURSOR_LSB
''                                                             write_FIRST_CE_PRECURSOR_LSB
''---------------------------------------------------------------------------------
Class REGISTER_DSP_TOP_first_ce_precursor_lsb
    Private write_FIRST_CE_PRECURSOR_LSB_value
    Private read_FIRST_CE_PRECURSOR_LSB_value
    Private flag_FIRST_CE_PRECURSOR_LSB

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

    Property Get get_FIRST_CE_PRECURSOR_LSB
        get_FIRST_CE_PRECURSOR_LSB = read_FIRST_CE_PRECURSOR_LSB_value
    End Property

    Property Let set_FIRST_CE_PRECURSOR_LSB(aData)
        write_FIRST_CE_PRECURSOR_LSB_value = aData
        flag_FIRST_CE_PRECURSOR_LSB        = &H1
    End Property

    Property Get read_FIRST_CE_PRECURSOR_LSB
        read
        read_FIRST_CE_PRECURSOR_LSB = read_FIRST_CE_PRECURSOR_LSB_value
    End Property

    Property Let write_FIRST_CE_PRECURSOR_LSB(aData)
        set_FIRST_CE_PRECURSOR_LSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        FIRST_CE_PRECURSOR_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if FIRST_CE_PRECURSOR_LSB_mask = mask then
                read_FIRST_CE_PRECURSOR_LSB_value = data_low
            else
                read_FIRST_CE_PRECURSOR_LSB_value = (data_low - H8000_0000) and FIRST_CE_PRECURSOR_LSB_mask
            end If
        else
            read_FIRST_CE_PRECURSOR_LSB_value = data_low and FIRST_CE_PRECURSOR_LSB_mask
        end If

    End Sub

    Sub write
        If flag_FIRST_CE_PRECURSOR_LSB = &H0 Then read
        If flag_FIRST_CE_PRECURSOR_LSB = &H0 Then write_FIRST_CE_PRECURSOR_LSB_value = get_FIRST_CE_PRECURSOR_LSB

        regValue = leftShift((write_FIRST_CE_PRECURSOR_LSB_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        FIRST_CE_PRECURSOR_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if FIRST_CE_PRECURSOR_LSB_mask = mask then
                read_FIRST_CE_PRECURSOR_LSB_value = data_low
            else
                read_FIRST_CE_PRECURSOR_LSB_value = (data_low - H8000_0000) and FIRST_CE_PRECURSOR_LSB_mask
            end If
        else
            read_FIRST_CE_PRECURSOR_LSB_value = data_low and FIRST_CE_PRECURSOR_LSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_FIRST_CE_PRECURSOR_LSB_value = &H0
        flag_FIRST_CE_PRECURSOR_LSB        = &H0
    End Sub
End Class


'' @REGISTER : DSP_TOP_first_ce_precursor_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' FIRST_CE_PRECURSOR_MSB                     [8:0]            get_FIRST_CE_PRECURSOR_MSB
''                                                             set_FIRST_CE_PRECURSOR_MSB
''                                                             read_FIRST_CE_PRECURSOR_MSB
''                                                             write_FIRST_CE_PRECURSOR_MSB
''---------------------------------------------------------------------------------
Class REGISTER_DSP_TOP_first_ce_precursor_msb
    Private write_FIRST_CE_PRECURSOR_MSB_value
    Private read_FIRST_CE_PRECURSOR_MSB_value
    Private flag_FIRST_CE_PRECURSOR_MSB

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

    Property Get get_FIRST_CE_PRECURSOR_MSB
        get_FIRST_CE_PRECURSOR_MSB = read_FIRST_CE_PRECURSOR_MSB_value
    End Property

    Property Let set_FIRST_CE_PRECURSOR_MSB(aData)
        write_FIRST_CE_PRECURSOR_MSB_value = aData
        flag_FIRST_CE_PRECURSOR_MSB        = &H1
    End Property

    Property Get read_FIRST_CE_PRECURSOR_MSB
        read
        read_FIRST_CE_PRECURSOR_MSB = read_FIRST_CE_PRECURSOR_MSB_value
    End Property

    Property Let write_FIRST_CE_PRECURSOR_MSB(aData)
        set_FIRST_CE_PRECURSOR_MSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        FIRST_CE_PRECURSOR_MSB_mask = &H1ff
        if data_low > LONG_MAX then
            if FIRST_CE_PRECURSOR_MSB_mask = mask then
                read_FIRST_CE_PRECURSOR_MSB_value = data_low
            else
                read_FIRST_CE_PRECURSOR_MSB_value = (data_low - H8000_0000) and FIRST_CE_PRECURSOR_MSB_mask
            end If
        else
            read_FIRST_CE_PRECURSOR_MSB_value = data_low and FIRST_CE_PRECURSOR_MSB_mask
        end If

    End Sub

    Sub write
        If flag_FIRST_CE_PRECURSOR_MSB = &H0 Then read
        If flag_FIRST_CE_PRECURSOR_MSB = &H0 Then write_FIRST_CE_PRECURSOR_MSB_value = get_FIRST_CE_PRECURSOR_MSB

        regValue = leftShift((write_FIRST_CE_PRECURSOR_MSB_value and &H1ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        FIRST_CE_PRECURSOR_MSB_mask = &H1ff
        if data_low > LONG_MAX then
            if FIRST_CE_PRECURSOR_MSB_mask = mask then
                read_FIRST_CE_PRECURSOR_MSB_value = data_low
            else
                read_FIRST_CE_PRECURSOR_MSB_value = (data_low - H8000_0000) and FIRST_CE_PRECURSOR_MSB_mask
            end If
        else
            read_FIRST_CE_PRECURSOR_MSB_value = data_low and FIRST_CE_PRECURSOR_MSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_FIRST_CE_PRECURSOR_MSB_value = &H0
        flag_FIRST_CE_PRECURSOR_MSB        = &H0
    End Sub
End Class


'' @REGISTER : DSP_TOP_spare_end_addr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SPARE_REGISTER                             [15:0]           get_SPARE_REGISTER
''                                                             set_SPARE_REGISTER
''                                                             read_SPARE_REGISTER
''                                                             write_SPARE_REGISTER
''---------------------------------------------------------------------------------
Class REGISTER_DSP_TOP_spare_end_addr
    Private write_SPARE_REGISTER_value
    Private read_SPARE_REGISTER_value
    Private flag_SPARE_REGISTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7e
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SPARE_REGISTER
        get_SPARE_REGISTER = read_SPARE_REGISTER_value
    End Property

    Property Let set_SPARE_REGISTER(aData)
        write_SPARE_REGISTER_value = aData
        flag_SPARE_REGISTER        = &H1
    End Property

    Property Get read_SPARE_REGISTER
        read
        read_SPARE_REGISTER = read_SPARE_REGISTER_value
    End Property

    Property Let write_SPARE_REGISTER(aData)
        set_SPARE_REGISTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SPARE_REGISTER_mask = &Hffff
        if data_low > LONG_MAX then
            if SPARE_REGISTER_mask = mask then
                read_SPARE_REGISTER_value = data_low
            else
                read_SPARE_REGISTER_value = (data_low - H8000_0000) and SPARE_REGISTER_mask
            end If
        else
            read_SPARE_REGISTER_value = data_low and SPARE_REGISTER_mask
        end If

    End Sub

    Sub write
        If flag_SPARE_REGISTER = &H0 Then read
        If flag_SPARE_REGISTER = &H0 Then write_SPARE_REGISTER_value = get_SPARE_REGISTER

        regValue = leftShift((write_SPARE_REGISTER_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SPARE_REGISTER_mask = &Hffff
        if data_low > LONG_MAX then
            if SPARE_REGISTER_mask = mask then
                read_SPARE_REGISTER_value = data_low
            else
                read_SPARE_REGISTER_value = (data_low - H8000_0000) and SPARE_REGISTER_mask
            end If
        else
            read_SPARE_REGISTER_value = data_low and SPARE_REGISTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SPARE_REGISTER_value = &H0
        flag_SPARE_REGISTER        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class DSP_TOP_INSTANCE

    Public dagc_status_0
    Public dagc_status_1
    Public soft_decision_even
    Public soft_decision_odd
    Public agc_ref_lvl
    Public agc_override_0
    Public agc_override_1
    Public dsp_test0
    Public dsp_test1
    Public agc_status
    Public phshft_control
    Public ted_dpll_control
    Public agc_100_ref_lvl
    Public agc_100_override_0
    Public agc_100_override_1
    Public agc_100_status
    Public agc_100_ctrl_0
    Public dcoffset_accum_lsb
    Public dcoffset_accum_msb
    Public dagc_accum_lsb
    Public dagc_accum_msb
    Public dpll_frz_bw_control
    Public dpll_frst_pramp_control
    Public dpll_fval_lsb
    Public dpll_fval_msb
    Public ce_timing_error
    Public pherr_accum_s1
    Public pherr_accum_s2
    Public phase_error
    Public integral_error_lsb
    Public integral_error_msb
    Public nco_accum_lsb
    Public nco_accum_msb
    Public phase_control
    Public first_ce_precursor_lsb
    Public first_ce_precursor_msb
    Public spare_end_addr


    Public default function Init(aBaseAddr)
        Set dagc_status_0 = (New REGISTER_DSP_TOP_dagc_status_0)(aBaseAddr, 16)
        Set dagc_status_1 = (New REGISTER_DSP_TOP_dagc_status_1)(aBaseAddr, 16)
        Set soft_decision_even = (New REGISTER_DSP_TOP_soft_decision_even)(aBaseAddr, 16)
        Set soft_decision_odd = (New REGISTER_DSP_TOP_soft_decision_odd)(aBaseAddr, 16)
        Set agc_ref_lvl = (New REGISTER_DSP_TOP_agc_ref_lvl)(aBaseAddr, 16)
        Set agc_override_0 = (New REGISTER_DSP_TOP_agc_override_0)(aBaseAddr, 16)
        Set agc_override_1 = (New REGISTER_DSP_TOP_agc_override_1)(aBaseAddr, 16)
        Set dsp_test0 = (New REGISTER_DSP_TOP_dsp_test0)(aBaseAddr, 16)
        Set dsp_test1 = (New REGISTER_DSP_TOP_dsp_test1)(aBaseAddr, 16)
        Set agc_status = (New REGISTER_DSP_TOP_agc_status)(aBaseAddr, 16)
        Set phshft_control = (New REGISTER_DSP_TOP_phshft_control)(aBaseAddr, 16)
        Set ted_dpll_control = (New REGISTER_DSP_TOP_ted_dpll_control)(aBaseAddr, 16)
        Set agc_100_ref_lvl = (New REGISTER_DSP_TOP_agc_100_ref_lvl)(aBaseAddr, 16)
        Set agc_100_override_0 = (New REGISTER_DSP_TOP_agc_100_override_0)(aBaseAddr, 16)
        Set agc_100_override_1 = (New REGISTER_DSP_TOP_agc_100_override_1)(aBaseAddr, 16)
        Set agc_100_status = (New REGISTER_DSP_TOP_agc_100_status)(aBaseAddr, 16)
        Set agc_100_ctrl_0 = (New REGISTER_DSP_TOP_agc_100_ctrl_0)(aBaseAddr, 16)
        Set dcoffset_accum_lsb = (New REGISTER_DSP_TOP_dcoffset_accum_lsb)(aBaseAddr, 16)
        Set dcoffset_accum_msb = (New REGISTER_DSP_TOP_dcoffset_accum_msb)(aBaseAddr, 16)
        Set dagc_accum_lsb = (New REGISTER_DSP_TOP_dagc_accum_lsb)(aBaseAddr, 16)
        Set dagc_accum_msb = (New REGISTER_DSP_TOP_dagc_accum_msb)(aBaseAddr, 16)
        Set dpll_frz_bw_control = (New REGISTER_DSP_TOP_dpll_frz_bw_control)(aBaseAddr, 16)
        Set dpll_frst_pramp_control = (New REGISTER_DSP_TOP_dpll_frst_pramp_control)(aBaseAddr, 16)
        Set dpll_fval_lsb = (New REGISTER_DSP_TOP_dpll_fval_lsb)(aBaseAddr, 16)
        Set dpll_fval_msb = (New REGISTER_DSP_TOP_dpll_fval_msb)(aBaseAddr, 16)
        Set ce_timing_error = (New REGISTER_DSP_TOP_ce_timing_error)(aBaseAddr, 16)
        Set pherr_accum_s1 = (New REGISTER_DSP_TOP_pherr_accum_s1)(aBaseAddr, 16)
        Set pherr_accum_s2 = (New REGISTER_DSP_TOP_pherr_accum_s2)(aBaseAddr, 16)
        Set phase_error = (New REGISTER_DSP_TOP_phase_error)(aBaseAddr, 16)
        Set integral_error_lsb = (New REGISTER_DSP_TOP_integral_error_lsb)(aBaseAddr, 16)
        Set integral_error_msb = (New REGISTER_DSP_TOP_integral_error_msb)(aBaseAddr, 16)
        Set nco_accum_lsb = (New REGISTER_DSP_TOP_nco_accum_lsb)(aBaseAddr, 16)
        Set nco_accum_msb = (New REGISTER_DSP_TOP_nco_accum_msb)(aBaseAddr, 16)
        Set phase_control = (New REGISTER_DSP_TOP_phase_control)(aBaseAddr, 16)
        Set first_ce_precursor_lsb = (New REGISTER_DSP_TOP_first_ce_precursor_lsb)(aBaseAddr, 16)
        Set first_ce_precursor_msb = (New REGISTER_DSP_TOP_first_ce_precursor_msb)(aBaseAddr, 16)
        Set spare_end_addr = (New REGISTER_DSP_TOP_spare_end_addr)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set DSP_TOP = CreateObject("System.Collections.ArrayList")
DSP_TOP.Add ((New DSP_TOP_INSTANCE)(&H49030a00))


