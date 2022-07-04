

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


'' @REGISTER : SWITCH_TOP_REGS_sw_misc_ctrl_reg
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RSVD_1                                     [31:5]           get_RSVD_1
''                                                             set_RSVD_1
''                                                             read_RSVD_1
''                                                             write_RSVD_1
''---------------------------------------------------------------------------------
'' CTF_SW_BP_EN                               [4:4]            get_CTF_SW_BP_EN
''                                                             set_CTF_SW_BP_EN
''                                                             read_CTF_SW_BP_EN
''                                                             write_CTF_SW_BP_EN
''---------------------------------------------------------------------------------
'' P1588_P7_RESET                             [3:3]            get_P1588_P7_RESET
''                                                             set_P1588_P7_RESET
''                                                             read_P1588_P7_RESET
''                                                             write_P1588_P7_RESET
''---------------------------------------------------------------------------------
'' P1588_P0toP6_P8_RESET                      [2:2]            get_P1588_P0toP6_P8_RESET
''                                                             set_P1588_P0toP6_P8_RESET
''                                                             read_P1588_P0toP6_P8_RESET
''                                                             write_P1588_P0toP6_P8_RESET
''---------------------------------------------------------------------------------
'' P1588_TESTBUS_SEL                          [1:1]            get_P1588_TESTBUS_SEL
''                                                             set_P1588_TESTBUS_SEL
''                                                             read_P1588_TESTBUS_SEL
''                                                             write_P1588_TESTBUS_SEL
''---------------------------------------------------------------------------------
'' FA_BYPASS                                  [0:0]            get_FA_BYPASS
''                                                             set_FA_BYPASS
''                                                             read_FA_BYPASS
''                                                             write_FA_BYPASS
''---------------------------------------------------------------------------------
Class REGISTER_SWITCH_TOP_REGS_sw_misc_ctrl_reg
    Private write_RSVD_1_value
    Private read_RSVD_1_value
    Private flag_RSVD_1
    Private write_CTF_SW_BP_EN_value
    Private read_CTF_SW_BP_EN_value
    Private flag_CTF_SW_BP_EN
    Private write_P1588_P7_RESET_value
    Private read_P1588_P7_RESET_value
    Private flag_P1588_P7_RESET
    Private write_P1588_P0toP6_P8_RESET_value
    Private read_P1588_P0toP6_P8_RESET_value
    Private flag_P1588_P0toP6_P8_RESET
    Private write_P1588_TESTBUS_SEL_value
    Private read_P1588_TESTBUS_SEL_value
    Private flag_P1588_TESTBUS_SEL
    Private write_FA_BYPASS_value
    Private read_FA_BYPASS_value
    Private flag_FA_BYPASS

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

    Property Get get_RSVD_1
        get_RSVD_1 = read_RSVD_1_value
    End Property

    Property Let set_RSVD_1(aData)
        write_RSVD_1_value = aData
        flag_RSVD_1        = &H1
    End Property

    Property Get read_RSVD_1
        read
        read_RSVD_1 = read_RSVD_1_value
    End Property

    Property Let write_RSVD_1(aData)
        set_RSVD_1 = aData
        write
    End Property

    Property Get get_CTF_SW_BP_EN
        get_CTF_SW_BP_EN = read_CTF_SW_BP_EN_value
    End Property

    Property Let set_CTF_SW_BP_EN(aData)
        write_CTF_SW_BP_EN_value = aData
        flag_CTF_SW_BP_EN        = &H1
    End Property

    Property Get read_CTF_SW_BP_EN
        read
        read_CTF_SW_BP_EN = read_CTF_SW_BP_EN_value
    End Property

    Property Let write_CTF_SW_BP_EN(aData)
        set_CTF_SW_BP_EN = aData
        write
    End Property

    Property Get get_P1588_P7_RESET
        get_P1588_P7_RESET = read_P1588_P7_RESET_value
    End Property

    Property Let set_P1588_P7_RESET(aData)
        write_P1588_P7_RESET_value = aData
        flag_P1588_P7_RESET        = &H1
    End Property

    Property Get read_P1588_P7_RESET
        read
        read_P1588_P7_RESET = read_P1588_P7_RESET_value
    End Property

    Property Let write_P1588_P7_RESET(aData)
        set_P1588_P7_RESET = aData
        write
    End Property

    Property Get get_P1588_P0toP6_P8_RESET
        get_P1588_P0toP6_P8_RESET = read_P1588_P0toP6_P8_RESET_value
    End Property

    Property Let set_P1588_P0toP6_P8_RESET(aData)
        write_P1588_P0toP6_P8_RESET_value = aData
        flag_P1588_P0toP6_P8_RESET        = &H1
    End Property

    Property Get read_P1588_P0toP6_P8_RESET
        read
        read_P1588_P0toP6_P8_RESET = read_P1588_P0toP6_P8_RESET_value
    End Property

    Property Let write_P1588_P0toP6_P8_RESET(aData)
        set_P1588_P0toP6_P8_RESET = aData
        write
    End Property

    Property Get get_P1588_TESTBUS_SEL
        get_P1588_TESTBUS_SEL = read_P1588_TESTBUS_SEL_value
    End Property

    Property Let set_P1588_TESTBUS_SEL(aData)
        write_P1588_TESTBUS_SEL_value = aData
        flag_P1588_TESTBUS_SEL        = &H1
    End Property

    Property Get read_P1588_TESTBUS_SEL
        read
        read_P1588_TESTBUS_SEL = read_P1588_TESTBUS_SEL_value
    End Property

    Property Let write_P1588_TESTBUS_SEL(aData)
        set_P1588_TESTBUS_SEL = aData
        write
    End Property

    Property Get get_FA_BYPASS
        get_FA_BYPASS = read_FA_BYPASS_value
    End Property

    Property Let set_FA_BYPASS(aData)
        write_FA_BYPASS_value = aData
        flag_FA_BYPASS        = &H1
    End Property

    Property Get read_FA_BYPASS
        read
        read_FA_BYPASS = read_FA_BYPASS_value
    End Property

    Property Let write_FA_BYPASS(aData)
        set_FA_BYPASS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RSVD_1_value = rightShift(data_low, 5) and &H7ffffff
        read_CTF_SW_BP_EN_value = rightShift(data_low, 4) and &H1
        read_P1588_P7_RESET_value = rightShift(data_low, 3) and &H1
        read_P1588_P0toP6_P8_RESET_value = rightShift(data_low, 2) and &H1
        read_P1588_TESTBUS_SEL_value = rightShift(data_low, 1) and &H1
        FA_BYPASS_mask = &H1
        if data_low > LONG_MAX then
            if FA_BYPASS_mask = mask then
                read_FA_BYPASS_value = data_low
            else
                read_FA_BYPASS_value = (data_low - H8000_0000) and FA_BYPASS_mask
            end If
        else
            read_FA_BYPASS_value = data_low and FA_BYPASS_mask
        end If

    End Sub

    Sub write
        If flag_RSVD_1 = &H0 or flag_CTF_SW_BP_EN = &H0 or flag_P1588_P7_RESET = &H0 or flag_P1588_P0toP6_P8_RESET = &H0 or flag_P1588_TESTBUS_SEL = &H0 or flag_FA_BYPASS = &H0 Then read
        If flag_RSVD_1 = &H0 Then write_RSVD_1_value = get_RSVD_1
        If flag_CTF_SW_BP_EN = &H0 Then write_CTF_SW_BP_EN_value = get_CTF_SW_BP_EN
        If flag_P1588_P7_RESET = &H0 Then write_P1588_P7_RESET_value = get_P1588_P7_RESET
        If flag_P1588_P0toP6_P8_RESET = &H0 Then write_P1588_P0toP6_P8_RESET_value = get_P1588_P0toP6_P8_RESET
        If flag_P1588_TESTBUS_SEL = &H0 Then write_P1588_TESTBUS_SEL_value = get_P1588_TESTBUS_SEL
        If flag_FA_BYPASS = &H0 Then write_FA_BYPASS_value = get_FA_BYPASS

        regValue = leftShift((write_RSVD_1_value and &H7ffffff), 5) + leftShift((write_CTF_SW_BP_EN_value and &H1), 4) + leftShift((write_P1588_P7_RESET_value and &H1), 3) + leftShift((write_P1588_P0toP6_P8_RESET_value and &H1), 2) + leftShift((write_P1588_TESTBUS_SEL_value and &H1), 1) + leftShift((write_FA_BYPASS_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RSVD_1_value = rightShift(data_low, 5) and &H7ffffff
        read_CTF_SW_BP_EN_value = rightShift(data_low, 4) and &H1
        read_P1588_P7_RESET_value = rightShift(data_low, 3) and &H1
        read_P1588_P0toP6_P8_RESET_value = rightShift(data_low, 2) and &H1
        read_P1588_TESTBUS_SEL_value = rightShift(data_low, 1) and &H1
        FA_BYPASS_mask = &H1
        if data_low > LONG_MAX then
            if FA_BYPASS_mask = mask then
                read_FA_BYPASS_value = data_low
            else
                read_FA_BYPASS_value = (data_low - H8000_0000) and FA_BYPASS_mask
            end If
        else
            read_FA_BYPASS_value = data_low and FA_BYPASS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RSVD_1_value = &H0
        flag_RSVD_1        = &H0
        write_CTF_SW_BP_EN_value = &H0
        flag_CTF_SW_BP_EN        = &H0
        write_P1588_P7_RESET_value = &H0
        flag_P1588_P7_RESET        = &H0
        write_P1588_P0toP6_P8_RESET_value = &H0
        flag_P1588_P0toP6_P8_RESET        = &H0
        write_P1588_TESTBUS_SEL_value = &H0
        flag_P1588_TESTBUS_SEL        = &H0
        write_FA_BYPASS_value = &H0
        flag_FA_BYPASS        = &H0
    End Sub
End Class


'' @REGISTER : SWITCH_TOP_REGS_prot_icv_addr_start_reg
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PROT_ICV_ADDR_START                        [31:0]           get_PROT_ICV_ADDR_START
''                                                             set_PROT_ICV_ADDR_START
''                                                             read_PROT_ICV_ADDR_START
''                                                             write_PROT_ICV_ADDR_START
''---------------------------------------------------------------------------------
Class REGISTER_SWITCH_TOP_REGS_prot_icv_addr_start_reg
    Private write_PROT_ICV_ADDR_START_value
    Private read_PROT_ICV_ADDR_START_value
    Private flag_PROT_ICV_ADDR_START

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

    Property Get get_PROT_ICV_ADDR_START
        get_PROT_ICV_ADDR_START = read_PROT_ICV_ADDR_START_value
    End Property

    Property Let set_PROT_ICV_ADDR_START(aData)
        write_PROT_ICV_ADDR_START_value = aData
        flag_PROT_ICV_ADDR_START        = &H1
    End Property

    Property Get read_PROT_ICV_ADDR_START
        read
        read_PROT_ICV_ADDR_START = read_PROT_ICV_ADDR_START_value
    End Property

    Property Let write_PROT_ICV_ADDR_START(aData)
        set_PROT_ICV_ADDR_START = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PROT_ICV_ADDR_START_mask = &Hffffffff
        if data_low > LONG_MAX then
            if PROT_ICV_ADDR_START_mask = mask then
                read_PROT_ICV_ADDR_START_value = data_low
            else
                read_PROT_ICV_ADDR_START_value = (data_low - H8000_0000) and PROT_ICV_ADDR_START_mask
            end If
        else
            read_PROT_ICV_ADDR_START_value = data_low and PROT_ICV_ADDR_START_mask
        end If

    End Sub

    Sub write
        If flag_PROT_ICV_ADDR_START = &H0 Then read
        If flag_PROT_ICV_ADDR_START = &H0 Then write_PROT_ICV_ADDR_START_value = get_PROT_ICV_ADDR_START

        regValue = leftShift(write_PROT_ICV_ADDR_START_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PROT_ICV_ADDR_START_mask = &Hffffffff
        if data_low > LONG_MAX then
            if PROT_ICV_ADDR_START_mask = mask then
                read_PROT_ICV_ADDR_START_value = data_low
            else
                read_PROT_ICV_ADDR_START_value = (data_low - H8000_0000) and PROT_ICV_ADDR_START_mask
            end If
        else
            read_PROT_ICV_ADDR_START_value = data_low and PROT_ICV_ADDR_START_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PROT_ICV_ADDR_START_value = &H0
        flag_PROT_ICV_ADDR_START        = &H0
    End Sub
End Class


'' @REGISTER : SWITCH_TOP_REGS_prot_icv_addr_end_reg
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PROT_ICV_ADDR_END                          [31:0]           get_PROT_ICV_ADDR_END
''                                                             set_PROT_ICV_ADDR_END
''                                                             read_PROT_ICV_ADDR_END
''                                                             write_PROT_ICV_ADDR_END
''---------------------------------------------------------------------------------
Class REGISTER_SWITCH_TOP_REGS_prot_icv_addr_end_reg
    Private write_PROT_ICV_ADDR_END_value
    Private read_PROT_ICV_ADDR_END_value
    Private flag_PROT_ICV_ADDR_END

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

    Property Get get_PROT_ICV_ADDR_END
        get_PROT_ICV_ADDR_END = read_PROT_ICV_ADDR_END_value
    End Property

    Property Let set_PROT_ICV_ADDR_END(aData)
        write_PROT_ICV_ADDR_END_value = aData
        flag_PROT_ICV_ADDR_END        = &H1
    End Property

    Property Get read_PROT_ICV_ADDR_END
        read
        read_PROT_ICV_ADDR_END = read_PROT_ICV_ADDR_END_value
    End Property

    Property Let write_PROT_ICV_ADDR_END(aData)
        set_PROT_ICV_ADDR_END = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PROT_ICV_ADDR_END_mask = &Hffffffff
        if data_low > LONG_MAX then
            if PROT_ICV_ADDR_END_mask = mask then
                read_PROT_ICV_ADDR_END_value = data_low
            else
                read_PROT_ICV_ADDR_END_value = (data_low - H8000_0000) and PROT_ICV_ADDR_END_mask
            end If
        else
            read_PROT_ICV_ADDR_END_value = data_low and PROT_ICV_ADDR_END_mask
        end If

    End Sub

    Sub write
        If flag_PROT_ICV_ADDR_END = &H0 Then read
        If flag_PROT_ICV_ADDR_END = &H0 Then write_PROT_ICV_ADDR_END_value = get_PROT_ICV_ADDR_END

        regValue = leftShift(write_PROT_ICV_ADDR_END_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PROT_ICV_ADDR_END_mask = &Hffffffff
        if data_low > LONG_MAX then
            if PROT_ICV_ADDR_END_mask = mask then
                read_PROT_ICV_ADDR_END_value = data_low
            else
                read_PROT_ICV_ADDR_END_value = (data_low - H8000_0000) and PROT_ICV_ADDR_END_mask
            end If
        else
            read_PROT_ICV_ADDR_END_value = data_low and PROT_ICV_ADDR_END_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PROT_ICV_ADDR_END_value = &H0
        flag_PROT_ICV_ADDR_END        = &H0
    End Sub
End Class


'' @REGISTER : SWITCH_TOP_REGS_icv_wr_disable_reg
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ICV_WR_DISABLE                             [31:0]           get_ICV_WR_DISABLE
''                                                             set_ICV_WR_DISABLE
''                                                             read_ICV_WR_DISABLE
''                                                             write_ICV_WR_DISABLE
''---------------------------------------------------------------------------------
Class REGISTER_SWITCH_TOP_REGS_icv_wr_disable_reg
    Private write_ICV_WR_DISABLE_value
    Private read_ICV_WR_DISABLE_value
    Private flag_ICV_WR_DISABLE

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

    Property Get get_ICV_WR_DISABLE
        get_ICV_WR_DISABLE = read_ICV_WR_DISABLE_value
    End Property

    Property Let set_ICV_WR_DISABLE(aData)
        write_ICV_WR_DISABLE_value = aData
        flag_ICV_WR_DISABLE        = &H1
    End Property

    Property Get read_ICV_WR_DISABLE
        read
        read_ICV_WR_DISABLE = read_ICV_WR_DISABLE_value
    End Property

    Property Let write_ICV_WR_DISABLE(aData)
        set_ICV_WR_DISABLE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_WR_DISABLE_mask = &Hffffffff
        if data_low > LONG_MAX then
            if ICV_WR_DISABLE_mask = mask then
                read_ICV_WR_DISABLE_value = data_low
            else
                read_ICV_WR_DISABLE_value = (data_low - H8000_0000) and ICV_WR_DISABLE_mask
            end If
        else
            read_ICV_WR_DISABLE_value = data_low and ICV_WR_DISABLE_mask
        end If

    End Sub

    Sub write
        If flag_ICV_WR_DISABLE = &H0 Then read
        If flag_ICV_WR_DISABLE = &H0 Then write_ICV_WR_DISABLE_value = get_ICV_WR_DISABLE

        regValue = leftShift(write_ICV_WR_DISABLE_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_WR_DISABLE_mask = &Hffffffff
        if data_low > LONG_MAX then
            if ICV_WR_DISABLE_mask = mask then
                read_ICV_WR_DISABLE_value = data_low
            else
                read_ICV_WR_DISABLE_value = (data_low - H8000_0000) and ICV_WR_DISABLE_mask
            end If
        else
            read_ICV_WR_DISABLE_value = data_low and ICV_WR_DISABLE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ICV_WR_DISABLE_value = &H0
        flag_ICV_WR_DISABLE        = &H0
    End Sub
End Class


'' @REGISTER : SWITCH_TOP_REGS_icv_wr_enable_reg
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ICV_WR_ENABLE                              [31:0]           get_ICV_WR_ENABLE
''                                                             set_ICV_WR_ENABLE
''                                                             read_ICV_WR_ENABLE
''                                                             write_ICV_WR_ENABLE
''---------------------------------------------------------------------------------
Class REGISTER_SWITCH_TOP_REGS_icv_wr_enable_reg
    Private write_ICV_WR_ENABLE_value
    Private read_ICV_WR_ENABLE_value
    Private flag_ICV_WR_ENABLE

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

    Property Get get_ICV_WR_ENABLE
        get_ICV_WR_ENABLE = read_ICV_WR_ENABLE_value
    End Property

    Property Let set_ICV_WR_ENABLE(aData)
        write_ICV_WR_ENABLE_value = aData
        flag_ICV_WR_ENABLE        = &H1
    End Property

    Property Get read_ICV_WR_ENABLE
        read
        read_ICV_WR_ENABLE = read_ICV_WR_ENABLE_value
    End Property

    Property Let write_ICV_WR_ENABLE(aData)
        set_ICV_WR_ENABLE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_WR_ENABLE_mask = &Hffffffff
        if data_low > LONG_MAX then
            if ICV_WR_ENABLE_mask = mask then
                read_ICV_WR_ENABLE_value = data_low
            else
                read_ICV_WR_ENABLE_value = (data_low - H8000_0000) and ICV_WR_ENABLE_mask
            end If
        else
            read_ICV_WR_ENABLE_value = data_low and ICV_WR_ENABLE_mask
        end If

    End Sub

    Sub write
        If flag_ICV_WR_ENABLE = &H0 Then read
        If flag_ICV_WR_ENABLE = &H0 Then write_ICV_WR_ENABLE_value = get_ICV_WR_ENABLE

        regValue = leftShift(write_ICV_WR_ENABLE_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ICV_WR_ENABLE_mask = &Hffffffff
        if data_low > LONG_MAX then
            if ICV_WR_ENABLE_mask = mask then
                read_ICV_WR_ENABLE_value = data_low
            else
                read_ICV_WR_ENABLE_value = (data_low - H8000_0000) and ICV_WR_ENABLE_mask
            end If
        else
            read_ICV_WR_ENABLE_value = data_low and ICV_WR_ENABLE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ICV_WR_ENABLE_value = &H0
        flag_ICV_WR_ENABLE        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class SWITCH_TOP_REGS_INSTANCE

    Public sw_misc_ctrl_reg
    Public prot_icv_addr_start_reg
    Public prot_icv_addr_end_reg
    Public icv_wr_disable_reg
    Public icv_wr_enable_reg


    Public default function Init(aBaseAddr)
        Set sw_misc_ctrl_reg = (New REGISTER_SWITCH_TOP_REGS_sw_misc_ctrl_reg)(aBaseAddr, 32)
        Set prot_icv_addr_start_reg = (New REGISTER_SWITCH_TOP_REGS_prot_icv_addr_start_reg)(aBaseAddr, 32)
        Set prot_icv_addr_end_reg = (New REGISTER_SWITCH_TOP_REGS_prot_icv_addr_end_reg)(aBaseAddr, 32)
        Set icv_wr_disable_reg = (New REGISTER_SWITCH_TOP_REGS_icv_wr_disable_reg)(aBaseAddr, 32)
        Set icv_wr_enable_reg = (New REGISTER_SWITCH_TOP_REGS_icv_wr_enable_reg)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set SWITCH_TOP_REGS = CreateObject("System.Collections.ArrayList")
SWITCH_TOP_REGS.Add ((New SWITCH_TOP_REGS_INSTANCE)(&H4b016000))


