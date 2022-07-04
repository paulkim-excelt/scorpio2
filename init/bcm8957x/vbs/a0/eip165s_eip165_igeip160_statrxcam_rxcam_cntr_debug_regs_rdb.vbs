

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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATRXCAM_RXCAM_CNTR_DEBUG_REGS_rxcam_count_debug1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RIM                                        [0:0]            get_RIM
''                                                             set_RIM
''                                                             read_RIM
''                                                             write_RIM
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATRXCAM_RXCAM_CNTR_DEBUG_REGS_rxcam_count_debug1
    Private write_RIM_value
    Private read_RIM_value
    Private flag_RIM

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H5400
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_RIM
        get_RIM = read_RIM_value
    End Property

    Property Let set_RIM(aData)
        write_RIM_value = aData
        flag_RIM        = &H1
    End Property

    Property Get read_RIM
        read
        read_RIM = read_RIM_value
    End Property

    Property Let write_RIM(aData)
        set_RIM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RIM_mask = &H1
        if data_low > LONG_MAX then
            if RIM_mask = mask then
                read_RIM_value = data_low
            else
                read_RIM_value = (data_low - H8000_0000) and RIM_mask
            end If
        else
            read_RIM_value = data_low and RIM_mask
        end If

    End Sub

    Sub write
        If flag_RIM = &H0 Then read
        If flag_RIM = &H0 Then write_RIM_value = get_RIM

        regValue = leftShift((write_RIM_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RIM_mask = &H1
        if data_low > LONG_MAX then
            if RIM_mask = mask then
                read_RIM_value = data_low
            else
                read_RIM_value = (data_low - H8000_0000) and RIM_mask
            end If
        else
            read_RIM_value = data_low and RIM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RIM_value = &H0
        flag_RIM        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATRXCAM_RXCAM_CNTR_DEBUG_REGS_rxcam_count_debug4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RXCAM_TEST                                 [0:0]            get_RXCAM_TEST
''                                                             set_RXCAM_TEST
''                                                             read_RXCAM_TEST
''                                                             write_RXCAM_TEST
''---------------------------------------------------------------------------------
'' RXCAM_NR                                   [6:3]            get_RXCAM_NR
''                                                             set_RXCAM_NR
''                                                             read_RXCAM_NR
''                                                             write_RXCAM_NR
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATRXCAM_RXCAM_CNTR_DEBUG_REGS_rxcam_count_debug4
    Private write_RXCAM_TEST_value
    Private read_RXCAM_TEST_value
    Private flag_RXCAM_TEST
    Private write_RXCAM_NR_value
    Private read_RXCAM_NR_value
    Private flag_RXCAM_NR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H540c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_RXCAM_TEST
        get_RXCAM_TEST = read_RXCAM_TEST_value
    End Property

    Property Let set_RXCAM_TEST(aData)
        write_RXCAM_TEST_value = aData
        flag_RXCAM_TEST        = &H1
    End Property

    Property Get read_RXCAM_TEST
        read
        read_RXCAM_TEST = read_RXCAM_TEST_value
    End Property

    Property Let write_RXCAM_TEST(aData)
        set_RXCAM_TEST = aData
        write
    End Property

    Property Get get_RXCAM_NR
        get_RXCAM_NR = read_RXCAM_NR_value
    End Property

    Property Let set_RXCAM_NR(aData)
        write_RXCAM_NR_value = aData
        flag_RXCAM_NR        = &H1
    End Property

    Property Get read_RXCAM_NR
        read
        read_RXCAM_NR = read_RXCAM_NR_value
    End Property

    Property Let write_RXCAM_NR(aData)
        set_RXCAM_NR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RXCAM_TEST_mask = &H1
        if data_low > LONG_MAX then
            if RXCAM_TEST_mask = mask then
                read_RXCAM_TEST_value = data_low
            else
                read_RXCAM_TEST_value = (data_low - H8000_0000) and RXCAM_TEST_mask
            end If
        else
            read_RXCAM_TEST_value = data_low and RXCAM_TEST_mask
        end If
        read_RXCAM_NR_value = rightShift(data_low, 3) and &Hf

    End Sub

    Sub write
        If flag_RXCAM_TEST = &H0 or flag_RXCAM_NR = &H0 Then read
        If flag_RXCAM_TEST = &H0 Then write_RXCAM_TEST_value = get_RXCAM_TEST
        If flag_RXCAM_NR = &H0 Then write_RXCAM_NR_value = get_RXCAM_NR

        regValue = leftShift((write_RXCAM_TEST_value and &H1), 0) + leftShift((write_RXCAM_NR_value and &Hf), 3)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RXCAM_TEST_mask = &H1
        if data_low > LONG_MAX then
            if RXCAM_TEST_mask = mask then
                read_RXCAM_TEST_value = data_low
            else
                read_RXCAM_TEST_value = (data_low - H8000_0000) and RXCAM_TEST_mask
            end If
        else
            read_RXCAM_TEST_value = data_low and RXCAM_TEST_mask
        end If
        read_RXCAM_NR_value = rightShift(data_low, 3) and &Hf

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RXCAM_TEST_value = &H0
        flag_RXCAM_TEST        = &H0
        write_RXCAM_NR_value = &H0
        flag_RXCAM_NR        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class EIP165S_EIP165_IGEIP160_STATRXCAM_RXCAM_CNTR_DEBUG_REGS_INSTANCE

    Public rxcam_count_debug1
    Public rxcam_count_debug4


    Public default function Init(aBaseAddr)
        Set rxcam_count_debug1 = (New REGISTER_EIP165S_EIP165_IGEIP160_STATRXCAM_RXCAM_CNTR_DEBUG_REGS_rxcam_count_debug1)(aBaseAddr, 32)
        Set rxcam_count_debug4 = (New REGISTER_EIP165S_EIP165_IGEIP160_STATRXCAM_RXCAM_CNTR_DEBUG_REGS_rxcam_count_debug4)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set EIP165S_EIP165_IGEIP160_STATRXCAM_RXCAM_CNTR_DEBUG_REGS = CreateObject("System.Collections.ArrayList")
EIP165S_EIP165_IGEIP160_STATRXCAM_RXCAM_CNTR_DEBUG_REGS.Add ((New EIP165S_EIP165_IGEIP160_STATRXCAM_RXCAM_CNTR_DEBUG_REGS_INSTANCE)(&H4d010000))
EIP165S_EIP165_IGEIP160_STATRXCAM_RXCAM_CNTR_DEBUG_REGS.Add ((New EIP165S_EIP165_IGEIP160_STATRXCAM_RXCAM_CNTR_DEBUG_REGS_INSTANCE)(&H4d110000))
EIP165S_EIP165_IGEIP160_STATRXCAM_RXCAM_CNTR_DEBUG_REGS.Add ((New EIP165S_EIP165_IGEIP160_STATRXCAM_RXCAM_CNTR_DEBUG_REGS_INSTANCE)(&H4d210000))
EIP165S_EIP165_IGEIP160_STATRXCAM_RXCAM_CNTR_DEBUG_REGS.Add ((New EIP165S_EIP165_IGEIP160_STATRXCAM_RXCAM_CNTR_DEBUG_REGS_INSTANCE)(&H4d310000))
EIP165S_EIP165_IGEIP160_STATRXCAM_RXCAM_CNTR_DEBUG_REGS.Add ((New EIP165S_EIP165_IGEIP160_STATRXCAM_RXCAM_CNTR_DEBUG_REGS_INSTANCE)(&H4d410000))
EIP165S_EIP165_IGEIP160_STATRXCAM_RXCAM_CNTR_DEBUG_REGS.Add ((New EIP165S_EIP165_IGEIP160_STATRXCAM_RXCAM_CNTR_DEBUG_REGS_INSTANCE)(&H4d510000))


