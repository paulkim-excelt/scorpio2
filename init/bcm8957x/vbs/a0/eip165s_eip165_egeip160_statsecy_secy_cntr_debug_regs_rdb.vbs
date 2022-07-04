

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


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_CNTR_DEBUG_REGS_secy_count_debug1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SIM                                        [2:0]            get_SIM
''                                                             set_SIM
''                                                             read_SIM
''                                                             write_SIM
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_CNTR_DEBUG_REGS_secy_count_debug1
    Private write_SIM_value
    Private read_SIM_value
    Private flag_SIM

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1e400
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SIM
        get_SIM = read_SIM_value
    End Property

    Property Let set_SIM(aData)
        write_SIM_value = aData
        flag_SIM        = &H1
    End Property

    Property Get read_SIM
        read
        read_SIM = read_SIM_value
    End Property

    Property Let write_SIM(aData)
        set_SIM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SIM_mask = &H7
        if data_low > LONG_MAX then
            if SIM_mask = mask then
                read_SIM_value = data_low
            else
                read_SIM_value = (data_low - H8000_0000) and SIM_mask
            end If
        else
            read_SIM_value = data_low and SIM_mask
        end If

    End Sub

    Sub write
        If flag_SIM = &H0 Then read
        If flag_SIM = &H0 Then write_SIM_value = get_SIM

        regValue = leftShift((write_SIM_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SIM_mask = &H7
        if data_low > LONG_MAX then
            if SIM_mask = mask then
                read_SIM_value = data_low
            else
                read_SIM_value = (data_low - H8000_0000) and SIM_mask
            end If
        else
            read_SIM_value = data_low and SIM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SIM_value = &H0
        flag_SIM        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSECY_SECY_CNTR_DEBUG_REGS_secy_count_debug4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SECY_TEST                                  [0:0]            get_SECY_TEST
''                                                             set_SECY_TEST
''                                                             read_SECY_TEST
''                                                             write_SECY_TEST
''---------------------------------------------------------------------------------
'' SECY_NR                                    [6:3]            get_SECY_NR
''                                                             set_SECY_NR
''                                                             read_SECY_NR
''                                                             write_SECY_NR
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_CNTR_DEBUG_REGS_secy_count_debug4
    Private write_SECY_TEST_value
    Private read_SECY_TEST_value
    Private flag_SECY_TEST
    Private write_SECY_NR_value
    Private read_SECY_NR_value
    Private flag_SECY_NR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1e40c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SECY_TEST
        get_SECY_TEST = read_SECY_TEST_value
    End Property

    Property Let set_SECY_TEST(aData)
        write_SECY_TEST_value = aData
        flag_SECY_TEST        = &H1
    End Property

    Property Get read_SECY_TEST
        read
        read_SECY_TEST = read_SECY_TEST_value
    End Property

    Property Let write_SECY_TEST(aData)
        set_SECY_TEST = aData
        write
    End Property

    Property Get get_SECY_NR
        get_SECY_NR = read_SECY_NR_value
    End Property

    Property Let set_SECY_NR(aData)
        write_SECY_NR_value = aData
        flag_SECY_NR        = &H1
    End Property

    Property Get read_SECY_NR
        read
        read_SECY_NR = read_SECY_NR_value
    End Property

    Property Let write_SECY_NR(aData)
        set_SECY_NR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SECY_TEST_mask = &H1
        if data_low > LONG_MAX then
            if SECY_TEST_mask = mask then
                read_SECY_TEST_value = data_low
            else
                read_SECY_TEST_value = (data_low - H8000_0000) and SECY_TEST_mask
            end If
        else
            read_SECY_TEST_value = data_low and SECY_TEST_mask
        end If
        read_SECY_NR_value = rightShift(data_low, 3) and &Hf

    End Sub

    Sub write
        If flag_SECY_TEST = &H0 or flag_SECY_NR = &H0 Then read
        If flag_SECY_TEST = &H0 Then write_SECY_TEST_value = get_SECY_TEST
        If flag_SECY_NR = &H0 Then write_SECY_NR_value = get_SECY_NR

        regValue = leftShift((write_SECY_TEST_value and &H1), 0) + leftShift((write_SECY_NR_value and &Hf), 3)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SECY_TEST_mask = &H1
        if data_low > LONG_MAX then
            if SECY_TEST_mask = mask then
                read_SECY_TEST_value = data_low
            else
                read_SECY_TEST_value = (data_low - H8000_0000) and SECY_TEST_mask
            end If
        else
            read_SECY_TEST_value = data_low and SECY_TEST_mask
        end If
        read_SECY_NR_value = rightShift(data_low, 3) and &Hf

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SECY_TEST_value = &H0
        flag_SECY_TEST        = &H0
        write_SECY_NR_value = &H0
        flag_SECY_NR        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class EIP165S_EIP165_EGEIP160_STATSECY_SECY_CNTR_DEBUG_REGS_INSTANCE

    Public secy_count_debug1
    Public secy_count_debug4


    Public default function Init(aBaseAddr)
        Set secy_count_debug1 = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_CNTR_DEBUG_REGS_secy_count_debug1)(aBaseAddr, 32)
        Set secy_count_debug4 = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSECY_SECY_CNTR_DEBUG_REGS_secy_count_debug4)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set EIP165S_EIP165_EGEIP160_STATSECY_SECY_CNTR_DEBUG_REGS = CreateObject("System.Collections.ArrayList")
EIP165S_EIP165_EGEIP160_STATSECY_SECY_CNTR_DEBUG_REGS.Add ((New EIP165S_EIP165_EGEIP160_STATSECY_SECY_CNTR_DEBUG_REGS_INSTANCE)(&H4d010000))
EIP165S_EIP165_EGEIP160_STATSECY_SECY_CNTR_DEBUG_REGS.Add ((New EIP165S_EIP165_EGEIP160_STATSECY_SECY_CNTR_DEBUG_REGS_INSTANCE)(&H4d110000))
EIP165S_EIP165_EGEIP160_STATSECY_SECY_CNTR_DEBUG_REGS.Add ((New EIP165S_EIP165_EGEIP160_STATSECY_SECY_CNTR_DEBUG_REGS_INSTANCE)(&H4d210000))
EIP165S_EIP165_EGEIP160_STATSECY_SECY_CNTR_DEBUG_REGS.Add ((New EIP165S_EIP165_EGEIP160_STATSECY_SECY_CNTR_DEBUG_REGS_INSTANCE)(&H4d310000))
EIP165S_EIP165_EGEIP160_STATSECY_SECY_CNTR_DEBUG_REGS.Add ((New EIP165S_EIP165_EGEIP160_STATSECY_SECY_CNTR_DEBUG_REGS_INSTANCE)(&H4d410000))
EIP165S_EIP165_EGEIP160_STATSECY_SECY_CNTR_DEBUG_REGS.Add ((New EIP165S_EIP165_EGEIP160_STATSECY_SECY_CNTR_DEBUG_REGS_INSTANCE)(&H4d510000))


