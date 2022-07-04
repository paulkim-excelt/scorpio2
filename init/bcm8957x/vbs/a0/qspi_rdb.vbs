

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


'' @REGISTER : QSPI_bspi_registers_revision_id
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' bspi_registers_REVISION_ID_MAJOR           [15:8]           get_bspi_registers_REVISION_ID_MAJOR
''                                                             set_bspi_registers_REVISION_ID_MAJOR
''                                                             read_bspi_registers_REVISION_ID_MAJOR
''                                                             write_bspi_registers_REVISION_ID_MAJOR
''---------------------------------------------------------------------------------
'' bspi_registers_REVISION_ID_MINOR           [7:0]            get_bspi_registers_REVISION_ID_MINOR
''                                                             set_bspi_registers_REVISION_ID_MINOR
''                                                             read_bspi_registers_REVISION_ID_MINOR
''                                                             write_bspi_registers_REVISION_ID_MINOR
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_bspi_registers_revision_id
    Private write_bspi_registers_REVISION_ID_MAJOR_value
    Private read_bspi_registers_REVISION_ID_MAJOR_value
    Private flag_bspi_registers_REVISION_ID_MAJOR
    Private write_bspi_registers_REVISION_ID_MINOR_value
    Private read_bspi_registers_REVISION_ID_MINOR_value
    Private flag_bspi_registers_REVISION_ID_MINOR

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

    Property Get get_bspi_registers_REVISION_ID_MAJOR
        get_bspi_registers_REVISION_ID_MAJOR = read_bspi_registers_REVISION_ID_MAJOR_value
    End Property

    Property Let set_bspi_registers_REVISION_ID_MAJOR(aData)
        write_bspi_registers_REVISION_ID_MAJOR_value = aData
        flag_bspi_registers_REVISION_ID_MAJOR        = &H1
    End Property

    Property Get read_bspi_registers_REVISION_ID_MAJOR
        read
        read_bspi_registers_REVISION_ID_MAJOR = read_bspi_registers_REVISION_ID_MAJOR_value
    End Property

    Property Let write_bspi_registers_REVISION_ID_MAJOR(aData)
        set_bspi_registers_REVISION_ID_MAJOR = aData
        write
    End Property

    Property Get get_bspi_registers_REVISION_ID_MINOR
        get_bspi_registers_REVISION_ID_MINOR = read_bspi_registers_REVISION_ID_MINOR_value
    End Property

    Property Let set_bspi_registers_REVISION_ID_MINOR(aData)
        write_bspi_registers_REVISION_ID_MINOR_value = aData
        flag_bspi_registers_REVISION_ID_MINOR        = &H1
    End Property

    Property Get read_bspi_registers_REVISION_ID_MINOR
        read
        read_bspi_registers_REVISION_ID_MINOR = read_bspi_registers_REVISION_ID_MINOR_value
    End Property

    Property Let write_bspi_registers_REVISION_ID_MINOR(aData)
        set_bspi_registers_REVISION_ID_MINOR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_bspi_registers_REVISION_ID_MAJOR_value = rightShift(data_low, 8) and &Hff
        bspi_registers_REVISION_ID_MINOR_mask = &Hff
        if data_low > LONG_MAX then
            if bspi_registers_REVISION_ID_MINOR_mask = mask then
                read_bspi_registers_REVISION_ID_MINOR_value = data_low
            else
                read_bspi_registers_REVISION_ID_MINOR_value = (data_low - H8000_0000) and bspi_registers_REVISION_ID_MINOR_mask
            end If
        else
            read_bspi_registers_REVISION_ID_MINOR_value = data_low and bspi_registers_REVISION_ID_MINOR_mask
        end If

    End Sub

    Sub write
        If flag_bspi_registers_REVISION_ID_MAJOR = &H0 or flag_bspi_registers_REVISION_ID_MINOR = &H0 Then read
        If flag_bspi_registers_REVISION_ID_MAJOR = &H0 Then write_bspi_registers_REVISION_ID_MAJOR_value = get_bspi_registers_REVISION_ID_MAJOR
        If flag_bspi_registers_REVISION_ID_MINOR = &H0 Then write_bspi_registers_REVISION_ID_MINOR_value = get_bspi_registers_REVISION_ID_MINOR

        regValue = leftShift((write_bspi_registers_REVISION_ID_MAJOR_value and &Hff), 8) + leftShift((write_bspi_registers_REVISION_ID_MINOR_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_bspi_registers_REVISION_ID_MAJOR_value = rightShift(data_low, 8) and &Hff
        bspi_registers_REVISION_ID_MINOR_mask = &Hff
        if data_low > LONG_MAX then
            if bspi_registers_REVISION_ID_MINOR_mask = mask then
                read_bspi_registers_REVISION_ID_MINOR_value = data_low
            else
                read_bspi_registers_REVISION_ID_MINOR_value = (data_low - H8000_0000) and bspi_registers_REVISION_ID_MINOR_mask
            end If
        else
            read_bspi_registers_REVISION_ID_MINOR_value = data_low and bspi_registers_REVISION_ID_MINOR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_bspi_registers_REVISION_ID_MAJOR_value = &H0
        flag_bspi_registers_REVISION_ID_MAJOR        = &H0
        write_bspi_registers_REVISION_ID_MINOR_value = &H0
        flag_bspi_registers_REVISION_ID_MINOR        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_bspi_registers_scratch
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' bspi_registers_SCRATCH_SCRATCH             [31:0]           get_bspi_registers_SCRATCH_SCRATCH
''                                                             set_bspi_registers_SCRATCH_SCRATCH
''                                                             read_bspi_registers_SCRATCH_SCRATCH
''                                                             write_bspi_registers_SCRATCH_SCRATCH
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_bspi_registers_scratch
    Private write_bspi_registers_SCRATCH_SCRATCH_value
    Private read_bspi_registers_SCRATCH_SCRATCH_value
    Private flag_bspi_registers_SCRATCH_SCRATCH

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

    Property Get get_bspi_registers_SCRATCH_SCRATCH
        get_bspi_registers_SCRATCH_SCRATCH = read_bspi_registers_SCRATCH_SCRATCH_value
    End Property

    Property Let set_bspi_registers_SCRATCH_SCRATCH(aData)
        write_bspi_registers_SCRATCH_SCRATCH_value = aData
        flag_bspi_registers_SCRATCH_SCRATCH        = &H1
    End Property

    Property Get read_bspi_registers_SCRATCH_SCRATCH
        read
        read_bspi_registers_SCRATCH_SCRATCH = read_bspi_registers_SCRATCH_SCRATCH_value
    End Property

    Property Let write_bspi_registers_SCRATCH_SCRATCH(aData)
        set_bspi_registers_SCRATCH_SCRATCH = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        bspi_registers_SCRATCH_SCRATCH_mask = &Hffffffff
        if data_low > LONG_MAX then
            if bspi_registers_SCRATCH_SCRATCH_mask = mask then
                read_bspi_registers_SCRATCH_SCRATCH_value = data_low
            else
                read_bspi_registers_SCRATCH_SCRATCH_value = (data_low - H8000_0000) and bspi_registers_SCRATCH_SCRATCH_mask
            end If
        else
            read_bspi_registers_SCRATCH_SCRATCH_value = data_low and bspi_registers_SCRATCH_SCRATCH_mask
        end If

    End Sub

    Sub write
        If flag_bspi_registers_SCRATCH_SCRATCH = &H0 Then read
        If flag_bspi_registers_SCRATCH_SCRATCH = &H0 Then write_bspi_registers_SCRATCH_SCRATCH_value = get_bspi_registers_SCRATCH_SCRATCH

        regValue = leftShift(write_bspi_registers_SCRATCH_SCRATCH_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        bspi_registers_SCRATCH_SCRATCH_mask = &Hffffffff
        if data_low > LONG_MAX then
            if bspi_registers_SCRATCH_SCRATCH_mask = mask then
                read_bspi_registers_SCRATCH_SCRATCH_value = data_low
            else
                read_bspi_registers_SCRATCH_SCRATCH_value = (data_low - H8000_0000) and bspi_registers_SCRATCH_SCRATCH_mask
            end If
        else
            read_bspi_registers_SCRATCH_SCRATCH_value = data_low and bspi_registers_SCRATCH_SCRATCH_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_bspi_registers_SCRATCH_SCRATCH_value = &H0
        flag_bspi_registers_SCRATCH_SCRATCH        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_bspi_registers_mast_n_boot_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' bspi_registers_MAST_N_BOOT_CTRL_mast_n_boot   [0:0]            get_bspi_registers_MAST_N_BOOT_CTRL_mast_n_boot
''                                                             set_bspi_registers_MAST_N_BOOT_CTRL_mast_n_boot
''                                                             read_bspi_registers_MAST_N_BOOT_CTRL_mast_n_boot
''                                                             write_bspi_registers_MAST_N_BOOT_CTRL_mast_n_boot
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_bspi_registers_mast_n_boot_ctrl
    Private write_bspi_registers_MAST_N_BOOT_CTRL_mast_n_boot_value
    Private read_bspi_registers_MAST_N_BOOT_CTRL_mast_n_boot_value
    Private flag_bspi_registers_MAST_N_BOOT_CTRL_mast_n_boot

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

    Property Get get_bspi_registers_MAST_N_BOOT_CTRL_mast_n_boot
        get_bspi_registers_MAST_N_BOOT_CTRL_mast_n_boot = read_bspi_registers_MAST_N_BOOT_CTRL_mast_n_boot_value
    End Property

    Property Let set_bspi_registers_MAST_N_BOOT_CTRL_mast_n_boot(aData)
        write_bspi_registers_MAST_N_BOOT_CTRL_mast_n_boot_value = aData
        flag_bspi_registers_MAST_N_BOOT_CTRL_mast_n_boot        = &H1
    End Property

    Property Get read_bspi_registers_MAST_N_BOOT_CTRL_mast_n_boot
        read
        read_bspi_registers_MAST_N_BOOT_CTRL_mast_n_boot = read_bspi_registers_MAST_N_BOOT_CTRL_mast_n_boot_value
    End Property

    Property Let write_bspi_registers_MAST_N_BOOT_CTRL_mast_n_boot(aData)
        set_bspi_registers_MAST_N_BOOT_CTRL_mast_n_boot = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        bspi_registers_MAST_N_BOOT_CTRL_mast_n_boot_mask = &H1
        if data_low > LONG_MAX then
            if bspi_registers_MAST_N_BOOT_CTRL_mast_n_boot_mask = mask then
                read_bspi_registers_MAST_N_BOOT_CTRL_mast_n_boot_value = data_low
            else
                read_bspi_registers_MAST_N_BOOT_CTRL_mast_n_boot_value = (data_low - H8000_0000) and bspi_registers_MAST_N_BOOT_CTRL_mast_n_boot_mask
            end If
        else
            read_bspi_registers_MAST_N_BOOT_CTRL_mast_n_boot_value = data_low and bspi_registers_MAST_N_BOOT_CTRL_mast_n_boot_mask
        end If

    End Sub

    Sub write
        If flag_bspi_registers_MAST_N_BOOT_CTRL_mast_n_boot = &H0 Then read
        If flag_bspi_registers_MAST_N_BOOT_CTRL_mast_n_boot = &H0 Then write_bspi_registers_MAST_N_BOOT_CTRL_mast_n_boot_value = get_bspi_registers_MAST_N_BOOT_CTRL_mast_n_boot

        regValue = leftShift((write_bspi_registers_MAST_N_BOOT_CTRL_mast_n_boot_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        bspi_registers_MAST_N_BOOT_CTRL_mast_n_boot_mask = &H1
        if data_low > LONG_MAX then
            if bspi_registers_MAST_N_BOOT_CTRL_mast_n_boot_mask = mask then
                read_bspi_registers_MAST_N_BOOT_CTRL_mast_n_boot_value = data_low
            else
                read_bspi_registers_MAST_N_BOOT_CTRL_mast_n_boot_value = (data_low - H8000_0000) and bspi_registers_MAST_N_BOOT_CTRL_mast_n_boot_mask
            end If
        else
            read_bspi_registers_MAST_N_BOOT_CTRL_mast_n_boot_value = data_low and bspi_registers_MAST_N_BOOT_CTRL_mast_n_boot_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_bspi_registers_MAST_N_BOOT_CTRL_mast_n_boot_value = &H0
        flag_bspi_registers_MAST_N_BOOT_CTRL_mast_n_boot        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_bspi_registers_busy_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' bspi_registers_BUSY_STATUS_busy            [0:0]            get_bspi_registers_BUSY_STATUS_busy
''                                                             set_bspi_registers_BUSY_STATUS_busy
''                                                             read_bspi_registers_BUSY_STATUS_busy
''                                                             write_bspi_registers_BUSY_STATUS_busy
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_bspi_registers_busy_status
    Private write_bspi_registers_BUSY_STATUS_busy_value
    Private read_bspi_registers_BUSY_STATUS_busy_value
    Private flag_bspi_registers_BUSY_STATUS_busy

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

    Property Get get_bspi_registers_BUSY_STATUS_busy
        get_bspi_registers_BUSY_STATUS_busy = read_bspi_registers_BUSY_STATUS_busy_value
    End Property

    Property Let set_bspi_registers_BUSY_STATUS_busy(aData)
        write_bspi_registers_BUSY_STATUS_busy_value = aData
        flag_bspi_registers_BUSY_STATUS_busy        = &H1
    End Property

    Property Get read_bspi_registers_BUSY_STATUS_busy
        read
        read_bspi_registers_BUSY_STATUS_busy = read_bspi_registers_BUSY_STATUS_busy_value
    End Property

    Property Let write_bspi_registers_BUSY_STATUS_busy(aData)
        set_bspi_registers_BUSY_STATUS_busy = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        bspi_registers_BUSY_STATUS_busy_mask = &H1
        if data_low > LONG_MAX then
            if bspi_registers_BUSY_STATUS_busy_mask = mask then
                read_bspi_registers_BUSY_STATUS_busy_value = data_low
            else
                read_bspi_registers_BUSY_STATUS_busy_value = (data_low - H8000_0000) and bspi_registers_BUSY_STATUS_busy_mask
            end If
        else
            read_bspi_registers_BUSY_STATUS_busy_value = data_low and bspi_registers_BUSY_STATUS_busy_mask
        end If

    End Sub

    Sub write
        If flag_bspi_registers_BUSY_STATUS_busy = &H0 Then read
        If flag_bspi_registers_BUSY_STATUS_busy = &H0 Then write_bspi_registers_BUSY_STATUS_busy_value = get_bspi_registers_BUSY_STATUS_busy

        regValue = leftShift((write_bspi_registers_BUSY_STATUS_busy_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        bspi_registers_BUSY_STATUS_busy_mask = &H1
        if data_low > LONG_MAX then
            if bspi_registers_BUSY_STATUS_busy_mask = mask then
                read_bspi_registers_BUSY_STATUS_busy_value = data_low
            else
                read_bspi_registers_BUSY_STATUS_busy_value = (data_low - H8000_0000) and bspi_registers_BUSY_STATUS_busy_mask
            end If
        else
            read_bspi_registers_BUSY_STATUS_busy_value = data_low and bspi_registers_BUSY_STATUS_busy_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_bspi_registers_BUSY_STATUS_busy_value = &H0
        flag_bspi_registers_BUSY_STATUS_busy        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_bspi_registers_intr_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' bspi_registers_INTR_STATUS_intr_1          [1:1]            get_bspi_registers_INTR_STATUS_intr_1
''                                                             set_bspi_registers_INTR_STATUS_intr_1
''                                                             read_bspi_registers_INTR_STATUS_intr_1
''                                                             write_bspi_registers_INTR_STATUS_intr_1
''---------------------------------------------------------------------------------
'' bspi_registers_INTR_STATUS_intr_0          [0:0]            get_bspi_registers_INTR_STATUS_intr_0
''                                                             set_bspi_registers_INTR_STATUS_intr_0
''                                                             read_bspi_registers_INTR_STATUS_intr_0
''                                                             write_bspi_registers_INTR_STATUS_intr_0
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_bspi_registers_intr_status
    Private write_bspi_registers_INTR_STATUS_intr_1_value
    Private read_bspi_registers_INTR_STATUS_intr_1_value
    Private flag_bspi_registers_INTR_STATUS_intr_1
    Private write_bspi_registers_INTR_STATUS_intr_0_value
    Private read_bspi_registers_INTR_STATUS_intr_0_value
    Private flag_bspi_registers_INTR_STATUS_intr_0

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

    Property Get get_bspi_registers_INTR_STATUS_intr_1
        get_bspi_registers_INTR_STATUS_intr_1 = read_bspi_registers_INTR_STATUS_intr_1_value
    End Property

    Property Let set_bspi_registers_INTR_STATUS_intr_1(aData)
        write_bspi_registers_INTR_STATUS_intr_1_value = aData
        flag_bspi_registers_INTR_STATUS_intr_1        = &H1
    End Property

    Property Get read_bspi_registers_INTR_STATUS_intr_1
        read
        read_bspi_registers_INTR_STATUS_intr_1 = read_bspi_registers_INTR_STATUS_intr_1_value
    End Property

    Property Let write_bspi_registers_INTR_STATUS_intr_1(aData)
        set_bspi_registers_INTR_STATUS_intr_1 = aData
        write
    End Property

    Property Get get_bspi_registers_INTR_STATUS_intr_0
        get_bspi_registers_INTR_STATUS_intr_0 = read_bspi_registers_INTR_STATUS_intr_0_value
    End Property

    Property Let set_bspi_registers_INTR_STATUS_intr_0(aData)
        write_bspi_registers_INTR_STATUS_intr_0_value = aData
        flag_bspi_registers_INTR_STATUS_intr_0        = &H1
    End Property

    Property Get read_bspi_registers_INTR_STATUS_intr_0
        read
        read_bspi_registers_INTR_STATUS_intr_0 = read_bspi_registers_INTR_STATUS_intr_0_value
    End Property

    Property Let write_bspi_registers_INTR_STATUS_intr_0(aData)
        set_bspi_registers_INTR_STATUS_intr_0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_bspi_registers_INTR_STATUS_intr_1_value = rightShift(data_low, 1) and &H1
        bspi_registers_INTR_STATUS_intr_0_mask = &H1
        if data_low > LONG_MAX then
            if bspi_registers_INTR_STATUS_intr_0_mask = mask then
                read_bspi_registers_INTR_STATUS_intr_0_value = data_low
            else
                read_bspi_registers_INTR_STATUS_intr_0_value = (data_low - H8000_0000) and bspi_registers_INTR_STATUS_intr_0_mask
            end If
        else
            read_bspi_registers_INTR_STATUS_intr_0_value = data_low and bspi_registers_INTR_STATUS_intr_0_mask
        end If

    End Sub

    Sub write
        If flag_bspi_registers_INTR_STATUS_intr_1 = &H0 or flag_bspi_registers_INTR_STATUS_intr_0 = &H0 Then read
        If flag_bspi_registers_INTR_STATUS_intr_1 = &H0 Then write_bspi_registers_INTR_STATUS_intr_1_value = get_bspi_registers_INTR_STATUS_intr_1
        If flag_bspi_registers_INTR_STATUS_intr_0 = &H0 Then write_bspi_registers_INTR_STATUS_intr_0_value = get_bspi_registers_INTR_STATUS_intr_0

        regValue = leftShift((write_bspi_registers_INTR_STATUS_intr_1_value and &H1), 1) + leftShift((write_bspi_registers_INTR_STATUS_intr_0_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_bspi_registers_INTR_STATUS_intr_1_value = rightShift(data_low, 1) and &H1
        bspi_registers_INTR_STATUS_intr_0_mask = &H1
        if data_low > LONG_MAX then
            if bspi_registers_INTR_STATUS_intr_0_mask = mask then
                read_bspi_registers_INTR_STATUS_intr_0_value = data_low
            else
                read_bspi_registers_INTR_STATUS_intr_0_value = (data_low - H8000_0000) and bspi_registers_INTR_STATUS_intr_0_mask
            end If
        else
            read_bspi_registers_INTR_STATUS_intr_0_value = data_low and bspi_registers_INTR_STATUS_intr_0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_bspi_registers_INTR_STATUS_intr_1_value = &H0
        flag_bspi_registers_INTR_STATUS_intr_1        = &H0
        write_bspi_registers_INTR_STATUS_intr_0_value = &H0
        flag_bspi_registers_INTR_STATUS_intr_0        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_bspi_registers_b0_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' BRB0SB0PA                                  [30:30]          get_BRB0SB0PA
''                                                             set_BRB0SB0PA
''                                                             read_BRB0SB0PA
''                                                             write_BRB0SB0PA
''---------------------------------------------------------------------------------
'' bspi_registers_B0_STATUS_b0_full           [29:29]          get_bspi_registers_B0_STATUS_b0_full
''                                                             set_bspi_registers_B0_STATUS_b0_full
''                                                             read_bspi_registers_B0_STATUS_b0_full
''                                                             write_bspi_registers_B0_STATUS_b0_full
''---------------------------------------------------------------------------------
'' bspi_registers_B0_STATUS_b0_empty          [28:28]          get_bspi_registers_B0_STATUS_b0_empty
''                                                             set_bspi_registers_B0_STATUS_b0_empty
''                                                             read_bspi_registers_B0_STATUS_b0_empty
''                                                             write_bspi_registers_B0_STATUS_b0_empty
''---------------------------------------------------------------------------------
'' bspi_registers_B0_STATUS_b0_miss           [27:27]          get_bspi_registers_B0_STATUS_b0_miss
''                                                             set_bspi_registers_B0_STATUS_b0_miss
''                                                             read_bspi_registers_B0_STATUS_b0_miss
''                                                             write_bspi_registers_B0_STATUS_b0_miss
''---------------------------------------------------------------------------------
'' bspi_registers_B0_STATUS_b0_hit            [26:26]          get_bspi_registers_B0_STATUS_b0_hit
''                                                             set_bspi_registers_B0_STATUS_b0_hit
''                                                             read_bspi_registers_B0_STATUS_b0_hit
''                                                             write_bspi_registers_B0_STATUS_b0_hit
''---------------------------------------------------------------------------------
'' bspi_registers_B0_STATUS_b0_address        [25:0]           get_bspi_registers_B0_STATUS_b0_address
''                                                             set_bspi_registers_B0_STATUS_b0_address
''                                                             read_bspi_registers_B0_STATUS_b0_address
''                                                             write_bspi_registers_B0_STATUS_b0_address
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_bspi_registers_b0_status
    Private write_BRB0SB0PA_value
    Private read_BRB0SB0PA_value
    Private flag_BRB0SB0PA
    Private write_bspi_registers_B0_STATUS_b0_full_value
    Private read_bspi_registers_B0_STATUS_b0_full_value
    Private flag_bspi_registers_B0_STATUS_b0_full
    Private write_bspi_registers_B0_STATUS_b0_empty_value
    Private read_bspi_registers_B0_STATUS_b0_empty_value
    Private flag_bspi_registers_B0_STATUS_b0_empty
    Private write_bspi_registers_B0_STATUS_b0_miss_value
    Private read_bspi_registers_B0_STATUS_b0_miss_value
    Private flag_bspi_registers_B0_STATUS_b0_miss
    Private write_bspi_registers_B0_STATUS_b0_hit_value
    Private read_bspi_registers_B0_STATUS_b0_hit_value
    Private flag_bspi_registers_B0_STATUS_b0_hit
    Private write_bspi_registers_B0_STATUS_b0_address_value
    Private read_bspi_registers_B0_STATUS_b0_address_value
    Private flag_bspi_registers_B0_STATUS_b0_address

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

    Property Get get_BRB0SB0PA
        get_BRB0SB0PA = read_BRB0SB0PA_value
    End Property

    Property Let set_BRB0SB0PA(aData)
        write_BRB0SB0PA_value = aData
        flag_BRB0SB0PA        = &H1
    End Property

    Property Get read_BRB0SB0PA
        read
        read_BRB0SB0PA = read_BRB0SB0PA_value
    End Property

    Property Let write_BRB0SB0PA(aData)
        set_BRB0SB0PA = aData
        write
    End Property

    Property Get get_bspi_registers_B0_STATUS_b0_full
        get_bspi_registers_B0_STATUS_b0_full = read_bspi_registers_B0_STATUS_b0_full_value
    End Property

    Property Let set_bspi_registers_B0_STATUS_b0_full(aData)
        write_bspi_registers_B0_STATUS_b0_full_value = aData
        flag_bspi_registers_B0_STATUS_b0_full        = &H1
    End Property

    Property Get read_bspi_registers_B0_STATUS_b0_full
        read
        read_bspi_registers_B0_STATUS_b0_full = read_bspi_registers_B0_STATUS_b0_full_value
    End Property

    Property Let write_bspi_registers_B0_STATUS_b0_full(aData)
        set_bspi_registers_B0_STATUS_b0_full = aData
        write
    End Property

    Property Get get_bspi_registers_B0_STATUS_b0_empty
        get_bspi_registers_B0_STATUS_b0_empty = read_bspi_registers_B0_STATUS_b0_empty_value
    End Property

    Property Let set_bspi_registers_B0_STATUS_b0_empty(aData)
        write_bspi_registers_B0_STATUS_b0_empty_value = aData
        flag_bspi_registers_B0_STATUS_b0_empty        = &H1
    End Property

    Property Get read_bspi_registers_B0_STATUS_b0_empty
        read
        read_bspi_registers_B0_STATUS_b0_empty = read_bspi_registers_B0_STATUS_b0_empty_value
    End Property

    Property Let write_bspi_registers_B0_STATUS_b0_empty(aData)
        set_bspi_registers_B0_STATUS_b0_empty = aData
        write
    End Property

    Property Get get_bspi_registers_B0_STATUS_b0_miss
        get_bspi_registers_B0_STATUS_b0_miss = read_bspi_registers_B0_STATUS_b0_miss_value
    End Property

    Property Let set_bspi_registers_B0_STATUS_b0_miss(aData)
        write_bspi_registers_B0_STATUS_b0_miss_value = aData
        flag_bspi_registers_B0_STATUS_b0_miss        = &H1
    End Property

    Property Get read_bspi_registers_B0_STATUS_b0_miss
        read
        read_bspi_registers_B0_STATUS_b0_miss = read_bspi_registers_B0_STATUS_b0_miss_value
    End Property

    Property Let write_bspi_registers_B0_STATUS_b0_miss(aData)
        set_bspi_registers_B0_STATUS_b0_miss = aData
        write
    End Property

    Property Get get_bspi_registers_B0_STATUS_b0_hit
        get_bspi_registers_B0_STATUS_b0_hit = read_bspi_registers_B0_STATUS_b0_hit_value
    End Property

    Property Let set_bspi_registers_B0_STATUS_b0_hit(aData)
        write_bspi_registers_B0_STATUS_b0_hit_value = aData
        flag_bspi_registers_B0_STATUS_b0_hit        = &H1
    End Property

    Property Get read_bspi_registers_B0_STATUS_b0_hit
        read
        read_bspi_registers_B0_STATUS_b0_hit = read_bspi_registers_B0_STATUS_b0_hit_value
    End Property

    Property Let write_bspi_registers_B0_STATUS_b0_hit(aData)
        set_bspi_registers_B0_STATUS_b0_hit = aData
        write
    End Property

    Property Get get_bspi_registers_B0_STATUS_b0_address
        get_bspi_registers_B0_STATUS_b0_address = read_bspi_registers_B0_STATUS_b0_address_value
    End Property

    Property Let set_bspi_registers_B0_STATUS_b0_address(aData)
        write_bspi_registers_B0_STATUS_b0_address_value = aData
        flag_bspi_registers_B0_STATUS_b0_address        = &H1
    End Property

    Property Get read_bspi_registers_B0_STATUS_b0_address
        read
        read_bspi_registers_B0_STATUS_b0_address = read_bspi_registers_B0_STATUS_b0_address_value
    End Property

    Property Let write_bspi_registers_B0_STATUS_b0_address(aData)
        set_bspi_registers_B0_STATUS_b0_address = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_BRB0SB0PA_value = rightShift(data_low, 30) and &H1
        read_bspi_registers_B0_STATUS_b0_full_value = rightShift(data_low, 29) and &H1
        read_bspi_registers_B0_STATUS_b0_empty_value = rightShift(data_low, 28) and &H1
        read_bspi_registers_B0_STATUS_b0_miss_value = rightShift(data_low, 27) and &H1
        read_bspi_registers_B0_STATUS_b0_hit_value = rightShift(data_low, 26) and &H1
        bspi_registers_B0_STATUS_b0_address_mask = &H3ffffff
        if data_low > LONG_MAX then
            if bspi_registers_B0_STATUS_b0_address_mask = mask then
                read_bspi_registers_B0_STATUS_b0_address_value = data_low
            else
                read_bspi_registers_B0_STATUS_b0_address_value = (data_low - H8000_0000) and bspi_registers_B0_STATUS_b0_address_mask
            end If
        else
            read_bspi_registers_B0_STATUS_b0_address_value = data_low and bspi_registers_B0_STATUS_b0_address_mask
        end If

    End Sub

    Sub write
        If flag_BRB0SB0PA = &H0 or flag_bspi_registers_B0_STATUS_b0_full = &H0 or flag_bspi_registers_B0_STATUS_b0_empty = &H0 or flag_bspi_registers_B0_STATUS_b0_miss = &H0 or flag_bspi_registers_B0_STATUS_b0_hit = &H0 or flag_bspi_registers_B0_STATUS_b0_address = &H0 Then read
        If flag_BRB0SB0PA = &H0 Then write_BRB0SB0PA_value = get_BRB0SB0PA
        If flag_bspi_registers_B0_STATUS_b0_full = &H0 Then write_bspi_registers_B0_STATUS_b0_full_value = get_bspi_registers_B0_STATUS_b0_full
        If flag_bspi_registers_B0_STATUS_b0_empty = &H0 Then write_bspi_registers_B0_STATUS_b0_empty_value = get_bspi_registers_B0_STATUS_b0_empty
        If flag_bspi_registers_B0_STATUS_b0_miss = &H0 Then write_bspi_registers_B0_STATUS_b0_miss_value = get_bspi_registers_B0_STATUS_b0_miss
        If flag_bspi_registers_B0_STATUS_b0_hit = &H0 Then write_bspi_registers_B0_STATUS_b0_hit_value = get_bspi_registers_B0_STATUS_b0_hit
        If flag_bspi_registers_B0_STATUS_b0_address = &H0 Then write_bspi_registers_B0_STATUS_b0_address_value = get_bspi_registers_B0_STATUS_b0_address

        regValue = leftShift((write_BRB0SB0PA_value and &H1), 30) + leftShift((write_bspi_registers_B0_STATUS_b0_full_value and &H1), 29) + leftShift((write_bspi_registers_B0_STATUS_b0_empty_value and &H1), 28) + leftShift((write_bspi_registers_B0_STATUS_b0_miss_value and &H1), 27) + leftShift((write_bspi_registers_B0_STATUS_b0_hit_value and &H1), 26) + leftShift((write_bspi_registers_B0_STATUS_b0_address_value and &H3ffffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_BRB0SB0PA_value = rightShift(data_low, 30) and &H1
        read_bspi_registers_B0_STATUS_b0_full_value = rightShift(data_low, 29) and &H1
        read_bspi_registers_B0_STATUS_b0_empty_value = rightShift(data_low, 28) and &H1
        read_bspi_registers_B0_STATUS_b0_miss_value = rightShift(data_low, 27) and &H1
        read_bspi_registers_B0_STATUS_b0_hit_value = rightShift(data_low, 26) and &H1
        bspi_registers_B0_STATUS_b0_address_mask = &H3ffffff
        if data_low > LONG_MAX then
            if bspi_registers_B0_STATUS_b0_address_mask = mask then
                read_bspi_registers_B0_STATUS_b0_address_value = data_low
            else
                read_bspi_registers_B0_STATUS_b0_address_value = (data_low - H8000_0000) and bspi_registers_B0_STATUS_b0_address_mask
            end If
        else
            read_bspi_registers_B0_STATUS_b0_address_value = data_low and bspi_registers_B0_STATUS_b0_address_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_BRB0SB0PA_value = &H0
        flag_BRB0SB0PA        = &H0
        write_bspi_registers_B0_STATUS_b0_full_value = &H0
        flag_bspi_registers_B0_STATUS_b0_full        = &H0
        write_bspi_registers_B0_STATUS_b0_empty_value = &H0
        flag_bspi_registers_B0_STATUS_b0_empty        = &H0
        write_bspi_registers_B0_STATUS_b0_miss_value = &H0
        flag_bspi_registers_B0_STATUS_b0_miss        = &H0
        write_bspi_registers_B0_STATUS_b0_hit_value = &H0
        flag_bspi_registers_B0_STATUS_b0_hit        = &H0
        write_bspi_registers_B0_STATUS_b0_address_value = &H0
        flag_bspi_registers_B0_STATUS_b0_address        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_bspi_registers_b0_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' bspi_registers_B0_CTRL_b0_flush            [0:0]            get_bspi_registers_B0_CTRL_b0_flush
''                                                             set_bspi_registers_B0_CTRL_b0_flush
''                                                             read_bspi_registers_B0_CTRL_b0_flush
''                                                             write_bspi_registers_B0_CTRL_b0_flush
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_bspi_registers_b0_ctrl
    Private write_bspi_registers_B0_CTRL_b0_flush_value
    Private read_bspi_registers_B0_CTRL_b0_flush_value
    Private flag_bspi_registers_B0_CTRL_b0_flush

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

    Property Get get_bspi_registers_B0_CTRL_b0_flush
        get_bspi_registers_B0_CTRL_b0_flush = read_bspi_registers_B0_CTRL_b0_flush_value
    End Property

    Property Let set_bspi_registers_B0_CTRL_b0_flush(aData)
        write_bspi_registers_B0_CTRL_b0_flush_value = aData
        flag_bspi_registers_B0_CTRL_b0_flush        = &H1
    End Property

    Property Get read_bspi_registers_B0_CTRL_b0_flush
        read
        read_bspi_registers_B0_CTRL_b0_flush = read_bspi_registers_B0_CTRL_b0_flush_value
    End Property

    Property Let write_bspi_registers_B0_CTRL_b0_flush(aData)
        set_bspi_registers_B0_CTRL_b0_flush = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        bspi_registers_B0_CTRL_b0_flush_mask = &H1
        if data_low > LONG_MAX then
            if bspi_registers_B0_CTRL_b0_flush_mask = mask then
                read_bspi_registers_B0_CTRL_b0_flush_value = data_low
            else
                read_bspi_registers_B0_CTRL_b0_flush_value = (data_low - H8000_0000) and bspi_registers_B0_CTRL_b0_flush_mask
            end If
        else
            read_bspi_registers_B0_CTRL_b0_flush_value = data_low and bspi_registers_B0_CTRL_b0_flush_mask
        end If

    End Sub

    Sub write
        If flag_bspi_registers_B0_CTRL_b0_flush = &H0 Then read
        If flag_bspi_registers_B0_CTRL_b0_flush = &H0 Then write_bspi_registers_B0_CTRL_b0_flush_value = get_bspi_registers_B0_CTRL_b0_flush

        regValue = leftShift((write_bspi_registers_B0_CTRL_b0_flush_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        bspi_registers_B0_CTRL_b0_flush_mask = &H1
        if data_low > LONG_MAX then
            if bspi_registers_B0_CTRL_b0_flush_mask = mask then
                read_bspi_registers_B0_CTRL_b0_flush_value = data_low
            else
                read_bspi_registers_B0_CTRL_b0_flush_value = (data_low - H8000_0000) and bspi_registers_B0_CTRL_b0_flush_mask
            end If
        else
            read_bspi_registers_B0_CTRL_b0_flush_value = data_low and bspi_registers_B0_CTRL_b0_flush_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_bspi_registers_B0_CTRL_b0_flush_value = &H0
        flag_bspi_registers_B0_CTRL_b0_flush        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_bspi_registers_b1_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' BRB1SB1PA                                  [30:30]          get_BRB1SB1PA
''                                                             set_BRB1SB1PA
''                                                             read_BRB1SB1PA
''                                                             write_BRB1SB1PA
''---------------------------------------------------------------------------------
'' bspi_registers_B1_STATUS_b1_full           [29:29]          get_bspi_registers_B1_STATUS_b1_full
''                                                             set_bspi_registers_B1_STATUS_b1_full
''                                                             read_bspi_registers_B1_STATUS_b1_full
''                                                             write_bspi_registers_B1_STATUS_b1_full
''---------------------------------------------------------------------------------
'' bspi_registers_B1_STATUS_b1_empty          [28:28]          get_bspi_registers_B1_STATUS_b1_empty
''                                                             set_bspi_registers_B1_STATUS_b1_empty
''                                                             read_bspi_registers_B1_STATUS_b1_empty
''                                                             write_bspi_registers_B1_STATUS_b1_empty
''---------------------------------------------------------------------------------
'' bspi_registers_B1_STATUS_b1_miss           [27:27]          get_bspi_registers_B1_STATUS_b1_miss
''                                                             set_bspi_registers_B1_STATUS_b1_miss
''                                                             read_bspi_registers_B1_STATUS_b1_miss
''                                                             write_bspi_registers_B1_STATUS_b1_miss
''---------------------------------------------------------------------------------
'' bspi_registers_B1_STATUS_b1_hit            [26:26]          get_bspi_registers_B1_STATUS_b1_hit
''                                                             set_bspi_registers_B1_STATUS_b1_hit
''                                                             read_bspi_registers_B1_STATUS_b1_hit
''                                                             write_bspi_registers_B1_STATUS_b1_hit
''---------------------------------------------------------------------------------
'' bspi_registers_B1_STATUS_b1_address        [25:0]           get_bspi_registers_B1_STATUS_b1_address
''                                                             set_bspi_registers_B1_STATUS_b1_address
''                                                             read_bspi_registers_B1_STATUS_b1_address
''                                                             write_bspi_registers_B1_STATUS_b1_address
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_bspi_registers_b1_status
    Private write_BRB1SB1PA_value
    Private read_BRB1SB1PA_value
    Private flag_BRB1SB1PA
    Private write_bspi_registers_B1_STATUS_b1_full_value
    Private read_bspi_registers_B1_STATUS_b1_full_value
    Private flag_bspi_registers_B1_STATUS_b1_full
    Private write_bspi_registers_B1_STATUS_b1_empty_value
    Private read_bspi_registers_B1_STATUS_b1_empty_value
    Private flag_bspi_registers_B1_STATUS_b1_empty
    Private write_bspi_registers_B1_STATUS_b1_miss_value
    Private read_bspi_registers_B1_STATUS_b1_miss_value
    Private flag_bspi_registers_B1_STATUS_b1_miss
    Private write_bspi_registers_B1_STATUS_b1_hit_value
    Private read_bspi_registers_B1_STATUS_b1_hit_value
    Private flag_bspi_registers_B1_STATUS_b1_hit
    Private write_bspi_registers_B1_STATUS_b1_address_value
    Private read_bspi_registers_B1_STATUS_b1_address_value
    Private flag_bspi_registers_B1_STATUS_b1_address

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

    Property Get get_BRB1SB1PA
        get_BRB1SB1PA = read_BRB1SB1PA_value
    End Property

    Property Let set_BRB1SB1PA(aData)
        write_BRB1SB1PA_value = aData
        flag_BRB1SB1PA        = &H1
    End Property

    Property Get read_BRB1SB1PA
        read
        read_BRB1SB1PA = read_BRB1SB1PA_value
    End Property

    Property Let write_BRB1SB1PA(aData)
        set_BRB1SB1PA = aData
        write
    End Property

    Property Get get_bspi_registers_B1_STATUS_b1_full
        get_bspi_registers_B1_STATUS_b1_full = read_bspi_registers_B1_STATUS_b1_full_value
    End Property

    Property Let set_bspi_registers_B1_STATUS_b1_full(aData)
        write_bspi_registers_B1_STATUS_b1_full_value = aData
        flag_bspi_registers_B1_STATUS_b1_full        = &H1
    End Property

    Property Get read_bspi_registers_B1_STATUS_b1_full
        read
        read_bspi_registers_B1_STATUS_b1_full = read_bspi_registers_B1_STATUS_b1_full_value
    End Property

    Property Let write_bspi_registers_B1_STATUS_b1_full(aData)
        set_bspi_registers_B1_STATUS_b1_full = aData
        write
    End Property

    Property Get get_bspi_registers_B1_STATUS_b1_empty
        get_bspi_registers_B1_STATUS_b1_empty = read_bspi_registers_B1_STATUS_b1_empty_value
    End Property

    Property Let set_bspi_registers_B1_STATUS_b1_empty(aData)
        write_bspi_registers_B1_STATUS_b1_empty_value = aData
        flag_bspi_registers_B1_STATUS_b1_empty        = &H1
    End Property

    Property Get read_bspi_registers_B1_STATUS_b1_empty
        read
        read_bspi_registers_B1_STATUS_b1_empty = read_bspi_registers_B1_STATUS_b1_empty_value
    End Property

    Property Let write_bspi_registers_B1_STATUS_b1_empty(aData)
        set_bspi_registers_B1_STATUS_b1_empty = aData
        write
    End Property

    Property Get get_bspi_registers_B1_STATUS_b1_miss
        get_bspi_registers_B1_STATUS_b1_miss = read_bspi_registers_B1_STATUS_b1_miss_value
    End Property

    Property Let set_bspi_registers_B1_STATUS_b1_miss(aData)
        write_bspi_registers_B1_STATUS_b1_miss_value = aData
        flag_bspi_registers_B1_STATUS_b1_miss        = &H1
    End Property

    Property Get read_bspi_registers_B1_STATUS_b1_miss
        read
        read_bspi_registers_B1_STATUS_b1_miss = read_bspi_registers_B1_STATUS_b1_miss_value
    End Property

    Property Let write_bspi_registers_B1_STATUS_b1_miss(aData)
        set_bspi_registers_B1_STATUS_b1_miss = aData
        write
    End Property

    Property Get get_bspi_registers_B1_STATUS_b1_hit
        get_bspi_registers_B1_STATUS_b1_hit = read_bspi_registers_B1_STATUS_b1_hit_value
    End Property

    Property Let set_bspi_registers_B1_STATUS_b1_hit(aData)
        write_bspi_registers_B1_STATUS_b1_hit_value = aData
        flag_bspi_registers_B1_STATUS_b1_hit        = &H1
    End Property

    Property Get read_bspi_registers_B1_STATUS_b1_hit
        read
        read_bspi_registers_B1_STATUS_b1_hit = read_bspi_registers_B1_STATUS_b1_hit_value
    End Property

    Property Let write_bspi_registers_B1_STATUS_b1_hit(aData)
        set_bspi_registers_B1_STATUS_b1_hit = aData
        write
    End Property

    Property Get get_bspi_registers_B1_STATUS_b1_address
        get_bspi_registers_B1_STATUS_b1_address = read_bspi_registers_B1_STATUS_b1_address_value
    End Property

    Property Let set_bspi_registers_B1_STATUS_b1_address(aData)
        write_bspi_registers_B1_STATUS_b1_address_value = aData
        flag_bspi_registers_B1_STATUS_b1_address        = &H1
    End Property

    Property Get read_bspi_registers_B1_STATUS_b1_address
        read
        read_bspi_registers_B1_STATUS_b1_address = read_bspi_registers_B1_STATUS_b1_address_value
    End Property

    Property Let write_bspi_registers_B1_STATUS_b1_address(aData)
        set_bspi_registers_B1_STATUS_b1_address = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_BRB1SB1PA_value = rightShift(data_low, 30) and &H1
        read_bspi_registers_B1_STATUS_b1_full_value = rightShift(data_low, 29) and &H1
        read_bspi_registers_B1_STATUS_b1_empty_value = rightShift(data_low, 28) and &H1
        read_bspi_registers_B1_STATUS_b1_miss_value = rightShift(data_low, 27) and &H1
        read_bspi_registers_B1_STATUS_b1_hit_value = rightShift(data_low, 26) and &H1
        bspi_registers_B1_STATUS_b1_address_mask = &H3ffffff
        if data_low > LONG_MAX then
            if bspi_registers_B1_STATUS_b1_address_mask = mask then
                read_bspi_registers_B1_STATUS_b1_address_value = data_low
            else
                read_bspi_registers_B1_STATUS_b1_address_value = (data_low - H8000_0000) and bspi_registers_B1_STATUS_b1_address_mask
            end If
        else
            read_bspi_registers_B1_STATUS_b1_address_value = data_low and bspi_registers_B1_STATUS_b1_address_mask
        end If

    End Sub

    Sub write
        If flag_BRB1SB1PA = &H0 or flag_bspi_registers_B1_STATUS_b1_full = &H0 or flag_bspi_registers_B1_STATUS_b1_empty = &H0 or flag_bspi_registers_B1_STATUS_b1_miss = &H0 or flag_bspi_registers_B1_STATUS_b1_hit = &H0 or flag_bspi_registers_B1_STATUS_b1_address = &H0 Then read
        If flag_BRB1SB1PA = &H0 Then write_BRB1SB1PA_value = get_BRB1SB1PA
        If flag_bspi_registers_B1_STATUS_b1_full = &H0 Then write_bspi_registers_B1_STATUS_b1_full_value = get_bspi_registers_B1_STATUS_b1_full
        If flag_bspi_registers_B1_STATUS_b1_empty = &H0 Then write_bspi_registers_B1_STATUS_b1_empty_value = get_bspi_registers_B1_STATUS_b1_empty
        If flag_bspi_registers_B1_STATUS_b1_miss = &H0 Then write_bspi_registers_B1_STATUS_b1_miss_value = get_bspi_registers_B1_STATUS_b1_miss
        If flag_bspi_registers_B1_STATUS_b1_hit = &H0 Then write_bspi_registers_B1_STATUS_b1_hit_value = get_bspi_registers_B1_STATUS_b1_hit
        If flag_bspi_registers_B1_STATUS_b1_address = &H0 Then write_bspi_registers_B1_STATUS_b1_address_value = get_bspi_registers_B1_STATUS_b1_address

        regValue = leftShift((write_BRB1SB1PA_value and &H1), 30) + leftShift((write_bspi_registers_B1_STATUS_b1_full_value and &H1), 29) + leftShift((write_bspi_registers_B1_STATUS_b1_empty_value and &H1), 28) + leftShift((write_bspi_registers_B1_STATUS_b1_miss_value and &H1), 27) + leftShift((write_bspi_registers_B1_STATUS_b1_hit_value and &H1), 26) + leftShift((write_bspi_registers_B1_STATUS_b1_address_value and &H3ffffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_BRB1SB1PA_value = rightShift(data_low, 30) and &H1
        read_bspi_registers_B1_STATUS_b1_full_value = rightShift(data_low, 29) and &H1
        read_bspi_registers_B1_STATUS_b1_empty_value = rightShift(data_low, 28) and &H1
        read_bspi_registers_B1_STATUS_b1_miss_value = rightShift(data_low, 27) and &H1
        read_bspi_registers_B1_STATUS_b1_hit_value = rightShift(data_low, 26) and &H1
        bspi_registers_B1_STATUS_b1_address_mask = &H3ffffff
        if data_low > LONG_MAX then
            if bspi_registers_B1_STATUS_b1_address_mask = mask then
                read_bspi_registers_B1_STATUS_b1_address_value = data_low
            else
                read_bspi_registers_B1_STATUS_b1_address_value = (data_low - H8000_0000) and bspi_registers_B1_STATUS_b1_address_mask
            end If
        else
            read_bspi_registers_B1_STATUS_b1_address_value = data_low and bspi_registers_B1_STATUS_b1_address_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_BRB1SB1PA_value = &H0
        flag_BRB1SB1PA        = &H0
        write_bspi_registers_B1_STATUS_b1_full_value = &H0
        flag_bspi_registers_B1_STATUS_b1_full        = &H0
        write_bspi_registers_B1_STATUS_b1_empty_value = &H0
        flag_bspi_registers_B1_STATUS_b1_empty        = &H0
        write_bspi_registers_B1_STATUS_b1_miss_value = &H0
        flag_bspi_registers_B1_STATUS_b1_miss        = &H0
        write_bspi_registers_B1_STATUS_b1_hit_value = &H0
        flag_bspi_registers_B1_STATUS_b1_hit        = &H0
        write_bspi_registers_B1_STATUS_b1_address_value = &H0
        flag_bspi_registers_B1_STATUS_b1_address        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_bspi_registers_b1_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' bspi_registers_B1_CTRL_b1_flush            [0:0]            get_bspi_registers_B1_CTRL_b1_flush
''                                                             set_bspi_registers_B1_CTRL_b1_flush
''                                                             read_bspi_registers_B1_CTRL_b1_flush
''                                                             write_bspi_registers_B1_CTRL_b1_flush
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_bspi_registers_b1_ctrl
    Private write_bspi_registers_B1_CTRL_b1_flush_value
    Private read_bspi_registers_B1_CTRL_b1_flush_value
    Private flag_bspi_registers_B1_CTRL_b1_flush

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

    Property Get get_bspi_registers_B1_CTRL_b1_flush
        get_bspi_registers_B1_CTRL_b1_flush = read_bspi_registers_B1_CTRL_b1_flush_value
    End Property

    Property Let set_bspi_registers_B1_CTRL_b1_flush(aData)
        write_bspi_registers_B1_CTRL_b1_flush_value = aData
        flag_bspi_registers_B1_CTRL_b1_flush        = &H1
    End Property

    Property Get read_bspi_registers_B1_CTRL_b1_flush
        read
        read_bspi_registers_B1_CTRL_b1_flush = read_bspi_registers_B1_CTRL_b1_flush_value
    End Property

    Property Let write_bspi_registers_B1_CTRL_b1_flush(aData)
        set_bspi_registers_B1_CTRL_b1_flush = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        bspi_registers_B1_CTRL_b1_flush_mask = &H1
        if data_low > LONG_MAX then
            if bspi_registers_B1_CTRL_b1_flush_mask = mask then
                read_bspi_registers_B1_CTRL_b1_flush_value = data_low
            else
                read_bspi_registers_B1_CTRL_b1_flush_value = (data_low - H8000_0000) and bspi_registers_B1_CTRL_b1_flush_mask
            end If
        else
            read_bspi_registers_B1_CTRL_b1_flush_value = data_low and bspi_registers_B1_CTRL_b1_flush_mask
        end If

    End Sub

    Sub write
        If flag_bspi_registers_B1_CTRL_b1_flush = &H0 Then read
        If flag_bspi_registers_B1_CTRL_b1_flush = &H0 Then write_bspi_registers_B1_CTRL_b1_flush_value = get_bspi_registers_B1_CTRL_b1_flush

        regValue = leftShift((write_bspi_registers_B1_CTRL_b1_flush_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        bspi_registers_B1_CTRL_b1_flush_mask = &H1
        if data_low > LONG_MAX then
            if bspi_registers_B1_CTRL_b1_flush_mask = mask then
                read_bspi_registers_B1_CTRL_b1_flush_value = data_low
            else
                read_bspi_registers_B1_CTRL_b1_flush_value = (data_low - H8000_0000) and bspi_registers_B1_CTRL_b1_flush_mask
            end If
        else
            read_bspi_registers_B1_CTRL_b1_flush_value = data_low and bspi_registers_B1_CTRL_b1_flush_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_bspi_registers_B1_CTRL_b1_flush_value = &H0
        flag_bspi_registers_B1_CTRL_b1_flush        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_bspi_registers_strap_override_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' bspi_registers_STRAP_OVERRIDE_CTRL_endian_mode   [4:4]            get_bspi_registers_STRAP_OVERRIDE_CTRL_endian_mode
''                                                             set_bspi_registers_STRAP_OVERRIDE_CTRL_endian_mode
''                                                             read_bspi_registers_STRAP_OVERRIDE_CTRL_endian_mode
''                                                             write_bspi_registers_STRAP_OVERRIDE_CTRL_endian_mode
''---------------------------------------------------------------------------------
'' bspi_registers_STRAP_OVERRIDE_CTRL_data_quad   [3:3]            get_bspi_registers_STRAP_OVERRIDE_CTRL_data_quad
''                                                             set_bspi_registers_STRAP_OVERRIDE_CTRL_data_quad
''                                                             read_bspi_registers_STRAP_OVERRIDE_CTRL_data_quad
''                                                             write_bspi_registers_STRAP_OVERRIDE_CTRL_data_quad
''---------------------------------------------------------------------------------
'' BRSOCA4N31                                 [2:2]            get_BRSOCA4N31
''                                                             set_BRSOCA4N31
''                                                             read_BRSOCA4N31
''                                                             write_BRSOCA4N31
''---------------------------------------------------------------------------------
'' BRSOCDDNS1                                 [1:1]            get_BRSOCDDNS1
''                                                             set_BRSOCDDNS1
''                                                             read_BRSOCDDNS1
''                                                             write_BRSOCDDNS1
''---------------------------------------------------------------------------------
'' bspi_registers_STRAP_OVERRIDE_CTRL_override   [0:0]            get_bspi_registers_STRAP_OVERRIDE_CTRL_override
''                                                             set_bspi_registers_STRAP_OVERRIDE_CTRL_override
''                                                             read_bspi_registers_STRAP_OVERRIDE_CTRL_override
''                                                             write_bspi_registers_STRAP_OVERRIDE_CTRL_override
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_bspi_registers_strap_override_ctrl
    Private write_bspi_registers_STRAP_OVERRIDE_CTRL_endian_mode_value
    Private read_bspi_registers_STRAP_OVERRIDE_CTRL_endian_mode_value
    Private flag_bspi_registers_STRAP_OVERRIDE_CTRL_endian_mode
    Private write_bspi_registers_STRAP_OVERRIDE_CTRL_data_quad_value
    Private read_bspi_registers_STRAP_OVERRIDE_CTRL_data_quad_value
    Private flag_bspi_registers_STRAP_OVERRIDE_CTRL_data_quad
    Private write_BRSOCA4N31_value
    Private read_BRSOCA4N31_value
    Private flag_BRSOCA4N31
    Private write_BRSOCDDNS1_value
    Private read_BRSOCDDNS1_value
    Private flag_BRSOCDDNS1
    Private write_bspi_registers_STRAP_OVERRIDE_CTRL_override_value
    Private read_bspi_registers_STRAP_OVERRIDE_CTRL_override_value
    Private flag_bspi_registers_STRAP_OVERRIDE_CTRL_override

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

    Property Get get_bspi_registers_STRAP_OVERRIDE_CTRL_endian_mode
        get_bspi_registers_STRAP_OVERRIDE_CTRL_endian_mode = read_bspi_registers_STRAP_OVERRIDE_CTRL_endian_mode_value
    End Property

    Property Let set_bspi_registers_STRAP_OVERRIDE_CTRL_endian_mode(aData)
        write_bspi_registers_STRAP_OVERRIDE_CTRL_endian_mode_value = aData
        flag_bspi_registers_STRAP_OVERRIDE_CTRL_endian_mode        = &H1
    End Property

    Property Get read_bspi_registers_STRAP_OVERRIDE_CTRL_endian_mode
        read
        read_bspi_registers_STRAP_OVERRIDE_CTRL_endian_mode = read_bspi_registers_STRAP_OVERRIDE_CTRL_endian_mode_value
    End Property

    Property Let write_bspi_registers_STRAP_OVERRIDE_CTRL_endian_mode(aData)
        set_bspi_registers_STRAP_OVERRIDE_CTRL_endian_mode = aData
        write
    End Property

    Property Get get_bspi_registers_STRAP_OVERRIDE_CTRL_data_quad
        get_bspi_registers_STRAP_OVERRIDE_CTRL_data_quad = read_bspi_registers_STRAP_OVERRIDE_CTRL_data_quad_value
    End Property

    Property Let set_bspi_registers_STRAP_OVERRIDE_CTRL_data_quad(aData)
        write_bspi_registers_STRAP_OVERRIDE_CTRL_data_quad_value = aData
        flag_bspi_registers_STRAP_OVERRIDE_CTRL_data_quad        = &H1
    End Property

    Property Get read_bspi_registers_STRAP_OVERRIDE_CTRL_data_quad
        read
        read_bspi_registers_STRAP_OVERRIDE_CTRL_data_quad = read_bspi_registers_STRAP_OVERRIDE_CTRL_data_quad_value
    End Property

    Property Let write_bspi_registers_STRAP_OVERRIDE_CTRL_data_quad(aData)
        set_bspi_registers_STRAP_OVERRIDE_CTRL_data_quad = aData
        write
    End Property

    Property Get get_BRSOCA4N31
        get_BRSOCA4N31 = read_BRSOCA4N31_value
    End Property

    Property Let set_BRSOCA4N31(aData)
        write_BRSOCA4N31_value = aData
        flag_BRSOCA4N31        = &H1
    End Property

    Property Get read_BRSOCA4N31
        read
        read_BRSOCA4N31 = read_BRSOCA4N31_value
    End Property

    Property Let write_BRSOCA4N31(aData)
        set_BRSOCA4N31 = aData
        write
    End Property

    Property Get get_BRSOCDDNS1
        get_BRSOCDDNS1 = read_BRSOCDDNS1_value
    End Property

    Property Let set_BRSOCDDNS1(aData)
        write_BRSOCDDNS1_value = aData
        flag_BRSOCDDNS1        = &H1
    End Property

    Property Get read_BRSOCDDNS1
        read
        read_BRSOCDDNS1 = read_BRSOCDDNS1_value
    End Property

    Property Let write_BRSOCDDNS1(aData)
        set_BRSOCDDNS1 = aData
        write
    End Property

    Property Get get_bspi_registers_STRAP_OVERRIDE_CTRL_override
        get_bspi_registers_STRAP_OVERRIDE_CTRL_override = read_bspi_registers_STRAP_OVERRIDE_CTRL_override_value
    End Property

    Property Let set_bspi_registers_STRAP_OVERRIDE_CTRL_override(aData)
        write_bspi_registers_STRAP_OVERRIDE_CTRL_override_value = aData
        flag_bspi_registers_STRAP_OVERRIDE_CTRL_override        = &H1
    End Property

    Property Get read_bspi_registers_STRAP_OVERRIDE_CTRL_override
        read
        read_bspi_registers_STRAP_OVERRIDE_CTRL_override = read_bspi_registers_STRAP_OVERRIDE_CTRL_override_value
    End Property

    Property Let write_bspi_registers_STRAP_OVERRIDE_CTRL_override(aData)
        set_bspi_registers_STRAP_OVERRIDE_CTRL_override = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_bspi_registers_STRAP_OVERRIDE_CTRL_endian_mode_value = rightShift(data_low, 4) and &H1
        read_bspi_registers_STRAP_OVERRIDE_CTRL_data_quad_value = rightShift(data_low, 3) and &H1
        read_BRSOCA4N31_value = rightShift(data_low, 2) and &H1
        read_BRSOCDDNS1_value = rightShift(data_low, 1) and &H1
        bspi_registers_STRAP_OVERRIDE_CTRL_override_mask = &H1
        if data_low > LONG_MAX then
            if bspi_registers_STRAP_OVERRIDE_CTRL_override_mask = mask then
                read_bspi_registers_STRAP_OVERRIDE_CTRL_override_value = data_low
            else
                read_bspi_registers_STRAP_OVERRIDE_CTRL_override_value = (data_low - H8000_0000) and bspi_registers_STRAP_OVERRIDE_CTRL_override_mask
            end If
        else
            read_bspi_registers_STRAP_OVERRIDE_CTRL_override_value = data_low and bspi_registers_STRAP_OVERRIDE_CTRL_override_mask
        end If

    End Sub

    Sub write
        If flag_bspi_registers_STRAP_OVERRIDE_CTRL_endian_mode = &H0 or flag_bspi_registers_STRAP_OVERRIDE_CTRL_data_quad = &H0 or flag_BRSOCA4N31 = &H0 or flag_BRSOCDDNS1 = &H0 or flag_bspi_registers_STRAP_OVERRIDE_CTRL_override = &H0 Then read
        If flag_bspi_registers_STRAP_OVERRIDE_CTRL_endian_mode = &H0 Then write_bspi_registers_STRAP_OVERRIDE_CTRL_endian_mode_value = get_bspi_registers_STRAP_OVERRIDE_CTRL_endian_mode
        If flag_bspi_registers_STRAP_OVERRIDE_CTRL_data_quad = &H0 Then write_bspi_registers_STRAP_OVERRIDE_CTRL_data_quad_value = get_bspi_registers_STRAP_OVERRIDE_CTRL_data_quad
        If flag_BRSOCA4N31 = &H0 Then write_BRSOCA4N31_value = get_BRSOCA4N31
        If flag_BRSOCDDNS1 = &H0 Then write_BRSOCDDNS1_value = get_BRSOCDDNS1
        If flag_bspi_registers_STRAP_OVERRIDE_CTRL_override = &H0 Then write_bspi_registers_STRAP_OVERRIDE_CTRL_override_value = get_bspi_registers_STRAP_OVERRIDE_CTRL_override

        regValue = leftShift((write_bspi_registers_STRAP_OVERRIDE_CTRL_endian_mode_value and &H1), 4) + leftShift((write_bspi_registers_STRAP_OVERRIDE_CTRL_data_quad_value and &H1), 3) + leftShift((write_BRSOCA4N31_value and &H1), 2) + leftShift((write_BRSOCDDNS1_value and &H1), 1) + leftShift((write_bspi_registers_STRAP_OVERRIDE_CTRL_override_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_bspi_registers_STRAP_OVERRIDE_CTRL_endian_mode_value = rightShift(data_low, 4) and &H1
        read_bspi_registers_STRAP_OVERRIDE_CTRL_data_quad_value = rightShift(data_low, 3) and &H1
        read_BRSOCA4N31_value = rightShift(data_low, 2) and &H1
        read_BRSOCDDNS1_value = rightShift(data_low, 1) and &H1
        bspi_registers_STRAP_OVERRIDE_CTRL_override_mask = &H1
        if data_low > LONG_MAX then
            if bspi_registers_STRAP_OVERRIDE_CTRL_override_mask = mask then
                read_bspi_registers_STRAP_OVERRIDE_CTRL_override_value = data_low
            else
                read_bspi_registers_STRAP_OVERRIDE_CTRL_override_value = (data_low - H8000_0000) and bspi_registers_STRAP_OVERRIDE_CTRL_override_mask
            end If
        else
            read_bspi_registers_STRAP_OVERRIDE_CTRL_override_value = data_low and bspi_registers_STRAP_OVERRIDE_CTRL_override_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_bspi_registers_STRAP_OVERRIDE_CTRL_endian_mode_value = &H0
        flag_bspi_registers_STRAP_OVERRIDE_CTRL_endian_mode        = &H0
        write_bspi_registers_STRAP_OVERRIDE_CTRL_data_quad_value = &H0
        flag_bspi_registers_STRAP_OVERRIDE_CTRL_data_quad        = &H0
        write_BRSOCA4N31_value = &H0
        flag_BRSOCA4N31        = &H0
        write_BRSOCDDNS1_value = &H0
        flag_BRSOCDDNS1        = &H0
        write_bspi_registers_STRAP_OVERRIDE_CTRL_override_value = &H0
        flag_bspi_registers_STRAP_OVERRIDE_CTRL_override        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_bspi_registers_flex_mode_enable
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' BRFMEBFME                                  [0:0]            get_BRFMEBFME
''                                                             set_BRFMEBFME
''                                                             read_BRFMEBFME
''                                                             write_BRFMEBFME
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_bspi_registers_flex_mode_enable
    Private write_BRFMEBFME_value
    Private read_BRFMEBFME_value
    Private flag_BRFMEBFME

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

    Property Get get_BRFMEBFME
        get_BRFMEBFME = read_BRFMEBFME_value
    End Property

    Property Let set_BRFMEBFME(aData)
        write_BRFMEBFME_value = aData
        flag_BRFMEBFME        = &H1
    End Property

    Property Get read_BRFMEBFME
        read
        read_BRFMEBFME = read_BRFMEBFME_value
    End Property

    Property Let write_BRFMEBFME(aData)
        set_BRFMEBFME = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        BRFMEBFME_mask = &H1
        if data_low > LONG_MAX then
            if BRFMEBFME_mask = mask then
                read_BRFMEBFME_value = data_low
            else
                read_BRFMEBFME_value = (data_low - H8000_0000) and BRFMEBFME_mask
            end If
        else
            read_BRFMEBFME_value = data_low and BRFMEBFME_mask
        end If

    End Sub

    Sub write
        If flag_BRFMEBFME = &H0 Then read
        If flag_BRFMEBFME = &H0 Then write_BRFMEBFME_value = get_BRFMEBFME

        regValue = leftShift((write_BRFMEBFME_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        BRFMEBFME_mask = &H1
        if data_low > LONG_MAX then
            if BRFMEBFME_mask = mask then
                read_BRFMEBFME_value = data_low
            else
                read_BRFMEBFME_value = (data_low - H8000_0000) and BRFMEBFME_mask
            end If
        else
            read_BRFMEBFME_value = data_low and BRFMEBFME_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_BRFMEBFME_value = &H0
        flag_BRFMEBFME        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_bspi_registers_bits_per_cycle
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' BRBPCBRBPCR5                               [31:26]          get_BRBPCBRBPCR5
''                                                             set_BRBPCBRBPCR5
''                                                             read_BRBPCBRBPCR5
''                                                             write_BRBPCBRBPCR5
''---------------------------------------------------------------------------------
'' bspi_registers_BITS_PER_CYCLE_cmd_bpc_select   [25:24]          get_bspi_registers_BITS_PER_CYCLE_cmd_bpc_select
''                                                             set_bspi_registers_BITS_PER_CYCLE_cmd_bpc_select
''                                                             read_bspi_registers_BITS_PER_CYCLE_cmd_bpc_select
''                                                             write_bspi_registers_BITS_PER_CYCLE_cmd_bpc_select
''---------------------------------------------------------------------------------
'' BRBPCBRBPCR41                              [23:18]          get_BRBPCBRBPCR41
''                                                             set_BRBPCBRBPCR41
''                                                             read_BRBPCBRBPCR41
''                                                             write_BRBPCBRBPCR41
''---------------------------------------------------------------------------------
'' bspi_registers_BITS_PER_CYCLE_addr_bpc_select   [17:16]          get_bspi_registers_BITS_PER_CYCLE_addr_bpc_select
''                                                             set_bspi_registers_BITS_PER_CYCLE_addr_bpc_select
''                                                             read_bspi_registers_BITS_PER_CYCLE_addr_bpc_select
''                                                             write_bspi_registers_BITS_PER_CYCLE_addr_bpc_select
''---------------------------------------------------------------------------------
'' BRBPCBRBPCR31                              [15:10]          get_BRBPCBRBPCR31
''                                                             set_BRBPCBRBPCR31
''                                                             read_BRBPCBRBPCR31
''                                                             write_BRBPCBRBPCR31
''---------------------------------------------------------------------------------
'' bspi_registers_BITS_PER_CYCLE_mode_bpc_select   [9:8]            get_bspi_registers_BITS_PER_CYCLE_mode_bpc_select
''                                                             set_bspi_registers_BITS_PER_CYCLE_mode_bpc_select
''                                                             read_bspi_registers_BITS_PER_CYCLE_mode_bpc_select
''                                                             write_bspi_registers_BITS_PER_CYCLE_mode_bpc_select
''---------------------------------------------------------------------------------
'' bspi_registers_BITS_PER_CYCLE_data_bpc_select   [1:0]            get_bspi_registers_BITS_PER_CYCLE_data_bpc_select
''                                                             set_bspi_registers_BITS_PER_CYCLE_data_bpc_select
''                                                             read_bspi_registers_BITS_PER_CYCLE_data_bpc_select
''                                                             write_bspi_registers_BITS_PER_CYCLE_data_bpc_select
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_bspi_registers_bits_per_cycle
    Private write_BRBPCBRBPCR5_value
    Private read_BRBPCBRBPCR5_value
    Private flag_BRBPCBRBPCR5
    Private write_bspi_registers_BITS_PER_CYCLE_cmd_bpc_select_value
    Private read_bspi_registers_BITS_PER_CYCLE_cmd_bpc_select_value
    Private flag_bspi_registers_BITS_PER_CYCLE_cmd_bpc_select
    Private write_BRBPCBRBPCR41_value
    Private read_BRBPCBRBPCR41_value
    Private flag_BRBPCBRBPCR41
    Private write_bspi_registers_BITS_PER_CYCLE_addr_bpc_select_value
    Private read_bspi_registers_BITS_PER_CYCLE_addr_bpc_select_value
    Private flag_bspi_registers_BITS_PER_CYCLE_addr_bpc_select
    Private write_BRBPCBRBPCR31_value
    Private read_BRBPCBRBPCR31_value
    Private flag_BRBPCBRBPCR31
    Private write_bspi_registers_BITS_PER_CYCLE_mode_bpc_select_value
    Private read_bspi_registers_BITS_PER_CYCLE_mode_bpc_select_value
    Private flag_bspi_registers_BITS_PER_CYCLE_mode_bpc_select
    Private write_bspi_registers_BITS_PER_CYCLE_data_bpc_select_value
    Private read_bspi_registers_BITS_PER_CYCLE_data_bpc_select_value
    Private flag_bspi_registers_BITS_PER_CYCLE_data_bpc_select

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

    Property Get get_BRBPCBRBPCR5
        get_BRBPCBRBPCR5 = read_BRBPCBRBPCR5_value
    End Property

    Property Let set_BRBPCBRBPCR5(aData)
        write_BRBPCBRBPCR5_value = aData
        flag_BRBPCBRBPCR5        = &H1
    End Property

    Property Get read_BRBPCBRBPCR5
        read
        read_BRBPCBRBPCR5 = read_BRBPCBRBPCR5_value
    End Property

    Property Let write_BRBPCBRBPCR5(aData)
        set_BRBPCBRBPCR5 = aData
        write
    End Property

    Property Get get_bspi_registers_BITS_PER_CYCLE_cmd_bpc_select
        get_bspi_registers_BITS_PER_CYCLE_cmd_bpc_select = read_bspi_registers_BITS_PER_CYCLE_cmd_bpc_select_value
    End Property

    Property Let set_bspi_registers_BITS_PER_CYCLE_cmd_bpc_select(aData)
        write_bspi_registers_BITS_PER_CYCLE_cmd_bpc_select_value = aData
        flag_bspi_registers_BITS_PER_CYCLE_cmd_bpc_select        = &H1
    End Property

    Property Get read_bspi_registers_BITS_PER_CYCLE_cmd_bpc_select
        read
        read_bspi_registers_BITS_PER_CYCLE_cmd_bpc_select = read_bspi_registers_BITS_PER_CYCLE_cmd_bpc_select_value
    End Property

    Property Let write_bspi_registers_BITS_PER_CYCLE_cmd_bpc_select(aData)
        set_bspi_registers_BITS_PER_CYCLE_cmd_bpc_select = aData
        write
    End Property

    Property Get get_BRBPCBRBPCR41
        get_BRBPCBRBPCR41 = read_BRBPCBRBPCR41_value
    End Property

    Property Let set_BRBPCBRBPCR41(aData)
        write_BRBPCBRBPCR41_value = aData
        flag_BRBPCBRBPCR41        = &H1
    End Property

    Property Get read_BRBPCBRBPCR41
        read
        read_BRBPCBRBPCR41 = read_BRBPCBRBPCR41_value
    End Property

    Property Let write_BRBPCBRBPCR41(aData)
        set_BRBPCBRBPCR41 = aData
        write
    End Property

    Property Get get_bspi_registers_BITS_PER_CYCLE_addr_bpc_select
        get_bspi_registers_BITS_PER_CYCLE_addr_bpc_select = read_bspi_registers_BITS_PER_CYCLE_addr_bpc_select_value
    End Property

    Property Let set_bspi_registers_BITS_PER_CYCLE_addr_bpc_select(aData)
        write_bspi_registers_BITS_PER_CYCLE_addr_bpc_select_value = aData
        flag_bspi_registers_BITS_PER_CYCLE_addr_bpc_select        = &H1
    End Property

    Property Get read_bspi_registers_BITS_PER_CYCLE_addr_bpc_select
        read
        read_bspi_registers_BITS_PER_CYCLE_addr_bpc_select = read_bspi_registers_BITS_PER_CYCLE_addr_bpc_select_value
    End Property

    Property Let write_bspi_registers_BITS_PER_CYCLE_addr_bpc_select(aData)
        set_bspi_registers_BITS_PER_CYCLE_addr_bpc_select = aData
        write
    End Property

    Property Get get_BRBPCBRBPCR31
        get_BRBPCBRBPCR31 = read_BRBPCBRBPCR31_value
    End Property

    Property Let set_BRBPCBRBPCR31(aData)
        write_BRBPCBRBPCR31_value = aData
        flag_BRBPCBRBPCR31        = &H1
    End Property

    Property Get read_BRBPCBRBPCR31
        read
        read_BRBPCBRBPCR31 = read_BRBPCBRBPCR31_value
    End Property

    Property Let write_BRBPCBRBPCR31(aData)
        set_BRBPCBRBPCR31 = aData
        write
    End Property

    Property Get get_bspi_registers_BITS_PER_CYCLE_mode_bpc_select
        get_bspi_registers_BITS_PER_CYCLE_mode_bpc_select = read_bspi_registers_BITS_PER_CYCLE_mode_bpc_select_value
    End Property

    Property Let set_bspi_registers_BITS_PER_CYCLE_mode_bpc_select(aData)
        write_bspi_registers_BITS_PER_CYCLE_mode_bpc_select_value = aData
        flag_bspi_registers_BITS_PER_CYCLE_mode_bpc_select        = &H1
    End Property

    Property Get read_bspi_registers_BITS_PER_CYCLE_mode_bpc_select
        read
        read_bspi_registers_BITS_PER_CYCLE_mode_bpc_select = read_bspi_registers_BITS_PER_CYCLE_mode_bpc_select_value
    End Property

    Property Let write_bspi_registers_BITS_PER_CYCLE_mode_bpc_select(aData)
        set_bspi_registers_BITS_PER_CYCLE_mode_bpc_select = aData
        write
    End Property

    Property Get get_bspi_registers_BITS_PER_CYCLE_data_bpc_select
        get_bspi_registers_BITS_PER_CYCLE_data_bpc_select = read_bspi_registers_BITS_PER_CYCLE_data_bpc_select_value
    End Property

    Property Let set_bspi_registers_BITS_PER_CYCLE_data_bpc_select(aData)
        write_bspi_registers_BITS_PER_CYCLE_data_bpc_select_value = aData
        flag_bspi_registers_BITS_PER_CYCLE_data_bpc_select        = &H1
    End Property

    Property Get read_bspi_registers_BITS_PER_CYCLE_data_bpc_select
        read
        read_bspi_registers_BITS_PER_CYCLE_data_bpc_select = read_bspi_registers_BITS_PER_CYCLE_data_bpc_select_value
    End Property

    Property Let write_bspi_registers_BITS_PER_CYCLE_data_bpc_select(aData)
        set_bspi_registers_BITS_PER_CYCLE_data_bpc_select = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_BRBPCBRBPCR5_value = rightShift(data_low, 26) and &H3f
        read_bspi_registers_BITS_PER_CYCLE_cmd_bpc_select_value = rightShift(data_low, 24) and &H3
        read_BRBPCBRBPCR41_value = rightShift(data_low, 18) and &H3f
        read_bspi_registers_BITS_PER_CYCLE_addr_bpc_select_value = rightShift(data_low, 16) and &H3
        read_BRBPCBRBPCR31_value = rightShift(data_low, 10) and &H3f
        read_bspi_registers_BITS_PER_CYCLE_mode_bpc_select_value = rightShift(data_low, 8) and &H3
        bspi_registers_BITS_PER_CYCLE_data_bpc_select_mask = &H3
        if data_low > LONG_MAX then
            if bspi_registers_BITS_PER_CYCLE_data_bpc_select_mask = mask then
                read_bspi_registers_BITS_PER_CYCLE_data_bpc_select_value = data_low
            else
                read_bspi_registers_BITS_PER_CYCLE_data_bpc_select_value = (data_low - H8000_0000) and bspi_registers_BITS_PER_CYCLE_data_bpc_select_mask
            end If
        else
            read_bspi_registers_BITS_PER_CYCLE_data_bpc_select_value = data_low and bspi_registers_BITS_PER_CYCLE_data_bpc_select_mask
        end If

    End Sub

    Sub write
        If flag_BRBPCBRBPCR5 = &H0 or flag_bspi_registers_BITS_PER_CYCLE_cmd_bpc_select = &H0 or flag_BRBPCBRBPCR41 = &H0 or flag_bspi_registers_BITS_PER_CYCLE_addr_bpc_select = &H0 or flag_BRBPCBRBPCR31 = &H0 or flag_bspi_registers_BITS_PER_CYCLE_mode_bpc_select = &H0 or flag_bspi_registers_BITS_PER_CYCLE_data_bpc_select = &H0 Then read
        If flag_BRBPCBRBPCR5 = &H0 Then write_BRBPCBRBPCR5_value = get_BRBPCBRBPCR5
        If flag_bspi_registers_BITS_PER_CYCLE_cmd_bpc_select = &H0 Then write_bspi_registers_BITS_PER_CYCLE_cmd_bpc_select_value = get_bspi_registers_BITS_PER_CYCLE_cmd_bpc_select
        If flag_BRBPCBRBPCR41 = &H0 Then write_BRBPCBRBPCR41_value = get_BRBPCBRBPCR41
        If flag_bspi_registers_BITS_PER_CYCLE_addr_bpc_select = &H0 Then write_bspi_registers_BITS_PER_CYCLE_addr_bpc_select_value = get_bspi_registers_BITS_PER_CYCLE_addr_bpc_select
        If flag_BRBPCBRBPCR31 = &H0 Then write_BRBPCBRBPCR31_value = get_BRBPCBRBPCR31
        If flag_bspi_registers_BITS_PER_CYCLE_mode_bpc_select = &H0 Then write_bspi_registers_BITS_PER_CYCLE_mode_bpc_select_value = get_bspi_registers_BITS_PER_CYCLE_mode_bpc_select
        If flag_bspi_registers_BITS_PER_CYCLE_data_bpc_select = &H0 Then write_bspi_registers_BITS_PER_CYCLE_data_bpc_select_value = get_bspi_registers_BITS_PER_CYCLE_data_bpc_select

        regValue = leftShift((write_BRBPCBRBPCR5_value and &H3f), 26) + leftShift((write_bspi_registers_BITS_PER_CYCLE_cmd_bpc_select_value and &H3), 24) + leftShift((write_BRBPCBRBPCR41_value and &H3f), 18) + leftShift((write_bspi_registers_BITS_PER_CYCLE_addr_bpc_select_value and &H3), 16) + leftShift((write_BRBPCBRBPCR31_value and &H3f), 10) + leftShift((write_bspi_registers_BITS_PER_CYCLE_mode_bpc_select_value and &H3), 8) + leftShift((write_bspi_registers_BITS_PER_CYCLE_data_bpc_select_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_BRBPCBRBPCR5_value = rightShift(data_low, 26) and &H3f
        read_bspi_registers_BITS_PER_CYCLE_cmd_bpc_select_value = rightShift(data_low, 24) and &H3
        read_BRBPCBRBPCR41_value = rightShift(data_low, 18) and &H3f
        read_bspi_registers_BITS_PER_CYCLE_addr_bpc_select_value = rightShift(data_low, 16) and &H3
        read_BRBPCBRBPCR31_value = rightShift(data_low, 10) and &H3f
        read_bspi_registers_BITS_PER_CYCLE_mode_bpc_select_value = rightShift(data_low, 8) and &H3
        bspi_registers_BITS_PER_CYCLE_data_bpc_select_mask = &H3
        if data_low > LONG_MAX then
            if bspi_registers_BITS_PER_CYCLE_data_bpc_select_mask = mask then
                read_bspi_registers_BITS_PER_CYCLE_data_bpc_select_value = data_low
            else
                read_bspi_registers_BITS_PER_CYCLE_data_bpc_select_value = (data_low - H8000_0000) and bspi_registers_BITS_PER_CYCLE_data_bpc_select_mask
            end If
        else
            read_bspi_registers_BITS_PER_CYCLE_data_bpc_select_value = data_low and bspi_registers_BITS_PER_CYCLE_data_bpc_select_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_BRBPCBRBPCR5_value = &H0
        flag_BRBPCBRBPCR5        = &H0
        write_bspi_registers_BITS_PER_CYCLE_cmd_bpc_select_value = &H0
        flag_bspi_registers_BITS_PER_CYCLE_cmd_bpc_select        = &H0
        write_BRBPCBRBPCR41_value = &H0
        flag_BRBPCBRBPCR41        = &H0
        write_bspi_registers_BITS_PER_CYCLE_addr_bpc_select_value = &H0
        flag_bspi_registers_BITS_PER_CYCLE_addr_bpc_select        = &H0
        write_BRBPCBRBPCR31_value = &H0
        flag_BRBPCBRBPCR31        = &H0
        write_bspi_registers_BITS_PER_CYCLE_mode_bpc_select_value = &H0
        flag_bspi_registers_BITS_PER_CYCLE_mode_bpc_select        = &H0
        write_bspi_registers_BITS_PER_CYCLE_data_bpc_select_value = &H0
        flag_bspi_registers_BITS_PER_CYCLE_data_bpc_select        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_bspi_registers_bits_per_phase
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' BRBPPBRBPPR5                               [31:25]          get_BRBPPBRBPPR5
''                                                             set_BRBPPBRBPPR5
''                                                             read_BRBPPBRBPPR5
''                                                             write_BRBPPBRBPPR5
''---------------------------------------------------------------------------------
'' bspi_registers_BITS_PER_PHASE_cmd_bpp_select   [24:24]          get_bspi_registers_BITS_PER_PHASE_cmd_bpp_select
''                                                             set_bspi_registers_BITS_PER_PHASE_cmd_bpp_select
''                                                             read_bspi_registers_BITS_PER_PHASE_cmd_bpp_select
''                                                             write_bspi_registers_BITS_PER_PHASE_cmd_bpp_select
''---------------------------------------------------------------------------------
'' BRBPPBRBPPR41                              [23:17]          get_BRBPPBRBPPR41
''                                                             set_BRBPPBRBPPR41
''                                                             read_BRBPPBRBPPR41
''                                                             write_BRBPPBRBPPR41
''---------------------------------------------------------------------------------
'' bspi_registers_BITS_PER_PHASE_addr_bpp_select   [16:16]          get_bspi_registers_BITS_PER_PHASE_addr_bpp_select
''                                                             set_bspi_registers_BITS_PER_PHASE_addr_bpp_select
''                                                             read_bspi_registers_BITS_PER_PHASE_addr_bpp_select
''                                                             write_bspi_registers_BITS_PER_PHASE_addr_bpp_select
''---------------------------------------------------------------------------------
'' bspi_registers_BITS_PER_PHASE_mode_bpp     [8:8]            get_bspi_registers_BITS_PER_PHASE_mode_bpp
''                                                             set_bspi_registers_BITS_PER_PHASE_mode_bpp
''                                                             read_bspi_registers_BITS_PER_PHASE_mode_bpp
''                                                             write_bspi_registers_BITS_PER_PHASE_mode_bpp
''---------------------------------------------------------------------------------
'' bspi_registers_BITS_PER_PHASE_dummy_cycles   [7:0]            get_bspi_registers_BITS_PER_PHASE_dummy_cycles
''                                                             set_bspi_registers_BITS_PER_PHASE_dummy_cycles
''                                                             read_bspi_registers_BITS_PER_PHASE_dummy_cycles
''                                                             write_bspi_registers_BITS_PER_PHASE_dummy_cycles
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_bspi_registers_bits_per_phase
    Private write_BRBPPBRBPPR5_value
    Private read_BRBPPBRBPPR5_value
    Private flag_BRBPPBRBPPR5
    Private write_bspi_registers_BITS_PER_PHASE_cmd_bpp_select_value
    Private read_bspi_registers_BITS_PER_PHASE_cmd_bpp_select_value
    Private flag_bspi_registers_BITS_PER_PHASE_cmd_bpp_select
    Private write_BRBPPBRBPPR41_value
    Private read_BRBPPBRBPPR41_value
    Private flag_BRBPPBRBPPR41
    Private write_bspi_registers_BITS_PER_PHASE_addr_bpp_select_value
    Private read_bspi_registers_BITS_PER_PHASE_addr_bpp_select_value
    Private flag_bspi_registers_BITS_PER_PHASE_addr_bpp_select
    Private write_bspi_registers_BITS_PER_PHASE_mode_bpp_value
    Private read_bspi_registers_BITS_PER_PHASE_mode_bpp_value
    Private flag_bspi_registers_BITS_PER_PHASE_mode_bpp
    Private write_bspi_registers_BITS_PER_PHASE_dummy_cycles_value
    Private read_bspi_registers_BITS_PER_PHASE_dummy_cycles_value
    Private flag_bspi_registers_BITS_PER_PHASE_dummy_cycles

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

    Property Get get_BRBPPBRBPPR5
        get_BRBPPBRBPPR5 = read_BRBPPBRBPPR5_value
    End Property

    Property Let set_BRBPPBRBPPR5(aData)
        write_BRBPPBRBPPR5_value = aData
        flag_BRBPPBRBPPR5        = &H1
    End Property

    Property Get read_BRBPPBRBPPR5
        read
        read_BRBPPBRBPPR5 = read_BRBPPBRBPPR5_value
    End Property

    Property Let write_BRBPPBRBPPR5(aData)
        set_BRBPPBRBPPR5 = aData
        write
    End Property

    Property Get get_bspi_registers_BITS_PER_PHASE_cmd_bpp_select
        get_bspi_registers_BITS_PER_PHASE_cmd_bpp_select = read_bspi_registers_BITS_PER_PHASE_cmd_bpp_select_value
    End Property

    Property Let set_bspi_registers_BITS_PER_PHASE_cmd_bpp_select(aData)
        write_bspi_registers_BITS_PER_PHASE_cmd_bpp_select_value = aData
        flag_bspi_registers_BITS_PER_PHASE_cmd_bpp_select        = &H1
    End Property

    Property Get read_bspi_registers_BITS_PER_PHASE_cmd_bpp_select
        read
        read_bspi_registers_BITS_PER_PHASE_cmd_bpp_select = read_bspi_registers_BITS_PER_PHASE_cmd_bpp_select_value
    End Property

    Property Let write_bspi_registers_BITS_PER_PHASE_cmd_bpp_select(aData)
        set_bspi_registers_BITS_PER_PHASE_cmd_bpp_select = aData
        write
    End Property

    Property Get get_BRBPPBRBPPR41
        get_BRBPPBRBPPR41 = read_BRBPPBRBPPR41_value
    End Property

    Property Let set_BRBPPBRBPPR41(aData)
        write_BRBPPBRBPPR41_value = aData
        flag_BRBPPBRBPPR41        = &H1
    End Property

    Property Get read_BRBPPBRBPPR41
        read
        read_BRBPPBRBPPR41 = read_BRBPPBRBPPR41_value
    End Property

    Property Let write_BRBPPBRBPPR41(aData)
        set_BRBPPBRBPPR41 = aData
        write
    End Property

    Property Get get_bspi_registers_BITS_PER_PHASE_addr_bpp_select
        get_bspi_registers_BITS_PER_PHASE_addr_bpp_select = read_bspi_registers_BITS_PER_PHASE_addr_bpp_select_value
    End Property

    Property Let set_bspi_registers_BITS_PER_PHASE_addr_bpp_select(aData)
        write_bspi_registers_BITS_PER_PHASE_addr_bpp_select_value = aData
        flag_bspi_registers_BITS_PER_PHASE_addr_bpp_select        = &H1
    End Property

    Property Get read_bspi_registers_BITS_PER_PHASE_addr_bpp_select
        read
        read_bspi_registers_BITS_PER_PHASE_addr_bpp_select = read_bspi_registers_BITS_PER_PHASE_addr_bpp_select_value
    End Property

    Property Let write_bspi_registers_BITS_PER_PHASE_addr_bpp_select(aData)
        set_bspi_registers_BITS_PER_PHASE_addr_bpp_select = aData
        write
    End Property

    Property Get get_bspi_registers_BITS_PER_PHASE_mode_bpp
        get_bspi_registers_BITS_PER_PHASE_mode_bpp = read_bspi_registers_BITS_PER_PHASE_mode_bpp_value
    End Property

    Property Let set_bspi_registers_BITS_PER_PHASE_mode_bpp(aData)
        write_bspi_registers_BITS_PER_PHASE_mode_bpp_value = aData
        flag_bspi_registers_BITS_PER_PHASE_mode_bpp        = &H1
    End Property

    Property Get read_bspi_registers_BITS_PER_PHASE_mode_bpp
        read
        read_bspi_registers_BITS_PER_PHASE_mode_bpp = read_bspi_registers_BITS_PER_PHASE_mode_bpp_value
    End Property

    Property Let write_bspi_registers_BITS_PER_PHASE_mode_bpp(aData)
        set_bspi_registers_BITS_PER_PHASE_mode_bpp = aData
        write
    End Property

    Property Get get_bspi_registers_BITS_PER_PHASE_dummy_cycles
        get_bspi_registers_BITS_PER_PHASE_dummy_cycles = read_bspi_registers_BITS_PER_PHASE_dummy_cycles_value
    End Property

    Property Let set_bspi_registers_BITS_PER_PHASE_dummy_cycles(aData)
        write_bspi_registers_BITS_PER_PHASE_dummy_cycles_value = aData
        flag_bspi_registers_BITS_PER_PHASE_dummy_cycles        = &H1
    End Property

    Property Get read_bspi_registers_BITS_PER_PHASE_dummy_cycles
        read
        read_bspi_registers_BITS_PER_PHASE_dummy_cycles = read_bspi_registers_BITS_PER_PHASE_dummy_cycles_value
    End Property

    Property Let write_bspi_registers_BITS_PER_PHASE_dummy_cycles(aData)
        set_bspi_registers_BITS_PER_PHASE_dummy_cycles = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_BRBPPBRBPPR5_value = rightShift(data_low, 25) and &H7f
        read_bspi_registers_BITS_PER_PHASE_cmd_bpp_select_value = rightShift(data_low, 24) and &H1
        read_BRBPPBRBPPR41_value = rightShift(data_low, 17) and &H7f
        read_bspi_registers_BITS_PER_PHASE_addr_bpp_select_value = rightShift(data_low, 16) and &H1
        read_bspi_registers_BITS_PER_PHASE_mode_bpp_value = rightShift(data_low, 8) and &H1
        bspi_registers_BITS_PER_PHASE_dummy_cycles_mask = &Hff
        if data_low > LONG_MAX then
            if bspi_registers_BITS_PER_PHASE_dummy_cycles_mask = mask then
                read_bspi_registers_BITS_PER_PHASE_dummy_cycles_value = data_low
            else
                read_bspi_registers_BITS_PER_PHASE_dummy_cycles_value = (data_low - H8000_0000) and bspi_registers_BITS_PER_PHASE_dummy_cycles_mask
            end If
        else
            read_bspi_registers_BITS_PER_PHASE_dummy_cycles_value = data_low and bspi_registers_BITS_PER_PHASE_dummy_cycles_mask
        end If

    End Sub

    Sub write
        If flag_BRBPPBRBPPR5 = &H0 or flag_bspi_registers_BITS_PER_PHASE_cmd_bpp_select = &H0 or flag_BRBPPBRBPPR41 = &H0 or flag_bspi_registers_BITS_PER_PHASE_addr_bpp_select = &H0 or flag_bspi_registers_BITS_PER_PHASE_mode_bpp = &H0 or flag_bspi_registers_BITS_PER_PHASE_dummy_cycles = &H0 Then read
        If flag_BRBPPBRBPPR5 = &H0 Then write_BRBPPBRBPPR5_value = get_BRBPPBRBPPR5
        If flag_bspi_registers_BITS_PER_PHASE_cmd_bpp_select = &H0 Then write_bspi_registers_BITS_PER_PHASE_cmd_bpp_select_value = get_bspi_registers_BITS_PER_PHASE_cmd_bpp_select
        If flag_BRBPPBRBPPR41 = &H0 Then write_BRBPPBRBPPR41_value = get_BRBPPBRBPPR41
        If flag_bspi_registers_BITS_PER_PHASE_addr_bpp_select = &H0 Then write_bspi_registers_BITS_PER_PHASE_addr_bpp_select_value = get_bspi_registers_BITS_PER_PHASE_addr_bpp_select
        If flag_bspi_registers_BITS_PER_PHASE_mode_bpp = &H0 Then write_bspi_registers_BITS_PER_PHASE_mode_bpp_value = get_bspi_registers_BITS_PER_PHASE_mode_bpp
        If flag_bspi_registers_BITS_PER_PHASE_dummy_cycles = &H0 Then write_bspi_registers_BITS_PER_PHASE_dummy_cycles_value = get_bspi_registers_BITS_PER_PHASE_dummy_cycles

        regValue = leftShift((write_BRBPPBRBPPR5_value and &H7f), 25) + leftShift((write_bspi_registers_BITS_PER_PHASE_cmd_bpp_select_value and &H1), 24) + leftShift((write_BRBPPBRBPPR41_value and &H7f), 17) + leftShift((write_bspi_registers_BITS_PER_PHASE_addr_bpp_select_value and &H1), 16) + leftShift((write_bspi_registers_BITS_PER_PHASE_mode_bpp_value and &H1), 8) + leftShift((write_bspi_registers_BITS_PER_PHASE_dummy_cycles_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_BRBPPBRBPPR5_value = rightShift(data_low, 25) and &H7f
        read_bspi_registers_BITS_PER_PHASE_cmd_bpp_select_value = rightShift(data_low, 24) and &H1
        read_BRBPPBRBPPR41_value = rightShift(data_low, 17) and &H7f
        read_bspi_registers_BITS_PER_PHASE_addr_bpp_select_value = rightShift(data_low, 16) and &H1
        read_bspi_registers_BITS_PER_PHASE_mode_bpp_value = rightShift(data_low, 8) and &H1
        bspi_registers_BITS_PER_PHASE_dummy_cycles_mask = &Hff
        if data_low > LONG_MAX then
            if bspi_registers_BITS_PER_PHASE_dummy_cycles_mask = mask then
                read_bspi_registers_BITS_PER_PHASE_dummy_cycles_value = data_low
            else
                read_bspi_registers_BITS_PER_PHASE_dummy_cycles_value = (data_low - H8000_0000) and bspi_registers_BITS_PER_PHASE_dummy_cycles_mask
            end If
        else
            read_bspi_registers_BITS_PER_PHASE_dummy_cycles_value = data_low and bspi_registers_BITS_PER_PHASE_dummy_cycles_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_BRBPPBRBPPR5_value = &H0
        flag_BRBPPBRBPPR5        = &H0
        write_bspi_registers_BITS_PER_PHASE_cmd_bpp_select_value = &H0
        flag_bspi_registers_BITS_PER_PHASE_cmd_bpp_select        = &H0
        write_BRBPPBRBPPR41_value = &H0
        flag_BRBPPBRBPPR41        = &H0
        write_bspi_registers_BITS_PER_PHASE_addr_bpp_select_value = &H0
        flag_bspi_registers_BITS_PER_PHASE_addr_bpp_select        = &H0
        write_bspi_registers_BITS_PER_PHASE_mode_bpp_value = &H0
        flag_bspi_registers_BITS_PER_PHASE_mode_bpp        = &H0
        write_bspi_registers_BITS_PER_PHASE_dummy_cycles_value = &H0
        flag_bspi_registers_BITS_PER_PHASE_dummy_cycles        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_bspi_registers_cmd_and_mode_byte
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' BRCAMBBRCAMBR3                             [31:24]          get_BRCAMBBRCAMBR3
''                                                             set_BRCAMBBRCAMBR3
''                                                             read_BRCAMBBRCAMBR3
''                                                             write_BRCAMBBRCAMBR3
''---------------------------------------------------------------------------------
'' BRCAMBBMB1                                 [23:16]          get_BRCAMBBMB1
''                                                             set_BRCAMBBMB1
''                                                             read_BRCAMBBMB1
''                                                             write_BRCAMBBMB1
''---------------------------------------------------------------------------------
'' BRCAMBBCB                                  [7:0]            get_BRCAMBBCB
''                                                             set_BRCAMBBCB
''                                                             read_BRCAMBBCB
''                                                             write_BRCAMBBCB
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_bspi_registers_cmd_and_mode_byte
    Private write_BRCAMBBRCAMBR3_value
    Private read_BRCAMBBRCAMBR3_value
    Private flag_BRCAMBBRCAMBR3
    Private write_BRCAMBBMB1_value
    Private read_BRCAMBBMB1_value
    Private flag_BRCAMBBMB1
    Private write_BRCAMBBCB_value
    Private read_BRCAMBBCB_value
    Private flag_BRCAMBBCB

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

    Property Get get_BRCAMBBRCAMBR3
        get_BRCAMBBRCAMBR3 = read_BRCAMBBRCAMBR3_value
    End Property

    Property Let set_BRCAMBBRCAMBR3(aData)
        write_BRCAMBBRCAMBR3_value = aData
        flag_BRCAMBBRCAMBR3        = &H1
    End Property

    Property Get read_BRCAMBBRCAMBR3
        read
        read_BRCAMBBRCAMBR3 = read_BRCAMBBRCAMBR3_value
    End Property

    Property Let write_BRCAMBBRCAMBR3(aData)
        set_BRCAMBBRCAMBR3 = aData
        write
    End Property

    Property Get get_BRCAMBBMB1
        get_BRCAMBBMB1 = read_BRCAMBBMB1_value
    End Property

    Property Let set_BRCAMBBMB1(aData)
        write_BRCAMBBMB1_value = aData
        flag_BRCAMBBMB1        = &H1
    End Property

    Property Get read_BRCAMBBMB1
        read
        read_BRCAMBBMB1 = read_BRCAMBBMB1_value
    End Property

    Property Let write_BRCAMBBMB1(aData)
        set_BRCAMBBMB1 = aData
        write
    End Property

    Property Get get_BRCAMBBCB
        get_BRCAMBBCB = read_BRCAMBBCB_value
    End Property

    Property Let set_BRCAMBBCB(aData)
        write_BRCAMBBCB_value = aData
        flag_BRCAMBBCB        = &H1
    End Property

    Property Get read_BRCAMBBCB
        read
        read_BRCAMBBCB = read_BRCAMBBCB_value
    End Property

    Property Let write_BRCAMBBCB(aData)
        set_BRCAMBBCB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_BRCAMBBRCAMBR3_value = rightShift(data_low, 24) and &Hff
        read_BRCAMBBMB1_value = rightShift(data_low, 16) and &Hff
        BRCAMBBCB_mask = &Hff
        if data_low > LONG_MAX then
            if BRCAMBBCB_mask = mask then
                read_BRCAMBBCB_value = data_low
            else
                read_BRCAMBBCB_value = (data_low - H8000_0000) and BRCAMBBCB_mask
            end If
        else
            read_BRCAMBBCB_value = data_low and BRCAMBBCB_mask
        end If

    End Sub

    Sub write
        If flag_BRCAMBBRCAMBR3 = &H0 or flag_BRCAMBBMB1 = &H0 or flag_BRCAMBBCB = &H0 Then read
        If flag_BRCAMBBRCAMBR3 = &H0 Then write_BRCAMBBRCAMBR3_value = get_BRCAMBBRCAMBR3
        If flag_BRCAMBBMB1 = &H0 Then write_BRCAMBBMB1_value = get_BRCAMBBMB1
        If flag_BRCAMBBCB = &H0 Then write_BRCAMBBCB_value = get_BRCAMBBCB

        regValue = leftShift((write_BRCAMBBRCAMBR3_value and &Hff), 24) + leftShift((write_BRCAMBBMB1_value and &Hff), 16) + leftShift((write_BRCAMBBCB_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_BRCAMBBRCAMBR3_value = rightShift(data_low, 24) and &Hff
        read_BRCAMBBMB1_value = rightShift(data_low, 16) and &Hff
        BRCAMBBCB_mask = &Hff
        if data_low > LONG_MAX then
            if BRCAMBBCB_mask = mask then
                read_BRCAMBBCB_value = data_low
            else
                read_BRCAMBBCB_value = (data_low - H8000_0000) and BRCAMBBCB_mask
            end If
        else
            read_BRCAMBBCB_value = data_low and BRCAMBBCB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_BRCAMBBRCAMBR3_value = &H0
        flag_BRCAMBBRCAMBR3        = &H0
        write_BRCAMBBMB1_value = &H0
        flag_BRCAMBBMB1        = &H0
        write_BRCAMBBCB_value = &H0
        flag_BRCAMBBCB        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_bspi_registers_bspi_flash_upper_addr_byte
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' BRBFUABBFUA                                [31:24]          get_BRBFUABBFUA
''                                                             set_BRBFUABBFUA
''                                                             read_BRBFUABBFUA
''                                                             write_BRBFUABBFUA
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_bspi_registers_bspi_flash_upper_addr_byte
    Private write_BRBFUABBFUA_value
    Private read_BRBFUABBFUA_value
    Private flag_BRBFUABBFUA

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

    Property Get get_BRBFUABBFUA
        get_BRBFUABBFUA = read_BRBFUABBFUA_value
    End Property

    Property Let set_BRBFUABBFUA(aData)
        write_BRBFUABBFUA_value = aData
        flag_BRBFUABBFUA        = &H1
    End Property

    Property Get read_BRBFUABBFUA
        read
        read_BRBFUABBFUA = read_BRBFUABBFUA_value
    End Property

    Property Let write_BRBFUABBFUA(aData)
        set_BRBFUABBFUA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_BRBFUABBFUA_value = rightShift(data_low, 24) and &Hff

    End Sub

    Sub write
        If flag_BRBFUABBFUA = &H0 Then read
        If flag_BRBFUABBFUA = &H0 Then write_BRBFUABBFUA_value = get_BRBFUABBFUA

        regValue = leftShift((write_BRBFUABBFUA_value and &Hff), 24)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_BRBFUABBFUA_value = rightShift(data_low, 24) and &Hff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_BRBFUABBFUA_value = &H0
        flag_BRBFUABBFUA        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_bspi_registers_bspi_xor_value
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' bspi_registers_BSPI_XOR_VALUE_bspi_xor_value   [31:20]          get_bspi_registers_BSPI_XOR_VALUE_bspi_xor_value
''                                                             set_bspi_registers_BSPI_XOR_VALUE_bspi_xor_value
''                                                             read_bspi_registers_BSPI_XOR_VALUE_bspi_xor_value
''                                                             write_bspi_registers_BSPI_XOR_VALUE_bspi_xor_value
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_bspi_registers_bspi_xor_value
    Private write_bspi_registers_BSPI_XOR_VALUE_bspi_xor_value_value
    Private read_bspi_registers_BSPI_XOR_VALUE_bspi_xor_value_value
    Private flag_bspi_registers_BSPI_XOR_VALUE_bspi_xor_value

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

    Property Get get_bspi_registers_BSPI_XOR_VALUE_bspi_xor_value
        get_bspi_registers_BSPI_XOR_VALUE_bspi_xor_value = read_bspi_registers_BSPI_XOR_VALUE_bspi_xor_value_value
    End Property

    Property Let set_bspi_registers_BSPI_XOR_VALUE_bspi_xor_value(aData)
        write_bspi_registers_BSPI_XOR_VALUE_bspi_xor_value_value = aData
        flag_bspi_registers_BSPI_XOR_VALUE_bspi_xor_value        = &H1
    End Property

    Property Get read_bspi_registers_BSPI_XOR_VALUE_bspi_xor_value
        read
        read_bspi_registers_BSPI_XOR_VALUE_bspi_xor_value = read_bspi_registers_BSPI_XOR_VALUE_bspi_xor_value_value
    End Property

    Property Let write_bspi_registers_BSPI_XOR_VALUE_bspi_xor_value(aData)
        set_bspi_registers_BSPI_XOR_VALUE_bspi_xor_value = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_bspi_registers_BSPI_XOR_VALUE_bspi_xor_value_value = rightShift(data_low, 20) and &Hfff

    End Sub

    Sub write
        If flag_bspi_registers_BSPI_XOR_VALUE_bspi_xor_value = &H0 Then read
        If flag_bspi_registers_BSPI_XOR_VALUE_bspi_xor_value = &H0 Then write_bspi_registers_BSPI_XOR_VALUE_bspi_xor_value_value = get_bspi_registers_BSPI_XOR_VALUE_bspi_xor_value

        regValue = leftShift((write_bspi_registers_BSPI_XOR_VALUE_bspi_xor_value_value and &Hfff), 20)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_bspi_registers_BSPI_XOR_VALUE_bspi_xor_value_value = rightShift(data_low, 20) and &Hfff

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_bspi_registers_BSPI_XOR_VALUE_bspi_xor_value_value = &H0
        flag_bspi_registers_BSPI_XOR_VALUE_bspi_xor_value        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_bspi_registers_bspi_xor_enable
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' bspi_registers_BSPI_XOR_ENABLE_bspi_xor_enable   [0:0]            get_bspi_registers_BSPI_XOR_ENABLE_bspi_xor_enable
''                                                             set_bspi_registers_BSPI_XOR_ENABLE_bspi_xor_enable
''                                                             read_bspi_registers_BSPI_XOR_ENABLE_bspi_xor_enable
''                                                             write_bspi_registers_BSPI_XOR_ENABLE_bspi_xor_enable
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_bspi_registers_bspi_xor_enable
    Private write_bspi_registers_BSPI_XOR_ENABLE_bspi_xor_enable_value
    Private read_bspi_registers_BSPI_XOR_ENABLE_bspi_xor_enable_value
    Private flag_bspi_registers_BSPI_XOR_ENABLE_bspi_xor_enable

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

    Property Get get_bspi_registers_BSPI_XOR_ENABLE_bspi_xor_enable
        get_bspi_registers_BSPI_XOR_ENABLE_bspi_xor_enable = read_bspi_registers_BSPI_XOR_ENABLE_bspi_xor_enable_value
    End Property

    Property Let set_bspi_registers_BSPI_XOR_ENABLE_bspi_xor_enable(aData)
        write_bspi_registers_BSPI_XOR_ENABLE_bspi_xor_enable_value = aData
        flag_bspi_registers_BSPI_XOR_ENABLE_bspi_xor_enable        = &H1
    End Property

    Property Get read_bspi_registers_BSPI_XOR_ENABLE_bspi_xor_enable
        read
        read_bspi_registers_BSPI_XOR_ENABLE_bspi_xor_enable = read_bspi_registers_BSPI_XOR_ENABLE_bspi_xor_enable_value
    End Property

    Property Let write_bspi_registers_BSPI_XOR_ENABLE_bspi_xor_enable(aData)
        set_bspi_registers_BSPI_XOR_ENABLE_bspi_xor_enable = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        bspi_registers_BSPI_XOR_ENABLE_bspi_xor_enable_mask = &H1
        if data_low > LONG_MAX then
            if bspi_registers_BSPI_XOR_ENABLE_bspi_xor_enable_mask = mask then
                read_bspi_registers_BSPI_XOR_ENABLE_bspi_xor_enable_value = data_low
            else
                read_bspi_registers_BSPI_XOR_ENABLE_bspi_xor_enable_value = (data_low - H8000_0000) and bspi_registers_BSPI_XOR_ENABLE_bspi_xor_enable_mask
            end If
        else
            read_bspi_registers_BSPI_XOR_ENABLE_bspi_xor_enable_value = data_low and bspi_registers_BSPI_XOR_ENABLE_bspi_xor_enable_mask
        end If

    End Sub

    Sub write
        If flag_bspi_registers_BSPI_XOR_ENABLE_bspi_xor_enable = &H0 Then read
        If flag_bspi_registers_BSPI_XOR_ENABLE_bspi_xor_enable = &H0 Then write_bspi_registers_BSPI_XOR_ENABLE_bspi_xor_enable_value = get_bspi_registers_BSPI_XOR_ENABLE_bspi_xor_enable

        regValue = leftShift((write_bspi_registers_BSPI_XOR_ENABLE_bspi_xor_enable_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        bspi_registers_BSPI_XOR_ENABLE_bspi_xor_enable_mask = &H1
        if data_low > LONG_MAX then
            if bspi_registers_BSPI_XOR_ENABLE_bspi_xor_enable_mask = mask then
                read_bspi_registers_BSPI_XOR_ENABLE_bspi_xor_enable_value = data_low
            else
                read_bspi_registers_BSPI_XOR_ENABLE_bspi_xor_enable_value = (data_low - H8000_0000) and bspi_registers_BSPI_XOR_ENABLE_bspi_xor_enable_mask
            end If
        else
            read_bspi_registers_BSPI_XOR_ENABLE_bspi_xor_enable_value = data_low and bspi_registers_BSPI_XOR_ENABLE_bspi_xor_enable_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_bspi_registers_BSPI_XOR_ENABLE_bspi_xor_enable_value = &H0
        flag_bspi_registers_BSPI_XOR_ENABLE_bspi_xor_enable        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_bspi_registers_bspi_pio_mode_enable
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' BRBPMEBPM                                  [0:0]            get_BRBPMEBPM
''                                                             set_BRBPMEBPM
''                                                             read_BRBPMEBPM
''                                                             write_BRBPMEBPM
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_bspi_registers_bspi_pio_mode_enable
    Private write_BRBPMEBPM_value
    Private read_BRBPMEBPM_value
    Private flag_BRBPMEBPM

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

    Property Get get_BRBPMEBPM
        get_BRBPMEBPM = read_BRBPMEBPM_value
    End Property

    Property Let set_BRBPMEBPM(aData)
        write_BRBPMEBPM_value = aData
        flag_BRBPMEBPM        = &H1
    End Property

    Property Get read_BRBPMEBPM
        read
        read_BRBPMEBPM = read_BRBPMEBPM_value
    End Property

    Property Let write_BRBPMEBPM(aData)
        set_BRBPMEBPM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        BRBPMEBPM_mask = &H1
        if data_low > LONG_MAX then
            if BRBPMEBPM_mask = mask then
                read_BRBPMEBPM_value = data_low
            else
                read_BRBPMEBPM_value = (data_low - H8000_0000) and BRBPMEBPM_mask
            end If
        else
            read_BRBPMEBPM_value = data_low and BRBPMEBPM_mask
        end If

    End Sub

    Sub write
        If flag_BRBPMEBPM = &H0 Then read
        If flag_BRBPMEBPM = &H0 Then write_BRBPMEBPM_value = get_BRBPMEBPM

        regValue = leftShift((write_BRBPMEBPM_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        BRBPMEBPM_mask = &H1
        if data_low > LONG_MAX then
            if BRBPMEBPM_mask = mask then
                read_BRBPMEBPM_value = data_low
            else
                read_BRBPMEBPM_value = (data_low - H8000_0000) and BRBPMEBPM_mask
            end If
        else
            read_BRBPMEBPM_value = data_low and BRBPMEBPM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_BRBPMEBPM_value = &H0
        flag_BRBPMEBPM        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_bspi_registers_bspi_pio_iodir
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' bspi_registers_BSPI_PIO_IODIR_bspi_pio_dir   [2:0]            get_bspi_registers_BSPI_PIO_IODIR_bspi_pio_dir
''                                                             set_bspi_registers_BSPI_PIO_IODIR_bspi_pio_dir
''                                                             read_bspi_registers_BSPI_PIO_IODIR_bspi_pio_dir
''                                                             write_bspi_registers_BSPI_PIO_IODIR_bspi_pio_dir
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_bspi_registers_bspi_pio_iodir
    Private write_bspi_registers_BSPI_PIO_IODIR_bspi_pio_dir_value
    Private read_bspi_registers_BSPI_PIO_IODIR_bspi_pio_dir_value
    Private flag_bspi_registers_BSPI_PIO_IODIR_bspi_pio_dir

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

    Property Get get_bspi_registers_BSPI_PIO_IODIR_bspi_pio_dir
        get_bspi_registers_BSPI_PIO_IODIR_bspi_pio_dir = read_bspi_registers_BSPI_PIO_IODIR_bspi_pio_dir_value
    End Property

    Property Let set_bspi_registers_BSPI_PIO_IODIR_bspi_pio_dir(aData)
        write_bspi_registers_BSPI_PIO_IODIR_bspi_pio_dir_value = aData
        flag_bspi_registers_BSPI_PIO_IODIR_bspi_pio_dir        = &H1
    End Property

    Property Get read_bspi_registers_BSPI_PIO_IODIR_bspi_pio_dir
        read
        read_bspi_registers_BSPI_PIO_IODIR_bspi_pio_dir = read_bspi_registers_BSPI_PIO_IODIR_bspi_pio_dir_value
    End Property

    Property Let write_bspi_registers_BSPI_PIO_IODIR_bspi_pio_dir(aData)
        set_bspi_registers_BSPI_PIO_IODIR_bspi_pio_dir = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        bspi_registers_BSPI_PIO_IODIR_bspi_pio_dir_mask = &H7
        if data_low > LONG_MAX then
            if bspi_registers_BSPI_PIO_IODIR_bspi_pio_dir_mask = mask then
                read_bspi_registers_BSPI_PIO_IODIR_bspi_pio_dir_value = data_low
            else
                read_bspi_registers_BSPI_PIO_IODIR_bspi_pio_dir_value = (data_low - H8000_0000) and bspi_registers_BSPI_PIO_IODIR_bspi_pio_dir_mask
            end If
        else
            read_bspi_registers_BSPI_PIO_IODIR_bspi_pio_dir_value = data_low and bspi_registers_BSPI_PIO_IODIR_bspi_pio_dir_mask
        end If

    End Sub

    Sub write
        If flag_bspi_registers_BSPI_PIO_IODIR_bspi_pio_dir = &H0 Then read
        If flag_bspi_registers_BSPI_PIO_IODIR_bspi_pio_dir = &H0 Then write_bspi_registers_BSPI_PIO_IODIR_bspi_pio_dir_value = get_bspi_registers_BSPI_PIO_IODIR_bspi_pio_dir

        regValue = leftShift((write_bspi_registers_BSPI_PIO_IODIR_bspi_pio_dir_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        bspi_registers_BSPI_PIO_IODIR_bspi_pio_dir_mask = &H7
        if data_low > LONG_MAX then
            if bspi_registers_BSPI_PIO_IODIR_bspi_pio_dir_mask = mask then
                read_bspi_registers_BSPI_PIO_IODIR_bspi_pio_dir_value = data_low
            else
                read_bspi_registers_BSPI_PIO_IODIR_bspi_pio_dir_value = (data_low - H8000_0000) and bspi_registers_BSPI_PIO_IODIR_bspi_pio_dir_mask
            end If
        else
            read_bspi_registers_BSPI_PIO_IODIR_bspi_pio_dir_value = data_low and bspi_registers_BSPI_PIO_IODIR_bspi_pio_dir_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_bspi_registers_BSPI_PIO_IODIR_bspi_pio_dir_value = &H0
        flag_bspi_registers_BSPI_PIO_IODIR_bspi_pio_dir        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_bspi_registers_bspi_pio_data
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' bspi_registers_BSPI_PIO_DATA_bspi_pio_data   [2:0]            get_bspi_registers_BSPI_PIO_DATA_bspi_pio_data
''                                                             set_bspi_registers_BSPI_PIO_DATA_bspi_pio_data
''                                                             read_bspi_registers_BSPI_PIO_DATA_bspi_pio_data
''                                                             write_bspi_registers_BSPI_PIO_DATA_bspi_pio_data
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_bspi_registers_bspi_pio_data
    Private write_bspi_registers_BSPI_PIO_DATA_bspi_pio_data_value
    Private read_bspi_registers_BSPI_PIO_DATA_bspi_pio_data_value
    Private flag_bspi_registers_BSPI_PIO_DATA_bspi_pio_data

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

    Property Get get_bspi_registers_BSPI_PIO_DATA_bspi_pio_data
        get_bspi_registers_BSPI_PIO_DATA_bspi_pio_data = read_bspi_registers_BSPI_PIO_DATA_bspi_pio_data_value
    End Property

    Property Let set_bspi_registers_BSPI_PIO_DATA_bspi_pio_data(aData)
        write_bspi_registers_BSPI_PIO_DATA_bspi_pio_data_value = aData
        flag_bspi_registers_BSPI_PIO_DATA_bspi_pio_data        = &H1
    End Property

    Property Get read_bspi_registers_BSPI_PIO_DATA_bspi_pio_data
        read
        read_bspi_registers_BSPI_PIO_DATA_bspi_pio_data = read_bspi_registers_BSPI_PIO_DATA_bspi_pio_data_value
    End Property

    Property Let write_bspi_registers_BSPI_PIO_DATA_bspi_pio_data(aData)
        set_bspi_registers_BSPI_PIO_DATA_bspi_pio_data = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        bspi_registers_BSPI_PIO_DATA_bspi_pio_data_mask = &H7
        if data_low > LONG_MAX then
            if bspi_registers_BSPI_PIO_DATA_bspi_pio_data_mask = mask then
                read_bspi_registers_BSPI_PIO_DATA_bspi_pio_data_value = data_low
            else
                read_bspi_registers_BSPI_PIO_DATA_bspi_pio_data_value = (data_low - H8000_0000) and bspi_registers_BSPI_PIO_DATA_bspi_pio_data_mask
            end If
        else
            read_bspi_registers_BSPI_PIO_DATA_bspi_pio_data_value = data_low and bspi_registers_BSPI_PIO_DATA_bspi_pio_data_mask
        end If

    End Sub

    Sub write
        If flag_bspi_registers_BSPI_PIO_DATA_bspi_pio_data = &H0 Then read
        If flag_bspi_registers_BSPI_PIO_DATA_bspi_pio_data = &H0 Then write_bspi_registers_BSPI_PIO_DATA_bspi_pio_data_value = get_bspi_registers_BSPI_PIO_DATA_bspi_pio_data

        regValue = leftShift((write_bspi_registers_BSPI_PIO_DATA_bspi_pio_data_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        bspi_registers_BSPI_PIO_DATA_bspi_pio_data_mask = &H7
        if data_low > LONG_MAX then
            if bspi_registers_BSPI_PIO_DATA_bspi_pio_data_mask = mask then
                read_bspi_registers_BSPI_PIO_DATA_bspi_pio_data_value = data_low
            else
                read_bspi_registers_BSPI_PIO_DATA_bspi_pio_data_value = (data_low - H8000_0000) and bspi_registers_BSPI_PIO_DATA_bspi_pio_data_mask
            end If
        else
            read_bspi_registers_BSPI_PIO_DATA_bspi_pio_data_value = data_low and bspi_registers_BSPI_PIO_DATA_bspi_pio_data_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_bspi_registers_BSPI_PIO_DATA_bspi_pio_data_value = &H0
        flag_bspi_registers_BSPI_PIO_DATA_bspi_pio_data        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_raf_start_addr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' raf_START_ADDR_START_ADDR                  [31:0]           get_raf_START_ADDR_START_ADDR
''                                                             set_raf_START_ADDR_START_ADDR
''                                                             read_raf_START_ADDR_START_ADDR
''                                                             write_raf_START_ADDR_START_ADDR
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_raf_start_addr
    Private write_raf_START_ADDR_START_ADDR_value
    Private read_raf_START_ADDR_START_ADDR_value
    Private flag_raf_START_ADDR_START_ADDR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H100
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_raf_START_ADDR_START_ADDR
        get_raf_START_ADDR_START_ADDR = read_raf_START_ADDR_START_ADDR_value
    End Property

    Property Let set_raf_START_ADDR_START_ADDR(aData)
        write_raf_START_ADDR_START_ADDR_value = aData
        flag_raf_START_ADDR_START_ADDR        = &H1
    End Property

    Property Get read_raf_START_ADDR_START_ADDR
        read
        read_raf_START_ADDR_START_ADDR = read_raf_START_ADDR_START_ADDR_value
    End Property

    Property Let write_raf_START_ADDR_START_ADDR(aData)
        set_raf_START_ADDR_START_ADDR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        raf_START_ADDR_START_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if raf_START_ADDR_START_ADDR_mask = mask then
                read_raf_START_ADDR_START_ADDR_value = data_low
            else
                read_raf_START_ADDR_START_ADDR_value = (data_low - H8000_0000) and raf_START_ADDR_START_ADDR_mask
            end If
        else
            read_raf_START_ADDR_START_ADDR_value = data_low and raf_START_ADDR_START_ADDR_mask
        end If

    End Sub

    Sub write
        If flag_raf_START_ADDR_START_ADDR = &H0 Then read
        If flag_raf_START_ADDR_START_ADDR = &H0 Then write_raf_START_ADDR_START_ADDR_value = get_raf_START_ADDR_START_ADDR

        regValue = leftShift(write_raf_START_ADDR_START_ADDR_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        raf_START_ADDR_START_ADDR_mask = &Hffffffff
        if data_low > LONG_MAX then
            if raf_START_ADDR_START_ADDR_mask = mask then
                read_raf_START_ADDR_START_ADDR_value = data_low
            else
                read_raf_START_ADDR_START_ADDR_value = (data_low - H8000_0000) and raf_START_ADDR_START_ADDR_mask
            end If
        else
            read_raf_START_ADDR_START_ADDR_value = data_low and raf_START_ADDR_START_ADDR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_raf_START_ADDR_START_ADDR_value = &H0
        flag_raf_START_ADDR_START_ADDR        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_raf_num_words
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' raf_NUM_WORDS_NumWords                     [31:0]           get_raf_NUM_WORDS_NumWords
''                                                             set_raf_NUM_WORDS_NumWords
''                                                             read_raf_NUM_WORDS_NumWords
''                                                             write_raf_NUM_WORDS_NumWords
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_raf_num_words
    Private write_raf_NUM_WORDS_NumWords_value
    Private read_raf_NUM_WORDS_NumWords_value
    Private flag_raf_NUM_WORDS_NumWords

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H104
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_raf_NUM_WORDS_NumWords
        get_raf_NUM_WORDS_NumWords = read_raf_NUM_WORDS_NumWords_value
    End Property

    Property Let set_raf_NUM_WORDS_NumWords(aData)
        write_raf_NUM_WORDS_NumWords_value = aData
        flag_raf_NUM_WORDS_NumWords        = &H1
    End Property

    Property Get read_raf_NUM_WORDS_NumWords
        read
        read_raf_NUM_WORDS_NumWords = read_raf_NUM_WORDS_NumWords_value
    End Property

    Property Let write_raf_NUM_WORDS_NumWords(aData)
        set_raf_NUM_WORDS_NumWords = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        raf_NUM_WORDS_NumWords_mask = &Hffffffff
        if data_low > LONG_MAX then
            if raf_NUM_WORDS_NumWords_mask = mask then
                read_raf_NUM_WORDS_NumWords_value = data_low
            else
                read_raf_NUM_WORDS_NumWords_value = (data_low - H8000_0000) and raf_NUM_WORDS_NumWords_mask
            end If
        else
            read_raf_NUM_WORDS_NumWords_value = data_low and raf_NUM_WORDS_NumWords_mask
        end If

    End Sub

    Sub write
        If flag_raf_NUM_WORDS_NumWords = &H0 Then read
        If flag_raf_NUM_WORDS_NumWords = &H0 Then write_raf_NUM_WORDS_NumWords_value = get_raf_NUM_WORDS_NumWords

        regValue = leftShift(write_raf_NUM_WORDS_NumWords_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        raf_NUM_WORDS_NumWords_mask = &Hffffffff
        if data_low > LONG_MAX then
            if raf_NUM_WORDS_NumWords_mask = mask then
                read_raf_NUM_WORDS_NumWords_value = data_low
            else
                read_raf_NUM_WORDS_NumWords_value = (data_low - H8000_0000) and raf_NUM_WORDS_NumWords_mask
            end If
        else
            read_raf_NUM_WORDS_NumWords_value = data_low and raf_NUM_WORDS_NumWords_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_raf_NUM_WORDS_NumWords_value = &H0
        flag_raf_NUM_WORDS_NumWords        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_raf_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' raf_CTRL_CLEAR                             [1:1]            get_raf_CTRL_CLEAR
''                                                             set_raf_CTRL_CLEAR
''                                                             read_raf_CTRL_CLEAR
''                                                             write_raf_CTRL_CLEAR
''---------------------------------------------------------------------------------
'' raf_CTRL_START                             [0:0]            get_raf_CTRL_START
''                                                             set_raf_CTRL_START
''                                                             read_raf_CTRL_START
''                                                             write_raf_CTRL_START
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_raf_ctrl
    Private write_raf_CTRL_CLEAR_value
    Private read_raf_CTRL_CLEAR_value
    Private flag_raf_CTRL_CLEAR
    Private write_raf_CTRL_START_value
    Private read_raf_CTRL_START_value
    Private flag_raf_CTRL_START

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H108
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_raf_CTRL_CLEAR
        get_raf_CTRL_CLEAR = read_raf_CTRL_CLEAR_value
    End Property

    Property Let set_raf_CTRL_CLEAR(aData)
        write_raf_CTRL_CLEAR_value = aData
        flag_raf_CTRL_CLEAR        = &H1
    End Property

    Property Get read_raf_CTRL_CLEAR
        read
        read_raf_CTRL_CLEAR = read_raf_CTRL_CLEAR_value
    End Property

    Property Let write_raf_CTRL_CLEAR(aData)
        set_raf_CTRL_CLEAR = aData
        write
    End Property

    Property Get get_raf_CTRL_START
        get_raf_CTRL_START = read_raf_CTRL_START_value
    End Property

    Property Let set_raf_CTRL_START(aData)
        write_raf_CTRL_START_value = aData
        flag_raf_CTRL_START        = &H1
    End Property

    Property Get read_raf_CTRL_START
        read
        read_raf_CTRL_START = read_raf_CTRL_START_value
    End Property

    Property Let write_raf_CTRL_START(aData)
        set_raf_CTRL_START = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_raf_CTRL_CLEAR_value = rightShift(data_low, 1) and &H1
        raf_CTRL_START_mask = &H1
        if data_low > LONG_MAX then
            if raf_CTRL_START_mask = mask then
                read_raf_CTRL_START_value = data_low
            else
                read_raf_CTRL_START_value = (data_low - H8000_0000) and raf_CTRL_START_mask
            end If
        else
            read_raf_CTRL_START_value = data_low and raf_CTRL_START_mask
        end If

    End Sub

    Sub write
        If flag_raf_CTRL_CLEAR = &H0 or flag_raf_CTRL_START = &H0 Then read
        If flag_raf_CTRL_CLEAR = &H0 Then write_raf_CTRL_CLEAR_value = get_raf_CTRL_CLEAR
        If flag_raf_CTRL_START = &H0 Then write_raf_CTRL_START_value = get_raf_CTRL_START

        regValue = leftShift((write_raf_CTRL_CLEAR_value and &H1), 1) + leftShift((write_raf_CTRL_START_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_raf_CTRL_CLEAR_value = rightShift(data_low, 1) and &H1
        raf_CTRL_START_mask = &H1
        if data_low > LONG_MAX then
            if raf_CTRL_START_mask = mask then
                read_raf_CTRL_START_value = data_low
            else
                read_raf_CTRL_START_value = (data_low - H8000_0000) and raf_CTRL_START_mask
            end If
        else
            read_raf_CTRL_START_value = data_low and raf_CTRL_START_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_raf_CTRL_CLEAR_value = &H0
        flag_raf_CTRL_CLEAR        = &H0
        write_raf_CTRL_START_value = &H0
        flag_raf_CTRL_START        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_raf_fullness
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' raf_FULLNESS_FULLNESS                      [6:0]            get_raf_FULLNESS_FULLNESS
''                                                             set_raf_FULLNESS_FULLNESS
''                                                             read_raf_FULLNESS_FULLNESS
''                                                             write_raf_FULLNESS_FULLNESS
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_raf_fullness
    Private write_raf_FULLNESS_FULLNESS_value
    Private read_raf_FULLNESS_FULLNESS_value
    Private flag_raf_FULLNESS_FULLNESS

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H10c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_raf_FULLNESS_FULLNESS
        get_raf_FULLNESS_FULLNESS = read_raf_FULLNESS_FULLNESS_value
    End Property

    Property Let set_raf_FULLNESS_FULLNESS(aData)
        write_raf_FULLNESS_FULLNESS_value = aData
        flag_raf_FULLNESS_FULLNESS        = &H1
    End Property

    Property Get read_raf_FULLNESS_FULLNESS
        read
        read_raf_FULLNESS_FULLNESS = read_raf_FULLNESS_FULLNESS_value
    End Property

    Property Let write_raf_FULLNESS_FULLNESS(aData)
        set_raf_FULLNESS_FULLNESS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        raf_FULLNESS_FULLNESS_mask = &H7f
        if data_low > LONG_MAX then
            if raf_FULLNESS_FULLNESS_mask = mask then
                read_raf_FULLNESS_FULLNESS_value = data_low
            else
                read_raf_FULLNESS_FULLNESS_value = (data_low - H8000_0000) and raf_FULLNESS_FULLNESS_mask
            end If
        else
            read_raf_FULLNESS_FULLNESS_value = data_low and raf_FULLNESS_FULLNESS_mask
        end If

    End Sub

    Sub write
        If flag_raf_FULLNESS_FULLNESS = &H0 Then read
        If flag_raf_FULLNESS_FULLNESS = &H0 Then write_raf_FULLNESS_FULLNESS_value = get_raf_FULLNESS_FULLNESS

        regValue = leftShift((write_raf_FULLNESS_FULLNESS_value and &H7f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        raf_FULLNESS_FULLNESS_mask = &H7f
        if data_low > LONG_MAX then
            if raf_FULLNESS_FULLNESS_mask = mask then
                read_raf_FULLNESS_FULLNESS_value = data_low
            else
                read_raf_FULLNESS_FULLNESS_value = (data_low - H8000_0000) and raf_FULLNESS_FULLNESS_mask
            end If
        else
            read_raf_FULLNESS_FULLNESS_value = data_low and raf_FULLNESS_FULLNESS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_raf_FULLNESS_FULLNESS_value = &H0
        flag_raf_FULLNESS_FULLNESS        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_raf_watermark
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' raf_WATERMARK_FULLNESS_WATERMARK           [1:0]            get_raf_WATERMARK_FULLNESS_WATERMARK
''                                                             set_raf_WATERMARK_FULLNESS_WATERMARK
''                                                             read_raf_WATERMARK_FULLNESS_WATERMARK
''                                                             write_raf_WATERMARK_FULLNESS_WATERMARK
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_raf_watermark
    Private write_raf_WATERMARK_FULLNESS_WATERMARK_value
    Private read_raf_WATERMARK_FULLNESS_WATERMARK_value
    Private flag_raf_WATERMARK_FULLNESS_WATERMARK

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H110
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_raf_WATERMARK_FULLNESS_WATERMARK
        get_raf_WATERMARK_FULLNESS_WATERMARK = read_raf_WATERMARK_FULLNESS_WATERMARK_value
    End Property

    Property Let set_raf_WATERMARK_FULLNESS_WATERMARK(aData)
        write_raf_WATERMARK_FULLNESS_WATERMARK_value = aData
        flag_raf_WATERMARK_FULLNESS_WATERMARK        = &H1
    End Property

    Property Get read_raf_WATERMARK_FULLNESS_WATERMARK
        read
        read_raf_WATERMARK_FULLNESS_WATERMARK = read_raf_WATERMARK_FULLNESS_WATERMARK_value
    End Property

    Property Let write_raf_WATERMARK_FULLNESS_WATERMARK(aData)
        set_raf_WATERMARK_FULLNESS_WATERMARK = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        raf_WATERMARK_FULLNESS_WATERMARK_mask = &H3
        if data_low > LONG_MAX then
            if raf_WATERMARK_FULLNESS_WATERMARK_mask = mask then
                read_raf_WATERMARK_FULLNESS_WATERMARK_value = data_low
            else
                read_raf_WATERMARK_FULLNESS_WATERMARK_value = (data_low - H8000_0000) and raf_WATERMARK_FULLNESS_WATERMARK_mask
            end If
        else
            read_raf_WATERMARK_FULLNESS_WATERMARK_value = data_low and raf_WATERMARK_FULLNESS_WATERMARK_mask
        end If

    End Sub

    Sub write
        If flag_raf_WATERMARK_FULLNESS_WATERMARK = &H0 Then read
        If flag_raf_WATERMARK_FULLNESS_WATERMARK = &H0 Then write_raf_WATERMARK_FULLNESS_WATERMARK_value = get_raf_WATERMARK_FULLNESS_WATERMARK

        regValue = leftShift((write_raf_WATERMARK_FULLNESS_WATERMARK_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        raf_WATERMARK_FULLNESS_WATERMARK_mask = &H3
        if data_low > LONG_MAX then
            if raf_WATERMARK_FULLNESS_WATERMARK_mask = mask then
                read_raf_WATERMARK_FULLNESS_WATERMARK_value = data_low
            else
                read_raf_WATERMARK_FULLNESS_WATERMARK_value = (data_low - H8000_0000) and raf_WATERMARK_FULLNESS_WATERMARK_mask
            end If
        else
            read_raf_WATERMARK_FULLNESS_WATERMARK_value = data_low and raf_WATERMARK_FULLNESS_WATERMARK_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_raf_WATERMARK_FULLNESS_WATERMARK_value = &H0
        flag_raf_WATERMARK_FULLNESS_WATERMARK        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_raf_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' raf_STATUS_FIFO_FULL                       [2:2]            get_raf_STATUS_FIFO_FULL
''                                                             set_raf_STATUS_FIFO_FULL
''                                                             read_raf_STATUS_FIFO_FULL
''                                                             write_raf_STATUS_FIFO_FULL
''---------------------------------------------------------------------------------
'' raf_STATUS_FIFO_EMPTY                      [1:1]            get_raf_STATUS_FIFO_EMPTY
''                                                             set_raf_STATUS_FIFO_EMPTY
''                                                             read_raf_STATUS_FIFO_EMPTY
''                                                             write_raf_STATUS_FIFO_EMPTY
''---------------------------------------------------------------------------------
'' raf_STATUS_SESSION_BUSY                    [0:0]            get_raf_STATUS_SESSION_BUSY
''                                                             set_raf_STATUS_SESSION_BUSY
''                                                             read_raf_STATUS_SESSION_BUSY
''                                                             write_raf_STATUS_SESSION_BUSY
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_raf_status
    Private write_raf_STATUS_FIFO_FULL_value
    Private read_raf_STATUS_FIFO_FULL_value
    Private flag_raf_STATUS_FIFO_FULL
    Private write_raf_STATUS_FIFO_EMPTY_value
    Private read_raf_STATUS_FIFO_EMPTY_value
    Private flag_raf_STATUS_FIFO_EMPTY
    Private write_raf_STATUS_SESSION_BUSY_value
    Private read_raf_STATUS_SESSION_BUSY_value
    Private flag_raf_STATUS_SESSION_BUSY

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H114
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_raf_STATUS_FIFO_FULL
        get_raf_STATUS_FIFO_FULL = read_raf_STATUS_FIFO_FULL_value
    End Property

    Property Let set_raf_STATUS_FIFO_FULL(aData)
        write_raf_STATUS_FIFO_FULL_value = aData
        flag_raf_STATUS_FIFO_FULL        = &H1
    End Property

    Property Get read_raf_STATUS_FIFO_FULL
        read
        read_raf_STATUS_FIFO_FULL = read_raf_STATUS_FIFO_FULL_value
    End Property

    Property Let write_raf_STATUS_FIFO_FULL(aData)
        set_raf_STATUS_FIFO_FULL = aData
        write
    End Property

    Property Get get_raf_STATUS_FIFO_EMPTY
        get_raf_STATUS_FIFO_EMPTY = read_raf_STATUS_FIFO_EMPTY_value
    End Property

    Property Let set_raf_STATUS_FIFO_EMPTY(aData)
        write_raf_STATUS_FIFO_EMPTY_value = aData
        flag_raf_STATUS_FIFO_EMPTY        = &H1
    End Property

    Property Get read_raf_STATUS_FIFO_EMPTY
        read
        read_raf_STATUS_FIFO_EMPTY = read_raf_STATUS_FIFO_EMPTY_value
    End Property

    Property Let write_raf_STATUS_FIFO_EMPTY(aData)
        set_raf_STATUS_FIFO_EMPTY = aData
        write
    End Property

    Property Get get_raf_STATUS_SESSION_BUSY
        get_raf_STATUS_SESSION_BUSY = read_raf_STATUS_SESSION_BUSY_value
    End Property

    Property Let set_raf_STATUS_SESSION_BUSY(aData)
        write_raf_STATUS_SESSION_BUSY_value = aData
        flag_raf_STATUS_SESSION_BUSY        = &H1
    End Property

    Property Get read_raf_STATUS_SESSION_BUSY
        read
        read_raf_STATUS_SESSION_BUSY = read_raf_STATUS_SESSION_BUSY_value
    End Property

    Property Let write_raf_STATUS_SESSION_BUSY(aData)
        set_raf_STATUS_SESSION_BUSY = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_raf_STATUS_FIFO_FULL_value = rightShift(data_low, 2) and &H1
        read_raf_STATUS_FIFO_EMPTY_value = rightShift(data_low, 1) and &H1
        raf_STATUS_SESSION_BUSY_mask = &H1
        if data_low > LONG_MAX then
            if raf_STATUS_SESSION_BUSY_mask = mask then
                read_raf_STATUS_SESSION_BUSY_value = data_low
            else
                read_raf_STATUS_SESSION_BUSY_value = (data_low - H8000_0000) and raf_STATUS_SESSION_BUSY_mask
            end If
        else
            read_raf_STATUS_SESSION_BUSY_value = data_low and raf_STATUS_SESSION_BUSY_mask
        end If

    End Sub

    Sub write
        If flag_raf_STATUS_FIFO_FULL = &H0 or flag_raf_STATUS_FIFO_EMPTY = &H0 or flag_raf_STATUS_SESSION_BUSY = &H0 Then read
        If flag_raf_STATUS_FIFO_FULL = &H0 Then write_raf_STATUS_FIFO_FULL_value = get_raf_STATUS_FIFO_FULL
        If flag_raf_STATUS_FIFO_EMPTY = &H0 Then write_raf_STATUS_FIFO_EMPTY_value = get_raf_STATUS_FIFO_EMPTY
        If flag_raf_STATUS_SESSION_BUSY = &H0 Then write_raf_STATUS_SESSION_BUSY_value = get_raf_STATUS_SESSION_BUSY

        regValue = leftShift((write_raf_STATUS_FIFO_FULL_value and &H1), 2) + leftShift((write_raf_STATUS_FIFO_EMPTY_value and &H1), 1) + leftShift((write_raf_STATUS_SESSION_BUSY_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_raf_STATUS_FIFO_FULL_value = rightShift(data_low, 2) and &H1
        read_raf_STATUS_FIFO_EMPTY_value = rightShift(data_low, 1) and &H1
        raf_STATUS_SESSION_BUSY_mask = &H1
        if data_low > LONG_MAX then
            if raf_STATUS_SESSION_BUSY_mask = mask then
                read_raf_STATUS_SESSION_BUSY_value = data_low
            else
                read_raf_STATUS_SESSION_BUSY_value = (data_low - H8000_0000) and raf_STATUS_SESSION_BUSY_mask
            end If
        else
            read_raf_STATUS_SESSION_BUSY_value = data_low and raf_STATUS_SESSION_BUSY_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_raf_STATUS_FIFO_FULL_value = &H0
        flag_raf_STATUS_FIFO_FULL        = &H0
        write_raf_STATUS_FIFO_EMPTY_value = &H0
        flag_raf_STATUS_FIFO_EMPTY        = &H0
        write_raf_STATUS_SESSION_BUSY_value = &H0
        flag_raf_STATUS_SESSION_BUSY        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_raf_read_data
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' raf_READ_DATA_DATA                         [31:0]           get_raf_READ_DATA_DATA
''                                                             set_raf_READ_DATA_DATA
''                                                             read_raf_READ_DATA_DATA
''                                                             write_raf_READ_DATA_DATA
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_raf_read_data
    Private write_raf_READ_DATA_DATA_value
    Private read_raf_READ_DATA_DATA_value
    Private flag_raf_READ_DATA_DATA

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H118
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_raf_READ_DATA_DATA
        get_raf_READ_DATA_DATA = read_raf_READ_DATA_DATA_value
    End Property

    Property Let set_raf_READ_DATA_DATA(aData)
        write_raf_READ_DATA_DATA_value = aData
        flag_raf_READ_DATA_DATA        = &H1
    End Property

    Property Get read_raf_READ_DATA_DATA
        read
        read_raf_READ_DATA_DATA = read_raf_READ_DATA_DATA_value
    End Property

    Property Let write_raf_READ_DATA_DATA(aData)
        set_raf_READ_DATA_DATA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        raf_READ_DATA_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if raf_READ_DATA_DATA_mask = mask then
                read_raf_READ_DATA_DATA_value = data_low
            else
                read_raf_READ_DATA_DATA_value = (data_low - H8000_0000) and raf_READ_DATA_DATA_mask
            end If
        else
            read_raf_READ_DATA_DATA_value = data_low and raf_READ_DATA_DATA_mask
        end If

    End Sub

    Sub write
        If flag_raf_READ_DATA_DATA = &H0 Then read
        If flag_raf_READ_DATA_DATA = &H0 Then write_raf_READ_DATA_DATA_value = get_raf_READ_DATA_DATA

        regValue = leftShift(write_raf_READ_DATA_DATA_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        raf_READ_DATA_DATA_mask = &Hffffffff
        if data_low > LONG_MAX then
            if raf_READ_DATA_DATA_mask = mask then
                read_raf_READ_DATA_DATA_value = data_low
            else
                read_raf_READ_DATA_DATA_value = (data_low - H8000_0000) and raf_READ_DATA_DATA_mask
            end If
        else
            read_raf_READ_DATA_DATA_value = data_low and raf_READ_DATA_DATA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_raf_READ_DATA_DATA_value = &H0
        flag_raf_READ_DATA_DATA        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_raf_word_cnt
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' raf_WORD_CNT_CURRENT_WORD_COUNT            [31:0]           get_raf_WORD_CNT_CURRENT_WORD_COUNT
''                                                             set_raf_WORD_CNT_CURRENT_WORD_COUNT
''                                                             read_raf_WORD_CNT_CURRENT_WORD_COUNT
''                                                             write_raf_WORD_CNT_CURRENT_WORD_COUNT
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_raf_word_cnt
    Private write_raf_WORD_CNT_CURRENT_WORD_COUNT_value
    Private read_raf_WORD_CNT_CURRENT_WORD_COUNT_value
    Private flag_raf_WORD_CNT_CURRENT_WORD_COUNT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H11c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_raf_WORD_CNT_CURRENT_WORD_COUNT
        get_raf_WORD_CNT_CURRENT_WORD_COUNT = read_raf_WORD_CNT_CURRENT_WORD_COUNT_value
    End Property

    Property Let set_raf_WORD_CNT_CURRENT_WORD_COUNT(aData)
        write_raf_WORD_CNT_CURRENT_WORD_COUNT_value = aData
        flag_raf_WORD_CNT_CURRENT_WORD_COUNT        = &H1
    End Property

    Property Get read_raf_WORD_CNT_CURRENT_WORD_COUNT
        read
        read_raf_WORD_CNT_CURRENT_WORD_COUNT = read_raf_WORD_CNT_CURRENT_WORD_COUNT_value
    End Property

    Property Let write_raf_WORD_CNT_CURRENT_WORD_COUNT(aData)
        set_raf_WORD_CNT_CURRENT_WORD_COUNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        raf_WORD_CNT_CURRENT_WORD_COUNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if raf_WORD_CNT_CURRENT_WORD_COUNT_mask = mask then
                read_raf_WORD_CNT_CURRENT_WORD_COUNT_value = data_low
            else
                read_raf_WORD_CNT_CURRENT_WORD_COUNT_value = (data_low - H8000_0000) and raf_WORD_CNT_CURRENT_WORD_COUNT_mask
            end If
        else
            read_raf_WORD_CNT_CURRENT_WORD_COUNT_value = data_low and raf_WORD_CNT_CURRENT_WORD_COUNT_mask
        end If

    End Sub

    Sub write
        If flag_raf_WORD_CNT_CURRENT_WORD_COUNT = &H0 Then read
        If flag_raf_WORD_CNT_CURRENT_WORD_COUNT = &H0 Then write_raf_WORD_CNT_CURRENT_WORD_COUNT_value = get_raf_WORD_CNT_CURRENT_WORD_COUNT

        regValue = leftShift(write_raf_WORD_CNT_CURRENT_WORD_COUNT_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        raf_WORD_CNT_CURRENT_WORD_COUNT_mask = &Hffffffff
        if data_low > LONG_MAX then
            if raf_WORD_CNT_CURRENT_WORD_COUNT_mask = mask then
                read_raf_WORD_CNT_CURRENT_WORD_COUNT_value = data_low
            else
                read_raf_WORD_CNT_CURRENT_WORD_COUNT_value = (data_low - H8000_0000) and raf_WORD_CNT_CURRENT_WORD_COUNT_mask
            end If
        else
            read_raf_WORD_CNT_CURRENT_WORD_COUNT_value = data_low and raf_WORD_CNT_CURRENT_WORD_COUNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_raf_WORD_CNT_CURRENT_WORD_COUNT_value = &H0
        flag_raf_WORD_CNT_CURRENT_WORD_COUNT        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_raf_curr_addr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' raf_CURR_ADDR_CURRENT_ADDRESS              [31:0]           get_raf_CURR_ADDR_CURRENT_ADDRESS
''                                                             set_raf_CURR_ADDR_CURRENT_ADDRESS
''                                                             read_raf_CURR_ADDR_CURRENT_ADDRESS
''                                                             write_raf_CURR_ADDR_CURRENT_ADDRESS
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_raf_curr_addr
    Private write_raf_CURR_ADDR_CURRENT_ADDRESS_value
    Private read_raf_CURR_ADDR_CURRENT_ADDRESS_value
    Private flag_raf_CURR_ADDR_CURRENT_ADDRESS

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H120
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_raf_CURR_ADDR_CURRENT_ADDRESS
        get_raf_CURR_ADDR_CURRENT_ADDRESS = read_raf_CURR_ADDR_CURRENT_ADDRESS_value
    End Property

    Property Let set_raf_CURR_ADDR_CURRENT_ADDRESS(aData)
        write_raf_CURR_ADDR_CURRENT_ADDRESS_value = aData
        flag_raf_CURR_ADDR_CURRENT_ADDRESS        = &H1
    End Property

    Property Get read_raf_CURR_ADDR_CURRENT_ADDRESS
        read
        read_raf_CURR_ADDR_CURRENT_ADDRESS = read_raf_CURR_ADDR_CURRENT_ADDRESS_value
    End Property

    Property Let write_raf_CURR_ADDR_CURRENT_ADDRESS(aData)
        set_raf_CURR_ADDR_CURRENT_ADDRESS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        raf_CURR_ADDR_CURRENT_ADDRESS_mask = &Hffffffff
        if data_low > LONG_MAX then
            if raf_CURR_ADDR_CURRENT_ADDRESS_mask = mask then
                read_raf_CURR_ADDR_CURRENT_ADDRESS_value = data_low
            else
                read_raf_CURR_ADDR_CURRENT_ADDRESS_value = (data_low - H8000_0000) and raf_CURR_ADDR_CURRENT_ADDRESS_mask
            end If
        else
            read_raf_CURR_ADDR_CURRENT_ADDRESS_value = data_low and raf_CURR_ADDR_CURRENT_ADDRESS_mask
        end If

    End Sub

    Sub write
        If flag_raf_CURR_ADDR_CURRENT_ADDRESS = &H0 Then read
        If flag_raf_CURR_ADDR_CURRENT_ADDRESS = &H0 Then write_raf_CURR_ADDR_CURRENT_ADDRESS_value = get_raf_CURR_ADDR_CURRENT_ADDRESS

        regValue = leftShift(write_raf_CURR_ADDR_CURRENT_ADDRESS_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        raf_CURR_ADDR_CURRENT_ADDRESS_mask = &Hffffffff
        if data_low > LONG_MAX then
            if raf_CURR_ADDR_CURRENT_ADDRESS_mask = mask then
                read_raf_CURR_ADDR_CURRENT_ADDRESS_value = data_low
            else
                read_raf_CURR_ADDR_CURRENT_ADDRESS_value = (data_low - H8000_0000) and raf_CURR_ADDR_CURRENT_ADDRESS_mask
            end If
        else
            read_raf_CURR_ADDR_CURRENT_ADDRESS_value = data_low and raf_CURR_ADDR_CURRENT_ADDRESS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_raf_CURR_ADDR_CURRENT_ADDRESS_value = &H0
        flag_raf_CURR_ADDR_CURRENT_ADDRESS        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_spcr0_lsb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_SPCR0_LSB_SPBR                        [7:0]            get_mspi_SPCR0_LSB_SPBR
''                                                             set_mspi_SPCR0_LSB_SPBR
''                                                             read_mspi_SPCR0_LSB_SPBR
''                                                             write_mspi_SPCR0_LSB_SPBR
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_spcr0_lsb
    Private write_mspi_SPCR0_LSB_SPBR_value
    Private read_mspi_SPCR0_LSB_SPBR_value
    Private flag_mspi_SPCR0_LSB_SPBR

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H200
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_SPCR0_LSB_SPBR
        get_mspi_SPCR0_LSB_SPBR = read_mspi_SPCR0_LSB_SPBR_value
    End Property

    Property Let set_mspi_SPCR0_LSB_SPBR(aData)
        write_mspi_SPCR0_LSB_SPBR_value = aData
        flag_mspi_SPCR0_LSB_SPBR        = &H1
    End Property

    Property Get read_mspi_SPCR0_LSB_SPBR
        read
        read_mspi_SPCR0_LSB_SPBR = read_mspi_SPCR0_LSB_SPBR_value
    End Property

    Property Let write_mspi_SPCR0_LSB_SPBR(aData)
        set_mspi_SPCR0_LSB_SPBR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_SPCR0_LSB_SPBR_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_SPCR0_LSB_SPBR_mask = mask then
                read_mspi_SPCR0_LSB_SPBR_value = data_low
            else
                read_mspi_SPCR0_LSB_SPBR_value = (data_low - H8000_0000) and mspi_SPCR0_LSB_SPBR_mask
            end If
        else
            read_mspi_SPCR0_LSB_SPBR_value = data_low and mspi_SPCR0_LSB_SPBR_mask
        end If

    End Sub

    Sub write
        If flag_mspi_SPCR0_LSB_SPBR = &H0 Then read
        If flag_mspi_SPCR0_LSB_SPBR = &H0 Then write_mspi_SPCR0_LSB_SPBR_value = get_mspi_SPCR0_LSB_SPBR

        regValue = leftShift((write_mspi_SPCR0_LSB_SPBR_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_SPCR0_LSB_SPBR_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_SPCR0_LSB_SPBR_mask = mask then
                read_mspi_SPCR0_LSB_SPBR_value = data_low
            else
                read_mspi_SPCR0_LSB_SPBR_value = (data_low - H8000_0000) and mspi_SPCR0_LSB_SPBR_mask
            end If
        else
            read_mspi_SPCR0_LSB_SPBR_value = data_low and mspi_SPCR0_LSB_SPBR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_SPCR0_LSB_SPBR_value = &H0
        flag_mspi_SPCR0_LSB_SPBR        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_spcr0_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_SPCR0_MSB_MSTR                        [7:7]            get_mspi_SPCR0_MSB_MSTR
''                                                             set_mspi_SPCR0_MSB_MSTR
''                                                             read_mspi_SPCR0_MSB_MSTR
''                                                             write_mspi_SPCR0_MSB_MSTR
''---------------------------------------------------------------------------------
'' mspi_SPCR0_MSB_StartTransDelay             [6:6]            get_mspi_SPCR0_MSB_StartTransDelay
''                                                             set_mspi_SPCR0_MSB_StartTransDelay
''                                                             read_mspi_SPCR0_MSB_StartTransDelay
''                                                             write_mspi_SPCR0_MSB_StartTransDelay
''---------------------------------------------------------------------------------
'' mspi_SPCR0_MSB_BitS                        [5:2]            get_mspi_SPCR0_MSB_BitS
''                                                             set_mspi_SPCR0_MSB_BitS
''                                                             read_mspi_SPCR0_MSB_BitS
''                                                             write_mspi_SPCR0_MSB_BitS
''---------------------------------------------------------------------------------
'' mspi_SPCR0_MSB_CPOL                        [1:1]            get_mspi_SPCR0_MSB_CPOL
''                                                             set_mspi_SPCR0_MSB_CPOL
''                                                             read_mspi_SPCR0_MSB_CPOL
''                                                             write_mspi_SPCR0_MSB_CPOL
''---------------------------------------------------------------------------------
'' mspi_SPCR0_MSB_CPHA                        [0:0]            get_mspi_SPCR0_MSB_CPHA
''                                                             set_mspi_SPCR0_MSB_CPHA
''                                                             read_mspi_SPCR0_MSB_CPHA
''                                                             write_mspi_SPCR0_MSB_CPHA
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_spcr0_msb
    Private write_mspi_SPCR0_MSB_MSTR_value
    Private read_mspi_SPCR0_MSB_MSTR_value
    Private flag_mspi_SPCR0_MSB_MSTR
    Private write_mspi_SPCR0_MSB_StartTransDelay_value
    Private read_mspi_SPCR0_MSB_StartTransDelay_value
    Private flag_mspi_SPCR0_MSB_StartTransDelay
    Private write_mspi_SPCR0_MSB_BitS_value
    Private read_mspi_SPCR0_MSB_BitS_value
    Private flag_mspi_SPCR0_MSB_BitS
    Private write_mspi_SPCR0_MSB_CPOL_value
    Private read_mspi_SPCR0_MSB_CPOL_value
    Private flag_mspi_SPCR0_MSB_CPOL
    Private write_mspi_SPCR0_MSB_CPHA_value
    Private read_mspi_SPCR0_MSB_CPHA_value
    Private flag_mspi_SPCR0_MSB_CPHA

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H204
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_SPCR0_MSB_MSTR
        get_mspi_SPCR0_MSB_MSTR = read_mspi_SPCR0_MSB_MSTR_value
    End Property

    Property Let set_mspi_SPCR0_MSB_MSTR(aData)
        write_mspi_SPCR0_MSB_MSTR_value = aData
        flag_mspi_SPCR0_MSB_MSTR        = &H1
    End Property

    Property Get read_mspi_SPCR0_MSB_MSTR
        read
        read_mspi_SPCR0_MSB_MSTR = read_mspi_SPCR0_MSB_MSTR_value
    End Property

    Property Let write_mspi_SPCR0_MSB_MSTR(aData)
        set_mspi_SPCR0_MSB_MSTR = aData
        write
    End Property

    Property Get get_mspi_SPCR0_MSB_StartTransDelay
        get_mspi_SPCR0_MSB_StartTransDelay = read_mspi_SPCR0_MSB_StartTransDelay_value
    End Property

    Property Let set_mspi_SPCR0_MSB_StartTransDelay(aData)
        write_mspi_SPCR0_MSB_StartTransDelay_value = aData
        flag_mspi_SPCR0_MSB_StartTransDelay        = &H1
    End Property

    Property Get read_mspi_SPCR0_MSB_StartTransDelay
        read
        read_mspi_SPCR0_MSB_StartTransDelay = read_mspi_SPCR0_MSB_StartTransDelay_value
    End Property

    Property Let write_mspi_SPCR0_MSB_StartTransDelay(aData)
        set_mspi_SPCR0_MSB_StartTransDelay = aData
        write
    End Property

    Property Get get_mspi_SPCR0_MSB_BitS
        get_mspi_SPCR0_MSB_BitS = read_mspi_SPCR0_MSB_BitS_value
    End Property

    Property Let set_mspi_SPCR0_MSB_BitS(aData)
        write_mspi_SPCR0_MSB_BitS_value = aData
        flag_mspi_SPCR0_MSB_BitS        = &H1
    End Property

    Property Get read_mspi_SPCR0_MSB_BitS
        read
        read_mspi_SPCR0_MSB_BitS = read_mspi_SPCR0_MSB_BitS_value
    End Property

    Property Let write_mspi_SPCR0_MSB_BitS(aData)
        set_mspi_SPCR0_MSB_BitS = aData
        write
    End Property

    Property Get get_mspi_SPCR0_MSB_CPOL
        get_mspi_SPCR0_MSB_CPOL = read_mspi_SPCR0_MSB_CPOL_value
    End Property

    Property Let set_mspi_SPCR0_MSB_CPOL(aData)
        write_mspi_SPCR0_MSB_CPOL_value = aData
        flag_mspi_SPCR0_MSB_CPOL        = &H1
    End Property

    Property Get read_mspi_SPCR0_MSB_CPOL
        read
        read_mspi_SPCR0_MSB_CPOL = read_mspi_SPCR0_MSB_CPOL_value
    End Property

    Property Let write_mspi_SPCR0_MSB_CPOL(aData)
        set_mspi_SPCR0_MSB_CPOL = aData
        write
    End Property

    Property Get get_mspi_SPCR0_MSB_CPHA
        get_mspi_SPCR0_MSB_CPHA = read_mspi_SPCR0_MSB_CPHA_value
    End Property

    Property Let set_mspi_SPCR0_MSB_CPHA(aData)
        write_mspi_SPCR0_MSB_CPHA_value = aData
        flag_mspi_SPCR0_MSB_CPHA        = &H1
    End Property

    Property Get read_mspi_SPCR0_MSB_CPHA
        read
        read_mspi_SPCR0_MSB_CPHA = read_mspi_SPCR0_MSB_CPHA_value
    End Property

    Property Let write_mspi_SPCR0_MSB_CPHA(aData)
        set_mspi_SPCR0_MSB_CPHA = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mspi_SPCR0_MSB_MSTR_value = rightShift(data_low, 7) and &H1
        read_mspi_SPCR0_MSB_StartTransDelay_value = rightShift(data_low, 6) and &H1
        read_mspi_SPCR0_MSB_BitS_value = rightShift(data_low, 2) and &Hf
        read_mspi_SPCR0_MSB_CPOL_value = rightShift(data_low, 1) and &H1
        mspi_SPCR0_MSB_CPHA_mask = &H1
        if data_low > LONG_MAX then
            if mspi_SPCR0_MSB_CPHA_mask = mask then
                read_mspi_SPCR0_MSB_CPHA_value = data_low
            else
                read_mspi_SPCR0_MSB_CPHA_value = (data_low - H8000_0000) and mspi_SPCR0_MSB_CPHA_mask
            end If
        else
            read_mspi_SPCR0_MSB_CPHA_value = data_low and mspi_SPCR0_MSB_CPHA_mask
        end If

    End Sub

    Sub write
        If flag_mspi_SPCR0_MSB_MSTR = &H0 or flag_mspi_SPCR0_MSB_StartTransDelay = &H0 or flag_mspi_SPCR0_MSB_BitS = &H0 or flag_mspi_SPCR0_MSB_CPOL = &H0 or flag_mspi_SPCR0_MSB_CPHA = &H0 Then read
        If flag_mspi_SPCR0_MSB_MSTR = &H0 Then write_mspi_SPCR0_MSB_MSTR_value = get_mspi_SPCR0_MSB_MSTR
        If flag_mspi_SPCR0_MSB_StartTransDelay = &H0 Then write_mspi_SPCR0_MSB_StartTransDelay_value = get_mspi_SPCR0_MSB_StartTransDelay
        If flag_mspi_SPCR0_MSB_BitS = &H0 Then write_mspi_SPCR0_MSB_BitS_value = get_mspi_SPCR0_MSB_BitS
        If flag_mspi_SPCR0_MSB_CPOL = &H0 Then write_mspi_SPCR0_MSB_CPOL_value = get_mspi_SPCR0_MSB_CPOL
        If flag_mspi_SPCR0_MSB_CPHA = &H0 Then write_mspi_SPCR0_MSB_CPHA_value = get_mspi_SPCR0_MSB_CPHA

        regValue = leftShift((write_mspi_SPCR0_MSB_MSTR_value and &H1), 7) + leftShift((write_mspi_SPCR0_MSB_StartTransDelay_value and &H1), 6) + leftShift((write_mspi_SPCR0_MSB_BitS_value and &Hf), 2) + leftShift((write_mspi_SPCR0_MSB_CPOL_value and &H1), 1) + leftShift((write_mspi_SPCR0_MSB_CPHA_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mspi_SPCR0_MSB_MSTR_value = rightShift(data_low, 7) and &H1
        read_mspi_SPCR0_MSB_StartTransDelay_value = rightShift(data_low, 6) and &H1
        read_mspi_SPCR0_MSB_BitS_value = rightShift(data_low, 2) and &Hf
        read_mspi_SPCR0_MSB_CPOL_value = rightShift(data_low, 1) and &H1
        mspi_SPCR0_MSB_CPHA_mask = &H1
        if data_low > LONG_MAX then
            if mspi_SPCR0_MSB_CPHA_mask = mask then
                read_mspi_SPCR0_MSB_CPHA_value = data_low
            else
                read_mspi_SPCR0_MSB_CPHA_value = (data_low - H8000_0000) and mspi_SPCR0_MSB_CPHA_mask
            end If
        else
            read_mspi_SPCR0_MSB_CPHA_value = data_low and mspi_SPCR0_MSB_CPHA_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_SPCR0_MSB_MSTR_value = &H0
        flag_mspi_SPCR0_MSB_MSTR        = &H0
        write_mspi_SPCR0_MSB_StartTransDelay_value = &H0
        flag_mspi_SPCR0_MSB_StartTransDelay        = &H0
        write_mspi_SPCR0_MSB_BitS_value = &H0
        flag_mspi_SPCR0_MSB_BitS        = &H0
        write_mspi_SPCR0_MSB_CPOL_value = &H0
        flag_mspi_SPCR0_MSB_CPOL        = &H0
        write_mspi_SPCR0_MSB_CPHA_value = &H0
        flag_mspi_SPCR0_MSB_CPHA        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_spcr1_lsb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_SPCR1_LSB_DTL                         [7:0]            get_mspi_SPCR1_LSB_DTL
''                                                             set_mspi_SPCR1_LSB_DTL
''                                                             read_mspi_SPCR1_LSB_DTL
''                                                             write_mspi_SPCR1_LSB_DTL
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_spcr1_lsb
    Private write_mspi_SPCR1_LSB_DTL_value
    Private read_mspi_SPCR1_LSB_DTL_value
    Private flag_mspi_SPCR1_LSB_DTL

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H208
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_SPCR1_LSB_DTL
        get_mspi_SPCR1_LSB_DTL = read_mspi_SPCR1_LSB_DTL_value
    End Property

    Property Let set_mspi_SPCR1_LSB_DTL(aData)
        write_mspi_SPCR1_LSB_DTL_value = aData
        flag_mspi_SPCR1_LSB_DTL        = &H1
    End Property

    Property Get read_mspi_SPCR1_LSB_DTL
        read
        read_mspi_SPCR1_LSB_DTL = read_mspi_SPCR1_LSB_DTL_value
    End Property

    Property Let write_mspi_SPCR1_LSB_DTL(aData)
        set_mspi_SPCR1_LSB_DTL = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_SPCR1_LSB_DTL_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_SPCR1_LSB_DTL_mask = mask then
                read_mspi_SPCR1_LSB_DTL_value = data_low
            else
                read_mspi_SPCR1_LSB_DTL_value = (data_low - H8000_0000) and mspi_SPCR1_LSB_DTL_mask
            end If
        else
            read_mspi_SPCR1_LSB_DTL_value = data_low and mspi_SPCR1_LSB_DTL_mask
        end If

    End Sub

    Sub write
        If flag_mspi_SPCR1_LSB_DTL = &H0 Then read
        If flag_mspi_SPCR1_LSB_DTL = &H0 Then write_mspi_SPCR1_LSB_DTL_value = get_mspi_SPCR1_LSB_DTL

        regValue = leftShift((write_mspi_SPCR1_LSB_DTL_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_SPCR1_LSB_DTL_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_SPCR1_LSB_DTL_mask = mask then
                read_mspi_SPCR1_LSB_DTL_value = data_low
            else
                read_mspi_SPCR1_LSB_DTL_value = (data_low - H8000_0000) and mspi_SPCR1_LSB_DTL_mask
            end If
        else
            read_mspi_SPCR1_LSB_DTL_value = data_low and mspi_SPCR1_LSB_DTL_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_SPCR1_LSB_DTL_value = &H0
        flag_mspi_SPCR1_LSB_DTL        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_spcr1_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_SPCR1_MSB_RDSCLK                      [7:0]            get_mspi_SPCR1_MSB_RDSCLK
''                                                             set_mspi_SPCR1_MSB_RDSCLK
''                                                             read_mspi_SPCR1_MSB_RDSCLK
''                                                             write_mspi_SPCR1_MSB_RDSCLK
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_spcr1_msb
    Private write_mspi_SPCR1_MSB_RDSCLK_value
    Private read_mspi_SPCR1_MSB_RDSCLK_value
    Private flag_mspi_SPCR1_MSB_RDSCLK

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H20c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_SPCR1_MSB_RDSCLK
        get_mspi_SPCR1_MSB_RDSCLK = read_mspi_SPCR1_MSB_RDSCLK_value
    End Property

    Property Let set_mspi_SPCR1_MSB_RDSCLK(aData)
        write_mspi_SPCR1_MSB_RDSCLK_value = aData
        flag_mspi_SPCR1_MSB_RDSCLK        = &H1
    End Property

    Property Get read_mspi_SPCR1_MSB_RDSCLK
        read
        read_mspi_SPCR1_MSB_RDSCLK = read_mspi_SPCR1_MSB_RDSCLK_value
    End Property

    Property Let write_mspi_SPCR1_MSB_RDSCLK(aData)
        set_mspi_SPCR1_MSB_RDSCLK = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_SPCR1_MSB_RDSCLK_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_SPCR1_MSB_RDSCLK_mask = mask then
                read_mspi_SPCR1_MSB_RDSCLK_value = data_low
            else
                read_mspi_SPCR1_MSB_RDSCLK_value = (data_low - H8000_0000) and mspi_SPCR1_MSB_RDSCLK_mask
            end If
        else
            read_mspi_SPCR1_MSB_RDSCLK_value = data_low and mspi_SPCR1_MSB_RDSCLK_mask
        end If

    End Sub

    Sub write
        If flag_mspi_SPCR1_MSB_RDSCLK = &H0 Then read
        If flag_mspi_SPCR1_MSB_RDSCLK = &H0 Then write_mspi_SPCR1_MSB_RDSCLK_value = get_mspi_SPCR1_MSB_RDSCLK

        regValue = leftShift((write_mspi_SPCR1_MSB_RDSCLK_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_SPCR1_MSB_RDSCLK_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_SPCR1_MSB_RDSCLK_mask = mask then
                read_mspi_SPCR1_MSB_RDSCLK_value = data_low
            else
                read_mspi_SPCR1_MSB_RDSCLK_value = (data_low - H8000_0000) and mspi_SPCR1_MSB_RDSCLK_mask
            end If
        else
            read_mspi_SPCR1_MSB_RDSCLK_value = data_low and mspi_SPCR1_MSB_RDSCLK_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_SPCR1_MSB_RDSCLK_value = &H0
        flag_mspi_SPCR1_MSB_RDSCLK        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_newqp
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_NEWQP_newqp                           [3:0]            get_mspi_NEWQP_newqp
''                                                             set_mspi_NEWQP_newqp
''                                                             read_mspi_NEWQP_newqp
''                                                             write_mspi_NEWQP_newqp
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_newqp
    Private write_mspi_NEWQP_newqp_value
    Private read_mspi_NEWQP_newqp_value
    Private flag_mspi_NEWQP_newqp

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H210
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_NEWQP_newqp
        get_mspi_NEWQP_newqp = read_mspi_NEWQP_newqp_value
    End Property

    Property Let set_mspi_NEWQP_newqp(aData)
        write_mspi_NEWQP_newqp_value = aData
        flag_mspi_NEWQP_newqp        = &H1
    End Property

    Property Get read_mspi_NEWQP_newqp
        read
        read_mspi_NEWQP_newqp = read_mspi_NEWQP_newqp_value
    End Property

    Property Let write_mspi_NEWQP_newqp(aData)
        set_mspi_NEWQP_newqp = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_NEWQP_newqp_mask = &Hf
        if data_low > LONG_MAX then
            if mspi_NEWQP_newqp_mask = mask then
                read_mspi_NEWQP_newqp_value = data_low
            else
                read_mspi_NEWQP_newqp_value = (data_low - H8000_0000) and mspi_NEWQP_newqp_mask
            end If
        else
            read_mspi_NEWQP_newqp_value = data_low and mspi_NEWQP_newqp_mask
        end If

    End Sub

    Sub write
        If flag_mspi_NEWQP_newqp = &H0 Then read
        If flag_mspi_NEWQP_newqp = &H0 Then write_mspi_NEWQP_newqp_value = get_mspi_NEWQP_newqp

        regValue = leftShift((write_mspi_NEWQP_newqp_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_NEWQP_newqp_mask = &Hf
        if data_low > LONG_MAX then
            if mspi_NEWQP_newqp_mask = mask then
                read_mspi_NEWQP_newqp_value = data_low
            else
                read_mspi_NEWQP_newqp_value = (data_low - H8000_0000) and mspi_NEWQP_newqp_mask
            end If
        else
            read_mspi_NEWQP_newqp_value = data_low and mspi_NEWQP_newqp_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_NEWQP_newqp_value = &H0
        flag_mspi_NEWQP_newqp        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_endqp
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_ENDQP_endqp                           [3:0]            get_mspi_ENDQP_endqp
''                                                             set_mspi_ENDQP_endqp
''                                                             read_mspi_ENDQP_endqp
''                                                             write_mspi_ENDQP_endqp
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_endqp
    Private write_mspi_ENDQP_endqp_value
    Private read_mspi_ENDQP_endqp_value
    Private flag_mspi_ENDQP_endqp

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H214
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_ENDQP_endqp
        get_mspi_ENDQP_endqp = read_mspi_ENDQP_endqp_value
    End Property

    Property Let set_mspi_ENDQP_endqp(aData)
        write_mspi_ENDQP_endqp_value = aData
        flag_mspi_ENDQP_endqp        = &H1
    End Property

    Property Get read_mspi_ENDQP_endqp
        read
        read_mspi_ENDQP_endqp = read_mspi_ENDQP_endqp_value
    End Property

    Property Let write_mspi_ENDQP_endqp(aData)
        set_mspi_ENDQP_endqp = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_ENDQP_endqp_mask = &Hf
        if data_low > LONG_MAX then
            if mspi_ENDQP_endqp_mask = mask then
                read_mspi_ENDQP_endqp_value = data_low
            else
                read_mspi_ENDQP_endqp_value = (data_low - H8000_0000) and mspi_ENDQP_endqp_mask
            end If
        else
            read_mspi_ENDQP_endqp_value = data_low and mspi_ENDQP_endqp_mask
        end If

    End Sub

    Sub write
        If flag_mspi_ENDQP_endqp = &H0 Then read
        If flag_mspi_ENDQP_endqp = &H0 Then write_mspi_ENDQP_endqp_value = get_mspi_ENDQP_endqp

        regValue = leftShift((write_mspi_ENDQP_endqp_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_ENDQP_endqp_mask = &Hf
        if data_low > LONG_MAX then
            if mspi_ENDQP_endqp_mask = mask then
                read_mspi_ENDQP_endqp_value = data_low
            else
                read_mspi_ENDQP_endqp_value = (data_low - H8000_0000) and mspi_ENDQP_endqp_mask
            end If
        else
            read_mspi_ENDQP_endqp_value = data_low and mspi_ENDQP_endqp_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_ENDQP_endqp_value = &H0
        flag_mspi_ENDQP_endqp        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_spcr2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_SPCR2_cont_after_cmd                  [7:7]            get_mspi_SPCR2_cont_after_cmd
''                                                             set_mspi_SPCR2_cont_after_cmd
''                                                             read_mspi_SPCR2_cont_after_cmd
''                                                             write_mspi_SPCR2_cont_after_cmd
''---------------------------------------------------------------------------------
'' mspi_SPCR2_spe                             [6:6]            get_mspi_SPCR2_spe
''                                                             set_mspi_SPCR2_spe
''                                                             read_mspi_SPCR2_spe
''                                                             write_mspi_SPCR2_spe
''---------------------------------------------------------------------------------
'' mspi_SPCR2_spifie                          [5:5]            get_mspi_SPCR2_spifie
''                                                             set_mspi_SPCR2_spifie
''                                                             read_mspi_SPCR2_spifie
''                                                             write_mspi_SPCR2_spifie
''---------------------------------------------------------------------------------
'' mspi_SPCR2_wren                            [4:4]            get_mspi_SPCR2_wren
''                                                             set_mspi_SPCR2_wren
''                                                             read_mspi_SPCR2_wren
''                                                             write_mspi_SPCR2_wren
''---------------------------------------------------------------------------------
'' mspi_SPCR2_wrt0                            [3:3]            get_mspi_SPCR2_wrt0
''                                                             set_mspi_SPCR2_wrt0
''                                                             read_mspi_SPCR2_wrt0
''                                                             write_mspi_SPCR2_wrt0
''---------------------------------------------------------------------------------
'' mspi_SPCR2_loopq                           [2:2]            get_mspi_SPCR2_loopq
''                                                             set_mspi_SPCR2_loopq
''                                                             read_mspi_SPCR2_loopq
''                                                             write_mspi_SPCR2_loopq
''---------------------------------------------------------------------------------
'' mspi_SPCR2_hie                             [1:1]            get_mspi_SPCR2_hie
''                                                             set_mspi_SPCR2_hie
''                                                             read_mspi_SPCR2_hie
''                                                             write_mspi_SPCR2_hie
''---------------------------------------------------------------------------------
'' mspi_SPCR2_halt                            [0:0]            get_mspi_SPCR2_halt
''                                                             set_mspi_SPCR2_halt
''                                                             read_mspi_SPCR2_halt
''                                                             write_mspi_SPCR2_halt
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_spcr2
    Private write_mspi_SPCR2_cont_after_cmd_value
    Private read_mspi_SPCR2_cont_after_cmd_value
    Private flag_mspi_SPCR2_cont_after_cmd
    Private write_mspi_SPCR2_spe_value
    Private read_mspi_SPCR2_spe_value
    Private flag_mspi_SPCR2_spe
    Private write_mspi_SPCR2_spifie_value
    Private read_mspi_SPCR2_spifie_value
    Private flag_mspi_SPCR2_spifie
    Private write_mspi_SPCR2_wren_value
    Private read_mspi_SPCR2_wren_value
    Private flag_mspi_SPCR2_wren
    Private write_mspi_SPCR2_wrt0_value
    Private read_mspi_SPCR2_wrt0_value
    Private flag_mspi_SPCR2_wrt0
    Private write_mspi_SPCR2_loopq_value
    Private read_mspi_SPCR2_loopq_value
    Private flag_mspi_SPCR2_loopq
    Private write_mspi_SPCR2_hie_value
    Private read_mspi_SPCR2_hie_value
    Private flag_mspi_SPCR2_hie
    Private write_mspi_SPCR2_halt_value
    Private read_mspi_SPCR2_halt_value
    Private flag_mspi_SPCR2_halt

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H218
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_SPCR2_cont_after_cmd
        get_mspi_SPCR2_cont_after_cmd = read_mspi_SPCR2_cont_after_cmd_value
    End Property

    Property Let set_mspi_SPCR2_cont_after_cmd(aData)
        write_mspi_SPCR2_cont_after_cmd_value = aData
        flag_mspi_SPCR2_cont_after_cmd        = &H1
    End Property

    Property Get read_mspi_SPCR2_cont_after_cmd
        read
        read_mspi_SPCR2_cont_after_cmd = read_mspi_SPCR2_cont_after_cmd_value
    End Property

    Property Let write_mspi_SPCR2_cont_after_cmd(aData)
        set_mspi_SPCR2_cont_after_cmd = aData
        write
    End Property

    Property Get get_mspi_SPCR2_spe
        get_mspi_SPCR2_spe = read_mspi_SPCR2_spe_value
    End Property

    Property Let set_mspi_SPCR2_spe(aData)
        write_mspi_SPCR2_spe_value = aData
        flag_mspi_SPCR2_spe        = &H1
    End Property

    Property Get read_mspi_SPCR2_spe
        read
        read_mspi_SPCR2_spe = read_mspi_SPCR2_spe_value
    End Property

    Property Let write_mspi_SPCR2_spe(aData)
        set_mspi_SPCR2_spe = aData
        write
    End Property

    Property Get get_mspi_SPCR2_spifie
        get_mspi_SPCR2_spifie = read_mspi_SPCR2_spifie_value
    End Property

    Property Let set_mspi_SPCR2_spifie(aData)
        write_mspi_SPCR2_spifie_value = aData
        flag_mspi_SPCR2_spifie        = &H1
    End Property

    Property Get read_mspi_SPCR2_spifie
        read
        read_mspi_SPCR2_spifie = read_mspi_SPCR2_spifie_value
    End Property

    Property Let write_mspi_SPCR2_spifie(aData)
        set_mspi_SPCR2_spifie = aData
        write
    End Property

    Property Get get_mspi_SPCR2_wren
        get_mspi_SPCR2_wren = read_mspi_SPCR2_wren_value
    End Property

    Property Let set_mspi_SPCR2_wren(aData)
        write_mspi_SPCR2_wren_value = aData
        flag_mspi_SPCR2_wren        = &H1
    End Property

    Property Get read_mspi_SPCR2_wren
        read
        read_mspi_SPCR2_wren = read_mspi_SPCR2_wren_value
    End Property

    Property Let write_mspi_SPCR2_wren(aData)
        set_mspi_SPCR2_wren = aData
        write
    End Property

    Property Get get_mspi_SPCR2_wrt0
        get_mspi_SPCR2_wrt0 = read_mspi_SPCR2_wrt0_value
    End Property

    Property Let set_mspi_SPCR2_wrt0(aData)
        write_mspi_SPCR2_wrt0_value = aData
        flag_mspi_SPCR2_wrt0        = &H1
    End Property

    Property Get read_mspi_SPCR2_wrt0
        read
        read_mspi_SPCR2_wrt0 = read_mspi_SPCR2_wrt0_value
    End Property

    Property Let write_mspi_SPCR2_wrt0(aData)
        set_mspi_SPCR2_wrt0 = aData
        write
    End Property

    Property Get get_mspi_SPCR2_loopq
        get_mspi_SPCR2_loopq = read_mspi_SPCR2_loopq_value
    End Property

    Property Let set_mspi_SPCR2_loopq(aData)
        write_mspi_SPCR2_loopq_value = aData
        flag_mspi_SPCR2_loopq        = &H1
    End Property

    Property Get read_mspi_SPCR2_loopq
        read
        read_mspi_SPCR2_loopq = read_mspi_SPCR2_loopq_value
    End Property

    Property Let write_mspi_SPCR2_loopq(aData)
        set_mspi_SPCR2_loopq = aData
        write
    End Property

    Property Get get_mspi_SPCR2_hie
        get_mspi_SPCR2_hie = read_mspi_SPCR2_hie_value
    End Property

    Property Let set_mspi_SPCR2_hie(aData)
        write_mspi_SPCR2_hie_value = aData
        flag_mspi_SPCR2_hie        = &H1
    End Property

    Property Get read_mspi_SPCR2_hie
        read
        read_mspi_SPCR2_hie = read_mspi_SPCR2_hie_value
    End Property

    Property Let write_mspi_SPCR2_hie(aData)
        set_mspi_SPCR2_hie = aData
        write
    End Property

    Property Get get_mspi_SPCR2_halt
        get_mspi_SPCR2_halt = read_mspi_SPCR2_halt_value
    End Property

    Property Let set_mspi_SPCR2_halt(aData)
        write_mspi_SPCR2_halt_value = aData
        flag_mspi_SPCR2_halt        = &H1
    End Property

    Property Get read_mspi_SPCR2_halt
        read
        read_mspi_SPCR2_halt = read_mspi_SPCR2_halt_value
    End Property

    Property Let write_mspi_SPCR2_halt(aData)
        set_mspi_SPCR2_halt = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mspi_SPCR2_cont_after_cmd_value = rightShift(data_low, 7) and &H1
        read_mspi_SPCR2_spe_value = rightShift(data_low, 6) and &H1
        read_mspi_SPCR2_spifie_value = rightShift(data_low, 5) and &H1
        read_mspi_SPCR2_wren_value = rightShift(data_low, 4) and &H1
        read_mspi_SPCR2_wrt0_value = rightShift(data_low, 3) and &H1
        read_mspi_SPCR2_loopq_value = rightShift(data_low, 2) and &H1
        read_mspi_SPCR2_hie_value = rightShift(data_low, 1) and &H1
        mspi_SPCR2_halt_mask = &H1
        if data_low > LONG_MAX then
            if mspi_SPCR2_halt_mask = mask then
                read_mspi_SPCR2_halt_value = data_low
            else
                read_mspi_SPCR2_halt_value = (data_low - H8000_0000) and mspi_SPCR2_halt_mask
            end If
        else
            read_mspi_SPCR2_halt_value = data_low and mspi_SPCR2_halt_mask
        end If

    End Sub

    Sub write
        If flag_mspi_SPCR2_cont_after_cmd = &H0 or flag_mspi_SPCR2_spe = &H0 or flag_mspi_SPCR2_spifie = &H0 or flag_mspi_SPCR2_wren = &H0 or flag_mspi_SPCR2_wrt0 = &H0 or flag_mspi_SPCR2_loopq = &H0 or flag_mspi_SPCR2_hie = &H0 or flag_mspi_SPCR2_halt = &H0 Then read
        If flag_mspi_SPCR2_cont_after_cmd = &H0 Then write_mspi_SPCR2_cont_after_cmd_value = get_mspi_SPCR2_cont_after_cmd
        If flag_mspi_SPCR2_spe = &H0 Then write_mspi_SPCR2_spe_value = get_mspi_SPCR2_spe
        If flag_mspi_SPCR2_spifie = &H0 Then write_mspi_SPCR2_spifie_value = get_mspi_SPCR2_spifie
        If flag_mspi_SPCR2_wren = &H0 Then write_mspi_SPCR2_wren_value = get_mspi_SPCR2_wren
        If flag_mspi_SPCR2_wrt0 = &H0 Then write_mspi_SPCR2_wrt0_value = get_mspi_SPCR2_wrt0
        If flag_mspi_SPCR2_loopq = &H0 Then write_mspi_SPCR2_loopq_value = get_mspi_SPCR2_loopq
        If flag_mspi_SPCR2_hie = &H0 Then write_mspi_SPCR2_hie_value = get_mspi_SPCR2_hie
        If flag_mspi_SPCR2_halt = &H0 Then write_mspi_SPCR2_halt_value = get_mspi_SPCR2_halt

        regValue = leftShift((write_mspi_SPCR2_cont_after_cmd_value and &H1), 7) + leftShift((write_mspi_SPCR2_spe_value and &H1), 6) + leftShift((write_mspi_SPCR2_spifie_value and &H1), 5) + leftShift((write_mspi_SPCR2_wren_value and &H1), 4) + leftShift((write_mspi_SPCR2_wrt0_value and &H1), 3) + leftShift((write_mspi_SPCR2_loopq_value and &H1), 2) + leftShift((write_mspi_SPCR2_hie_value and &H1), 1) + leftShift((write_mspi_SPCR2_halt_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mspi_SPCR2_cont_after_cmd_value = rightShift(data_low, 7) and &H1
        read_mspi_SPCR2_spe_value = rightShift(data_low, 6) and &H1
        read_mspi_SPCR2_spifie_value = rightShift(data_low, 5) and &H1
        read_mspi_SPCR2_wren_value = rightShift(data_low, 4) and &H1
        read_mspi_SPCR2_wrt0_value = rightShift(data_low, 3) and &H1
        read_mspi_SPCR2_loopq_value = rightShift(data_low, 2) and &H1
        read_mspi_SPCR2_hie_value = rightShift(data_low, 1) and &H1
        mspi_SPCR2_halt_mask = &H1
        if data_low > LONG_MAX then
            if mspi_SPCR2_halt_mask = mask then
                read_mspi_SPCR2_halt_value = data_low
            else
                read_mspi_SPCR2_halt_value = (data_low - H8000_0000) and mspi_SPCR2_halt_mask
            end If
        else
            read_mspi_SPCR2_halt_value = data_low and mspi_SPCR2_halt_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_SPCR2_cont_after_cmd_value = &H0
        flag_mspi_SPCR2_cont_after_cmd        = &H0
        write_mspi_SPCR2_spe_value = &H0
        flag_mspi_SPCR2_spe        = &H0
        write_mspi_SPCR2_spifie_value = &H0
        flag_mspi_SPCR2_spifie        = &H0
        write_mspi_SPCR2_wren_value = &H0
        flag_mspi_SPCR2_wren        = &H0
        write_mspi_SPCR2_wrt0_value = &H0
        flag_mspi_SPCR2_wrt0        = &H0
        write_mspi_SPCR2_loopq_value = &H0
        flag_mspi_SPCR2_loopq        = &H0
        write_mspi_SPCR2_hie_value = &H0
        flag_mspi_SPCR2_hie        = &H0
        write_mspi_SPCR2_halt_value = &H0
        flag_mspi_SPCR2_halt        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_mspi_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_MSPI_STATUS_HALTA                     [1:1]            get_mspi_MSPI_STATUS_HALTA
''                                                             set_mspi_MSPI_STATUS_HALTA
''                                                             read_mspi_MSPI_STATUS_HALTA
''                                                             write_mspi_MSPI_STATUS_HALTA
''---------------------------------------------------------------------------------
'' mspi_MSPI_STATUS_SPIF                      [0:0]            get_mspi_MSPI_STATUS_SPIF
''                                                             set_mspi_MSPI_STATUS_SPIF
''                                                             read_mspi_MSPI_STATUS_SPIF
''                                                             write_mspi_MSPI_STATUS_SPIF
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_mspi_status
    Private write_mspi_MSPI_STATUS_HALTA_value
    Private read_mspi_MSPI_STATUS_HALTA_value
    Private flag_mspi_MSPI_STATUS_HALTA
    Private write_mspi_MSPI_STATUS_SPIF_value
    Private read_mspi_MSPI_STATUS_SPIF_value
    Private flag_mspi_MSPI_STATUS_SPIF

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H220
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_MSPI_STATUS_HALTA
        get_mspi_MSPI_STATUS_HALTA = read_mspi_MSPI_STATUS_HALTA_value
    End Property

    Property Let set_mspi_MSPI_STATUS_HALTA(aData)
        write_mspi_MSPI_STATUS_HALTA_value = aData
        flag_mspi_MSPI_STATUS_HALTA        = &H1
    End Property

    Property Get read_mspi_MSPI_STATUS_HALTA
        read
        read_mspi_MSPI_STATUS_HALTA = read_mspi_MSPI_STATUS_HALTA_value
    End Property

    Property Let write_mspi_MSPI_STATUS_HALTA(aData)
        set_mspi_MSPI_STATUS_HALTA = aData
        write
    End Property

    Property Get get_mspi_MSPI_STATUS_SPIF
        get_mspi_MSPI_STATUS_SPIF = read_mspi_MSPI_STATUS_SPIF_value
    End Property

    Property Let set_mspi_MSPI_STATUS_SPIF(aData)
        write_mspi_MSPI_STATUS_SPIF_value = aData
        flag_mspi_MSPI_STATUS_SPIF        = &H1
    End Property

    Property Get read_mspi_MSPI_STATUS_SPIF
        read
        read_mspi_MSPI_STATUS_SPIF = read_mspi_MSPI_STATUS_SPIF_value
    End Property

    Property Let write_mspi_MSPI_STATUS_SPIF(aData)
        set_mspi_MSPI_STATUS_SPIF = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mspi_MSPI_STATUS_HALTA_value = rightShift(data_low, 1) and &H1
        mspi_MSPI_STATUS_SPIF_mask = &H1
        if data_low > LONG_MAX then
            if mspi_MSPI_STATUS_SPIF_mask = mask then
                read_mspi_MSPI_STATUS_SPIF_value = data_low
            else
                read_mspi_MSPI_STATUS_SPIF_value = (data_low - H8000_0000) and mspi_MSPI_STATUS_SPIF_mask
            end If
        else
            read_mspi_MSPI_STATUS_SPIF_value = data_low and mspi_MSPI_STATUS_SPIF_mask
        end If

    End Sub

    Sub write
        If flag_mspi_MSPI_STATUS_HALTA = &H0 or flag_mspi_MSPI_STATUS_SPIF = &H0 Then read
        If flag_mspi_MSPI_STATUS_HALTA = &H0 Then write_mspi_MSPI_STATUS_HALTA_value = get_mspi_MSPI_STATUS_HALTA
        If flag_mspi_MSPI_STATUS_SPIF = &H0 Then write_mspi_MSPI_STATUS_SPIF_value = get_mspi_MSPI_STATUS_SPIF

        regValue = leftShift((write_mspi_MSPI_STATUS_HALTA_value and &H1), 1) + leftShift((write_mspi_MSPI_STATUS_SPIF_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_mspi_MSPI_STATUS_HALTA_value = rightShift(data_low, 1) and &H1
        mspi_MSPI_STATUS_SPIF_mask = &H1
        if data_low > LONG_MAX then
            if mspi_MSPI_STATUS_SPIF_mask = mask then
                read_mspi_MSPI_STATUS_SPIF_value = data_low
            else
                read_mspi_MSPI_STATUS_SPIF_value = (data_low - H8000_0000) and mspi_MSPI_STATUS_SPIF_mask
            end If
        else
            read_mspi_MSPI_STATUS_SPIF_value = data_low and mspi_MSPI_STATUS_SPIF_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_MSPI_STATUS_HALTA_value = &H0
        flag_mspi_MSPI_STATUS_HALTA        = &H0
        write_mspi_MSPI_STATUS_SPIF_value = &H0
        flag_mspi_MSPI_STATUS_SPIF        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_cptqp
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_CPTQP_cptqp                           [3:0]            get_mspi_CPTQP_cptqp
''                                                             set_mspi_CPTQP_cptqp
''                                                             read_mspi_CPTQP_cptqp
''                                                             write_mspi_CPTQP_cptqp
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_cptqp
    Private write_mspi_CPTQP_cptqp_value
    Private read_mspi_CPTQP_cptqp_value
    Private flag_mspi_CPTQP_cptqp

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H224
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_CPTQP_cptqp
        get_mspi_CPTQP_cptqp = read_mspi_CPTQP_cptqp_value
    End Property

    Property Let set_mspi_CPTQP_cptqp(aData)
        write_mspi_CPTQP_cptqp_value = aData
        flag_mspi_CPTQP_cptqp        = &H1
    End Property

    Property Get read_mspi_CPTQP_cptqp
        read
        read_mspi_CPTQP_cptqp = read_mspi_CPTQP_cptqp_value
    End Property

    Property Let write_mspi_CPTQP_cptqp(aData)
        set_mspi_CPTQP_cptqp = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_CPTQP_cptqp_mask = &Hf
        if data_low > LONG_MAX then
            if mspi_CPTQP_cptqp_mask = mask then
                read_mspi_CPTQP_cptqp_value = data_low
            else
                read_mspi_CPTQP_cptqp_value = (data_low - H8000_0000) and mspi_CPTQP_cptqp_mask
            end If
        else
            read_mspi_CPTQP_cptqp_value = data_low and mspi_CPTQP_cptqp_mask
        end If

    End Sub

    Sub write
        If flag_mspi_CPTQP_cptqp = &H0 Then read
        If flag_mspi_CPTQP_cptqp = &H0 Then write_mspi_CPTQP_cptqp_value = get_mspi_CPTQP_cptqp

        regValue = leftShift((write_mspi_CPTQP_cptqp_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_CPTQP_cptqp_mask = &Hf
        if data_low > LONG_MAX then
            if mspi_CPTQP_cptqp_mask = mask then
                read_mspi_CPTQP_cptqp_value = data_low
            else
                read_mspi_CPTQP_cptqp_value = (data_low - H8000_0000) and mspi_CPTQP_cptqp_mask
            end If
        else
            read_mspi_CPTQP_cptqp_value = data_low and mspi_CPTQP_cptqp_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_CPTQP_cptqp_value = &H0
        flag_mspi_CPTQP_cptqp        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_txram00
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_TXRAM00_txram                         [7:0]            get_mspi_TXRAM00_txram
''                                                             set_mspi_TXRAM00_txram
''                                                             read_mspi_TXRAM00_txram
''                                                             write_mspi_TXRAM00_txram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_txram00
    Private write_mspi_TXRAM00_txram_value
    Private read_mspi_TXRAM00_txram_value
    Private flag_mspi_TXRAM00_txram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H240
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_TXRAM00_txram
        get_mspi_TXRAM00_txram = read_mspi_TXRAM00_txram_value
    End Property

    Property Let set_mspi_TXRAM00_txram(aData)
        write_mspi_TXRAM00_txram_value = aData
        flag_mspi_TXRAM00_txram        = &H1
    End Property

    Property Get read_mspi_TXRAM00_txram
        read
        read_mspi_TXRAM00_txram = read_mspi_TXRAM00_txram_value
    End Property

    Property Let write_mspi_TXRAM00_txram(aData)
        set_mspi_TXRAM00_txram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_TXRAM00_txram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_TXRAM00_txram_mask = mask then
                read_mspi_TXRAM00_txram_value = data_low
            else
                read_mspi_TXRAM00_txram_value = (data_low - H8000_0000) and mspi_TXRAM00_txram_mask
            end If
        else
            read_mspi_TXRAM00_txram_value = data_low and mspi_TXRAM00_txram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_TXRAM00_txram = &H0 Then read
        If flag_mspi_TXRAM00_txram = &H0 Then write_mspi_TXRAM00_txram_value = get_mspi_TXRAM00_txram

        regValue = leftShift((write_mspi_TXRAM00_txram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_TXRAM00_txram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_TXRAM00_txram_mask = mask then
                read_mspi_TXRAM00_txram_value = data_low
            else
                read_mspi_TXRAM00_txram_value = (data_low - H8000_0000) and mspi_TXRAM00_txram_mask
            end If
        else
            read_mspi_TXRAM00_txram_value = data_low and mspi_TXRAM00_txram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_TXRAM00_txram_value = &H0
        flag_mspi_TXRAM00_txram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_txram01
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_TXRAM01_txram                         [7:0]            get_mspi_TXRAM01_txram
''                                                             set_mspi_TXRAM01_txram
''                                                             read_mspi_TXRAM01_txram
''                                                             write_mspi_TXRAM01_txram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_txram01
    Private write_mspi_TXRAM01_txram_value
    Private read_mspi_TXRAM01_txram_value
    Private flag_mspi_TXRAM01_txram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H244
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_TXRAM01_txram
        get_mspi_TXRAM01_txram = read_mspi_TXRAM01_txram_value
    End Property

    Property Let set_mspi_TXRAM01_txram(aData)
        write_mspi_TXRAM01_txram_value = aData
        flag_mspi_TXRAM01_txram        = &H1
    End Property

    Property Get read_mspi_TXRAM01_txram
        read
        read_mspi_TXRAM01_txram = read_mspi_TXRAM01_txram_value
    End Property

    Property Let write_mspi_TXRAM01_txram(aData)
        set_mspi_TXRAM01_txram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_TXRAM01_txram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_TXRAM01_txram_mask = mask then
                read_mspi_TXRAM01_txram_value = data_low
            else
                read_mspi_TXRAM01_txram_value = (data_low - H8000_0000) and mspi_TXRAM01_txram_mask
            end If
        else
            read_mspi_TXRAM01_txram_value = data_low and mspi_TXRAM01_txram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_TXRAM01_txram = &H0 Then read
        If flag_mspi_TXRAM01_txram = &H0 Then write_mspi_TXRAM01_txram_value = get_mspi_TXRAM01_txram

        regValue = leftShift((write_mspi_TXRAM01_txram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_TXRAM01_txram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_TXRAM01_txram_mask = mask then
                read_mspi_TXRAM01_txram_value = data_low
            else
                read_mspi_TXRAM01_txram_value = (data_low - H8000_0000) and mspi_TXRAM01_txram_mask
            end If
        else
            read_mspi_TXRAM01_txram_value = data_low and mspi_TXRAM01_txram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_TXRAM01_txram_value = &H0
        flag_mspi_TXRAM01_txram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_txram02
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_TXRAM02_txram                         [7:0]            get_mspi_TXRAM02_txram
''                                                             set_mspi_TXRAM02_txram
''                                                             read_mspi_TXRAM02_txram
''                                                             write_mspi_TXRAM02_txram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_txram02
    Private write_mspi_TXRAM02_txram_value
    Private read_mspi_TXRAM02_txram_value
    Private flag_mspi_TXRAM02_txram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H248
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_TXRAM02_txram
        get_mspi_TXRAM02_txram = read_mspi_TXRAM02_txram_value
    End Property

    Property Let set_mspi_TXRAM02_txram(aData)
        write_mspi_TXRAM02_txram_value = aData
        flag_mspi_TXRAM02_txram        = &H1
    End Property

    Property Get read_mspi_TXRAM02_txram
        read
        read_mspi_TXRAM02_txram = read_mspi_TXRAM02_txram_value
    End Property

    Property Let write_mspi_TXRAM02_txram(aData)
        set_mspi_TXRAM02_txram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_TXRAM02_txram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_TXRAM02_txram_mask = mask then
                read_mspi_TXRAM02_txram_value = data_low
            else
                read_mspi_TXRAM02_txram_value = (data_low - H8000_0000) and mspi_TXRAM02_txram_mask
            end If
        else
            read_mspi_TXRAM02_txram_value = data_low and mspi_TXRAM02_txram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_TXRAM02_txram = &H0 Then read
        If flag_mspi_TXRAM02_txram = &H0 Then write_mspi_TXRAM02_txram_value = get_mspi_TXRAM02_txram

        regValue = leftShift((write_mspi_TXRAM02_txram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_TXRAM02_txram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_TXRAM02_txram_mask = mask then
                read_mspi_TXRAM02_txram_value = data_low
            else
                read_mspi_TXRAM02_txram_value = (data_low - H8000_0000) and mspi_TXRAM02_txram_mask
            end If
        else
            read_mspi_TXRAM02_txram_value = data_low and mspi_TXRAM02_txram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_TXRAM02_txram_value = &H0
        flag_mspi_TXRAM02_txram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_txram03
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_TXRAM03_txram                         [7:0]            get_mspi_TXRAM03_txram
''                                                             set_mspi_TXRAM03_txram
''                                                             read_mspi_TXRAM03_txram
''                                                             write_mspi_TXRAM03_txram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_txram03
    Private write_mspi_TXRAM03_txram_value
    Private read_mspi_TXRAM03_txram_value
    Private flag_mspi_TXRAM03_txram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H24c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_TXRAM03_txram
        get_mspi_TXRAM03_txram = read_mspi_TXRAM03_txram_value
    End Property

    Property Let set_mspi_TXRAM03_txram(aData)
        write_mspi_TXRAM03_txram_value = aData
        flag_mspi_TXRAM03_txram        = &H1
    End Property

    Property Get read_mspi_TXRAM03_txram
        read
        read_mspi_TXRAM03_txram = read_mspi_TXRAM03_txram_value
    End Property

    Property Let write_mspi_TXRAM03_txram(aData)
        set_mspi_TXRAM03_txram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_TXRAM03_txram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_TXRAM03_txram_mask = mask then
                read_mspi_TXRAM03_txram_value = data_low
            else
                read_mspi_TXRAM03_txram_value = (data_low - H8000_0000) and mspi_TXRAM03_txram_mask
            end If
        else
            read_mspi_TXRAM03_txram_value = data_low and mspi_TXRAM03_txram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_TXRAM03_txram = &H0 Then read
        If flag_mspi_TXRAM03_txram = &H0 Then write_mspi_TXRAM03_txram_value = get_mspi_TXRAM03_txram

        regValue = leftShift((write_mspi_TXRAM03_txram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_TXRAM03_txram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_TXRAM03_txram_mask = mask then
                read_mspi_TXRAM03_txram_value = data_low
            else
                read_mspi_TXRAM03_txram_value = (data_low - H8000_0000) and mspi_TXRAM03_txram_mask
            end If
        else
            read_mspi_TXRAM03_txram_value = data_low and mspi_TXRAM03_txram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_TXRAM03_txram_value = &H0
        flag_mspi_TXRAM03_txram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_txram04
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_TXRAM04_txram                         [7:0]            get_mspi_TXRAM04_txram
''                                                             set_mspi_TXRAM04_txram
''                                                             read_mspi_TXRAM04_txram
''                                                             write_mspi_TXRAM04_txram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_txram04
    Private write_mspi_TXRAM04_txram_value
    Private read_mspi_TXRAM04_txram_value
    Private flag_mspi_TXRAM04_txram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H250
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_TXRAM04_txram
        get_mspi_TXRAM04_txram = read_mspi_TXRAM04_txram_value
    End Property

    Property Let set_mspi_TXRAM04_txram(aData)
        write_mspi_TXRAM04_txram_value = aData
        flag_mspi_TXRAM04_txram        = &H1
    End Property

    Property Get read_mspi_TXRAM04_txram
        read
        read_mspi_TXRAM04_txram = read_mspi_TXRAM04_txram_value
    End Property

    Property Let write_mspi_TXRAM04_txram(aData)
        set_mspi_TXRAM04_txram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_TXRAM04_txram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_TXRAM04_txram_mask = mask then
                read_mspi_TXRAM04_txram_value = data_low
            else
                read_mspi_TXRAM04_txram_value = (data_low - H8000_0000) and mspi_TXRAM04_txram_mask
            end If
        else
            read_mspi_TXRAM04_txram_value = data_low and mspi_TXRAM04_txram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_TXRAM04_txram = &H0 Then read
        If flag_mspi_TXRAM04_txram = &H0 Then write_mspi_TXRAM04_txram_value = get_mspi_TXRAM04_txram

        regValue = leftShift((write_mspi_TXRAM04_txram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_TXRAM04_txram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_TXRAM04_txram_mask = mask then
                read_mspi_TXRAM04_txram_value = data_low
            else
                read_mspi_TXRAM04_txram_value = (data_low - H8000_0000) and mspi_TXRAM04_txram_mask
            end If
        else
            read_mspi_TXRAM04_txram_value = data_low and mspi_TXRAM04_txram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_TXRAM04_txram_value = &H0
        flag_mspi_TXRAM04_txram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_txram05
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_TXRAM05_txram                         [7:0]            get_mspi_TXRAM05_txram
''                                                             set_mspi_TXRAM05_txram
''                                                             read_mspi_TXRAM05_txram
''                                                             write_mspi_TXRAM05_txram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_txram05
    Private write_mspi_TXRAM05_txram_value
    Private read_mspi_TXRAM05_txram_value
    Private flag_mspi_TXRAM05_txram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H254
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_TXRAM05_txram
        get_mspi_TXRAM05_txram = read_mspi_TXRAM05_txram_value
    End Property

    Property Let set_mspi_TXRAM05_txram(aData)
        write_mspi_TXRAM05_txram_value = aData
        flag_mspi_TXRAM05_txram        = &H1
    End Property

    Property Get read_mspi_TXRAM05_txram
        read
        read_mspi_TXRAM05_txram = read_mspi_TXRAM05_txram_value
    End Property

    Property Let write_mspi_TXRAM05_txram(aData)
        set_mspi_TXRAM05_txram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_TXRAM05_txram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_TXRAM05_txram_mask = mask then
                read_mspi_TXRAM05_txram_value = data_low
            else
                read_mspi_TXRAM05_txram_value = (data_low - H8000_0000) and mspi_TXRAM05_txram_mask
            end If
        else
            read_mspi_TXRAM05_txram_value = data_low and mspi_TXRAM05_txram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_TXRAM05_txram = &H0 Then read
        If flag_mspi_TXRAM05_txram = &H0 Then write_mspi_TXRAM05_txram_value = get_mspi_TXRAM05_txram

        regValue = leftShift((write_mspi_TXRAM05_txram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_TXRAM05_txram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_TXRAM05_txram_mask = mask then
                read_mspi_TXRAM05_txram_value = data_low
            else
                read_mspi_TXRAM05_txram_value = (data_low - H8000_0000) and mspi_TXRAM05_txram_mask
            end If
        else
            read_mspi_TXRAM05_txram_value = data_low and mspi_TXRAM05_txram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_TXRAM05_txram_value = &H0
        flag_mspi_TXRAM05_txram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_txram06
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_TXRAM06_txram                         [7:0]            get_mspi_TXRAM06_txram
''                                                             set_mspi_TXRAM06_txram
''                                                             read_mspi_TXRAM06_txram
''                                                             write_mspi_TXRAM06_txram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_txram06
    Private write_mspi_TXRAM06_txram_value
    Private read_mspi_TXRAM06_txram_value
    Private flag_mspi_TXRAM06_txram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H258
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_TXRAM06_txram
        get_mspi_TXRAM06_txram = read_mspi_TXRAM06_txram_value
    End Property

    Property Let set_mspi_TXRAM06_txram(aData)
        write_mspi_TXRAM06_txram_value = aData
        flag_mspi_TXRAM06_txram        = &H1
    End Property

    Property Get read_mspi_TXRAM06_txram
        read
        read_mspi_TXRAM06_txram = read_mspi_TXRAM06_txram_value
    End Property

    Property Let write_mspi_TXRAM06_txram(aData)
        set_mspi_TXRAM06_txram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_TXRAM06_txram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_TXRAM06_txram_mask = mask then
                read_mspi_TXRAM06_txram_value = data_low
            else
                read_mspi_TXRAM06_txram_value = (data_low - H8000_0000) and mspi_TXRAM06_txram_mask
            end If
        else
            read_mspi_TXRAM06_txram_value = data_low and mspi_TXRAM06_txram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_TXRAM06_txram = &H0 Then read
        If flag_mspi_TXRAM06_txram = &H0 Then write_mspi_TXRAM06_txram_value = get_mspi_TXRAM06_txram

        regValue = leftShift((write_mspi_TXRAM06_txram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_TXRAM06_txram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_TXRAM06_txram_mask = mask then
                read_mspi_TXRAM06_txram_value = data_low
            else
                read_mspi_TXRAM06_txram_value = (data_low - H8000_0000) and mspi_TXRAM06_txram_mask
            end If
        else
            read_mspi_TXRAM06_txram_value = data_low and mspi_TXRAM06_txram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_TXRAM06_txram_value = &H0
        flag_mspi_TXRAM06_txram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_txram07
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_TXRAM07_txram                         [7:0]            get_mspi_TXRAM07_txram
''                                                             set_mspi_TXRAM07_txram
''                                                             read_mspi_TXRAM07_txram
''                                                             write_mspi_TXRAM07_txram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_txram07
    Private write_mspi_TXRAM07_txram_value
    Private read_mspi_TXRAM07_txram_value
    Private flag_mspi_TXRAM07_txram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H25c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_TXRAM07_txram
        get_mspi_TXRAM07_txram = read_mspi_TXRAM07_txram_value
    End Property

    Property Let set_mspi_TXRAM07_txram(aData)
        write_mspi_TXRAM07_txram_value = aData
        flag_mspi_TXRAM07_txram        = &H1
    End Property

    Property Get read_mspi_TXRAM07_txram
        read
        read_mspi_TXRAM07_txram = read_mspi_TXRAM07_txram_value
    End Property

    Property Let write_mspi_TXRAM07_txram(aData)
        set_mspi_TXRAM07_txram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_TXRAM07_txram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_TXRAM07_txram_mask = mask then
                read_mspi_TXRAM07_txram_value = data_low
            else
                read_mspi_TXRAM07_txram_value = (data_low - H8000_0000) and mspi_TXRAM07_txram_mask
            end If
        else
            read_mspi_TXRAM07_txram_value = data_low and mspi_TXRAM07_txram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_TXRAM07_txram = &H0 Then read
        If flag_mspi_TXRAM07_txram = &H0 Then write_mspi_TXRAM07_txram_value = get_mspi_TXRAM07_txram

        regValue = leftShift((write_mspi_TXRAM07_txram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_TXRAM07_txram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_TXRAM07_txram_mask = mask then
                read_mspi_TXRAM07_txram_value = data_low
            else
                read_mspi_TXRAM07_txram_value = (data_low - H8000_0000) and mspi_TXRAM07_txram_mask
            end If
        else
            read_mspi_TXRAM07_txram_value = data_low and mspi_TXRAM07_txram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_TXRAM07_txram_value = &H0
        flag_mspi_TXRAM07_txram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_txram08
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_TXRAM08_txram                         [7:0]            get_mspi_TXRAM08_txram
''                                                             set_mspi_TXRAM08_txram
''                                                             read_mspi_TXRAM08_txram
''                                                             write_mspi_TXRAM08_txram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_txram08
    Private write_mspi_TXRAM08_txram_value
    Private read_mspi_TXRAM08_txram_value
    Private flag_mspi_TXRAM08_txram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H260
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_TXRAM08_txram
        get_mspi_TXRAM08_txram = read_mspi_TXRAM08_txram_value
    End Property

    Property Let set_mspi_TXRAM08_txram(aData)
        write_mspi_TXRAM08_txram_value = aData
        flag_mspi_TXRAM08_txram        = &H1
    End Property

    Property Get read_mspi_TXRAM08_txram
        read
        read_mspi_TXRAM08_txram = read_mspi_TXRAM08_txram_value
    End Property

    Property Let write_mspi_TXRAM08_txram(aData)
        set_mspi_TXRAM08_txram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_TXRAM08_txram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_TXRAM08_txram_mask = mask then
                read_mspi_TXRAM08_txram_value = data_low
            else
                read_mspi_TXRAM08_txram_value = (data_low - H8000_0000) and mspi_TXRAM08_txram_mask
            end If
        else
            read_mspi_TXRAM08_txram_value = data_low and mspi_TXRAM08_txram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_TXRAM08_txram = &H0 Then read
        If flag_mspi_TXRAM08_txram = &H0 Then write_mspi_TXRAM08_txram_value = get_mspi_TXRAM08_txram

        regValue = leftShift((write_mspi_TXRAM08_txram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_TXRAM08_txram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_TXRAM08_txram_mask = mask then
                read_mspi_TXRAM08_txram_value = data_low
            else
                read_mspi_TXRAM08_txram_value = (data_low - H8000_0000) and mspi_TXRAM08_txram_mask
            end If
        else
            read_mspi_TXRAM08_txram_value = data_low and mspi_TXRAM08_txram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_TXRAM08_txram_value = &H0
        flag_mspi_TXRAM08_txram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_txram09
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_TXRAM09_txram                         [7:0]            get_mspi_TXRAM09_txram
''                                                             set_mspi_TXRAM09_txram
''                                                             read_mspi_TXRAM09_txram
''                                                             write_mspi_TXRAM09_txram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_txram09
    Private write_mspi_TXRAM09_txram_value
    Private read_mspi_TXRAM09_txram_value
    Private flag_mspi_TXRAM09_txram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H264
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_TXRAM09_txram
        get_mspi_TXRAM09_txram = read_mspi_TXRAM09_txram_value
    End Property

    Property Let set_mspi_TXRAM09_txram(aData)
        write_mspi_TXRAM09_txram_value = aData
        flag_mspi_TXRAM09_txram        = &H1
    End Property

    Property Get read_mspi_TXRAM09_txram
        read
        read_mspi_TXRAM09_txram = read_mspi_TXRAM09_txram_value
    End Property

    Property Let write_mspi_TXRAM09_txram(aData)
        set_mspi_TXRAM09_txram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_TXRAM09_txram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_TXRAM09_txram_mask = mask then
                read_mspi_TXRAM09_txram_value = data_low
            else
                read_mspi_TXRAM09_txram_value = (data_low - H8000_0000) and mspi_TXRAM09_txram_mask
            end If
        else
            read_mspi_TXRAM09_txram_value = data_low and mspi_TXRAM09_txram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_TXRAM09_txram = &H0 Then read
        If flag_mspi_TXRAM09_txram = &H0 Then write_mspi_TXRAM09_txram_value = get_mspi_TXRAM09_txram

        regValue = leftShift((write_mspi_TXRAM09_txram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_TXRAM09_txram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_TXRAM09_txram_mask = mask then
                read_mspi_TXRAM09_txram_value = data_low
            else
                read_mspi_TXRAM09_txram_value = (data_low - H8000_0000) and mspi_TXRAM09_txram_mask
            end If
        else
            read_mspi_TXRAM09_txram_value = data_low and mspi_TXRAM09_txram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_TXRAM09_txram_value = &H0
        flag_mspi_TXRAM09_txram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_txram10
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_TXRAM10_txram                         [7:0]            get_mspi_TXRAM10_txram
''                                                             set_mspi_TXRAM10_txram
''                                                             read_mspi_TXRAM10_txram
''                                                             write_mspi_TXRAM10_txram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_txram10
    Private write_mspi_TXRAM10_txram_value
    Private read_mspi_TXRAM10_txram_value
    Private flag_mspi_TXRAM10_txram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H268
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_TXRAM10_txram
        get_mspi_TXRAM10_txram = read_mspi_TXRAM10_txram_value
    End Property

    Property Let set_mspi_TXRAM10_txram(aData)
        write_mspi_TXRAM10_txram_value = aData
        flag_mspi_TXRAM10_txram        = &H1
    End Property

    Property Get read_mspi_TXRAM10_txram
        read
        read_mspi_TXRAM10_txram = read_mspi_TXRAM10_txram_value
    End Property

    Property Let write_mspi_TXRAM10_txram(aData)
        set_mspi_TXRAM10_txram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_TXRAM10_txram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_TXRAM10_txram_mask = mask then
                read_mspi_TXRAM10_txram_value = data_low
            else
                read_mspi_TXRAM10_txram_value = (data_low - H8000_0000) and mspi_TXRAM10_txram_mask
            end If
        else
            read_mspi_TXRAM10_txram_value = data_low and mspi_TXRAM10_txram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_TXRAM10_txram = &H0 Then read
        If flag_mspi_TXRAM10_txram = &H0 Then write_mspi_TXRAM10_txram_value = get_mspi_TXRAM10_txram

        regValue = leftShift((write_mspi_TXRAM10_txram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_TXRAM10_txram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_TXRAM10_txram_mask = mask then
                read_mspi_TXRAM10_txram_value = data_low
            else
                read_mspi_TXRAM10_txram_value = (data_low - H8000_0000) and mspi_TXRAM10_txram_mask
            end If
        else
            read_mspi_TXRAM10_txram_value = data_low and mspi_TXRAM10_txram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_TXRAM10_txram_value = &H0
        flag_mspi_TXRAM10_txram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_txram11
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_TXRAM11_txram                         [7:0]            get_mspi_TXRAM11_txram
''                                                             set_mspi_TXRAM11_txram
''                                                             read_mspi_TXRAM11_txram
''                                                             write_mspi_TXRAM11_txram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_txram11
    Private write_mspi_TXRAM11_txram_value
    Private read_mspi_TXRAM11_txram_value
    Private flag_mspi_TXRAM11_txram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H26c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_TXRAM11_txram
        get_mspi_TXRAM11_txram = read_mspi_TXRAM11_txram_value
    End Property

    Property Let set_mspi_TXRAM11_txram(aData)
        write_mspi_TXRAM11_txram_value = aData
        flag_mspi_TXRAM11_txram        = &H1
    End Property

    Property Get read_mspi_TXRAM11_txram
        read
        read_mspi_TXRAM11_txram = read_mspi_TXRAM11_txram_value
    End Property

    Property Let write_mspi_TXRAM11_txram(aData)
        set_mspi_TXRAM11_txram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_TXRAM11_txram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_TXRAM11_txram_mask = mask then
                read_mspi_TXRAM11_txram_value = data_low
            else
                read_mspi_TXRAM11_txram_value = (data_low - H8000_0000) and mspi_TXRAM11_txram_mask
            end If
        else
            read_mspi_TXRAM11_txram_value = data_low and mspi_TXRAM11_txram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_TXRAM11_txram = &H0 Then read
        If flag_mspi_TXRAM11_txram = &H0 Then write_mspi_TXRAM11_txram_value = get_mspi_TXRAM11_txram

        regValue = leftShift((write_mspi_TXRAM11_txram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_TXRAM11_txram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_TXRAM11_txram_mask = mask then
                read_mspi_TXRAM11_txram_value = data_low
            else
                read_mspi_TXRAM11_txram_value = (data_low - H8000_0000) and mspi_TXRAM11_txram_mask
            end If
        else
            read_mspi_TXRAM11_txram_value = data_low and mspi_TXRAM11_txram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_TXRAM11_txram_value = &H0
        flag_mspi_TXRAM11_txram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_txram12
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_TXRAM12_txram                         [7:0]            get_mspi_TXRAM12_txram
''                                                             set_mspi_TXRAM12_txram
''                                                             read_mspi_TXRAM12_txram
''                                                             write_mspi_TXRAM12_txram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_txram12
    Private write_mspi_TXRAM12_txram_value
    Private read_mspi_TXRAM12_txram_value
    Private flag_mspi_TXRAM12_txram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H270
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_TXRAM12_txram
        get_mspi_TXRAM12_txram = read_mspi_TXRAM12_txram_value
    End Property

    Property Let set_mspi_TXRAM12_txram(aData)
        write_mspi_TXRAM12_txram_value = aData
        flag_mspi_TXRAM12_txram        = &H1
    End Property

    Property Get read_mspi_TXRAM12_txram
        read
        read_mspi_TXRAM12_txram = read_mspi_TXRAM12_txram_value
    End Property

    Property Let write_mspi_TXRAM12_txram(aData)
        set_mspi_TXRAM12_txram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_TXRAM12_txram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_TXRAM12_txram_mask = mask then
                read_mspi_TXRAM12_txram_value = data_low
            else
                read_mspi_TXRAM12_txram_value = (data_low - H8000_0000) and mspi_TXRAM12_txram_mask
            end If
        else
            read_mspi_TXRAM12_txram_value = data_low and mspi_TXRAM12_txram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_TXRAM12_txram = &H0 Then read
        If flag_mspi_TXRAM12_txram = &H0 Then write_mspi_TXRAM12_txram_value = get_mspi_TXRAM12_txram

        regValue = leftShift((write_mspi_TXRAM12_txram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_TXRAM12_txram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_TXRAM12_txram_mask = mask then
                read_mspi_TXRAM12_txram_value = data_low
            else
                read_mspi_TXRAM12_txram_value = (data_low - H8000_0000) and mspi_TXRAM12_txram_mask
            end If
        else
            read_mspi_TXRAM12_txram_value = data_low and mspi_TXRAM12_txram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_TXRAM12_txram_value = &H0
        flag_mspi_TXRAM12_txram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_txram13
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_TXRAM13_txram                         [7:0]            get_mspi_TXRAM13_txram
''                                                             set_mspi_TXRAM13_txram
''                                                             read_mspi_TXRAM13_txram
''                                                             write_mspi_TXRAM13_txram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_txram13
    Private write_mspi_TXRAM13_txram_value
    Private read_mspi_TXRAM13_txram_value
    Private flag_mspi_TXRAM13_txram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H274
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_TXRAM13_txram
        get_mspi_TXRAM13_txram = read_mspi_TXRAM13_txram_value
    End Property

    Property Let set_mspi_TXRAM13_txram(aData)
        write_mspi_TXRAM13_txram_value = aData
        flag_mspi_TXRAM13_txram        = &H1
    End Property

    Property Get read_mspi_TXRAM13_txram
        read
        read_mspi_TXRAM13_txram = read_mspi_TXRAM13_txram_value
    End Property

    Property Let write_mspi_TXRAM13_txram(aData)
        set_mspi_TXRAM13_txram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_TXRAM13_txram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_TXRAM13_txram_mask = mask then
                read_mspi_TXRAM13_txram_value = data_low
            else
                read_mspi_TXRAM13_txram_value = (data_low - H8000_0000) and mspi_TXRAM13_txram_mask
            end If
        else
            read_mspi_TXRAM13_txram_value = data_low and mspi_TXRAM13_txram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_TXRAM13_txram = &H0 Then read
        If flag_mspi_TXRAM13_txram = &H0 Then write_mspi_TXRAM13_txram_value = get_mspi_TXRAM13_txram

        regValue = leftShift((write_mspi_TXRAM13_txram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_TXRAM13_txram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_TXRAM13_txram_mask = mask then
                read_mspi_TXRAM13_txram_value = data_low
            else
                read_mspi_TXRAM13_txram_value = (data_low - H8000_0000) and mspi_TXRAM13_txram_mask
            end If
        else
            read_mspi_TXRAM13_txram_value = data_low and mspi_TXRAM13_txram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_TXRAM13_txram_value = &H0
        flag_mspi_TXRAM13_txram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_txram14
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_TXRAM14_txram                         [7:0]            get_mspi_TXRAM14_txram
''                                                             set_mspi_TXRAM14_txram
''                                                             read_mspi_TXRAM14_txram
''                                                             write_mspi_TXRAM14_txram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_txram14
    Private write_mspi_TXRAM14_txram_value
    Private read_mspi_TXRAM14_txram_value
    Private flag_mspi_TXRAM14_txram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H278
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_TXRAM14_txram
        get_mspi_TXRAM14_txram = read_mspi_TXRAM14_txram_value
    End Property

    Property Let set_mspi_TXRAM14_txram(aData)
        write_mspi_TXRAM14_txram_value = aData
        flag_mspi_TXRAM14_txram        = &H1
    End Property

    Property Get read_mspi_TXRAM14_txram
        read
        read_mspi_TXRAM14_txram = read_mspi_TXRAM14_txram_value
    End Property

    Property Let write_mspi_TXRAM14_txram(aData)
        set_mspi_TXRAM14_txram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_TXRAM14_txram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_TXRAM14_txram_mask = mask then
                read_mspi_TXRAM14_txram_value = data_low
            else
                read_mspi_TXRAM14_txram_value = (data_low - H8000_0000) and mspi_TXRAM14_txram_mask
            end If
        else
            read_mspi_TXRAM14_txram_value = data_low and mspi_TXRAM14_txram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_TXRAM14_txram = &H0 Then read
        If flag_mspi_TXRAM14_txram = &H0 Then write_mspi_TXRAM14_txram_value = get_mspi_TXRAM14_txram

        regValue = leftShift((write_mspi_TXRAM14_txram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_TXRAM14_txram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_TXRAM14_txram_mask = mask then
                read_mspi_TXRAM14_txram_value = data_low
            else
                read_mspi_TXRAM14_txram_value = (data_low - H8000_0000) and mspi_TXRAM14_txram_mask
            end If
        else
            read_mspi_TXRAM14_txram_value = data_low and mspi_TXRAM14_txram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_TXRAM14_txram_value = &H0
        flag_mspi_TXRAM14_txram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_txram15
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_TXRAM15_txram                         [7:0]            get_mspi_TXRAM15_txram
''                                                             set_mspi_TXRAM15_txram
''                                                             read_mspi_TXRAM15_txram
''                                                             write_mspi_TXRAM15_txram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_txram15
    Private write_mspi_TXRAM15_txram_value
    Private read_mspi_TXRAM15_txram_value
    Private flag_mspi_TXRAM15_txram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H27c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_TXRAM15_txram
        get_mspi_TXRAM15_txram = read_mspi_TXRAM15_txram_value
    End Property

    Property Let set_mspi_TXRAM15_txram(aData)
        write_mspi_TXRAM15_txram_value = aData
        flag_mspi_TXRAM15_txram        = &H1
    End Property

    Property Get read_mspi_TXRAM15_txram
        read
        read_mspi_TXRAM15_txram = read_mspi_TXRAM15_txram_value
    End Property

    Property Let write_mspi_TXRAM15_txram(aData)
        set_mspi_TXRAM15_txram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_TXRAM15_txram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_TXRAM15_txram_mask = mask then
                read_mspi_TXRAM15_txram_value = data_low
            else
                read_mspi_TXRAM15_txram_value = (data_low - H8000_0000) and mspi_TXRAM15_txram_mask
            end If
        else
            read_mspi_TXRAM15_txram_value = data_low and mspi_TXRAM15_txram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_TXRAM15_txram = &H0 Then read
        If flag_mspi_TXRAM15_txram = &H0 Then write_mspi_TXRAM15_txram_value = get_mspi_TXRAM15_txram

        regValue = leftShift((write_mspi_TXRAM15_txram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_TXRAM15_txram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_TXRAM15_txram_mask = mask then
                read_mspi_TXRAM15_txram_value = data_low
            else
                read_mspi_TXRAM15_txram_value = (data_low - H8000_0000) and mspi_TXRAM15_txram_mask
            end If
        else
            read_mspi_TXRAM15_txram_value = data_low and mspi_TXRAM15_txram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_TXRAM15_txram_value = &H0
        flag_mspi_TXRAM15_txram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_txram16
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_TXRAM16_txram                         [7:0]            get_mspi_TXRAM16_txram
''                                                             set_mspi_TXRAM16_txram
''                                                             read_mspi_TXRAM16_txram
''                                                             write_mspi_TXRAM16_txram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_txram16
    Private write_mspi_TXRAM16_txram_value
    Private read_mspi_TXRAM16_txram_value
    Private flag_mspi_TXRAM16_txram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H280
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_TXRAM16_txram
        get_mspi_TXRAM16_txram = read_mspi_TXRAM16_txram_value
    End Property

    Property Let set_mspi_TXRAM16_txram(aData)
        write_mspi_TXRAM16_txram_value = aData
        flag_mspi_TXRAM16_txram        = &H1
    End Property

    Property Get read_mspi_TXRAM16_txram
        read
        read_mspi_TXRAM16_txram = read_mspi_TXRAM16_txram_value
    End Property

    Property Let write_mspi_TXRAM16_txram(aData)
        set_mspi_TXRAM16_txram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_TXRAM16_txram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_TXRAM16_txram_mask = mask then
                read_mspi_TXRAM16_txram_value = data_low
            else
                read_mspi_TXRAM16_txram_value = (data_low - H8000_0000) and mspi_TXRAM16_txram_mask
            end If
        else
            read_mspi_TXRAM16_txram_value = data_low and mspi_TXRAM16_txram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_TXRAM16_txram = &H0 Then read
        If flag_mspi_TXRAM16_txram = &H0 Then write_mspi_TXRAM16_txram_value = get_mspi_TXRAM16_txram

        regValue = leftShift((write_mspi_TXRAM16_txram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_TXRAM16_txram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_TXRAM16_txram_mask = mask then
                read_mspi_TXRAM16_txram_value = data_low
            else
                read_mspi_TXRAM16_txram_value = (data_low - H8000_0000) and mspi_TXRAM16_txram_mask
            end If
        else
            read_mspi_TXRAM16_txram_value = data_low and mspi_TXRAM16_txram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_TXRAM16_txram_value = &H0
        flag_mspi_TXRAM16_txram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_txram17
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_TXRAM17_txram                         [7:0]            get_mspi_TXRAM17_txram
''                                                             set_mspi_TXRAM17_txram
''                                                             read_mspi_TXRAM17_txram
''                                                             write_mspi_TXRAM17_txram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_txram17
    Private write_mspi_TXRAM17_txram_value
    Private read_mspi_TXRAM17_txram_value
    Private flag_mspi_TXRAM17_txram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H284
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_TXRAM17_txram
        get_mspi_TXRAM17_txram = read_mspi_TXRAM17_txram_value
    End Property

    Property Let set_mspi_TXRAM17_txram(aData)
        write_mspi_TXRAM17_txram_value = aData
        flag_mspi_TXRAM17_txram        = &H1
    End Property

    Property Get read_mspi_TXRAM17_txram
        read
        read_mspi_TXRAM17_txram = read_mspi_TXRAM17_txram_value
    End Property

    Property Let write_mspi_TXRAM17_txram(aData)
        set_mspi_TXRAM17_txram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_TXRAM17_txram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_TXRAM17_txram_mask = mask then
                read_mspi_TXRAM17_txram_value = data_low
            else
                read_mspi_TXRAM17_txram_value = (data_low - H8000_0000) and mspi_TXRAM17_txram_mask
            end If
        else
            read_mspi_TXRAM17_txram_value = data_low and mspi_TXRAM17_txram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_TXRAM17_txram = &H0 Then read
        If flag_mspi_TXRAM17_txram = &H0 Then write_mspi_TXRAM17_txram_value = get_mspi_TXRAM17_txram

        regValue = leftShift((write_mspi_TXRAM17_txram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_TXRAM17_txram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_TXRAM17_txram_mask = mask then
                read_mspi_TXRAM17_txram_value = data_low
            else
                read_mspi_TXRAM17_txram_value = (data_low - H8000_0000) and mspi_TXRAM17_txram_mask
            end If
        else
            read_mspi_TXRAM17_txram_value = data_low and mspi_TXRAM17_txram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_TXRAM17_txram_value = &H0
        flag_mspi_TXRAM17_txram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_txram18
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_TXRAM18_txram                         [7:0]            get_mspi_TXRAM18_txram
''                                                             set_mspi_TXRAM18_txram
''                                                             read_mspi_TXRAM18_txram
''                                                             write_mspi_TXRAM18_txram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_txram18
    Private write_mspi_TXRAM18_txram_value
    Private read_mspi_TXRAM18_txram_value
    Private flag_mspi_TXRAM18_txram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H288
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_TXRAM18_txram
        get_mspi_TXRAM18_txram = read_mspi_TXRAM18_txram_value
    End Property

    Property Let set_mspi_TXRAM18_txram(aData)
        write_mspi_TXRAM18_txram_value = aData
        flag_mspi_TXRAM18_txram        = &H1
    End Property

    Property Get read_mspi_TXRAM18_txram
        read
        read_mspi_TXRAM18_txram = read_mspi_TXRAM18_txram_value
    End Property

    Property Let write_mspi_TXRAM18_txram(aData)
        set_mspi_TXRAM18_txram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_TXRAM18_txram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_TXRAM18_txram_mask = mask then
                read_mspi_TXRAM18_txram_value = data_low
            else
                read_mspi_TXRAM18_txram_value = (data_low - H8000_0000) and mspi_TXRAM18_txram_mask
            end If
        else
            read_mspi_TXRAM18_txram_value = data_low and mspi_TXRAM18_txram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_TXRAM18_txram = &H0 Then read
        If flag_mspi_TXRAM18_txram = &H0 Then write_mspi_TXRAM18_txram_value = get_mspi_TXRAM18_txram

        regValue = leftShift((write_mspi_TXRAM18_txram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_TXRAM18_txram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_TXRAM18_txram_mask = mask then
                read_mspi_TXRAM18_txram_value = data_low
            else
                read_mspi_TXRAM18_txram_value = (data_low - H8000_0000) and mspi_TXRAM18_txram_mask
            end If
        else
            read_mspi_TXRAM18_txram_value = data_low and mspi_TXRAM18_txram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_TXRAM18_txram_value = &H0
        flag_mspi_TXRAM18_txram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_txram19
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_TXRAM19_txram                         [7:0]            get_mspi_TXRAM19_txram
''                                                             set_mspi_TXRAM19_txram
''                                                             read_mspi_TXRAM19_txram
''                                                             write_mspi_TXRAM19_txram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_txram19
    Private write_mspi_TXRAM19_txram_value
    Private read_mspi_TXRAM19_txram_value
    Private flag_mspi_TXRAM19_txram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H28c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_TXRAM19_txram
        get_mspi_TXRAM19_txram = read_mspi_TXRAM19_txram_value
    End Property

    Property Let set_mspi_TXRAM19_txram(aData)
        write_mspi_TXRAM19_txram_value = aData
        flag_mspi_TXRAM19_txram        = &H1
    End Property

    Property Get read_mspi_TXRAM19_txram
        read
        read_mspi_TXRAM19_txram = read_mspi_TXRAM19_txram_value
    End Property

    Property Let write_mspi_TXRAM19_txram(aData)
        set_mspi_TXRAM19_txram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_TXRAM19_txram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_TXRAM19_txram_mask = mask then
                read_mspi_TXRAM19_txram_value = data_low
            else
                read_mspi_TXRAM19_txram_value = (data_low - H8000_0000) and mspi_TXRAM19_txram_mask
            end If
        else
            read_mspi_TXRAM19_txram_value = data_low and mspi_TXRAM19_txram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_TXRAM19_txram = &H0 Then read
        If flag_mspi_TXRAM19_txram = &H0 Then write_mspi_TXRAM19_txram_value = get_mspi_TXRAM19_txram

        regValue = leftShift((write_mspi_TXRAM19_txram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_TXRAM19_txram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_TXRAM19_txram_mask = mask then
                read_mspi_TXRAM19_txram_value = data_low
            else
                read_mspi_TXRAM19_txram_value = (data_low - H8000_0000) and mspi_TXRAM19_txram_mask
            end If
        else
            read_mspi_TXRAM19_txram_value = data_low and mspi_TXRAM19_txram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_TXRAM19_txram_value = &H0
        flag_mspi_TXRAM19_txram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_txram20
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_TXRAM20_txram                         [7:0]            get_mspi_TXRAM20_txram
''                                                             set_mspi_TXRAM20_txram
''                                                             read_mspi_TXRAM20_txram
''                                                             write_mspi_TXRAM20_txram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_txram20
    Private write_mspi_TXRAM20_txram_value
    Private read_mspi_TXRAM20_txram_value
    Private flag_mspi_TXRAM20_txram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H290
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_TXRAM20_txram
        get_mspi_TXRAM20_txram = read_mspi_TXRAM20_txram_value
    End Property

    Property Let set_mspi_TXRAM20_txram(aData)
        write_mspi_TXRAM20_txram_value = aData
        flag_mspi_TXRAM20_txram        = &H1
    End Property

    Property Get read_mspi_TXRAM20_txram
        read
        read_mspi_TXRAM20_txram = read_mspi_TXRAM20_txram_value
    End Property

    Property Let write_mspi_TXRAM20_txram(aData)
        set_mspi_TXRAM20_txram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_TXRAM20_txram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_TXRAM20_txram_mask = mask then
                read_mspi_TXRAM20_txram_value = data_low
            else
                read_mspi_TXRAM20_txram_value = (data_low - H8000_0000) and mspi_TXRAM20_txram_mask
            end If
        else
            read_mspi_TXRAM20_txram_value = data_low and mspi_TXRAM20_txram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_TXRAM20_txram = &H0 Then read
        If flag_mspi_TXRAM20_txram = &H0 Then write_mspi_TXRAM20_txram_value = get_mspi_TXRAM20_txram

        regValue = leftShift((write_mspi_TXRAM20_txram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_TXRAM20_txram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_TXRAM20_txram_mask = mask then
                read_mspi_TXRAM20_txram_value = data_low
            else
                read_mspi_TXRAM20_txram_value = (data_low - H8000_0000) and mspi_TXRAM20_txram_mask
            end If
        else
            read_mspi_TXRAM20_txram_value = data_low and mspi_TXRAM20_txram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_TXRAM20_txram_value = &H0
        flag_mspi_TXRAM20_txram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_txram21
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_TXRAM21_txram                         [7:0]            get_mspi_TXRAM21_txram
''                                                             set_mspi_TXRAM21_txram
''                                                             read_mspi_TXRAM21_txram
''                                                             write_mspi_TXRAM21_txram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_txram21
    Private write_mspi_TXRAM21_txram_value
    Private read_mspi_TXRAM21_txram_value
    Private flag_mspi_TXRAM21_txram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H294
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_TXRAM21_txram
        get_mspi_TXRAM21_txram = read_mspi_TXRAM21_txram_value
    End Property

    Property Let set_mspi_TXRAM21_txram(aData)
        write_mspi_TXRAM21_txram_value = aData
        flag_mspi_TXRAM21_txram        = &H1
    End Property

    Property Get read_mspi_TXRAM21_txram
        read
        read_mspi_TXRAM21_txram = read_mspi_TXRAM21_txram_value
    End Property

    Property Let write_mspi_TXRAM21_txram(aData)
        set_mspi_TXRAM21_txram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_TXRAM21_txram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_TXRAM21_txram_mask = mask then
                read_mspi_TXRAM21_txram_value = data_low
            else
                read_mspi_TXRAM21_txram_value = (data_low - H8000_0000) and mspi_TXRAM21_txram_mask
            end If
        else
            read_mspi_TXRAM21_txram_value = data_low and mspi_TXRAM21_txram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_TXRAM21_txram = &H0 Then read
        If flag_mspi_TXRAM21_txram = &H0 Then write_mspi_TXRAM21_txram_value = get_mspi_TXRAM21_txram

        regValue = leftShift((write_mspi_TXRAM21_txram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_TXRAM21_txram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_TXRAM21_txram_mask = mask then
                read_mspi_TXRAM21_txram_value = data_low
            else
                read_mspi_TXRAM21_txram_value = (data_low - H8000_0000) and mspi_TXRAM21_txram_mask
            end If
        else
            read_mspi_TXRAM21_txram_value = data_low and mspi_TXRAM21_txram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_TXRAM21_txram_value = &H0
        flag_mspi_TXRAM21_txram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_txram22
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_TXRAM22_txram                         [7:0]            get_mspi_TXRAM22_txram
''                                                             set_mspi_TXRAM22_txram
''                                                             read_mspi_TXRAM22_txram
''                                                             write_mspi_TXRAM22_txram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_txram22
    Private write_mspi_TXRAM22_txram_value
    Private read_mspi_TXRAM22_txram_value
    Private flag_mspi_TXRAM22_txram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H298
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_TXRAM22_txram
        get_mspi_TXRAM22_txram = read_mspi_TXRAM22_txram_value
    End Property

    Property Let set_mspi_TXRAM22_txram(aData)
        write_mspi_TXRAM22_txram_value = aData
        flag_mspi_TXRAM22_txram        = &H1
    End Property

    Property Get read_mspi_TXRAM22_txram
        read
        read_mspi_TXRAM22_txram = read_mspi_TXRAM22_txram_value
    End Property

    Property Let write_mspi_TXRAM22_txram(aData)
        set_mspi_TXRAM22_txram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_TXRAM22_txram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_TXRAM22_txram_mask = mask then
                read_mspi_TXRAM22_txram_value = data_low
            else
                read_mspi_TXRAM22_txram_value = (data_low - H8000_0000) and mspi_TXRAM22_txram_mask
            end If
        else
            read_mspi_TXRAM22_txram_value = data_low and mspi_TXRAM22_txram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_TXRAM22_txram = &H0 Then read
        If flag_mspi_TXRAM22_txram = &H0 Then write_mspi_TXRAM22_txram_value = get_mspi_TXRAM22_txram

        regValue = leftShift((write_mspi_TXRAM22_txram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_TXRAM22_txram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_TXRAM22_txram_mask = mask then
                read_mspi_TXRAM22_txram_value = data_low
            else
                read_mspi_TXRAM22_txram_value = (data_low - H8000_0000) and mspi_TXRAM22_txram_mask
            end If
        else
            read_mspi_TXRAM22_txram_value = data_low and mspi_TXRAM22_txram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_TXRAM22_txram_value = &H0
        flag_mspi_TXRAM22_txram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_txram23
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_TXRAM23_txram                         [7:0]            get_mspi_TXRAM23_txram
''                                                             set_mspi_TXRAM23_txram
''                                                             read_mspi_TXRAM23_txram
''                                                             write_mspi_TXRAM23_txram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_txram23
    Private write_mspi_TXRAM23_txram_value
    Private read_mspi_TXRAM23_txram_value
    Private flag_mspi_TXRAM23_txram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H29c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_TXRAM23_txram
        get_mspi_TXRAM23_txram = read_mspi_TXRAM23_txram_value
    End Property

    Property Let set_mspi_TXRAM23_txram(aData)
        write_mspi_TXRAM23_txram_value = aData
        flag_mspi_TXRAM23_txram        = &H1
    End Property

    Property Get read_mspi_TXRAM23_txram
        read
        read_mspi_TXRAM23_txram = read_mspi_TXRAM23_txram_value
    End Property

    Property Let write_mspi_TXRAM23_txram(aData)
        set_mspi_TXRAM23_txram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_TXRAM23_txram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_TXRAM23_txram_mask = mask then
                read_mspi_TXRAM23_txram_value = data_low
            else
                read_mspi_TXRAM23_txram_value = (data_low - H8000_0000) and mspi_TXRAM23_txram_mask
            end If
        else
            read_mspi_TXRAM23_txram_value = data_low and mspi_TXRAM23_txram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_TXRAM23_txram = &H0 Then read
        If flag_mspi_TXRAM23_txram = &H0 Then write_mspi_TXRAM23_txram_value = get_mspi_TXRAM23_txram

        regValue = leftShift((write_mspi_TXRAM23_txram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_TXRAM23_txram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_TXRAM23_txram_mask = mask then
                read_mspi_TXRAM23_txram_value = data_low
            else
                read_mspi_TXRAM23_txram_value = (data_low - H8000_0000) and mspi_TXRAM23_txram_mask
            end If
        else
            read_mspi_TXRAM23_txram_value = data_low and mspi_TXRAM23_txram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_TXRAM23_txram_value = &H0
        flag_mspi_TXRAM23_txram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_txram24
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_TXRAM24_txram                         [7:0]            get_mspi_TXRAM24_txram
''                                                             set_mspi_TXRAM24_txram
''                                                             read_mspi_TXRAM24_txram
''                                                             write_mspi_TXRAM24_txram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_txram24
    Private write_mspi_TXRAM24_txram_value
    Private read_mspi_TXRAM24_txram_value
    Private flag_mspi_TXRAM24_txram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2a0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_TXRAM24_txram
        get_mspi_TXRAM24_txram = read_mspi_TXRAM24_txram_value
    End Property

    Property Let set_mspi_TXRAM24_txram(aData)
        write_mspi_TXRAM24_txram_value = aData
        flag_mspi_TXRAM24_txram        = &H1
    End Property

    Property Get read_mspi_TXRAM24_txram
        read
        read_mspi_TXRAM24_txram = read_mspi_TXRAM24_txram_value
    End Property

    Property Let write_mspi_TXRAM24_txram(aData)
        set_mspi_TXRAM24_txram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_TXRAM24_txram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_TXRAM24_txram_mask = mask then
                read_mspi_TXRAM24_txram_value = data_low
            else
                read_mspi_TXRAM24_txram_value = (data_low - H8000_0000) and mspi_TXRAM24_txram_mask
            end If
        else
            read_mspi_TXRAM24_txram_value = data_low and mspi_TXRAM24_txram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_TXRAM24_txram = &H0 Then read
        If flag_mspi_TXRAM24_txram = &H0 Then write_mspi_TXRAM24_txram_value = get_mspi_TXRAM24_txram

        regValue = leftShift((write_mspi_TXRAM24_txram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_TXRAM24_txram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_TXRAM24_txram_mask = mask then
                read_mspi_TXRAM24_txram_value = data_low
            else
                read_mspi_TXRAM24_txram_value = (data_low - H8000_0000) and mspi_TXRAM24_txram_mask
            end If
        else
            read_mspi_TXRAM24_txram_value = data_low and mspi_TXRAM24_txram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_TXRAM24_txram_value = &H0
        flag_mspi_TXRAM24_txram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_txram25
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_TXRAM25_txram                         [7:0]            get_mspi_TXRAM25_txram
''                                                             set_mspi_TXRAM25_txram
''                                                             read_mspi_TXRAM25_txram
''                                                             write_mspi_TXRAM25_txram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_txram25
    Private write_mspi_TXRAM25_txram_value
    Private read_mspi_TXRAM25_txram_value
    Private flag_mspi_TXRAM25_txram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2a4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_TXRAM25_txram
        get_mspi_TXRAM25_txram = read_mspi_TXRAM25_txram_value
    End Property

    Property Let set_mspi_TXRAM25_txram(aData)
        write_mspi_TXRAM25_txram_value = aData
        flag_mspi_TXRAM25_txram        = &H1
    End Property

    Property Get read_mspi_TXRAM25_txram
        read
        read_mspi_TXRAM25_txram = read_mspi_TXRAM25_txram_value
    End Property

    Property Let write_mspi_TXRAM25_txram(aData)
        set_mspi_TXRAM25_txram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_TXRAM25_txram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_TXRAM25_txram_mask = mask then
                read_mspi_TXRAM25_txram_value = data_low
            else
                read_mspi_TXRAM25_txram_value = (data_low - H8000_0000) and mspi_TXRAM25_txram_mask
            end If
        else
            read_mspi_TXRAM25_txram_value = data_low and mspi_TXRAM25_txram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_TXRAM25_txram = &H0 Then read
        If flag_mspi_TXRAM25_txram = &H0 Then write_mspi_TXRAM25_txram_value = get_mspi_TXRAM25_txram

        regValue = leftShift((write_mspi_TXRAM25_txram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_TXRAM25_txram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_TXRAM25_txram_mask = mask then
                read_mspi_TXRAM25_txram_value = data_low
            else
                read_mspi_TXRAM25_txram_value = (data_low - H8000_0000) and mspi_TXRAM25_txram_mask
            end If
        else
            read_mspi_TXRAM25_txram_value = data_low and mspi_TXRAM25_txram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_TXRAM25_txram_value = &H0
        flag_mspi_TXRAM25_txram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_txram26
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_TXRAM26_txram                         [7:0]            get_mspi_TXRAM26_txram
''                                                             set_mspi_TXRAM26_txram
''                                                             read_mspi_TXRAM26_txram
''                                                             write_mspi_TXRAM26_txram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_txram26
    Private write_mspi_TXRAM26_txram_value
    Private read_mspi_TXRAM26_txram_value
    Private flag_mspi_TXRAM26_txram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2a8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_TXRAM26_txram
        get_mspi_TXRAM26_txram = read_mspi_TXRAM26_txram_value
    End Property

    Property Let set_mspi_TXRAM26_txram(aData)
        write_mspi_TXRAM26_txram_value = aData
        flag_mspi_TXRAM26_txram        = &H1
    End Property

    Property Get read_mspi_TXRAM26_txram
        read
        read_mspi_TXRAM26_txram = read_mspi_TXRAM26_txram_value
    End Property

    Property Let write_mspi_TXRAM26_txram(aData)
        set_mspi_TXRAM26_txram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_TXRAM26_txram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_TXRAM26_txram_mask = mask then
                read_mspi_TXRAM26_txram_value = data_low
            else
                read_mspi_TXRAM26_txram_value = (data_low - H8000_0000) and mspi_TXRAM26_txram_mask
            end If
        else
            read_mspi_TXRAM26_txram_value = data_low and mspi_TXRAM26_txram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_TXRAM26_txram = &H0 Then read
        If flag_mspi_TXRAM26_txram = &H0 Then write_mspi_TXRAM26_txram_value = get_mspi_TXRAM26_txram

        regValue = leftShift((write_mspi_TXRAM26_txram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_TXRAM26_txram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_TXRAM26_txram_mask = mask then
                read_mspi_TXRAM26_txram_value = data_low
            else
                read_mspi_TXRAM26_txram_value = (data_low - H8000_0000) and mspi_TXRAM26_txram_mask
            end If
        else
            read_mspi_TXRAM26_txram_value = data_low and mspi_TXRAM26_txram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_TXRAM26_txram_value = &H0
        flag_mspi_TXRAM26_txram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_txram27
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_TXRAM27_txram                         [7:0]            get_mspi_TXRAM27_txram
''                                                             set_mspi_TXRAM27_txram
''                                                             read_mspi_TXRAM27_txram
''                                                             write_mspi_TXRAM27_txram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_txram27
    Private write_mspi_TXRAM27_txram_value
    Private read_mspi_TXRAM27_txram_value
    Private flag_mspi_TXRAM27_txram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2ac
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_TXRAM27_txram
        get_mspi_TXRAM27_txram = read_mspi_TXRAM27_txram_value
    End Property

    Property Let set_mspi_TXRAM27_txram(aData)
        write_mspi_TXRAM27_txram_value = aData
        flag_mspi_TXRAM27_txram        = &H1
    End Property

    Property Get read_mspi_TXRAM27_txram
        read
        read_mspi_TXRAM27_txram = read_mspi_TXRAM27_txram_value
    End Property

    Property Let write_mspi_TXRAM27_txram(aData)
        set_mspi_TXRAM27_txram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_TXRAM27_txram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_TXRAM27_txram_mask = mask then
                read_mspi_TXRAM27_txram_value = data_low
            else
                read_mspi_TXRAM27_txram_value = (data_low - H8000_0000) and mspi_TXRAM27_txram_mask
            end If
        else
            read_mspi_TXRAM27_txram_value = data_low and mspi_TXRAM27_txram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_TXRAM27_txram = &H0 Then read
        If flag_mspi_TXRAM27_txram = &H0 Then write_mspi_TXRAM27_txram_value = get_mspi_TXRAM27_txram

        regValue = leftShift((write_mspi_TXRAM27_txram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_TXRAM27_txram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_TXRAM27_txram_mask = mask then
                read_mspi_TXRAM27_txram_value = data_low
            else
                read_mspi_TXRAM27_txram_value = (data_low - H8000_0000) and mspi_TXRAM27_txram_mask
            end If
        else
            read_mspi_TXRAM27_txram_value = data_low and mspi_TXRAM27_txram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_TXRAM27_txram_value = &H0
        flag_mspi_TXRAM27_txram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_txram28
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_TXRAM28_txram                         [7:0]            get_mspi_TXRAM28_txram
''                                                             set_mspi_TXRAM28_txram
''                                                             read_mspi_TXRAM28_txram
''                                                             write_mspi_TXRAM28_txram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_txram28
    Private write_mspi_TXRAM28_txram_value
    Private read_mspi_TXRAM28_txram_value
    Private flag_mspi_TXRAM28_txram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2b0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_TXRAM28_txram
        get_mspi_TXRAM28_txram = read_mspi_TXRAM28_txram_value
    End Property

    Property Let set_mspi_TXRAM28_txram(aData)
        write_mspi_TXRAM28_txram_value = aData
        flag_mspi_TXRAM28_txram        = &H1
    End Property

    Property Get read_mspi_TXRAM28_txram
        read
        read_mspi_TXRAM28_txram = read_mspi_TXRAM28_txram_value
    End Property

    Property Let write_mspi_TXRAM28_txram(aData)
        set_mspi_TXRAM28_txram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_TXRAM28_txram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_TXRAM28_txram_mask = mask then
                read_mspi_TXRAM28_txram_value = data_low
            else
                read_mspi_TXRAM28_txram_value = (data_low - H8000_0000) and mspi_TXRAM28_txram_mask
            end If
        else
            read_mspi_TXRAM28_txram_value = data_low and mspi_TXRAM28_txram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_TXRAM28_txram = &H0 Then read
        If flag_mspi_TXRAM28_txram = &H0 Then write_mspi_TXRAM28_txram_value = get_mspi_TXRAM28_txram

        regValue = leftShift((write_mspi_TXRAM28_txram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_TXRAM28_txram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_TXRAM28_txram_mask = mask then
                read_mspi_TXRAM28_txram_value = data_low
            else
                read_mspi_TXRAM28_txram_value = (data_low - H8000_0000) and mspi_TXRAM28_txram_mask
            end If
        else
            read_mspi_TXRAM28_txram_value = data_low and mspi_TXRAM28_txram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_TXRAM28_txram_value = &H0
        flag_mspi_TXRAM28_txram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_txram29
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_TXRAM29_txram                         [7:0]            get_mspi_TXRAM29_txram
''                                                             set_mspi_TXRAM29_txram
''                                                             read_mspi_TXRAM29_txram
''                                                             write_mspi_TXRAM29_txram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_txram29
    Private write_mspi_TXRAM29_txram_value
    Private read_mspi_TXRAM29_txram_value
    Private flag_mspi_TXRAM29_txram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2b4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_TXRAM29_txram
        get_mspi_TXRAM29_txram = read_mspi_TXRAM29_txram_value
    End Property

    Property Let set_mspi_TXRAM29_txram(aData)
        write_mspi_TXRAM29_txram_value = aData
        flag_mspi_TXRAM29_txram        = &H1
    End Property

    Property Get read_mspi_TXRAM29_txram
        read
        read_mspi_TXRAM29_txram = read_mspi_TXRAM29_txram_value
    End Property

    Property Let write_mspi_TXRAM29_txram(aData)
        set_mspi_TXRAM29_txram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_TXRAM29_txram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_TXRAM29_txram_mask = mask then
                read_mspi_TXRAM29_txram_value = data_low
            else
                read_mspi_TXRAM29_txram_value = (data_low - H8000_0000) and mspi_TXRAM29_txram_mask
            end If
        else
            read_mspi_TXRAM29_txram_value = data_low and mspi_TXRAM29_txram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_TXRAM29_txram = &H0 Then read
        If flag_mspi_TXRAM29_txram = &H0 Then write_mspi_TXRAM29_txram_value = get_mspi_TXRAM29_txram

        regValue = leftShift((write_mspi_TXRAM29_txram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_TXRAM29_txram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_TXRAM29_txram_mask = mask then
                read_mspi_TXRAM29_txram_value = data_low
            else
                read_mspi_TXRAM29_txram_value = (data_low - H8000_0000) and mspi_TXRAM29_txram_mask
            end If
        else
            read_mspi_TXRAM29_txram_value = data_low and mspi_TXRAM29_txram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_TXRAM29_txram_value = &H0
        flag_mspi_TXRAM29_txram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_txram30
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_TXRAM30_txram                         [7:0]            get_mspi_TXRAM30_txram
''                                                             set_mspi_TXRAM30_txram
''                                                             read_mspi_TXRAM30_txram
''                                                             write_mspi_TXRAM30_txram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_txram30
    Private write_mspi_TXRAM30_txram_value
    Private read_mspi_TXRAM30_txram_value
    Private flag_mspi_TXRAM30_txram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2b8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_TXRAM30_txram
        get_mspi_TXRAM30_txram = read_mspi_TXRAM30_txram_value
    End Property

    Property Let set_mspi_TXRAM30_txram(aData)
        write_mspi_TXRAM30_txram_value = aData
        flag_mspi_TXRAM30_txram        = &H1
    End Property

    Property Get read_mspi_TXRAM30_txram
        read
        read_mspi_TXRAM30_txram = read_mspi_TXRAM30_txram_value
    End Property

    Property Let write_mspi_TXRAM30_txram(aData)
        set_mspi_TXRAM30_txram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_TXRAM30_txram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_TXRAM30_txram_mask = mask then
                read_mspi_TXRAM30_txram_value = data_low
            else
                read_mspi_TXRAM30_txram_value = (data_low - H8000_0000) and mspi_TXRAM30_txram_mask
            end If
        else
            read_mspi_TXRAM30_txram_value = data_low and mspi_TXRAM30_txram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_TXRAM30_txram = &H0 Then read
        If flag_mspi_TXRAM30_txram = &H0 Then write_mspi_TXRAM30_txram_value = get_mspi_TXRAM30_txram

        regValue = leftShift((write_mspi_TXRAM30_txram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_TXRAM30_txram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_TXRAM30_txram_mask = mask then
                read_mspi_TXRAM30_txram_value = data_low
            else
                read_mspi_TXRAM30_txram_value = (data_low - H8000_0000) and mspi_TXRAM30_txram_mask
            end If
        else
            read_mspi_TXRAM30_txram_value = data_low and mspi_TXRAM30_txram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_TXRAM30_txram_value = &H0
        flag_mspi_TXRAM30_txram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_txram31
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_TXRAM31_txram                         [7:0]            get_mspi_TXRAM31_txram
''                                                             set_mspi_TXRAM31_txram
''                                                             read_mspi_TXRAM31_txram
''                                                             write_mspi_TXRAM31_txram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_txram31
    Private write_mspi_TXRAM31_txram_value
    Private read_mspi_TXRAM31_txram_value
    Private flag_mspi_TXRAM31_txram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2bc
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_TXRAM31_txram
        get_mspi_TXRAM31_txram = read_mspi_TXRAM31_txram_value
    End Property

    Property Let set_mspi_TXRAM31_txram(aData)
        write_mspi_TXRAM31_txram_value = aData
        flag_mspi_TXRAM31_txram        = &H1
    End Property

    Property Get read_mspi_TXRAM31_txram
        read
        read_mspi_TXRAM31_txram = read_mspi_TXRAM31_txram_value
    End Property

    Property Let write_mspi_TXRAM31_txram(aData)
        set_mspi_TXRAM31_txram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_TXRAM31_txram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_TXRAM31_txram_mask = mask then
                read_mspi_TXRAM31_txram_value = data_low
            else
                read_mspi_TXRAM31_txram_value = (data_low - H8000_0000) and mspi_TXRAM31_txram_mask
            end If
        else
            read_mspi_TXRAM31_txram_value = data_low and mspi_TXRAM31_txram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_TXRAM31_txram = &H0 Then read
        If flag_mspi_TXRAM31_txram = &H0 Then write_mspi_TXRAM31_txram_value = get_mspi_TXRAM31_txram

        regValue = leftShift((write_mspi_TXRAM31_txram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_TXRAM31_txram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_TXRAM31_txram_mask = mask then
                read_mspi_TXRAM31_txram_value = data_low
            else
                read_mspi_TXRAM31_txram_value = (data_low - H8000_0000) and mspi_TXRAM31_txram_mask
            end If
        else
            read_mspi_TXRAM31_txram_value = data_low and mspi_TXRAM31_txram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_TXRAM31_txram_value = &H0
        flag_mspi_TXRAM31_txram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_rxram00
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_RXRAM00_rxram                         [7:0]            get_mspi_RXRAM00_rxram
''                                                             set_mspi_RXRAM00_rxram
''                                                             read_mspi_RXRAM00_rxram
''                                                             write_mspi_RXRAM00_rxram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_rxram00
    Private write_mspi_RXRAM00_rxram_value
    Private read_mspi_RXRAM00_rxram_value
    Private flag_mspi_RXRAM00_rxram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2c0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_RXRAM00_rxram
        get_mspi_RXRAM00_rxram = read_mspi_RXRAM00_rxram_value
    End Property

    Property Let set_mspi_RXRAM00_rxram(aData)
        write_mspi_RXRAM00_rxram_value = aData
        flag_mspi_RXRAM00_rxram        = &H1
    End Property

    Property Get read_mspi_RXRAM00_rxram
        read
        read_mspi_RXRAM00_rxram = read_mspi_RXRAM00_rxram_value
    End Property

    Property Let write_mspi_RXRAM00_rxram(aData)
        set_mspi_RXRAM00_rxram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_RXRAM00_rxram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_RXRAM00_rxram_mask = mask then
                read_mspi_RXRAM00_rxram_value = data_low
            else
                read_mspi_RXRAM00_rxram_value = (data_low - H8000_0000) and mspi_RXRAM00_rxram_mask
            end If
        else
            read_mspi_RXRAM00_rxram_value = data_low and mspi_RXRAM00_rxram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_RXRAM00_rxram = &H0 Then read
        If flag_mspi_RXRAM00_rxram = &H0 Then write_mspi_RXRAM00_rxram_value = get_mspi_RXRAM00_rxram

        regValue = leftShift((write_mspi_RXRAM00_rxram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_RXRAM00_rxram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_RXRAM00_rxram_mask = mask then
                read_mspi_RXRAM00_rxram_value = data_low
            else
                read_mspi_RXRAM00_rxram_value = (data_low - H8000_0000) and mspi_RXRAM00_rxram_mask
            end If
        else
            read_mspi_RXRAM00_rxram_value = data_low and mspi_RXRAM00_rxram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_RXRAM00_rxram_value = &H0
        flag_mspi_RXRAM00_rxram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_rxram01
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_RXRAM01_rxram                         [7:0]            get_mspi_RXRAM01_rxram
''                                                             set_mspi_RXRAM01_rxram
''                                                             read_mspi_RXRAM01_rxram
''                                                             write_mspi_RXRAM01_rxram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_rxram01
    Private write_mspi_RXRAM01_rxram_value
    Private read_mspi_RXRAM01_rxram_value
    Private flag_mspi_RXRAM01_rxram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2c4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_RXRAM01_rxram
        get_mspi_RXRAM01_rxram = read_mspi_RXRAM01_rxram_value
    End Property

    Property Let set_mspi_RXRAM01_rxram(aData)
        write_mspi_RXRAM01_rxram_value = aData
        flag_mspi_RXRAM01_rxram        = &H1
    End Property

    Property Get read_mspi_RXRAM01_rxram
        read
        read_mspi_RXRAM01_rxram = read_mspi_RXRAM01_rxram_value
    End Property

    Property Let write_mspi_RXRAM01_rxram(aData)
        set_mspi_RXRAM01_rxram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_RXRAM01_rxram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_RXRAM01_rxram_mask = mask then
                read_mspi_RXRAM01_rxram_value = data_low
            else
                read_mspi_RXRAM01_rxram_value = (data_low - H8000_0000) and mspi_RXRAM01_rxram_mask
            end If
        else
            read_mspi_RXRAM01_rxram_value = data_low and mspi_RXRAM01_rxram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_RXRAM01_rxram = &H0 Then read
        If flag_mspi_RXRAM01_rxram = &H0 Then write_mspi_RXRAM01_rxram_value = get_mspi_RXRAM01_rxram

        regValue = leftShift((write_mspi_RXRAM01_rxram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_RXRAM01_rxram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_RXRAM01_rxram_mask = mask then
                read_mspi_RXRAM01_rxram_value = data_low
            else
                read_mspi_RXRAM01_rxram_value = (data_low - H8000_0000) and mspi_RXRAM01_rxram_mask
            end If
        else
            read_mspi_RXRAM01_rxram_value = data_low and mspi_RXRAM01_rxram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_RXRAM01_rxram_value = &H0
        flag_mspi_RXRAM01_rxram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_rxram02
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_RXRAM02_rxram                         [7:0]            get_mspi_RXRAM02_rxram
''                                                             set_mspi_RXRAM02_rxram
''                                                             read_mspi_RXRAM02_rxram
''                                                             write_mspi_RXRAM02_rxram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_rxram02
    Private write_mspi_RXRAM02_rxram_value
    Private read_mspi_RXRAM02_rxram_value
    Private flag_mspi_RXRAM02_rxram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2c8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_RXRAM02_rxram
        get_mspi_RXRAM02_rxram = read_mspi_RXRAM02_rxram_value
    End Property

    Property Let set_mspi_RXRAM02_rxram(aData)
        write_mspi_RXRAM02_rxram_value = aData
        flag_mspi_RXRAM02_rxram        = &H1
    End Property

    Property Get read_mspi_RXRAM02_rxram
        read
        read_mspi_RXRAM02_rxram = read_mspi_RXRAM02_rxram_value
    End Property

    Property Let write_mspi_RXRAM02_rxram(aData)
        set_mspi_RXRAM02_rxram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_RXRAM02_rxram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_RXRAM02_rxram_mask = mask then
                read_mspi_RXRAM02_rxram_value = data_low
            else
                read_mspi_RXRAM02_rxram_value = (data_low - H8000_0000) and mspi_RXRAM02_rxram_mask
            end If
        else
            read_mspi_RXRAM02_rxram_value = data_low and mspi_RXRAM02_rxram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_RXRAM02_rxram = &H0 Then read
        If flag_mspi_RXRAM02_rxram = &H0 Then write_mspi_RXRAM02_rxram_value = get_mspi_RXRAM02_rxram

        regValue = leftShift((write_mspi_RXRAM02_rxram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_RXRAM02_rxram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_RXRAM02_rxram_mask = mask then
                read_mspi_RXRAM02_rxram_value = data_low
            else
                read_mspi_RXRAM02_rxram_value = (data_low - H8000_0000) and mspi_RXRAM02_rxram_mask
            end If
        else
            read_mspi_RXRAM02_rxram_value = data_low and mspi_RXRAM02_rxram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_RXRAM02_rxram_value = &H0
        flag_mspi_RXRAM02_rxram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_rxram03
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_RXRAM03_rxram                         [7:0]            get_mspi_RXRAM03_rxram
''                                                             set_mspi_RXRAM03_rxram
''                                                             read_mspi_RXRAM03_rxram
''                                                             write_mspi_RXRAM03_rxram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_rxram03
    Private write_mspi_RXRAM03_rxram_value
    Private read_mspi_RXRAM03_rxram_value
    Private flag_mspi_RXRAM03_rxram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2cc
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_RXRAM03_rxram
        get_mspi_RXRAM03_rxram = read_mspi_RXRAM03_rxram_value
    End Property

    Property Let set_mspi_RXRAM03_rxram(aData)
        write_mspi_RXRAM03_rxram_value = aData
        flag_mspi_RXRAM03_rxram        = &H1
    End Property

    Property Get read_mspi_RXRAM03_rxram
        read
        read_mspi_RXRAM03_rxram = read_mspi_RXRAM03_rxram_value
    End Property

    Property Let write_mspi_RXRAM03_rxram(aData)
        set_mspi_RXRAM03_rxram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_RXRAM03_rxram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_RXRAM03_rxram_mask = mask then
                read_mspi_RXRAM03_rxram_value = data_low
            else
                read_mspi_RXRAM03_rxram_value = (data_low - H8000_0000) and mspi_RXRAM03_rxram_mask
            end If
        else
            read_mspi_RXRAM03_rxram_value = data_low and mspi_RXRAM03_rxram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_RXRAM03_rxram = &H0 Then read
        If flag_mspi_RXRAM03_rxram = &H0 Then write_mspi_RXRAM03_rxram_value = get_mspi_RXRAM03_rxram

        regValue = leftShift((write_mspi_RXRAM03_rxram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_RXRAM03_rxram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_RXRAM03_rxram_mask = mask then
                read_mspi_RXRAM03_rxram_value = data_low
            else
                read_mspi_RXRAM03_rxram_value = (data_low - H8000_0000) and mspi_RXRAM03_rxram_mask
            end If
        else
            read_mspi_RXRAM03_rxram_value = data_low and mspi_RXRAM03_rxram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_RXRAM03_rxram_value = &H0
        flag_mspi_RXRAM03_rxram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_rxram04
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_RXRAM04_rxram                         [7:0]            get_mspi_RXRAM04_rxram
''                                                             set_mspi_RXRAM04_rxram
''                                                             read_mspi_RXRAM04_rxram
''                                                             write_mspi_RXRAM04_rxram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_rxram04
    Private write_mspi_RXRAM04_rxram_value
    Private read_mspi_RXRAM04_rxram_value
    Private flag_mspi_RXRAM04_rxram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2d0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_RXRAM04_rxram
        get_mspi_RXRAM04_rxram = read_mspi_RXRAM04_rxram_value
    End Property

    Property Let set_mspi_RXRAM04_rxram(aData)
        write_mspi_RXRAM04_rxram_value = aData
        flag_mspi_RXRAM04_rxram        = &H1
    End Property

    Property Get read_mspi_RXRAM04_rxram
        read
        read_mspi_RXRAM04_rxram = read_mspi_RXRAM04_rxram_value
    End Property

    Property Let write_mspi_RXRAM04_rxram(aData)
        set_mspi_RXRAM04_rxram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_RXRAM04_rxram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_RXRAM04_rxram_mask = mask then
                read_mspi_RXRAM04_rxram_value = data_low
            else
                read_mspi_RXRAM04_rxram_value = (data_low - H8000_0000) and mspi_RXRAM04_rxram_mask
            end If
        else
            read_mspi_RXRAM04_rxram_value = data_low and mspi_RXRAM04_rxram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_RXRAM04_rxram = &H0 Then read
        If flag_mspi_RXRAM04_rxram = &H0 Then write_mspi_RXRAM04_rxram_value = get_mspi_RXRAM04_rxram

        regValue = leftShift((write_mspi_RXRAM04_rxram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_RXRAM04_rxram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_RXRAM04_rxram_mask = mask then
                read_mspi_RXRAM04_rxram_value = data_low
            else
                read_mspi_RXRAM04_rxram_value = (data_low - H8000_0000) and mspi_RXRAM04_rxram_mask
            end If
        else
            read_mspi_RXRAM04_rxram_value = data_low and mspi_RXRAM04_rxram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_RXRAM04_rxram_value = &H0
        flag_mspi_RXRAM04_rxram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_rxram05
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_RXRAM05_rxram                         [7:0]            get_mspi_RXRAM05_rxram
''                                                             set_mspi_RXRAM05_rxram
''                                                             read_mspi_RXRAM05_rxram
''                                                             write_mspi_RXRAM05_rxram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_rxram05
    Private write_mspi_RXRAM05_rxram_value
    Private read_mspi_RXRAM05_rxram_value
    Private flag_mspi_RXRAM05_rxram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2d4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_RXRAM05_rxram
        get_mspi_RXRAM05_rxram = read_mspi_RXRAM05_rxram_value
    End Property

    Property Let set_mspi_RXRAM05_rxram(aData)
        write_mspi_RXRAM05_rxram_value = aData
        flag_mspi_RXRAM05_rxram        = &H1
    End Property

    Property Get read_mspi_RXRAM05_rxram
        read
        read_mspi_RXRAM05_rxram = read_mspi_RXRAM05_rxram_value
    End Property

    Property Let write_mspi_RXRAM05_rxram(aData)
        set_mspi_RXRAM05_rxram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_RXRAM05_rxram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_RXRAM05_rxram_mask = mask then
                read_mspi_RXRAM05_rxram_value = data_low
            else
                read_mspi_RXRAM05_rxram_value = (data_low - H8000_0000) and mspi_RXRAM05_rxram_mask
            end If
        else
            read_mspi_RXRAM05_rxram_value = data_low and mspi_RXRAM05_rxram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_RXRAM05_rxram = &H0 Then read
        If flag_mspi_RXRAM05_rxram = &H0 Then write_mspi_RXRAM05_rxram_value = get_mspi_RXRAM05_rxram

        regValue = leftShift((write_mspi_RXRAM05_rxram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_RXRAM05_rxram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_RXRAM05_rxram_mask = mask then
                read_mspi_RXRAM05_rxram_value = data_low
            else
                read_mspi_RXRAM05_rxram_value = (data_low - H8000_0000) and mspi_RXRAM05_rxram_mask
            end If
        else
            read_mspi_RXRAM05_rxram_value = data_low and mspi_RXRAM05_rxram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_RXRAM05_rxram_value = &H0
        flag_mspi_RXRAM05_rxram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_rxram06
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_RXRAM06_rxram                         [7:0]            get_mspi_RXRAM06_rxram
''                                                             set_mspi_RXRAM06_rxram
''                                                             read_mspi_RXRAM06_rxram
''                                                             write_mspi_RXRAM06_rxram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_rxram06
    Private write_mspi_RXRAM06_rxram_value
    Private read_mspi_RXRAM06_rxram_value
    Private flag_mspi_RXRAM06_rxram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2d8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_RXRAM06_rxram
        get_mspi_RXRAM06_rxram = read_mspi_RXRAM06_rxram_value
    End Property

    Property Let set_mspi_RXRAM06_rxram(aData)
        write_mspi_RXRAM06_rxram_value = aData
        flag_mspi_RXRAM06_rxram        = &H1
    End Property

    Property Get read_mspi_RXRAM06_rxram
        read
        read_mspi_RXRAM06_rxram = read_mspi_RXRAM06_rxram_value
    End Property

    Property Let write_mspi_RXRAM06_rxram(aData)
        set_mspi_RXRAM06_rxram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_RXRAM06_rxram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_RXRAM06_rxram_mask = mask then
                read_mspi_RXRAM06_rxram_value = data_low
            else
                read_mspi_RXRAM06_rxram_value = (data_low - H8000_0000) and mspi_RXRAM06_rxram_mask
            end If
        else
            read_mspi_RXRAM06_rxram_value = data_low and mspi_RXRAM06_rxram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_RXRAM06_rxram = &H0 Then read
        If flag_mspi_RXRAM06_rxram = &H0 Then write_mspi_RXRAM06_rxram_value = get_mspi_RXRAM06_rxram

        regValue = leftShift((write_mspi_RXRAM06_rxram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_RXRAM06_rxram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_RXRAM06_rxram_mask = mask then
                read_mspi_RXRAM06_rxram_value = data_low
            else
                read_mspi_RXRAM06_rxram_value = (data_low - H8000_0000) and mspi_RXRAM06_rxram_mask
            end If
        else
            read_mspi_RXRAM06_rxram_value = data_low and mspi_RXRAM06_rxram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_RXRAM06_rxram_value = &H0
        flag_mspi_RXRAM06_rxram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_rxram07
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_RXRAM07_rxram                         [7:0]            get_mspi_RXRAM07_rxram
''                                                             set_mspi_RXRAM07_rxram
''                                                             read_mspi_RXRAM07_rxram
''                                                             write_mspi_RXRAM07_rxram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_rxram07
    Private write_mspi_RXRAM07_rxram_value
    Private read_mspi_RXRAM07_rxram_value
    Private flag_mspi_RXRAM07_rxram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2dc
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_RXRAM07_rxram
        get_mspi_RXRAM07_rxram = read_mspi_RXRAM07_rxram_value
    End Property

    Property Let set_mspi_RXRAM07_rxram(aData)
        write_mspi_RXRAM07_rxram_value = aData
        flag_mspi_RXRAM07_rxram        = &H1
    End Property

    Property Get read_mspi_RXRAM07_rxram
        read
        read_mspi_RXRAM07_rxram = read_mspi_RXRAM07_rxram_value
    End Property

    Property Let write_mspi_RXRAM07_rxram(aData)
        set_mspi_RXRAM07_rxram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_RXRAM07_rxram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_RXRAM07_rxram_mask = mask then
                read_mspi_RXRAM07_rxram_value = data_low
            else
                read_mspi_RXRAM07_rxram_value = (data_low - H8000_0000) and mspi_RXRAM07_rxram_mask
            end If
        else
            read_mspi_RXRAM07_rxram_value = data_low and mspi_RXRAM07_rxram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_RXRAM07_rxram = &H0 Then read
        If flag_mspi_RXRAM07_rxram = &H0 Then write_mspi_RXRAM07_rxram_value = get_mspi_RXRAM07_rxram

        regValue = leftShift((write_mspi_RXRAM07_rxram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_RXRAM07_rxram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_RXRAM07_rxram_mask = mask then
                read_mspi_RXRAM07_rxram_value = data_low
            else
                read_mspi_RXRAM07_rxram_value = (data_low - H8000_0000) and mspi_RXRAM07_rxram_mask
            end If
        else
            read_mspi_RXRAM07_rxram_value = data_low and mspi_RXRAM07_rxram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_RXRAM07_rxram_value = &H0
        flag_mspi_RXRAM07_rxram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_rxram08
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_RXRAM08_rxram                         [7:0]            get_mspi_RXRAM08_rxram
''                                                             set_mspi_RXRAM08_rxram
''                                                             read_mspi_RXRAM08_rxram
''                                                             write_mspi_RXRAM08_rxram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_rxram08
    Private write_mspi_RXRAM08_rxram_value
    Private read_mspi_RXRAM08_rxram_value
    Private flag_mspi_RXRAM08_rxram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2e0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_RXRAM08_rxram
        get_mspi_RXRAM08_rxram = read_mspi_RXRAM08_rxram_value
    End Property

    Property Let set_mspi_RXRAM08_rxram(aData)
        write_mspi_RXRAM08_rxram_value = aData
        flag_mspi_RXRAM08_rxram        = &H1
    End Property

    Property Get read_mspi_RXRAM08_rxram
        read
        read_mspi_RXRAM08_rxram = read_mspi_RXRAM08_rxram_value
    End Property

    Property Let write_mspi_RXRAM08_rxram(aData)
        set_mspi_RXRAM08_rxram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_RXRAM08_rxram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_RXRAM08_rxram_mask = mask then
                read_mspi_RXRAM08_rxram_value = data_low
            else
                read_mspi_RXRAM08_rxram_value = (data_low - H8000_0000) and mspi_RXRAM08_rxram_mask
            end If
        else
            read_mspi_RXRAM08_rxram_value = data_low and mspi_RXRAM08_rxram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_RXRAM08_rxram = &H0 Then read
        If flag_mspi_RXRAM08_rxram = &H0 Then write_mspi_RXRAM08_rxram_value = get_mspi_RXRAM08_rxram

        regValue = leftShift((write_mspi_RXRAM08_rxram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_RXRAM08_rxram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_RXRAM08_rxram_mask = mask then
                read_mspi_RXRAM08_rxram_value = data_low
            else
                read_mspi_RXRAM08_rxram_value = (data_low - H8000_0000) and mspi_RXRAM08_rxram_mask
            end If
        else
            read_mspi_RXRAM08_rxram_value = data_low and mspi_RXRAM08_rxram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_RXRAM08_rxram_value = &H0
        flag_mspi_RXRAM08_rxram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_rxram09
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_RXRAM09_rxram                         [7:0]            get_mspi_RXRAM09_rxram
''                                                             set_mspi_RXRAM09_rxram
''                                                             read_mspi_RXRAM09_rxram
''                                                             write_mspi_RXRAM09_rxram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_rxram09
    Private write_mspi_RXRAM09_rxram_value
    Private read_mspi_RXRAM09_rxram_value
    Private flag_mspi_RXRAM09_rxram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2e4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_RXRAM09_rxram
        get_mspi_RXRAM09_rxram = read_mspi_RXRAM09_rxram_value
    End Property

    Property Let set_mspi_RXRAM09_rxram(aData)
        write_mspi_RXRAM09_rxram_value = aData
        flag_mspi_RXRAM09_rxram        = &H1
    End Property

    Property Get read_mspi_RXRAM09_rxram
        read
        read_mspi_RXRAM09_rxram = read_mspi_RXRAM09_rxram_value
    End Property

    Property Let write_mspi_RXRAM09_rxram(aData)
        set_mspi_RXRAM09_rxram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_RXRAM09_rxram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_RXRAM09_rxram_mask = mask then
                read_mspi_RXRAM09_rxram_value = data_low
            else
                read_mspi_RXRAM09_rxram_value = (data_low - H8000_0000) and mspi_RXRAM09_rxram_mask
            end If
        else
            read_mspi_RXRAM09_rxram_value = data_low and mspi_RXRAM09_rxram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_RXRAM09_rxram = &H0 Then read
        If flag_mspi_RXRAM09_rxram = &H0 Then write_mspi_RXRAM09_rxram_value = get_mspi_RXRAM09_rxram

        regValue = leftShift((write_mspi_RXRAM09_rxram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_RXRAM09_rxram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_RXRAM09_rxram_mask = mask then
                read_mspi_RXRAM09_rxram_value = data_low
            else
                read_mspi_RXRAM09_rxram_value = (data_low - H8000_0000) and mspi_RXRAM09_rxram_mask
            end If
        else
            read_mspi_RXRAM09_rxram_value = data_low and mspi_RXRAM09_rxram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_RXRAM09_rxram_value = &H0
        flag_mspi_RXRAM09_rxram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_rxram10
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_RXRAM10_rxram                         [7:0]            get_mspi_RXRAM10_rxram
''                                                             set_mspi_RXRAM10_rxram
''                                                             read_mspi_RXRAM10_rxram
''                                                             write_mspi_RXRAM10_rxram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_rxram10
    Private write_mspi_RXRAM10_rxram_value
    Private read_mspi_RXRAM10_rxram_value
    Private flag_mspi_RXRAM10_rxram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2e8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_RXRAM10_rxram
        get_mspi_RXRAM10_rxram = read_mspi_RXRAM10_rxram_value
    End Property

    Property Let set_mspi_RXRAM10_rxram(aData)
        write_mspi_RXRAM10_rxram_value = aData
        flag_mspi_RXRAM10_rxram        = &H1
    End Property

    Property Get read_mspi_RXRAM10_rxram
        read
        read_mspi_RXRAM10_rxram = read_mspi_RXRAM10_rxram_value
    End Property

    Property Let write_mspi_RXRAM10_rxram(aData)
        set_mspi_RXRAM10_rxram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_RXRAM10_rxram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_RXRAM10_rxram_mask = mask then
                read_mspi_RXRAM10_rxram_value = data_low
            else
                read_mspi_RXRAM10_rxram_value = (data_low - H8000_0000) and mspi_RXRAM10_rxram_mask
            end If
        else
            read_mspi_RXRAM10_rxram_value = data_low and mspi_RXRAM10_rxram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_RXRAM10_rxram = &H0 Then read
        If flag_mspi_RXRAM10_rxram = &H0 Then write_mspi_RXRAM10_rxram_value = get_mspi_RXRAM10_rxram

        regValue = leftShift((write_mspi_RXRAM10_rxram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_RXRAM10_rxram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_RXRAM10_rxram_mask = mask then
                read_mspi_RXRAM10_rxram_value = data_low
            else
                read_mspi_RXRAM10_rxram_value = (data_low - H8000_0000) and mspi_RXRAM10_rxram_mask
            end If
        else
            read_mspi_RXRAM10_rxram_value = data_low and mspi_RXRAM10_rxram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_RXRAM10_rxram_value = &H0
        flag_mspi_RXRAM10_rxram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_rxram11
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_RXRAM11_rxram                         [7:0]            get_mspi_RXRAM11_rxram
''                                                             set_mspi_RXRAM11_rxram
''                                                             read_mspi_RXRAM11_rxram
''                                                             write_mspi_RXRAM11_rxram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_rxram11
    Private write_mspi_RXRAM11_rxram_value
    Private read_mspi_RXRAM11_rxram_value
    Private flag_mspi_RXRAM11_rxram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2ec
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_RXRAM11_rxram
        get_mspi_RXRAM11_rxram = read_mspi_RXRAM11_rxram_value
    End Property

    Property Let set_mspi_RXRAM11_rxram(aData)
        write_mspi_RXRAM11_rxram_value = aData
        flag_mspi_RXRAM11_rxram        = &H1
    End Property

    Property Get read_mspi_RXRAM11_rxram
        read
        read_mspi_RXRAM11_rxram = read_mspi_RXRAM11_rxram_value
    End Property

    Property Let write_mspi_RXRAM11_rxram(aData)
        set_mspi_RXRAM11_rxram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_RXRAM11_rxram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_RXRAM11_rxram_mask = mask then
                read_mspi_RXRAM11_rxram_value = data_low
            else
                read_mspi_RXRAM11_rxram_value = (data_low - H8000_0000) and mspi_RXRAM11_rxram_mask
            end If
        else
            read_mspi_RXRAM11_rxram_value = data_low and mspi_RXRAM11_rxram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_RXRAM11_rxram = &H0 Then read
        If flag_mspi_RXRAM11_rxram = &H0 Then write_mspi_RXRAM11_rxram_value = get_mspi_RXRAM11_rxram

        regValue = leftShift((write_mspi_RXRAM11_rxram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_RXRAM11_rxram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_RXRAM11_rxram_mask = mask then
                read_mspi_RXRAM11_rxram_value = data_low
            else
                read_mspi_RXRAM11_rxram_value = (data_low - H8000_0000) and mspi_RXRAM11_rxram_mask
            end If
        else
            read_mspi_RXRAM11_rxram_value = data_low and mspi_RXRAM11_rxram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_RXRAM11_rxram_value = &H0
        flag_mspi_RXRAM11_rxram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_rxram12
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_RXRAM12_rxram                         [7:0]            get_mspi_RXRAM12_rxram
''                                                             set_mspi_RXRAM12_rxram
''                                                             read_mspi_RXRAM12_rxram
''                                                             write_mspi_RXRAM12_rxram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_rxram12
    Private write_mspi_RXRAM12_rxram_value
    Private read_mspi_RXRAM12_rxram_value
    Private flag_mspi_RXRAM12_rxram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2f0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_RXRAM12_rxram
        get_mspi_RXRAM12_rxram = read_mspi_RXRAM12_rxram_value
    End Property

    Property Let set_mspi_RXRAM12_rxram(aData)
        write_mspi_RXRAM12_rxram_value = aData
        flag_mspi_RXRAM12_rxram        = &H1
    End Property

    Property Get read_mspi_RXRAM12_rxram
        read
        read_mspi_RXRAM12_rxram = read_mspi_RXRAM12_rxram_value
    End Property

    Property Let write_mspi_RXRAM12_rxram(aData)
        set_mspi_RXRAM12_rxram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_RXRAM12_rxram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_RXRAM12_rxram_mask = mask then
                read_mspi_RXRAM12_rxram_value = data_low
            else
                read_mspi_RXRAM12_rxram_value = (data_low - H8000_0000) and mspi_RXRAM12_rxram_mask
            end If
        else
            read_mspi_RXRAM12_rxram_value = data_low and mspi_RXRAM12_rxram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_RXRAM12_rxram = &H0 Then read
        If flag_mspi_RXRAM12_rxram = &H0 Then write_mspi_RXRAM12_rxram_value = get_mspi_RXRAM12_rxram

        regValue = leftShift((write_mspi_RXRAM12_rxram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_RXRAM12_rxram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_RXRAM12_rxram_mask = mask then
                read_mspi_RXRAM12_rxram_value = data_low
            else
                read_mspi_RXRAM12_rxram_value = (data_low - H8000_0000) and mspi_RXRAM12_rxram_mask
            end If
        else
            read_mspi_RXRAM12_rxram_value = data_low and mspi_RXRAM12_rxram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_RXRAM12_rxram_value = &H0
        flag_mspi_RXRAM12_rxram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_rxram13
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_RXRAM13_rxram                         [7:0]            get_mspi_RXRAM13_rxram
''                                                             set_mspi_RXRAM13_rxram
''                                                             read_mspi_RXRAM13_rxram
''                                                             write_mspi_RXRAM13_rxram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_rxram13
    Private write_mspi_RXRAM13_rxram_value
    Private read_mspi_RXRAM13_rxram_value
    Private flag_mspi_RXRAM13_rxram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2f4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_RXRAM13_rxram
        get_mspi_RXRAM13_rxram = read_mspi_RXRAM13_rxram_value
    End Property

    Property Let set_mspi_RXRAM13_rxram(aData)
        write_mspi_RXRAM13_rxram_value = aData
        flag_mspi_RXRAM13_rxram        = &H1
    End Property

    Property Get read_mspi_RXRAM13_rxram
        read
        read_mspi_RXRAM13_rxram = read_mspi_RXRAM13_rxram_value
    End Property

    Property Let write_mspi_RXRAM13_rxram(aData)
        set_mspi_RXRAM13_rxram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_RXRAM13_rxram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_RXRAM13_rxram_mask = mask then
                read_mspi_RXRAM13_rxram_value = data_low
            else
                read_mspi_RXRAM13_rxram_value = (data_low - H8000_0000) and mspi_RXRAM13_rxram_mask
            end If
        else
            read_mspi_RXRAM13_rxram_value = data_low and mspi_RXRAM13_rxram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_RXRAM13_rxram = &H0 Then read
        If flag_mspi_RXRAM13_rxram = &H0 Then write_mspi_RXRAM13_rxram_value = get_mspi_RXRAM13_rxram

        regValue = leftShift((write_mspi_RXRAM13_rxram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_RXRAM13_rxram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_RXRAM13_rxram_mask = mask then
                read_mspi_RXRAM13_rxram_value = data_low
            else
                read_mspi_RXRAM13_rxram_value = (data_low - H8000_0000) and mspi_RXRAM13_rxram_mask
            end If
        else
            read_mspi_RXRAM13_rxram_value = data_low and mspi_RXRAM13_rxram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_RXRAM13_rxram_value = &H0
        flag_mspi_RXRAM13_rxram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_rxram14
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_RXRAM14_rxram                         [7:0]            get_mspi_RXRAM14_rxram
''                                                             set_mspi_RXRAM14_rxram
''                                                             read_mspi_RXRAM14_rxram
''                                                             write_mspi_RXRAM14_rxram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_rxram14
    Private write_mspi_RXRAM14_rxram_value
    Private read_mspi_RXRAM14_rxram_value
    Private flag_mspi_RXRAM14_rxram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2f8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_RXRAM14_rxram
        get_mspi_RXRAM14_rxram = read_mspi_RXRAM14_rxram_value
    End Property

    Property Let set_mspi_RXRAM14_rxram(aData)
        write_mspi_RXRAM14_rxram_value = aData
        flag_mspi_RXRAM14_rxram        = &H1
    End Property

    Property Get read_mspi_RXRAM14_rxram
        read
        read_mspi_RXRAM14_rxram = read_mspi_RXRAM14_rxram_value
    End Property

    Property Let write_mspi_RXRAM14_rxram(aData)
        set_mspi_RXRAM14_rxram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_RXRAM14_rxram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_RXRAM14_rxram_mask = mask then
                read_mspi_RXRAM14_rxram_value = data_low
            else
                read_mspi_RXRAM14_rxram_value = (data_low - H8000_0000) and mspi_RXRAM14_rxram_mask
            end If
        else
            read_mspi_RXRAM14_rxram_value = data_low and mspi_RXRAM14_rxram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_RXRAM14_rxram = &H0 Then read
        If flag_mspi_RXRAM14_rxram = &H0 Then write_mspi_RXRAM14_rxram_value = get_mspi_RXRAM14_rxram

        regValue = leftShift((write_mspi_RXRAM14_rxram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_RXRAM14_rxram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_RXRAM14_rxram_mask = mask then
                read_mspi_RXRAM14_rxram_value = data_low
            else
                read_mspi_RXRAM14_rxram_value = (data_low - H8000_0000) and mspi_RXRAM14_rxram_mask
            end If
        else
            read_mspi_RXRAM14_rxram_value = data_low and mspi_RXRAM14_rxram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_RXRAM14_rxram_value = &H0
        flag_mspi_RXRAM14_rxram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_rxram15
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_RXRAM15_rxram                         [7:0]            get_mspi_RXRAM15_rxram
''                                                             set_mspi_RXRAM15_rxram
''                                                             read_mspi_RXRAM15_rxram
''                                                             write_mspi_RXRAM15_rxram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_rxram15
    Private write_mspi_RXRAM15_rxram_value
    Private read_mspi_RXRAM15_rxram_value
    Private flag_mspi_RXRAM15_rxram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2fc
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_RXRAM15_rxram
        get_mspi_RXRAM15_rxram = read_mspi_RXRAM15_rxram_value
    End Property

    Property Let set_mspi_RXRAM15_rxram(aData)
        write_mspi_RXRAM15_rxram_value = aData
        flag_mspi_RXRAM15_rxram        = &H1
    End Property

    Property Get read_mspi_RXRAM15_rxram
        read
        read_mspi_RXRAM15_rxram = read_mspi_RXRAM15_rxram_value
    End Property

    Property Let write_mspi_RXRAM15_rxram(aData)
        set_mspi_RXRAM15_rxram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_RXRAM15_rxram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_RXRAM15_rxram_mask = mask then
                read_mspi_RXRAM15_rxram_value = data_low
            else
                read_mspi_RXRAM15_rxram_value = (data_low - H8000_0000) and mspi_RXRAM15_rxram_mask
            end If
        else
            read_mspi_RXRAM15_rxram_value = data_low and mspi_RXRAM15_rxram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_RXRAM15_rxram = &H0 Then read
        If flag_mspi_RXRAM15_rxram = &H0 Then write_mspi_RXRAM15_rxram_value = get_mspi_RXRAM15_rxram

        regValue = leftShift((write_mspi_RXRAM15_rxram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_RXRAM15_rxram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_RXRAM15_rxram_mask = mask then
                read_mspi_RXRAM15_rxram_value = data_low
            else
                read_mspi_RXRAM15_rxram_value = (data_low - H8000_0000) and mspi_RXRAM15_rxram_mask
            end If
        else
            read_mspi_RXRAM15_rxram_value = data_low and mspi_RXRAM15_rxram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_RXRAM15_rxram_value = &H0
        flag_mspi_RXRAM15_rxram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_rxram16
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_RXRAM16_rxram                         [7:0]            get_mspi_RXRAM16_rxram
''                                                             set_mspi_RXRAM16_rxram
''                                                             read_mspi_RXRAM16_rxram
''                                                             write_mspi_RXRAM16_rxram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_rxram16
    Private write_mspi_RXRAM16_rxram_value
    Private read_mspi_RXRAM16_rxram_value
    Private flag_mspi_RXRAM16_rxram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H300
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_RXRAM16_rxram
        get_mspi_RXRAM16_rxram = read_mspi_RXRAM16_rxram_value
    End Property

    Property Let set_mspi_RXRAM16_rxram(aData)
        write_mspi_RXRAM16_rxram_value = aData
        flag_mspi_RXRAM16_rxram        = &H1
    End Property

    Property Get read_mspi_RXRAM16_rxram
        read
        read_mspi_RXRAM16_rxram = read_mspi_RXRAM16_rxram_value
    End Property

    Property Let write_mspi_RXRAM16_rxram(aData)
        set_mspi_RXRAM16_rxram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_RXRAM16_rxram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_RXRAM16_rxram_mask = mask then
                read_mspi_RXRAM16_rxram_value = data_low
            else
                read_mspi_RXRAM16_rxram_value = (data_low - H8000_0000) and mspi_RXRAM16_rxram_mask
            end If
        else
            read_mspi_RXRAM16_rxram_value = data_low and mspi_RXRAM16_rxram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_RXRAM16_rxram = &H0 Then read
        If flag_mspi_RXRAM16_rxram = &H0 Then write_mspi_RXRAM16_rxram_value = get_mspi_RXRAM16_rxram

        regValue = leftShift((write_mspi_RXRAM16_rxram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_RXRAM16_rxram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_RXRAM16_rxram_mask = mask then
                read_mspi_RXRAM16_rxram_value = data_low
            else
                read_mspi_RXRAM16_rxram_value = (data_low - H8000_0000) and mspi_RXRAM16_rxram_mask
            end If
        else
            read_mspi_RXRAM16_rxram_value = data_low and mspi_RXRAM16_rxram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_RXRAM16_rxram_value = &H0
        flag_mspi_RXRAM16_rxram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_rxram17
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_RXRAM17_rxram                         [7:0]            get_mspi_RXRAM17_rxram
''                                                             set_mspi_RXRAM17_rxram
''                                                             read_mspi_RXRAM17_rxram
''                                                             write_mspi_RXRAM17_rxram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_rxram17
    Private write_mspi_RXRAM17_rxram_value
    Private read_mspi_RXRAM17_rxram_value
    Private flag_mspi_RXRAM17_rxram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H304
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_RXRAM17_rxram
        get_mspi_RXRAM17_rxram = read_mspi_RXRAM17_rxram_value
    End Property

    Property Let set_mspi_RXRAM17_rxram(aData)
        write_mspi_RXRAM17_rxram_value = aData
        flag_mspi_RXRAM17_rxram        = &H1
    End Property

    Property Get read_mspi_RXRAM17_rxram
        read
        read_mspi_RXRAM17_rxram = read_mspi_RXRAM17_rxram_value
    End Property

    Property Let write_mspi_RXRAM17_rxram(aData)
        set_mspi_RXRAM17_rxram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_RXRAM17_rxram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_RXRAM17_rxram_mask = mask then
                read_mspi_RXRAM17_rxram_value = data_low
            else
                read_mspi_RXRAM17_rxram_value = (data_low - H8000_0000) and mspi_RXRAM17_rxram_mask
            end If
        else
            read_mspi_RXRAM17_rxram_value = data_low and mspi_RXRAM17_rxram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_RXRAM17_rxram = &H0 Then read
        If flag_mspi_RXRAM17_rxram = &H0 Then write_mspi_RXRAM17_rxram_value = get_mspi_RXRAM17_rxram

        regValue = leftShift((write_mspi_RXRAM17_rxram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_RXRAM17_rxram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_RXRAM17_rxram_mask = mask then
                read_mspi_RXRAM17_rxram_value = data_low
            else
                read_mspi_RXRAM17_rxram_value = (data_low - H8000_0000) and mspi_RXRAM17_rxram_mask
            end If
        else
            read_mspi_RXRAM17_rxram_value = data_low and mspi_RXRAM17_rxram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_RXRAM17_rxram_value = &H0
        flag_mspi_RXRAM17_rxram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_rxram18
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_RXRAM18_rxram                         [7:0]            get_mspi_RXRAM18_rxram
''                                                             set_mspi_RXRAM18_rxram
''                                                             read_mspi_RXRAM18_rxram
''                                                             write_mspi_RXRAM18_rxram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_rxram18
    Private write_mspi_RXRAM18_rxram_value
    Private read_mspi_RXRAM18_rxram_value
    Private flag_mspi_RXRAM18_rxram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H308
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_RXRAM18_rxram
        get_mspi_RXRAM18_rxram = read_mspi_RXRAM18_rxram_value
    End Property

    Property Let set_mspi_RXRAM18_rxram(aData)
        write_mspi_RXRAM18_rxram_value = aData
        flag_mspi_RXRAM18_rxram        = &H1
    End Property

    Property Get read_mspi_RXRAM18_rxram
        read
        read_mspi_RXRAM18_rxram = read_mspi_RXRAM18_rxram_value
    End Property

    Property Let write_mspi_RXRAM18_rxram(aData)
        set_mspi_RXRAM18_rxram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_RXRAM18_rxram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_RXRAM18_rxram_mask = mask then
                read_mspi_RXRAM18_rxram_value = data_low
            else
                read_mspi_RXRAM18_rxram_value = (data_low - H8000_0000) and mspi_RXRAM18_rxram_mask
            end If
        else
            read_mspi_RXRAM18_rxram_value = data_low and mspi_RXRAM18_rxram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_RXRAM18_rxram = &H0 Then read
        If flag_mspi_RXRAM18_rxram = &H0 Then write_mspi_RXRAM18_rxram_value = get_mspi_RXRAM18_rxram

        regValue = leftShift((write_mspi_RXRAM18_rxram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_RXRAM18_rxram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_RXRAM18_rxram_mask = mask then
                read_mspi_RXRAM18_rxram_value = data_low
            else
                read_mspi_RXRAM18_rxram_value = (data_low - H8000_0000) and mspi_RXRAM18_rxram_mask
            end If
        else
            read_mspi_RXRAM18_rxram_value = data_low and mspi_RXRAM18_rxram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_RXRAM18_rxram_value = &H0
        flag_mspi_RXRAM18_rxram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_rxram19
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_RXRAM19_rxram                         [7:0]            get_mspi_RXRAM19_rxram
''                                                             set_mspi_RXRAM19_rxram
''                                                             read_mspi_RXRAM19_rxram
''                                                             write_mspi_RXRAM19_rxram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_rxram19
    Private write_mspi_RXRAM19_rxram_value
    Private read_mspi_RXRAM19_rxram_value
    Private flag_mspi_RXRAM19_rxram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H30c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_RXRAM19_rxram
        get_mspi_RXRAM19_rxram = read_mspi_RXRAM19_rxram_value
    End Property

    Property Let set_mspi_RXRAM19_rxram(aData)
        write_mspi_RXRAM19_rxram_value = aData
        flag_mspi_RXRAM19_rxram        = &H1
    End Property

    Property Get read_mspi_RXRAM19_rxram
        read
        read_mspi_RXRAM19_rxram = read_mspi_RXRAM19_rxram_value
    End Property

    Property Let write_mspi_RXRAM19_rxram(aData)
        set_mspi_RXRAM19_rxram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_RXRAM19_rxram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_RXRAM19_rxram_mask = mask then
                read_mspi_RXRAM19_rxram_value = data_low
            else
                read_mspi_RXRAM19_rxram_value = (data_low - H8000_0000) and mspi_RXRAM19_rxram_mask
            end If
        else
            read_mspi_RXRAM19_rxram_value = data_low and mspi_RXRAM19_rxram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_RXRAM19_rxram = &H0 Then read
        If flag_mspi_RXRAM19_rxram = &H0 Then write_mspi_RXRAM19_rxram_value = get_mspi_RXRAM19_rxram

        regValue = leftShift((write_mspi_RXRAM19_rxram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_RXRAM19_rxram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_RXRAM19_rxram_mask = mask then
                read_mspi_RXRAM19_rxram_value = data_low
            else
                read_mspi_RXRAM19_rxram_value = (data_low - H8000_0000) and mspi_RXRAM19_rxram_mask
            end If
        else
            read_mspi_RXRAM19_rxram_value = data_low and mspi_RXRAM19_rxram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_RXRAM19_rxram_value = &H0
        flag_mspi_RXRAM19_rxram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_rxram20
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_RXRAM20_rxram                         [7:0]            get_mspi_RXRAM20_rxram
''                                                             set_mspi_RXRAM20_rxram
''                                                             read_mspi_RXRAM20_rxram
''                                                             write_mspi_RXRAM20_rxram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_rxram20
    Private write_mspi_RXRAM20_rxram_value
    Private read_mspi_RXRAM20_rxram_value
    Private flag_mspi_RXRAM20_rxram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H310
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_RXRAM20_rxram
        get_mspi_RXRAM20_rxram = read_mspi_RXRAM20_rxram_value
    End Property

    Property Let set_mspi_RXRAM20_rxram(aData)
        write_mspi_RXRAM20_rxram_value = aData
        flag_mspi_RXRAM20_rxram        = &H1
    End Property

    Property Get read_mspi_RXRAM20_rxram
        read
        read_mspi_RXRAM20_rxram = read_mspi_RXRAM20_rxram_value
    End Property

    Property Let write_mspi_RXRAM20_rxram(aData)
        set_mspi_RXRAM20_rxram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_RXRAM20_rxram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_RXRAM20_rxram_mask = mask then
                read_mspi_RXRAM20_rxram_value = data_low
            else
                read_mspi_RXRAM20_rxram_value = (data_low - H8000_0000) and mspi_RXRAM20_rxram_mask
            end If
        else
            read_mspi_RXRAM20_rxram_value = data_low and mspi_RXRAM20_rxram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_RXRAM20_rxram = &H0 Then read
        If flag_mspi_RXRAM20_rxram = &H0 Then write_mspi_RXRAM20_rxram_value = get_mspi_RXRAM20_rxram

        regValue = leftShift((write_mspi_RXRAM20_rxram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_RXRAM20_rxram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_RXRAM20_rxram_mask = mask then
                read_mspi_RXRAM20_rxram_value = data_low
            else
                read_mspi_RXRAM20_rxram_value = (data_low - H8000_0000) and mspi_RXRAM20_rxram_mask
            end If
        else
            read_mspi_RXRAM20_rxram_value = data_low and mspi_RXRAM20_rxram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_RXRAM20_rxram_value = &H0
        flag_mspi_RXRAM20_rxram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_rxram21
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_RXRAM21_rxram                         [7:0]            get_mspi_RXRAM21_rxram
''                                                             set_mspi_RXRAM21_rxram
''                                                             read_mspi_RXRAM21_rxram
''                                                             write_mspi_RXRAM21_rxram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_rxram21
    Private write_mspi_RXRAM21_rxram_value
    Private read_mspi_RXRAM21_rxram_value
    Private flag_mspi_RXRAM21_rxram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H314
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_RXRAM21_rxram
        get_mspi_RXRAM21_rxram = read_mspi_RXRAM21_rxram_value
    End Property

    Property Let set_mspi_RXRAM21_rxram(aData)
        write_mspi_RXRAM21_rxram_value = aData
        flag_mspi_RXRAM21_rxram        = &H1
    End Property

    Property Get read_mspi_RXRAM21_rxram
        read
        read_mspi_RXRAM21_rxram = read_mspi_RXRAM21_rxram_value
    End Property

    Property Let write_mspi_RXRAM21_rxram(aData)
        set_mspi_RXRAM21_rxram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_RXRAM21_rxram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_RXRAM21_rxram_mask = mask then
                read_mspi_RXRAM21_rxram_value = data_low
            else
                read_mspi_RXRAM21_rxram_value = (data_low - H8000_0000) and mspi_RXRAM21_rxram_mask
            end If
        else
            read_mspi_RXRAM21_rxram_value = data_low and mspi_RXRAM21_rxram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_RXRAM21_rxram = &H0 Then read
        If flag_mspi_RXRAM21_rxram = &H0 Then write_mspi_RXRAM21_rxram_value = get_mspi_RXRAM21_rxram

        regValue = leftShift((write_mspi_RXRAM21_rxram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_RXRAM21_rxram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_RXRAM21_rxram_mask = mask then
                read_mspi_RXRAM21_rxram_value = data_low
            else
                read_mspi_RXRAM21_rxram_value = (data_low - H8000_0000) and mspi_RXRAM21_rxram_mask
            end If
        else
            read_mspi_RXRAM21_rxram_value = data_low and mspi_RXRAM21_rxram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_RXRAM21_rxram_value = &H0
        flag_mspi_RXRAM21_rxram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_rxram22
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_RXRAM22_rxram                         [7:0]            get_mspi_RXRAM22_rxram
''                                                             set_mspi_RXRAM22_rxram
''                                                             read_mspi_RXRAM22_rxram
''                                                             write_mspi_RXRAM22_rxram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_rxram22
    Private write_mspi_RXRAM22_rxram_value
    Private read_mspi_RXRAM22_rxram_value
    Private flag_mspi_RXRAM22_rxram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H318
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_RXRAM22_rxram
        get_mspi_RXRAM22_rxram = read_mspi_RXRAM22_rxram_value
    End Property

    Property Let set_mspi_RXRAM22_rxram(aData)
        write_mspi_RXRAM22_rxram_value = aData
        flag_mspi_RXRAM22_rxram        = &H1
    End Property

    Property Get read_mspi_RXRAM22_rxram
        read
        read_mspi_RXRAM22_rxram = read_mspi_RXRAM22_rxram_value
    End Property

    Property Let write_mspi_RXRAM22_rxram(aData)
        set_mspi_RXRAM22_rxram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_RXRAM22_rxram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_RXRAM22_rxram_mask = mask then
                read_mspi_RXRAM22_rxram_value = data_low
            else
                read_mspi_RXRAM22_rxram_value = (data_low - H8000_0000) and mspi_RXRAM22_rxram_mask
            end If
        else
            read_mspi_RXRAM22_rxram_value = data_low and mspi_RXRAM22_rxram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_RXRAM22_rxram = &H0 Then read
        If flag_mspi_RXRAM22_rxram = &H0 Then write_mspi_RXRAM22_rxram_value = get_mspi_RXRAM22_rxram

        regValue = leftShift((write_mspi_RXRAM22_rxram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_RXRAM22_rxram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_RXRAM22_rxram_mask = mask then
                read_mspi_RXRAM22_rxram_value = data_low
            else
                read_mspi_RXRAM22_rxram_value = (data_low - H8000_0000) and mspi_RXRAM22_rxram_mask
            end If
        else
            read_mspi_RXRAM22_rxram_value = data_low and mspi_RXRAM22_rxram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_RXRAM22_rxram_value = &H0
        flag_mspi_RXRAM22_rxram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_rxram23
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_RXRAM23_rxram                         [7:0]            get_mspi_RXRAM23_rxram
''                                                             set_mspi_RXRAM23_rxram
''                                                             read_mspi_RXRAM23_rxram
''                                                             write_mspi_RXRAM23_rxram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_rxram23
    Private write_mspi_RXRAM23_rxram_value
    Private read_mspi_RXRAM23_rxram_value
    Private flag_mspi_RXRAM23_rxram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H31c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_RXRAM23_rxram
        get_mspi_RXRAM23_rxram = read_mspi_RXRAM23_rxram_value
    End Property

    Property Let set_mspi_RXRAM23_rxram(aData)
        write_mspi_RXRAM23_rxram_value = aData
        flag_mspi_RXRAM23_rxram        = &H1
    End Property

    Property Get read_mspi_RXRAM23_rxram
        read
        read_mspi_RXRAM23_rxram = read_mspi_RXRAM23_rxram_value
    End Property

    Property Let write_mspi_RXRAM23_rxram(aData)
        set_mspi_RXRAM23_rxram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_RXRAM23_rxram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_RXRAM23_rxram_mask = mask then
                read_mspi_RXRAM23_rxram_value = data_low
            else
                read_mspi_RXRAM23_rxram_value = (data_low - H8000_0000) and mspi_RXRAM23_rxram_mask
            end If
        else
            read_mspi_RXRAM23_rxram_value = data_low and mspi_RXRAM23_rxram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_RXRAM23_rxram = &H0 Then read
        If flag_mspi_RXRAM23_rxram = &H0 Then write_mspi_RXRAM23_rxram_value = get_mspi_RXRAM23_rxram

        regValue = leftShift((write_mspi_RXRAM23_rxram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_RXRAM23_rxram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_RXRAM23_rxram_mask = mask then
                read_mspi_RXRAM23_rxram_value = data_low
            else
                read_mspi_RXRAM23_rxram_value = (data_low - H8000_0000) and mspi_RXRAM23_rxram_mask
            end If
        else
            read_mspi_RXRAM23_rxram_value = data_low and mspi_RXRAM23_rxram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_RXRAM23_rxram_value = &H0
        flag_mspi_RXRAM23_rxram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_rxram24
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_RXRAM24_rxram                         [7:0]            get_mspi_RXRAM24_rxram
''                                                             set_mspi_RXRAM24_rxram
''                                                             read_mspi_RXRAM24_rxram
''                                                             write_mspi_RXRAM24_rxram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_rxram24
    Private write_mspi_RXRAM24_rxram_value
    Private read_mspi_RXRAM24_rxram_value
    Private flag_mspi_RXRAM24_rxram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H320
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_RXRAM24_rxram
        get_mspi_RXRAM24_rxram = read_mspi_RXRAM24_rxram_value
    End Property

    Property Let set_mspi_RXRAM24_rxram(aData)
        write_mspi_RXRAM24_rxram_value = aData
        flag_mspi_RXRAM24_rxram        = &H1
    End Property

    Property Get read_mspi_RXRAM24_rxram
        read
        read_mspi_RXRAM24_rxram = read_mspi_RXRAM24_rxram_value
    End Property

    Property Let write_mspi_RXRAM24_rxram(aData)
        set_mspi_RXRAM24_rxram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_RXRAM24_rxram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_RXRAM24_rxram_mask = mask then
                read_mspi_RXRAM24_rxram_value = data_low
            else
                read_mspi_RXRAM24_rxram_value = (data_low - H8000_0000) and mspi_RXRAM24_rxram_mask
            end If
        else
            read_mspi_RXRAM24_rxram_value = data_low and mspi_RXRAM24_rxram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_RXRAM24_rxram = &H0 Then read
        If flag_mspi_RXRAM24_rxram = &H0 Then write_mspi_RXRAM24_rxram_value = get_mspi_RXRAM24_rxram

        regValue = leftShift((write_mspi_RXRAM24_rxram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_RXRAM24_rxram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_RXRAM24_rxram_mask = mask then
                read_mspi_RXRAM24_rxram_value = data_low
            else
                read_mspi_RXRAM24_rxram_value = (data_low - H8000_0000) and mspi_RXRAM24_rxram_mask
            end If
        else
            read_mspi_RXRAM24_rxram_value = data_low and mspi_RXRAM24_rxram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_RXRAM24_rxram_value = &H0
        flag_mspi_RXRAM24_rxram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_rxram25
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_RXRAM25_rxram                         [7:0]            get_mspi_RXRAM25_rxram
''                                                             set_mspi_RXRAM25_rxram
''                                                             read_mspi_RXRAM25_rxram
''                                                             write_mspi_RXRAM25_rxram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_rxram25
    Private write_mspi_RXRAM25_rxram_value
    Private read_mspi_RXRAM25_rxram_value
    Private flag_mspi_RXRAM25_rxram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H324
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_RXRAM25_rxram
        get_mspi_RXRAM25_rxram = read_mspi_RXRAM25_rxram_value
    End Property

    Property Let set_mspi_RXRAM25_rxram(aData)
        write_mspi_RXRAM25_rxram_value = aData
        flag_mspi_RXRAM25_rxram        = &H1
    End Property

    Property Get read_mspi_RXRAM25_rxram
        read
        read_mspi_RXRAM25_rxram = read_mspi_RXRAM25_rxram_value
    End Property

    Property Let write_mspi_RXRAM25_rxram(aData)
        set_mspi_RXRAM25_rxram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_RXRAM25_rxram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_RXRAM25_rxram_mask = mask then
                read_mspi_RXRAM25_rxram_value = data_low
            else
                read_mspi_RXRAM25_rxram_value = (data_low - H8000_0000) and mspi_RXRAM25_rxram_mask
            end If
        else
            read_mspi_RXRAM25_rxram_value = data_low and mspi_RXRAM25_rxram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_RXRAM25_rxram = &H0 Then read
        If flag_mspi_RXRAM25_rxram = &H0 Then write_mspi_RXRAM25_rxram_value = get_mspi_RXRAM25_rxram

        regValue = leftShift((write_mspi_RXRAM25_rxram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_RXRAM25_rxram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_RXRAM25_rxram_mask = mask then
                read_mspi_RXRAM25_rxram_value = data_low
            else
                read_mspi_RXRAM25_rxram_value = (data_low - H8000_0000) and mspi_RXRAM25_rxram_mask
            end If
        else
            read_mspi_RXRAM25_rxram_value = data_low and mspi_RXRAM25_rxram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_RXRAM25_rxram_value = &H0
        flag_mspi_RXRAM25_rxram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_rxram26
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_RXRAM26_rxram                         [7:0]            get_mspi_RXRAM26_rxram
''                                                             set_mspi_RXRAM26_rxram
''                                                             read_mspi_RXRAM26_rxram
''                                                             write_mspi_RXRAM26_rxram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_rxram26
    Private write_mspi_RXRAM26_rxram_value
    Private read_mspi_RXRAM26_rxram_value
    Private flag_mspi_RXRAM26_rxram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H328
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_RXRAM26_rxram
        get_mspi_RXRAM26_rxram = read_mspi_RXRAM26_rxram_value
    End Property

    Property Let set_mspi_RXRAM26_rxram(aData)
        write_mspi_RXRAM26_rxram_value = aData
        flag_mspi_RXRAM26_rxram        = &H1
    End Property

    Property Get read_mspi_RXRAM26_rxram
        read
        read_mspi_RXRAM26_rxram = read_mspi_RXRAM26_rxram_value
    End Property

    Property Let write_mspi_RXRAM26_rxram(aData)
        set_mspi_RXRAM26_rxram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_RXRAM26_rxram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_RXRAM26_rxram_mask = mask then
                read_mspi_RXRAM26_rxram_value = data_low
            else
                read_mspi_RXRAM26_rxram_value = (data_low - H8000_0000) and mspi_RXRAM26_rxram_mask
            end If
        else
            read_mspi_RXRAM26_rxram_value = data_low and mspi_RXRAM26_rxram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_RXRAM26_rxram = &H0 Then read
        If flag_mspi_RXRAM26_rxram = &H0 Then write_mspi_RXRAM26_rxram_value = get_mspi_RXRAM26_rxram

        regValue = leftShift((write_mspi_RXRAM26_rxram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_RXRAM26_rxram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_RXRAM26_rxram_mask = mask then
                read_mspi_RXRAM26_rxram_value = data_low
            else
                read_mspi_RXRAM26_rxram_value = (data_low - H8000_0000) and mspi_RXRAM26_rxram_mask
            end If
        else
            read_mspi_RXRAM26_rxram_value = data_low and mspi_RXRAM26_rxram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_RXRAM26_rxram_value = &H0
        flag_mspi_RXRAM26_rxram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_rxram27
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_RXRAM27_rxram                         [7:0]            get_mspi_RXRAM27_rxram
''                                                             set_mspi_RXRAM27_rxram
''                                                             read_mspi_RXRAM27_rxram
''                                                             write_mspi_RXRAM27_rxram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_rxram27
    Private write_mspi_RXRAM27_rxram_value
    Private read_mspi_RXRAM27_rxram_value
    Private flag_mspi_RXRAM27_rxram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H32c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_RXRAM27_rxram
        get_mspi_RXRAM27_rxram = read_mspi_RXRAM27_rxram_value
    End Property

    Property Let set_mspi_RXRAM27_rxram(aData)
        write_mspi_RXRAM27_rxram_value = aData
        flag_mspi_RXRAM27_rxram        = &H1
    End Property

    Property Get read_mspi_RXRAM27_rxram
        read
        read_mspi_RXRAM27_rxram = read_mspi_RXRAM27_rxram_value
    End Property

    Property Let write_mspi_RXRAM27_rxram(aData)
        set_mspi_RXRAM27_rxram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_RXRAM27_rxram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_RXRAM27_rxram_mask = mask then
                read_mspi_RXRAM27_rxram_value = data_low
            else
                read_mspi_RXRAM27_rxram_value = (data_low - H8000_0000) and mspi_RXRAM27_rxram_mask
            end If
        else
            read_mspi_RXRAM27_rxram_value = data_low and mspi_RXRAM27_rxram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_RXRAM27_rxram = &H0 Then read
        If flag_mspi_RXRAM27_rxram = &H0 Then write_mspi_RXRAM27_rxram_value = get_mspi_RXRAM27_rxram

        regValue = leftShift((write_mspi_RXRAM27_rxram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_RXRAM27_rxram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_RXRAM27_rxram_mask = mask then
                read_mspi_RXRAM27_rxram_value = data_low
            else
                read_mspi_RXRAM27_rxram_value = (data_low - H8000_0000) and mspi_RXRAM27_rxram_mask
            end If
        else
            read_mspi_RXRAM27_rxram_value = data_low and mspi_RXRAM27_rxram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_RXRAM27_rxram_value = &H0
        flag_mspi_RXRAM27_rxram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_rxram28
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_RXRAM28_rxram                         [7:0]            get_mspi_RXRAM28_rxram
''                                                             set_mspi_RXRAM28_rxram
''                                                             read_mspi_RXRAM28_rxram
''                                                             write_mspi_RXRAM28_rxram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_rxram28
    Private write_mspi_RXRAM28_rxram_value
    Private read_mspi_RXRAM28_rxram_value
    Private flag_mspi_RXRAM28_rxram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H330
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_RXRAM28_rxram
        get_mspi_RXRAM28_rxram = read_mspi_RXRAM28_rxram_value
    End Property

    Property Let set_mspi_RXRAM28_rxram(aData)
        write_mspi_RXRAM28_rxram_value = aData
        flag_mspi_RXRAM28_rxram        = &H1
    End Property

    Property Get read_mspi_RXRAM28_rxram
        read
        read_mspi_RXRAM28_rxram = read_mspi_RXRAM28_rxram_value
    End Property

    Property Let write_mspi_RXRAM28_rxram(aData)
        set_mspi_RXRAM28_rxram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_RXRAM28_rxram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_RXRAM28_rxram_mask = mask then
                read_mspi_RXRAM28_rxram_value = data_low
            else
                read_mspi_RXRAM28_rxram_value = (data_low - H8000_0000) and mspi_RXRAM28_rxram_mask
            end If
        else
            read_mspi_RXRAM28_rxram_value = data_low and mspi_RXRAM28_rxram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_RXRAM28_rxram = &H0 Then read
        If flag_mspi_RXRAM28_rxram = &H0 Then write_mspi_RXRAM28_rxram_value = get_mspi_RXRAM28_rxram

        regValue = leftShift((write_mspi_RXRAM28_rxram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_RXRAM28_rxram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_RXRAM28_rxram_mask = mask then
                read_mspi_RXRAM28_rxram_value = data_low
            else
                read_mspi_RXRAM28_rxram_value = (data_low - H8000_0000) and mspi_RXRAM28_rxram_mask
            end If
        else
            read_mspi_RXRAM28_rxram_value = data_low and mspi_RXRAM28_rxram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_RXRAM28_rxram_value = &H0
        flag_mspi_RXRAM28_rxram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_rxram29
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_RXRAM29_rxram                         [7:0]            get_mspi_RXRAM29_rxram
''                                                             set_mspi_RXRAM29_rxram
''                                                             read_mspi_RXRAM29_rxram
''                                                             write_mspi_RXRAM29_rxram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_rxram29
    Private write_mspi_RXRAM29_rxram_value
    Private read_mspi_RXRAM29_rxram_value
    Private flag_mspi_RXRAM29_rxram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H334
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_RXRAM29_rxram
        get_mspi_RXRAM29_rxram = read_mspi_RXRAM29_rxram_value
    End Property

    Property Let set_mspi_RXRAM29_rxram(aData)
        write_mspi_RXRAM29_rxram_value = aData
        flag_mspi_RXRAM29_rxram        = &H1
    End Property

    Property Get read_mspi_RXRAM29_rxram
        read
        read_mspi_RXRAM29_rxram = read_mspi_RXRAM29_rxram_value
    End Property

    Property Let write_mspi_RXRAM29_rxram(aData)
        set_mspi_RXRAM29_rxram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_RXRAM29_rxram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_RXRAM29_rxram_mask = mask then
                read_mspi_RXRAM29_rxram_value = data_low
            else
                read_mspi_RXRAM29_rxram_value = (data_low - H8000_0000) and mspi_RXRAM29_rxram_mask
            end If
        else
            read_mspi_RXRAM29_rxram_value = data_low and mspi_RXRAM29_rxram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_RXRAM29_rxram = &H0 Then read
        If flag_mspi_RXRAM29_rxram = &H0 Then write_mspi_RXRAM29_rxram_value = get_mspi_RXRAM29_rxram

        regValue = leftShift((write_mspi_RXRAM29_rxram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_RXRAM29_rxram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_RXRAM29_rxram_mask = mask then
                read_mspi_RXRAM29_rxram_value = data_low
            else
                read_mspi_RXRAM29_rxram_value = (data_low - H8000_0000) and mspi_RXRAM29_rxram_mask
            end If
        else
            read_mspi_RXRAM29_rxram_value = data_low and mspi_RXRAM29_rxram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_RXRAM29_rxram_value = &H0
        flag_mspi_RXRAM29_rxram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_rxram30
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_RXRAM30_rxram                         [7:0]            get_mspi_RXRAM30_rxram
''                                                             set_mspi_RXRAM30_rxram
''                                                             read_mspi_RXRAM30_rxram
''                                                             write_mspi_RXRAM30_rxram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_rxram30
    Private write_mspi_RXRAM30_rxram_value
    Private read_mspi_RXRAM30_rxram_value
    Private flag_mspi_RXRAM30_rxram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H338
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_RXRAM30_rxram
        get_mspi_RXRAM30_rxram = read_mspi_RXRAM30_rxram_value
    End Property

    Property Let set_mspi_RXRAM30_rxram(aData)
        write_mspi_RXRAM30_rxram_value = aData
        flag_mspi_RXRAM30_rxram        = &H1
    End Property

    Property Get read_mspi_RXRAM30_rxram
        read
        read_mspi_RXRAM30_rxram = read_mspi_RXRAM30_rxram_value
    End Property

    Property Let write_mspi_RXRAM30_rxram(aData)
        set_mspi_RXRAM30_rxram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_RXRAM30_rxram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_RXRAM30_rxram_mask = mask then
                read_mspi_RXRAM30_rxram_value = data_low
            else
                read_mspi_RXRAM30_rxram_value = (data_low - H8000_0000) and mspi_RXRAM30_rxram_mask
            end If
        else
            read_mspi_RXRAM30_rxram_value = data_low and mspi_RXRAM30_rxram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_RXRAM30_rxram = &H0 Then read
        If flag_mspi_RXRAM30_rxram = &H0 Then write_mspi_RXRAM30_rxram_value = get_mspi_RXRAM30_rxram

        regValue = leftShift((write_mspi_RXRAM30_rxram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_RXRAM30_rxram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_RXRAM30_rxram_mask = mask then
                read_mspi_RXRAM30_rxram_value = data_low
            else
                read_mspi_RXRAM30_rxram_value = (data_low - H8000_0000) and mspi_RXRAM30_rxram_mask
            end If
        else
            read_mspi_RXRAM30_rxram_value = data_low and mspi_RXRAM30_rxram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_RXRAM30_rxram_value = &H0
        flag_mspi_RXRAM30_rxram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_rxram31
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_RXRAM31_rxram                         [7:0]            get_mspi_RXRAM31_rxram
''                                                             set_mspi_RXRAM31_rxram
''                                                             read_mspi_RXRAM31_rxram
''                                                             write_mspi_RXRAM31_rxram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_rxram31
    Private write_mspi_RXRAM31_rxram_value
    Private read_mspi_RXRAM31_rxram_value
    Private flag_mspi_RXRAM31_rxram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H33c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_RXRAM31_rxram
        get_mspi_RXRAM31_rxram = read_mspi_RXRAM31_rxram_value
    End Property

    Property Let set_mspi_RXRAM31_rxram(aData)
        write_mspi_RXRAM31_rxram_value = aData
        flag_mspi_RXRAM31_rxram        = &H1
    End Property

    Property Get read_mspi_RXRAM31_rxram
        read
        read_mspi_RXRAM31_rxram = read_mspi_RXRAM31_rxram_value
    End Property

    Property Let write_mspi_RXRAM31_rxram(aData)
        set_mspi_RXRAM31_rxram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_RXRAM31_rxram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_RXRAM31_rxram_mask = mask then
                read_mspi_RXRAM31_rxram_value = data_low
            else
                read_mspi_RXRAM31_rxram_value = (data_low - H8000_0000) and mspi_RXRAM31_rxram_mask
            end If
        else
            read_mspi_RXRAM31_rxram_value = data_low and mspi_RXRAM31_rxram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_RXRAM31_rxram = &H0 Then read
        If flag_mspi_RXRAM31_rxram = &H0 Then write_mspi_RXRAM31_rxram_value = get_mspi_RXRAM31_rxram

        regValue = leftShift((write_mspi_RXRAM31_rxram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_RXRAM31_rxram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_RXRAM31_rxram_mask = mask then
                read_mspi_RXRAM31_rxram_value = data_low
            else
                read_mspi_RXRAM31_rxram_value = (data_low - H8000_0000) and mspi_RXRAM31_rxram_mask
            end If
        else
            read_mspi_RXRAM31_rxram_value = data_low and mspi_RXRAM31_rxram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_RXRAM31_rxram_value = &H0
        flag_mspi_RXRAM31_rxram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_cdram00
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_CDRAM00_cdram                         [7:0]            get_mspi_CDRAM00_cdram
''                                                             set_mspi_CDRAM00_cdram
''                                                             read_mspi_CDRAM00_cdram
''                                                             write_mspi_CDRAM00_cdram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_cdram00
    Private write_mspi_CDRAM00_cdram_value
    Private read_mspi_CDRAM00_cdram_value
    Private flag_mspi_CDRAM00_cdram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H340
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_CDRAM00_cdram
        get_mspi_CDRAM00_cdram = read_mspi_CDRAM00_cdram_value
    End Property

    Property Let set_mspi_CDRAM00_cdram(aData)
        write_mspi_CDRAM00_cdram_value = aData
        flag_mspi_CDRAM00_cdram        = &H1
    End Property

    Property Get read_mspi_CDRAM00_cdram
        read
        read_mspi_CDRAM00_cdram = read_mspi_CDRAM00_cdram_value
    End Property

    Property Let write_mspi_CDRAM00_cdram(aData)
        set_mspi_CDRAM00_cdram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_CDRAM00_cdram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_CDRAM00_cdram_mask = mask then
                read_mspi_CDRAM00_cdram_value = data_low
            else
                read_mspi_CDRAM00_cdram_value = (data_low - H8000_0000) and mspi_CDRAM00_cdram_mask
            end If
        else
            read_mspi_CDRAM00_cdram_value = data_low and mspi_CDRAM00_cdram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_CDRAM00_cdram = &H0 Then read
        If flag_mspi_CDRAM00_cdram = &H0 Then write_mspi_CDRAM00_cdram_value = get_mspi_CDRAM00_cdram

        regValue = leftShift((write_mspi_CDRAM00_cdram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_CDRAM00_cdram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_CDRAM00_cdram_mask = mask then
                read_mspi_CDRAM00_cdram_value = data_low
            else
                read_mspi_CDRAM00_cdram_value = (data_low - H8000_0000) and mspi_CDRAM00_cdram_mask
            end If
        else
            read_mspi_CDRAM00_cdram_value = data_low and mspi_CDRAM00_cdram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_CDRAM00_cdram_value = &H0
        flag_mspi_CDRAM00_cdram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_cdram01
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_CDRAM01_cdram                         [7:0]            get_mspi_CDRAM01_cdram
''                                                             set_mspi_CDRAM01_cdram
''                                                             read_mspi_CDRAM01_cdram
''                                                             write_mspi_CDRAM01_cdram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_cdram01
    Private write_mspi_CDRAM01_cdram_value
    Private read_mspi_CDRAM01_cdram_value
    Private flag_mspi_CDRAM01_cdram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H344
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_CDRAM01_cdram
        get_mspi_CDRAM01_cdram = read_mspi_CDRAM01_cdram_value
    End Property

    Property Let set_mspi_CDRAM01_cdram(aData)
        write_mspi_CDRAM01_cdram_value = aData
        flag_mspi_CDRAM01_cdram        = &H1
    End Property

    Property Get read_mspi_CDRAM01_cdram
        read
        read_mspi_CDRAM01_cdram = read_mspi_CDRAM01_cdram_value
    End Property

    Property Let write_mspi_CDRAM01_cdram(aData)
        set_mspi_CDRAM01_cdram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_CDRAM01_cdram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_CDRAM01_cdram_mask = mask then
                read_mspi_CDRAM01_cdram_value = data_low
            else
                read_mspi_CDRAM01_cdram_value = (data_low - H8000_0000) and mspi_CDRAM01_cdram_mask
            end If
        else
            read_mspi_CDRAM01_cdram_value = data_low and mspi_CDRAM01_cdram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_CDRAM01_cdram = &H0 Then read
        If flag_mspi_CDRAM01_cdram = &H0 Then write_mspi_CDRAM01_cdram_value = get_mspi_CDRAM01_cdram

        regValue = leftShift((write_mspi_CDRAM01_cdram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_CDRAM01_cdram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_CDRAM01_cdram_mask = mask then
                read_mspi_CDRAM01_cdram_value = data_low
            else
                read_mspi_CDRAM01_cdram_value = (data_low - H8000_0000) and mspi_CDRAM01_cdram_mask
            end If
        else
            read_mspi_CDRAM01_cdram_value = data_low and mspi_CDRAM01_cdram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_CDRAM01_cdram_value = &H0
        flag_mspi_CDRAM01_cdram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_cdram02
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_CDRAM02_cdram                         [7:0]            get_mspi_CDRAM02_cdram
''                                                             set_mspi_CDRAM02_cdram
''                                                             read_mspi_CDRAM02_cdram
''                                                             write_mspi_CDRAM02_cdram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_cdram02
    Private write_mspi_CDRAM02_cdram_value
    Private read_mspi_CDRAM02_cdram_value
    Private flag_mspi_CDRAM02_cdram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H348
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_CDRAM02_cdram
        get_mspi_CDRAM02_cdram = read_mspi_CDRAM02_cdram_value
    End Property

    Property Let set_mspi_CDRAM02_cdram(aData)
        write_mspi_CDRAM02_cdram_value = aData
        flag_mspi_CDRAM02_cdram        = &H1
    End Property

    Property Get read_mspi_CDRAM02_cdram
        read
        read_mspi_CDRAM02_cdram = read_mspi_CDRAM02_cdram_value
    End Property

    Property Let write_mspi_CDRAM02_cdram(aData)
        set_mspi_CDRAM02_cdram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_CDRAM02_cdram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_CDRAM02_cdram_mask = mask then
                read_mspi_CDRAM02_cdram_value = data_low
            else
                read_mspi_CDRAM02_cdram_value = (data_low - H8000_0000) and mspi_CDRAM02_cdram_mask
            end If
        else
            read_mspi_CDRAM02_cdram_value = data_low and mspi_CDRAM02_cdram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_CDRAM02_cdram = &H0 Then read
        If flag_mspi_CDRAM02_cdram = &H0 Then write_mspi_CDRAM02_cdram_value = get_mspi_CDRAM02_cdram

        regValue = leftShift((write_mspi_CDRAM02_cdram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_CDRAM02_cdram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_CDRAM02_cdram_mask = mask then
                read_mspi_CDRAM02_cdram_value = data_low
            else
                read_mspi_CDRAM02_cdram_value = (data_low - H8000_0000) and mspi_CDRAM02_cdram_mask
            end If
        else
            read_mspi_CDRAM02_cdram_value = data_low and mspi_CDRAM02_cdram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_CDRAM02_cdram_value = &H0
        flag_mspi_CDRAM02_cdram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_cdram03
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_CDRAM03_cdram                         [7:0]            get_mspi_CDRAM03_cdram
''                                                             set_mspi_CDRAM03_cdram
''                                                             read_mspi_CDRAM03_cdram
''                                                             write_mspi_CDRAM03_cdram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_cdram03
    Private write_mspi_CDRAM03_cdram_value
    Private read_mspi_CDRAM03_cdram_value
    Private flag_mspi_CDRAM03_cdram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H34c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_CDRAM03_cdram
        get_mspi_CDRAM03_cdram = read_mspi_CDRAM03_cdram_value
    End Property

    Property Let set_mspi_CDRAM03_cdram(aData)
        write_mspi_CDRAM03_cdram_value = aData
        flag_mspi_CDRAM03_cdram        = &H1
    End Property

    Property Get read_mspi_CDRAM03_cdram
        read
        read_mspi_CDRAM03_cdram = read_mspi_CDRAM03_cdram_value
    End Property

    Property Let write_mspi_CDRAM03_cdram(aData)
        set_mspi_CDRAM03_cdram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_CDRAM03_cdram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_CDRAM03_cdram_mask = mask then
                read_mspi_CDRAM03_cdram_value = data_low
            else
                read_mspi_CDRAM03_cdram_value = (data_low - H8000_0000) and mspi_CDRAM03_cdram_mask
            end If
        else
            read_mspi_CDRAM03_cdram_value = data_low and mspi_CDRAM03_cdram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_CDRAM03_cdram = &H0 Then read
        If flag_mspi_CDRAM03_cdram = &H0 Then write_mspi_CDRAM03_cdram_value = get_mspi_CDRAM03_cdram

        regValue = leftShift((write_mspi_CDRAM03_cdram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_CDRAM03_cdram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_CDRAM03_cdram_mask = mask then
                read_mspi_CDRAM03_cdram_value = data_low
            else
                read_mspi_CDRAM03_cdram_value = (data_low - H8000_0000) and mspi_CDRAM03_cdram_mask
            end If
        else
            read_mspi_CDRAM03_cdram_value = data_low and mspi_CDRAM03_cdram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_CDRAM03_cdram_value = &H0
        flag_mspi_CDRAM03_cdram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_cdram04
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_CDRAM04_cdram                         [7:0]            get_mspi_CDRAM04_cdram
''                                                             set_mspi_CDRAM04_cdram
''                                                             read_mspi_CDRAM04_cdram
''                                                             write_mspi_CDRAM04_cdram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_cdram04
    Private write_mspi_CDRAM04_cdram_value
    Private read_mspi_CDRAM04_cdram_value
    Private flag_mspi_CDRAM04_cdram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H350
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_CDRAM04_cdram
        get_mspi_CDRAM04_cdram = read_mspi_CDRAM04_cdram_value
    End Property

    Property Let set_mspi_CDRAM04_cdram(aData)
        write_mspi_CDRAM04_cdram_value = aData
        flag_mspi_CDRAM04_cdram        = &H1
    End Property

    Property Get read_mspi_CDRAM04_cdram
        read
        read_mspi_CDRAM04_cdram = read_mspi_CDRAM04_cdram_value
    End Property

    Property Let write_mspi_CDRAM04_cdram(aData)
        set_mspi_CDRAM04_cdram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_CDRAM04_cdram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_CDRAM04_cdram_mask = mask then
                read_mspi_CDRAM04_cdram_value = data_low
            else
                read_mspi_CDRAM04_cdram_value = (data_low - H8000_0000) and mspi_CDRAM04_cdram_mask
            end If
        else
            read_mspi_CDRAM04_cdram_value = data_low and mspi_CDRAM04_cdram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_CDRAM04_cdram = &H0 Then read
        If flag_mspi_CDRAM04_cdram = &H0 Then write_mspi_CDRAM04_cdram_value = get_mspi_CDRAM04_cdram

        regValue = leftShift((write_mspi_CDRAM04_cdram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_CDRAM04_cdram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_CDRAM04_cdram_mask = mask then
                read_mspi_CDRAM04_cdram_value = data_low
            else
                read_mspi_CDRAM04_cdram_value = (data_low - H8000_0000) and mspi_CDRAM04_cdram_mask
            end If
        else
            read_mspi_CDRAM04_cdram_value = data_low and mspi_CDRAM04_cdram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_CDRAM04_cdram_value = &H0
        flag_mspi_CDRAM04_cdram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_cdram05
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_CDRAM05_cdram                         [7:0]            get_mspi_CDRAM05_cdram
''                                                             set_mspi_CDRAM05_cdram
''                                                             read_mspi_CDRAM05_cdram
''                                                             write_mspi_CDRAM05_cdram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_cdram05
    Private write_mspi_CDRAM05_cdram_value
    Private read_mspi_CDRAM05_cdram_value
    Private flag_mspi_CDRAM05_cdram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H354
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_CDRAM05_cdram
        get_mspi_CDRAM05_cdram = read_mspi_CDRAM05_cdram_value
    End Property

    Property Let set_mspi_CDRAM05_cdram(aData)
        write_mspi_CDRAM05_cdram_value = aData
        flag_mspi_CDRAM05_cdram        = &H1
    End Property

    Property Get read_mspi_CDRAM05_cdram
        read
        read_mspi_CDRAM05_cdram = read_mspi_CDRAM05_cdram_value
    End Property

    Property Let write_mspi_CDRAM05_cdram(aData)
        set_mspi_CDRAM05_cdram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_CDRAM05_cdram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_CDRAM05_cdram_mask = mask then
                read_mspi_CDRAM05_cdram_value = data_low
            else
                read_mspi_CDRAM05_cdram_value = (data_low - H8000_0000) and mspi_CDRAM05_cdram_mask
            end If
        else
            read_mspi_CDRAM05_cdram_value = data_low and mspi_CDRAM05_cdram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_CDRAM05_cdram = &H0 Then read
        If flag_mspi_CDRAM05_cdram = &H0 Then write_mspi_CDRAM05_cdram_value = get_mspi_CDRAM05_cdram

        regValue = leftShift((write_mspi_CDRAM05_cdram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_CDRAM05_cdram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_CDRAM05_cdram_mask = mask then
                read_mspi_CDRAM05_cdram_value = data_low
            else
                read_mspi_CDRAM05_cdram_value = (data_low - H8000_0000) and mspi_CDRAM05_cdram_mask
            end If
        else
            read_mspi_CDRAM05_cdram_value = data_low and mspi_CDRAM05_cdram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_CDRAM05_cdram_value = &H0
        flag_mspi_CDRAM05_cdram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_cdram06
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_CDRAM06_cdram                         [7:0]            get_mspi_CDRAM06_cdram
''                                                             set_mspi_CDRAM06_cdram
''                                                             read_mspi_CDRAM06_cdram
''                                                             write_mspi_CDRAM06_cdram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_cdram06
    Private write_mspi_CDRAM06_cdram_value
    Private read_mspi_CDRAM06_cdram_value
    Private flag_mspi_CDRAM06_cdram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H358
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_CDRAM06_cdram
        get_mspi_CDRAM06_cdram = read_mspi_CDRAM06_cdram_value
    End Property

    Property Let set_mspi_CDRAM06_cdram(aData)
        write_mspi_CDRAM06_cdram_value = aData
        flag_mspi_CDRAM06_cdram        = &H1
    End Property

    Property Get read_mspi_CDRAM06_cdram
        read
        read_mspi_CDRAM06_cdram = read_mspi_CDRAM06_cdram_value
    End Property

    Property Let write_mspi_CDRAM06_cdram(aData)
        set_mspi_CDRAM06_cdram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_CDRAM06_cdram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_CDRAM06_cdram_mask = mask then
                read_mspi_CDRAM06_cdram_value = data_low
            else
                read_mspi_CDRAM06_cdram_value = (data_low - H8000_0000) and mspi_CDRAM06_cdram_mask
            end If
        else
            read_mspi_CDRAM06_cdram_value = data_low and mspi_CDRAM06_cdram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_CDRAM06_cdram = &H0 Then read
        If flag_mspi_CDRAM06_cdram = &H0 Then write_mspi_CDRAM06_cdram_value = get_mspi_CDRAM06_cdram

        regValue = leftShift((write_mspi_CDRAM06_cdram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_CDRAM06_cdram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_CDRAM06_cdram_mask = mask then
                read_mspi_CDRAM06_cdram_value = data_low
            else
                read_mspi_CDRAM06_cdram_value = (data_low - H8000_0000) and mspi_CDRAM06_cdram_mask
            end If
        else
            read_mspi_CDRAM06_cdram_value = data_low and mspi_CDRAM06_cdram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_CDRAM06_cdram_value = &H0
        flag_mspi_CDRAM06_cdram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_cdram07
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_CDRAM07_cdram                         [7:0]            get_mspi_CDRAM07_cdram
''                                                             set_mspi_CDRAM07_cdram
''                                                             read_mspi_CDRAM07_cdram
''                                                             write_mspi_CDRAM07_cdram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_cdram07
    Private write_mspi_CDRAM07_cdram_value
    Private read_mspi_CDRAM07_cdram_value
    Private flag_mspi_CDRAM07_cdram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H35c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_CDRAM07_cdram
        get_mspi_CDRAM07_cdram = read_mspi_CDRAM07_cdram_value
    End Property

    Property Let set_mspi_CDRAM07_cdram(aData)
        write_mspi_CDRAM07_cdram_value = aData
        flag_mspi_CDRAM07_cdram        = &H1
    End Property

    Property Get read_mspi_CDRAM07_cdram
        read
        read_mspi_CDRAM07_cdram = read_mspi_CDRAM07_cdram_value
    End Property

    Property Let write_mspi_CDRAM07_cdram(aData)
        set_mspi_CDRAM07_cdram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_CDRAM07_cdram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_CDRAM07_cdram_mask = mask then
                read_mspi_CDRAM07_cdram_value = data_low
            else
                read_mspi_CDRAM07_cdram_value = (data_low - H8000_0000) and mspi_CDRAM07_cdram_mask
            end If
        else
            read_mspi_CDRAM07_cdram_value = data_low and mspi_CDRAM07_cdram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_CDRAM07_cdram = &H0 Then read
        If flag_mspi_CDRAM07_cdram = &H0 Then write_mspi_CDRAM07_cdram_value = get_mspi_CDRAM07_cdram

        regValue = leftShift((write_mspi_CDRAM07_cdram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_CDRAM07_cdram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_CDRAM07_cdram_mask = mask then
                read_mspi_CDRAM07_cdram_value = data_low
            else
                read_mspi_CDRAM07_cdram_value = (data_low - H8000_0000) and mspi_CDRAM07_cdram_mask
            end If
        else
            read_mspi_CDRAM07_cdram_value = data_low and mspi_CDRAM07_cdram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_CDRAM07_cdram_value = &H0
        flag_mspi_CDRAM07_cdram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_cdram08
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_CDRAM08_cdram                         [7:0]            get_mspi_CDRAM08_cdram
''                                                             set_mspi_CDRAM08_cdram
''                                                             read_mspi_CDRAM08_cdram
''                                                             write_mspi_CDRAM08_cdram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_cdram08
    Private write_mspi_CDRAM08_cdram_value
    Private read_mspi_CDRAM08_cdram_value
    Private flag_mspi_CDRAM08_cdram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H360
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_CDRAM08_cdram
        get_mspi_CDRAM08_cdram = read_mspi_CDRAM08_cdram_value
    End Property

    Property Let set_mspi_CDRAM08_cdram(aData)
        write_mspi_CDRAM08_cdram_value = aData
        flag_mspi_CDRAM08_cdram        = &H1
    End Property

    Property Get read_mspi_CDRAM08_cdram
        read
        read_mspi_CDRAM08_cdram = read_mspi_CDRAM08_cdram_value
    End Property

    Property Let write_mspi_CDRAM08_cdram(aData)
        set_mspi_CDRAM08_cdram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_CDRAM08_cdram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_CDRAM08_cdram_mask = mask then
                read_mspi_CDRAM08_cdram_value = data_low
            else
                read_mspi_CDRAM08_cdram_value = (data_low - H8000_0000) and mspi_CDRAM08_cdram_mask
            end If
        else
            read_mspi_CDRAM08_cdram_value = data_low and mspi_CDRAM08_cdram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_CDRAM08_cdram = &H0 Then read
        If flag_mspi_CDRAM08_cdram = &H0 Then write_mspi_CDRAM08_cdram_value = get_mspi_CDRAM08_cdram

        regValue = leftShift((write_mspi_CDRAM08_cdram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_CDRAM08_cdram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_CDRAM08_cdram_mask = mask then
                read_mspi_CDRAM08_cdram_value = data_low
            else
                read_mspi_CDRAM08_cdram_value = (data_low - H8000_0000) and mspi_CDRAM08_cdram_mask
            end If
        else
            read_mspi_CDRAM08_cdram_value = data_low and mspi_CDRAM08_cdram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_CDRAM08_cdram_value = &H0
        flag_mspi_CDRAM08_cdram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_cdram09
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_CDRAM09_cdram                         [7:0]            get_mspi_CDRAM09_cdram
''                                                             set_mspi_CDRAM09_cdram
''                                                             read_mspi_CDRAM09_cdram
''                                                             write_mspi_CDRAM09_cdram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_cdram09
    Private write_mspi_CDRAM09_cdram_value
    Private read_mspi_CDRAM09_cdram_value
    Private flag_mspi_CDRAM09_cdram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H364
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_CDRAM09_cdram
        get_mspi_CDRAM09_cdram = read_mspi_CDRAM09_cdram_value
    End Property

    Property Let set_mspi_CDRAM09_cdram(aData)
        write_mspi_CDRAM09_cdram_value = aData
        flag_mspi_CDRAM09_cdram        = &H1
    End Property

    Property Get read_mspi_CDRAM09_cdram
        read
        read_mspi_CDRAM09_cdram = read_mspi_CDRAM09_cdram_value
    End Property

    Property Let write_mspi_CDRAM09_cdram(aData)
        set_mspi_CDRAM09_cdram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_CDRAM09_cdram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_CDRAM09_cdram_mask = mask then
                read_mspi_CDRAM09_cdram_value = data_low
            else
                read_mspi_CDRAM09_cdram_value = (data_low - H8000_0000) and mspi_CDRAM09_cdram_mask
            end If
        else
            read_mspi_CDRAM09_cdram_value = data_low and mspi_CDRAM09_cdram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_CDRAM09_cdram = &H0 Then read
        If flag_mspi_CDRAM09_cdram = &H0 Then write_mspi_CDRAM09_cdram_value = get_mspi_CDRAM09_cdram

        regValue = leftShift((write_mspi_CDRAM09_cdram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_CDRAM09_cdram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_CDRAM09_cdram_mask = mask then
                read_mspi_CDRAM09_cdram_value = data_low
            else
                read_mspi_CDRAM09_cdram_value = (data_low - H8000_0000) and mspi_CDRAM09_cdram_mask
            end If
        else
            read_mspi_CDRAM09_cdram_value = data_low and mspi_CDRAM09_cdram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_CDRAM09_cdram_value = &H0
        flag_mspi_CDRAM09_cdram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_cdram10
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_CDRAM10_cdram                         [7:0]            get_mspi_CDRAM10_cdram
''                                                             set_mspi_CDRAM10_cdram
''                                                             read_mspi_CDRAM10_cdram
''                                                             write_mspi_CDRAM10_cdram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_cdram10
    Private write_mspi_CDRAM10_cdram_value
    Private read_mspi_CDRAM10_cdram_value
    Private flag_mspi_CDRAM10_cdram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H368
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_CDRAM10_cdram
        get_mspi_CDRAM10_cdram = read_mspi_CDRAM10_cdram_value
    End Property

    Property Let set_mspi_CDRAM10_cdram(aData)
        write_mspi_CDRAM10_cdram_value = aData
        flag_mspi_CDRAM10_cdram        = &H1
    End Property

    Property Get read_mspi_CDRAM10_cdram
        read
        read_mspi_CDRAM10_cdram = read_mspi_CDRAM10_cdram_value
    End Property

    Property Let write_mspi_CDRAM10_cdram(aData)
        set_mspi_CDRAM10_cdram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_CDRAM10_cdram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_CDRAM10_cdram_mask = mask then
                read_mspi_CDRAM10_cdram_value = data_low
            else
                read_mspi_CDRAM10_cdram_value = (data_low - H8000_0000) and mspi_CDRAM10_cdram_mask
            end If
        else
            read_mspi_CDRAM10_cdram_value = data_low and mspi_CDRAM10_cdram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_CDRAM10_cdram = &H0 Then read
        If flag_mspi_CDRAM10_cdram = &H0 Then write_mspi_CDRAM10_cdram_value = get_mspi_CDRAM10_cdram

        regValue = leftShift((write_mspi_CDRAM10_cdram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_CDRAM10_cdram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_CDRAM10_cdram_mask = mask then
                read_mspi_CDRAM10_cdram_value = data_low
            else
                read_mspi_CDRAM10_cdram_value = (data_low - H8000_0000) and mspi_CDRAM10_cdram_mask
            end If
        else
            read_mspi_CDRAM10_cdram_value = data_low and mspi_CDRAM10_cdram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_CDRAM10_cdram_value = &H0
        flag_mspi_CDRAM10_cdram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_cdram11
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_CDRAM11_cdram                         [7:0]            get_mspi_CDRAM11_cdram
''                                                             set_mspi_CDRAM11_cdram
''                                                             read_mspi_CDRAM11_cdram
''                                                             write_mspi_CDRAM11_cdram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_cdram11
    Private write_mspi_CDRAM11_cdram_value
    Private read_mspi_CDRAM11_cdram_value
    Private flag_mspi_CDRAM11_cdram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H36c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_CDRAM11_cdram
        get_mspi_CDRAM11_cdram = read_mspi_CDRAM11_cdram_value
    End Property

    Property Let set_mspi_CDRAM11_cdram(aData)
        write_mspi_CDRAM11_cdram_value = aData
        flag_mspi_CDRAM11_cdram        = &H1
    End Property

    Property Get read_mspi_CDRAM11_cdram
        read
        read_mspi_CDRAM11_cdram = read_mspi_CDRAM11_cdram_value
    End Property

    Property Let write_mspi_CDRAM11_cdram(aData)
        set_mspi_CDRAM11_cdram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_CDRAM11_cdram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_CDRAM11_cdram_mask = mask then
                read_mspi_CDRAM11_cdram_value = data_low
            else
                read_mspi_CDRAM11_cdram_value = (data_low - H8000_0000) and mspi_CDRAM11_cdram_mask
            end If
        else
            read_mspi_CDRAM11_cdram_value = data_low and mspi_CDRAM11_cdram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_CDRAM11_cdram = &H0 Then read
        If flag_mspi_CDRAM11_cdram = &H0 Then write_mspi_CDRAM11_cdram_value = get_mspi_CDRAM11_cdram

        regValue = leftShift((write_mspi_CDRAM11_cdram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_CDRAM11_cdram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_CDRAM11_cdram_mask = mask then
                read_mspi_CDRAM11_cdram_value = data_low
            else
                read_mspi_CDRAM11_cdram_value = (data_low - H8000_0000) and mspi_CDRAM11_cdram_mask
            end If
        else
            read_mspi_CDRAM11_cdram_value = data_low and mspi_CDRAM11_cdram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_CDRAM11_cdram_value = &H0
        flag_mspi_CDRAM11_cdram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_cdram12
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_CDRAM12_cdram                         [7:0]            get_mspi_CDRAM12_cdram
''                                                             set_mspi_CDRAM12_cdram
''                                                             read_mspi_CDRAM12_cdram
''                                                             write_mspi_CDRAM12_cdram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_cdram12
    Private write_mspi_CDRAM12_cdram_value
    Private read_mspi_CDRAM12_cdram_value
    Private flag_mspi_CDRAM12_cdram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H370
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_CDRAM12_cdram
        get_mspi_CDRAM12_cdram = read_mspi_CDRAM12_cdram_value
    End Property

    Property Let set_mspi_CDRAM12_cdram(aData)
        write_mspi_CDRAM12_cdram_value = aData
        flag_mspi_CDRAM12_cdram        = &H1
    End Property

    Property Get read_mspi_CDRAM12_cdram
        read
        read_mspi_CDRAM12_cdram = read_mspi_CDRAM12_cdram_value
    End Property

    Property Let write_mspi_CDRAM12_cdram(aData)
        set_mspi_CDRAM12_cdram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_CDRAM12_cdram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_CDRAM12_cdram_mask = mask then
                read_mspi_CDRAM12_cdram_value = data_low
            else
                read_mspi_CDRAM12_cdram_value = (data_low - H8000_0000) and mspi_CDRAM12_cdram_mask
            end If
        else
            read_mspi_CDRAM12_cdram_value = data_low and mspi_CDRAM12_cdram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_CDRAM12_cdram = &H0 Then read
        If flag_mspi_CDRAM12_cdram = &H0 Then write_mspi_CDRAM12_cdram_value = get_mspi_CDRAM12_cdram

        regValue = leftShift((write_mspi_CDRAM12_cdram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_CDRAM12_cdram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_CDRAM12_cdram_mask = mask then
                read_mspi_CDRAM12_cdram_value = data_low
            else
                read_mspi_CDRAM12_cdram_value = (data_low - H8000_0000) and mspi_CDRAM12_cdram_mask
            end If
        else
            read_mspi_CDRAM12_cdram_value = data_low and mspi_CDRAM12_cdram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_CDRAM12_cdram_value = &H0
        flag_mspi_CDRAM12_cdram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_cdram13
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_CDRAM13_cdram                         [7:0]            get_mspi_CDRAM13_cdram
''                                                             set_mspi_CDRAM13_cdram
''                                                             read_mspi_CDRAM13_cdram
''                                                             write_mspi_CDRAM13_cdram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_cdram13
    Private write_mspi_CDRAM13_cdram_value
    Private read_mspi_CDRAM13_cdram_value
    Private flag_mspi_CDRAM13_cdram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H374
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_CDRAM13_cdram
        get_mspi_CDRAM13_cdram = read_mspi_CDRAM13_cdram_value
    End Property

    Property Let set_mspi_CDRAM13_cdram(aData)
        write_mspi_CDRAM13_cdram_value = aData
        flag_mspi_CDRAM13_cdram        = &H1
    End Property

    Property Get read_mspi_CDRAM13_cdram
        read
        read_mspi_CDRAM13_cdram = read_mspi_CDRAM13_cdram_value
    End Property

    Property Let write_mspi_CDRAM13_cdram(aData)
        set_mspi_CDRAM13_cdram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_CDRAM13_cdram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_CDRAM13_cdram_mask = mask then
                read_mspi_CDRAM13_cdram_value = data_low
            else
                read_mspi_CDRAM13_cdram_value = (data_low - H8000_0000) and mspi_CDRAM13_cdram_mask
            end If
        else
            read_mspi_CDRAM13_cdram_value = data_low and mspi_CDRAM13_cdram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_CDRAM13_cdram = &H0 Then read
        If flag_mspi_CDRAM13_cdram = &H0 Then write_mspi_CDRAM13_cdram_value = get_mspi_CDRAM13_cdram

        regValue = leftShift((write_mspi_CDRAM13_cdram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_CDRAM13_cdram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_CDRAM13_cdram_mask = mask then
                read_mspi_CDRAM13_cdram_value = data_low
            else
                read_mspi_CDRAM13_cdram_value = (data_low - H8000_0000) and mspi_CDRAM13_cdram_mask
            end If
        else
            read_mspi_CDRAM13_cdram_value = data_low and mspi_CDRAM13_cdram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_CDRAM13_cdram_value = &H0
        flag_mspi_CDRAM13_cdram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_cdram14
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_CDRAM14_cdram                         [7:0]            get_mspi_CDRAM14_cdram
''                                                             set_mspi_CDRAM14_cdram
''                                                             read_mspi_CDRAM14_cdram
''                                                             write_mspi_CDRAM14_cdram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_cdram14
    Private write_mspi_CDRAM14_cdram_value
    Private read_mspi_CDRAM14_cdram_value
    Private flag_mspi_CDRAM14_cdram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H378
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_CDRAM14_cdram
        get_mspi_CDRAM14_cdram = read_mspi_CDRAM14_cdram_value
    End Property

    Property Let set_mspi_CDRAM14_cdram(aData)
        write_mspi_CDRAM14_cdram_value = aData
        flag_mspi_CDRAM14_cdram        = &H1
    End Property

    Property Get read_mspi_CDRAM14_cdram
        read
        read_mspi_CDRAM14_cdram = read_mspi_CDRAM14_cdram_value
    End Property

    Property Let write_mspi_CDRAM14_cdram(aData)
        set_mspi_CDRAM14_cdram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_CDRAM14_cdram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_CDRAM14_cdram_mask = mask then
                read_mspi_CDRAM14_cdram_value = data_low
            else
                read_mspi_CDRAM14_cdram_value = (data_low - H8000_0000) and mspi_CDRAM14_cdram_mask
            end If
        else
            read_mspi_CDRAM14_cdram_value = data_low and mspi_CDRAM14_cdram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_CDRAM14_cdram = &H0 Then read
        If flag_mspi_CDRAM14_cdram = &H0 Then write_mspi_CDRAM14_cdram_value = get_mspi_CDRAM14_cdram

        regValue = leftShift((write_mspi_CDRAM14_cdram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_CDRAM14_cdram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_CDRAM14_cdram_mask = mask then
                read_mspi_CDRAM14_cdram_value = data_low
            else
                read_mspi_CDRAM14_cdram_value = (data_low - H8000_0000) and mspi_CDRAM14_cdram_mask
            end If
        else
            read_mspi_CDRAM14_cdram_value = data_low and mspi_CDRAM14_cdram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_CDRAM14_cdram_value = &H0
        flag_mspi_CDRAM14_cdram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_cdram15
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_CDRAM15_cdram                         [7:0]            get_mspi_CDRAM15_cdram
''                                                             set_mspi_CDRAM15_cdram
''                                                             read_mspi_CDRAM15_cdram
''                                                             write_mspi_CDRAM15_cdram
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_cdram15
    Private write_mspi_CDRAM15_cdram_value
    Private read_mspi_CDRAM15_cdram_value
    Private flag_mspi_CDRAM15_cdram

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H37c
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_CDRAM15_cdram
        get_mspi_CDRAM15_cdram = read_mspi_CDRAM15_cdram_value
    End Property

    Property Let set_mspi_CDRAM15_cdram(aData)
        write_mspi_CDRAM15_cdram_value = aData
        flag_mspi_CDRAM15_cdram        = &H1
    End Property

    Property Get read_mspi_CDRAM15_cdram
        read
        read_mspi_CDRAM15_cdram = read_mspi_CDRAM15_cdram_value
    End Property

    Property Let write_mspi_CDRAM15_cdram(aData)
        set_mspi_CDRAM15_cdram = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_CDRAM15_cdram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_CDRAM15_cdram_mask = mask then
                read_mspi_CDRAM15_cdram_value = data_low
            else
                read_mspi_CDRAM15_cdram_value = (data_low - H8000_0000) and mspi_CDRAM15_cdram_mask
            end If
        else
            read_mspi_CDRAM15_cdram_value = data_low and mspi_CDRAM15_cdram_mask
        end If

    End Sub

    Sub write
        If flag_mspi_CDRAM15_cdram = &H0 Then read
        If flag_mspi_CDRAM15_cdram = &H0 Then write_mspi_CDRAM15_cdram_value = get_mspi_CDRAM15_cdram

        regValue = leftShift((write_mspi_CDRAM15_cdram_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_CDRAM15_cdram_mask = &Hff
        if data_low > LONG_MAX then
            if mspi_CDRAM15_cdram_mask = mask then
                read_mspi_CDRAM15_cdram_value = data_low
            else
                read_mspi_CDRAM15_cdram_value = (data_low - H8000_0000) and mspi_CDRAM15_cdram_mask
            end If
        else
            read_mspi_CDRAM15_cdram_value = data_low and mspi_CDRAM15_cdram_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_CDRAM15_cdram_value = &H0
        flag_mspi_CDRAM15_cdram        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_write_lock
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_WRITE_LOCK_WriteLock                  [0:0]            get_mspi_WRITE_LOCK_WriteLock
''                                                             set_mspi_WRITE_LOCK_WriteLock
''                                                             read_mspi_WRITE_LOCK_WriteLock
''                                                             write_mspi_WRITE_LOCK_WriteLock
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_write_lock
    Private write_mspi_WRITE_LOCK_WriteLock_value
    Private read_mspi_WRITE_LOCK_WriteLock_value
    Private flag_mspi_WRITE_LOCK_WriteLock

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H380
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_WRITE_LOCK_WriteLock
        get_mspi_WRITE_LOCK_WriteLock = read_mspi_WRITE_LOCK_WriteLock_value
    End Property

    Property Let set_mspi_WRITE_LOCK_WriteLock(aData)
        write_mspi_WRITE_LOCK_WriteLock_value = aData
        flag_mspi_WRITE_LOCK_WriteLock        = &H1
    End Property

    Property Get read_mspi_WRITE_LOCK_WriteLock
        read
        read_mspi_WRITE_LOCK_WriteLock = read_mspi_WRITE_LOCK_WriteLock_value
    End Property

    Property Let write_mspi_WRITE_LOCK_WriteLock(aData)
        set_mspi_WRITE_LOCK_WriteLock = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_WRITE_LOCK_WriteLock_mask = &H1
        if data_low > LONG_MAX then
            if mspi_WRITE_LOCK_WriteLock_mask = mask then
                read_mspi_WRITE_LOCK_WriteLock_value = data_low
            else
                read_mspi_WRITE_LOCK_WriteLock_value = (data_low - H8000_0000) and mspi_WRITE_LOCK_WriteLock_mask
            end If
        else
            read_mspi_WRITE_LOCK_WriteLock_value = data_low and mspi_WRITE_LOCK_WriteLock_mask
        end If

    End Sub

    Sub write
        If flag_mspi_WRITE_LOCK_WriteLock = &H0 Then read
        If flag_mspi_WRITE_LOCK_WriteLock = &H0 Then write_mspi_WRITE_LOCK_WriteLock_value = get_mspi_WRITE_LOCK_WriteLock

        regValue = leftShift((write_mspi_WRITE_LOCK_WriteLock_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_WRITE_LOCK_WriteLock_mask = &H1
        if data_low > LONG_MAX then
            if mspi_WRITE_LOCK_WriteLock_mask = mask then
                read_mspi_WRITE_LOCK_WriteLock_value = data_low
            else
                read_mspi_WRITE_LOCK_WriteLock_value = (data_low - H8000_0000) and mspi_WRITE_LOCK_WriteLock_mask
            end If
        else
            read_mspi_WRITE_LOCK_WriteLock_value = data_low and mspi_WRITE_LOCK_WriteLock_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_WRITE_LOCK_WriteLock_value = &H0
        flag_mspi_WRITE_LOCK_WriteLock        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_disable_flush_gen
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' mspi_DISABLE_FLUSH_GEN_DisableFlushGen     [0:0]            get_mspi_DISABLE_FLUSH_GEN_DisableFlushGen
''                                                             set_mspi_DISABLE_FLUSH_GEN_DisableFlushGen
''                                                             read_mspi_DISABLE_FLUSH_GEN_DisableFlushGen
''                                                             write_mspi_DISABLE_FLUSH_GEN_DisableFlushGen
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_disable_flush_gen
    Private write_mspi_DISABLE_FLUSH_GEN_DisableFlushGen_value
    Private read_mspi_DISABLE_FLUSH_GEN_DisableFlushGen_value
    Private flag_mspi_DISABLE_FLUSH_GEN_DisableFlushGen

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H384
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_mspi_DISABLE_FLUSH_GEN_DisableFlushGen
        get_mspi_DISABLE_FLUSH_GEN_DisableFlushGen = read_mspi_DISABLE_FLUSH_GEN_DisableFlushGen_value
    End Property

    Property Let set_mspi_DISABLE_FLUSH_GEN_DisableFlushGen(aData)
        write_mspi_DISABLE_FLUSH_GEN_DisableFlushGen_value = aData
        flag_mspi_DISABLE_FLUSH_GEN_DisableFlushGen        = &H1
    End Property

    Property Get read_mspi_DISABLE_FLUSH_GEN_DisableFlushGen
        read
        read_mspi_DISABLE_FLUSH_GEN_DisableFlushGen = read_mspi_DISABLE_FLUSH_GEN_DisableFlushGen_value
    End Property

    Property Let write_mspi_DISABLE_FLUSH_GEN_DisableFlushGen(aData)
        set_mspi_DISABLE_FLUSH_GEN_DisableFlushGen = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_DISABLE_FLUSH_GEN_DisableFlushGen_mask = &H1
        if data_low > LONG_MAX then
            if mspi_DISABLE_FLUSH_GEN_DisableFlushGen_mask = mask then
                read_mspi_DISABLE_FLUSH_GEN_DisableFlushGen_value = data_low
            else
                read_mspi_DISABLE_FLUSH_GEN_DisableFlushGen_value = (data_low - H8000_0000) and mspi_DISABLE_FLUSH_GEN_DisableFlushGen_mask
            end If
        else
            read_mspi_DISABLE_FLUSH_GEN_DisableFlushGen_value = data_low and mspi_DISABLE_FLUSH_GEN_DisableFlushGen_mask
        end If

    End Sub

    Sub write
        If flag_mspi_DISABLE_FLUSH_GEN_DisableFlushGen = &H0 Then read
        If flag_mspi_DISABLE_FLUSH_GEN_DisableFlushGen = &H0 Then write_mspi_DISABLE_FLUSH_GEN_DisableFlushGen_value = get_mspi_DISABLE_FLUSH_GEN_DisableFlushGen

        regValue = leftShift((write_mspi_DISABLE_FLUSH_GEN_DisableFlushGen_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        mspi_DISABLE_FLUSH_GEN_DisableFlushGen_mask = &H1
        if data_low > LONG_MAX then
            if mspi_DISABLE_FLUSH_GEN_DisableFlushGen_mask = mask then
                read_mspi_DISABLE_FLUSH_GEN_DisableFlushGen_value = data_low
            else
                read_mspi_DISABLE_FLUSH_GEN_DisableFlushGen_value = (data_low - H8000_0000) and mspi_DISABLE_FLUSH_GEN_DisableFlushGen_mask
            end If
        else
            read_mspi_DISABLE_FLUSH_GEN_DisableFlushGen_value = data_low and mspi_DISABLE_FLUSH_GEN_DisableFlushGen_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_mspi_DISABLE_FLUSH_GEN_DisableFlushGen_value = &H0
        flag_mspi_DISABLE_FLUSH_GEN_DisableFlushGen        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_raf_interrupt_lr_fullness_reached
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RILFRRILFRR1                               [31:1]           get_RILFRRILFRR1
''                                                             set_RILFRRILFRR1
''                                                             read_RILFRRILFRR1
''                                                             write_RILFRRILFRR1
''---------------------------------------------------------------------------------
'' RILFRSLFR1                                 [0:0]            get_RILFRSLFR1
''                                                             set_RILFRSLFR1
''                                                             read_RILFRSLFR1
''                                                             write_RILFRSLFR1
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_raf_interrupt_lr_fullness_reached
    Private write_RILFRRILFRR1_value
    Private read_RILFRRILFRR1_value
    Private flag_RILFRRILFRR1
    Private write_RILFRSLFR1_value
    Private read_RILFRSLFR1_value
    Private flag_RILFRSLFR1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3a0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_RILFRRILFRR1
        get_RILFRRILFRR1 = read_RILFRRILFRR1_value
    End Property

    Property Let set_RILFRRILFRR1(aData)
        write_RILFRRILFRR1_value = aData
        flag_RILFRRILFRR1        = &H1
    End Property

    Property Get read_RILFRRILFRR1
        read
        read_RILFRRILFRR1 = read_RILFRRILFRR1_value
    End Property

    Property Let write_RILFRRILFRR1(aData)
        set_RILFRRILFRR1 = aData
        write
    End Property

    Property Get get_RILFRSLFR1
        get_RILFRSLFR1 = read_RILFRSLFR1_value
    End Property

    Property Let set_RILFRSLFR1(aData)
        write_RILFRSLFR1_value = aData
        flag_RILFRSLFR1        = &H1
    End Property

    Property Get read_RILFRSLFR1
        read
        read_RILFRSLFR1 = read_RILFRSLFR1_value
    End Property

    Property Let write_RILFRSLFR1(aData)
        set_RILFRSLFR1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RILFRRILFRR1_value = rightShift(data_low, 1) and &H7fffffff
        RILFRSLFR1_mask = &H1
        if data_low > LONG_MAX then
            if RILFRSLFR1_mask = mask then
                read_RILFRSLFR1_value = data_low
            else
                read_RILFRSLFR1_value = (data_low - H8000_0000) and RILFRSLFR1_mask
            end If
        else
            read_RILFRSLFR1_value = data_low and RILFRSLFR1_mask
        end If

    End Sub

    Sub write
        If flag_RILFRRILFRR1 = &H0 or flag_RILFRSLFR1 = &H0 Then read
        If flag_RILFRRILFRR1 = &H0 Then write_RILFRRILFRR1_value = get_RILFRRILFRR1
        If flag_RILFRSLFR1 = &H0 Then write_RILFRSLFR1_value = get_RILFRSLFR1

        regValue = leftShift((write_RILFRRILFRR1_value and &H7fffffff), 1) + leftShift((write_RILFRSLFR1_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RILFRRILFRR1_value = rightShift(data_low, 1) and &H7fffffff
        RILFRSLFR1_mask = &H1
        if data_low > LONG_MAX then
            if RILFRSLFR1_mask = mask then
                read_RILFRSLFR1_value = data_low
            else
                read_RILFRSLFR1_value = (data_low - H8000_0000) and RILFRSLFR1_mask
            end If
        else
            read_RILFRSLFR1_value = data_low and RILFRSLFR1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RILFRRILFRR1_value = &H0
        flag_RILFRRILFRR1        = &H0
        write_RILFRSLFR1_value = &H0
        flag_RILFRSLFR1        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_raf_interrupt_lr_truncated
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RILTRILTR1                                 [31:1]           get_RILTRILTR1
''                                                             set_RILTRILTR1
''                                                             read_RILTRILTR1
''                                                             write_RILTRILTR1
''---------------------------------------------------------------------------------
'' raf_interrupt_LR_truncated_spi_LR_truncated   [0:0]            get_raf_interrupt_LR_truncated_spi_LR_truncated
''                                                             set_raf_interrupt_LR_truncated_spi_LR_truncated
''                                                             read_raf_interrupt_LR_truncated_spi_LR_truncated
''                                                             write_raf_interrupt_LR_truncated_spi_LR_truncated
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_raf_interrupt_lr_truncated
    Private write_RILTRILTR1_value
    Private read_RILTRILTR1_value
    Private flag_RILTRILTR1
    Private write_raf_interrupt_LR_truncated_spi_LR_truncated_value
    Private read_raf_interrupt_LR_truncated_spi_LR_truncated_value
    Private flag_raf_interrupt_LR_truncated_spi_LR_truncated

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3a4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_RILTRILTR1
        get_RILTRILTR1 = read_RILTRILTR1_value
    End Property

    Property Let set_RILTRILTR1(aData)
        write_RILTRILTR1_value = aData
        flag_RILTRILTR1        = &H1
    End Property

    Property Get read_RILTRILTR1
        read
        read_RILTRILTR1 = read_RILTRILTR1_value
    End Property

    Property Let write_RILTRILTR1(aData)
        set_RILTRILTR1 = aData
        write
    End Property

    Property Get get_raf_interrupt_LR_truncated_spi_LR_truncated
        get_raf_interrupt_LR_truncated_spi_LR_truncated = read_raf_interrupt_LR_truncated_spi_LR_truncated_value
    End Property

    Property Let set_raf_interrupt_LR_truncated_spi_LR_truncated(aData)
        write_raf_interrupt_LR_truncated_spi_LR_truncated_value = aData
        flag_raf_interrupt_LR_truncated_spi_LR_truncated        = &H1
    End Property

    Property Get read_raf_interrupt_LR_truncated_spi_LR_truncated
        read
        read_raf_interrupt_LR_truncated_spi_LR_truncated = read_raf_interrupt_LR_truncated_spi_LR_truncated_value
    End Property

    Property Let write_raf_interrupt_LR_truncated_spi_LR_truncated(aData)
        set_raf_interrupt_LR_truncated_spi_LR_truncated = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RILTRILTR1_value = rightShift(data_low, 1) and &H7fffffff
        raf_interrupt_LR_truncated_spi_LR_truncated_mask = &H1
        if data_low > LONG_MAX then
            if raf_interrupt_LR_truncated_spi_LR_truncated_mask = mask then
                read_raf_interrupt_LR_truncated_spi_LR_truncated_value = data_low
            else
                read_raf_interrupt_LR_truncated_spi_LR_truncated_value = (data_low - H8000_0000) and raf_interrupt_LR_truncated_spi_LR_truncated_mask
            end If
        else
            read_raf_interrupt_LR_truncated_spi_LR_truncated_value = data_low and raf_interrupt_LR_truncated_spi_LR_truncated_mask
        end If

    End Sub

    Sub write
        If flag_RILTRILTR1 = &H0 or flag_raf_interrupt_LR_truncated_spi_LR_truncated = &H0 Then read
        If flag_RILTRILTR1 = &H0 Then write_RILTRILTR1_value = get_RILTRILTR1
        If flag_raf_interrupt_LR_truncated_spi_LR_truncated = &H0 Then write_raf_interrupt_LR_truncated_spi_LR_truncated_value = get_raf_interrupt_LR_truncated_spi_LR_truncated

        regValue = leftShift((write_RILTRILTR1_value and &H7fffffff), 1) + leftShift((write_raf_interrupt_LR_truncated_spi_LR_truncated_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RILTRILTR1_value = rightShift(data_low, 1) and &H7fffffff
        raf_interrupt_LR_truncated_spi_LR_truncated_mask = &H1
        if data_low > LONG_MAX then
            if raf_interrupt_LR_truncated_spi_LR_truncated_mask = mask then
                read_raf_interrupt_LR_truncated_spi_LR_truncated_value = data_low
            else
                read_raf_interrupt_LR_truncated_spi_LR_truncated_value = (data_low - H8000_0000) and raf_interrupt_LR_truncated_spi_LR_truncated_mask
            end If
        else
            read_raf_interrupt_LR_truncated_spi_LR_truncated_value = data_low and raf_interrupt_LR_truncated_spi_LR_truncated_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RILTRILTR1_value = &H0
        flag_RILTRILTR1        = &H0
        write_raf_interrupt_LR_truncated_spi_LR_truncated_value = &H0
        flag_raf_interrupt_LR_truncated_spi_LR_truncated        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_raf_interrupt_lr_impatient
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RILIRILIR1                                 [31:1]           get_RILIRILIR1
''                                                             set_RILIRILIR1
''                                                             read_RILIRILIR1
''                                                             write_RILIRILIR1
''---------------------------------------------------------------------------------
'' raf_interrupt_LR_impatient_spi_LR_impatient   [0:0]            get_raf_interrupt_LR_impatient_spi_LR_impatient
''                                                             set_raf_interrupt_LR_impatient_spi_LR_impatient
''                                                             read_raf_interrupt_LR_impatient_spi_LR_impatient
''                                                             write_raf_interrupt_LR_impatient_spi_LR_impatient
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_raf_interrupt_lr_impatient
    Private write_RILIRILIR1_value
    Private read_RILIRILIR1_value
    Private flag_RILIRILIR1
    Private write_raf_interrupt_LR_impatient_spi_LR_impatient_value
    Private read_raf_interrupt_LR_impatient_spi_LR_impatient_value
    Private flag_raf_interrupt_LR_impatient_spi_LR_impatient

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3a8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_RILIRILIR1
        get_RILIRILIR1 = read_RILIRILIR1_value
    End Property

    Property Let set_RILIRILIR1(aData)
        write_RILIRILIR1_value = aData
        flag_RILIRILIR1        = &H1
    End Property

    Property Get read_RILIRILIR1
        read
        read_RILIRILIR1 = read_RILIRILIR1_value
    End Property

    Property Let write_RILIRILIR1(aData)
        set_RILIRILIR1 = aData
        write
    End Property

    Property Get get_raf_interrupt_LR_impatient_spi_LR_impatient
        get_raf_interrupt_LR_impatient_spi_LR_impatient = read_raf_interrupt_LR_impatient_spi_LR_impatient_value
    End Property

    Property Let set_raf_interrupt_LR_impatient_spi_LR_impatient(aData)
        write_raf_interrupt_LR_impatient_spi_LR_impatient_value = aData
        flag_raf_interrupt_LR_impatient_spi_LR_impatient        = &H1
    End Property

    Property Get read_raf_interrupt_LR_impatient_spi_LR_impatient
        read
        read_raf_interrupt_LR_impatient_spi_LR_impatient = read_raf_interrupt_LR_impatient_spi_LR_impatient_value
    End Property

    Property Let write_raf_interrupt_LR_impatient_spi_LR_impatient(aData)
        set_raf_interrupt_LR_impatient_spi_LR_impatient = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RILIRILIR1_value = rightShift(data_low, 1) and &H7fffffff
        raf_interrupt_LR_impatient_spi_LR_impatient_mask = &H1
        if data_low > LONG_MAX then
            if raf_interrupt_LR_impatient_spi_LR_impatient_mask = mask then
                read_raf_interrupt_LR_impatient_spi_LR_impatient_value = data_low
            else
                read_raf_interrupt_LR_impatient_spi_LR_impatient_value = (data_low - H8000_0000) and raf_interrupt_LR_impatient_spi_LR_impatient_mask
            end If
        else
            read_raf_interrupt_LR_impatient_spi_LR_impatient_value = data_low and raf_interrupt_LR_impatient_spi_LR_impatient_mask
        end If

    End Sub

    Sub write
        If flag_RILIRILIR1 = &H0 or flag_raf_interrupt_LR_impatient_spi_LR_impatient = &H0 Then read
        If flag_RILIRILIR1 = &H0 Then write_RILIRILIR1_value = get_RILIRILIR1
        If flag_raf_interrupt_LR_impatient_spi_LR_impatient = &H0 Then write_raf_interrupt_LR_impatient_spi_LR_impatient_value = get_raf_interrupt_LR_impatient_spi_LR_impatient

        regValue = leftShift((write_RILIRILIR1_value and &H7fffffff), 1) + leftShift((write_raf_interrupt_LR_impatient_spi_LR_impatient_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RILIRILIR1_value = rightShift(data_low, 1) and &H7fffffff
        raf_interrupt_LR_impatient_spi_LR_impatient_mask = &H1
        if data_low > LONG_MAX then
            if raf_interrupt_LR_impatient_spi_LR_impatient_mask = mask then
                read_raf_interrupt_LR_impatient_spi_LR_impatient_value = data_low
            else
                read_raf_interrupt_LR_impatient_spi_LR_impatient_value = (data_low - H8000_0000) and raf_interrupt_LR_impatient_spi_LR_impatient_mask
            end If
        else
            read_raf_interrupt_LR_impatient_spi_LR_impatient_value = data_low and raf_interrupt_LR_impatient_spi_LR_impatient_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RILIRILIR1_value = &H0
        flag_RILIRILIR1        = &H0
        write_raf_interrupt_LR_impatient_spi_LR_impatient_value = &H0
        flag_raf_interrupt_LR_impatient_spi_LR_impatient        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_raf_interrupt_lr_session_done
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RILSDRILSDR1                               [31:1]           get_RILSDRILSDR1
''                                                             set_RILSDRILSDR1
''                                                             read_RILSDRILSDR1
''                                                             write_RILSDRILSDR1
''---------------------------------------------------------------------------------
'' RILSDSLSD1                                 [0:0]            get_RILSDSLSD1
''                                                             set_RILSDSLSD1
''                                                             read_RILSDSLSD1
''                                                             write_RILSDSLSD1
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_raf_interrupt_lr_session_done
    Private write_RILSDRILSDR1_value
    Private read_RILSDRILSDR1_value
    Private flag_RILSDRILSDR1
    Private write_RILSDSLSD1_value
    Private read_RILSDSLSD1_value
    Private flag_RILSDSLSD1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3ac
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_RILSDRILSDR1
        get_RILSDRILSDR1 = read_RILSDRILSDR1_value
    End Property

    Property Let set_RILSDRILSDR1(aData)
        write_RILSDRILSDR1_value = aData
        flag_RILSDRILSDR1        = &H1
    End Property

    Property Get read_RILSDRILSDR1
        read
        read_RILSDRILSDR1 = read_RILSDRILSDR1_value
    End Property

    Property Let write_RILSDRILSDR1(aData)
        set_RILSDRILSDR1 = aData
        write
    End Property

    Property Get get_RILSDSLSD1
        get_RILSDSLSD1 = read_RILSDSLSD1_value
    End Property

    Property Let set_RILSDSLSD1(aData)
        write_RILSDSLSD1_value = aData
        flag_RILSDSLSD1        = &H1
    End Property

    Property Get read_RILSDSLSD1
        read
        read_RILSDSLSD1 = read_RILSDSLSD1_value
    End Property

    Property Let write_RILSDSLSD1(aData)
        set_RILSDSLSD1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RILSDRILSDR1_value = rightShift(data_low, 1) and &H7fffffff
        RILSDSLSD1_mask = &H1
        if data_low > LONG_MAX then
            if RILSDSLSD1_mask = mask then
                read_RILSDSLSD1_value = data_low
            else
                read_RILSDSLSD1_value = (data_low - H8000_0000) and RILSDSLSD1_mask
            end If
        else
            read_RILSDSLSD1_value = data_low and RILSDSLSD1_mask
        end If

    End Sub

    Sub write
        If flag_RILSDRILSDR1 = &H0 or flag_RILSDSLSD1 = &H0 Then read
        If flag_RILSDRILSDR1 = &H0 Then write_RILSDRILSDR1_value = get_RILSDRILSDR1
        If flag_RILSDSLSD1 = &H0 Then write_RILSDSLSD1_value = get_RILSDSLSD1

        regValue = leftShift((write_RILSDRILSDR1_value and &H7fffffff), 1) + leftShift((write_RILSDSLSD1_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RILSDRILSDR1_value = rightShift(data_low, 1) and &H7fffffff
        RILSDSLSD1_mask = &H1
        if data_low > LONG_MAX then
            if RILSDSLSD1_mask = mask then
                read_RILSDSLSD1_value = data_low
            else
                read_RILSDSLSD1_value = (data_low - H8000_0000) and RILSDSLSD1_mask
            end If
        else
            read_RILSDSLSD1_value = data_low and RILSDSLSD1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RILSDRILSDR1_value = &H0
        flag_RILSDRILSDR1        = &H0
        write_RILSDSLSD1_value = &H0
        flag_RILSDSLSD1        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_raf_interrupt_lr_overread
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RILORILOR1                                 [31:1]           get_RILORILOR1
''                                                             set_RILORILOR1
''                                                             read_RILORILOR1
''                                                             write_RILORILOR1
''---------------------------------------------------------------------------------
'' raf_interrupt_LR_overread_spi_LR_overread   [0:0]            get_raf_interrupt_LR_overread_spi_LR_overread
''                                                             set_raf_interrupt_LR_overread_spi_LR_overread
''                                                             read_raf_interrupt_LR_overread_spi_LR_overread
''                                                             write_raf_interrupt_LR_overread_spi_LR_overread
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_raf_interrupt_lr_overread
    Private write_RILORILOR1_value
    Private read_RILORILOR1_value
    Private flag_RILORILOR1
    Private write_raf_interrupt_LR_overread_spi_LR_overread_value
    Private read_raf_interrupt_LR_overread_spi_LR_overread_value
    Private flag_raf_interrupt_LR_overread_spi_LR_overread

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3b0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_RILORILOR1
        get_RILORILOR1 = read_RILORILOR1_value
    End Property

    Property Let set_RILORILOR1(aData)
        write_RILORILOR1_value = aData
        flag_RILORILOR1        = &H1
    End Property

    Property Get read_RILORILOR1
        read
        read_RILORILOR1 = read_RILORILOR1_value
    End Property

    Property Let write_RILORILOR1(aData)
        set_RILORILOR1 = aData
        write
    End Property

    Property Get get_raf_interrupt_LR_overread_spi_LR_overread
        get_raf_interrupt_LR_overread_spi_LR_overread = read_raf_interrupt_LR_overread_spi_LR_overread_value
    End Property

    Property Let set_raf_interrupt_LR_overread_spi_LR_overread(aData)
        write_raf_interrupt_LR_overread_spi_LR_overread_value = aData
        flag_raf_interrupt_LR_overread_spi_LR_overread        = &H1
    End Property

    Property Get read_raf_interrupt_LR_overread_spi_LR_overread
        read
        read_raf_interrupt_LR_overread_spi_LR_overread = read_raf_interrupt_LR_overread_spi_LR_overread_value
    End Property

    Property Let write_raf_interrupt_LR_overread_spi_LR_overread(aData)
        set_raf_interrupt_LR_overread_spi_LR_overread = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RILORILOR1_value = rightShift(data_low, 1) and &H7fffffff
        raf_interrupt_LR_overread_spi_LR_overread_mask = &H1
        if data_low > LONG_MAX then
            if raf_interrupt_LR_overread_spi_LR_overread_mask = mask then
                read_raf_interrupt_LR_overread_spi_LR_overread_value = data_low
            else
                read_raf_interrupt_LR_overread_spi_LR_overread_value = (data_low - H8000_0000) and raf_interrupt_LR_overread_spi_LR_overread_mask
            end If
        else
            read_raf_interrupt_LR_overread_spi_LR_overread_value = data_low and raf_interrupt_LR_overread_spi_LR_overread_mask
        end If

    End Sub

    Sub write
        If flag_RILORILOR1 = &H0 or flag_raf_interrupt_LR_overread_spi_LR_overread = &H0 Then read
        If flag_RILORILOR1 = &H0 Then write_RILORILOR1_value = get_RILORILOR1
        If flag_raf_interrupt_LR_overread_spi_LR_overread = &H0 Then write_raf_interrupt_LR_overread_spi_LR_overread_value = get_raf_interrupt_LR_overread_spi_LR_overread

        regValue = leftShift((write_RILORILOR1_value and &H7fffffff), 1) + leftShift((write_raf_interrupt_LR_overread_spi_LR_overread_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RILORILOR1_value = rightShift(data_low, 1) and &H7fffffff
        raf_interrupt_LR_overread_spi_LR_overread_mask = &H1
        if data_low > LONG_MAX then
            if raf_interrupt_LR_overread_spi_LR_overread_mask = mask then
                read_raf_interrupt_LR_overread_spi_LR_overread_value = data_low
            else
                read_raf_interrupt_LR_overread_spi_LR_overread_value = (data_low - H8000_0000) and raf_interrupt_LR_overread_spi_LR_overread_mask
            end If
        else
            read_raf_interrupt_LR_overread_spi_LR_overread_value = data_low and raf_interrupt_LR_overread_spi_LR_overread_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RILORILOR1_value = &H0
        flag_RILORILOR1        = &H0
        write_raf_interrupt_LR_overread_spi_LR_overread_value = &H0
        flag_raf_interrupt_LR_overread_spi_LR_overread        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_interrupt_mspi_done
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MIMDMIMDR1                                 [31:1]           get_MIMDMIMDR1
''                                                             set_MIMDMIMDR1
''                                                             read_MIMDMIMDR1
''                                                             write_MIMDMIMDR1
''---------------------------------------------------------------------------------
'' mspi_interrupt_MSPI_done_MSPI_done         [0:0]            get_mspi_interrupt_MSPI_done_MSPI_done
''                                                             set_mspi_interrupt_MSPI_done_MSPI_done
''                                                             read_mspi_interrupt_MSPI_done_MSPI_done
''                                                             write_mspi_interrupt_MSPI_done_MSPI_done
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_interrupt_mspi_done
    Private write_MIMDMIMDR1_value
    Private read_MIMDMIMDR1_value
    Private flag_MIMDMIMDR1
    Private write_mspi_interrupt_MSPI_done_MSPI_done_value
    Private read_mspi_interrupt_MSPI_done_MSPI_done_value
    Private flag_mspi_interrupt_MSPI_done_MSPI_done

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3b4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MIMDMIMDR1
        get_MIMDMIMDR1 = read_MIMDMIMDR1_value
    End Property

    Property Let set_MIMDMIMDR1(aData)
        write_MIMDMIMDR1_value = aData
        flag_MIMDMIMDR1        = &H1
    End Property

    Property Get read_MIMDMIMDR1
        read
        read_MIMDMIMDR1 = read_MIMDMIMDR1_value
    End Property

    Property Let write_MIMDMIMDR1(aData)
        set_MIMDMIMDR1 = aData
        write
    End Property

    Property Get get_mspi_interrupt_MSPI_done_MSPI_done
        get_mspi_interrupt_MSPI_done_MSPI_done = read_mspi_interrupt_MSPI_done_MSPI_done_value
    End Property

    Property Let set_mspi_interrupt_MSPI_done_MSPI_done(aData)
        write_mspi_interrupt_MSPI_done_MSPI_done_value = aData
        flag_mspi_interrupt_MSPI_done_MSPI_done        = &H1
    End Property

    Property Get read_mspi_interrupt_MSPI_done_MSPI_done
        read
        read_mspi_interrupt_MSPI_done_MSPI_done = read_mspi_interrupt_MSPI_done_MSPI_done_value
    End Property

    Property Let write_mspi_interrupt_MSPI_done_MSPI_done(aData)
        set_mspi_interrupt_MSPI_done_MSPI_done = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MIMDMIMDR1_value = rightShift(data_low, 1) and &H7fffffff
        mspi_interrupt_MSPI_done_MSPI_done_mask = &H1
        if data_low > LONG_MAX then
            if mspi_interrupt_MSPI_done_MSPI_done_mask = mask then
                read_mspi_interrupt_MSPI_done_MSPI_done_value = data_low
            else
                read_mspi_interrupt_MSPI_done_MSPI_done_value = (data_low - H8000_0000) and mspi_interrupt_MSPI_done_MSPI_done_mask
            end If
        else
            read_mspi_interrupt_MSPI_done_MSPI_done_value = data_low and mspi_interrupt_MSPI_done_MSPI_done_mask
        end If

    End Sub

    Sub write
        If flag_MIMDMIMDR1 = &H0 or flag_mspi_interrupt_MSPI_done_MSPI_done = &H0 Then read
        If flag_MIMDMIMDR1 = &H0 Then write_MIMDMIMDR1_value = get_MIMDMIMDR1
        If flag_mspi_interrupt_MSPI_done_MSPI_done = &H0 Then write_mspi_interrupt_MSPI_done_MSPI_done_value = get_mspi_interrupt_MSPI_done_MSPI_done

        regValue = leftShift((write_MIMDMIMDR1_value and &H7fffffff), 1) + leftShift((write_mspi_interrupt_MSPI_done_MSPI_done_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MIMDMIMDR1_value = rightShift(data_low, 1) and &H7fffffff
        mspi_interrupt_MSPI_done_MSPI_done_mask = &H1
        if data_low > LONG_MAX then
            if mspi_interrupt_MSPI_done_MSPI_done_mask = mask then
                read_mspi_interrupt_MSPI_done_MSPI_done_value = data_low
            else
                read_mspi_interrupt_MSPI_done_MSPI_done_value = (data_low - H8000_0000) and mspi_interrupt_MSPI_done_MSPI_done_mask
            end If
        else
            read_mspi_interrupt_MSPI_done_MSPI_done_value = data_low and mspi_interrupt_MSPI_done_MSPI_done_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MIMDMIMDR1_value = &H0
        flag_MIMDMIMDR1        = &H0
        write_mspi_interrupt_MSPI_done_MSPI_done_value = &H0
        flag_mspi_interrupt_MSPI_done_MSPI_done        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_mspi_interrupt_mspi_halt_set_transaction_done
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MIMHSTDMIMHSTDR1                           [31:1]           get_MIMHSTDMIMHSTDR1
''                                                             set_MIMHSTDMIMHSTDR1
''                                                             read_MIMHSTDMIMHSTDR1
''                                                             write_MIMHSTDMIMHSTDR1
''---------------------------------------------------------------------------------
'' MIMHSTDMHSTD1                              [0:0]            get_MIMHSTDMHSTD1
''                                                             set_MIMHSTDMHSTD1
''                                                             read_MIMHSTDMHSTD1
''                                                             write_MIMHSTDMHSTD1
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_mspi_interrupt_mspi_halt_set_transaction_done
    Private write_MIMHSTDMIMHSTDR1_value
    Private read_MIMHSTDMIMHSTDR1_value
    Private flag_MIMHSTDMIMHSTDR1
    Private write_MIMHSTDMHSTD1_value
    Private read_MIMHSTDMHSTD1_value
    Private flag_MIMHSTDMHSTD1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3b8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MIMHSTDMIMHSTDR1
        get_MIMHSTDMIMHSTDR1 = read_MIMHSTDMIMHSTDR1_value
    End Property

    Property Let set_MIMHSTDMIMHSTDR1(aData)
        write_MIMHSTDMIMHSTDR1_value = aData
        flag_MIMHSTDMIMHSTDR1        = &H1
    End Property

    Property Get read_MIMHSTDMIMHSTDR1
        read
        read_MIMHSTDMIMHSTDR1 = read_MIMHSTDMIMHSTDR1_value
    End Property

    Property Let write_MIMHSTDMIMHSTDR1(aData)
        set_MIMHSTDMIMHSTDR1 = aData
        write
    End Property

    Property Get get_MIMHSTDMHSTD1
        get_MIMHSTDMHSTD1 = read_MIMHSTDMHSTD1_value
    End Property

    Property Let set_MIMHSTDMHSTD1(aData)
        write_MIMHSTDMHSTD1_value = aData
        flag_MIMHSTDMHSTD1        = &H1
    End Property

    Property Get read_MIMHSTDMHSTD1
        read
        read_MIMHSTDMHSTD1 = read_MIMHSTDMHSTD1_value
    End Property

    Property Let write_MIMHSTDMHSTD1(aData)
        set_MIMHSTDMHSTD1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MIMHSTDMIMHSTDR1_value = rightShift(data_low, 1) and &H7fffffff
        MIMHSTDMHSTD1_mask = &H1
        if data_low > LONG_MAX then
            if MIMHSTDMHSTD1_mask = mask then
                read_MIMHSTDMHSTD1_value = data_low
            else
                read_MIMHSTDMHSTD1_value = (data_low - H8000_0000) and MIMHSTDMHSTD1_mask
            end If
        else
            read_MIMHSTDMHSTD1_value = data_low and MIMHSTDMHSTD1_mask
        end If

    End Sub

    Sub write
        If flag_MIMHSTDMIMHSTDR1 = &H0 or flag_MIMHSTDMHSTD1 = &H0 Then read
        If flag_MIMHSTDMIMHSTDR1 = &H0 Then write_MIMHSTDMIMHSTDR1_value = get_MIMHSTDMIMHSTDR1
        If flag_MIMHSTDMHSTD1 = &H0 Then write_MIMHSTDMHSTD1_value = get_MIMHSTDMHSTD1

        regValue = leftShift((write_MIMHSTDMIMHSTDR1_value and &H7fffffff), 1) + leftShift((write_MIMHSTDMHSTD1_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MIMHSTDMIMHSTDR1_value = rightShift(data_low, 1) and &H7fffffff
        MIMHSTDMHSTD1_mask = &H1
        if data_low > LONG_MAX then
            if MIMHSTDMHSTD1_mask = mask then
                read_MIMHSTDMHSTD1_value = data_low
            else
                read_MIMHSTDMHSTD1_value = (data_low - H8000_0000) and MIMHSTDMHSTD1_mask
            end If
        else
            read_MIMHSTDMHSTD1_value = data_low and MIMHSTDMHSTD1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MIMHSTDMIMHSTDR1_value = &H0
        flag_MIMHSTDMIMHSTDR1        = &H0
        write_MIMHSTDMHSTD1_value = &H0
        flag_MIMHSTDMHSTD1        = &H0
    End Sub
End Class


'' @REGISTER : QSPI_raf_interrupt_ecc
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' raf_interrupt_ECC_RSVD_1                   [31:2]           get_raf_interrupt_ECC_RSVD_1
''                                                             set_raf_interrupt_ECC_RSVD_1
''                                                             read_raf_interrupt_ECC_RSVD_1
''                                                             write_raf_interrupt_ECC_RSVD_1
''---------------------------------------------------------------------------------
'' raf_interrupt_ECC_DED                      [1:1]            get_raf_interrupt_ECC_DED
''                                                             set_raf_interrupt_ECC_DED
''                                                             read_raf_interrupt_ECC_DED
''                                                             write_raf_interrupt_ECC_DED
''---------------------------------------------------------------------------------
'' raf_interrupt_ECC_SEC                      [0:0]            get_raf_interrupt_ECC_SEC
''                                                             set_raf_interrupt_ECC_SEC
''                                                             read_raf_interrupt_ECC_SEC
''                                                             write_raf_interrupt_ECC_SEC
''---------------------------------------------------------------------------------
Class REGISTER_QSPI_raf_interrupt_ecc
    Private write_raf_interrupt_ECC_RSVD_1_value
    Private read_raf_interrupt_ECC_RSVD_1_value
    Private flag_raf_interrupt_ECC_RSVD_1
    Private write_raf_interrupt_ECC_DED_value
    Private read_raf_interrupt_ECC_DED_value
    Private flag_raf_interrupt_ECC_DED
    Private write_raf_interrupt_ECC_SEC_value
    Private read_raf_interrupt_ECC_SEC_value
    Private flag_raf_interrupt_ECC_SEC

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3bc
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_raf_interrupt_ECC_RSVD_1
        get_raf_interrupt_ECC_RSVD_1 = read_raf_interrupt_ECC_RSVD_1_value
    End Property

    Property Let set_raf_interrupt_ECC_RSVD_1(aData)
        write_raf_interrupt_ECC_RSVD_1_value = aData
        flag_raf_interrupt_ECC_RSVD_1        = &H1
    End Property

    Property Get read_raf_interrupt_ECC_RSVD_1
        read
        read_raf_interrupt_ECC_RSVD_1 = read_raf_interrupt_ECC_RSVD_1_value
    End Property

    Property Let write_raf_interrupt_ECC_RSVD_1(aData)
        set_raf_interrupt_ECC_RSVD_1 = aData
        write
    End Property

    Property Get get_raf_interrupt_ECC_DED
        get_raf_interrupt_ECC_DED = read_raf_interrupt_ECC_DED_value
    End Property

    Property Let set_raf_interrupt_ECC_DED(aData)
        write_raf_interrupt_ECC_DED_value = aData
        flag_raf_interrupt_ECC_DED        = &H1
    End Property

    Property Get read_raf_interrupt_ECC_DED
        read
        read_raf_interrupt_ECC_DED = read_raf_interrupt_ECC_DED_value
    End Property

    Property Let write_raf_interrupt_ECC_DED(aData)
        set_raf_interrupt_ECC_DED = aData
        write
    End Property

    Property Get get_raf_interrupt_ECC_SEC
        get_raf_interrupt_ECC_SEC = read_raf_interrupt_ECC_SEC_value
    End Property

    Property Let set_raf_interrupt_ECC_SEC(aData)
        write_raf_interrupt_ECC_SEC_value = aData
        flag_raf_interrupt_ECC_SEC        = &H1
    End Property

    Property Get read_raf_interrupt_ECC_SEC
        read
        read_raf_interrupt_ECC_SEC = read_raf_interrupt_ECC_SEC_value
    End Property

    Property Let write_raf_interrupt_ECC_SEC(aData)
        set_raf_interrupt_ECC_SEC = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_raf_interrupt_ECC_RSVD_1_value = rightShift(data_low, 2) and &H3fffffff
        read_raf_interrupt_ECC_DED_value = rightShift(data_low, 1) and &H1
        raf_interrupt_ECC_SEC_mask = &H1
        if data_low > LONG_MAX then
            if raf_interrupt_ECC_SEC_mask = mask then
                read_raf_interrupt_ECC_SEC_value = data_low
            else
                read_raf_interrupt_ECC_SEC_value = (data_low - H8000_0000) and raf_interrupt_ECC_SEC_mask
            end If
        else
            read_raf_interrupt_ECC_SEC_value = data_low and raf_interrupt_ECC_SEC_mask
        end If

    End Sub

    Sub write
        If flag_raf_interrupt_ECC_RSVD_1 = &H0 or flag_raf_interrupt_ECC_DED = &H0 or flag_raf_interrupt_ECC_SEC = &H0 Then read
        If flag_raf_interrupt_ECC_RSVD_1 = &H0 Then write_raf_interrupt_ECC_RSVD_1_value = get_raf_interrupt_ECC_RSVD_1
        If flag_raf_interrupt_ECC_DED = &H0 Then write_raf_interrupt_ECC_DED_value = get_raf_interrupt_ECC_DED
        If flag_raf_interrupt_ECC_SEC = &H0 Then write_raf_interrupt_ECC_SEC_value = get_raf_interrupt_ECC_SEC

        regValue = leftShift((write_raf_interrupt_ECC_RSVD_1_value and &H3fffffff), 2) + leftShift((write_raf_interrupt_ECC_DED_value and &H1), 1) + leftShift((write_raf_interrupt_ECC_SEC_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_raf_interrupt_ECC_RSVD_1_value = rightShift(data_low, 2) and &H3fffffff
        read_raf_interrupt_ECC_DED_value = rightShift(data_low, 1) and &H1
        raf_interrupt_ECC_SEC_mask = &H1
        if data_low > LONG_MAX then
            if raf_interrupt_ECC_SEC_mask = mask then
                read_raf_interrupt_ECC_SEC_value = data_low
            else
                read_raf_interrupt_ECC_SEC_value = (data_low - H8000_0000) and raf_interrupt_ECC_SEC_mask
            end If
        else
            read_raf_interrupt_ECC_SEC_value = data_low and raf_interrupt_ECC_SEC_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_raf_interrupt_ECC_RSVD_1_value = &H0
        flag_raf_interrupt_ECC_RSVD_1        = &H0
        write_raf_interrupt_ECC_DED_value = &H0
        flag_raf_interrupt_ECC_DED        = &H0
        write_raf_interrupt_ECC_SEC_value = &H0
        flag_raf_interrupt_ECC_SEC        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class QSPI_INSTANCE

    Public bspi_registers_revision_id
    Public bspi_registers_scratch
    Public bspi_registers_mast_n_boot_ctrl
    Public bspi_registers_busy_status
    Public bspi_registers_intr_status
    Public bspi_registers_b0_status
    Public bspi_registers_b0_ctrl
    Public bspi_registers_b1_status
    Public bspi_registers_b1_ctrl
    Public bspi_registers_strap_override_ctrl
    Public bspi_registers_flex_mode_enable
    Public bspi_registers_bits_per_cycle
    Public bspi_registers_bits_per_phase
    Public bspi_registers_cmd_and_mode_byte
    Public bspi_registers_bspi_flash_upper_addr_byte
    Public bspi_registers_bspi_xor_value
    Public bspi_registers_bspi_xor_enable
    Public bspi_registers_bspi_pio_mode_enable
    Public bspi_registers_bspi_pio_iodir
    Public bspi_registers_bspi_pio_data
    Public raf_start_addr
    Public raf_num_words
    Public raf_ctrl
    Public raf_fullness
    Public raf_watermark
    Public raf_status
    Public raf_read_data
    Public raf_word_cnt
    Public raf_curr_addr
    Public mspi_spcr0_lsb
    Public mspi_spcr0_msb
    Public mspi_spcr1_lsb
    Public mspi_spcr1_msb
    Public mspi_newqp
    Public mspi_endqp
    Public mspi_spcr2
    Public mspi_mspi_status
    Public mspi_cptqp
    Public mspi_txram00
    Public mspi_txram01
    Public mspi_txram02
    Public mspi_txram03
    Public mspi_txram04
    Public mspi_txram05
    Public mspi_txram06
    Public mspi_txram07
    Public mspi_txram08
    Public mspi_txram09
    Public mspi_txram10
    Public mspi_txram11
    Public mspi_txram12
    Public mspi_txram13
    Public mspi_txram14
    Public mspi_txram15
    Public mspi_txram16
    Public mspi_txram17
    Public mspi_txram18
    Public mspi_txram19
    Public mspi_txram20
    Public mspi_txram21
    Public mspi_txram22
    Public mspi_txram23
    Public mspi_txram24
    Public mspi_txram25
    Public mspi_txram26
    Public mspi_txram27
    Public mspi_txram28
    Public mspi_txram29
    Public mspi_txram30
    Public mspi_txram31
    Public mspi_rxram00
    Public mspi_rxram01
    Public mspi_rxram02
    Public mspi_rxram03
    Public mspi_rxram04
    Public mspi_rxram05
    Public mspi_rxram06
    Public mspi_rxram07
    Public mspi_rxram08
    Public mspi_rxram09
    Public mspi_rxram10
    Public mspi_rxram11
    Public mspi_rxram12
    Public mspi_rxram13
    Public mspi_rxram14
    Public mspi_rxram15
    Public mspi_rxram16
    Public mspi_rxram17
    Public mspi_rxram18
    Public mspi_rxram19
    Public mspi_rxram20
    Public mspi_rxram21
    Public mspi_rxram22
    Public mspi_rxram23
    Public mspi_rxram24
    Public mspi_rxram25
    Public mspi_rxram26
    Public mspi_rxram27
    Public mspi_rxram28
    Public mspi_rxram29
    Public mspi_rxram30
    Public mspi_rxram31
    Public mspi_cdram00
    Public mspi_cdram01
    Public mspi_cdram02
    Public mspi_cdram03
    Public mspi_cdram04
    Public mspi_cdram05
    Public mspi_cdram06
    Public mspi_cdram07
    Public mspi_cdram08
    Public mspi_cdram09
    Public mspi_cdram10
    Public mspi_cdram11
    Public mspi_cdram12
    Public mspi_cdram13
    Public mspi_cdram14
    Public mspi_cdram15
    Public mspi_write_lock
    Public mspi_disable_flush_gen
    Public raf_interrupt_lr_fullness_reached
    Public raf_interrupt_lr_truncated
    Public raf_interrupt_lr_impatient
    Public raf_interrupt_lr_session_done
    Public raf_interrupt_lr_overread
    Public mspi_interrupt_mspi_done
    Public mspi_interrupt_mspi_halt_set_transaction_done
    Public raf_interrupt_ecc


    Public default function Init(aBaseAddr)
        Set bspi_registers_revision_id = (New REGISTER_QSPI_bspi_registers_revision_id)(aBaseAddr, 32)
        Set bspi_registers_scratch = (New REGISTER_QSPI_bspi_registers_scratch)(aBaseAddr, 32)
        Set bspi_registers_mast_n_boot_ctrl = (New REGISTER_QSPI_bspi_registers_mast_n_boot_ctrl)(aBaseAddr, 32)
        Set bspi_registers_busy_status = (New REGISTER_QSPI_bspi_registers_busy_status)(aBaseAddr, 32)
        Set bspi_registers_intr_status = (New REGISTER_QSPI_bspi_registers_intr_status)(aBaseAddr, 32)
        Set bspi_registers_b0_status = (New REGISTER_QSPI_bspi_registers_b0_status)(aBaseAddr, 32)
        Set bspi_registers_b0_ctrl = (New REGISTER_QSPI_bspi_registers_b0_ctrl)(aBaseAddr, 32)
        Set bspi_registers_b1_status = (New REGISTER_QSPI_bspi_registers_b1_status)(aBaseAddr, 32)
        Set bspi_registers_b1_ctrl = (New REGISTER_QSPI_bspi_registers_b1_ctrl)(aBaseAddr, 32)
        Set bspi_registers_strap_override_ctrl = (New REGISTER_QSPI_bspi_registers_strap_override_ctrl)(aBaseAddr, 32)
        Set bspi_registers_flex_mode_enable = (New REGISTER_QSPI_bspi_registers_flex_mode_enable)(aBaseAddr, 32)
        Set bspi_registers_bits_per_cycle = (New REGISTER_QSPI_bspi_registers_bits_per_cycle)(aBaseAddr, 32)
        Set bspi_registers_bits_per_phase = (New REGISTER_QSPI_bspi_registers_bits_per_phase)(aBaseAddr, 32)
        Set bspi_registers_cmd_and_mode_byte = (New REGISTER_QSPI_bspi_registers_cmd_and_mode_byte)(aBaseAddr, 32)
        Set bspi_registers_bspi_flash_upper_addr_byte = (New REGISTER_QSPI_bspi_registers_bspi_flash_upper_addr_byte)(aBaseAddr, 32)
        Set bspi_registers_bspi_xor_value = (New REGISTER_QSPI_bspi_registers_bspi_xor_value)(aBaseAddr, 32)
        Set bspi_registers_bspi_xor_enable = (New REGISTER_QSPI_bspi_registers_bspi_xor_enable)(aBaseAddr, 32)
        Set bspi_registers_bspi_pio_mode_enable = (New REGISTER_QSPI_bspi_registers_bspi_pio_mode_enable)(aBaseAddr, 32)
        Set bspi_registers_bspi_pio_iodir = (New REGISTER_QSPI_bspi_registers_bspi_pio_iodir)(aBaseAddr, 32)
        Set bspi_registers_bspi_pio_data = (New REGISTER_QSPI_bspi_registers_bspi_pio_data)(aBaseAddr, 32)
        Set raf_start_addr = (New REGISTER_QSPI_raf_start_addr)(aBaseAddr, 32)
        Set raf_num_words = (New REGISTER_QSPI_raf_num_words)(aBaseAddr, 32)
        Set raf_ctrl = (New REGISTER_QSPI_raf_ctrl)(aBaseAddr, 32)
        Set raf_fullness = (New REGISTER_QSPI_raf_fullness)(aBaseAddr, 32)
        Set raf_watermark = (New REGISTER_QSPI_raf_watermark)(aBaseAddr, 32)
        Set raf_status = (New REGISTER_QSPI_raf_status)(aBaseAddr, 32)
        Set raf_read_data = (New REGISTER_QSPI_raf_read_data)(aBaseAddr, 32)
        Set raf_word_cnt = (New REGISTER_QSPI_raf_word_cnt)(aBaseAddr, 32)
        Set raf_curr_addr = (New REGISTER_QSPI_raf_curr_addr)(aBaseAddr, 32)
        Set mspi_spcr0_lsb = (New REGISTER_QSPI_mspi_spcr0_lsb)(aBaseAddr, 32)
        Set mspi_spcr0_msb = (New REGISTER_QSPI_mspi_spcr0_msb)(aBaseAddr, 32)
        Set mspi_spcr1_lsb = (New REGISTER_QSPI_mspi_spcr1_lsb)(aBaseAddr, 32)
        Set mspi_spcr1_msb = (New REGISTER_QSPI_mspi_spcr1_msb)(aBaseAddr, 32)
        Set mspi_newqp = (New REGISTER_QSPI_mspi_newqp)(aBaseAddr, 32)
        Set mspi_endqp = (New REGISTER_QSPI_mspi_endqp)(aBaseAddr, 32)
        Set mspi_spcr2 = (New REGISTER_QSPI_mspi_spcr2)(aBaseAddr, 32)
        Set mspi_mspi_status = (New REGISTER_QSPI_mspi_mspi_status)(aBaseAddr, 32)
        Set mspi_cptqp = (New REGISTER_QSPI_mspi_cptqp)(aBaseAddr, 32)
        Set mspi_txram00 = (New REGISTER_QSPI_mspi_txram00)(aBaseAddr, 32)
        Set mspi_txram01 = (New REGISTER_QSPI_mspi_txram01)(aBaseAddr, 32)
        Set mspi_txram02 = (New REGISTER_QSPI_mspi_txram02)(aBaseAddr, 32)
        Set mspi_txram03 = (New REGISTER_QSPI_mspi_txram03)(aBaseAddr, 32)
        Set mspi_txram04 = (New REGISTER_QSPI_mspi_txram04)(aBaseAddr, 32)
        Set mspi_txram05 = (New REGISTER_QSPI_mspi_txram05)(aBaseAddr, 32)
        Set mspi_txram06 = (New REGISTER_QSPI_mspi_txram06)(aBaseAddr, 32)
        Set mspi_txram07 = (New REGISTER_QSPI_mspi_txram07)(aBaseAddr, 32)
        Set mspi_txram08 = (New REGISTER_QSPI_mspi_txram08)(aBaseAddr, 32)
        Set mspi_txram09 = (New REGISTER_QSPI_mspi_txram09)(aBaseAddr, 32)
        Set mspi_txram10 = (New REGISTER_QSPI_mspi_txram10)(aBaseAddr, 32)
        Set mspi_txram11 = (New REGISTER_QSPI_mspi_txram11)(aBaseAddr, 32)
        Set mspi_txram12 = (New REGISTER_QSPI_mspi_txram12)(aBaseAddr, 32)
        Set mspi_txram13 = (New REGISTER_QSPI_mspi_txram13)(aBaseAddr, 32)
        Set mspi_txram14 = (New REGISTER_QSPI_mspi_txram14)(aBaseAddr, 32)
        Set mspi_txram15 = (New REGISTER_QSPI_mspi_txram15)(aBaseAddr, 32)
        Set mspi_txram16 = (New REGISTER_QSPI_mspi_txram16)(aBaseAddr, 32)
        Set mspi_txram17 = (New REGISTER_QSPI_mspi_txram17)(aBaseAddr, 32)
        Set mspi_txram18 = (New REGISTER_QSPI_mspi_txram18)(aBaseAddr, 32)
        Set mspi_txram19 = (New REGISTER_QSPI_mspi_txram19)(aBaseAddr, 32)
        Set mspi_txram20 = (New REGISTER_QSPI_mspi_txram20)(aBaseAddr, 32)
        Set mspi_txram21 = (New REGISTER_QSPI_mspi_txram21)(aBaseAddr, 32)
        Set mspi_txram22 = (New REGISTER_QSPI_mspi_txram22)(aBaseAddr, 32)
        Set mspi_txram23 = (New REGISTER_QSPI_mspi_txram23)(aBaseAddr, 32)
        Set mspi_txram24 = (New REGISTER_QSPI_mspi_txram24)(aBaseAddr, 32)
        Set mspi_txram25 = (New REGISTER_QSPI_mspi_txram25)(aBaseAddr, 32)
        Set mspi_txram26 = (New REGISTER_QSPI_mspi_txram26)(aBaseAddr, 32)
        Set mspi_txram27 = (New REGISTER_QSPI_mspi_txram27)(aBaseAddr, 32)
        Set mspi_txram28 = (New REGISTER_QSPI_mspi_txram28)(aBaseAddr, 32)
        Set mspi_txram29 = (New REGISTER_QSPI_mspi_txram29)(aBaseAddr, 32)
        Set mspi_txram30 = (New REGISTER_QSPI_mspi_txram30)(aBaseAddr, 32)
        Set mspi_txram31 = (New REGISTER_QSPI_mspi_txram31)(aBaseAddr, 32)
        Set mspi_rxram00 = (New REGISTER_QSPI_mspi_rxram00)(aBaseAddr, 32)
        Set mspi_rxram01 = (New REGISTER_QSPI_mspi_rxram01)(aBaseAddr, 32)
        Set mspi_rxram02 = (New REGISTER_QSPI_mspi_rxram02)(aBaseAddr, 32)
        Set mspi_rxram03 = (New REGISTER_QSPI_mspi_rxram03)(aBaseAddr, 32)
        Set mspi_rxram04 = (New REGISTER_QSPI_mspi_rxram04)(aBaseAddr, 32)
        Set mspi_rxram05 = (New REGISTER_QSPI_mspi_rxram05)(aBaseAddr, 32)
        Set mspi_rxram06 = (New REGISTER_QSPI_mspi_rxram06)(aBaseAddr, 32)
        Set mspi_rxram07 = (New REGISTER_QSPI_mspi_rxram07)(aBaseAddr, 32)
        Set mspi_rxram08 = (New REGISTER_QSPI_mspi_rxram08)(aBaseAddr, 32)
        Set mspi_rxram09 = (New REGISTER_QSPI_mspi_rxram09)(aBaseAddr, 32)
        Set mspi_rxram10 = (New REGISTER_QSPI_mspi_rxram10)(aBaseAddr, 32)
        Set mspi_rxram11 = (New REGISTER_QSPI_mspi_rxram11)(aBaseAddr, 32)
        Set mspi_rxram12 = (New REGISTER_QSPI_mspi_rxram12)(aBaseAddr, 32)
        Set mspi_rxram13 = (New REGISTER_QSPI_mspi_rxram13)(aBaseAddr, 32)
        Set mspi_rxram14 = (New REGISTER_QSPI_mspi_rxram14)(aBaseAddr, 32)
        Set mspi_rxram15 = (New REGISTER_QSPI_mspi_rxram15)(aBaseAddr, 32)
        Set mspi_rxram16 = (New REGISTER_QSPI_mspi_rxram16)(aBaseAddr, 32)
        Set mspi_rxram17 = (New REGISTER_QSPI_mspi_rxram17)(aBaseAddr, 32)
        Set mspi_rxram18 = (New REGISTER_QSPI_mspi_rxram18)(aBaseAddr, 32)
        Set mspi_rxram19 = (New REGISTER_QSPI_mspi_rxram19)(aBaseAddr, 32)
        Set mspi_rxram20 = (New REGISTER_QSPI_mspi_rxram20)(aBaseAddr, 32)
        Set mspi_rxram21 = (New REGISTER_QSPI_mspi_rxram21)(aBaseAddr, 32)
        Set mspi_rxram22 = (New REGISTER_QSPI_mspi_rxram22)(aBaseAddr, 32)
        Set mspi_rxram23 = (New REGISTER_QSPI_mspi_rxram23)(aBaseAddr, 32)
        Set mspi_rxram24 = (New REGISTER_QSPI_mspi_rxram24)(aBaseAddr, 32)
        Set mspi_rxram25 = (New REGISTER_QSPI_mspi_rxram25)(aBaseAddr, 32)
        Set mspi_rxram26 = (New REGISTER_QSPI_mspi_rxram26)(aBaseAddr, 32)
        Set mspi_rxram27 = (New REGISTER_QSPI_mspi_rxram27)(aBaseAddr, 32)
        Set mspi_rxram28 = (New REGISTER_QSPI_mspi_rxram28)(aBaseAddr, 32)
        Set mspi_rxram29 = (New REGISTER_QSPI_mspi_rxram29)(aBaseAddr, 32)
        Set mspi_rxram30 = (New REGISTER_QSPI_mspi_rxram30)(aBaseAddr, 32)
        Set mspi_rxram31 = (New REGISTER_QSPI_mspi_rxram31)(aBaseAddr, 32)
        Set mspi_cdram00 = (New REGISTER_QSPI_mspi_cdram00)(aBaseAddr, 32)
        Set mspi_cdram01 = (New REGISTER_QSPI_mspi_cdram01)(aBaseAddr, 32)
        Set mspi_cdram02 = (New REGISTER_QSPI_mspi_cdram02)(aBaseAddr, 32)
        Set mspi_cdram03 = (New REGISTER_QSPI_mspi_cdram03)(aBaseAddr, 32)
        Set mspi_cdram04 = (New REGISTER_QSPI_mspi_cdram04)(aBaseAddr, 32)
        Set mspi_cdram05 = (New REGISTER_QSPI_mspi_cdram05)(aBaseAddr, 32)
        Set mspi_cdram06 = (New REGISTER_QSPI_mspi_cdram06)(aBaseAddr, 32)
        Set mspi_cdram07 = (New REGISTER_QSPI_mspi_cdram07)(aBaseAddr, 32)
        Set mspi_cdram08 = (New REGISTER_QSPI_mspi_cdram08)(aBaseAddr, 32)
        Set mspi_cdram09 = (New REGISTER_QSPI_mspi_cdram09)(aBaseAddr, 32)
        Set mspi_cdram10 = (New REGISTER_QSPI_mspi_cdram10)(aBaseAddr, 32)
        Set mspi_cdram11 = (New REGISTER_QSPI_mspi_cdram11)(aBaseAddr, 32)
        Set mspi_cdram12 = (New REGISTER_QSPI_mspi_cdram12)(aBaseAddr, 32)
        Set mspi_cdram13 = (New REGISTER_QSPI_mspi_cdram13)(aBaseAddr, 32)
        Set mspi_cdram14 = (New REGISTER_QSPI_mspi_cdram14)(aBaseAddr, 32)
        Set mspi_cdram15 = (New REGISTER_QSPI_mspi_cdram15)(aBaseAddr, 32)
        Set mspi_write_lock = (New REGISTER_QSPI_mspi_write_lock)(aBaseAddr, 32)
        Set mspi_disable_flush_gen = (New REGISTER_QSPI_mspi_disable_flush_gen)(aBaseAddr, 32)
        Set raf_interrupt_lr_fullness_reached = (New REGISTER_QSPI_raf_interrupt_lr_fullness_reached)(aBaseAddr, 32)
        Set raf_interrupt_lr_truncated = (New REGISTER_QSPI_raf_interrupt_lr_truncated)(aBaseAddr, 32)
        Set raf_interrupt_lr_impatient = (New REGISTER_QSPI_raf_interrupt_lr_impatient)(aBaseAddr, 32)
        Set raf_interrupt_lr_session_done = (New REGISTER_QSPI_raf_interrupt_lr_session_done)(aBaseAddr, 32)
        Set raf_interrupt_lr_overread = (New REGISTER_QSPI_raf_interrupt_lr_overread)(aBaseAddr, 32)
        Set mspi_interrupt_mspi_done = (New REGISTER_QSPI_mspi_interrupt_mspi_done)(aBaseAddr, 32)
        Set mspi_interrupt_mspi_halt_set_transaction_done = (New REGISTER_QSPI_mspi_interrupt_mspi_halt_set_transaction_done)(aBaseAddr, 32)
        Set raf_interrupt_ecc = (New REGISTER_QSPI_raf_interrupt_ecc)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set QSPI = CreateObject("System.Collections.ArrayList")
QSPI.Add ((New QSPI_INSTANCE)(&H40144000))


