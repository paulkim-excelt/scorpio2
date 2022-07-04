

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


'' @REGISTER : CPU_INDIRECT_REG_rdb_ind_regs_ctrl_ser_l16
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' timeout_err                                [15:15]          get_timeout_err
''                                                             set_timeout_err
''                                                             read_timeout_err
''                                                             write_timeout_err
''---------------------------------------------------------------------------------
'' RSVD1                                      [14:12]          get_RSVD1
''                                                             set_RSVD1
''                                                             read_RSVD1
''                                                             write_RSVD1
''---------------------------------------------------------------------------------
'' timeout_cntr                               [11:8]           get_timeout_cntr
''                                                             set_timeout_cntr
''                                                             read_timeout_cntr
''                                                             write_timeout_cntr
''---------------------------------------------------------------------------------
'' DONE                                       [7:7]            get_DONE
''                                                             set_DONE
''                                                             read_DONE
''                                                             write_DONE
''---------------------------------------------------------------------------------
'' STATUS                                     [6:6]            get_STATUS
''                                                             set_STATUS
''                                                             read_STATUS
''                                                             write_STATUS
''---------------------------------------------------------------------------------
'' COMMIT_ON_RDWR                             [5:5]            get_COMMIT_ON_RDWR
''                                                             set_COMMIT_ON_RDWR
''                                                             read_COMMIT_ON_RDWR
''                                                             write_COMMIT_ON_RDWR
''---------------------------------------------------------------------------------
'' COMMIT                                     [4:4]            get_COMMIT
''                                                             set_COMMIT
''                                                             read_COMMIT
''                                                             write_COMMIT
''---------------------------------------------------------------------------------
'' AUTO_INCR                                  [3:3]            get_AUTO_INCR
''                                                             set_AUTO_INCR
''                                                             read_AUTO_INCR
''                                                             write_AUTO_INCR
''---------------------------------------------------------------------------------
'' RDB_WR                                     [2:2]            get_RDB_WR
''                                                             set_RDB_WR
''                                                             read_RDB_WR
''                                                             write_RDB_WR
''---------------------------------------------------------------------------------
'' SIZE                                       [1:0]            get_SIZE
''                                                             set_SIZE
''                                                             read_SIZE
''                                                             write_SIZE
''---------------------------------------------------------------------------------
Class REGISTER_CPU_INDIRECT_REG_rdb_ind_regs_ctrl_ser_l16
    Private write_timeout_err_value
    Private read_timeout_err_value
    Private flag_timeout_err
    Private write_RSVD1_value
    Private read_RSVD1_value
    Private flag_RSVD1
    Private write_timeout_cntr_value
    Private read_timeout_cntr_value
    Private flag_timeout_cntr
    Private write_DONE_value
    Private read_DONE_value
    Private flag_DONE
    Private write_STATUS_value
    Private read_STATUS_value
    Private flag_STATUS
    Private write_COMMIT_ON_RDWR_value
    Private read_COMMIT_ON_RDWR_value
    Private flag_COMMIT_ON_RDWR
    Private write_COMMIT_value
    Private read_COMMIT_value
    Private flag_COMMIT
    Private write_AUTO_INCR_value
    Private read_AUTO_INCR_value
    Private flag_AUTO_INCR
    Private write_RDB_WR_value
    Private read_RDB_WR_value
    Private flag_RDB_WR
    Private write_SIZE_value
    Private read_SIZE_value
    Private flag_SIZE

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

    Property Get get_timeout_err
        get_timeout_err = read_timeout_err_value
    End Property

    Property Let set_timeout_err(aData)
        write_timeout_err_value = aData
        flag_timeout_err        = &H1
    End Property

    Property Get read_timeout_err
        read
        read_timeout_err = read_timeout_err_value
    End Property

    Property Let write_timeout_err(aData)
        set_timeout_err = aData
        write
    End Property

    Property Get get_RSVD1
        get_RSVD1 = read_RSVD1_value
    End Property

    Property Let set_RSVD1(aData)
        write_RSVD1_value = aData
        flag_RSVD1        = &H1
    End Property

    Property Get read_RSVD1
        read
        read_RSVD1 = read_RSVD1_value
    End Property

    Property Let write_RSVD1(aData)
        set_RSVD1 = aData
        write
    End Property

    Property Get get_timeout_cntr
        get_timeout_cntr = read_timeout_cntr_value
    End Property

    Property Let set_timeout_cntr(aData)
        write_timeout_cntr_value = aData
        flag_timeout_cntr        = &H1
    End Property

    Property Get read_timeout_cntr
        read
        read_timeout_cntr = read_timeout_cntr_value
    End Property

    Property Let write_timeout_cntr(aData)
        set_timeout_cntr = aData
        write
    End Property

    Property Get get_DONE
        get_DONE = read_DONE_value
    End Property

    Property Let set_DONE(aData)
        write_DONE_value = aData
        flag_DONE        = &H1
    End Property

    Property Get read_DONE
        read
        read_DONE = read_DONE_value
    End Property

    Property Let write_DONE(aData)
        set_DONE = aData
        write
    End Property

    Property Get get_STATUS
        get_STATUS = read_STATUS_value
    End Property

    Property Let set_STATUS(aData)
        write_STATUS_value = aData
        flag_STATUS        = &H1
    End Property

    Property Get read_STATUS
        read
        read_STATUS = read_STATUS_value
    End Property

    Property Let write_STATUS(aData)
        set_STATUS = aData
        write
    End Property

    Property Get get_COMMIT_ON_RDWR
        get_COMMIT_ON_RDWR = read_COMMIT_ON_RDWR_value
    End Property

    Property Let set_COMMIT_ON_RDWR(aData)
        write_COMMIT_ON_RDWR_value = aData
        flag_COMMIT_ON_RDWR        = &H1
    End Property

    Property Get read_COMMIT_ON_RDWR
        read
        read_COMMIT_ON_RDWR = read_COMMIT_ON_RDWR_value
    End Property

    Property Let write_COMMIT_ON_RDWR(aData)
        set_COMMIT_ON_RDWR = aData
        write
    End Property

    Property Get get_COMMIT
        get_COMMIT = read_COMMIT_value
    End Property

    Property Let set_COMMIT(aData)
        write_COMMIT_value = aData
        flag_COMMIT        = &H1
    End Property

    Property Get read_COMMIT
        read
        read_COMMIT = read_COMMIT_value
    End Property

    Property Let write_COMMIT(aData)
        set_COMMIT = aData
        write
    End Property

    Property Get get_AUTO_INCR
        get_AUTO_INCR = read_AUTO_INCR_value
    End Property

    Property Let set_AUTO_INCR(aData)
        write_AUTO_INCR_value = aData
        flag_AUTO_INCR        = &H1
    End Property

    Property Get read_AUTO_INCR
        read
        read_AUTO_INCR = read_AUTO_INCR_value
    End Property

    Property Let write_AUTO_INCR(aData)
        set_AUTO_INCR = aData
        write
    End Property

    Property Get get_RDB_WR
        get_RDB_WR = read_RDB_WR_value
    End Property

    Property Let set_RDB_WR(aData)
        write_RDB_WR_value = aData
        flag_RDB_WR        = &H1
    End Property

    Property Get read_RDB_WR
        read
        read_RDB_WR = read_RDB_WR_value
    End Property

    Property Let write_RDB_WR(aData)
        set_RDB_WR = aData
        write
    End Property

    Property Get get_SIZE
        get_SIZE = read_SIZE_value
    End Property

    Property Let set_SIZE(aData)
        write_SIZE_value = aData
        flag_SIZE        = &H1
    End Property

    Property Get read_SIZE
        read
        read_SIZE = read_SIZE_value
    End Property

    Property Let write_SIZE(aData)
        set_SIZE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_timeout_err_value = rightShift(data_low, 15) and &H1
        read_RSVD1_value = rightShift(data_low, 12) and &H7
        read_timeout_cntr_value = rightShift(data_low, 8) and &Hf
        read_DONE_value = rightShift(data_low, 7) and &H1
        read_STATUS_value = rightShift(data_low, 6) and &H1
        read_COMMIT_ON_RDWR_value = rightShift(data_low, 5) and &H1
        read_COMMIT_value = rightShift(data_low, 4) and &H1
        read_AUTO_INCR_value = rightShift(data_low, 3) and &H1
        read_RDB_WR_value = rightShift(data_low, 2) and &H1
        SIZE_mask = &H3
        if data_low > LONG_MAX then
            if SIZE_mask = mask then
                read_SIZE_value = data_low
            else
                read_SIZE_value = (data_low - H8000_0000) and SIZE_mask
            end If
        else
            read_SIZE_value = data_low and SIZE_mask
        end If

    End Sub

    Sub write
        If flag_timeout_err = &H0 or flag_RSVD1 = &H0 or flag_timeout_cntr = &H0 or flag_DONE = &H0 or flag_STATUS = &H0 or flag_COMMIT_ON_RDWR = &H0 or flag_COMMIT = &H0 or flag_AUTO_INCR = &H0 or flag_RDB_WR = &H0 or flag_SIZE = &H0 Then read
        If flag_timeout_err = &H0 Then write_timeout_err_value = get_timeout_err
        If flag_RSVD1 = &H0 Then write_RSVD1_value = get_RSVD1
        If flag_timeout_cntr = &H0 Then write_timeout_cntr_value = get_timeout_cntr
        If flag_DONE = &H0 Then write_DONE_value = get_DONE
        If flag_STATUS = &H0 Then write_STATUS_value = get_STATUS
        If flag_COMMIT_ON_RDWR = &H0 Then write_COMMIT_ON_RDWR_value = get_COMMIT_ON_RDWR
        If flag_COMMIT = &H0 Then write_COMMIT_value = get_COMMIT
        If flag_AUTO_INCR = &H0 Then write_AUTO_INCR_value = get_AUTO_INCR
        If flag_RDB_WR = &H0 Then write_RDB_WR_value = get_RDB_WR
        If flag_SIZE = &H0 Then write_SIZE_value = get_SIZE

        regValue = leftShift((write_timeout_err_value and &H1), 15) + leftShift((write_RSVD1_value and &H7), 12) + leftShift((write_timeout_cntr_value and &Hf), 8) + leftShift((write_DONE_value and &H1), 7) + leftShift((write_STATUS_value and &H1), 6) + leftShift((write_COMMIT_ON_RDWR_value and &H1), 5) + leftShift((write_COMMIT_value and &H1), 4) + leftShift((write_AUTO_INCR_value and &H1), 3) + leftShift((write_RDB_WR_value and &H1), 2) + leftShift((write_SIZE_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_timeout_err_value = rightShift(data_low, 15) and &H1
        read_RSVD1_value = rightShift(data_low, 12) and &H7
        read_timeout_cntr_value = rightShift(data_low, 8) and &Hf
        read_DONE_value = rightShift(data_low, 7) and &H1
        read_STATUS_value = rightShift(data_low, 6) and &H1
        read_COMMIT_ON_RDWR_value = rightShift(data_low, 5) and &H1
        read_COMMIT_value = rightShift(data_low, 4) and &H1
        read_AUTO_INCR_value = rightShift(data_low, 3) and &H1
        read_RDB_WR_value = rightShift(data_low, 2) and &H1
        SIZE_mask = &H3
        if data_low > LONG_MAX then
            if SIZE_mask = mask then
                read_SIZE_value = data_low
            else
                read_SIZE_value = (data_low - H8000_0000) and SIZE_mask
            end If
        else
            read_SIZE_value = data_low and SIZE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_timeout_err_value = &H0
        flag_timeout_err        = &H0
        write_RSVD1_value = &H0
        flag_RSVD1        = &H0
        write_timeout_cntr_value = &H0
        flag_timeout_cntr        = &H0
        write_DONE_value = &H0
        flag_DONE        = &H0
        write_STATUS_value = &H0
        flag_STATUS        = &H0
        write_COMMIT_ON_RDWR_value = &H0
        flag_COMMIT_ON_RDWR        = &H0
        write_COMMIT_value = &H0
        flag_COMMIT        = &H0
        write_AUTO_INCR_value = &H0
        flag_AUTO_INCR        = &H0
        write_RDB_WR_value = &H0
        flag_RDB_WR        = &H0
        write_SIZE_value = &H0
        flag_SIZE        = &H0
    End Sub
End Class


'' @REGISTER : CPU_INDIRECT_REG_rdb_ind_regs_ctrl_ser_h16
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
Class REGISTER_CPU_INDIRECT_REG_rdb_ind_regs_ctrl_ser_h16

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
    End Sub
End Class


'' @REGISTER : CPU_INDIRECT_REG_rdb_ind_regs_addr_ser_l16
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ADDRESS_L16                                [15:0]           get_ADDRESS_L16
''                                                             set_ADDRESS_L16
''                                                             read_ADDRESS_L16
''                                                             write_ADDRESS_L16
''---------------------------------------------------------------------------------
Class REGISTER_CPU_INDIRECT_REG_rdb_ind_regs_addr_ser_l16
    Private write_ADDRESS_L16_value
    Private read_ADDRESS_L16_value
    Private flag_ADDRESS_L16

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

    Property Get get_ADDRESS_L16
        get_ADDRESS_L16 = read_ADDRESS_L16_value
    End Property

    Property Let set_ADDRESS_L16(aData)
        write_ADDRESS_L16_value = aData
        flag_ADDRESS_L16        = &H1
    End Property

    Property Get read_ADDRESS_L16
        read
        read_ADDRESS_L16 = read_ADDRESS_L16_value
    End Property

    Property Let write_ADDRESS_L16(aData)
        set_ADDRESS_L16 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ADDRESS_L16_mask = &Hffff
        if data_low > LONG_MAX then
            if ADDRESS_L16_mask = mask then
                read_ADDRESS_L16_value = data_low
            else
                read_ADDRESS_L16_value = (data_low - H8000_0000) and ADDRESS_L16_mask
            end If
        else
            read_ADDRESS_L16_value = data_low and ADDRESS_L16_mask
        end If

    End Sub

    Sub write
        If flag_ADDRESS_L16 = &H0 Then read
        If flag_ADDRESS_L16 = &H0 Then write_ADDRESS_L16_value = get_ADDRESS_L16

        regValue = leftShift((write_ADDRESS_L16_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ADDRESS_L16_mask = &Hffff
        if data_low > LONG_MAX then
            if ADDRESS_L16_mask = mask then
                read_ADDRESS_L16_value = data_low
            else
                read_ADDRESS_L16_value = (data_low - H8000_0000) and ADDRESS_L16_mask
            end If
        else
            read_ADDRESS_L16_value = data_low and ADDRESS_L16_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ADDRESS_L16_value = &H0
        flag_ADDRESS_L16        = &H0
    End Sub
End Class


'' @REGISTER : CPU_INDIRECT_REG_rdb_ind_regs_addr_ser_h16
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ADDRESS_H16                                [15:0]           get_ADDRESS_H16
''                                                             set_ADDRESS_H16
''                                                             read_ADDRESS_H16
''                                                             write_ADDRESS_H16
''---------------------------------------------------------------------------------
Class REGISTER_CPU_INDIRECT_REG_rdb_ind_regs_addr_ser_h16
    Private write_ADDRESS_H16_value
    Private read_ADDRESS_H16_value
    Private flag_ADDRESS_H16

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

    Property Get get_ADDRESS_H16
        get_ADDRESS_H16 = read_ADDRESS_H16_value
    End Property

    Property Let set_ADDRESS_H16(aData)
        write_ADDRESS_H16_value = aData
        flag_ADDRESS_H16        = &H1
    End Property

    Property Get read_ADDRESS_H16
        read
        read_ADDRESS_H16 = read_ADDRESS_H16_value
    End Property

    Property Let write_ADDRESS_H16(aData)
        set_ADDRESS_H16 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ADDRESS_H16_mask = &Hffff
        if data_low > LONG_MAX then
            if ADDRESS_H16_mask = mask then
                read_ADDRESS_H16_value = data_low
            else
                read_ADDRESS_H16_value = (data_low - H8000_0000) and ADDRESS_H16_mask
            end If
        else
            read_ADDRESS_H16_value = data_low and ADDRESS_H16_mask
        end If

    End Sub

    Sub write
        If flag_ADDRESS_H16 = &H0 Then read
        If flag_ADDRESS_H16 = &H0 Then write_ADDRESS_H16_value = get_ADDRESS_H16

        regValue = leftShift((write_ADDRESS_H16_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ADDRESS_H16_mask = &Hffff
        if data_low > LONG_MAX then
            if ADDRESS_H16_mask = mask then
                read_ADDRESS_H16_value = data_low
            else
                read_ADDRESS_H16_value = (data_low - H8000_0000) and ADDRESS_H16_mask
            end If
        else
            read_ADDRESS_H16_value = data_low and ADDRESS_H16_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ADDRESS_H16_value = &H0
        flag_ADDRESS_H16        = &H0
    End Sub
End Class


'' @REGISTER : CPU_INDIRECT_REG_rdb_ind_regs_data_ser_l_l16
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DATA_L_L16                                 [15:0]           get_DATA_L_L16
''                                                             set_DATA_L_L16
''                                                             read_DATA_L_L16
''                                                             write_DATA_L_L16
''---------------------------------------------------------------------------------
Class REGISTER_CPU_INDIRECT_REG_rdb_ind_regs_data_ser_l_l16
    Private write_DATA_L_L16_value
    Private read_DATA_L_L16_value
    Private flag_DATA_L_L16

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

    Property Get get_DATA_L_L16
        get_DATA_L_L16 = read_DATA_L_L16_value
    End Property

    Property Let set_DATA_L_L16(aData)
        write_DATA_L_L16_value = aData
        flag_DATA_L_L16        = &H1
    End Property

    Property Get read_DATA_L_L16
        read
        read_DATA_L_L16 = read_DATA_L_L16_value
    End Property

    Property Let write_DATA_L_L16(aData)
        set_DATA_L_L16 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DATA_L_L16_mask = &Hffff
        if data_low > LONG_MAX then
            if DATA_L_L16_mask = mask then
                read_DATA_L_L16_value = data_low
            else
                read_DATA_L_L16_value = (data_low - H8000_0000) and DATA_L_L16_mask
            end If
        else
            read_DATA_L_L16_value = data_low and DATA_L_L16_mask
        end If

    End Sub

    Sub write
        If flag_DATA_L_L16 = &H0 Then read
        If flag_DATA_L_L16 = &H0 Then write_DATA_L_L16_value = get_DATA_L_L16

        regValue = leftShift((write_DATA_L_L16_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DATA_L_L16_mask = &Hffff
        if data_low > LONG_MAX then
            if DATA_L_L16_mask = mask then
                read_DATA_L_L16_value = data_low
            else
                read_DATA_L_L16_value = (data_low - H8000_0000) and DATA_L_L16_mask
            end If
        else
            read_DATA_L_L16_value = data_low and DATA_L_L16_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DATA_L_L16_value = &H0
        flag_DATA_L_L16        = &H0
    End Sub
End Class


'' @REGISTER : CPU_INDIRECT_REG_rdb_ind_regs_data_ser_l_h16
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DATA_L_H16                                 [15:0]           get_DATA_L_H16
''                                                             set_DATA_L_H16
''                                                             read_DATA_L_H16
''                                                             write_DATA_L_H16
''---------------------------------------------------------------------------------
Class REGISTER_CPU_INDIRECT_REG_rdb_ind_regs_data_ser_l_h16
    Private write_DATA_L_H16_value
    Private read_DATA_L_H16_value
    Private flag_DATA_L_H16

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Ha
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_DATA_L_H16
        get_DATA_L_H16 = read_DATA_L_H16_value
    End Property

    Property Let set_DATA_L_H16(aData)
        write_DATA_L_H16_value = aData
        flag_DATA_L_H16        = &H1
    End Property

    Property Get read_DATA_L_H16
        read
        read_DATA_L_H16 = read_DATA_L_H16_value
    End Property

    Property Let write_DATA_L_H16(aData)
        set_DATA_L_H16 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DATA_L_H16_mask = &Hffff
        if data_low > LONG_MAX then
            if DATA_L_H16_mask = mask then
                read_DATA_L_H16_value = data_low
            else
                read_DATA_L_H16_value = (data_low - H8000_0000) and DATA_L_H16_mask
            end If
        else
            read_DATA_L_H16_value = data_low and DATA_L_H16_mask
        end If

    End Sub

    Sub write
        If flag_DATA_L_H16 = &H0 Then read
        If flag_DATA_L_H16 = &H0 Then write_DATA_L_H16_value = get_DATA_L_H16

        regValue = leftShift((write_DATA_L_H16_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DATA_L_H16_mask = &Hffff
        if data_low > LONG_MAX then
            if DATA_L_H16_mask = mask then
                read_DATA_L_H16_value = data_low
            else
                read_DATA_L_H16_value = (data_low - H8000_0000) and DATA_L_H16_mask
            end If
        else
            read_DATA_L_H16_value = data_low and DATA_L_H16_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DATA_L_H16_value = &H0
        flag_DATA_L_H16        = &H0
    End Sub
End Class


'' @REGISTER : CPU_INDIRECT_REG_rdb_ind_regs_data_ser_h_l16
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DATA_H_L16                                 [15:0]           get_DATA_H_L16
''                                                             set_DATA_H_L16
''                                                             read_DATA_H_L16
''                                                             write_DATA_H_L16
''---------------------------------------------------------------------------------
Class REGISTER_CPU_INDIRECT_REG_rdb_ind_regs_data_ser_h_l16
    Private write_DATA_H_L16_value
    Private read_DATA_H_L16_value
    Private flag_DATA_H_L16

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

    Property Get get_DATA_H_L16
        get_DATA_H_L16 = read_DATA_H_L16_value
    End Property

    Property Let set_DATA_H_L16(aData)
        write_DATA_H_L16_value = aData
        flag_DATA_H_L16        = &H1
    End Property

    Property Get read_DATA_H_L16
        read
        read_DATA_H_L16 = read_DATA_H_L16_value
    End Property

    Property Let write_DATA_H_L16(aData)
        set_DATA_H_L16 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DATA_H_L16_mask = &Hffff
        if data_low > LONG_MAX then
            if DATA_H_L16_mask = mask then
                read_DATA_H_L16_value = data_low
            else
                read_DATA_H_L16_value = (data_low - H8000_0000) and DATA_H_L16_mask
            end If
        else
            read_DATA_H_L16_value = data_low and DATA_H_L16_mask
        end If

    End Sub

    Sub write
        If flag_DATA_H_L16 = &H0 Then read
        If flag_DATA_H_L16 = &H0 Then write_DATA_H_L16_value = get_DATA_H_L16

        regValue = leftShift((write_DATA_H_L16_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DATA_H_L16_mask = &Hffff
        if data_low > LONG_MAX then
            if DATA_H_L16_mask = mask then
                read_DATA_H_L16_value = data_low
            else
                read_DATA_H_L16_value = (data_low - H8000_0000) and DATA_H_L16_mask
            end If
        else
            read_DATA_H_L16_value = data_low and DATA_H_L16_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DATA_H_L16_value = &H0
        flag_DATA_H_L16        = &H0
    End Sub
End Class


'' @REGISTER : CPU_INDIRECT_REG_rdb_ind_regs_data_ser_h_h16
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DATA_H_H16                                 [15:0]           get_DATA_H_H16
''                                                             set_DATA_H_H16
''                                                             read_DATA_H_H16
''                                                             write_DATA_H_H16
''---------------------------------------------------------------------------------
Class REGISTER_CPU_INDIRECT_REG_rdb_ind_regs_data_ser_h_h16
    Private write_DATA_H_H16_value
    Private read_DATA_H_H16_value
    Private flag_DATA_H_H16

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &He
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_DATA_H_H16
        get_DATA_H_H16 = read_DATA_H_H16_value
    End Property

    Property Let set_DATA_H_H16(aData)
        write_DATA_H_H16_value = aData
        flag_DATA_H_H16        = &H1
    End Property

    Property Get read_DATA_H_H16
        read
        read_DATA_H_H16 = read_DATA_H_H16_value
    End Property

    Property Let write_DATA_H_H16(aData)
        set_DATA_H_H16 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DATA_H_H16_mask = &Hffff
        if data_low > LONG_MAX then
            if DATA_H_H16_mask = mask then
                read_DATA_H_H16_value = data_low
            else
                read_DATA_H_H16_value = (data_low - H8000_0000) and DATA_H_H16_mask
            end If
        else
            read_DATA_H_H16_value = data_low and DATA_H_H16_mask
        end If

    End Sub

    Sub write
        If flag_DATA_H_H16 = &H0 Then read
        If flag_DATA_H_H16 = &H0 Then write_DATA_H_H16_value = get_DATA_H_H16

        regValue = leftShift((write_DATA_H_H16_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DATA_H_H16_mask = &Hffff
        if data_low > LONG_MAX then
            if DATA_H_H16_mask = mask then
                read_DATA_H_H16_value = data_low
            else
                read_DATA_H_H16_value = (data_low - H8000_0000) and DATA_H_H16_mask
            end If
        else
            read_DATA_H_H16_value = data_low and DATA_H_H16_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DATA_H_H16_value = &H0
        flag_DATA_H_H16        = &H0
    End Sub
End Class


'' @REGISTER : CPU_INDIRECT_REG_rdb_ind_regs_ctrl_cpu_l16
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' timeout_err                                [15:15]          get_timeout_err
''                                                             set_timeout_err
''                                                             read_timeout_err
''                                                             write_timeout_err
''---------------------------------------------------------------------------------
'' RSVD1                                      [14:12]          get_RSVD1
''                                                             set_RSVD1
''                                                             read_RSVD1
''                                                             write_RSVD1
''---------------------------------------------------------------------------------
'' timeout_cntr                               [11:8]           get_timeout_cntr
''                                                             set_timeout_cntr
''                                                             read_timeout_cntr
''                                                             write_timeout_cntr
''---------------------------------------------------------------------------------
'' DONE                                       [7:7]            get_DONE
''                                                             set_DONE
''                                                             read_DONE
''                                                             write_DONE
''---------------------------------------------------------------------------------
'' STATUS                                     [6:6]            get_STATUS
''                                                             set_STATUS
''                                                             read_STATUS
''                                                             write_STATUS
''---------------------------------------------------------------------------------
'' COMMIT_ON_RDWR                             [5:5]            get_COMMIT_ON_RDWR
''                                                             set_COMMIT_ON_RDWR
''                                                             read_COMMIT_ON_RDWR
''                                                             write_COMMIT_ON_RDWR
''---------------------------------------------------------------------------------
'' COMMIT                                     [4:4]            get_COMMIT
''                                                             set_COMMIT
''                                                             read_COMMIT
''                                                             write_COMMIT
''---------------------------------------------------------------------------------
'' AUTO_INCR                                  [3:3]            get_AUTO_INCR
''                                                             set_AUTO_INCR
''                                                             read_AUTO_INCR
''                                                             write_AUTO_INCR
''---------------------------------------------------------------------------------
'' RDB_WR                                     [2:2]            get_RDB_WR
''                                                             set_RDB_WR
''                                                             read_RDB_WR
''                                                             write_RDB_WR
''---------------------------------------------------------------------------------
'' SIZE                                       [1:0]            get_SIZE
''                                                             set_SIZE
''                                                             read_SIZE
''                                                             write_SIZE
''---------------------------------------------------------------------------------
Class REGISTER_CPU_INDIRECT_REG_rdb_ind_regs_ctrl_cpu_l16
    Private write_timeout_err_value
    Private read_timeout_err_value
    Private flag_timeout_err
    Private write_RSVD1_value
    Private read_RSVD1_value
    Private flag_RSVD1
    Private write_timeout_cntr_value
    Private read_timeout_cntr_value
    Private flag_timeout_cntr
    Private write_DONE_value
    Private read_DONE_value
    Private flag_DONE
    Private write_STATUS_value
    Private read_STATUS_value
    Private flag_STATUS
    Private write_COMMIT_ON_RDWR_value
    Private read_COMMIT_ON_RDWR_value
    Private flag_COMMIT_ON_RDWR
    Private write_COMMIT_value
    Private read_COMMIT_value
    Private flag_COMMIT
    Private write_AUTO_INCR_value
    Private read_AUTO_INCR_value
    Private flag_AUTO_INCR
    Private write_RDB_WR_value
    Private read_RDB_WR_value
    Private flag_RDB_WR
    Private write_SIZE_value
    Private read_SIZE_value
    Private flag_SIZE

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

    Property Get get_timeout_err
        get_timeout_err = read_timeout_err_value
    End Property

    Property Let set_timeout_err(aData)
        write_timeout_err_value = aData
        flag_timeout_err        = &H1
    End Property

    Property Get read_timeout_err
        read
        read_timeout_err = read_timeout_err_value
    End Property

    Property Let write_timeout_err(aData)
        set_timeout_err = aData
        write
    End Property

    Property Get get_RSVD1
        get_RSVD1 = read_RSVD1_value
    End Property

    Property Let set_RSVD1(aData)
        write_RSVD1_value = aData
        flag_RSVD1        = &H1
    End Property

    Property Get read_RSVD1
        read
        read_RSVD1 = read_RSVD1_value
    End Property

    Property Let write_RSVD1(aData)
        set_RSVD1 = aData
        write
    End Property

    Property Get get_timeout_cntr
        get_timeout_cntr = read_timeout_cntr_value
    End Property

    Property Let set_timeout_cntr(aData)
        write_timeout_cntr_value = aData
        flag_timeout_cntr        = &H1
    End Property

    Property Get read_timeout_cntr
        read
        read_timeout_cntr = read_timeout_cntr_value
    End Property

    Property Let write_timeout_cntr(aData)
        set_timeout_cntr = aData
        write
    End Property

    Property Get get_DONE
        get_DONE = read_DONE_value
    End Property

    Property Let set_DONE(aData)
        write_DONE_value = aData
        flag_DONE        = &H1
    End Property

    Property Get read_DONE
        read
        read_DONE = read_DONE_value
    End Property

    Property Let write_DONE(aData)
        set_DONE = aData
        write
    End Property

    Property Get get_STATUS
        get_STATUS = read_STATUS_value
    End Property

    Property Let set_STATUS(aData)
        write_STATUS_value = aData
        flag_STATUS        = &H1
    End Property

    Property Get read_STATUS
        read
        read_STATUS = read_STATUS_value
    End Property

    Property Let write_STATUS(aData)
        set_STATUS = aData
        write
    End Property

    Property Get get_COMMIT_ON_RDWR
        get_COMMIT_ON_RDWR = read_COMMIT_ON_RDWR_value
    End Property

    Property Let set_COMMIT_ON_RDWR(aData)
        write_COMMIT_ON_RDWR_value = aData
        flag_COMMIT_ON_RDWR        = &H1
    End Property

    Property Get read_COMMIT_ON_RDWR
        read
        read_COMMIT_ON_RDWR = read_COMMIT_ON_RDWR_value
    End Property

    Property Let write_COMMIT_ON_RDWR(aData)
        set_COMMIT_ON_RDWR = aData
        write
    End Property

    Property Get get_COMMIT
        get_COMMIT = read_COMMIT_value
    End Property

    Property Let set_COMMIT(aData)
        write_COMMIT_value = aData
        flag_COMMIT        = &H1
    End Property

    Property Get read_COMMIT
        read
        read_COMMIT = read_COMMIT_value
    End Property

    Property Let write_COMMIT(aData)
        set_COMMIT = aData
        write
    End Property

    Property Get get_AUTO_INCR
        get_AUTO_INCR = read_AUTO_INCR_value
    End Property

    Property Let set_AUTO_INCR(aData)
        write_AUTO_INCR_value = aData
        flag_AUTO_INCR        = &H1
    End Property

    Property Get read_AUTO_INCR
        read
        read_AUTO_INCR = read_AUTO_INCR_value
    End Property

    Property Let write_AUTO_INCR(aData)
        set_AUTO_INCR = aData
        write
    End Property

    Property Get get_RDB_WR
        get_RDB_WR = read_RDB_WR_value
    End Property

    Property Let set_RDB_WR(aData)
        write_RDB_WR_value = aData
        flag_RDB_WR        = &H1
    End Property

    Property Get read_RDB_WR
        read
        read_RDB_WR = read_RDB_WR_value
    End Property

    Property Let write_RDB_WR(aData)
        set_RDB_WR = aData
        write
    End Property

    Property Get get_SIZE
        get_SIZE = read_SIZE_value
    End Property

    Property Let set_SIZE(aData)
        write_SIZE_value = aData
        flag_SIZE        = &H1
    End Property

    Property Get read_SIZE
        read
        read_SIZE = read_SIZE_value
    End Property

    Property Let write_SIZE(aData)
        set_SIZE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_timeout_err_value = rightShift(data_low, 15) and &H1
        read_RSVD1_value = rightShift(data_low, 12) and &H7
        read_timeout_cntr_value = rightShift(data_low, 8) and &Hf
        read_DONE_value = rightShift(data_low, 7) and &H1
        read_STATUS_value = rightShift(data_low, 6) and &H1
        read_COMMIT_ON_RDWR_value = rightShift(data_low, 5) and &H1
        read_COMMIT_value = rightShift(data_low, 4) and &H1
        read_AUTO_INCR_value = rightShift(data_low, 3) and &H1
        read_RDB_WR_value = rightShift(data_low, 2) and &H1
        SIZE_mask = &H3
        if data_low > LONG_MAX then
            if SIZE_mask = mask then
                read_SIZE_value = data_low
            else
                read_SIZE_value = (data_low - H8000_0000) and SIZE_mask
            end If
        else
            read_SIZE_value = data_low and SIZE_mask
        end If

    End Sub

    Sub write
        If flag_timeout_err = &H0 or flag_RSVD1 = &H0 or flag_timeout_cntr = &H0 or flag_DONE = &H0 or flag_STATUS = &H0 or flag_COMMIT_ON_RDWR = &H0 or flag_COMMIT = &H0 or flag_AUTO_INCR = &H0 or flag_RDB_WR = &H0 or flag_SIZE = &H0 Then read
        If flag_timeout_err = &H0 Then write_timeout_err_value = get_timeout_err
        If flag_RSVD1 = &H0 Then write_RSVD1_value = get_RSVD1
        If flag_timeout_cntr = &H0 Then write_timeout_cntr_value = get_timeout_cntr
        If flag_DONE = &H0 Then write_DONE_value = get_DONE
        If flag_STATUS = &H0 Then write_STATUS_value = get_STATUS
        If flag_COMMIT_ON_RDWR = &H0 Then write_COMMIT_ON_RDWR_value = get_COMMIT_ON_RDWR
        If flag_COMMIT = &H0 Then write_COMMIT_value = get_COMMIT
        If flag_AUTO_INCR = &H0 Then write_AUTO_INCR_value = get_AUTO_INCR
        If flag_RDB_WR = &H0 Then write_RDB_WR_value = get_RDB_WR
        If flag_SIZE = &H0 Then write_SIZE_value = get_SIZE

        regValue = leftShift((write_timeout_err_value and &H1), 15) + leftShift((write_RSVD1_value and &H7), 12) + leftShift((write_timeout_cntr_value and &Hf), 8) + leftShift((write_DONE_value and &H1), 7) + leftShift((write_STATUS_value and &H1), 6) + leftShift((write_COMMIT_ON_RDWR_value and &H1), 5) + leftShift((write_COMMIT_value and &H1), 4) + leftShift((write_AUTO_INCR_value and &H1), 3) + leftShift((write_RDB_WR_value and &H1), 2) + leftShift((write_SIZE_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_timeout_err_value = rightShift(data_low, 15) and &H1
        read_RSVD1_value = rightShift(data_low, 12) and &H7
        read_timeout_cntr_value = rightShift(data_low, 8) and &Hf
        read_DONE_value = rightShift(data_low, 7) and &H1
        read_STATUS_value = rightShift(data_low, 6) and &H1
        read_COMMIT_ON_RDWR_value = rightShift(data_low, 5) and &H1
        read_COMMIT_value = rightShift(data_low, 4) and &H1
        read_AUTO_INCR_value = rightShift(data_low, 3) and &H1
        read_RDB_WR_value = rightShift(data_low, 2) and &H1
        SIZE_mask = &H3
        if data_low > LONG_MAX then
            if SIZE_mask = mask then
                read_SIZE_value = data_low
            else
                read_SIZE_value = (data_low - H8000_0000) and SIZE_mask
            end If
        else
            read_SIZE_value = data_low and SIZE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_timeout_err_value = &H0
        flag_timeout_err        = &H0
        write_RSVD1_value = &H0
        flag_RSVD1        = &H0
        write_timeout_cntr_value = &H0
        flag_timeout_cntr        = &H0
        write_DONE_value = &H0
        flag_DONE        = &H0
        write_STATUS_value = &H0
        flag_STATUS        = &H0
        write_COMMIT_ON_RDWR_value = &H0
        flag_COMMIT_ON_RDWR        = &H0
        write_COMMIT_value = &H0
        flag_COMMIT        = &H0
        write_AUTO_INCR_value = &H0
        flag_AUTO_INCR        = &H0
        write_RDB_WR_value = &H0
        flag_RDB_WR        = &H0
        write_SIZE_value = &H0
        flag_SIZE        = &H0
    End Sub
End Class


'' @REGISTER : CPU_INDIRECT_REG_rdb_ind_regs_ctrl_cpu_h16
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
Class REGISTER_CPU_INDIRECT_REG_rdb_ind_regs_ctrl_cpu_h16

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H12
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
    End Sub
End Class


'' @REGISTER : CPU_INDIRECT_REG_rdb_ind_regs_addr_cpu_l16
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ADDRESS_L16                                [15:0]           get_ADDRESS_L16
''                                                             set_ADDRESS_L16
''                                                             read_ADDRESS_L16
''                                                             write_ADDRESS_L16
''---------------------------------------------------------------------------------
Class REGISTER_CPU_INDIRECT_REG_rdb_ind_regs_addr_cpu_l16
    Private write_ADDRESS_L16_value
    Private read_ADDRESS_L16_value
    Private flag_ADDRESS_L16

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

    Property Get get_ADDRESS_L16
        get_ADDRESS_L16 = read_ADDRESS_L16_value
    End Property

    Property Let set_ADDRESS_L16(aData)
        write_ADDRESS_L16_value = aData
        flag_ADDRESS_L16        = &H1
    End Property

    Property Get read_ADDRESS_L16
        read
        read_ADDRESS_L16 = read_ADDRESS_L16_value
    End Property

    Property Let write_ADDRESS_L16(aData)
        set_ADDRESS_L16 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ADDRESS_L16_mask = &Hffff
        if data_low > LONG_MAX then
            if ADDRESS_L16_mask = mask then
                read_ADDRESS_L16_value = data_low
            else
                read_ADDRESS_L16_value = (data_low - H8000_0000) and ADDRESS_L16_mask
            end If
        else
            read_ADDRESS_L16_value = data_low and ADDRESS_L16_mask
        end If

    End Sub

    Sub write
        If flag_ADDRESS_L16 = &H0 Then read
        If flag_ADDRESS_L16 = &H0 Then write_ADDRESS_L16_value = get_ADDRESS_L16

        regValue = leftShift((write_ADDRESS_L16_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ADDRESS_L16_mask = &Hffff
        if data_low > LONG_MAX then
            if ADDRESS_L16_mask = mask then
                read_ADDRESS_L16_value = data_low
            else
                read_ADDRESS_L16_value = (data_low - H8000_0000) and ADDRESS_L16_mask
            end If
        else
            read_ADDRESS_L16_value = data_low and ADDRESS_L16_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ADDRESS_L16_value = &H0
        flag_ADDRESS_L16        = &H0
    End Sub
End Class


'' @REGISTER : CPU_INDIRECT_REG_rdb_ind_regs_addr_cpu_h16
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ADDRESS_H16                                [15:0]           get_ADDRESS_H16
''                                                             set_ADDRESS_H16
''                                                             read_ADDRESS_H16
''                                                             write_ADDRESS_H16
''---------------------------------------------------------------------------------
Class REGISTER_CPU_INDIRECT_REG_rdb_ind_regs_addr_cpu_h16
    Private write_ADDRESS_H16_value
    Private read_ADDRESS_H16_value
    Private flag_ADDRESS_H16

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H16
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ADDRESS_H16
        get_ADDRESS_H16 = read_ADDRESS_H16_value
    End Property

    Property Let set_ADDRESS_H16(aData)
        write_ADDRESS_H16_value = aData
        flag_ADDRESS_H16        = &H1
    End Property

    Property Get read_ADDRESS_H16
        read
        read_ADDRESS_H16 = read_ADDRESS_H16_value
    End Property

    Property Let write_ADDRESS_H16(aData)
        set_ADDRESS_H16 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ADDRESS_H16_mask = &Hffff
        if data_low > LONG_MAX then
            if ADDRESS_H16_mask = mask then
                read_ADDRESS_H16_value = data_low
            else
                read_ADDRESS_H16_value = (data_low - H8000_0000) and ADDRESS_H16_mask
            end If
        else
            read_ADDRESS_H16_value = data_low and ADDRESS_H16_mask
        end If

    End Sub

    Sub write
        If flag_ADDRESS_H16 = &H0 Then read
        If flag_ADDRESS_H16 = &H0 Then write_ADDRESS_H16_value = get_ADDRESS_H16

        regValue = leftShift((write_ADDRESS_H16_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ADDRESS_H16_mask = &Hffff
        if data_low > LONG_MAX then
            if ADDRESS_H16_mask = mask then
                read_ADDRESS_H16_value = data_low
            else
                read_ADDRESS_H16_value = (data_low - H8000_0000) and ADDRESS_H16_mask
            end If
        else
            read_ADDRESS_H16_value = data_low and ADDRESS_H16_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ADDRESS_H16_value = &H0
        flag_ADDRESS_H16        = &H0
    End Sub
End Class


'' @REGISTER : CPU_INDIRECT_REG_rdb_ind_regs_data_cpu_l_l16
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DATA_L_L16                                 [15:0]           get_DATA_L_L16
''                                                             set_DATA_L_L16
''                                                             read_DATA_L_L16
''                                                             write_DATA_L_L16
''---------------------------------------------------------------------------------
Class REGISTER_CPU_INDIRECT_REG_rdb_ind_regs_data_cpu_l_l16
    Private write_DATA_L_L16_value
    Private read_DATA_L_L16_value
    Private flag_DATA_L_L16

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

    Property Get get_DATA_L_L16
        get_DATA_L_L16 = read_DATA_L_L16_value
    End Property

    Property Let set_DATA_L_L16(aData)
        write_DATA_L_L16_value = aData
        flag_DATA_L_L16        = &H1
    End Property

    Property Get read_DATA_L_L16
        read
        read_DATA_L_L16 = read_DATA_L_L16_value
    End Property

    Property Let write_DATA_L_L16(aData)
        set_DATA_L_L16 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DATA_L_L16_mask = &Hffff
        if data_low > LONG_MAX then
            if DATA_L_L16_mask = mask then
                read_DATA_L_L16_value = data_low
            else
                read_DATA_L_L16_value = (data_low - H8000_0000) and DATA_L_L16_mask
            end If
        else
            read_DATA_L_L16_value = data_low and DATA_L_L16_mask
        end If

    End Sub

    Sub write
        If flag_DATA_L_L16 = &H0 Then read
        If flag_DATA_L_L16 = &H0 Then write_DATA_L_L16_value = get_DATA_L_L16

        regValue = leftShift((write_DATA_L_L16_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DATA_L_L16_mask = &Hffff
        if data_low > LONG_MAX then
            if DATA_L_L16_mask = mask then
                read_DATA_L_L16_value = data_low
            else
                read_DATA_L_L16_value = (data_low - H8000_0000) and DATA_L_L16_mask
            end If
        else
            read_DATA_L_L16_value = data_low and DATA_L_L16_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DATA_L_L16_value = &H0
        flag_DATA_L_L16        = &H0
    End Sub
End Class


'' @REGISTER : CPU_INDIRECT_REG_rdb_ind_regs_data_cpu_l_h16
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DATA_L_H16                                 [15:0]           get_DATA_L_H16
''                                                             set_DATA_L_H16
''                                                             read_DATA_L_H16
''                                                             write_DATA_L_H16
''---------------------------------------------------------------------------------
Class REGISTER_CPU_INDIRECT_REG_rdb_ind_regs_data_cpu_l_h16
    Private write_DATA_L_H16_value
    Private read_DATA_L_H16_value
    Private flag_DATA_L_H16

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_DATA_L_H16
        get_DATA_L_H16 = read_DATA_L_H16_value
    End Property

    Property Let set_DATA_L_H16(aData)
        write_DATA_L_H16_value = aData
        flag_DATA_L_H16        = &H1
    End Property

    Property Get read_DATA_L_H16
        read
        read_DATA_L_H16 = read_DATA_L_H16_value
    End Property

    Property Let write_DATA_L_H16(aData)
        set_DATA_L_H16 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DATA_L_H16_mask = &Hffff
        if data_low > LONG_MAX then
            if DATA_L_H16_mask = mask then
                read_DATA_L_H16_value = data_low
            else
                read_DATA_L_H16_value = (data_low - H8000_0000) and DATA_L_H16_mask
            end If
        else
            read_DATA_L_H16_value = data_low and DATA_L_H16_mask
        end If

    End Sub

    Sub write
        If flag_DATA_L_H16 = &H0 Then read
        If flag_DATA_L_H16 = &H0 Then write_DATA_L_H16_value = get_DATA_L_H16

        regValue = leftShift((write_DATA_L_H16_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DATA_L_H16_mask = &Hffff
        if data_low > LONG_MAX then
            if DATA_L_H16_mask = mask then
                read_DATA_L_H16_value = data_low
            else
                read_DATA_L_H16_value = (data_low - H8000_0000) and DATA_L_H16_mask
            end If
        else
            read_DATA_L_H16_value = data_low and DATA_L_H16_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DATA_L_H16_value = &H0
        flag_DATA_L_H16        = &H0
    End Sub
End Class


'' @REGISTER : CPU_INDIRECT_REG_rdb_ind_regs_data_cpu_h_l16
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DATA_H_L16                                 [15:0]           get_DATA_H_L16
''                                                             set_DATA_H_L16
''                                                             read_DATA_H_L16
''                                                             write_DATA_H_L16
''---------------------------------------------------------------------------------
Class REGISTER_CPU_INDIRECT_REG_rdb_ind_regs_data_cpu_h_l16
    Private write_DATA_H_L16_value
    Private read_DATA_H_L16_value
    Private flag_DATA_H_L16

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

    Property Get get_DATA_H_L16
        get_DATA_H_L16 = read_DATA_H_L16_value
    End Property

    Property Let set_DATA_H_L16(aData)
        write_DATA_H_L16_value = aData
        flag_DATA_H_L16        = &H1
    End Property

    Property Get read_DATA_H_L16
        read
        read_DATA_H_L16 = read_DATA_H_L16_value
    End Property

    Property Let write_DATA_H_L16(aData)
        set_DATA_H_L16 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DATA_H_L16_mask = &Hffff
        if data_low > LONG_MAX then
            if DATA_H_L16_mask = mask then
                read_DATA_H_L16_value = data_low
            else
                read_DATA_H_L16_value = (data_low - H8000_0000) and DATA_H_L16_mask
            end If
        else
            read_DATA_H_L16_value = data_low and DATA_H_L16_mask
        end If

    End Sub

    Sub write
        If flag_DATA_H_L16 = &H0 Then read
        If flag_DATA_H_L16 = &H0 Then write_DATA_H_L16_value = get_DATA_H_L16

        regValue = leftShift((write_DATA_H_L16_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DATA_H_L16_mask = &Hffff
        if data_low > LONG_MAX then
            if DATA_H_L16_mask = mask then
                read_DATA_H_L16_value = data_low
            else
                read_DATA_H_L16_value = (data_low - H8000_0000) and DATA_H_L16_mask
            end If
        else
            read_DATA_H_L16_value = data_low and DATA_H_L16_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DATA_H_L16_value = &H0
        flag_DATA_H_L16        = &H0
    End Sub
End Class


'' @REGISTER : CPU_INDIRECT_REG_rdb_ind_regs_data_cpu_h_h16
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DATA_H_H16                                 [15:0]           get_DATA_H_H16
''                                                             set_DATA_H_H16
''                                                             read_DATA_H_H16
''                                                             write_DATA_H_H16
''---------------------------------------------------------------------------------
Class REGISTER_CPU_INDIRECT_REG_rdb_ind_regs_data_cpu_h_h16
    Private write_DATA_H_H16_value
    Private read_DATA_H_H16_value
    Private flag_DATA_H_H16

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

    Property Get get_DATA_H_H16
        get_DATA_H_H16 = read_DATA_H_H16_value
    End Property

    Property Let set_DATA_H_H16(aData)
        write_DATA_H_H16_value = aData
        flag_DATA_H_H16        = &H1
    End Property

    Property Get read_DATA_H_H16
        read
        read_DATA_H_H16 = read_DATA_H_H16_value
    End Property

    Property Let write_DATA_H_H16(aData)
        set_DATA_H_H16 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DATA_H_H16_mask = &Hffff
        if data_low > LONG_MAX then
            if DATA_H_H16_mask = mask then
                read_DATA_H_H16_value = data_low
            else
                read_DATA_H_H16_value = (data_low - H8000_0000) and DATA_H_H16_mask
            end If
        else
            read_DATA_H_H16_value = data_low and DATA_H_H16_mask
        end If

    End Sub

    Sub write
        If flag_DATA_H_H16 = &H0 Then read
        If flag_DATA_H_H16 = &H0 Then write_DATA_H_H16_value = get_DATA_H_H16

        regValue = leftShift((write_DATA_H_H16_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DATA_H_H16_mask = &Hffff
        if data_low > LONG_MAX then
            if DATA_H_H16_mask = mask then
                read_DATA_H_H16_value = data_low
            else
                read_DATA_H_H16_value = (data_low - H8000_0000) and DATA_H_H16_mask
            end If
        else
            read_DATA_H_H16_value = data_low and DATA_H_H16_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DATA_H_H16_value = &H0
        flag_DATA_H_H16        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class CPU_INDIRECT_REG_INSTANCE

    Public rdb_ind_regs_ctrl_ser_l16
    Public rdb_ind_regs_ctrl_ser_h16
    Public rdb_ind_regs_addr_ser_l16
    Public rdb_ind_regs_addr_ser_h16
    Public rdb_ind_regs_data_ser_l_l16
    Public rdb_ind_regs_data_ser_l_h16
    Public rdb_ind_regs_data_ser_h_l16
    Public rdb_ind_regs_data_ser_h_h16
    Public rdb_ind_regs_ctrl_cpu_l16
    Public rdb_ind_regs_ctrl_cpu_h16
    Public rdb_ind_regs_addr_cpu_l16
    Public rdb_ind_regs_addr_cpu_h16
    Public rdb_ind_regs_data_cpu_l_l16
    Public rdb_ind_regs_data_cpu_l_h16
    Public rdb_ind_regs_data_cpu_h_l16
    Public rdb_ind_regs_data_cpu_h_h16


    Public default function Init(aBaseAddr)
        Set rdb_ind_regs_ctrl_ser_l16 = (New REGISTER_CPU_INDIRECT_REG_rdb_ind_regs_ctrl_ser_l16)(aBaseAddr, 16)
        Set rdb_ind_regs_ctrl_ser_h16 = (New REGISTER_CPU_INDIRECT_REG_rdb_ind_regs_ctrl_ser_h16)(aBaseAddr, 16)
        Set rdb_ind_regs_addr_ser_l16 = (New REGISTER_CPU_INDIRECT_REG_rdb_ind_regs_addr_ser_l16)(aBaseAddr, 16)
        Set rdb_ind_regs_addr_ser_h16 = (New REGISTER_CPU_INDIRECT_REG_rdb_ind_regs_addr_ser_h16)(aBaseAddr, 16)
        Set rdb_ind_regs_data_ser_l_l16 = (New REGISTER_CPU_INDIRECT_REG_rdb_ind_regs_data_ser_l_l16)(aBaseAddr, 16)
        Set rdb_ind_regs_data_ser_l_h16 = (New REGISTER_CPU_INDIRECT_REG_rdb_ind_regs_data_ser_l_h16)(aBaseAddr, 16)
        Set rdb_ind_regs_data_ser_h_l16 = (New REGISTER_CPU_INDIRECT_REG_rdb_ind_regs_data_ser_h_l16)(aBaseAddr, 16)
        Set rdb_ind_regs_data_ser_h_h16 = (New REGISTER_CPU_INDIRECT_REG_rdb_ind_regs_data_ser_h_h16)(aBaseAddr, 16)
        Set rdb_ind_regs_ctrl_cpu_l16 = (New REGISTER_CPU_INDIRECT_REG_rdb_ind_regs_ctrl_cpu_l16)(aBaseAddr, 16)
        Set rdb_ind_regs_ctrl_cpu_h16 = (New REGISTER_CPU_INDIRECT_REG_rdb_ind_regs_ctrl_cpu_h16)(aBaseAddr, 16)
        Set rdb_ind_regs_addr_cpu_l16 = (New REGISTER_CPU_INDIRECT_REG_rdb_ind_regs_addr_cpu_l16)(aBaseAddr, 16)
        Set rdb_ind_regs_addr_cpu_h16 = (New REGISTER_CPU_INDIRECT_REG_rdb_ind_regs_addr_cpu_h16)(aBaseAddr, 16)
        Set rdb_ind_regs_data_cpu_l_l16 = (New REGISTER_CPU_INDIRECT_REG_rdb_ind_regs_data_cpu_l_l16)(aBaseAddr, 16)
        Set rdb_ind_regs_data_cpu_l_h16 = (New REGISTER_CPU_INDIRECT_REG_rdb_ind_regs_data_cpu_l_h16)(aBaseAddr, 16)
        Set rdb_ind_regs_data_cpu_h_l16 = (New REGISTER_CPU_INDIRECT_REG_rdb_ind_regs_data_cpu_h_l16)(aBaseAddr, 16)
        Set rdb_ind_regs_data_cpu_h_h16 = (New REGISTER_CPU_INDIRECT_REG_rdb_ind_regs_data_cpu_h_h16)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set CPU_INDIRECT_REG = CreateObject("System.Collections.ArrayList")
CPU_INDIRECT_REG.Add ((New CPU_INDIRECT_REG_INSTANCE)(&H4b280000))


