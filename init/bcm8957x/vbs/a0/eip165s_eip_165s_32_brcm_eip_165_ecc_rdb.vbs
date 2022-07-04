

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


'' @REGISTER : EIP165S_EIP_165S_32_BRCM_EIP_165_ECC_ecc_corrected_flags
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ig_trc_ram                                 [0:0]            get_ig_trc_ram
''                                                             set_ig_trc_ram
''                                                             read_ig_trc_ram
''                                                             write_ig_trc_ram
''---------------------------------------------------------------------------------
'' ig_stat_sa                                 [1:1]            get_ig_stat_sa
''                                                             set_ig_stat_sa
''                                                             read_ig_stat_sa
''                                                             write_ig_stat_sa
''---------------------------------------------------------------------------------
'' ig_stat_class                              [2:2]            get_ig_stat_class
''                                                             set_ig_stat_class
''                                                             read_ig_stat_class
''                                                             write_ig_stat_class
''---------------------------------------------------------------------------------
'' ig_stat_vport                              [3:3]            get_ig_stat_vport
''                                                             set_ig_stat_vport
''                                                             read_ig_stat_vport
''                                                             write_ig_stat_vport
''---------------------------------------------------------------------------------
'' ig_saf_ram_sc                              [4:4]            get_ig_saf_ram_sc
''                                                             set_ig_saf_ram_sc
''                                                             read_ig_saf_ram_sc
''                                                             write_ig_saf_ram_sc
''---------------------------------------------------------------------------------
'' ig_saf_ram_ec                              [5:5]            get_ig_saf_ram_ec
''                                                             set_ig_saf_ram_ec
''                                                             read_ig_saf_ram_ec
''                                                             write_ig_saf_ram_ec
''---------------------------------------------------------------------------------
'' ig_saf_ram                                 [6:6]            get_ig_saf_ram
''                                                             set_ig_saf_ram
''                                                             read_ig_saf_ram
''                                                             write_ig_saf_ram
''---------------------------------------------------------------------------------
'' eg_trc_ram                                 [7:7]            get_eg_trc_ram
''                                                             set_eg_trc_ram
''                                                             read_eg_trc_ram
''                                                             write_eg_trc_ram
''---------------------------------------------------------------------------------
'' eg_stat_sa                                 [8:8]            get_eg_stat_sa
''                                                             set_eg_stat_sa
''                                                             read_eg_stat_sa
''                                                             write_eg_stat_sa
''---------------------------------------------------------------------------------
'' eg_stat_class                              [9:9]            get_eg_stat_class
''                                                             set_eg_stat_class
''                                                             read_eg_stat_class
''                                                             write_eg_stat_class
''---------------------------------------------------------------------------------
'' eg_stat_vport                              [10:10]          get_eg_stat_vport
''                                                             set_eg_stat_vport
''                                                             read_eg_stat_vport
''                                                             write_eg_stat_vport
''---------------------------------------------------------------------------------
'' eg_saf_ram_sc                              [11:11]          get_eg_saf_ram_sc
''                                                             set_eg_saf_ram_sc
''                                                             read_eg_saf_ram_sc
''                                                             write_eg_saf_ram_sc
''---------------------------------------------------------------------------------
'' eg_saf_ram_ec                              [12:12]          get_eg_saf_ram_ec
''                                                             set_eg_saf_ram_ec
''                                                             read_eg_saf_ram_ec
''                                                             write_eg_saf_ram_ec
''---------------------------------------------------------------------------------
'' eg_saf_ram                                 [13:13]          get_eg_saf_ram
''                                                             set_eg_saf_ram
''                                                             read_eg_saf_ram
''                                                             write_eg_saf_ram
''---------------------------------------------------------------------------------
'' redir_debug                                [14:14]          get_redir_debug
''                                                             set_redir_debug
''                                                             read_redir_debug
''                                                             write_redir_debug
''---------------------------------------------------------------------------------
'' ig_capt_debug                              [15:15]          get_ig_capt_debug
''                                                             set_ig_capt_debug
''                                                             read_ig_capt_debug
''                                                             write_ig_capt_debug
''---------------------------------------------------------------------------------
'' eg_capt_debug                              [16:16]          get_eg_capt_debug
''                                                             set_eg_capt_debug
''                                                             read_eg_capt_debug
''                                                             write_eg_capt_debug
''---------------------------------------------------------------------------------
'' ig_tcam_ram                                [17:17]          get_ig_tcam_ram
''                                                             set_ig_tcam_ram
''                                                             read_ig_tcam_ram
''                                                             write_ig_tcam_ram
''---------------------------------------------------------------------------------
'' eg_tcam_ram                                [18:18]          get_eg_tcam_ram
''                                                             set_eg_tcam_ram
''                                                             read_eg_tcam_ram
''                                                             write_eg_tcam_ram
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_165S_32_BRCM_EIP_165_ECC_ecc_corrected_flags
    Private write_ig_trc_ram_value
    Private read_ig_trc_ram_value
    Private flag_ig_trc_ram
    Private write_ig_stat_sa_value
    Private read_ig_stat_sa_value
    Private flag_ig_stat_sa
    Private write_ig_stat_class_value
    Private read_ig_stat_class_value
    Private flag_ig_stat_class
    Private write_ig_stat_vport_value
    Private read_ig_stat_vport_value
    Private flag_ig_stat_vport
    Private write_ig_saf_ram_sc_value
    Private read_ig_saf_ram_sc_value
    Private flag_ig_saf_ram_sc
    Private write_ig_saf_ram_ec_value
    Private read_ig_saf_ram_ec_value
    Private flag_ig_saf_ram_ec
    Private write_ig_saf_ram_value
    Private read_ig_saf_ram_value
    Private flag_ig_saf_ram
    Private write_eg_trc_ram_value
    Private read_eg_trc_ram_value
    Private flag_eg_trc_ram
    Private write_eg_stat_sa_value
    Private read_eg_stat_sa_value
    Private flag_eg_stat_sa
    Private write_eg_stat_class_value
    Private read_eg_stat_class_value
    Private flag_eg_stat_class
    Private write_eg_stat_vport_value
    Private read_eg_stat_vport_value
    Private flag_eg_stat_vport
    Private write_eg_saf_ram_sc_value
    Private read_eg_saf_ram_sc_value
    Private flag_eg_saf_ram_sc
    Private write_eg_saf_ram_ec_value
    Private read_eg_saf_ram_ec_value
    Private flag_eg_saf_ram_ec
    Private write_eg_saf_ram_value
    Private read_eg_saf_ram_value
    Private flag_eg_saf_ram
    Private write_redir_debug_value
    Private read_redir_debug_value
    Private flag_redir_debug
    Private write_ig_capt_debug_value
    Private read_ig_capt_debug_value
    Private flag_ig_capt_debug
    Private write_eg_capt_debug_value
    Private read_eg_capt_debug_value
    Private flag_eg_capt_debug
    Private write_ig_tcam_ram_value
    Private read_ig_tcam_ram_value
    Private flag_ig_tcam_ram
    Private write_eg_tcam_ram_value
    Private read_eg_tcam_ram_value
    Private flag_eg_tcam_ram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H20d00
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ig_trc_ram
        get_ig_trc_ram = read_ig_trc_ram_value
    End Property

    Property Let set_ig_trc_ram(aData)
        write_ig_trc_ram_value = aData
        flag_ig_trc_ram        = &H1
    End Property

    Property Get read_ig_trc_ram
        read
        read_ig_trc_ram = read_ig_trc_ram_value
    End Property

    Property Let write_ig_trc_ram(aData)
        set_ig_trc_ram = aData
        write
    End Property

    Property Get get_ig_stat_sa
        get_ig_stat_sa = read_ig_stat_sa_value
    End Property

    Property Let set_ig_stat_sa(aData)
        write_ig_stat_sa_value = aData
        flag_ig_stat_sa        = &H1
    End Property

    Property Get read_ig_stat_sa
        read
        read_ig_stat_sa = read_ig_stat_sa_value
    End Property

    Property Let write_ig_stat_sa(aData)
        set_ig_stat_sa = aData
        write
    End Property

    Property Get get_ig_stat_class
        get_ig_stat_class = read_ig_stat_class_value
    End Property

    Property Let set_ig_stat_class(aData)
        write_ig_stat_class_value = aData
        flag_ig_stat_class        = &H1
    End Property

    Property Get read_ig_stat_class
        read
        read_ig_stat_class = read_ig_stat_class_value
    End Property

    Property Let write_ig_stat_class(aData)
        set_ig_stat_class = aData
        write
    End Property

    Property Get get_ig_stat_vport
        get_ig_stat_vport = read_ig_stat_vport_value
    End Property

    Property Let set_ig_stat_vport(aData)
        write_ig_stat_vport_value = aData
        flag_ig_stat_vport        = &H1
    End Property

    Property Get read_ig_stat_vport
        read
        read_ig_stat_vport = read_ig_stat_vport_value
    End Property

    Property Let write_ig_stat_vport(aData)
        set_ig_stat_vport = aData
        write
    End Property

    Property Get get_ig_saf_ram_sc
        get_ig_saf_ram_sc = read_ig_saf_ram_sc_value
    End Property

    Property Let set_ig_saf_ram_sc(aData)
        write_ig_saf_ram_sc_value = aData
        flag_ig_saf_ram_sc        = &H1
    End Property

    Property Get read_ig_saf_ram_sc
        read
        read_ig_saf_ram_sc = read_ig_saf_ram_sc_value
    End Property

    Property Let write_ig_saf_ram_sc(aData)
        set_ig_saf_ram_sc = aData
        write
    End Property

    Property Get get_ig_saf_ram_ec
        get_ig_saf_ram_ec = read_ig_saf_ram_ec_value
    End Property

    Property Let set_ig_saf_ram_ec(aData)
        write_ig_saf_ram_ec_value = aData
        flag_ig_saf_ram_ec        = &H1
    End Property

    Property Get read_ig_saf_ram_ec
        read
        read_ig_saf_ram_ec = read_ig_saf_ram_ec_value
    End Property

    Property Let write_ig_saf_ram_ec(aData)
        set_ig_saf_ram_ec = aData
        write
    End Property

    Property Get get_ig_saf_ram
        get_ig_saf_ram = read_ig_saf_ram_value
    End Property

    Property Let set_ig_saf_ram(aData)
        write_ig_saf_ram_value = aData
        flag_ig_saf_ram        = &H1
    End Property

    Property Get read_ig_saf_ram
        read
        read_ig_saf_ram = read_ig_saf_ram_value
    End Property

    Property Let write_ig_saf_ram(aData)
        set_ig_saf_ram = aData
        write
    End Property

    Property Get get_eg_trc_ram
        get_eg_trc_ram = read_eg_trc_ram_value
    End Property

    Property Let set_eg_trc_ram(aData)
        write_eg_trc_ram_value = aData
        flag_eg_trc_ram        = &H1
    End Property

    Property Get read_eg_trc_ram
        read
        read_eg_trc_ram = read_eg_trc_ram_value
    End Property

    Property Let write_eg_trc_ram(aData)
        set_eg_trc_ram = aData
        write
    End Property

    Property Get get_eg_stat_sa
        get_eg_stat_sa = read_eg_stat_sa_value
    End Property

    Property Let set_eg_stat_sa(aData)
        write_eg_stat_sa_value = aData
        flag_eg_stat_sa        = &H1
    End Property

    Property Get read_eg_stat_sa
        read
        read_eg_stat_sa = read_eg_stat_sa_value
    End Property

    Property Let write_eg_stat_sa(aData)
        set_eg_stat_sa = aData
        write
    End Property

    Property Get get_eg_stat_class
        get_eg_stat_class = read_eg_stat_class_value
    End Property

    Property Let set_eg_stat_class(aData)
        write_eg_stat_class_value = aData
        flag_eg_stat_class        = &H1
    End Property

    Property Get read_eg_stat_class
        read
        read_eg_stat_class = read_eg_stat_class_value
    End Property

    Property Let write_eg_stat_class(aData)
        set_eg_stat_class = aData
        write
    End Property

    Property Get get_eg_stat_vport
        get_eg_stat_vport = read_eg_stat_vport_value
    End Property

    Property Let set_eg_stat_vport(aData)
        write_eg_stat_vport_value = aData
        flag_eg_stat_vport        = &H1
    End Property

    Property Get read_eg_stat_vport
        read
        read_eg_stat_vport = read_eg_stat_vport_value
    End Property

    Property Let write_eg_stat_vport(aData)
        set_eg_stat_vport = aData
        write
    End Property

    Property Get get_eg_saf_ram_sc
        get_eg_saf_ram_sc = read_eg_saf_ram_sc_value
    End Property

    Property Let set_eg_saf_ram_sc(aData)
        write_eg_saf_ram_sc_value = aData
        flag_eg_saf_ram_sc        = &H1
    End Property

    Property Get read_eg_saf_ram_sc
        read
        read_eg_saf_ram_sc = read_eg_saf_ram_sc_value
    End Property

    Property Let write_eg_saf_ram_sc(aData)
        set_eg_saf_ram_sc = aData
        write
    End Property

    Property Get get_eg_saf_ram_ec
        get_eg_saf_ram_ec = read_eg_saf_ram_ec_value
    End Property

    Property Let set_eg_saf_ram_ec(aData)
        write_eg_saf_ram_ec_value = aData
        flag_eg_saf_ram_ec        = &H1
    End Property

    Property Get read_eg_saf_ram_ec
        read
        read_eg_saf_ram_ec = read_eg_saf_ram_ec_value
    End Property

    Property Let write_eg_saf_ram_ec(aData)
        set_eg_saf_ram_ec = aData
        write
    End Property

    Property Get get_eg_saf_ram
        get_eg_saf_ram = read_eg_saf_ram_value
    End Property

    Property Let set_eg_saf_ram(aData)
        write_eg_saf_ram_value = aData
        flag_eg_saf_ram        = &H1
    End Property

    Property Get read_eg_saf_ram
        read
        read_eg_saf_ram = read_eg_saf_ram_value
    End Property

    Property Let write_eg_saf_ram(aData)
        set_eg_saf_ram = aData
        write
    End Property

    Property Get get_redir_debug
        get_redir_debug = read_redir_debug_value
    End Property

    Property Let set_redir_debug(aData)
        write_redir_debug_value = aData
        flag_redir_debug        = &H1
    End Property

    Property Get read_redir_debug
        read
        read_redir_debug = read_redir_debug_value
    End Property

    Property Let write_redir_debug(aData)
        set_redir_debug = aData
        write
    End Property

    Property Get get_ig_capt_debug
        get_ig_capt_debug = read_ig_capt_debug_value
    End Property

    Property Let set_ig_capt_debug(aData)
        write_ig_capt_debug_value = aData
        flag_ig_capt_debug        = &H1
    End Property

    Property Get read_ig_capt_debug
        read
        read_ig_capt_debug = read_ig_capt_debug_value
    End Property

    Property Let write_ig_capt_debug(aData)
        set_ig_capt_debug = aData
        write
    End Property

    Property Get get_eg_capt_debug
        get_eg_capt_debug = read_eg_capt_debug_value
    End Property

    Property Let set_eg_capt_debug(aData)
        write_eg_capt_debug_value = aData
        flag_eg_capt_debug        = &H1
    End Property

    Property Get read_eg_capt_debug
        read
        read_eg_capt_debug = read_eg_capt_debug_value
    End Property

    Property Let write_eg_capt_debug(aData)
        set_eg_capt_debug = aData
        write
    End Property

    Property Get get_ig_tcam_ram
        get_ig_tcam_ram = read_ig_tcam_ram_value
    End Property

    Property Let set_ig_tcam_ram(aData)
        write_ig_tcam_ram_value = aData
        flag_ig_tcam_ram        = &H1
    End Property

    Property Get read_ig_tcam_ram
        read
        read_ig_tcam_ram = read_ig_tcam_ram_value
    End Property

    Property Let write_ig_tcam_ram(aData)
        set_ig_tcam_ram = aData
        write
    End Property

    Property Get get_eg_tcam_ram
        get_eg_tcam_ram = read_eg_tcam_ram_value
    End Property

    Property Let set_eg_tcam_ram(aData)
        write_eg_tcam_ram_value = aData
        flag_eg_tcam_ram        = &H1
    End Property

    Property Get read_eg_tcam_ram
        read
        read_eg_tcam_ram = read_eg_tcam_ram_value
    End Property

    Property Let write_eg_tcam_ram(aData)
        set_eg_tcam_ram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ig_trc_ram_mask = &H1
        if data_low > LONG_MAX then
            if ig_trc_ram_mask = mask then
                read_ig_trc_ram_value = data_low
            else
                read_ig_trc_ram_value = (data_low - H8000_0000) and ig_trc_ram_mask
            end If
        else
            read_ig_trc_ram_value = data_low and ig_trc_ram_mask
        end If
        read_ig_stat_sa_value = rightShift(data_low, 1) and &H1
        read_ig_stat_class_value = rightShift(data_low, 2) and &H1
        read_ig_stat_vport_value = rightShift(data_low, 3) and &H1
        read_ig_saf_ram_sc_value = rightShift(data_low, 4) and &H1
        read_ig_saf_ram_ec_value = rightShift(data_low, 5) and &H1
        read_ig_saf_ram_value = rightShift(data_low, 6) and &H1
        read_eg_trc_ram_value = rightShift(data_low, 7) and &H1
        read_eg_stat_sa_value = rightShift(data_low, 8) and &H1
        read_eg_stat_class_value = rightShift(data_low, 9) and &H1
        read_eg_stat_vport_value = rightShift(data_low, 10) and &H1
        read_eg_saf_ram_sc_value = rightShift(data_low, 11) and &H1
        read_eg_saf_ram_ec_value = rightShift(data_low, 12) and &H1
        read_eg_saf_ram_value = rightShift(data_low, 13) and &H1
        read_redir_debug_value = rightShift(data_low, 14) and &H1
        read_ig_capt_debug_value = rightShift(data_low, 15) and &H1
        read_eg_capt_debug_value = rightShift(data_low, 16) and &H1
        read_ig_tcam_ram_value = rightShift(data_low, 17) and &H1
        read_eg_tcam_ram_value = rightShift(data_low, 18) and &H1

    End Sub

    Sub write
        If flag_ig_trc_ram = &H0 or flag_ig_stat_sa = &H0 or flag_ig_stat_class = &H0 or flag_ig_stat_vport = &H0 or flag_ig_saf_ram_sc = &H0 or flag_ig_saf_ram_ec = &H0 or flag_ig_saf_ram = &H0 or flag_eg_trc_ram = &H0 or flag_eg_stat_sa = &H0 or flag_eg_stat_class = &H0 or flag_eg_stat_vport = &H0 or flag_eg_saf_ram_sc = &H0 or flag_eg_saf_ram_ec = &H0 or flag_eg_saf_ram = &H0 or flag_redir_debug = &H0 or flag_ig_capt_debug = &H0 or flag_eg_capt_debug = &H0 or flag_ig_tcam_ram = &H0 or flag_eg_tcam_ram = &H0 Then read
        If flag_ig_trc_ram = &H0 Then write_ig_trc_ram_value = get_ig_trc_ram
        If flag_ig_stat_sa = &H0 Then write_ig_stat_sa_value = get_ig_stat_sa
        If flag_ig_stat_class = &H0 Then write_ig_stat_class_value = get_ig_stat_class
        If flag_ig_stat_vport = &H0 Then write_ig_stat_vport_value = get_ig_stat_vport
        If flag_ig_saf_ram_sc = &H0 Then write_ig_saf_ram_sc_value = get_ig_saf_ram_sc
        If flag_ig_saf_ram_ec = &H0 Then write_ig_saf_ram_ec_value = get_ig_saf_ram_ec
        If flag_ig_saf_ram = &H0 Then write_ig_saf_ram_value = get_ig_saf_ram
        If flag_eg_trc_ram = &H0 Then write_eg_trc_ram_value = get_eg_trc_ram
        If flag_eg_stat_sa = &H0 Then write_eg_stat_sa_value = get_eg_stat_sa
        If flag_eg_stat_class = &H0 Then write_eg_stat_class_value = get_eg_stat_class
        If flag_eg_stat_vport = &H0 Then write_eg_stat_vport_value = get_eg_stat_vport
        If flag_eg_saf_ram_sc = &H0 Then write_eg_saf_ram_sc_value = get_eg_saf_ram_sc
        If flag_eg_saf_ram_ec = &H0 Then write_eg_saf_ram_ec_value = get_eg_saf_ram_ec
        If flag_eg_saf_ram = &H0 Then write_eg_saf_ram_value = get_eg_saf_ram
        If flag_redir_debug = &H0 Then write_redir_debug_value = get_redir_debug
        If flag_ig_capt_debug = &H0 Then write_ig_capt_debug_value = get_ig_capt_debug
        If flag_eg_capt_debug = &H0 Then write_eg_capt_debug_value = get_eg_capt_debug
        If flag_ig_tcam_ram = &H0 Then write_ig_tcam_ram_value = get_ig_tcam_ram
        If flag_eg_tcam_ram = &H0 Then write_eg_tcam_ram_value = get_eg_tcam_ram

        regValue = leftShift((write_ig_trc_ram_value and &H1), 0) + leftShift((write_ig_stat_sa_value and &H1), 1) + leftShift((write_ig_stat_class_value and &H1), 2) + leftShift((write_ig_stat_vport_value and &H1), 3) + leftShift((write_ig_saf_ram_sc_value and &H1), 4) + leftShift((write_ig_saf_ram_ec_value and &H1), 5) + leftShift((write_ig_saf_ram_value and &H1), 6) + leftShift((write_eg_trc_ram_value and &H1), 7) + leftShift((write_eg_stat_sa_value and &H1), 8) + leftShift((write_eg_stat_class_value and &H1), 9) + leftShift((write_eg_stat_vport_value and &H1), 10) + leftShift((write_eg_saf_ram_sc_value and &H1), 11) + leftShift((write_eg_saf_ram_ec_value and &H1), 12) + leftShift((write_eg_saf_ram_value and &H1), 13) + leftShift((write_redir_debug_value and &H1), 14) + leftShift((write_ig_capt_debug_value and &H1), 15) + leftShift((write_eg_capt_debug_value and &H1), 16) + leftShift((write_ig_tcam_ram_value and &H1), 17) + leftShift((write_eg_tcam_ram_value and &H1), 18)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ig_trc_ram_mask = &H1
        if data_low > LONG_MAX then
            if ig_trc_ram_mask = mask then
                read_ig_trc_ram_value = data_low
            else
                read_ig_trc_ram_value = (data_low - H8000_0000) and ig_trc_ram_mask
            end If
        else
            read_ig_trc_ram_value = data_low and ig_trc_ram_mask
        end If
        read_ig_stat_sa_value = rightShift(data_low, 1) and &H1
        read_ig_stat_class_value = rightShift(data_low, 2) and &H1
        read_ig_stat_vport_value = rightShift(data_low, 3) and &H1
        read_ig_saf_ram_sc_value = rightShift(data_low, 4) and &H1
        read_ig_saf_ram_ec_value = rightShift(data_low, 5) and &H1
        read_ig_saf_ram_value = rightShift(data_low, 6) and &H1
        read_eg_trc_ram_value = rightShift(data_low, 7) and &H1
        read_eg_stat_sa_value = rightShift(data_low, 8) and &H1
        read_eg_stat_class_value = rightShift(data_low, 9) and &H1
        read_eg_stat_vport_value = rightShift(data_low, 10) and &H1
        read_eg_saf_ram_sc_value = rightShift(data_low, 11) and &H1
        read_eg_saf_ram_ec_value = rightShift(data_low, 12) and &H1
        read_eg_saf_ram_value = rightShift(data_low, 13) and &H1
        read_redir_debug_value = rightShift(data_low, 14) and &H1
        read_ig_capt_debug_value = rightShift(data_low, 15) and &H1
        read_eg_capt_debug_value = rightShift(data_low, 16) and &H1
        read_ig_tcam_ram_value = rightShift(data_low, 17) and &H1
        read_eg_tcam_ram_value = rightShift(data_low, 18) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ig_trc_ram_value = &H0
        flag_ig_trc_ram        = &H0
        write_ig_stat_sa_value = &H0
        flag_ig_stat_sa        = &H0
        write_ig_stat_class_value = &H0
        flag_ig_stat_class        = &H0
        write_ig_stat_vport_value = &H0
        flag_ig_stat_vport        = &H0
        write_ig_saf_ram_sc_value = &H0
        flag_ig_saf_ram_sc        = &H0
        write_ig_saf_ram_ec_value = &H0
        flag_ig_saf_ram_ec        = &H0
        write_ig_saf_ram_value = &H0
        flag_ig_saf_ram        = &H0
        write_eg_trc_ram_value = &H0
        flag_eg_trc_ram        = &H0
        write_eg_stat_sa_value = &H0
        flag_eg_stat_sa        = &H0
        write_eg_stat_class_value = &H0
        flag_eg_stat_class        = &H0
        write_eg_stat_vport_value = &H0
        flag_eg_stat_vport        = &H0
        write_eg_saf_ram_sc_value = &H0
        flag_eg_saf_ram_sc        = &H0
        write_eg_saf_ram_ec_value = &H0
        flag_eg_saf_ram_ec        = &H0
        write_eg_saf_ram_value = &H0
        flag_eg_saf_ram        = &H0
        write_redir_debug_value = &H0
        flag_redir_debug        = &H0
        write_ig_capt_debug_value = &H0
        flag_ig_capt_debug        = &H0
        write_eg_capt_debug_value = &H0
        flag_eg_capt_debug        = &H0
        write_ig_tcam_ram_value = &H0
        flag_ig_tcam_ram        = &H0
        write_eg_tcam_ram_value = &H0
        flag_eg_tcam_ram        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_165S_32_BRCM_EIP_165_ECC_ecc_uncorrected_flags
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ig_trc_ram                                 [0:0]            get_ig_trc_ram
''                                                             set_ig_trc_ram
''                                                             read_ig_trc_ram
''                                                             write_ig_trc_ram
''---------------------------------------------------------------------------------
'' ig_stat_sa                                 [1:1]            get_ig_stat_sa
''                                                             set_ig_stat_sa
''                                                             read_ig_stat_sa
''                                                             write_ig_stat_sa
''---------------------------------------------------------------------------------
'' ig_stat_class                              [2:2]            get_ig_stat_class
''                                                             set_ig_stat_class
''                                                             read_ig_stat_class
''                                                             write_ig_stat_class
''---------------------------------------------------------------------------------
'' ig_stat_vport                              [3:3]            get_ig_stat_vport
''                                                             set_ig_stat_vport
''                                                             read_ig_stat_vport
''                                                             write_ig_stat_vport
''---------------------------------------------------------------------------------
'' ig_saf_ram_sc                              [4:4]            get_ig_saf_ram_sc
''                                                             set_ig_saf_ram_sc
''                                                             read_ig_saf_ram_sc
''                                                             write_ig_saf_ram_sc
''---------------------------------------------------------------------------------
'' ig_saf_ram_ec                              [5:5]            get_ig_saf_ram_ec
''                                                             set_ig_saf_ram_ec
''                                                             read_ig_saf_ram_ec
''                                                             write_ig_saf_ram_ec
''---------------------------------------------------------------------------------
'' ig_saf_ram                                 [6:6]            get_ig_saf_ram
''                                                             set_ig_saf_ram
''                                                             read_ig_saf_ram
''                                                             write_ig_saf_ram
''---------------------------------------------------------------------------------
'' eg_trc_ram                                 [7:7]            get_eg_trc_ram
''                                                             set_eg_trc_ram
''                                                             read_eg_trc_ram
''                                                             write_eg_trc_ram
''---------------------------------------------------------------------------------
'' eg_stat_sa                                 [8:8]            get_eg_stat_sa
''                                                             set_eg_stat_sa
''                                                             read_eg_stat_sa
''                                                             write_eg_stat_sa
''---------------------------------------------------------------------------------
'' eg_stat_class                              [9:9]            get_eg_stat_class
''                                                             set_eg_stat_class
''                                                             read_eg_stat_class
''                                                             write_eg_stat_class
''---------------------------------------------------------------------------------
'' eg_stat_vport                              [10:10]          get_eg_stat_vport
''                                                             set_eg_stat_vport
''                                                             read_eg_stat_vport
''                                                             write_eg_stat_vport
''---------------------------------------------------------------------------------
'' eg_saf_ram_sc                              [11:11]          get_eg_saf_ram_sc
''                                                             set_eg_saf_ram_sc
''                                                             read_eg_saf_ram_sc
''                                                             write_eg_saf_ram_sc
''---------------------------------------------------------------------------------
'' eg_saf_ram_ec                              [12:12]          get_eg_saf_ram_ec
''                                                             set_eg_saf_ram_ec
''                                                             read_eg_saf_ram_ec
''                                                             write_eg_saf_ram_ec
''---------------------------------------------------------------------------------
'' eg_saf_ram                                 [13:13]          get_eg_saf_ram
''                                                             set_eg_saf_ram
''                                                             read_eg_saf_ram
''                                                             write_eg_saf_ram
''---------------------------------------------------------------------------------
'' redir_debug                                [14:14]          get_redir_debug
''                                                             set_redir_debug
''                                                             read_redir_debug
''                                                             write_redir_debug
''---------------------------------------------------------------------------------
'' ig_capt_debug                              [15:15]          get_ig_capt_debug
''                                                             set_ig_capt_debug
''                                                             read_ig_capt_debug
''                                                             write_ig_capt_debug
''---------------------------------------------------------------------------------
'' eg_capt_debug                              [16:16]          get_eg_capt_debug
''                                                             set_eg_capt_debug
''                                                             read_eg_capt_debug
''                                                             write_eg_capt_debug
''---------------------------------------------------------------------------------
'' ig_tcam_ram                                [17:17]          get_ig_tcam_ram
''                                                             set_ig_tcam_ram
''                                                             read_ig_tcam_ram
''                                                             write_ig_tcam_ram
''---------------------------------------------------------------------------------
'' eg_tcam_ram                                [18:18]          get_eg_tcam_ram
''                                                             set_eg_tcam_ram
''                                                             read_eg_tcam_ram
''                                                             write_eg_tcam_ram
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_165S_32_BRCM_EIP_165_ECC_ecc_uncorrected_flags
    Private write_ig_trc_ram_value
    Private read_ig_trc_ram_value
    Private flag_ig_trc_ram
    Private write_ig_stat_sa_value
    Private read_ig_stat_sa_value
    Private flag_ig_stat_sa
    Private write_ig_stat_class_value
    Private read_ig_stat_class_value
    Private flag_ig_stat_class
    Private write_ig_stat_vport_value
    Private read_ig_stat_vport_value
    Private flag_ig_stat_vport
    Private write_ig_saf_ram_sc_value
    Private read_ig_saf_ram_sc_value
    Private flag_ig_saf_ram_sc
    Private write_ig_saf_ram_ec_value
    Private read_ig_saf_ram_ec_value
    Private flag_ig_saf_ram_ec
    Private write_ig_saf_ram_value
    Private read_ig_saf_ram_value
    Private flag_ig_saf_ram
    Private write_eg_trc_ram_value
    Private read_eg_trc_ram_value
    Private flag_eg_trc_ram
    Private write_eg_stat_sa_value
    Private read_eg_stat_sa_value
    Private flag_eg_stat_sa
    Private write_eg_stat_class_value
    Private read_eg_stat_class_value
    Private flag_eg_stat_class
    Private write_eg_stat_vport_value
    Private read_eg_stat_vport_value
    Private flag_eg_stat_vport
    Private write_eg_saf_ram_sc_value
    Private read_eg_saf_ram_sc_value
    Private flag_eg_saf_ram_sc
    Private write_eg_saf_ram_ec_value
    Private read_eg_saf_ram_ec_value
    Private flag_eg_saf_ram_ec
    Private write_eg_saf_ram_value
    Private read_eg_saf_ram_value
    Private flag_eg_saf_ram
    Private write_redir_debug_value
    Private read_redir_debug_value
    Private flag_redir_debug
    Private write_ig_capt_debug_value
    Private read_ig_capt_debug_value
    Private flag_ig_capt_debug
    Private write_eg_capt_debug_value
    Private read_eg_capt_debug_value
    Private flag_eg_capt_debug
    Private write_ig_tcam_ram_value
    Private read_ig_tcam_ram_value
    Private flag_ig_tcam_ram
    Private write_eg_tcam_ram_value
    Private read_eg_tcam_ram_value
    Private flag_eg_tcam_ram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H20d04
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ig_trc_ram
        get_ig_trc_ram = read_ig_trc_ram_value
    End Property

    Property Let set_ig_trc_ram(aData)
        write_ig_trc_ram_value = aData
        flag_ig_trc_ram        = &H1
    End Property

    Property Get read_ig_trc_ram
        read
        read_ig_trc_ram = read_ig_trc_ram_value
    End Property

    Property Let write_ig_trc_ram(aData)
        set_ig_trc_ram = aData
        write
    End Property

    Property Get get_ig_stat_sa
        get_ig_stat_sa = read_ig_stat_sa_value
    End Property

    Property Let set_ig_stat_sa(aData)
        write_ig_stat_sa_value = aData
        flag_ig_stat_sa        = &H1
    End Property

    Property Get read_ig_stat_sa
        read
        read_ig_stat_sa = read_ig_stat_sa_value
    End Property

    Property Let write_ig_stat_sa(aData)
        set_ig_stat_sa = aData
        write
    End Property

    Property Get get_ig_stat_class
        get_ig_stat_class = read_ig_stat_class_value
    End Property

    Property Let set_ig_stat_class(aData)
        write_ig_stat_class_value = aData
        flag_ig_stat_class        = &H1
    End Property

    Property Get read_ig_stat_class
        read
        read_ig_stat_class = read_ig_stat_class_value
    End Property

    Property Let write_ig_stat_class(aData)
        set_ig_stat_class = aData
        write
    End Property

    Property Get get_ig_stat_vport
        get_ig_stat_vport = read_ig_stat_vport_value
    End Property

    Property Let set_ig_stat_vport(aData)
        write_ig_stat_vport_value = aData
        flag_ig_stat_vport        = &H1
    End Property

    Property Get read_ig_stat_vport
        read
        read_ig_stat_vport = read_ig_stat_vport_value
    End Property

    Property Let write_ig_stat_vport(aData)
        set_ig_stat_vport = aData
        write
    End Property

    Property Get get_ig_saf_ram_sc
        get_ig_saf_ram_sc = read_ig_saf_ram_sc_value
    End Property

    Property Let set_ig_saf_ram_sc(aData)
        write_ig_saf_ram_sc_value = aData
        flag_ig_saf_ram_sc        = &H1
    End Property

    Property Get read_ig_saf_ram_sc
        read
        read_ig_saf_ram_sc = read_ig_saf_ram_sc_value
    End Property

    Property Let write_ig_saf_ram_sc(aData)
        set_ig_saf_ram_sc = aData
        write
    End Property

    Property Get get_ig_saf_ram_ec
        get_ig_saf_ram_ec = read_ig_saf_ram_ec_value
    End Property

    Property Let set_ig_saf_ram_ec(aData)
        write_ig_saf_ram_ec_value = aData
        flag_ig_saf_ram_ec        = &H1
    End Property

    Property Get read_ig_saf_ram_ec
        read
        read_ig_saf_ram_ec = read_ig_saf_ram_ec_value
    End Property

    Property Let write_ig_saf_ram_ec(aData)
        set_ig_saf_ram_ec = aData
        write
    End Property

    Property Get get_ig_saf_ram
        get_ig_saf_ram = read_ig_saf_ram_value
    End Property

    Property Let set_ig_saf_ram(aData)
        write_ig_saf_ram_value = aData
        flag_ig_saf_ram        = &H1
    End Property

    Property Get read_ig_saf_ram
        read
        read_ig_saf_ram = read_ig_saf_ram_value
    End Property

    Property Let write_ig_saf_ram(aData)
        set_ig_saf_ram = aData
        write
    End Property

    Property Get get_eg_trc_ram
        get_eg_trc_ram = read_eg_trc_ram_value
    End Property

    Property Let set_eg_trc_ram(aData)
        write_eg_trc_ram_value = aData
        flag_eg_trc_ram        = &H1
    End Property

    Property Get read_eg_trc_ram
        read
        read_eg_trc_ram = read_eg_trc_ram_value
    End Property

    Property Let write_eg_trc_ram(aData)
        set_eg_trc_ram = aData
        write
    End Property

    Property Get get_eg_stat_sa
        get_eg_stat_sa = read_eg_stat_sa_value
    End Property

    Property Let set_eg_stat_sa(aData)
        write_eg_stat_sa_value = aData
        flag_eg_stat_sa        = &H1
    End Property

    Property Get read_eg_stat_sa
        read
        read_eg_stat_sa = read_eg_stat_sa_value
    End Property

    Property Let write_eg_stat_sa(aData)
        set_eg_stat_sa = aData
        write
    End Property

    Property Get get_eg_stat_class
        get_eg_stat_class = read_eg_stat_class_value
    End Property

    Property Let set_eg_stat_class(aData)
        write_eg_stat_class_value = aData
        flag_eg_stat_class        = &H1
    End Property

    Property Get read_eg_stat_class
        read
        read_eg_stat_class = read_eg_stat_class_value
    End Property

    Property Let write_eg_stat_class(aData)
        set_eg_stat_class = aData
        write
    End Property

    Property Get get_eg_stat_vport
        get_eg_stat_vport = read_eg_stat_vport_value
    End Property

    Property Let set_eg_stat_vport(aData)
        write_eg_stat_vport_value = aData
        flag_eg_stat_vport        = &H1
    End Property

    Property Get read_eg_stat_vport
        read
        read_eg_stat_vport = read_eg_stat_vport_value
    End Property

    Property Let write_eg_stat_vport(aData)
        set_eg_stat_vport = aData
        write
    End Property

    Property Get get_eg_saf_ram_sc
        get_eg_saf_ram_sc = read_eg_saf_ram_sc_value
    End Property

    Property Let set_eg_saf_ram_sc(aData)
        write_eg_saf_ram_sc_value = aData
        flag_eg_saf_ram_sc        = &H1
    End Property

    Property Get read_eg_saf_ram_sc
        read
        read_eg_saf_ram_sc = read_eg_saf_ram_sc_value
    End Property

    Property Let write_eg_saf_ram_sc(aData)
        set_eg_saf_ram_sc = aData
        write
    End Property

    Property Get get_eg_saf_ram_ec
        get_eg_saf_ram_ec = read_eg_saf_ram_ec_value
    End Property

    Property Let set_eg_saf_ram_ec(aData)
        write_eg_saf_ram_ec_value = aData
        flag_eg_saf_ram_ec        = &H1
    End Property

    Property Get read_eg_saf_ram_ec
        read
        read_eg_saf_ram_ec = read_eg_saf_ram_ec_value
    End Property

    Property Let write_eg_saf_ram_ec(aData)
        set_eg_saf_ram_ec = aData
        write
    End Property

    Property Get get_eg_saf_ram
        get_eg_saf_ram = read_eg_saf_ram_value
    End Property

    Property Let set_eg_saf_ram(aData)
        write_eg_saf_ram_value = aData
        flag_eg_saf_ram        = &H1
    End Property

    Property Get read_eg_saf_ram
        read
        read_eg_saf_ram = read_eg_saf_ram_value
    End Property

    Property Let write_eg_saf_ram(aData)
        set_eg_saf_ram = aData
        write
    End Property

    Property Get get_redir_debug
        get_redir_debug = read_redir_debug_value
    End Property

    Property Let set_redir_debug(aData)
        write_redir_debug_value = aData
        flag_redir_debug        = &H1
    End Property

    Property Get read_redir_debug
        read
        read_redir_debug = read_redir_debug_value
    End Property

    Property Let write_redir_debug(aData)
        set_redir_debug = aData
        write
    End Property

    Property Get get_ig_capt_debug
        get_ig_capt_debug = read_ig_capt_debug_value
    End Property

    Property Let set_ig_capt_debug(aData)
        write_ig_capt_debug_value = aData
        flag_ig_capt_debug        = &H1
    End Property

    Property Get read_ig_capt_debug
        read
        read_ig_capt_debug = read_ig_capt_debug_value
    End Property

    Property Let write_ig_capt_debug(aData)
        set_ig_capt_debug = aData
        write
    End Property

    Property Get get_eg_capt_debug
        get_eg_capt_debug = read_eg_capt_debug_value
    End Property

    Property Let set_eg_capt_debug(aData)
        write_eg_capt_debug_value = aData
        flag_eg_capt_debug        = &H1
    End Property

    Property Get read_eg_capt_debug
        read
        read_eg_capt_debug = read_eg_capt_debug_value
    End Property

    Property Let write_eg_capt_debug(aData)
        set_eg_capt_debug = aData
        write
    End Property

    Property Get get_ig_tcam_ram
        get_ig_tcam_ram = read_ig_tcam_ram_value
    End Property

    Property Let set_ig_tcam_ram(aData)
        write_ig_tcam_ram_value = aData
        flag_ig_tcam_ram        = &H1
    End Property

    Property Get read_ig_tcam_ram
        read
        read_ig_tcam_ram = read_ig_tcam_ram_value
    End Property

    Property Let write_ig_tcam_ram(aData)
        set_ig_tcam_ram = aData
        write
    End Property

    Property Get get_eg_tcam_ram
        get_eg_tcam_ram = read_eg_tcam_ram_value
    End Property

    Property Let set_eg_tcam_ram(aData)
        write_eg_tcam_ram_value = aData
        flag_eg_tcam_ram        = &H1
    End Property

    Property Get read_eg_tcam_ram
        read
        read_eg_tcam_ram = read_eg_tcam_ram_value
    End Property

    Property Let write_eg_tcam_ram(aData)
        set_eg_tcam_ram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ig_trc_ram_mask = &H1
        if data_low > LONG_MAX then
            if ig_trc_ram_mask = mask then
                read_ig_trc_ram_value = data_low
            else
                read_ig_trc_ram_value = (data_low - H8000_0000) and ig_trc_ram_mask
            end If
        else
            read_ig_trc_ram_value = data_low and ig_trc_ram_mask
        end If
        read_ig_stat_sa_value = rightShift(data_low, 1) and &H1
        read_ig_stat_class_value = rightShift(data_low, 2) and &H1
        read_ig_stat_vport_value = rightShift(data_low, 3) and &H1
        read_ig_saf_ram_sc_value = rightShift(data_low, 4) and &H1
        read_ig_saf_ram_ec_value = rightShift(data_low, 5) and &H1
        read_ig_saf_ram_value = rightShift(data_low, 6) and &H1
        read_eg_trc_ram_value = rightShift(data_low, 7) and &H1
        read_eg_stat_sa_value = rightShift(data_low, 8) and &H1
        read_eg_stat_class_value = rightShift(data_low, 9) and &H1
        read_eg_stat_vport_value = rightShift(data_low, 10) and &H1
        read_eg_saf_ram_sc_value = rightShift(data_low, 11) and &H1
        read_eg_saf_ram_ec_value = rightShift(data_low, 12) and &H1
        read_eg_saf_ram_value = rightShift(data_low, 13) and &H1
        read_redir_debug_value = rightShift(data_low, 14) and &H1
        read_ig_capt_debug_value = rightShift(data_low, 15) and &H1
        read_eg_capt_debug_value = rightShift(data_low, 16) and &H1
        read_ig_tcam_ram_value = rightShift(data_low, 17) and &H1
        read_eg_tcam_ram_value = rightShift(data_low, 18) and &H1

    End Sub

    Sub write
        If flag_ig_trc_ram = &H0 or flag_ig_stat_sa = &H0 or flag_ig_stat_class = &H0 or flag_ig_stat_vport = &H0 or flag_ig_saf_ram_sc = &H0 or flag_ig_saf_ram_ec = &H0 or flag_ig_saf_ram = &H0 or flag_eg_trc_ram = &H0 or flag_eg_stat_sa = &H0 or flag_eg_stat_class = &H0 or flag_eg_stat_vport = &H0 or flag_eg_saf_ram_sc = &H0 or flag_eg_saf_ram_ec = &H0 or flag_eg_saf_ram = &H0 or flag_redir_debug = &H0 or flag_ig_capt_debug = &H0 or flag_eg_capt_debug = &H0 or flag_ig_tcam_ram = &H0 or flag_eg_tcam_ram = &H0 Then read
        If flag_ig_trc_ram = &H0 Then write_ig_trc_ram_value = get_ig_trc_ram
        If flag_ig_stat_sa = &H0 Then write_ig_stat_sa_value = get_ig_stat_sa
        If flag_ig_stat_class = &H0 Then write_ig_stat_class_value = get_ig_stat_class
        If flag_ig_stat_vport = &H0 Then write_ig_stat_vport_value = get_ig_stat_vport
        If flag_ig_saf_ram_sc = &H0 Then write_ig_saf_ram_sc_value = get_ig_saf_ram_sc
        If flag_ig_saf_ram_ec = &H0 Then write_ig_saf_ram_ec_value = get_ig_saf_ram_ec
        If flag_ig_saf_ram = &H0 Then write_ig_saf_ram_value = get_ig_saf_ram
        If flag_eg_trc_ram = &H0 Then write_eg_trc_ram_value = get_eg_trc_ram
        If flag_eg_stat_sa = &H0 Then write_eg_stat_sa_value = get_eg_stat_sa
        If flag_eg_stat_class = &H0 Then write_eg_stat_class_value = get_eg_stat_class
        If flag_eg_stat_vport = &H0 Then write_eg_stat_vport_value = get_eg_stat_vport
        If flag_eg_saf_ram_sc = &H0 Then write_eg_saf_ram_sc_value = get_eg_saf_ram_sc
        If flag_eg_saf_ram_ec = &H0 Then write_eg_saf_ram_ec_value = get_eg_saf_ram_ec
        If flag_eg_saf_ram = &H0 Then write_eg_saf_ram_value = get_eg_saf_ram
        If flag_redir_debug = &H0 Then write_redir_debug_value = get_redir_debug
        If flag_ig_capt_debug = &H0 Then write_ig_capt_debug_value = get_ig_capt_debug
        If flag_eg_capt_debug = &H0 Then write_eg_capt_debug_value = get_eg_capt_debug
        If flag_ig_tcam_ram = &H0 Then write_ig_tcam_ram_value = get_ig_tcam_ram
        If flag_eg_tcam_ram = &H0 Then write_eg_tcam_ram_value = get_eg_tcam_ram

        regValue = leftShift((write_ig_trc_ram_value and &H1), 0) + leftShift((write_ig_stat_sa_value and &H1), 1) + leftShift((write_ig_stat_class_value and &H1), 2) + leftShift((write_ig_stat_vport_value and &H1), 3) + leftShift((write_ig_saf_ram_sc_value and &H1), 4) + leftShift((write_ig_saf_ram_ec_value and &H1), 5) + leftShift((write_ig_saf_ram_value and &H1), 6) + leftShift((write_eg_trc_ram_value and &H1), 7) + leftShift((write_eg_stat_sa_value and &H1), 8) + leftShift((write_eg_stat_class_value and &H1), 9) + leftShift((write_eg_stat_vport_value and &H1), 10) + leftShift((write_eg_saf_ram_sc_value and &H1), 11) + leftShift((write_eg_saf_ram_ec_value and &H1), 12) + leftShift((write_eg_saf_ram_value and &H1), 13) + leftShift((write_redir_debug_value and &H1), 14) + leftShift((write_ig_capt_debug_value and &H1), 15) + leftShift((write_eg_capt_debug_value and &H1), 16) + leftShift((write_ig_tcam_ram_value and &H1), 17) + leftShift((write_eg_tcam_ram_value and &H1), 18)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ig_trc_ram_mask = &H1
        if data_low > LONG_MAX then
            if ig_trc_ram_mask = mask then
                read_ig_trc_ram_value = data_low
            else
                read_ig_trc_ram_value = (data_low - H8000_0000) and ig_trc_ram_mask
            end If
        else
            read_ig_trc_ram_value = data_low and ig_trc_ram_mask
        end If
        read_ig_stat_sa_value = rightShift(data_low, 1) and &H1
        read_ig_stat_class_value = rightShift(data_low, 2) and &H1
        read_ig_stat_vport_value = rightShift(data_low, 3) and &H1
        read_ig_saf_ram_sc_value = rightShift(data_low, 4) and &H1
        read_ig_saf_ram_ec_value = rightShift(data_low, 5) and &H1
        read_ig_saf_ram_value = rightShift(data_low, 6) and &H1
        read_eg_trc_ram_value = rightShift(data_low, 7) and &H1
        read_eg_stat_sa_value = rightShift(data_low, 8) and &H1
        read_eg_stat_class_value = rightShift(data_low, 9) and &H1
        read_eg_stat_vport_value = rightShift(data_low, 10) and &H1
        read_eg_saf_ram_sc_value = rightShift(data_low, 11) and &H1
        read_eg_saf_ram_ec_value = rightShift(data_low, 12) and &H1
        read_eg_saf_ram_value = rightShift(data_low, 13) and &H1
        read_redir_debug_value = rightShift(data_low, 14) and &H1
        read_ig_capt_debug_value = rightShift(data_low, 15) and &H1
        read_eg_capt_debug_value = rightShift(data_low, 16) and &H1
        read_ig_tcam_ram_value = rightShift(data_low, 17) and &H1
        read_eg_tcam_ram_value = rightShift(data_low, 18) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ig_trc_ram_value = &H0
        flag_ig_trc_ram        = &H0
        write_ig_stat_sa_value = &H0
        flag_ig_stat_sa        = &H0
        write_ig_stat_class_value = &H0
        flag_ig_stat_class        = &H0
        write_ig_stat_vport_value = &H0
        flag_ig_stat_vport        = &H0
        write_ig_saf_ram_sc_value = &H0
        flag_ig_saf_ram_sc        = &H0
        write_ig_saf_ram_ec_value = &H0
        flag_ig_saf_ram_ec        = &H0
        write_ig_saf_ram_value = &H0
        flag_ig_saf_ram        = &H0
        write_eg_trc_ram_value = &H0
        flag_eg_trc_ram        = &H0
        write_eg_stat_sa_value = &H0
        flag_eg_stat_sa        = &H0
        write_eg_stat_class_value = &H0
        flag_eg_stat_class        = &H0
        write_eg_stat_vport_value = &H0
        flag_eg_stat_vport        = &H0
        write_eg_saf_ram_sc_value = &H0
        flag_eg_saf_ram_sc        = &H0
        write_eg_saf_ram_ec_value = &H0
        flag_eg_saf_ram_ec        = &H0
        write_eg_saf_ram_value = &H0
        flag_eg_saf_ram        = &H0
        write_redir_debug_value = &H0
        flag_redir_debug        = &H0
        write_ig_capt_debug_value = &H0
        flag_ig_capt_debug        = &H0
        write_eg_capt_debug_value = &H0
        flag_eg_capt_debug        = &H0
        write_ig_tcam_ram_value = &H0
        flag_ig_tcam_ram        = &H0
        write_eg_tcam_ram_value = &H0
        flag_eg_tcam_ram        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_165S_32_BRCM_EIP_165_ECC_ecc_corrected_count
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' corrected_count                            [15:0]           get_corrected_count
''                                                             set_corrected_count
''                                                             read_corrected_count
''                                                             write_corrected_count
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_165S_32_BRCM_EIP_165_ECC_ecc_corrected_count
    Private write_corrected_count_value
    Private read_corrected_count_value
    Private flag_corrected_count

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H20d08
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_corrected_count
        get_corrected_count = read_corrected_count_value
    End Property

    Property Let set_corrected_count(aData)
        write_corrected_count_value = aData
        flag_corrected_count        = &H1
    End Property

    Property Get read_corrected_count
        read
        read_corrected_count = read_corrected_count_value
    End Property

    Property Let write_corrected_count(aData)
        set_corrected_count = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        corrected_count_mask = &Hffff
        if data_low > LONG_MAX then
            if corrected_count_mask = mask then
                read_corrected_count_value = data_low
            else
                read_corrected_count_value = (data_low - H8000_0000) and corrected_count_mask
            end If
        else
            read_corrected_count_value = data_low and corrected_count_mask
        end If

    End Sub

    Sub write
        If flag_corrected_count = &H0 Then read
        If flag_corrected_count = &H0 Then write_corrected_count_value = get_corrected_count

        regValue = leftShift((write_corrected_count_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        corrected_count_mask = &Hffff
        if data_low > LONG_MAX then
            if corrected_count_mask = mask then
                read_corrected_count_value = data_low
            else
                read_corrected_count_value = (data_low - H8000_0000) and corrected_count_mask
            end If
        else
            read_corrected_count_value = data_low and corrected_count_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_corrected_count_value = &H0
        flag_corrected_count        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_165S_32_BRCM_EIP_165_ECC_ecc_uncorrected_count
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' UNCO_COUN                                  [15:0]           get_UNCO_COUN
''                                                             set_UNCO_COUN
''                                                             read_UNCO_COUN
''                                                             write_UNCO_COUN
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_165S_32_BRCM_EIP_165_ECC_ecc_uncorrected_count
    Private write_UNCO_COUN_value
    Private read_UNCO_COUN_value
    Private flag_UNCO_COUN

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H20d0c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_UNCO_COUN
        get_UNCO_COUN = read_UNCO_COUN_value
    End Property

    Property Let set_UNCO_COUN(aData)
        write_UNCO_COUN_value = aData
        flag_UNCO_COUN        = &H1
    End Property

    Property Get read_UNCO_COUN
        read
        read_UNCO_COUN = read_UNCO_COUN_value
    End Property

    Property Let write_UNCO_COUN(aData)
        set_UNCO_COUN = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UNCO_COUN_mask = &Hffff
        if data_low > LONG_MAX then
            if UNCO_COUN_mask = mask then
                read_UNCO_COUN_value = data_low
            else
                read_UNCO_COUN_value = (data_low - H8000_0000) and UNCO_COUN_mask
            end If
        else
            read_UNCO_COUN_value = data_low and UNCO_COUN_mask
        end If

    End Sub

    Sub write
        If flag_UNCO_COUN = &H0 Then read
        If flag_UNCO_COUN = &H0 Then write_UNCO_COUN_value = get_UNCO_COUN

        regValue = leftShift((write_UNCO_COUN_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        UNCO_COUN_mask = &Hffff
        if data_low > LONG_MAX then
            if UNCO_COUN_mask = mask then
                read_UNCO_COUN_value = data_low
            else
                read_UNCO_COUN_value = (data_low - H8000_0000) and UNCO_COUN_mask
            end If
        else
            read_UNCO_COUN_value = data_low and UNCO_COUN_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_UNCO_COUN_value = &H0
        flag_UNCO_COUN        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_165S_32_BRCM_EIP_165_ECC_ecc_test_1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' IG_TRC_RAM                                 [0:0]            get_IG_TRC_RAM
''                                                             set_IG_TRC_RAM
''                                                             read_IG_TRC_RAM
''                                                             write_IG_TRC_RAM
''---------------------------------------------------------------------------------
'' IG_STAT_SA                                 [1:1]            get_IG_STAT_SA
''                                                             set_IG_STAT_SA
''                                                             read_IG_STAT_SA
''                                                             write_IG_STAT_SA
''---------------------------------------------------------------------------------
'' IG_STAT_CLAS                               [2:2]            get_IG_STAT_CLAS
''                                                             set_IG_STAT_CLAS
''                                                             read_IG_STAT_CLAS
''                                                             write_IG_STAT_CLAS
''---------------------------------------------------------------------------------
'' IG_STAT_VPOR                               [3:3]            get_IG_STAT_VPOR
''                                                             set_IG_STAT_VPOR
''                                                             read_IG_STAT_VPOR
''                                                             write_IG_STAT_VPOR
''---------------------------------------------------------------------------------
'' IG_SAF_SC_RAM                              [4:4]            get_IG_SAF_SC_RAM
''                                                             set_IG_SAF_SC_RAM
''                                                             read_IG_SAF_SC_RAM
''                                                             write_IG_SAF_SC_RAM
''---------------------------------------------------------------------------------
'' IG_SAF_EC_RAM                              [5:5]            get_IG_SAF_EC_RAM
''                                                             set_IG_SAF_EC_RAM
''                                                             read_IG_SAF_EC_RAM
''                                                             write_IG_SAF_EC_RAM
''---------------------------------------------------------------------------------
'' IG_SAF_RAM                                 [6:6]            get_IG_SAF_RAM
''                                                             set_IG_SAF_RAM
''                                                             read_IG_SAF_RAM
''                                                             write_IG_SAF_RAM
''---------------------------------------------------------------------------------
'' EG_TRC_RAM                                 [7:7]            get_EG_TRC_RAM
''                                                             set_EG_TRC_RAM
''                                                             read_EG_TRC_RAM
''                                                             write_EG_TRC_RAM
''---------------------------------------------------------------------------------
'' EG_STAT_SA                                 [8:8]            get_EG_STAT_SA
''                                                             set_EG_STAT_SA
''                                                             read_EG_STAT_SA
''                                                             write_EG_STAT_SA
''---------------------------------------------------------------------------------
'' EG_STAT_CLAS                               [9:9]            get_EG_STAT_CLAS
''                                                             set_EG_STAT_CLAS
''                                                             read_EG_STAT_CLAS
''                                                             write_EG_STAT_CLAS
''---------------------------------------------------------------------------------
'' EG_STAT_VPOR                               [10:10]          get_EG_STAT_VPOR
''                                                             set_EG_STAT_VPOR
''                                                             read_EG_STAT_VPOR
''                                                             write_EG_STAT_VPOR
''---------------------------------------------------------------------------------
'' EG_SAF_SC_RAM                              [11:11]          get_EG_SAF_SC_RAM
''                                                             set_EG_SAF_SC_RAM
''                                                             read_EG_SAF_SC_RAM
''                                                             write_EG_SAF_SC_RAM
''---------------------------------------------------------------------------------
'' EG_SAF_EC_RAM                              [12:12]          get_EG_SAF_EC_RAM
''                                                             set_EG_SAF_EC_RAM
''                                                             read_EG_SAF_EC_RAM
''                                                             write_EG_SAF_EC_RAM
''---------------------------------------------------------------------------------
'' EG_SAF_RAM                                 [13:13]          get_EG_SAF_RAM
''                                                             set_EG_SAF_RAM
''                                                             read_EG_SAF_RAM
''                                                             write_EG_SAF_RAM
''---------------------------------------------------------------------------------
'' REDIR_DEBUG                                [14:14]          get_REDIR_DEBUG
''                                                             set_REDIR_DEBUG
''                                                             read_REDIR_DEBUG
''                                                             write_REDIR_DEBUG
''---------------------------------------------------------------------------------
'' IG_CAPT_DEBU                               [15:15]          get_IG_CAPT_DEBU
''                                                             set_IG_CAPT_DEBU
''                                                             read_IG_CAPT_DEBU
''                                                             write_IG_CAPT_DEBU
''---------------------------------------------------------------------------------
'' EG_CAPT_DEBU                               [16:16]          get_EG_CAPT_DEBU
''                                                             set_EG_CAPT_DEBU
''                                                             read_EG_CAPT_DEBU
''                                                             write_EG_CAPT_DEBU
''---------------------------------------------------------------------------------
'' IG_TCAM_RAM                                [17:17]          get_IG_TCAM_RAM
''                                                             set_IG_TCAM_RAM
''                                                             read_IG_TCAM_RAM
''                                                             write_IG_TCAM_RAM
''---------------------------------------------------------------------------------
'' EG_TCAM_RAM                                [18:18]          get_EG_TCAM_RAM
''                                                             set_EG_TCAM_RAM
''                                                             read_EG_TCAM_RAM
''                                                             write_EG_TCAM_RAM
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_165S_32_BRCM_EIP_165_ECC_ecc_test_1
    Private write_IG_TRC_RAM_value
    Private read_IG_TRC_RAM_value
    Private flag_IG_TRC_RAM
    Private write_IG_STAT_SA_value
    Private read_IG_STAT_SA_value
    Private flag_IG_STAT_SA
    Private write_IG_STAT_CLAS_value
    Private read_IG_STAT_CLAS_value
    Private flag_IG_STAT_CLAS
    Private write_IG_STAT_VPOR_value
    Private read_IG_STAT_VPOR_value
    Private flag_IG_STAT_VPOR
    Private write_IG_SAF_SC_RAM_value
    Private read_IG_SAF_SC_RAM_value
    Private flag_IG_SAF_SC_RAM
    Private write_IG_SAF_EC_RAM_value
    Private read_IG_SAF_EC_RAM_value
    Private flag_IG_SAF_EC_RAM
    Private write_IG_SAF_RAM_value
    Private read_IG_SAF_RAM_value
    Private flag_IG_SAF_RAM
    Private write_EG_TRC_RAM_value
    Private read_EG_TRC_RAM_value
    Private flag_EG_TRC_RAM
    Private write_EG_STAT_SA_value
    Private read_EG_STAT_SA_value
    Private flag_EG_STAT_SA
    Private write_EG_STAT_CLAS_value
    Private read_EG_STAT_CLAS_value
    Private flag_EG_STAT_CLAS
    Private write_EG_STAT_VPOR_value
    Private read_EG_STAT_VPOR_value
    Private flag_EG_STAT_VPOR
    Private write_EG_SAF_SC_RAM_value
    Private read_EG_SAF_SC_RAM_value
    Private flag_EG_SAF_SC_RAM
    Private write_EG_SAF_EC_RAM_value
    Private read_EG_SAF_EC_RAM_value
    Private flag_EG_SAF_EC_RAM
    Private write_EG_SAF_RAM_value
    Private read_EG_SAF_RAM_value
    Private flag_EG_SAF_RAM
    Private write_REDIR_DEBUG_value
    Private read_REDIR_DEBUG_value
    Private flag_REDIR_DEBUG
    Private write_IG_CAPT_DEBU_value
    Private read_IG_CAPT_DEBU_value
    Private flag_IG_CAPT_DEBU
    Private write_EG_CAPT_DEBU_value
    Private read_EG_CAPT_DEBU_value
    Private flag_EG_CAPT_DEBU
    Private write_IG_TCAM_RAM_value
    Private read_IG_TCAM_RAM_value
    Private flag_IG_TCAM_RAM
    Private write_EG_TCAM_RAM_value
    Private read_EG_TCAM_RAM_value
    Private flag_EG_TCAM_RAM

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H20d10
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_IG_TRC_RAM
        get_IG_TRC_RAM = read_IG_TRC_RAM_value
    End Property

    Property Let set_IG_TRC_RAM(aData)
        write_IG_TRC_RAM_value = aData
        flag_IG_TRC_RAM        = &H1
    End Property

    Property Get read_IG_TRC_RAM
        read
        read_IG_TRC_RAM = read_IG_TRC_RAM_value
    End Property

    Property Let write_IG_TRC_RAM(aData)
        set_IG_TRC_RAM = aData
        write
    End Property

    Property Get get_IG_STAT_SA
        get_IG_STAT_SA = read_IG_STAT_SA_value
    End Property

    Property Let set_IG_STAT_SA(aData)
        write_IG_STAT_SA_value = aData
        flag_IG_STAT_SA        = &H1
    End Property

    Property Get read_IG_STAT_SA
        read
        read_IG_STAT_SA = read_IG_STAT_SA_value
    End Property

    Property Let write_IG_STAT_SA(aData)
        set_IG_STAT_SA = aData
        write
    End Property

    Property Get get_IG_STAT_CLAS
        get_IG_STAT_CLAS = read_IG_STAT_CLAS_value
    End Property

    Property Let set_IG_STAT_CLAS(aData)
        write_IG_STAT_CLAS_value = aData
        flag_IG_STAT_CLAS        = &H1
    End Property

    Property Get read_IG_STAT_CLAS
        read
        read_IG_STAT_CLAS = read_IG_STAT_CLAS_value
    End Property

    Property Let write_IG_STAT_CLAS(aData)
        set_IG_STAT_CLAS = aData
        write
    End Property

    Property Get get_IG_STAT_VPOR
        get_IG_STAT_VPOR = read_IG_STAT_VPOR_value
    End Property

    Property Let set_IG_STAT_VPOR(aData)
        write_IG_STAT_VPOR_value = aData
        flag_IG_STAT_VPOR        = &H1
    End Property

    Property Get read_IG_STAT_VPOR
        read
        read_IG_STAT_VPOR = read_IG_STAT_VPOR_value
    End Property

    Property Let write_IG_STAT_VPOR(aData)
        set_IG_STAT_VPOR = aData
        write
    End Property

    Property Get get_IG_SAF_SC_RAM
        get_IG_SAF_SC_RAM = read_IG_SAF_SC_RAM_value
    End Property

    Property Let set_IG_SAF_SC_RAM(aData)
        write_IG_SAF_SC_RAM_value = aData
        flag_IG_SAF_SC_RAM        = &H1
    End Property

    Property Get read_IG_SAF_SC_RAM
        read
        read_IG_SAF_SC_RAM = read_IG_SAF_SC_RAM_value
    End Property

    Property Let write_IG_SAF_SC_RAM(aData)
        set_IG_SAF_SC_RAM = aData
        write
    End Property

    Property Get get_IG_SAF_EC_RAM
        get_IG_SAF_EC_RAM = read_IG_SAF_EC_RAM_value
    End Property

    Property Let set_IG_SAF_EC_RAM(aData)
        write_IG_SAF_EC_RAM_value = aData
        flag_IG_SAF_EC_RAM        = &H1
    End Property

    Property Get read_IG_SAF_EC_RAM
        read
        read_IG_SAF_EC_RAM = read_IG_SAF_EC_RAM_value
    End Property

    Property Let write_IG_SAF_EC_RAM(aData)
        set_IG_SAF_EC_RAM = aData
        write
    End Property

    Property Get get_IG_SAF_RAM
        get_IG_SAF_RAM = read_IG_SAF_RAM_value
    End Property

    Property Let set_IG_SAF_RAM(aData)
        write_IG_SAF_RAM_value = aData
        flag_IG_SAF_RAM        = &H1
    End Property

    Property Get read_IG_SAF_RAM
        read
        read_IG_SAF_RAM = read_IG_SAF_RAM_value
    End Property

    Property Let write_IG_SAF_RAM(aData)
        set_IG_SAF_RAM = aData
        write
    End Property

    Property Get get_EG_TRC_RAM
        get_EG_TRC_RAM = read_EG_TRC_RAM_value
    End Property

    Property Let set_EG_TRC_RAM(aData)
        write_EG_TRC_RAM_value = aData
        flag_EG_TRC_RAM        = &H1
    End Property

    Property Get read_EG_TRC_RAM
        read
        read_EG_TRC_RAM = read_EG_TRC_RAM_value
    End Property

    Property Let write_EG_TRC_RAM(aData)
        set_EG_TRC_RAM = aData
        write
    End Property

    Property Get get_EG_STAT_SA
        get_EG_STAT_SA = read_EG_STAT_SA_value
    End Property

    Property Let set_EG_STAT_SA(aData)
        write_EG_STAT_SA_value = aData
        flag_EG_STAT_SA        = &H1
    End Property

    Property Get read_EG_STAT_SA
        read
        read_EG_STAT_SA = read_EG_STAT_SA_value
    End Property

    Property Let write_EG_STAT_SA(aData)
        set_EG_STAT_SA = aData
        write
    End Property

    Property Get get_EG_STAT_CLAS
        get_EG_STAT_CLAS = read_EG_STAT_CLAS_value
    End Property

    Property Let set_EG_STAT_CLAS(aData)
        write_EG_STAT_CLAS_value = aData
        flag_EG_STAT_CLAS        = &H1
    End Property

    Property Get read_EG_STAT_CLAS
        read
        read_EG_STAT_CLAS = read_EG_STAT_CLAS_value
    End Property

    Property Let write_EG_STAT_CLAS(aData)
        set_EG_STAT_CLAS = aData
        write
    End Property

    Property Get get_EG_STAT_VPOR
        get_EG_STAT_VPOR = read_EG_STAT_VPOR_value
    End Property

    Property Let set_EG_STAT_VPOR(aData)
        write_EG_STAT_VPOR_value = aData
        flag_EG_STAT_VPOR        = &H1
    End Property

    Property Get read_EG_STAT_VPOR
        read
        read_EG_STAT_VPOR = read_EG_STAT_VPOR_value
    End Property

    Property Let write_EG_STAT_VPOR(aData)
        set_EG_STAT_VPOR = aData
        write
    End Property

    Property Get get_EG_SAF_SC_RAM
        get_EG_SAF_SC_RAM = read_EG_SAF_SC_RAM_value
    End Property

    Property Let set_EG_SAF_SC_RAM(aData)
        write_EG_SAF_SC_RAM_value = aData
        flag_EG_SAF_SC_RAM        = &H1
    End Property

    Property Get read_EG_SAF_SC_RAM
        read
        read_EG_SAF_SC_RAM = read_EG_SAF_SC_RAM_value
    End Property

    Property Let write_EG_SAF_SC_RAM(aData)
        set_EG_SAF_SC_RAM = aData
        write
    End Property

    Property Get get_EG_SAF_EC_RAM
        get_EG_SAF_EC_RAM = read_EG_SAF_EC_RAM_value
    End Property

    Property Let set_EG_SAF_EC_RAM(aData)
        write_EG_SAF_EC_RAM_value = aData
        flag_EG_SAF_EC_RAM        = &H1
    End Property

    Property Get read_EG_SAF_EC_RAM
        read
        read_EG_SAF_EC_RAM = read_EG_SAF_EC_RAM_value
    End Property

    Property Let write_EG_SAF_EC_RAM(aData)
        set_EG_SAF_EC_RAM = aData
        write
    End Property

    Property Get get_EG_SAF_RAM
        get_EG_SAF_RAM = read_EG_SAF_RAM_value
    End Property

    Property Let set_EG_SAF_RAM(aData)
        write_EG_SAF_RAM_value = aData
        flag_EG_SAF_RAM        = &H1
    End Property

    Property Get read_EG_SAF_RAM
        read
        read_EG_SAF_RAM = read_EG_SAF_RAM_value
    End Property

    Property Let write_EG_SAF_RAM(aData)
        set_EG_SAF_RAM = aData
        write
    End Property

    Property Get get_REDIR_DEBUG
        get_REDIR_DEBUG = read_REDIR_DEBUG_value
    End Property

    Property Let set_REDIR_DEBUG(aData)
        write_REDIR_DEBUG_value = aData
        flag_REDIR_DEBUG        = &H1
    End Property

    Property Get read_REDIR_DEBUG
        read
        read_REDIR_DEBUG = read_REDIR_DEBUG_value
    End Property

    Property Let write_REDIR_DEBUG(aData)
        set_REDIR_DEBUG = aData
        write
    End Property

    Property Get get_IG_CAPT_DEBU
        get_IG_CAPT_DEBU = read_IG_CAPT_DEBU_value
    End Property

    Property Let set_IG_CAPT_DEBU(aData)
        write_IG_CAPT_DEBU_value = aData
        flag_IG_CAPT_DEBU        = &H1
    End Property

    Property Get read_IG_CAPT_DEBU
        read
        read_IG_CAPT_DEBU = read_IG_CAPT_DEBU_value
    End Property

    Property Let write_IG_CAPT_DEBU(aData)
        set_IG_CAPT_DEBU = aData
        write
    End Property

    Property Get get_EG_CAPT_DEBU
        get_EG_CAPT_DEBU = read_EG_CAPT_DEBU_value
    End Property

    Property Let set_EG_CAPT_DEBU(aData)
        write_EG_CAPT_DEBU_value = aData
        flag_EG_CAPT_DEBU        = &H1
    End Property

    Property Get read_EG_CAPT_DEBU
        read
        read_EG_CAPT_DEBU = read_EG_CAPT_DEBU_value
    End Property

    Property Let write_EG_CAPT_DEBU(aData)
        set_EG_CAPT_DEBU = aData
        write
    End Property

    Property Get get_IG_TCAM_RAM
        get_IG_TCAM_RAM = read_IG_TCAM_RAM_value
    End Property

    Property Let set_IG_TCAM_RAM(aData)
        write_IG_TCAM_RAM_value = aData
        flag_IG_TCAM_RAM        = &H1
    End Property

    Property Get read_IG_TCAM_RAM
        read
        read_IG_TCAM_RAM = read_IG_TCAM_RAM_value
    End Property

    Property Let write_IG_TCAM_RAM(aData)
        set_IG_TCAM_RAM = aData
        write
    End Property

    Property Get get_EG_TCAM_RAM
        get_EG_TCAM_RAM = read_EG_TCAM_RAM_value
    End Property

    Property Let set_EG_TCAM_RAM(aData)
        write_EG_TCAM_RAM_value = aData
        flag_EG_TCAM_RAM        = &H1
    End Property

    Property Get read_EG_TCAM_RAM
        read
        read_EG_TCAM_RAM = read_EG_TCAM_RAM_value
    End Property

    Property Let write_EG_TCAM_RAM(aData)
        set_EG_TCAM_RAM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        IG_TRC_RAM_mask = &H1
        if data_low > LONG_MAX then
            if IG_TRC_RAM_mask = mask then
                read_IG_TRC_RAM_value = data_low
            else
                read_IG_TRC_RAM_value = (data_low - H8000_0000) and IG_TRC_RAM_mask
            end If
        else
            read_IG_TRC_RAM_value = data_low and IG_TRC_RAM_mask
        end If
        read_IG_STAT_SA_value = rightShift(data_low, 1) and &H1
        read_IG_STAT_CLAS_value = rightShift(data_low, 2) and &H1
        read_IG_STAT_VPOR_value = rightShift(data_low, 3) and &H1
        read_IG_SAF_SC_RAM_value = rightShift(data_low, 4) and &H1
        read_IG_SAF_EC_RAM_value = rightShift(data_low, 5) and &H1
        read_IG_SAF_RAM_value = rightShift(data_low, 6) and &H1
        read_EG_TRC_RAM_value = rightShift(data_low, 7) and &H1
        read_EG_STAT_SA_value = rightShift(data_low, 8) and &H1
        read_EG_STAT_CLAS_value = rightShift(data_low, 9) and &H1
        read_EG_STAT_VPOR_value = rightShift(data_low, 10) and &H1
        read_EG_SAF_SC_RAM_value = rightShift(data_low, 11) and &H1
        read_EG_SAF_EC_RAM_value = rightShift(data_low, 12) and &H1
        read_EG_SAF_RAM_value = rightShift(data_low, 13) and &H1
        read_REDIR_DEBUG_value = rightShift(data_low, 14) and &H1
        read_IG_CAPT_DEBU_value = rightShift(data_low, 15) and &H1
        read_EG_CAPT_DEBU_value = rightShift(data_low, 16) and &H1
        read_IG_TCAM_RAM_value = rightShift(data_low, 17) and &H1
        read_EG_TCAM_RAM_value = rightShift(data_low, 18) and &H1

    End Sub

    Sub write
        If flag_IG_TRC_RAM = &H0 or flag_IG_STAT_SA = &H0 or flag_IG_STAT_CLAS = &H0 or flag_IG_STAT_VPOR = &H0 or flag_IG_SAF_SC_RAM = &H0 or flag_IG_SAF_EC_RAM = &H0 or flag_IG_SAF_RAM = &H0 or flag_EG_TRC_RAM = &H0 or flag_EG_STAT_SA = &H0 or flag_EG_STAT_CLAS = &H0 or flag_EG_STAT_VPOR = &H0 or flag_EG_SAF_SC_RAM = &H0 or flag_EG_SAF_EC_RAM = &H0 or flag_EG_SAF_RAM = &H0 or flag_REDIR_DEBUG = &H0 or flag_IG_CAPT_DEBU = &H0 or flag_EG_CAPT_DEBU = &H0 or flag_IG_TCAM_RAM = &H0 or flag_EG_TCAM_RAM = &H0 Then read
        If flag_IG_TRC_RAM = &H0 Then write_IG_TRC_RAM_value = get_IG_TRC_RAM
        If flag_IG_STAT_SA = &H0 Then write_IG_STAT_SA_value = get_IG_STAT_SA
        If flag_IG_STAT_CLAS = &H0 Then write_IG_STAT_CLAS_value = get_IG_STAT_CLAS
        If flag_IG_STAT_VPOR = &H0 Then write_IG_STAT_VPOR_value = get_IG_STAT_VPOR
        If flag_IG_SAF_SC_RAM = &H0 Then write_IG_SAF_SC_RAM_value = get_IG_SAF_SC_RAM
        If flag_IG_SAF_EC_RAM = &H0 Then write_IG_SAF_EC_RAM_value = get_IG_SAF_EC_RAM
        If flag_IG_SAF_RAM = &H0 Then write_IG_SAF_RAM_value = get_IG_SAF_RAM
        If flag_EG_TRC_RAM = &H0 Then write_EG_TRC_RAM_value = get_EG_TRC_RAM
        If flag_EG_STAT_SA = &H0 Then write_EG_STAT_SA_value = get_EG_STAT_SA
        If flag_EG_STAT_CLAS = &H0 Then write_EG_STAT_CLAS_value = get_EG_STAT_CLAS
        If flag_EG_STAT_VPOR = &H0 Then write_EG_STAT_VPOR_value = get_EG_STAT_VPOR
        If flag_EG_SAF_SC_RAM = &H0 Then write_EG_SAF_SC_RAM_value = get_EG_SAF_SC_RAM
        If flag_EG_SAF_EC_RAM = &H0 Then write_EG_SAF_EC_RAM_value = get_EG_SAF_EC_RAM
        If flag_EG_SAF_RAM = &H0 Then write_EG_SAF_RAM_value = get_EG_SAF_RAM
        If flag_REDIR_DEBUG = &H0 Then write_REDIR_DEBUG_value = get_REDIR_DEBUG
        If flag_IG_CAPT_DEBU = &H0 Then write_IG_CAPT_DEBU_value = get_IG_CAPT_DEBU
        If flag_EG_CAPT_DEBU = &H0 Then write_EG_CAPT_DEBU_value = get_EG_CAPT_DEBU
        If flag_IG_TCAM_RAM = &H0 Then write_IG_TCAM_RAM_value = get_IG_TCAM_RAM
        If flag_EG_TCAM_RAM = &H0 Then write_EG_TCAM_RAM_value = get_EG_TCAM_RAM

        regValue = leftShift((write_IG_TRC_RAM_value and &H1), 0) + leftShift((write_IG_STAT_SA_value and &H1), 1) + leftShift((write_IG_STAT_CLAS_value and &H1), 2) + leftShift((write_IG_STAT_VPOR_value and &H1), 3) + leftShift((write_IG_SAF_SC_RAM_value and &H1), 4) + leftShift((write_IG_SAF_EC_RAM_value and &H1), 5) + leftShift((write_IG_SAF_RAM_value and &H1), 6) + leftShift((write_EG_TRC_RAM_value and &H1), 7) + leftShift((write_EG_STAT_SA_value and &H1), 8) + leftShift((write_EG_STAT_CLAS_value and &H1), 9) + leftShift((write_EG_STAT_VPOR_value and &H1), 10) + leftShift((write_EG_SAF_SC_RAM_value and &H1), 11) + leftShift((write_EG_SAF_EC_RAM_value and &H1), 12) + leftShift((write_EG_SAF_RAM_value and &H1), 13) + leftShift((write_REDIR_DEBUG_value and &H1), 14) + leftShift((write_IG_CAPT_DEBU_value and &H1), 15) + leftShift((write_EG_CAPT_DEBU_value and &H1), 16) + leftShift((write_IG_TCAM_RAM_value and &H1), 17) + leftShift((write_EG_TCAM_RAM_value and &H1), 18)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        IG_TRC_RAM_mask = &H1
        if data_low > LONG_MAX then
            if IG_TRC_RAM_mask = mask then
                read_IG_TRC_RAM_value = data_low
            else
                read_IG_TRC_RAM_value = (data_low - H8000_0000) and IG_TRC_RAM_mask
            end If
        else
            read_IG_TRC_RAM_value = data_low and IG_TRC_RAM_mask
        end If
        read_IG_STAT_SA_value = rightShift(data_low, 1) and &H1
        read_IG_STAT_CLAS_value = rightShift(data_low, 2) and &H1
        read_IG_STAT_VPOR_value = rightShift(data_low, 3) and &H1
        read_IG_SAF_SC_RAM_value = rightShift(data_low, 4) and &H1
        read_IG_SAF_EC_RAM_value = rightShift(data_low, 5) and &H1
        read_IG_SAF_RAM_value = rightShift(data_low, 6) and &H1
        read_EG_TRC_RAM_value = rightShift(data_low, 7) and &H1
        read_EG_STAT_SA_value = rightShift(data_low, 8) and &H1
        read_EG_STAT_CLAS_value = rightShift(data_low, 9) and &H1
        read_EG_STAT_VPOR_value = rightShift(data_low, 10) and &H1
        read_EG_SAF_SC_RAM_value = rightShift(data_low, 11) and &H1
        read_EG_SAF_EC_RAM_value = rightShift(data_low, 12) and &H1
        read_EG_SAF_RAM_value = rightShift(data_low, 13) and &H1
        read_REDIR_DEBUG_value = rightShift(data_low, 14) and &H1
        read_IG_CAPT_DEBU_value = rightShift(data_low, 15) and &H1
        read_EG_CAPT_DEBU_value = rightShift(data_low, 16) and &H1
        read_IG_TCAM_RAM_value = rightShift(data_low, 17) and &H1
        read_EG_TCAM_RAM_value = rightShift(data_low, 18) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_IG_TRC_RAM_value = &H0
        flag_IG_TRC_RAM        = &H0
        write_IG_STAT_SA_value = &H0
        flag_IG_STAT_SA        = &H0
        write_IG_STAT_CLAS_value = &H0
        flag_IG_STAT_CLAS        = &H0
        write_IG_STAT_VPOR_value = &H0
        flag_IG_STAT_VPOR        = &H0
        write_IG_SAF_SC_RAM_value = &H0
        flag_IG_SAF_SC_RAM        = &H0
        write_IG_SAF_EC_RAM_value = &H0
        flag_IG_SAF_EC_RAM        = &H0
        write_IG_SAF_RAM_value = &H0
        flag_IG_SAF_RAM        = &H0
        write_EG_TRC_RAM_value = &H0
        flag_EG_TRC_RAM        = &H0
        write_EG_STAT_SA_value = &H0
        flag_EG_STAT_SA        = &H0
        write_EG_STAT_CLAS_value = &H0
        flag_EG_STAT_CLAS        = &H0
        write_EG_STAT_VPOR_value = &H0
        flag_EG_STAT_VPOR        = &H0
        write_EG_SAF_SC_RAM_value = &H0
        flag_EG_SAF_SC_RAM        = &H0
        write_EG_SAF_EC_RAM_value = &H0
        flag_EG_SAF_EC_RAM        = &H0
        write_EG_SAF_RAM_value = &H0
        flag_EG_SAF_RAM        = &H0
        write_REDIR_DEBUG_value = &H0
        flag_REDIR_DEBUG        = &H0
        write_IG_CAPT_DEBU_value = &H0
        flag_IG_CAPT_DEBU        = &H0
        write_EG_CAPT_DEBU_value = &H0
        flag_EG_CAPT_DEBU        = &H0
        write_IG_TCAM_RAM_value = &H0
        flag_IG_TCAM_RAM        = &H0
        write_EG_TCAM_RAM_value = &H0
        flag_EG_TCAM_RAM        = &H0
    End Sub
End Class


'' @REGISTER : EIP165S_EIP_165S_32_BRCM_EIP_165_ECC_ecc_test_2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' IG_TRC_RAM                                 [0:0]            get_IG_TRC_RAM
''                                                             set_IG_TRC_RAM
''                                                             read_IG_TRC_RAM
''                                                             write_IG_TRC_RAM
''---------------------------------------------------------------------------------
'' IG_STAT_SA1                                [1:1]            get_IG_STAT_SA1
''                                                             set_IG_STAT_SA1
''                                                             read_IG_STAT_SA1
''                                                             write_IG_STAT_SA1
''---------------------------------------------------------------------------------
'' IG_STAT_CLAS1                              [2:2]            get_IG_STAT_CLAS1
''                                                             set_IG_STAT_CLAS1
''                                                             read_IG_STAT_CLAS1
''                                                             write_IG_STAT_CLAS1
''---------------------------------------------------------------------------------
'' IG_STAT_VPOR1                              [3:3]            get_IG_STAT_VPOR1
''                                                             set_IG_STAT_VPOR1
''                                                             read_IG_STAT_VPOR1
''                                                             write_IG_STAT_VPOR1
''---------------------------------------------------------------------------------
'' IG_SAF_SC_RAM1                             [4:4]            get_IG_SAF_SC_RAM1
''                                                             set_IG_SAF_SC_RAM1
''                                                             read_IG_SAF_SC_RAM1
''                                                             write_IG_SAF_SC_RAM1
''---------------------------------------------------------------------------------
'' IG_SAF_EC_RAM1                             [5:5]            get_IG_SAF_EC_RAM1
''                                                             set_IG_SAF_EC_RAM1
''                                                             read_IG_SAF_EC_RAM1
''                                                             write_IG_SAF_EC_RAM1
''---------------------------------------------------------------------------------
'' IG_SAF_RAM1                                [6:6]            get_IG_SAF_RAM1
''                                                             set_IG_SAF_RAM1
''                                                             read_IG_SAF_RAM1
''                                                             write_IG_SAF_RAM1
''---------------------------------------------------------------------------------
'' EG_TRC_RAM1                                [7:7]            get_EG_TRC_RAM1
''                                                             set_EG_TRC_RAM1
''                                                             read_EG_TRC_RAM1
''                                                             write_EG_TRC_RAM1
''---------------------------------------------------------------------------------
'' EG_STAT_SA1                                [8:8]            get_EG_STAT_SA1
''                                                             set_EG_STAT_SA1
''                                                             read_EG_STAT_SA1
''                                                             write_EG_STAT_SA1
''---------------------------------------------------------------------------------
'' EG_STAT_CLAS1                              [9:9]            get_EG_STAT_CLAS1
''                                                             set_EG_STAT_CLAS1
''                                                             read_EG_STAT_CLAS1
''                                                             write_EG_STAT_CLAS1
''---------------------------------------------------------------------------------
'' EG_STAT_VPOR1                              [10:10]          get_EG_STAT_VPOR1
''                                                             set_EG_STAT_VPOR1
''                                                             read_EG_STAT_VPOR1
''                                                             write_EG_STAT_VPOR1
''---------------------------------------------------------------------------------
'' EG_SAF_SC_RAM1                             [11:11]          get_EG_SAF_SC_RAM1
''                                                             set_EG_SAF_SC_RAM1
''                                                             read_EG_SAF_SC_RAM1
''                                                             write_EG_SAF_SC_RAM1
''---------------------------------------------------------------------------------
'' EG_SAF_EC_RAM1                             [12:12]          get_EG_SAF_EC_RAM1
''                                                             set_EG_SAF_EC_RAM1
''                                                             read_EG_SAF_EC_RAM1
''                                                             write_EG_SAF_EC_RAM1
''---------------------------------------------------------------------------------
'' EG_SAF_RAM1                                [13:13]          get_EG_SAF_RAM1
''                                                             set_EG_SAF_RAM1
''                                                             read_EG_SAF_RAM1
''                                                             write_EG_SAF_RAM1
''---------------------------------------------------------------------------------
'' REDIR_DEBUG1                               [14:14]          get_REDIR_DEBUG1
''                                                             set_REDIR_DEBUG1
''                                                             read_REDIR_DEBUG1
''                                                             write_REDIR_DEBUG1
''---------------------------------------------------------------------------------
'' IG_CAPT_DEBU1                              [15:15]          get_IG_CAPT_DEBU1
''                                                             set_IG_CAPT_DEBU1
''                                                             read_IG_CAPT_DEBU1
''                                                             write_IG_CAPT_DEBU1
''---------------------------------------------------------------------------------
'' EG_CAPT_DEBU1                              [16:16]          get_EG_CAPT_DEBU1
''                                                             set_EG_CAPT_DEBU1
''                                                             read_EG_CAPT_DEBU1
''                                                             write_EG_CAPT_DEBU1
''---------------------------------------------------------------------------------
'' IG_TCAM_RAM1                               [17:17]          get_IG_TCAM_RAM1
''                                                             set_IG_TCAM_RAM1
''                                                             read_IG_TCAM_RAM1
''                                                             write_IG_TCAM_RAM1
''---------------------------------------------------------------------------------
'' EG_TCAM_RAM1                               [18:18]          get_EG_TCAM_RAM1
''                                                             set_EG_TCAM_RAM1
''                                                             read_EG_TCAM_RAM1
''                                                             write_EG_TCAM_RAM1
''---------------------------------------------------------------------------------
Class REGISTER_EIP165S_EIP_165S_32_BRCM_EIP_165_ECC_ecc_test_2
    Private write_IG_TRC_RAM_value
    Private read_IG_TRC_RAM_value
    Private flag_IG_TRC_RAM
    Private write_IG_STAT_SA1_value
    Private read_IG_STAT_SA1_value
    Private flag_IG_STAT_SA1
    Private write_IG_STAT_CLAS1_value
    Private read_IG_STAT_CLAS1_value
    Private flag_IG_STAT_CLAS1
    Private write_IG_STAT_VPOR1_value
    Private read_IG_STAT_VPOR1_value
    Private flag_IG_STAT_VPOR1
    Private write_IG_SAF_SC_RAM1_value
    Private read_IG_SAF_SC_RAM1_value
    Private flag_IG_SAF_SC_RAM1
    Private write_IG_SAF_EC_RAM1_value
    Private read_IG_SAF_EC_RAM1_value
    Private flag_IG_SAF_EC_RAM1
    Private write_IG_SAF_RAM1_value
    Private read_IG_SAF_RAM1_value
    Private flag_IG_SAF_RAM1
    Private write_EG_TRC_RAM1_value
    Private read_EG_TRC_RAM1_value
    Private flag_EG_TRC_RAM1
    Private write_EG_STAT_SA1_value
    Private read_EG_STAT_SA1_value
    Private flag_EG_STAT_SA1
    Private write_EG_STAT_CLAS1_value
    Private read_EG_STAT_CLAS1_value
    Private flag_EG_STAT_CLAS1
    Private write_EG_STAT_VPOR1_value
    Private read_EG_STAT_VPOR1_value
    Private flag_EG_STAT_VPOR1
    Private write_EG_SAF_SC_RAM1_value
    Private read_EG_SAF_SC_RAM1_value
    Private flag_EG_SAF_SC_RAM1
    Private write_EG_SAF_EC_RAM1_value
    Private read_EG_SAF_EC_RAM1_value
    Private flag_EG_SAF_EC_RAM1
    Private write_EG_SAF_RAM1_value
    Private read_EG_SAF_RAM1_value
    Private flag_EG_SAF_RAM1
    Private write_REDIR_DEBUG1_value
    Private read_REDIR_DEBUG1_value
    Private flag_REDIR_DEBUG1
    Private write_IG_CAPT_DEBU1_value
    Private read_IG_CAPT_DEBU1_value
    Private flag_IG_CAPT_DEBU1
    Private write_EG_CAPT_DEBU1_value
    Private read_EG_CAPT_DEBU1_value
    Private flag_EG_CAPT_DEBU1
    Private write_IG_TCAM_RAM1_value
    Private read_IG_TCAM_RAM1_value
    Private flag_IG_TCAM_RAM1
    Private write_EG_TCAM_RAM1_value
    Private read_EG_TCAM_RAM1_value
    Private flag_EG_TCAM_RAM1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H20d14
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_IG_TRC_RAM
        get_IG_TRC_RAM = read_IG_TRC_RAM_value
    End Property

    Property Let set_IG_TRC_RAM(aData)
        write_IG_TRC_RAM_value = aData
        flag_IG_TRC_RAM        = &H1
    End Property

    Property Get read_IG_TRC_RAM
        read
        read_IG_TRC_RAM = read_IG_TRC_RAM_value
    End Property

    Property Let write_IG_TRC_RAM(aData)
        set_IG_TRC_RAM = aData
        write
    End Property

    Property Get get_IG_STAT_SA1
        get_IG_STAT_SA1 = read_IG_STAT_SA1_value
    End Property

    Property Let set_IG_STAT_SA1(aData)
        write_IG_STAT_SA1_value = aData
        flag_IG_STAT_SA1        = &H1
    End Property

    Property Get read_IG_STAT_SA1
        read
        read_IG_STAT_SA1 = read_IG_STAT_SA1_value
    End Property

    Property Let write_IG_STAT_SA1(aData)
        set_IG_STAT_SA1 = aData
        write
    End Property

    Property Get get_IG_STAT_CLAS1
        get_IG_STAT_CLAS1 = read_IG_STAT_CLAS1_value
    End Property

    Property Let set_IG_STAT_CLAS1(aData)
        write_IG_STAT_CLAS1_value = aData
        flag_IG_STAT_CLAS1        = &H1
    End Property

    Property Get read_IG_STAT_CLAS1
        read
        read_IG_STAT_CLAS1 = read_IG_STAT_CLAS1_value
    End Property

    Property Let write_IG_STAT_CLAS1(aData)
        set_IG_STAT_CLAS1 = aData
        write
    End Property

    Property Get get_IG_STAT_VPOR1
        get_IG_STAT_VPOR1 = read_IG_STAT_VPOR1_value
    End Property

    Property Let set_IG_STAT_VPOR1(aData)
        write_IG_STAT_VPOR1_value = aData
        flag_IG_STAT_VPOR1        = &H1
    End Property

    Property Get read_IG_STAT_VPOR1
        read
        read_IG_STAT_VPOR1 = read_IG_STAT_VPOR1_value
    End Property

    Property Let write_IG_STAT_VPOR1(aData)
        set_IG_STAT_VPOR1 = aData
        write
    End Property

    Property Get get_IG_SAF_SC_RAM1
        get_IG_SAF_SC_RAM1 = read_IG_SAF_SC_RAM1_value
    End Property

    Property Let set_IG_SAF_SC_RAM1(aData)
        write_IG_SAF_SC_RAM1_value = aData
        flag_IG_SAF_SC_RAM1        = &H1
    End Property

    Property Get read_IG_SAF_SC_RAM1
        read
        read_IG_SAF_SC_RAM1 = read_IG_SAF_SC_RAM1_value
    End Property

    Property Let write_IG_SAF_SC_RAM1(aData)
        set_IG_SAF_SC_RAM1 = aData
        write
    End Property

    Property Get get_IG_SAF_EC_RAM1
        get_IG_SAF_EC_RAM1 = read_IG_SAF_EC_RAM1_value
    End Property

    Property Let set_IG_SAF_EC_RAM1(aData)
        write_IG_SAF_EC_RAM1_value = aData
        flag_IG_SAF_EC_RAM1        = &H1
    End Property

    Property Get read_IG_SAF_EC_RAM1
        read
        read_IG_SAF_EC_RAM1 = read_IG_SAF_EC_RAM1_value
    End Property

    Property Let write_IG_SAF_EC_RAM1(aData)
        set_IG_SAF_EC_RAM1 = aData
        write
    End Property

    Property Get get_IG_SAF_RAM1
        get_IG_SAF_RAM1 = read_IG_SAF_RAM1_value
    End Property

    Property Let set_IG_SAF_RAM1(aData)
        write_IG_SAF_RAM1_value = aData
        flag_IG_SAF_RAM1        = &H1
    End Property

    Property Get read_IG_SAF_RAM1
        read
        read_IG_SAF_RAM1 = read_IG_SAF_RAM1_value
    End Property

    Property Let write_IG_SAF_RAM1(aData)
        set_IG_SAF_RAM1 = aData
        write
    End Property

    Property Get get_EG_TRC_RAM1
        get_EG_TRC_RAM1 = read_EG_TRC_RAM1_value
    End Property

    Property Let set_EG_TRC_RAM1(aData)
        write_EG_TRC_RAM1_value = aData
        flag_EG_TRC_RAM1        = &H1
    End Property

    Property Get read_EG_TRC_RAM1
        read
        read_EG_TRC_RAM1 = read_EG_TRC_RAM1_value
    End Property

    Property Let write_EG_TRC_RAM1(aData)
        set_EG_TRC_RAM1 = aData
        write
    End Property

    Property Get get_EG_STAT_SA1
        get_EG_STAT_SA1 = read_EG_STAT_SA1_value
    End Property

    Property Let set_EG_STAT_SA1(aData)
        write_EG_STAT_SA1_value = aData
        flag_EG_STAT_SA1        = &H1
    End Property

    Property Get read_EG_STAT_SA1
        read
        read_EG_STAT_SA1 = read_EG_STAT_SA1_value
    End Property

    Property Let write_EG_STAT_SA1(aData)
        set_EG_STAT_SA1 = aData
        write
    End Property

    Property Get get_EG_STAT_CLAS1
        get_EG_STAT_CLAS1 = read_EG_STAT_CLAS1_value
    End Property

    Property Let set_EG_STAT_CLAS1(aData)
        write_EG_STAT_CLAS1_value = aData
        flag_EG_STAT_CLAS1        = &H1
    End Property

    Property Get read_EG_STAT_CLAS1
        read
        read_EG_STAT_CLAS1 = read_EG_STAT_CLAS1_value
    End Property

    Property Let write_EG_STAT_CLAS1(aData)
        set_EG_STAT_CLAS1 = aData
        write
    End Property

    Property Get get_EG_STAT_VPOR1
        get_EG_STAT_VPOR1 = read_EG_STAT_VPOR1_value
    End Property

    Property Let set_EG_STAT_VPOR1(aData)
        write_EG_STAT_VPOR1_value = aData
        flag_EG_STAT_VPOR1        = &H1
    End Property

    Property Get read_EG_STAT_VPOR1
        read
        read_EG_STAT_VPOR1 = read_EG_STAT_VPOR1_value
    End Property

    Property Let write_EG_STAT_VPOR1(aData)
        set_EG_STAT_VPOR1 = aData
        write
    End Property

    Property Get get_EG_SAF_SC_RAM1
        get_EG_SAF_SC_RAM1 = read_EG_SAF_SC_RAM1_value
    End Property

    Property Let set_EG_SAF_SC_RAM1(aData)
        write_EG_SAF_SC_RAM1_value = aData
        flag_EG_SAF_SC_RAM1        = &H1
    End Property

    Property Get read_EG_SAF_SC_RAM1
        read
        read_EG_SAF_SC_RAM1 = read_EG_SAF_SC_RAM1_value
    End Property

    Property Let write_EG_SAF_SC_RAM1(aData)
        set_EG_SAF_SC_RAM1 = aData
        write
    End Property

    Property Get get_EG_SAF_EC_RAM1
        get_EG_SAF_EC_RAM1 = read_EG_SAF_EC_RAM1_value
    End Property

    Property Let set_EG_SAF_EC_RAM1(aData)
        write_EG_SAF_EC_RAM1_value = aData
        flag_EG_SAF_EC_RAM1        = &H1
    End Property

    Property Get read_EG_SAF_EC_RAM1
        read
        read_EG_SAF_EC_RAM1 = read_EG_SAF_EC_RAM1_value
    End Property

    Property Let write_EG_SAF_EC_RAM1(aData)
        set_EG_SAF_EC_RAM1 = aData
        write
    End Property

    Property Get get_EG_SAF_RAM1
        get_EG_SAF_RAM1 = read_EG_SAF_RAM1_value
    End Property

    Property Let set_EG_SAF_RAM1(aData)
        write_EG_SAF_RAM1_value = aData
        flag_EG_SAF_RAM1        = &H1
    End Property

    Property Get read_EG_SAF_RAM1
        read
        read_EG_SAF_RAM1 = read_EG_SAF_RAM1_value
    End Property

    Property Let write_EG_SAF_RAM1(aData)
        set_EG_SAF_RAM1 = aData
        write
    End Property

    Property Get get_REDIR_DEBUG1
        get_REDIR_DEBUG1 = read_REDIR_DEBUG1_value
    End Property

    Property Let set_REDIR_DEBUG1(aData)
        write_REDIR_DEBUG1_value = aData
        flag_REDIR_DEBUG1        = &H1
    End Property

    Property Get read_REDIR_DEBUG1
        read
        read_REDIR_DEBUG1 = read_REDIR_DEBUG1_value
    End Property

    Property Let write_REDIR_DEBUG1(aData)
        set_REDIR_DEBUG1 = aData
        write
    End Property

    Property Get get_IG_CAPT_DEBU1
        get_IG_CAPT_DEBU1 = read_IG_CAPT_DEBU1_value
    End Property

    Property Let set_IG_CAPT_DEBU1(aData)
        write_IG_CAPT_DEBU1_value = aData
        flag_IG_CAPT_DEBU1        = &H1
    End Property

    Property Get read_IG_CAPT_DEBU1
        read
        read_IG_CAPT_DEBU1 = read_IG_CAPT_DEBU1_value
    End Property

    Property Let write_IG_CAPT_DEBU1(aData)
        set_IG_CAPT_DEBU1 = aData
        write
    End Property

    Property Get get_EG_CAPT_DEBU1
        get_EG_CAPT_DEBU1 = read_EG_CAPT_DEBU1_value
    End Property

    Property Let set_EG_CAPT_DEBU1(aData)
        write_EG_CAPT_DEBU1_value = aData
        flag_EG_CAPT_DEBU1        = &H1
    End Property

    Property Get read_EG_CAPT_DEBU1
        read
        read_EG_CAPT_DEBU1 = read_EG_CAPT_DEBU1_value
    End Property

    Property Let write_EG_CAPT_DEBU1(aData)
        set_EG_CAPT_DEBU1 = aData
        write
    End Property

    Property Get get_IG_TCAM_RAM1
        get_IG_TCAM_RAM1 = read_IG_TCAM_RAM1_value
    End Property

    Property Let set_IG_TCAM_RAM1(aData)
        write_IG_TCAM_RAM1_value = aData
        flag_IG_TCAM_RAM1        = &H1
    End Property

    Property Get read_IG_TCAM_RAM1
        read
        read_IG_TCAM_RAM1 = read_IG_TCAM_RAM1_value
    End Property

    Property Let write_IG_TCAM_RAM1(aData)
        set_IG_TCAM_RAM1 = aData
        write
    End Property

    Property Get get_EG_TCAM_RAM1
        get_EG_TCAM_RAM1 = read_EG_TCAM_RAM1_value
    End Property

    Property Let set_EG_TCAM_RAM1(aData)
        write_EG_TCAM_RAM1_value = aData
        flag_EG_TCAM_RAM1        = &H1
    End Property

    Property Get read_EG_TCAM_RAM1
        read
        read_EG_TCAM_RAM1 = read_EG_TCAM_RAM1_value
    End Property

    Property Let write_EG_TCAM_RAM1(aData)
        set_EG_TCAM_RAM1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        IG_TRC_RAM_mask = &H1
        if data_low > LONG_MAX then
            if IG_TRC_RAM_mask = mask then
                read_IG_TRC_RAM_value = data_low
            else
                read_IG_TRC_RAM_value = (data_low - H8000_0000) and IG_TRC_RAM_mask
            end If
        else
            read_IG_TRC_RAM_value = data_low and IG_TRC_RAM_mask
        end If
        read_IG_STAT_SA1_value = rightShift(data_low, 1) and &H1
        read_IG_STAT_CLAS1_value = rightShift(data_low, 2) and &H1
        read_IG_STAT_VPOR1_value = rightShift(data_low, 3) and &H1
        read_IG_SAF_SC_RAM1_value = rightShift(data_low, 4) and &H1
        read_IG_SAF_EC_RAM1_value = rightShift(data_low, 5) and &H1
        read_IG_SAF_RAM1_value = rightShift(data_low, 6) and &H1
        read_EG_TRC_RAM1_value = rightShift(data_low, 7) and &H1
        read_EG_STAT_SA1_value = rightShift(data_low, 8) and &H1
        read_EG_STAT_CLAS1_value = rightShift(data_low, 9) and &H1
        read_EG_STAT_VPOR1_value = rightShift(data_low, 10) and &H1
        read_EG_SAF_SC_RAM1_value = rightShift(data_low, 11) and &H1
        read_EG_SAF_EC_RAM1_value = rightShift(data_low, 12) and &H1
        read_EG_SAF_RAM1_value = rightShift(data_low, 13) and &H1
        read_REDIR_DEBUG1_value = rightShift(data_low, 14) and &H1
        read_IG_CAPT_DEBU1_value = rightShift(data_low, 15) and &H1
        read_EG_CAPT_DEBU1_value = rightShift(data_low, 16) and &H1
        read_IG_TCAM_RAM1_value = rightShift(data_low, 17) and &H1
        read_EG_TCAM_RAM1_value = rightShift(data_low, 18) and &H1

    End Sub

    Sub write
        If flag_IG_TRC_RAM = &H0 or flag_IG_STAT_SA1 = &H0 or flag_IG_STAT_CLAS1 = &H0 or flag_IG_STAT_VPOR1 = &H0 or flag_IG_SAF_SC_RAM1 = &H0 or flag_IG_SAF_EC_RAM1 = &H0 or flag_IG_SAF_RAM1 = &H0 or flag_EG_TRC_RAM1 = &H0 or flag_EG_STAT_SA1 = &H0 or flag_EG_STAT_CLAS1 = &H0 or flag_EG_STAT_VPOR1 = &H0 or flag_EG_SAF_SC_RAM1 = &H0 or flag_EG_SAF_EC_RAM1 = &H0 or flag_EG_SAF_RAM1 = &H0 or flag_REDIR_DEBUG1 = &H0 or flag_IG_CAPT_DEBU1 = &H0 or flag_EG_CAPT_DEBU1 = &H0 or flag_IG_TCAM_RAM1 = &H0 or flag_EG_TCAM_RAM1 = &H0 Then read
        If flag_IG_TRC_RAM = &H0 Then write_IG_TRC_RAM_value = get_IG_TRC_RAM
        If flag_IG_STAT_SA1 = &H0 Then write_IG_STAT_SA1_value = get_IG_STAT_SA1
        If flag_IG_STAT_CLAS1 = &H0 Then write_IG_STAT_CLAS1_value = get_IG_STAT_CLAS1
        If flag_IG_STAT_VPOR1 = &H0 Then write_IG_STAT_VPOR1_value = get_IG_STAT_VPOR1
        If flag_IG_SAF_SC_RAM1 = &H0 Then write_IG_SAF_SC_RAM1_value = get_IG_SAF_SC_RAM1
        If flag_IG_SAF_EC_RAM1 = &H0 Then write_IG_SAF_EC_RAM1_value = get_IG_SAF_EC_RAM1
        If flag_IG_SAF_RAM1 = &H0 Then write_IG_SAF_RAM1_value = get_IG_SAF_RAM1
        If flag_EG_TRC_RAM1 = &H0 Then write_EG_TRC_RAM1_value = get_EG_TRC_RAM1
        If flag_EG_STAT_SA1 = &H0 Then write_EG_STAT_SA1_value = get_EG_STAT_SA1
        If flag_EG_STAT_CLAS1 = &H0 Then write_EG_STAT_CLAS1_value = get_EG_STAT_CLAS1
        If flag_EG_STAT_VPOR1 = &H0 Then write_EG_STAT_VPOR1_value = get_EG_STAT_VPOR1
        If flag_EG_SAF_SC_RAM1 = &H0 Then write_EG_SAF_SC_RAM1_value = get_EG_SAF_SC_RAM1
        If flag_EG_SAF_EC_RAM1 = &H0 Then write_EG_SAF_EC_RAM1_value = get_EG_SAF_EC_RAM1
        If flag_EG_SAF_RAM1 = &H0 Then write_EG_SAF_RAM1_value = get_EG_SAF_RAM1
        If flag_REDIR_DEBUG1 = &H0 Then write_REDIR_DEBUG1_value = get_REDIR_DEBUG1
        If flag_IG_CAPT_DEBU1 = &H0 Then write_IG_CAPT_DEBU1_value = get_IG_CAPT_DEBU1
        If flag_EG_CAPT_DEBU1 = &H0 Then write_EG_CAPT_DEBU1_value = get_EG_CAPT_DEBU1
        If flag_IG_TCAM_RAM1 = &H0 Then write_IG_TCAM_RAM1_value = get_IG_TCAM_RAM1
        If flag_EG_TCAM_RAM1 = &H0 Then write_EG_TCAM_RAM1_value = get_EG_TCAM_RAM1

        regValue = leftShift((write_IG_TRC_RAM_value and &H1), 0) + leftShift((write_IG_STAT_SA1_value and &H1), 1) + leftShift((write_IG_STAT_CLAS1_value and &H1), 2) + leftShift((write_IG_STAT_VPOR1_value and &H1), 3) + leftShift((write_IG_SAF_SC_RAM1_value and &H1), 4) + leftShift((write_IG_SAF_EC_RAM1_value and &H1), 5) + leftShift((write_IG_SAF_RAM1_value and &H1), 6) + leftShift((write_EG_TRC_RAM1_value and &H1), 7) + leftShift((write_EG_STAT_SA1_value and &H1), 8) + leftShift((write_EG_STAT_CLAS1_value and &H1), 9) + leftShift((write_EG_STAT_VPOR1_value and &H1), 10) + leftShift((write_EG_SAF_SC_RAM1_value and &H1), 11) + leftShift((write_EG_SAF_EC_RAM1_value and &H1), 12) + leftShift((write_EG_SAF_RAM1_value and &H1), 13) + leftShift((write_REDIR_DEBUG1_value and &H1), 14) + leftShift((write_IG_CAPT_DEBU1_value and &H1), 15) + leftShift((write_EG_CAPT_DEBU1_value and &H1), 16) + leftShift((write_IG_TCAM_RAM1_value and &H1), 17) + leftShift((write_EG_TCAM_RAM1_value and &H1), 18)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        IG_TRC_RAM_mask = &H1
        if data_low > LONG_MAX then
            if IG_TRC_RAM_mask = mask then
                read_IG_TRC_RAM_value = data_low
            else
                read_IG_TRC_RAM_value = (data_low - H8000_0000) and IG_TRC_RAM_mask
            end If
        else
            read_IG_TRC_RAM_value = data_low and IG_TRC_RAM_mask
        end If
        read_IG_STAT_SA1_value = rightShift(data_low, 1) and &H1
        read_IG_STAT_CLAS1_value = rightShift(data_low, 2) and &H1
        read_IG_STAT_VPOR1_value = rightShift(data_low, 3) and &H1
        read_IG_SAF_SC_RAM1_value = rightShift(data_low, 4) and &H1
        read_IG_SAF_EC_RAM1_value = rightShift(data_low, 5) and &H1
        read_IG_SAF_RAM1_value = rightShift(data_low, 6) and &H1
        read_EG_TRC_RAM1_value = rightShift(data_low, 7) and &H1
        read_EG_STAT_SA1_value = rightShift(data_low, 8) and &H1
        read_EG_STAT_CLAS1_value = rightShift(data_low, 9) and &H1
        read_EG_STAT_VPOR1_value = rightShift(data_low, 10) and &H1
        read_EG_SAF_SC_RAM1_value = rightShift(data_low, 11) and &H1
        read_EG_SAF_EC_RAM1_value = rightShift(data_low, 12) and &H1
        read_EG_SAF_RAM1_value = rightShift(data_low, 13) and &H1
        read_REDIR_DEBUG1_value = rightShift(data_low, 14) and &H1
        read_IG_CAPT_DEBU1_value = rightShift(data_low, 15) and &H1
        read_EG_CAPT_DEBU1_value = rightShift(data_low, 16) and &H1
        read_IG_TCAM_RAM1_value = rightShift(data_low, 17) and &H1
        read_EG_TCAM_RAM1_value = rightShift(data_low, 18) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_IG_TRC_RAM_value = &H0
        flag_IG_TRC_RAM        = &H0
        write_IG_STAT_SA1_value = &H0
        flag_IG_STAT_SA1        = &H0
        write_IG_STAT_CLAS1_value = &H0
        flag_IG_STAT_CLAS1        = &H0
        write_IG_STAT_VPOR1_value = &H0
        flag_IG_STAT_VPOR1        = &H0
        write_IG_SAF_SC_RAM1_value = &H0
        flag_IG_SAF_SC_RAM1        = &H0
        write_IG_SAF_EC_RAM1_value = &H0
        flag_IG_SAF_EC_RAM1        = &H0
        write_IG_SAF_RAM1_value = &H0
        flag_IG_SAF_RAM1        = &H0
        write_EG_TRC_RAM1_value = &H0
        flag_EG_TRC_RAM1        = &H0
        write_EG_STAT_SA1_value = &H0
        flag_EG_STAT_SA1        = &H0
        write_EG_STAT_CLAS1_value = &H0
        flag_EG_STAT_CLAS1        = &H0
        write_EG_STAT_VPOR1_value = &H0
        flag_EG_STAT_VPOR1        = &H0
        write_EG_SAF_SC_RAM1_value = &H0
        flag_EG_SAF_SC_RAM1        = &H0
        write_EG_SAF_EC_RAM1_value = &H0
        flag_EG_SAF_EC_RAM1        = &H0
        write_EG_SAF_RAM1_value = &H0
        flag_EG_SAF_RAM1        = &H0
        write_REDIR_DEBUG1_value = &H0
        flag_REDIR_DEBUG1        = &H0
        write_IG_CAPT_DEBU1_value = &H0
        flag_IG_CAPT_DEBU1        = &H0
        write_EG_CAPT_DEBU1_value = &H0
        flag_EG_CAPT_DEBU1        = &H0
        write_IG_TCAM_RAM1_value = &H0
        flag_IG_TCAM_RAM1        = &H0
        write_EG_TCAM_RAM1_value = &H0
        flag_EG_TCAM_RAM1        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class EIP165S_EIP_165S_32_BRCM_EIP_165_ECC_INSTANCE

    Public ecc_corrected_flags
    Public ecc_uncorrected_flags
    Public ecc_corrected_count
    Public ecc_uncorrected_count
    Public ecc_test_1
    Public ecc_test_2


    Public default function Init(aBaseAddr)
        Set ecc_corrected_flags = (New REGISTER_EIP165S_EIP_165S_32_BRCM_EIP_165_ECC_ecc_corrected_flags)(aBaseAddr, 32)
        Set ecc_uncorrected_flags = (New REGISTER_EIP165S_EIP_165S_32_BRCM_EIP_165_ECC_ecc_uncorrected_flags)(aBaseAddr, 32)
        Set ecc_corrected_count = (New REGISTER_EIP165S_EIP_165S_32_BRCM_EIP_165_ECC_ecc_corrected_count)(aBaseAddr, 32)
        Set ecc_uncorrected_count = (New REGISTER_EIP165S_EIP_165S_32_BRCM_EIP_165_ECC_ecc_uncorrected_count)(aBaseAddr, 32)
        Set ecc_test_1 = (New REGISTER_EIP165S_EIP_165S_32_BRCM_EIP_165_ECC_ecc_test_1)(aBaseAddr, 32)
        Set ecc_test_2 = (New REGISTER_EIP165S_EIP_165S_32_BRCM_EIP_165_ECC_ecc_test_2)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set EIP165S_EIP_165S_32_BRCM_EIP_165_ECC = CreateObject("System.Collections.ArrayList")
EIP165S_EIP_165S_32_BRCM_EIP_165_ECC.Add ((New EIP165S_EIP_165S_32_BRCM_EIP_165_ECC_INSTANCE)(&H4d010000))
EIP165S_EIP_165S_32_BRCM_EIP_165_ECC.Add ((New EIP165S_EIP_165S_32_BRCM_EIP_165_ECC_INSTANCE)(&H4d110000))
EIP165S_EIP_165S_32_BRCM_EIP_165_ECC.Add ((New EIP165S_EIP_165S_32_BRCM_EIP_165_ECC_INSTANCE)(&H4d210000))
EIP165S_EIP_165S_32_BRCM_EIP_165_ECC.Add ((New EIP165S_EIP_165S_32_BRCM_EIP_165_ECC_INSTANCE)(&H4d310000))
EIP165S_EIP_165S_32_BRCM_EIP_165_ECC.Add ((New EIP165S_EIP_165S_32_BRCM_EIP_165_ECC_INSTANCE)(&H4d410000))
EIP165S_EIP_165S_32_BRCM_EIP_165_ECC.Add ((New EIP165S_EIP_165S_32_BRCM_EIP_165_ECC_INSTANCE)(&H4d510000))


