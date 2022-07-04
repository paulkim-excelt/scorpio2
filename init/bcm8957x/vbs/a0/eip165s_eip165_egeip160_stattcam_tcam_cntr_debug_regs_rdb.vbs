

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


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_CNTR_DEBUG_REGS_tcam_count_debug1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TIM                                        [0:0]            get_TIM
''                                                             set_TIM
''                                                             read_TIM
''                                                             write_TIM
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_CNTR_DEBUG_REGS_tcam_count_debug1
    Private write_TIM_value
    Private read_TIM_value
    Private flag_TIM

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H14400
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_TIM
        get_TIM = read_TIM_value
    End Property

    Property Let set_TIM(aData)
        write_TIM_value = aData
        flag_TIM        = &H1
    End Property

    Property Get read_TIM
        read
        read_TIM = read_TIM_value
    End Property

    Property Let write_TIM(aData)
        set_TIM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TIM_mask = &H1
        if data_low > LONG_MAX then
            if TIM_mask = mask then
                read_TIM_value = data_low
            else
                read_TIM_value = (data_low - H8000_0000) and TIM_mask
            end If
        else
            read_TIM_value = data_low and TIM_mask
        end If

    End Sub

    Sub write
        If flag_TIM = &H0 Then read
        If flag_TIM = &H0 Then write_TIM_value = get_TIM

        regValue = leftShift((write_TIM_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TIM_mask = &H1
        if data_low > LONG_MAX then
            if TIM_mask = mask then
                read_TIM_value = data_low
            else
                read_TIM_value = (data_low - H8000_0000) and TIM_mask
            end If
        else
            read_TIM_value = data_low and TIM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TIM_value = &H0
        flag_TIM        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_CNTR_DEBUG_REGS_tcam_count_debug3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' GIM                                        [2:0]            get_GIM
''                                                             set_GIM
''                                                             read_GIM
''                                                             write_GIM
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_CNTR_DEBUG_REGS_tcam_count_debug3
    Private write_GIM_value
    Private read_GIM_value
    Private flag_GIM

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H14408
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_GIM
        get_GIM = read_GIM_value
    End Property

    Property Let set_GIM(aData)
        write_GIM_value = aData
        flag_GIM        = &H1
    End Property

    Property Get read_GIM
        read
        read_GIM = read_GIM_value
    End Property

    Property Let write_GIM(aData)
        set_GIM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GIM_mask = &H7
        if data_low > LONG_MAX then
            if GIM_mask = mask then
                read_GIM_value = data_low
            else
                read_GIM_value = (data_low - H8000_0000) and GIM_mask
            end If
        else
            read_GIM_value = data_low and GIM_mask
        end If

    End Sub

    Sub write
        If flag_GIM = &H0 Then read
        If flag_GIM = &H0 Then write_GIM_value = get_GIM

        regValue = leftShift((write_GIM_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        GIM_mask = &H7
        if data_low > LONG_MAX then
            if GIM_mask = mask then
                read_GIM_value = data_low
            else
                read_GIM_value = (data_low - H8000_0000) and GIM_mask
            end If
        else
            read_GIM_value = data_low and GIM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_GIM_value = &H0
        flag_GIM        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_CNTR_DEBUG_REGS_tcam_count_debug4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TCAM_TEST                                  [0:0]            get_TCAM_TEST
''                                                             set_TCAM_TEST
''                                                             read_TCAM_TEST
''                                                             write_TCAM_TEST
''---------------------------------------------------------------------------------
'' GLOBAL_TEST                                [2:2]            get_GLOBAL_TEST
''                                                             set_GLOBAL_TEST
''                                                             read_GLOBAL_TEST
''                                                             write_GLOBAL_TEST
''---------------------------------------------------------------------------------
'' TCAM_NR                                    [7:3]            get_TCAM_NR
''                                                             set_TCAM_NR
''                                                             read_TCAM_NR
''                                                             write_TCAM_NR
''---------------------------------------------------------------------------------
'' GOI                                        [30:16]          get_GOI
''                                                             set_GOI
''                                                             read_GOI
''                                                             write_GOI
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_CNTR_DEBUG_REGS_tcam_count_debug4
    Private write_TCAM_TEST_value
    Private read_TCAM_TEST_value
    Private flag_TCAM_TEST
    Private write_GLOBAL_TEST_value
    Private read_GLOBAL_TEST_value
    Private flag_GLOBAL_TEST
    Private write_TCAM_NR_value
    Private read_TCAM_NR_value
    Private flag_TCAM_NR
    Private write_GOI_value
    Private read_GOI_value
    Private flag_GOI

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1440c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_TCAM_TEST
        get_TCAM_TEST = read_TCAM_TEST_value
    End Property

    Property Let set_TCAM_TEST(aData)
        write_TCAM_TEST_value = aData
        flag_TCAM_TEST        = &H1
    End Property

    Property Get read_TCAM_TEST
        read
        read_TCAM_TEST = read_TCAM_TEST_value
    End Property

    Property Let write_TCAM_TEST(aData)
        set_TCAM_TEST = aData
        write
    End Property

    Property Get get_GLOBAL_TEST
        get_GLOBAL_TEST = read_GLOBAL_TEST_value
    End Property

    Property Let set_GLOBAL_TEST(aData)
        write_GLOBAL_TEST_value = aData
        flag_GLOBAL_TEST        = &H1
    End Property

    Property Get read_GLOBAL_TEST
        read
        read_GLOBAL_TEST = read_GLOBAL_TEST_value
    End Property

    Property Let write_GLOBAL_TEST(aData)
        set_GLOBAL_TEST = aData
        write
    End Property

    Property Get get_TCAM_NR
        get_TCAM_NR = read_TCAM_NR_value
    End Property

    Property Let set_TCAM_NR(aData)
        write_TCAM_NR_value = aData
        flag_TCAM_NR        = &H1
    End Property

    Property Get read_TCAM_NR
        read
        read_TCAM_NR = read_TCAM_NR_value
    End Property

    Property Let write_TCAM_NR(aData)
        set_TCAM_NR = aData
        write
    End Property

    Property Get get_GOI
        get_GOI = read_GOI_value
    End Property

    Property Let set_GOI(aData)
        write_GOI_value = aData
        flag_GOI        = &H1
    End Property

    Property Get read_GOI
        read
        read_GOI = read_GOI_value
    End Property

    Property Let write_GOI(aData)
        set_GOI = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TCAM_TEST_mask = &H1
        if data_low > LONG_MAX then
            if TCAM_TEST_mask = mask then
                read_TCAM_TEST_value = data_low
            else
                read_TCAM_TEST_value = (data_low - H8000_0000) and TCAM_TEST_mask
            end If
        else
            read_TCAM_TEST_value = data_low and TCAM_TEST_mask
        end If
        read_GLOBAL_TEST_value = rightShift(data_low, 2) and &H1
        read_TCAM_NR_value = rightShift(data_low, 3) and &H1f
        read_GOI_value = rightShift(data_low, 16) and &H7fff

    End Sub

    Sub write
        If flag_TCAM_TEST = &H0 or flag_GLOBAL_TEST = &H0 or flag_TCAM_NR = &H0 or flag_GOI = &H0 Then read
        If flag_TCAM_TEST = &H0 Then write_TCAM_TEST_value = get_TCAM_TEST
        If flag_GLOBAL_TEST = &H0 Then write_GLOBAL_TEST_value = get_GLOBAL_TEST
        If flag_TCAM_NR = &H0 Then write_TCAM_NR_value = get_TCAM_NR
        If flag_GOI = &H0 Then write_GOI_value = get_GOI

        regValue = leftShift((write_TCAM_TEST_value and &H1), 0) + leftShift((write_GLOBAL_TEST_value and &H1), 2) + leftShift((write_TCAM_NR_value and &H1f), 3) + leftShift((write_GOI_value and &H7fff), 16)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TCAM_TEST_mask = &H1
        if data_low > LONG_MAX then
            if TCAM_TEST_mask = mask then
                read_TCAM_TEST_value = data_low
            else
                read_TCAM_TEST_value = (data_low - H8000_0000) and TCAM_TEST_mask
            end If
        else
            read_TCAM_TEST_value = data_low and TCAM_TEST_mask
        end If
        read_GLOBAL_TEST_value = rightShift(data_low, 2) and &H1
        read_TCAM_NR_value = rightShift(data_low, 3) and &H1f
        read_GOI_value = rightShift(data_low, 16) and &H7fff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TCAM_TEST_value = &H0
        flag_TCAM_TEST        = &H0
        write_GLOBAL_TEST_value = &H0
        flag_GLOBAL_TEST        = &H0
        write_TCAM_NR_value = &H0
        flag_TCAM_NR        = &H0
        write_GOI_value = &H0
        flag_GOI        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_CNTR_DEBUG_REGS_INSTANCE

    Public tcam_count_debug1
    Public tcam_count_debug3
    Public tcam_count_debug4


    Public default function Init(aBaseAddr)
        Set tcam_count_debug1 = (New REGISTER_EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_CNTR_DEBUG_REGS_tcam_count_debug1)(aBaseAddr, 32)
        Set tcam_count_debug3 = (New REGISTER_EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_CNTR_DEBUG_REGS_tcam_count_debug3)(aBaseAddr, 32)
        Set tcam_count_debug4 = (New REGISTER_EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_CNTR_DEBUG_REGS_tcam_count_debug4)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_CNTR_DEBUG_REGS = CreateObject("System.Collections.ArrayList")
EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_CNTR_DEBUG_REGS.Add ((New EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_CNTR_DEBUG_REGS_INSTANCE)(&H4d010000))
EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_CNTR_DEBUG_REGS.Add ((New EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_CNTR_DEBUG_REGS_INSTANCE)(&H4d110000))
EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_CNTR_DEBUG_REGS.Add ((New EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_CNTR_DEBUG_REGS_INSTANCE)(&H4d210000))
EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_CNTR_DEBUG_REGS.Add ((New EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_CNTR_DEBUG_REGS_INSTANCE)(&H4d310000))
EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_CNTR_DEBUG_REGS.Add ((New EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_CNTR_DEBUG_REGS_INSTANCE)(&H4d410000))
EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_CNTR_DEBUG_REGS.Add ((New EIP165S_EIP165_EGEIP160_STATTCAM_TCAM_CNTR_DEBUG_REGS_INSTANCE)(&H4d510000))


