

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


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_GLOBAL_gl_time_tick
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' time_tick                                  [31:0]           get_time_tick
''                                                             set_time_tick
''                                                             read_time_tick
''                                                             write_time_tick
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_GLOBAL_gl_time_tick
    Private write_time_tick_value
    Private read_time_tick_value
    Private flag_time_tick

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H17e00
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_time_tick
        get_time_tick = read_time_tick_value
    End Property

    Property Let set_time_tick(aData)
        write_time_tick_value = aData
        flag_time_tick        = &H1
    End Property

    Property Get read_time_tick
        read
        read_time_tick = read_time_tick_value
    End Property

    Property Let write_time_tick(aData)
        set_time_tick = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        time_tick_mask = &Hffffffff
        if data_low > LONG_MAX then
            if time_tick_mask = mask then
                read_time_tick_value = data_low
            else
                read_time_tick_value = (data_low - H8000_0000) and time_tick_mask
            end If
        else
            read_time_tick_value = data_low and time_tick_mask
        end If

    End Sub

    Sub write
        If flag_time_tick = &H0 Then read
        If flag_time_tick = &H0 Then write_time_tick_value = get_time_tick

        regValue = leftShift(write_time_tick_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        time_tick_mask = &Hffffffff
        if data_low > LONG_MAX then
            if time_tick_mask = mask then
                read_time_tick_value = data_low
            else
                read_time_tick_value = (data_low - H8000_0000) and time_tick_mask
            end If
        else
            read_time_tick_value = data_low and time_tick_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_time_tick_value = &H0
        flag_time_tick        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_160S_E_32_BRCM_GLOBAL_gl_time_prescale
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' prescale                                   [31:0]           get_prescale
''                                                             set_prescale
''                                                             read_prescale
''                                                             write_prescale
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_160S_E_32_BRCM_GLOBAL_gl_time_prescale
    Private write_prescale_value
    Private read_prescale_value
    Private flag_prescale

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H17e04
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_prescale
        get_prescale = read_prescale_value
    End Property

    Property Let set_prescale(aData)
        write_prescale_value = aData
        flag_prescale        = &H1
    End Property

    Property Get read_prescale
        read
        read_prescale = read_prescale_value
    End Property

    Property Let write_prescale(aData)
        set_prescale = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        prescale_mask = &Hffffffff
        if data_low > LONG_MAX then
            if prescale_mask = mask then
                read_prescale_value = data_low
            else
                read_prescale_value = (data_low - H8000_0000) and prescale_mask
            end If
        else
            read_prescale_value = data_low and prescale_mask
        end If

    End Sub

    Sub write
        If flag_prescale = &H0 Then read
        If flag_prescale = &H0 Then write_prescale_value = get_prescale

        regValue = leftShift(write_prescale_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        prescale_mask = &Hffffffff
        if data_low > LONG_MAX then
            if prescale_mask = mask then
                read_prescale_value = data_low
            else
                read_prescale_value = (data_low - H8000_0000) and prescale_mask
            end If
        else
            read_prescale_value = data_low and prescale_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_prescale_value = &H0
        flag_prescale        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class EIP165S_EIP_160S_E_32_BRCM_GLOBAL_INSTANCE

    Public gl_time_tick
    Public gl_time_prescale


    Public default function Init(aBaseAddr)
        Set gl_time_tick = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_GLOBAL_gl_time_tick)(aBaseAddr, 32)
        Set gl_time_prescale = (New REGISTER_EIP165S_EIP_160S_E_32_BRCM_GLOBAL_gl_time_prescale)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set EIP165S_EIP_160S_E_32_BRCM_GLOBAL = CreateObject("System.Collections.ArrayList")
EIP165S_EIP_160S_E_32_BRCM_GLOBAL.Add ((New EIP165S_EIP_160S_E_32_BRCM_GLOBAL_INSTANCE)(&H4d010000))
EIP165S_EIP_160S_E_32_BRCM_GLOBAL.Add ((New EIP165S_EIP_160S_E_32_BRCM_GLOBAL_INSTANCE)(&H4d110000))
EIP165S_EIP_160S_E_32_BRCM_GLOBAL.Add ((New EIP165S_EIP_160S_E_32_BRCM_GLOBAL_INSTANCE)(&H4d210000))
EIP165S_EIP_160S_E_32_BRCM_GLOBAL.Add ((New EIP165S_EIP_160S_E_32_BRCM_GLOBAL_INSTANCE)(&H4d310000))
EIP165S_EIP_160S_E_32_BRCM_GLOBAL.Add ((New EIP165S_EIP_160S_E_32_BRCM_GLOBAL_INSTANCE)(&H4d410000))
EIP165S_EIP_160S_E_32_BRCM_GLOBAL.Add ((New EIP165S_EIP_160S_E_32_BRCM_GLOBAL_INSTANCE)(&H4d510000))


