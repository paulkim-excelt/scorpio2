

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


'' @REGISTER : CTF_ctf_control
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CTF_CONTROL_RESERVED                       [31:19]          get_CTF_CONTROL_RESERVED
''                                                             set_CTF_CONTROL_RESERVED
''                                                             read_CTF_CONTROL_RESERVED
''                                                             write_CTF_CONTROL_RESERVED
''---------------------------------------------------------------------------------
'' CTF_CONTROL_DISABLE_MAC_DA_CHECK           [18:18]          get_CTF_CONTROL_DISABLE_MAC_DA_CHECK
''                                                             set_CTF_CONTROL_DISABLE_MAC_DA_CHECK
''                                                             read_CTF_CONTROL_DISABLE_MAC_DA_CHECK
''                                                             write_CTF_CONTROL_DISABLE_MAC_DA_CHECK
''---------------------------------------------------------------------------------
'' CTF_CONTROL_HB_INIT                        [17:17]          get_CTF_CONTROL_HB_INIT
''                                                             set_CTF_CONTROL_HB_INIT
''                                                             read_CTF_CONTROL_HB_INIT
''                                                             write_CTF_CONTROL_HB_INIT
''---------------------------------------------------------------------------------
'' CTF_CONTROL_LAB_INIT                       [16:16]          get_CTF_CONTROL_LAB_INIT
''                                                             set_CTF_CONTROL_LAB_INIT
''                                                             read_CTF_CONTROL_LAB_INIT
''                                                             write_CTF_CONTROL_LAB_INIT
''---------------------------------------------------------------------------------
'' CTF_CONTROL_HWQ_INIT                       [15:15]          get_CTF_CONTROL_HWQ_INIT
''                                                             set_CTF_CONTROL_HWQ_INIT
''                                                             read_CTF_CONTROL_HWQ_INIT
''                                                             write_CTF_CONTROL_HWQ_INIT
''---------------------------------------------------------------------------------
'' CTF_CONTROL_NEXT_HOP_INIT                  [14:14]          get_CTF_CONTROL_NEXT_HOP_INIT
''                                                             set_CTF_CONTROL_NEXT_HOP_INIT
''                                                             read_CTF_CONTROL_NEXT_HOP_INIT
''                                                             write_CTF_CONTROL_NEXT_HOP_INIT
''---------------------------------------------------------------------------------
'' CTF_CONTROL_NAPT_FLOW_INIT                 [13:13]          get_CTF_CONTROL_NAPT_FLOW_INIT
''                                                             set_CTF_CONTROL_NAPT_FLOW_INIT
''                                                             read_CTF_CONTROL_NAPT_FLOW_INIT
''                                                             write_CTF_CONTROL_NAPT_FLOW_INIT
''---------------------------------------------------------------------------------
'' CTF_CONTROL_HWQ_THRESHOLD                  [12:4]           get_CTF_CONTROL_HWQ_THRESHOLD
''                                                             set_CTF_CONTROL_HWQ_THRESHOLD
''                                                             read_CTF_CONTROL_HWQ_THRESHOLD
''                                                             write_CTF_CONTROL_HWQ_THRESHOLD
''---------------------------------------------------------------------------------
'' CTF_CONTROL_CRC_OWRT_CONFIG                [3:3]            get_CTF_CONTROL_CRC_OWRT_CONFIG
''                                                             set_CTF_CONTROL_CRC_OWRT_CONFIG
''                                                             read_CTF_CONTROL_CRC_OWRT_CONFIG
''                                                             write_CTF_CONTROL_CRC_OWRT_CONFIG
''---------------------------------------------------------------------------------
'' CTF_CONTROL_CRC_FWD_CONFIG                 [2:2]            get_CTF_CONTROL_CRC_FWD_CONFIG
''                                                             set_CTF_CONTROL_CRC_FWD_CONFIG
''                                                             read_CTF_CONTROL_CRC_FWD_CONFIG
''                                                             write_CTF_CONTROL_CRC_FWD_CONFIG
''---------------------------------------------------------------------------------
'' CTF_CONTROL_BYPASS_CTF                     [1:1]            get_CTF_CONTROL_BYPASS_CTF
''                                                             set_CTF_CONTROL_BYPASS_CTF
''                                                             read_CTF_CONTROL_BYPASS_CTF
''                                                             write_CTF_CONTROL_BYPASS_CTF
''---------------------------------------------------------------------------------
'' CTF_CONTROL_ACCELERATOR_MODE               [0:0]            get_CTF_CONTROL_ACCELERATOR_MODE
''                                                             set_CTF_CONTROL_ACCELERATOR_MODE
''                                                             read_CTF_CONTROL_ACCELERATOR_MODE
''                                                             write_CTF_CONTROL_ACCELERATOR_MODE
''---------------------------------------------------------------------------------
Class REGISTER_CTF_ctf_control
    Private write_CTF_CONTROL_RESERVED_value
    Private read_CTF_CONTROL_RESERVED_value
    Private flag_CTF_CONTROL_RESERVED
    Private write_CTF_CONTROL_DISABLE_MAC_DA_CHECK_value
    Private read_CTF_CONTROL_DISABLE_MAC_DA_CHECK_value
    Private flag_CTF_CONTROL_DISABLE_MAC_DA_CHECK
    Private write_CTF_CONTROL_HB_INIT_value
    Private read_CTF_CONTROL_HB_INIT_value
    Private flag_CTF_CONTROL_HB_INIT
    Private write_CTF_CONTROL_LAB_INIT_value
    Private read_CTF_CONTROL_LAB_INIT_value
    Private flag_CTF_CONTROL_LAB_INIT
    Private write_CTF_CONTROL_HWQ_INIT_value
    Private read_CTF_CONTROL_HWQ_INIT_value
    Private flag_CTF_CONTROL_HWQ_INIT
    Private write_CTF_CONTROL_NEXT_HOP_INIT_value
    Private read_CTF_CONTROL_NEXT_HOP_INIT_value
    Private flag_CTF_CONTROL_NEXT_HOP_INIT
    Private write_CTF_CONTROL_NAPT_FLOW_INIT_value
    Private read_CTF_CONTROL_NAPT_FLOW_INIT_value
    Private flag_CTF_CONTROL_NAPT_FLOW_INIT
    Private write_CTF_CONTROL_HWQ_THRESHOLD_value
    Private read_CTF_CONTROL_HWQ_THRESHOLD_value
    Private flag_CTF_CONTROL_HWQ_THRESHOLD
    Private write_CTF_CONTROL_CRC_OWRT_CONFIG_value
    Private read_CTF_CONTROL_CRC_OWRT_CONFIG_value
    Private flag_CTF_CONTROL_CRC_OWRT_CONFIG
    Private write_CTF_CONTROL_CRC_FWD_CONFIG_value
    Private read_CTF_CONTROL_CRC_FWD_CONFIG_value
    Private flag_CTF_CONTROL_CRC_FWD_CONFIG
    Private write_CTF_CONTROL_BYPASS_CTF_value
    Private read_CTF_CONTROL_BYPASS_CTF_value
    Private flag_CTF_CONTROL_BYPASS_CTF
    Private write_CTF_CONTROL_ACCELERATOR_MODE_value
    Private read_CTF_CONTROL_ACCELERATOR_MODE_value
    Private flag_CTF_CONTROL_ACCELERATOR_MODE

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

    Property Get get_CTF_CONTROL_RESERVED
        get_CTF_CONTROL_RESERVED = read_CTF_CONTROL_RESERVED_value
    End Property

    Property Let set_CTF_CONTROL_RESERVED(aData)
        write_CTF_CONTROL_RESERVED_value = aData
        flag_CTF_CONTROL_RESERVED        = &H1
    End Property

    Property Get read_CTF_CONTROL_RESERVED
        read
        read_CTF_CONTROL_RESERVED = read_CTF_CONTROL_RESERVED_value
    End Property

    Property Let write_CTF_CONTROL_RESERVED(aData)
        set_CTF_CONTROL_RESERVED = aData
        write
    End Property

    Property Get get_CTF_CONTROL_DISABLE_MAC_DA_CHECK
        get_CTF_CONTROL_DISABLE_MAC_DA_CHECK = read_CTF_CONTROL_DISABLE_MAC_DA_CHECK_value
    End Property

    Property Let set_CTF_CONTROL_DISABLE_MAC_DA_CHECK(aData)
        write_CTF_CONTROL_DISABLE_MAC_DA_CHECK_value = aData
        flag_CTF_CONTROL_DISABLE_MAC_DA_CHECK        = &H1
    End Property

    Property Get read_CTF_CONTROL_DISABLE_MAC_DA_CHECK
        read
        read_CTF_CONTROL_DISABLE_MAC_DA_CHECK = read_CTF_CONTROL_DISABLE_MAC_DA_CHECK_value
    End Property

    Property Let write_CTF_CONTROL_DISABLE_MAC_DA_CHECK(aData)
        set_CTF_CONTROL_DISABLE_MAC_DA_CHECK = aData
        write
    End Property

    Property Get get_CTF_CONTROL_HB_INIT
        get_CTF_CONTROL_HB_INIT = read_CTF_CONTROL_HB_INIT_value
    End Property

    Property Let set_CTF_CONTROL_HB_INIT(aData)
        write_CTF_CONTROL_HB_INIT_value = aData
        flag_CTF_CONTROL_HB_INIT        = &H1
    End Property

    Property Get read_CTF_CONTROL_HB_INIT
        read
        read_CTF_CONTROL_HB_INIT = read_CTF_CONTROL_HB_INIT_value
    End Property

    Property Let write_CTF_CONTROL_HB_INIT(aData)
        set_CTF_CONTROL_HB_INIT = aData
        write
    End Property

    Property Get get_CTF_CONTROL_LAB_INIT
        get_CTF_CONTROL_LAB_INIT = read_CTF_CONTROL_LAB_INIT_value
    End Property

    Property Let set_CTF_CONTROL_LAB_INIT(aData)
        write_CTF_CONTROL_LAB_INIT_value = aData
        flag_CTF_CONTROL_LAB_INIT        = &H1
    End Property

    Property Get read_CTF_CONTROL_LAB_INIT
        read
        read_CTF_CONTROL_LAB_INIT = read_CTF_CONTROL_LAB_INIT_value
    End Property

    Property Let write_CTF_CONTROL_LAB_INIT(aData)
        set_CTF_CONTROL_LAB_INIT = aData
        write
    End Property

    Property Get get_CTF_CONTROL_HWQ_INIT
        get_CTF_CONTROL_HWQ_INIT = read_CTF_CONTROL_HWQ_INIT_value
    End Property

    Property Let set_CTF_CONTROL_HWQ_INIT(aData)
        write_CTF_CONTROL_HWQ_INIT_value = aData
        flag_CTF_CONTROL_HWQ_INIT        = &H1
    End Property

    Property Get read_CTF_CONTROL_HWQ_INIT
        read
        read_CTF_CONTROL_HWQ_INIT = read_CTF_CONTROL_HWQ_INIT_value
    End Property

    Property Let write_CTF_CONTROL_HWQ_INIT(aData)
        set_CTF_CONTROL_HWQ_INIT = aData
        write
    End Property

    Property Get get_CTF_CONTROL_NEXT_HOP_INIT
        get_CTF_CONTROL_NEXT_HOP_INIT = read_CTF_CONTROL_NEXT_HOP_INIT_value
    End Property

    Property Let set_CTF_CONTROL_NEXT_HOP_INIT(aData)
        write_CTF_CONTROL_NEXT_HOP_INIT_value = aData
        flag_CTF_CONTROL_NEXT_HOP_INIT        = &H1
    End Property

    Property Get read_CTF_CONTROL_NEXT_HOP_INIT
        read
        read_CTF_CONTROL_NEXT_HOP_INIT = read_CTF_CONTROL_NEXT_HOP_INIT_value
    End Property

    Property Let write_CTF_CONTROL_NEXT_HOP_INIT(aData)
        set_CTF_CONTROL_NEXT_HOP_INIT = aData
        write
    End Property

    Property Get get_CTF_CONTROL_NAPT_FLOW_INIT
        get_CTF_CONTROL_NAPT_FLOW_INIT = read_CTF_CONTROL_NAPT_FLOW_INIT_value
    End Property

    Property Let set_CTF_CONTROL_NAPT_FLOW_INIT(aData)
        write_CTF_CONTROL_NAPT_FLOW_INIT_value = aData
        flag_CTF_CONTROL_NAPT_FLOW_INIT        = &H1
    End Property

    Property Get read_CTF_CONTROL_NAPT_FLOW_INIT
        read
        read_CTF_CONTROL_NAPT_FLOW_INIT = read_CTF_CONTROL_NAPT_FLOW_INIT_value
    End Property

    Property Let write_CTF_CONTROL_NAPT_FLOW_INIT(aData)
        set_CTF_CONTROL_NAPT_FLOW_INIT = aData
        write
    End Property

    Property Get get_CTF_CONTROL_HWQ_THRESHOLD
        get_CTF_CONTROL_HWQ_THRESHOLD = read_CTF_CONTROL_HWQ_THRESHOLD_value
    End Property

    Property Let set_CTF_CONTROL_HWQ_THRESHOLD(aData)
        write_CTF_CONTROL_HWQ_THRESHOLD_value = aData
        flag_CTF_CONTROL_HWQ_THRESHOLD        = &H1
    End Property

    Property Get read_CTF_CONTROL_HWQ_THRESHOLD
        read
        read_CTF_CONTROL_HWQ_THRESHOLD = read_CTF_CONTROL_HWQ_THRESHOLD_value
    End Property

    Property Let write_CTF_CONTROL_HWQ_THRESHOLD(aData)
        set_CTF_CONTROL_HWQ_THRESHOLD = aData
        write
    End Property

    Property Get get_CTF_CONTROL_CRC_OWRT_CONFIG
        get_CTF_CONTROL_CRC_OWRT_CONFIG = read_CTF_CONTROL_CRC_OWRT_CONFIG_value
    End Property

    Property Let set_CTF_CONTROL_CRC_OWRT_CONFIG(aData)
        write_CTF_CONTROL_CRC_OWRT_CONFIG_value = aData
        flag_CTF_CONTROL_CRC_OWRT_CONFIG        = &H1
    End Property

    Property Get read_CTF_CONTROL_CRC_OWRT_CONFIG
        read
        read_CTF_CONTROL_CRC_OWRT_CONFIG = read_CTF_CONTROL_CRC_OWRT_CONFIG_value
    End Property

    Property Let write_CTF_CONTROL_CRC_OWRT_CONFIG(aData)
        set_CTF_CONTROL_CRC_OWRT_CONFIG = aData
        write
    End Property

    Property Get get_CTF_CONTROL_CRC_FWD_CONFIG
        get_CTF_CONTROL_CRC_FWD_CONFIG = read_CTF_CONTROL_CRC_FWD_CONFIG_value
    End Property

    Property Let set_CTF_CONTROL_CRC_FWD_CONFIG(aData)
        write_CTF_CONTROL_CRC_FWD_CONFIG_value = aData
        flag_CTF_CONTROL_CRC_FWD_CONFIG        = &H1
    End Property

    Property Get read_CTF_CONTROL_CRC_FWD_CONFIG
        read
        read_CTF_CONTROL_CRC_FWD_CONFIG = read_CTF_CONTROL_CRC_FWD_CONFIG_value
    End Property

    Property Let write_CTF_CONTROL_CRC_FWD_CONFIG(aData)
        set_CTF_CONTROL_CRC_FWD_CONFIG = aData
        write
    End Property

    Property Get get_CTF_CONTROL_BYPASS_CTF
        get_CTF_CONTROL_BYPASS_CTF = read_CTF_CONTROL_BYPASS_CTF_value
    End Property

    Property Let set_CTF_CONTROL_BYPASS_CTF(aData)
        write_CTF_CONTROL_BYPASS_CTF_value = aData
        flag_CTF_CONTROL_BYPASS_CTF        = &H1
    End Property

    Property Get read_CTF_CONTROL_BYPASS_CTF
        read
        read_CTF_CONTROL_BYPASS_CTF = read_CTF_CONTROL_BYPASS_CTF_value
    End Property

    Property Let write_CTF_CONTROL_BYPASS_CTF(aData)
        set_CTF_CONTROL_BYPASS_CTF = aData
        write
    End Property

    Property Get get_CTF_CONTROL_ACCELERATOR_MODE
        get_CTF_CONTROL_ACCELERATOR_MODE = read_CTF_CONTROL_ACCELERATOR_MODE_value
    End Property

    Property Let set_CTF_CONTROL_ACCELERATOR_MODE(aData)
        write_CTF_CONTROL_ACCELERATOR_MODE_value = aData
        flag_CTF_CONTROL_ACCELERATOR_MODE        = &H1
    End Property

    Property Get read_CTF_CONTROL_ACCELERATOR_MODE
        read
        read_CTF_CONTROL_ACCELERATOR_MODE = read_CTF_CONTROL_ACCELERATOR_MODE_value
    End Property

    Property Let write_CTF_CONTROL_ACCELERATOR_MODE(aData)
        set_CTF_CONTROL_ACCELERATOR_MODE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CTF_CONTROL_RESERVED_value = rightShift(data_low, 19) and &H1fff
        read_CTF_CONTROL_DISABLE_MAC_DA_CHECK_value = rightShift(data_low, 18) and &H1
        read_CTF_CONTROL_HB_INIT_value = rightShift(data_low, 17) and &H1
        read_CTF_CONTROL_LAB_INIT_value = rightShift(data_low, 16) and &H1
        read_CTF_CONTROL_HWQ_INIT_value = rightShift(data_low, 15) and &H1
        read_CTF_CONTROL_NEXT_HOP_INIT_value = rightShift(data_low, 14) and &H1
        read_CTF_CONTROL_NAPT_FLOW_INIT_value = rightShift(data_low, 13) and &H1
        read_CTF_CONTROL_HWQ_THRESHOLD_value = rightShift(data_low, 4) and &H1ff
        read_CTF_CONTROL_CRC_OWRT_CONFIG_value = rightShift(data_low, 3) and &H1
        read_CTF_CONTROL_CRC_FWD_CONFIG_value = rightShift(data_low, 2) and &H1
        read_CTF_CONTROL_BYPASS_CTF_value = rightShift(data_low, 1) and &H1
        CTF_CONTROL_ACCELERATOR_MODE_mask = &H1
        if data_low > LONG_MAX then
            if CTF_CONTROL_ACCELERATOR_MODE_mask = mask then
                read_CTF_CONTROL_ACCELERATOR_MODE_value = data_low
            else
                read_CTF_CONTROL_ACCELERATOR_MODE_value = (data_low - H8000_0000) and CTF_CONTROL_ACCELERATOR_MODE_mask
            end If
        else
            read_CTF_CONTROL_ACCELERATOR_MODE_value = data_low and CTF_CONTROL_ACCELERATOR_MODE_mask
        end If

    End Sub

    Sub write
        If flag_CTF_CONTROL_RESERVED = &H0 or flag_CTF_CONTROL_DISABLE_MAC_DA_CHECK = &H0 or flag_CTF_CONTROL_HB_INIT = &H0 or flag_CTF_CONTROL_LAB_INIT = &H0 or flag_CTF_CONTROL_HWQ_INIT = &H0 or flag_CTF_CONTROL_NEXT_HOP_INIT = &H0 or flag_CTF_CONTROL_NAPT_FLOW_INIT = &H0 or flag_CTF_CONTROL_HWQ_THRESHOLD = &H0 or flag_CTF_CONTROL_CRC_OWRT_CONFIG = &H0 or flag_CTF_CONTROL_CRC_FWD_CONFIG = &H0 or flag_CTF_CONTROL_BYPASS_CTF = &H0 or flag_CTF_CONTROL_ACCELERATOR_MODE = &H0 Then read
        If flag_CTF_CONTROL_RESERVED = &H0 Then write_CTF_CONTROL_RESERVED_value = get_CTF_CONTROL_RESERVED
        If flag_CTF_CONTROL_DISABLE_MAC_DA_CHECK = &H0 Then write_CTF_CONTROL_DISABLE_MAC_DA_CHECK_value = get_CTF_CONTROL_DISABLE_MAC_DA_CHECK
        If flag_CTF_CONTROL_HB_INIT = &H0 Then write_CTF_CONTROL_HB_INIT_value = get_CTF_CONTROL_HB_INIT
        If flag_CTF_CONTROL_LAB_INIT = &H0 Then write_CTF_CONTROL_LAB_INIT_value = get_CTF_CONTROL_LAB_INIT
        If flag_CTF_CONTROL_HWQ_INIT = &H0 Then write_CTF_CONTROL_HWQ_INIT_value = get_CTF_CONTROL_HWQ_INIT
        If flag_CTF_CONTROL_NEXT_HOP_INIT = &H0 Then write_CTF_CONTROL_NEXT_HOP_INIT_value = get_CTF_CONTROL_NEXT_HOP_INIT
        If flag_CTF_CONTROL_NAPT_FLOW_INIT = &H0 Then write_CTF_CONTROL_NAPT_FLOW_INIT_value = get_CTF_CONTROL_NAPT_FLOW_INIT
        If flag_CTF_CONTROL_HWQ_THRESHOLD = &H0 Then write_CTF_CONTROL_HWQ_THRESHOLD_value = get_CTF_CONTROL_HWQ_THRESHOLD
        If flag_CTF_CONTROL_CRC_OWRT_CONFIG = &H0 Then write_CTF_CONTROL_CRC_OWRT_CONFIG_value = get_CTF_CONTROL_CRC_OWRT_CONFIG
        If flag_CTF_CONTROL_CRC_FWD_CONFIG = &H0 Then write_CTF_CONTROL_CRC_FWD_CONFIG_value = get_CTF_CONTROL_CRC_FWD_CONFIG
        If flag_CTF_CONTROL_BYPASS_CTF = &H0 Then write_CTF_CONTROL_BYPASS_CTF_value = get_CTF_CONTROL_BYPASS_CTF
        If flag_CTF_CONTROL_ACCELERATOR_MODE = &H0 Then write_CTF_CONTROL_ACCELERATOR_MODE_value = get_CTF_CONTROL_ACCELERATOR_MODE

        regValue = leftShift((write_CTF_CONTROL_RESERVED_value and &H1fff), 19) + leftShift((write_CTF_CONTROL_DISABLE_MAC_DA_CHECK_value and &H1), 18) + leftShift((write_CTF_CONTROL_HB_INIT_value and &H1), 17) + leftShift((write_CTF_CONTROL_LAB_INIT_value and &H1), 16) + leftShift((write_CTF_CONTROL_HWQ_INIT_value and &H1), 15) + leftShift((write_CTF_CONTROL_NEXT_HOP_INIT_value and &H1), 14) + leftShift((write_CTF_CONTROL_NAPT_FLOW_INIT_value and &H1), 13) + leftShift((write_CTF_CONTROL_HWQ_THRESHOLD_value and &H1ff), 4) + leftShift((write_CTF_CONTROL_CRC_OWRT_CONFIG_value and &H1), 3) + leftShift((write_CTF_CONTROL_CRC_FWD_CONFIG_value and &H1), 2) + leftShift((write_CTF_CONTROL_BYPASS_CTF_value and &H1), 1) + leftShift((write_CTF_CONTROL_ACCELERATOR_MODE_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CTF_CONTROL_RESERVED_value = rightShift(data_low, 19) and &H1fff
        read_CTF_CONTROL_DISABLE_MAC_DA_CHECK_value = rightShift(data_low, 18) and &H1
        read_CTF_CONTROL_HB_INIT_value = rightShift(data_low, 17) and &H1
        read_CTF_CONTROL_LAB_INIT_value = rightShift(data_low, 16) and &H1
        read_CTF_CONTROL_HWQ_INIT_value = rightShift(data_low, 15) and &H1
        read_CTF_CONTROL_NEXT_HOP_INIT_value = rightShift(data_low, 14) and &H1
        read_CTF_CONTROL_NAPT_FLOW_INIT_value = rightShift(data_low, 13) and &H1
        read_CTF_CONTROL_HWQ_THRESHOLD_value = rightShift(data_low, 4) and &H1ff
        read_CTF_CONTROL_CRC_OWRT_CONFIG_value = rightShift(data_low, 3) and &H1
        read_CTF_CONTROL_CRC_FWD_CONFIG_value = rightShift(data_low, 2) and &H1
        read_CTF_CONTROL_BYPASS_CTF_value = rightShift(data_low, 1) and &H1
        CTF_CONTROL_ACCELERATOR_MODE_mask = &H1
        if data_low > LONG_MAX then
            if CTF_CONTROL_ACCELERATOR_MODE_mask = mask then
                read_CTF_CONTROL_ACCELERATOR_MODE_value = data_low
            else
                read_CTF_CONTROL_ACCELERATOR_MODE_value = (data_low - H8000_0000) and CTF_CONTROL_ACCELERATOR_MODE_mask
            end If
        else
            read_CTF_CONTROL_ACCELERATOR_MODE_value = data_low and CTF_CONTROL_ACCELERATOR_MODE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CTF_CONTROL_RESERVED_value = &H0
        flag_CTF_CONTROL_RESERVED        = &H0
        write_CTF_CONTROL_DISABLE_MAC_DA_CHECK_value = &H0
        flag_CTF_CONTROL_DISABLE_MAC_DA_CHECK        = &H0
        write_CTF_CONTROL_HB_INIT_value = &H0
        flag_CTF_CONTROL_HB_INIT        = &H0
        write_CTF_CONTROL_LAB_INIT_value = &H0
        flag_CTF_CONTROL_LAB_INIT        = &H0
        write_CTF_CONTROL_HWQ_INIT_value = &H0
        flag_CTF_CONTROL_HWQ_INIT        = &H0
        write_CTF_CONTROL_NEXT_HOP_INIT_value = &H0
        flag_CTF_CONTROL_NEXT_HOP_INIT        = &H0
        write_CTF_CONTROL_NAPT_FLOW_INIT_value = &H0
        flag_CTF_CONTROL_NAPT_FLOW_INIT        = &H0
        write_CTF_CONTROL_HWQ_THRESHOLD_value = &H0
        flag_CTF_CONTROL_HWQ_THRESHOLD        = &H0
        write_CTF_CONTROL_CRC_OWRT_CONFIG_value = &H0
        flag_CTF_CONTROL_CRC_OWRT_CONFIG        = &H0
        write_CTF_CONTROL_CRC_FWD_CONFIG_value = &H0
        flag_CTF_CONTROL_CRC_FWD_CONFIG        = &H0
        write_CTF_CONTROL_BYPASS_CTF_value = &H0
        flag_CTF_CONTROL_BYPASS_CTF        = &H0
        write_CTF_CONTROL_ACCELERATOR_MODE_value = &H0
        flag_CTF_CONTROL_ACCELERATOR_MODE        = &H0
    End Sub
End Class


'' @REGISTER : CTF_ctf_mem_acc_control
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CTF_MEM_ACC_CONTROL_RESERVED               [31:23]          get_CTF_MEM_ACC_CONTROL_RESERVED
''                                                             set_CTF_MEM_ACC_CONTROL_RESERVED
''                                                             read_CTF_MEM_ACC_CONTROL_RESERVED
''                                                             write_CTF_MEM_ACC_CONTROL_RESERVED
''---------------------------------------------------------------------------------
'' CTF_MEM_ACC_CONTROL_CURRENT_TABLE_INDEX    [22:13]          get_CTF_MEM_ACC_CONTROL_CURRENT_TABLE_INDEX
''                                                             set_CTF_MEM_ACC_CONTROL_CURRENT_TABLE_INDEX
''                                                             read_CTF_MEM_ACC_CONTROL_CURRENT_TABLE_INDEX
''                                                             write_CTF_MEM_ACC_CONTROL_CURRENT_TABLE_INDEX
''---------------------------------------------------------------------------------
'' CTF_MEM_ACC_CONTROL_RD_WR_N                [12:12]          get_CTF_MEM_ACC_CONTROL_RD_WR_N
''                                                             set_CTF_MEM_ACC_CONTROL_RD_WR_N
''                                                             read_CTF_MEM_ACC_CONTROL_RD_WR_N
''                                                             write_CTF_MEM_ACC_CONTROL_RD_WR_N
''---------------------------------------------------------------------------------
'' CTF_MEM_ACC_CONTROL_TABLE_SELECT           [11:10]          get_CTF_MEM_ACC_CONTROL_TABLE_SELECT
''                                                             set_CTF_MEM_ACC_CONTROL_TABLE_SELECT
''                                                             read_CTF_MEM_ACC_CONTROL_TABLE_SELECT
''                                                             write_CTF_MEM_ACC_CONTROL_TABLE_SELECT
''---------------------------------------------------------------------------------
'' CTF_MEM_ACC_CONTROL_TABLE_INDEX            [9:0]            get_CTF_MEM_ACC_CONTROL_TABLE_INDEX
''                                                             set_CTF_MEM_ACC_CONTROL_TABLE_INDEX
''                                                             read_CTF_MEM_ACC_CONTROL_TABLE_INDEX
''                                                             write_CTF_MEM_ACC_CONTROL_TABLE_INDEX
''---------------------------------------------------------------------------------
Class REGISTER_CTF_ctf_mem_acc_control
    Private write_CTF_MEM_ACC_CONTROL_RESERVED_value
    Private read_CTF_MEM_ACC_CONTROL_RESERVED_value
    Private flag_CTF_MEM_ACC_CONTROL_RESERVED
    Private write_CTF_MEM_ACC_CONTROL_CURRENT_TABLE_INDEX_value
    Private read_CTF_MEM_ACC_CONTROL_CURRENT_TABLE_INDEX_value
    Private flag_CTF_MEM_ACC_CONTROL_CURRENT_TABLE_INDEX
    Private write_CTF_MEM_ACC_CONTROL_RD_WR_N_value
    Private read_CTF_MEM_ACC_CONTROL_RD_WR_N_value
    Private flag_CTF_MEM_ACC_CONTROL_RD_WR_N
    Private write_CTF_MEM_ACC_CONTROL_TABLE_SELECT_value
    Private read_CTF_MEM_ACC_CONTROL_TABLE_SELECT_value
    Private flag_CTF_MEM_ACC_CONTROL_TABLE_SELECT
    Private write_CTF_MEM_ACC_CONTROL_TABLE_INDEX_value
    Private read_CTF_MEM_ACC_CONTROL_TABLE_INDEX_value
    Private flag_CTF_MEM_ACC_CONTROL_TABLE_INDEX

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

    Property Get get_CTF_MEM_ACC_CONTROL_RESERVED
        get_CTF_MEM_ACC_CONTROL_RESERVED = read_CTF_MEM_ACC_CONTROL_RESERVED_value
    End Property

    Property Let set_CTF_MEM_ACC_CONTROL_RESERVED(aData)
        write_CTF_MEM_ACC_CONTROL_RESERVED_value = aData
        flag_CTF_MEM_ACC_CONTROL_RESERVED        = &H1
    End Property

    Property Get read_CTF_MEM_ACC_CONTROL_RESERVED
        read
        read_CTF_MEM_ACC_CONTROL_RESERVED = read_CTF_MEM_ACC_CONTROL_RESERVED_value
    End Property

    Property Let write_CTF_MEM_ACC_CONTROL_RESERVED(aData)
        set_CTF_MEM_ACC_CONTROL_RESERVED = aData
        write
    End Property

    Property Get get_CTF_MEM_ACC_CONTROL_CURRENT_TABLE_INDEX
        get_CTF_MEM_ACC_CONTROL_CURRENT_TABLE_INDEX = read_CTF_MEM_ACC_CONTROL_CURRENT_TABLE_INDEX_value
    End Property

    Property Let set_CTF_MEM_ACC_CONTROL_CURRENT_TABLE_INDEX(aData)
        write_CTF_MEM_ACC_CONTROL_CURRENT_TABLE_INDEX_value = aData
        flag_CTF_MEM_ACC_CONTROL_CURRENT_TABLE_INDEX        = &H1
    End Property

    Property Get read_CTF_MEM_ACC_CONTROL_CURRENT_TABLE_INDEX
        read
        read_CTF_MEM_ACC_CONTROL_CURRENT_TABLE_INDEX = read_CTF_MEM_ACC_CONTROL_CURRENT_TABLE_INDEX_value
    End Property

    Property Let write_CTF_MEM_ACC_CONTROL_CURRENT_TABLE_INDEX(aData)
        set_CTF_MEM_ACC_CONTROL_CURRENT_TABLE_INDEX = aData
        write
    End Property

    Property Get get_CTF_MEM_ACC_CONTROL_RD_WR_N
        get_CTF_MEM_ACC_CONTROL_RD_WR_N = read_CTF_MEM_ACC_CONTROL_RD_WR_N_value
    End Property

    Property Let set_CTF_MEM_ACC_CONTROL_RD_WR_N(aData)
        write_CTF_MEM_ACC_CONTROL_RD_WR_N_value = aData
        flag_CTF_MEM_ACC_CONTROL_RD_WR_N        = &H1
    End Property

    Property Get read_CTF_MEM_ACC_CONTROL_RD_WR_N
        read
        read_CTF_MEM_ACC_CONTROL_RD_WR_N = read_CTF_MEM_ACC_CONTROL_RD_WR_N_value
    End Property

    Property Let write_CTF_MEM_ACC_CONTROL_RD_WR_N(aData)
        set_CTF_MEM_ACC_CONTROL_RD_WR_N = aData
        write
    End Property

    Property Get get_CTF_MEM_ACC_CONTROL_TABLE_SELECT
        get_CTF_MEM_ACC_CONTROL_TABLE_SELECT = read_CTF_MEM_ACC_CONTROL_TABLE_SELECT_value
    End Property

    Property Let set_CTF_MEM_ACC_CONTROL_TABLE_SELECT(aData)
        write_CTF_MEM_ACC_CONTROL_TABLE_SELECT_value = aData
        flag_CTF_MEM_ACC_CONTROL_TABLE_SELECT        = &H1
    End Property

    Property Get read_CTF_MEM_ACC_CONTROL_TABLE_SELECT
        read
        read_CTF_MEM_ACC_CONTROL_TABLE_SELECT = read_CTF_MEM_ACC_CONTROL_TABLE_SELECT_value
    End Property

    Property Let write_CTF_MEM_ACC_CONTROL_TABLE_SELECT(aData)
        set_CTF_MEM_ACC_CONTROL_TABLE_SELECT = aData
        write
    End Property

    Property Get get_CTF_MEM_ACC_CONTROL_TABLE_INDEX
        get_CTF_MEM_ACC_CONTROL_TABLE_INDEX = read_CTF_MEM_ACC_CONTROL_TABLE_INDEX_value
    End Property

    Property Let set_CTF_MEM_ACC_CONTROL_TABLE_INDEX(aData)
        write_CTF_MEM_ACC_CONTROL_TABLE_INDEX_value = aData
        flag_CTF_MEM_ACC_CONTROL_TABLE_INDEX        = &H1
    End Property

    Property Get read_CTF_MEM_ACC_CONTROL_TABLE_INDEX
        read
        read_CTF_MEM_ACC_CONTROL_TABLE_INDEX = read_CTF_MEM_ACC_CONTROL_TABLE_INDEX_value
    End Property

    Property Let write_CTF_MEM_ACC_CONTROL_TABLE_INDEX(aData)
        set_CTF_MEM_ACC_CONTROL_TABLE_INDEX = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CTF_MEM_ACC_CONTROL_RESERVED_value = rightShift(data_low, 23) and &H1ff
        read_CTF_MEM_ACC_CONTROL_CURRENT_TABLE_INDEX_value = rightShift(data_low, 13) and &H3ff
        read_CTF_MEM_ACC_CONTROL_RD_WR_N_value = rightShift(data_low, 12) and &H1
        read_CTF_MEM_ACC_CONTROL_TABLE_SELECT_value = rightShift(data_low, 10) and &H3
        CTF_MEM_ACC_CONTROL_TABLE_INDEX_mask = &H3ff
        if data_low > LONG_MAX then
            if CTF_MEM_ACC_CONTROL_TABLE_INDEX_mask = mask then
                read_CTF_MEM_ACC_CONTROL_TABLE_INDEX_value = data_low
            else
                read_CTF_MEM_ACC_CONTROL_TABLE_INDEX_value = (data_low - H8000_0000) and CTF_MEM_ACC_CONTROL_TABLE_INDEX_mask
            end If
        else
            read_CTF_MEM_ACC_CONTROL_TABLE_INDEX_value = data_low and CTF_MEM_ACC_CONTROL_TABLE_INDEX_mask
        end If

    End Sub

    Sub write
        If flag_CTF_MEM_ACC_CONTROL_RESERVED = &H0 or flag_CTF_MEM_ACC_CONTROL_CURRENT_TABLE_INDEX = &H0 or flag_CTF_MEM_ACC_CONTROL_RD_WR_N = &H0 or flag_CTF_MEM_ACC_CONTROL_TABLE_SELECT = &H0 or flag_CTF_MEM_ACC_CONTROL_TABLE_INDEX = &H0 Then read
        If flag_CTF_MEM_ACC_CONTROL_RESERVED = &H0 Then write_CTF_MEM_ACC_CONTROL_RESERVED_value = get_CTF_MEM_ACC_CONTROL_RESERVED
        If flag_CTF_MEM_ACC_CONTROL_CURRENT_TABLE_INDEX = &H0 Then write_CTF_MEM_ACC_CONTROL_CURRENT_TABLE_INDEX_value = get_CTF_MEM_ACC_CONTROL_CURRENT_TABLE_INDEX
        If flag_CTF_MEM_ACC_CONTROL_RD_WR_N = &H0 Then write_CTF_MEM_ACC_CONTROL_RD_WR_N_value = get_CTF_MEM_ACC_CONTROL_RD_WR_N
        If flag_CTF_MEM_ACC_CONTROL_TABLE_SELECT = &H0 Then write_CTF_MEM_ACC_CONTROL_TABLE_SELECT_value = get_CTF_MEM_ACC_CONTROL_TABLE_SELECT
        If flag_CTF_MEM_ACC_CONTROL_TABLE_INDEX = &H0 Then write_CTF_MEM_ACC_CONTROL_TABLE_INDEX_value = get_CTF_MEM_ACC_CONTROL_TABLE_INDEX

        regValue = leftShift((write_CTF_MEM_ACC_CONTROL_RESERVED_value and &H1ff), 23) + leftShift((write_CTF_MEM_ACC_CONTROL_CURRENT_TABLE_INDEX_value and &H3ff), 13) + leftShift((write_CTF_MEM_ACC_CONTROL_RD_WR_N_value and &H1), 12) + leftShift((write_CTF_MEM_ACC_CONTROL_TABLE_SELECT_value and &H3), 10) + leftShift((write_CTF_MEM_ACC_CONTROL_TABLE_INDEX_value and &H3ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CTF_MEM_ACC_CONTROL_RESERVED_value = rightShift(data_low, 23) and &H1ff
        read_CTF_MEM_ACC_CONTROL_CURRENT_TABLE_INDEX_value = rightShift(data_low, 13) and &H3ff
        read_CTF_MEM_ACC_CONTROL_RD_WR_N_value = rightShift(data_low, 12) and &H1
        read_CTF_MEM_ACC_CONTROL_TABLE_SELECT_value = rightShift(data_low, 10) and &H3
        CTF_MEM_ACC_CONTROL_TABLE_INDEX_mask = &H3ff
        if data_low > LONG_MAX then
            if CTF_MEM_ACC_CONTROL_TABLE_INDEX_mask = mask then
                read_CTF_MEM_ACC_CONTROL_TABLE_INDEX_value = data_low
            else
                read_CTF_MEM_ACC_CONTROL_TABLE_INDEX_value = (data_low - H8000_0000) and CTF_MEM_ACC_CONTROL_TABLE_INDEX_mask
            end If
        else
            read_CTF_MEM_ACC_CONTROL_TABLE_INDEX_value = data_low and CTF_MEM_ACC_CONTROL_TABLE_INDEX_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CTF_MEM_ACC_CONTROL_RESERVED_value = &H0
        flag_CTF_MEM_ACC_CONTROL_RESERVED        = &H0
        write_CTF_MEM_ACC_CONTROL_CURRENT_TABLE_INDEX_value = &H0
        flag_CTF_MEM_ACC_CONTROL_CURRENT_TABLE_INDEX        = &H0
        write_CTF_MEM_ACC_CONTROL_RD_WR_N_value = &H0
        flag_CTF_MEM_ACC_CONTROL_RD_WR_N        = &H0
        write_CTF_MEM_ACC_CONTROL_TABLE_SELECT_value = &H0
        flag_CTF_MEM_ACC_CONTROL_TABLE_SELECT        = &H0
        write_CTF_MEM_ACC_CONTROL_TABLE_INDEX_value = &H0
        flag_CTF_MEM_ACC_CONTROL_TABLE_INDEX        = &H0
    End Sub
End Class


'' @REGISTER : CTF_ctf_brcm_hdr_control
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CTF_BRCM_HDR_CONTROL_RESERVED              [31:9]           get_CTF_BRCM_HDR_CONTROL_RESERVED
''                                                             set_CTF_BRCM_HDR_CONTROL_RESERVED
''                                                             read_CTF_BRCM_HDR_CONTROL_RESERVED
''                                                             write_CTF_BRCM_HDR_CONTROL_RESERVED
''---------------------------------------------------------------------------------
'' CTF_BRCM_HDR_CONTROL_BRCM_HDR_TC           [8:6]            get_CTF_BRCM_HDR_CONTROL_BRCM_HDR_TC
''                                                             set_CTF_BRCM_HDR_CONTROL_BRCM_HDR_TC
''                                                             read_CTF_BRCM_HDR_CONTROL_BRCM_HDR_TC
''                                                             write_CTF_BRCM_HDR_CONTROL_BRCM_HDR_TC
''---------------------------------------------------------------------------------
'' CTF_BRCM_HDR_CONTROL_BRCM_HDR_TE           [5:4]            get_CTF_BRCM_HDR_CONTROL_BRCM_HDR_TE
''                                                             set_CTF_BRCM_HDR_CONTROL_BRCM_HDR_TE
''                                                             read_CTF_BRCM_HDR_CONTROL_BRCM_HDR_TE
''                                                             write_CTF_BRCM_HDR_CONTROL_BRCM_HDR_TE
''---------------------------------------------------------------------------------
'' CBHCBHPIE                                  [3:3]            get_CBHCBHPIE
''                                                             set_CBHCBHPIE
''                                                             read_CBHCBHPIE
''                                                             write_CBHCBHPIE
''---------------------------------------------------------------------------------
'' CTF_BRCM_HDR_CONTROL_BRCM_HDR_SW_TX_ENABLE   [2:2]            get_CTF_BRCM_HDR_CONTROL_BRCM_HDR_SW_TX_ENABLE
''                                                             set_CTF_BRCM_HDR_CONTROL_BRCM_HDR_SW_TX_ENABLE
''                                                             read_CTF_BRCM_HDR_CONTROL_BRCM_HDR_SW_TX_ENABLE
''                                                             write_CTF_BRCM_HDR_CONTROL_BRCM_HDR_SW_TX_ENABLE
''---------------------------------------------------------------------------------
'' CTF_BRCM_HDR_CONTROL_BRCM_HDR_SW_RX_ENABLE   [1:1]            get_CTF_BRCM_HDR_CONTROL_BRCM_HDR_SW_RX_ENABLE
''                                                             set_CTF_BRCM_HDR_CONTROL_BRCM_HDR_SW_RX_ENABLE
''                                                             read_CTF_BRCM_HDR_CONTROL_BRCM_HDR_SW_RX_ENABLE
''                                                             write_CTF_BRCM_HDR_CONTROL_BRCM_HDR_SW_RX_ENABLE
''---------------------------------------------------------------------------------
'' CTF_BRCM_HDR_CONTROL_BRCM_HDR_HW_ENABLE    [0:0]            get_CTF_BRCM_HDR_CONTROL_BRCM_HDR_HW_ENABLE
''                                                             set_CTF_BRCM_HDR_CONTROL_BRCM_HDR_HW_ENABLE
''                                                             read_CTF_BRCM_HDR_CONTROL_BRCM_HDR_HW_ENABLE
''                                                             write_CTF_BRCM_HDR_CONTROL_BRCM_HDR_HW_ENABLE
''---------------------------------------------------------------------------------
Class REGISTER_CTF_ctf_brcm_hdr_control
    Private write_CTF_BRCM_HDR_CONTROL_RESERVED_value
    Private read_CTF_BRCM_HDR_CONTROL_RESERVED_value
    Private flag_CTF_BRCM_HDR_CONTROL_RESERVED
    Private write_CTF_BRCM_HDR_CONTROL_BRCM_HDR_TC_value
    Private read_CTF_BRCM_HDR_CONTROL_BRCM_HDR_TC_value
    Private flag_CTF_BRCM_HDR_CONTROL_BRCM_HDR_TC
    Private write_CTF_BRCM_HDR_CONTROL_BRCM_HDR_TE_value
    Private read_CTF_BRCM_HDR_CONTROL_BRCM_HDR_TE_value
    Private flag_CTF_BRCM_HDR_CONTROL_BRCM_HDR_TE
    Private write_CBHCBHPIE_value
    Private read_CBHCBHPIE_value
    Private flag_CBHCBHPIE
    Private write_CTF_BRCM_HDR_CONTROL_BRCM_HDR_SW_TX_ENABLE_value
    Private read_CTF_BRCM_HDR_CONTROL_BRCM_HDR_SW_TX_ENABLE_value
    Private flag_CTF_BRCM_HDR_CONTROL_BRCM_HDR_SW_TX_ENABLE
    Private write_CTF_BRCM_HDR_CONTROL_BRCM_HDR_SW_RX_ENABLE_value
    Private read_CTF_BRCM_HDR_CONTROL_BRCM_HDR_SW_RX_ENABLE_value
    Private flag_CTF_BRCM_HDR_CONTROL_BRCM_HDR_SW_RX_ENABLE
    Private write_CTF_BRCM_HDR_CONTROL_BRCM_HDR_HW_ENABLE_value
    Private read_CTF_BRCM_HDR_CONTROL_BRCM_HDR_HW_ENABLE_value
    Private flag_CTF_BRCM_HDR_CONTROL_BRCM_HDR_HW_ENABLE

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

    Property Get get_CTF_BRCM_HDR_CONTROL_RESERVED
        get_CTF_BRCM_HDR_CONTROL_RESERVED = read_CTF_BRCM_HDR_CONTROL_RESERVED_value
    End Property

    Property Let set_CTF_BRCM_HDR_CONTROL_RESERVED(aData)
        write_CTF_BRCM_HDR_CONTROL_RESERVED_value = aData
        flag_CTF_BRCM_HDR_CONTROL_RESERVED        = &H1
    End Property

    Property Get read_CTF_BRCM_HDR_CONTROL_RESERVED
        read
        read_CTF_BRCM_HDR_CONTROL_RESERVED = read_CTF_BRCM_HDR_CONTROL_RESERVED_value
    End Property

    Property Let write_CTF_BRCM_HDR_CONTROL_RESERVED(aData)
        set_CTF_BRCM_HDR_CONTROL_RESERVED = aData
        write
    End Property

    Property Get get_CTF_BRCM_HDR_CONTROL_BRCM_HDR_TC
        get_CTF_BRCM_HDR_CONTROL_BRCM_HDR_TC = read_CTF_BRCM_HDR_CONTROL_BRCM_HDR_TC_value
    End Property

    Property Let set_CTF_BRCM_HDR_CONTROL_BRCM_HDR_TC(aData)
        write_CTF_BRCM_HDR_CONTROL_BRCM_HDR_TC_value = aData
        flag_CTF_BRCM_HDR_CONTROL_BRCM_HDR_TC        = &H1
    End Property

    Property Get read_CTF_BRCM_HDR_CONTROL_BRCM_HDR_TC
        read
        read_CTF_BRCM_HDR_CONTROL_BRCM_HDR_TC = read_CTF_BRCM_HDR_CONTROL_BRCM_HDR_TC_value
    End Property

    Property Let write_CTF_BRCM_HDR_CONTROL_BRCM_HDR_TC(aData)
        set_CTF_BRCM_HDR_CONTROL_BRCM_HDR_TC = aData
        write
    End Property

    Property Get get_CTF_BRCM_HDR_CONTROL_BRCM_HDR_TE
        get_CTF_BRCM_HDR_CONTROL_BRCM_HDR_TE = read_CTF_BRCM_HDR_CONTROL_BRCM_HDR_TE_value
    End Property

    Property Let set_CTF_BRCM_HDR_CONTROL_BRCM_HDR_TE(aData)
        write_CTF_BRCM_HDR_CONTROL_BRCM_HDR_TE_value = aData
        flag_CTF_BRCM_HDR_CONTROL_BRCM_HDR_TE        = &H1
    End Property

    Property Get read_CTF_BRCM_HDR_CONTROL_BRCM_HDR_TE
        read
        read_CTF_BRCM_HDR_CONTROL_BRCM_HDR_TE = read_CTF_BRCM_HDR_CONTROL_BRCM_HDR_TE_value
    End Property

    Property Let write_CTF_BRCM_HDR_CONTROL_BRCM_HDR_TE(aData)
        set_CTF_BRCM_HDR_CONTROL_BRCM_HDR_TE = aData
        write
    End Property

    Property Get get_CBHCBHPIE
        get_CBHCBHPIE = read_CBHCBHPIE_value
    End Property

    Property Let set_CBHCBHPIE(aData)
        write_CBHCBHPIE_value = aData
        flag_CBHCBHPIE        = &H1
    End Property

    Property Get read_CBHCBHPIE
        read
        read_CBHCBHPIE = read_CBHCBHPIE_value
    End Property

    Property Let write_CBHCBHPIE(aData)
        set_CBHCBHPIE = aData
        write
    End Property

    Property Get get_CTF_BRCM_HDR_CONTROL_BRCM_HDR_SW_TX_ENABLE
        get_CTF_BRCM_HDR_CONTROL_BRCM_HDR_SW_TX_ENABLE = read_CTF_BRCM_HDR_CONTROL_BRCM_HDR_SW_TX_ENABLE_value
    End Property

    Property Let set_CTF_BRCM_HDR_CONTROL_BRCM_HDR_SW_TX_ENABLE(aData)
        write_CTF_BRCM_HDR_CONTROL_BRCM_HDR_SW_TX_ENABLE_value = aData
        flag_CTF_BRCM_HDR_CONTROL_BRCM_HDR_SW_TX_ENABLE        = &H1
    End Property

    Property Get read_CTF_BRCM_HDR_CONTROL_BRCM_HDR_SW_TX_ENABLE
        read
        read_CTF_BRCM_HDR_CONTROL_BRCM_HDR_SW_TX_ENABLE = read_CTF_BRCM_HDR_CONTROL_BRCM_HDR_SW_TX_ENABLE_value
    End Property

    Property Let write_CTF_BRCM_HDR_CONTROL_BRCM_HDR_SW_TX_ENABLE(aData)
        set_CTF_BRCM_HDR_CONTROL_BRCM_HDR_SW_TX_ENABLE = aData
        write
    End Property

    Property Get get_CTF_BRCM_HDR_CONTROL_BRCM_HDR_SW_RX_ENABLE
        get_CTF_BRCM_HDR_CONTROL_BRCM_HDR_SW_RX_ENABLE = read_CTF_BRCM_HDR_CONTROL_BRCM_HDR_SW_RX_ENABLE_value
    End Property

    Property Let set_CTF_BRCM_HDR_CONTROL_BRCM_HDR_SW_RX_ENABLE(aData)
        write_CTF_BRCM_HDR_CONTROL_BRCM_HDR_SW_RX_ENABLE_value = aData
        flag_CTF_BRCM_HDR_CONTROL_BRCM_HDR_SW_RX_ENABLE        = &H1
    End Property

    Property Get read_CTF_BRCM_HDR_CONTROL_BRCM_HDR_SW_RX_ENABLE
        read
        read_CTF_BRCM_HDR_CONTROL_BRCM_HDR_SW_RX_ENABLE = read_CTF_BRCM_HDR_CONTROL_BRCM_HDR_SW_RX_ENABLE_value
    End Property

    Property Let write_CTF_BRCM_HDR_CONTROL_BRCM_HDR_SW_RX_ENABLE(aData)
        set_CTF_BRCM_HDR_CONTROL_BRCM_HDR_SW_RX_ENABLE = aData
        write
    End Property

    Property Get get_CTF_BRCM_HDR_CONTROL_BRCM_HDR_HW_ENABLE
        get_CTF_BRCM_HDR_CONTROL_BRCM_HDR_HW_ENABLE = read_CTF_BRCM_HDR_CONTROL_BRCM_HDR_HW_ENABLE_value
    End Property

    Property Let set_CTF_BRCM_HDR_CONTROL_BRCM_HDR_HW_ENABLE(aData)
        write_CTF_BRCM_HDR_CONTROL_BRCM_HDR_HW_ENABLE_value = aData
        flag_CTF_BRCM_HDR_CONTROL_BRCM_HDR_HW_ENABLE        = &H1
    End Property

    Property Get read_CTF_BRCM_HDR_CONTROL_BRCM_HDR_HW_ENABLE
        read
        read_CTF_BRCM_HDR_CONTROL_BRCM_HDR_HW_ENABLE = read_CTF_BRCM_HDR_CONTROL_BRCM_HDR_HW_ENABLE_value
    End Property

    Property Let write_CTF_BRCM_HDR_CONTROL_BRCM_HDR_HW_ENABLE(aData)
        set_CTF_BRCM_HDR_CONTROL_BRCM_HDR_HW_ENABLE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CTF_BRCM_HDR_CONTROL_RESERVED_value = rightShift(data_low, 9) and &H7fffff
        read_CTF_BRCM_HDR_CONTROL_BRCM_HDR_TC_value = rightShift(data_low, 6) and &H7
        read_CTF_BRCM_HDR_CONTROL_BRCM_HDR_TE_value = rightShift(data_low, 4) and &H3
        read_CBHCBHPIE_value = rightShift(data_low, 3) and &H1
        read_CTF_BRCM_HDR_CONTROL_BRCM_HDR_SW_TX_ENABLE_value = rightShift(data_low, 2) and &H1
        read_CTF_BRCM_HDR_CONTROL_BRCM_HDR_SW_RX_ENABLE_value = rightShift(data_low, 1) and &H1
        CTF_BRCM_HDR_CONTROL_BRCM_HDR_HW_ENABLE_mask = &H1
        if data_low > LONG_MAX then
            if CTF_BRCM_HDR_CONTROL_BRCM_HDR_HW_ENABLE_mask = mask then
                read_CTF_BRCM_HDR_CONTROL_BRCM_HDR_HW_ENABLE_value = data_low
            else
                read_CTF_BRCM_HDR_CONTROL_BRCM_HDR_HW_ENABLE_value = (data_low - H8000_0000) and CTF_BRCM_HDR_CONTROL_BRCM_HDR_HW_ENABLE_mask
            end If
        else
            read_CTF_BRCM_HDR_CONTROL_BRCM_HDR_HW_ENABLE_value = data_low and CTF_BRCM_HDR_CONTROL_BRCM_HDR_HW_ENABLE_mask
        end If

    End Sub

    Sub write
        If flag_CTF_BRCM_HDR_CONTROL_RESERVED = &H0 or flag_CTF_BRCM_HDR_CONTROL_BRCM_HDR_TC = &H0 or flag_CTF_BRCM_HDR_CONTROL_BRCM_HDR_TE = &H0 or flag_CBHCBHPIE = &H0 or flag_CTF_BRCM_HDR_CONTROL_BRCM_HDR_SW_TX_ENABLE = &H0 or flag_CTF_BRCM_HDR_CONTROL_BRCM_HDR_SW_RX_ENABLE = &H0 or flag_CTF_BRCM_HDR_CONTROL_BRCM_HDR_HW_ENABLE = &H0 Then read
        If flag_CTF_BRCM_HDR_CONTROL_RESERVED = &H0 Then write_CTF_BRCM_HDR_CONTROL_RESERVED_value = get_CTF_BRCM_HDR_CONTROL_RESERVED
        If flag_CTF_BRCM_HDR_CONTROL_BRCM_HDR_TC = &H0 Then write_CTF_BRCM_HDR_CONTROL_BRCM_HDR_TC_value = get_CTF_BRCM_HDR_CONTROL_BRCM_HDR_TC
        If flag_CTF_BRCM_HDR_CONTROL_BRCM_HDR_TE = &H0 Then write_CTF_BRCM_HDR_CONTROL_BRCM_HDR_TE_value = get_CTF_BRCM_HDR_CONTROL_BRCM_HDR_TE
        If flag_CBHCBHPIE = &H0 Then write_CBHCBHPIE_value = get_CBHCBHPIE
        If flag_CTF_BRCM_HDR_CONTROL_BRCM_HDR_SW_TX_ENABLE = &H0 Then write_CTF_BRCM_HDR_CONTROL_BRCM_HDR_SW_TX_ENABLE_value = get_CTF_BRCM_HDR_CONTROL_BRCM_HDR_SW_TX_ENABLE
        If flag_CTF_BRCM_HDR_CONTROL_BRCM_HDR_SW_RX_ENABLE = &H0 Then write_CTF_BRCM_HDR_CONTROL_BRCM_HDR_SW_RX_ENABLE_value = get_CTF_BRCM_HDR_CONTROL_BRCM_HDR_SW_RX_ENABLE
        If flag_CTF_BRCM_HDR_CONTROL_BRCM_HDR_HW_ENABLE = &H0 Then write_CTF_BRCM_HDR_CONTROL_BRCM_HDR_HW_ENABLE_value = get_CTF_BRCM_HDR_CONTROL_BRCM_HDR_HW_ENABLE

        regValue = leftShift((write_CTF_BRCM_HDR_CONTROL_RESERVED_value and &H7fffff), 9) + leftShift((write_CTF_BRCM_HDR_CONTROL_BRCM_HDR_TC_value and &H7), 6) + leftShift((write_CTF_BRCM_HDR_CONTROL_BRCM_HDR_TE_value and &H3), 4) + leftShift((write_CBHCBHPIE_value and &H1), 3) + leftShift((write_CTF_BRCM_HDR_CONTROL_BRCM_HDR_SW_TX_ENABLE_value and &H1), 2) + leftShift((write_CTF_BRCM_HDR_CONTROL_BRCM_HDR_SW_RX_ENABLE_value and &H1), 1) + leftShift((write_CTF_BRCM_HDR_CONTROL_BRCM_HDR_HW_ENABLE_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CTF_BRCM_HDR_CONTROL_RESERVED_value = rightShift(data_low, 9) and &H7fffff
        read_CTF_BRCM_HDR_CONTROL_BRCM_HDR_TC_value = rightShift(data_low, 6) and &H7
        read_CTF_BRCM_HDR_CONTROL_BRCM_HDR_TE_value = rightShift(data_low, 4) and &H3
        read_CBHCBHPIE_value = rightShift(data_low, 3) and &H1
        read_CTF_BRCM_HDR_CONTROL_BRCM_HDR_SW_TX_ENABLE_value = rightShift(data_low, 2) and &H1
        read_CTF_BRCM_HDR_CONTROL_BRCM_HDR_SW_RX_ENABLE_value = rightShift(data_low, 1) and &H1
        CTF_BRCM_HDR_CONTROL_BRCM_HDR_HW_ENABLE_mask = &H1
        if data_low > LONG_MAX then
            if CTF_BRCM_HDR_CONTROL_BRCM_HDR_HW_ENABLE_mask = mask then
                read_CTF_BRCM_HDR_CONTROL_BRCM_HDR_HW_ENABLE_value = data_low
            else
                read_CTF_BRCM_HDR_CONTROL_BRCM_HDR_HW_ENABLE_value = (data_low - H8000_0000) and CTF_BRCM_HDR_CONTROL_BRCM_HDR_HW_ENABLE_mask
            end If
        else
            read_CTF_BRCM_HDR_CONTROL_BRCM_HDR_HW_ENABLE_value = data_low and CTF_BRCM_HDR_CONTROL_BRCM_HDR_HW_ENABLE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CTF_BRCM_HDR_CONTROL_RESERVED_value = &H0
        flag_CTF_BRCM_HDR_CONTROL_RESERVED        = &H0
        write_CTF_BRCM_HDR_CONTROL_BRCM_HDR_TC_value = &H0
        flag_CTF_BRCM_HDR_CONTROL_BRCM_HDR_TC        = &H0
        write_CTF_BRCM_HDR_CONTROL_BRCM_HDR_TE_value = &H0
        flag_CTF_BRCM_HDR_CONTROL_BRCM_HDR_TE        = &H0
        write_CBHCBHPIE_value = &H0
        flag_CBHCBHPIE        = &H0
        write_CTF_BRCM_HDR_CONTROL_BRCM_HDR_SW_TX_ENABLE_value = &H0
        flag_CTF_BRCM_HDR_CONTROL_BRCM_HDR_SW_TX_ENABLE        = &H0
        write_CTF_BRCM_HDR_CONTROL_BRCM_HDR_SW_RX_ENABLE_value = &H0
        flag_CTF_BRCM_HDR_CONTROL_BRCM_HDR_SW_RX_ENABLE        = &H0
        write_CTF_BRCM_HDR_CONTROL_BRCM_HDR_HW_ENABLE_value = &H0
        flag_CTF_BRCM_HDR_CONTROL_BRCM_HDR_HW_ENABLE        = &H0
    End Sub
End Class


'' @REGISTER : CTF_ctf_l2_skip_control
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CTF_L2_SKIP_CONTROL_RESERVED               [31:21]          get_CTF_L2_SKIP_CONTROL_RESERVED
''                                                             set_CTF_L2_SKIP_CONTROL_RESERVED
''                                                             read_CTF_L2_SKIP_CONTROL_RESERVED
''                                                             write_CTF_L2_SKIP_CONTROL_RESERVED
''---------------------------------------------------------------------------------
'' CL2SCE2TSC                                 [20:20]          get_CL2SCE2TSC
''                                                             set_CL2SCE2TSC
''                                                             read_CL2SCE2TSC
''                                                             write_CL2SCE2TSC
''---------------------------------------------------------------------------------
'' CL2SCL2PESE1                               [19:19]          get_CL2SCL2PESE1
''                                                             set_CL2SCL2PESE1
''                                                             read_CL2SCL2PESE1
''                                                             write_CL2SCL2PESE1
''---------------------------------------------------------------------------------
'' CL2SCL2PESB1                               [18:16]          get_CL2SCL2PESB1
''                                                             set_CL2SCL2PESB1
''                                                             read_CL2SCL2PESB1
''                                                             write_CL2SCL2PESB1
''---------------------------------------------------------------------------------
'' CL2SCL2PEST1                               [15:0]           get_CL2SCL2PEST1
''                                                             set_CL2SCL2PEST1
''                                                             read_CL2SCL2PEST1
''                                                             write_CL2SCL2PEST1
''---------------------------------------------------------------------------------
Class REGISTER_CTF_ctf_l2_skip_control
    Private write_CTF_L2_SKIP_CONTROL_RESERVED_value
    Private read_CTF_L2_SKIP_CONTROL_RESERVED_value
    Private flag_CTF_L2_SKIP_CONTROL_RESERVED
    Private write_CL2SCE2TSC_value
    Private read_CL2SCE2TSC_value
    Private flag_CL2SCE2TSC
    Private write_CL2SCL2PESE1_value
    Private read_CL2SCL2PESE1_value
    Private flag_CL2SCL2PESE1
    Private write_CL2SCL2PESB1_value
    Private read_CL2SCL2PESB1_value
    Private flag_CL2SCL2PESB1
    Private write_CL2SCL2PEST1_value
    Private read_CL2SCL2PEST1_value
    Private flag_CL2SCL2PEST1

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

    Property Get get_CTF_L2_SKIP_CONTROL_RESERVED
        get_CTF_L2_SKIP_CONTROL_RESERVED = read_CTF_L2_SKIP_CONTROL_RESERVED_value
    End Property

    Property Let set_CTF_L2_SKIP_CONTROL_RESERVED(aData)
        write_CTF_L2_SKIP_CONTROL_RESERVED_value = aData
        flag_CTF_L2_SKIP_CONTROL_RESERVED        = &H1
    End Property

    Property Get read_CTF_L2_SKIP_CONTROL_RESERVED
        read
        read_CTF_L2_SKIP_CONTROL_RESERVED = read_CTF_L2_SKIP_CONTROL_RESERVED_value
    End Property

    Property Let write_CTF_L2_SKIP_CONTROL_RESERVED(aData)
        set_CTF_L2_SKIP_CONTROL_RESERVED = aData
        write
    End Property

    Property Get get_CL2SCE2TSC
        get_CL2SCE2TSC = read_CL2SCE2TSC_value
    End Property

    Property Let set_CL2SCE2TSC(aData)
        write_CL2SCE2TSC_value = aData
        flag_CL2SCE2TSC        = &H1
    End Property

    Property Get read_CL2SCE2TSC
        read
        read_CL2SCE2TSC = read_CL2SCE2TSC_value
    End Property

    Property Let write_CL2SCE2TSC(aData)
        set_CL2SCE2TSC = aData
        write
    End Property

    Property Get get_CL2SCL2PESE1
        get_CL2SCL2PESE1 = read_CL2SCL2PESE1_value
    End Property

    Property Let set_CL2SCL2PESE1(aData)
        write_CL2SCL2PESE1_value = aData
        flag_CL2SCL2PESE1        = &H1
    End Property

    Property Get read_CL2SCL2PESE1
        read
        read_CL2SCL2PESE1 = read_CL2SCL2PESE1_value
    End Property

    Property Let write_CL2SCL2PESE1(aData)
        set_CL2SCL2PESE1 = aData
        write
    End Property

    Property Get get_CL2SCL2PESB1
        get_CL2SCL2PESB1 = read_CL2SCL2PESB1_value
    End Property

    Property Let set_CL2SCL2PESB1(aData)
        write_CL2SCL2PESB1_value = aData
        flag_CL2SCL2PESB1        = &H1
    End Property

    Property Get read_CL2SCL2PESB1
        read
        read_CL2SCL2PESB1 = read_CL2SCL2PESB1_value
    End Property

    Property Let write_CL2SCL2PESB1(aData)
        set_CL2SCL2PESB1 = aData
        write
    End Property

    Property Get get_CL2SCL2PEST1
        get_CL2SCL2PEST1 = read_CL2SCL2PEST1_value
    End Property

    Property Let set_CL2SCL2PEST1(aData)
        write_CL2SCL2PEST1_value = aData
        flag_CL2SCL2PEST1        = &H1
    End Property

    Property Get read_CL2SCL2PEST1
        read
        read_CL2SCL2PEST1 = read_CL2SCL2PEST1_value
    End Property

    Property Let write_CL2SCL2PEST1(aData)
        set_CL2SCL2PEST1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CTF_L2_SKIP_CONTROL_RESERVED_value = rightShift(data_low, 21) and &H7ff
        read_CL2SCE2TSC_value = rightShift(data_low, 20) and &H1
        read_CL2SCL2PESE1_value = rightShift(data_low, 19) and &H1
        read_CL2SCL2PESB1_value = rightShift(data_low, 16) and &H7
        CL2SCL2PEST1_mask = &Hffff
        if data_low > LONG_MAX then
            if CL2SCL2PEST1_mask = mask then
                read_CL2SCL2PEST1_value = data_low
            else
                read_CL2SCL2PEST1_value = (data_low - H8000_0000) and CL2SCL2PEST1_mask
            end If
        else
            read_CL2SCL2PEST1_value = data_low and CL2SCL2PEST1_mask
        end If

    End Sub

    Sub write
        If flag_CTF_L2_SKIP_CONTROL_RESERVED = &H0 or flag_CL2SCE2TSC = &H0 or flag_CL2SCL2PESE1 = &H0 or flag_CL2SCL2PESB1 = &H0 or flag_CL2SCL2PEST1 = &H0 Then read
        If flag_CTF_L2_SKIP_CONTROL_RESERVED = &H0 Then write_CTF_L2_SKIP_CONTROL_RESERVED_value = get_CTF_L2_SKIP_CONTROL_RESERVED
        If flag_CL2SCE2TSC = &H0 Then write_CL2SCE2TSC_value = get_CL2SCE2TSC
        If flag_CL2SCL2PESE1 = &H0 Then write_CL2SCL2PESE1_value = get_CL2SCL2PESE1
        If flag_CL2SCL2PESB1 = &H0 Then write_CL2SCL2PESB1_value = get_CL2SCL2PESB1
        If flag_CL2SCL2PEST1 = &H0 Then write_CL2SCL2PEST1_value = get_CL2SCL2PEST1

        regValue = leftShift((write_CTF_L2_SKIP_CONTROL_RESERVED_value and &H7ff), 21) + leftShift((write_CL2SCE2TSC_value and &H1), 20) + leftShift((write_CL2SCL2PESE1_value and &H1), 19) + leftShift((write_CL2SCL2PESB1_value and &H7), 16) + leftShift((write_CL2SCL2PEST1_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CTF_L2_SKIP_CONTROL_RESERVED_value = rightShift(data_low, 21) and &H7ff
        read_CL2SCE2TSC_value = rightShift(data_low, 20) and &H1
        read_CL2SCL2PESE1_value = rightShift(data_low, 19) and &H1
        read_CL2SCL2PESB1_value = rightShift(data_low, 16) and &H7
        CL2SCL2PEST1_mask = &Hffff
        if data_low > LONG_MAX then
            if CL2SCL2PEST1_mask = mask then
                read_CL2SCL2PEST1_value = data_low
            else
                read_CL2SCL2PEST1_value = (data_low - H8000_0000) and CL2SCL2PEST1_mask
            end If
        else
            read_CL2SCL2PEST1_value = data_low and CL2SCL2PEST1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CTF_L2_SKIP_CONTROL_RESERVED_value = &H0
        flag_CTF_L2_SKIP_CONTROL_RESERVED        = &H0
        write_CL2SCE2TSC_value = &H0
        flag_CL2SCE2TSC        = &H0
        write_CL2SCL2PESE1_value = &H0
        flag_CL2SCL2PESE1        = &H0
        write_CL2SCL2PESB1_value = &H0
        flag_CL2SCL2PESB1        = &H0
        write_CL2SCL2PEST1_value = &H0
        flag_CL2SCL2PEST1        = &H0
    End Sub
End Class


'' @REGISTER : CTF_ctf_l2_tag_type
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CTF_L2_TAG_TYPE_L2_PARSE_ET_TAGGED_TYPE1   [31:16]          get_CTF_L2_TAG_TYPE_L2_PARSE_ET_TAGGED_TYPE1
''                                                             set_CTF_L2_TAG_TYPE_L2_PARSE_ET_TAGGED_TYPE1
''                                                             read_CTF_L2_TAG_TYPE_L2_PARSE_ET_TAGGED_TYPE1
''                                                             write_CTF_L2_TAG_TYPE_L2_PARSE_ET_TAGGED_TYPE1
''---------------------------------------------------------------------------------
'' CTF_L2_TAG_TYPE_L2_PARSE_ET_TAGGED_TYPE0   [15:0]           get_CTF_L2_TAG_TYPE_L2_PARSE_ET_TAGGED_TYPE0
''                                                             set_CTF_L2_TAG_TYPE_L2_PARSE_ET_TAGGED_TYPE0
''                                                             read_CTF_L2_TAG_TYPE_L2_PARSE_ET_TAGGED_TYPE0
''                                                             write_CTF_L2_TAG_TYPE_L2_PARSE_ET_TAGGED_TYPE0
''---------------------------------------------------------------------------------
Class REGISTER_CTF_ctf_l2_tag_type
    Private write_CTF_L2_TAG_TYPE_L2_PARSE_ET_TAGGED_TYPE1_value
    Private read_CTF_L2_TAG_TYPE_L2_PARSE_ET_TAGGED_TYPE1_value
    Private flag_CTF_L2_TAG_TYPE_L2_PARSE_ET_TAGGED_TYPE1
    Private write_CTF_L2_TAG_TYPE_L2_PARSE_ET_TAGGED_TYPE0_value
    Private read_CTF_L2_TAG_TYPE_L2_PARSE_ET_TAGGED_TYPE0_value
    Private flag_CTF_L2_TAG_TYPE_L2_PARSE_ET_TAGGED_TYPE0

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

    Property Get get_CTF_L2_TAG_TYPE_L2_PARSE_ET_TAGGED_TYPE1
        get_CTF_L2_TAG_TYPE_L2_PARSE_ET_TAGGED_TYPE1 = read_CTF_L2_TAG_TYPE_L2_PARSE_ET_TAGGED_TYPE1_value
    End Property

    Property Let set_CTF_L2_TAG_TYPE_L2_PARSE_ET_TAGGED_TYPE1(aData)
        write_CTF_L2_TAG_TYPE_L2_PARSE_ET_TAGGED_TYPE1_value = aData
        flag_CTF_L2_TAG_TYPE_L2_PARSE_ET_TAGGED_TYPE1        = &H1
    End Property

    Property Get read_CTF_L2_TAG_TYPE_L2_PARSE_ET_TAGGED_TYPE1
        read
        read_CTF_L2_TAG_TYPE_L2_PARSE_ET_TAGGED_TYPE1 = read_CTF_L2_TAG_TYPE_L2_PARSE_ET_TAGGED_TYPE1_value
    End Property

    Property Let write_CTF_L2_TAG_TYPE_L2_PARSE_ET_TAGGED_TYPE1(aData)
        set_CTF_L2_TAG_TYPE_L2_PARSE_ET_TAGGED_TYPE1 = aData
        write
    End Property

    Property Get get_CTF_L2_TAG_TYPE_L2_PARSE_ET_TAGGED_TYPE0
        get_CTF_L2_TAG_TYPE_L2_PARSE_ET_TAGGED_TYPE0 = read_CTF_L2_TAG_TYPE_L2_PARSE_ET_TAGGED_TYPE0_value
    End Property

    Property Let set_CTF_L2_TAG_TYPE_L2_PARSE_ET_TAGGED_TYPE0(aData)
        write_CTF_L2_TAG_TYPE_L2_PARSE_ET_TAGGED_TYPE0_value = aData
        flag_CTF_L2_TAG_TYPE_L2_PARSE_ET_TAGGED_TYPE0        = &H1
    End Property

    Property Get read_CTF_L2_TAG_TYPE_L2_PARSE_ET_TAGGED_TYPE0
        read
        read_CTF_L2_TAG_TYPE_L2_PARSE_ET_TAGGED_TYPE0 = read_CTF_L2_TAG_TYPE_L2_PARSE_ET_TAGGED_TYPE0_value
    End Property

    Property Let write_CTF_L2_TAG_TYPE_L2_PARSE_ET_TAGGED_TYPE0(aData)
        set_CTF_L2_TAG_TYPE_L2_PARSE_ET_TAGGED_TYPE0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CTF_L2_TAG_TYPE_L2_PARSE_ET_TAGGED_TYPE1_value = rightShift(data_low, 16) and &Hffff
        CTF_L2_TAG_TYPE_L2_PARSE_ET_TAGGED_TYPE0_mask = &Hffff
        if data_low > LONG_MAX then
            if CTF_L2_TAG_TYPE_L2_PARSE_ET_TAGGED_TYPE0_mask = mask then
                read_CTF_L2_TAG_TYPE_L2_PARSE_ET_TAGGED_TYPE0_value = data_low
            else
                read_CTF_L2_TAG_TYPE_L2_PARSE_ET_TAGGED_TYPE0_value = (data_low - H8000_0000) and CTF_L2_TAG_TYPE_L2_PARSE_ET_TAGGED_TYPE0_mask
            end If
        else
            read_CTF_L2_TAG_TYPE_L2_PARSE_ET_TAGGED_TYPE0_value = data_low and CTF_L2_TAG_TYPE_L2_PARSE_ET_TAGGED_TYPE0_mask
        end If

    End Sub

    Sub write
        If flag_CTF_L2_TAG_TYPE_L2_PARSE_ET_TAGGED_TYPE1 = &H0 or flag_CTF_L2_TAG_TYPE_L2_PARSE_ET_TAGGED_TYPE0 = &H0 Then read
        If flag_CTF_L2_TAG_TYPE_L2_PARSE_ET_TAGGED_TYPE1 = &H0 Then write_CTF_L2_TAG_TYPE_L2_PARSE_ET_TAGGED_TYPE1_value = get_CTF_L2_TAG_TYPE_L2_PARSE_ET_TAGGED_TYPE1
        If flag_CTF_L2_TAG_TYPE_L2_PARSE_ET_TAGGED_TYPE0 = &H0 Then write_CTF_L2_TAG_TYPE_L2_PARSE_ET_TAGGED_TYPE0_value = get_CTF_L2_TAG_TYPE_L2_PARSE_ET_TAGGED_TYPE0

        regValue = leftShift((write_CTF_L2_TAG_TYPE_L2_PARSE_ET_TAGGED_TYPE1_value and &Hffff), 16) + leftShift((write_CTF_L2_TAG_TYPE_L2_PARSE_ET_TAGGED_TYPE0_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CTF_L2_TAG_TYPE_L2_PARSE_ET_TAGGED_TYPE1_value = rightShift(data_low, 16) and &Hffff
        CTF_L2_TAG_TYPE_L2_PARSE_ET_TAGGED_TYPE0_mask = &Hffff
        if data_low > LONG_MAX then
            if CTF_L2_TAG_TYPE_L2_PARSE_ET_TAGGED_TYPE0_mask = mask then
                read_CTF_L2_TAG_TYPE_L2_PARSE_ET_TAGGED_TYPE0_value = data_low
            else
                read_CTF_L2_TAG_TYPE_L2_PARSE_ET_TAGGED_TYPE0_value = (data_low - H8000_0000) and CTF_L2_TAG_TYPE_L2_PARSE_ET_TAGGED_TYPE0_mask
            end If
        else
            read_CTF_L2_TAG_TYPE_L2_PARSE_ET_TAGGED_TYPE0_value = data_low and CTF_L2_TAG_TYPE_L2_PARSE_ET_TAGGED_TYPE0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CTF_L2_TAG_TYPE_L2_PARSE_ET_TAGGED_TYPE1_value = &H0
        flag_CTF_L2_TAG_TYPE_L2_PARSE_ET_TAGGED_TYPE1        = &H0
        write_CTF_L2_TAG_TYPE_L2_PARSE_ET_TAGGED_TYPE0_value = &H0
        flag_CTF_L2_TAG_TYPE_L2_PARSE_ET_TAGGED_TYPE0        = &H0
    End Sub
End Class


'' @REGISTER : CTF_ctf_l2_llc_max_length
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CTF_L2_LLC_MAX_LENGTH_RESERVED             [31:16]          get_CTF_L2_LLC_MAX_LENGTH_RESERVED
''                                                             set_CTF_L2_LLC_MAX_LENGTH_RESERVED
''                                                             read_CTF_L2_LLC_MAX_LENGTH_RESERVED
''                                                             write_CTF_L2_LLC_MAX_LENGTH_RESERVED
''---------------------------------------------------------------------------------
'' CTF_L2_LLC_MAX_LENGTH_L2_PARSE_LLC_MAX_LENGTH   [15:0]           get_CTF_L2_LLC_MAX_LENGTH_L2_PARSE_LLC_MAX_LENGTH
''                                                             set_CTF_L2_LLC_MAX_LENGTH_L2_PARSE_LLC_MAX_LENGTH
''                                                             read_CTF_L2_LLC_MAX_LENGTH_L2_PARSE_LLC_MAX_LENGTH
''                                                             write_CTF_L2_LLC_MAX_LENGTH_L2_PARSE_LLC_MAX_LENGTH
''---------------------------------------------------------------------------------
Class REGISTER_CTF_ctf_l2_llc_max_length
    Private write_CTF_L2_LLC_MAX_LENGTH_RESERVED_value
    Private read_CTF_L2_LLC_MAX_LENGTH_RESERVED_value
    Private flag_CTF_L2_LLC_MAX_LENGTH_RESERVED
    Private write_CTF_L2_LLC_MAX_LENGTH_L2_PARSE_LLC_MAX_LENGTH_value
    Private read_CTF_L2_LLC_MAX_LENGTH_L2_PARSE_LLC_MAX_LENGTH_value
    Private flag_CTF_L2_LLC_MAX_LENGTH_L2_PARSE_LLC_MAX_LENGTH

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

    Property Get get_CTF_L2_LLC_MAX_LENGTH_RESERVED
        get_CTF_L2_LLC_MAX_LENGTH_RESERVED = read_CTF_L2_LLC_MAX_LENGTH_RESERVED_value
    End Property

    Property Let set_CTF_L2_LLC_MAX_LENGTH_RESERVED(aData)
        write_CTF_L2_LLC_MAX_LENGTH_RESERVED_value = aData
        flag_CTF_L2_LLC_MAX_LENGTH_RESERVED        = &H1
    End Property

    Property Get read_CTF_L2_LLC_MAX_LENGTH_RESERVED
        read
        read_CTF_L2_LLC_MAX_LENGTH_RESERVED = read_CTF_L2_LLC_MAX_LENGTH_RESERVED_value
    End Property

    Property Let write_CTF_L2_LLC_MAX_LENGTH_RESERVED(aData)
        set_CTF_L2_LLC_MAX_LENGTH_RESERVED = aData
        write
    End Property

    Property Get get_CTF_L2_LLC_MAX_LENGTH_L2_PARSE_LLC_MAX_LENGTH
        get_CTF_L2_LLC_MAX_LENGTH_L2_PARSE_LLC_MAX_LENGTH = read_CTF_L2_LLC_MAX_LENGTH_L2_PARSE_LLC_MAX_LENGTH_value
    End Property

    Property Let set_CTF_L2_LLC_MAX_LENGTH_L2_PARSE_LLC_MAX_LENGTH(aData)
        write_CTF_L2_LLC_MAX_LENGTH_L2_PARSE_LLC_MAX_LENGTH_value = aData
        flag_CTF_L2_LLC_MAX_LENGTH_L2_PARSE_LLC_MAX_LENGTH        = &H1
    End Property

    Property Get read_CTF_L2_LLC_MAX_LENGTH_L2_PARSE_LLC_MAX_LENGTH
        read
        read_CTF_L2_LLC_MAX_LENGTH_L2_PARSE_LLC_MAX_LENGTH = read_CTF_L2_LLC_MAX_LENGTH_L2_PARSE_LLC_MAX_LENGTH_value
    End Property

    Property Let write_CTF_L2_LLC_MAX_LENGTH_L2_PARSE_LLC_MAX_LENGTH(aData)
        set_CTF_L2_LLC_MAX_LENGTH_L2_PARSE_LLC_MAX_LENGTH = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CTF_L2_LLC_MAX_LENGTH_RESERVED_value = rightShift(data_low, 16) and &Hffff
        CTF_L2_LLC_MAX_LENGTH_L2_PARSE_LLC_MAX_LENGTH_mask = &Hffff
        if data_low > LONG_MAX then
            if CTF_L2_LLC_MAX_LENGTH_L2_PARSE_LLC_MAX_LENGTH_mask = mask then
                read_CTF_L2_LLC_MAX_LENGTH_L2_PARSE_LLC_MAX_LENGTH_value = data_low
            else
                read_CTF_L2_LLC_MAX_LENGTH_L2_PARSE_LLC_MAX_LENGTH_value = (data_low - H8000_0000) and CTF_L2_LLC_MAX_LENGTH_L2_PARSE_LLC_MAX_LENGTH_mask
            end If
        else
            read_CTF_L2_LLC_MAX_LENGTH_L2_PARSE_LLC_MAX_LENGTH_value = data_low and CTF_L2_LLC_MAX_LENGTH_L2_PARSE_LLC_MAX_LENGTH_mask
        end If

    End Sub

    Sub write
        If flag_CTF_L2_LLC_MAX_LENGTH_RESERVED = &H0 or flag_CTF_L2_LLC_MAX_LENGTH_L2_PARSE_LLC_MAX_LENGTH = &H0 Then read
        If flag_CTF_L2_LLC_MAX_LENGTH_RESERVED = &H0 Then write_CTF_L2_LLC_MAX_LENGTH_RESERVED_value = get_CTF_L2_LLC_MAX_LENGTH_RESERVED
        If flag_CTF_L2_LLC_MAX_LENGTH_L2_PARSE_LLC_MAX_LENGTH = &H0 Then write_CTF_L2_LLC_MAX_LENGTH_L2_PARSE_LLC_MAX_LENGTH_value = get_CTF_L2_LLC_MAX_LENGTH_L2_PARSE_LLC_MAX_LENGTH

        regValue = leftShift((write_CTF_L2_LLC_MAX_LENGTH_RESERVED_value and &Hffff), 16) + leftShift((write_CTF_L2_LLC_MAX_LENGTH_L2_PARSE_LLC_MAX_LENGTH_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CTF_L2_LLC_MAX_LENGTH_RESERVED_value = rightShift(data_low, 16) and &Hffff
        CTF_L2_LLC_MAX_LENGTH_L2_PARSE_LLC_MAX_LENGTH_mask = &Hffff
        if data_low > LONG_MAX then
            if CTF_L2_LLC_MAX_LENGTH_L2_PARSE_LLC_MAX_LENGTH_mask = mask then
                read_CTF_L2_LLC_MAX_LENGTH_L2_PARSE_LLC_MAX_LENGTH_value = data_low
            else
                read_CTF_L2_LLC_MAX_LENGTH_L2_PARSE_LLC_MAX_LENGTH_value = (data_low - H8000_0000) and CTF_L2_LLC_MAX_LENGTH_L2_PARSE_LLC_MAX_LENGTH_mask
            end If
        else
            read_CTF_L2_LLC_MAX_LENGTH_L2_PARSE_LLC_MAX_LENGTH_value = data_low and CTF_L2_LLC_MAX_LENGTH_L2_PARSE_LLC_MAX_LENGTH_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CTF_L2_LLC_MAX_LENGTH_RESERVED_value = &H0
        flag_CTF_L2_LLC_MAX_LENGTH_RESERVED        = &H0
        write_CTF_L2_LLC_MAX_LENGTH_L2_PARSE_LLC_MAX_LENGTH_value = &H0
        flag_CTF_L2_LLC_MAX_LENGTH_L2_PARSE_LLC_MAX_LENGTH        = &H0
    End Sub
End Class


'' @REGISTER : CTF_ctf_l2_llc_snap_type_lo
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CL2LSTLL2PSDSCO                            [31:0]           get_CL2LSTLL2PSDSCO
''                                                             set_CL2LSTLL2PSDSCO
''                                                             read_CL2LSTLL2PSDSCO
''                                                             write_CL2LSTLL2PSDSCO
''---------------------------------------------------------------------------------
Class REGISTER_CTF_ctf_l2_llc_snap_type_lo
    Private write_CL2LSTLL2PSDSCO_value
    Private read_CL2LSTLL2PSDSCO_value
    Private flag_CL2LSTLL2PSDSCO

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

    Property Get get_CL2LSTLL2PSDSCO
        get_CL2LSTLL2PSDSCO = read_CL2LSTLL2PSDSCO_value
    End Property

    Property Let set_CL2LSTLL2PSDSCO(aData)
        write_CL2LSTLL2PSDSCO_value = aData
        flag_CL2LSTLL2PSDSCO        = &H1
    End Property

    Property Get read_CL2LSTLL2PSDSCO
        read
        read_CL2LSTLL2PSDSCO = read_CL2LSTLL2PSDSCO_value
    End Property

    Property Let write_CL2LSTLL2PSDSCO(aData)
        set_CL2LSTLL2PSDSCO = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CL2LSTLL2PSDSCO_mask = &Hffffffff
        if data_low > LONG_MAX then
            if CL2LSTLL2PSDSCO_mask = mask then
                read_CL2LSTLL2PSDSCO_value = data_low
            else
                read_CL2LSTLL2PSDSCO_value = (data_low - H8000_0000) and CL2LSTLL2PSDSCO_mask
            end If
        else
            read_CL2LSTLL2PSDSCO_value = data_low and CL2LSTLL2PSDSCO_mask
        end If

    End Sub

    Sub write
        If flag_CL2LSTLL2PSDSCO = &H0 Then read
        If flag_CL2LSTLL2PSDSCO = &H0 Then write_CL2LSTLL2PSDSCO_value = get_CL2LSTLL2PSDSCO

        regValue = leftShift(write_CL2LSTLL2PSDSCO_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CL2LSTLL2PSDSCO_mask = &Hffffffff
        if data_low > LONG_MAX then
            if CL2LSTLL2PSDSCO_mask = mask then
                read_CL2LSTLL2PSDSCO_value = data_low
            else
                read_CL2LSTLL2PSDSCO_value = (data_low - H8000_0000) and CL2LSTLL2PSDSCO_mask
            end If
        else
            read_CL2LSTLL2PSDSCO_value = data_low and CL2LSTLL2PSDSCO_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CL2LSTLL2PSDSCO_value = &H0
        flag_CL2LSTLL2PSDSCO        = &H0
    End Sub
End Class


'' @REGISTER : CTF_ctf_l2_llc_snap_type_hi
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CTF_L2_LLC_SNAP_TYPE_HI_RESERVED           [31:16]          get_CTF_L2_LLC_SNAP_TYPE_HI_RESERVED
''                                                             set_CTF_L2_LLC_SNAP_TYPE_HI_RESERVED
''                                                             read_CTF_L2_LLC_SNAP_TYPE_HI_RESERVED
''                                                             write_CTF_L2_LLC_SNAP_TYPE_HI_RESERVED
''---------------------------------------------------------------------------------
'' CL2LSTHL2PSDSCO                            [15:0]           get_CL2LSTHL2PSDSCO
''                                                             set_CL2LSTHL2PSDSCO
''                                                             read_CL2LSTHL2PSDSCO
''                                                             write_CL2LSTHL2PSDSCO
''---------------------------------------------------------------------------------
Class REGISTER_CTF_ctf_l2_llc_snap_type_hi
    Private write_CTF_L2_LLC_SNAP_TYPE_HI_RESERVED_value
    Private read_CTF_L2_LLC_SNAP_TYPE_HI_RESERVED_value
    Private flag_CTF_L2_LLC_SNAP_TYPE_HI_RESERVED
    Private write_CL2LSTHL2PSDSCO_value
    Private read_CL2LSTHL2PSDSCO_value
    Private flag_CL2LSTHL2PSDSCO

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

    Property Get get_CTF_L2_LLC_SNAP_TYPE_HI_RESERVED
        get_CTF_L2_LLC_SNAP_TYPE_HI_RESERVED = read_CTF_L2_LLC_SNAP_TYPE_HI_RESERVED_value
    End Property

    Property Let set_CTF_L2_LLC_SNAP_TYPE_HI_RESERVED(aData)
        write_CTF_L2_LLC_SNAP_TYPE_HI_RESERVED_value = aData
        flag_CTF_L2_LLC_SNAP_TYPE_HI_RESERVED        = &H1
    End Property

    Property Get read_CTF_L2_LLC_SNAP_TYPE_HI_RESERVED
        read
        read_CTF_L2_LLC_SNAP_TYPE_HI_RESERVED = read_CTF_L2_LLC_SNAP_TYPE_HI_RESERVED_value
    End Property

    Property Let write_CTF_L2_LLC_SNAP_TYPE_HI_RESERVED(aData)
        set_CTF_L2_LLC_SNAP_TYPE_HI_RESERVED = aData
        write
    End Property

    Property Get get_CL2LSTHL2PSDSCO
        get_CL2LSTHL2PSDSCO = read_CL2LSTHL2PSDSCO_value
    End Property

    Property Let set_CL2LSTHL2PSDSCO(aData)
        write_CL2LSTHL2PSDSCO_value = aData
        flag_CL2LSTHL2PSDSCO        = &H1
    End Property

    Property Get read_CL2LSTHL2PSDSCO
        read
        read_CL2LSTHL2PSDSCO = read_CL2LSTHL2PSDSCO_value
    End Property

    Property Let write_CL2LSTHL2PSDSCO(aData)
        set_CL2LSTHL2PSDSCO = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CTF_L2_LLC_SNAP_TYPE_HI_RESERVED_value = rightShift(data_low, 16) and &Hffff
        CL2LSTHL2PSDSCO_mask = &Hffff
        if data_low > LONG_MAX then
            if CL2LSTHL2PSDSCO_mask = mask then
                read_CL2LSTHL2PSDSCO_value = data_low
            else
                read_CL2LSTHL2PSDSCO_value = (data_low - H8000_0000) and CL2LSTHL2PSDSCO_mask
            end If
        else
            read_CL2LSTHL2PSDSCO_value = data_low and CL2LSTHL2PSDSCO_mask
        end If

    End Sub

    Sub write
        If flag_CTF_L2_LLC_SNAP_TYPE_HI_RESERVED = &H0 or flag_CL2LSTHL2PSDSCO = &H0 Then read
        If flag_CTF_L2_LLC_SNAP_TYPE_HI_RESERVED = &H0 Then write_CTF_L2_LLC_SNAP_TYPE_HI_RESERVED_value = get_CTF_L2_LLC_SNAP_TYPE_HI_RESERVED
        If flag_CL2LSTHL2PSDSCO = &H0 Then write_CL2LSTHL2PSDSCO_value = get_CL2LSTHL2PSDSCO

        regValue = leftShift((write_CTF_L2_LLC_SNAP_TYPE_HI_RESERVED_value and &Hffff), 16) + leftShift((write_CL2LSTHL2PSDSCO_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CTF_L2_LLC_SNAP_TYPE_HI_RESERVED_value = rightShift(data_low, 16) and &Hffff
        CL2LSTHL2PSDSCO_mask = &Hffff
        if data_low > LONG_MAX then
            if CL2LSTHL2PSDSCO_mask = mask then
                read_CL2LSTHL2PSDSCO_value = data_low
            else
                read_CL2LSTHL2PSDSCO_value = (data_low - H8000_0000) and CL2LSTHL2PSDSCO_mask
            end If
        else
            read_CL2LSTHL2PSDSCO_value = data_low and CL2LSTHL2PSDSCO_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CTF_L2_LLC_SNAP_TYPE_HI_RESERVED_value = &H0
        flag_CTF_L2_LLC_SNAP_TYPE_HI_RESERVED        = &H0
        write_CL2LSTHL2PSDSCO_value = &H0
        flag_CL2LSTHL2PSDSCO        = &H0
    End Sub
End Class


'' @REGISTER : CTF_ctf_l2_ethertype
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CTF_L2_ETHERTYPE_L2_PARSE_ET_IPV6          [31:16]          get_CTF_L2_ETHERTYPE_L2_PARSE_ET_IPV6
''                                                             set_CTF_L2_ETHERTYPE_L2_PARSE_ET_IPV6
''                                                             read_CTF_L2_ETHERTYPE_L2_PARSE_ET_IPV6
''                                                             write_CTF_L2_ETHERTYPE_L2_PARSE_ET_IPV6
''---------------------------------------------------------------------------------
'' CTF_L2_ETHERTYPE_L2_PARSE_ET_IPV4          [15:0]           get_CTF_L2_ETHERTYPE_L2_PARSE_ET_IPV4
''                                                             set_CTF_L2_ETHERTYPE_L2_PARSE_ET_IPV4
''                                                             read_CTF_L2_ETHERTYPE_L2_PARSE_ET_IPV4
''                                                             write_CTF_L2_ETHERTYPE_L2_PARSE_ET_IPV4
''---------------------------------------------------------------------------------
Class REGISTER_CTF_ctf_l2_ethertype
    Private write_CTF_L2_ETHERTYPE_L2_PARSE_ET_IPV6_value
    Private read_CTF_L2_ETHERTYPE_L2_PARSE_ET_IPV6_value
    Private flag_CTF_L2_ETHERTYPE_L2_PARSE_ET_IPV6
    Private write_CTF_L2_ETHERTYPE_L2_PARSE_ET_IPV4_value
    Private read_CTF_L2_ETHERTYPE_L2_PARSE_ET_IPV4_value
    Private flag_CTF_L2_ETHERTYPE_L2_PARSE_ET_IPV4

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H20
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_CTF_L2_ETHERTYPE_L2_PARSE_ET_IPV6
        get_CTF_L2_ETHERTYPE_L2_PARSE_ET_IPV6 = read_CTF_L2_ETHERTYPE_L2_PARSE_ET_IPV6_value
    End Property

    Property Let set_CTF_L2_ETHERTYPE_L2_PARSE_ET_IPV6(aData)
        write_CTF_L2_ETHERTYPE_L2_PARSE_ET_IPV6_value = aData
        flag_CTF_L2_ETHERTYPE_L2_PARSE_ET_IPV6        = &H1
    End Property

    Property Get read_CTF_L2_ETHERTYPE_L2_PARSE_ET_IPV6
        read
        read_CTF_L2_ETHERTYPE_L2_PARSE_ET_IPV6 = read_CTF_L2_ETHERTYPE_L2_PARSE_ET_IPV6_value
    End Property

    Property Let write_CTF_L2_ETHERTYPE_L2_PARSE_ET_IPV6(aData)
        set_CTF_L2_ETHERTYPE_L2_PARSE_ET_IPV6 = aData
        write
    End Property

    Property Get get_CTF_L2_ETHERTYPE_L2_PARSE_ET_IPV4
        get_CTF_L2_ETHERTYPE_L2_PARSE_ET_IPV4 = read_CTF_L2_ETHERTYPE_L2_PARSE_ET_IPV4_value
    End Property

    Property Let set_CTF_L2_ETHERTYPE_L2_PARSE_ET_IPV4(aData)
        write_CTF_L2_ETHERTYPE_L2_PARSE_ET_IPV4_value = aData
        flag_CTF_L2_ETHERTYPE_L2_PARSE_ET_IPV4        = &H1
    End Property

    Property Get read_CTF_L2_ETHERTYPE_L2_PARSE_ET_IPV4
        read
        read_CTF_L2_ETHERTYPE_L2_PARSE_ET_IPV4 = read_CTF_L2_ETHERTYPE_L2_PARSE_ET_IPV4_value
    End Property

    Property Let write_CTF_L2_ETHERTYPE_L2_PARSE_ET_IPV4(aData)
        set_CTF_L2_ETHERTYPE_L2_PARSE_ET_IPV4 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CTF_L2_ETHERTYPE_L2_PARSE_ET_IPV6_value = rightShift(data_low, 16) and &Hffff
        CTF_L2_ETHERTYPE_L2_PARSE_ET_IPV4_mask = &Hffff
        if data_low > LONG_MAX then
            if CTF_L2_ETHERTYPE_L2_PARSE_ET_IPV4_mask = mask then
                read_CTF_L2_ETHERTYPE_L2_PARSE_ET_IPV4_value = data_low
            else
                read_CTF_L2_ETHERTYPE_L2_PARSE_ET_IPV4_value = (data_low - H8000_0000) and CTF_L2_ETHERTYPE_L2_PARSE_ET_IPV4_mask
            end If
        else
            read_CTF_L2_ETHERTYPE_L2_PARSE_ET_IPV4_value = data_low and CTF_L2_ETHERTYPE_L2_PARSE_ET_IPV4_mask
        end If

    End Sub

    Sub write
        If flag_CTF_L2_ETHERTYPE_L2_PARSE_ET_IPV6 = &H0 or flag_CTF_L2_ETHERTYPE_L2_PARSE_ET_IPV4 = &H0 Then read
        If flag_CTF_L2_ETHERTYPE_L2_PARSE_ET_IPV6 = &H0 Then write_CTF_L2_ETHERTYPE_L2_PARSE_ET_IPV6_value = get_CTF_L2_ETHERTYPE_L2_PARSE_ET_IPV6
        If flag_CTF_L2_ETHERTYPE_L2_PARSE_ET_IPV4 = &H0 Then write_CTF_L2_ETHERTYPE_L2_PARSE_ET_IPV4_value = get_CTF_L2_ETHERTYPE_L2_PARSE_ET_IPV4

        regValue = leftShift((write_CTF_L2_ETHERTYPE_L2_PARSE_ET_IPV6_value and &Hffff), 16) + leftShift((write_CTF_L2_ETHERTYPE_L2_PARSE_ET_IPV4_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CTF_L2_ETHERTYPE_L2_PARSE_ET_IPV6_value = rightShift(data_low, 16) and &Hffff
        CTF_L2_ETHERTYPE_L2_PARSE_ET_IPV4_mask = &Hffff
        if data_low > LONG_MAX then
            if CTF_L2_ETHERTYPE_L2_PARSE_ET_IPV4_mask = mask then
                read_CTF_L2_ETHERTYPE_L2_PARSE_ET_IPV4_value = data_low
            else
                read_CTF_L2_ETHERTYPE_L2_PARSE_ET_IPV4_value = (data_low - H8000_0000) and CTF_L2_ETHERTYPE_L2_PARSE_ET_IPV4_mask
            end If
        else
            read_CTF_L2_ETHERTYPE_L2_PARSE_ET_IPV4_value = data_low and CTF_L2_ETHERTYPE_L2_PARSE_ET_IPV4_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CTF_L2_ETHERTYPE_L2_PARSE_ET_IPV6_value = &H0
        flag_CTF_L2_ETHERTYPE_L2_PARSE_ET_IPV6        = &H0
        write_CTF_L2_ETHERTYPE_L2_PARSE_ET_IPV4_value = &H0
        flag_CTF_L2_ETHERTYPE_L2_PARSE_ET_IPV4        = &H0
    End Sub
End Class


'' @REGISTER : CTF_ctf_l3_ipv6_type
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CTF_L3_IPV6_TYPE_RESERVED                  [31:16]          get_CTF_L3_IPV6_TYPE_RESERVED
''                                                             set_CTF_L3_IPV6_TYPE_RESERVED
''                                                             read_CTF_L3_IPV6_TYPE_RESERVED
''                                                             write_CTF_L3_IPV6_TYPE_RESERVED
''---------------------------------------------------------------------------------
'' CL3I6TL3PI6NHU                             [15:8]           get_CL3I6TL3PI6NHU
''                                                             set_CL3I6TL3PI6NHU
''                                                             read_CL3I6TL3PI6NHU
''                                                             write_CL3I6TL3PI6NHU
''---------------------------------------------------------------------------------
'' CL3I6TL3PI6NHT1                            [7:0]            get_CL3I6TL3PI6NHT1
''                                                             set_CL3I6TL3PI6NHT1
''                                                             read_CL3I6TL3PI6NHT1
''                                                             write_CL3I6TL3PI6NHT1
''---------------------------------------------------------------------------------
Class REGISTER_CTF_ctf_l3_ipv6_type
    Private write_CTF_L3_IPV6_TYPE_RESERVED_value
    Private read_CTF_L3_IPV6_TYPE_RESERVED_value
    Private flag_CTF_L3_IPV6_TYPE_RESERVED
    Private write_CL3I6TL3PI6NHU_value
    Private read_CL3I6TL3PI6NHU_value
    Private flag_CL3I6TL3PI6NHU
    Private write_CL3I6TL3PI6NHT1_value
    Private read_CL3I6TL3PI6NHT1_value
    Private flag_CL3I6TL3PI6NHT1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H24
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_CTF_L3_IPV6_TYPE_RESERVED
        get_CTF_L3_IPV6_TYPE_RESERVED = read_CTF_L3_IPV6_TYPE_RESERVED_value
    End Property

    Property Let set_CTF_L3_IPV6_TYPE_RESERVED(aData)
        write_CTF_L3_IPV6_TYPE_RESERVED_value = aData
        flag_CTF_L3_IPV6_TYPE_RESERVED        = &H1
    End Property

    Property Get read_CTF_L3_IPV6_TYPE_RESERVED
        read
        read_CTF_L3_IPV6_TYPE_RESERVED = read_CTF_L3_IPV6_TYPE_RESERVED_value
    End Property

    Property Let write_CTF_L3_IPV6_TYPE_RESERVED(aData)
        set_CTF_L3_IPV6_TYPE_RESERVED = aData
        write
    End Property

    Property Get get_CL3I6TL3PI6NHU
        get_CL3I6TL3PI6NHU = read_CL3I6TL3PI6NHU_value
    End Property

    Property Let set_CL3I6TL3PI6NHU(aData)
        write_CL3I6TL3PI6NHU_value = aData
        flag_CL3I6TL3PI6NHU        = &H1
    End Property

    Property Get read_CL3I6TL3PI6NHU
        read
        read_CL3I6TL3PI6NHU = read_CL3I6TL3PI6NHU_value
    End Property

    Property Let write_CL3I6TL3PI6NHU(aData)
        set_CL3I6TL3PI6NHU = aData
        write
    End Property

    Property Get get_CL3I6TL3PI6NHT1
        get_CL3I6TL3PI6NHT1 = read_CL3I6TL3PI6NHT1_value
    End Property

    Property Let set_CL3I6TL3PI6NHT1(aData)
        write_CL3I6TL3PI6NHT1_value = aData
        flag_CL3I6TL3PI6NHT1        = &H1
    End Property

    Property Get read_CL3I6TL3PI6NHT1
        read
        read_CL3I6TL3PI6NHT1 = read_CL3I6TL3PI6NHT1_value
    End Property

    Property Let write_CL3I6TL3PI6NHT1(aData)
        set_CL3I6TL3PI6NHT1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CTF_L3_IPV6_TYPE_RESERVED_value = rightShift(data_low, 16) and &Hffff
        read_CL3I6TL3PI6NHU_value = rightShift(data_low, 8) and &Hff
        CL3I6TL3PI6NHT1_mask = &Hff
        if data_low > LONG_MAX then
            if CL3I6TL3PI6NHT1_mask = mask then
                read_CL3I6TL3PI6NHT1_value = data_low
            else
                read_CL3I6TL3PI6NHT1_value = (data_low - H8000_0000) and CL3I6TL3PI6NHT1_mask
            end If
        else
            read_CL3I6TL3PI6NHT1_value = data_low and CL3I6TL3PI6NHT1_mask
        end If

    End Sub

    Sub write
        If flag_CTF_L3_IPV6_TYPE_RESERVED = &H0 or flag_CL3I6TL3PI6NHU = &H0 or flag_CL3I6TL3PI6NHT1 = &H0 Then read
        If flag_CTF_L3_IPV6_TYPE_RESERVED = &H0 Then write_CTF_L3_IPV6_TYPE_RESERVED_value = get_CTF_L3_IPV6_TYPE_RESERVED
        If flag_CL3I6TL3PI6NHU = &H0 Then write_CL3I6TL3PI6NHU_value = get_CL3I6TL3PI6NHU
        If flag_CL3I6TL3PI6NHT1 = &H0 Then write_CL3I6TL3PI6NHT1_value = get_CL3I6TL3PI6NHT1

        regValue = leftShift((write_CTF_L3_IPV6_TYPE_RESERVED_value and &Hffff), 16) + leftShift((write_CL3I6TL3PI6NHU_value and &Hff), 8) + leftShift((write_CL3I6TL3PI6NHT1_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CTF_L3_IPV6_TYPE_RESERVED_value = rightShift(data_low, 16) and &Hffff
        read_CL3I6TL3PI6NHU_value = rightShift(data_low, 8) and &Hff
        CL3I6TL3PI6NHT1_mask = &Hff
        if data_low > LONG_MAX then
            if CL3I6TL3PI6NHT1_mask = mask then
                read_CL3I6TL3PI6NHT1_value = data_low
            else
                read_CL3I6TL3PI6NHT1_value = (data_low - H8000_0000) and CL3I6TL3PI6NHT1_mask
            end If
        else
            read_CL3I6TL3PI6NHT1_value = data_low and CL3I6TL3PI6NHT1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CTF_L3_IPV6_TYPE_RESERVED_value = &H0
        flag_CTF_L3_IPV6_TYPE_RESERVED        = &H0
        write_CL3I6TL3PI6NHU_value = &H0
        flag_CL3I6TL3PI6NHU        = &H0
        write_CL3I6TL3PI6NHT1_value = &H0
        flag_CL3I6TL3PI6NHT1        = &H0
    End Sub
End Class


'' @REGISTER : CTF_ctf_l3_ipv4_type
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CTF_L3_IPV4_TYPE_RESERVED                  [31:17]          get_CTF_L3_IPV4_TYPE_RESERVED
''                                                             set_CTF_L3_IPV4_TYPE_RESERVED
''                                                             read_CTF_L3_IPV4_TYPE_RESERVED
''                                                             write_CTF_L3_IPV4_TYPE_RESERVED
''---------------------------------------------------------------------------------
'' CTF_L3_IPV4_TYPE_L3_PARSE_CHECKSUM_ENABLE   [16:16]          get_CTF_L3_IPV4_TYPE_L3_PARSE_CHECKSUM_ENABLE
''                                                             set_CTF_L3_IPV4_TYPE_L3_PARSE_CHECKSUM_ENABLE
''                                                             read_CTF_L3_IPV4_TYPE_L3_PARSE_CHECKSUM_ENABLE
''                                                             write_CTF_L3_IPV4_TYPE_L3_PARSE_CHECKSUM_ENABLE
''---------------------------------------------------------------------------------
'' CTF_L3_IPV4_TYPE_L3_PARSE_IPV4_PROTO_UDP   [15:8]           get_CTF_L3_IPV4_TYPE_L3_PARSE_IPV4_PROTO_UDP
''                                                             set_CTF_L3_IPV4_TYPE_L3_PARSE_IPV4_PROTO_UDP
''                                                             read_CTF_L3_IPV4_TYPE_L3_PARSE_IPV4_PROTO_UDP
''                                                             write_CTF_L3_IPV4_TYPE_L3_PARSE_IPV4_PROTO_UDP
''---------------------------------------------------------------------------------
'' CTF_L3_IPV4_TYPE_L3_PARSE_IPV4_PROTO_TCP   [7:0]            get_CTF_L3_IPV4_TYPE_L3_PARSE_IPV4_PROTO_TCP
''                                                             set_CTF_L3_IPV4_TYPE_L3_PARSE_IPV4_PROTO_TCP
''                                                             read_CTF_L3_IPV4_TYPE_L3_PARSE_IPV4_PROTO_TCP
''                                                             write_CTF_L3_IPV4_TYPE_L3_PARSE_IPV4_PROTO_TCP
''---------------------------------------------------------------------------------
Class REGISTER_CTF_ctf_l3_ipv4_type
    Private write_CTF_L3_IPV4_TYPE_RESERVED_value
    Private read_CTF_L3_IPV4_TYPE_RESERVED_value
    Private flag_CTF_L3_IPV4_TYPE_RESERVED
    Private write_CTF_L3_IPV4_TYPE_L3_PARSE_CHECKSUM_ENABLE_value
    Private read_CTF_L3_IPV4_TYPE_L3_PARSE_CHECKSUM_ENABLE_value
    Private flag_CTF_L3_IPV4_TYPE_L3_PARSE_CHECKSUM_ENABLE
    Private write_CTF_L3_IPV4_TYPE_L3_PARSE_IPV4_PROTO_UDP_value
    Private read_CTF_L3_IPV4_TYPE_L3_PARSE_IPV4_PROTO_UDP_value
    Private flag_CTF_L3_IPV4_TYPE_L3_PARSE_IPV4_PROTO_UDP
    Private write_CTF_L3_IPV4_TYPE_L3_PARSE_IPV4_PROTO_TCP_value
    Private read_CTF_L3_IPV4_TYPE_L3_PARSE_IPV4_PROTO_TCP_value
    Private flag_CTF_L3_IPV4_TYPE_L3_PARSE_IPV4_PROTO_TCP

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H28
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_CTF_L3_IPV4_TYPE_RESERVED
        get_CTF_L3_IPV4_TYPE_RESERVED = read_CTF_L3_IPV4_TYPE_RESERVED_value
    End Property

    Property Let set_CTF_L3_IPV4_TYPE_RESERVED(aData)
        write_CTF_L3_IPV4_TYPE_RESERVED_value = aData
        flag_CTF_L3_IPV4_TYPE_RESERVED        = &H1
    End Property

    Property Get read_CTF_L3_IPV4_TYPE_RESERVED
        read
        read_CTF_L3_IPV4_TYPE_RESERVED = read_CTF_L3_IPV4_TYPE_RESERVED_value
    End Property

    Property Let write_CTF_L3_IPV4_TYPE_RESERVED(aData)
        set_CTF_L3_IPV4_TYPE_RESERVED = aData
        write
    End Property

    Property Get get_CTF_L3_IPV4_TYPE_L3_PARSE_CHECKSUM_ENABLE
        get_CTF_L3_IPV4_TYPE_L3_PARSE_CHECKSUM_ENABLE = read_CTF_L3_IPV4_TYPE_L3_PARSE_CHECKSUM_ENABLE_value
    End Property

    Property Let set_CTF_L3_IPV4_TYPE_L3_PARSE_CHECKSUM_ENABLE(aData)
        write_CTF_L3_IPV4_TYPE_L3_PARSE_CHECKSUM_ENABLE_value = aData
        flag_CTF_L3_IPV4_TYPE_L3_PARSE_CHECKSUM_ENABLE        = &H1
    End Property

    Property Get read_CTF_L3_IPV4_TYPE_L3_PARSE_CHECKSUM_ENABLE
        read
        read_CTF_L3_IPV4_TYPE_L3_PARSE_CHECKSUM_ENABLE = read_CTF_L3_IPV4_TYPE_L3_PARSE_CHECKSUM_ENABLE_value
    End Property

    Property Let write_CTF_L3_IPV4_TYPE_L3_PARSE_CHECKSUM_ENABLE(aData)
        set_CTF_L3_IPV4_TYPE_L3_PARSE_CHECKSUM_ENABLE = aData
        write
    End Property

    Property Get get_CTF_L3_IPV4_TYPE_L3_PARSE_IPV4_PROTO_UDP
        get_CTF_L3_IPV4_TYPE_L3_PARSE_IPV4_PROTO_UDP = read_CTF_L3_IPV4_TYPE_L3_PARSE_IPV4_PROTO_UDP_value
    End Property

    Property Let set_CTF_L3_IPV4_TYPE_L3_PARSE_IPV4_PROTO_UDP(aData)
        write_CTF_L3_IPV4_TYPE_L3_PARSE_IPV4_PROTO_UDP_value = aData
        flag_CTF_L3_IPV4_TYPE_L3_PARSE_IPV4_PROTO_UDP        = &H1
    End Property

    Property Get read_CTF_L3_IPV4_TYPE_L3_PARSE_IPV4_PROTO_UDP
        read
        read_CTF_L3_IPV4_TYPE_L3_PARSE_IPV4_PROTO_UDP = read_CTF_L3_IPV4_TYPE_L3_PARSE_IPV4_PROTO_UDP_value
    End Property

    Property Let write_CTF_L3_IPV4_TYPE_L3_PARSE_IPV4_PROTO_UDP(aData)
        set_CTF_L3_IPV4_TYPE_L3_PARSE_IPV4_PROTO_UDP = aData
        write
    End Property

    Property Get get_CTF_L3_IPV4_TYPE_L3_PARSE_IPV4_PROTO_TCP
        get_CTF_L3_IPV4_TYPE_L3_PARSE_IPV4_PROTO_TCP = read_CTF_L3_IPV4_TYPE_L3_PARSE_IPV4_PROTO_TCP_value
    End Property

    Property Let set_CTF_L3_IPV4_TYPE_L3_PARSE_IPV4_PROTO_TCP(aData)
        write_CTF_L3_IPV4_TYPE_L3_PARSE_IPV4_PROTO_TCP_value = aData
        flag_CTF_L3_IPV4_TYPE_L3_PARSE_IPV4_PROTO_TCP        = &H1
    End Property

    Property Get read_CTF_L3_IPV4_TYPE_L3_PARSE_IPV4_PROTO_TCP
        read
        read_CTF_L3_IPV4_TYPE_L3_PARSE_IPV4_PROTO_TCP = read_CTF_L3_IPV4_TYPE_L3_PARSE_IPV4_PROTO_TCP_value
    End Property

    Property Let write_CTF_L3_IPV4_TYPE_L3_PARSE_IPV4_PROTO_TCP(aData)
        set_CTF_L3_IPV4_TYPE_L3_PARSE_IPV4_PROTO_TCP = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CTF_L3_IPV4_TYPE_RESERVED_value = rightShift(data_low, 17) and &H7fff
        read_CTF_L3_IPV4_TYPE_L3_PARSE_CHECKSUM_ENABLE_value = rightShift(data_low, 16) and &H1
        read_CTF_L3_IPV4_TYPE_L3_PARSE_IPV4_PROTO_UDP_value = rightShift(data_low, 8) and &Hff
        CTF_L3_IPV4_TYPE_L3_PARSE_IPV4_PROTO_TCP_mask = &Hff
        if data_low > LONG_MAX then
            if CTF_L3_IPV4_TYPE_L3_PARSE_IPV4_PROTO_TCP_mask = mask then
                read_CTF_L3_IPV4_TYPE_L3_PARSE_IPV4_PROTO_TCP_value = data_low
            else
                read_CTF_L3_IPV4_TYPE_L3_PARSE_IPV4_PROTO_TCP_value = (data_low - H8000_0000) and CTF_L3_IPV4_TYPE_L3_PARSE_IPV4_PROTO_TCP_mask
            end If
        else
            read_CTF_L3_IPV4_TYPE_L3_PARSE_IPV4_PROTO_TCP_value = data_low and CTF_L3_IPV4_TYPE_L3_PARSE_IPV4_PROTO_TCP_mask
        end If

    End Sub

    Sub write
        If flag_CTF_L3_IPV4_TYPE_RESERVED = &H0 or flag_CTF_L3_IPV4_TYPE_L3_PARSE_CHECKSUM_ENABLE = &H0 or flag_CTF_L3_IPV4_TYPE_L3_PARSE_IPV4_PROTO_UDP = &H0 or flag_CTF_L3_IPV4_TYPE_L3_PARSE_IPV4_PROTO_TCP = &H0 Then read
        If flag_CTF_L3_IPV4_TYPE_RESERVED = &H0 Then write_CTF_L3_IPV4_TYPE_RESERVED_value = get_CTF_L3_IPV4_TYPE_RESERVED
        If flag_CTF_L3_IPV4_TYPE_L3_PARSE_CHECKSUM_ENABLE = &H0 Then write_CTF_L3_IPV4_TYPE_L3_PARSE_CHECKSUM_ENABLE_value = get_CTF_L3_IPV4_TYPE_L3_PARSE_CHECKSUM_ENABLE
        If flag_CTF_L3_IPV4_TYPE_L3_PARSE_IPV4_PROTO_UDP = &H0 Then write_CTF_L3_IPV4_TYPE_L3_PARSE_IPV4_PROTO_UDP_value = get_CTF_L3_IPV4_TYPE_L3_PARSE_IPV4_PROTO_UDP
        If flag_CTF_L3_IPV4_TYPE_L3_PARSE_IPV4_PROTO_TCP = &H0 Then write_CTF_L3_IPV4_TYPE_L3_PARSE_IPV4_PROTO_TCP_value = get_CTF_L3_IPV4_TYPE_L3_PARSE_IPV4_PROTO_TCP

        regValue = leftShift((write_CTF_L3_IPV4_TYPE_RESERVED_value and &H7fff), 17) + leftShift((write_CTF_L3_IPV4_TYPE_L3_PARSE_CHECKSUM_ENABLE_value and &H1), 16) + leftShift((write_CTF_L3_IPV4_TYPE_L3_PARSE_IPV4_PROTO_UDP_value and &Hff), 8) + leftShift((write_CTF_L3_IPV4_TYPE_L3_PARSE_IPV4_PROTO_TCP_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CTF_L3_IPV4_TYPE_RESERVED_value = rightShift(data_low, 17) and &H7fff
        read_CTF_L3_IPV4_TYPE_L3_PARSE_CHECKSUM_ENABLE_value = rightShift(data_low, 16) and &H1
        read_CTF_L3_IPV4_TYPE_L3_PARSE_IPV4_PROTO_UDP_value = rightShift(data_low, 8) and &Hff
        CTF_L3_IPV4_TYPE_L3_PARSE_IPV4_PROTO_TCP_mask = &Hff
        if data_low > LONG_MAX then
            if CTF_L3_IPV4_TYPE_L3_PARSE_IPV4_PROTO_TCP_mask = mask then
                read_CTF_L3_IPV4_TYPE_L3_PARSE_IPV4_PROTO_TCP_value = data_low
            else
                read_CTF_L3_IPV4_TYPE_L3_PARSE_IPV4_PROTO_TCP_value = (data_low - H8000_0000) and CTF_L3_IPV4_TYPE_L3_PARSE_IPV4_PROTO_TCP_mask
            end If
        else
            read_CTF_L3_IPV4_TYPE_L3_PARSE_IPV4_PROTO_TCP_value = data_low and CTF_L3_IPV4_TYPE_L3_PARSE_IPV4_PROTO_TCP_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CTF_L3_IPV4_TYPE_RESERVED_value = &H0
        flag_CTF_L3_IPV4_TYPE_RESERVED        = &H0
        write_CTF_L3_IPV4_TYPE_L3_PARSE_CHECKSUM_ENABLE_value = &H0
        flag_CTF_L3_IPV4_TYPE_L3_PARSE_CHECKSUM_ENABLE        = &H0
        write_CTF_L3_IPV4_TYPE_L3_PARSE_IPV4_PROTO_UDP_value = &H0
        flag_CTF_L3_IPV4_TYPE_L3_PARSE_IPV4_PROTO_UDP        = &H0
        write_CTF_L3_IPV4_TYPE_L3_PARSE_IPV4_PROTO_TCP_value = &H0
        flag_CTF_L3_IPV4_TYPE_L3_PARSE_IPV4_PROTO_TCP        = &H0
    End Sub
End Class


'' @REGISTER : CTF_ctf_l3_napt_control
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CTF_L3_NAPT_CONTROL_RESERVED               [31:23]          get_CTF_L3_NAPT_CONTROL_RESERVED
''                                                             set_CTF_L3_NAPT_CONTROL_RESERVED
''                                                             read_CTF_L3_NAPT_CONTROL_RESERVED
''                                                             write_CTF_L3_NAPT_CONTROL_RESERVED
''---------------------------------------------------------------------------------
'' CTF_L3_NAPT_CONTROL_L3_FWD_TTL_HOP_ZERO    [22:22]          get_CTF_L3_NAPT_CONTROL_L3_FWD_TTL_HOP_ZERO
''                                                             set_CTF_L3_NAPT_CONTROL_L3_FWD_TTL_HOP_ZERO
''                                                             read_CTF_L3_NAPT_CONTROL_L3_FWD_TTL_HOP_ZERO
''                                                             write_CTF_L3_NAPT_CONTROL_L3_FWD_TTL_HOP_ZERO
''---------------------------------------------------------------------------------
'' CL3NCL3HEDT1                               [21:21]          get_CL3NCL3HEDT1
''                                                             set_CL3NCL3HEDT1
''                                                             read_CL3NCL3HEDT1
''                                                             write_CL3NCL3HEDT1
''---------------------------------------------------------------------------------
'' CTF_L3_NAPT_CONTROL_NAPT_HASH_SELECT       [20:20]          get_CTF_L3_NAPT_CONTROL_NAPT_HASH_SELECT
''                                                             set_CTF_L3_NAPT_CONTROL_NAPT_HASH_SELECT
''                                                             read_CTF_L3_NAPT_CONTROL_NAPT_HASH_SELECT
''                                                             write_CTF_L3_NAPT_CONTROL_NAPT_HASH_SELECT
''---------------------------------------------------------------------------------
'' CL3NCHCORE1                                [19:19]          get_CL3NCHCORE1
''                                                             set_CL3NCHCORE1
''                                                             read_CL3NCHCORE1
''                                                             write_CL3NCHCORE1
''---------------------------------------------------------------------------------
'' CTF_L3_NAPT_CONTROL_NAPT_TIMESTAMP         [18:16]          get_CTF_L3_NAPT_CONTROL_NAPT_TIMESTAMP
''                                                             set_CTF_L3_NAPT_CONTROL_NAPT_TIMESTAMP
''                                                             read_CTF_L3_NAPT_CONTROL_NAPT_TIMESTAMP
''                                                             write_CTF_L3_NAPT_CONTROL_NAPT_TIMESTAMP
''---------------------------------------------------------------------------------
'' CTF_L3_NAPT_CONTROL_NAPT_HASH_SEED         [15:0]           get_CTF_L3_NAPT_CONTROL_NAPT_HASH_SEED
''                                                             set_CTF_L3_NAPT_CONTROL_NAPT_HASH_SEED
''                                                             read_CTF_L3_NAPT_CONTROL_NAPT_HASH_SEED
''                                                             write_CTF_L3_NAPT_CONTROL_NAPT_HASH_SEED
''---------------------------------------------------------------------------------
Class REGISTER_CTF_ctf_l3_napt_control
    Private write_CTF_L3_NAPT_CONTROL_RESERVED_value
    Private read_CTF_L3_NAPT_CONTROL_RESERVED_value
    Private flag_CTF_L3_NAPT_CONTROL_RESERVED
    Private write_CTF_L3_NAPT_CONTROL_L3_FWD_TTL_HOP_ZERO_value
    Private read_CTF_L3_NAPT_CONTROL_L3_FWD_TTL_HOP_ZERO_value
    Private flag_CTF_L3_NAPT_CONTROL_L3_FWD_TTL_HOP_ZERO
    Private write_CL3NCL3HEDT1_value
    Private read_CL3NCL3HEDT1_value
    Private flag_CL3NCL3HEDT1
    Private write_CTF_L3_NAPT_CONTROL_NAPT_HASH_SELECT_value
    Private read_CTF_L3_NAPT_CONTROL_NAPT_HASH_SELECT_value
    Private flag_CTF_L3_NAPT_CONTROL_NAPT_HASH_SELECT
    Private write_CL3NCHCORE1_value
    Private read_CL3NCHCORE1_value
    Private flag_CL3NCHCORE1
    Private write_CTF_L3_NAPT_CONTROL_NAPT_TIMESTAMP_value
    Private read_CTF_L3_NAPT_CONTROL_NAPT_TIMESTAMP_value
    Private flag_CTF_L3_NAPT_CONTROL_NAPT_TIMESTAMP
    Private write_CTF_L3_NAPT_CONTROL_NAPT_HASH_SEED_value
    Private read_CTF_L3_NAPT_CONTROL_NAPT_HASH_SEED_value
    Private flag_CTF_L3_NAPT_CONTROL_NAPT_HASH_SEED

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_CTF_L3_NAPT_CONTROL_RESERVED
        get_CTF_L3_NAPT_CONTROL_RESERVED = read_CTF_L3_NAPT_CONTROL_RESERVED_value
    End Property

    Property Let set_CTF_L3_NAPT_CONTROL_RESERVED(aData)
        write_CTF_L3_NAPT_CONTROL_RESERVED_value = aData
        flag_CTF_L3_NAPT_CONTROL_RESERVED        = &H1
    End Property

    Property Get read_CTF_L3_NAPT_CONTROL_RESERVED
        read
        read_CTF_L3_NAPT_CONTROL_RESERVED = read_CTF_L3_NAPT_CONTROL_RESERVED_value
    End Property

    Property Let write_CTF_L3_NAPT_CONTROL_RESERVED(aData)
        set_CTF_L3_NAPT_CONTROL_RESERVED = aData
        write
    End Property

    Property Get get_CTF_L3_NAPT_CONTROL_L3_FWD_TTL_HOP_ZERO
        get_CTF_L3_NAPT_CONTROL_L3_FWD_TTL_HOP_ZERO = read_CTF_L3_NAPT_CONTROL_L3_FWD_TTL_HOP_ZERO_value
    End Property

    Property Let set_CTF_L3_NAPT_CONTROL_L3_FWD_TTL_HOP_ZERO(aData)
        write_CTF_L3_NAPT_CONTROL_L3_FWD_TTL_HOP_ZERO_value = aData
        flag_CTF_L3_NAPT_CONTROL_L3_FWD_TTL_HOP_ZERO        = &H1
    End Property

    Property Get read_CTF_L3_NAPT_CONTROL_L3_FWD_TTL_HOP_ZERO
        read
        read_CTF_L3_NAPT_CONTROL_L3_FWD_TTL_HOP_ZERO = read_CTF_L3_NAPT_CONTROL_L3_FWD_TTL_HOP_ZERO_value
    End Property

    Property Let write_CTF_L3_NAPT_CONTROL_L3_FWD_TTL_HOP_ZERO(aData)
        set_CTF_L3_NAPT_CONTROL_L3_FWD_TTL_HOP_ZERO = aData
        write
    End Property

    Property Get get_CL3NCL3HEDT1
        get_CL3NCL3HEDT1 = read_CL3NCL3HEDT1_value
    End Property

    Property Let set_CL3NCL3HEDT1(aData)
        write_CL3NCL3HEDT1_value = aData
        flag_CL3NCL3HEDT1        = &H1
    End Property

    Property Get read_CL3NCL3HEDT1
        read
        read_CL3NCL3HEDT1 = read_CL3NCL3HEDT1_value
    End Property

    Property Let write_CL3NCL3HEDT1(aData)
        set_CL3NCL3HEDT1 = aData
        write
    End Property

    Property Get get_CTF_L3_NAPT_CONTROL_NAPT_HASH_SELECT
        get_CTF_L3_NAPT_CONTROL_NAPT_HASH_SELECT = read_CTF_L3_NAPT_CONTROL_NAPT_HASH_SELECT_value
    End Property

    Property Let set_CTF_L3_NAPT_CONTROL_NAPT_HASH_SELECT(aData)
        write_CTF_L3_NAPT_CONTROL_NAPT_HASH_SELECT_value = aData
        flag_CTF_L3_NAPT_CONTROL_NAPT_HASH_SELECT        = &H1
    End Property

    Property Get read_CTF_L3_NAPT_CONTROL_NAPT_HASH_SELECT
        read
        read_CTF_L3_NAPT_CONTROL_NAPT_HASH_SELECT = read_CTF_L3_NAPT_CONTROL_NAPT_HASH_SELECT_value
    End Property

    Property Let write_CTF_L3_NAPT_CONTROL_NAPT_HASH_SELECT(aData)
        set_CTF_L3_NAPT_CONTROL_NAPT_HASH_SELECT = aData
        write
    End Property

    Property Get get_CL3NCHCORE1
        get_CL3NCHCORE1 = read_CL3NCHCORE1_value
    End Property

    Property Let set_CL3NCHCORE1(aData)
        write_CL3NCHCORE1_value = aData
        flag_CL3NCHCORE1        = &H1
    End Property

    Property Get read_CL3NCHCORE1
        read
        read_CL3NCHCORE1 = read_CL3NCHCORE1_value
    End Property

    Property Let write_CL3NCHCORE1(aData)
        set_CL3NCHCORE1 = aData
        write
    End Property

    Property Get get_CTF_L3_NAPT_CONTROL_NAPT_TIMESTAMP
        get_CTF_L3_NAPT_CONTROL_NAPT_TIMESTAMP = read_CTF_L3_NAPT_CONTROL_NAPT_TIMESTAMP_value
    End Property

    Property Let set_CTF_L3_NAPT_CONTROL_NAPT_TIMESTAMP(aData)
        write_CTF_L3_NAPT_CONTROL_NAPT_TIMESTAMP_value = aData
        flag_CTF_L3_NAPT_CONTROL_NAPT_TIMESTAMP        = &H1
    End Property

    Property Get read_CTF_L3_NAPT_CONTROL_NAPT_TIMESTAMP
        read
        read_CTF_L3_NAPT_CONTROL_NAPT_TIMESTAMP = read_CTF_L3_NAPT_CONTROL_NAPT_TIMESTAMP_value
    End Property

    Property Let write_CTF_L3_NAPT_CONTROL_NAPT_TIMESTAMP(aData)
        set_CTF_L3_NAPT_CONTROL_NAPT_TIMESTAMP = aData
        write
    End Property

    Property Get get_CTF_L3_NAPT_CONTROL_NAPT_HASH_SEED
        get_CTF_L3_NAPT_CONTROL_NAPT_HASH_SEED = read_CTF_L3_NAPT_CONTROL_NAPT_HASH_SEED_value
    End Property

    Property Let set_CTF_L3_NAPT_CONTROL_NAPT_HASH_SEED(aData)
        write_CTF_L3_NAPT_CONTROL_NAPT_HASH_SEED_value = aData
        flag_CTF_L3_NAPT_CONTROL_NAPT_HASH_SEED        = &H1
    End Property

    Property Get read_CTF_L3_NAPT_CONTROL_NAPT_HASH_SEED
        read
        read_CTF_L3_NAPT_CONTROL_NAPT_HASH_SEED = read_CTF_L3_NAPT_CONTROL_NAPT_HASH_SEED_value
    End Property

    Property Let write_CTF_L3_NAPT_CONTROL_NAPT_HASH_SEED(aData)
        set_CTF_L3_NAPT_CONTROL_NAPT_HASH_SEED = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CTF_L3_NAPT_CONTROL_RESERVED_value = rightShift(data_low, 23) and &H1ff
        read_CTF_L3_NAPT_CONTROL_L3_FWD_TTL_HOP_ZERO_value = rightShift(data_low, 22) and &H1
        read_CL3NCL3HEDT1_value = rightShift(data_low, 21) and &H1
        read_CTF_L3_NAPT_CONTROL_NAPT_HASH_SELECT_value = rightShift(data_low, 20) and &H1
        read_CL3NCHCORE1_value = rightShift(data_low, 19) and &H1
        read_CTF_L3_NAPT_CONTROL_NAPT_TIMESTAMP_value = rightShift(data_low, 16) and &H7
        CTF_L3_NAPT_CONTROL_NAPT_HASH_SEED_mask = &Hffff
        if data_low > LONG_MAX then
            if CTF_L3_NAPT_CONTROL_NAPT_HASH_SEED_mask = mask then
                read_CTF_L3_NAPT_CONTROL_NAPT_HASH_SEED_value = data_low
            else
                read_CTF_L3_NAPT_CONTROL_NAPT_HASH_SEED_value = (data_low - H8000_0000) and CTF_L3_NAPT_CONTROL_NAPT_HASH_SEED_mask
            end If
        else
            read_CTF_L3_NAPT_CONTROL_NAPT_HASH_SEED_value = data_low and CTF_L3_NAPT_CONTROL_NAPT_HASH_SEED_mask
        end If

    End Sub

    Sub write
        If flag_CTF_L3_NAPT_CONTROL_RESERVED = &H0 or flag_CTF_L3_NAPT_CONTROL_L3_FWD_TTL_HOP_ZERO = &H0 or flag_CL3NCL3HEDT1 = &H0 or flag_CTF_L3_NAPT_CONTROL_NAPT_HASH_SELECT = &H0 or flag_CL3NCHCORE1 = &H0 or flag_CTF_L3_NAPT_CONTROL_NAPT_TIMESTAMP = &H0 or flag_CTF_L3_NAPT_CONTROL_NAPT_HASH_SEED = &H0 Then read
        If flag_CTF_L3_NAPT_CONTROL_RESERVED = &H0 Then write_CTF_L3_NAPT_CONTROL_RESERVED_value = get_CTF_L3_NAPT_CONTROL_RESERVED
        If flag_CTF_L3_NAPT_CONTROL_L3_FWD_TTL_HOP_ZERO = &H0 Then write_CTF_L3_NAPT_CONTROL_L3_FWD_TTL_HOP_ZERO_value = get_CTF_L3_NAPT_CONTROL_L3_FWD_TTL_HOP_ZERO
        If flag_CL3NCL3HEDT1 = &H0 Then write_CL3NCL3HEDT1_value = get_CL3NCL3HEDT1
        If flag_CTF_L3_NAPT_CONTROL_NAPT_HASH_SELECT = &H0 Then write_CTF_L3_NAPT_CONTROL_NAPT_HASH_SELECT_value = get_CTF_L3_NAPT_CONTROL_NAPT_HASH_SELECT
        If flag_CL3NCHCORE1 = &H0 Then write_CL3NCHCORE1_value = get_CL3NCHCORE1
        If flag_CTF_L3_NAPT_CONTROL_NAPT_TIMESTAMP = &H0 Then write_CTF_L3_NAPT_CONTROL_NAPT_TIMESTAMP_value = get_CTF_L3_NAPT_CONTROL_NAPT_TIMESTAMP
        If flag_CTF_L3_NAPT_CONTROL_NAPT_HASH_SEED = &H0 Then write_CTF_L3_NAPT_CONTROL_NAPT_HASH_SEED_value = get_CTF_L3_NAPT_CONTROL_NAPT_HASH_SEED

        regValue = leftShift((write_CTF_L3_NAPT_CONTROL_RESERVED_value and &H1ff), 23) + leftShift((write_CTF_L3_NAPT_CONTROL_L3_FWD_TTL_HOP_ZERO_value and &H1), 22) + leftShift((write_CL3NCL3HEDT1_value and &H1), 21) + leftShift((write_CTF_L3_NAPT_CONTROL_NAPT_HASH_SELECT_value and &H1), 20) + leftShift((write_CL3NCHCORE1_value and &H1), 19) + leftShift((write_CTF_L3_NAPT_CONTROL_NAPT_TIMESTAMP_value and &H7), 16) + leftShift((write_CTF_L3_NAPT_CONTROL_NAPT_HASH_SEED_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CTF_L3_NAPT_CONTROL_RESERVED_value = rightShift(data_low, 23) and &H1ff
        read_CTF_L3_NAPT_CONTROL_L3_FWD_TTL_HOP_ZERO_value = rightShift(data_low, 22) and &H1
        read_CL3NCL3HEDT1_value = rightShift(data_low, 21) and &H1
        read_CTF_L3_NAPT_CONTROL_NAPT_HASH_SELECT_value = rightShift(data_low, 20) and &H1
        read_CL3NCHCORE1_value = rightShift(data_low, 19) and &H1
        read_CTF_L3_NAPT_CONTROL_NAPT_TIMESTAMP_value = rightShift(data_low, 16) and &H7
        CTF_L3_NAPT_CONTROL_NAPT_HASH_SEED_mask = &Hffff
        if data_low > LONG_MAX then
            if CTF_L3_NAPT_CONTROL_NAPT_HASH_SEED_mask = mask then
                read_CTF_L3_NAPT_CONTROL_NAPT_HASH_SEED_value = data_low
            else
                read_CTF_L3_NAPT_CONTROL_NAPT_HASH_SEED_value = (data_low - H8000_0000) and CTF_L3_NAPT_CONTROL_NAPT_HASH_SEED_mask
            end If
        else
            read_CTF_L3_NAPT_CONTROL_NAPT_HASH_SEED_value = data_low and CTF_L3_NAPT_CONTROL_NAPT_HASH_SEED_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CTF_L3_NAPT_CONTROL_RESERVED_value = &H0
        flag_CTF_L3_NAPT_CONTROL_RESERVED        = &H0
        write_CTF_L3_NAPT_CONTROL_L3_FWD_TTL_HOP_ZERO_value = &H0
        flag_CTF_L3_NAPT_CONTROL_L3_FWD_TTL_HOP_ZERO        = &H0
        write_CL3NCL3HEDT1_value = &H0
        flag_CL3NCL3HEDT1        = &H0
        write_CTF_L3_NAPT_CONTROL_NAPT_HASH_SELECT_value = &H0
        flag_CTF_L3_NAPT_CONTROL_NAPT_HASH_SELECT        = &H0
        write_CL3NCHCORE1_value = &H0
        flag_CL3NCHCORE1        = &H0
        write_CTF_L3_NAPT_CONTROL_NAPT_TIMESTAMP_value = &H0
        flag_CTF_L3_NAPT_CONTROL_NAPT_TIMESTAMP        = &H0
        write_CTF_L3_NAPT_CONTROL_NAPT_HASH_SEED_value = &H0
        flag_CTF_L3_NAPT_CONTROL_NAPT_HASH_SEED        = &H0
    End Sub
End Class


'' @REGISTER : CTF_ctf_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CTF_STATUS_RESERVED                        [31:10]          get_CTF_STATUS_RESERVED
''                                                             set_CTF_STATUS_RESERVED
''                                                             read_CTF_STATUS_RESERVED
''                                                             write_CTF_STATUS_RESERVED
''---------------------------------------------------------------------------------
'' CTF_STATUS_HB_INIT_DONE                    [9:9]            get_CTF_STATUS_HB_INIT_DONE
''                                                             set_CTF_STATUS_HB_INIT_DONE
''                                                             read_CTF_STATUS_HB_INIT_DONE
''                                                             write_CTF_STATUS_HB_INIT_DONE
''---------------------------------------------------------------------------------
'' CTF_STATUS_LAB_INIT_DONE                   [8:8]            get_CTF_STATUS_LAB_INIT_DONE
''                                                             set_CTF_STATUS_LAB_INIT_DONE
''                                                             read_CTF_STATUS_LAB_INIT_DONE
''                                                             write_CTF_STATUS_LAB_INIT_DONE
''---------------------------------------------------------------------------------
'' CTF_STATUS_HWQ_INIT_DONE                   [7:7]            get_CTF_STATUS_HWQ_INIT_DONE
''                                                             set_CTF_STATUS_HWQ_INIT_DONE
''                                                             read_CTF_STATUS_HWQ_INIT_DONE
''                                                             write_CTF_STATUS_HWQ_INIT_DONE
''---------------------------------------------------------------------------------
'' CTF_STATUS_NEXT_HOP_INIT_DONE              [6:6]            get_CTF_STATUS_NEXT_HOP_INIT_DONE
''                                                             set_CTF_STATUS_NEXT_HOP_INIT_DONE
''                                                             read_CTF_STATUS_NEXT_HOP_INIT_DONE
''                                                             write_CTF_STATUS_NEXT_HOP_INIT_DONE
''---------------------------------------------------------------------------------
'' CTF_STATUS_NAPT_FLOW_INIT_DONE             [5:5]            get_CTF_STATUS_NAPT_FLOW_INIT_DONE
''                                                             set_CTF_STATUS_NAPT_FLOW_INIT_DONE
''                                                             read_CTF_STATUS_NAPT_FLOW_INIT_DONE
''                                                             write_CTF_STATUS_NAPT_FLOW_INIT_DONE
''---------------------------------------------------------------------------------
'' CTF_STATUS_BRCM_HDR_EDIT_INVALID           [4:4]            get_CTF_STATUS_BRCM_HDR_EDIT_INVALID
''                                                             set_CTF_STATUS_BRCM_HDR_EDIT_INVALID
''                                                             read_CTF_STATUS_BRCM_HDR_EDIT_INVALID
''                                                             write_CTF_STATUS_BRCM_HDR_EDIT_INVALID
''---------------------------------------------------------------------------------
'' CTF_STATUS_L3_IPV4_CHECKSUM_ERR            [3:3]            get_CTF_STATUS_L3_IPV4_CHECKSUM_ERR
''                                                             set_CTF_STATUS_L3_IPV4_CHECKSUM_ERR
''                                                             read_CTF_STATUS_L3_IPV4_CHECKSUM_ERR
''                                                             write_CTF_STATUS_L3_IPV4_CHECKSUM_ERR
''---------------------------------------------------------------------------------
'' CTF_STATUS_L3_PARSING_INCOMPLETE           [2:2]            get_CTF_STATUS_L3_PARSING_INCOMPLETE
''                                                             set_CTF_STATUS_L3_PARSING_INCOMPLETE
''                                                             read_CTF_STATUS_L3_PARSING_INCOMPLETE
''                                                             write_CTF_STATUS_L3_PARSING_INCOMPLETE
''---------------------------------------------------------------------------------
'' CTF_STATUS_L2_PARSING_INCOMPLETE           [1:1]            get_CTF_STATUS_L2_PARSING_INCOMPLETE
''                                                             set_CTF_STATUS_L2_PARSING_INCOMPLETE
''                                                             read_CTF_STATUS_L2_PARSING_INCOMPLETE
''                                                             write_CTF_STATUS_L2_PARSING_INCOMPLETE
''---------------------------------------------------------------------------------
'' CTF_STATUS_BRCM_HDR_PARSING_INCOMPLETE     [0:0]            get_CTF_STATUS_BRCM_HDR_PARSING_INCOMPLETE
''                                                             set_CTF_STATUS_BRCM_HDR_PARSING_INCOMPLETE
''                                                             read_CTF_STATUS_BRCM_HDR_PARSING_INCOMPLETE
''                                                             write_CTF_STATUS_BRCM_HDR_PARSING_INCOMPLETE
''---------------------------------------------------------------------------------
Class REGISTER_CTF_ctf_status
    Private write_CTF_STATUS_RESERVED_value
    Private read_CTF_STATUS_RESERVED_value
    Private flag_CTF_STATUS_RESERVED
    Private write_CTF_STATUS_HB_INIT_DONE_value
    Private read_CTF_STATUS_HB_INIT_DONE_value
    Private flag_CTF_STATUS_HB_INIT_DONE
    Private write_CTF_STATUS_LAB_INIT_DONE_value
    Private read_CTF_STATUS_LAB_INIT_DONE_value
    Private flag_CTF_STATUS_LAB_INIT_DONE
    Private write_CTF_STATUS_HWQ_INIT_DONE_value
    Private read_CTF_STATUS_HWQ_INIT_DONE_value
    Private flag_CTF_STATUS_HWQ_INIT_DONE
    Private write_CTF_STATUS_NEXT_HOP_INIT_DONE_value
    Private read_CTF_STATUS_NEXT_HOP_INIT_DONE_value
    Private flag_CTF_STATUS_NEXT_HOP_INIT_DONE
    Private write_CTF_STATUS_NAPT_FLOW_INIT_DONE_value
    Private read_CTF_STATUS_NAPT_FLOW_INIT_DONE_value
    Private flag_CTF_STATUS_NAPT_FLOW_INIT_DONE
    Private write_CTF_STATUS_BRCM_HDR_EDIT_INVALID_value
    Private read_CTF_STATUS_BRCM_HDR_EDIT_INVALID_value
    Private flag_CTF_STATUS_BRCM_HDR_EDIT_INVALID
    Private write_CTF_STATUS_L3_IPV4_CHECKSUM_ERR_value
    Private read_CTF_STATUS_L3_IPV4_CHECKSUM_ERR_value
    Private flag_CTF_STATUS_L3_IPV4_CHECKSUM_ERR
    Private write_CTF_STATUS_L3_PARSING_INCOMPLETE_value
    Private read_CTF_STATUS_L3_PARSING_INCOMPLETE_value
    Private flag_CTF_STATUS_L3_PARSING_INCOMPLETE
    Private write_CTF_STATUS_L2_PARSING_INCOMPLETE_value
    Private read_CTF_STATUS_L2_PARSING_INCOMPLETE_value
    Private flag_CTF_STATUS_L2_PARSING_INCOMPLETE
    Private write_CTF_STATUS_BRCM_HDR_PARSING_INCOMPLETE_value
    Private read_CTF_STATUS_BRCM_HDR_PARSING_INCOMPLETE_value
    Private flag_CTF_STATUS_BRCM_HDR_PARSING_INCOMPLETE

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H30
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_CTF_STATUS_RESERVED
        get_CTF_STATUS_RESERVED = read_CTF_STATUS_RESERVED_value
    End Property

    Property Let set_CTF_STATUS_RESERVED(aData)
        write_CTF_STATUS_RESERVED_value = aData
        flag_CTF_STATUS_RESERVED        = &H1
    End Property

    Property Get read_CTF_STATUS_RESERVED
        read
        read_CTF_STATUS_RESERVED = read_CTF_STATUS_RESERVED_value
    End Property

    Property Let write_CTF_STATUS_RESERVED(aData)
        set_CTF_STATUS_RESERVED = aData
        write
    End Property

    Property Get get_CTF_STATUS_HB_INIT_DONE
        get_CTF_STATUS_HB_INIT_DONE = read_CTF_STATUS_HB_INIT_DONE_value
    End Property

    Property Let set_CTF_STATUS_HB_INIT_DONE(aData)
        write_CTF_STATUS_HB_INIT_DONE_value = aData
        flag_CTF_STATUS_HB_INIT_DONE        = &H1
    End Property

    Property Get read_CTF_STATUS_HB_INIT_DONE
        read
        read_CTF_STATUS_HB_INIT_DONE = read_CTF_STATUS_HB_INIT_DONE_value
    End Property

    Property Let write_CTF_STATUS_HB_INIT_DONE(aData)
        set_CTF_STATUS_HB_INIT_DONE = aData
        write
    End Property

    Property Get get_CTF_STATUS_LAB_INIT_DONE
        get_CTF_STATUS_LAB_INIT_DONE = read_CTF_STATUS_LAB_INIT_DONE_value
    End Property

    Property Let set_CTF_STATUS_LAB_INIT_DONE(aData)
        write_CTF_STATUS_LAB_INIT_DONE_value = aData
        flag_CTF_STATUS_LAB_INIT_DONE        = &H1
    End Property

    Property Get read_CTF_STATUS_LAB_INIT_DONE
        read
        read_CTF_STATUS_LAB_INIT_DONE = read_CTF_STATUS_LAB_INIT_DONE_value
    End Property

    Property Let write_CTF_STATUS_LAB_INIT_DONE(aData)
        set_CTF_STATUS_LAB_INIT_DONE = aData
        write
    End Property

    Property Get get_CTF_STATUS_HWQ_INIT_DONE
        get_CTF_STATUS_HWQ_INIT_DONE = read_CTF_STATUS_HWQ_INIT_DONE_value
    End Property

    Property Let set_CTF_STATUS_HWQ_INIT_DONE(aData)
        write_CTF_STATUS_HWQ_INIT_DONE_value = aData
        flag_CTF_STATUS_HWQ_INIT_DONE        = &H1
    End Property

    Property Get read_CTF_STATUS_HWQ_INIT_DONE
        read
        read_CTF_STATUS_HWQ_INIT_DONE = read_CTF_STATUS_HWQ_INIT_DONE_value
    End Property

    Property Let write_CTF_STATUS_HWQ_INIT_DONE(aData)
        set_CTF_STATUS_HWQ_INIT_DONE = aData
        write
    End Property

    Property Get get_CTF_STATUS_NEXT_HOP_INIT_DONE
        get_CTF_STATUS_NEXT_HOP_INIT_DONE = read_CTF_STATUS_NEXT_HOP_INIT_DONE_value
    End Property

    Property Let set_CTF_STATUS_NEXT_HOP_INIT_DONE(aData)
        write_CTF_STATUS_NEXT_HOP_INIT_DONE_value = aData
        flag_CTF_STATUS_NEXT_HOP_INIT_DONE        = &H1
    End Property

    Property Get read_CTF_STATUS_NEXT_HOP_INIT_DONE
        read
        read_CTF_STATUS_NEXT_HOP_INIT_DONE = read_CTF_STATUS_NEXT_HOP_INIT_DONE_value
    End Property

    Property Let write_CTF_STATUS_NEXT_HOP_INIT_DONE(aData)
        set_CTF_STATUS_NEXT_HOP_INIT_DONE = aData
        write
    End Property

    Property Get get_CTF_STATUS_NAPT_FLOW_INIT_DONE
        get_CTF_STATUS_NAPT_FLOW_INIT_DONE = read_CTF_STATUS_NAPT_FLOW_INIT_DONE_value
    End Property

    Property Let set_CTF_STATUS_NAPT_FLOW_INIT_DONE(aData)
        write_CTF_STATUS_NAPT_FLOW_INIT_DONE_value = aData
        flag_CTF_STATUS_NAPT_FLOW_INIT_DONE        = &H1
    End Property

    Property Get read_CTF_STATUS_NAPT_FLOW_INIT_DONE
        read
        read_CTF_STATUS_NAPT_FLOW_INIT_DONE = read_CTF_STATUS_NAPT_FLOW_INIT_DONE_value
    End Property

    Property Let write_CTF_STATUS_NAPT_FLOW_INIT_DONE(aData)
        set_CTF_STATUS_NAPT_FLOW_INIT_DONE = aData
        write
    End Property

    Property Get get_CTF_STATUS_BRCM_HDR_EDIT_INVALID
        get_CTF_STATUS_BRCM_HDR_EDIT_INVALID = read_CTF_STATUS_BRCM_HDR_EDIT_INVALID_value
    End Property

    Property Let set_CTF_STATUS_BRCM_HDR_EDIT_INVALID(aData)
        write_CTF_STATUS_BRCM_HDR_EDIT_INVALID_value = aData
        flag_CTF_STATUS_BRCM_HDR_EDIT_INVALID        = &H1
    End Property

    Property Get read_CTF_STATUS_BRCM_HDR_EDIT_INVALID
        read
        read_CTF_STATUS_BRCM_HDR_EDIT_INVALID = read_CTF_STATUS_BRCM_HDR_EDIT_INVALID_value
    End Property

    Property Let write_CTF_STATUS_BRCM_HDR_EDIT_INVALID(aData)
        set_CTF_STATUS_BRCM_HDR_EDIT_INVALID = aData
        write
    End Property

    Property Get get_CTF_STATUS_L3_IPV4_CHECKSUM_ERR
        get_CTF_STATUS_L3_IPV4_CHECKSUM_ERR = read_CTF_STATUS_L3_IPV4_CHECKSUM_ERR_value
    End Property

    Property Let set_CTF_STATUS_L3_IPV4_CHECKSUM_ERR(aData)
        write_CTF_STATUS_L3_IPV4_CHECKSUM_ERR_value = aData
        flag_CTF_STATUS_L3_IPV4_CHECKSUM_ERR        = &H1
    End Property

    Property Get read_CTF_STATUS_L3_IPV4_CHECKSUM_ERR
        read
        read_CTF_STATUS_L3_IPV4_CHECKSUM_ERR = read_CTF_STATUS_L3_IPV4_CHECKSUM_ERR_value
    End Property

    Property Let write_CTF_STATUS_L3_IPV4_CHECKSUM_ERR(aData)
        set_CTF_STATUS_L3_IPV4_CHECKSUM_ERR = aData
        write
    End Property

    Property Get get_CTF_STATUS_L3_PARSING_INCOMPLETE
        get_CTF_STATUS_L3_PARSING_INCOMPLETE = read_CTF_STATUS_L3_PARSING_INCOMPLETE_value
    End Property

    Property Let set_CTF_STATUS_L3_PARSING_INCOMPLETE(aData)
        write_CTF_STATUS_L3_PARSING_INCOMPLETE_value = aData
        flag_CTF_STATUS_L3_PARSING_INCOMPLETE        = &H1
    End Property

    Property Get read_CTF_STATUS_L3_PARSING_INCOMPLETE
        read
        read_CTF_STATUS_L3_PARSING_INCOMPLETE = read_CTF_STATUS_L3_PARSING_INCOMPLETE_value
    End Property

    Property Let write_CTF_STATUS_L3_PARSING_INCOMPLETE(aData)
        set_CTF_STATUS_L3_PARSING_INCOMPLETE = aData
        write
    End Property

    Property Get get_CTF_STATUS_L2_PARSING_INCOMPLETE
        get_CTF_STATUS_L2_PARSING_INCOMPLETE = read_CTF_STATUS_L2_PARSING_INCOMPLETE_value
    End Property

    Property Let set_CTF_STATUS_L2_PARSING_INCOMPLETE(aData)
        write_CTF_STATUS_L2_PARSING_INCOMPLETE_value = aData
        flag_CTF_STATUS_L2_PARSING_INCOMPLETE        = &H1
    End Property

    Property Get read_CTF_STATUS_L2_PARSING_INCOMPLETE
        read
        read_CTF_STATUS_L2_PARSING_INCOMPLETE = read_CTF_STATUS_L2_PARSING_INCOMPLETE_value
    End Property

    Property Let write_CTF_STATUS_L2_PARSING_INCOMPLETE(aData)
        set_CTF_STATUS_L2_PARSING_INCOMPLETE = aData
        write
    End Property

    Property Get get_CTF_STATUS_BRCM_HDR_PARSING_INCOMPLETE
        get_CTF_STATUS_BRCM_HDR_PARSING_INCOMPLETE = read_CTF_STATUS_BRCM_HDR_PARSING_INCOMPLETE_value
    End Property

    Property Let set_CTF_STATUS_BRCM_HDR_PARSING_INCOMPLETE(aData)
        write_CTF_STATUS_BRCM_HDR_PARSING_INCOMPLETE_value = aData
        flag_CTF_STATUS_BRCM_HDR_PARSING_INCOMPLETE        = &H1
    End Property

    Property Get read_CTF_STATUS_BRCM_HDR_PARSING_INCOMPLETE
        read
        read_CTF_STATUS_BRCM_HDR_PARSING_INCOMPLETE = read_CTF_STATUS_BRCM_HDR_PARSING_INCOMPLETE_value
    End Property

    Property Let write_CTF_STATUS_BRCM_HDR_PARSING_INCOMPLETE(aData)
        set_CTF_STATUS_BRCM_HDR_PARSING_INCOMPLETE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CTF_STATUS_RESERVED_value = rightShift(data_low, 10) and &H3fffff
        read_CTF_STATUS_HB_INIT_DONE_value = rightShift(data_low, 9) and &H1
        read_CTF_STATUS_LAB_INIT_DONE_value = rightShift(data_low, 8) and &H1
        read_CTF_STATUS_HWQ_INIT_DONE_value = rightShift(data_low, 7) and &H1
        read_CTF_STATUS_NEXT_HOP_INIT_DONE_value = rightShift(data_low, 6) and &H1
        read_CTF_STATUS_NAPT_FLOW_INIT_DONE_value = rightShift(data_low, 5) and &H1
        read_CTF_STATUS_BRCM_HDR_EDIT_INVALID_value = rightShift(data_low, 4) and &H1
        read_CTF_STATUS_L3_IPV4_CHECKSUM_ERR_value = rightShift(data_low, 3) and &H1
        read_CTF_STATUS_L3_PARSING_INCOMPLETE_value = rightShift(data_low, 2) and &H1
        read_CTF_STATUS_L2_PARSING_INCOMPLETE_value = rightShift(data_low, 1) and &H1
        CTF_STATUS_BRCM_HDR_PARSING_INCOMPLETE_mask = &H1
        if data_low > LONG_MAX then
            if CTF_STATUS_BRCM_HDR_PARSING_INCOMPLETE_mask = mask then
                read_CTF_STATUS_BRCM_HDR_PARSING_INCOMPLETE_value = data_low
            else
                read_CTF_STATUS_BRCM_HDR_PARSING_INCOMPLETE_value = (data_low - H8000_0000) and CTF_STATUS_BRCM_HDR_PARSING_INCOMPLETE_mask
            end If
        else
            read_CTF_STATUS_BRCM_HDR_PARSING_INCOMPLETE_value = data_low and CTF_STATUS_BRCM_HDR_PARSING_INCOMPLETE_mask
        end If

    End Sub

    Sub write
        If flag_CTF_STATUS_RESERVED = &H0 or flag_CTF_STATUS_HB_INIT_DONE = &H0 or flag_CTF_STATUS_LAB_INIT_DONE = &H0 or flag_CTF_STATUS_HWQ_INIT_DONE = &H0 or flag_CTF_STATUS_NEXT_HOP_INIT_DONE = &H0 or flag_CTF_STATUS_NAPT_FLOW_INIT_DONE = &H0 or flag_CTF_STATUS_BRCM_HDR_EDIT_INVALID = &H0 or flag_CTF_STATUS_L3_IPV4_CHECKSUM_ERR = &H0 or flag_CTF_STATUS_L3_PARSING_INCOMPLETE = &H0 or flag_CTF_STATUS_L2_PARSING_INCOMPLETE = &H0 or flag_CTF_STATUS_BRCM_HDR_PARSING_INCOMPLETE = &H0 Then read
        If flag_CTF_STATUS_RESERVED = &H0 Then write_CTF_STATUS_RESERVED_value = get_CTF_STATUS_RESERVED
        If flag_CTF_STATUS_HB_INIT_DONE = &H0 Then write_CTF_STATUS_HB_INIT_DONE_value = get_CTF_STATUS_HB_INIT_DONE
        If flag_CTF_STATUS_LAB_INIT_DONE = &H0 Then write_CTF_STATUS_LAB_INIT_DONE_value = get_CTF_STATUS_LAB_INIT_DONE
        If flag_CTF_STATUS_HWQ_INIT_DONE = &H0 Then write_CTF_STATUS_HWQ_INIT_DONE_value = get_CTF_STATUS_HWQ_INIT_DONE
        If flag_CTF_STATUS_NEXT_HOP_INIT_DONE = &H0 Then write_CTF_STATUS_NEXT_HOP_INIT_DONE_value = get_CTF_STATUS_NEXT_HOP_INIT_DONE
        If flag_CTF_STATUS_NAPT_FLOW_INIT_DONE = &H0 Then write_CTF_STATUS_NAPT_FLOW_INIT_DONE_value = get_CTF_STATUS_NAPT_FLOW_INIT_DONE
        If flag_CTF_STATUS_BRCM_HDR_EDIT_INVALID = &H0 Then write_CTF_STATUS_BRCM_HDR_EDIT_INVALID_value = get_CTF_STATUS_BRCM_HDR_EDIT_INVALID
        If flag_CTF_STATUS_L3_IPV4_CHECKSUM_ERR = &H0 Then write_CTF_STATUS_L3_IPV4_CHECKSUM_ERR_value = get_CTF_STATUS_L3_IPV4_CHECKSUM_ERR
        If flag_CTF_STATUS_L3_PARSING_INCOMPLETE = &H0 Then write_CTF_STATUS_L3_PARSING_INCOMPLETE_value = get_CTF_STATUS_L3_PARSING_INCOMPLETE
        If flag_CTF_STATUS_L2_PARSING_INCOMPLETE = &H0 Then write_CTF_STATUS_L2_PARSING_INCOMPLETE_value = get_CTF_STATUS_L2_PARSING_INCOMPLETE
        If flag_CTF_STATUS_BRCM_HDR_PARSING_INCOMPLETE = &H0 Then write_CTF_STATUS_BRCM_HDR_PARSING_INCOMPLETE_value = get_CTF_STATUS_BRCM_HDR_PARSING_INCOMPLETE

        regValue = leftShift((write_CTF_STATUS_RESERVED_value and &H3fffff), 10) + leftShift((write_CTF_STATUS_HB_INIT_DONE_value and &H1), 9) + leftShift((write_CTF_STATUS_LAB_INIT_DONE_value and &H1), 8) + leftShift((write_CTF_STATUS_HWQ_INIT_DONE_value and &H1), 7) + leftShift((write_CTF_STATUS_NEXT_HOP_INIT_DONE_value and &H1), 6) + leftShift((write_CTF_STATUS_NAPT_FLOW_INIT_DONE_value and &H1), 5) + leftShift((write_CTF_STATUS_BRCM_HDR_EDIT_INVALID_value and &H1), 4) + leftShift((write_CTF_STATUS_L3_IPV4_CHECKSUM_ERR_value and &H1), 3) + leftShift((write_CTF_STATUS_L3_PARSING_INCOMPLETE_value and &H1), 2) + leftShift((write_CTF_STATUS_L2_PARSING_INCOMPLETE_value and &H1), 1) + leftShift((write_CTF_STATUS_BRCM_HDR_PARSING_INCOMPLETE_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CTF_STATUS_RESERVED_value = rightShift(data_low, 10) and &H3fffff
        read_CTF_STATUS_HB_INIT_DONE_value = rightShift(data_low, 9) and &H1
        read_CTF_STATUS_LAB_INIT_DONE_value = rightShift(data_low, 8) and &H1
        read_CTF_STATUS_HWQ_INIT_DONE_value = rightShift(data_low, 7) and &H1
        read_CTF_STATUS_NEXT_HOP_INIT_DONE_value = rightShift(data_low, 6) and &H1
        read_CTF_STATUS_NAPT_FLOW_INIT_DONE_value = rightShift(data_low, 5) and &H1
        read_CTF_STATUS_BRCM_HDR_EDIT_INVALID_value = rightShift(data_low, 4) and &H1
        read_CTF_STATUS_L3_IPV4_CHECKSUM_ERR_value = rightShift(data_low, 3) and &H1
        read_CTF_STATUS_L3_PARSING_INCOMPLETE_value = rightShift(data_low, 2) and &H1
        read_CTF_STATUS_L2_PARSING_INCOMPLETE_value = rightShift(data_low, 1) and &H1
        CTF_STATUS_BRCM_HDR_PARSING_INCOMPLETE_mask = &H1
        if data_low > LONG_MAX then
            if CTF_STATUS_BRCM_HDR_PARSING_INCOMPLETE_mask = mask then
                read_CTF_STATUS_BRCM_HDR_PARSING_INCOMPLETE_value = data_low
            else
                read_CTF_STATUS_BRCM_HDR_PARSING_INCOMPLETE_value = (data_low - H8000_0000) and CTF_STATUS_BRCM_HDR_PARSING_INCOMPLETE_mask
            end If
        else
            read_CTF_STATUS_BRCM_HDR_PARSING_INCOMPLETE_value = data_low and CTF_STATUS_BRCM_HDR_PARSING_INCOMPLETE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CTF_STATUS_RESERVED_value = &H0
        flag_CTF_STATUS_RESERVED        = &H0
        write_CTF_STATUS_HB_INIT_DONE_value = &H0
        flag_CTF_STATUS_HB_INIT_DONE        = &H0
        write_CTF_STATUS_LAB_INIT_DONE_value = &H0
        flag_CTF_STATUS_LAB_INIT_DONE        = &H0
        write_CTF_STATUS_HWQ_INIT_DONE_value = &H0
        flag_CTF_STATUS_HWQ_INIT_DONE        = &H0
        write_CTF_STATUS_NEXT_HOP_INIT_DONE_value = &H0
        flag_CTF_STATUS_NEXT_HOP_INIT_DONE        = &H0
        write_CTF_STATUS_NAPT_FLOW_INIT_DONE_value = &H0
        flag_CTF_STATUS_NAPT_FLOW_INIT_DONE        = &H0
        write_CTF_STATUS_BRCM_HDR_EDIT_INVALID_value = &H0
        flag_CTF_STATUS_BRCM_HDR_EDIT_INVALID        = &H0
        write_CTF_STATUS_L3_IPV4_CHECKSUM_ERR_value = &H0
        flag_CTF_STATUS_L3_IPV4_CHECKSUM_ERR        = &H0
        write_CTF_STATUS_L3_PARSING_INCOMPLETE_value = &H0
        flag_CTF_STATUS_L3_PARSING_INCOMPLETE        = &H0
        write_CTF_STATUS_L2_PARSING_INCOMPLETE_value = &H0
        flag_CTF_STATUS_L2_PARSING_INCOMPLETE        = &H0
        write_CTF_STATUS_BRCM_HDR_PARSING_INCOMPLETE_value = &H0
        flag_CTF_STATUS_BRCM_HDR_PARSING_INCOMPLETE        = &H0
    End Sub
End Class


'' @REGISTER : CTF_ctf_status_mask
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CTF_STATUS_MASK_RESERVED                   [31:10]          get_CTF_STATUS_MASK_RESERVED
''                                                             set_CTF_STATUS_MASK_RESERVED
''                                                             read_CTF_STATUS_MASK_RESERVED
''                                                             write_CTF_STATUS_MASK_RESERVED
''---------------------------------------------------------------------------------
'' CTF_STATUS_MASK_HB_INIT_DONE_ENABLE        [9:9]            get_CTF_STATUS_MASK_HB_INIT_DONE_ENABLE
''                                                             set_CTF_STATUS_MASK_HB_INIT_DONE_ENABLE
''                                                             read_CTF_STATUS_MASK_HB_INIT_DONE_ENABLE
''                                                             write_CTF_STATUS_MASK_HB_INIT_DONE_ENABLE
''---------------------------------------------------------------------------------
'' CTF_STATUS_MASK_LAB_INIT_DONE_ENABLE       [8:8]            get_CTF_STATUS_MASK_LAB_INIT_DONE_ENABLE
''                                                             set_CTF_STATUS_MASK_LAB_INIT_DONE_ENABLE
''                                                             read_CTF_STATUS_MASK_LAB_INIT_DONE_ENABLE
''                                                             write_CTF_STATUS_MASK_LAB_INIT_DONE_ENABLE
''---------------------------------------------------------------------------------
'' CTF_STATUS_MASK_HWQ_INIT_DONE_ENABLE       [7:7]            get_CTF_STATUS_MASK_HWQ_INIT_DONE_ENABLE
''                                                             set_CTF_STATUS_MASK_HWQ_INIT_DONE_ENABLE
''                                                             read_CTF_STATUS_MASK_HWQ_INIT_DONE_ENABLE
''                                                             write_CTF_STATUS_MASK_HWQ_INIT_DONE_ENABLE
''---------------------------------------------------------------------------------
'' CTF_STATUS_MASK_NEXT_HOP_INIT_DONE_ENABLE   [6:6]            get_CTF_STATUS_MASK_NEXT_HOP_INIT_DONE_ENABLE
''                                                             set_CTF_STATUS_MASK_NEXT_HOP_INIT_DONE_ENABLE
''                                                             read_CTF_STATUS_MASK_NEXT_HOP_INIT_DONE_ENABLE
''                                                             write_CTF_STATUS_MASK_NEXT_HOP_INIT_DONE_ENABLE
''---------------------------------------------------------------------------------
'' CSMNFIDE                                   [5:5]            get_CSMNFIDE
''                                                             set_CSMNFIDE
''                                                             read_CSMNFIDE
''                                                             write_CSMNFIDE
''---------------------------------------------------------------------------------
'' CSMBHEIIE1                                 [4:4]            get_CSMBHEIIE1
''                                                             set_CSMBHEIIE1
''                                                             read_CSMBHEIIE1
''                                                             write_CSMBHEIIE1
''---------------------------------------------------------------------------------
'' CSML3I4CEIE1                               [3:3]            get_CSML3I4CEIE1
''                                                             set_CSML3I4CEIE1
''                                                             read_CSML3I4CEIE1
''                                                             write_CSML3I4CEIE1
''---------------------------------------------------------------------------------
'' CSML3PIIE1                                 [2:2]            get_CSML3PIIE1
''                                                             set_CSML3PIIE1
''                                                             read_CSML3PIIE1
''                                                             write_CSML3PIIE1
''---------------------------------------------------------------------------------
'' CSML2PIIE1                                 [1:1]            get_CSML2PIIE1
''                                                             set_CSML2PIIE1
''                                                             read_CSML2PIIE1
''                                                             write_CSML2PIIE1
''---------------------------------------------------------------------------------
'' CSMBHPIIE1                                 [0:0]            get_CSMBHPIIE1
''                                                             set_CSMBHPIIE1
''                                                             read_CSMBHPIIE1
''                                                             write_CSMBHPIIE1
''---------------------------------------------------------------------------------
Class REGISTER_CTF_ctf_status_mask
    Private write_CTF_STATUS_MASK_RESERVED_value
    Private read_CTF_STATUS_MASK_RESERVED_value
    Private flag_CTF_STATUS_MASK_RESERVED
    Private write_CTF_STATUS_MASK_HB_INIT_DONE_ENABLE_value
    Private read_CTF_STATUS_MASK_HB_INIT_DONE_ENABLE_value
    Private flag_CTF_STATUS_MASK_HB_INIT_DONE_ENABLE
    Private write_CTF_STATUS_MASK_LAB_INIT_DONE_ENABLE_value
    Private read_CTF_STATUS_MASK_LAB_INIT_DONE_ENABLE_value
    Private flag_CTF_STATUS_MASK_LAB_INIT_DONE_ENABLE
    Private write_CTF_STATUS_MASK_HWQ_INIT_DONE_ENABLE_value
    Private read_CTF_STATUS_MASK_HWQ_INIT_DONE_ENABLE_value
    Private flag_CTF_STATUS_MASK_HWQ_INIT_DONE_ENABLE
    Private write_CTF_STATUS_MASK_NEXT_HOP_INIT_DONE_ENABLE_value
    Private read_CTF_STATUS_MASK_NEXT_HOP_INIT_DONE_ENABLE_value
    Private flag_CTF_STATUS_MASK_NEXT_HOP_INIT_DONE_ENABLE
    Private write_CSMNFIDE_value
    Private read_CSMNFIDE_value
    Private flag_CSMNFIDE
    Private write_CSMBHEIIE1_value
    Private read_CSMBHEIIE1_value
    Private flag_CSMBHEIIE1
    Private write_CSML3I4CEIE1_value
    Private read_CSML3I4CEIE1_value
    Private flag_CSML3I4CEIE1
    Private write_CSML3PIIE1_value
    Private read_CSML3PIIE1_value
    Private flag_CSML3PIIE1
    Private write_CSML2PIIE1_value
    Private read_CSML2PIIE1_value
    Private flag_CSML2PIIE1
    Private write_CSMBHPIIE1_value
    Private read_CSMBHPIIE1_value
    Private flag_CSMBHPIIE1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H34
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_CTF_STATUS_MASK_RESERVED
        get_CTF_STATUS_MASK_RESERVED = read_CTF_STATUS_MASK_RESERVED_value
    End Property

    Property Let set_CTF_STATUS_MASK_RESERVED(aData)
        write_CTF_STATUS_MASK_RESERVED_value = aData
        flag_CTF_STATUS_MASK_RESERVED        = &H1
    End Property

    Property Get read_CTF_STATUS_MASK_RESERVED
        read
        read_CTF_STATUS_MASK_RESERVED = read_CTF_STATUS_MASK_RESERVED_value
    End Property

    Property Let write_CTF_STATUS_MASK_RESERVED(aData)
        set_CTF_STATUS_MASK_RESERVED = aData
        write
    End Property

    Property Get get_CTF_STATUS_MASK_HB_INIT_DONE_ENABLE
        get_CTF_STATUS_MASK_HB_INIT_DONE_ENABLE = read_CTF_STATUS_MASK_HB_INIT_DONE_ENABLE_value
    End Property

    Property Let set_CTF_STATUS_MASK_HB_INIT_DONE_ENABLE(aData)
        write_CTF_STATUS_MASK_HB_INIT_DONE_ENABLE_value = aData
        flag_CTF_STATUS_MASK_HB_INIT_DONE_ENABLE        = &H1
    End Property

    Property Get read_CTF_STATUS_MASK_HB_INIT_DONE_ENABLE
        read
        read_CTF_STATUS_MASK_HB_INIT_DONE_ENABLE = read_CTF_STATUS_MASK_HB_INIT_DONE_ENABLE_value
    End Property

    Property Let write_CTF_STATUS_MASK_HB_INIT_DONE_ENABLE(aData)
        set_CTF_STATUS_MASK_HB_INIT_DONE_ENABLE = aData
        write
    End Property

    Property Get get_CTF_STATUS_MASK_LAB_INIT_DONE_ENABLE
        get_CTF_STATUS_MASK_LAB_INIT_DONE_ENABLE = read_CTF_STATUS_MASK_LAB_INIT_DONE_ENABLE_value
    End Property

    Property Let set_CTF_STATUS_MASK_LAB_INIT_DONE_ENABLE(aData)
        write_CTF_STATUS_MASK_LAB_INIT_DONE_ENABLE_value = aData
        flag_CTF_STATUS_MASK_LAB_INIT_DONE_ENABLE        = &H1
    End Property

    Property Get read_CTF_STATUS_MASK_LAB_INIT_DONE_ENABLE
        read
        read_CTF_STATUS_MASK_LAB_INIT_DONE_ENABLE = read_CTF_STATUS_MASK_LAB_INIT_DONE_ENABLE_value
    End Property

    Property Let write_CTF_STATUS_MASK_LAB_INIT_DONE_ENABLE(aData)
        set_CTF_STATUS_MASK_LAB_INIT_DONE_ENABLE = aData
        write
    End Property

    Property Get get_CTF_STATUS_MASK_HWQ_INIT_DONE_ENABLE
        get_CTF_STATUS_MASK_HWQ_INIT_DONE_ENABLE = read_CTF_STATUS_MASK_HWQ_INIT_DONE_ENABLE_value
    End Property

    Property Let set_CTF_STATUS_MASK_HWQ_INIT_DONE_ENABLE(aData)
        write_CTF_STATUS_MASK_HWQ_INIT_DONE_ENABLE_value = aData
        flag_CTF_STATUS_MASK_HWQ_INIT_DONE_ENABLE        = &H1
    End Property

    Property Get read_CTF_STATUS_MASK_HWQ_INIT_DONE_ENABLE
        read
        read_CTF_STATUS_MASK_HWQ_INIT_DONE_ENABLE = read_CTF_STATUS_MASK_HWQ_INIT_DONE_ENABLE_value
    End Property

    Property Let write_CTF_STATUS_MASK_HWQ_INIT_DONE_ENABLE(aData)
        set_CTF_STATUS_MASK_HWQ_INIT_DONE_ENABLE = aData
        write
    End Property

    Property Get get_CTF_STATUS_MASK_NEXT_HOP_INIT_DONE_ENABLE
        get_CTF_STATUS_MASK_NEXT_HOP_INIT_DONE_ENABLE = read_CTF_STATUS_MASK_NEXT_HOP_INIT_DONE_ENABLE_value
    End Property

    Property Let set_CTF_STATUS_MASK_NEXT_HOP_INIT_DONE_ENABLE(aData)
        write_CTF_STATUS_MASK_NEXT_HOP_INIT_DONE_ENABLE_value = aData
        flag_CTF_STATUS_MASK_NEXT_HOP_INIT_DONE_ENABLE        = &H1
    End Property

    Property Get read_CTF_STATUS_MASK_NEXT_HOP_INIT_DONE_ENABLE
        read
        read_CTF_STATUS_MASK_NEXT_HOP_INIT_DONE_ENABLE = read_CTF_STATUS_MASK_NEXT_HOP_INIT_DONE_ENABLE_value
    End Property

    Property Let write_CTF_STATUS_MASK_NEXT_HOP_INIT_DONE_ENABLE(aData)
        set_CTF_STATUS_MASK_NEXT_HOP_INIT_DONE_ENABLE = aData
        write
    End Property

    Property Get get_CSMNFIDE
        get_CSMNFIDE = read_CSMNFIDE_value
    End Property

    Property Let set_CSMNFIDE(aData)
        write_CSMNFIDE_value = aData
        flag_CSMNFIDE        = &H1
    End Property

    Property Get read_CSMNFIDE
        read
        read_CSMNFIDE = read_CSMNFIDE_value
    End Property

    Property Let write_CSMNFIDE(aData)
        set_CSMNFIDE = aData
        write
    End Property

    Property Get get_CSMBHEIIE1
        get_CSMBHEIIE1 = read_CSMBHEIIE1_value
    End Property

    Property Let set_CSMBHEIIE1(aData)
        write_CSMBHEIIE1_value = aData
        flag_CSMBHEIIE1        = &H1
    End Property

    Property Get read_CSMBHEIIE1
        read
        read_CSMBHEIIE1 = read_CSMBHEIIE1_value
    End Property

    Property Let write_CSMBHEIIE1(aData)
        set_CSMBHEIIE1 = aData
        write
    End Property

    Property Get get_CSML3I4CEIE1
        get_CSML3I4CEIE1 = read_CSML3I4CEIE1_value
    End Property

    Property Let set_CSML3I4CEIE1(aData)
        write_CSML3I4CEIE1_value = aData
        flag_CSML3I4CEIE1        = &H1
    End Property

    Property Get read_CSML3I4CEIE1
        read
        read_CSML3I4CEIE1 = read_CSML3I4CEIE1_value
    End Property

    Property Let write_CSML3I4CEIE1(aData)
        set_CSML3I4CEIE1 = aData
        write
    End Property

    Property Get get_CSML3PIIE1
        get_CSML3PIIE1 = read_CSML3PIIE1_value
    End Property

    Property Let set_CSML3PIIE1(aData)
        write_CSML3PIIE1_value = aData
        flag_CSML3PIIE1        = &H1
    End Property

    Property Get read_CSML3PIIE1
        read
        read_CSML3PIIE1 = read_CSML3PIIE1_value
    End Property

    Property Let write_CSML3PIIE1(aData)
        set_CSML3PIIE1 = aData
        write
    End Property

    Property Get get_CSML2PIIE1
        get_CSML2PIIE1 = read_CSML2PIIE1_value
    End Property

    Property Let set_CSML2PIIE1(aData)
        write_CSML2PIIE1_value = aData
        flag_CSML2PIIE1        = &H1
    End Property

    Property Get read_CSML2PIIE1
        read
        read_CSML2PIIE1 = read_CSML2PIIE1_value
    End Property

    Property Let write_CSML2PIIE1(aData)
        set_CSML2PIIE1 = aData
        write
    End Property

    Property Get get_CSMBHPIIE1
        get_CSMBHPIIE1 = read_CSMBHPIIE1_value
    End Property

    Property Let set_CSMBHPIIE1(aData)
        write_CSMBHPIIE1_value = aData
        flag_CSMBHPIIE1        = &H1
    End Property

    Property Get read_CSMBHPIIE1
        read
        read_CSMBHPIIE1 = read_CSMBHPIIE1_value
    End Property

    Property Let write_CSMBHPIIE1(aData)
        set_CSMBHPIIE1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CTF_STATUS_MASK_RESERVED_value = rightShift(data_low, 10) and &H3fffff
        read_CTF_STATUS_MASK_HB_INIT_DONE_ENABLE_value = rightShift(data_low, 9) and &H1
        read_CTF_STATUS_MASK_LAB_INIT_DONE_ENABLE_value = rightShift(data_low, 8) and &H1
        read_CTF_STATUS_MASK_HWQ_INIT_DONE_ENABLE_value = rightShift(data_low, 7) and &H1
        read_CTF_STATUS_MASK_NEXT_HOP_INIT_DONE_ENABLE_value = rightShift(data_low, 6) and &H1
        read_CSMNFIDE_value = rightShift(data_low, 5) and &H1
        read_CSMBHEIIE1_value = rightShift(data_low, 4) and &H1
        read_CSML3I4CEIE1_value = rightShift(data_low, 3) and &H1
        read_CSML3PIIE1_value = rightShift(data_low, 2) and &H1
        read_CSML2PIIE1_value = rightShift(data_low, 1) and &H1
        CSMBHPIIE1_mask = &H1
        if data_low > LONG_MAX then
            if CSMBHPIIE1_mask = mask then
                read_CSMBHPIIE1_value = data_low
            else
                read_CSMBHPIIE1_value = (data_low - H8000_0000) and CSMBHPIIE1_mask
            end If
        else
            read_CSMBHPIIE1_value = data_low and CSMBHPIIE1_mask
        end If

    End Sub

    Sub write
        If flag_CTF_STATUS_MASK_RESERVED = &H0 or flag_CTF_STATUS_MASK_HB_INIT_DONE_ENABLE = &H0 or flag_CTF_STATUS_MASK_LAB_INIT_DONE_ENABLE = &H0 or flag_CTF_STATUS_MASK_HWQ_INIT_DONE_ENABLE = &H0 or flag_CTF_STATUS_MASK_NEXT_HOP_INIT_DONE_ENABLE = &H0 or flag_CSMNFIDE = &H0 or flag_CSMBHEIIE1 = &H0 or flag_CSML3I4CEIE1 = &H0 or flag_CSML3PIIE1 = &H0 or flag_CSML2PIIE1 = &H0 or flag_CSMBHPIIE1 = &H0 Then read
        If flag_CTF_STATUS_MASK_RESERVED = &H0 Then write_CTF_STATUS_MASK_RESERVED_value = get_CTF_STATUS_MASK_RESERVED
        If flag_CTF_STATUS_MASK_HB_INIT_DONE_ENABLE = &H0 Then write_CTF_STATUS_MASK_HB_INIT_DONE_ENABLE_value = get_CTF_STATUS_MASK_HB_INIT_DONE_ENABLE
        If flag_CTF_STATUS_MASK_LAB_INIT_DONE_ENABLE = &H0 Then write_CTF_STATUS_MASK_LAB_INIT_DONE_ENABLE_value = get_CTF_STATUS_MASK_LAB_INIT_DONE_ENABLE
        If flag_CTF_STATUS_MASK_HWQ_INIT_DONE_ENABLE = &H0 Then write_CTF_STATUS_MASK_HWQ_INIT_DONE_ENABLE_value = get_CTF_STATUS_MASK_HWQ_INIT_DONE_ENABLE
        If flag_CTF_STATUS_MASK_NEXT_HOP_INIT_DONE_ENABLE = &H0 Then write_CTF_STATUS_MASK_NEXT_HOP_INIT_DONE_ENABLE_value = get_CTF_STATUS_MASK_NEXT_HOP_INIT_DONE_ENABLE
        If flag_CSMNFIDE = &H0 Then write_CSMNFIDE_value = get_CSMNFIDE
        If flag_CSMBHEIIE1 = &H0 Then write_CSMBHEIIE1_value = get_CSMBHEIIE1
        If flag_CSML3I4CEIE1 = &H0 Then write_CSML3I4CEIE1_value = get_CSML3I4CEIE1
        If flag_CSML3PIIE1 = &H0 Then write_CSML3PIIE1_value = get_CSML3PIIE1
        If flag_CSML2PIIE1 = &H0 Then write_CSML2PIIE1_value = get_CSML2PIIE1
        If flag_CSMBHPIIE1 = &H0 Then write_CSMBHPIIE1_value = get_CSMBHPIIE1

        regValue = leftShift((write_CTF_STATUS_MASK_RESERVED_value and &H3fffff), 10) + leftShift((write_CTF_STATUS_MASK_HB_INIT_DONE_ENABLE_value and &H1), 9) + leftShift((write_CTF_STATUS_MASK_LAB_INIT_DONE_ENABLE_value and &H1), 8) + leftShift((write_CTF_STATUS_MASK_HWQ_INIT_DONE_ENABLE_value and &H1), 7) + leftShift((write_CTF_STATUS_MASK_NEXT_HOP_INIT_DONE_ENABLE_value and &H1), 6) + leftShift((write_CSMNFIDE_value and &H1), 5) + leftShift((write_CSMBHEIIE1_value and &H1), 4) + leftShift((write_CSML3I4CEIE1_value and &H1), 3) + leftShift((write_CSML3PIIE1_value and &H1), 2) + leftShift((write_CSML2PIIE1_value and &H1), 1) + leftShift((write_CSMBHPIIE1_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CTF_STATUS_MASK_RESERVED_value = rightShift(data_low, 10) and &H3fffff
        read_CTF_STATUS_MASK_HB_INIT_DONE_ENABLE_value = rightShift(data_low, 9) and &H1
        read_CTF_STATUS_MASK_LAB_INIT_DONE_ENABLE_value = rightShift(data_low, 8) and &H1
        read_CTF_STATUS_MASK_HWQ_INIT_DONE_ENABLE_value = rightShift(data_low, 7) and &H1
        read_CTF_STATUS_MASK_NEXT_HOP_INIT_DONE_ENABLE_value = rightShift(data_low, 6) and &H1
        read_CSMNFIDE_value = rightShift(data_low, 5) and &H1
        read_CSMBHEIIE1_value = rightShift(data_low, 4) and &H1
        read_CSML3I4CEIE1_value = rightShift(data_low, 3) and &H1
        read_CSML3PIIE1_value = rightShift(data_low, 2) and &H1
        read_CSML2PIIE1_value = rightShift(data_low, 1) and &H1
        CSMBHPIIE1_mask = &H1
        if data_low > LONG_MAX then
            if CSMBHPIIE1_mask = mask then
                read_CSMBHPIIE1_value = data_low
            else
                read_CSMBHPIIE1_value = (data_low - H8000_0000) and CSMBHPIIE1_mask
            end If
        else
            read_CSMBHPIIE1_value = data_low and CSMBHPIIE1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CTF_STATUS_MASK_RESERVED_value = &H0
        flag_CTF_STATUS_MASK_RESERVED        = &H0
        write_CTF_STATUS_MASK_HB_INIT_DONE_ENABLE_value = &H0
        flag_CTF_STATUS_MASK_HB_INIT_DONE_ENABLE        = &H0
        write_CTF_STATUS_MASK_LAB_INIT_DONE_ENABLE_value = &H0
        flag_CTF_STATUS_MASK_LAB_INIT_DONE_ENABLE        = &H0
        write_CTF_STATUS_MASK_HWQ_INIT_DONE_ENABLE_value = &H0
        flag_CTF_STATUS_MASK_HWQ_INIT_DONE_ENABLE        = &H0
        write_CTF_STATUS_MASK_NEXT_HOP_INIT_DONE_ENABLE_value = &H0
        flag_CTF_STATUS_MASK_NEXT_HOP_INIT_DONE_ENABLE        = &H0
        write_CSMNFIDE_value = &H0
        flag_CSMNFIDE        = &H0
        write_CSMBHEIIE1_value = &H0
        flag_CSMBHEIIE1        = &H0
        write_CSML3I4CEIE1_value = &H0
        flag_CSML3I4CEIE1        = &H0
        write_CSML3PIIE1_value = &H0
        flag_CSML3PIIE1        = &H0
        write_CSML2PIIE1_value = &H0
        flag_CSML2PIIE1        = &H0
        write_CSMBHPIIE1_value = &H0
        flag_CSMBHPIIE1        = &H0
    End Sub
End Class


'' @REGISTER : CTF_ctf_receive_status_enable
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CTF_RECEIVE_STATUS_ENABLE_RESERVED         [31:8]           get_CTF_RECEIVE_STATUS_ENABLE_RESERVED
''                                                             set_CTF_RECEIVE_STATUS_ENABLE_RESERVED
''                                                             read_CTF_RECEIVE_STATUS_ENABLE_RESERVED
''                                                             write_CTF_RECEIVE_STATUS_ENABLE_RESERVED
''---------------------------------------------------------------------------------
'' CRSEL3PEFSE1                               [7:7]            get_CRSEL3PEFSE1
''                                                             set_CRSEL3PEFSE1
''                                                             read_CRSEL3PEFSE1
''                                                             write_CRSEL3PEFSE1
''---------------------------------------------------------------------------------
'' CRSEL3I4HLFSE1                             [6:6]            get_CRSEL3I4HLFSE1
''                                                             set_CRSEL3I4HLFSE1
''                                                             read_CRSEL3I4HLFSE1
''                                                             write_CRSEL3I4HLFSE1
''---------------------------------------------------------------------------------
'' CRSEL3I4OFSE1                              [5:5]            get_CRSEL3I4OFSE1
''                                                             set_CRSEL3I4OFSE1
''                                                             read_CRSEL3I4OFSE1
''                                                             write_CRSEL3I4OFSE1
''---------------------------------------------------------------------------------
'' CRSEL3I4CFSE1                              [4:4]            get_CRSEL3I4CFSE1
''                                                             set_CRSEL3I4CFSE1
''                                                             read_CRSEL3I4CFSE1
''                                                             write_CRSEL3I4CFSE1
''---------------------------------------------------------------------------------
'' CRSEL3FFSE1                                [3:3]            get_CRSEL3FFSE1
''                                                             set_CRSEL3FFSE1
''                                                             read_CRSEL3FFSE1
''                                                             write_CRSEL3FFSE1
''---------------------------------------------------------------------------------
'' CRSEL3VFSE1                                [2:2]            get_CRSEL3VFSE1
''                                                             set_CRSEL3VFSE1
''                                                             read_CRSEL3VFSE1
''                                                             write_CRSEL3VFSE1
''---------------------------------------------------------------------------------
'' CRSEL2EFSE1                                [1:1]            get_CRSEL2EFSE1
''                                                             set_CRSEL2EFSE1
''                                                             read_CRSEL2EFSE1
''                                                             write_CRSEL2EFSE1
''---------------------------------------------------------------------------------
'' CRSEL2SFSE1                                [0:0]            get_CRSEL2SFSE1
''                                                             set_CRSEL2SFSE1
''                                                             read_CRSEL2SFSE1
''                                                             write_CRSEL2SFSE1
''---------------------------------------------------------------------------------
Class REGISTER_CTF_ctf_receive_status_enable
    Private write_CTF_RECEIVE_STATUS_ENABLE_RESERVED_value
    Private read_CTF_RECEIVE_STATUS_ENABLE_RESERVED_value
    Private flag_CTF_RECEIVE_STATUS_ENABLE_RESERVED
    Private write_CRSEL3PEFSE1_value
    Private read_CRSEL3PEFSE1_value
    Private flag_CRSEL3PEFSE1
    Private write_CRSEL3I4HLFSE1_value
    Private read_CRSEL3I4HLFSE1_value
    Private flag_CRSEL3I4HLFSE1
    Private write_CRSEL3I4OFSE1_value
    Private read_CRSEL3I4OFSE1_value
    Private flag_CRSEL3I4OFSE1
    Private write_CRSEL3I4CFSE1_value
    Private read_CRSEL3I4CFSE1_value
    Private flag_CRSEL3I4CFSE1
    Private write_CRSEL3FFSE1_value
    Private read_CRSEL3FFSE1_value
    Private flag_CRSEL3FFSE1
    Private write_CRSEL3VFSE1_value
    Private read_CRSEL3VFSE1_value
    Private flag_CRSEL3VFSE1
    Private write_CRSEL2EFSE1_value
    Private read_CRSEL2EFSE1_value
    Private flag_CRSEL2EFSE1
    Private write_CRSEL2SFSE1_value
    Private read_CRSEL2SFSE1_value
    Private flag_CRSEL2SFSE1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H38
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_CTF_RECEIVE_STATUS_ENABLE_RESERVED
        get_CTF_RECEIVE_STATUS_ENABLE_RESERVED = read_CTF_RECEIVE_STATUS_ENABLE_RESERVED_value
    End Property

    Property Let set_CTF_RECEIVE_STATUS_ENABLE_RESERVED(aData)
        write_CTF_RECEIVE_STATUS_ENABLE_RESERVED_value = aData
        flag_CTF_RECEIVE_STATUS_ENABLE_RESERVED        = &H1
    End Property

    Property Get read_CTF_RECEIVE_STATUS_ENABLE_RESERVED
        read
        read_CTF_RECEIVE_STATUS_ENABLE_RESERVED = read_CTF_RECEIVE_STATUS_ENABLE_RESERVED_value
    End Property

    Property Let write_CTF_RECEIVE_STATUS_ENABLE_RESERVED(aData)
        set_CTF_RECEIVE_STATUS_ENABLE_RESERVED = aData
        write
    End Property

    Property Get get_CRSEL3PEFSE1
        get_CRSEL3PEFSE1 = read_CRSEL3PEFSE1_value
    End Property

    Property Let set_CRSEL3PEFSE1(aData)
        write_CRSEL3PEFSE1_value = aData
        flag_CRSEL3PEFSE1        = &H1
    End Property

    Property Get read_CRSEL3PEFSE1
        read
        read_CRSEL3PEFSE1 = read_CRSEL3PEFSE1_value
    End Property

    Property Let write_CRSEL3PEFSE1(aData)
        set_CRSEL3PEFSE1 = aData
        write
    End Property

    Property Get get_CRSEL3I4HLFSE1
        get_CRSEL3I4HLFSE1 = read_CRSEL3I4HLFSE1_value
    End Property

    Property Let set_CRSEL3I4HLFSE1(aData)
        write_CRSEL3I4HLFSE1_value = aData
        flag_CRSEL3I4HLFSE1        = &H1
    End Property

    Property Get read_CRSEL3I4HLFSE1
        read
        read_CRSEL3I4HLFSE1 = read_CRSEL3I4HLFSE1_value
    End Property

    Property Let write_CRSEL3I4HLFSE1(aData)
        set_CRSEL3I4HLFSE1 = aData
        write
    End Property

    Property Get get_CRSEL3I4OFSE1
        get_CRSEL3I4OFSE1 = read_CRSEL3I4OFSE1_value
    End Property

    Property Let set_CRSEL3I4OFSE1(aData)
        write_CRSEL3I4OFSE1_value = aData
        flag_CRSEL3I4OFSE1        = &H1
    End Property

    Property Get read_CRSEL3I4OFSE1
        read
        read_CRSEL3I4OFSE1 = read_CRSEL3I4OFSE1_value
    End Property

    Property Let write_CRSEL3I4OFSE1(aData)
        set_CRSEL3I4OFSE1 = aData
        write
    End Property

    Property Get get_CRSEL3I4CFSE1
        get_CRSEL3I4CFSE1 = read_CRSEL3I4CFSE1_value
    End Property

    Property Let set_CRSEL3I4CFSE1(aData)
        write_CRSEL3I4CFSE1_value = aData
        flag_CRSEL3I4CFSE1        = &H1
    End Property

    Property Get read_CRSEL3I4CFSE1
        read
        read_CRSEL3I4CFSE1 = read_CRSEL3I4CFSE1_value
    End Property

    Property Let write_CRSEL3I4CFSE1(aData)
        set_CRSEL3I4CFSE1 = aData
        write
    End Property

    Property Get get_CRSEL3FFSE1
        get_CRSEL3FFSE1 = read_CRSEL3FFSE1_value
    End Property

    Property Let set_CRSEL3FFSE1(aData)
        write_CRSEL3FFSE1_value = aData
        flag_CRSEL3FFSE1        = &H1
    End Property

    Property Get read_CRSEL3FFSE1
        read
        read_CRSEL3FFSE1 = read_CRSEL3FFSE1_value
    End Property

    Property Let write_CRSEL3FFSE1(aData)
        set_CRSEL3FFSE1 = aData
        write
    End Property

    Property Get get_CRSEL3VFSE1
        get_CRSEL3VFSE1 = read_CRSEL3VFSE1_value
    End Property

    Property Let set_CRSEL3VFSE1(aData)
        write_CRSEL3VFSE1_value = aData
        flag_CRSEL3VFSE1        = &H1
    End Property

    Property Get read_CRSEL3VFSE1
        read
        read_CRSEL3VFSE1 = read_CRSEL3VFSE1_value
    End Property

    Property Let write_CRSEL3VFSE1(aData)
        set_CRSEL3VFSE1 = aData
        write
    End Property

    Property Get get_CRSEL2EFSE1
        get_CRSEL2EFSE1 = read_CRSEL2EFSE1_value
    End Property

    Property Let set_CRSEL2EFSE1(aData)
        write_CRSEL2EFSE1_value = aData
        flag_CRSEL2EFSE1        = &H1
    End Property

    Property Get read_CRSEL2EFSE1
        read
        read_CRSEL2EFSE1 = read_CRSEL2EFSE1_value
    End Property

    Property Let write_CRSEL2EFSE1(aData)
        set_CRSEL2EFSE1 = aData
        write
    End Property

    Property Get get_CRSEL2SFSE1
        get_CRSEL2SFSE1 = read_CRSEL2SFSE1_value
    End Property

    Property Let set_CRSEL2SFSE1(aData)
        write_CRSEL2SFSE1_value = aData
        flag_CRSEL2SFSE1        = &H1
    End Property

    Property Get read_CRSEL2SFSE1
        read
        read_CRSEL2SFSE1 = read_CRSEL2SFSE1_value
    End Property

    Property Let write_CRSEL2SFSE1(aData)
        set_CRSEL2SFSE1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CTF_RECEIVE_STATUS_ENABLE_RESERVED_value = rightShift(data_low, 8) and &Hffffff
        read_CRSEL3PEFSE1_value = rightShift(data_low, 7) and &H1
        read_CRSEL3I4HLFSE1_value = rightShift(data_low, 6) and &H1
        read_CRSEL3I4OFSE1_value = rightShift(data_low, 5) and &H1
        read_CRSEL3I4CFSE1_value = rightShift(data_low, 4) and &H1
        read_CRSEL3FFSE1_value = rightShift(data_low, 3) and &H1
        read_CRSEL3VFSE1_value = rightShift(data_low, 2) and &H1
        read_CRSEL2EFSE1_value = rightShift(data_low, 1) and &H1
        CRSEL2SFSE1_mask = &H1
        if data_low > LONG_MAX then
            if CRSEL2SFSE1_mask = mask then
                read_CRSEL2SFSE1_value = data_low
            else
                read_CRSEL2SFSE1_value = (data_low - H8000_0000) and CRSEL2SFSE1_mask
            end If
        else
            read_CRSEL2SFSE1_value = data_low and CRSEL2SFSE1_mask
        end If

    End Sub

    Sub write
        If flag_CTF_RECEIVE_STATUS_ENABLE_RESERVED = &H0 or flag_CRSEL3PEFSE1 = &H0 or flag_CRSEL3I4HLFSE1 = &H0 or flag_CRSEL3I4OFSE1 = &H0 or flag_CRSEL3I4CFSE1 = &H0 or flag_CRSEL3FFSE1 = &H0 or flag_CRSEL3VFSE1 = &H0 or flag_CRSEL2EFSE1 = &H0 or flag_CRSEL2SFSE1 = &H0 Then read
        If flag_CTF_RECEIVE_STATUS_ENABLE_RESERVED = &H0 Then write_CTF_RECEIVE_STATUS_ENABLE_RESERVED_value = get_CTF_RECEIVE_STATUS_ENABLE_RESERVED
        If flag_CRSEL3PEFSE1 = &H0 Then write_CRSEL3PEFSE1_value = get_CRSEL3PEFSE1
        If flag_CRSEL3I4HLFSE1 = &H0 Then write_CRSEL3I4HLFSE1_value = get_CRSEL3I4HLFSE1
        If flag_CRSEL3I4OFSE1 = &H0 Then write_CRSEL3I4OFSE1_value = get_CRSEL3I4OFSE1
        If flag_CRSEL3I4CFSE1 = &H0 Then write_CRSEL3I4CFSE1_value = get_CRSEL3I4CFSE1
        If flag_CRSEL3FFSE1 = &H0 Then write_CRSEL3FFSE1_value = get_CRSEL3FFSE1
        If flag_CRSEL3VFSE1 = &H0 Then write_CRSEL3VFSE1_value = get_CRSEL3VFSE1
        If flag_CRSEL2EFSE1 = &H0 Then write_CRSEL2EFSE1_value = get_CRSEL2EFSE1
        If flag_CRSEL2SFSE1 = &H0 Then write_CRSEL2SFSE1_value = get_CRSEL2SFSE1

        regValue = leftShift((write_CTF_RECEIVE_STATUS_ENABLE_RESERVED_value and &Hffffff), 8) + leftShift((write_CRSEL3PEFSE1_value and &H1), 7) + leftShift((write_CRSEL3I4HLFSE1_value and &H1), 6) + leftShift((write_CRSEL3I4OFSE1_value and &H1), 5) + leftShift((write_CRSEL3I4CFSE1_value and &H1), 4) + leftShift((write_CRSEL3FFSE1_value and &H1), 3) + leftShift((write_CRSEL3VFSE1_value and &H1), 2) + leftShift((write_CRSEL2EFSE1_value and &H1), 1) + leftShift((write_CRSEL2SFSE1_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CTF_RECEIVE_STATUS_ENABLE_RESERVED_value = rightShift(data_low, 8) and &Hffffff
        read_CRSEL3PEFSE1_value = rightShift(data_low, 7) and &H1
        read_CRSEL3I4HLFSE1_value = rightShift(data_low, 6) and &H1
        read_CRSEL3I4OFSE1_value = rightShift(data_low, 5) and &H1
        read_CRSEL3I4CFSE1_value = rightShift(data_low, 4) and &H1
        read_CRSEL3FFSE1_value = rightShift(data_low, 3) and &H1
        read_CRSEL3VFSE1_value = rightShift(data_low, 2) and &H1
        read_CRSEL2EFSE1_value = rightShift(data_low, 1) and &H1
        CRSEL2SFSE1_mask = &H1
        if data_low > LONG_MAX then
            if CRSEL2SFSE1_mask = mask then
                read_CRSEL2SFSE1_value = data_low
            else
                read_CRSEL2SFSE1_value = (data_low - H8000_0000) and CRSEL2SFSE1_mask
            end If
        else
            read_CRSEL2SFSE1_value = data_low and CRSEL2SFSE1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CTF_RECEIVE_STATUS_ENABLE_RESERVED_value = &H0
        flag_CTF_RECEIVE_STATUS_ENABLE_RESERVED        = &H0
        write_CRSEL3PEFSE1_value = &H0
        flag_CRSEL3PEFSE1        = &H0
        write_CRSEL3I4HLFSE1_value = &H0
        flag_CRSEL3I4HLFSE1        = &H0
        write_CRSEL3I4OFSE1_value = &H0
        flag_CRSEL3I4OFSE1        = &H0
        write_CRSEL3I4CFSE1_value = &H0
        flag_CRSEL3I4CFSE1        = &H0
        write_CRSEL3FFSE1_value = &H0
        flag_CRSEL3FFSE1        = &H0
        write_CRSEL3VFSE1_value = &H0
        flag_CRSEL3VFSE1        = &H0
        write_CRSEL2EFSE1_value = &H0
        flag_CRSEL2EFSE1        = &H0
        write_CRSEL2SFSE1_value = &H0
        flag_CRSEL2SFSE1        = &H0
    End Sub
End Class


'' @REGISTER : CTF_ctf_hit_count
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CTF_HIT_COUNT_COUNT                        [31:0]           get_CTF_HIT_COUNT_COUNT
''                                                             set_CTF_HIT_COUNT_COUNT
''                                                             read_CTF_HIT_COUNT_COUNT
''                                                             write_CTF_HIT_COUNT_COUNT
''---------------------------------------------------------------------------------
Class REGISTER_CTF_ctf_hit_count
    Private write_CTF_HIT_COUNT_COUNT_value
    Private read_CTF_HIT_COUNT_COUNT_value
    Private flag_CTF_HIT_COUNT_COUNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_CTF_HIT_COUNT_COUNT
        get_CTF_HIT_COUNT_COUNT = read_CTF_HIT_COUNT_COUNT_value
    End Property

    Property Let set_CTF_HIT_COUNT_COUNT(aData)
        write_CTF_HIT_COUNT_COUNT_value = aData
        flag_CTF_HIT_COUNT_COUNT        = &H1
    End Property

    Property Get read_CTF_HIT_COUNT_COUNT
        read
        read_CTF_HIT_COUNT_COUNT = read_CTF_HIT_COUNT_COUNT_value
    End Property

    Property Let write_CTF_HIT_COUNT_COUNT(aData)
        set_CTF_HIT_COUNT_COUNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CTF_HIT_COUNT_COUNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if CTF_HIT_COUNT_COUNT_mask = mask then
                read_CTF_HIT_COUNT_COUNT_value = data_low
            else
                read_CTF_HIT_COUNT_COUNT_value = (data_low - H8000_0000) and CTF_HIT_COUNT_COUNT_mask
            end If
        else
            read_CTF_HIT_COUNT_COUNT_value = data_low and CTF_HIT_COUNT_COUNT_mask
        end If

    End Sub

    Sub write
        If flag_CTF_HIT_COUNT_COUNT = &H0 Then read
        If flag_CTF_HIT_COUNT_COUNT = &H0 Then write_CTF_HIT_COUNT_COUNT_value = get_CTF_HIT_COUNT_COUNT

        regValue = leftShift(write_CTF_HIT_COUNT_COUNT_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CTF_HIT_COUNT_COUNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if CTF_HIT_COUNT_COUNT_mask = mask then
                read_CTF_HIT_COUNT_COUNT_value = data_low
            else
                read_CTF_HIT_COUNT_COUNT_value = (data_low - H8000_0000) and CTF_HIT_COUNT_COUNT_mask
            end If
        else
            read_CTF_HIT_COUNT_COUNT_value = data_low and CTF_HIT_COUNT_COUNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CTF_HIT_COUNT_COUNT_value = &H0
        flag_CTF_HIT_COUNT_COUNT        = &H0
    End Sub
End Class


'' @REGISTER : CTF_ctf_miss_count
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CTF_MISS_COUNT_COUNT                       [31:0]           get_CTF_MISS_COUNT_COUNT
''                                                             set_CTF_MISS_COUNT_COUNT
''                                                             read_CTF_MISS_COUNT_COUNT
''                                                             write_CTF_MISS_COUNT_COUNT
''---------------------------------------------------------------------------------
Class REGISTER_CTF_ctf_miss_count
    Private write_CTF_MISS_COUNT_COUNT_value
    Private read_CTF_MISS_COUNT_COUNT_value
    Private flag_CTF_MISS_COUNT_COUNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H40
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_CTF_MISS_COUNT_COUNT
        get_CTF_MISS_COUNT_COUNT = read_CTF_MISS_COUNT_COUNT_value
    End Property

    Property Let set_CTF_MISS_COUNT_COUNT(aData)
        write_CTF_MISS_COUNT_COUNT_value = aData
        flag_CTF_MISS_COUNT_COUNT        = &H1
    End Property

    Property Get read_CTF_MISS_COUNT_COUNT
        read
        read_CTF_MISS_COUNT_COUNT = read_CTF_MISS_COUNT_COUNT_value
    End Property

    Property Let write_CTF_MISS_COUNT_COUNT(aData)
        set_CTF_MISS_COUNT_COUNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CTF_MISS_COUNT_COUNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if CTF_MISS_COUNT_COUNT_mask = mask then
                read_CTF_MISS_COUNT_COUNT_value = data_low
            else
                read_CTF_MISS_COUNT_COUNT_value = (data_low - H8000_0000) and CTF_MISS_COUNT_COUNT_mask
            end If
        else
            read_CTF_MISS_COUNT_COUNT_value = data_low and CTF_MISS_COUNT_COUNT_mask
        end If

    End Sub

    Sub write
        If flag_CTF_MISS_COUNT_COUNT = &H0 Then read
        If flag_CTF_MISS_COUNT_COUNT = &H0 Then write_CTF_MISS_COUNT_COUNT_value = get_CTF_MISS_COUNT_COUNT

        regValue = leftShift(write_CTF_MISS_COUNT_COUNT_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CTF_MISS_COUNT_COUNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if CTF_MISS_COUNT_COUNT_mask = mask then
                read_CTF_MISS_COUNT_COUNT_value = data_low
            else
                read_CTF_MISS_COUNT_COUNT_value = (data_low - H8000_0000) and CTF_MISS_COUNT_COUNT_mask
            end If
        else
            read_CTF_MISS_COUNT_COUNT_value = data_low and CTF_MISS_COUNT_COUNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CTF_MISS_COUNT_COUNT_value = &H0
        flag_CTF_MISS_COUNT_COUNT        = &H0
    End Sub
End Class


'' @REGISTER : CTF_ctf_snap_fail_count
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CTF_SNAP_FAIL_COUNT_COUNT                  [31:0]           get_CTF_SNAP_FAIL_COUNT_COUNT
''                                                             set_CTF_SNAP_FAIL_COUNT_COUNT
''                                                             read_CTF_SNAP_FAIL_COUNT_COUNT
''                                                             write_CTF_SNAP_FAIL_COUNT_COUNT
''---------------------------------------------------------------------------------
Class REGISTER_CTF_ctf_snap_fail_count
    Private write_CTF_SNAP_FAIL_COUNT_COUNT_value
    Private read_CTF_SNAP_FAIL_COUNT_COUNT_value
    Private flag_CTF_SNAP_FAIL_COUNT_COUNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H44
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_CTF_SNAP_FAIL_COUNT_COUNT
        get_CTF_SNAP_FAIL_COUNT_COUNT = read_CTF_SNAP_FAIL_COUNT_COUNT_value
    End Property

    Property Let set_CTF_SNAP_FAIL_COUNT_COUNT(aData)
        write_CTF_SNAP_FAIL_COUNT_COUNT_value = aData
        flag_CTF_SNAP_FAIL_COUNT_COUNT        = &H1
    End Property

    Property Get read_CTF_SNAP_FAIL_COUNT_COUNT
        read
        read_CTF_SNAP_FAIL_COUNT_COUNT = read_CTF_SNAP_FAIL_COUNT_COUNT_value
    End Property

    Property Let write_CTF_SNAP_FAIL_COUNT_COUNT(aData)
        set_CTF_SNAP_FAIL_COUNT_COUNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CTF_SNAP_FAIL_COUNT_COUNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if CTF_SNAP_FAIL_COUNT_COUNT_mask = mask then
                read_CTF_SNAP_FAIL_COUNT_COUNT_value = data_low
            else
                read_CTF_SNAP_FAIL_COUNT_COUNT_value = (data_low - H8000_0000) and CTF_SNAP_FAIL_COUNT_COUNT_mask
            end If
        else
            read_CTF_SNAP_FAIL_COUNT_COUNT_value = data_low and CTF_SNAP_FAIL_COUNT_COUNT_mask
        end If

    End Sub

    Sub write
        If flag_CTF_SNAP_FAIL_COUNT_COUNT = &H0 Then read
        If flag_CTF_SNAP_FAIL_COUNT_COUNT = &H0 Then write_CTF_SNAP_FAIL_COUNT_COUNT_value = get_CTF_SNAP_FAIL_COUNT_COUNT

        regValue = leftShift(write_CTF_SNAP_FAIL_COUNT_COUNT_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CTF_SNAP_FAIL_COUNT_COUNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if CTF_SNAP_FAIL_COUNT_COUNT_mask = mask then
                read_CTF_SNAP_FAIL_COUNT_COUNT_value = data_low
            else
                read_CTF_SNAP_FAIL_COUNT_COUNT_value = (data_low - H8000_0000) and CTF_SNAP_FAIL_COUNT_COUNT_mask
            end If
        else
            read_CTF_SNAP_FAIL_COUNT_COUNT_value = data_low and CTF_SNAP_FAIL_COUNT_COUNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CTF_SNAP_FAIL_COUNT_COUNT_value = &H0
        flag_CTF_SNAP_FAIL_COUNT_COUNT        = &H0
    End Sub
End Class


'' @REGISTER : CTF_ctf_etype_fail_count
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CTF_ETYPE_FAIL_COUNT_COUNT                 [31:0]           get_CTF_ETYPE_FAIL_COUNT_COUNT
''                                                             set_CTF_ETYPE_FAIL_COUNT_COUNT
''                                                             read_CTF_ETYPE_FAIL_COUNT_COUNT
''                                                             write_CTF_ETYPE_FAIL_COUNT_COUNT
''---------------------------------------------------------------------------------
Class REGISTER_CTF_ctf_etype_fail_count
    Private write_CTF_ETYPE_FAIL_COUNT_COUNT_value
    Private read_CTF_ETYPE_FAIL_COUNT_COUNT_value
    Private flag_CTF_ETYPE_FAIL_COUNT_COUNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H48
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_CTF_ETYPE_FAIL_COUNT_COUNT
        get_CTF_ETYPE_FAIL_COUNT_COUNT = read_CTF_ETYPE_FAIL_COUNT_COUNT_value
    End Property

    Property Let set_CTF_ETYPE_FAIL_COUNT_COUNT(aData)
        write_CTF_ETYPE_FAIL_COUNT_COUNT_value = aData
        flag_CTF_ETYPE_FAIL_COUNT_COUNT        = &H1
    End Property

    Property Get read_CTF_ETYPE_FAIL_COUNT_COUNT
        read
        read_CTF_ETYPE_FAIL_COUNT_COUNT = read_CTF_ETYPE_FAIL_COUNT_COUNT_value
    End Property

    Property Let write_CTF_ETYPE_FAIL_COUNT_COUNT(aData)
        set_CTF_ETYPE_FAIL_COUNT_COUNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CTF_ETYPE_FAIL_COUNT_COUNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if CTF_ETYPE_FAIL_COUNT_COUNT_mask = mask then
                read_CTF_ETYPE_FAIL_COUNT_COUNT_value = data_low
            else
                read_CTF_ETYPE_FAIL_COUNT_COUNT_value = (data_low - H8000_0000) and CTF_ETYPE_FAIL_COUNT_COUNT_mask
            end If
        else
            read_CTF_ETYPE_FAIL_COUNT_COUNT_value = data_low and CTF_ETYPE_FAIL_COUNT_COUNT_mask
        end If

    End Sub

    Sub write
        If flag_CTF_ETYPE_FAIL_COUNT_COUNT = &H0 Then read
        If flag_CTF_ETYPE_FAIL_COUNT_COUNT = &H0 Then write_CTF_ETYPE_FAIL_COUNT_COUNT_value = get_CTF_ETYPE_FAIL_COUNT_COUNT

        regValue = leftShift(write_CTF_ETYPE_FAIL_COUNT_COUNT_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CTF_ETYPE_FAIL_COUNT_COUNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if CTF_ETYPE_FAIL_COUNT_COUNT_mask = mask then
                read_CTF_ETYPE_FAIL_COUNT_COUNT_value = data_low
            else
                read_CTF_ETYPE_FAIL_COUNT_COUNT_value = (data_low - H8000_0000) and CTF_ETYPE_FAIL_COUNT_COUNT_mask
            end If
        else
            read_CTF_ETYPE_FAIL_COUNT_COUNT_value = data_low and CTF_ETYPE_FAIL_COUNT_COUNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CTF_ETYPE_FAIL_COUNT_COUNT_value = &H0
        flag_CTF_ETYPE_FAIL_COUNT_COUNT        = &H0
    End Sub
End Class


'' @REGISTER : CTF_ctf_version_fail_count
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CTF_VERSION_FAIL_COUNT_COUNT               [31:0]           get_CTF_VERSION_FAIL_COUNT_COUNT
''                                                             set_CTF_VERSION_FAIL_COUNT_COUNT
''                                                             read_CTF_VERSION_FAIL_COUNT_COUNT
''                                                             write_CTF_VERSION_FAIL_COUNT_COUNT
''---------------------------------------------------------------------------------
Class REGISTER_CTF_ctf_version_fail_count
    Private write_CTF_VERSION_FAIL_COUNT_COUNT_value
    Private read_CTF_VERSION_FAIL_COUNT_COUNT_value
    Private flag_CTF_VERSION_FAIL_COUNT_COUNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H4c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_CTF_VERSION_FAIL_COUNT_COUNT
        get_CTF_VERSION_FAIL_COUNT_COUNT = read_CTF_VERSION_FAIL_COUNT_COUNT_value
    End Property

    Property Let set_CTF_VERSION_FAIL_COUNT_COUNT(aData)
        write_CTF_VERSION_FAIL_COUNT_COUNT_value = aData
        flag_CTF_VERSION_FAIL_COUNT_COUNT        = &H1
    End Property

    Property Get read_CTF_VERSION_FAIL_COUNT_COUNT
        read
        read_CTF_VERSION_FAIL_COUNT_COUNT = read_CTF_VERSION_FAIL_COUNT_COUNT_value
    End Property

    Property Let write_CTF_VERSION_FAIL_COUNT_COUNT(aData)
        set_CTF_VERSION_FAIL_COUNT_COUNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CTF_VERSION_FAIL_COUNT_COUNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if CTF_VERSION_FAIL_COUNT_COUNT_mask = mask then
                read_CTF_VERSION_FAIL_COUNT_COUNT_value = data_low
            else
                read_CTF_VERSION_FAIL_COUNT_COUNT_value = (data_low - H8000_0000) and CTF_VERSION_FAIL_COUNT_COUNT_mask
            end If
        else
            read_CTF_VERSION_FAIL_COUNT_COUNT_value = data_low and CTF_VERSION_FAIL_COUNT_COUNT_mask
        end If

    End Sub

    Sub write
        If flag_CTF_VERSION_FAIL_COUNT_COUNT = &H0 Then read
        If flag_CTF_VERSION_FAIL_COUNT_COUNT = &H0 Then write_CTF_VERSION_FAIL_COUNT_COUNT_value = get_CTF_VERSION_FAIL_COUNT_COUNT

        regValue = leftShift(write_CTF_VERSION_FAIL_COUNT_COUNT_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CTF_VERSION_FAIL_COUNT_COUNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if CTF_VERSION_FAIL_COUNT_COUNT_mask = mask then
                read_CTF_VERSION_FAIL_COUNT_COUNT_value = data_low
            else
                read_CTF_VERSION_FAIL_COUNT_COUNT_value = (data_low - H8000_0000) and CTF_VERSION_FAIL_COUNT_COUNT_mask
            end If
        else
            read_CTF_VERSION_FAIL_COUNT_COUNT_value = data_low and CTF_VERSION_FAIL_COUNT_COUNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CTF_VERSION_FAIL_COUNT_COUNT_value = &H0
        flag_CTF_VERSION_FAIL_COUNT_COUNT        = &H0
    End Sub
End Class


'' @REGISTER : CTF_ctf_frag_fail_count
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CTF_FRAG_FAIL_COUNT_COUNT                  [31:0]           get_CTF_FRAG_FAIL_COUNT_COUNT
''                                                             set_CTF_FRAG_FAIL_COUNT_COUNT
''                                                             read_CTF_FRAG_FAIL_COUNT_COUNT
''                                                             write_CTF_FRAG_FAIL_COUNT_COUNT
''---------------------------------------------------------------------------------
Class REGISTER_CTF_ctf_frag_fail_count
    Private write_CTF_FRAG_FAIL_COUNT_COUNT_value
    Private read_CTF_FRAG_FAIL_COUNT_COUNT_value
    Private flag_CTF_FRAG_FAIL_COUNT_COUNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H50
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_CTF_FRAG_FAIL_COUNT_COUNT
        get_CTF_FRAG_FAIL_COUNT_COUNT = read_CTF_FRAG_FAIL_COUNT_COUNT_value
    End Property

    Property Let set_CTF_FRAG_FAIL_COUNT_COUNT(aData)
        write_CTF_FRAG_FAIL_COUNT_COUNT_value = aData
        flag_CTF_FRAG_FAIL_COUNT_COUNT        = &H1
    End Property

    Property Get read_CTF_FRAG_FAIL_COUNT_COUNT
        read
        read_CTF_FRAG_FAIL_COUNT_COUNT = read_CTF_FRAG_FAIL_COUNT_COUNT_value
    End Property

    Property Let write_CTF_FRAG_FAIL_COUNT_COUNT(aData)
        set_CTF_FRAG_FAIL_COUNT_COUNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CTF_FRAG_FAIL_COUNT_COUNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if CTF_FRAG_FAIL_COUNT_COUNT_mask = mask then
                read_CTF_FRAG_FAIL_COUNT_COUNT_value = data_low
            else
                read_CTF_FRAG_FAIL_COUNT_COUNT_value = (data_low - H8000_0000) and CTF_FRAG_FAIL_COUNT_COUNT_mask
            end If
        else
            read_CTF_FRAG_FAIL_COUNT_COUNT_value = data_low and CTF_FRAG_FAIL_COUNT_COUNT_mask
        end If

    End Sub

    Sub write
        If flag_CTF_FRAG_FAIL_COUNT_COUNT = &H0 Then read
        If flag_CTF_FRAG_FAIL_COUNT_COUNT = &H0 Then write_CTF_FRAG_FAIL_COUNT_COUNT_value = get_CTF_FRAG_FAIL_COUNT_COUNT

        regValue = leftShift(write_CTF_FRAG_FAIL_COUNT_COUNT_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CTF_FRAG_FAIL_COUNT_COUNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if CTF_FRAG_FAIL_COUNT_COUNT_mask = mask then
                read_CTF_FRAG_FAIL_COUNT_COUNT_value = data_low
            else
                read_CTF_FRAG_FAIL_COUNT_COUNT_value = (data_low - H8000_0000) and CTF_FRAG_FAIL_COUNT_COUNT_mask
            end If
        else
            read_CTF_FRAG_FAIL_COUNT_COUNT_value = data_low and CTF_FRAG_FAIL_COUNT_COUNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CTF_FRAG_FAIL_COUNT_COUNT_value = &H0
        flag_CTF_FRAG_FAIL_COUNT_COUNT        = &H0
    End Sub
End Class


'' @REGISTER : CTF_ctf_protocol_ext_fail_count
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CTF_PROTOCOL_EXT_FAIL_COUNT_COUNT          [31:0]           get_CTF_PROTOCOL_EXT_FAIL_COUNT_COUNT
''                                                             set_CTF_PROTOCOL_EXT_FAIL_COUNT_COUNT
''                                                             read_CTF_PROTOCOL_EXT_FAIL_COUNT_COUNT
''                                                             write_CTF_PROTOCOL_EXT_FAIL_COUNT_COUNT
''---------------------------------------------------------------------------------
Class REGISTER_CTF_ctf_protocol_ext_fail_count
    Private write_CTF_PROTOCOL_EXT_FAIL_COUNT_COUNT_value
    Private read_CTF_PROTOCOL_EXT_FAIL_COUNT_COUNT_value
    Private flag_CTF_PROTOCOL_EXT_FAIL_COUNT_COUNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H54
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_CTF_PROTOCOL_EXT_FAIL_COUNT_COUNT
        get_CTF_PROTOCOL_EXT_FAIL_COUNT_COUNT = read_CTF_PROTOCOL_EXT_FAIL_COUNT_COUNT_value
    End Property

    Property Let set_CTF_PROTOCOL_EXT_FAIL_COUNT_COUNT(aData)
        write_CTF_PROTOCOL_EXT_FAIL_COUNT_COUNT_value = aData
        flag_CTF_PROTOCOL_EXT_FAIL_COUNT_COUNT        = &H1
    End Property

    Property Get read_CTF_PROTOCOL_EXT_FAIL_COUNT_COUNT
        read
        read_CTF_PROTOCOL_EXT_FAIL_COUNT_COUNT = read_CTF_PROTOCOL_EXT_FAIL_COUNT_COUNT_value
    End Property

    Property Let write_CTF_PROTOCOL_EXT_FAIL_COUNT_COUNT(aData)
        set_CTF_PROTOCOL_EXT_FAIL_COUNT_COUNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CTF_PROTOCOL_EXT_FAIL_COUNT_COUNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if CTF_PROTOCOL_EXT_FAIL_COUNT_COUNT_mask = mask then
                read_CTF_PROTOCOL_EXT_FAIL_COUNT_COUNT_value = data_low
            else
                read_CTF_PROTOCOL_EXT_FAIL_COUNT_COUNT_value = (data_low - H8000_0000) and CTF_PROTOCOL_EXT_FAIL_COUNT_COUNT_mask
            end If
        else
            read_CTF_PROTOCOL_EXT_FAIL_COUNT_COUNT_value = data_low and CTF_PROTOCOL_EXT_FAIL_COUNT_COUNT_mask
        end If

    End Sub

    Sub write
        If flag_CTF_PROTOCOL_EXT_FAIL_COUNT_COUNT = &H0 Then read
        If flag_CTF_PROTOCOL_EXT_FAIL_COUNT_COUNT = &H0 Then write_CTF_PROTOCOL_EXT_FAIL_COUNT_COUNT_value = get_CTF_PROTOCOL_EXT_FAIL_COUNT_COUNT

        regValue = leftShift(write_CTF_PROTOCOL_EXT_FAIL_COUNT_COUNT_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CTF_PROTOCOL_EXT_FAIL_COUNT_COUNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if CTF_PROTOCOL_EXT_FAIL_COUNT_COUNT_mask = mask then
                read_CTF_PROTOCOL_EXT_FAIL_COUNT_COUNT_value = data_low
            else
                read_CTF_PROTOCOL_EXT_FAIL_COUNT_COUNT_value = (data_low - H8000_0000) and CTF_PROTOCOL_EXT_FAIL_COUNT_COUNT_mask
            end If
        else
            read_CTF_PROTOCOL_EXT_FAIL_COUNT_COUNT_value = data_low and CTF_PROTOCOL_EXT_FAIL_COUNT_COUNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CTF_PROTOCOL_EXT_FAIL_COUNT_COUNT_value = &H0
        flag_CTF_PROTOCOL_EXT_FAIL_COUNT_COUNT        = &H0
    End Sub
End Class


'' @REGISTER : CTF_ctf_ipv4_checksum_fail_count
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CTF_IPV4_CHECKSUM_FAIL_COUNT_COUNT         [31:0]           get_CTF_IPV4_CHECKSUM_FAIL_COUNT_COUNT
''                                                             set_CTF_IPV4_CHECKSUM_FAIL_COUNT_COUNT
''                                                             read_CTF_IPV4_CHECKSUM_FAIL_COUNT_COUNT
''                                                             write_CTF_IPV4_CHECKSUM_FAIL_COUNT_COUNT
''---------------------------------------------------------------------------------
Class REGISTER_CTF_ctf_ipv4_checksum_fail_count
    Private write_CTF_IPV4_CHECKSUM_FAIL_COUNT_COUNT_value
    Private read_CTF_IPV4_CHECKSUM_FAIL_COUNT_COUNT_value
    Private flag_CTF_IPV4_CHECKSUM_FAIL_COUNT_COUNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H58
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_CTF_IPV4_CHECKSUM_FAIL_COUNT_COUNT
        get_CTF_IPV4_CHECKSUM_FAIL_COUNT_COUNT = read_CTF_IPV4_CHECKSUM_FAIL_COUNT_COUNT_value
    End Property

    Property Let set_CTF_IPV4_CHECKSUM_FAIL_COUNT_COUNT(aData)
        write_CTF_IPV4_CHECKSUM_FAIL_COUNT_COUNT_value = aData
        flag_CTF_IPV4_CHECKSUM_FAIL_COUNT_COUNT        = &H1
    End Property

    Property Get read_CTF_IPV4_CHECKSUM_FAIL_COUNT_COUNT
        read
        read_CTF_IPV4_CHECKSUM_FAIL_COUNT_COUNT = read_CTF_IPV4_CHECKSUM_FAIL_COUNT_COUNT_value
    End Property

    Property Let write_CTF_IPV4_CHECKSUM_FAIL_COUNT_COUNT(aData)
        set_CTF_IPV4_CHECKSUM_FAIL_COUNT_COUNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CTF_IPV4_CHECKSUM_FAIL_COUNT_COUNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if CTF_IPV4_CHECKSUM_FAIL_COUNT_COUNT_mask = mask then
                read_CTF_IPV4_CHECKSUM_FAIL_COUNT_COUNT_value = data_low
            else
                read_CTF_IPV4_CHECKSUM_FAIL_COUNT_COUNT_value = (data_low - H8000_0000) and CTF_IPV4_CHECKSUM_FAIL_COUNT_COUNT_mask
            end If
        else
            read_CTF_IPV4_CHECKSUM_FAIL_COUNT_COUNT_value = data_low and CTF_IPV4_CHECKSUM_FAIL_COUNT_COUNT_mask
        end If

    End Sub

    Sub write
        If flag_CTF_IPV4_CHECKSUM_FAIL_COUNT_COUNT = &H0 Then read
        If flag_CTF_IPV4_CHECKSUM_FAIL_COUNT_COUNT = &H0 Then write_CTF_IPV4_CHECKSUM_FAIL_COUNT_COUNT_value = get_CTF_IPV4_CHECKSUM_FAIL_COUNT_COUNT

        regValue = leftShift(write_CTF_IPV4_CHECKSUM_FAIL_COUNT_COUNT_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CTF_IPV4_CHECKSUM_FAIL_COUNT_COUNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if CTF_IPV4_CHECKSUM_FAIL_COUNT_COUNT_mask = mask then
                read_CTF_IPV4_CHECKSUM_FAIL_COUNT_COUNT_value = data_low
            else
                read_CTF_IPV4_CHECKSUM_FAIL_COUNT_COUNT_value = (data_low - H8000_0000) and CTF_IPV4_CHECKSUM_FAIL_COUNT_COUNT_mask
            end If
        else
            read_CTF_IPV4_CHECKSUM_FAIL_COUNT_COUNT_value = data_low and CTF_IPV4_CHECKSUM_FAIL_COUNT_COUNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CTF_IPV4_CHECKSUM_FAIL_COUNT_COUNT_value = &H0
        flag_CTF_IPV4_CHECKSUM_FAIL_COUNT_COUNT        = &H0
    End Sub
End Class


'' @REGISTER : CTF_ctf_ipv4_options_fail_count
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CTF_IPV4_OPTIONS_FAIL_COUNT_COUNT          [31:0]           get_CTF_IPV4_OPTIONS_FAIL_COUNT_COUNT
''                                                             set_CTF_IPV4_OPTIONS_FAIL_COUNT_COUNT
''                                                             read_CTF_IPV4_OPTIONS_FAIL_COUNT_COUNT
''                                                             write_CTF_IPV4_OPTIONS_FAIL_COUNT_COUNT
''---------------------------------------------------------------------------------
Class REGISTER_CTF_ctf_ipv4_options_fail_count
    Private write_CTF_IPV4_OPTIONS_FAIL_COUNT_COUNT_value
    Private read_CTF_IPV4_OPTIONS_FAIL_COUNT_COUNT_value
    Private flag_CTF_IPV4_OPTIONS_FAIL_COUNT_COUNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H5c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_CTF_IPV4_OPTIONS_FAIL_COUNT_COUNT
        get_CTF_IPV4_OPTIONS_FAIL_COUNT_COUNT = read_CTF_IPV4_OPTIONS_FAIL_COUNT_COUNT_value
    End Property

    Property Let set_CTF_IPV4_OPTIONS_FAIL_COUNT_COUNT(aData)
        write_CTF_IPV4_OPTIONS_FAIL_COUNT_COUNT_value = aData
        flag_CTF_IPV4_OPTIONS_FAIL_COUNT_COUNT        = &H1
    End Property

    Property Get read_CTF_IPV4_OPTIONS_FAIL_COUNT_COUNT
        read
        read_CTF_IPV4_OPTIONS_FAIL_COUNT_COUNT = read_CTF_IPV4_OPTIONS_FAIL_COUNT_COUNT_value
    End Property

    Property Let write_CTF_IPV4_OPTIONS_FAIL_COUNT_COUNT(aData)
        set_CTF_IPV4_OPTIONS_FAIL_COUNT_COUNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CTF_IPV4_OPTIONS_FAIL_COUNT_COUNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if CTF_IPV4_OPTIONS_FAIL_COUNT_COUNT_mask = mask then
                read_CTF_IPV4_OPTIONS_FAIL_COUNT_COUNT_value = data_low
            else
                read_CTF_IPV4_OPTIONS_FAIL_COUNT_COUNT_value = (data_low - H8000_0000) and CTF_IPV4_OPTIONS_FAIL_COUNT_COUNT_mask
            end If
        else
            read_CTF_IPV4_OPTIONS_FAIL_COUNT_COUNT_value = data_low and CTF_IPV4_OPTIONS_FAIL_COUNT_COUNT_mask
        end If

    End Sub

    Sub write
        If flag_CTF_IPV4_OPTIONS_FAIL_COUNT_COUNT = &H0 Then read
        If flag_CTF_IPV4_OPTIONS_FAIL_COUNT_COUNT = &H0 Then write_CTF_IPV4_OPTIONS_FAIL_COUNT_COUNT_value = get_CTF_IPV4_OPTIONS_FAIL_COUNT_COUNT

        regValue = leftShift(write_CTF_IPV4_OPTIONS_FAIL_COUNT_COUNT_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CTF_IPV4_OPTIONS_FAIL_COUNT_COUNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if CTF_IPV4_OPTIONS_FAIL_COUNT_COUNT_mask = mask then
                read_CTF_IPV4_OPTIONS_FAIL_COUNT_COUNT_value = data_low
            else
                read_CTF_IPV4_OPTIONS_FAIL_COUNT_COUNT_value = (data_low - H8000_0000) and CTF_IPV4_OPTIONS_FAIL_COUNT_COUNT_mask
            end If
        else
            read_CTF_IPV4_OPTIONS_FAIL_COUNT_COUNT_value = data_low and CTF_IPV4_OPTIONS_FAIL_COUNT_COUNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CTF_IPV4_OPTIONS_FAIL_COUNT_COUNT_value = &H0
        flag_CTF_IPV4_OPTIONS_FAIL_COUNT_COUNT        = &H0
    End Sub
End Class


'' @REGISTER : CTF_ctf_ipv4_header_length_fail_count
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CTF_IPV4_HEADER_LENGTH_FAIL_COUNT_COUNT    [31:0]           get_CTF_IPV4_HEADER_LENGTH_FAIL_COUNT_COUNT
''                                                             set_CTF_IPV4_HEADER_LENGTH_FAIL_COUNT_COUNT
''                                                             read_CTF_IPV4_HEADER_LENGTH_FAIL_COUNT_COUNT
''                                                             write_CTF_IPV4_HEADER_LENGTH_FAIL_COUNT_COUNT
''---------------------------------------------------------------------------------
Class REGISTER_CTF_ctf_ipv4_header_length_fail_count
    Private write_CTF_IPV4_HEADER_LENGTH_FAIL_COUNT_COUNT_value
    Private read_CTF_IPV4_HEADER_LENGTH_FAIL_COUNT_COUNT_value
    Private flag_CTF_IPV4_HEADER_LENGTH_FAIL_COUNT_COUNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H60
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_CTF_IPV4_HEADER_LENGTH_FAIL_COUNT_COUNT
        get_CTF_IPV4_HEADER_LENGTH_FAIL_COUNT_COUNT = read_CTF_IPV4_HEADER_LENGTH_FAIL_COUNT_COUNT_value
    End Property

    Property Let set_CTF_IPV4_HEADER_LENGTH_FAIL_COUNT_COUNT(aData)
        write_CTF_IPV4_HEADER_LENGTH_FAIL_COUNT_COUNT_value = aData
        flag_CTF_IPV4_HEADER_LENGTH_FAIL_COUNT_COUNT        = &H1
    End Property

    Property Get read_CTF_IPV4_HEADER_LENGTH_FAIL_COUNT_COUNT
        read
        read_CTF_IPV4_HEADER_LENGTH_FAIL_COUNT_COUNT = read_CTF_IPV4_HEADER_LENGTH_FAIL_COUNT_COUNT_value
    End Property

    Property Let write_CTF_IPV4_HEADER_LENGTH_FAIL_COUNT_COUNT(aData)
        set_CTF_IPV4_HEADER_LENGTH_FAIL_COUNT_COUNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CTF_IPV4_HEADER_LENGTH_FAIL_COUNT_COUNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if CTF_IPV4_HEADER_LENGTH_FAIL_COUNT_COUNT_mask = mask then
                read_CTF_IPV4_HEADER_LENGTH_FAIL_COUNT_COUNT_value = data_low
            else
                read_CTF_IPV4_HEADER_LENGTH_FAIL_COUNT_COUNT_value = (data_low - H8000_0000) and CTF_IPV4_HEADER_LENGTH_FAIL_COUNT_COUNT_mask
            end If
        else
            read_CTF_IPV4_HEADER_LENGTH_FAIL_COUNT_COUNT_value = data_low and CTF_IPV4_HEADER_LENGTH_FAIL_COUNT_COUNT_mask
        end If

    End Sub

    Sub write
        If flag_CTF_IPV4_HEADER_LENGTH_FAIL_COUNT_COUNT = &H0 Then read
        If flag_CTF_IPV4_HEADER_LENGTH_FAIL_COUNT_COUNT = &H0 Then write_CTF_IPV4_HEADER_LENGTH_FAIL_COUNT_COUNT_value = get_CTF_IPV4_HEADER_LENGTH_FAIL_COUNT_COUNT

        regValue = leftShift(write_CTF_IPV4_HEADER_LENGTH_FAIL_COUNT_COUNT_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CTF_IPV4_HEADER_LENGTH_FAIL_COUNT_COUNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if CTF_IPV4_HEADER_LENGTH_FAIL_COUNT_COUNT_mask = mask then
                read_CTF_IPV4_HEADER_LENGTH_FAIL_COUNT_COUNT_value = data_low
            else
                read_CTF_IPV4_HEADER_LENGTH_FAIL_COUNT_COUNT_value = (data_low - H8000_0000) and CTF_IPV4_HEADER_LENGTH_FAIL_COUNT_COUNT_mask
            end If
        else
            read_CTF_IPV4_HEADER_LENGTH_FAIL_COUNT_COUNT_value = data_low and CTF_IPV4_HEADER_LENGTH_FAIL_COUNT_COUNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CTF_IPV4_HEADER_LENGTH_FAIL_COUNT_COUNT_value = &H0
        flag_CTF_IPV4_HEADER_LENGTH_FAIL_COUNT_COUNT        = &H0
    End Sub
End Class


'' @REGISTER : CTF_ctf_error
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CTF_ERROR_RESERVED                         [31:9]           get_CTF_ERROR_RESERVED
''                                                             set_CTF_ERROR_RESERVED
''                                                             read_CTF_ERROR_RESERVED
''                                                             write_CTF_ERROR_RESERVED
''---------------------------------------------------------------------------------
'' CTF_ERROR_HWQ_OVERFLOW_ERROR               [8:8]            get_CTF_ERROR_HWQ_OVERFLOW_ERROR
''                                                             set_CTF_ERROR_HWQ_OVERFLOW_ERROR
''                                                             read_CTF_ERROR_HWQ_OVERFLOW_ERROR
''                                                             write_CTF_ERROR_HWQ_OVERFLOW_ERROR
''---------------------------------------------------------------------------------
'' CTF_ERROR_HB_OVERFLOW_ERROR                [7:7]            get_CTF_ERROR_HB_OVERFLOW_ERROR
''                                                             set_CTF_ERROR_HB_OVERFLOW_ERROR
''                                                             read_CTF_ERROR_HB_OVERFLOW_ERROR
''                                                             write_CTF_ERROR_HB_OVERFLOW_ERROR
''---------------------------------------------------------------------------------
'' CTF_ERROR_RXQ_OVERFLOW_ERROR               [6:6]            get_CTF_ERROR_RXQ_OVERFLOW_ERROR
''                                                             set_CTF_ERROR_RXQ_OVERFLOW_ERROR
''                                                             read_CTF_ERROR_RXQ_OVERFLOW_ERROR
''                                                             write_CTF_ERROR_RXQ_OVERFLOW_ERROR
''---------------------------------------------------------------------------------
'' CTF_ERROR_SOP_EOP_ERROR                    [5:5]            get_CTF_ERROR_SOP_EOP_ERROR
''                                                             set_CTF_ERROR_SOP_EOP_ERROR
''                                                             read_CTF_ERROR_SOP_EOP_ERROR
''                                                             write_CTF_ERROR_SOP_EOP_ERROR
''---------------------------------------------------------------------------------
'' CTF_ERROR_SPB_OVERFLOW_ERROR               [4:4]            get_CTF_ERROR_SPB_OVERFLOW_ERROR
''                                                             set_CTF_ERROR_SPB_OVERFLOW_ERROR
''                                                             read_CTF_ERROR_SPB_OVERFLOW_ERROR
''                                                             write_CTF_ERROR_SPB_OVERFLOW_ERROR
''---------------------------------------------------------------------------------
'' CTF_ERROR_LAB_OVERFLOW_ERROR               [3:3]            get_CTF_ERROR_LAB_OVERFLOW_ERROR
''                                                             set_CTF_ERROR_LAB_OVERFLOW_ERROR
''                                                             read_CTF_ERROR_LAB_OVERFLOW_ERROR
''                                                             write_CTF_ERROR_LAB_OVERFLOW_ERROR
''---------------------------------------------------------------------------------
'' CTF_ERROR_INTERNAL_MERGE_ERROR             [2:2]            get_CTF_ERROR_INTERNAL_MERGE_ERROR
''                                                             set_CTF_ERROR_INTERNAL_MERGE_ERROR
''                                                             read_CTF_ERROR_INTERNAL_MERGE_ERROR
''                                                             write_CTF_ERROR_INTERNAL_MERGE_ERROR
''---------------------------------------------------------------------------------
'' CTF_ERROR_TXQ_OVERFLOW_ERROR               [1:1]            get_CTF_ERROR_TXQ_OVERFLOW_ERROR
''                                                             set_CTF_ERROR_TXQ_OVERFLOW_ERROR
''                                                             read_CTF_ERROR_TXQ_OVERFLOW_ERROR
''                                                             write_CTF_ERROR_TXQ_OVERFLOW_ERROR
''---------------------------------------------------------------------------------
'' CTF_ERROR_RB_OVERFLOW_ERROR                [0:0]            get_CTF_ERROR_RB_OVERFLOW_ERROR
''                                                             set_CTF_ERROR_RB_OVERFLOW_ERROR
''                                                             read_CTF_ERROR_RB_OVERFLOW_ERROR
''                                                             write_CTF_ERROR_RB_OVERFLOW_ERROR
''---------------------------------------------------------------------------------
Class REGISTER_CTF_ctf_error
    Private write_CTF_ERROR_RESERVED_value
    Private read_CTF_ERROR_RESERVED_value
    Private flag_CTF_ERROR_RESERVED
    Private write_CTF_ERROR_HWQ_OVERFLOW_ERROR_value
    Private read_CTF_ERROR_HWQ_OVERFLOW_ERROR_value
    Private flag_CTF_ERROR_HWQ_OVERFLOW_ERROR
    Private write_CTF_ERROR_HB_OVERFLOW_ERROR_value
    Private read_CTF_ERROR_HB_OVERFLOW_ERROR_value
    Private flag_CTF_ERROR_HB_OVERFLOW_ERROR
    Private write_CTF_ERROR_RXQ_OVERFLOW_ERROR_value
    Private read_CTF_ERROR_RXQ_OVERFLOW_ERROR_value
    Private flag_CTF_ERROR_RXQ_OVERFLOW_ERROR
    Private write_CTF_ERROR_SOP_EOP_ERROR_value
    Private read_CTF_ERROR_SOP_EOP_ERROR_value
    Private flag_CTF_ERROR_SOP_EOP_ERROR
    Private write_CTF_ERROR_SPB_OVERFLOW_ERROR_value
    Private read_CTF_ERROR_SPB_OVERFLOW_ERROR_value
    Private flag_CTF_ERROR_SPB_OVERFLOW_ERROR
    Private write_CTF_ERROR_LAB_OVERFLOW_ERROR_value
    Private read_CTF_ERROR_LAB_OVERFLOW_ERROR_value
    Private flag_CTF_ERROR_LAB_OVERFLOW_ERROR
    Private write_CTF_ERROR_INTERNAL_MERGE_ERROR_value
    Private read_CTF_ERROR_INTERNAL_MERGE_ERROR_value
    Private flag_CTF_ERROR_INTERNAL_MERGE_ERROR
    Private write_CTF_ERROR_TXQ_OVERFLOW_ERROR_value
    Private read_CTF_ERROR_TXQ_OVERFLOW_ERROR_value
    Private flag_CTF_ERROR_TXQ_OVERFLOW_ERROR
    Private write_CTF_ERROR_RB_OVERFLOW_ERROR_value
    Private read_CTF_ERROR_RB_OVERFLOW_ERROR_value
    Private flag_CTF_ERROR_RB_OVERFLOW_ERROR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H64
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_CTF_ERROR_RESERVED
        get_CTF_ERROR_RESERVED = read_CTF_ERROR_RESERVED_value
    End Property

    Property Let set_CTF_ERROR_RESERVED(aData)
        write_CTF_ERROR_RESERVED_value = aData
        flag_CTF_ERROR_RESERVED        = &H1
    End Property

    Property Get read_CTF_ERROR_RESERVED
        read
        read_CTF_ERROR_RESERVED = read_CTF_ERROR_RESERVED_value
    End Property

    Property Let write_CTF_ERROR_RESERVED(aData)
        set_CTF_ERROR_RESERVED = aData
        write
    End Property

    Property Get get_CTF_ERROR_HWQ_OVERFLOW_ERROR
        get_CTF_ERROR_HWQ_OVERFLOW_ERROR = read_CTF_ERROR_HWQ_OVERFLOW_ERROR_value
    End Property

    Property Let set_CTF_ERROR_HWQ_OVERFLOW_ERROR(aData)
        write_CTF_ERROR_HWQ_OVERFLOW_ERROR_value = aData
        flag_CTF_ERROR_HWQ_OVERFLOW_ERROR        = &H1
    End Property

    Property Get read_CTF_ERROR_HWQ_OVERFLOW_ERROR
        read
        read_CTF_ERROR_HWQ_OVERFLOW_ERROR = read_CTF_ERROR_HWQ_OVERFLOW_ERROR_value
    End Property

    Property Let write_CTF_ERROR_HWQ_OVERFLOW_ERROR(aData)
        set_CTF_ERROR_HWQ_OVERFLOW_ERROR = aData
        write
    End Property

    Property Get get_CTF_ERROR_HB_OVERFLOW_ERROR
        get_CTF_ERROR_HB_OVERFLOW_ERROR = read_CTF_ERROR_HB_OVERFLOW_ERROR_value
    End Property

    Property Let set_CTF_ERROR_HB_OVERFLOW_ERROR(aData)
        write_CTF_ERROR_HB_OVERFLOW_ERROR_value = aData
        flag_CTF_ERROR_HB_OVERFLOW_ERROR        = &H1
    End Property

    Property Get read_CTF_ERROR_HB_OVERFLOW_ERROR
        read
        read_CTF_ERROR_HB_OVERFLOW_ERROR = read_CTF_ERROR_HB_OVERFLOW_ERROR_value
    End Property

    Property Let write_CTF_ERROR_HB_OVERFLOW_ERROR(aData)
        set_CTF_ERROR_HB_OVERFLOW_ERROR = aData
        write
    End Property

    Property Get get_CTF_ERROR_RXQ_OVERFLOW_ERROR
        get_CTF_ERROR_RXQ_OVERFLOW_ERROR = read_CTF_ERROR_RXQ_OVERFLOW_ERROR_value
    End Property

    Property Let set_CTF_ERROR_RXQ_OVERFLOW_ERROR(aData)
        write_CTF_ERROR_RXQ_OVERFLOW_ERROR_value = aData
        flag_CTF_ERROR_RXQ_OVERFLOW_ERROR        = &H1
    End Property

    Property Get read_CTF_ERROR_RXQ_OVERFLOW_ERROR
        read
        read_CTF_ERROR_RXQ_OVERFLOW_ERROR = read_CTF_ERROR_RXQ_OVERFLOW_ERROR_value
    End Property

    Property Let write_CTF_ERROR_RXQ_OVERFLOW_ERROR(aData)
        set_CTF_ERROR_RXQ_OVERFLOW_ERROR = aData
        write
    End Property

    Property Get get_CTF_ERROR_SOP_EOP_ERROR
        get_CTF_ERROR_SOP_EOP_ERROR = read_CTF_ERROR_SOP_EOP_ERROR_value
    End Property

    Property Let set_CTF_ERROR_SOP_EOP_ERROR(aData)
        write_CTF_ERROR_SOP_EOP_ERROR_value = aData
        flag_CTF_ERROR_SOP_EOP_ERROR        = &H1
    End Property

    Property Get read_CTF_ERROR_SOP_EOP_ERROR
        read
        read_CTF_ERROR_SOP_EOP_ERROR = read_CTF_ERROR_SOP_EOP_ERROR_value
    End Property

    Property Let write_CTF_ERROR_SOP_EOP_ERROR(aData)
        set_CTF_ERROR_SOP_EOP_ERROR = aData
        write
    End Property

    Property Get get_CTF_ERROR_SPB_OVERFLOW_ERROR
        get_CTF_ERROR_SPB_OVERFLOW_ERROR = read_CTF_ERROR_SPB_OVERFLOW_ERROR_value
    End Property

    Property Let set_CTF_ERROR_SPB_OVERFLOW_ERROR(aData)
        write_CTF_ERROR_SPB_OVERFLOW_ERROR_value = aData
        flag_CTF_ERROR_SPB_OVERFLOW_ERROR        = &H1
    End Property

    Property Get read_CTF_ERROR_SPB_OVERFLOW_ERROR
        read
        read_CTF_ERROR_SPB_OVERFLOW_ERROR = read_CTF_ERROR_SPB_OVERFLOW_ERROR_value
    End Property

    Property Let write_CTF_ERROR_SPB_OVERFLOW_ERROR(aData)
        set_CTF_ERROR_SPB_OVERFLOW_ERROR = aData
        write
    End Property

    Property Get get_CTF_ERROR_LAB_OVERFLOW_ERROR
        get_CTF_ERROR_LAB_OVERFLOW_ERROR = read_CTF_ERROR_LAB_OVERFLOW_ERROR_value
    End Property

    Property Let set_CTF_ERROR_LAB_OVERFLOW_ERROR(aData)
        write_CTF_ERROR_LAB_OVERFLOW_ERROR_value = aData
        flag_CTF_ERROR_LAB_OVERFLOW_ERROR        = &H1
    End Property

    Property Get read_CTF_ERROR_LAB_OVERFLOW_ERROR
        read
        read_CTF_ERROR_LAB_OVERFLOW_ERROR = read_CTF_ERROR_LAB_OVERFLOW_ERROR_value
    End Property

    Property Let write_CTF_ERROR_LAB_OVERFLOW_ERROR(aData)
        set_CTF_ERROR_LAB_OVERFLOW_ERROR = aData
        write
    End Property

    Property Get get_CTF_ERROR_INTERNAL_MERGE_ERROR
        get_CTF_ERROR_INTERNAL_MERGE_ERROR = read_CTF_ERROR_INTERNAL_MERGE_ERROR_value
    End Property

    Property Let set_CTF_ERROR_INTERNAL_MERGE_ERROR(aData)
        write_CTF_ERROR_INTERNAL_MERGE_ERROR_value = aData
        flag_CTF_ERROR_INTERNAL_MERGE_ERROR        = &H1
    End Property

    Property Get read_CTF_ERROR_INTERNAL_MERGE_ERROR
        read
        read_CTF_ERROR_INTERNAL_MERGE_ERROR = read_CTF_ERROR_INTERNAL_MERGE_ERROR_value
    End Property

    Property Let write_CTF_ERROR_INTERNAL_MERGE_ERROR(aData)
        set_CTF_ERROR_INTERNAL_MERGE_ERROR = aData
        write
    End Property

    Property Get get_CTF_ERROR_TXQ_OVERFLOW_ERROR
        get_CTF_ERROR_TXQ_OVERFLOW_ERROR = read_CTF_ERROR_TXQ_OVERFLOW_ERROR_value
    End Property

    Property Let set_CTF_ERROR_TXQ_OVERFLOW_ERROR(aData)
        write_CTF_ERROR_TXQ_OVERFLOW_ERROR_value = aData
        flag_CTF_ERROR_TXQ_OVERFLOW_ERROR        = &H1
    End Property

    Property Get read_CTF_ERROR_TXQ_OVERFLOW_ERROR
        read
        read_CTF_ERROR_TXQ_OVERFLOW_ERROR = read_CTF_ERROR_TXQ_OVERFLOW_ERROR_value
    End Property

    Property Let write_CTF_ERROR_TXQ_OVERFLOW_ERROR(aData)
        set_CTF_ERROR_TXQ_OVERFLOW_ERROR = aData
        write
    End Property

    Property Get get_CTF_ERROR_RB_OVERFLOW_ERROR
        get_CTF_ERROR_RB_OVERFLOW_ERROR = read_CTF_ERROR_RB_OVERFLOW_ERROR_value
    End Property

    Property Let set_CTF_ERROR_RB_OVERFLOW_ERROR(aData)
        write_CTF_ERROR_RB_OVERFLOW_ERROR_value = aData
        flag_CTF_ERROR_RB_OVERFLOW_ERROR        = &H1
    End Property

    Property Get read_CTF_ERROR_RB_OVERFLOW_ERROR
        read
        read_CTF_ERROR_RB_OVERFLOW_ERROR = read_CTF_ERROR_RB_OVERFLOW_ERROR_value
    End Property

    Property Let write_CTF_ERROR_RB_OVERFLOW_ERROR(aData)
        set_CTF_ERROR_RB_OVERFLOW_ERROR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CTF_ERROR_RESERVED_value = rightShift(data_low, 9) and &H7fffff
        read_CTF_ERROR_HWQ_OVERFLOW_ERROR_value = rightShift(data_low, 8) and &H1
        read_CTF_ERROR_HB_OVERFLOW_ERROR_value = rightShift(data_low, 7) and &H1
        read_CTF_ERROR_RXQ_OVERFLOW_ERROR_value = rightShift(data_low, 6) and &H1
        read_CTF_ERROR_SOP_EOP_ERROR_value = rightShift(data_low, 5) and &H1
        read_CTF_ERROR_SPB_OVERFLOW_ERROR_value = rightShift(data_low, 4) and &H1
        read_CTF_ERROR_LAB_OVERFLOW_ERROR_value = rightShift(data_low, 3) and &H1
        read_CTF_ERROR_INTERNAL_MERGE_ERROR_value = rightShift(data_low, 2) and &H1
        read_CTF_ERROR_TXQ_OVERFLOW_ERROR_value = rightShift(data_low, 1) and &H1
        CTF_ERROR_RB_OVERFLOW_ERROR_mask = &H1
        if data_low > LONG_MAX then
            if CTF_ERROR_RB_OVERFLOW_ERROR_mask = mask then
                read_CTF_ERROR_RB_OVERFLOW_ERROR_value = data_low
            else
                read_CTF_ERROR_RB_OVERFLOW_ERROR_value = (data_low - H8000_0000) and CTF_ERROR_RB_OVERFLOW_ERROR_mask
            end If
        else
            read_CTF_ERROR_RB_OVERFLOW_ERROR_value = data_low and CTF_ERROR_RB_OVERFLOW_ERROR_mask
        end If

    End Sub

    Sub write
        If flag_CTF_ERROR_RESERVED = &H0 or flag_CTF_ERROR_HWQ_OVERFLOW_ERROR = &H0 or flag_CTF_ERROR_HB_OVERFLOW_ERROR = &H0 or flag_CTF_ERROR_RXQ_OVERFLOW_ERROR = &H0 or flag_CTF_ERROR_SOP_EOP_ERROR = &H0 or flag_CTF_ERROR_SPB_OVERFLOW_ERROR = &H0 or flag_CTF_ERROR_LAB_OVERFLOW_ERROR = &H0 or flag_CTF_ERROR_INTERNAL_MERGE_ERROR = &H0 or flag_CTF_ERROR_TXQ_OVERFLOW_ERROR = &H0 or flag_CTF_ERROR_RB_OVERFLOW_ERROR = &H0 Then read
        If flag_CTF_ERROR_RESERVED = &H0 Then write_CTF_ERROR_RESERVED_value = get_CTF_ERROR_RESERVED
        If flag_CTF_ERROR_HWQ_OVERFLOW_ERROR = &H0 Then write_CTF_ERROR_HWQ_OVERFLOW_ERROR_value = get_CTF_ERROR_HWQ_OVERFLOW_ERROR
        If flag_CTF_ERROR_HB_OVERFLOW_ERROR = &H0 Then write_CTF_ERROR_HB_OVERFLOW_ERROR_value = get_CTF_ERROR_HB_OVERFLOW_ERROR
        If flag_CTF_ERROR_RXQ_OVERFLOW_ERROR = &H0 Then write_CTF_ERROR_RXQ_OVERFLOW_ERROR_value = get_CTF_ERROR_RXQ_OVERFLOW_ERROR
        If flag_CTF_ERROR_SOP_EOP_ERROR = &H0 Then write_CTF_ERROR_SOP_EOP_ERROR_value = get_CTF_ERROR_SOP_EOP_ERROR
        If flag_CTF_ERROR_SPB_OVERFLOW_ERROR = &H0 Then write_CTF_ERROR_SPB_OVERFLOW_ERROR_value = get_CTF_ERROR_SPB_OVERFLOW_ERROR
        If flag_CTF_ERROR_LAB_OVERFLOW_ERROR = &H0 Then write_CTF_ERROR_LAB_OVERFLOW_ERROR_value = get_CTF_ERROR_LAB_OVERFLOW_ERROR
        If flag_CTF_ERROR_INTERNAL_MERGE_ERROR = &H0 Then write_CTF_ERROR_INTERNAL_MERGE_ERROR_value = get_CTF_ERROR_INTERNAL_MERGE_ERROR
        If flag_CTF_ERROR_TXQ_OVERFLOW_ERROR = &H0 Then write_CTF_ERROR_TXQ_OVERFLOW_ERROR_value = get_CTF_ERROR_TXQ_OVERFLOW_ERROR
        If flag_CTF_ERROR_RB_OVERFLOW_ERROR = &H0 Then write_CTF_ERROR_RB_OVERFLOW_ERROR_value = get_CTF_ERROR_RB_OVERFLOW_ERROR

        regValue = leftShift((write_CTF_ERROR_RESERVED_value and &H7fffff), 9) + leftShift((write_CTF_ERROR_HWQ_OVERFLOW_ERROR_value and &H1), 8) + leftShift((write_CTF_ERROR_HB_OVERFLOW_ERROR_value and &H1), 7) + leftShift((write_CTF_ERROR_RXQ_OVERFLOW_ERROR_value and &H1), 6) + leftShift((write_CTF_ERROR_SOP_EOP_ERROR_value and &H1), 5) + leftShift((write_CTF_ERROR_SPB_OVERFLOW_ERROR_value and &H1), 4) + leftShift((write_CTF_ERROR_LAB_OVERFLOW_ERROR_value and &H1), 3) + leftShift((write_CTF_ERROR_INTERNAL_MERGE_ERROR_value and &H1), 2) + leftShift((write_CTF_ERROR_TXQ_OVERFLOW_ERROR_value and &H1), 1) + leftShift((write_CTF_ERROR_RB_OVERFLOW_ERROR_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CTF_ERROR_RESERVED_value = rightShift(data_low, 9) and &H7fffff
        read_CTF_ERROR_HWQ_OVERFLOW_ERROR_value = rightShift(data_low, 8) and &H1
        read_CTF_ERROR_HB_OVERFLOW_ERROR_value = rightShift(data_low, 7) and &H1
        read_CTF_ERROR_RXQ_OVERFLOW_ERROR_value = rightShift(data_low, 6) and &H1
        read_CTF_ERROR_SOP_EOP_ERROR_value = rightShift(data_low, 5) and &H1
        read_CTF_ERROR_SPB_OVERFLOW_ERROR_value = rightShift(data_low, 4) and &H1
        read_CTF_ERROR_LAB_OVERFLOW_ERROR_value = rightShift(data_low, 3) and &H1
        read_CTF_ERROR_INTERNAL_MERGE_ERROR_value = rightShift(data_low, 2) and &H1
        read_CTF_ERROR_TXQ_OVERFLOW_ERROR_value = rightShift(data_low, 1) and &H1
        CTF_ERROR_RB_OVERFLOW_ERROR_mask = &H1
        if data_low > LONG_MAX then
            if CTF_ERROR_RB_OVERFLOW_ERROR_mask = mask then
                read_CTF_ERROR_RB_OVERFLOW_ERROR_value = data_low
            else
                read_CTF_ERROR_RB_OVERFLOW_ERROR_value = (data_low - H8000_0000) and CTF_ERROR_RB_OVERFLOW_ERROR_mask
            end If
        else
            read_CTF_ERROR_RB_OVERFLOW_ERROR_value = data_low and CTF_ERROR_RB_OVERFLOW_ERROR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CTF_ERROR_RESERVED_value = &H0
        flag_CTF_ERROR_RESERVED        = &H0
        write_CTF_ERROR_HWQ_OVERFLOW_ERROR_value = &H0
        flag_CTF_ERROR_HWQ_OVERFLOW_ERROR        = &H0
        write_CTF_ERROR_HB_OVERFLOW_ERROR_value = &H0
        flag_CTF_ERROR_HB_OVERFLOW_ERROR        = &H0
        write_CTF_ERROR_RXQ_OVERFLOW_ERROR_value = &H0
        flag_CTF_ERROR_RXQ_OVERFLOW_ERROR        = &H0
        write_CTF_ERROR_SOP_EOP_ERROR_value = &H0
        flag_CTF_ERROR_SOP_EOP_ERROR        = &H0
        write_CTF_ERROR_SPB_OVERFLOW_ERROR_value = &H0
        flag_CTF_ERROR_SPB_OVERFLOW_ERROR        = &H0
        write_CTF_ERROR_LAB_OVERFLOW_ERROR_value = &H0
        flag_CTF_ERROR_LAB_OVERFLOW_ERROR        = &H0
        write_CTF_ERROR_INTERNAL_MERGE_ERROR_value = &H0
        flag_CTF_ERROR_INTERNAL_MERGE_ERROR        = &H0
        write_CTF_ERROR_TXQ_OVERFLOW_ERROR_value = &H0
        flag_CTF_ERROR_TXQ_OVERFLOW_ERROR        = &H0
        write_CTF_ERROR_RB_OVERFLOW_ERROR_value = &H0
        flag_CTF_ERROR_RB_OVERFLOW_ERROR        = &H0
    End Sub
End Class


'' @REGISTER : CTF_ctf_error_mask
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CTF_ERROR_MASK_RESERVED                    [31:9]           get_CTF_ERROR_MASK_RESERVED
''                                                             set_CTF_ERROR_MASK_RESERVED
''                                                             read_CTF_ERROR_MASK_RESERVED
''                                                             write_CTF_ERROR_MASK_RESERVED
''---------------------------------------------------------------------------------
'' CTF_ERROR_MASK_HWQ_OVERFLOW_ERROR_ENABLE   [8:8]            get_CTF_ERROR_MASK_HWQ_OVERFLOW_ERROR_ENABLE
''                                                             set_CTF_ERROR_MASK_HWQ_OVERFLOW_ERROR_ENABLE
''                                                             read_CTF_ERROR_MASK_HWQ_OVERFLOW_ERROR_ENABLE
''                                                             write_CTF_ERROR_MASK_HWQ_OVERFLOW_ERROR_ENABLE
''---------------------------------------------------------------------------------
'' CTF_ERROR_MASK_HB_OVERFLOW_ERROR_ENABLE    [7:7]            get_CTF_ERROR_MASK_HB_OVERFLOW_ERROR_ENABLE
''                                                             set_CTF_ERROR_MASK_HB_OVERFLOW_ERROR_ENABLE
''                                                             read_CTF_ERROR_MASK_HB_OVERFLOW_ERROR_ENABLE
''                                                             write_CTF_ERROR_MASK_HB_OVERFLOW_ERROR_ENABLE
''---------------------------------------------------------------------------------
'' CTF_ERROR_MASK_RXQ_OVERFLOW_ERROR_ENABLE   [6:6]            get_CTF_ERROR_MASK_RXQ_OVERFLOW_ERROR_ENABLE
''                                                             set_CTF_ERROR_MASK_RXQ_OVERFLOW_ERROR_ENABLE
''                                                             read_CTF_ERROR_MASK_RXQ_OVERFLOW_ERROR_ENABLE
''                                                             write_CTF_ERROR_MASK_RXQ_OVERFLOW_ERROR_ENABLE
''---------------------------------------------------------------------------------
'' CTF_ERROR_MASK_SOP_EOP_ERROR_ENABLE        [5:5]            get_CTF_ERROR_MASK_SOP_EOP_ERROR_ENABLE
''                                                             set_CTF_ERROR_MASK_SOP_EOP_ERROR_ENABLE
''                                                             read_CTF_ERROR_MASK_SOP_EOP_ERROR_ENABLE
''                                                             write_CTF_ERROR_MASK_SOP_EOP_ERROR_ENABLE
''---------------------------------------------------------------------------------
'' CTF_ERROR_MASK_SPB_OVERFLOW_ERROR_ENABLE   [4:4]            get_CTF_ERROR_MASK_SPB_OVERFLOW_ERROR_ENABLE
''                                                             set_CTF_ERROR_MASK_SPB_OVERFLOW_ERROR_ENABLE
''                                                             read_CTF_ERROR_MASK_SPB_OVERFLOW_ERROR_ENABLE
''                                                             write_CTF_ERROR_MASK_SPB_OVERFLOW_ERROR_ENABLE
''---------------------------------------------------------------------------------
'' CTF_ERROR_MASK_LAB_OVERFLOW_ERROR_ENABLE   [3:3]            get_CTF_ERROR_MASK_LAB_OVERFLOW_ERROR_ENABLE
''                                                             set_CTF_ERROR_MASK_LAB_OVERFLOW_ERROR_ENABLE
''                                                             read_CTF_ERROR_MASK_LAB_OVERFLOW_ERROR_ENABLE
''                                                             write_CTF_ERROR_MASK_LAB_OVERFLOW_ERROR_ENABLE
''---------------------------------------------------------------------------------
'' CTF_ERROR_MASK_INTERNAL_MERGE_ERROR_ENABLE   [2:2]            get_CTF_ERROR_MASK_INTERNAL_MERGE_ERROR_ENABLE
''                                                             set_CTF_ERROR_MASK_INTERNAL_MERGE_ERROR_ENABLE
''                                                             read_CTF_ERROR_MASK_INTERNAL_MERGE_ERROR_ENABLE
''                                                             write_CTF_ERROR_MASK_INTERNAL_MERGE_ERROR_ENABLE
''---------------------------------------------------------------------------------
'' CTF_ERROR_MASK_TXQ_OVERFLOW_ERROR_ENABLE   [1:1]            get_CTF_ERROR_MASK_TXQ_OVERFLOW_ERROR_ENABLE
''                                                             set_CTF_ERROR_MASK_TXQ_OVERFLOW_ERROR_ENABLE
''                                                             read_CTF_ERROR_MASK_TXQ_OVERFLOW_ERROR_ENABLE
''                                                             write_CTF_ERROR_MASK_TXQ_OVERFLOW_ERROR_ENABLE
''---------------------------------------------------------------------------------
'' CTF_ERROR_MASK_RB_OVERFLOW_ERROR_ENABLE    [0:0]            get_CTF_ERROR_MASK_RB_OVERFLOW_ERROR_ENABLE
''                                                             set_CTF_ERROR_MASK_RB_OVERFLOW_ERROR_ENABLE
''                                                             read_CTF_ERROR_MASK_RB_OVERFLOW_ERROR_ENABLE
''                                                             write_CTF_ERROR_MASK_RB_OVERFLOW_ERROR_ENABLE
''---------------------------------------------------------------------------------
Class REGISTER_CTF_ctf_error_mask
    Private write_CTF_ERROR_MASK_RESERVED_value
    Private read_CTF_ERROR_MASK_RESERVED_value
    Private flag_CTF_ERROR_MASK_RESERVED
    Private write_CTF_ERROR_MASK_HWQ_OVERFLOW_ERROR_ENABLE_value
    Private read_CTF_ERROR_MASK_HWQ_OVERFLOW_ERROR_ENABLE_value
    Private flag_CTF_ERROR_MASK_HWQ_OVERFLOW_ERROR_ENABLE
    Private write_CTF_ERROR_MASK_HB_OVERFLOW_ERROR_ENABLE_value
    Private read_CTF_ERROR_MASK_HB_OVERFLOW_ERROR_ENABLE_value
    Private flag_CTF_ERROR_MASK_HB_OVERFLOW_ERROR_ENABLE
    Private write_CTF_ERROR_MASK_RXQ_OVERFLOW_ERROR_ENABLE_value
    Private read_CTF_ERROR_MASK_RXQ_OVERFLOW_ERROR_ENABLE_value
    Private flag_CTF_ERROR_MASK_RXQ_OVERFLOW_ERROR_ENABLE
    Private write_CTF_ERROR_MASK_SOP_EOP_ERROR_ENABLE_value
    Private read_CTF_ERROR_MASK_SOP_EOP_ERROR_ENABLE_value
    Private flag_CTF_ERROR_MASK_SOP_EOP_ERROR_ENABLE
    Private write_CTF_ERROR_MASK_SPB_OVERFLOW_ERROR_ENABLE_value
    Private read_CTF_ERROR_MASK_SPB_OVERFLOW_ERROR_ENABLE_value
    Private flag_CTF_ERROR_MASK_SPB_OVERFLOW_ERROR_ENABLE
    Private write_CTF_ERROR_MASK_LAB_OVERFLOW_ERROR_ENABLE_value
    Private read_CTF_ERROR_MASK_LAB_OVERFLOW_ERROR_ENABLE_value
    Private flag_CTF_ERROR_MASK_LAB_OVERFLOW_ERROR_ENABLE
    Private write_CTF_ERROR_MASK_INTERNAL_MERGE_ERROR_ENABLE_value
    Private read_CTF_ERROR_MASK_INTERNAL_MERGE_ERROR_ENABLE_value
    Private flag_CTF_ERROR_MASK_INTERNAL_MERGE_ERROR_ENABLE
    Private write_CTF_ERROR_MASK_TXQ_OVERFLOW_ERROR_ENABLE_value
    Private read_CTF_ERROR_MASK_TXQ_OVERFLOW_ERROR_ENABLE_value
    Private flag_CTF_ERROR_MASK_TXQ_OVERFLOW_ERROR_ENABLE
    Private write_CTF_ERROR_MASK_RB_OVERFLOW_ERROR_ENABLE_value
    Private read_CTF_ERROR_MASK_RB_OVERFLOW_ERROR_ENABLE_value
    Private flag_CTF_ERROR_MASK_RB_OVERFLOW_ERROR_ENABLE

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H68
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_CTF_ERROR_MASK_RESERVED
        get_CTF_ERROR_MASK_RESERVED = read_CTF_ERROR_MASK_RESERVED_value
    End Property

    Property Let set_CTF_ERROR_MASK_RESERVED(aData)
        write_CTF_ERROR_MASK_RESERVED_value = aData
        flag_CTF_ERROR_MASK_RESERVED        = &H1
    End Property

    Property Get read_CTF_ERROR_MASK_RESERVED
        read
        read_CTF_ERROR_MASK_RESERVED = read_CTF_ERROR_MASK_RESERVED_value
    End Property

    Property Let write_CTF_ERROR_MASK_RESERVED(aData)
        set_CTF_ERROR_MASK_RESERVED = aData
        write
    End Property

    Property Get get_CTF_ERROR_MASK_HWQ_OVERFLOW_ERROR_ENABLE
        get_CTF_ERROR_MASK_HWQ_OVERFLOW_ERROR_ENABLE = read_CTF_ERROR_MASK_HWQ_OVERFLOW_ERROR_ENABLE_value
    End Property

    Property Let set_CTF_ERROR_MASK_HWQ_OVERFLOW_ERROR_ENABLE(aData)
        write_CTF_ERROR_MASK_HWQ_OVERFLOW_ERROR_ENABLE_value = aData
        flag_CTF_ERROR_MASK_HWQ_OVERFLOW_ERROR_ENABLE        = &H1
    End Property

    Property Get read_CTF_ERROR_MASK_HWQ_OVERFLOW_ERROR_ENABLE
        read
        read_CTF_ERROR_MASK_HWQ_OVERFLOW_ERROR_ENABLE = read_CTF_ERROR_MASK_HWQ_OVERFLOW_ERROR_ENABLE_value
    End Property

    Property Let write_CTF_ERROR_MASK_HWQ_OVERFLOW_ERROR_ENABLE(aData)
        set_CTF_ERROR_MASK_HWQ_OVERFLOW_ERROR_ENABLE = aData
        write
    End Property

    Property Get get_CTF_ERROR_MASK_HB_OVERFLOW_ERROR_ENABLE
        get_CTF_ERROR_MASK_HB_OVERFLOW_ERROR_ENABLE = read_CTF_ERROR_MASK_HB_OVERFLOW_ERROR_ENABLE_value
    End Property

    Property Let set_CTF_ERROR_MASK_HB_OVERFLOW_ERROR_ENABLE(aData)
        write_CTF_ERROR_MASK_HB_OVERFLOW_ERROR_ENABLE_value = aData
        flag_CTF_ERROR_MASK_HB_OVERFLOW_ERROR_ENABLE        = &H1
    End Property

    Property Get read_CTF_ERROR_MASK_HB_OVERFLOW_ERROR_ENABLE
        read
        read_CTF_ERROR_MASK_HB_OVERFLOW_ERROR_ENABLE = read_CTF_ERROR_MASK_HB_OVERFLOW_ERROR_ENABLE_value
    End Property

    Property Let write_CTF_ERROR_MASK_HB_OVERFLOW_ERROR_ENABLE(aData)
        set_CTF_ERROR_MASK_HB_OVERFLOW_ERROR_ENABLE = aData
        write
    End Property

    Property Get get_CTF_ERROR_MASK_RXQ_OVERFLOW_ERROR_ENABLE
        get_CTF_ERROR_MASK_RXQ_OVERFLOW_ERROR_ENABLE = read_CTF_ERROR_MASK_RXQ_OVERFLOW_ERROR_ENABLE_value
    End Property

    Property Let set_CTF_ERROR_MASK_RXQ_OVERFLOW_ERROR_ENABLE(aData)
        write_CTF_ERROR_MASK_RXQ_OVERFLOW_ERROR_ENABLE_value = aData
        flag_CTF_ERROR_MASK_RXQ_OVERFLOW_ERROR_ENABLE        = &H1
    End Property

    Property Get read_CTF_ERROR_MASK_RXQ_OVERFLOW_ERROR_ENABLE
        read
        read_CTF_ERROR_MASK_RXQ_OVERFLOW_ERROR_ENABLE = read_CTF_ERROR_MASK_RXQ_OVERFLOW_ERROR_ENABLE_value
    End Property

    Property Let write_CTF_ERROR_MASK_RXQ_OVERFLOW_ERROR_ENABLE(aData)
        set_CTF_ERROR_MASK_RXQ_OVERFLOW_ERROR_ENABLE = aData
        write
    End Property

    Property Get get_CTF_ERROR_MASK_SOP_EOP_ERROR_ENABLE
        get_CTF_ERROR_MASK_SOP_EOP_ERROR_ENABLE = read_CTF_ERROR_MASK_SOP_EOP_ERROR_ENABLE_value
    End Property

    Property Let set_CTF_ERROR_MASK_SOP_EOP_ERROR_ENABLE(aData)
        write_CTF_ERROR_MASK_SOP_EOP_ERROR_ENABLE_value = aData
        flag_CTF_ERROR_MASK_SOP_EOP_ERROR_ENABLE        = &H1
    End Property

    Property Get read_CTF_ERROR_MASK_SOP_EOP_ERROR_ENABLE
        read
        read_CTF_ERROR_MASK_SOP_EOP_ERROR_ENABLE = read_CTF_ERROR_MASK_SOP_EOP_ERROR_ENABLE_value
    End Property

    Property Let write_CTF_ERROR_MASK_SOP_EOP_ERROR_ENABLE(aData)
        set_CTF_ERROR_MASK_SOP_EOP_ERROR_ENABLE = aData
        write
    End Property

    Property Get get_CTF_ERROR_MASK_SPB_OVERFLOW_ERROR_ENABLE
        get_CTF_ERROR_MASK_SPB_OVERFLOW_ERROR_ENABLE = read_CTF_ERROR_MASK_SPB_OVERFLOW_ERROR_ENABLE_value
    End Property

    Property Let set_CTF_ERROR_MASK_SPB_OVERFLOW_ERROR_ENABLE(aData)
        write_CTF_ERROR_MASK_SPB_OVERFLOW_ERROR_ENABLE_value = aData
        flag_CTF_ERROR_MASK_SPB_OVERFLOW_ERROR_ENABLE        = &H1
    End Property

    Property Get read_CTF_ERROR_MASK_SPB_OVERFLOW_ERROR_ENABLE
        read
        read_CTF_ERROR_MASK_SPB_OVERFLOW_ERROR_ENABLE = read_CTF_ERROR_MASK_SPB_OVERFLOW_ERROR_ENABLE_value
    End Property

    Property Let write_CTF_ERROR_MASK_SPB_OVERFLOW_ERROR_ENABLE(aData)
        set_CTF_ERROR_MASK_SPB_OVERFLOW_ERROR_ENABLE = aData
        write
    End Property

    Property Get get_CTF_ERROR_MASK_LAB_OVERFLOW_ERROR_ENABLE
        get_CTF_ERROR_MASK_LAB_OVERFLOW_ERROR_ENABLE = read_CTF_ERROR_MASK_LAB_OVERFLOW_ERROR_ENABLE_value
    End Property

    Property Let set_CTF_ERROR_MASK_LAB_OVERFLOW_ERROR_ENABLE(aData)
        write_CTF_ERROR_MASK_LAB_OVERFLOW_ERROR_ENABLE_value = aData
        flag_CTF_ERROR_MASK_LAB_OVERFLOW_ERROR_ENABLE        = &H1
    End Property

    Property Get read_CTF_ERROR_MASK_LAB_OVERFLOW_ERROR_ENABLE
        read
        read_CTF_ERROR_MASK_LAB_OVERFLOW_ERROR_ENABLE = read_CTF_ERROR_MASK_LAB_OVERFLOW_ERROR_ENABLE_value
    End Property

    Property Let write_CTF_ERROR_MASK_LAB_OVERFLOW_ERROR_ENABLE(aData)
        set_CTF_ERROR_MASK_LAB_OVERFLOW_ERROR_ENABLE = aData
        write
    End Property

    Property Get get_CTF_ERROR_MASK_INTERNAL_MERGE_ERROR_ENABLE
        get_CTF_ERROR_MASK_INTERNAL_MERGE_ERROR_ENABLE = read_CTF_ERROR_MASK_INTERNAL_MERGE_ERROR_ENABLE_value
    End Property

    Property Let set_CTF_ERROR_MASK_INTERNAL_MERGE_ERROR_ENABLE(aData)
        write_CTF_ERROR_MASK_INTERNAL_MERGE_ERROR_ENABLE_value = aData
        flag_CTF_ERROR_MASK_INTERNAL_MERGE_ERROR_ENABLE        = &H1
    End Property

    Property Get read_CTF_ERROR_MASK_INTERNAL_MERGE_ERROR_ENABLE
        read
        read_CTF_ERROR_MASK_INTERNAL_MERGE_ERROR_ENABLE = read_CTF_ERROR_MASK_INTERNAL_MERGE_ERROR_ENABLE_value
    End Property

    Property Let write_CTF_ERROR_MASK_INTERNAL_MERGE_ERROR_ENABLE(aData)
        set_CTF_ERROR_MASK_INTERNAL_MERGE_ERROR_ENABLE = aData
        write
    End Property

    Property Get get_CTF_ERROR_MASK_TXQ_OVERFLOW_ERROR_ENABLE
        get_CTF_ERROR_MASK_TXQ_OVERFLOW_ERROR_ENABLE = read_CTF_ERROR_MASK_TXQ_OVERFLOW_ERROR_ENABLE_value
    End Property

    Property Let set_CTF_ERROR_MASK_TXQ_OVERFLOW_ERROR_ENABLE(aData)
        write_CTF_ERROR_MASK_TXQ_OVERFLOW_ERROR_ENABLE_value = aData
        flag_CTF_ERROR_MASK_TXQ_OVERFLOW_ERROR_ENABLE        = &H1
    End Property

    Property Get read_CTF_ERROR_MASK_TXQ_OVERFLOW_ERROR_ENABLE
        read
        read_CTF_ERROR_MASK_TXQ_OVERFLOW_ERROR_ENABLE = read_CTF_ERROR_MASK_TXQ_OVERFLOW_ERROR_ENABLE_value
    End Property

    Property Let write_CTF_ERROR_MASK_TXQ_OVERFLOW_ERROR_ENABLE(aData)
        set_CTF_ERROR_MASK_TXQ_OVERFLOW_ERROR_ENABLE = aData
        write
    End Property

    Property Get get_CTF_ERROR_MASK_RB_OVERFLOW_ERROR_ENABLE
        get_CTF_ERROR_MASK_RB_OVERFLOW_ERROR_ENABLE = read_CTF_ERROR_MASK_RB_OVERFLOW_ERROR_ENABLE_value
    End Property

    Property Let set_CTF_ERROR_MASK_RB_OVERFLOW_ERROR_ENABLE(aData)
        write_CTF_ERROR_MASK_RB_OVERFLOW_ERROR_ENABLE_value = aData
        flag_CTF_ERROR_MASK_RB_OVERFLOW_ERROR_ENABLE        = &H1
    End Property

    Property Get read_CTF_ERROR_MASK_RB_OVERFLOW_ERROR_ENABLE
        read
        read_CTF_ERROR_MASK_RB_OVERFLOW_ERROR_ENABLE = read_CTF_ERROR_MASK_RB_OVERFLOW_ERROR_ENABLE_value
    End Property

    Property Let write_CTF_ERROR_MASK_RB_OVERFLOW_ERROR_ENABLE(aData)
        set_CTF_ERROR_MASK_RB_OVERFLOW_ERROR_ENABLE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CTF_ERROR_MASK_RESERVED_value = rightShift(data_low, 9) and &H7fffff
        read_CTF_ERROR_MASK_HWQ_OVERFLOW_ERROR_ENABLE_value = rightShift(data_low, 8) and &H1
        read_CTF_ERROR_MASK_HB_OVERFLOW_ERROR_ENABLE_value = rightShift(data_low, 7) and &H1
        read_CTF_ERROR_MASK_RXQ_OVERFLOW_ERROR_ENABLE_value = rightShift(data_low, 6) and &H1
        read_CTF_ERROR_MASK_SOP_EOP_ERROR_ENABLE_value = rightShift(data_low, 5) and &H1
        read_CTF_ERROR_MASK_SPB_OVERFLOW_ERROR_ENABLE_value = rightShift(data_low, 4) and &H1
        read_CTF_ERROR_MASK_LAB_OVERFLOW_ERROR_ENABLE_value = rightShift(data_low, 3) and &H1
        read_CTF_ERROR_MASK_INTERNAL_MERGE_ERROR_ENABLE_value = rightShift(data_low, 2) and &H1
        read_CTF_ERROR_MASK_TXQ_OVERFLOW_ERROR_ENABLE_value = rightShift(data_low, 1) and &H1
        CTF_ERROR_MASK_RB_OVERFLOW_ERROR_ENABLE_mask = &H1
        if data_low > LONG_MAX then
            if CTF_ERROR_MASK_RB_OVERFLOW_ERROR_ENABLE_mask = mask then
                read_CTF_ERROR_MASK_RB_OVERFLOW_ERROR_ENABLE_value = data_low
            else
                read_CTF_ERROR_MASK_RB_OVERFLOW_ERROR_ENABLE_value = (data_low - H8000_0000) and CTF_ERROR_MASK_RB_OVERFLOW_ERROR_ENABLE_mask
            end If
        else
            read_CTF_ERROR_MASK_RB_OVERFLOW_ERROR_ENABLE_value = data_low and CTF_ERROR_MASK_RB_OVERFLOW_ERROR_ENABLE_mask
        end If

    End Sub

    Sub write
        If flag_CTF_ERROR_MASK_RESERVED = &H0 or flag_CTF_ERROR_MASK_HWQ_OVERFLOW_ERROR_ENABLE = &H0 or flag_CTF_ERROR_MASK_HB_OVERFLOW_ERROR_ENABLE = &H0 or flag_CTF_ERROR_MASK_RXQ_OVERFLOW_ERROR_ENABLE = &H0 or flag_CTF_ERROR_MASK_SOP_EOP_ERROR_ENABLE = &H0 or flag_CTF_ERROR_MASK_SPB_OVERFLOW_ERROR_ENABLE = &H0 or flag_CTF_ERROR_MASK_LAB_OVERFLOW_ERROR_ENABLE = &H0 or flag_CTF_ERROR_MASK_INTERNAL_MERGE_ERROR_ENABLE = &H0 or flag_CTF_ERROR_MASK_TXQ_OVERFLOW_ERROR_ENABLE = &H0 or flag_CTF_ERROR_MASK_RB_OVERFLOW_ERROR_ENABLE = &H0 Then read
        If flag_CTF_ERROR_MASK_RESERVED = &H0 Then write_CTF_ERROR_MASK_RESERVED_value = get_CTF_ERROR_MASK_RESERVED
        If flag_CTF_ERROR_MASK_HWQ_OVERFLOW_ERROR_ENABLE = &H0 Then write_CTF_ERROR_MASK_HWQ_OVERFLOW_ERROR_ENABLE_value = get_CTF_ERROR_MASK_HWQ_OVERFLOW_ERROR_ENABLE
        If flag_CTF_ERROR_MASK_HB_OVERFLOW_ERROR_ENABLE = &H0 Then write_CTF_ERROR_MASK_HB_OVERFLOW_ERROR_ENABLE_value = get_CTF_ERROR_MASK_HB_OVERFLOW_ERROR_ENABLE
        If flag_CTF_ERROR_MASK_RXQ_OVERFLOW_ERROR_ENABLE = &H0 Then write_CTF_ERROR_MASK_RXQ_OVERFLOW_ERROR_ENABLE_value = get_CTF_ERROR_MASK_RXQ_OVERFLOW_ERROR_ENABLE
        If flag_CTF_ERROR_MASK_SOP_EOP_ERROR_ENABLE = &H0 Then write_CTF_ERROR_MASK_SOP_EOP_ERROR_ENABLE_value = get_CTF_ERROR_MASK_SOP_EOP_ERROR_ENABLE
        If flag_CTF_ERROR_MASK_SPB_OVERFLOW_ERROR_ENABLE = &H0 Then write_CTF_ERROR_MASK_SPB_OVERFLOW_ERROR_ENABLE_value = get_CTF_ERROR_MASK_SPB_OVERFLOW_ERROR_ENABLE
        If flag_CTF_ERROR_MASK_LAB_OVERFLOW_ERROR_ENABLE = &H0 Then write_CTF_ERROR_MASK_LAB_OVERFLOW_ERROR_ENABLE_value = get_CTF_ERROR_MASK_LAB_OVERFLOW_ERROR_ENABLE
        If flag_CTF_ERROR_MASK_INTERNAL_MERGE_ERROR_ENABLE = &H0 Then write_CTF_ERROR_MASK_INTERNAL_MERGE_ERROR_ENABLE_value = get_CTF_ERROR_MASK_INTERNAL_MERGE_ERROR_ENABLE
        If flag_CTF_ERROR_MASK_TXQ_OVERFLOW_ERROR_ENABLE = &H0 Then write_CTF_ERROR_MASK_TXQ_OVERFLOW_ERROR_ENABLE_value = get_CTF_ERROR_MASK_TXQ_OVERFLOW_ERROR_ENABLE
        If flag_CTF_ERROR_MASK_RB_OVERFLOW_ERROR_ENABLE = &H0 Then write_CTF_ERROR_MASK_RB_OVERFLOW_ERROR_ENABLE_value = get_CTF_ERROR_MASK_RB_OVERFLOW_ERROR_ENABLE

        regValue = leftShift((write_CTF_ERROR_MASK_RESERVED_value and &H7fffff), 9) + leftShift((write_CTF_ERROR_MASK_HWQ_OVERFLOW_ERROR_ENABLE_value and &H1), 8) + leftShift((write_CTF_ERROR_MASK_HB_OVERFLOW_ERROR_ENABLE_value and &H1), 7) + leftShift((write_CTF_ERROR_MASK_RXQ_OVERFLOW_ERROR_ENABLE_value and &H1), 6) + leftShift((write_CTF_ERROR_MASK_SOP_EOP_ERROR_ENABLE_value and &H1), 5) + leftShift((write_CTF_ERROR_MASK_SPB_OVERFLOW_ERROR_ENABLE_value and &H1), 4) + leftShift((write_CTF_ERROR_MASK_LAB_OVERFLOW_ERROR_ENABLE_value and &H1), 3) + leftShift((write_CTF_ERROR_MASK_INTERNAL_MERGE_ERROR_ENABLE_value and &H1), 2) + leftShift((write_CTF_ERROR_MASK_TXQ_OVERFLOW_ERROR_ENABLE_value and &H1), 1) + leftShift((write_CTF_ERROR_MASK_RB_OVERFLOW_ERROR_ENABLE_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CTF_ERROR_MASK_RESERVED_value = rightShift(data_low, 9) and &H7fffff
        read_CTF_ERROR_MASK_HWQ_OVERFLOW_ERROR_ENABLE_value = rightShift(data_low, 8) and &H1
        read_CTF_ERROR_MASK_HB_OVERFLOW_ERROR_ENABLE_value = rightShift(data_low, 7) and &H1
        read_CTF_ERROR_MASK_RXQ_OVERFLOW_ERROR_ENABLE_value = rightShift(data_low, 6) and &H1
        read_CTF_ERROR_MASK_SOP_EOP_ERROR_ENABLE_value = rightShift(data_low, 5) and &H1
        read_CTF_ERROR_MASK_SPB_OVERFLOW_ERROR_ENABLE_value = rightShift(data_low, 4) and &H1
        read_CTF_ERROR_MASK_LAB_OVERFLOW_ERROR_ENABLE_value = rightShift(data_low, 3) and &H1
        read_CTF_ERROR_MASK_INTERNAL_MERGE_ERROR_ENABLE_value = rightShift(data_low, 2) and &H1
        read_CTF_ERROR_MASK_TXQ_OVERFLOW_ERROR_ENABLE_value = rightShift(data_low, 1) and &H1
        CTF_ERROR_MASK_RB_OVERFLOW_ERROR_ENABLE_mask = &H1
        if data_low > LONG_MAX then
            if CTF_ERROR_MASK_RB_OVERFLOW_ERROR_ENABLE_mask = mask then
                read_CTF_ERROR_MASK_RB_OVERFLOW_ERROR_ENABLE_value = data_low
            else
                read_CTF_ERROR_MASK_RB_OVERFLOW_ERROR_ENABLE_value = (data_low - H8000_0000) and CTF_ERROR_MASK_RB_OVERFLOW_ERROR_ENABLE_mask
            end If
        else
            read_CTF_ERROR_MASK_RB_OVERFLOW_ERROR_ENABLE_value = data_low and CTF_ERROR_MASK_RB_OVERFLOW_ERROR_ENABLE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CTF_ERROR_MASK_RESERVED_value = &H0
        flag_CTF_ERROR_MASK_RESERVED        = &H0
        write_CTF_ERROR_MASK_HWQ_OVERFLOW_ERROR_ENABLE_value = &H0
        flag_CTF_ERROR_MASK_HWQ_OVERFLOW_ERROR_ENABLE        = &H0
        write_CTF_ERROR_MASK_HB_OVERFLOW_ERROR_ENABLE_value = &H0
        flag_CTF_ERROR_MASK_HB_OVERFLOW_ERROR_ENABLE        = &H0
        write_CTF_ERROR_MASK_RXQ_OVERFLOW_ERROR_ENABLE_value = &H0
        flag_CTF_ERROR_MASK_RXQ_OVERFLOW_ERROR_ENABLE        = &H0
        write_CTF_ERROR_MASK_SOP_EOP_ERROR_ENABLE_value = &H0
        flag_CTF_ERROR_MASK_SOP_EOP_ERROR_ENABLE        = &H0
        write_CTF_ERROR_MASK_SPB_OVERFLOW_ERROR_ENABLE_value = &H0
        flag_CTF_ERROR_MASK_SPB_OVERFLOW_ERROR_ENABLE        = &H0
        write_CTF_ERROR_MASK_LAB_OVERFLOW_ERROR_ENABLE_value = &H0
        flag_CTF_ERROR_MASK_LAB_OVERFLOW_ERROR_ENABLE        = &H0
        write_CTF_ERROR_MASK_INTERNAL_MERGE_ERROR_ENABLE_value = &H0
        flag_CTF_ERROR_MASK_INTERNAL_MERGE_ERROR_ENABLE        = &H0
        write_CTF_ERROR_MASK_TXQ_OVERFLOW_ERROR_ENABLE_value = &H0
        flag_CTF_ERROR_MASK_TXQ_OVERFLOW_ERROR_ENABLE        = &H0
        write_CTF_ERROR_MASK_RB_OVERFLOW_ERROR_ENABLE_value = &H0
        flag_CTF_ERROR_MASK_RB_OVERFLOW_ERROR_ENABLE        = &H0
    End Sub
End Class


'' @REGISTER : CTF_ctf_debug_control
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CTF_DEBUG_CONTROL_RESERVED                 [31:7]           get_CTF_DEBUG_CONTROL_RESERVED
''                                                             set_CTF_DEBUG_CONTROL_RESERVED
''                                                             read_CTF_DEBUG_CONTROL_RESERVED
''                                                             write_CTF_DEBUG_CONTROL_RESERVED
''---------------------------------------------------------------------------------
'' CTF_DEBUG_CONTROL_OK_TO_SEND_CONFIG        [6:3]            get_CTF_DEBUG_CONTROL_OK_TO_SEND_CONFIG
''                                                             set_CTF_DEBUG_CONTROL_OK_TO_SEND_CONFIG
''                                                             read_CTF_DEBUG_CONTROL_OK_TO_SEND_CONFIG
''                                                             write_CTF_DEBUG_CONTROL_OK_TO_SEND_CONFIG
''---------------------------------------------------------------------------------
'' CTF_DEBUG_CONTROL_FORCE_ALL_HIT            [2:2]            get_CTF_DEBUG_CONTROL_FORCE_ALL_HIT
''                                                             set_CTF_DEBUG_CONTROL_FORCE_ALL_HIT
''                                                             read_CTF_DEBUG_CONTROL_FORCE_ALL_HIT
''                                                             write_CTF_DEBUG_CONTROL_FORCE_ALL_HIT
''---------------------------------------------------------------------------------
'' CTF_DEBUG_CONTROL_FORCE_ALL_MISS           [1:1]            get_CTF_DEBUG_CONTROL_FORCE_ALL_MISS
''                                                             set_CTF_DEBUG_CONTROL_FORCE_ALL_MISS
''                                                             read_CTF_DEBUG_CONTROL_FORCE_ALL_MISS
''                                                             write_CTF_DEBUG_CONTROL_FORCE_ALL_MISS
''---------------------------------------------------------------------------------
'' CTF_DEBUG_CONTROL_REG_DEBUG                [0:0]            get_CTF_DEBUG_CONTROL_REG_DEBUG
''                                                             set_CTF_DEBUG_CONTROL_REG_DEBUG
''                                                             read_CTF_DEBUG_CONTROL_REG_DEBUG
''                                                             write_CTF_DEBUG_CONTROL_REG_DEBUG
''---------------------------------------------------------------------------------
Class REGISTER_CTF_ctf_debug_control
    Private write_CTF_DEBUG_CONTROL_RESERVED_value
    Private read_CTF_DEBUG_CONTROL_RESERVED_value
    Private flag_CTF_DEBUG_CONTROL_RESERVED
    Private write_CTF_DEBUG_CONTROL_OK_TO_SEND_CONFIG_value
    Private read_CTF_DEBUG_CONTROL_OK_TO_SEND_CONFIG_value
    Private flag_CTF_DEBUG_CONTROL_OK_TO_SEND_CONFIG
    Private write_CTF_DEBUG_CONTROL_FORCE_ALL_HIT_value
    Private read_CTF_DEBUG_CONTROL_FORCE_ALL_HIT_value
    Private flag_CTF_DEBUG_CONTROL_FORCE_ALL_HIT
    Private write_CTF_DEBUG_CONTROL_FORCE_ALL_MISS_value
    Private read_CTF_DEBUG_CONTROL_FORCE_ALL_MISS_value
    Private flag_CTF_DEBUG_CONTROL_FORCE_ALL_MISS
    Private write_CTF_DEBUG_CONTROL_REG_DEBUG_value
    Private read_CTF_DEBUG_CONTROL_REG_DEBUG_value
    Private flag_CTF_DEBUG_CONTROL_REG_DEBUG

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H6c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_CTF_DEBUG_CONTROL_RESERVED
        get_CTF_DEBUG_CONTROL_RESERVED = read_CTF_DEBUG_CONTROL_RESERVED_value
    End Property

    Property Let set_CTF_DEBUG_CONTROL_RESERVED(aData)
        write_CTF_DEBUG_CONTROL_RESERVED_value = aData
        flag_CTF_DEBUG_CONTROL_RESERVED        = &H1
    End Property

    Property Get read_CTF_DEBUG_CONTROL_RESERVED
        read
        read_CTF_DEBUG_CONTROL_RESERVED = read_CTF_DEBUG_CONTROL_RESERVED_value
    End Property

    Property Let write_CTF_DEBUG_CONTROL_RESERVED(aData)
        set_CTF_DEBUG_CONTROL_RESERVED = aData
        write
    End Property

    Property Get get_CTF_DEBUG_CONTROL_OK_TO_SEND_CONFIG
        get_CTF_DEBUG_CONTROL_OK_TO_SEND_CONFIG = read_CTF_DEBUG_CONTROL_OK_TO_SEND_CONFIG_value
    End Property

    Property Let set_CTF_DEBUG_CONTROL_OK_TO_SEND_CONFIG(aData)
        write_CTF_DEBUG_CONTROL_OK_TO_SEND_CONFIG_value = aData
        flag_CTF_DEBUG_CONTROL_OK_TO_SEND_CONFIG        = &H1
    End Property

    Property Get read_CTF_DEBUG_CONTROL_OK_TO_SEND_CONFIG
        read
        read_CTF_DEBUG_CONTROL_OK_TO_SEND_CONFIG = read_CTF_DEBUG_CONTROL_OK_TO_SEND_CONFIG_value
    End Property

    Property Let write_CTF_DEBUG_CONTROL_OK_TO_SEND_CONFIG(aData)
        set_CTF_DEBUG_CONTROL_OK_TO_SEND_CONFIG = aData
        write
    End Property

    Property Get get_CTF_DEBUG_CONTROL_FORCE_ALL_HIT
        get_CTF_DEBUG_CONTROL_FORCE_ALL_HIT = read_CTF_DEBUG_CONTROL_FORCE_ALL_HIT_value
    End Property

    Property Let set_CTF_DEBUG_CONTROL_FORCE_ALL_HIT(aData)
        write_CTF_DEBUG_CONTROL_FORCE_ALL_HIT_value = aData
        flag_CTF_DEBUG_CONTROL_FORCE_ALL_HIT        = &H1
    End Property

    Property Get read_CTF_DEBUG_CONTROL_FORCE_ALL_HIT
        read
        read_CTF_DEBUG_CONTROL_FORCE_ALL_HIT = read_CTF_DEBUG_CONTROL_FORCE_ALL_HIT_value
    End Property

    Property Let write_CTF_DEBUG_CONTROL_FORCE_ALL_HIT(aData)
        set_CTF_DEBUG_CONTROL_FORCE_ALL_HIT = aData
        write
    End Property

    Property Get get_CTF_DEBUG_CONTROL_FORCE_ALL_MISS
        get_CTF_DEBUG_CONTROL_FORCE_ALL_MISS = read_CTF_DEBUG_CONTROL_FORCE_ALL_MISS_value
    End Property

    Property Let set_CTF_DEBUG_CONTROL_FORCE_ALL_MISS(aData)
        write_CTF_DEBUG_CONTROL_FORCE_ALL_MISS_value = aData
        flag_CTF_DEBUG_CONTROL_FORCE_ALL_MISS        = &H1
    End Property

    Property Get read_CTF_DEBUG_CONTROL_FORCE_ALL_MISS
        read
        read_CTF_DEBUG_CONTROL_FORCE_ALL_MISS = read_CTF_DEBUG_CONTROL_FORCE_ALL_MISS_value
    End Property

    Property Let write_CTF_DEBUG_CONTROL_FORCE_ALL_MISS(aData)
        set_CTF_DEBUG_CONTROL_FORCE_ALL_MISS = aData
        write
    End Property

    Property Get get_CTF_DEBUG_CONTROL_REG_DEBUG
        get_CTF_DEBUG_CONTROL_REG_DEBUG = read_CTF_DEBUG_CONTROL_REG_DEBUG_value
    End Property

    Property Let set_CTF_DEBUG_CONTROL_REG_DEBUG(aData)
        write_CTF_DEBUG_CONTROL_REG_DEBUG_value = aData
        flag_CTF_DEBUG_CONTROL_REG_DEBUG        = &H1
    End Property

    Property Get read_CTF_DEBUG_CONTROL_REG_DEBUG
        read
        read_CTF_DEBUG_CONTROL_REG_DEBUG = read_CTF_DEBUG_CONTROL_REG_DEBUG_value
    End Property

    Property Let write_CTF_DEBUG_CONTROL_REG_DEBUG(aData)
        set_CTF_DEBUG_CONTROL_REG_DEBUG = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CTF_DEBUG_CONTROL_RESERVED_value = rightShift(data_low, 7) and &H1ffffff
        read_CTF_DEBUG_CONTROL_OK_TO_SEND_CONFIG_value = rightShift(data_low, 3) and &Hf
        read_CTF_DEBUG_CONTROL_FORCE_ALL_HIT_value = rightShift(data_low, 2) and &H1
        read_CTF_DEBUG_CONTROL_FORCE_ALL_MISS_value = rightShift(data_low, 1) and &H1
        CTF_DEBUG_CONTROL_REG_DEBUG_mask = &H1
        if data_low > LONG_MAX then
            if CTF_DEBUG_CONTROL_REG_DEBUG_mask = mask then
                read_CTF_DEBUG_CONTROL_REG_DEBUG_value = data_low
            else
                read_CTF_DEBUG_CONTROL_REG_DEBUG_value = (data_low - H8000_0000) and CTF_DEBUG_CONTROL_REG_DEBUG_mask
            end If
        else
            read_CTF_DEBUG_CONTROL_REG_DEBUG_value = data_low and CTF_DEBUG_CONTROL_REG_DEBUG_mask
        end If

    End Sub

    Sub write
        If flag_CTF_DEBUG_CONTROL_RESERVED = &H0 or flag_CTF_DEBUG_CONTROL_OK_TO_SEND_CONFIG = &H0 or flag_CTF_DEBUG_CONTROL_FORCE_ALL_HIT = &H0 or flag_CTF_DEBUG_CONTROL_FORCE_ALL_MISS = &H0 or flag_CTF_DEBUG_CONTROL_REG_DEBUG = &H0 Then read
        If flag_CTF_DEBUG_CONTROL_RESERVED = &H0 Then write_CTF_DEBUG_CONTROL_RESERVED_value = get_CTF_DEBUG_CONTROL_RESERVED
        If flag_CTF_DEBUG_CONTROL_OK_TO_SEND_CONFIG = &H0 Then write_CTF_DEBUG_CONTROL_OK_TO_SEND_CONFIG_value = get_CTF_DEBUG_CONTROL_OK_TO_SEND_CONFIG
        If flag_CTF_DEBUG_CONTROL_FORCE_ALL_HIT = &H0 Then write_CTF_DEBUG_CONTROL_FORCE_ALL_HIT_value = get_CTF_DEBUG_CONTROL_FORCE_ALL_HIT
        If flag_CTF_DEBUG_CONTROL_FORCE_ALL_MISS = &H0 Then write_CTF_DEBUG_CONTROL_FORCE_ALL_MISS_value = get_CTF_DEBUG_CONTROL_FORCE_ALL_MISS
        If flag_CTF_DEBUG_CONTROL_REG_DEBUG = &H0 Then write_CTF_DEBUG_CONTROL_REG_DEBUG_value = get_CTF_DEBUG_CONTROL_REG_DEBUG

        regValue = leftShift((write_CTF_DEBUG_CONTROL_RESERVED_value and &H1ffffff), 7) + leftShift((write_CTF_DEBUG_CONTROL_OK_TO_SEND_CONFIG_value and &Hf), 3) + leftShift((write_CTF_DEBUG_CONTROL_FORCE_ALL_HIT_value and &H1), 2) + leftShift((write_CTF_DEBUG_CONTROL_FORCE_ALL_MISS_value and &H1), 1) + leftShift((write_CTF_DEBUG_CONTROL_REG_DEBUG_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CTF_DEBUG_CONTROL_RESERVED_value = rightShift(data_low, 7) and &H1ffffff
        read_CTF_DEBUG_CONTROL_OK_TO_SEND_CONFIG_value = rightShift(data_low, 3) and &Hf
        read_CTF_DEBUG_CONTROL_FORCE_ALL_HIT_value = rightShift(data_low, 2) and &H1
        read_CTF_DEBUG_CONTROL_FORCE_ALL_MISS_value = rightShift(data_low, 1) and &H1
        CTF_DEBUG_CONTROL_REG_DEBUG_mask = &H1
        if data_low > LONG_MAX then
            if CTF_DEBUG_CONTROL_REG_DEBUG_mask = mask then
                read_CTF_DEBUG_CONTROL_REG_DEBUG_value = data_low
            else
                read_CTF_DEBUG_CONTROL_REG_DEBUG_value = (data_low - H8000_0000) and CTF_DEBUG_CONTROL_REG_DEBUG_mask
            end If
        else
            read_CTF_DEBUG_CONTROL_REG_DEBUG_value = data_low and CTF_DEBUG_CONTROL_REG_DEBUG_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CTF_DEBUG_CONTROL_RESERVED_value = &H0
        flag_CTF_DEBUG_CONTROL_RESERVED        = &H0
        write_CTF_DEBUG_CONTROL_OK_TO_SEND_CONFIG_value = &H0
        flag_CTF_DEBUG_CONTROL_OK_TO_SEND_CONFIG        = &H0
        write_CTF_DEBUG_CONTROL_FORCE_ALL_HIT_value = &H0
        flag_CTF_DEBUG_CONTROL_FORCE_ALL_HIT        = &H0
        write_CTF_DEBUG_CONTROL_FORCE_ALL_MISS_value = &H0
        flag_CTF_DEBUG_CONTROL_FORCE_ALL_MISS        = &H0
        write_CTF_DEBUG_CONTROL_REG_DEBUG_value = &H0
        flag_CTF_DEBUG_CONTROL_REG_DEBUG        = &H0
    End Sub
End Class


'' @REGISTER : CTF_ctf_debug_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CTF_DEBUG_STATUS_RESERVED                  [31:1]           get_CTF_DEBUG_STATUS_RESERVED
''                                                             set_CTF_DEBUG_STATUS_RESERVED
''                                                             read_CTF_DEBUG_STATUS_RESERVED
''                                                             write_CTF_DEBUG_STATUS_RESERVED
''---------------------------------------------------------------------------------
'' CTF_DEBUG_STATUS_MEM_ACC_BUSY              [0:0]            get_CTF_DEBUG_STATUS_MEM_ACC_BUSY
''                                                             set_CTF_DEBUG_STATUS_MEM_ACC_BUSY
''                                                             read_CTF_DEBUG_STATUS_MEM_ACC_BUSY
''                                                             write_CTF_DEBUG_STATUS_MEM_ACC_BUSY
''---------------------------------------------------------------------------------
Class REGISTER_CTF_ctf_debug_status
    Private write_CTF_DEBUG_STATUS_RESERVED_value
    Private read_CTF_DEBUG_STATUS_RESERVED_value
    Private flag_CTF_DEBUG_STATUS_RESERVED
    Private write_CTF_DEBUG_STATUS_MEM_ACC_BUSY_value
    Private read_CTF_DEBUG_STATUS_MEM_ACC_BUSY_value
    Private flag_CTF_DEBUG_STATUS_MEM_ACC_BUSY

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H70
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_CTF_DEBUG_STATUS_RESERVED
        get_CTF_DEBUG_STATUS_RESERVED = read_CTF_DEBUG_STATUS_RESERVED_value
    End Property

    Property Let set_CTF_DEBUG_STATUS_RESERVED(aData)
        write_CTF_DEBUG_STATUS_RESERVED_value = aData
        flag_CTF_DEBUG_STATUS_RESERVED        = &H1
    End Property

    Property Get read_CTF_DEBUG_STATUS_RESERVED
        read
        read_CTF_DEBUG_STATUS_RESERVED = read_CTF_DEBUG_STATUS_RESERVED_value
    End Property

    Property Let write_CTF_DEBUG_STATUS_RESERVED(aData)
        set_CTF_DEBUG_STATUS_RESERVED = aData
        write
    End Property

    Property Get get_CTF_DEBUG_STATUS_MEM_ACC_BUSY
        get_CTF_DEBUG_STATUS_MEM_ACC_BUSY = read_CTF_DEBUG_STATUS_MEM_ACC_BUSY_value
    End Property

    Property Let set_CTF_DEBUG_STATUS_MEM_ACC_BUSY(aData)
        write_CTF_DEBUG_STATUS_MEM_ACC_BUSY_value = aData
        flag_CTF_DEBUG_STATUS_MEM_ACC_BUSY        = &H1
    End Property

    Property Get read_CTF_DEBUG_STATUS_MEM_ACC_BUSY
        read
        read_CTF_DEBUG_STATUS_MEM_ACC_BUSY = read_CTF_DEBUG_STATUS_MEM_ACC_BUSY_value
    End Property

    Property Let write_CTF_DEBUG_STATUS_MEM_ACC_BUSY(aData)
        set_CTF_DEBUG_STATUS_MEM_ACC_BUSY = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CTF_DEBUG_STATUS_RESERVED_value = rightShift(data_low, 1) and &H7fffffff
        CTF_DEBUG_STATUS_MEM_ACC_BUSY_mask = &H1
        if data_low > LONG_MAX then
            if CTF_DEBUG_STATUS_MEM_ACC_BUSY_mask = mask then
                read_CTF_DEBUG_STATUS_MEM_ACC_BUSY_value = data_low
            else
                read_CTF_DEBUG_STATUS_MEM_ACC_BUSY_value = (data_low - H8000_0000) and CTF_DEBUG_STATUS_MEM_ACC_BUSY_mask
            end If
        else
            read_CTF_DEBUG_STATUS_MEM_ACC_BUSY_value = data_low and CTF_DEBUG_STATUS_MEM_ACC_BUSY_mask
        end If

    End Sub

    Sub write
        If flag_CTF_DEBUG_STATUS_RESERVED = &H0 or flag_CTF_DEBUG_STATUS_MEM_ACC_BUSY = &H0 Then read
        If flag_CTF_DEBUG_STATUS_RESERVED = &H0 Then write_CTF_DEBUG_STATUS_RESERVED_value = get_CTF_DEBUG_STATUS_RESERVED
        If flag_CTF_DEBUG_STATUS_MEM_ACC_BUSY = &H0 Then write_CTF_DEBUG_STATUS_MEM_ACC_BUSY_value = get_CTF_DEBUG_STATUS_MEM_ACC_BUSY

        regValue = leftShift((write_CTF_DEBUG_STATUS_RESERVED_value and &H7fffffff), 1) + leftShift((write_CTF_DEBUG_STATUS_MEM_ACC_BUSY_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CTF_DEBUG_STATUS_RESERVED_value = rightShift(data_low, 1) and &H7fffffff
        CTF_DEBUG_STATUS_MEM_ACC_BUSY_mask = &H1
        if data_low > LONG_MAX then
            if CTF_DEBUG_STATUS_MEM_ACC_BUSY_mask = mask then
                read_CTF_DEBUG_STATUS_MEM_ACC_BUSY_value = data_low
            else
                read_CTF_DEBUG_STATUS_MEM_ACC_BUSY_value = (data_low - H8000_0000) and CTF_DEBUG_STATUS_MEM_ACC_BUSY_mask
            end If
        else
            read_CTF_DEBUG_STATUS_MEM_ACC_BUSY_value = data_low and CTF_DEBUG_STATUS_MEM_ACC_BUSY_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CTF_DEBUG_STATUS_RESERVED_value = &H0
        flag_CTF_DEBUG_STATUS_RESERVED        = &H0
        write_CTF_DEBUG_STATUS_MEM_ACC_BUSY_value = &H0
        flag_CTF_DEBUG_STATUS_MEM_ACC_BUSY        = &H0
    End Sub
End Class


'' @REGISTER : CTF_ctf_mem_debug
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CTF_MEM_DEBUG_RESERVED                     [31:31]          get_CTF_MEM_DEBUG_RESERVED
''                                                             set_CTF_MEM_DEBUG_RESERVED
''                                                             read_CTF_MEM_DEBUG_RESERVED
''                                                             write_CTF_MEM_DEBUG_RESERVED
''---------------------------------------------------------------------------------
'' CTF_MEM_DEBUG_HB_STBY                      [30:30]          get_CTF_MEM_DEBUG_HB_STBY
''                                                             set_CTF_MEM_DEBUG_HB_STBY
''                                                             read_CTF_MEM_DEBUG_HB_STBY
''                                                             write_CTF_MEM_DEBUG_HB_STBY
''---------------------------------------------------------------------------------
'' CTF_MEM_DEBUG_LAB_STBY                     [29:29]          get_CTF_MEM_DEBUG_LAB_STBY
''                                                             set_CTF_MEM_DEBUG_LAB_STBY
''                                                             read_CTF_MEM_DEBUG_LAB_STBY
''                                                             write_CTF_MEM_DEBUG_LAB_STBY
''---------------------------------------------------------------------------------
'' CTF_MEM_DEBUG_HB_PSM_VDD                   [28:27]          get_CTF_MEM_DEBUG_HB_PSM_VDD
''                                                             set_CTF_MEM_DEBUG_HB_PSM_VDD
''                                                             read_CTF_MEM_DEBUG_HB_PSM_VDD
''                                                             write_CTF_MEM_DEBUG_HB_PSM_VDD
''---------------------------------------------------------------------------------
'' CTF_MEM_DEBUG_LAB_PSM_VDD                  [26:25]          get_CTF_MEM_DEBUG_LAB_PSM_VDD
''                                                             set_CTF_MEM_DEBUG_LAB_PSM_VDD
''                                                             read_CTF_MEM_DEBUG_LAB_PSM_VDD
''                                                             write_CTF_MEM_DEBUG_LAB_PSM_VDD
''---------------------------------------------------------------------------------
'' CTF_MEM_DEBUG_HWQ_PSM_VDD                  [24:23]          get_CTF_MEM_DEBUG_HWQ_PSM_VDD
''                                                             set_CTF_MEM_DEBUG_HWQ_PSM_VDD
''                                                             read_CTF_MEM_DEBUG_HWQ_PSM_VDD
''                                                             write_CTF_MEM_DEBUG_HWQ_PSM_VDD
''---------------------------------------------------------------------------------
'' CTF_MEM_DEBUG_NEXT_HOP_PSM_VDD             [22:21]          get_CTF_MEM_DEBUG_NEXT_HOP_PSM_VDD
''                                                             set_CTF_MEM_DEBUG_NEXT_HOP_PSM_VDD
''                                                             read_CTF_MEM_DEBUG_NEXT_HOP_PSM_VDD
''                                                             write_CTF_MEM_DEBUG_NEXT_HOP_PSM_VDD
''---------------------------------------------------------------------------------
'' CTF_MEM_DEBUG_NAPT_FLOW_PSM_VDD            [20:19]          get_CTF_MEM_DEBUG_NAPT_FLOW_PSM_VDD
''                                                             set_CTF_MEM_DEBUG_NAPT_FLOW_PSM_VDD
''                                                             read_CTF_MEM_DEBUG_NAPT_FLOW_PSM_VDD
''                                                             write_CTF_MEM_DEBUG_NAPT_FLOW_PSM_VDD
''---------------------------------------------------------------------------------
'' CTF_MEM_DEBUG_HB_TM                        [18:17]          get_CTF_MEM_DEBUG_HB_TM
''                                                             set_CTF_MEM_DEBUG_HB_TM
''                                                             read_CTF_MEM_DEBUG_HB_TM
''                                                             write_CTF_MEM_DEBUG_HB_TM
''---------------------------------------------------------------------------------
'' CTF_MEM_DEBUG_LAB_TM                       [16:15]          get_CTF_MEM_DEBUG_LAB_TM
''                                                             set_CTF_MEM_DEBUG_LAB_TM
''                                                             read_CTF_MEM_DEBUG_LAB_TM
''                                                             write_CTF_MEM_DEBUG_LAB_TM
''---------------------------------------------------------------------------------
'' CTF_MEM_DEBUG_HWQ_TM                       [14:10]          get_CTF_MEM_DEBUG_HWQ_TM
''                                                             set_CTF_MEM_DEBUG_HWQ_TM
''                                                             read_CTF_MEM_DEBUG_HWQ_TM
''                                                             write_CTF_MEM_DEBUG_HWQ_TM
''---------------------------------------------------------------------------------
'' CTF_MEM_DEBUG_NEXT_HOP_TM                  [9:5]            get_CTF_MEM_DEBUG_NEXT_HOP_TM
''                                                             set_CTF_MEM_DEBUG_NEXT_HOP_TM
''                                                             read_CTF_MEM_DEBUG_NEXT_HOP_TM
''                                                             write_CTF_MEM_DEBUG_NEXT_HOP_TM
''---------------------------------------------------------------------------------
'' CTF_MEM_DEBUG_NAPT_FLOW_TM                 [4:0]            get_CTF_MEM_DEBUG_NAPT_FLOW_TM
''                                                             set_CTF_MEM_DEBUG_NAPT_FLOW_TM
''                                                             read_CTF_MEM_DEBUG_NAPT_FLOW_TM
''                                                             write_CTF_MEM_DEBUG_NAPT_FLOW_TM
''---------------------------------------------------------------------------------
Class REGISTER_CTF_ctf_mem_debug
    Private write_CTF_MEM_DEBUG_RESERVED_value
    Private read_CTF_MEM_DEBUG_RESERVED_value
    Private flag_CTF_MEM_DEBUG_RESERVED
    Private write_CTF_MEM_DEBUG_HB_STBY_value
    Private read_CTF_MEM_DEBUG_HB_STBY_value
    Private flag_CTF_MEM_DEBUG_HB_STBY
    Private write_CTF_MEM_DEBUG_LAB_STBY_value
    Private read_CTF_MEM_DEBUG_LAB_STBY_value
    Private flag_CTF_MEM_DEBUG_LAB_STBY
    Private write_CTF_MEM_DEBUG_HB_PSM_VDD_value
    Private read_CTF_MEM_DEBUG_HB_PSM_VDD_value
    Private flag_CTF_MEM_DEBUG_HB_PSM_VDD
    Private write_CTF_MEM_DEBUG_LAB_PSM_VDD_value
    Private read_CTF_MEM_DEBUG_LAB_PSM_VDD_value
    Private flag_CTF_MEM_DEBUG_LAB_PSM_VDD
    Private write_CTF_MEM_DEBUG_HWQ_PSM_VDD_value
    Private read_CTF_MEM_DEBUG_HWQ_PSM_VDD_value
    Private flag_CTF_MEM_DEBUG_HWQ_PSM_VDD
    Private write_CTF_MEM_DEBUG_NEXT_HOP_PSM_VDD_value
    Private read_CTF_MEM_DEBUG_NEXT_HOP_PSM_VDD_value
    Private flag_CTF_MEM_DEBUG_NEXT_HOP_PSM_VDD
    Private write_CTF_MEM_DEBUG_NAPT_FLOW_PSM_VDD_value
    Private read_CTF_MEM_DEBUG_NAPT_FLOW_PSM_VDD_value
    Private flag_CTF_MEM_DEBUG_NAPT_FLOW_PSM_VDD
    Private write_CTF_MEM_DEBUG_HB_TM_value
    Private read_CTF_MEM_DEBUG_HB_TM_value
    Private flag_CTF_MEM_DEBUG_HB_TM
    Private write_CTF_MEM_DEBUG_LAB_TM_value
    Private read_CTF_MEM_DEBUG_LAB_TM_value
    Private flag_CTF_MEM_DEBUG_LAB_TM
    Private write_CTF_MEM_DEBUG_HWQ_TM_value
    Private read_CTF_MEM_DEBUG_HWQ_TM_value
    Private flag_CTF_MEM_DEBUG_HWQ_TM
    Private write_CTF_MEM_DEBUG_NEXT_HOP_TM_value
    Private read_CTF_MEM_DEBUG_NEXT_HOP_TM_value
    Private flag_CTF_MEM_DEBUG_NEXT_HOP_TM
    Private write_CTF_MEM_DEBUG_NAPT_FLOW_TM_value
    Private read_CTF_MEM_DEBUG_NAPT_FLOW_TM_value
    Private flag_CTF_MEM_DEBUG_NAPT_FLOW_TM

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H74
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_CTF_MEM_DEBUG_RESERVED
        get_CTF_MEM_DEBUG_RESERVED = read_CTF_MEM_DEBUG_RESERVED_value
    End Property

    Property Let set_CTF_MEM_DEBUG_RESERVED(aData)
        write_CTF_MEM_DEBUG_RESERVED_value = aData
        flag_CTF_MEM_DEBUG_RESERVED        = &H1
    End Property

    Property Get read_CTF_MEM_DEBUG_RESERVED
        read
        read_CTF_MEM_DEBUG_RESERVED = read_CTF_MEM_DEBUG_RESERVED_value
    End Property

    Property Let write_CTF_MEM_DEBUG_RESERVED(aData)
        set_CTF_MEM_DEBUG_RESERVED = aData
        write
    End Property

    Property Get get_CTF_MEM_DEBUG_HB_STBY
        get_CTF_MEM_DEBUG_HB_STBY = read_CTF_MEM_DEBUG_HB_STBY_value
    End Property

    Property Let set_CTF_MEM_DEBUG_HB_STBY(aData)
        write_CTF_MEM_DEBUG_HB_STBY_value = aData
        flag_CTF_MEM_DEBUG_HB_STBY        = &H1
    End Property

    Property Get read_CTF_MEM_DEBUG_HB_STBY
        read
        read_CTF_MEM_DEBUG_HB_STBY = read_CTF_MEM_DEBUG_HB_STBY_value
    End Property

    Property Let write_CTF_MEM_DEBUG_HB_STBY(aData)
        set_CTF_MEM_DEBUG_HB_STBY = aData
        write
    End Property

    Property Get get_CTF_MEM_DEBUG_LAB_STBY
        get_CTF_MEM_DEBUG_LAB_STBY = read_CTF_MEM_DEBUG_LAB_STBY_value
    End Property

    Property Let set_CTF_MEM_DEBUG_LAB_STBY(aData)
        write_CTF_MEM_DEBUG_LAB_STBY_value = aData
        flag_CTF_MEM_DEBUG_LAB_STBY        = &H1
    End Property

    Property Get read_CTF_MEM_DEBUG_LAB_STBY
        read
        read_CTF_MEM_DEBUG_LAB_STBY = read_CTF_MEM_DEBUG_LAB_STBY_value
    End Property

    Property Let write_CTF_MEM_DEBUG_LAB_STBY(aData)
        set_CTF_MEM_DEBUG_LAB_STBY = aData
        write
    End Property

    Property Get get_CTF_MEM_DEBUG_HB_PSM_VDD
        get_CTF_MEM_DEBUG_HB_PSM_VDD = read_CTF_MEM_DEBUG_HB_PSM_VDD_value
    End Property

    Property Let set_CTF_MEM_DEBUG_HB_PSM_VDD(aData)
        write_CTF_MEM_DEBUG_HB_PSM_VDD_value = aData
        flag_CTF_MEM_DEBUG_HB_PSM_VDD        = &H1
    End Property

    Property Get read_CTF_MEM_DEBUG_HB_PSM_VDD
        read
        read_CTF_MEM_DEBUG_HB_PSM_VDD = read_CTF_MEM_DEBUG_HB_PSM_VDD_value
    End Property

    Property Let write_CTF_MEM_DEBUG_HB_PSM_VDD(aData)
        set_CTF_MEM_DEBUG_HB_PSM_VDD = aData
        write
    End Property

    Property Get get_CTF_MEM_DEBUG_LAB_PSM_VDD
        get_CTF_MEM_DEBUG_LAB_PSM_VDD = read_CTF_MEM_DEBUG_LAB_PSM_VDD_value
    End Property

    Property Let set_CTF_MEM_DEBUG_LAB_PSM_VDD(aData)
        write_CTF_MEM_DEBUG_LAB_PSM_VDD_value = aData
        flag_CTF_MEM_DEBUG_LAB_PSM_VDD        = &H1
    End Property

    Property Get read_CTF_MEM_DEBUG_LAB_PSM_VDD
        read
        read_CTF_MEM_DEBUG_LAB_PSM_VDD = read_CTF_MEM_DEBUG_LAB_PSM_VDD_value
    End Property

    Property Let write_CTF_MEM_DEBUG_LAB_PSM_VDD(aData)
        set_CTF_MEM_DEBUG_LAB_PSM_VDD = aData
        write
    End Property

    Property Get get_CTF_MEM_DEBUG_HWQ_PSM_VDD
        get_CTF_MEM_DEBUG_HWQ_PSM_VDD = read_CTF_MEM_DEBUG_HWQ_PSM_VDD_value
    End Property

    Property Let set_CTF_MEM_DEBUG_HWQ_PSM_VDD(aData)
        write_CTF_MEM_DEBUG_HWQ_PSM_VDD_value = aData
        flag_CTF_MEM_DEBUG_HWQ_PSM_VDD        = &H1
    End Property

    Property Get read_CTF_MEM_DEBUG_HWQ_PSM_VDD
        read
        read_CTF_MEM_DEBUG_HWQ_PSM_VDD = read_CTF_MEM_DEBUG_HWQ_PSM_VDD_value
    End Property

    Property Let write_CTF_MEM_DEBUG_HWQ_PSM_VDD(aData)
        set_CTF_MEM_DEBUG_HWQ_PSM_VDD = aData
        write
    End Property

    Property Get get_CTF_MEM_DEBUG_NEXT_HOP_PSM_VDD
        get_CTF_MEM_DEBUG_NEXT_HOP_PSM_VDD = read_CTF_MEM_DEBUG_NEXT_HOP_PSM_VDD_value
    End Property

    Property Let set_CTF_MEM_DEBUG_NEXT_HOP_PSM_VDD(aData)
        write_CTF_MEM_DEBUG_NEXT_HOP_PSM_VDD_value = aData
        flag_CTF_MEM_DEBUG_NEXT_HOP_PSM_VDD        = &H1
    End Property

    Property Get read_CTF_MEM_DEBUG_NEXT_HOP_PSM_VDD
        read
        read_CTF_MEM_DEBUG_NEXT_HOP_PSM_VDD = read_CTF_MEM_DEBUG_NEXT_HOP_PSM_VDD_value
    End Property

    Property Let write_CTF_MEM_DEBUG_NEXT_HOP_PSM_VDD(aData)
        set_CTF_MEM_DEBUG_NEXT_HOP_PSM_VDD = aData
        write
    End Property

    Property Get get_CTF_MEM_DEBUG_NAPT_FLOW_PSM_VDD
        get_CTF_MEM_DEBUG_NAPT_FLOW_PSM_VDD = read_CTF_MEM_DEBUG_NAPT_FLOW_PSM_VDD_value
    End Property

    Property Let set_CTF_MEM_DEBUG_NAPT_FLOW_PSM_VDD(aData)
        write_CTF_MEM_DEBUG_NAPT_FLOW_PSM_VDD_value = aData
        flag_CTF_MEM_DEBUG_NAPT_FLOW_PSM_VDD        = &H1
    End Property

    Property Get read_CTF_MEM_DEBUG_NAPT_FLOW_PSM_VDD
        read
        read_CTF_MEM_DEBUG_NAPT_FLOW_PSM_VDD = read_CTF_MEM_DEBUG_NAPT_FLOW_PSM_VDD_value
    End Property

    Property Let write_CTF_MEM_DEBUG_NAPT_FLOW_PSM_VDD(aData)
        set_CTF_MEM_DEBUG_NAPT_FLOW_PSM_VDD = aData
        write
    End Property

    Property Get get_CTF_MEM_DEBUG_HB_TM
        get_CTF_MEM_DEBUG_HB_TM = read_CTF_MEM_DEBUG_HB_TM_value
    End Property

    Property Let set_CTF_MEM_DEBUG_HB_TM(aData)
        write_CTF_MEM_DEBUG_HB_TM_value = aData
        flag_CTF_MEM_DEBUG_HB_TM        = &H1
    End Property

    Property Get read_CTF_MEM_DEBUG_HB_TM
        read
        read_CTF_MEM_DEBUG_HB_TM = read_CTF_MEM_DEBUG_HB_TM_value
    End Property

    Property Let write_CTF_MEM_DEBUG_HB_TM(aData)
        set_CTF_MEM_DEBUG_HB_TM = aData
        write
    End Property

    Property Get get_CTF_MEM_DEBUG_LAB_TM
        get_CTF_MEM_DEBUG_LAB_TM = read_CTF_MEM_DEBUG_LAB_TM_value
    End Property

    Property Let set_CTF_MEM_DEBUG_LAB_TM(aData)
        write_CTF_MEM_DEBUG_LAB_TM_value = aData
        flag_CTF_MEM_DEBUG_LAB_TM        = &H1
    End Property

    Property Get read_CTF_MEM_DEBUG_LAB_TM
        read
        read_CTF_MEM_DEBUG_LAB_TM = read_CTF_MEM_DEBUG_LAB_TM_value
    End Property

    Property Let write_CTF_MEM_DEBUG_LAB_TM(aData)
        set_CTF_MEM_DEBUG_LAB_TM = aData
        write
    End Property

    Property Get get_CTF_MEM_DEBUG_HWQ_TM
        get_CTF_MEM_DEBUG_HWQ_TM = read_CTF_MEM_DEBUG_HWQ_TM_value
    End Property

    Property Let set_CTF_MEM_DEBUG_HWQ_TM(aData)
        write_CTF_MEM_DEBUG_HWQ_TM_value = aData
        flag_CTF_MEM_DEBUG_HWQ_TM        = &H1
    End Property

    Property Get read_CTF_MEM_DEBUG_HWQ_TM
        read
        read_CTF_MEM_DEBUG_HWQ_TM = read_CTF_MEM_DEBUG_HWQ_TM_value
    End Property

    Property Let write_CTF_MEM_DEBUG_HWQ_TM(aData)
        set_CTF_MEM_DEBUG_HWQ_TM = aData
        write
    End Property

    Property Get get_CTF_MEM_DEBUG_NEXT_HOP_TM
        get_CTF_MEM_DEBUG_NEXT_HOP_TM = read_CTF_MEM_DEBUG_NEXT_HOP_TM_value
    End Property

    Property Let set_CTF_MEM_DEBUG_NEXT_HOP_TM(aData)
        write_CTF_MEM_DEBUG_NEXT_HOP_TM_value = aData
        flag_CTF_MEM_DEBUG_NEXT_HOP_TM        = &H1
    End Property

    Property Get read_CTF_MEM_DEBUG_NEXT_HOP_TM
        read
        read_CTF_MEM_DEBUG_NEXT_HOP_TM = read_CTF_MEM_DEBUG_NEXT_HOP_TM_value
    End Property

    Property Let write_CTF_MEM_DEBUG_NEXT_HOP_TM(aData)
        set_CTF_MEM_DEBUG_NEXT_HOP_TM = aData
        write
    End Property

    Property Get get_CTF_MEM_DEBUG_NAPT_FLOW_TM
        get_CTF_MEM_DEBUG_NAPT_FLOW_TM = read_CTF_MEM_DEBUG_NAPT_FLOW_TM_value
    End Property

    Property Let set_CTF_MEM_DEBUG_NAPT_FLOW_TM(aData)
        write_CTF_MEM_DEBUG_NAPT_FLOW_TM_value = aData
        flag_CTF_MEM_DEBUG_NAPT_FLOW_TM        = &H1
    End Property

    Property Get read_CTF_MEM_DEBUG_NAPT_FLOW_TM
        read
        read_CTF_MEM_DEBUG_NAPT_FLOW_TM = read_CTF_MEM_DEBUG_NAPT_FLOW_TM_value
    End Property

    Property Let write_CTF_MEM_DEBUG_NAPT_FLOW_TM(aData)
        set_CTF_MEM_DEBUG_NAPT_FLOW_TM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CTF_MEM_DEBUG_RESERVED_value = rightShift(data_low, 31) and &H1
        read_CTF_MEM_DEBUG_HB_STBY_value = rightShift(data_low, 30) and &H1
        read_CTF_MEM_DEBUG_LAB_STBY_value = rightShift(data_low, 29) and &H1
        read_CTF_MEM_DEBUG_HB_PSM_VDD_value = rightShift(data_low, 27) and &H3
        read_CTF_MEM_DEBUG_LAB_PSM_VDD_value = rightShift(data_low, 25) and &H3
        read_CTF_MEM_DEBUG_HWQ_PSM_VDD_value = rightShift(data_low, 23) and &H3
        read_CTF_MEM_DEBUG_NEXT_HOP_PSM_VDD_value = rightShift(data_low, 21) and &H3
        read_CTF_MEM_DEBUG_NAPT_FLOW_PSM_VDD_value = rightShift(data_low, 19) and &H3
        read_CTF_MEM_DEBUG_HB_TM_value = rightShift(data_low, 17) and &H3
        read_CTF_MEM_DEBUG_LAB_TM_value = rightShift(data_low, 15) and &H3
        read_CTF_MEM_DEBUG_HWQ_TM_value = rightShift(data_low, 10) and &H1f
        read_CTF_MEM_DEBUG_NEXT_HOP_TM_value = rightShift(data_low, 5) and &H1f
        CTF_MEM_DEBUG_NAPT_FLOW_TM_mask = &H1f
        if data_low > LONG_MAX then
            if CTF_MEM_DEBUG_NAPT_FLOW_TM_mask = mask then
                read_CTF_MEM_DEBUG_NAPT_FLOW_TM_value = data_low
            else
                read_CTF_MEM_DEBUG_NAPT_FLOW_TM_value = (data_low - H8000_0000) and CTF_MEM_DEBUG_NAPT_FLOW_TM_mask
            end If
        else
            read_CTF_MEM_DEBUG_NAPT_FLOW_TM_value = data_low and CTF_MEM_DEBUG_NAPT_FLOW_TM_mask
        end If

    End Sub

    Sub write
        If flag_CTF_MEM_DEBUG_RESERVED = &H0 or flag_CTF_MEM_DEBUG_HB_STBY = &H0 or flag_CTF_MEM_DEBUG_LAB_STBY = &H0 or flag_CTF_MEM_DEBUG_HB_PSM_VDD = &H0 or flag_CTF_MEM_DEBUG_LAB_PSM_VDD = &H0 or flag_CTF_MEM_DEBUG_HWQ_PSM_VDD = &H0 or flag_CTF_MEM_DEBUG_NEXT_HOP_PSM_VDD = &H0 or flag_CTF_MEM_DEBUG_NAPT_FLOW_PSM_VDD = &H0 or flag_CTF_MEM_DEBUG_HB_TM = &H0 or flag_CTF_MEM_DEBUG_LAB_TM = &H0 or flag_CTF_MEM_DEBUG_HWQ_TM = &H0 or flag_CTF_MEM_DEBUG_NEXT_HOP_TM = &H0 or flag_CTF_MEM_DEBUG_NAPT_FLOW_TM = &H0 Then read
        If flag_CTF_MEM_DEBUG_RESERVED = &H0 Then write_CTF_MEM_DEBUG_RESERVED_value = get_CTF_MEM_DEBUG_RESERVED
        If flag_CTF_MEM_DEBUG_HB_STBY = &H0 Then write_CTF_MEM_DEBUG_HB_STBY_value = get_CTF_MEM_DEBUG_HB_STBY
        If flag_CTF_MEM_DEBUG_LAB_STBY = &H0 Then write_CTF_MEM_DEBUG_LAB_STBY_value = get_CTF_MEM_DEBUG_LAB_STBY
        If flag_CTF_MEM_DEBUG_HB_PSM_VDD = &H0 Then write_CTF_MEM_DEBUG_HB_PSM_VDD_value = get_CTF_MEM_DEBUG_HB_PSM_VDD
        If flag_CTF_MEM_DEBUG_LAB_PSM_VDD = &H0 Then write_CTF_MEM_DEBUG_LAB_PSM_VDD_value = get_CTF_MEM_DEBUG_LAB_PSM_VDD
        If flag_CTF_MEM_DEBUG_HWQ_PSM_VDD = &H0 Then write_CTF_MEM_DEBUG_HWQ_PSM_VDD_value = get_CTF_MEM_DEBUG_HWQ_PSM_VDD
        If flag_CTF_MEM_DEBUG_NEXT_HOP_PSM_VDD = &H0 Then write_CTF_MEM_DEBUG_NEXT_HOP_PSM_VDD_value = get_CTF_MEM_DEBUG_NEXT_HOP_PSM_VDD
        If flag_CTF_MEM_DEBUG_NAPT_FLOW_PSM_VDD = &H0 Then write_CTF_MEM_DEBUG_NAPT_FLOW_PSM_VDD_value = get_CTF_MEM_DEBUG_NAPT_FLOW_PSM_VDD
        If flag_CTF_MEM_DEBUG_HB_TM = &H0 Then write_CTF_MEM_DEBUG_HB_TM_value = get_CTF_MEM_DEBUG_HB_TM
        If flag_CTF_MEM_DEBUG_LAB_TM = &H0 Then write_CTF_MEM_DEBUG_LAB_TM_value = get_CTF_MEM_DEBUG_LAB_TM
        If flag_CTF_MEM_DEBUG_HWQ_TM = &H0 Then write_CTF_MEM_DEBUG_HWQ_TM_value = get_CTF_MEM_DEBUG_HWQ_TM
        If flag_CTF_MEM_DEBUG_NEXT_HOP_TM = &H0 Then write_CTF_MEM_DEBUG_NEXT_HOP_TM_value = get_CTF_MEM_DEBUG_NEXT_HOP_TM
        If flag_CTF_MEM_DEBUG_NAPT_FLOW_TM = &H0 Then write_CTF_MEM_DEBUG_NAPT_FLOW_TM_value = get_CTF_MEM_DEBUG_NAPT_FLOW_TM

        regValue = leftShift((write_CTF_MEM_DEBUG_RESERVED_value and &H1), 31) + leftShift((write_CTF_MEM_DEBUG_HB_STBY_value and &H1), 30) + leftShift((write_CTF_MEM_DEBUG_LAB_STBY_value and &H1), 29) + leftShift((write_CTF_MEM_DEBUG_HB_PSM_VDD_value and &H3), 27) + leftShift((write_CTF_MEM_DEBUG_LAB_PSM_VDD_value and &H3), 25) + leftShift((write_CTF_MEM_DEBUG_HWQ_PSM_VDD_value and &H3), 23) + leftShift((write_CTF_MEM_DEBUG_NEXT_HOP_PSM_VDD_value and &H3), 21) + leftShift((write_CTF_MEM_DEBUG_NAPT_FLOW_PSM_VDD_value and &H3), 19) + leftShift((write_CTF_MEM_DEBUG_HB_TM_value and &H3), 17) + leftShift((write_CTF_MEM_DEBUG_LAB_TM_value and &H3), 15) + leftShift((write_CTF_MEM_DEBUG_HWQ_TM_value and &H1f), 10) + leftShift((write_CTF_MEM_DEBUG_NEXT_HOP_TM_value and &H1f), 5) + leftShift((write_CTF_MEM_DEBUG_NAPT_FLOW_TM_value and &H1f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CTF_MEM_DEBUG_RESERVED_value = rightShift(data_low, 31) and &H1
        read_CTF_MEM_DEBUG_HB_STBY_value = rightShift(data_low, 30) and &H1
        read_CTF_MEM_DEBUG_LAB_STBY_value = rightShift(data_low, 29) and &H1
        read_CTF_MEM_DEBUG_HB_PSM_VDD_value = rightShift(data_low, 27) and &H3
        read_CTF_MEM_DEBUG_LAB_PSM_VDD_value = rightShift(data_low, 25) and &H3
        read_CTF_MEM_DEBUG_HWQ_PSM_VDD_value = rightShift(data_low, 23) and &H3
        read_CTF_MEM_DEBUG_NEXT_HOP_PSM_VDD_value = rightShift(data_low, 21) and &H3
        read_CTF_MEM_DEBUG_NAPT_FLOW_PSM_VDD_value = rightShift(data_low, 19) and &H3
        read_CTF_MEM_DEBUG_HB_TM_value = rightShift(data_low, 17) and &H3
        read_CTF_MEM_DEBUG_LAB_TM_value = rightShift(data_low, 15) and &H3
        read_CTF_MEM_DEBUG_HWQ_TM_value = rightShift(data_low, 10) and &H1f
        read_CTF_MEM_DEBUG_NEXT_HOP_TM_value = rightShift(data_low, 5) and &H1f
        CTF_MEM_DEBUG_NAPT_FLOW_TM_mask = &H1f
        if data_low > LONG_MAX then
            if CTF_MEM_DEBUG_NAPT_FLOW_TM_mask = mask then
                read_CTF_MEM_DEBUG_NAPT_FLOW_TM_value = data_low
            else
                read_CTF_MEM_DEBUG_NAPT_FLOW_TM_value = (data_low - H8000_0000) and CTF_MEM_DEBUG_NAPT_FLOW_TM_mask
            end If
        else
            read_CTF_MEM_DEBUG_NAPT_FLOW_TM_value = data_low and CTF_MEM_DEBUG_NAPT_FLOW_TM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CTF_MEM_DEBUG_RESERVED_value = &H0
        flag_CTF_MEM_DEBUG_RESERVED        = &H0
        write_CTF_MEM_DEBUG_HB_STBY_value = &H0
        flag_CTF_MEM_DEBUG_HB_STBY        = &H0
        write_CTF_MEM_DEBUG_LAB_STBY_value = &H0
        flag_CTF_MEM_DEBUG_LAB_STBY        = &H0
        write_CTF_MEM_DEBUG_HB_PSM_VDD_value = &H0
        flag_CTF_MEM_DEBUG_HB_PSM_VDD        = &H0
        write_CTF_MEM_DEBUG_LAB_PSM_VDD_value = &H0
        flag_CTF_MEM_DEBUG_LAB_PSM_VDD        = &H0
        write_CTF_MEM_DEBUG_HWQ_PSM_VDD_value = &H0
        flag_CTF_MEM_DEBUG_HWQ_PSM_VDD        = &H0
        write_CTF_MEM_DEBUG_NEXT_HOP_PSM_VDD_value = &H0
        flag_CTF_MEM_DEBUG_NEXT_HOP_PSM_VDD        = &H0
        write_CTF_MEM_DEBUG_NAPT_FLOW_PSM_VDD_value = &H0
        flag_CTF_MEM_DEBUG_NAPT_FLOW_PSM_VDD        = &H0
        write_CTF_MEM_DEBUG_HB_TM_value = &H0
        flag_CTF_MEM_DEBUG_HB_TM        = &H0
        write_CTF_MEM_DEBUG_LAB_TM_value = &H0
        flag_CTF_MEM_DEBUG_LAB_TM        = &H0
        write_CTF_MEM_DEBUG_HWQ_TM_value = &H0
        flag_CTF_MEM_DEBUG_HWQ_TM        = &H0
        write_CTF_MEM_DEBUG_NEXT_HOP_TM_value = &H0
        flag_CTF_MEM_DEBUG_NEXT_HOP_TM        = &H0
        write_CTF_MEM_DEBUG_NAPT_FLOW_TM_value = &H0
        flag_CTF_MEM_DEBUG_NAPT_FLOW_TM        = &H0
    End Sub
End Class


'' @REGISTER : CTF_ctf_ecc_debug
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CTF_ECC_DEBUG_RESERVED                     [31:18]          get_CTF_ECC_DEBUG_RESERVED
''                                                             set_CTF_ECC_DEBUG_RESERVED
''                                                             read_CTF_ECC_DEBUG_RESERVED
''                                                             write_CTF_ECC_DEBUG_RESERVED
''---------------------------------------------------------------------------------
'' CTF_ECC_DEBUG_HB_DISABLE_ECC               [17:17]          get_CTF_ECC_DEBUG_HB_DISABLE_ECC
''                                                             set_CTF_ECC_DEBUG_HB_DISABLE_ECC
''                                                             read_CTF_ECC_DEBUG_HB_DISABLE_ECC
''                                                             write_CTF_ECC_DEBUG_HB_DISABLE_ECC
''---------------------------------------------------------------------------------
'' CTF_ECC_DEBUG_HB_ECC_CORRUPT               [16:15]          get_CTF_ECC_DEBUG_HB_ECC_CORRUPT
''                                                             set_CTF_ECC_DEBUG_HB_ECC_CORRUPT
''                                                             read_CTF_ECC_DEBUG_HB_ECC_CORRUPT
''                                                             write_CTF_ECC_DEBUG_HB_ECC_CORRUPT
''---------------------------------------------------------------------------------
'' CTF_ECC_DEBUG_LAB_DISABLE_ECC              [14:14]          get_CTF_ECC_DEBUG_LAB_DISABLE_ECC
''                                                             set_CTF_ECC_DEBUG_LAB_DISABLE_ECC
''                                                             read_CTF_ECC_DEBUG_LAB_DISABLE_ECC
''                                                             write_CTF_ECC_DEBUG_LAB_DISABLE_ECC
''---------------------------------------------------------------------------------
'' CTF_ECC_DEBUG_LAB_ECC_CORRUPT              [13:12]          get_CTF_ECC_DEBUG_LAB_ECC_CORRUPT
''                                                             set_CTF_ECC_DEBUG_LAB_ECC_CORRUPT
''                                                             read_CTF_ECC_DEBUG_LAB_ECC_CORRUPT
''                                                             write_CTF_ECC_DEBUG_LAB_ECC_CORRUPT
''---------------------------------------------------------------------------------
'' CTF_ECC_DEBUG_HWQ_1_DISABLE_ECC            [11:11]          get_CTF_ECC_DEBUG_HWQ_1_DISABLE_ECC
''                                                             set_CTF_ECC_DEBUG_HWQ_1_DISABLE_ECC
''                                                             read_CTF_ECC_DEBUG_HWQ_1_DISABLE_ECC
''                                                             write_CTF_ECC_DEBUG_HWQ_1_DISABLE_ECC
''---------------------------------------------------------------------------------
'' CTF_ECC_DEBUG_HWQ_1_ECC_CORRUPT            [10:9]           get_CTF_ECC_DEBUG_HWQ_1_ECC_CORRUPT
''                                                             set_CTF_ECC_DEBUG_HWQ_1_ECC_CORRUPT
''                                                             read_CTF_ECC_DEBUG_HWQ_1_ECC_CORRUPT
''                                                             write_CTF_ECC_DEBUG_HWQ_1_ECC_CORRUPT
''---------------------------------------------------------------------------------
'' CTF_ECC_DEBUG_HWQ_0_DISABLE_ECC            [8:8]            get_CTF_ECC_DEBUG_HWQ_0_DISABLE_ECC
''                                                             set_CTF_ECC_DEBUG_HWQ_0_DISABLE_ECC
''                                                             read_CTF_ECC_DEBUG_HWQ_0_DISABLE_ECC
''                                                             write_CTF_ECC_DEBUG_HWQ_0_DISABLE_ECC
''---------------------------------------------------------------------------------
'' CTF_ECC_DEBUG_HWQ_0_ECC_CORRUPT            [7:6]            get_CTF_ECC_DEBUG_HWQ_0_ECC_CORRUPT
''                                                             set_CTF_ECC_DEBUG_HWQ_0_ECC_CORRUPT
''                                                             read_CTF_ECC_DEBUG_HWQ_0_ECC_CORRUPT
''                                                             write_CTF_ECC_DEBUG_HWQ_0_ECC_CORRUPT
''---------------------------------------------------------------------------------
'' CTF_ECC_DEBUG_NEXT_HOP_DISABLE_ECC         [5:5]            get_CTF_ECC_DEBUG_NEXT_HOP_DISABLE_ECC
''                                                             set_CTF_ECC_DEBUG_NEXT_HOP_DISABLE_ECC
''                                                             read_CTF_ECC_DEBUG_NEXT_HOP_DISABLE_ECC
''                                                             write_CTF_ECC_DEBUG_NEXT_HOP_DISABLE_ECC
''---------------------------------------------------------------------------------
'' CTF_ECC_DEBUG_NEXT_HOP_ECC_CORRUPT         [4:3]            get_CTF_ECC_DEBUG_NEXT_HOP_ECC_CORRUPT
''                                                             set_CTF_ECC_DEBUG_NEXT_HOP_ECC_CORRUPT
''                                                             read_CTF_ECC_DEBUG_NEXT_HOP_ECC_CORRUPT
''                                                             write_CTF_ECC_DEBUG_NEXT_HOP_ECC_CORRUPT
''---------------------------------------------------------------------------------
'' CTF_ECC_DEBUG_NAPT_FLOW_DISABLE_ECC        [2:2]            get_CTF_ECC_DEBUG_NAPT_FLOW_DISABLE_ECC
''                                                             set_CTF_ECC_DEBUG_NAPT_FLOW_DISABLE_ECC
''                                                             read_CTF_ECC_DEBUG_NAPT_FLOW_DISABLE_ECC
''                                                             write_CTF_ECC_DEBUG_NAPT_FLOW_DISABLE_ECC
''---------------------------------------------------------------------------------
'' CTF_ECC_DEBUG_NAPT_FLOW_ECC_CORRUPT        [1:0]            get_CTF_ECC_DEBUG_NAPT_FLOW_ECC_CORRUPT
''                                                             set_CTF_ECC_DEBUG_NAPT_FLOW_ECC_CORRUPT
''                                                             read_CTF_ECC_DEBUG_NAPT_FLOW_ECC_CORRUPT
''                                                             write_CTF_ECC_DEBUG_NAPT_FLOW_ECC_CORRUPT
''---------------------------------------------------------------------------------
Class REGISTER_CTF_ctf_ecc_debug
    Private write_CTF_ECC_DEBUG_RESERVED_value
    Private read_CTF_ECC_DEBUG_RESERVED_value
    Private flag_CTF_ECC_DEBUG_RESERVED
    Private write_CTF_ECC_DEBUG_HB_DISABLE_ECC_value
    Private read_CTF_ECC_DEBUG_HB_DISABLE_ECC_value
    Private flag_CTF_ECC_DEBUG_HB_DISABLE_ECC
    Private write_CTF_ECC_DEBUG_HB_ECC_CORRUPT_value
    Private read_CTF_ECC_DEBUG_HB_ECC_CORRUPT_value
    Private flag_CTF_ECC_DEBUG_HB_ECC_CORRUPT
    Private write_CTF_ECC_DEBUG_LAB_DISABLE_ECC_value
    Private read_CTF_ECC_DEBUG_LAB_DISABLE_ECC_value
    Private flag_CTF_ECC_DEBUG_LAB_DISABLE_ECC
    Private write_CTF_ECC_DEBUG_LAB_ECC_CORRUPT_value
    Private read_CTF_ECC_DEBUG_LAB_ECC_CORRUPT_value
    Private flag_CTF_ECC_DEBUG_LAB_ECC_CORRUPT
    Private write_CTF_ECC_DEBUG_HWQ_1_DISABLE_ECC_value
    Private read_CTF_ECC_DEBUG_HWQ_1_DISABLE_ECC_value
    Private flag_CTF_ECC_DEBUG_HWQ_1_DISABLE_ECC
    Private write_CTF_ECC_DEBUG_HWQ_1_ECC_CORRUPT_value
    Private read_CTF_ECC_DEBUG_HWQ_1_ECC_CORRUPT_value
    Private flag_CTF_ECC_DEBUG_HWQ_1_ECC_CORRUPT
    Private write_CTF_ECC_DEBUG_HWQ_0_DISABLE_ECC_value
    Private read_CTF_ECC_DEBUG_HWQ_0_DISABLE_ECC_value
    Private flag_CTF_ECC_DEBUG_HWQ_0_DISABLE_ECC
    Private write_CTF_ECC_DEBUG_HWQ_0_ECC_CORRUPT_value
    Private read_CTF_ECC_DEBUG_HWQ_0_ECC_CORRUPT_value
    Private flag_CTF_ECC_DEBUG_HWQ_0_ECC_CORRUPT
    Private write_CTF_ECC_DEBUG_NEXT_HOP_DISABLE_ECC_value
    Private read_CTF_ECC_DEBUG_NEXT_HOP_DISABLE_ECC_value
    Private flag_CTF_ECC_DEBUG_NEXT_HOP_DISABLE_ECC
    Private write_CTF_ECC_DEBUG_NEXT_HOP_ECC_CORRUPT_value
    Private read_CTF_ECC_DEBUG_NEXT_HOP_ECC_CORRUPT_value
    Private flag_CTF_ECC_DEBUG_NEXT_HOP_ECC_CORRUPT
    Private write_CTF_ECC_DEBUG_NAPT_FLOW_DISABLE_ECC_value
    Private read_CTF_ECC_DEBUG_NAPT_FLOW_DISABLE_ECC_value
    Private flag_CTF_ECC_DEBUG_NAPT_FLOW_DISABLE_ECC
    Private write_CTF_ECC_DEBUG_NAPT_FLOW_ECC_CORRUPT_value
    Private read_CTF_ECC_DEBUG_NAPT_FLOW_ECC_CORRUPT_value
    Private flag_CTF_ECC_DEBUG_NAPT_FLOW_ECC_CORRUPT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H78
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_CTF_ECC_DEBUG_RESERVED
        get_CTF_ECC_DEBUG_RESERVED = read_CTF_ECC_DEBUG_RESERVED_value
    End Property

    Property Let set_CTF_ECC_DEBUG_RESERVED(aData)
        write_CTF_ECC_DEBUG_RESERVED_value = aData
        flag_CTF_ECC_DEBUG_RESERVED        = &H1
    End Property

    Property Get read_CTF_ECC_DEBUG_RESERVED
        read
        read_CTF_ECC_DEBUG_RESERVED = read_CTF_ECC_DEBUG_RESERVED_value
    End Property

    Property Let write_CTF_ECC_DEBUG_RESERVED(aData)
        set_CTF_ECC_DEBUG_RESERVED = aData
        write
    End Property

    Property Get get_CTF_ECC_DEBUG_HB_DISABLE_ECC
        get_CTF_ECC_DEBUG_HB_DISABLE_ECC = read_CTF_ECC_DEBUG_HB_DISABLE_ECC_value
    End Property

    Property Let set_CTF_ECC_DEBUG_HB_DISABLE_ECC(aData)
        write_CTF_ECC_DEBUG_HB_DISABLE_ECC_value = aData
        flag_CTF_ECC_DEBUG_HB_DISABLE_ECC        = &H1
    End Property

    Property Get read_CTF_ECC_DEBUG_HB_DISABLE_ECC
        read
        read_CTF_ECC_DEBUG_HB_DISABLE_ECC = read_CTF_ECC_DEBUG_HB_DISABLE_ECC_value
    End Property

    Property Let write_CTF_ECC_DEBUG_HB_DISABLE_ECC(aData)
        set_CTF_ECC_DEBUG_HB_DISABLE_ECC = aData
        write
    End Property

    Property Get get_CTF_ECC_DEBUG_HB_ECC_CORRUPT
        get_CTF_ECC_DEBUG_HB_ECC_CORRUPT = read_CTF_ECC_DEBUG_HB_ECC_CORRUPT_value
    End Property

    Property Let set_CTF_ECC_DEBUG_HB_ECC_CORRUPT(aData)
        write_CTF_ECC_DEBUG_HB_ECC_CORRUPT_value = aData
        flag_CTF_ECC_DEBUG_HB_ECC_CORRUPT        = &H1
    End Property

    Property Get read_CTF_ECC_DEBUG_HB_ECC_CORRUPT
        read
        read_CTF_ECC_DEBUG_HB_ECC_CORRUPT = read_CTF_ECC_DEBUG_HB_ECC_CORRUPT_value
    End Property

    Property Let write_CTF_ECC_DEBUG_HB_ECC_CORRUPT(aData)
        set_CTF_ECC_DEBUG_HB_ECC_CORRUPT = aData
        write
    End Property

    Property Get get_CTF_ECC_DEBUG_LAB_DISABLE_ECC
        get_CTF_ECC_DEBUG_LAB_DISABLE_ECC = read_CTF_ECC_DEBUG_LAB_DISABLE_ECC_value
    End Property

    Property Let set_CTF_ECC_DEBUG_LAB_DISABLE_ECC(aData)
        write_CTF_ECC_DEBUG_LAB_DISABLE_ECC_value = aData
        flag_CTF_ECC_DEBUG_LAB_DISABLE_ECC        = &H1
    End Property

    Property Get read_CTF_ECC_DEBUG_LAB_DISABLE_ECC
        read
        read_CTF_ECC_DEBUG_LAB_DISABLE_ECC = read_CTF_ECC_DEBUG_LAB_DISABLE_ECC_value
    End Property

    Property Let write_CTF_ECC_DEBUG_LAB_DISABLE_ECC(aData)
        set_CTF_ECC_DEBUG_LAB_DISABLE_ECC = aData
        write
    End Property

    Property Get get_CTF_ECC_DEBUG_LAB_ECC_CORRUPT
        get_CTF_ECC_DEBUG_LAB_ECC_CORRUPT = read_CTF_ECC_DEBUG_LAB_ECC_CORRUPT_value
    End Property

    Property Let set_CTF_ECC_DEBUG_LAB_ECC_CORRUPT(aData)
        write_CTF_ECC_DEBUG_LAB_ECC_CORRUPT_value = aData
        flag_CTF_ECC_DEBUG_LAB_ECC_CORRUPT        = &H1
    End Property

    Property Get read_CTF_ECC_DEBUG_LAB_ECC_CORRUPT
        read
        read_CTF_ECC_DEBUG_LAB_ECC_CORRUPT = read_CTF_ECC_DEBUG_LAB_ECC_CORRUPT_value
    End Property

    Property Let write_CTF_ECC_DEBUG_LAB_ECC_CORRUPT(aData)
        set_CTF_ECC_DEBUG_LAB_ECC_CORRUPT = aData
        write
    End Property

    Property Get get_CTF_ECC_DEBUG_HWQ_1_DISABLE_ECC
        get_CTF_ECC_DEBUG_HWQ_1_DISABLE_ECC = read_CTF_ECC_DEBUG_HWQ_1_DISABLE_ECC_value
    End Property

    Property Let set_CTF_ECC_DEBUG_HWQ_1_DISABLE_ECC(aData)
        write_CTF_ECC_DEBUG_HWQ_1_DISABLE_ECC_value = aData
        flag_CTF_ECC_DEBUG_HWQ_1_DISABLE_ECC        = &H1
    End Property

    Property Get read_CTF_ECC_DEBUG_HWQ_1_DISABLE_ECC
        read
        read_CTF_ECC_DEBUG_HWQ_1_DISABLE_ECC = read_CTF_ECC_DEBUG_HWQ_1_DISABLE_ECC_value
    End Property

    Property Let write_CTF_ECC_DEBUG_HWQ_1_DISABLE_ECC(aData)
        set_CTF_ECC_DEBUG_HWQ_1_DISABLE_ECC = aData
        write
    End Property

    Property Get get_CTF_ECC_DEBUG_HWQ_1_ECC_CORRUPT
        get_CTF_ECC_DEBUG_HWQ_1_ECC_CORRUPT = read_CTF_ECC_DEBUG_HWQ_1_ECC_CORRUPT_value
    End Property

    Property Let set_CTF_ECC_DEBUG_HWQ_1_ECC_CORRUPT(aData)
        write_CTF_ECC_DEBUG_HWQ_1_ECC_CORRUPT_value = aData
        flag_CTF_ECC_DEBUG_HWQ_1_ECC_CORRUPT        = &H1
    End Property

    Property Get read_CTF_ECC_DEBUG_HWQ_1_ECC_CORRUPT
        read
        read_CTF_ECC_DEBUG_HWQ_1_ECC_CORRUPT = read_CTF_ECC_DEBUG_HWQ_1_ECC_CORRUPT_value
    End Property

    Property Let write_CTF_ECC_DEBUG_HWQ_1_ECC_CORRUPT(aData)
        set_CTF_ECC_DEBUG_HWQ_1_ECC_CORRUPT = aData
        write
    End Property

    Property Get get_CTF_ECC_DEBUG_HWQ_0_DISABLE_ECC
        get_CTF_ECC_DEBUG_HWQ_0_DISABLE_ECC = read_CTF_ECC_DEBUG_HWQ_0_DISABLE_ECC_value
    End Property

    Property Let set_CTF_ECC_DEBUG_HWQ_0_DISABLE_ECC(aData)
        write_CTF_ECC_DEBUG_HWQ_0_DISABLE_ECC_value = aData
        flag_CTF_ECC_DEBUG_HWQ_0_DISABLE_ECC        = &H1
    End Property

    Property Get read_CTF_ECC_DEBUG_HWQ_0_DISABLE_ECC
        read
        read_CTF_ECC_DEBUG_HWQ_0_DISABLE_ECC = read_CTF_ECC_DEBUG_HWQ_0_DISABLE_ECC_value
    End Property

    Property Let write_CTF_ECC_DEBUG_HWQ_0_DISABLE_ECC(aData)
        set_CTF_ECC_DEBUG_HWQ_0_DISABLE_ECC = aData
        write
    End Property

    Property Get get_CTF_ECC_DEBUG_HWQ_0_ECC_CORRUPT
        get_CTF_ECC_DEBUG_HWQ_0_ECC_CORRUPT = read_CTF_ECC_DEBUG_HWQ_0_ECC_CORRUPT_value
    End Property

    Property Let set_CTF_ECC_DEBUG_HWQ_0_ECC_CORRUPT(aData)
        write_CTF_ECC_DEBUG_HWQ_0_ECC_CORRUPT_value = aData
        flag_CTF_ECC_DEBUG_HWQ_0_ECC_CORRUPT        = &H1
    End Property

    Property Get read_CTF_ECC_DEBUG_HWQ_0_ECC_CORRUPT
        read
        read_CTF_ECC_DEBUG_HWQ_0_ECC_CORRUPT = read_CTF_ECC_DEBUG_HWQ_0_ECC_CORRUPT_value
    End Property

    Property Let write_CTF_ECC_DEBUG_HWQ_0_ECC_CORRUPT(aData)
        set_CTF_ECC_DEBUG_HWQ_0_ECC_CORRUPT = aData
        write
    End Property

    Property Get get_CTF_ECC_DEBUG_NEXT_HOP_DISABLE_ECC
        get_CTF_ECC_DEBUG_NEXT_HOP_DISABLE_ECC = read_CTF_ECC_DEBUG_NEXT_HOP_DISABLE_ECC_value
    End Property

    Property Let set_CTF_ECC_DEBUG_NEXT_HOP_DISABLE_ECC(aData)
        write_CTF_ECC_DEBUG_NEXT_HOP_DISABLE_ECC_value = aData
        flag_CTF_ECC_DEBUG_NEXT_HOP_DISABLE_ECC        = &H1
    End Property

    Property Get read_CTF_ECC_DEBUG_NEXT_HOP_DISABLE_ECC
        read
        read_CTF_ECC_DEBUG_NEXT_HOP_DISABLE_ECC = read_CTF_ECC_DEBUG_NEXT_HOP_DISABLE_ECC_value
    End Property

    Property Let write_CTF_ECC_DEBUG_NEXT_HOP_DISABLE_ECC(aData)
        set_CTF_ECC_DEBUG_NEXT_HOP_DISABLE_ECC = aData
        write
    End Property

    Property Get get_CTF_ECC_DEBUG_NEXT_HOP_ECC_CORRUPT
        get_CTF_ECC_DEBUG_NEXT_HOP_ECC_CORRUPT = read_CTF_ECC_DEBUG_NEXT_HOP_ECC_CORRUPT_value
    End Property

    Property Let set_CTF_ECC_DEBUG_NEXT_HOP_ECC_CORRUPT(aData)
        write_CTF_ECC_DEBUG_NEXT_HOP_ECC_CORRUPT_value = aData
        flag_CTF_ECC_DEBUG_NEXT_HOP_ECC_CORRUPT        = &H1
    End Property

    Property Get read_CTF_ECC_DEBUG_NEXT_HOP_ECC_CORRUPT
        read
        read_CTF_ECC_DEBUG_NEXT_HOP_ECC_CORRUPT = read_CTF_ECC_DEBUG_NEXT_HOP_ECC_CORRUPT_value
    End Property

    Property Let write_CTF_ECC_DEBUG_NEXT_HOP_ECC_CORRUPT(aData)
        set_CTF_ECC_DEBUG_NEXT_HOP_ECC_CORRUPT = aData
        write
    End Property

    Property Get get_CTF_ECC_DEBUG_NAPT_FLOW_DISABLE_ECC
        get_CTF_ECC_DEBUG_NAPT_FLOW_DISABLE_ECC = read_CTF_ECC_DEBUG_NAPT_FLOW_DISABLE_ECC_value
    End Property

    Property Let set_CTF_ECC_DEBUG_NAPT_FLOW_DISABLE_ECC(aData)
        write_CTF_ECC_DEBUG_NAPT_FLOW_DISABLE_ECC_value = aData
        flag_CTF_ECC_DEBUG_NAPT_FLOW_DISABLE_ECC        = &H1
    End Property

    Property Get read_CTF_ECC_DEBUG_NAPT_FLOW_DISABLE_ECC
        read
        read_CTF_ECC_DEBUG_NAPT_FLOW_DISABLE_ECC = read_CTF_ECC_DEBUG_NAPT_FLOW_DISABLE_ECC_value
    End Property

    Property Let write_CTF_ECC_DEBUG_NAPT_FLOW_DISABLE_ECC(aData)
        set_CTF_ECC_DEBUG_NAPT_FLOW_DISABLE_ECC = aData
        write
    End Property

    Property Get get_CTF_ECC_DEBUG_NAPT_FLOW_ECC_CORRUPT
        get_CTF_ECC_DEBUG_NAPT_FLOW_ECC_CORRUPT = read_CTF_ECC_DEBUG_NAPT_FLOW_ECC_CORRUPT_value
    End Property

    Property Let set_CTF_ECC_DEBUG_NAPT_FLOW_ECC_CORRUPT(aData)
        write_CTF_ECC_DEBUG_NAPT_FLOW_ECC_CORRUPT_value = aData
        flag_CTF_ECC_DEBUG_NAPT_FLOW_ECC_CORRUPT        = &H1
    End Property

    Property Get read_CTF_ECC_DEBUG_NAPT_FLOW_ECC_CORRUPT
        read
        read_CTF_ECC_DEBUG_NAPT_FLOW_ECC_CORRUPT = read_CTF_ECC_DEBUG_NAPT_FLOW_ECC_CORRUPT_value
    End Property

    Property Let write_CTF_ECC_DEBUG_NAPT_FLOW_ECC_CORRUPT(aData)
        set_CTF_ECC_DEBUG_NAPT_FLOW_ECC_CORRUPT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CTF_ECC_DEBUG_RESERVED_value = rightShift(data_low, 18) and &H3fff
        read_CTF_ECC_DEBUG_HB_DISABLE_ECC_value = rightShift(data_low, 17) and &H1
        read_CTF_ECC_DEBUG_HB_ECC_CORRUPT_value = rightShift(data_low, 15) and &H3
        read_CTF_ECC_DEBUG_LAB_DISABLE_ECC_value = rightShift(data_low, 14) and &H1
        read_CTF_ECC_DEBUG_LAB_ECC_CORRUPT_value = rightShift(data_low, 12) and &H3
        read_CTF_ECC_DEBUG_HWQ_1_DISABLE_ECC_value = rightShift(data_low, 11) and &H1
        read_CTF_ECC_DEBUG_HWQ_1_ECC_CORRUPT_value = rightShift(data_low, 9) and &H3
        read_CTF_ECC_DEBUG_HWQ_0_DISABLE_ECC_value = rightShift(data_low, 8) and &H1
        read_CTF_ECC_DEBUG_HWQ_0_ECC_CORRUPT_value = rightShift(data_low, 6) and &H3
        read_CTF_ECC_DEBUG_NEXT_HOP_DISABLE_ECC_value = rightShift(data_low, 5) and &H1
        read_CTF_ECC_DEBUG_NEXT_HOP_ECC_CORRUPT_value = rightShift(data_low, 3) and &H3
        read_CTF_ECC_DEBUG_NAPT_FLOW_DISABLE_ECC_value = rightShift(data_low, 2) and &H1
        CTF_ECC_DEBUG_NAPT_FLOW_ECC_CORRUPT_mask = &H3
        if data_low > LONG_MAX then
            if CTF_ECC_DEBUG_NAPT_FLOW_ECC_CORRUPT_mask = mask then
                read_CTF_ECC_DEBUG_NAPT_FLOW_ECC_CORRUPT_value = data_low
            else
                read_CTF_ECC_DEBUG_NAPT_FLOW_ECC_CORRUPT_value = (data_low - H8000_0000) and CTF_ECC_DEBUG_NAPT_FLOW_ECC_CORRUPT_mask
            end If
        else
            read_CTF_ECC_DEBUG_NAPT_FLOW_ECC_CORRUPT_value = data_low and CTF_ECC_DEBUG_NAPT_FLOW_ECC_CORRUPT_mask
        end If

    End Sub

    Sub write
        If flag_CTF_ECC_DEBUG_RESERVED = &H0 or flag_CTF_ECC_DEBUG_HB_DISABLE_ECC = &H0 or flag_CTF_ECC_DEBUG_HB_ECC_CORRUPT = &H0 or flag_CTF_ECC_DEBUG_LAB_DISABLE_ECC = &H0 or flag_CTF_ECC_DEBUG_LAB_ECC_CORRUPT = &H0 or flag_CTF_ECC_DEBUG_HWQ_1_DISABLE_ECC = &H0 or flag_CTF_ECC_DEBUG_HWQ_1_ECC_CORRUPT = &H0 or flag_CTF_ECC_DEBUG_HWQ_0_DISABLE_ECC = &H0 or flag_CTF_ECC_DEBUG_HWQ_0_ECC_CORRUPT = &H0 or flag_CTF_ECC_DEBUG_NEXT_HOP_DISABLE_ECC = &H0 or flag_CTF_ECC_DEBUG_NEXT_HOP_ECC_CORRUPT = &H0 or flag_CTF_ECC_DEBUG_NAPT_FLOW_DISABLE_ECC = &H0 or flag_CTF_ECC_DEBUG_NAPT_FLOW_ECC_CORRUPT = &H0 Then read
        If flag_CTF_ECC_DEBUG_RESERVED = &H0 Then write_CTF_ECC_DEBUG_RESERVED_value = get_CTF_ECC_DEBUG_RESERVED
        If flag_CTF_ECC_DEBUG_HB_DISABLE_ECC = &H0 Then write_CTF_ECC_DEBUG_HB_DISABLE_ECC_value = get_CTF_ECC_DEBUG_HB_DISABLE_ECC
        If flag_CTF_ECC_DEBUG_HB_ECC_CORRUPT = &H0 Then write_CTF_ECC_DEBUG_HB_ECC_CORRUPT_value = get_CTF_ECC_DEBUG_HB_ECC_CORRUPT
        If flag_CTF_ECC_DEBUG_LAB_DISABLE_ECC = &H0 Then write_CTF_ECC_DEBUG_LAB_DISABLE_ECC_value = get_CTF_ECC_DEBUG_LAB_DISABLE_ECC
        If flag_CTF_ECC_DEBUG_LAB_ECC_CORRUPT = &H0 Then write_CTF_ECC_DEBUG_LAB_ECC_CORRUPT_value = get_CTF_ECC_DEBUG_LAB_ECC_CORRUPT
        If flag_CTF_ECC_DEBUG_HWQ_1_DISABLE_ECC = &H0 Then write_CTF_ECC_DEBUG_HWQ_1_DISABLE_ECC_value = get_CTF_ECC_DEBUG_HWQ_1_DISABLE_ECC
        If flag_CTF_ECC_DEBUG_HWQ_1_ECC_CORRUPT = &H0 Then write_CTF_ECC_DEBUG_HWQ_1_ECC_CORRUPT_value = get_CTF_ECC_DEBUG_HWQ_1_ECC_CORRUPT
        If flag_CTF_ECC_DEBUG_HWQ_0_DISABLE_ECC = &H0 Then write_CTF_ECC_DEBUG_HWQ_0_DISABLE_ECC_value = get_CTF_ECC_DEBUG_HWQ_0_DISABLE_ECC
        If flag_CTF_ECC_DEBUG_HWQ_0_ECC_CORRUPT = &H0 Then write_CTF_ECC_DEBUG_HWQ_0_ECC_CORRUPT_value = get_CTF_ECC_DEBUG_HWQ_0_ECC_CORRUPT
        If flag_CTF_ECC_DEBUG_NEXT_HOP_DISABLE_ECC = &H0 Then write_CTF_ECC_DEBUG_NEXT_HOP_DISABLE_ECC_value = get_CTF_ECC_DEBUG_NEXT_HOP_DISABLE_ECC
        If flag_CTF_ECC_DEBUG_NEXT_HOP_ECC_CORRUPT = &H0 Then write_CTF_ECC_DEBUG_NEXT_HOP_ECC_CORRUPT_value = get_CTF_ECC_DEBUG_NEXT_HOP_ECC_CORRUPT
        If flag_CTF_ECC_DEBUG_NAPT_FLOW_DISABLE_ECC = &H0 Then write_CTF_ECC_DEBUG_NAPT_FLOW_DISABLE_ECC_value = get_CTF_ECC_DEBUG_NAPT_FLOW_DISABLE_ECC
        If flag_CTF_ECC_DEBUG_NAPT_FLOW_ECC_CORRUPT = &H0 Then write_CTF_ECC_DEBUG_NAPT_FLOW_ECC_CORRUPT_value = get_CTF_ECC_DEBUG_NAPT_FLOW_ECC_CORRUPT

        regValue = leftShift((write_CTF_ECC_DEBUG_RESERVED_value and &H3fff), 18) + leftShift((write_CTF_ECC_DEBUG_HB_DISABLE_ECC_value and &H1), 17) + leftShift((write_CTF_ECC_DEBUG_HB_ECC_CORRUPT_value and &H3), 15) + leftShift((write_CTF_ECC_DEBUG_LAB_DISABLE_ECC_value and &H1), 14) + leftShift((write_CTF_ECC_DEBUG_LAB_ECC_CORRUPT_value and &H3), 12) + leftShift((write_CTF_ECC_DEBUG_HWQ_1_DISABLE_ECC_value and &H1), 11) + leftShift((write_CTF_ECC_DEBUG_HWQ_1_ECC_CORRUPT_value and &H3), 9) + leftShift((write_CTF_ECC_DEBUG_HWQ_0_DISABLE_ECC_value and &H1), 8) + leftShift((write_CTF_ECC_DEBUG_HWQ_0_ECC_CORRUPT_value and &H3), 6) + leftShift((write_CTF_ECC_DEBUG_NEXT_HOP_DISABLE_ECC_value and &H1), 5) + leftShift((write_CTF_ECC_DEBUG_NEXT_HOP_ECC_CORRUPT_value and &H3), 3) + leftShift((write_CTF_ECC_DEBUG_NAPT_FLOW_DISABLE_ECC_value and &H1), 2) + leftShift((write_CTF_ECC_DEBUG_NAPT_FLOW_ECC_CORRUPT_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CTF_ECC_DEBUG_RESERVED_value = rightShift(data_low, 18) and &H3fff
        read_CTF_ECC_DEBUG_HB_DISABLE_ECC_value = rightShift(data_low, 17) and &H1
        read_CTF_ECC_DEBUG_HB_ECC_CORRUPT_value = rightShift(data_low, 15) and &H3
        read_CTF_ECC_DEBUG_LAB_DISABLE_ECC_value = rightShift(data_low, 14) and &H1
        read_CTF_ECC_DEBUG_LAB_ECC_CORRUPT_value = rightShift(data_low, 12) and &H3
        read_CTF_ECC_DEBUG_HWQ_1_DISABLE_ECC_value = rightShift(data_low, 11) and &H1
        read_CTF_ECC_DEBUG_HWQ_1_ECC_CORRUPT_value = rightShift(data_low, 9) and &H3
        read_CTF_ECC_DEBUG_HWQ_0_DISABLE_ECC_value = rightShift(data_low, 8) and &H1
        read_CTF_ECC_DEBUG_HWQ_0_ECC_CORRUPT_value = rightShift(data_low, 6) and &H3
        read_CTF_ECC_DEBUG_NEXT_HOP_DISABLE_ECC_value = rightShift(data_low, 5) and &H1
        read_CTF_ECC_DEBUG_NEXT_HOP_ECC_CORRUPT_value = rightShift(data_low, 3) and &H3
        read_CTF_ECC_DEBUG_NAPT_FLOW_DISABLE_ECC_value = rightShift(data_low, 2) and &H1
        CTF_ECC_DEBUG_NAPT_FLOW_ECC_CORRUPT_mask = &H3
        if data_low > LONG_MAX then
            if CTF_ECC_DEBUG_NAPT_FLOW_ECC_CORRUPT_mask = mask then
                read_CTF_ECC_DEBUG_NAPT_FLOW_ECC_CORRUPT_value = data_low
            else
                read_CTF_ECC_DEBUG_NAPT_FLOW_ECC_CORRUPT_value = (data_low - H8000_0000) and CTF_ECC_DEBUG_NAPT_FLOW_ECC_CORRUPT_mask
            end If
        else
            read_CTF_ECC_DEBUG_NAPT_FLOW_ECC_CORRUPT_value = data_low and CTF_ECC_DEBUG_NAPT_FLOW_ECC_CORRUPT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CTF_ECC_DEBUG_RESERVED_value = &H0
        flag_CTF_ECC_DEBUG_RESERVED        = &H0
        write_CTF_ECC_DEBUG_HB_DISABLE_ECC_value = &H0
        flag_CTF_ECC_DEBUG_HB_DISABLE_ECC        = &H0
        write_CTF_ECC_DEBUG_HB_ECC_CORRUPT_value = &H0
        flag_CTF_ECC_DEBUG_HB_ECC_CORRUPT        = &H0
        write_CTF_ECC_DEBUG_LAB_DISABLE_ECC_value = &H0
        flag_CTF_ECC_DEBUG_LAB_DISABLE_ECC        = &H0
        write_CTF_ECC_DEBUG_LAB_ECC_CORRUPT_value = &H0
        flag_CTF_ECC_DEBUG_LAB_ECC_CORRUPT        = &H0
        write_CTF_ECC_DEBUG_HWQ_1_DISABLE_ECC_value = &H0
        flag_CTF_ECC_DEBUG_HWQ_1_DISABLE_ECC        = &H0
        write_CTF_ECC_DEBUG_HWQ_1_ECC_CORRUPT_value = &H0
        flag_CTF_ECC_DEBUG_HWQ_1_ECC_CORRUPT        = &H0
        write_CTF_ECC_DEBUG_HWQ_0_DISABLE_ECC_value = &H0
        flag_CTF_ECC_DEBUG_HWQ_0_DISABLE_ECC        = &H0
        write_CTF_ECC_DEBUG_HWQ_0_ECC_CORRUPT_value = &H0
        flag_CTF_ECC_DEBUG_HWQ_0_ECC_CORRUPT        = &H0
        write_CTF_ECC_DEBUG_NEXT_HOP_DISABLE_ECC_value = &H0
        flag_CTF_ECC_DEBUG_NEXT_HOP_DISABLE_ECC        = &H0
        write_CTF_ECC_DEBUG_NEXT_HOP_ECC_CORRUPT_value = &H0
        flag_CTF_ECC_DEBUG_NEXT_HOP_ECC_CORRUPT        = &H0
        write_CTF_ECC_DEBUG_NAPT_FLOW_DISABLE_ECC_value = &H0
        flag_CTF_ECC_DEBUG_NAPT_FLOW_DISABLE_ECC        = &H0
        write_CTF_ECC_DEBUG_NAPT_FLOW_ECC_CORRUPT_value = &H0
        flag_CTF_ECC_DEBUG_NAPT_FLOW_ECC_CORRUPT        = &H0
    End Sub
End Class


'' @REGISTER : CTF_ctf_ecc_error
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CTF_ECC_ERROR_RESERVED                     [31:12]          get_CTF_ECC_ERROR_RESERVED
''                                                             set_CTF_ECC_ERROR_RESERVED
''                                                             read_CTF_ECC_ERROR_RESERVED
''                                                             write_CTF_ECC_ERROR_RESERVED
''---------------------------------------------------------------------------------
'' CTF_ECC_ERROR_HB_UNCORRECTED_ERROR         [11:11]          get_CTF_ECC_ERROR_HB_UNCORRECTED_ERROR
''                                                             set_CTF_ECC_ERROR_HB_UNCORRECTED_ERROR
''                                                             read_CTF_ECC_ERROR_HB_UNCORRECTED_ERROR
''                                                             write_CTF_ECC_ERROR_HB_UNCORRECTED_ERROR
''---------------------------------------------------------------------------------
'' CTF_ECC_ERROR_HB_CORRECTED_ERROR           [10:10]          get_CTF_ECC_ERROR_HB_CORRECTED_ERROR
''                                                             set_CTF_ECC_ERROR_HB_CORRECTED_ERROR
''                                                             read_CTF_ECC_ERROR_HB_CORRECTED_ERROR
''                                                             write_CTF_ECC_ERROR_HB_CORRECTED_ERROR
''---------------------------------------------------------------------------------
'' CTF_ECC_ERROR_LAB_UNCORRECTED_ERROR        [9:9]            get_CTF_ECC_ERROR_LAB_UNCORRECTED_ERROR
''                                                             set_CTF_ECC_ERROR_LAB_UNCORRECTED_ERROR
''                                                             read_CTF_ECC_ERROR_LAB_UNCORRECTED_ERROR
''                                                             write_CTF_ECC_ERROR_LAB_UNCORRECTED_ERROR
''---------------------------------------------------------------------------------
'' CTF_ECC_ERROR_LAB_CORRECTED_ERROR          [8:8]            get_CTF_ECC_ERROR_LAB_CORRECTED_ERROR
''                                                             set_CTF_ECC_ERROR_LAB_CORRECTED_ERROR
''                                                             read_CTF_ECC_ERROR_LAB_CORRECTED_ERROR
''                                                             write_CTF_ECC_ERROR_LAB_CORRECTED_ERROR
''---------------------------------------------------------------------------------
'' CTF_ECC_ERROR_HWQ_1_UNCORRECTED_ERROR      [7:7]            get_CTF_ECC_ERROR_HWQ_1_UNCORRECTED_ERROR
''                                                             set_CTF_ECC_ERROR_HWQ_1_UNCORRECTED_ERROR
''                                                             read_CTF_ECC_ERROR_HWQ_1_UNCORRECTED_ERROR
''                                                             write_CTF_ECC_ERROR_HWQ_1_UNCORRECTED_ERROR
''---------------------------------------------------------------------------------
'' CTF_ECC_ERROR_HWQ_1_CORRECTED_ERROR        [6:6]            get_CTF_ECC_ERROR_HWQ_1_CORRECTED_ERROR
''                                                             set_CTF_ECC_ERROR_HWQ_1_CORRECTED_ERROR
''                                                             read_CTF_ECC_ERROR_HWQ_1_CORRECTED_ERROR
''                                                             write_CTF_ECC_ERROR_HWQ_1_CORRECTED_ERROR
''---------------------------------------------------------------------------------
'' CTF_ECC_ERROR_HWQ_0_UNCORRECTED_ERROR      [5:5]            get_CTF_ECC_ERROR_HWQ_0_UNCORRECTED_ERROR
''                                                             set_CTF_ECC_ERROR_HWQ_0_UNCORRECTED_ERROR
''                                                             read_CTF_ECC_ERROR_HWQ_0_UNCORRECTED_ERROR
''                                                             write_CTF_ECC_ERROR_HWQ_0_UNCORRECTED_ERROR
''---------------------------------------------------------------------------------
'' CTF_ECC_ERROR_HWQ_0_CORRECTED_ERROR        [4:4]            get_CTF_ECC_ERROR_HWQ_0_CORRECTED_ERROR
''                                                             set_CTF_ECC_ERROR_HWQ_0_CORRECTED_ERROR
''                                                             read_CTF_ECC_ERROR_HWQ_0_CORRECTED_ERROR
''                                                             write_CTF_ECC_ERROR_HWQ_0_CORRECTED_ERROR
''---------------------------------------------------------------------------------
'' CTF_ECC_ERROR_NEXT_HOP_UNCORRECTED_ERROR   [3:3]            get_CTF_ECC_ERROR_NEXT_HOP_UNCORRECTED_ERROR
''                                                             set_CTF_ECC_ERROR_NEXT_HOP_UNCORRECTED_ERROR
''                                                             read_CTF_ECC_ERROR_NEXT_HOP_UNCORRECTED_ERROR
''                                                             write_CTF_ECC_ERROR_NEXT_HOP_UNCORRECTED_ERROR
''---------------------------------------------------------------------------------
'' CTF_ECC_ERROR_NEXT_HOP_CORRECTED_ERROR     [2:2]            get_CTF_ECC_ERROR_NEXT_HOP_CORRECTED_ERROR
''                                                             set_CTF_ECC_ERROR_NEXT_HOP_CORRECTED_ERROR
''                                                             read_CTF_ECC_ERROR_NEXT_HOP_CORRECTED_ERROR
''                                                             write_CTF_ECC_ERROR_NEXT_HOP_CORRECTED_ERROR
''---------------------------------------------------------------------------------
'' CTF_ECC_ERROR_NAPT_FLOW_UNCORRECTED_ERROR   [1:1]            get_CTF_ECC_ERROR_NAPT_FLOW_UNCORRECTED_ERROR
''                                                             set_CTF_ECC_ERROR_NAPT_FLOW_UNCORRECTED_ERROR
''                                                             read_CTF_ECC_ERROR_NAPT_FLOW_UNCORRECTED_ERROR
''                                                             write_CTF_ECC_ERROR_NAPT_FLOW_UNCORRECTED_ERROR
''---------------------------------------------------------------------------------
'' CTF_ECC_ERROR_NAPT_FLOW_CORRECTED_ERROR    [0:0]            get_CTF_ECC_ERROR_NAPT_FLOW_CORRECTED_ERROR
''                                                             set_CTF_ECC_ERROR_NAPT_FLOW_CORRECTED_ERROR
''                                                             read_CTF_ECC_ERROR_NAPT_FLOW_CORRECTED_ERROR
''                                                             write_CTF_ECC_ERROR_NAPT_FLOW_CORRECTED_ERROR
''---------------------------------------------------------------------------------
Class REGISTER_CTF_ctf_ecc_error
    Private write_CTF_ECC_ERROR_RESERVED_value
    Private read_CTF_ECC_ERROR_RESERVED_value
    Private flag_CTF_ECC_ERROR_RESERVED
    Private write_CTF_ECC_ERROR_HB_UNCORRECTED_ERROR_value
    Private read_CTF_ECC_ERROR_HB_UNCORRECTED_ERROR_value
    Private flag_CTF_ECC_ERROR_HB_UNCORRECTED_ERROR
    Private write_CTF_ECC_ERROR_HB_CORRECTED_ERROR_value
    Private read_CTF_ECC_ERROR_HB_CORRECTED_ERROR_value
    Private flag_CTF_ECC_ERROR_HB_CORRECTED_ERROR
    Private write_CTF_ECC_ERROR_LAB_UNCORRECTED_ERROR_value
    Private read_CTF_ECC_ERROR_LAB_UNCORRECTED_ERROR_value
    Private flag_CTF_ECC_ERROR_LAB_UNCORRECTED_ERROR
    Private write_CTF_ECC_ERROR_LAB_CORRECTED_ERROR_value
    Private read_CTF_ECC_ERROR_LAB_CORRECTED_ERROR_value
    Private flag_CTF_ECC_ERROR_LAB_CORRECTED_ERROR
    Private write_CTF_ECC_ERROR_HWQ_1_UNCORRECTED_ERROR_value
    Private read_CTF_ECC_ERROR_HWQ_1_UNCORRECTED_ERROR_value
    Private flag_CTF_ECC_ERROR_HWQ_1_UNCORRECTED_ERROR
    Private write_CTF_ECC_ERROR_HWQ_1_CORRECTED_ERROR_value
    Private read_CTF_ECC_ERROR_HWQ_1_CORRECTED_ERROR_value
    Private flag_CTF_ECC_ERROR_HWQ_1_CORRECTED_ERROR
    Private write_CTF_ECC_ERROR_HWQ_0_UNCORRECTED_ERROR_value
    Private read_CTF_ECC_ERROR_HWQ_0_UNCORRECTED_ERROR_value
    Private flag_CTF_ECC_ERROR_HWQ_0_UNCORRECTED_ERROR
    Private write_CTF_ECC_ERROR_HWQ_0_CORRECTED_ERROR_value
    Private read_CTF_ECC_ERROR_HWQ_0_CORRECTED_ERROR_value
    Private flag_CTF_ECC_ERROR_HWQ_0_CORRECTED_ERROR
    Private write_CTF_ECC_ERROR_NEXT_HOP_UNCORRECTED_ERROR_value
    Private read_CTF_ECC_ERROR_NEXT_HOP_UNCORRECTED_ERROR_value
    Private flag_CTF_ECC_ERROR_NEXT_HOP_UNCORRECTED_ERROR
    Private write_CTF_ECC_ERROR_NEXT_HOP_CORRECTED_ERROR_value
    Private read_CTF_ECC_ERROR_NEXT_HOP_CORRECTED_ERROR_value
    Private flag_CTF_ECC_ERROR_NEXT_HOP_CORRECTED_ERROR
    Private write_CTF_ECC_ERROR_NAPT_FLOW_UNCORRECTED_ERROR_value
    Private read_CTF_ECC_ERROR_NAPT_FLOW_UNCORRECTED_ERROR_value
    Private flag_CTF_ECC_ERROR_NAPT_FLOW_UNCORRECTED_ERROR
    Private write_CTF_ECC_ERROR_NAPT_FLOW_CORRECTED_ERROR_value
    Private read_CTF_ECC_ERROR_NAPT_FLOW_CORRECTED_ERROR_value
    Private flag_CTF_ECC_ERROR_NAPT_FLOW_CORRECTED_ERROR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_CTF_ECC_ERROR_RESERVED
        get_CTF_ECC_ERROR_RESERVED = read_CTF_ECC_ERROR_RESERVED_value
    End Property

    Property Let set_CTF_ECC_ERROR_RESERVED(aData)
        write_CTF_ECC_ERROR_RESERVED_value = aData
        flag_CTF_ECC_ERROR_RESERVED        = &H1
    End Property

    Property Get read_CTF_ECC_ERROR_RESERVED
        read
        read_CTF_ECC_ERROR_RESERVED = read_CTF_ECC_ERROR_RESERVED_value
    End Property

    Property Let write_CTF_ECC_ERROR_RESERVED(aData)
        set_CTF_ECC_ERROR_RESERVED = aData
        write
    End Property

    Property Get get_CTF_ECC_ERROR_HB_UNCORRECTED_ERROR
        get_CTF_ECC_ERROR_HB_UNCORRECTED_ERROR = read_CTF_ECC_ERROR_HB_UNCORRECTED_ERROR_value
    End Property

    Property Let set_CTF_ECC_ERROR_HB_UNCORRECTED_ERROR(aData)
        write_CTF_ECC_ERROR_HB_UNCORRECTED_ERROR_value = aData
        flag_CTF_ECC_ERROR_HB_UNCORRECTED_ERROR        = &H1
    End Property

    Property Get read_CTF_ECC_ERROR_HB_UNCORRECTED_ERROR
        read
        read_CTF_ECC_ERROR_HB_UNCORRECTED_ERROR = read_CTF_ECC_ERROR_HB_UNCORRECTED_ERROR_value
    End Property

    Property Let write_CTF_ECC_ERROR_HB_UNCORRECTED_ERROR(aData)
        set_CTF_ECC_ERROR_HB_UNCORRECTED_ERROR = aData
        write
    End Property

    Property Get get_CTF_ECC_ERROR_HB_CORRECTED_ERROR
        get_CTF_ECC_ERROR_HB_CORRECTED_ERROR = read_CTF_ECC_ERROR_HB_CORRECTED_ERROR_value
    End Property

    Property Let set_CTF_ECC_ERROR_HB_CORRECTED_ERROR(aData)
        write_CTF_ECC_ERROR_HB_CORRECTED_ERROR_value = aData
        flag_CTF_ECC_ERROR_HB_CORRECTED_ERROR        = &H1
    End Property

    Property Get read_CTF_ECC_ERROR_HB_CORRECTED_ERROR
        read
        read_CTF_ECC_ERROR_HB_CORRECTED_ERROR = read_CTF_ECC_ERROR_HB_CORRECTED_ERROR_value
    End Property

    Property Let write_CTF_ECC_ERROR_HB_CORRECTED_ERROR(aData)
        set_CTF_ECC_ERROR_HB_CORRECTED_ERROR = aData
        write
    End Property

    Property Get get_CTF_ECC_ERROR_LAB_UNCORRECTED_ERROR
        get_CTF_ECC_ERROR_LAB_UNCORRECTED_ERROR = read_CTF_ECC_ERROR_LAB_UNCORRECTED_ERROR_value
    End Property

    Property Let set_CTF_ECC_ERROR_LAB_UNCORRECTED_ERROR(aData)
        write_CTF_ECC_ERROR_LAB_UNCORRECTED_ERROR_value = aData
        flag_CTF_ECC_ERROR_LAB_UNCORRECTED_ERROR        = &H1
    End Property

    Property Get read_CTF_ECC_ERROR_LAB_UNCORRECTED_ERROR
        read
        read_CTF_ECC_ERROR_LAB_UNCORRECTED_ERROR = read_CTF_ECC_ERROR_LAB_UNCORRECTED_ERROR_value
    End Property

    Property Let write_CTF_ECC_ERROR_LAB_UNCORRECTED_ERROR(aData)
        set_CTF_ECC_ERROR_LAB_UNCORRECTED_ERROR = aData
        write
    End Property

    Property Get get_CTF_ECC_ERROR_LAB_CORRECTED_ERROR
        get_CTF_ECC_ERROR_LAB_CORRECTED_ERROR = read_CTF_ECC_ERROR_LAB_CORRECTED_ERROR_value
    End Property

    Property Let set_CTF_ECC_ERROR_LAB_CORRECTED_ERROR(aData)
        write_CTF_ECC_ERROR_LAB_CORRECTED_ERROR_value = aData
        flag_CTF_ECC_ERROR_LAB_CORRECTED_ERROR        = &H1
    End Property

    Property Get read_CTF_ECC_ERROR_LAB_CORRECTED_ERROR
        read
        read_CTF_ECC_ERROR_LAB_CORRECTED_ERROR = read_CTF_ECC_ERROR_LAB_CORRECTED_ERROR_value
    End Property

    Property Let write_CTF_ECC_ERROR_LAB_CORRECTED_ERROR(aData)
        set_CTF_ECC_ERROR_LAB_CORRECTED_ERROR = aData
        write
    End Property

    Property Get get_CTF_ECC_ERROR_HWQ_1_UNCORRECTED_ERROR
        get_CTF_ECC_ERROR_HWQ_1_UNCORRECTED_ERROR = read_CTF_ECC_ERROR_HWQ_1_UNCORRECTED_ERROR_value
    End Property

    Property Let set_CTF_ECC_ERROR_HWQ_1_UNCORRECTED_ERROR(aData)
        write_CTF_ECC_ERROR_HWQ_1_UNCORRECTED_ERROR_value = aData
        flag_CTF_ECC_ERROR_HWQ_1_UNCORRECTED_ERROR        = &H1
    End Property

    Property Get read_CTF_ECC_ERROR_HWQ_1_UNCORRECTED_ERROR
        read
        read_CTF_ECC_ERROR_HWQ_1_UNCORRECTED_ERROR = read_CTF_ECC_ERROR_HWQ_1_UNCORRECTED_ERROR_value
    End Property

    Property Let write_CTF_ECC_ERROR_HWQ_1_UNCORRECTED_ERROR(aData)
        set_CTF_ECC_ERROR_HWQ_1_UNCORRECTED_ERROR = aData
        write
    End Property

    Property Get get_CTF_ECC_ERROR_HWQ_1_CORRECTED_ERROR
        get_CTF_ECC_ERROR_HWQ_1_CORRECTED_ERROR = read_CTF_ECC_ERROR_HWQ_1_CORRECTED_ERROR_value
    End Property

    Property Let set_CTF_ECC_ERROR_HWQ_1_CORRECTED_ERROR(aData)
        write_CTF_ECC_ERROR_HWQ_1_CORRECTED_ERROR_value = aData
        flag_CTF_ECC_ERROR_HWQ_1_CORRECTED_ERROR        = &H1
    End Property

    Property Get read_CTF_ECC_ERROR_HWQ_1_CORRECTED_ERROR
        read
        read_CTF_ECC_ERROR_HWQ_1_CORRECTED_ERROR = read_CTF_ECC_ERROR_HWQ_1_CORRECTED_ERROR_value
    End Property

    Property Let write_CTF_ECC_ERROR_HWQ_1_CORRECTED_ERROR(aData)
        set_CTF_ECC_ERROR_HWQ_1_CORRECTED_ERROR = aData
        write
    End Property

    Property Get get_CTF_ECC_ERROR_HWQ_0_UNCORRECTED_ERROR
        get_CTF_ECC_ERROR_HWQ_0_UNCORRECTED_ERROR = read_CTF_ECC_ERROR_HWQ_0_UNCORRECTED_ERROR_value
    End Property

    Property Let set_CTF_ECC_ERROR_HWQ_0_UNCORRECTED_ERROR(aData)
        write_CTF_ECC_ERROR_HWQ_0_UNCORRECTED_ERROR_value = aData
        flag_CTF_ECC_ERROR_HWQ_0_UNCORRECTED_ERROR        = &H1
    End Property

    Property Get read_CTF_ECC_ERROR_HWQ_0_UNCORRECTED_ERROR
        read
        read_CTF_ECC_ERROR_HWQ_0_UNCORRECTED_ERROR = read_CTF_ECC_ERROR_HWQ_0_UNCORRECTED_ERROR_value
    End Property

    Property Let write_CTF_ECC_ERROR_HWQ_0_UNCORRECTED_ERROR(aData)
        set_CTF_ECC_ERROR_HWQ_0_UNCORRECTED_ERROR = aData
        write
    End Property

    Property Get get_CTF_ECC_ERROR_HWQ_0_CORRECTED_ERROR
        get_CTF_ECC_ERROR_HWQ_0_CORRECTED_ERROR = read_CTF_ECC_ERROR_HWQ_0_CORRECTED_ERROR_value
    End Property

    Property Let set_CTF_ECC_ERROR_HWQ_0_CORRECTED_ERROR(aData)
        write_CTF_ECC_ERROR_HWQ_0_CORRECTED_ERROR_value = aData
        flag_CTF_ECC_ERROR_HWQ_0_CORRECTED_ERROR        = &H1
    End Property

    Property Get read_CTF_ECC_ERROR_HWQ_0_CORRECTED_ERROR
        read
        read_CTF_ECC_ERROR_HWQ_0_CORRECTED_ERROR = read_CTF_ECC_ERROR_HWQ_0_CORRECTED_ERROR_value
    End Property

    Property Let write_CTF_ECC_ERROR_HWQ_0_CORRECTED_ERROR(aData)
        set_CTF_ECC_ERROR_HWQ_0_CORRECTED_ERROR = aData
        write
    End Property

    Property Get get_CTF_ECC_ERROR_NEXT_HOP_UNCORRECTED_ERROR
        get_CTF_ECC_ERROR_NEXT_HOP_UNCORRECTED_ERROR = read_CTF_ECC_ERROR_NEXT_HOP_UNCORRECTED_ERROR_value
    End Property

    Property Let set_CTF_ECC_ERROR_NEXT_HOP_UNCORRECTED_ERROR(aData)
        write_CTF_ECC_ERROR_NEXT_HOP_UNCORRECTED_ERROR_value = aData
        flag_CTF_ECC_ERROR_NEXT_HOP_UNCORRECTED_ERROR        = &H1
    End Property

    Property Get read_CTF_ECC_ERROR_NEXT_HOP_UNCORRECTED_ERROR
        read
        read_CTF_ECC_ERROR_NEXT_HOP_UNCORRECTED_ERROR = read_CTF_ECC_ERROR_NEXT_HOP_UNCORRECTED_ERROR_value
    End Property

    Property Let write_CTF_ECC_ERROR_NEXT_HOP_UNCORRECTED_ERROR(aData)
        set_CTF_ECC_ERROR_NEXT_HOP_UNCORRECTED_ERROR = aData
        write
    End Property

    Property Get get_CTF_ECC_ERROR_NEXT_HOP_CORRECTED_ERROR
        get_CTF_ECC_ERROR_NEXT_HOP_CORRECTED_ERROR = read_CTF_ECC_ERROR_NEXT_HOP_CORRECTED_ERROR_value
    End Property

    Property Let set_CTF_ECC_ERROR_NEXT_HOP_CORRECTED_ERROR(aData)
        write_CTF_ECC_ERROR_NEXT_HOP_CORRECTED_ERROR_value = aData
        flag_CTF_ECC_ERROR_NEXT_HOP_CORRECTED_ERROR        = &H1
    End Property

    Property Get read_CTF_ECC_ERROR_NEXT_HOP_CORRECTED_ERROR
        read
        read_CTF_ECC_ERROR_NEXT_HOP_CORRECTED_ERROR = read_CTF_ECC_ERROR_NEXT_HOP_CORRECTED_ERROR_value
    End Property

    Property Let write_CTF_ECC_ERROR_NEXT_HOP_CORRECTED_ERROR(aData)
        set_CTF_ECC_ERROR_NEXT_HOP_CORRECTED_ERROR = aData
        write
    End Property

    Property Get get_CTF_ECC_ERROR_NAPT_FLOW_UNCORRECTED_ERROR
        get_CTF_ECC_ERROR_NAPT_FLOW_UNCORRECTED_ERROR = read_CTF_ECC_ERROR_NAPT_FLOW_UNCORRECTED_ERROR_value
    End Property

    Property Let set_CTF_ECC_ERROR_NAPT_FLOW_UNCORRECTED_ERROR(aData)
        write_CTF_ECC_ERROR_NAPT_FLOW_UNCORRECTED_ERROR_value = aData
        flag_CTF_ECC_ERROR_NAPT_FLOW_UNCORRECTED_ERROR        = &H1
    End Property

    Property Get read_CTF_ECC_ERROR_NAPT_FLOW_UNCORRECTED_ERROR
        read
        read_CTF_ECC_ERROR_NAPT_FLOW_UNCORRECTED_ERROR = read_CTF_ECC_ERROR_NAPT_FLOW_UNCORRECTED_ERROR_value
    End Property

    Property Let write_CTF_ECC_ERROR_NAPT_FLOW_UNCORRECTED_ERROR(aData)
        set_CTF_ECC_ERROR_NAPT_FLOW_UNCORRECTED_ERROR = aData
        write
    End Property

    Property Get get_CTF_ECC_ERROR_NAPT_FLOW_CORRECTED_ERROR
        get_CTF_ECC_ERROR_NAPT_FLOW_CORRECTED_ERROR = read_CTF_ECC_ERROR_NAPT_FLOW_CORRECTED_ERROR_value
    End Property

    Property Let set_CTF_ECC_ERROR_NAPT_FLOW_CORRECTED_ERROR(aData)
        write_CTF_ECC_ERROR_NAPT_FLOW_CORRECTED_ERROR_value = aData
        flag_CTF_ECC_ERROR_NAPT_FLOW_CORRECTED_ERROR        = &H1
    End Property

    Property Get read_CTF_ECC_ERROR_NAPT_FLOW_CORRECTED_ERROR
        read
        read_CTF_ECC_ERROR_NAPT_FLOW_CORRECTED_ERROR = read_CTF_ECC_ERROR_NAPT_FLOW_CORRECTED_ERROR_value
    End Property

    Property Let write_CTF_ECC_ERROR_NAPT_FLOW_CORRECTED_ERROR(aData)
        set_CTF_ECC_ERROR_NAPT_FLOW_CORRECTED_ERROR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CTF_ECC_ERROR_RESERVED_value = rightShift(data_low, 12) and &Hfffff
        read_CTF_ECC_ERROR_HB_UNCORRECTED_ERROR_value = rightShift(data_low, 11) and &H1
        read_CTF_ECC_ERROR_HB_CORRECTED_ERROR_value = rightShift(data_low, 10) and &H1
        read_CTF_ECC_ERROR_LAB_UNCORRECTED_ERROR_value = rightShift(data_low, 9) and &H1
        read_CTF_ECC_ERROR_LAB_CORRECTED_ERROR_value = rightShift(data_low, 8) and &H1
        read_CTF_ECC_ERROR_HWQ_1_UNCORRECTED_ERROR_value = rightShift(data_low, 7) and &H1
        read_CTF_ECC_ERROR_HWQ_1_CORRECTED_ERROR_value = rightShift(data_low, 6) and &H1
        read_CTF_ECC_ERROR_HWQ_0_UNCORRECTED_ERROR_value = rightShift(data_low, 5) and &H1
        read_CTF_ECC_ERROR_HWQ_0_CORRECTED_ERROR_value = rightShift(data_low, 4) and &H1
        read_CTF_ECC_ERROR_NEXT_HOP_UNCORRECTED_ERROR_value = rightShift(data_low, 3) and &H1
        read_CTF_ECC_ERROR_NEXT_HOP_CORRECTED_ERROR_value = rightShift(data_low, 2) and &H1
        read_CTF_ECC_ERROR_NAPT_FLOW_UNCORRECTED_ERROR_value = rightShift(data_low, 1) and &H1
        CTF_ECC_ERROR_NAPT_FLOW_CORRECTED_ERROR_mask = &H1
        if data_low > LONG_MAX then
            if CTF_ECC_ERROR_NAPT_FLOW_CORRECTED_ERROR_mask = mask then
                read_CTF_ECC_ERROR_NAPT_FLOW_CORRECTED_ERROR_value = data_low
            else
                read_CTF_ECC_ERROR_NAPT_FLOW_CORRECTED_ERROR_value = (data_low - H8000_0000) and CTF_ECC_ERROR_NAPT_FLOW_CORRECTED_ERROR_mask
            end If
        else
            read_CTF_ECC_ERROR_NAPT_FLOW_CORRECTED_ERROR_value = data_low and CTF_ECC_ERROR_NAPT_FLOW_CORRECTED_ERROR_mask
        end If

    End Sub

    Sub write
        If flag_CTF_ECC_ERROR_RESERVED = &H0 or flag_CTF_ECC_ERROR_HB_UNCORRECTED_ERROR = &H0 or flag_CTF_ECC_ERROR_HB_CORRECTED_ERROR = &H0 or flag_CTF_ECC_ERROR_LAB_UNCORRECTED_ERROR = &H0 or flag_CTF_ECC_ERROR_LAB_CORRECTED_ERROR = &H0 or flag_CTF_ECC_ERROR_HWQ_1_UNCORRECTED_ERROR = &H0 or flag_CTF_ECC_ERROR_HWQ_1_CORRECTED_ERROR = &H0 or flag_CTF_ECC_ERROR_HWQ_0_UNCORRECTED_ERROR = &H0 or flag_CTF_ECC_ERROR_HWQ_0_CORRECTED_ERROR = &H0 or flag_CTF_ECC_ERROR_NEXT_HOP_UNCORRECTED_ERROR = &H0 or flag_CTF_ECC_ERROR_NEXT_HOP_CORRECTED_ERROR = &H0 or flag_CTF_ECC_ERROR_NAPT_FLOW_UNCORRECTED_ERROR = &H0 or flag_CTF_ECC_ERROR_NAPT_FLOW_CORRECTED_ERROR = &H0 Then read
        If flag_CTF_ECC_ERROR_RESERVED = &H0 Then write_CTF_ECC_ERROR_RESERVED_value = get_CTF_ECC_ERROR_RESERVED
        If flag_CTF_ECC_ERROR_HB_UNCORRECTED_ERROR = &H0 Then write_CTF_ECC_ERROR_HB_UNCORRECTED_ERROR_value = get_CTF_ECC_ERROR_HB_UNCORRECTED_ERROR
        If flag_CTF_ECC_ERROR_HB_CORRECTED_ERROR = &H0 Then write_CTF_ECC_ERROR_HB_CORRECTED_ERROR_value = get_CTF_ECC_ERROR_HB_CORRECTED_ERROR
        If flag_CTF_ECC_ERROR_LAB_UNCORRECTED_ERROR = &H0 Then write_CTF_ECC_ERROR_LAB_UNCORRECTED_ERROR_value = get_CTF_ECC_ERROR_LAB_UNCORRECTED_ERROR
        If flag_CTF_ECC_ERROR_LAB_CORRECTED_ERROR = &H0 Then write_CTF_ECC_ERROR_LAB_CORRECTED_ERROR_value = get_CTF_ECC_ERROR_LAB_CORRECTED_ERROR
        If flag_CTF_ECC_ERROR_HWQ_1_UNCORRECTED_ERROR = &H0 Then write_CTF_ECC_ERROR_HWQ_1_UNCORRECTED_ERROR_value = get_CTF_ECC_ERROR_HWQ_1_UNCORRECTED_ERROR
        If flag_CTF_ECC_ERROR_HWQ_1_CORRECTED_ERROR = &H0 Then write_CTF_ECC_ERROR_HWQ_1_CORRECTED_ERROR_value = get_CTF_ECC_ERROR_HWQ_1_CORRECTED_ERROR
        If flag_CTF_ECC_ERROR_HWQ_0_UNCORRECTED_ERROR = &H0 Then write_CTF_ECC_ERROR_HWQ_0_UNCORRECTED_ERROR_value = get_CTF_ECC_ERROR_HWQ_0_UNCORRECTED_ERROR
        If flag_CTF_ECC_ERROR_HWQ_0_CORRECTED_ERROR = &H0 Then write_CTF_ECC_ERROR_HWQ_0_CORRECTED_ERROR_value = get_CTF_ECC_ERROR_HWQ_0_CORRECTED_ERROR
        If flag_CTF_ECC_ERROR_NEXT_HOP_UNCORRECTED_ERROR = &H0 Then write_CTF_ECC_ERROR_NEXT_HOP_UNCORRECTED_ERROR_value = get_CTF_ECC_ERROR_NEXT_HOP_UNCORRECTED_ERROR
        If flag_CTF_ECC_ERROR_NEXT_HOP_CORRECTED_ERROR = &H0 Then write_CTF_ECC_ERROR_NEXT_HOP_CORRECTED_ERROR_value = get_CTF_ECC_ERROR_NEXT_HOP_CORRECTED_ERROR
        If flag_CTF_ECC_ERROR_NAPT_FLOW_UNCORRECTED_ERROR = &H0 Then write_CTF_ECC_ERROR_NAPT_FLOW_UNCORRECTED_ERROR_value = get_CTF_ECC_ERROR_NAPT_FLOW_UNCORRECTED_ERROR
        If flag_CTF_ECC_ERROR_NAPT_FLOW_CORRECTED_ERROR = &H0 Then write_CTF_ECC_ERROR_NAPT_FLOW_CORRECTED_ERROR_value = get_CTF_ECC_ERROR_NAPT_FLOW_CORRECTED_ERROR

        regValue = leftShift((write_CTF_ECC_ERROR_RESERVED_value and &Hfffff), 12) + leftShift((write_CTF_ECC_ERROR_HB_UNCORRECTED_ERROR_value and &H1), 11) + leftShift((write_CTF_ECC_ERROR_HB_CORRECTED_ERROR_value and &H1), 10) + leftShift((write_CTF_ECC_ERROR_LAB_UNCORRECTED_ERROR_value and &H1), 9) + leftShift((write_CTF_ECC_ERROR_LAB_CORRECTED_ERROR_value and &H1), 8) + leftShift((write_CTF_ECC_ERROR_HWQ_1_UNCORRECTED_ERROR_value and &H1), 7) + leftShift((write_CTF_ECC_ERROR_HWQ_1_CORRECTED_ERROR_value and &H1), 6) + leftShift((write_CTF_ECC_ERROR_HWQ_0_UNCORRECTED_ERROR_value and &H1), 5) + leftShift((write_CTF_ECC_ERROR_HWQ_0_CORRECTED_ERROR_value and &H1), 4) + leftShift((write_CTF_ECC_ERROR_NEXT_HOP_UNCORRECTED_ERROR_value and &H1), 3) + leftShift((write_CTF_ECC_ERROR_NEXT_HOP_CORRECTED_ERROR_value and &H1), 2) + leftShift((write_CTF_ECC_ERROR_NAPT_FLOW_UNCORRECTED_ERROR_value and &H1), 1) + leftShift((write_CTF_ECC_ERROR_NAPT_FLOW_CORRECTED_ERROR_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CTF_ECC_ERROR_RESERVED_value = rightShift(data_low, 12) and &Hfffff
        read_CTF_ECC_ERROR_HB_UNCORRECTED_ERROR_value = rightShift(data_low, 11) and &H1
        read_CTF_ECC_ERROR_HB_CORRECTED_ERROR_value = rightShift(data_low, 10) and &H1
        read_CTF_ECC_ERROR_LAB_UNCORRECTED_ERROR_value = rightShift(data_low, 9) and &H1
        read_CTF_ECC_ERROR_LAB_CORRECTED_ERROR_value = rightShift(data_low, 8) and &H1
        read_CTF_ECC_ERROR_HWQ_1_UNCORRECTED_ERROR_value = rightShift(data_low, 7) and &H1
        read_CTF_ECC_ERROR_HWQ_1_CORRECTED_ERROR_value = rightShift(data_low, 6) and &H1
        read_CTF_ECC_ERROR_HWQ_0_UNCORRECTED_ERROR_value = rightShift(data_low, 5) and &H1
        read_CTF_ECC_ERROR_HWQ_0_CORRECTED_ERROR_value = rightShift(data_low, 4) and &H1
        read_CTF_ECC_ERROR_NEXT_HOP_UNCORRECTED_ERROR_value = rightShift(data_low, 3) and &H1
        read_CTF_ECC_ERROR_NEXT_HOP_CORRECTED_ERROR_value = rightShift(data_low, 2) and &H1
        read_CTF_ECC_ERROR_NAPT_FLOW_UNCORRECTED_ERROR_value = rightShift(data_low, 1) and &H1
        CTF_ECC_ERROR_NAPT_FLOW_CORRECTED_ERROR_mask = &H1
        if data_low > LONG_MAX then
            if CTF_ECC_ERROR_NAPT_FLOW_CORRECTED_ERROR_mask = mask then
                read_CTF_ECC_ERROR_NAPT_FLOW_CORRECTED_ERROR_value = data_low
            else
                read_CTF_ECC_ERROR_NAPT_FLOW_CORRECTED_ERROR_value = (data_low - H8000_0000) and CTF_ECC_ERROR_NAPT_FLOW_CORRECTED_ERROR_mask
            end If
        else
            read_CTF_ECC_ERROR_NAPT_FLOW_CORRECTED_ERROR_value = data_low and CTF_ECC_ERROR_NAPT_FLOW_CORRECTED_ERROR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CTF_ECC_ERROR_RESERVED_value = &H0
        flag_CTF_ECC_ERROR_RESERVED        = &H0
        write_CTF_ECC_ERROR_HB_UNCORRECTED_ERROR_value = &H0
        flag_CTF_ECC_ERROR_HB_UNCORRECTED_ERROR        = &H0
        write_CTF_ECC_ERROR_HB_CORRECTED_ERROR_value = &H0
        flag_CTF_ECC_ERROR_HB_CORRECTED_ERROR        = &H0
        write_CTF_ECC_ERROR_LAB_UNCORRECTED_ERROR_value = &H0
        flag_CTF_ECC_ERROR_LAB_UNCORRECTED_ERROR        = &H0
        write_CTF_ECC_ERROR_LAB_CORRECTED_ERROR_value = &H0
        flag_CTF_ECC_ERROR_LAB_CORRECTED_ERROR        = &H0
        write_CTF_ECC_ERROR_HWQ_1_UNCORRECTED_ERROR_value = &H0
        flag_CTF_ECC_ERROR_HWQ_1_UNCORRECTED_ERROR        = &H0
        write_CTF_ECC_ERROR_HWQ_1_CORRECTED_ERROR_value = &H0
        flag_CTF_ECC_ERROR_HWQ_1_CORRECTED_ERROR        = &H0
        write_CTF_ECC_ERROR_HWQ_0_UNCORRECTED_ERROR_value = &H0
        flag_CTF_ECC_ERROR_HWQ_0_UNCORRECTED_ERROR        = &H0
        write_CTF_ECC_ERROR_HWQ_0_CORRECTED_ERROR_value = &H0
        flag_CTF_ECC_ERROR_HWQ_0_CORRECTED_ERROR        = &H0
        write_CTF_ECC_ERROR_NEXT_HOP_UNCORRECTED_ERROR_value = &H0
        flag_CTF_ECC_ERROR_NEXT_HOP_UNCORRECTED_ERROR        = &H0
        write_CTF_ECC_ERROR_NEXT_HOP_CORRECTED_ERROR_value = &H0
        flag_CTF_ECC_ERROR_NEXT_HOP_CORRECTED_ERROR        = &H0
        write_CTF_ECC_ERROR_NAPT_FLOW_UNCORRECTED_ERROR_value = &H0
        flag_CTF_ECC_ERROR_NAPT_FLOW_UNCORRECTED_ERROR        = &H0
        write_CTF_ECC_ERROR_NAPT_FLOW_CORRECTED_ERROR_value = &H0
        flag_CTF_ECC_ERROR_NAPT_FLOW_CORRECTED_ERROR        = &H0
    End Sub
End Class


'' @REGISTER : CTF_ctf_ecc_error_mask
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CTF_ECC_ERROR_MASK_RESERVED                [31:12]          get_CTF_ECC_ERROR_MASK_RESERVED
''                                                             set_CTF_ECC_ERROR_MASK_RESERVED
''                                                             read_CTF_ECC_ERROR_MASK_RESERVED
''                                                             write_CTF_ECC_ERROR_MASK_RESERVED
''---------------------------------------------------------------------------------
'' CEEMHUEIE                                  [11:11]          get_CEEMHUEIE
''                                                             set_CEEMHUEIE
''                                                             read_CEEMHUEIE
''                                                             write_CEEMHUEIE
''---------------------------------------------------------------------------------
'' CEEMHCEIE1                                 [10:10]          get_CEEMHCEIE1
''                                                             set_CEEMHCEIE1
''                                                             read_CEEMHCEIE1
''                                                             write_CEEMHCEIE1
''---------------------------------------------------------------------------------
'' CEEMLUEIE1                                 [9:9]            get_CEEMLUEIE1
''                                                             set_CEEMLUEIE1
''                                                             read_CEEMLUEIE1
''                                                             write_CEEMLUEIE1
''---------------------------------------------------------------------------------
'' CEEMLCEIE1                                 [8:8]            get_CEEMLCEIE1
''                                                             set_CEEMLCEIE1
''                                                             read_CEEMLCEIE1
''                                                             write_CEEMLCEIE1
''---------------------------------------------------------------------------------
'' CEEMH1UEIE1                                [7:7]            get_CEEMH1UEIE1
''                                                             set_CEEMH1UEIE1
''                                                             read_CEEMH1UEIE1
''                                                             write_CEEMH1UEIE1
''---------------------------------------------------------------------------------
'' CEEMH1CEIE1                                [6:6]            get_CEEMH1CEIE1
''                                                             set_CEEMH1CEIE1
''                                                             read_CEEMH1CEIE1
''                                                             write_CEEMH1CEIE1
''---------------------------------------------------------------------------------
'' CEEMH0UEIE1                                [5:5]            get_CEEMH0UEIE1
''                                                             set_CEEMH0UEIE1
''                                                             read_CEEMH0UEIE1
''                                                             write_CEEMH0UEIE1
''---------------------------------------------------------------------------------
'' CEEMH0CEIE1                                [4:4]            get_CEEMH0CEIE1
''                                                             set_CEEMH0CEIE1
''                                                             read_CEEMH0CEIE1
''                                                             write_CEEMH0CEIE1
''---------------------------------------------------------------------------------
'' CEEMNHUEIE1                                [3:3]            get_CEEMNHUEIE1
''                                                             set_CEEMNHUEIE1
''                                                             read_CEEMNHUEIE1
''                                                             write_CEEMNHUEIE1
''---------------------------------------------------------------------------------
'' CEEMNHCEIE1                                [2:2]            get_CEEMNHCEIE1
''                                                             set_CEEMNHCEIE1
''                                                             read_CEEMNHCEIE1
''                                                             write_CEEMNHCEIE1
''---------------------------------------------------------------------------------
'' CEEMNFUEIE1                                [1:1]            get_CEEMNFUEIE1
''                                                             set_CEEMNFUEIE1
''                                                             read_CEEMNFUEIE1
''                                                             write_CEEMNFUEIE1
''---------------------------------------------------------------------------------
'' CEEMNFCEIE1                                [0:0]            get_CEEMNFCEIE1
''                                                             set_CEEMNFCEIE1
''                                                             read_CEEMNFCEIE1
''                                                             write_CEEMNFCEIE1
''---------------------------------------------------------------------------------
Class REGISTER_CTF_ctf_ecc_error_mask
    Private write_CTF_ECC_ERROR_MASK_RESERVED_value
    Private read_CTF_ECC_ERROR_MASK_RESERVED_value
    Private flag_CTF_ECC_ERROR_MASK_RESERVED
    Private write_CEEMHUEIE_value
    Private read_CEEMHUEIE_value
    Private flag_CEEMHUEIE
    Private write_CEEMHCEIE1_value
    Private read_CEEMHCEIE1_value
    Private flag_CEEMHCEIE1
    Private write_CEEMLUEIE1_value
    Private read_CEEMLUEIE1_value
    Private flag_CEEMLUEIE1
    Private write_CEEMLCEIE1_value
    Private read_CEEMLCEIE1_value
    Private flag_CEEMLCEIE1
    Private write_CEEMH1UEIE1_value
    Private read_CEEMH1UEIE1_value
    Private flag_CEEMH1UEIE1
    Private write_CEEMH1CEIE1_value
    Private read_CEEMH1CEIE1_value
    Private flag_CEEMH1CEIE1
    Private write_CEEMH0UEIE1_value
    Private read_CEEMH0UEIE1_value
    Private flag_CEEMH0UEIE1
    Private write_CEEMH0CEIE1_value
    Private read_CEEMH0CEIE1_value
    Private flag_CEEMH0CEIE1
    Private write_CEEMNHUEIE1_value
    Private read_CEEMNHUEIE1_value
    Private flag_CEEMNHUEIE1
    Private write_CEEMNHCEIE1_value
    Private read_CEEMNHCEIE1_value
    Private flag_CEEMNHCEIE1
    Private write_CEEMNFUEIE1_value
    Private read_CEEMNFUEIE1_value
    Private flag_CEEMNFUEIE1
    Private write_CEEMNFCEIE1_value
    Private read_CEEMNFCEIE1_value
    Private flag_CEEMNFCEIE1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H80
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_CTF_ECC_ERROR_MASK_RESERVED
        get_CTF_ECC_ERROR_MASK_RESERVED = read_CTF_ECC_ERROR_MASK_RESERVED_value
    End Property

    Property Let set_CTF_ECC_ERROR_MASK_RESERVED(aData)
        write_CTF_ECC_ERROR_MASK_RESERVED_value = aData
        flag_CTF_ECC_ERROR_MASK_RESERVED        = &H1
    End Property

    Property Get read_CTF_ECC_ERROR_MASK_RESERVED
        read
        read_CTF_ECC_ERROR_MASK_RESERVED = read_CTF_ECC_ERROR_MASK_RESERVED_value
    End Property

    Property Let write_CTF_ECC_ERROR_MASK_RESERVED(aData)
        set_CTF_ECC_ERROR_MASK_RESERVED = aData
        write
    End Property

    Property Get get_CEEMHUEIE
        get_CEEMHUEIE = read_CEEMHUEIE_value
    End Property

    Property Let set_CEEMHUEIE(aData)
        write_CEEMHUEIE_value = aData
        flag_CEEMHUEIE        = &H1
    End Property

    Property Get read_CEEMHUEIE
        read
        read_CEEMHUEIE = read_CEEMHUEIE_value
    End Property

    Property Let write_CEEMHUEIE(aData)
        set_CEEMHUEIE = aData
        write
    End Property

    Property Get get_CEEMHCEIE1
        get_CEEMHCEIE1 = read_CEEMHCEIE1_value
    End Property

    Property Let set_CEEMHCEIE1(aData)
        write_CEEMHCEIE1_value = aData
        flag_CEEMHCEIE1        = &H1
    End Property

    Property Get read_CEEMHCEIE1
        read
        read_CEEMHCEIE1 = read_CEEMHCEIE1_value
    End Property

    Property Let write_CEEMHCEIE1(aData)
        set_CEEMHCEIE1 = aData
        write
    End Property

    Property Get get_CEEMLUEIE1
        get_CEEMLUEIE1 = read_CEEMLUEIE1_value
    End Property

    Property Let set_CEEMLUEIE1(aData)
        write_CEEMLUEIE1_value = aData
        flag_CEEMLUEIE1        = &H1
    End Property

    Property Get read_CEEMLUEIE1
        read
        read_CEEMLUEIE1 = read_CEEMLUEIE1_value
    End Property

    Property Let write_CEEMLUEIE1(aData)
        set_CEEMLUEIE1 = aData
        write
    End Property

    Property Get get_CEEMLCEIE1
        get_CEEMLCEIE1 = read_CEEMLCEIE1_value
    End Property

    Property Let set_CEEMLCEIE1(aData)
        write_CEEMLCEIE1_value = aData
        flag_CEEMLCEIE1        = &H1
    End Property

    Property Get read_CEEMLCEIE1
        read
        read_CEEMLCEIE1 = read_CEEMLCEIE1_value
    End Property

    Property Let write_CEEMLCEIE1(aData)
        set_CEEMLCEIE1 = aData
        write
    End Property

    Property Get get_CEEMH1UEIE1
        get_CEEMH1UEIE1 = read_CEEMH1UEIE1_value
    End Property

    Property Let set_CEEMH1UEIE1(aData)
        write_CEEMH1UEIE1_value = aData
        flag_CEEMH1UEIE1        = &H1
    End Property

    Property Get read_CEEMH1UEIE1
        read
        read_CEEMH1UEIE1 = read_CEEMH1UEIE1_value
    End Property

    Property Let write_CEEMH1UEIE1(aData)
        set_CEEMH1UEIE1 = aData
        write
    End Property

    Property Get get_CEEMH1CEIE1
        get_CEEMH1CEIE1 = read_CEEMH1CEIE1_value
    End Property

    Property Let set_CEEMH1CEIE1(aData)
        write_CEEMH1CEIE1_value = aData
        flag_CEEMH1CEIE1        = &H1
    End Property

    Property Get read_CEEMH1CEIE1
        read
        read_CEEMH1CEIE1 = read_CEEMH1CEIE1_value
    End Property

    Property Let write_CEEMH1CEIE1(aData)
        set_CEEMH1CEIE1 = aData
        write
    End Property

    Property Get get_CEEMH0UEIE1
        get_CEEMH0UEIE1 = read_CEEMH0UEIE1_value
    End Property

    Property Let set_CEEMH0UEIE1(aData)
        write_CEEMH0UEIE1_value = aData
        flag_CEEMH0UEIE1        = &H1
    End Property

    Property Get read_CEEMH0UEIE1
        read
        read_CEEMH0UEIE1 = read_CEEMH0UEIE1_value
    End Property

    Property Let write_CEEMH0UEIE1(aData)
        set_CEEMH0UEIE1 = aData
        write
    End Property

    Property Get get_CEEMH0CEIE1
        get_CEEMH0CEIE1 = read_CEEMH0CEIE1_value
    End Property

    Property Let set_CEEMH0CEIE1(aData)
        write_CEEMH0CEIE1_value = aData
        flag_CEEMH0CEIE1        = &H1
    End Property

    Property Get read_CEEMH0CEIE1
        read
        read_CEEMH0CEIE1 = read_CEEMH0CEIE1_value
    End Property

    Property Let write_CEEMH0CEIE1(aData)
        set_CEEMH0CEIE1 = aData
        write
    End Property

    Property Get get_CEEMNHUEIE1
        get_CEEMNHUEIE1 = read_CEEMNHUEIE1_value
    End Property

    Property Let set_CEEMNHUEIE1(aData)
        write_CEEMNHUEIE1_value = aData
        flag_CEEMNHUEIE1        = &H1
    End Property

    Property Get read_CEEMNHUEIE1
        read
        read_CEEMNHUEIE1 = read_CEEMNHUEIE1_value
    End Property

    Property Let write_CEEMNHUEIE1(aData)
        set_CEEMNHUEIE1 = aData
        write
    End Property

    Property Get get_CEEMNHCEIE1
        get_CEEMNHCEIE1 = read_CEEMNHCEIE1_value
    End Property

    Property Let set_CEEMNHCEIE1(aData)
        write_CEEMNHCEIE1_value = aData
        flag_CEEMNHCEIE1        = &H1
    End Property

    Property Get read_CEEMNHCEIE1
        read
        read_CEEMNHCEIE1 = read_CEEMNHCEIE1_value
    End Property

    Property Let write_CEEMNHCEIE1(aData)
        set_CEEMNHCEIE1 = aData
        write
    End Property

    Property Get get_CEEMNFUEIE1
        get_CEEMNFUEIE1 = read_CEEMNFUEIE1_value
    End Property

    Property Let set_CEEMNFUEIE1(aData)
        write_CEEMNFUEIE1_value = aData
        flag_CEEMNFUEIE1        = &H1
    End Property

    Property Get read_CEEMNFUEIE1
        read
        read_CEEMNFUEIE1 = read_CEEMNFUEIE1_value
    End Property

    Property Let write_CEEMNFUEIE1(aData)
        set_CEEMNFUEIE1 = aData
        write
    End Property

    Property Get get_CEEMNFCEIE1
        get_CEEMNFCEIE1 = read_CEEMNFCEIE1_value
    End Property

    Property Let set_CEEMNFCEIE1(aData)
        write_CEEMNFCEIE1_value = aData
        flag_CEEMNFCEIE1        = &H1
    End Property

    Property Get read_CEEMNFCEIE1
        read
        read_CEEMNFCEIE1 = read_CEEMNFCEIE1_value
    End Property

    Property Let write_CEEMNFCEIE1(aData)
        set_CEEMNFCEIE1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CTF_ECC_ERROR_MASK_RESERVED_value = rightShift(data_low, 12) and &Hfffff
        read_CEEMHUEIE_value = rightShift(data_low, 11) and &H1
        read_CEEMHCEIE1_value = rightShift(data_low, 10) and &H1
        read_CEEMLUEIE1_value = rightShift(data_low, 9) and &H1
        read_CEEMLCEIE1_value = rightShift(data_low, 8) and &H1
        read_CEEMH1UEIE1_value = rightShift(data_low, 7) and &H1
        read_CEEMH1CEIE1_value = rightShift(data_low, 6) and &H1
        read_CEEMH0UEIE1_value = rightShift(data_low, 5) and &H1
        read_CEEMH0CEIE1_value = rightShift(data_low, 4) and &H1
        read_CEEMNHUEIE1_value = rightShift(data_low, 3) and &H1
        read_CEEMNHCEIE1_value = rightShift(data_low, 2) and &H1
        read_CEEMNFUEIE1_value = rightShift(data_low, 1) and &H1
        CEEMNFCEIE1_mask = &H1
        if data_low > LONG_MAX then
            if CEEMNFCEIE1_mask = mask then
                read_CEEMNFCEIE1_value = data_low
            else
                read_CEEMNFCEIE1_value = (data_low - H8000_0000) and CEEMNFCEIE1_mask
            end If
        else
            read_CEEMNFCEIE1_value = data_low and CEEMNFCEIE1_mask
        end If

    End Sub

    Sub write
        If flag_CTF_ECC_ERROR_MASK_RESERVED = &H0 or flag_CEEMHUEIE = &H0 or flag_CEEMHCEIE1 = &H0 or flag_CEEMLUEIE1 = &H0 or flag_CEEMLCEIE1 = &H0 or flag_CEEMH1UEIE1 = &H0 or flag_CEEMH1CEIE1 = &H0 or flag_CEEMH0UEIE1 = &H0 or flag_CEEMH0CEIE1 = &H0 or flag_CEEMNHUEIE1 = &H0 or flag_CEEMNHCEIE1 = &H0 or flag_CEEMNFUEIE1 = &H0 or flag_CEEMNFCEIE1 = &H0 Then read
        If flag_CTF_ECC_ERROR_MASK_RESERVED = &H0 Then write_CTF_ECC_ERROR_MASK_RESERVED_value = get_CTF_ECC_ERROR_MASK_RESERVED
        If flag_CEEMHUEIE = &H0 Then write_CEEMHUEIE_value = get_CEEMHUEIE
        If flag_CEEMHCEIE1 = &H0 Then write_CEEMHCEIE1_value = get_CEEMHCEIE1
        If flag_CEEMLUEIE1 = &H0 Then write_CEEMLUEIE1_value = get_CEEMLUEIE1
        If flag_CEEMLCEIE1 = &H0 Then write_CEEMLCEIE1_value = get_CEEMLCEIE1
        If flag_CEEMH1UEIE1 = &H0 Then write_CEEMH1UEIE1_value = get_CEEMH1UEIE1
        If flag_CEEMH1CEIE1 = &H0 Then write_CEEMH1CEIE1_value = get_CEEMH1CEIE1
        If flag_CEEMH0UEIE1 = &H0 Then write_CEEMH0UEIE1_value = get_CEEMH0UEIE1
        If flag_CEEMH0CEIE1 = &H0 Then write_CEEMH0CEIE1_value = get_CEEMH0CEIE1
        If flag_CEEMNHUEIE1 = &H0 Then write_CEEMNHUEIE1_value = get_CEEMNHUEIE1
        If flag_CEEMNHCEIE1 = &H0 Then write_CEEMNHCEIE1_value = get_CEEMNHCEIE1
        If flag_CEEMNFUEIE1 = &H0 Then write_CEEMNFUEIE1_value = get_CEEMNFUEIE1
        If flag_CEEMNFCEIE1 = &H0 Then write_CEEMNFCEIE1_value = get_CEEMNFCEIE1

        regValue = leftShift((write_CTF_ECC_ERROR_MASK_RESERVED_value and &Hfffff), 12) + leftShift((write_CEEMHUEIE_value and &H1), 11) + leftShift((write_CEEMHCEIE1_value and &H1), 10) + leftShift((write_CEEMLUEIE1_value and &H1), 9) + leftShift((write_CEEMLCEIE1_value and &H1), 8) + leftShift((write_CEEMH1UEIE1_value and &H1), 7) + leftShift((write_CEEMH1CEIE1_value and &H1), 6) + leftShift((write_CEEMH0UEIE1_value and &H1), 5) + leftShift((write_CEEMH0CEIE1_value and &H1), 4) + leftShift((write_CEEMNHUEIE1_value and &H1), 3) + leftShift((write_CEEMNHCEIE1_value and &H1), 2) + leftShift((write_CEEMNFUEIE1_value and &H1), 1) + leftShift((write_CEEMNFCEIE1_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CTF_ECC_ERROR_MASK_RESERVED_value = rightShift(data_low, 12) and &Hfffff
        read_CEEMHUEIE_value = rightShift(data_low, 11) and &H1
        read_CEEMHCEIE1_value = rightShift(data_low, 10) and &H1
        read_CEEMLUEIE1_value = rightShift(data_low, 9) and &H1
        read_CEEMLCEIE1_value = rightShift(data_low, 8) and &H1
        read_CEEMH1UEIE1_value = rightShift(data_low, 7) and &H1
        read_CEEMH1CEIE1_value = rightShift(data_low, 6) and &H1
        read_CEEMH0UEIE1_value = rightShift(data_low, 5) and &H1
        read_CEEMH0CEIE1_value = rightShift(data_low, 4) and &H1
        read_CEEMNHUEIE1_value = rightShift(data_low, 3) and &H1
        read_CEEMNHCEIE1_value = rightShift(data_low, 2) and &H1
        read_CEEMNFUEIE1_value = rightShift(data_low, 1) and &H1
        CEEMNFCEIE1_mask = &H1
        if data_low > LONG_MAX then
            if CEEMNFCEIE1_mask = mask then
                read_CEEMNFCEIE1_value = data_low
            else
                read_CEEMNFCEIE1_value = (data_low - H8000_0000) and CEEMNFCEIE1_mask
            end If
        else
            read_CEEMNFCEIE1_value = data_low and CEEMNFCEIE1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CTF_ECC_ERROR_MASK_RESERVED_value = &H0
        flag_CTF_ECC_ERROR_MASK_RESERVED        = &H0
        write_CEEMHUEIE_value = &H0
        flag_CEEMHUEIE        = &H0
        write_CEEMHCEIE1_value = &H0
        flag_CEEMHCEIE1        = &H0
        write_CEEMLUEIE1_value = &H0
        flag_CEEMLUEIE1        = &H0
        write_CEEMLCEIE1_value = &H0
        flag_CEEMLCEIE1        = &H0
        write_CEEMH1UEIE1_value = &H0
        flag_CEEMH1UEIE1        = &H0
        write_CEEMH1CEIE1_value = &H0
        flag_CEEMH1CEIE1        = &H0
        write_CEEMH0UEIE1_value = &H0
        flag_CEEMH0UEIE1        = &H0
        write_CEEMH0CEIE1_value = &H0
        flag_CEEMH0CEIE1        = &H0
        write_CEEMNHUEIE1_value = &H0
        flag_CEEMNHUEIE1        = &H0
        write_CEEMNHCEIE1_value = &H0
        flag_CEEMNHCEIE1        = &H0
        write_CEEMNFUEIE1_value = &H0
        flag_CEEMNFUEIE1        = &H0
        write_CEEMNFCEIE1_value = &H0
        flag_CEEMNFCEIE1        = &H0
    End Sub
End Class


'' @REGISTER : CTF_ctf_ecc_napt_flow_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CTF_ECC_NAPT_FLOW_STATUS_RESERVED          [31:10]          get_CTF_ECC_NAPT_FLOW_STATUS_RESERVED
''                                                             set_CTF_ECC_NAPT_FLOW_STATUS_RESERVED
''                                                             read_CTF_ECC_NAPT_FLOW_STATUS_RESERVED
''                                                             write_CTF_ECC_NAPT_FLOW_STATUS_RESERVED
''---------------------------------------------------------------------------------
'' CENFSNFEA                                  [9:0]            get_CENFSNFEA
''                                                             set_CENFSNFEA
''                                                             read_CENFSNFEA
''                                                             write_CENFSNFEA
''---------------------------------------------------------------------------------
Class REGISTER_CTF_ctf_ecc_napt_flow_status
    Private write_CTF_ECC_NAPT_FLOW_STATUS_RESERVED_value
    Private read_CTF_ECC_NAPT_FLOW_STATUS_RESERVED_value
    Private flag_CTF_ECC_NAPT_FLOW_STATUS_RESERVED
    Private write_CENFSNFEA_value
    Private read_CENFSNFEA_value
    Private flag_CENFSNFEA

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H84
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_CTF_ECC_NAPT_FLOW_STATUS_RESERVED
        get_CTF_ECC_NAPT_FLOW_STATUS_RESERVED = read_CTF_ECC_NAPT_FLOW_STATUS_RESERVED_value
    End Property

    Property Let set_CTF_ECC_NAPT_FLOW_STATUS_RESERVED(aData)
        write_CTF_ECC_NAPT_FLOW_STATUS_RESERVED_value = aData
        flag_CTF_ECC_NAPT_FLOW_STATUS_RESERVED        = &H1
    End Property

    Property Get read_CTF_ECC_NAPT_FLOW_STATUS_RESERVED
        read
        read_CTF_ECC_NAPT_FLOW_STATUS_RESERVED = read_CTF_ECC_NAPT_FLOW_STATUS_RESERVED_value
    End Property

    Property Let write_CTF_ECC_NAPT_FLOW_STATUS_RESERVED(aData)
        set_CTF_ECC_NAPT_FLOW_STATUS_RESERVED = aData
        write
    End Property

    Property Get get_CENFSNFEA
        get_CENFSNFEA = read_CENFSNFEA_value
    End Property

    Property Let set_CENFSNFEA(aData)
        write_CENFSNFEA_value = aData
        flag_CENFSNFEA        = &H1
    End Property

    Property Get read_CENFSNFEA
        read
        read_CENFSNFEA = read_CENFSNFEA_value
    End Property

    Property Let write_CENFSNFEA(aData)
        set_CENFSNFEA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CTF_ECC_NAPT_FLOW_STATUS_RESERVED_value = rightShift(data_low, 10) and &H3fffff
        CENFSNFEA_mask = &H3ff
        if data_low > LONG_MAX then
            if CENFSNFEA_mask = mask then
                read_CENFSNFEA_value = data_low
            else
                read_CENFSNFEA_value = (data_low - H8000_0000) and CENFSNFEA_mask
            end If
        else
            read_CENFSNFEA_value = data_low and CENFSNFEA_mask
        end If

    End Sub

    Sub write
        If flag_CTF_ECC_NAPT_FLOW_STATUS_RESERVED = &H0 or flag_CENFSNFEA = &H0 Then read
        If flag_CTF_ECC_NAPT_FLOW_STATUS_RESERVED = &H0 Then write_CTF_ECC_NAPT_FLOW_STATUS_RESERVED_value = get_CTF_ECC_NAPT_FLOW_STATUS_RESERVED
        If flag_CENFSNFEA = &H0 Then write_CENFSNFEA_value = get_CENFSNFEA

        regValue = leftShift((write_CTF_ECC_NAPT_FLOW_STATUS_RESERVED_value and &H3fffff), 10) + leftShift((write_CENFSNFEA_value and &H3ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CTF_ECC_NAPT_FLOW_STATUS_RESERVED_value = rightShift(data_low, 10) and &H3fffff
        CENFSNFEA_mask = &H3ff
        if data_low > LONG_MAX then
            if CENFSNFEA_mask = mask then
                read_CENFSNFEA_value = data_low
            else
                read_CENFSNFEA_value = (data_low - H8000_0000) and CENFSNFEA_mask
            end If
        else
            read_CENFSNFEA_value = data_low and CENFSNFEA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CTF_ECC_NAPT_FLOW_STATUS_RESERVED_value = &H0
        flag_CTF_ECC_NAPT_FLOW_STATUS_RESERVED        = &H0
        write_CENFSNFEA_value = &H0
        flag_CENFSNFEA        = &H0
    End Sub
End Class


'' @REGISTER : CTF_ctf_ecc_next_hop_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CTF_ECC_NEXT_HOP_STATUS_RESERVED           [31:7]           get_CTF_ECC_NEXT_HOP_STATUS_RESERVED
''                                                             set_CTF_ECC_NEXT_HOP_STATUS_RESERVED
''                                                             read_CTF_ECC_NEXT_HOP_STATUS_RESERVED
''                                                             write_CTF_ECC_NEXT_HOP_STATUS_RESERVED
''---------------------------------------------------------------------------------
'' CTF_ECC_NEXT_HOP_STATUS_NEXT_HOP_ERROR_ADDRESS   [6:0]            get_CTF_ECC_NEXT_HOP_STATUS_NEXT_HOP_ERROR_ADDRESS
''                                                             set_CTF_ECC_NEXT_HOP_STATUS_NEXT_HOP_ERROR_ADDRESS
''                                                             read_CTF_ECC_NEXT_HOP_STATUS_NEXT_HOP_ERROR_ADDRESS
''                                                             write_CTF_ECC_NEXT_HOP_STATUS_NEXT_HOP_ERROR_ADDRESS
''---------------------------------------------------------------------------------
Class REGISTER_CTF_ctf_ecc_next_hop_status
    Private write_CTF_ECC_NEXT_HOP_STATUS_RESERVED_value
    Private read_CTF_ECC_NEXT_HOP_STATUS_RESERVED_value
    Private flag_CTF_ECC_NEXT_HOP_STATUS_RESERVED
    Private write_CTF_ECC_NEXT_HOP_STATUS_NEXT_HOP_ERROR_ADDRESS_value
    Private read_CTF_ECC_NEXT_HOP_STATUS_NEXT_HOP_ERROR_ADDRESS_value
    Private flag_CTF_ECC_NEXT_HOP_STATUS_NEXT_HOP_ERROR_ADDRESS

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H88
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_CTF_ECC_NEXT_HOP_STATUS_RESERVED
        get_CTF_ECC_NEXT_HOP_STATUS_RESERVED = read_CTF_ECC_NEXT_HOP_STATUS_RESERVED_value
    End Property

    Property Let set_CTF_ECC_NEXT_HOP_STATUS_RESERVED(aData)
        write_CTF_ECC_NEXT_HOP_STATUS_RESERVED_value = aData
        flag_CTF_ECC_NEXT_HOP_STATUS_RESERVED        = &H1
    End Property

    Property Get read_CTF_ECC_NEXT_HOP_STATUS_RESERVED
        read
        read_CTF_ECC_NEXT_HOP_STATUS_RESERVED = read_CTF_ECC_NEXT_HOP_STATUS_RESERVED_value
    End Property

    Property Let write_CTF_ECC_NEXT_HOP_STATUS_RESERVED(aData)
        set_CTF_ECC_NEXT_HOP_STATUS_RESERVED = aData
        write
    End Property

    Property Get get_CTF_ECC_NEXT_HOP_STATUS_NEXT_HOP_ERROR_ADDRESS
        get_CTF_ECC_NEXT_HOP_STATUS_NEXT_HOP_ERROR_ADDRESS = read_CTF_ECC_NEXT_HOP_STATUS_NEXT_HOP_ERROR_ADDRESS_value
    End Property

    Property Let set_CTF_ECC_NEXT_HOP_STATUS_NEXT_HOP_ERROR_ADDRESS(aData)
        write_CTF_ECC_NEXT_HOP_STATUS_NEXT_HOP_ERROR_ADDRESS_value = aData
        flag_CTF_ECC_NEXT_HOP_STATUS_NEXT_HOP_ERROR_ADDRESS        = &H1
    End Property

    Property Get read_CTF_ECC_NEXT_HOP_STATUS_NEXT_HOP_ERROR_ADDRESS
        read
        read_CTF_ECC_NEXT_HOP_STATUS_NEXT_HOP_ERROR_ADDRESS = read_CTF_ECC_NEXT_HOP_STATUS_NEXT_HOP_ERROR_ADDRESS_value
    End Property

    Property Let write_CTF_ECC_NEXT_HOP_STATUS_NEXT_HOP_ERROR_ADDRESS(aData)
        set_CTF_ECC_NEXT_HOP_STATUS_NEXT_HOP_ERROR_ADDRESS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CTF_ECC_NEXT_HOP_STATUS_RESERVED_value = rightShift(data_low, 7) and &H1ffffff
        CTF_ECC_NEXT_HOP_STATUS_NEXT_HOP_ERROR_ADDRESS_mask = &H7f
        if data_low > LONG_MAX then
            if CTF_ECC_NEXT_HOP_STATUS_NEXT_HOP_ERROR_ADDRESS_mask = mask then
                read_CTF_ECC_NEXT_HOP_STATUS_NEXT_HOP_ERROR_ADDRESS_value = data_low
            else
                read_CTF_ECC_NEXT_HOP_STATUS_NEXT_HOP_ERROR_ADDRESS_value = (data_low - H8000_0000) and CTF_ECC_NEXT_HOP_STATUS_NEXT_HOP_ERROR_ADDRESS_mask
            end If
        else
            read_CTF_ECC_NEXT_HOP_STATUS_NEXT_HOP_ERROR_ADDRESS_value = data_low and CTF_ECC_NEXT_HOP_STATUS_NEXT_HOP_ERROR_ADDRESS_mask
        end If

    End Sub

    Sub write
        If flag_CTF_ECC_NEXT_HOP_STATUS_RESERVED = &H0 or flag_CTF_ECC_NEXT_HOP_STATUS_NEXT_HOP_ERROR_ADDRESS = &H0 Then read
        If flag_CTF_ECC_NEXT_HOP_STATUS_RESERVED = &H0 Then write_CTF_ECC_NEXT_HOP_STATUS_RESERVED_value = get_CTF_ECC_NEXT_HOP_STATUS_RESERVED
        If flag_CTF_ECC_NEXT_HOP_STATUS_NEXT_HOP_ERROR_ADDRESS = &H0 Then write_CTF_ECC_NEXT_HOP_STATUS_NEXT_HOP_ERROR_ADDRESS_value = get_CTF_ECC_NEXT_HOP_STATUS_NEXT_HOP_ERROR_ADDRESS

        regValue = leftShift((write_CTF_ECC_NEXT_HOP_STATUS_RESERVED_value and &H1ffffff), 7) + leftShift((write_CTF_ECC_NEXT_HOP_STATUS_NEXT_HOP_ERROR_ADDRESS_value and &H7f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CTF_ECC_NEXT_HOP_STATUS_RESERVED_value = rightShift(data_low, 7) and &H1ffffff
        CTF_ECC_NEXT_HOP_STATUS_NEXT_HOP_ERROR_ADDRESS_mask = &H7f
        if data_low > LONG_MAX then
            if CTF_ECC_NEXT_HOP_STATUS_NEXT_HOP_ERROR_ADDRESS_mask = mask then
                read_CTF_ECC_NEXT_HOP_STATUS_NEXT_HOP_ERROR_ADDRESS_value = data_low
            else
                read_CTF_ECC_NEXT_HOP_STATUS_NEXT_HOP_ERROR_ADDRESS_value = (data_low - H8000_0000) and CTF_ECC_NEXT_HOP_STATUS_NEXT_HOP_ERROR_ADDRESS_mask
            end If
        else
            read_CTF_ECC_NEXT_HOP_STATUS_NEXT_HOP_ERROR_ADDRESS_value = data_low and CTF_ECC_NEXT_HOP_STATUS_NEXT_HOP_ERROR_ADDRESS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CTF_ECC_NEXT_HOP_STATUS_RESERVED_value = &H0
        flag_CTF_ECC_NEXT_HOP_STATUS_RESERVED        = &H0
        write_CTF_ECC_NEXT_HOP_STATUS_NEXT_HOP_ERROR_ADDRESS_value = &H0
        flag_CTF_ECC_NEXT_HOP_STATUS_NEXT_HOP_ERROR_ADDRESS        = &H0
    End Sub
End Class


'' @REGISTER : CTF_ctf_ecc_hwq_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CTF_ECC_HWQ_STATUS_RESERVED                [31:16]          get_CTF_ECC_HWQ_STATUS_RESERVED
''                                                             set_CTF_ECC_HWQ_STATUS_RESERVED
''                                                             read_CTF_ECC_HWQ_STATUS_RESERVED
''                                                             write_CTF_ECC_HWQ_STATUS_RESERVED
''---------------------------------------------------------------------------------
'' CTF_ECC_HWQ_STATUS_HWQ_1_ERROR_ADDRESS     [15:8]           get_CTF_ECC_HWQ_STATUS_HWQ_1_ERROR_ADDRESS
''                                                             set_CTF_ECC_HWQ_STATUS_HWQ_1_ERROR_ADDRESS
''                                                             read_CTF_ECC_HWQ_STATUS_HWQ_1_ERROR_ADDRESS
''                                                             write_CTF_ECC_HWQ_STATUS_HWQ_1_ERROR_ADDRESS
''---------------------------------------------------------------------------------
'' CTF_ECC_HWQ_STATUS_HWQ_0_ERROR_ADDRESS     [7:0]            get_CTF_ECC_HWQ_STATUS_HWQ_0_ERROR_ADDRESS
''                                                             set_CTF_ECC_HWQ_STATUS_HWQ_0_ERROR_ADDRESS
''                                                             read_CTF_ECC_HWQ_STATUS_HWQ_0_ERROR_ADDRESS
''                                                             write_CTF_ECC_HWQ_STATUS_HWQ_0_ERROR_ADDRESS
''---------------------------------------------------------------------------------
Class REGISTER_CTF_ctf_ecc_hwq_status
    Private write_CTF_ECC_HWQ_STATUS_RESERVED_value
    Private read_CTF_ECC_HWQ_STATUS_RESERVED_value
    Private flag_CTF_ECC_HWQ_STATUS_RESERVED
    Private write_CTF_ECC_HWQ_STATUS_HWQ_1_ERROR_ADDRESS_value
    Private read_CTF_ECC_HWQ_STATUS_HWQ_1_ERROR_ADDRESS_value
    Private flag_CTF_ECC_HWQ_STATUS_HWQ_1_ERROR_ADDRESS
    Private write_CTF_ECC_HWQ_STATUS_HWQ_0_ERROR_ADDRESS_value
    Private read_CTF_ECC_HWQ_STATUS_HWQ_0_ERROR_ADDRESS_value
    Private flag_CTF_ECC_HWQ_STATUS_HWQ_0_ERROR_ADDRESS

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H8c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_CTF_ECC_HWQ_STATUS_RESERVED
        get_CTF_ECC_HWQ_STATUS_RESERVED = read_CTF_ECC_HWQ_STATUS_RESERVED_value
    End Property

    Property Let set_CTF_ECC_HWQ_STATUS_RESERVED(aData)
        write_CTF_ECC_HWQ_STATUS_RESERVED_value = aData
        flag_CTF_ECC_HWQ_STATUS_RESERVED        = &H1
    End Property

    Property Get read_CTF_ECC_HWQ_STATUS_RESERVED
        read
        read_CTF_ECC_HWQ_STATUS_RESERVED = read_CTF_ECC_HWQ_STATUS_RESERVED_value
    End Property

    Property Let write_CTF_ECC_HWQ_STATUS_RESERVED(aData)
        set_CTF_ECC_HWQ_STATUS_RESERVED = aData
        write
    End Property

    Property Get get_CTF_ECC_HWQ_STATUS_HWQ_1_ERROR_ADDRESS
        get_CTF_ECC_HWQ_STATUS_HWQ_1_ERROR_ADDRESS = read_CTF_ECC_HWQ_STATUS_HWQ_1_ERROR_ADDRESS_value
    End Property

    Property Let set_CTF_ECC_HWQ_STATUS_HWQ_1_ERROR_ADDRESS(aData)
        write_CTF_ECC_HWQ_STATUS_HWQ_1_ERROR_ADDRESS_value = aData
        flag_CTF_ECC_HWQ_STATUS_HWQ_1_ERROR_ADDRESS        = &H1
    End Property

    Property Get read_CTF_ECC_HWQ_STATUS_HWQ_1_ERROR_ADDRESS
        read
        read_CTF_ECC_HWQ_STATUS_HWQ_1_ERROR_ADDRESS = read_CTF_ECC_HWQ_STATUS_HWQ_1_ERROR_ADDRESS_value
    End Property

    Property Let write_CTF_ECC_HWQ_STATUS_HWQ_1_ERROR_ADDRESS(aData)
        set_CTF_ECC_HWQ_STATUS_HWQ_1_ERROR_ADDRESS = aData
        write
    End Property

    Property Get get_CTF_ECC_HWQ_STATUS_HWQ_0_ERROR_ADDRESS
        get_CTF_ECC_HWQ_STATUS_HWQ_0_ERROR_ADDRESS = read_CTF_ECC_HWQ_STATUS_HWQ_0_ERROR_ADDRESS_value
    End Property

    Property Let set_CTF_ECC_HWQ_STATUS_HWQ_0_ERROR_ADDRESS(aData)
        write_CTF_ECC_HWQ_STATUS_HWQ_0_ERROR_ADDRESS_value = aData
        flag_CTF_ECC_HWQ_STATUS_HWQ_0_ERROR_ADDRESS        = &H1
    End Property

    Property Get read_CTF_ECC_HWQ_STATUS_HWQ_0_ERROR_ADDRESS
        read
        read_CTF_ECC_HWQ_STATUS_HWQ_0_ERROR_ADDRESS = read_CTF_ECC_HWQ_STATUS_HWQ_0_ERROR_ADDRESS_value
    End Property

    Property Let write_CTF_ECC_HWQ_STATUS_HWQ_0_ERROR_ADDRESS(aData)
        set_CTF_ECC_HWQ_STATUS_HWQ_0_ERROR_ADDRESS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CTF_ECC_HWQ_STATUS_RESERVED_value = rightShift(data_low, 16) and &Hffff
        read_CTF_ECC_HWQ_STATUS_HWQ_1_ERROR_ADDRESS_value = rightShift(data_low, 8) and &Hff
        CTF_ECC_HWQ_STATUS_HWQ_0_ERROR_ADDRESS_mask = &Hff
        if data_low > LONG_MAX then
            if CTF_ECC_HWQ_STATUS_HWQ_0_ERROR_ADDRESS_mask = mask then
                read_CTF_ECC_HWQ_STATUS_HWQ_0_ERROR_ADDRESS_value = data_low
            else
                read_CTF_ECC_HWQ_STATUS_HWQ_0_ERROR_ADDRESS_value = (data_low - H8000_0000) and CTF_ECC_HWQ_STATUS_HWQ_0_ERROR_ADDRESS_mask
            end If
        else
            read_CTF_ECC_HWQ_STATUS_HWQ_0_ERROR_ADDRESS_value = data_low and CTF_ECC_HWQ_STATUS_HWQ_0_ERROR_ADDRESS_mask
        end If

    End Sub

    Sub write
        If flag_CTF_ECC_HWQ_STATUS_RESERVED = &H0 or flag_CTF_ECC_HWQ_STATUS_HWQ_1_ERROR_ADDRESS = &H0 or flag_CTF_ECC_HWQ_STATUS_HWQ_0_ERROR_ADDRESS = &H0 Then read
        If flag_CTF_ECC_HWQ_STATUS_RESERVED = &H0 Then write_CTF_ECC_HWQ_STATUS_RESERVED_value = get_CTF_ECC_HWQ_STATUS_RESERVED
        If flag_CTF_ECC_HWQ_STATUS_HWQ_1_ERROR_ADDRESS = &H0 Then write_CTF_ECC_HWQ_STATUS_HWQ_1_ERROR_ADDRESS_value = get_CTF_ECC_HWQ_STATUS_HWQ_1_ERROR_ADDRESS
        If flag_CTF_ECC_HWQ_STATUS_HWQ_0_ERROR_ADDRESS = &H0 Then write_CTF_ECC_HWQ_STATUS_HWQ_0_ERROR_ADDRESS_value = get_CTF_ECC_HWQ_STATUS_HWQ_0_ERROR_ADDRESS

        regValue = leftShift((write_CTF_ECC_HWQ_STATUS_RESERVED_value and &Hffff), 16) + leftShift((write_CTF_ECC_HWQ_STATUS_HWQ_1_ERROR_ADDRESS_value and &Hff), 8) + leftShift((write_CTF_ECC_HWQ_STATUS_HWQ_0_ERROR_ADDRESS_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CTF_ECC_HWQ_STATUS_RESERVED_value = rightShift(data_low, 16) and &Hffff
        read_CTF_ECC_HWQ_STATUS_HWQ_1_ERROR_ADDRESS_value = rightShift(data_low, 8) and &Hff
        CTF_ECC_HWQ_STATUS_HWQ_0_ERROR_ADDRESS_mask = &Hff
        if data_low > LONG_MAX then
            if CTF_ECC_HWQ_STATUS_HWQ_0_ERROR_ADDRESS_mask = mask then
                read_CTF_ECC_HWQ_STATUS_HWQ_0_ERROR_ADDRESS_value = data_low
            else
                read_CTF_ECC_HWQ_STATUS_HWQ_0_ERROR_ADDRESS_value = (data_low - H8000_0000) and CTF_ECC_HWQ_STATUS_HWQ_0_ERROR_ADDRESS_mask
            end If
        else
            read_CTF_ECC_HWQ_STATUS_HWQ_0_ERROR_ADDRESS_value = data_low and CTF_ECC_HWQ_STATUS_HWQ_0_ERROR_ADDRESS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CTF_ECC_HWQ_STATUS_RESERVED_value = &H0
        flag_CTF_ECC_HWQ_STATUS_RESERVED        = &H0
        write_CTF_ECC_HWQ_STATUS_HWQ_1_ERROR_ADDRESS_value = &H0
        flag_CTF_ECC_HWQ_STATUS_HWQ_1_ERROR_ADDRESS        = &H0
        write_CTF_ECC_HWQ_STATUS_HWQ_0_ERROR_ADDRESS_value = &H0
        flag_CTF_ECC_HWQ_STATUS_HWQ_0_ERROR_ADDRESS        = &H0
    End Sub
End Class


'' @REGISTER : CTF_ctf_ecc_lab_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CTF_ECC_LAB_STATUS_RESERVED                [31:5]           get_CTF_ECC_LAB_STATUS_RESERVED
''                                                             set_CTF_ECC_LAB_STATUS_RESERVED
''                                                             read_CTF_ECC_LAB_STATUS_RESERVED
''                                                             write_CTF_ECC_LAB_STATUS_RESERVED
''---------------------------------------------------------------------------------
'' CTF_ECC_LAB_STATUS_LAB_ERROR_ADDRESS       [4:0]            get_CTF_ECC_LAB_STATUS_LAB_ERROR_ADDRESS
''                                                             set_CTF_ECC_LAB_STATUS_LAB_ERROR_ADDRESS
''                                                             read_CTF_ECC_LAB_STATUS_LAB_ERROR_ADDRESS
''                                                             write_CTF_ECC_LAB_STATUS_LAB_ERROR_ADDRESS
''---------------------------------------------------------------------------------
Class REGISTER_CTF_ctf_ecc_lab_status
    Private write_CTF_ECC_LAB_STATUS_RESERVED_value
    Private read_CTF_ECC_LAB_STATUS_RESERVED_value
    Private flag_CTF_ECC_LAB_STATUS_RESERVED
    Private write_CTF_ECC_LAB_STATUS_LAB_ERROR_ADDRESS_value
    Private read_CTF_ECC_LAB_STATUS_LAB_ERROR_ADDRESS_value
    Private flag_CTF_ECC_LAB_STATUS_LAB_ERROR_ADDRESS

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H90
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_CTF_ECC_LAB_STATUS_RESERVED
        get_CTF_ECC_LAB_STATUS_RESERVED = read_CTF_ECC_LAB_STATUS_RESERVED_value
    End Property

    Property Let set_CTF_ECC_LAB_STATUS_RESERVED(aData)
        write_CTF_ECC_LAB_STATUS_RESERVED_value = aData
        flag_CTF_ECC_LAB_STATUS_RESERVED        = &H1
    End Property

    Property Get read_CTF_ECC_LAB_STATUS_RESERVED
        read
        read_CTF_ECC_LAB_STATUS_RESERVED = read_CTF_ECC_LAB_STATUS_RESERVED_value
    End Property

    Property Let write_CTF_ECC_LAB_STATUS_RESERVED(aData)
        set_CTF_ECC_LAB_STATUS_RESERVED = aData
        write
    End Property

    Property Get get_CTF_ECC_LAB_STATUS_LAB_ERROR_ADDRESS
        get_CTF_ECC_LAB_STATUS_LAB_ERROR_ADDRESS = read_CTF_ECC_LAB_STATUS_LAB_ERROR_ADDRESS_value
    End Property

    Property Let set_CTF_ECC_LAB_STATUS_LAB_ERROR_ADDRESS(aData)
        write_CTF_ECC_LAB_STATUS_LAB_ERROR_ADDRESS_value = aData
        flag_CTF_ECC_LAB_STATUS_LAB_ERROR_ADDRESS        = &H1
    End Property

    Property Get read_CTF_ECC_LAB_STATUS_LAB_ERROR_ADDRESS
        read
        read_CTF_ECC_LAB_STATUS_LAB_ERROR_ADDRESS = read_CTF_ECC_LAB_STATUS_LAB_ERROR_ADDRESS_value
    End Property

    Property Let write_CTF_ECC_LAB_STATUS_LAB_ERROR_ADDRESS(aData)
        set_CTF_ECC_LAB_STATUS_LAB_ERROR_ADDRESS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CTF_ECC_LAB_STATUS_RESERVED_value = rightShift(data_low, 5) and &H7ffffff
        CTF_ECC_LAB_STATUS_LAB_ERROR_ADDRESS_mask = &H1f
        if data_low > LONG_MAX then
            if CTF_ECC_LAB_STATUS_LAB_ERROR_ADDRESS_mask = mask then
                read_CTF_ECC_LAB_STATUS_LAB_ERROR_ADDRESS_value = data_low
            else
                read_CTF_ECC_LAB_STATUS_LAB_ERROR_ADDRESS_value = (data_low - H8000_0000) and CTF_ECC_LAB_STATUS_LAB_ERROR_ADDRESS_mask
            end If
        else
            read_CTF_ECC_LAB_STATUS_LAB_ERROR_ADDRESS_value = data_low and CTF_ECC_LAB_STATUS_LAB_ERROR_ADDRESS_mask
        end If

    End Sub

    Sub write
        If flag_CTF_ECC_LAB_STATUS_RESERVED = &H0 or flag_CTF_ECC_LAB_STATUS_LAB_ERROR_ADDRESS = &H0 Then read
        If flag_CTF_ECC_LAB_STATUS_RESERVED = &H0 Then write_CTF_ECC_LAB_STATUS_RESERVED_value = get_CTF_ECC_LAB_STATUS_RESERVED
        If flag_CTF_ECC_LAB_STATUS_LAB_ERROR_ADDRESS = &H0 Then write_CTF_ECC_LAB_STATUS_LAB_ERROR_ADDRESS_value = get_CTF_ECC_LAB_STATUS_LAB_ERROR_ADDRESS

        regValue = leftShift((write_CTF_ECC_LAB_STATUS_RESERVED_value and &H7ffffff), 5) + leftShift((write_CTF_ECC_LAB_STATUS_LAB_ERROR_ADDRESS_value and &H1f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CTF_ECC_LAB_STATUS_RESERVED_value = rightShift(data_low, 5) and &H7ffffff
        CTF_ECC_LAB_STATUS_LAB_ERROR_ADDRESS_mask = &H1f
        if data_low > LONG_MAX then
            if CTF_ECC_LAB_STATUS_LAB_ERROR_ADDRESS_mask = mask then
                read_CTF_ECC_LAB_STATUS_LAB_ERROR_ADDRESS_value = data_low
            else
                read_CTF_ECC_LAB_STATUS_LAB_ERROR_ADDRESS_value = (data_low - H8000_0000) and CTF_ECC_LAB_STATUS_LAB_ERROR_ADDRESS_mask
            end If
        else
            read_CTF_ECC_LAB_STATUS_LAB_ERROR_ADDRESS_value = data_low and CTF_ECC_LAB_STATUS_LAB_ERROR_ADDRESS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CTF_ECC_LAB_STATUS_RESERVED_value = &H0
        flag_CTF_ECC_LAB_STATUS_RESERVED        = &H0
        write_CTF_ECC_LAB_STATUS_LAB_ERROR_ADDRESS_value = &H0
        flag_CTF_ECC_LAB_STATUS_LAB_ERROR_ADDRESS        = &H0
    End Sub
End Class


'' @REGISTER : CTF_ctf_ecc_hb_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CTF_ECC_HB_STATUS_RESERVED                 [31:5]           get_CTF_ECC_HB_STATUS_RESERVED
''                                                             set_CTF_ECC_HB_STATUS_RESERVED
''                                                             read_CTF_ECC_HB_STATUS_RESERVED
''                                                             write_CTF_ECC_HB_STATUS_RESERVED
''---------------------------------------------------------------------------------
'' CTF_ECC_HB_STATUS_HB_ERROR_ADDRESS         [4:0]            get_CTF_ECC_HB_STATUS_HB_ERROR_ADDRESS
''                                                             set_CTF_ECC_HB_STATUS_HB_ERROR_ADDRESS
''                                                             read_CTF_ECC_HB_STATUS_HB_ERROR_ADDRESS
''                                                             write_CTF_ECC_HB_STATUS_HB_ERROR_ADDRESS
''---------------------------------------------------------------------------------
Class REGISTER_CTF_ctf_ecc_hb_status
    Private write_CTF_ECC_HB_STATUS_RESERVED_value
    Private read_CTF_ECC_HB_STATUS_RESERVED_value
    Private flag_CTF_ECC_HB_STATUS_RESERVED
    Private write_CTF_ECC_HB_STATUS_HB_ERROR_ADDRESS_value
    Private read_CTF_ECC_HB_STATUS_HB_ERROR_ADDRESS_value
    Private flag_CTF_ECC_HB_STATUS_HB_ERROR_ADDRESS

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H94
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_CTF_ECC_HB_STATUS_RESERVED
        get_CTF_ECC_HB_STATUS_RESERVED = read_CTF_ECC_HB_STATUS_RESERVED_value
    End Property

    Property Let set_CTF_ECC_HB_STATUS_RESERVED(aData)
        write_CTF_ECC_HB_STATUS_RESERVED_value = aData
        flag_CTF_ECC_HB_STATUS_RESERVED        = &H1
    End Property

    Property Get read_CTF_ECC_HB_STATUS_RESERVED
        read
        read_CTF_ECC_HB_STATUS_RESERVED = read_CTF_ECC_HB_STATUS_RESERVED_value
    End Property

    Property Let write_CTF_ECC_HB_STATUS_RESERVED(aData)
        set_CTF_ECC_HB_STATUS_RESERVED = aData
        write
    End Property

    Property Get get_CTF_ECC_HB_STATUS_HB_ERROR_ADDRESS
        get_CTF_ECC_HB_STATUS_HB_ERROR_ADDRESS = read_CTF_ECC_HB_STATUS_HB_ERROR_ADDRESS_value
    End Property

    Property Let set_CTF_ECC_HB_STATUS_HB_ERROR_ADDRESS(aData)
        write_CTF_ECC_HB_STATUS_HB_ERROR_ADDRESS_value = aData
        flag_CTF_ECC_HB_STATUS_HB_ERROR_ADDRESS        = &H1
    End Property

    Property Get read_CTF_ECC_HB_STATUS_HB_ERROR_ADDRESS
        read
        read_CTF_ECC_HB_STATUS_HB_ERROR_ADDRESS = read_CTF_ECC_HB_STATUS_HB_ERROR_ADDRESS_value
    End Property

    Property Let write_CTF_ECC_HB_STATUS_HB_ERROR_ADDRESS(aData)
        set_CTF_ECC_HB_STATUS_HB_ERROR_ADDRESS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CTF_ECC_HB_STATUS_RESERVED_value = rightShift(data_low, 5) and &H7ffffff
        CTF_ECC_HB_STATUS_HB_ERROR_ADDRESS_mask = &H1f
        if data_low > LONG_MAX then
            if CTF_ECC_HB_STATUS_HB_ERROR_ADDRESS_mask = mask then
                read_CTF_ECC_HB_STATUS_HB_ERROR_ADDRESS_value = data_low
            else
                read_CTF_ECC_HB_STATUS_HB_ERROR_ADDRESS_value = (data_low - H8000_0000) and CTF_ECC_HB_STATUS_HB_ERROR_ADDRESS_mask
            end If
        else
            read_CTF_ECC_HB_STATUS_HB_ERROR_ADDRESS_value = data_low and CTF_ECC_HB_STATUS_HB_ERROR_ADDRESS_mask
        end If

    End Sub

    Sub write
        If flag_CTF_ECC_HB_STATUS_RESERVED = &H0 or flag_CTF_ECC_HB_STATUS_HB_ERROR_ADDRESS = &H0 Then read
        If flag_CTF_ECC_HB_STATUS_RESERVED = &H0 Then write_CTF_ECC_HB_STATUS_RESERVED_value = get_CTF_ECC_HB_STATUS_RESERVED
        If flag_CTF_ECC_HB_STATUS_HB_ERROR_ADDRESS = &H0 Then write_CTF_ECC_HB_STATUS_HB_ERROR_ADDRESS_value = get_CTF_ECC_HB_STATUS_HB_ERROR_ADDRESS

        regValue = leftShift((write_CTF_ECC_HB_STATUS_RESERVED_value and &H7ffffff), 5) + leftShift((write_CTF_ECC_HB_STATUS_HB_ERROR_ADDRESS_value and &H1f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CTF_ECC_HB_STATUS_RESERVED_value = rightShift(data_low, 5) and &H7ffffff
        CTF_ECC_HB_STATUS_HB_ERROR_ADDRESS_mask = &H1f
        if data_low > LONG_MAX then
            if CTF_ECC_HB_STATUS_HB_ERROR_ADDRESS_mask = mask then
                read_CTF_ECC_HB_STATUS_HB_ERROR_ADDRESS_value = data_low
            else
                read_CTF_ECC_HB_STATUS_HB_ERROR_ADDRESS_value = (data_low - H8000_0000) and CTF_ECC_HB_STATUS_HB_ERROR_ADDRESS_mask
            end If
        else
            read_CTF_ECC_HB_STATUS_HB_ERROR_ADDRESS_value = data_low and CTF_ECC_HB_STATUS_HB_ERROR_ADDRESS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CTF_ECC_HB_STATUS_RESERVED_value = &H0
        flag_CTF_ECC_HB_STATUS_RESERVED        = &H0
        write_CTF_ECC_HB_STATUS_HB_ERROR_ADDRESS_value = &H0
        flag_CTF_ECC_HB_STATUS_HB_ERROR_ADDRESS        = &H0
    End Sub
End Class


'' @REGISTER : CTF_ctf_hwq_max_depth
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CTF_HWQ_MAX_DEPTH_RESERVED                 [31:10]          get_CTF_HWQ_MAX_DEPTH_RESERVED
''                                                             set_CTF_HWQ_MAX_DEPTH_RESERVED
''                                                             read_CTF_HWQ_MAX_DEPTH_RESERVED
''                                                             write_CTF_HWQ_MAX_DEPTH_RESERVED
''---------------------------------------------------------------------------------
'' CTF_HWQ_MAX_DEPTH_MAX_DEPTH                [9:0]            get_CTF_HWQ_MAX_DEPTH_MAX_DEPTH
''                                                             set_CTF_HWQ_MAX_DEPTH_MAX_DEPTH
''                                                             read_CTF_HWQ_MAX_DEPTH_MAX_DEPTH
''                                                             write_CTF_HWQ_MAX_DEPTH_MAX_DEPTH
''---------------------------------------------------------------------------------
Class REGISTER_CTF_ctf_hwq_max_depth
    Private write_CTF_HWQ_MAX_DEPTH_RESERVED_value
    Private read_CTF_HWQ_MAX_DEPTH_RESERVED_value
    Private flag_CTF_HWQ_MAX_DEPTH_RESERVED
    Private write_CTF_HWQ_MAX_DEPTH_MAX_DEPTH_value
    Private read_CTF_HWQ_MAX_DEPTH_MAX_DEPTH_value
    Private flag_CTF_HWQ_MAX_DEPTH_MAX_DEPTH

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H98
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_CTF_HWQ_MAX_DEPTH_RESERVED
        get_CTF_HWQ_MAX_DEPTH_RESERVED = read_CTF_HWQ_MAX_DEPTH_RESERVED_value
    End Property

    Property Let set_CTF_HWQ_MAX_DEPTH_RESERVED(aData)
        write_CTF_HWQ_MAX_DEPTH_RESERVED_value = aData
        flag_CTF_HWQ_MAX_DEPTH_RESERVED        = &H1
    End Property

    Property Get read_CTF_HWQ_MAX_DEPTH_RESERVED
        read
        read_CTF_HWQ_MAX_DEPTH_RESERVED = read_CTF_HWQ_MAX_DEPTH_RESERVED_value
    End Property

    Property Let write_CTF_HWQ_MAX_DEPTH_RESERVED(aData)
        set_CTF_HWQ_MAX_DEPTH_RESERVED = aData
        write
    End Property

    Property Get get_CTF_HWQ_MAX_DEPTH_MAX_DEPTH
        get_CTF_HWQ_MAX_DEPTH_MAX_DEPTH = read_CTF_HWQ_MAX_DEPTH_MAX_DEPTH_value
    End Property

    Property Let set_CTF_HWQ_MAX_DEPTH_MAX_DEPTH(aData)
        write_CTF_HWQ_MAX_DEPTH_MAX_DEPTH_value = aData
        flag_CTF_HWQ_MAX_DEPTH_MAX_DEPTH        = &H1
    End Property

    Property Get read_CTF_HWQ_MAX_DEPTH_MAX_DEPTH
        read
        read_CTF_HWQ_MAX_DEPTH_MAX_DEPTH = read_CTF_HWQ_MAX_DEPTH_MAX_DEPTH_value
    End Property

    Property Let write_CTF_HWQ_MAX_DEPTH_MAX_DEPTH(aData)
        set_CTF_HWQ_MAX_DEPTH_MAX_DEPTH = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CTF_HWQ_MAX_DEPTH_RESERVED_value = rightShift(data_low, 10) and &H3fffff
        CTF_HWQ_MAX_DEPTH_MAX_DEPTH_mask = &H3ff
        if data_low > LONG_MAX then
            if CTF_HWQ_MAX_DEPTH_MAX_DEPTH_mask = mask then
                read_CTF_HWQ_MAX_DEPTH_MAX_DEPTH_value = data_low
            else
                read_CTF_HWQ_MAX_DEPTH_MAX_DEPTH_value = (data_low - H8000_0000) and CTF_HWQ_MAX_DEPTH_MAX_DEPTH_mask
            end If
        else
            read_CTF_HWQ_MAX_DEPTH_MAX_DEPTH_value = data_low and CTF_HWQ_MAX_DEPTH_MAX_DEPTH_mask
        end If

    End Sub

    Sub write
        If flag_CTF_HWQ_MAX_DEPTH_RESERVED = &H0 or flag_CTF_HWQ_MAX_DEPTH_MAX_DEPTH = &H0 Then read
        If flag_CTF_HWQ_MAX_DEPTH_RESERVED = &H0 Then write_CTF_HWQ_MAX_DEPTH_RESERVED_value = get_CTF_HWQ_MAX_DEPTH_RESERVED
        If flag_CTF_HWQ_MAX_DEPTH_MAX_DEPTH = &H0 Then write_CTF_HWQ_MAX_DEPTH_MAX_DEPTH_value = get_CTF_HWQ_MAX_DEPTH_MAX_DEPTH

        regValue = leftShift((write_CTF_HWQ_MAX_DEPTH_RESERVED_value and &H3fffff), 10) + leftShift((write_CTF_HWQ_MAX_DEPTH_MAX_DEPTH_value and &H3ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CTF_HWQ_MAX_DEPTH_RESERVED_value = rightShift(data_low, 10) and &H3fffff
        CTF_HWQ_MAX_DEPTH_MAX_DEPTH_mask = &H3ff
        if data_low > LONG_MAX then
            if CTF_HWQ_MAX_DEPTH_MAX_DEPTH_mask = mask then
                read_CTF_HWQ_MAX_DEPTH_MAX_DEPTH_value = data_low
            else
                read_CTF_HWQ_MAX_DEPTH_MAX_DEPTH_value = (data_low - H8000_0000) and CTF_HWQ_MAX_DEPTH_MAX_DEPTH_mask
            end If
        else
            read_CTF_HWQ_MAX_DEPTH_MAX_DEPTH_value = data_low and CTF_HWQ_MAX_DEPTH_MAX_DEPTH_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CTF_HWQ_MAX_DEPTH_RESERVED_value = &H0
        flag_CTF_HWQ_MAX_DEPTH_RESERVED        = &H0
        write_CTF_HWQ_MAX_DEPTH_MAX_DEPTH_value = &H0
        flag_CTF_HWQ_MAX_DEPTH_MAX_DEPTH        = &H0
    End Sub
End Class


'' @REGISTER : CTF_ctf_lab_max_depth
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CTF_LAB_MAX_DEPTH_RESERVED                 [31:6]           get_CTF_LAB_MAX_DEPTH_RESERVED
''                                                             set_CTF_LAB_MAX_DEPTH_RESERVED
''                                                             read_CTF_LAB_MAX_DEPTH_RESERVED
''                                                             write_CTF_LAB_MAX_DEPTH_RESERVED
''---------------------------------------------------------------------------------
'' CTF_LAB_MAX_DEPTH_MAX_DEPTH                [5:0]            get_CTF_LAB_MAX_DEPTH_MAX_DEPTH
''                                                             set_CTF_LAB_MAX_DEPTH_MAX_DEPTH
''                                                             read_CTF_LAB_MAX_DEPTH_MAX_DEPTH
''                                                             write_CTF_LAB_MAX_DEPTH_MAX_DEPTH
''---------------------------------------------------------------------------------
Class REGISTER_CTF_ctf_lab_max_depth
    Private write_CTF_LAB_MAX_DEPTH_RESERVED_value
    Private read_CTF_LAB_MAX_DEPTH_RESERVED_value
    Private flag_CTF_LAB_MAX_DEPTH_RESERVED
    Private write_CTF_LAB_MAX_DEPTH_MAX_DEPTH_value
    Private read_CTF_LAB_MAX_DEPTH_MAX_DEPTH_value
    Private flag_CTF_LAB_MAX_DEPTH_MAX_DEPTH

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H9c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_CTF_LAB_MAX_DEPTH_RESERVED
        get_CTF_LAB_MAX_DEPTH_RESERVED = read_CTF_LAB_MAX_DEPTH_RESERVED_value
    End Property

    Property Let set_CTF_LAB_MAX_DEPTH_RESERVED(aData)
        write_CTF_LAB_MAX_DEPTH_RESERVED_value = aData
        flag_CTF_LAB_MAX_DEPTH_RESERVED        = &H1
    End Property

    Property Get read_CTF_LAB_MAX_DEPTH_RESERVED
        read
        read_CTF_LAB_MAX_DEPTH_RESERVED = read_CTF_LAB_MAX_DEPTH_RESERVED_value
    End Property

    Property Let write_CTF_LAB_MAX_DEPTH_RESERVED(aData)
        set_CTF_LAB_MAX_DEPTH_RESERVED = aData
        write
    End Property

    Property Get get_CTF_LAB_MAX_DEPTH_MAX_DEPTH
        get_CTF_LAB_MAX_DEPTH_MAX_DEPTH = read_CTF_LAB_MAX_DEPTH_MAX_DEPTH_value
    End Property

    Property Let set_CTF_LAB_MAX_DEPTH_MAX_DEPTH(aData)
        write_CTF_LAB_MAX_DEPTH_MAX_DEPTH_value = aData
        flag_CTF_LAB_MAX_DEPTH_MAX_DEPTH        = &H1
    End Property

    Property Get read_CTF_LAB_MAX_DEPTH_MAX_DEPTH
        read
        read_CTF_LAB_MAX_DEPTH_MAX_DEPTH = read_CTF_LAB_MAX_DEPTH_MAX_DEPTH_value
    End Property

    Property Let write_CTF_LAB_MAX_DEPTH_MAX_DEPTH(aData)
        set_CTF_LAB_MAX_DEPTH_MAX_DEPTH = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CTF_LAB_MAX_DEPTH_RESERVED_value = rightShift(data_low, 6) and &H3ffffff
        CTF_LAB_MAX_DEPTH_MAX_DEPTH_mask = &H3f
        if data_low > LONG_MAX then
            if CTF_LAB_MAX_DEPTH_MAX_DEPTH_mask = mask then
                read_CTF_LAB_MAX_DEPTH_MAX_DEPTH_value = data_low
            else
                read_CTF_LAB_MAX_DEPTH_MAX_DEPTH_value = (data_low - H8000_0000) and CTF_LAB_MAX_DEPTH_MAX_DEPTH_mask
            end If
        else
            read_CTF_LAB_MAX_DEPTH_MAX_DEPTH_value = data_low and CTF_LAB_MAX_DEPTH_MAX_DEPTH_mask
        end If

    End Sub

    Sub write
        If flag_CTF_LAB_MAX_DEPTH_RESERVED = &H0 or flag_CTF_LAB_MAX_DEPTH_MAX_DEPTH = &H0 Then read
        If flag_CTF_LAB_MAX_DEPTH_RESERVED = &H0 Then write_CTF_LAB_MAX_DEPTH_RESERVED_value = get_CTF_LAB_MAX_DEPTH_RESERVED
        If flag_CTF_LAB_MAX_DEPTH_MAX_DEPTH = &H0 Then write_CTF_LAB_MAX_DEPTH_MAX_DEPTH_value = get_CTF_LAB_MAX_DEPTH_MAX_DEPTH

        regValue = leftShift((write_CTF_LAB_MAX_DEPTH_RESERVED_value and &H3ffffff), 6) + leftShift((write_CTF_LAB_MAX_DEPTH_MAX_DEPTH_value and &H3f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CTF_LAB_MAX_DEPTH_RESERVED_value = rightShift(data_low, 6) and &H3ffffff
        CTF_LAB_MAX_DEPTH_MAX_DEPTH_mask = &H3f
        if data_low > LONG_MAX then
            if CTF_LAB_MAX_DEPTH_MAX_DEPTH_mask = mask then
                read_CTF_LAB_MAX_DEPTH_MAX_DEPTH_value = data_low
            else
                read_CTF_LAB_MAX_DEPTH_MAX_DEPTH_value = (data_low - H8000_0000) and CTF_LAB_MAX_DEPTH_MAX_DEPTH_mask
            end If
        else
            read_CTF_LAB_MAX_DEPTH_MAX_DEPTH_value = data_low and CTF_LAB_MAX_DEPTH_MAX_DEPTH_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CTF_LAB_MAX_DEPTH_RESERVED_value = &H0
        flag_CTF_LAB_MAX_DEPTH_RESERVED        = &H0
        write_CTF_LAB_MAX_DEPTH_MAX_DEPTH_value = &H0
        flag_CTF_LAB_MAX_DEPTH_MAX_DEPTH        = &H0
    End Sub
End Class


'' @REGISTER : CTF_ctf_mem_acc_data0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CTF_MEM_ACC_DATA0_DATA                     [31:0]           get_CTF_MEM_ACC_DATA0_DATA
''                                                             set_CTF_MEM_ACC_DATA0_DATA
''                                                             read_CTF_MEM_ACC_DATA0_DATA
''                                                             write_CTF_MEM_ACC_DATA0_DATA
''---------------------------------------------------------------------------------
Class REGISTER_CTF_ctf_mem_acc_data0
    Private write_CTF_MEM_ACC_DATA0_DATA_value
    Private read_CTF_MEM_ACC_DATA0_DATA_value
    Private flag_CTF_MEM_ACC_DATA0_DATA

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Ha0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_CTF_MEM_ACC_DATA0_DATA
        get_CTF_MEM_ACC_DATA0_DATA = read_CTF_MEM_ACC_DATA0_DATA_value
    End Property

    Property Let set_CTF_MEM_ACC_DATA0_DATA(aData)
        write_CTF_MEM_ACC_DATA0_DATA_value = aData
        flag_CTF_MEM_ACC_DATA0_DATA        = &H1
    End Property

    Property Get read_CTF_MEM_ACC_DATA0_DATA
        read
        read_CTF_MEM_ACC_DATA0_DATA = read_CTF_MEM_ACC_DATA0_DATA_value
    End Property

    Property Let write_CTF_MEM_ACC_DATA0_DATA(aData)
        set_CTF_MEM_ACC_DATA0_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CTF_MEM_ACC_DATA0_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if CTF_MEM_ACC_DATA0_DATA_mask = mask then
                read_CTF_MEM_ACC_DATA0_DATA_value = data_low
            else
                read_CTF_MEM_ACC_DATA0_DATA_value = (data_low - H8000_0000) and CTF_MEM_ACC_DATA0_DATA_mask
            end If
        else
            read_CTF_MEM_ACC_DATA0_DATA_value = data_low and CTF_MEM_ACC_DATA0_DATA_mask
        end If

    End Sub

    Sub write
        If flag_CTF_MEM_ACC_DATA0_DATA = &H0 Then read
        If flag_CTF_MEM_ACC_DATA0_DATA = &H0 Then write_CTF_MEM_ACC_DATA0_DATA_value = get_CTF_MEM_ACC_DATA0_DATA

        regValue = leftShift(write_CTF_MEM_ACC_DATA0_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CTF_MEM_ACC_DATA0_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if CTF_MEM_ACC_DATA0_DATA_mask = mask then
                read_CTF_MEM_ACC_DATA0_DATA_value = data_low
            else
                read_CTF_MEM_ACC_DATA0_DATA_value = (data_low - H8000_0000) and CTF_MEM_ACC_DATA0_DATA_mask
            end If
        else
            read_CTF_MEM_ACC_DATA0_DATA_value = data_low and CTF_MEM_ACC_DATA0_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CTF_MEM_ACC_DATA0_DATA_value = &H0
        flag_CTF_MEM_ACC_DATA0_DATA        = &H0
    End Sub
End Class


'' @REGISTER : CTF_ctf_mem_acc_data1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CTF_MEM_ACC_DATA1_DATA                     [31:0]           get_CTF_MEM_ACC_DATA1_DATA
''                                                             set_CTF_MEM_ACC_DATA1_DATA
''                                                             read_CTF_MEM_ACC_DATA1_DATA
''                                                             write_CTF_MEM_ACC_DATA1_DATA
''---------------------------------------------------------------------------------
Class REGISTER_CTF_ctf_mem_acc_data1
    Private write_CTF_MEM_ACC_DATA1_DATA_value
    Private read_CTF_MEM_ACC_DATA1_DATA_value
    Private flag_CTF_MEM_ACC_DATA1_DATA

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Ha4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_CTF_MEM_ACC_DATA1_DATA
        get_CTF_MEM_ACC_DATA1_DATA = read_CTF_MEM_ACC_DATA1_DATA_value
    End Property

    Property Let set_CTF_MEM_ACC_DATA1_DATA(aData)
        write_CTF_MEM_ACC_DATA1_DATA_value = aData
        flag_CTF_MEM_ACC_DATA1_DATA        = &H1
    End Property

    Property Get read_CTF_MEM_ACC_DATA1_DATA
        read
        read_CTF_MEM_ACC_DATA1_DATA = read_CTF_MEM_ACC_DATA1_DATA_value
    End Property

    Property Let write_CTF_MEM_ACC_DATA1_DATA(aData)
        set_CTF_MEM_ACC_DATA1_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CTF_MEM_ACC_DATA1_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if CTF_MEM_ACC_DATA1_DATA_mask = mask then
                read_CTF_MEM_ACC_DATA1_DATA_value = data_low
            else
                read_CTF_MEM_ACC_DATA1_DATA_value = (data_low - H8000_0000) and CTF_MEM_ACC_DATA1_DATA_mask
            end If
        else
            read_CTF_MEM_ACC_DATA1_DATA_value = data_low and CTF_MEM_ACC_DATA1_DATA_mask
        end If

    End Sub

    Sub write
        If flag_CTF_MEM_ACC_DATA1_DATA = &H0 Then read
        If flag_CTF_MEM_ACC_DATA1_DATA = &H0 Then write_CTF_MEM_ACC_DATA1_DATA_value = get_CTF_MEM_ACC_DATA1_DATA

        regValue = leftShift(write_CTF_MEM_ACC_DATA1_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CTF_MEM_ACC_DATA1_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if CTF_MEM_ACC_DATA1_DATA_mask = mask then
                read_CTF_MEM_ACC_DATA1_DATA_value = data_low
            else
                read_CTF_MEM_ACC_DATA1_DATA_value = (data_low - H8000_0000) and CTF_MEM_ACC_DATA1_DATA_mask
            end If
        else
            read_CTF_MEM_ACC_DATA1_DATA_value = data_low and CTF_MEM_ACC_DATA1_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CTF_MEM_ACC_DATA1_DATA_value = &H0
        flag_CTF_MEM_ACC_DATA1_DATA        = &H0
    End Sub
End Class


'' @REGISTER : CTF_ctf_mem_acc_data2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CTF_MEM_ACC_DATA2_DATA                     [31:0]           get_CTF_MEM_ACC_DATA2_DATA
''                                                             set_CTF_MEM_ACC_DATA2_DATA
''                                                             read_CTF_MEM_ACC_DATA2_DATA
''                                                             write_CTF_MEM_ACC_DATA2_DATA
''---------------------------------------------------------------------------------
Class REGISTER_CTF_ctf_mem_acc_data2
    Private write_CTF_MEM_ACC_DATA2_DATA_value
    Private read_CTF_MEM_ACC_DATA2_DATA_value
    Private flag_CTF_MEM_ACC_DATA2_DATA

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Ha8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_CTF_MEM_ACC_DATA2_DATA
        get_CTF_MEM_ACC_DATA2_DATA = read_CTF_MEM_ACC_DATA2_DATA_value
    End Property

    Property Let set_CTF_MEM_ACC_DATA2_DATA(aData)
        write_CTF_MEM_ACC_DATA2_DATA_value = aData
        flag_CTF_MEM_ACC_DATA2_DATA        = &H1
    End Property

    Property Get read_CTF_MEM_ACC_DATA2_DATA
        read
        read_CTF_MEM_ACC_DATA2_DATA = read_CTF_MEM_ACC_DATA2_DATA_value
    End Property

    Property Let write_CTF_MEM_ACC_DATA2_DATA(aData)
        set_CTF_MEM_ACC_DATA2_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CTF_MEM_ACC_DATA2_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if CTF_MEM_ACC_DATA2_DATA_mask = mask then
                read_CTF_MEM_ACC_DATA2_DATA_value = data_low
            else
                read_CTF_MEM_ACC_DATA2_DATA_value = (data_low - H8000_0000) and CTF_MEM_ACC_DATA2_DATA_mask
            end If
        else
            read_CTF_MEM_ACC_DATA2_DATA_value = data_low and CTF_MEM_ACC_DATA2_DATA_mask
        end If

    End Sub

    Sub write
        If flag_CTF_MEM_ACC_DATA2_DATA = &H0 Then read
        If flag_CTF_MEM_ACC_DATA2_DATA = &H0 Then write_CTF_MEM_ACC_DATA2_DATA_value = get_CTF_MEM_ACC_DATA2_DATA

        regValue = leftShift(write_CTF_MEM_ACC_DATA2_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CTF_MEM_ACC_DATA2_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if CTF_MEM_ACC_DATA2_DATA_mask = mask then
                read_CTF_MEM_ACC_DATA2_DATA_value = data_low
            else
                read_CTF_MEM_ACC_DATA2_DATA_value = (data_low - H8000_0000) and CTF_MEM_ACC_DATA2_DATA_mask
            end If
        else
            read_CTF_MEM_ACC_DATA2_DATA_value = data_low and CTF_MEM_ACC_DATA2_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CTF_MEM_ACC_DATA2_DATA_value = &H0
        flag_CTF_MEM_ACC_DATA2_DATA        = &H0
    End Sub
End Class


'' @REGISTER : CTF_ctf_mem_acc_data3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CTF_MEM_ACC_DATA3_DATA                     [31:0]           get_CTF_MEM_ACC_DATA3_DATA
''                                                             set_CTF_MEM_ACC_DATA3_DATA
''                                                             read_CTF_MEM_ACC_DATA3_DATA
''                                                             write_CTF_MEM_ACC_DATA3_DATA
''---------------------------------------------------------------------------------
Class REGISTER_CTF_ctf_mem_acc_data3
    Private write_CTF_MEM_ACC_DATA3_DATA_value
    Private read_CTF_MEM_ACC_DATA3_DATA_value
    Private flag_CTF_MEM_ACC_DATA3_DATA

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hac
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_CTF_MEM_ACC_DATA3_DATA
        get_CTF_MEM_ACC_DATA3_DATA = read_CTF_MEM_ACC_DATA3_DATA_value
    End Property

    Property Let set_CTF_MEM_ACC_DATA3_DATA(aData)
        write_CTF_MEM_ACC_DATA3_DATA_value = aData
        flag_CTF_MEM_ACC_DATA3_DATA        = &H1
    End Property

    Property Get read_CTF_MEM_ACC_DATA3_DATA
        read
        read_CTF_MEM_ACC_DATA3_DATA = read_CTF_MEM_ACC_DATA3_DATA_value
    End Property

    Property Let write_CTF_MEM_ACC_DATA3_DATA(aData)
        set_CTF_MEM_ACC_DATA3_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CTF_MEM_ACC_DATA3_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if CTF_MEM_ACC_DATA3_DATA_mask = mask then
                read_CTF_MEM_ACC_DATA3_DATA_value = data_low
            else
                read_CTF_MEM_ACC_DATA3_DATA_value = (data_low - H8000_0000) and CTF_MEM_ACC_DATA3_DATA_mask
            end If
        else
            read_CTF_MEM_ACC_DATA3_DATA_value = data_low and CTF_MEM_ACC_DATA3_DATA_mask
        end If

    End Sub

    Sub write
        If flag_CTF_MEM_ACC_DATA3_DATA = &H0 Then read
        If flag_CTF_MEM_ACC_DATA3_DATA = &H0 Then write_CTF_MEM_ACC_DATA3_DATA_value = get_CTF_MEM_ACC_DATA3_DATA

        regValue = leftShift(write_CTF_MEM_ACC_DATA3_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CTF_MEM_ACC_DATA3_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if CTF_MEM_ACC_DATA3_DATA_mask = mask then
                read_CTF_MEM_ACC_DATA3_DATA_value = data_low
            else
                read_CTF_MEM_ACC_DATA3_DATA_value = (data_low - H8000_0000) and CTF_MEM_ACC_DATA3_DATA_mask
            end If
        else
            read_CTF_MEM_ACC_DATA3_DATA_value = data_low and CTF_MEM_ACC_DATA3_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CTF_MEM_ACC_DATA3_DATA_value = &H0
        flag_CTF_MEM_ACC_DATA3_DATA        = &H0
    End Sub
End Class


'' @REGISTER : CTF_ctf_mem_acc_data4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CTF_MEM_ACC_DATA4_DATA                     [31:0]           get_CTF_MEM_ACC_DATA4_DATA
''                                                             set_CTF_MEM_ACC_DATA4_DATA
''                                                             read_CTF_MEM_ACC_DATA4_DATA
''                                                             write_CTF_MEM_ACC_DATA4_DATA
''---------------------------------------------------------------------------------
Class REGISTER_CTF_ctf_mem_acc_data4
    Private write_CTF_MEM_ACC_DATA4_DATA_value
    Private read_CTF_MEM_ACC_DATA4_DATA_value
    Private flag_CTF_MEM_ACC_DATA4_DATA

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hb0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_CTF_MEM_ACC_DATA4_DATA
        get_CTF_MEM_ACC_DATA4_DATA = read_CTF_MEM_ACC_DATA4_DATA_value
    End Property

    Property Let set_CTF_MEM_ACC_DATA4_DATA(aData)
        write_CTF_MEM_ACC_DATA4_DATA_value = aData
        flag_CTF_MEM_ACC_DATA4_DATA        = &H1
    End Property

    Property Get read_CTF_MEM_ACC_DATA4_DATA
        read
        read_CTF_MEM_ACC_DATA4_DATA = read_CTF_MEM_ACC_DATA4_DATA_value
    End Property

    Property Let write_CTF_MEM_ACC_DATA4_DATA(aData)
        set_CTF_MEM_ACC_DATA4_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CTF_MEM_ACC_DATA4_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if CTF_MEM_ACC_DATA4_DATA_mask = mask then
                read_CTF_MEM_ACC_DATA4_DATA_value = data_low
            else
                read_CTF_MEM_ACC_DATA4_DATA_value = (data_low - H8000_0000) and CTF_MEM_ACC_DATA4_DATA_mask
            end If
        else
            read_CTF_MEM_ACC_DATA4_DATA_value = data_low and CTF_MEM_ACC_DATA4_DATA_mask
        end If

    End Sub

    Sub write
        If flag_CTF_MEM_ACC_DATA4_DATA = &H0 Then read
        If flag_CTF_MEM_ACC_DATA4_DATA = &H0 Then write_CTF_MEM_ACC_DATA4_DATA_value = get_CTF_MEM_ACC_DATA4_DATA

        regValue = leftShift(write_CTF_MEM_ACC_DATA4_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CTF_MEM_ACC_DATA4_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if CTF_MEM_ACC_DATA4_DATA_mask = mask then
                read_CTF_MEM_ACC_DATA4_DATA_value = data_low
            else
                read_CTF_MEM_ACC_DATA4_DATA_value = (data_low - H8000_0000) and CTF_MEM_ACC_DATA4_DATA_mask
            end If
        else
            read_CTF_MEM_ACC_DATA4_DATA_value = data_low and CTF_MEM_ACC_DATA4_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CTF_MEM_ACC_DATA4_DATA_value = &H0
        flag_CTF_MEM_ACC_DATA4_DATA        = &H0
    End Sub
End Class


'' @REGISTER : CTF_ctf_mem_acc_data5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CTF_MEM_ACC_DATA5_DATA                     [31:0]           get_CTF_MEM_ACC_DATA5_DATA
''                                                             set_CTF_MEM_ACC_DATA5_DATA
''                                                             read_CTF_MEM_ACC_DATA5_DATA
''                                                             write_CTF_MEM_ACC_DATA5_DATA
''---------------------------------------------------------------------------------
Class REGISTER_CTF_ctf_mem_acc_data5
    Private write_CTF_MEM_ACC_DATA5_DATA_value
    Private read_CTF_MEM_ACC_DATA5_DATA_value
    Private flag_CTF_MEM_ACC_DATA5_DATA

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hb4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_CTF_MEM_ACC_DATA5_DATA
        get_CTF_MEM_ACC_DATA5_DATA = read_CTF_MEM_ACC_DATA5_DATA_value
    End Property

    Property Let set_CTF_MEM_ACC_DATA5_DATA(aData)
        write_CTF_MEM_ACC_DATA5_DATA_value = aData
        flag_CTF_MEM_ACC_DATA5_DATA        = &H1
    End Property

    Property Get read_CTF_MEM_ACC_DATA5_DATA
        read
        read_CTF_MEM_ACC_DATA5_DATA = read_CTF_MEM_ACC_DATA5_DATA_value
    End Property

    Property Let write_CTF_MEM_ACC_DATA5_DATA(aData)
        set_CTF_MEM_ACC_DATA5_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CTF_MEM_ACC_DATA5_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if CTF_MEM_ACC_DATA5_DATA_mask = mask then
                read_CTF_MEM_ACC_DATA5_DATA_value = data_low
            else
                read_CTF_MEM_ACC_DATA5_DATA_value = (data_low - H8000_0000) and CTF_MEM_ACC_DATA5_DATA_mask
            end If
        else
            read_CTF_MEM_ACC_DATA5_DATA_value = data_low and CTF_MEM_ACC_DATA5_DATA_mask
        end If

    End Sub

    Sub write
        If flag_CTF_MEM_ACC_DATA5_DATA = &H0 Then read
        If flag_CTF_MEM_ACC_DATA5_DATA = &H0 Then write_CTF_MEM_ACC_DATA5_DATA_value = get_CTF_MEM_ACC_DATA5_DATA

        regValue = leftShift(write_CTF_MEM_ACC_DATA5_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CTF_MEM_ACC_DATA5_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if CTF_MEM_ACC_DATA5_DATA_mask = mask then
                read_CTF_MEM_ACC_DATA5_DATA_value = data_low
            else
                read_CTF_MEM_ACC_DATA5_DATA_value = (data_low - H8000_0000) and CTF_MEM_ACC_DATA5_DATA_mask
            end If
        else
            read_CTF_MEM_ACC_DATA5_DATA_value = data_low and CTF_MEM_ACC_DATA5_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CTF_MEM_ACC_DATA5_DATA_value = &H0
        flag_CTF_MEM_ACC_DATA5_DATA        = &H0
    End Sub
End Class


'' @REGISTER : CTF_ctf_mem_acc_data6
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CTF_MEM_ACC_DATA6_DATA                     [31:0]           get_CTF_MEM_ACC_DATA6_DATA
''                                                             set_CTF_MEM_ACC_DATA6_DATA
''                                                             read_CTF_MEM_ACC_DATA6_DATA
''                                                             write_CTF_MEM_ACC_DATA6_DATA
''---------------------------------------------------------------------------------
Class REGISTER_CTF_ctf_mem_acc_data6
    Private write_CTF_MEM_ACC_DATA6_DATA_value
    Private read_CTF_MEM_ACC_DATA6_DATA_value
    Private flag_CTF_MEM_ACC_DATA6_DATA

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hb8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_CTF_MEM_ACC_DATA6_DATA
        get_CTF_MEM_ACC_DATA6_DATA = read_CTF_MEM_ACC_DATA6_DATA_value
    End Property

    Property Let set_CTF_MEM_ACC_DATA6_DATA(aData)
        write_CTF_MEM_ACC_DATA6_DATA_value = aData
        flag_CTF_MEM_ACC_DATA6_DATA        = &H1
    End Property

    Property Get read_CTF_MEM_ACC_DATA6_DATA
        read
        read_CTF_MEM_ACC_DATA6_DATA = read_CTF_MEM_ACC_DATA6_DATA_value
    End Property

    Property Let write_CTF_MEM_ACC_DATA6_DATA(aData)
        set_CTF_MEM_ACC_DATA6_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CTF_MEM_ACC_DATA6_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if CTF_MEM_ACC_DATA6_DATA_mask = mask then
                read_CTF_MEM_ACC_DATA6_DATA_value = data_low
            else
                read_CTF_MEM_ACC_DATA6_DATA_value = (data_low - H8000_0000) and CTF_MEM_ACC_DATA6_DATA_mask
            end If
        else
            read_CTF_MEM_ACC_DATA6_DATA_value = data_low and CTF_MEM_ACC_DATA6_DATA_mask
        end If

    End Sub

    Sub write
        If flag_CTF_MEM_ACC_DATA6_DATA = &H0 Then read
        If flag_CTF_MEM_ACC_DATA6_DATA = &H0 Then write_CTF_MEM_ACC_DATA6_DATA_value = get_CTF_MEM_ACC_DATA6_DATA

        regValue = leftShift(write_CTF_MEM_ACC_DATA6_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CTF_MEM_ACC_DATA6_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if CTF_MEM_ACC_DATA6_DATA_mask = mask then
                read_CTF_MEM_ACC_DATA6_DATA_value = data_low
            else
                read_CTF_MEM_ACC_DATA6_DATA_value = (data_low - H8000_0000) and CTF_MEM_ACC_DATA6_DATA_mask
            end If
        else
            read_CTF_MEM_ACC_DATA6_DATA_value = data_low and CTF_MEM_ACC_DATA6_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CTF_MEM_ACC_DATA6_DATA_value = &H0
        flag_CTF_MEM_ACC_DATA6_DATA        = &H0
    End Sub
End Class


'' @REGISTER : CTF_ctf_mem_acc_data7
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CTF_MEM_ACC_DATA7_DATA                     [31:0]           get_CTF_MEM_ACC_DATA7_DATA
''                                                             set_CTF_MEM_ACC_DATA7_DATA
''                                                             read_CTF_MEM_ACC_DATA7_DATA
''                                                             write_CTF_MEM_ACC_DATA7_DATA
''---------------------------------------------------------------------------------
Class REGISTER_CTF_ctf_mem_acc_data7
    Private write_CTF_MEM_ACC_DATA7_DATA_value
    Private read_CTF_MEM_ACC_DATA7_DATA_value
    Private flag_CTF_MEM_ACC_DATA7_DATA

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hbc
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_CTF_MEM_ACC_DATA7_DATA
        get_CTF_MEM_ACC_DATA7_DATA = read_CTF_MEM_ACC_DATA7_DATA_value
    End Property

    Property Let set_CTF_MEM_ACC_DATA7_DATA(aData)
        write_CTF_MEM_ACC_DATA7_DATA_value = aData
        flag_CTF_MEM_ACC_DATA7_DATA        = &H1
    End Property

    Property Get read_CTF_MEM_ACC_DATA7_DATA
        read
        read_CTF_MEM_ACC_DATA7_DATA = read_CTF_MEM_ACC_DATA7_DATA_value
    End Property

    Property Let write_CTF_MEM_ACC_DATA7_DATA(aData)
        set_CTF_MEM_ACC_DATA7_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CTF_MEM_ACC_DATA7_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if CTF_MEM_ACC_DATA7_DATA_mask = mask then
                read_CTF_MEM_ACC_DATA7_DATA_value = data_low
            else
                read_CTF_MEM_ACC_DATA7_DATA_value = (data_low - H8000_0000) and CTF_MEM_ACC_DATA7_DATA_mask
            end If
        else
            read_CTF_MEM_ACC_DATA7_DATA_value = data_low and CTF_MEM_ACC_DATA7_DATA_mask
        end If

    End Sub

    Sub write
        If flag_CTF_MEM_ACC_DATA7_DATA = &H0 Then read
        If flag_CTF_MEM_ACC_DATA7_DATA = &H0 Then write_CTF_MEM_ACC_DATA7_DATA_value = get_CTF_MEM_ACC_DATA7_DATA

        regValue = leftShift(write_CTF_MEM_ACC_DATA7_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CTF_MEM_ACC_DATA7_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if CTF_MEM_ACC_DATA7_DATA_mask = mask then
                read_CTF_MEM_ACC_DATA7_DATA_value = data_low
            else
                read_CTF_MEM_ACC_DATA7_DATA_value = (data_low - H8000_0000) and CTF_MEM_ACC_DATA7_DATA_mask
            end If
        else
            read_CTF_MEM_ACC_DATA7_DATA_value = data_low and CTF_MEM_ACC_DATA7_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CTF_MEM_ACC_DATA7_DATA_value = &H0
        flag_CTF_MEM_ACC_DATA7_DATA        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class CTF_INSTANCE

    Public ctf_control
    Public ctf_mem_acc_control
    Public ctf_brcm_hdr_control
    Public ctf_l2_skip_control
    Public ctf_l2_tag_type
    Public ctf_l2_llc_max_length
    Public ctf_l2_llc_snap_type_lo
    Public ctf_l2_llc_snap_type_hi
    Public ctf_l2_ethertype
    Public ctf_l3_ipv6_type
    Public ctf_l3_ipv4_type
    Public ctf_l3_napt_control
    Public ctf_status
    Public ctf_status_mask
    Public ctf_receive_status_enable
    Public ctf_hit_count
    Public ctf_miss_count
    Public ctf_snap_fail_count
    Public ctf_etype_fail_count
    Public ctf_version_fail_count
    Public ctf_frag_fail_count
    Public ctf_protocol_ext_fail_count
    Public ctf_ipv4_checksum_fail_count
    Public ctf_ipv4_options_fail_count
    Public ctf_ipv4_header_length_fail_count
    Public ctf_error
    Public ctf_error_mask
    Public ctf_debug_control
    Public ctf_debug_status
    Public ctf_mem_debug
    Public ctf_ecc_debug
    Public ctf_ecc_error
    Public ctf_ecc_error_mask
    Public ctf_ecc_napt_flow_status
    Public ctf_ecc_next_hop_status
    Public ctf_ecc_hwq_status
    Public ctf_ecc_lab_status
    Public ctf_ecc_hb_status
    Public ctf_hwq_max_depth
    Public ctf_lab_max_depth
    Public ctf_mem_acc_data0
    Public ctf_mem_acc_data1
    Public ctf_mem_acc_data2
    Public ctf_mem_acc_data3
    Public ctf_mem_acc_data4
    Public ctf_mem_acc_data5
    Public ctf_mem_acc_data6
    Public ctf_mem_acc_data7


    Public default function Init(aBaseAddr)
        Set ctf_control = (New REGISTER_CTF_ctf_control)(aBaseAddr, 32)
        Set ctf_mem_acc_control = (New REGISTER_CTF_ctf_mem_acc_control)(aBaseAddr, 32)
        Set ctf_brcm_hdr_control = (New REGISTER_CTF_ctf_brcm_hdr_control)(aBaseAddr, 32)
        Set ctf_l2_skip_control = (New REGISTER_CTF_ctf_l2_skip_control)(aBaseAddr, 32)
        Set ctf_l2_tag_type = (New REGISTER_CTF_ctf_l2_tag_type)(aBaseAddr, 32)
        Set ctf_l2_llc_max_length = (New REGISTER_CTF_ctf_l2_llc_max_length)(aBaseAddr, 32)
        Set ctf_l2_llc_snap_type_lo = (New REGISTER_CTF_ctf_l2_llc_snap_type_lo)(aBaseAddr, 32)
        Set ctf_l2_llc_snap_type_hi = (New REGISTER_CTF_ctf_l2_llc_snap_type_hi)(aBaseAddr, 32)
        Set ctf_l2_ethertype = (New REGISTER_CTF_ctf_l2_ethertype)(aBaseAddr, 32)
        Set ctf_l3_ipv6_type = (New REGISTER_CTF_ctf_l3_ipv6_type)(aBaseAddr, 32)
        Set ctf_l3_ipv4_type = (New REGISTER_CTF_ctf_l3_ipv4_type)(aBaseAddr, 32)
        Set ctf_l3_napt_control = (New REGISTER_CTF_ctf_l3_napt_control)(aBaseAddr, 32)
        Set ctf_status = (New REGISTER_CTF_ctf_status)(aBaseAddr, 32)
        Set ctf_status_mask = (New REGISTER_CTF_ctf_status_mask)(aBaseAddr, 32)
        Set ctf_receive_status_enable = (New REGISTER_CTF_ctf_receive_status_enable)(aBaseAddr, 32)
        Set ctf_hit_count = (New REGISTER_CTF_ctf_hit_count)(aBaseAddr, 32)
        Set ctf_miss_count = (New REGISTER_CTF_ctf_miss_count)(aBaseAddr, 32)
        Set ctf_snap_fail_count = (New REGISTER_CTF_ctf_snap_fail_count)(aBaseAddr, 32)
        Set ctf_etype_fail_count = (New REGISTER_CTF_ctf_etype_fail_count)(aBaseAddr, 32)
        Set ctf_version_fail_count = (New REGISTER_CTF_ctf_version_fail_count)(aBaseAddr, 32)
        Set ctf_frag_fail_count = (New REGISTER_CTF_ctf_frag_fail_count)(aBaseAddr, 32)
        Set ctf_protocol_ext_fail_count = (New REGISTER_CTF_ctf_protocol_ext_fail_count)(aBaseAddr, 32)
        Set ctf_ipv4_checksum_fail_count = (New REGISTER_CTF_ctf_ipv4_checksum_fail_count)(aBaseAddr, 32)
        Set ctf_ipv4_options_fail_count = (New REGISTER_CTF_ctf_ipv4_options_fail_count)(aBaseAddr, 32)
        Set ctf_ipv4_header_length_fail_count = (New REGISTER_CTF_ctf_ipv4_header_length_fail_count)(aBaseAddr, 32)
        Set ctf_error = (New REGISTER_CTF_ctf_error)(aBaseAddr, 32)
        Set ctf_error_mask = (New REGISTER_CTF_ctf_error_mask)(aBaseAddr, 32)
        Set ctf_debug_control = (New REGISTER_CTF_ctf_debug_control)(aBaseAddr, 32)
        Set ctf_debug_status = (New REGISTER_CTF_ctf_debug_status)(aBaseAddr, 32)
        Set ctf_mem_debug = (New REGISTER_CTF_ctf_mem_debug)(aBaseAddr, 32)
        Set ctf_ecc_debug = (New REGISTER_CTF_ctf_ecc_debug)(aBaseAddr, 32)
        Set ctf_ecc_error = (New REGISTER_CTF_ctf_ecc_error)(aBaseAddr, 32)
        Set ctf_ecc_error_mask = (New REGISTER_CTF_ctf_ecc_error_mask)(aBaseAddr, 32)
        Set ctf_ecc_napt_flow_status = (New REGISTER_CTF_ctf_ecc_napt_flow_status)(aBaseAddr, 32)
        Set ctf_ecc_next_hop_status = (New REGISTER_CTF_ctf_ecc_next_hop_status)(aBaseAddr, 32)
        Set ctf_ecc_hwq_status = (New REGISTER_CTF_ctf_ecc_hwq_status)(aBaseAddr, 32)
        Set ctf_ecc_lab_status = (New REGISTER_CTF_ctf_ecc_lab_status)(aBaseAddr, 32)
        Set ctf_ecc_hb_status = (New REGISTER_CTF_ctf_ecc_hb_status)(aBaseAddr, 32)
        Set ctf_hwq_max_depth = (New REGISTER_CTF_ctf_hwq_max_depth)(aBaseAddr, 32)
        Set ctf_lab_max_depth = (New REGISTER_CTF_ctf_lab_max_depth)(aBaseAddr, 32)
        Set ctf_mem_acc_data0 = (New REGISTER_CTF_ctf_mem_acc_data0)(aBaseAddr, 32)
        Set ctf_mem_acc_data1 = (New REGISTER_CTF_ctf_mem_acc_data1)(aBaseAddr, 32)
        Set ctf_mem_acc_data2 = (New REGISTER_CTF_ctf_mem_acc_data2)(aBaseAddr, 32)
        Set ctf_mem_acc_data3 = (New REGISTER_CTF_ctf_mem_acc_data3)(aBaseAddr, 32)
        Set ctf_mem_acc_data4 = (New REGISTER_CTF_ctf_mem_acc_data4)(aBaseAddr, 32)
        Set ctf_mem_acc_data5 = (New REGISTER_CTF_ctf_mem_acc_data5)(aBaseAddr, 32)
        Set ctf_mem_acc_data6 = (New REGISTER_CTF_ctf_mem_acc_data6)(aBaseAddr, 32)
        Set ctf_mem_acc_data7 = (New REGISTER_CTF_ctf_mem_acc_data7)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set CTF = CreateObject("System.Collections.ArrayList")
CTF.Add ((New CTF_INSTANCE)(&H4b010000))


