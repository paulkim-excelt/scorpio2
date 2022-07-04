

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


'' @REGISTER : TX2LN__SGMIIPLUS2_X2_fx100_txcontrol1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' bypass_nrz                                 [4:4]            get_bypass_nrz
''                                                             set_bypass_nrz
''                                                             read_bypass_nrz
''                                                             write_bypass_nrz
''---------------------------------------------------------------------------------
'' bypass_encoder                             [3:3]            get_bypass_encoder
''                                                             set_bypass_encoder
''                                                             read_bypass_encoder
''                                                             write_bypass_encoder
''---------------------------------------------------------------------------------
'' far_end_fault_en                           [2:2]            get_far_end_fault_en
''                                                             set_far_end_fault_en
''                                                             read_far_end_fault_en
''                                                             write_far_end_fault_en
''---------------------------------------------------------------------------------
'' force_link                                 [1:1]            get_force_link
''                                                             set_force_link
''                                                             read_force_link
''                                                             write_force_link
''---------------------------------------------------------------------------------
'' fast_timers                                [0:0]            get_fast_timers
''                                                             set_fast_timers
''                                                             read_fast_timers
''                                                             write_fast_timers
''---------------------------------------------------------------------------------
Class REGISTER_TX2LN__SGMIIPLUS2_X2_fx100_txcontrol1
    Private write_bypass_nrz_value
    Private read_bypass_nrz_value
    Private flag_bypass_nrz
    Private write_bypass_encoder_value
    Private read_bypass_encoder_value
    Private flag_bypass_encoder
    Private write_far_end_fault_en_value
    Private read_far_end_fault_en_value
    Private flag_far_end_fault_en
    Private write_force_link_value
    Private read_force_link_value
    Private flag_force_link
    Private write_fast_timers_value
    Private read_fast_timers_value
    Private flag_fast_timers

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H6
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_bypass_nrz
        get_bypass_nrz = read_bypass_nrz_value
    End Property

    Property Let set_bypass_nrz(aData)
        write_bypass_nrz_value = aData
        flag_bypass_nrz        = &H1
    End Property

    Property Get read_bypass_nrz
        read
        read_bypass_nrz = read_bypass_nrz_value
    End Property

    Property Let write_bypass_nrz(aData)
        set_bypass_nrz = aData
        write
    End Property

    Property Get get_bypass_encoder
        get_bypass_encoder = read_bypass_encoder_value
    End Property

    Property Let set_bypass_encoder(aData)
        write_bypass_encoder_value = aData
        flag_bypass_encoder        = &H1
    End Property

    Property Get read_bypass_encoder
        read
        read_bypass_encoder = read_bypass_encoder_value
    End Property

    Property Let write_bypass_encoder(aData)
        set_bypass_encoder = aData
        write
    End Property

    Property Get get_far_end_fault_en
        get_far_end_fault_en = read_far_end_fault_en_value
    End Property

    Property Let set_far_end_fault_en(aData)
        write_far_end_fault_en_value = aData
        flag_far_end_fault_en        = &H1
    End Property

    Property Get read_far_end_fault_en
        read
        read_far_end_fault_en = read_far_end_fault_en_value
    End Property

    Property Let write_far_end_fault_en(aData)
        set_far_end_fault_en = aData
        write
    End Property

    Property Get get_force_link
        get_force_link = read_force_link_value
    End Property

    Property Let set_force_link(aData)
        write_force_link_value = aData
        flag_force_link        = &H1
    End Property

    Property Get read_force_link
        read
        read_force_link = read_force_link_value
    End Property

    Property Let write_force_link(aData)
        set_force_link = aData
        write
    End Property

    Property Get get_fast_timers
        get_fast_timers = read_fast_timers_value
    End Property

    Property Let set_fast_timers(aData)
        write_fast_timers_value = aData
        flag_fast_timers        = &H1
    End Property

    Property Get read_fast_timers
        read
        read_fast_timers = read_fast_timers_value
    End Property

    Property Let write_fast_timers(aData)
        set_fast_timers = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_bypass_nrz_value = rightShift(data_low, 4) and &H1
        read_bypass_encoder_value = rightShift(data_low, 3) and &H1
        read_far_end_fault_en_value = rightShift(data_low, 2) and &H1
        read_force_link_value = rightShift(data_low, 1) and &H1
        fast_timers_mask = &H1
        if data_low > LONG_MAX then
            if fast_timers_mask = mask then
                read_fast_timers_value = data_low
            else
                read_fast_timers_value = (data_low - H8000_0000) and fast_timers_mask
            end If
        else
            read_fast_timers_value = data_low and fast_timers_mask
        end If

    End Sub

    Sub write
        If flag_bypass_nrz = &H0 or flag_bypass_encoder = &H0 or flag_far_end_fault_en = &H0 or flag_force_link = &H0 or flag_fast_timers = &H0 Then read
        If flag_bypass_nrz = &H0 Then write_bypass_nrz_value = get_bypass_nrz
        If flag_bypass_encoder = &H0 Then write_bypass_encoder_value = get_bypass_encoder
        If flag_far_end_fault_en = &H0 Then write_far_end_fault_en_value = get_far_end_fault_en
        If flag_force_link = &H0 Then write_force_link_value = get_force_link
        If flag_fast_timers = &H0 Then write_fast_timers_value = get_fast_timers

        regValue = leftShift((write_bypass_nrz_value and &H1), 4) + leftShift((write_bypass_encoder_value and &H1), 3) + leftShift((write_far_end_fault_en_value and &H1), 2) + leftShift((write_force_link_value and &H1), 1) + leftShift((write_fast_timers_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_bypass_nrz_value = rightShift(data_low, 4) and &H1
        read_bypass_encoder_value = rightShift(data_low, 3) and &H1
        read_far_end_fault_en_value = rightShift(data_low, 2) and &H1
        read_force_link_value = rightShift(data_low, 1) and &H1
        fast_timers_mask = &H1
        if data_low > LONG_MAX then
            if fast_timers_mask = mask then
                read_fast_timers_value = data_low
            else
                read_fast_timers_value = (data_low - H8000_0000) and fast_timers_mask
            end If
        else
            read_fast_timers_value = data_low and fast_timers_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_bypass_nrz_value = &H0
        flag_bypass_nrz        = &H0
        write_bypass_encoder_value = &H0
        flag_bypass_encoder        = &H0
        write_far_end_fault_en_value = &H0
        flag_far_end_fault_en        = &H0
        write_force_link_value = &H0
        flag_force_link        = &H0
        write_fast_timers_value = &H0
        flag_fast_timers        = &H0
    End Sub
End Class


'' @REGISTER : TX2LN__SGMIIPLUS2_X2_blockaddress
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
Class REGISTER_TX2LN__SGMIIPLUS2_X2_blockaddress
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

Class TX2LN__SGMIIPLUS2_X2_INSTANCE

    Public fx100_txcontrol1
    Public blockaddress


    Public default function Init(aBaseAddr)
        Set fx100_txcontrol1 = (New REGISTER_TX2LN__SGMIIPLUS2_X2_fx100_txcontrol1)(aBaseAddr, 16)
        Set blockaddress = (New REGISTER_TX2LN__SGMIIPLUS2_X2_blockaddress)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set TX2LN__SGMIIPLUS2_X2 = CreateObject("System.Collections.ArrayList")
TX2LN__SGMIIPLUS2_X2.Add ((New TX2LN__SGMIIPLUS2_X2_INSTANCE)(&H4acd0120))
TX2LN__SGMIIPLUS2_X2.Add ((New TX2LN__SGMIIPLUS2_X2_INSTANCE)(&H4acf0120))


