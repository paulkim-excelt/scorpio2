

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


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_SYSTEM_CONTROL_saf_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' enable                                     [0:0]            get_enable
''                                                             set_enable
''                                                             read_enable
''                                                             write_enable
''---------------------------------------------------------------------------------
'' DROP_CLASS                                 [1:1]            get_DROP_CLASS
''                                                             set_DROP_CLASS
''                                                             read_DROP_CLASS
''                                                             write_DROP_CLASS
''---------------------------------------------------------------------------------
'' DROP_PP                                    [2:2]            get_DROP_PP
''                                                             set_DROP_PP
''                                                             read_DROP_PP
''                                                             write_DROP_PP
''---------------------------------------------------------------------------------
'' DROP_SECFAIL                               [3:3]            get_DROP_SECFAIL
''                                                             set_DROP_SECFAIL
''                                                             read_DROP_SECFAIL
''                                                             write_DROP_SECFAIL
''---------------------------------------------------------------------------------
'' DROP_MTU                                   [4:4]            get_DROP_MTU
''                                                             set_DROP_MTU
''                                                             read_DROP_MTU
''                                                             write_DROP_MTU
''---------------------------------------------------------------------------------
'' DROP_MACERR                                [5:5]            get_DROP_MACERR
''                                                             set_DROP_MACERR
''                                                             read_DROP_MACERR
''                                                             write_DROP_MACERR
''---------------------------------------------------------------------------------
'' DROP_MACCRC                                [6:6]            get_DROP_MACCRC
''                                                             set_DROP_MACCRC
''                                                             read_DROP_MACCRC
''                                                             write_DROP_MACCRC
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_SYSTEM_CONTROL_saf_ctrl
    Private write_enable_value
    Private read_enable_value
    Private flag_enable
    Private write_DROP_CLASS_value
    Private read_DROP_CLASS_value
    Private flag_DROP_CLASS
    Private write_DROP_PP_value
    Private read_DROP_PP_value
    Private flag_DROP_PP
    Private write_DROP_SECFAIL_value
    Private read_DROP_SECFAIL_value
    Private flag_DROP_SECFAIL
    Private write_DROP_MTU_value
    Private read_DROP_MTU_value
    Private flag_DROP_MTU
    Private write_DROP_MACERR_value
    Private read_DROP_MACERR_value
    Private flag_DROP_MACERR
    Private write_DROP_MACCRC_value
    Private read_DROP_MACCRC_value
    Private flag_DROP_MACCRC

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hfe00
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_enable
        get_enable = read_enable_value
    End Property

    Property Let set_enable(aData)
        write_enable_value = aData
        flag_enable        = &H1
    End Property

    Property Get read_enable
        read
        read_enable = read_enable_value
    End Property

    Property Let write_enable(aData)
        set_enable = aData
        write
    End Property

    Property Get get_DROP_CLASS
        get_DROP_CLASS = read_DROP_CLASS_value
    End Property

    Property Let set_DROP_CLASS(aData)
        write_DROP_CLASS_value = aData
        flag_DROP_CLASS        = &H1
    End Property

    Property Get read_DROP_CLASS
        read
        read_DROP_CLASS = read_DROP_CLASS_value
    End Property

    Property Let write_DROP_CLASS(aData)
        set_DROP_CLASS = aData
        write
    End Property

    Property Get get_DROP_PP
        get_DROP_PP = read_DROP_PP_value
    End Property

    Property Let set_DROP_PP(aData)
        write_DROP_PP_value = aData
        flag_DROP_PP        = &H1
    End Property

    Property Get read_DROP_PP
        read
        read_DROP_PP = read_DROP_PP_value
    End Property

    Property Let write_DROP_PP(aData)
        set_DROP_PP = aData
        write
    End Property

    Property Get get_DROP_SECFAIL
        get_DROP_SECFAIL = read_DROP_SECFAIL_value
    End Property

    Property Let set_DROP_SECFAIL(aData)
        write_DROP_SECFAIL_value = aData
        flag_DROP_SECFAIL        = &H1
    End Property

    Property Get read_DROP_SECFAIL
        read
        read_DROP_SECFAIL = read_DROP_SECFAIL_value
    End Property

    Property Let write_DROP_SECFAIL(aData)
        set_DROP_SECFAIL = aData
        write
    End Property

    Property Get get_DROP_MTU
        get_DROP_MTU = read_DROP_MTU_value
    End Property

    Property Let set_DROP_MTU(aData)
        write_DROP_MTU_value = aData
        flag_DROP_MTU        = &H1
    End Property

    Property Get read_DROP_MTU
        read
        read_DROP_MTU = read_DROP_MTU_value
    End Property

    Property Let write_DROP_MTU(aData)
        set_DROP_MTU = aData
        write
    End Property

    Property Get get_DROP_MACERR
        get_DROP_MACERR = read_DROP_MACERR_value
    End Property

    Property Let set_DROP_MACERR(aData)
        write_DROP_MACERR_value = aData
        flag_DROP_MACERR        = &H1
    End Property

    Property Get read_DROP_MACERR
        read
        read_DROP_MACERR = read_DROP_MACERR_value
    End Property

    Property Let write_DROP_MACERR(aData)
        set_DROP_MACERR = aData
        write
    End Property

    Property Get get_DROP_MACCRC
        get_DROP_MACCRC = read_DROP_MACCRC_value
    End Property

    Property Let set_DROP_MACCRC(aData)
        write_DROP_MACCRC_value = aData
        flag_DROP_MACCRC        = &H1
    End Property

    Property Get read_DROP_MACCRC
        read
        read_DROP_MACCRC = read_DROP_MACCRC_value
    End Property

    Property Let write_DROP_MACCRC(aData)
        set_DROP_MACCRC = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        enable_mask = &H1
        if data_low > LONG_MAX then
            if enable_mask = mask then
                read_enable_value = data_low
            else
                read_enable_value = (data_low - H8000_0000) and enable_mask
            end If
        else
            read_enable_value = data_low and enable_mask
        end If
        read_DROP_CLASS_value = rightShift(data_low, 1) and &H1
        read_DROP_PP_value = rightShift(data_low, 2) and &H1
        read_DROP_SECFAIL_value = rightShift(data_low, 3) and &H1
        read_DROP_MTU_value = rightShift(data_low, 4) and &H1
        read_DROP_MACERR_value = rightShift(data_low, 5) and &H1
        read_DROP_MACCRC_value = rightShift(data_low, 6) and &H1

    End Sub

    Sub write
        If flag_enable = &H0 or flag_DROP_CLASS = &H0 or flag_DROP_PP = &H0 or flag_DROP_SECFAIL = &H0 or flag_DROP_MTU = &H0 or flag_DROP_MACERR = &H0 or flag_DROP_MACCRC = &H0 Then read
        If flag_enable = &H0 Then write_enable_value = get_enable
        If flag_DROP_CLASS = &H0 Then write_DROP_CLASS_value = get_DROP_CLASS
        If flag_DROP_PP = &H0 Then write_DROP_PP_value = get_DROP_PP
        If flag_DROP_SECFAIL = &H0 Then write_DROP_SECFAIL_value = get_DROP_SECFAIL
        If flag_DROP_MTU = &H0 Then write_DROP_MTU_value = get_DROP_MTU
        If flag_DROP_MACERR = &H0 Then write_DROP_MACERR_value = get_DROP_MACERR
        If flag_DROP_MACCRC = &H0 Then write_DROP_MACCRC_value = get_DROP_MACCRC

        regValue = leftShift((write_enable_value and &H1), 0) + leftShift((write_DROP_CLASS_value and &H1), 1) + leftShift((write_DROP_PP_value and &H1), 2) + leftShift((write_DROP_SECFAIL_value and &H1), 3) + leftShift((write_DROP_MTU_value and &H1), 4) + leftShift((write_DROP_MACERR_value and &H1), 5) + leftShift((write_DROP_MACCRC_value and &H1), 6)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        enable_mask = &H1
        if data_low > LONG_MAX then
            if enable_mask = mask then
                read_enable_value = data_low
            else
                read_enable_value = (data_low - H8000_0000) and enable_mask
            end If
        else
            read_enable_value = data_low and enable_mask
        end If
        read_DROP_CLASS_value = rightShift(data_low, 1) and &H1
        read_DROP_PP_value = rightShift(data_low, 2) and &H1
        read_DROP_SECFAIL_value = rightShift(data_low, 3) and &H1
        read_DROP_MTU_value = rightShift(data_low, 4) and &H1
        read_DROP_MACERR_value = rightShift(data_low, 5) and &H1
        read_DROP_MACCRC_value = rightShift(data_low, 6) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_enable_value = &H0
        flag_enable        = &H0
        write_DROP_CLASS_value = &H0
        flag_DROP_CLASS        = &H0
        write_DROP_PP_value = &H0
        flag_DROP_PP        = &H0
        write_DROP_SECFAIL_value = &H0
        flag_DROP_SECFAIL        = &H0
        write_DROP_MTU_value = &H0
        flag_DROP_MTU        = &H0
        write_DROP_MACERR_value = &H0
        flag_DROP_MACERR        = &H0
        write_DROP_MACCRC_value = &H0
        flag_DROP_MACCRC        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_SYSTEM_CONTROL_saf_threshold
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LOW_WATE                                   [11:0]           get_LOW_WATE
''                                                             set_LOW_WATE
''                                                             read_LOW_WATE
''                                                             write_LOW_WATE
''---------------------------------------------------------------------------------
'' HIGH_WATE                                  [27:16]          get_HIGH_WATE
''                                                             set_HIGH_WATE
''                                                             read_HIGH_WATE
''                                                             write_HIGH_WATE
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_SYSTEM_CONTROL_saf_threshold
    Private write_LOW_WATE_value
    Private read_LOW_WATE_value
    Private flag_LOW_WATE
    Private write_HIGH_WATE_value
    Private read_HIGH_WATE_value
    Private flag_HIGH_WATE

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hfe04
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_LOW_WATE
        get_LOW_WATE = read_LOW_WATE_value
    End Property

    Property Let set_LOW_WATE(aData)
        write_LOW_WATE_value = aData
        flag_LOW_WATE        = &H1
    End Property

    Property Get read_LOW_WATE
        read
        read_LOW_WATE = read_LOW_WATE_value
    End Property

    Property Let write_LOW_WATE(aData)
        set_LOW_WATE = aData
        write
    End Property

    Property Get get_HIGH_WATE
        get_HIGH_WATE = read_HIGH_WATE_value
    End Property

    Property Let set_HIGH_WATE(aData)
        write_HIGH_WATE_value = aData
        flag_HIGH_WATE        = &H1
    End Property

    Property Get read_HIGH_WATE
        read
        read_HIGH_WATE = read_HIGH_WATE_value
    End Property

    Property Let write_HIGH_WATE(aData)
        set_HIGH_WATE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOW_WATE_mask = &Hfff
        if data_low > LONG_MAX then
            if LOW_WATE_mask = mask then
                read_LOW_WATE_value = data_low
            else
                read_LOW_WATE_value = (data_low - H8000_0000) and LOW_WATE_mask
            end If
        else
            read_LOW_WATE_value = data_low and LOW_WATE_mask
        end If
        read_HIGH_WATE_value = rightShift(data_low, 16) and &Hfff

    End Sub

    Sub write
        If flag_LOW_WATE = &H0 or flag_HIGH_WATE = &H0 Then read
        If flag_LOW_WATE = &H0 Then write_LOW_WATE_value = get_LOW_WATE
        If flag_HIGH_WATE = &H0 Then write_HIGH_WATE_value = get_HIGH_WATE

        regValue = leftShift((write_LOW_WATE_value and &Hfff), 0) + leftShift((write_HIGH_WATE_value and &Hfff), 16)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LOW_WATE_mask = &Hfff
        if data_low > LONG_MAX then
            if LOW_WATE_mask = mask then
                read_LOW_WATE_value = data_low
            else
                read_LOW_WATE_value = (data_low - H8000_0000) and LOW_WATE_mask
            end If
        else
            read_LOW_WATE_value = data_low and LOW_WATE_mask
        end If
        read_HIGH_WATE_value = rightShift(data_low, 16) and &Hfff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LOW_WATE_value = &H0
        flag_LOW_WATE        = &H0
        write_HIGH_WATE_value = &H0
        flag_HIGH_WATE        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_SYSTEM_CONTROL_eip160_clock_state
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pe_clk                                     [0:0]            get_pe_clk
''                                                             set_pe_clk
''                                                             read_pe_clk
''                                                             write_pe_clk
''---------------------------------------------------------------------------------
'' ice_clk                                    [1:1]            get_ice_clk
''                                                             set_ice_clk
''                                                             read_ice_clk
''                                                             write_ice_clk
''---------------------------------------------------------------------------------
'' RXCAM_CLK                                  [4:4]            get_RXCAM_CLK
''                                                             set_RXCAM_CLK
''                                                             read_RXCAM_CLK
''                                                             write_RXCAM_CLK
''---------------------------------------------------------------------------------
'' flow_clk                                   [5:5]            get_flow_clk
''                                                             set_flow_clk
''                                                             read_flow_clk
''                                                             write_flow_clk
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_SYSTEM_CONTROL_eip160_clock_state
    Private write_pe_clk_value
    Private read_pe_clk_value
    Private flag_pe_clk
    Private write_ice_clk_value
    Private read_ice_clk_value
    Private flag_ice_clk
    Private write_RXCAM_CLK_value
    Private read_RXCAM_CLK_value
    Private flag_RXCAM_CLK
    Private write_flow_clk_value
    Private read_flow_clk_value
    Private flag_flow_clk

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hffe8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_pe_clk
        get_pe_clk = read_pe_clk_value
    End Property

    Property Let set_pe_clk(aData)
        write_pe_clk_value = aData
        flag_pe_clk        = &H1
    End Property

    Property Get read_pe_clk
        read
        read_pe_clk = read_pe_clk_value
    End Property

    Property Let write_pe_clk(aData)
        set_pe_clk = aData
        write
    End Property

    Property Get get_ice_clk
        get_ice_clk = read_ice_clk_value
    End Property

    Property Let set_ice_clk(aData)
        write_ice_clk_value = aData
        flag_ice_clk        = &H1
    End Property

    Property Get read_ice_clk
        read
        read_ice_clk = read_ice_clk_value
    End Property

    Property Let write_ice_clk(aData)
        set_ice_clk = aData
        write
    End Property

    Property Get get_RXCAM_CLK
        get_RXCAM_CLK = read_RXCAM_CLK_value
    End Property

    Property Let set_RXCAM_CLK(aData)
        write_RXCAM_CLK_value = aData
        flag_RXCAM_CLK        = &H1
    End Property

    Property Get read_RXCAM_CLK
        read
        read_RXCAM_CLK = read_RXCAM_CLK_value
    End Property

    Property Let write_RXCAM_CLK(aData)
        set_RXCAM_CLK = aData
        write
    End Property

    Property Get get_flow_clk
        get_flow_clk = read_flow_clk_value
    End Property

    Property Let set_flow_clk(aData)
        write_flow_clk_value = aData
        flag_flow_clk        = &H1
    End Property

    Property Get read_flow_clk
        read
        read_flow_clk = read_flow_clk_value
    End Property

    Property Let write_flow_clk(aData)
        set_flow_clk = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pe_clk_mask = &H1
        if data_low > LONG_MAX then
            if pe_clk_mask = mask then
                read_pe_clk_value = data_low
            else
                read_pe_clk_value = (data_low - H8000_0000) and pe_clk_mask
            end If
        else
            read_pe_clk_value = data_low and pe_clk_mask
        end If
        read_ice_clk_value = rightShift(data_low, 1) and &H1
        read_RXCAM_CLK_value = rightShift(data_low, 4) and &H1
        read_flow_clk_value = rightShift(data_low, 5) and &H1

    End Sub

    Sub write
        If flag_pe_clk = &H0 or flag_ice_clk = &H0 or flag_RXCAM_CLK = &H0 or flag_flow_clk = &H0 Then read
        If flag_pe_clk = &H0 Then write_pe_clk_value = get_pe_clk
        If flag_ice_clk = &H0 Then write_ice_clk_value = get_ice_clk
        If flag_RXCAM_CLK = &H0 Then write_RXCAM_CLK_value = get_RXCAM_CLK
        If flag_flow_clk = &H0 Then write_flow_clk_value = get_flow_clk

        regValue = leftShift((write_pe_clk_value and &H1), 0) + leftShift((write_ice_clk_value and &H1), 1) + leftShift((write_RXCAM_CLK_value and &H1), 4) + leftShift((write_flow_clk_value and &H1), 5)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pe_clk_mask = &H1
        if data_low > LONG_MAX then
            if pe_clk_mask = mask then
                read_pe_clk_value = data_low
            else
                read_pe_clk_value = (data_low - H8000_0000) and pe_clk_mask
            end If
        else
            read_pe_clk_value = data_low and pe_clk_mask
        end If
        read_ice_clk_value = rightShift(data_low, 1) and &H1
        read_RXCAM_CLK_value = rightShift(data_low, 4) and &H1
        read_flow_clk_value = rightShift(data_low, 5) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pe_clk_value = &H0
        flag_pe_clk        = &H0
        write_ice_clk_value = &H0
        flag_ice_clk        = &H0
        write_RXCAM_CLK_value = &H0
        flag_RXCAM_CLK        = &H0
        write_flow_clk_value = &H0
        flag_flow_clk        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_SYSTEM_CONTROL_eip160_force_clock_on
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PE_CLK_ON                                  [0:0]            get_PE_CLK_ON
''                                                             set_PE_CLK_ON
''                                                             read_PE_CLK_ON
''                                                             write_PE_CLK_ON
''---------------------------------------------------------------------------------
'' ICE_CLK_ON                                 [1:1]            get_ICE_CLK_ON
''                                                             set_ICE_CLK_ON
''                                                             read_ICE_CLK_ON
''                                                             write_ICE_CLK_ON
''---------------------------------------------------------------------------------
'' RXCAM_CLK_ON                               [4:4]            get_RXCAM_CLK_ON
''                                                             set_RXCAM_CLK_ON
''                                                             read_RXCAM_CLK_ON
''                                                             write_RXCAM_CLK_ON
''---------------------------------------------------------------------------------
'' FLOW_CLK_ON                                [5:5]            get_FLOW_CLK_ON
''                                                             set_FLOW_CLK_ON
''                                                             read_FLOW_CLK_ON
''                                                             write_FLOW_CLK_ON
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_SYSTEM_CONTROL_eip160_force_clock_on
    Private write_PE_CLK_ON_value
    Private read_PE_CLK_ON_value
    Private flag_PE_CLK_ON
    Private write_ICE_CLK_ON_value
    Private read_ICE_CLK_ON_value
    Private flag_ICE_CLK_ON
    Private write_RXCAM_CLK_ON_value
    Private read_RXCAM_CLK_ON_value
    Private flag_RXCAM_CLK_ON
    Private write_FLOW_CLK_ON_value
    Private read_FLOW_CLK_ON_value
    Private flag_FLOW_CLK_ON

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hffec
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PE_CLK_ON
        get_PE_CLK_ON = read_PE_CLK_ON_value
    End Property

    Property Let set_PE_CLK_ON(aData)
        write_PE_CLK_ON_value = aData
        flag_PE_CLK_ON        = &H1
    End Property

    Property Get read_PE_CLK_ON
        read
        read_PE_CLK_ON = read_PE_CLK_ON_value
    End Property

    Property Let write_PE_CLK_ON(aData)
        set_PE_CLK_ON = aData
        write
    End Property

    Property Get get_ICE_CLK_ON
        get_ICE_CLK_ON = read_ICE_CLK_ON_value
    End Property

    Property Let set_ICE_CLK_ON(aData)
        write_ICE_CLK_ON_value = aData
        flag_ICE_CLK_ON        = &H1
    End Property

    Property Get read_ICE_CLK_ON
        read
        read_ICE_CLK_ON = read_ICE_CLK_ON_value
    End Property

    Property Let write_ICE_CLK_ON(aData)
        set_ICE_CLK_ON = aData
        write
    End Property

    Property Get get_RXCAM_CLK_ON
        get_RXCAM_CLK_ON = read_RXCAM_CLK_ON_value
    End Property

    Property Let set_RXCAM_CLK_ON(aData)
        write_RXCAM_CLK_ON_value = aData
        flag_RXCAM_CLK_ON        = &H1
    End Property

    Property Get read_RXCAM_CLK_ON
        read
        read_RXCAM_CLK_ON = read_RXCAM_CLK_ON_value
    End Property

    Property Let write_RXCAM_CLK_ON(aData)
        set_RXCAM_CLK_ON = aData
        write
    End Property

    Property Get get_FLOW_CLK_ON
        get_FLOW_CLK_ON = read_FLOW_CLK_ON_value
    End Property

    Property Let set_FLOW_CLK_ON(aData)
        write_FLOW_CLK_ON_value = aData
        flag_FLOW_CLK_ON        = &H1
    End Property

    Property Get read_FLOW_CLK_ON
        read
        read_FLOW_CLK_ON = read_FLOW_CLK_ON_value
    End Property

    Property Let write_FLOW_CLK_ON(aData)
        set_FLOW_CLK_ON = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PE_CLK_ON_mask = &H1
        if data_low > LONG_MAX then
            if PE_CLK_ON_mask = mask then
                read_PE_CLK_ON_value = data_low
            else
                read_PE_CLK_ON_value = (data_low - H8000_0000) and PE_CLK_ON_mask
            end If
        else
            read_PE_CLK_ON_value = data_low and PE_CLK_ON_mask
        end If
        read_ICE_CLK_ON_value = rightShift(data_low, 1) and &H1
        read_RXCAM_CLK_ON_value = rightShift(data_low, 4) and &H1
        read_FLOW_CLK_ON_value = rightShift(data_low, 5) and &H1

    End Sub

    Sub write
        If flag_PE_CLK_ON = &H0 or flag_ICE_CLK_ON = &H0 or flag_RXCAM_CLK_ON = &H0 or flag_FLOW_CLK_ON = &H0 Then read
        If flag_PE_CLK_ON = &H0 Then write_PE_CLK_ON_value = get_PE_CLK_ON
        If flag_ICE_CLK_ON = &H0 Then write_ICE_CLK_ON_value = get_ICE_CLK_ON
        If flag_RXCAM_CLK_ON = &H0 Then write_RXCAM_CLK_ON_value = get_RXCAM_CLK_ON
        If flag_FLOW_CLK_ON = &H0 Then write_FLOW_CLK_ON_value = get_FLOW_CLK_ON

        regValue = leftShift((write_PE_CLK_ON_value and &H1), 0) + leftShift((write_ICE_CLK_ON_value and &H1), 1) + leftShift((write_RXCAM_CLK_ON_value and &H1), 4) + leftShift((write_FLOW_CLK_ON_value and &H1), 5)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PE_CLK_ON_mask = &H1
        if data_low > LONG_MAX then
            if PE_CLK_ON_mask = mask then
                read_PE_CLK_ON_value = data_low
            else
                read_PE_CLK_ON_value = (data_low - H8000_0000) and PE_CLK_ON_mask
            end If
        else
            read_PE_CLK_ON_value = data_low and PE_CLK_ON_mask
        end If
        read_ICE_CLK_ON_value = rightShift(data_low, 1) and &H1
        read_RXCAM_CLK_ON_value = rightShift(data_low, 4) and &H1
        read_FLOW_CLK_ON_value = rightShift(data_low, 5) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PE_CLK_ON_value = &H0
        flag_PE_CLK_ON        = &H0
        write_ICE_CLK_ON_value = &H0
        flag_ICE_CLK_ON        = &H0
        write_RXCAM_CLK_ON_value = &H0
        flag_RXCAM_CLK_ON        = &H0
        write_FLOW_CLK_ON_value = &H0
        flag_FLOW_CLK_ON        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_SYSTEM_CONTROL_eip160_force_clock_off
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PE_CLK_OFF                                 [0:0]            get_PE_CLK_OFF
''                                                             set_PE_CLK_OFF
''                                                             read_PE_CLK_OFF
''                                                             write_PE_CLK_OFF
''---------------------------------------------------------------------------------
'' TCAM_CLK_OFF                               [1:1]            get_TCAM_CLK_OFF
''                                                             set_TCAM_CLK_OFF
''                                                             read_TCAM_CLK_OFF
''                                                             write_TCAM_CLK_OFF
''---------------------------------------------------------------------------------
'' RXCA_CLK_OFF                               [4:4]            get_RXCA_CLK_OFF
''                                                             set_RXCA_CLK_OFF
''                                                             read_RXCA_CLK_OFF
''                                                             write_RXCA_CLK_OFF
''---------------------------------------------------------------------------------
'' FLOW_CLK_OFF                               [5:5]            get_FLOW_CLK_OFF
''                                                             set_FLOW_CLK_OFF
''                                                             read_FLOW_CLK_OFF
''                                                             write_FLOW_CLK_OFF
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_SYSTEM_CONTROL_eip160_force_clock_off
    Private write_PE_CLK_OFF_value
    Private read_PE_CLK_OFF_value
    Private flag_PE_CLK_OFF
    Private write_TCAM_CLK_OFF_value
    Private read_TCAM_CLK_OFF_value
    Private flag_TCAM_CLK_OFF
    Private write_RXCA_CLK_OFF_value
    Private read_RXCA_CLK_OFF_value
    Private flag_RXCA_CLK_OFF
    Private write_FLOW_CLK_OFF_value
    Private read_FLOW_CLK_OFF_value
    Private flag_FLOW_CLK_OFF

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hfff0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PE_CLK_OFF
        get_PE_CLK_OFF = read_PE_CLK_OFF_value
    End Property

    Property Let set_PE_CLK_OFF(aData)
        write_PE_CLK_OFF_value = aData
        flag_PE_CLK_OFF        = &H1
    End Property

    Property Get read_PE_CLK_OFF
        read
        read_PE_CLK_OFF = read_PE_CLK_OFF_value
    End Property

    Property Let write_PE_CLK_OFF(aData)
        set_PE_CLK_OFF = aData
        write
    End Property

    Property Get get_TCAM_CLK_OFF
        get_TCAM_CLK_OFF = read_TCAM_CLK_OFF_value
    End Property

    Property Let set_TCAM_CLK_OFF(aData)
        write_TCAM_CLK_OFF_value = aData
        flag_TCAM_CLK_OFF        = &H1
    End Property

    Property Get read_TCAM_CLK_OFF
        read
        read_TCAM_CLK_OFF = read_TCAM_CLK_OFF_value
    End Property

    Property Let write_TCAM_CLK_OFF(aData)
        set_TCAM_CLK_OFF = aData
        write
    End Property

    Property Get get_RXCA_CLK_OFF
        get_RXCA_CLK_OFF = read_RXCA_CLK_OFF_value
    End Property

    Property Let set_RXCA_CLK_OFF(aData)
        write_RXCA_CLK_OFF_value = aData
        flag_RXCA_CLK_OFF        = &H1
    End Property

    Property Get read_RXCA_CLK_OFF
        read
        read_RXCA_CLK_OFF = read_RXCA_CLK_OFF_value
    End Property

    Property Let write_RXCA_CLK_OFF(aData)
        set_RXCA_CLK_OFF = aData
        write
    End Property

    Property Get get_FLOW_CLK_OFF
        get_FLOW_CLK_OFF = read_FLOW_CLK_OFF_value
    End Property

    Property Let set_FLOW_CLK_OFF(aData)
        write_FLOW_CLK_OFF_value = aData
        flag_FLOW_CLK_OFF        = &H1
    End Property

    Property Get read_FLOW_CLK_OFF
        read
        read_FLOW_CLK_OFF = read_FLOW_CLK_OFF_value
    End Property

    Property Let write_FLOW_CLK_OFF(aData)
        set_FLOW_CLK_OFF = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PE_CLK_OFF_mask = &H1
        if data_low > LONG_MAX then
            if PE_CLK_OFF_mask = mask then
                read_PE_CLK_OFF_value = data_low
            else
                read_PE_CLK_OFF_value = (data_low - H8000_0000) and PE_CLK_OFF_mask
            end If
        else
            read_PE_CLK_OFF_value = data_low and PE_CLK_OFF_mask
        end If
        read_TCAM_CLK_OFF_value = rightShift(data_low, 1) and &H1
        read_RXCA_CLK_OFF_value = rightShift(data_low, 4) and &H1
        read_FLOW_CLK_OFF_value = rightShift(data_low, 5) and &H1

    End Sub

    Sub write
        If flag_PE_CLK_OFF = &H0 or flag_TCAM_CLK_OFF = &H0 or flag_RXCA_CLK_OFF = &H0 or flag_FLOW_CLK_OFF = &H0 Then read
        If flag_PE_CLK_OFF = &H0 Then write_PE_CLK_OFF_value = get_PE_CLK_OFF
        If flag_TCAM_CLK_OFF = &H0 Then write_TCAM_CLK_OFF_value = get_TCAM_CLK_OFF
        If flag_RXCA_CLK_OFF = &H0 Then write_RXCA_CLK_OFF_value = get_RXCA_CLK_OFF
        If flag_FLOW_CLK_OFF = &H0 Then write_FLOW_CLK_OFF_value = get_FLOW_CLK_OFF

        regValue = leftShift((write_PE_CLK_OFF_value and &H1), 0) + leftShift((write_TCAM_CLK_OFF_value and &H1), 1) + leftShift((write_RXCA_CLK_OFF_value and &H1), 4) + leftShift((write_FLOW_CLK_OFF_value and &H1), 5)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PE_CLK_OFF_mask = &H1
        if data_low > LONG_MAX then
            if PE_CLK_OFF_mask = mask then
                read_PE_CLK_OFF_value = data_low
            else
                read_PE_CLK_OFF_value = (data_low - H8000_0000) and PE_CLK_OFF_mask
            end If
        else
            read_PE_CLK_OFF_value = data_low and PE_CLK_OFF_mask
        end If
        read_TCAM_CLK_OFF_value = rightShift(data_low, 1) and &H1
        read_RXCA_CLK_OFF_value = rightShift(data_low, 4) and &H1
        read_FLOW_CLK_OFF_value = rightShift(data_low, 5) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PE_CLK_OFF_value = &H0
        flag_PE_CLK_OFF        = &H0
        write_TCAM_CLK_OFF_value = &H0
        flag_TCAM_CLK_OFF        = &H0
        write_RXCA_CLK_OFF_value = &H0
        flag_RXCA_CLK_OFF        = &H0
        write_FLOW_CLK_OFF_value = &H0
        flag_FLOW_CLK_OFF        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_SYSTEM_CONTROL_eip160_config2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SA_COUNTERS                                [3:0]            get_SA_COUNTERS
''                                                             set_SA_COUNTERS
''                                                             read_SA_COUNTERS
''                                                             write_SA_COUNTERS
''---------------------------------------------------------------------------------
'' VL_COUNTERS                                [7:4]            get_VL_COUNTERS
''                                                             set_VL_COUNTERS
''                                                             read_VL_COUNTERS
''                                                             write_VL_COUNTERS
''---------------------------------------------------------------------------------
'' GLOB_COUN                                  [13:8]           get_GLOB_COUN
''                                                             set_GLOB_COUN
''                                                             read_GLOB_COUN
''                                                             write_GLOB_COUN
''---------------------------------------------------------------------------------
'' SATU_CNTR                                  [14:14]          get_SATU_CNTR
''                                                             set_SATU_CNTR
''                                                             read_SATU_CNTR
''                                                             write_SATU_CNTR
''---------------------------------------------------------------------------------
'' AUTO_CNTR_RESE                             [15:15]          get_AUTO_CNTR_RESE
''                                                             set_AUTO_CNTR_RESE
''                                                             read_AUTO_CNTR_RESE
''                                                             write_AUTO_CNTR_RESE
''---------------------------------------------------------------------------------
'' SA_OCTE_CTRS                               [17:16]          get_SA_OCTE_CTRS
''                                                             set_SA_OCTE_CTRS
''                                                             read_SA_OCTE_CTRS
''                                                             write_SA_OCTE_CTRS
''---------------------------------------------------------------------------------
'' VL_OCTE_CTRS                               [19:18]          get_VL_OCTE_CTRS
''                                                             set_VL_OCTE_CTRS
''                                                             read_VL_OCTE_CTRS
''                                                             write_VL_OCTE_CTRS
''---------------------------------------------------------------------------------
'' GLOB_OCTE_CTRS                             [23:20]          get_GLOB_OCTE_CTRS
''                                                             set_GLOB_OCTE_CTRS
''                                                             read_GLOB_OCTE_CTRS
''                                                             write_GLOB_OCTE_CTRS
''---------------------------------------------------------------------------------
'' INGRESS_ONLY                               [24:24]          get_INGRESS_ONLY
''                                                             set_INGRESS_ONLY
''                                                             read_INGRESS_ONLY
''                                                             write_INGRESS_ONLY
''---------------------------------------------------------------------------------
'' EGRESS_ONLY                                [25:25]          get_EGRESS_ONLY
''                                                             set_EGRESS_ONLY
''                                                             read_EGRESS_ONLY
''                                                             write_EGRESS_ONLY
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_SYSTEM_CONTROL_eip160_config2
    Private write_SA_COUNTERS_value
    Private read_SA_COUNTERS_value
    Private flag_SA_COUNTERS
    Private write_VL_COUNTERS_value
    Private read_VL_COUNTERS_value
    Private flag_VL_COUNTERS
    Private write_GLOB_COUN_value
    Private read_GLOB_COUN_value
    Private flag_GLOB_COUN
    Private write_SATU_CNTR_value
    Private read_SATU_CNTR_value
    Private flag_SATU_CNTR
    Private write_AUTO_CNTR_RESE_value
    Private read_AUTO_CNTR_RESE_value
    Private flag_AUTO_CNTR_RESE
    Private write_SA_OCTE_CTRS_value
    Private read_SA_OCTE_CTRS_value
    Private flag_SA_OCTE_CTRS
    Private write_VL_OCTE_CTRS_value
    Private read_VL_OCTE_CTRS_value
    Private flag_VL_OCTE_CTRS
    Private write_GLOB_OCTE_CTRS_value
    Private read_GLOB_OCTE_CTRS_value
    Private flag_GLOB_OCTE_CTRS
    Private write_INGRESS_ONLY_value
    Private read_INGRESS_ONLY_value
    Private flag_INGRESS_ONLY
    Private write_EGRESS_ONLY_value
    Private read_EGRESS_ONLY_value
    Private flag_EGRESS_ONLY

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hfff4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SA_COUNTERS
        get_SA_COUNTERS = read_SA_COUNTERS_value
    End Property

    Property Let set_SA_COUNTERS(aData)
        write_SA_COUNTERS_value = aData
        flag_SA_COUNTERS        = &H1
    End Property

    Property Get read_SA_COUNTERS
        read
        read_SA_COUNTERS = read_SA_COUNTERS_value
    End Property

    Property Let write_SA_COUNTERS(aData)
        set_SA_COUNTERS = aData
        write
    End Property

    Property Get get_VL_COUNTERS
        get_VL_COUNTERS = read_VL_COUNTERS_value
    End Property

    Property Let set_VL_COUNTERS(aData)
        write_VL_COUNTERS_value = aData
        flag_VL_COUNTERS        = &H1
    End Property

    Property Get read_VL_COUNTERS
        read
        read_VL_COUNTERS = read_VL_COUNTERS_value
    End Property

    Property Let write_VL_COUNTERS(aData)
        set_VL_COUNTERS = aData
        write
    End Property

    Property Get get_GLOB_COUN
        get_GLOB_COUN = read_GLOB_COUN_value
    End Property

    Property Let set_GLOB_COUN(aData)
        write_GLOB_COUN_value = aData
        flag_GLOB_COUN        = &H1
    End Property

    Property Get read_GLOB_COUN
        read
        read_GLOB_COUN = read_GLOB_COUN_value
    End Property

    Property Let write_GLOB_COUN(aData)
        set_GLOB_COUN = aData
        write
    End Property

    Property Get get_SATU_CNTR
        get_SATU_CNTR = read_SATU_CNTR_value
    End Property

    Property Let set_SATU_CNTR(aData)
        write_SATU_CNTR_value = aData
        flag_SATU_CNTR        = &H1
    End Property

    Property Get read_SATU_CNTR
        read
        read_SATU_CNTR = read_SATU_CNTR_value
    End Property

    Property Let write_SATU_CNTR(aData)
        set_SATU_CNTR = aData
        write
    End Property

    Property Get get_AUTO_CNTR_RESE
        get_AUTO_CNTR_RESE = read_AUTO_CNTR_RESE_value
    End Property

    Property Let set_AUTO_CNTR_RESE(aData)
        write_AUTO_CNTR_RESE_value = aData
        flag_AUTO_CNTR_RESE        = &H1
    End Property

    Property Get read_AUTO_CNTR_RESE
        read
        read_AUTO_CNTR_RESE = read_AUTO_CNTR_RESE_value
    End Property

    Property Let write_AUTO_CNTR_RESE(aData)
        set_AUTO_CNTR_RESE = aData
        write
    End Property

    Property Get get_SA_OCTE_CTRS
        get_SA_OCTE_CTRS = read_SA_OCTE_CTRS_value
    End Property

    Property Let set_SA_OCTE_CTRS(aData)
        write_SA_OCTE_CTRS_value = aData
        flag_SA_OCTE_CTRS        = &H1
    End Property

    Property Get read_SA_OCTE_CTRS
        read
        read_SA_OCTE_CTRS = read_SA_OCTE_CTRS_value
    End Property

    Property Let write_SA_OCTE_CTRS(aData)
        set_SA_OCTE_CTRS = aData
        write
    End Property

    Property Get get_VL_OCTE_CTRS
        get_VL_OCTE_CTRS = read_VL_OCTE_CTRS_value
    End Property

    Property Let set_VL_OCTE_CTRS(aData)
        write_VL_OCTE_CTRS_value = aData
        flag_VL_OCTE_CTRS        = &H1
    End Property

    Property Get read_VL_OCTE_CTRS
        read
        read_VL_OCTE_CTRS = read_VL_OCTE_CTRS_value
    End Property

    Property Let write_VL_OCTE_CTRS(aData)
        set_VL_OCTE_CTRS = aData
        write
    End Property

    Property Get get_GLOB_OCTE_CTRS
        get_GLOB_OCTE_CTRS = read_GLOB_OCTE_CTRS_value
    End Property

    Property Let set_GLOB_OCTE_CTRS(aData)
        write_GLOB_OCTE_CTRS_value = aData
        flag_GLOB_OCTE_CTRS        = &H1
    End Property

    Property Get read_GLOB_OCTE_CTRS
        read
        read_GLOB_OCTE_CTRS = read_GLOB_OCTE_CTRS_value
    End Property

    Property Let write_GLOB_OCTE_CTRS(aData)
        set_GLOB_OCTE_CTRS = aData
        write
    End Property

    Property Get get_INGRESS_ONLY
        get_INGRESS_ONLY = read_INGRESS_ONLY_value
    End Property

    Property Let set_INGRESS_ONLY(aData)
        write_INGRESS_ONLY_value = aData
        flag_INGRESS_ONLY        = &H1
    End Property

    Property Get read_INGRESS_ONLY
        read
        read_INGRESS_ONLY = read_INGRESS_ONLY_value
    End Property

    Property Let write_INGRESS_ONLY(aData)
        set_INGRESS_ONLY = aData
        write
    End Property

    Property Get get_EGRESS_ONLY
        get_EGRESS_ONLY = read_EGRESS_ONLY_value
    End Property

    Property Let set_EGRESS_ONLY(aData)
        write_EGRESS_ONLY_value = aData
        flag_EGRESS_ONLY        = &H1
    End Property

    Property Get read_EGRESS_ONLY
        read
        read_EGRESS_ONLY = read_EGRESS_ONLY_value
    End Property

    Property Let write_EGRESS_ONLY(aData)
        set_EGRESS_ONLY = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_COUNTERS_mask = &Hf
        if data_low > LONG_MAX then
            if SA_COUNTERS_mask = mask then
                read_SA_COUNTERS_value = data_low
            else
                read_SA_COUNTERS_value = (data_low - H8000_0000) and SA_COUNTERS_mask
            end If
        else
            read_SA_COUNTERS_value = data_low and SA_COUNTERS_mask
        end If
        read_VL_COUNTERS_value = rightShift(data_low, 4) and &Hf
        read_GLOB_COUN_value = rightShift(data_low, 8) and &H3f
        read_SATU_CNTR_value = rightShift(data_low, 14) and &H1
        read_AUTO_CNTR_RESE_value = rightShift(data_low, 15) and &H1
        read_SA_OCTE_CTRS_value = rightShift(data_low, 16) and &H3
        read_VL_OCTE_CTRS_value = rightShift(data_low, 18) and &H3
        read_GLOB_OCTE_CTRS_value = rightShift(data_low, 20) and &Hf
        read_INGRESS_ONLY_value = rightShift(data_low, 24) and &H1
        read_EGRESS_ONLY_value = rightShift(data_low, 25) and &H1

    End Sub

    Sub write
        If flag_SA_COUNTERS = &H0 or flag_VL_COUNTERS = &H0 or flag_GLOB_COUN = &H0 or flag_SATU_CNTR = &H0 or flag_AUTO_CNTR_RESE = &H0 or flag_SA_OCTE_CTRS = &H0 or flag_VL_OCTE_CTRS = &H0 or flag_GLOB_OCTE_CTRS = &H0 or flag_INGRESS_ONLY = &H0 or flag_EGRESS_ONLY = &H0 Then read
        If flag_SA_COUNTERS = &H0 Then write_SA_COUNTERS_value = get_SA_COUNTERS
        If flag_VL_COUNTERS = &H0 Then write_VL_COUNTERS_value = get_VL_COUNTERS
        If flag_GLOB_COUN = &H0 Then write_GLOB_COUN_value = get_GLOB_COUN
        If flag_SATU_CNTR = &H0 Then write_SATU_CNTR_value = get_SATU_CNTR
        If flag_AUTO_CNTR_RESE = &H0 Then write_AUTO_CNTR_RESE_value = get_AUTO_CNTR_RESE
        If flag_SA_OCTE_CTRS = &H0 Then write_SA_OCTE_CTRS_value = get_SA_OCTE_CTRS
        If flag_VL_OCTE_CTRS = &H0 Then write_VL_OCTE_CTRS_value = get_VL_OCTE_CTRS
        If flag_GLOB_OCTE_CTRS = &H0 Then write_GLOB_OCTE_CTRS_value = get_GLOB_OCTE_CTRS
        If flag_INGRESS_ONLY = &H0 Then write_INGRESS_ONLY_value = get_INGRESS_ONLY
        If flag_EGRESS_ONLY = &H0 Then write_EGRESS_ONLY_value = get_EGRESS_ONLY

        regValue = leftShift((write_SA_COUNTERS_value and &Hf), 0) + leftShift((write_VL_COUNTERS_value and &Hf), 4) + leftShift((write_GLOB_COUN_value and &H3f), 8) + leftShift((write_SATU_CNTR_value and &H1), 14) + leftShift((write_AUTO_CNTR_RESE_value and &H1), 15) + leftShift((write_SA_OCTE_CTRS_value and &H3), 16) + leftShift((write_VL_OCTE_CTRS_value and &H3), 18) + leftShift((write_GLOB_OCTE_CTRS_value and &Hf), 20) + leftShift((write_INGRESS_ONLY_value and &H1), 24) + leftShift((write_EGRESS_ONLY_value and &H1), 25)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_COUNTERS_mask = &Hf
        if data_low > LONG_MAX then
            if SA_COUNTERS_mask = mask then
                read_SA_COUNTERS_value = data_low
            else
                read_SA_COUNTERS_value = (data_low - H8000_0000) and SA_COUNTERS_mask
            end If
        else
            read_SA_COUNTERS_value = data_low and SA_COUNTERS_mask
        end If
        read_VL_COUNTERS_value = rightShift(data_low, 4) and &Hf
        read_GLOB_COUN_value = rightShift(data_low, 8) and &H3f
        read_SATU_CNTR_value = rightShift(data_low, 14) and &H1
        read_AUTO_CNTR_RESE_value = rightShift(data_low, 15) and &H1
        read_SA_OCTE_CTRS_value = rightShift(data_low, 16) and &H3
        read_VL_OCTE_CTRS_value = rightShift(data_low, 18) and &H3
        read_GLOB_OCTE_CTRS_value = rightShift(data_low, 20) and &Hf
        read_INGRESS_ONLY_value = rightShift(data_low, 24) and &H1
        read_EGRESS_ONLY_value = rightShift(data_low, 25) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SA_COUNTERS_value = &H0
        flag_SA_COUNTERS        = &H0
        write_VL_COUNTERS_value = &H0
        flag_VL_COUNTERS        = &H0
        write_GLOB_COUN_value = &H0
        flag_GLOB_COUN        = &H0
        write_SATU_CNTR_value = &H0
        flag_SATU_CNTR        = &H0
        write_AUTO_CNTR_RESE_value = &H0
        flag_AUTO_CNTR_RESE        = &H0
        write_SA_OCTE_CTRS_value = &H0
        flag_SA_OCTE_CTRS        = &H0
        write_VL_OCTE_CTRS_value = &H0
        flag_VL_OCTE_CTRS        = &H0
        write_GLOB_OCTE_CTRS_value = &H0
        flag_GLOB_OCTE_CTRS        = &H0
        write_INGRESS_ONLY_value = &H0
        flag_INGRESS_ONLY        = &H0
        write_EGRESS_ONLY_value = &H0
        flag_EGRESS_ONLY        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_SYSTEM_CONTROL_eip160_config
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' NR_OF_SAS                                  [7:0]            get_NR_OF_SAS
''                                                             set_NR_OF_SAS
''                                                             read_NR_OF_SAS
''                                                             write_NR_OF_SAS
''---------------------------------------------------------------------------------
'' CONS_CHEC                                  [15:8]           get_CONS_CHEC
''                                                             set_CONS_CHEC
''                                                             read_CONS_CHEC
''                                                             write_CONS_CHEC
''---------------------------------------------------------------------------------
'' MATCH_SCI                                  [16:16]          get_MATCH_SCI
''                                                             set_MATCH_SCI
''                                                             read_MATCH_SCI
''                                                             write_MATCH_SCI
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_SYSTEM_CONTROL_eip160_config
    Private write_NR_OF_SAS_value
    Private read_NR_OF_SAS_value
    Private flag_NR_OF_SAS
    Private write_CONS_CHEC_value
    Private read_CONS_CHEC_value
    Private flag_CONS_CHEC
    Private write_MATCH_SCI_value
    Private read_MATCH_SCI_value
    Private flag_MATCH_SCI

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hfff8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_NR_OF_SAS
        get_NR_OF_SAS = read_NR_OF_SAS_value
    End Property

    Property Let set_NR_OF_SAS(aData)
        write_NR_OF_SAS_value = aData
        flag_NR_OF_SAS        = &H1
    End Property

    Property Get read_NR_OF_SAS
        read
        read_NR_OF_SAS = read_NR_OF_SAS_value
    End Property

    Property Let write_NR_OF_SAS(aData)
        set_NR_OF_SAS = aData
        write
    End Property

    Property Get get_CONS_CHEC
        get_CONS_CHEC = read_CONS_CHEC_value
    End Property

    Property Let set_CONS_CHEC(aData)
        write_CONS_CHEC_value = aData
        flag_CONS_CHEC        = &H1
    End Property

    Property Get read_CONS_CHEC
        read
        read_CONS_CHEC = read_CONS_CHEC_value
    End Property

    Property Let write_CONS_CHEC(aData)
        set_CONS_CHEC = aData
        write
    End Property

    Property Get get_MATCH_SCI
        get_MATCH_SCI = read_MATCH_SCI_value
    End Property

    Property Let set_MATCH_SCI(aData)
        write_MATCH_SCI_value = aData
        flag_MATCH_SCI        = &H1
    End Property

    Property Get read_MATCH_SCI
        read
        read_MATCH_SCI = read_MATCH_SCI_value
    End Property

    Property Let write_MATCH_SCI(aData)
        set_MATCH_SCI = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        NR_OF_SAS_mask = &Hff
        if data_low > LONG_MAX then
            if NR_OF_SAS_mask = mask then
                read_NR_OF_SAS_value = data_low
            else
                read_NR_OF_SAS_value = (data_low - H8000_0000) and NR_OF_SAS_mask
            end If
        else
            read_NR_OF_SAS_value = data_low and NR_OF_SAS_mask
        end If
        read_CONS_CHEC_value = rightShift(data_low, 8) and &Hff
        read_MATCH_SCI_value = rightShift(data_low, 16) and &H1

    End Sub

    Sub write
        If flag_NR_OF_SAS = &H0 or flag_CONS_CHEC = &H0 or flag_MATCH_SCI = &H0 Then read
        If flag_NR_OF_SAS = &H0 Then write_NR_OF_SAS_value = get_NR_OF_SAS
        If flag_CONS_CHEC = &H0 Then write_CONS_CHEC_value = get_CONS_CHEC
        If flag_MATCH_SCI = &H0 Then write_MATCH_SCI_value = get_MATCH_SCI

        regValue = leftShift((write_NR_OF_SAS_value and &Hff), 0) + leftShift((write_CONS_CHEC_value and &Hff), 8) + leftShift((write_MATCH_SCI_value and &H1), 16)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        NR_OF_SAS_mask = &Hff
        if data_low > LONG_MAX then
            if NR_OF_SAS_mask = mask then
                read_NR_OF_SAS_value = data_low
            else
                read_NR_OF_SAS_value = (data_low - H8000_0000) and NR_OF_SAS_mask
            end If
        else
            read_NR_OF_SAS_value = data_low and NR_OF_SAS_mask
        end If
        read_CONS_CHEC_value = rightShift(data_low, 8) and &Hff
        read_MATCH_SCI_value = rightShift(data_low, 16) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_NR_OF_SAS_value = &H0
        flag_NR_OF_SAS        = &H0
        write_CONS_CHEC_value = &H0
        flag_CONS_CHEC        = &H0
        write_MATCH_SCI_value = &H0
        flag_MATCH_SCI        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_I_32_BRCM_SYSTEM_CONTROL_eip160_version
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' EIP_NUMBER                                 [7:0]            get_EIP_NUMBER
''                                                             set_EIP_NUMBER
''                                                             read_EIP_NUMBER
''                                                             write_EIP_NUMBER
''---------------------------------------------------------------------------------
'' ENC                                        [15:8]           get_ENC
''                                                             set_ENC
''                                                             read_ENC
''                                                             write_ENC
''---------------------------------------------------------------------------------
'' PATCH_LEVEL                                [19:16]          get_PATCH_LEVEL
''                                                             set_PATCH_LEVEL
''                                                             read_PATCH_LEVEL
''                                                             write_PATCH_LEVEL
''---------------------------------------------------------------------------------
'' MINO_VERS                                  [23:20]          get_MINO_VERS
''                                                             set_MINO_VERS
''                                                             read_MINO_VERS
''                                                             write_MINO_VERS
''---------------------------------------------------------------------------------
'' MAJO_VERS                                  [27:24]          get_MAJO_VERS
''                                                             set_MAJO_VERS
''                                                             read_MAJO_VERS
''                                                             write_MAJO_VERS
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_I_32_BRCM_SYSTEM_CONTROL_eip160_version
    Private write_EIP_NUMBER_value
    Private read_EIP_NUMBER_value
    Private flag_EIP_NUMBER
    Private write_ENC_value
    Private read_ENC_value
    Private flag_ENC
    Private write_PATCH_LEVEL_value
    Private read_PATCH_LEVEL_value
    Private flag_PATCH_LEVEL
    Private write_MINO_VERS_value
    Private read_MINO_VERS_value
    Private flag_MINO_VERS
    Private write_MAJO_VERS_value
    Private read_MAJO_VERS_value
    Private flag_MAJO_VERS

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hfffc
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_EIP_NUMBER
        get_EIP_NUMBER = read_EIP_NUMBER_value
    End Property

    Property Let set_EIP_NUMBER(aData)
        write_EIP_NUMBER_value = aData
        flag_EIP_NUMBER        = &H1
    End Property

    Property Get read_EIP_NUMBER
        read
        read_EIP_NUMBER = read_EIP_NUMBER_value
    End Property

    Property Let write_EIP_NUMBER(aData)
        set_EIP_NUMBER = aData
        write
    End Property

    Property Get get_ENC
        get_ENC = read_ENC_value
    End Property

    Property Let set_ENC(aData)
        write_ENC_value = aData
        flag_ENC        = &H1
    End Property

    Property Get read_ENC
        read
        read_ENC = read_ENC_value
    End Property

    Property Let write_ENC(aData)
        set_ENC = aData
        write
    End Property

    Property Get get_PATCH_LEVEL
        get_PATCH_LEVEL = read_PATCH_LEVEL_value
    End Property

    Property Let set_PATCH_LEVEL(aData)
        write_PATCH_LEVEL_value = aData
        flag_PATCH_LEVEL        = &H1
    End Property

    Property Get read_PATCH_LEVEL
        read
        read_PATCH_LEVEL = read_PATCH_LEVEL_value
    End Property

    Property Let write_PATCH_LEVEL(aData)
        set_PATCH_LEVEL = aData
        write
    End Property

    Property Get get_MINO_VERS
        get_MINO_VERS = read_MINO_VERS_value
    End Property

    Property Let set_MINO_VERS(aData)
        write_MINO_VERS_value = aData
        flag_MINO_VERS        = &H1
    End Property

    Property Get read_MINO_VERS
        read
        read_MINO_VERS = read_MINO_VERS_value
    End Property

    Property Let write_MINO_VERS(aData)
        set_MINO_VERS = aData
        write
    End Property

    Property Get get_MAJO_VERS
        get_MAJO_VERS = read_MAJO_VERS_value
    End Property

    Property Let set_MAJO_VERS(aData)
        write_MAJO_VERS_value = aData
        flag_MAJO_VERS        = &H1
    End Property

    Property Get read_MAJO_VERS
        read
        read_MAJO_VERS = read_MAJO_VERS_value
    End Property

    Property Let write_MAJO_VERS(aData)
        set_MAJO_VERS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        EIP_NUMBER_mask = &Hff
        if data_low > LONG_MAX then
            if EIP_NUMBER_mask = mask then
                read_EIP_NUMBER_value = data_low
            else
                read_EIP_NUMBER_value = (data_low - H8000_0000) and EIP_NUMBER_mask
            end If
        else
            read_EIP_NUMBER_value = data_low and EIP_NUMBER_mask
        end If
        read_ENC_value = rightShift(data_low, 8) and &Hff
        read_PATCH_LEVEL_value = rightShift(data_low, 16) and &Hf
        read_MINO_VERS_value = rightShift(data_low, 20) and &Hf
        read_MAJO_VERS_value = rightShift(data_low, 24) and &Hf

    End Sub

    Sub write
        If flag_EIP_NUMBER = &H0 or flag_ENC = &H0 or flag_PATCH_LEVEL = &H0 or flag_MINO_VERS = &H0 or flag_MAJO_VERS = &H0 Then read
        If flag_EIP_NUMBER = &H0 Then write_EIP_NUMBER_value = get_EIP_NUMBER
        If flag_ENC = &H0 Then write_ENC_value = get_ENC
        If flag_PATCH_LEVEL = &H0 Then write_PATCH_LEVEL_value = get_PATCH_LEVEL
        If flag_MINO_VERS = &H0 Then write_MINO_VERS_value = get_MINO_VERS
        If flag_MAJO_VERS = &H0 Then write_MAJO_VERS_value = get_MAJO_VERS

        regValue = leftShift((write_EIP_NUMBER_value and &Hff), 0) + leftShift((write_ENC_value and &Hff), 8) + leftShift((write_PATCH_LEVEL_value and &Hf), 16) + leftShift((write_MINO_VERS_value and &Hf), 20) + leftShift((write_MAJO_VERS_value and &Hf), 24)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        EIP_NUMBER_mask = &Hff
        if data_low > LONG_MAX then
            if EIP_NUMBER_mask = mask then
                read_EIP_NUMBER_value = data_low
            else
                read_EIP_NUMBER_value = (data_low - H8000_0000) and EIP_NUMBER_mask
            end If
        else
            read_EIP_NUMBER_value = data_low and EIP_NUMBER_mask
        end If
        read_ENC_value = rightShift(data_low, 8) and &Hff
        read_PATCH_LEVEL_value = rightShift(data_low, 16) and &Hf
        read_MINO_VERS_value = rightShift(data_low, 20) and &Hf
        read_MAJO_VERS_value = rightShift(data_low, 24) and &Hf

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_EIP_NUMBER_value = &H0
        flag_EIP_NUMBER        = &H0
        write_ENC_value = &H0
        flag_ENC        = &H0
        write_PATCH_LEVEL_value = &H0
        flag_PATCH_LEVEL        = &H0
        write_MINO_VERS_value = &H0
        flag_MINO_VERS        = &H0
        write_MAJO_VERS_value = &H0
        flag_MAJO_VERS        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class EIP165S_EIP_160S_I_32_BRCM_SYSTEM_CONTROL_INSTANCE

    Public saf_ctrl
    Public saf_threshold
    Public eip160_clock_state
    Public eip160_force_clock_on
    Public eip160_force_clock_off
    Public eip160_config2
    Public eip160_config
    Public eip160_version


    Public default function Init(aBaseAddr)
        Set saf_ctrl = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_SYSTEM_CONTROL_saf_ctrl)(aBaseAddr, 32)
        Set saf_threshold = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_SYSTEM_CONTROL_saf_threshold)(aBaseAddr, 32)
        Set eip160_clock_state = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_SYSTEM_CONTROL_eip160_clock_state)(aBaseAddr, 32)
        Set eip160_force_clock_on = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_SYSTEM_CONTROL_eip160_force_clock_on)(aBaseAddr, 32)
        Set eip160_force_clock_off = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_SYSTEM_CONTROL_eip160_force_clock_off)(aBaseAddr, 32)
        Set eip160_config2 = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_SYSTEM_CONTROL_eip160_config2)(aBaseAddr, 32)
        Set eip160_config = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_SYSTEM_CONTROL_eip160_config)(aBaseAddr, 32)
        Set eip160_version = (New REGISTER_EIP165S_EIP_160S_I_32_BRCM_SYSTEM_CONTROL_eip160_version)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set EIP165S_EIP_160S_I_32_BRCM_SYSTEM_CONTROL = CreateObject("System.Collections.ArrayList")
EIP165S_EIP_160S_I_32_BRCM_SYSTEM_CONTROL.Add ((New EIP165S_EIP_160S_I_32_BRCM_SYSTEM_CONTROL_INSTANCE)(&H4d010000))
EIP165S_EIP_160S_I_32_BRCM_SYSTEM_CONTROL.Add ((New EIP165S_EIP_160S_I_32_BRCM_SYSTEM_CONTROL_INSTANCE)(&H4d110000))
EIP165S_EIP_160S_I_32_BRCM_SYSTEM_CONTROL.Add ((New EIP165S_EIP_160S_I_32_BRCM_SYSTEM_CONTROL_INSTANCE)(&H4d210000))
EIP165S_EIP_160S_I_32_BRCM_SYSTEM_CONTROL.Add ((New EIP165S_EIP_160S_I_32_BRCM_SYSTEM_CONTROL_INSTANCE)(&H4d310000))
EIP165S_EIP_160S_I_32_BRCM_SYSTEM_CONTROL.Add ((New EIP165S_EIP_160S_I_32_BRCM_SYSTEM_CONTROL_INSTANCE)(&H4d410000))
EIP165S_EIP_160S_I_32_BRCM_SYSTEM_CONTROL.Add ((New EIP165S_EIP_160S_I_32_BRCM_SYSTEM_CONTROL_INSTANCE)(&H4d510000))


