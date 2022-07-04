

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


'' @REGISTER : HSM_SCRATCH_scratch_reg_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' scratch_register0                          [31:0]           get_scratch_register0
''                                                             set_scratch_register0
''                                                             read_scratch_register0
''                                                             write_scratch_register0
''---------------------------------------------------------------------------------
Class REGISTER_HSM_SCRATCH_scratch_reg_0
    Private write_scratch_register0_value
    Private read_scratch_register0_value
    Private flag_scratch_register0

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

    Property Get get_scratch_register0
        get_scratch_register0 = read_scratch_register0_value
    End Property

    Property Let set_scratch_register0(aData)
        write_scratch_register0_value = aData
        flag_scratch_register0        = &H1
    End Property

    Property Get read_scratch_register0
        read
        read_scratch_register0 = read_scratch_register0_value
    End Property

    Property Let write_scratch_register0(aData)
        set_scratch_register0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        scratch_register0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if scratch_register0_mask = mask then
                read_scratch_register0_value = data_low
            else
                read_scratch_register0_value = (data_low - H8000_0000) and scratch_register0_mask
            end If
        else
            read_scratch_register0_value = data_low and scratch_register0_mask
        end If

    End Sub

    Sub write
        If flag_scratch_register0 = &H0 Then read
        If flag_scratch_register0 = &H0 Then write_scratch_register0_value = get_scratch_register0

        regValue = leftShift(write_scratch_register0_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        scratch_register0_mask = &Hffffffff
        if data_low > LONG_MAX then
            if scratch_register0_mask = mask then
                read_scratch_register0_value = data_low
            else
                read_scratch_register0_value = (data_low - H8000_0000) and scratch_register0_mask
            end If
        else
            read_scratch_register0_value = data_low and scratch_register0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_scratch_register0_value = &H0
        flag_scratch_register0        = &H0
    End Sub
End Class


'' @REGISTER : HSM_SCRATCH_scratch_reg_1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' scratch_register1                          [31:0]           get_scratch_register1
''                                                             set_scratch_register1
''                                                             read_scratch_register1
''                                                             write_scratch_register1
''---------------------------------------------------------------------------------
Class REGISTER_HSM_SCRATCH_scratch_reg_1
    Private write_scratch_register1_value
    Private read_scratch_register1_value
    Private flag_scratch_register1

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

    Property Get get_scratch_register1
        get_scratch_register1 = read_scratch_register1_value
    End Property

    Property Let set_scratch_register1(aData)
        write_scratch_register1_value = aData
        flag_scratch_register1        = &H1
    End Property

    Property Get read_scratch_register1
        read
        read_scratch_register1 = read_scratch_register1_value
    End Property

    Property Let write_scratch_register1(aData)
        set_scratch_register1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        scratch_register1_mask = &Hffffffff
        if data_low > LONG_MAX then
            if scratch_register1_mask = mask then
                read_scratch_register1_value = data_low
            else
                read_scratch_register1_value = (data_low - H8000_0000) and scratch_register1_mask
            end If
        else
            read_scratch_register1_value = data_low and scratch_register1_mask
        end If

    End Sub

    Sub write
        If flag_scratch_register1 = &H0 Then read
        If flag_scratch_register1 = &H0 Then write_scratch_register1_value = get_scratch_register1

        regValue = leftShift(write_scratch_register1_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        scratch_register1_mask = &Hffffffff
        if data_low > LONG_MAX then
            if scratch_register1_mask = mask then
                read_scratch_register1_value = data_low
            else
                read_scratch_register1_value = (data_low - H8000_0000) and scratch_register1_mask
            end If
        else
            read_scratch_register1_value = data_low and scratch_register1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_scratch_register1_value = &H0
        flag_scratch_register1        = &H0
    End Sub
End Class


'' @REGISTER : HSM_SCRATCH_scratch_reg_2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' scratch_register2                          [31:0]           get_scratch_register2
''                                                             set_scratch_register2
''                                                             read_scratch_register2
''                                                             write_scratch_register2
''---------------------------------------------------------------------------------
Class REGISTER_HSM_SCRATCH_scratch_reg_2
    Private write_scratch_register2_value
    Private read_scratch_register2_value
    Private flag_scratch_register2

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

    Property Get get_scratch_register2
        get_scratch_register2 = read_scratch_register2_value
    End Property

    Property Let set_scratch_register2(aData)
        write_scratch_register2_value = aData
        flag_scratch_register2        = &H1
    End Property

    Property Get read_scratch_register2
        read
        read_scratch_register2 = read_scratch_register2_value
    End Property

    Property Let write_scratch_register2(aData)
        set_scratch_register2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        scratch_register2_mask = &Hffffffff
        if data_low > LONG_MAX then
            if scratch_register2_mask = mask then
                read_scratch_register2_value = data_low
            else
                read_scratch_register2_value = (data_low - H8000_0000) and scratch_register2_mask
            end If
        else
            read_scratch_register2_value = data_low and scratch_register2_mask
        end If

    End Sub

    Sub write
        If flag_scratch_register2 = &H0 Then read
        If flag_scratch_register2 = &H0 Then write_scratch_register2_value = get_scratch_register2

        regValue = leftShift(write_scratch_register2_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        scratch_register2_mask = &Hffffffff
        if data_low > LONG_MAX then
            if scratch_register2_mask = mask then
                read_scratch_register2_value = data_low
            else
                read_scratch_register2_value = (data_low - H8000_0000) and scratch_register2_mask
            end If
        else
            read_scratch_register2_value = data_low and scratch_register2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_scratch_register2_value = &H0
        flag_scratch_register2        = &H0
    End Sub
End Class


'' @REGISTER : HSM_SCRATCH_scratch_reg_3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' scratch_register3                          [31:0]           get_scratch_register3
''                                                             set_scratch_register3
''                                                             read_scratch_register3
''                                                             write_scratch_register3
''---------------------------------------------------------------------------------
Class REGISTER_HSM_SCRATCH_scratch_reg_3
    Private write_scratch_register3_value
    Private read_scratch_register3_value
    Private flag_scratch_register3

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

    Property Get get_scratch_register3
        get_scratch_register3 = read_scratch_register3_value
    End Property

    Property Let set_scratch_register3(aData)
        write_scratch_register3_value = aData
        flag_scratch_register3        = &H1
    End Property

    Property Get read_scratch_register3
        read
        read_scratch_register3 = read_scratch_register3_value
    End Property

    Property Let write_scratch_register3(aData)
        set_scratch_register3 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        scratch_register3_mask = &Hffffffff
        if data_low > LONG_MAX then
            if scratch_register3_mask = mask then
                read_scratch_register3_value = data_low
            else
                read_scratch_register3_value = (data_low - H8000_0000) and scratch_register3_mask
            end If
        else
            read_scratch_register3_value = data_low and scratch_register3_mask
        end If

    End Sub

    Sub write
        If flag_scratch_register3 = &H0 Then read
        If flag_scratch_register3 = &H0 Then write_scratch_register3_value = get_scratch_register3

        regValue = leftShift(write_scratch_register3_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        scratch_register3_mask = &Hffffffff
        if data_low > LONG_MAX then
            if scratch_register3_mask = mask then
                read_scratch_register3_value = data_low
            else
                read_scratch_register3_value = (data_low - H8000_0000) and scratch_register3_mask
            end If
        else
            read_scratch_register3_value = data_low and scratch_register3_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_scratch_register3_value = &H0
        flag_scratch_register3        = &H0
    End Sub
End Class


'' @REGISTER : HSM_SCRATCH_scratch_reg_4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' scratch_register4                          [31:0]           get_scratch_register4
''                                                             set_scratch_register4
''                                                             read_scratch_register4
''                                                             write_scratch_register4
''---------------------------------------------------------------------------------
Class REGISTER_HSM_SCRATCH_scratch_reg_4
    Private write_scratch_register4_value
    Private read_scratch_register4_value
    Private flag_scratch_register4

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

    Property Get get_scratch_register4
        get_scratch_register4 = read_scratch_register4_value
    End Property

    Property Let set_scratch_register4(aData)
        write_scratch_register4_value = aData
        flag_scratch_register4        = &H1
    End Property

    Property Get read_scratch_register4
        read
        read_scratch_register4 = read_scratch_register4_value
    End Property

    Property Let write_scratch_register4(aData)
        set_scratch_register4 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        scratch_register4_mask = &Hffffffff
        if data_low > LONG_MAX then
            if scratch_register4_mask = mask then
                read_scratch_register4_value = data_low
            else
                read_scratch_register4_value = (data_low - H8000_0000) and scratch_register4_mask
            end If
        else
            read_scratch_register4_value = data_low and scratch_register4_mask
        end If

    End Sub

    Sub write
        If flag_scratch_register4 = &H0 Then read
        If flag_scratch_register4 = &H0 Then write_scratch_register4_value = get_scratch_register4

        regValue = leftShift(write_scratch_register4_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        scratch_register4_mask = &Hffffffff
        if data_low > LONG_MAX then
            if scratch_register4_mask = mask then
                read_scratch_register4_value = data_low
            else
                read_scratch_register4_value = (data_low - H8000_0000) and scratch_register4_mask
            end If
        else
            read_scratch_register4_value = data_low and scratch_register4_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_scratch_register4_value = &H0
        flag_scratch_register4        = &H0
    End Sub
End Class


'' @REGISTER : HSM_SCRATCH_scratch_reg_5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' scratch_register5                          [31:0]           get_scratch_register5
''                                                             set_scratch_register5
''                                                             read_scratch_register5
''                                                             write_scratch_register5
''---------------------------------------------------------------------------------
Class REGISTER_HSM_SCRATCH_scratch_reg_5
    Private write_scratch_register5_value
    Private read_scratch_register5_value
    Private flag_scratch_register5

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

    Property Get get_scratch_register5
        get_scratch_register5 = read_scratch_register5_value
    End Property

    Property Let set_scratch_register5(aData)
        write_scratch_register5_value = aData
        flag_scratch_register5        = &H1
    End Property

    Property Get read_scratch_register5
        read
        read_scratch_register5 = read_scratch_register5_value
    End Property

    Property Let write_scratch_register5(aData)
        set_scratch_register5 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        scratch_register5_mask = &Hffffffff
        if data_low > LONG_MAX then
            if scratch_register5_mask = mask then
                read_scratch_register5_value = data_low
            else
                read_scratch_register5_value = (data_low - H8000_0000) and scratch_register5_mask
            end If
        else
            read_scratch_register5_value = data_low and scratch_register5_mask
        end If

    End Sub

    Sub write
        If flag_scratch_register5 = &H0 Then read
        If flag_scratch_register5 = &H0 Then write_scratch_register5_value = get_scratch_register5

        regValue = leftShift(write_scratch_register5_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        scratch_register5_mask = &Hffffffff
        if data_low > LONG_MAX then
            if scratch_register5_mask = mask then
                read_scratch_register5_value = data_low
            else
                read_scratch_register5_value = (data_low - H8000_0000) and scratch_register5_mask
            end If
        else
            read_scratch_register5_value = data_low and scratch_register5_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_scratch_register5_value = &H0
        flag_scratch_register5        = &H0
    End Sub
End Class


'' @REGISTER : HSM_SCRATCH_scratch_reg_6
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' scratch_register6                          [31:0]           get_scratch_register6
''                                                             set_scratch_register6
''                                                             read_scratch_register6
''                                                             write_scratch_register6
''---------------------------------------------------------------------------------
Class REGISTER_HSM_SCRATCH_scratch_reg_6
    Private write_scratch_register6_value
    Private read_scratch_register6_value
    Private flag_scratch_register6

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

    Property Get get_scratch_register6
        get_scratch_register6 = read_scratch_register6_value
    End Property

    Property Let set_scratch_register6(aData)
        write_scratch_register6_value = aData
        flag_scratch_register6        = &H1
    End Property

    Property Get read_scratch_register6
        read
        read_scratch_register6 = read_scratch_register6_value
    End Property

    Property Let write_scratch_register6(aData)
        set_scratch_register6 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        scratch_register6_mask = &Hffffffff
        if data_low > LONG_MAX then
            if scratch_register6_mask = mask then
                read_scratch_register6_value = data_low
            else
                read_scratch_register6_value = (data_low - H8000_0000) and scratch_register6_mask
            end If
        else
            read_scratch_register6_value = data_low and scratch_register6_mask
        end If

    End Sub

    Sub write
        If flag_scratch_register6 = &H0 Then read
        If flag_scratch_register6 = &H0 Then write_scratch_register6_value = get_scratch_register6

        regValue = leftShift(write_scratch_register6_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        scratch_register6_mask = &Hffffffff
        if data_low > LONG_MAX then
            if scratch_register6_mask = mask then
                read_scratch_register6_value = data_low
            else
                read_scratch_register6_value = (data_low - H8000_0000) and scratch_register6_mask
            end If
        else
            read_scratch_register6_value = data_low and scratch_register6_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_scratch_register6_value = &H0
        flag_scratch_register6        = &H0
    End Sub
End Class


'' @REGISTER : HSM_SCRATCH_scratch_reg_7
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' scratch_register7                          [31:0]           get_scratch_register7
''                                                             set_scratch_register7
''                                                             read_scratch_register7
''                                                             write_scratch_register7
''---------------------------------------------------------------------------------
Class REGISTER_HSM_SCRATCH_scratch_reg_7
    Private write_scratch_register7_value
    Private read_scratch_register7_value
    Private flag_scratch_register7

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

    Property Get get_scratch_register7
        get_scratch_register7 = read_scratch_register7_value
    End Property

    Property Let set_scratch_register7(aData)
        write_scratch_register7_value = aData
        flag_scratch_register7        = &H1
    End Property

    Property Get read_scratch_register7
        read
        read_scratch_register7 = read_scratch_register7_value
    End Property

    Property Let write_scratch_register7(aData)
        set_scratch_register7 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        scratch_register7_mask = &Hffffffff
        if data_low > LONG_MAX then
            if scratch_register7_mask = mask then
                read_scratch_register7_value = data_low
            else
                read_scratch_register7_value = (data_low - H8000_0000) and scratch_register7_mask
            end If
        else
            read_scratch_register7_value = data_low and scratch_register7_mask
        end If

    End Sub

    Sub write
        If flag_scratch_register7 = &H0 Then read
        If flag_scratch_register7 = &H0 Then write_scratch_register7_value = get_scratch_register7

        regValue = leftShift(write_scratch_register7_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        scratch_register7_mask = &Hffffffff
        if data_low > LONG_MAX then
            if scratch_register7_mask = mask then
                read_scratch_register7_value = data_low
            else
                read_scratch_register7_value = (data_low - H8000_0000) and scratch_register7_mask
            end If
        else
            read_scratch_register7_value = data_low and scratch_register7_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_scratch_register7_value = &H0
        flag_scratch_register7        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class HSM_SCRATCH_INSTANCE

    Public scratch_reg_0
    Public scratch_reg_1
    Public scratch_reg_2
    Public scratch_reg_3
    Public scratch_reg_4
    Public scratch_reg_5
    Public scratch_reg_6
    Public scratch_reg_7


    Public default function Init(aBaseAddr)
        Set scratch_reg_0 = (New REGISTER_HSM_SCRATCH_scratch_reg_0)(aBaseAddr, 32)
        Set scratch_reg_1 = (New REGISTER_HSM_SCRATCH_scratch_reg_1)(aBaseAddr, 32)
        Set scratch_reg_2 = (New REGISTER_HSM_SCRATCH_scratch_reg_2)(aBaseAddr, 32)
        Set scratch_reg_3 = (New REGISTER_HSM_SCRATCH_scratch_reg_3)(aBaseAddr, 32)
        Set scratch_reg_4 = (New REGISTER_HSM_SCRATCH_scratch_reg_4)(aBaseAddr, 32)
        Set scratch_reg_5 = (New REGISTER_HSM_SCRATCH_scratch_reg_5)(aBaseAddr, 32)
        Set scratch_reg_6 = (New REGISTER_HSM_SCRATCH_scratch_reg_6)(aBaseAddr, 32)
        Set scratch_reg_7 = (New REGISTER_HSM_SCRATCH_scratch_reg_7)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set HSM_SCRATCH = CreateObject("System.Collections.ArrayList")
HSM_SCRATCH.Add ((New HSM_SCRATCH_INSTANCE)(&H4c019000))


