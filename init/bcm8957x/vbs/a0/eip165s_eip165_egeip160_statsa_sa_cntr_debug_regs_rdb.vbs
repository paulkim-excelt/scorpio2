

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


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_CNTR_DEBUG_REGS_sa_count_debug1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SIM                                        [3:0]            get_SIM
''                                                             set_SIM
''                                                             read_SIM
''                                                             write_SIM
''---------------------------------------------------------------------------------
'' SOI                                        [30:16]          get_SOI
''                                                             set_SOI
''                                                             read_SOI
''                                                             write_SOI
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_CNTR_DEBUG_REGS_sa_count_debug1
    Private write_SIM_value
    Private read_SIM_value
    Private flag_SIM
    Private write_SOI_value
    Private read_SOI_value
    Private flag_SOI

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1e200
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

    Property Get get_SOI
        get_SOI = read_SOI_value
    End Property

    Property Let set_SOI(aData)
        write_SOI_value = aData
        flag_SOI        = &H1
    End Property

    Property Get read_SOI
        read
        read_SOI = read_SOI_value
    End Property

    Property Let write_SOI(aData)
        set_SOI = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SIM_mask = &Hf
        if data_low > LONG_MAX then
            if SIM_mask = mask then
                read_SIM_value = data_low
            else
                read_SIM_value = (data_low - H8000_0000) and SIM_mask
            end If
        else
            read_SIM_value = data_low and SIM_mask
        end If
        read_SOI_value = rightShift(data_low, 16) and &H7fff

    End Sub

    Sub write
        If flag_SIM = &H0 or flag_SOI = &H0 Then read
        If flag_SIM = &H0 Then write_SIM_value = get_SIM
        If flag_SOI = &H0 Then write_SOI_value = get_SOI

        regValue = leftShift((write_SIM_value and &Hf), 0) + leftShift((write_SOI_value and &H7fff), 16)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SIM_mask = &Hf
        if data_low > LONG_MAX then
            if SIM_mask = mask then
                read_SIM_value = data_low
            else
                read_SIM_value = (data_low - H8000_0000) and SIM_mask
            end If
        else
            read_SIM_value = data_low and SIM_mask
        end If
        read_SOI_value = rightShift(data_low, 16) and &H7fff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SIM_value = &H0
        flag_SIM        = &H0
        write_SOI_value = &H0
        flag_SOI        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_EGEIP160_STATSA_SA_CNTR_DEBUG_REGS_sa_count_debug4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SA_TEST                                    [0:0]            get_SA_TEST
''                                                             set_SA_TEST
''                                                             read_SA_TEST
''                                                             write_SA_TEST
''---------------------------------------------------------------------------------
'' SA_NR                                      [7:3]            get_SA_NR
''                                                             set_SA_NR
''                                                             read_SA_NR
''                                                             write_SA_NR
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_CNTR_DEBUG_REGS_sa_count_debug4
    Private write_SA_TEST_value
    Private read_SA_TEST_value
    Private flag_SA_TEST
    Private write_SA_NR_value
    Private read_SA_NR_value
    Private flag_SA_NR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1e20c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SA_TEST
        get_SA_TEST = read_SA_TEST_value
    End Property

    Property Let set_SA_TEST(aData)
        write_SA_TEST_value = aData
        flag_SA_TEST        = &H1
    End Property

    Property Get read_SA_TEST
        read
        read_SA_TEST = read_SA_TEST_value
    End Property

    Property Let write_SA_TEST(aData)
        set_SA_TEST = aData
        write
    End Property

    Property Get get_SA_NR
        get_SA_NR = read_SA_NR_value
    End Property

    Property Let set_SA_NR(aData)
        write_SA_NR_value = aData
        flag_SA_NR        = &H1
    End Property

    Property Get read_SA_NR
        read
        read_SA_NR = read_SA_NR_value
    End Property

    Property Let write_SA_NR(aData)
        set_SA_NR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_TEST_mask = &H1
        if data_low > LONG_MAX then
            if SA_TEST_mask = mask then
                read_SA_TEST_value = data_low
            else
                read_SA_TEST_value = (data_low - H8000_0000) and SA_TEST_mask
            end If
        else
            read_SA_TEST_value = data_low and SA_TEST_mask
        end If
        read_SA_NR_value = rightShift(data_low, 3) and &H1f

    End Sub

    Sub write
        If flag_SA_TEST = &H0 or flag_SA_NR = &H0 Then read
        If flag_SA_TEST = &H0 Then write_SA_TEST_value = get_SA_TEST
        If flag_SA_NR = &H0 Then write_SA_NR_value = get_SA_NR

        regValue = leftShift((write_SA_TEST_value and &H1), 0) + leftShift((write_SA_NR_value and &H1f), 3)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SA_TEST_mask = &H1
        if data_low > LONG_MAX then
            if SA_TEST_mask = mask then
                read_SA_TEST_value = data_low
            else
                read_SA_TEST_value = (data_low - H8000_0000) and SA_TEST_mask
            end If
        else
            read_SA_TEST_value = data_low and SA_TEST_mask
        end If
        read_SA_NR_value = rightShift(data_low, 3) and &H1f

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SA_TEST_value = &H0
        flag_SA_TEST        = &H0
        write_SA_NR_value = &H0
        flag_SA_NR        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class EIP165S_EIP165_EGEIP160_STATSA_SA_CNTR_DEBUG_REGS_INSTANCE

    Public sa_count_debug1
    Public sa_count_debug4


    Public default function Init(aBaseAddr)
        Set sa_count_debug1 = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_CNTR_DEBUG_REGS_sa_count_debug1)(aBaseAddr, 32)
        Set sa_count_debug4 = (New REGISTER_EIP165S_EIP165_EGEIP160_STATSA_SA_CNTR_DEBUG_REGS_sa_count_debug4)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set EIP165S_EIP165_EGEIP160_STATSA_SA_CNTR_DEBUG_REGS = CreateObject("System.Collections.ArrayList")
EIP165S_EIP165_EGEIP160_STATSA_SA_CNTR_DEBUG_REGS.Add ((New EIP165S_EIP165_EGEIP160_STATSA_SA_CNTR_DEBUG_REGS_INSTANCE)(&H4d010000))
EIP165S_EIP165_EGEIP160_STATSA_SA_CNTR_DEBUG_REGS.Add ((New EIP165S_EIP165_EGEIP160_STATSA_SA_CNTR_DEBUG_REGS_INSTANCE)(&H4d110000))
EIP165S_EIP165_EGEIP160_STATSA_SA_CNTR_DEBUG_REGS.Add ((New EIP165S_EIP165_EGEIP160_STATSA_SA_CNTR_DEBUG_REGS_INSTANCE)(&H4d210000))
EIP165S_EIP165_EGEIP160_STATSA_SA_CNTR_DEBUG_REGS.Add ((New EIP165S_EIP165_EGEIP160_STATSA_SA_CNTR_DEBUG_REGS_INSTANCE)(&H4d310000))
EIP165S_EIP165_EGEIP160_STATSA_SA_CNTR_DEBUG_REGS.Add ((New EIP165S_EIP165_EGEIP160_STATSA_SA_CNTR_DEBUG_REGS_INSTANCE)(&H4d410000))
EIP165S_EIP165_EGEIP160_STATSA_SA_CNTR_DEBUG_REGS.Add ((New EIP165S_EIP165_EGEIP160_STATSA_SA_CNTR_DEBUG_REGS_INSTANCE)(&H4d510000))


