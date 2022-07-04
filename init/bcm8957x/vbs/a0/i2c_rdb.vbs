

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


'' @REGISTER : I2C_bsccs
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SDA                                        [7:7]            get_SDA
''                                                             set_SDA
''                                                             read_SDA
''                                                             write_SDA
''---------------------------------------------------------------------------------
'' SCL                                        [6:6]            get_SCL
''                                                             set_SCL
''                                                             read_SCL
''                                                             write_SCL
''---------------------------------------------------------------------------------
'' BUSY                                       [5:5]            get_BUSY
''                                                             set_BUSY
''                                                             read_BUSY
''                                                             write_BUSY
''---------------------------------------------------------------------------------
'' RDY                                        [4:4]            get_RDY
''                                                             set_RDY
''                                                             read_RDY
''                                                             write_RDY
''---------------------------------------------------------------------------------
'' ACK                                        [3:3]            get_ACK
''                                                             set_ACK
''                                                             read_ACK
''                                                             write_ACK
''---------------------------------------------------------------------------------
'' CMD                                        [2:1]            get_CMD
''                                                             set_CMD
''                                                             read_CMD
''                                                             write_CMD
''---------------------------------------------------------------------------------
'' EN                                         [0:0]            get_EN
''                                                             set_EN
''                                                             read_EN
''                                                             write_EN
''---------------------------------------------------------------------------------
Class REGISTER_I2C_bsccs
    Private write_SDA_value
    Private read_SDA_value
    Private flag_SDA
    Private write_SCL_value
    Private read_SCL_value
    Private flag_SCL
    Private write_BUSY_value
    Private read_BUSY_value
    Private flag_BUSY
    Private write_RDY_value
    Private read_RDY_value
    Private flag_RDY
    Private write_ACK_value
    Private read_ACK_value
    Private flag_ACK
    Private write_CMD_value
    Private read_CMD_value
    Private flag_CMD
    Private write_EN_value
    Private read_EN_value
    Private flag_EN

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

    Property Get get_SDA
        get_SDA = read_SDA_value
    End Property

    Property Let set_SDA(aData)
        write_SDA_value = aData
        flag_SDA        = &H1
    End Property

    Property Get read_SDA
        read
        read_SDA = read_SDA_value
    End Property

    Property Let write_SDA(aData)
        set_SDA = aData
        write
    End Property

    Property Get get_SCL
        get_SCL = read_SCL_value
    End Property

    Property Let set_SCL(aData)
        write_SCL_value = aData
        flag_SCL        = &H1
    End Property

    Property Get read_SCL
        read
        read_SCL = read_SCL_value
    End Property

    Property Let write_SCL(aData)
        set_SCL = aData
        write
    End Property

    Property Get get_BUSY
        get_BUSY = read_BUSY_value
    End Property

    Property Let set_BUSY(aData)
        write_BUSY_value = aData
        flag_BUSY        = &H1
    End Property

    Property Get read_BUSY
        read
        read_BUSY = read_BUSY_value
    End Property

    Property Let write_BUSY(aData)
        set_BUSY = aData
        write
    End Property

    Property Get get_RDY
        get_RDY = read_RDY_value
    End Property

    Property Let set_RDY(aData)
        write_RDY_value = aData
        flag_RDY        = &H1
    End Property

    Property Get read_RDY
        read
        read_RDY = read_RDY_value
    End Property

    Property Let write_RDY(aData)
        set_RDY = aData
        write
    End Property

    Property Get get_ACK
        get_ACK = read_ACK_value
    End Property

    Property Let set_ACK(aData)
        write_ACK_value = aData
        flag_ACK        = &H1
    End Property

    Property Get read_ACK
        read
        read_ACK = read_ACK_value
    End Property

    Property Let write_ACK(aData)
        set_ACK = aData
        write
    End Property

    Property Get get_CMD
        get_CMD = read_CMD_value
    End Property

    Property Let set_CMD(aData)
        write_CMD_value = aData
        flag_CMD        = &H1
    End Property

    Property Get read_CMD
        read
        read_CMD = read_CMD_value
    End Property

    Property Let write_CMD(aData)
        set_CMD = aData
        write
    End Property

    Property Get get_EN
        get_EN = read_EN_value
    End Property

    Property Let set_EN(aData)
        write_EN_value = aData
        flag_EN        = &H1
    End Property

    Property Get read_EN
        read
        read_EN = read_EN_value
    End Property

    Property Let write_EN(aData)
        set_EN = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_SDA_value = rightShift(data_low, 7) and &H1
        read_SCL_value = rightShift(data_low, 6) and &H1
        read_BUSY_value = rightShift(data_low, 5) and &H1
        read_RDY_value = rightShift(data_low, 4) and &H1
        read_ACK_value = rightShift(data_low, 3) and &H1
        read_CMD_value = rightShift(data_low, 1) and &H3
        EN_mask = &H1
        if data_low > LONG_MAX then
            if EN_mask = mask then
                read_EN_value = data_low
            else
                read_EN_value = (data_low - H8000_0000) and EN_mask
            end If
        else
            read_EN_value = data_low and EN_mask
        end If

    End Sub

    Sub write
        If flag_SDA = &H0 or flag_SCL = &H0 or flag_BUSY = &H0 or flag_RDY = &H0 or flag_ACK = &H0 or flag_CMD = &H0 or flag_EN = &H0 Then read
        If flag_SDA = &H0 Then write_SDA_value = get_SDA
        If flag_SCL = &H0 Then write_SCL_value = get_SCL
        If flag_BUSY = &H0 Then write_BUSY_value = get_BUSY
        If flag_RDY = &H0 Then write_RDY_value = get_RDY
        If flag_ACK = &H0 Then write_ACK_value = get_ACK
        If flag_CMD = &H0 Then write_CMD_value = get_CMD
        If flag_EN = &H0 Then write_EN_value = get_EN

        regValue = leftShift((write_SDA_value and &H1), 7) + leftShift((write_SCL_value and &H1), 6) + leftShift((write_BUSY_value and &H1), 5) + leftShift((write_RDY_value and &H1), 4) + leftShift((write_ACK_value and &H1), 3) + leftShift((write_CMD_value and &H3), 1) + leftShift((write_EN_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_SDA_value = rightShift(data_low, 7) and &H1
        read_SCL_value = rightShift(data_low, 6) and &H1
        read_BUSY_value = rightShift(data_low, 5) and &H1
        read_RDY_value = rightShift(data_low, 4) and &H1
        read_ACK_value = rightShift(data_low, 3) and &H1
        read_CMD_value = rightShift(data_low, 1) and &H3
        EN_mask = &H1
        if data_low > LONG_MAX then
            if EN_mask = mask then
                read_EN_value = data_low
            else
                read_EN_value = (data_low - H8000_0000) and EN_mask
            end If
        else
            read_EN_value = data_low and EN_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SDA_value = &H0
        flag_SDA        = &H0
        write_SCL_value = &H0
        flag_SCL        = &H0
        write_BUSY_value = &H0
        flag_BUSY        = &H0
        write_RDY_value = &H0
        flag_RDY        = &H0
        write_ACK_value = &H0
        flag_ACK        = &H0
        write_CMD_value = &H0
        flag_CMD        = &H0
        write_EN_value = &H0
        flag_EN        = &H0
    End Sub
End Class


'' @REGISTER : I2C_bsctim
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DEGLITCH_EN                                [7:7]            get_DEGLITCH_EN
''                                                             set_DEGLITCH_EN
''                                                             read_DEGLITCH_EN
''                                                             write_DEGLITCH_EN
''---------------------------------------------------------------------------------
'' P                                          [5:3]            get_P
''                                                             set_P
''                                                             read_P
''                                                             write_P
''---------------------------------------------------------------------------------
'' DIV                                        [1:0]            get_DIV
''                                                             set_DIV
''                                                             read_DIV
''                                                             write_DIV
''---------------------------------------------------------------------------------
Class REGISTER_I2C_bsctim
    Private write_DEGLITCH_EN_value
    Private read_DEGLITCH_EN_value
    Private flag_DEGLITCH_EN
    Private write_P_value
    Private read_P_value
    Private flag_P
    Private write_DIV_value
    Private read_DIV_value
    Private flag_DIV

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

    Property Get get_DEGLITCH_EN
        get_DEGLITCH_EN = read_DEGLITCH_EN_value
    End Property

    Property Let set_DEGLITCH_EN(aData)
        write_DEGLITCH_EN_value = aData
        flag_DEGLITCH_EN        = &H1
    End Property

    Property Get read_DEGLITCH_EN
        read
        read_DEGLITCH_EN = read_DEGLITCH_EN_value
    End Property

    Property Let write_DEGLITCH_EN(aData)
        set_DEGLITCH_EN = aData
        write
    End Property

    Property Get get_P
        get_P = read_P_value
    End Property

    Property Let set_P(aData)
        write_P_value = aData
        flag_P        = &H1
    End Property

    Property Get read_P
        read
        read_P = read_P_value
    End Property

    Property Let write_P(aData)
        set_P = aData
        write
    End Property

    Property Get get_DIV
        get_DIV = read_DIV_value
    End Property

    Property Let set_DIV(aData)
        write_DIV_value = aData
        flag_DIV        = &H1
    End Property

    Property Get read_DIV
        read
        read_DIV = read_DIV_value
    End Property

    Property Let write_DIV(aData)
        set_DIV = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_DEGLITCH_EN_value = rightShift(data_low, 7) and &H1
        read_P_value = rightShift(data_low, 3) and &H7
        DIV_mask = &H3
        if data_low > LONG_MAX then
            if DIV_mask = mask then
                read_DIV_value = data_low
            else
                read_DIV_value = (data_low - H8000_0000) and DIV_mask
            end If
        else
            read_DIV_value = data_low and DIV_mask
        end If

    End Sub

    Sub write
        If flag_DEGLITCH_EN = &H0 or flag_P = &H0 or flag_DIV = &H0 Then read
        If flag_DEGLITCH_EN = &H0 Then write_DEGLITCH_EN_value = get_DEGLITCH_EN
        If flag_P = &H0 Then write_P_value = get_P
        If flag_DIV = &H0 Then write_DIV_value = get_DIV

        regValue = leftShift((write_DEGLITCH_EN_value and &H1), 7) + leftShift((write_P_value and &H7), 3) + leftShift((write_DIV_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_DEGLITCH_EN_value = rightShift(data_low, 7) and &H1
        read_P_value = rightShift(data_low, 3) and &H7
        DIV_mask = &H3
        if data_low > LONG_MAX then
            if DIV_mask = mask then
                read_DIV_value = data_low
            else
                read_DIV_value = (data_low - H8000_0000) and DIV_mask
            end If
        else
            read_DIV_value = data_low and DIV_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DEGLITCH_EN_value = &H0
        flag_DEGLITCH_EN        = &H0
        write_P_value = &H0
        flag_P        = &H0
        write_DIV_value = &H0
        flag_DIV        = &H0
    End Sub
End Class


'' @REGISTER : I2C_bscdat
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DAT                                        [7:0]            get_DAT
''                                                             set_DAT
''                                                             read_DAT
''                                                             write_DAT
''---------------------------------------------------------------------------------
Class REGISTER_I2C_bscdat
    Private write_DAT_value
    Private read_DAT_value
    Private flag_DAT

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

    Property Get get_DAT
        get_DAT = read_DAT_value
    End Property

    Property Let set_DAT(aData)
        write_DAT_value = aData
        flag_DAT        = &H1
    End Property

    Property Get read_DAT
        read
        read_DAT = read_DAT_value
    End Property

    Property Let write_DAT(aData)
        set_DAT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DAT_mask = &Hff
        if data_low > LONG_MAX then
            if DAT_mask = mask then
                read_DAT_value = data_low
            else
                read_DAT_value = (data_low - H8000_0000) and DAT_mask
            end If
        else
            read_DAT_value = data_low and DAT_mask
        end If

    End Sub

    Sub write
        If flag_DAT = &H0 Then read
        If flag_DAT = &H0 Then write_DAT_value = get_DAT

        regValue = leftShift((write_DAT_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        DAT_mask = &Hff
        if data_low > LONG_MAX then
            if DAT_mask = mask then
                read_DAT_value = data_low
            else
                read_DAT_value = (data_low - H8000_0000) and DAT_mask
            end If
        else
            read_DAT_value = data_low and DAT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DAT_value = &H0
        flag_DAT        = &H0
    End Sub
End Class


'' @REGISTER : I2C_bsctout
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TE                                         [7:7]            get_TE
''                                                             set_TE
''                                                             read_TE
''                                                             write_TE
''---------------------------------------------------------------------------------
'' TOUT                                       [6:0]            get_TOUT
''                                                             set_TOUT
''                                                             read_TOUT
''                                                             write_TOUT
''---------------------------------------------------------------------------------
Class REGISTER_I2C_bsctout
    Private write_TE_value
    Private read_TE_value
    Private flag_TE
    Private write_TOUT_value
    Private read_TOUT_value
    Private flag_TOUT

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

    Property Get get_TE
        get_TE = read_TE_value
    End Property

    Property Let set_TE(aData)
        write_TE_value = aData
        flag_TE        = &H1
    End Property

    Property Get read_TE
        read
        read_TE = read_TE_value
    End Property

    Property Let write_TE(aData)
        set_TE = aData
        write
    End Property

    Property Get get_TOUT
        get_TOUT = read_TOUT_value
    End Property

    Property Let set_TOUT(aData)
        write_TOUT_value = aData
        flag_TOUT        = &H1
    End Property

    Property Get read_TOUT
        read
        read_TOUT = read_TOUT_value
    End Property

    Property Let write_TOUT(aData)
        set_TOUT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TE_value = rightShift(data_low, 7) and &H1
        TOUT_mask = &H7f
        if data_low > LONG_MAX then
            if TOUT_mask = mask then
                read_TOUT_value = data_low
            else
                read_TOUT_value = (data_low - H8000_0000) and TOUT_mask
            end If
        else
            read_TOUT_value = data_low and TOUT_mask
        end If

    End Sub

    Sub write
        If flag_TE = &H0 or flag_TOUT = &H0 Then read
        If flag_TE = &H0 Then write_TE_value = get_TE
        If flag_TOUT = &H0 Then write_TOUT_value = get_TOUT

        regValue = leftShift((write_TE_value and &H1), 7) + leftShift((write_TOUT_value and &H7f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TE_value = rightShift(data_low, 7) and &H1
        TOUT_mask = &H7f
        if data_low > LONG_MAX then
            if TOUT_mask = mask then
                read_TOUT_value = data_low
            else
                read_TOUT_value = (data_low - H8000_0000) and TOUT_mask
            end If
        else
            read_TOUT_value = data_low and TOUT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TE_value = &H0
        flag_TE        = &H0
        write_TOUT_value = &H0
        flag_TOUT        = &H0
    End Sub
End Class


'' @REGISTER : I2C_bscfcr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Flush                                      [7:7]            get_Flush
''                                                             set_Flush
''                                                             read_Flush
''                                                             write_Flush
''---------------------------------------------------------------------------------
'' FIFOEN                                     [6:6]            get_FIFOEN
''                                                             set_FIFOEN
''                                                             read_FIFOEN
''                                                             write_FIFOEN
''---------------------------------------------------------------------------------
'' FIFOCNT                                    [2:0]            get_FIFOCNT
''                                                             set_FIFOCNT
''                                                             read_FIFOCNT
''                                                             write_FIFOCNT
''---------------------------------------------------------------------------------
Class REGISTER_I2C_bscfcr
    Private write_Flush_value
    Private read_Flush_value
    Private flag_Flush
    Private write_FIFOEN_value
    Private read_FIFOEN_value
    Private flag_FIFOEN
    Private write_FIFOCNT_value
    Private read_FIFOCNT_value
    Private flag_FIFOCNT

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

    Property Get get_Flush
        get_Flush = read_Flush_value
    End Property

    Property Let set_Flush(aData)
        write_Flush_value = aData
        flag_Flush        = &H1
    End Property

    Property Get read_Flush
        read
        read_Flush = read_Flush_value
    End Property

    Property Let write_Flush(aData)
        set_Flush = aData
        write
    End Property

    Property Get get_FIFOEN
        get_FIFOEN = read_FIFOEN_value
    End Property

    Property Let set_FIFOEN(aData)
        write_FIFOEN_value = aData
        flag_FIFOEN        = &H1
    End Property

    Property Get read_FIFOEN
        read
        read_FIFOEN = read_FIFOEN_value
    End Property

    Property Let write_FIFOEN(aData)
        set_FIFOEN = aData
        write
    End Property

    Property Get get_FIFOCNT
        get_FIFOCNT = read_FIFOCNT_value
    End Property

    Property Let set_FIFOCNT(aData)
        write_FIFOCNT_value = aData
        flag_FIFOCNT        = &H1
    End Property

    Property Get read_FIFOCNT
        read
        read_FIFOCNT = read_FIFOCNT_value
    End Property

    Property Let write_FIFOCNT(aData)
        set_FIFOCNT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Flush_value = rightShift(data_low, 7) and &H1
        read_FIFOEN_value = rightShift(data_low, 6) and &H1
        FIFOCNT_mask = &H7
        if data_low > LONG_MAX then
            if FIFOCNT_mask = mask then
                read_FIFOCNT_value = data_low
            else
                read_FIFOCNT_value = (data_low - H8000_0000) and FIFOCNT_mask
            end If
        else
            read_FIFOCNT_value = data_low and FIFOCNT_mask
        end If

    End Sub

    Sub write
        If flag_Flush = &H0 or flag_FIFOEN = &H0 or flag_FIFOCNT = &H0 Then read
        If flag_Flush = &H0 Then write_Flush_value = get_Flush
        If flag_FIFOEN = &H0 Then write_FIFOEN_value = get_FIFOEN
        If flag_FIFOCNT = &H0 Then write_FIFOCNT_value = get_FIFOCNT

        regValue = leftShift((write_Flush_value and &H1), 7) + leftShift((write_FIFOEN_value and &H1), 6) + leftShift((write_FIFOCNT_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Flush_value = rightShift(data_low, 7) and &H1
        read_FIFOEN_value = rightShift(data_low, 6) and &H1
        FIFOCNT_mask = &H7
        if data_low > LONG_MAX then
            if FIFOCNT_mask = mask then
                read_FIFOCNT_value = data_low
            else
                read_FIFOCNT_value = (data_low - H8000_0000) and FIFOCNT_mask
            end If
        else
            read_FIFOCNT_value = data_low and FIFOCNT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Flush_value = &H0
        flag_Flush        = &H0
        write_FIFOEN_value = &H0
        flag_FIFOEN        = &H0
        write_FIFOCNT_value = &H0
        flag_FIFOCNT        = &H0
    End Sub
End Class


'' @REGISTER : I2C_bscfifordout
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' FIFO_RDOUT                                 [7:0]            get_FIFO_RDOUT
''                                                             set_FIFO_RDOUT
''                                                             read_FIFO_RDOUT
''                                                             write_FIFO_RDOUT
''---------------------------------------------------------------------------------
Class REGISTER_I2C_bscfifordout
    Private write_FIFO_RDOUT_value
    Private read_FIFO_RDOUT_value
    Private flag_FIFO_RDOUT

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

    Property Get get_FIFO_RDOUT
        get_FIFO_RDOUT = read_FIFO_RDOUT_value
    End Property

    Property Let set_FIFO_RDOUT(aData)
        write_FIFO_RDOUT_value = aData
        flag_FIFO_RDOUT        = &H1
    End Property

    Property Get read_FIFO_RDOUT
        read
        read_FIFO_RDOUT = read_FIFO_RDOUT_value
    End Property

    Property Let write_FIFO_RDOUT(aData)
        set_FIFO_RDOUT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        FIFO_RDOUT_mask = &Hff
        if data_low > LONG_MAX then
            if FIFO_RDOUT_mask = mask then
                read_FIFO_RDOUT_value = data_low
            else
                read_FIFO_RDOUT_value = (data_low - H8000_0000) and FIFO_RDOUT_mask
            end If
        else
            read_FIFO_RDOUT_value = data_low and FIFO_RDOUT_mask
        end If

    End Sub

    Sub write
        If flag_FIFO_RDOUT = &H0 Then read
        If flag_FIFO_RDOUT = &H0 Then write_FIFO_RDOUT_value = get_FIFO_RDOUT

        regValue = leftShift((write_FIFO_RDOUT_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        FIFO_RDOUT_mask = &Hff
        if data_low > LONG_MAX then
            if FIFO_RDOUT_mask = mask then
                read_FIFO_RDOUT_value = data_low
            else
                read_FIFO_RDOUT_value = (data_low - H8000_0000) and FIFO_RDOUT_mask
            end If
        else
            read_FIFO_RDOUT_value = data_low and FIFO_RDOUT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_FIFO_RDOUT_value = &H0
        flag_FIFO_RDOUT        = &H0
    End Sub
End Class


'' @REGISTER : I2C_bscier
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CMD_RUN_INT_EN                             [7:7]            get_CMD_RUN_INT_EN
''                                                             set_CMD_RUN_INT_EN
''                                                             read_CMD_RUN_INT_EN
''                                                             write_CMD_RUN_INT_EN
''---------------------------------------------------------------------------------
'' BSC_INT_EN                                 [3:3]            get_BSC_INT_EN
''                                                             set_BSC_INT_EN
''                                                             read_BSC_INT_EN
''                                                             write_BSC_INT_EN
''---------------------------------------------------------------------------------
'' ERRINT_EN                                  [2:2]            get_ERRINT_EN
''                                                             set_ERRINT_EN
''                                                             read_ERRINT_EN
''                                                             write_ERRINT_EN
''---------------------------------------------------------------------------------
'' FIFOINT_EN                                 [1:1]            get_FIFOINT_EN
''                                                             set_FIFOINT_EN
''                                                             read_FIFOINT_EN
''                                                             write_FIFOINT_EN
''---------------------------------------------------------------------------------
'' NOACK_EN                                   [0:0]            get_NOACK_EN
''                                                             set_NOACK_EN
''                                                             read_NOACK_EN
''                                                             write_NOACK_EN
''---------------------------------------------------------------------------------
Class REGISTER_I2C_bscier
    Private write_CMD_RUN_INT_EN_value
    Private read_CMD_RUN_INT_EN_value
    Private flag_CMD_RUN_INT_EN
    Private write_BSC_INT_EN_value
    Private read_BSC_INT_EN_value
    Private flag_BSC_INT_EN
    Private write_ERRINT_EN_value
    Private read_ERRINT_EN_value
    Private flag_ERRINT_EN
    Private write_FIFOINT_EN_value
    Private read_FIFOINT_EN_value
    Private flag_FIFOINT_EN
    Private write_NOACK_EN_value
    Private read_NOACK_EN_value
    Private flag_NOACK_EN

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

    Property Get get_CMD_RUN_INT_EN
        get_CMD_RUN_INT_EN = read_CMD_RUN_INT_EN_value
    End Property

    Property Let set_CMD_RUN_INT_EN(aData)
        write_CMD_RUN_INT_EN_value = aData
        flag_CMD_RUN_INT_EN        = &H1
    End Property

    Property Get read_CMD_RUN_INT_EN
        read
        read_CMD_RUN_INT_EN = read_CMD_RUN_INT_EN_value
    End Property

    Property Let write_CMD_RUN_INT_EN(aData)
        set_CMD_RUN_INT_EN = aData
        write
    End Property

    Property Get get_BSC_INT_EN
        get_BSC_INT_EN = read_BSC_INT_EN_value
    End Property

    Property Let set_BSC_INT_EN(aData)
        write_BSC_INT_EN_value = aData
        flag_BSC_INT_EN        = &H1
    End Property

    Property Get read_BSC_INT_EN
        read
        read_BSC_INT_EN = read_BSC_INT_EN_value
    End Property

    Property Let write_BSC_INT_EN(aData)
        set_BSC_INT_EN = aData
        write
    End Property

    Property Get get_ERRINT_EN
        get_ERRINT_EN = read_ERRINT_EN_value
    End Property

    Property Let set_ERRINT_EN(aData)
        write_ERRINT_EN_value = aData
        flag_ERRINT_EN        = &H1
    End Property

    Property Get read_ERRINT_EN
        read
        read_ERRINT_EN = read_ERRINT_EN_value
    End Property

    Property Let write_ERRINT_EN(aData)
        set_ERRINT_EN = aData
        write
    End Property

    Property Get get_FIFOINT_EN
        get_FIFOINT_EN = read_FIFOINT_EN_value
    End Property

    Property Let set_FIFOINT_EN(aData)
        write_FIFOINT_EN_value = aData
        flag_FIFOINT_EN        = &H1
    End Property

    Property Get read_FIFOINT_EN
        read
        read_FIFOINT_EN = read_FIFOINT_EN_value
    End Property

    Property Let write_FIFOINT_EN(aData)
        set_FIFOINT_EN = aData
        write
    End Property

    Property Get get_NOACK_EN
        get_NOACK_EN = read_NOACK_EN_value
    End Property

    Property Let set_NOACK_EN(aData)
        write_NOACK_EN_value = aData
        flag_NOACK_EN        = &H1
    End Property

    Property Get read_NOACK_EN
        read
        read_NOACK_EN = read_NOACK_EN_value
    End Property

    Property Let write_NOACK_EN(aData)
        set_NOACK_EN = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CMD_RUN_INT_EN_value = rightShift(data_low, 7) and &H1
        read_BSC_INT_EN_value = rightShift(data_low, 3) and &H1
        read_ERRINT_EN_value = rightShift(data_low, 2) and &H1
        read_FIFOINT_EN_value = rightShift(data_low, 1) and &H1
        NOACK_EN_mask = &H1
        if data_low > LONG_MAX then
            if NOACK_EN_mask = mask then
                read_NOACK_EN_value = data_low
            else
                read_NOACK_EN_value = (data_low - H8000_0000) and NOACK_EN_mask
            end If
        else
            read_NOACK_EN_value = data_low and NOACK_EN_mask
        end If

    End Sub

    Sub write
        If flag_CMD_RUN_INT_EN = &H0 or flag_BSC_INT_EN = &H0 or flag_ERRINT_EN = &H0 or flag_FIFOINT_EN = &H0 or flag_NOACK_EN = &H0 Then read
        If flag_CMD_RUN_INT_EN = &H0 Then write_CMD_RUN_INT_EN_value = get_CMD_RUN_INT_EN
        If flag_BSC_INT_EN = &H0 Then write_BSC_INT_EN_value = get_BSC_INT_EN
        If flag_ERRINT_EN = &H0 Then write_ERRINT_EN_value = get_ERRINT_EN
        If flag_FIFOINT_EN = &H0 Then write_FIFOINT_EN_value = get_FIFOINT_EN
        If flag_NOACK_EN = &H0 Then write_NOACK_EN_value = get_NOACK_EN

        regValue = leftShift((write_CMD_RUN_INT_EN_value and &H1), 7) + leftShift((write_BSC_INT_EN_value and &H1), 3) + leftShift((write_ERRINT_EN_value and &H1), 2) + leftShift((write_FIFOINT_EN_value and &H1), 1) + leftShift((write_NOACK_EN_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CMD_RUN_INT_EN_value = rightShift(data_low, 7) and &H1
        read_BSC_INT_EN_value = rightShift(data_low, 3) and &H1
        read_ERRINT_EN_value = rightShift(data_low, 2) and &H1
        read_FIFOINT_EN_value = rightShift(data_low, 1) and &H1
        NOACK_EN_mask = &H1
        if data_low > LONG_MAX then
            if NOACK_EN_mask = mask then
                read_NOACK_EN_value = data_low
            else
                read_NOACK_EN_value = (data_low - H8000_0000) and NOACK_EN_mask
            end If
        else
            read_NOACK_EN_value = data_low and NOACK_EN_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CMD_RUN_INT_EN_value = &H0
        flag_CMD_RUN_INT_EN        = &H0
        write_BSC_INT_EN_value = &H0
        flag_BSC_INT_EN        = &H0
        write_ERRINT_EN_value = &H0
        flag_ERRINT_EN        = &H0
        write_FIFOINT_EN_value = &H0
        flag_FIFOINT_EN        = &H0
        write_NOACK_EN_value = &H0
        flag_NOACK_EN        = &H0
    End Sub
End Class


'' @REGISTER : I2C_bscisr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' COMMAND_RUN                                [7:7]            get_COMMAND_RUN
''                                                             set_COMMAND_RUN
''                                                             read_COMMAND_RUN
''                                                             write_COMMAND_RUN
''---------------------------------------------------------------------------------
'' BSC_SES_DONE                               [3:3]            get_BSC_SES_DONE
''                                                             set_BSC_SES_DONE
''                                                             read_BSC_SES_DONE
''                                                             write_BSC_SES_DONE
''---------------------------------------------------------------------------------
'' BSCERR                                     [2:2]            get_BSCERR
''                                                             set_BSCERR
''                                                             read_BSCERR
''                                                             write_BSCERR
''---------------------------------------------------------------------------------
'' TXFIFOEMPTY                                [1:1]            get_TXFIFOEMPTY
''                                                             set_TXFIFOEMPTY
''                                                             read_TXFIFOEMPTY
''                                                             write_TXFIFOEMPTY
''---------------------------------------------------------------------------------
'' NOACK                                      [0:0]            get_NOACK
''                                                             set_NOACK
''                                                             read_NOACK
''                                                             write_NOACK
''---------------------------------------------------------------------------------
Class REGISTER_I2C_bscisr
    Private write_COMMAND_RUN_value
    Private read_COMMAND_RUN_value
    Private flag_COMMAND_RUN
    Private write_BSC_SES_DONE_value
    Private read_BSC_SES_DONE_value
    Private flag_BSC_SES_DONE
    Private write_BSCERR_value
    Private read_BSCERR_value
    Private flag_BSCERR
    Private write_TXFIFOEMPTY_value
    Private read_TXFIFOEMPTY_value
    Private flag_TXFIFOEMPTY
    Private write_NOACK_value
    Private read_NOACK_value
    Private flag_NOACK

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

    Property Get get_COMMAND_RUN
        get_COMMAND_RUN = read_COMMAND_RUN_value
    End Property

    Property Let set_COMMAND_RUN(aData)
        write_COMMAND_RUN_value = aData
        flag_COMMAND_RUN        = &H1
    End Property

    Property Get read_COMMAND_RUN
        read
        read_COMMAND_RUN = read_COMMAND_RUN_value
    End Property

    Property Let write_COMMAND_RUN(aData)
        set_COMMAND_RUN = aData
        write
    End Property

    Property Get get_BSC_SES_DONE
        get_BSC_SES_DONE = read_BSC_SES_DONE_value
    End Property

    Property Let set_BSC_SES_DONE(aData)
        write_BSC_SES_DONE_value = aData
        flag_BSC_SES_DONE        = &H1
    End Property

    Property Get read_BSC_SES_DONE
        read
        read_BSC_SES_DONE = read_BSC_SES_DONE_value
    End Property

    Property Let write_BSC_SES_DONE(aData)
        set_BSC_SES_DONE = aData
        write
    End Property

    Property Get get_BSCERR
        get_BSCERR = read_BSCERR_value
    End Property

    Property Let set_BSCERR(aData)
        write_BSCERR_value = aData
        flag_BSCERR        = &H1
    End Property

    Property Get read_BSCERR
        read
        read_BSCERR = read_BSCERR_value
    End Property

    Property Let write_BSCERR(aData)
        set_BSCERR = aData
        write
    End Property

    Property Get get_TXFIFOEMPTY
        get_TXFIFOEMPTY = read_TXFIFOEMPTY_value
    End Property

    Property Let set_TXFIFOEMPTY(aData)
        write_TXFIFOEMPTY_value = aData
        flag_TXFIFOEMPTY        = &H1
    End Property

    Property Get read_TXFIFOEMPTY
        read
        read_TXFIFOEMPTY = read_TXFIFOEMPTY_value
    End Property

    Property Let write_TXFIFOEMPTY(aData)
        set_TXFIFOEMPTY = aData
        write
    End Property

    Property Get get_NOACK
        get_NOACK = read_NOACK_value
    End Property

    Property Let set_NOACK(aData)
        write_NOACK_value = aData
        flag_NOACK        = &H1
    End Property

    Property Get read_NOACK
        read
        read_NOACK = read_NOACK_value
    End Property

    Property Let write_NOACK(aData)
        set_NOACK = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_COMMAND_RUN_value = rightShift(data_low, 7) and &H1
        read_BSC_SES_DONE_value = rightShift(data_low, 3) and &H1
        read_BSCERR_value = rightShift(data_low, 2) and &H1
        read_TXFIFOEMPTY_value = rightShift(data_low, 1) and &H1
        NOACK_mask = &H1
        if data_low > LONG_MAX then
            if NOACK_mask = mask then
                read_NOACK_value = data_low
            else
                read_NOACK_value = (data_low - H8000_0000) and NOACK_mask
            end If
        else
            read_NOACK_value = data_low and NOACK_mask
        end If

    End Sub

    Sub write
        If flag_COMMAND_RUN = &H0 or flag_BSC_SES_DONE = &H0 or flag_BSCERR = &H0 or flag_TXFIFOEMPTY = &H0 or flag_NOACK = &H0 Then read
        If flag_COMMAND_RUN = &H0 Then write_COMMAND_RUN_value = get_COMMAND_RUN
        If flag_BSC_SES_DONE = &H0 Then write_BSC_SES_DONE_value = get_BSC_SES_DONE
        If flag_BSCERR = &H0 Then write_BSCERR_value = get_BSCERR
        If flag_TXFIFOEMPTY = &H0 Then write_TXFIFOEMPTY_value = get_TXFIFOEMPTY
        If flag_NOACK = &H0 Then write_NOACK_value = get_NOACK

        regValue = leftShift((write_COMMAND_RUN_value and &H1), 7) + leftShift((write_BSC_SES_DONE_value and &H1), 3) + leftShift((write_BSCERR_value and &H1), 2) + leftShift((write_TXFIFOEMPTY_value and &H1), 1) + leftShift((write_NOACK_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_COMMAND_RUN_value = rightShift(data_low, 7) and &H1
        read_BSC_SES_DONE_value = rightShift(data_low, 3) and &H1
        read_BSCERR_value = rightShift(data_low, 2) and &H1
        read_TXFIFOEMPTY_value = rightShift(data_low, 1) and &H1
        NOACK_mask = &H1
        if data_low > LONG_MAX then
            if NOACK_mask = mask then
                read_NOACK_value = data_low
            else
                read_NOACK_value = (data_low - H8000_0000) and NOACK_mask
            end If
        else
            read_NOACK_value = data_low and NOACK_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_COMMAND_RUN_value = &H0
        flag_COMMAND_RUN        = &H0
        write_BSC_SES_DONE_value = &H0
        flag_BSC_SES_DONE        = &H0
        write_BSCERR_value = &H0
        flag_BSCERR        = &H0
        write_TXFIFOEMPTY_value = &H0
        flag_TXFIFOEMPTY        = &H0
        write_NOACK_value = &H0
        flag_NOACK        = &H0
    End Sub
End Class


'' @REGISTER : I2C_bscclken
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' AUTO_SENSE                                 [7:7]            get_AUTO_SENSE
''                                                             set_AUTO_SENSE
''                                                             read_AUTO_SENSE
''                                                             write_AUTO_SENSE
''---------------------------------------------------------------------------------
'' MPHASE                                     [6:4]            get_MPHASE
''                                                             set_MPHASE
''                                                             read_MPHASE
''                                                             write_MPHASE
''---------------------------------------------------------------------------------
'' NPHASE                                     [3:1]            get_NPHASE
''                                                             set_NPHASE
''                                                             read_NPHASE
''                                                             write_NPHASE
''---------------------------------------------------------------------------------
'' CLKEN                                      [0:0]            get_CLKEN
''                                                             set_CLKEN
''                                                             read_CLKEN
''                                                             write_CLKEN
''---------------------------------------------------------------------------------
Class REGISTER_I2C_bscclken
    Private write_AUTO_SENSE_value
    Private read_AUTO_SENSE_value
    Private flag_AUTO_SENSE
    Private write_MPHASE_value
    Private read_MPHASE_value
    Private flag_MPHASE
    Private write_NPHASE_value
    Private read_NPHASE_value
    Private flag_NPHASE
    Private write_CLKEN_value
    Private read_CLKEN_value
    Private flag_CLKEN

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

    Property Get get_AUTO_SENSE
        get_AUTO_SENSE = read_AUTO_SENSE_value
    End Property

    Property Let set_AUTO_SENSE(aData)
        write_AUTO_SENSE_value = aData
        flag_AUTO_SENSE        = &H1
    End Property

    Property Get read_AUTO_SENSE
        read
        read_AUTO_SENSE = read_AUTO_SENSE_value
    End Property

    Property Let write_AUTO_SENSE(aData)
        set_AUTO_SENSE = aData
        write
    End Property

    Property Get get_MPHASE
        get_MPHASE = read_MPHASE_value
    End Property

    Property Let set_MPHASE(aData)
        write_MPHASE_value = aData
        flag_MPHASE        = &H1
    End Property

    Property Get read_MPHASE
        read
        read_MPHASE = read_MPHASE_value
    End Property

    Property Let write_MPHASE(aData)
        set_MPHASE = aData
        write
    End Property

    Property Get get_NPHASE
        get_NPHASE = read_NPHASE_value
    End Property

    Property Let set_NPHASE(aData)
        write_NPHASE_value = aData
        flag_NPHASE        = &H1
    End Property

    Property Get read_NPHASE
        read
        read_NPHASE = read_NPHASE_value
    End Property

    Property Let write_NPHASE(aData)
        set_NPHASE = aData
        write
    End Property

    Property Get get_CLKEN
        get_CLKEN = read_CLKEN_value
    End Property

    Property Let set_CLKEN(aData)
        write_CLKEN_value = aData
        flag_CLKEN        = &H1
    End Property

    Property Get read_CLKEN
        read
        read_CLKEN = read_CLKEN_value
    End Property

    Property Let write_CLKEN(aData)
        set_CLKEN = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_AUTO_SENSE_value = rightShift(data_low, 7) and &H1
        read_MPHASE_value = rightShift(data_low, 4) and &H7
        read_NPHASE_value = rightShift(data_low, 1) and &H7
        CLKEN_mask = &H1
        if data_low > LONG_MAX then
            if CLKEN_mask = mask then
                read_CLKEN_value = data_low
            else
                read_CLKEN_value = (data_low - H8000_0000) and CLKEN_mask
            end If
        else
            read_CLKEN_value = data_low and CLKEN_mask
        end If

    End Sub

    Sub write
        If flag_AUTO_SENSE = &H0 or flag_MPHASE = &H0 or flag_NPHASE = &H0 or flag_CLKEN = &H0 Then read
        If flag_AUTO_SENSE = &H0 Then write_AUTO_SENSE_value = get_AUTO_SENSE
        If flag_MPHASE = &H0 Then write_MPHASE_value = get_MPHASE
        If flag_NPHASE = &H0 Then write_NPHASE_value = get_NPHASE
        If flag_CLKEN = &H0 Then write_CLKEN_value = get_CLKEN

        regValue = leftShift((write_AUTO_SENSE_value and &H1), 7) + leftShift((write_MPHASE_value and &H7), 4) + leftShift((write_NPHASE_value and &H7), 1) + leftShift((write_CLKEN_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_AUTO_SENSE_value = rightShift(data_low, 7) and &H1
        read_MPHASE_value = rightShift(data_low, 4) and &H7
        read_NPHASE_value = rightShift(data_low, 1) and &H7
        CLKEN_mask = &H1
        if data_low > LONG_MAX then
            if CLKEN_mask = mask then
                read_CLKEN_value = data_low
            else
                read_CLKEN_value = (data_low - H8000_0000) and CLKEN_mask
            end If
        else
            read_CLKEN_value = data_low and CLKEN_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_AUTO_SENSE_value = &H0
        flag_AUTO_SENSE        = &H0
        write_MPHASE_value = &H0
        flag_MPHASE        = &H0
        write_NPHASE_value = &H0
        flag_NPHASE        = &H0
        write_CLKEN_value = &H0
        flag_CLKEN        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class I2C_INSTANCE

    Public bsccs
    Public bsctim
    Public bscdat
    Public bsctout
    Public bscfcr
    Public bscfifordout
    Public bscier
    Public bscisr
    Public bscclken


    Public default function Init(aBaseAddr)
        Set bsccs = (New REGISTER_I2C_bsccs)(aBaseAddr, 32)
        Set bsctim = (New REGISTER_I2C_bsctim)(aBaseAddr, 32)
        Set bscdat = (New REGISTER_I2C_bscdat)(aBaseAddr, 32)
        Set bsctout = (New REGISTER_I2C_bsctout)(aBaseAddr, 32)
        Set bscfcr = (New REGISTER_I2C_bscfcr)(aBaseAddr, 32)
        Set bscfifordout = (New REGISTER_I2C_bscfifordout)(aBaseAddr, 32)
        Set bscier = (New REGISTER_I2C_bscier)(aBaseAddr, 32)
        Set bscisr = (New REGISTER_I2C_bscisr)(aBaseAddr, 32)
        Set bscclken = (New REGISTER_I2C_bscclken)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set I2C = CreateObject("System.Collections.ArrayList")
I2C.Add ((New I2C_INSTANCE)(&H40147000))


