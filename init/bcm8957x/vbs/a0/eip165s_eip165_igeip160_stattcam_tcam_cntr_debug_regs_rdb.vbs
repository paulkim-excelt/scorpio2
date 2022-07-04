

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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_CNTR_DEBUG_REGS_tcam_count_debug1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' tcam_increment_mask                        [0:0]            get_tcam_increment_mask
''                                                             set_tcam_increment_mask
''                                                             read_tcam_increment_mask
''                                                             write_tcam_increment_mask
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_CNTR_DEBUG_REGS_tcam_count_debug1
    Private write_tcam_increment_mask_value
    Private read_tcam_increment_mask_value
    Private flag_tcam_increment_mask

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4400
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_tcam_increment_mask
        get_tcam_increment_mask = read_tcam_increment_mask_value
    End Property

    Property Let set_tcam_increment_mask(aData)
        write_tcam_increment_mask_value = aData
        flag_tcam_increment_mask        = &H1
    End Property

    Property Get read_tcam_increment_mask
        read
        read_tcam_increment_mask = read_tcam_increment_mask_value
    End Property

    Property Let write_tcam_increment_mask(aData)
        set_tcam_increment_mask = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        tcam_increment_mask_mask = &H1
        if data_low > LONG_MAX then
            if tcam_increment_mask_mask = mask then
                read_tcam_increment_mask_value = data_low
            else
                read_tcam_increment_mask_value = (data_low - H8000_0000) and tcam_increment_mask_mask
            end If
        else
            read_tcam_increment_mask_value = data_low and tcam_increment_mask_mask
        end If

    End Sub

    Sub write
        If flag_tcam_increment_mask = &H0 Then read
        If flag_tcam_increment_mask = &H0 Then write_tcam_increment_mask_value = get_tcam_increment_mask

        regValue = leftShift((write_tcam_increment_mask_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        tcam_increment_mask_mask = &H1
        if data_low > LONG_MAX then
            if tcam_increment_mask_mask = mask then
                read_tcam_increment_mask_value = data_low
            else
                read_tcam_increment_mask_value = (data_low - H8000_0000) and tcam_increment_mask_mask
            end If
        else
            read_tcam_increment_mask_value = data_low and tcam_increment_mask_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_tcam_increment_mask_value = &H0
        flag_tcam_increment_mask        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_CNTR_DEBUG_REGS_tcam_count_debug3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' global_increment_mask                      [2:0]            get_global_increment_mask
''                                                             set_global_increment_mask
''                                                             read_global_increment_mask
''                                                             write_global_increment_mask
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_CNTR_DEBUG_REGS_tcam_count_debug3
    Private write_global_increment_mask_value
    Private read_global_increment_mask_value
    Private flag_global_increment_mask

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4408
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_global_increment_mask
        get_global_increment_mask = read_global_increment_mask_value
    End Property

    Property Let set_global_increment_mask(aData)
        write_global_increment_mask_value = aData
        flag_global_increment_mask        = &H1
    End Property

    Property Get read_global_increment_mask
        read
        read_global_increment_mask = read_global_increment_mask_value
    End Property

    Property Let write_global_increment_mask(aData)
        set_global_increment_mask = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        global_increment_mask_mask = &H7
        if data_low > LONG_MAX then
            if global_increment_mask_mask = mask then
                read_global_increment_mask_value = data_low
            else
                read_global_increment_mask_value = (data_low - H8000_0000) and global_increment_mask_mask
            end If
        else
            read_global_increment_mask_value = data_low and global_increment_mask_mask
        end If

    End Sub

    Sub write
        If flag_global_increment_mask = &H0 Then read
        If flag_global_increment_mask = &H0 Then write_global_increment_mask_value = get_global_increment_mask

        regValue = leftShift((write_global_increment_mask_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        global_increment_mask_mask = &H7
        if data_low > LONG_MAX then
            if global_increment_mask_mask = mask then
                read_global_increment_mask_value = data_low
            else
                read_global_increment_mask_value = (data_low - H8000_0000) and global_increment_mask_mask
            end If
        else
            read_global_increment_mask_value = data_low and global_increment_mask_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_global_increment_mask_value = &H0
        flag_global_increment_mask        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_CNTR_DEBUG_REGS_tcam_count_debug4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' tcam_test                                  [0:0]            get_tcam_test
''                                                             set_tcam_test
''                                                             read_tcam_test
''                                                             write_tcam_test
''---------------------------------------------------------------------------------
'' global_test                                [2:2]            get_global_test
''                                                             set_global_test
''                                                             read_global_test
''                                                             write_global_test
''---------------------------------------------------------------------------------
'' tcam_nr                                    [7:3]            get_tcam_nr
''                                                             set_tcam_nr
''                                                             read_tcam_nr
''                                                             write_tcam_nr
''---------------------------------------------------------------------------------
'' global_octet_increment                     [30:16]          get_global_octet_increment
''                                                             set_global_octet_increment
''                                                             read_global_octet_increment
''                                                             write_global_octet_increment
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_CNTR_DEBUG_REGS_tcam_count_debug4
    Private write_tcam_test_value
    Private read_tcam_test_value
    Private flag_tcam_test
    Private write_global_test_value
    Private read_global_test_value
    Private flag_global_test
    Private write_tcam_nr_value
    Private read_tcam_nr_value
    Private flag_tcam_nr
    Private write_global_octet_increment_value
    Private read_global_octet_increment_value
    Private flag_global_octet_increment

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H440c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_tcam_test
        get_tcam_test = read_tcam_test_value
    End Property

    Property Let set_tcam_test(aData)
        write_tcam_test_value = aData
        flag_tcam_test        = &H1
    End Property

    Property Get read_tcam_test
        read
        read_tcam_test = read_tcam_test_value
    End Property

    Property Let write_tcam_test(aData)
        set_tcam_test = aData
        write
    End Property

    Property Get get_global_test
        get_global_test = read_global_test_value
    End Property

    Property Let set_global_test(aData)
        write_global_test_value = aData
        flag_global_test        = &H1
    End Property

    Property Get read_global_test
        read
        read_global_test = read_global_test_value
    End Property

    Property Let write_global_test(aData)
        set_global_test = aData
        write
    End Property

    Property Get get_tcam_nr
        get_tcam_nr = read_tcam_nr_value
    End Property

    Property Let set_tcam_nr(aData)
        write_tcam_nr_value = aData
        flag_tcam_nr        = &H1
    End Property

    Property Get read_tcam_nr
        read
        read_tcam_nr = read_tcam_nr_value
    End Property

    Property Let write_tcam_nr(aData)
        set_tcam_nr = aData
        write
    End Property

    Property Get get_global_octet_increment
        get_global_octet_increment = read_global_octet_increment_value
    End Property

    Property Let set_global_octet_increment(aData)
        write_global_octet_increment_value = aData
        flag_global_octet_increment        = &H1
    End Property

    Property Get read_global_octet_increment
        read
        read_global_octet_increment = read_global_octet_increment_value
    End Property

    Property Let write_global_octet_increment(aData)
        set_global_octet_increment = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        tcam_test_mask = &H1
        if data_low > LONG_MAX then
            if tcam_test_mask = mask then
                read_tcam_test_value = data_low
            else
                read_tcam_test_value = (data_low - H8000_0000) and tcam_test_mask
            end If
        else
            read_tcam_test_value = data_low and tcam_test_mask
        end If
        read_global_test_value = rightShift(data_low, 2) and &H1
        read_tcam_nr_value = rightShift(data_low, 3) and &H1f
        read_global_octet_increment_value = rightShift(data_low, 16) and &H7fff

    End Sub

    Sub write
        If flag_tcam_test = &H0 or flag_global_test = &H0 or flag_tcam_nr = &H0 or flag_global_octet_increment = &H0 Then read
        If flag_tcam_test = &H0 Then write_tcam_test_value = get_tcam_test
        If flag_global_test = &H0 Then write_global_test_value = get_global_test
        If flag_tcam_nr = &H0 Then write_tcam_nr_value = get_tcam_nr
        If flag_global_octet_increment = &H0 Then write_global_octet_increment_value = get_global_octet_increment

        regValue = leftShift((write_tcam_test_value and &H1), 0) + leftShift((write_global_test_value and &H1), 2) + leftShift((write_tcam_nr_value and &H1f), 3) + leftShift((write_global_octet_increment_value and &H7fff), 16)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        tcam_test_mask = &H1
        if data_low > LONG_MAX then
            if tcam_test_mask = mask then
                read_tcam_test_value = data_low
            else
                read_tcam_test_value = (data_low - H8000_0000) and tcam_test_mask
            end If
        else
            read_tcam_test_value = data_low and tcam_test_mask
        end If
        read_global_test_value = rightShift(data_low, 2) and &H1
        read_tcam_nr_value = rightShift(data_low, 3) and &H1f
        read_global_octet_increment_value = rightShift(data_low, 16) and &H7fff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_tcam_test_value = &H0
        flag_tcam_test        = &H0
        write_global_test_value = &H0
        flag_global_test        = &H0
        write_tcam_nr_value = &H0
        flag_tcam_nr        = &H0
        write_global_octet_increment_value = &H0
        flag_global_octet_increment        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_CNTR_DEBUG_REGS_INSTANCE

    Public tcam_count_debug1
    Public tcam_count_debug3
    Public tcam_count_debug4


    Public default function Init(aBaseAddr)
        Set tcam_count_debug1 = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_CNTR_DEBUG_REGS_tcam_count_debug1)(aBaseAddr, 32)
        Set tcam_count_debug3 = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_CNTR_DEBUG_REGS_tcam_count_debug3)(aBaseAddr, 32)
        Set tcam_count_debug4 = (New REGISTER_EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_CNTR_DEBUG_REGS_tcam_count_debug4)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_CNTR_DEBUG_REGS = CreateObject("System.Collections.ArrayList")
EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_CNTR_DEBUG_REGS.Add ((New EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_CNTR_DEBUG_REGS_INSTANCE)(&H4d010000))
EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_CNTR_DEBUG_REGS.Add ((New EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_CNTR_DEBUG_REGS_INSTANCE)(&H4d110000))
EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_CNTR_DEBUG_REGS.Add ((New EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_CNTR_DEBUG_REGS_INSTANCE)(&H4d210000))
EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_CNTR_DEBUG_REGS.Add ((New EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_CNTR_DEBUG_REGS_INSTANCE)(&H4d310000))
EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_CNTR_DEBUG_REGS.Add ((New EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_CNTR_DEBUG_REGS_INSTANCE)(&H4d410000))
EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_CNTR_DEBUG_REGS.Add ((New EIP165S_EIP165_IGEIP160_STATTCAM_TCAM_CNTR_DEBUG_REGS_INSTANCE)(&H4d510000))


