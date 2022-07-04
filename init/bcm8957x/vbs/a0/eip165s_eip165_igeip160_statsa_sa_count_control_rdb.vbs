

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


'' @REGISTER : EIP165S_EIP165_IGEIP160_STATSA_SA_COUNT_CONTROL_sa_count_control
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RESET_ALL                                  [0:0]            get_RESET_ALL
''                                                             set_RESET_ALL
''                                                             read_RESET_ALL
''                                                             write_RESET_ALL
''---------------------------------------------------------------------------------
'' DEBUG_ACCESS                               [1:1]            get_DEBUG_ACCESS
''                                                             set_DEBUG_ACCESS
''                                                             read_DEBUG_ACCESS
''                                                             write_DEBUG_ACCESS
''---------------------------------------------------------------------------------
'' SATU_CNTR                                  [2:2]            get_SATU_CNTR
''                                                             set_SATU_CNTR
''                                                             read_SATU_CNTR
''                                                             write_SATU_CNTR
''---------------------------------------------------------------------------------
'' AUTO_CNTR_RESE                             [3:3]            get_AUTO_CNTR_RESE
''                                                             set_AUTO_CNTR_RESE
''                                                             read_AUTO_CNTR_RESE
''                                                             write_AUTO_CNTR_RESE
''---------------------------------------------------------------------------------
'' RESE_SUMM                                  [4:4]            get_RESE_SUMM
''                                                             set_RESE_SUMM
''                                                             read_RESE_SUMM
''                                                             write_RESE_SUMM
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP165_IGEIP160_STATSA_SA_COUNT_CONTROL_sa_count_control
    Private write_RESET_ALL_value
    Private read_RESET_ALL_value
    Private flag_RESET_ALL
    Private write_DEBUG_ACCESS_value
    Private read_DEBUG_ACCESS_value
    Private flag_DEBUG_ACCESS
    Private write_SATU_CNTR_value
    Private read_SATU_CNTR_value
    Private flag_SATU_CNTR
    Private write_AUTO_CNTR_RESE_value
    Private read_AUTO_CNTR_RESE_value
    Private flag_AUTO_CNTR_RESE
    Private write_RESE_SUMM_value
    Private read_RESE_SUMM_value
    Private flag_RESE_SUMM

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He210
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_RESET_ALL
        get_RESET_ALL = read_RESET_ALL_value
    End Property

    Property Let set_RESET_ALL(aData)
        write_RESET_ALL_value = aData
        flag_RESET_ALL        = &H1
    End Property

    Property Get read_RESET_ALL
        read
        read_RESET_ALL = read_RESET_ALL_value
    End Property

    Property Let write_RESET_ALL(aData)
        set_RESET_ALL = aData
        write
    End Property

    Property Get get_DEBUG_ACCESS
        get_DEBUG_ACCESS = read_DEBUG_ACCESS_value
    End Property

    Property Let set_DEBUG_ACCESS(aData)
        write_DEBUG_ACCESS_value = aData
        flag_DEBUG_ACCESS        = &H1
    End Property

    Property Get read_DEBUG_ACCESS
        read
        read_DEBUG_ACCESS = read_DEBUG_ACCESS_value
    End Property

    Property Let write_DEBUG_ACCESS(aData)
        set_DEBUG_ACCESS = aData
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

    Property Get get_RESE_SUMM
        get_RESE_SUMM = read_RESE_SUMM_value
    End Property

    Property Let set_RESE_SUMM(aData)
        write_RESE_SUMM_value = aData
        flag_RESE_SUMM        = &H1
    End Property

    Property Get read_RESE_SUMM
        read
        read_RESE_SUMM = read_RESE_SUMM_value
    End Property

    Property Let write_RESE_SUMM(aData)
        set_RESE_SUMM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RESET_ALL_mask = &H1
        if data_low > LONG_MAX then
            if RESET_ALL_mask = mask then
                read_RESET_ALL_value = data_low
            else
                read_RESET_ALL_value = (data_low - H8000_0000) and RESET_ALL_mask
            end If
        else
            read_RESET_ALL_value = data_low and RESET_ALL_mask
        end If
        read_DEBUG_ACCESS_value = rightShift(data_low, 1) and &H1
        read_SATU_CNTR_value = rightShift(data_low, 2) and &H1
        read_AUTO_CNTR_RESE_value = rightShift(data_low, 3) and &H1
        read_RESE_SUMM_value = rightShift(data_low, 4) and &H1

    End Sub

    Sub write
        If flag_RESET_ALL = &H0 or flag_DEBUG_ACCESS = &H0 or flag_SATU_CNTR = &H0 or flag_AUTO_CNTR_RESE = &H0 or flag_RESE_SUMM = &H0 Then read
        If flag_RESET_ALL = &H0 Then write_RESET_ALL_value = get_RESET_ALL
        If flag_DEBUG_ACCESS = &H0 Then write_DEBUG_ACCESS_value = get_DEBUG_ACCESS
        If flag_SATU_CNTR = &H0 Then write_SATU_CNTR_value = get_SATU_CNTR
        If flag_AUTO_CNTR_RESE = &H0 Then write_AUTO_CNTR_RESE_value = get_AUTO_CNTR_RESE
        If flag_RESE_SUMM = &H0 Then write_RESE_SUMM_value = get_RESE_SUMM

        regValue = leftShift((write_RESET_ALL_value and &H1), 0) + leftShift((write_DEBUG_ACCESS_value and &H1), 1) + leftShift((write_SATU_CNTR_value and &H1), 2) + leftShift((write_AUTO_CNTR_RESE_value and &H1), 3) + leftShift((write_RESE_SUMM_value and &H1), 4)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        RESET_ALL_mask = &H1
        if data_low > LONG_MAX then
            if RESET_ALL_mask = mask then
                read_RESET_ALL_value = data_low
            else
                read_RESET_ALL_value = (data_low - H8000_0000) and RESET_ALL_mask
            end If
        else
            read_RESET_ALL_value = data_low and RESET_ALL_mask
        end If
        read_DEBUG_ACCESS_value = rightShift(data_low, 1) and &H1
        read_SATU_CNTR_value = rightShift(data_low, 2) and &H1
        read_AUTO_CNTR_RESE_value = rightShift(data_low, 3) and &H1
        read_RESE_SUMM_value = rightShift(data_low, 4) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RESET_ALL_value = &H0
        flag_RESET_ALL        = &H0
        write_DEBUG_ACCESS_value = &H0
        flag_DEBUG_ACCESS        = &H0
        write_SATU_CNTR_value = &H0
        flag_SATU_CNTR        = &H0
        write_AUTO_CNTR_RESE_value = &H0
        flag_AUTO_CNTR_RESE        = &H0
        write_RESE_SUMM_value = &H0
        flag_RESE_SUMM        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class EIP165S_EIP165_IGEIP160_STATSA_SA_COUNT_CONTROL_INSTANCE

    Public sa_count_control


    Public default function Init(aBaseAddr)
        Set sa_count_control = (New REGISTER_EIP165S_EIP165_IGEIP160_STATSA_SA_COUNT_CONTROL_sa_count_control)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set EIP165S_EIP165_IGEIP160_STATSA_SA_COUNT_CONTROL = CreateObject("System.Collections.ArrayList")
EIP165S_EIP165_IGEIP160_STATSA_SA_COUNT_CONTROL.Add ((New EIP165S_EIP165_IGEIP160_STATSA_SA_COUNT_CONTROL_INSTANCE)(&H4d010000))
EIP165S_EIP165_IGEIP160_STATSA_SA_COUNT_CONTROL.Add ((New EIP165S_EIP165_IGEIP160_STATSA_SA_COUNT_CONTROL_INSTANCE)(&H4d110000))
EIP165S_EIP165_IGEIP160_STATSA_SA_COUNT_CONTROL.Add ((New EIP165S_EIP165_IGEIP160_STATSA_SA_COUNT_CONTROL_INSTANCE)(&H4d210000))
EIP165S_EIP165_IGEIP160_STATSA_SA_COUNT_CONTROL.Add ((New EIP165S_EIP165_IGEIP160_STATSA_SA_COUNT_CONTROL_INSTANCE)(&H4d310000))
EIP165S_EIP165_IGEIP160_STATSA_SA_COUNT_CONTROL.Add ((New EIP165S_EIP165_IGEIP160_STATSA_SA_COUNT_CONTROL_INSTANCE)(&H4d410000))
EIP165S_EIP165_IGEIP160_STATSA_SA_COUNT_CONTROL.Add ((New EIP165S_EIP165_IGEIP160_STATSA_SA_COUNT_CONTROL_INSTANCE)(&H4d510000))


