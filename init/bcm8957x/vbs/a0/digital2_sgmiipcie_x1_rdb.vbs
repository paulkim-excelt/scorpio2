

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


'' @REGISTER : DIGITAL2_SGMIIPCIE_X1_serdesid0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rev_letter                                 [15:14]          get_rev_letter
''                                                             set_rev_letter
''                                                             read_rev_letter
''                                                             write_rev_letter
''---------------------------------------------------------------------------------
'' rev_number                                 [13:11]          get_rev_number
''                                                             set_rev_number
''                                                             read_rev_number
''                                                             write_rev_number
''---------------------------------------------------------------------------------
'' bonding                                    [10:9]           get_bonding
''                                                             set_bonding
''                                                             read_bonding
''                                                             write_bonding
''---------------------------------------------------------------------------------
'' tech_proc                                  [8:6]            get_tech_proc
''                                                             set_tech_proc
''                                                             read_tech_proc
''                                                             write_tech_proc
''---------------------------------------------------------------------------------
'' model_number                               [5:0]            get_model_number
''                                                             set_model_number
''                                                             read_model_number
''                                                             write_model_number
''---------------------------------------------------------------------------------
Class REGISTER_DIGITAL2_SGMIIPCIE_X1_serdesid0
    Private write_rev_letter_value
    Private read_rev_letter_value
    Private flag_rev_letter
    Private write_rev_number_value
    Private read_rev_number_value
    Private flag_rev_number
    Private write_bonding_value
    Private read_bonding_value
    Private flag_bonding
    Private write_tech_proc_value
    Private read_tech_proc_value
    Private flag_tech_proc
    Private write_model_number_value
    Private read_model_number_value
    Private flag_model_number

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

    Property Get get_rev_letter
        get_rev_letter = read_rev_letter_value
    End Property

    Property Let set_rev_letter(aData)
        write_rev_letter_value = aData
        flag_rev_letter        = &H1
    End Property

    Property Get read_rev_letter
        read
        read_rev_letter = read_rev_letter_value
    End Property

    Property Let write_rev_letter(aData)
        set_rev_letter = aData
        write
    End Property

    Property Get get_rev_number
        get_rev_number = read_rev_number_value
    End Property

    Property Let set_rev_number(aData)
        write_rev_number_value = aData
        flag_rev_number        = &H1
    End Property

    Property Get read_rev_number
        read
        read_rev_number = read_rev_number_value
    End Property

    Property Let write_rev_number(aData)
        set_rev_number = aData
        write
    End Property

    Property Get get_bonding
        get_bonding = read_bonding_value
    End Property

    Property Let set_bonding(aData)
        write_bonding_value = aData
        flag_bonding        = &H1
    End Property

    Property Get read_bonding
        read
        read_bonding = read_bonding_value
    End Property

    Property Let write_bonding(aData)
        set_bonding = aData
        write
    End Property

    Property Get get_tech_proc
        get_tech_proc = read_tech_proc_value
    End Property

    Property Let set_tech_proc(aData)
        write_tech_proc_value = aData
        flag_tech_proc        = &H1
    End Property

    Property Get read_tech_proc
        read
        read_tech_proc = read_tech_proc_value
    End Property

    Property Let write_tech_proc(aData)
        set_tech_proc = aData
        write
    End Property

    Property Get get_model_number
        get_model_number = read_model_number_value
    End Property

    Property Let set_model_number(aData)
        write_model_number_value = aData
        flag_model_number        = &H1
    End Property

    Property Get read_model_number
        read
        read_model_number = read_model_number_value
    End Property

    Property Let write_model_number(aData)
        set_model_number = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rev_letter_value = rightShift(data_low, 14) and &H3
        read_rev_number_value = rightShift(data_low, 11) and &H7
        read_bonding_value = rightShift(data_low, 9) and &H3
        read_tech_proc_value = rightShift(data_low, 6) and &H7
        model_number_mask = &H3f
        if data_low > LONG_MAX then
            if model_number_mask = mask then
                read_model_number_value = data_low
            else
                read_model_number_value = (data_low - H8000_0000) and model_number_mask
            end If
        else
            read_model_number_value = data_low and model_number_mask
        end If

    End Sub

    Sub write
        If flag_rev_letter = &H0 or flag_rev_number = &H0 or flag_bonding = &H0 or flag_tech_proc = &H0 or flag_model_number = &H0 Then read
        If flag_rev_letter = &H0 Then write_rev_letter_value = get_rev_letter
        If flag_rev_number = &H0 Then write_rev_number_value = get_rev_number
        If flag_bonding = &H0 Then write_bonding_value = get_bonding
        If flag_tech_proc = &H0 Then write_tech_proc_value = get_tech_proc
        If flag_model_number = &H0 Then write_model_number_value = get_model_number

        regValue = leftShift((write_rev_letter_value and &H3), 14) + leftShift((write_rev_number_value and &H7), 11) + leftShift((write_bonding_value and &H3), 9) + leftShift((write_tech_proc_value and &H7), 6) + leftShift((write_model_number_value and &H3f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_rev_letter_value = rightShift(data_low, 14) and &H3
        read_rev_number_value = rightShift(data_low, 11) and &H7
        read_bonding_value = rightShift(data_low, 9) and &H3
        read_tech_proc_value = rightShift(data_low, 6) and &H7
        model_number_mask = &H3f
        if data_low > LONG_MAX then
            if model_number_mask = mask then
                read_model_number_value = data_low
            else
                read_model_number_value = (data_low - H8000_0000) and model_number_mask
            end If
        else
            read_model_number_value = data_low and model_number_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rev_letter_value = &H0
        flag_rev_letter        = &H0
        write_rev_number_value = &H0
        flag_rev_number        = &H0
        write_bonding_value = &H0
        flag_bonding        = &H0
        write_tech_proc_value = &H0
        flag_tech_proc        = &H0
        write_model_number_value = &H0
        flag_model_number        = &H0
    End Sub
End Class


'' @REGISTER : DIGITAL2_SGMIIPCIE_X1_blockaddress
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' BlockAddress                               [14:4]           get_BlockAddress
''                                                             set_BlockAddress
''                                                             read_BlockAddress
''                                                             write_BlockAddress
''---------------------------------------------------------------------------------
Class REGISTER_DIGITAL2_SGMIIPCIE_X1_blockaddress
    Private write_BlockAddress_value
    Private read_BlockAddress_value
    Private flag_BlockAddress

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1e
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_BlockAddress
        get_BlockAddress = read_BlockAddress_value
    End Property

    Property Let set_BlockAddress(aData)
        write_BlockAddress_value = aData
        flag_BlockAddress        = &H1
    End Property

    Property Get read_BlockAddress
        read
        read_BlockAddress = read_BlockAddress_value
    End Property

    Property Let write_BlockAddress(aData)
        set_BlockAddress = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_BlockAddress_value = rightShift(data_low, 4) and &H7ff

    End Sub

    Sub write
        If flag_BlockAddress = &H0 Then read
        If flag_BlockAddress = &H0 Then write_BlockAddress_value = get_BlockAddress

        regValue = leftShift((write_BlockAddress_value and &H7ff), 4)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_BlockAddress_value = rightShift(data_low, 4) and &H7ff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_BlockAddress_value = &H0
        flag_BlockAddress        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class DIGITAL2_SGMIIPCIE_X1_INSTANCE

    Public serdesid0
    Public blockaddress


    Public default function Init(aBaseAddr)
        Set serdesid0 = (New REGISTER_DIGITAL2_SGMIIPCIE_X1_serdesid0)(aBaseAddr, 16)
        Set blockaddress = (New REGISTER_DIGITAL2_SGMIIPCIE_X1_blockaddress)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set DIGITAL2_SGMIIPCIE_X1 = CreateObject("System.Collections.ArrayList")
DIGITAL2_SGMIIPCIE_X1.Add ((New DIGITAL2_SGMIIPCIE_X1_INSTANCE)(&H4add0080))


