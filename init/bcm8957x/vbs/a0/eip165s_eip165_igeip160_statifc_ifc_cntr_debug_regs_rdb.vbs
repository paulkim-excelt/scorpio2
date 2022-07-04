

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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATIFC_IFC_CNTR_DEBUG_REGS_ifc_count_debug1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' IIM                                        [7:0]            get_IIM
''                                                             set_IIM
''                                                             read_IIM
''                                                             write_IIM
''---------------------------------------------------------------------------------
'' IOI                                        [30:16]          get_IOI
''                                                             set_IOI
''                                                             read_IOI
''                                                             write_IOI
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATIFC_IFC_CNTR_DEBUG_REGS_ifc_count_debug1
    Private write_IIM_value
    Private read_IIM_value
    Private flag_IIM
    Private write_IOI_value
    Private read_IOI_value
    Private flag_IOI

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He600
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_IIM
        get_IIM = read_IIM_value
    End Property

    Property Let set_IIM(aData)
        write_IIM_value = aData
        flag_IIM        = &H1
    End Property

    Property Get read_IIM
        read
        read_IIM = read_IIM_value
    End Property

    Property Let write_IIM(aData)
        set_IIM = aData
        write
    End Property

    Property Get get_IOI
        get_IOI = read_IOI_value
    End Property

    Property Let set_IOI(aData)
        write_IOI_value = aData
        flag_IOI        = &H1
    End Property

    Property Get read_IOI
        read
        read_IOI = read_IOI_value
    End Property

    Property Let write_IOI(aData)
        set_IOI = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        IIM_mask = &Hff
        if data_low > LONG_MAX then
            if IIM_mask = mask then
                read_IIM_value = data_low
            else
                read_IIM_value = (data_low - H8000_0000) and IIM_mask
            end If
        else
            read_IIM_value = data_low and IIM_mask
        end If
        read_IOI_value = rightShift(data_low, 16) and &H7fff

    End Sub

    Sub write
        If flag_IIM = &H0 or flag_IOI = &H0 Then read
        If flag_IIM = &H0 Then write_IIM_value = get_IIM
        If flag_IOI = &H0 Then write_IOI_value = get_IOI

        regValue = leftShift((write_IIM_value and &Hff), 0) + leftShift((write_IOI_value and &H7fff), 16)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        IIM_mask = &Hff
        if data_low > LONG_MAX then
            if IIM_mask = mask then
                read_IIM_value = data_low
            else
                read_IIM_value = (data_low - H8000_0000) and IIM_mask
            end If
        else
            read_IIM_value = data_low and IIM_mask
        end If
        read_IOI_value = rightShift(data_low, 16) and &H7fff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_IIM_value = &H0
        flag_IIM        = &H0
        write_IOI_value = &H0
        flag_IOI        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATIFC_IFC_CNTR_DEBUG_REGS_ifc_count_debug4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' IFC_TEST                                   [0:0]            get_IFC_TEST
''                                                             set_IFC_TEST
''                                                             read_IFC_TEST
''                                                             write_IFC_TEST
''---------------------------------------------------------------------------------
'' IFC_NR                                     [6:3]            get_IFC_NR
''                                                             set_IFC_NR
''                                                             read_IFC_NR
''                                                             write_IFC_NR
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATIFC_IFC_CNTR_DEBUG_REGS_ifc_count_debug4
    Private write_IFC_TEST_value
    Private read_IFC_TEST_value
    Private flag_IFC_TEST
    Private write_IFC_NR_value
    Private read_IFC_NR_value
    Private flag_IFC_NR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He60c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_IFC_TEST
        get_IFC_TEST = read_IFC_TEST_value
    End Property

    Property Let set_IFC_TEST(aData)
        write_IFC_TEST_value = aData
        flag_IFC_TEST        = &H1
    End Property

    Property Get read_IFC_TEST
        read
        read_IFC_TEST = read_IFC_TEST_value
    End Property

    Property Let write_IFC_TEST(aData)
        set_IFC_TEST = aData
        write
    End Property

    Property Get get_IFC_NR
        get_IFC_NR = read_IFC_NR_value
    End Property

    Property Let set_IFC_NR(aData)
        write_IFC_NR_value = aData
        flag_IFC_NR        = &H1
    End Property

    Property Get read_IFC_NR
        read
        read_IFC_NR = read_IFC_NR_value
    End Property

    Property Let write_IFC_NR(aData)
        set_IFC_NR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        IFC_TEST_mask = &H1
        if data_low > LONG_MAX then
            if IFC_TEST_mask = mask then
                read_IFC_TEST_value = data_low
            else
                read_IFC_TEST_value = (data_low - H8000_0000) and IFC_TEST_mask
            end If
        else
            read_IFC_TEST_value = data_low and IFC_TEST_mask
        end If
        read_IFC_NR_value = rightShift(data_low, 3) and &Hf

    End Sub

    Sub write
        If flag_IFC_TEST = &H0 or flag_IFC_NR = &H0 Then read
        If flag_IFC_TEST = &H0 Then write_IFC_TEST_value = get_IFC_TEST
        If flag_IFC_NR = &H0 Then write_IFC_NR_value = get_IFC_NR

        regValue = leftShift((write_IFC_TEST_value and &H1), 0) + leftShift((write_IFC_NR_value and &Hf), 3)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        IFC_TEST_mask = &H1
        if data_low > LONG_MAX then
            if IFC_TEST_mask = mask then
                read_IFC_TEST_value = data_low
            else
                read_IFC_TEST_value = (data_low - H8000_0000) and IFC_TEST_mask
            end If
        else
            read_IFC_TEST_value = data_low and IFC_TEST_mask
        end If
        read_IFC_NR_value = rightShift(data_low, 3) and &Hf

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_IFC_TEST_value = &H0
        flag_IFC_TEST        = &H0
        write_IFC_NR_value = &H0
        flag_IFC_NR        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class EIP165S_EIP165_IGEIP160_STATIFC_IFC_CNTR_DEBUG_REGS_INSTANCE

    Public ifc_count_debug1
    Public ifc_count_debug4


    Public default function Init(aBaseAddr)
        Set ifc_count_debug1 = (New REGISTER_EIP165S_EIP165_IGEIP160_STATIFC_IFC_CNTR_DEBUG_REGS_ifc_count_debug1)(aBaseAddr, 32)
        Set ifc_count_debug4 = (New REGISTER_EIP165S_EIP165_IGEIP160_STATIFC_IFC_CNTR_DEBUG_REGS_ifc_count_debug4)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set EIP165S_EIP165_IGEIP160_STATIFC_IFC_CNTR_DEBUG_REGS = CreateObject("System.Collections.ArrayList")
EIP165S_EIP165_IGEIP160_STATIFC_IFC_CNTR_DEBUG_REGS.Add ((New EIP165S_EIP165_IGEIP160_STATIFC_IFC_CNTR_DEBUG_REGS_INSTANCE)(&H4d010000))
EIP165S_EIP165_IGEIP160_STATIFC_IFC_CNTR_DEBUG_REGS.Add ((New EIP165S_EIP165_IGEIP160_STATIFC_IFC_CNTR_DEBUG_REGS_INSTANCE)(&H4d110000))
EIP165S_EIP165_IGEIP160_STATIFC_IFC_CNTR_DEBUG_REGS.Add ((New EIP165S_EIP165_IGEIP160_STATIFC_IFC_CNTR_DEBUG_REGS_INSTANCE)(&H4d210000))
EIP165S_EIP165_IGEIP160_STATIFC_IFC_CNTR_DEBUG_REGS.Add ((New EIP165S_EIP165_IGEIP160_STATIFC_IFC_CNTR_DEBUG_REGS_INSTANCE)(&H4d310000))
EIP165S_EIP165_IGEIP160_STATIFC_IFC_CNTR_DEBUG_REGS.Add ((New EIP165S_EIP165_IGEIP160_STATIFC_IFC_CNTR_DEBUG_REGS_INSTANCE)(&H4d410000))
EIP165S_EIP165_IGEIP160_STATIFC_IFC_CNTR_DEBUG_REGS.Add ((New EIP165S_EIP165_IGEIP160_STATIFC_IFC_CNTR_DEBUG_REGS_INSTANCE)(&H4d510000))


