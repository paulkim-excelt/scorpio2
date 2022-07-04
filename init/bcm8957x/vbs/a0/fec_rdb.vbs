

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


'' @REGISTER : FEC_config_0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CLEAR_FEC_ERR_FRM16                        [15:15]          get_CLEAR_FEC_ERR_FRM16
''                                                             set_CLEAR_FEC_ERR_FRM16
''                                                             read_CLEAR_FEC_ERR_FRM16
''                                                             write_CLEAR_FEC_ERR_FRM16
''---------------------------------------------------------------------------------
'' CLEAR_FLB_ERR_FRM16                        [14:14]          get_CLEAR_FLB_ERR_FRM16
''                                                             set_CLEAR_FLB_ERR_FRM16
''                                                             read_CLEAR_FLB_ERR_FRM16
''                                                             write_CLEAR_FLB_ERR_FRM16
''---------------------------------------------------------------------------------
'' CLEAR_FEC_ERR_FRM                          [13:13]          get_CLEAR_FEC_ERR_FRM
''                                                             set_CLEAR_FEC_ERR_FRM
''                                                             read_CLEAR_FEC_ERR_FRM
''                                                             write_CLEAR_FEC_ERR_FRM
''---------------------------------------------------------------------------------
'' CLEAR_FLB_ERR_FRM                          [12:12]          get_CLEAR_FLB_ERR_FRM
''                                                             set_CLEAR_FLB_ERR_FRM
''                                                             read_CLEAR_FLB_ERR_FRM
''                                                             write_CLEAR_FLB_ERR_FRM
''---------------------------------------------------------------------------------
'' FEC_CNTS_ENABLE                            [11:11]          get_FEC_CNTS_ENABLE
''                                                             set_FEC_CNTS_ENABLE
''                                                             read_FEC_CNTS_ENABLE
''                                                             write_FEC_CNTS_ENABLE
''---------------------------------------------------------------------------------
'' CLEAR_FAV_ERR_REG                          [10:10]          get_CLEAR_FAV_ERR_REG
''                                                             set_CLEAR_FAV_ERR_REG
''                                                             read_CLEAR_FAV_ERR_REG
''                                                             write_CLEAR_FAV_ERR_REG
''---------------------------------------------------------------------------------
'' CLEAR_FLB_ERR_REG                          [9:9]            get_CLEAR_FLB_ERR_REG
''                                                             set_CLEAR_FLB_ERR_REG
''                                                             read_CLEAR_FLB_ERR_REG
''                                                             write_CLEAR_FLB_ERR_REG
''---------------------------------------------------------------------------------
'' CLEAR_DEC_COR_ERRSYM_512F                  [8:8]            get_CLEAR_DEC_COR_ERRSYM_512F
''                                                             set_CLEAR_DEC_COR_ERRSYM_512F
''                                                             read_CLEAR_DEC_COR_ERRSYM_512F
''                                                             write_CLEAR_DEC_COR_ERRSYM_512F
''---------------------------------------------------------------------------------
'' FEC_DEC_STAT_CLR                           [7:7]            get_FEC_DEC_STAT_CLR
''                                                             set_FEC_DEC_STAT_CLR
''                                                             read_FEC_DEC_STAT_CLR
''                                                             write_FEC_DEC_STAT_CLR
''---------------------------------------------------------------------------------
'' FEC_DEC_INIT                               [6:6]            get_FEC_DEC_INIT
''                                                             set_FEC_DEC_INIT
''                                                             read_FEC_DEC_INIT
''                                                             write_FEC_DEC_INIT
''---------------------------------------------------------------------------------
'' CLEAR_SYMB_ERR_CNT                         [5:5]            get_CLEAR_SYMB_ERR_CNT
''                                                             set_CLEAR_SYMB_ERR_CNT
''                                                             read_CLEAR_SYMB_ERR_CNT
''                                                             write_CLEAR_SYMB_ERR_CNT
''---------------------------------------------------------------------------------
'' CLEAR_BLK_ERR_CNT                          [4:4]            get_CLEAR_BLK_ERR_CNT
''                                                             set_CLEAR_BLK_ERR_CNT
''                                                             read_CLEAR_BLK_ERR_CNT
''                                                             write_CLEAR_BLK_ERR_CNT
''---------------------------------------------------------------------------------
'' CLEAR_BLK_CNT                              [3:3]            get_CLEAR_BLK_CNT
''                                                             set_CLEAR_BLK_CNT
''                                                             read_CLEAR_BLK_CNT
''                                                             write_CLEAR_BLK_CNT
''---------------------------------------------------------------------------------
'' MASK_ERROR                                 [2:2]            get_MASK_ERROR
''                                                             set_MASK_ERROR
''                                                             read_MASK_ERROR
''                                                             write_MASK_ERROR
''---------------------------------------------------------------------------------
'' SUB_DISABLE                                [1:1]            get_SUB_DISABLE
''                                                             set_SUB_DISABLE
''                                                             read_SUB_DISABLE
''                                                             write_SUB_DISABLE
''---------------------------------------------------------------------------------
'' BYPASS                                     [0:0]            get_BYPASS
''                                                             set_BYPASS
''                                                             read_BYPASS
''                                                             write_BYPASS
''---------------------------------------------------------------------------------
Class REGISTER_FEC_config_0
    Private write_CLEAR_FEC_ERR_FRM16_value
    Private read_CLEAR_FEC_ERR_FRM16_value
    Private flag_CLEAR_FEC_ERR_FRM16
    Private write_CLEAR_FLB_ERR_FRM16_value
    Private read_CLEAR_FLB_ERR_FRM16_value
    Private flag_CLEAR_FLB_ERR_FRM16
    Private write_CLEAR_FEC_ERR_FRM_value
    Private read_CLEAR_FEC_ERR_FRM_value
    Private flag_CLEAR_FEC_ERR_FRM
    Private write_CLEAR_FLB_ERR_FRM_value
    Private read_CLEAR_FLB_ERR_FRM_value
    Private flag_CLEAR_FLB_ERR_FRM
    Private write_FEC_CNTS_ENABLE_value
    Private read_FEC_CNTS_ENABLE_value
    Private flag_FEC_CNTS_ENABLE
    Private write_CLEAR_FAV_ERR_REG_value
    Private read_CLEAR_FAV_ERR_REG_value
    Private flag_CLEAR_FAV_ERR_REG
    Private write_CLEAR_FLB_ERR_REG_value
    Private read_CLEAR_FLB_ERR_REG_value
    Private flag_CLEAR_FLB_ERR_REG
    Private write_CLEAR_DEC_COR_ERRSYM_512F_value
    Private read_CLEAR_DEC_COR_ERRSYM_512F_value
    Private flag_CLEAR_DEC_COR_ERRSYM_512F
    Private write_FEC_DEC_STAT_CLR_value
    Private read_FEC_DEC_STAT_CLR_value
    Private flag_FEC_DEC_STAT_CLR
    Private write_FEC_DEC_INIT_value
    Private read_FEC_DEC_INIT_value
    Private flag_FEC_DEC_INIT
    Private write_CLEAR_SYMB_ERR_CNT_value
    Private read_CLEAR_SYMB_ERR_CNT_value
    Private flag_CLEAR_SYMB_ERR_CNT
    Private write_CLEAR_BLK_ERR_CNT_value
    Private read_CLEAR_BLK_ERR_CNT_value
    Private flag_CLEAR_BLK_ERR_CNT
    Private write_CLEAR_BLK_CNT_value
    Private read_CLEAR_BLK_CNT_value
    Private flag_CLEAR_BLK_CNT
    Private write_MASK_ERROR_value
    Private read_MASK_ERROR_value
    Private flag_MASK_ERROR
    Private write_SUB_DISABLE_value
    Private read_SUB_DISABLE_value
    Private flag_SUB_DISABLE
    Private write_BYPASS_value
    Private read_BYPASS_value
    Private flag_BYPASS

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

    Property Get get_CLEAR_FEC_ERR_FRM16
        get_CLEAR_FEC_ERR_FRM16 = read_CLEAR_FEC_ERR_FRM16_value
    End Property

    Property Let set_CLEAR_FEC_ERR_FRM16(aData)
        write_CLEAR_FEC_ERR_FRM16_value = aData
        flag_CLEAR_FEC_ERR_FRM16        = &H1
    End Property

    Property Get read_CLEAR_FEC_ERR_FRM16
        read
        read_CLEAR_FEC_ERR_FRM16 = read_CLEAR_FEC_ERR_FRM16_value
    End Property

    Property Let write_CLEAR_FEC_ERR_FRM16(aData)
        set_CLEAR_FEC_ERR_FRM16 = aData
        write
    End Property

    Property Get get_CLEAR_FLB_ERR_FRM16
        get_CLEAR_FLB_ERR_FRM16 = read_CLEAR_FLB_ERR_FRM16_value
    End Property

    Property Let set_CLEAR_FLB_ERR_FRM16(aData)
        write_CLEAR_FLB_ERR_FRM16_value = aData
        flag_CLEAR_FLB_ERR_FRM16        = &H1
    End Property

    Property Get read_CLEAR_FLB_ERR_FRM16
        read
        read_CLEAR_FLB_ERR_FRM16 = read_CLEAR_FLB_ERR_FRM16_value
    End Property

    Property Let write_CLEAR_FLB_ERR_FRM16(aData)
        set_CLEAR_FLB_ERR_FRM16 = aData
        write
    End Property

    Property Get get_CLEAR_FEC_ERR_FRM
        get_CLEAR_FEC_ERR_FRM = read_CLEAR_FEC_ERR_FRM_value
    End Property

    Property Let set_CLEAR_FEC_ERR_FRM(aData)
        write_CLEAR_FEC_ERR_FRM_value = aData
        flag_CLEAR_FEC_ERR_FRM        = &H1
    End Property

    Property Get read_CLEAR_FEC_ERR_FRM
        read
        read_CLEAR_FEC_ERR_FRM = read_CLEAR_FEC_ERR_FRM_value
    End Property

    Property Let write_CLEAR_FEC_ERR_FRM(aData)
        set_CLEAR_FEC_ERR_FRM = aData
        write
    End Property

    Property Get get_CLEAR_FLB_ERR_FRM
        get_CLEAR_FLB_ERR_FRM = read_CLEAR_FLB_ERR_FRM_value
    End Property

    Property Let set_CLEAR_FLB_ERR_FRM(aData)
        write_CLEAR_FLB_ERR_FRM_value = aData
        flag_CLEAR_FLB_ERR_FRM        = &H1
    End Property

    Property Get read_CLEAR_FLB_ERR_FRM
        read
        read_CLEAR_FLB_ERR_FRM = read_CLEAR_FLB_ERR_FRM_value
    End Property

    Property Let write_CLEAR_FLB_ERR_FRM(aData)
        set_CLEAR_FLB_ERR_FRM = aData
        write
    End Property

    Property Get get_FEC_CNTS_ENABLE
        get_FEC_CNTS_ENABLE = read_FEC_CNTS_ENABLE_value
    End Property

    Property Let set_FEC_CNTS_ENABLE(aData)
        write_FEC_CNTS_ENABLE_value = aData
        flag_FEC_CNTS_ENABLE        = &H1
    End Property

    Property Get read_FEC_CNTS_ENABLE
        read
        read_FEC_CNTS_ENABLE = read_FEC_CNTS_ENABLE_value
    End Property

    Property Let write_FEC_CNTS_ENABLE(aData)
        set_FEC_CNTS_ENABLE = aData
        write
    End Property

    Property Get get_CLEAR_FAV_ERR_REG
        get_CLEAR_FAV_ERR_REG = read_CLEAR_FAV_ERR_REG_value
    End Property

    Property Let set_CLEAR_FAV_ERR_REG(aData)
        write_CLEAR_FAV_ERR_REG_value = aData
        flag_CLEAR_FAV_ERR_REG        = &H1
    End Property

    Property Get read_CLEAR_FAV_ERR_REG
        read
        read_CLEAR_FAV_ERR_REG = read_CLEAR_FAV_ERR_REG_value
    End Property

    Property Let write_CLEAR_FAV_ERR_REG(aData)
        set_CLEAR_FAV_ERR_REG = aData
        write
    End Property

    Property Get get_CLEAR_FLB_ERR_REG
        get_CLEAR_FLB_ERR_REG = read_CLEAR_FLB_ERR_REG_value
    End Property

    Property Let set_CLEAR_FLB_ERR_REG(aData)
        write_CLEAR_FLB_ERR_REG_value = aData
        flag_CLEAR_FLB_ERR_REG        = &H1
    End Property

    Property Get read_CLEAR_FLB_ERR_REG
        read
        read_CLEAR_FLB_ERR_REG = read_CLEAR_FLB_ERR_REG_value
    End Property

    Property Let write_CLEAR_FLB_ERR_REG(aData)
        set_CLEAR_FLB_ERR_REG = aData
        write
    End Property

    Property Get get_CLEAR_DEC_COR_ERRSYM_512F
        get_CLEAR_DEC_COR_ERRSYM_512F = read_CLEAR_DEC_COR_ERRSYM_512F_value
    End Property

    Property Let set_CLEAR_DEC_COR_ERRSYM_512F(aData)
        write_CLEAR_DEC_COR_ERRSYM_512F_value = aData
        flag_CLEAR_DEC_COR_ERRSYM_512F        = &H1
    End Property

    Property Get read_CLEAR_DEC_COR_ERRSYM_512F
        read
        read_CLEAR_DEC_COR_ERRSYM_512F = read_CLEAR_DEC_COR_ERRSYM_512F_value
    End Property

    Property Let write_CLEAR_DEC_COR_ERRSYM_512F(aData)
        set_CLEAR_DEC_COR_ERRSYM_512F = aData
        write
    End Property

    Property Get get_FEC_DEC_STAT_CLR
        get_FEC_DEC_STAT_CLR = read_FEC_DEC_STAT_CLR_value
    End Property

    Property Let set_FEC_DEC_STAT_CLR(aData)
        write_FEC_DEC_STAT_CLR_value = aData
        flag_FEC_DEC_STAT_CLR        = &H1
    End Property

    Property Get read_FEC_DEC_STAT_CLR
        read
        read_FEC_DEC_STAT_CLR = read_FEC_DEC_STAT_CLR_value
    End Property

    Property Let write_FEC_DEC_STAT_CLR(aData)
        set_FEC_DEC_STAT_CLR = aData
        write
    End Property

    Property Get get_FEC_DEC_INIT
        get_FEC_DEC_INIT = read_FEC_DEC_INIT_value
    End Property

    Property Let set_FEC_DEC_INIT(aData)
        write_FEC_DEC_INIT_value = aData
        flag_FEC_DEC_INIT        = &H1
    End Property

    Property Get read_FEC_DEC_INIT
        read
        read_FEC_DEC_INIT = read_FEC_DEC_INIT_value
    End Property

    Property Let write_FEC_DEC_INIT(aData)
        set_FEC_DEC_INIT = aData
        write
    End Property

    Property Get get_CLEAR_SYMB_ERR_CNT
        get_CLEAR_SYMB_ERR_CNT = read_CLEAR_SYMB_ERR_CNT_value
    End Property

    Property Let set_CLEAR_SYMB_ERR_CNT(aData)
        write_CLEAR_SYMB_ERR_CNT_value = aData
        flag_CLEAR_SYMB_ERR_CNT        = &H1
    End Property

    Property Get read_CLEAR_SYMB_ERR_CNT
        read
        read_CLEAR_SYMB_ERR_CNT = read_CLEAR_SYMB_ERR_CNT_value
    End Property

    Property Let write_CLEAR_SYMB_ERR_CNT(aData)
        set_CLEAR_SYMB_ERR_CNT = aData
        write
    End Property

    Property Get get_CLEAR_BLK_ERR_CNT
        get_CLEAR_BLK_ERR_CNT = read_CLEAR_BLK_ERR_CNT_value
    End Property

    Property Let set_CLEAR_BLK_ERR_CNT(aData)
        write_CLEAR_BLK_ERR_CNT_value = aData
        flag_CLEAR_BLK_ERR_CNT        = &H1
    End Property

    Property Get read_CLEAR_BLK_ERR_CNT
        read
        read_CLEAR_BLK_ERR_CNT = read_CLEAR_BLK_ERR_CNT_value
    End Property

    Property Let write_CLEAR_BLK_ERR_CNT(aData)
        set_CLEAR_BLK_ERR_CNT = aData
        write
    End Property

    Property Get get_CLEAR_BLK_CNT
        get_CLEAR_BLK_CNT = read_CLEAR_BLK_CNT_value
    End Property

    Property Let set_CLEAR_BLK_CNT(aData)
        write_CLEAR_BLK_CNT_value = aData
        flag_CLEAR_BLK_CNT        = &H1
    End Property

    Property Get read_CLEAR_BLK_CNT
        read
        read_CLEAR_BLK_CNT = read_CLEAR_BLK_CNT_value
    End Property

    Property Let write_CLEAR_BLK_CNT(aData)
        set_CLEAR_BLK_CNT = aData
        write
    End Property

    Property Get get_MASK_ERROR
        get_MASK_ERROR = read_MASK_ERROR_value
    End Property

    Property Let set_MASK_ERROR(aData)
        write_MASK_ERROR_value = aData
        flag_MASK_ERROR        = &H1
    End Property

    Property Get read_MASK_ERROR
        read
        read_MASK_ERROR = read_MASK_ERROR_value
    End Property

    Property Let write_MASK_ERROR(aData)
        set_MASK_ERROR = aData
        write
    End Property

    Property Get get_SUB_DISABLE
        get_SUB_DISABLE = read_SUB_DISABLE_value
    End Property

    Property Let set_SUB_DISABLE(aData)
        write_SUB_DISABLE_value = aData
        flag_SUB_DISABLE        = &H1
    End Property

    Property Get read_SUB_DISABLE
        read
        read_SUB_DISABLE = read_SUB_DISABLE_value
    End Property

    Property Let write_SUB_DISABLE(aData)
        set_SUB_DISABLE = aData
        write
    End Property

    Property Get get_BYPASS
        get_BYPASS = read_BYPASS_value
    End Property

    Property Let set_BYPASS(aData)
        write_BYPASS_value = aData
        flag_BYPASS        = &H1
    End Property

    Property Get read_BYPASS
        read
        read_BYPASS = read_BYPASS_value
    End Property

    Property Let write_BYPASS(aData)
        set_BYPASS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CLEAR_FEC_ERR_FRM16_value = rightShift(data_low, 15) and &H1
        read_CLEAR_FLB_ERR_FRM16_value = rightShift(data_low, 14) and &H1
        read_CLEAR_FEC_ERR_FRM_value = rightShift(data_low, 13) and &H1
        read_CLEAR_FLB_ERR_FRM_value = rightShift(data_low, 12) and &H1
        read_FEC_CNTS_ENABLE_value = rightShift(data_low, 11) and &H1
        read_CLEAR_FAV_ERR_REG_value = rightShift(data_low, 10) and &H1
        read_CLEAR_FLB_ERR_REG_value = rightShift(data_low, 9) and &H1
        read_CLEAR_DEC_COR_ERRSYM_512F_value = rightShift(data_low, 8) and &H1
        read_FEC_DEC_STAT_CLR_value = rightShift(data_low, 7) and &H1
        read_FEC_DEC_INIT_value = rightShift(data_low, 6) and &H1
        read_CLEAR_SYMB_ERR_CNT_value = rightShift(data_low, 5) and &H1
        read_CLEAR_BLK_ERR_CNT_value = rightShift(data_low, 4) and &H1
        read_CLEAR_BLK_CNT_value = rightShift(data_low, 3) and &H1
        read_MASK_ERROR_value = rightShift(data_low, 2) and &H1
        read_SUB_DISABLE_value = rightShift(data_low, 1) and &H1
        BYPASS_mask = &H1
        if data_low > LONG_MAX then
            if BYPASS_mask = mask then
                read_BYPASS_value = data_low
            else
                read_BYPASS_value = (data_low - H8000_0000) and BYPASS_mask
            end If
        else
            read_BYPASS_value = data_low and BYPASS_mask
        end If

    End Sub

    Sub write
        If flag_CLEAR_FEC_ERR_FRM16 = &H0 or flag_CLEAR_FLB_ERR_FRM16 = &H0 or flag_CLEAR_FEC_ERR_FRM = &H0 or flag_CLEAR_FLB_ERR_FRM = &H0 or flag_FEC_CNTS_ENABLE = &H0 or flag_CLEAR_FAV_ERR_REG = &H0 or flag_CLEAR_FLB_ERR_REG = &H0 or flag_CLEAR_DEC_COR_ERRSYM_512F = &H0 or flag_FEC_DEC_STAT_CLR = &H0 or flag_FEC_DEC_INIT = &H0 or flag_CLEAR_SYMB_ERR_CNT = &H0 or flag_CLEAR_BLK_ERR_CNT = &H0 or flag_CLEAR_BLK_CNT = &H0 or flag_MASK_ERROR = &H0 or flag_SUB_DISABLE = &H0 or flag_BYPASS = &H0 Then read
        If flag_CLEAR_FEC_ERR_FRM16 = &H0 Then write_CLEAR_FEC_ERR_FRM16_value = get_CLEAR_FEC_ERR_FRM16
        If flag_CLEAR_FLB_ERR_FRM16 = &H0 Then write_CLEAR_FLB_ERR_FRM16_value = get_CLEAR_FLB_ERR_FRM16
        If flag_CLEAR_FEC_ERR_FRM = &H0 Then write_CLEAR_FEC_ERR_FRM_value = get_CLEAR_FEC_ERR_FRM
        If flag_CLEAR_FLB_ERR_FRM = &H0 Then write_CLEAR_FLB_ERR_FRM_value = get_CLEAR_FLB_ERR_FRM
        If flag_FEC_CNTS_ENABLE = &H0 Then write_FEC_CNTS_ENABLE_value = get_FEC_CNTS_ENABLE
        If flag_CLEAR_FAV_ERR_REG = &H0 Then write_CLEAR_FAV_ERR_REG_value = get_CLEAR_FAV_ERR_REG
        If flag_CLEAR_FLB_ERR_REG = &H0 Then write_CLEAR_FLB_ERR_REG_value = get_CLEAR_FLB_ERR_REG
        If flag_CLEAR_DEC_COR_ERRSYM_512F = &H0 Then write_CLEAR_DEC_COR_ERRSYM_512F_value = get_CLEAR_DEC_COR_ERRSYM_512F
        If flag_FEC_DEC_STAT_CLR = &H0 Then write_FEC_DEC_STAT_CLR_value = get_FEC_DEC_STAT_CLR
        If flag_FEC_DEC_INIT = &H0 Then write_FEC_DEC_INIT_value = get_FEC_DEC_INIT
        If flag_CLEAR_SYMB_ERR_CNT = &H0 Then write_CLEAR_SYMB_ERR_CNT_value = get_CLEAR_SYMB_ERR_CNT
        If flag_CLEAR_BLK_ERR_CNT = &H0 Then write_CLEAR_BLK_ERR_CNT_value = get_CLEAR_BLK_ERR_CNT
        If flag_CLEAR_BLK_CNT = &H0 Then write_CLEAR_BLK_CNT_value = get_CLEAR_BLK_CNT
        If flag_MASK_ERROR = &H0 Then write_MASK_ERROR_value = get_MASK_ERROR
        If flag_SUB_DISABLE = &H0 Then write_SUB_DISABLE_value = get_SUB_DISABLE
        If flag_BYPASS = &H0 Then write_BYPASS_value = get_BYPASS

        regValue = leftShift((write_CLEAR_FEC_ERR_FRM16_value and &H1), 15) + leftShift((write_CLEAR_FLB_ERR_FRM16_value and &H1), 14) + leftShift((write_CLEAR_FEC_ERR_FRM_value and &H1), 13) + leftShift((write_CLEAR_FLB_ERR_FRM_value and &H1), 12) + leftShift((write_FEC_CNTS_ENABLE_value and &H1), 11) + leftShift((write_CLEAR_FAV_ERR_REG_value and &H1), 10) + leftShift((write_CLEAR_FLB_ERR_REG_value and &H1), 9) + leftShift((write_CLEAR_DEC_COR_ERRSYM_512F_value and &H1), 8) + leftShift((write_FEC_DEC_STAT_CLR_value and &H1), 7) + leftShift((write_FEC_DEC_INIT_value and &H1), 6) + leftShift((write_CLEAR_SYMB_ERR_CNT_value and &H1), 5) + leftShift((write_CLEAR_BLK_ERR_CNT_value and &H1), 4) + leftShift((write_CLEAR_BLK_CNT_value and &H1), 3) + leftShift((write_MASK_ERROR_value and &H1), 2) + leftShift((write_SUB_DISABLE_value and &H1), 1) + leftShift((write_BYPASS_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CLEAR_FEC_ERR_FRM16_value = rightShift(data_low, 15) and &H1
        read_CLEAR_FLB_ERR_FRM16_value = rightShift(data_low, 14) and &H1
        read_CLEAR_FEC_ERR_FRM_value = rightShift(data_low, 13) and &H1
        read_CLEAR_FLB_ERR_FRM_value = rightShift(data_low, 12) and &H1
        read_FEC_CNTS_ENABLE_value = rightShift(data_low, 11) and &H1
        read_CLEAR_FAV_ERR_REG_value = rightShift(data_low, 10) and &H1
        read_CLEAR_FLB_ERR_REG_value = rightShift(data_low, 9) and &H1
        read_CLEAR_DEC_COR_ERRSYM_512F_value = rightShift(data_low, 8) and &H1
        read_FEC_DEC_STAT_CLR_value = rightShift(data_low, 7) and &H1
        read_FEC_DEC_INIT_value = rightShift(data_low, 6) and &H1
        read_CLEAR_SYMB_ERR_CNT_value = rightShift(data_low, 5) and &H1
        read_CLEAR_BLK_ERR_CNT_value = rightShift(data_low, 4) and &H1
        read_CLEAR_BLK_CNT_value = rightShift(data_low, 3) and &H1
        read_MASK_ERROR_value = rightShift(data_low, 2) and &H1
        read_SUB_DISABLE_value = rightShift(data_low, 1) and &H1
        BYPASS_mask = &H1
        if data_low > LONG_MAX then
            if BYPASS_mask = mask then
                read_BYPASS_value = data_low
            else
                read_BYPASS_value = (data_low - H8000_0000) and BYPASS_mask
            end If
        else
            read_BYPASS_value = data_low and BYPASS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CLEAR_FEC_ERR_FRM16_value = &H0
        flag_CLEAR_FEC_ERR_FRM16        = &H0
        write_CLEAR_FLB_ERR_FRM16_value = &H0
        flag_CLEAR_FLB_ERR_FRM16        = &H0
        write_CLEAR_FEC_ERR_FRM_value = &H0
        flag_CLEAR_FEC_ERR_FRM        = &H0
        write_CLEAR_FLB_ERR_FRM_value = &H0
        flag_CLEAR_FLB_ERR_FRM        = &H0
        write_FEC_CNTS_ENABLE_value = &H0
        flag_FEC_CNTS_ENABLE        = &H0
        write_CLEAR_FAV_ERR_REG_value = &H0
        flag_CLEAR_FAV_ERR_REG        = &H0
        write_CLEAR_FLB_ERR_REG_value = &H0
        flag_CLEAR_FLB_ERR_REG        = &H0
        write_CLEAR_DEC_COR_ERRSYM_512F_value = &H0
        flag_CLEAR_DEC_COR_ERRSYM_512F        = &H0
        write_FEC_DEC_STAT_CLR_value = &H0
        flag_FEC_DEC_STAT_CLR        = &H0
        write_FEC_DEC_INIT_value = &H0
        flag_FEC_DEC_INIT        = &H0
        write_CLEAR_SYMB_ERR_CNT_value = &H0
        flag_CLEAR_SYMB_ERR_CNT        = &H0
        write_CLEAR_BLK_ERR_CNT_value = &H0
        flag_CLEAR_BLK_ERR_CNT        = &H0
        write_CLEAR_BLK_CNT_value = &H0
        flag_CLEAR_BLK_CNT        = &H0
        write_MASK_ERROR_value = &H0
        flag_MASK_ERROR        = &H0
        write_SUB_DISABLE_value = &H0
        flag_SUB_DISABLE        = &H0
        write_BYPASS_value = &H0
        flag_BYPASS        = &H0
    End Sub
End Class


'' @REGISTER : FEC_blk_cnt_period_lsb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' BLK_CNT_PERIOD_LSB                         [15:0]           get_BLK_CNT_PERIOD_LSB
''                                                             set_BLK_CNT_PERIOD_LSB
''                                                             read_BLK_CNT_PERIOD_LSB
''                                                             write_BLK_CNT_PERIOD_LSB
''---------------------------------------------------------------------------------
Class REGISTER_FEC_blk_cnt_period_lsb
    Private write_BLK_CNT_PERIOD_LSB_value
    Private read_BLK_CNT_PERIOD_LSB_value
    Private flag_BLK_CNT_PERIOD_LSB

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

    Property Get get_BLK_CNT_PERIOD_LSB
        get_BLK_CNT_PERIOD_LSB = read_BLK_CNT_PERIOD_LSB_value
    End Property

    Property Let set_BLK_CNT_PERIOD_LSB(aData)
        write_BLK_CNT_PERIOD_LSB_value = aData
        flag_BLK_CNT_PERIOD_LSB        = &H1
    End Property

    Property Get read_BLK_CNT_PERIOD_LSB
        read
        read_BLK_CNT_PERIOD_LSB = read_BLK_CNT_PERIOD_LSB_value
    End Property

    Property Let write_BLK_CNT_PERIOD_LSB(aData)
        set_BLK_CNT_PERIOD_LSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        BLK_CNT_PERIOD_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if BLK_CNT_PERIOD_LSB_mask = mask then
                read_BLK_CNT_PERIOD_LSB_value = data_low
            else
                read_BLK_CNT_PERIOD_LSB_value = (data_low - H8000_0000) and BLK_CNT_PERIOD_LSB_mask
            end If
        else
            read_BLK_CNT_PERIOD_LSB_value = data_low and BLK_CNT_PERIOD_LSB_mask
        end If

    End Sub

    Sub write
        If flag_BLK_CNT_PERIOD_LSB = &H0 Then read
        If flag_BLK_CNT_PERIOD_LSB = &H0 Then write_BLK_CNT_PERIOD_LSB_value = get_BLK_CNT_PERIOD_LSB

        regValue = leftShift((write_BLK_CNT_PERIOD_LSB_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        BLK_CNT_PERIOD_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if BLK_CNT_PERIOD_LSB_mask = mask then
                read_BLK_CNT_PERIOD_LSB_value = data_low
            else
                read_BLK_CNT_PERIOD_LSB_value = (data_low - H8000_0000) and BLK_CNT_PERIOD_LSB_mask
            end If
        else
            read_BLK_CNT_PERIOD_LSB_value = data_low and BLK_CNT_PERIOD_LSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_BLK_CNT_PERIOD_LSB_value = &H0
        flag_BLK_CNT_PERIOD_LSB        = &H0
    End Sub
End Class


'' @REGISTER : FEC_blk_cnt_period_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' BLK_CNT_PERIOD_MSB                         [15:0]           get_BLK_CNT_PERIOD_MSB
''                                                             set_BLK_CNT_PERIOD_MSB
''                                                             read_BLK_CNT_PERIOD_MSB
''                                                             write_BLK_CNT_PERIOD_MSB
''---------------------------------------------------------------------------------
Class REGISTER_FEC_blk_cnt_period_msb
    Private write_BLK_CNT_PERIOD_MSB_value
    Private read_BLK_CNT_PERIOD_MSB_value
    Private flag_BLK_CNT_PERIOD_MSB

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

    Property Get get_BLK_CNT_PERIOD_MSB
        get_BLK_CNT_PERIOD_MSB = read_BLK_CNT_PERIOD_MSB_value
    End Property

    Property Let set_BLK_CNT_PERIOD_MSB(aData)
        write_BLK_CNT_PERIOD_MSB_value = aData
        flag_BLK_CNT_PERIOD_MSB        = &H1
    End Property

    Property Get read_BLK_CNT_PERIOD_MSB
        read
        read_BLK_CNT_PERIOD_MSB = read_BLK_CNT_PERIOD_MSB_value
    End Property

    Property Let write_BLK_CNT_PERIOD_MSB(aData)
        set_BLK_CNT_PERIOD_MSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        BLK_CNT_PERIOD_MSB_mask = &Hffff
        if data_low > LONG_MAX then
            if BLK_CNT_PERIOD_MSB_mask = mask then
                read_BLK_CNT_PERIOD_MSB_value = data_low
            else
                read_BLK_CNT_PERIOD_MSB_value = (data_low - H8000_0000) and BLK_CNT_PERIOD_MSB_mask
            end If
        else
            read_BLK_CNT_PERIOD_MSB_value = data_low and BLK_CNT_PERIOD_MSB_mask
        end If

    End Sub

    Sub write
        If flag_BLK_CNT_PERIOD_MSB = &H0 Then read
        If flag_BLK_CNT_PERIOD_MSB = &H0 Then write_BLK_CNT_PERIOD_MSB_value = get_BLK_CNT_PERIOD_MSB

        regValue = leftShift((write_BLK_CNT_PERIOD_MSB_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        BLK_CNT_PERIOD_MSB_mask = &Hffff
        if data_low > LONG_MAX then
            if BLK_CNT_PERIOD_MSB_mask = mask then
                read_BLK_CNT_PERIOD_MSB_value = data_low
            else
                read_BLK_CNT_PERIOD_MSB_value = (data_low - H8000_0000) and BLK_CNT_PERIOD_MSB_mask
            end If
        else
            read_BLK_CNT_PERIOD_MSB_value = data_low and BLK_CNT_PERIOD_MSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_BLK_CNT_PERIOD_MSB_value = &H0
        flag_BLK_CNT_PERIOD_MSB        = &H0
    End Sub
End Class


'' @REGISTER : FEC_blk_cnt_lsb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' BLK_CNT_LSB                                [15:0]           get_BLK_CNT_LSB
''                                                             set_BLK_CNT_LSB
''                                                             read_BLK_CNT_LSB
''                                                             write_BLK_CNT_LSB
''---------------------------------------------------------------------------------
Class REGISTER_FEC_blk_cnt_lsb
    Private write_BLK_CNT_LSB_value
    Private read_BLK_CNT_LSB_value
    Private flag_BLK_CNT_LSB

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

    Property Get get_BLK_CNT_LSB
        get_BLK_CNT_LSB = read_BLK_CNT_LSB_value
    End Property

    Property Let set_BLK_CNT_LSB(aData)
        write_BLK_CNT_LSB_value = aData
        flag_BLK_CNT_LSB        = &H1
    End Property

    Property Get read_BLK_CNT_LSB
        read
        read_BLK_CNT_LSB = read_BLK_CNT_LSB_value
    End Property

    Property Let write_BLK_CNT_LSB(aData)
        set_BLK_CNT_LSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        BLK_CNT_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if BLK_CNT_LSB_mask = mask then
                read_BLK_CNT_LSB_value = data_low
            else
                read_BLK_CNT_LSB_value = (data_low - H8000_0000) and BLK_CNT_LSB_mask
            end If
        else
            read_BLK_CNT_LSB_value = data_low and BLK_CNT_LSB_mask
        end If

    End Sub

    Sub write
        If flag_BLK_CNT_LSB = &H0 Then read
        If flag_BLK_CNT_LSB = &H0 Then write_BLK_CNT_LSB_value = get_BLK_CNT_LSB

        regValue = leftShift((write_BLK_CNT_LSB_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        BLK_CNT_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if BLK_CNT_LSB_mask = mask then
                read_BLK_CNT_LSB_value = data_low
            else
                read_BLK_CNT_LSB_value = (data_low - H8000_0000) and BLK_CNT_LSB_mask
            end If
        else
            read_BLK_CNT_LSB_value = data_low and BLK_CNT_LSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_BLK_CNT_LSB_value = &H0
        flag_BLK_CNT_LSB        = &H0
    End Sub
End Class


'' @REGISTER : FEC_blk_cnt_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' BLK_CNT_MSB                                [15:0]           get_BLK_CNT_MSB
''                                                             set_BLK_CNT_MSB
''                                                             read_BLK_CNT_MSB
''                                                             write_BLK_CNT_MSB
''---------------------------------------------------------------------------------
Class REGISTER_FEC_blk_cnt_msb
    Private write_BLK_CNT_MSB_value
    Private read_BLK_CNT_MSB_value
    Private flag_BLK_CNT_MSB

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

    Property Get get_BLK_CNT_MSB
        get_BLK_CNT_MSB = read_BLK_CNT_MSB_value
    End Property

    Property Let set_BLK_CNT_MSB(aData)
        write_BLK_CNT_MSB_value = aData
        flag_BLK_CNT_MSB        = &H1
    End Property

    Property Get read_BLK_CNT_MSB
        read
        read_BLK_CNT_MSB = read_BLK_CNT_MSB_value
    End Property

    Property Let write_BLK_CNT_MSB(aData)
        set_BLK_CNT_MSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        BLK_CNT_MSB_mask = &Hffff
        if data_low > LONG_MAX then
            if BLK_CNT_MSB_mask = mask then
                read_BLK_CNT_MSB_value = data_low
            else
                read_BLK_CNT_MSB_value = (data_low - H8000_0000) and BLK_CNT_MSB_mask
            end If
        else
            read_BLK_CNT_MSB_value = data_low and BLK_CNT_MSB_mask
        end If

    End Sub

    Sub write
        If flag_BLK_CNT_MSB = &H0 Then read
        If flag_BLK_CNT_MSB = &H0 Then write_BLK_CNT_MSB_value = get_BLK_CNT_MSB

        regValue = leftShift((write_BLK_CNT_MSB_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        BLK_CNT_MSB_mask = &Hffff
        if data_low > LONG_MAX then
            if BLK_CNT_MSB_mask = mask then
                read_BLK_CNT_MSB_value = data_low
            else
                read_BLK_CNT_MSB_value = (data_low - H8000_0000) and BLK_CNT_MSB_mask
            end If
        else
            read_BLK_CNT_MSB_value = data_low and BLK_CNT_MSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_BLK_CNT_MSB_value = &H0
        flag_BLK_CNT_MSB        = &H0
    End Sub
End Class


'' @REGISTER : FEC_blk_err_cnt_lsb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' BLK_ERR_CNT_LSB                            [15:0]           get_BLK_ERR_CNT_LSB
''                                                             set_BLK_ERR_CNT_LSB
''                                                             read_BLK_ERR_CNT_LSB
''                                                             write_BLK_ERR_CNT_LSB
''---------------------------------------------------------------------------------
Class REGISTER_FEC_blk_err_cnt_lsb
    Private write_BLK_ERR_CNT_LSB_value
    Private read_BLK_ERR_CNT_LSB_value
    Private flag_BLK_ERR_CNT_LSB

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

    Property Get get_BLK_ERR_CNT_LSB
        get_BLK_ERR_CNT_LSB = read_BLK_ERR_CNT_LSB_value
    End Property

    Property Let set_BLK_ERR_CNT_LSB(aData)
        write_BLK_ERR_CNT_LSB_value = aData
        flag_BLK_ERR_CNT_LSB        = &H1
    End Property

    Property Get read_BLK_ERR_CNT_LSB
        read
        read_BLK_ERR_CNT_LSB = read_BLK_ERR_CNT_LSB_value
    End Property

    Property Let write_BLK_ERR_CNT_LSB(aData)
        set_BLK_ERR_CNT_LSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        BLK_ERR_CNT_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if BLK_ERR_CNT_LSB_mask = mask then
                read_BLK_ERR_CNT_LSB_value = data_low
            else
                read_BLK_ERR_CNT_LSB_value = (data_low - H8000_0000) and BLK_ERR_CNT_LSB_mask
            end If
        else
            read_BLK_ERR_CNT_LSB_value = data_low and BLK_ERR_CNT_LSB_mask
        end If

    End Sub

    Sub write
        If flag_BLK_ERR_CNT_LSB = &H0 Then read
        If flag_BLK_ERR_CNT_LSB = &H0 Then write_BLK_ERR_CNT_LSB_value = get_BLK_ERR_CNT_LSB

        regValue = leftShift((write_BLK_ERR_CNT_LSB_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        BLK_ERR_CNT_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if BLK_ERR_CNT_LSB_mask = mask then
                read_BLK_ERR_CNT_LSB_value = data_low
            else
                read_BLK_ERR_CNT_LSB_value = (data_low - H8000_0000) and BLK_ERR_CNT_LSB_mask
            end If
        else
            read_BLK_ERR_CNT_LSB_value = data_low and BLK_ERR_CNT_LSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_BLK_ERR_CNT_LSB_value = &H0
        flag_BLK_ERR_CNT_LSB        = &H0
    End Sub
End Class


'' @REGISTER : FEC_blk_err_cnt_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' BLK_ERR_CNT_MSB                            [15:0]           get_BLK_ERR_CNT_MSB
''                                                             set_BLK_ERR_CNT_MSB
''                                                             read_BLK_ERR_CNT_MSB
''                                                             write_BLK_ERR_CNT_MSB
''---------------------------------------------------------------------------------
Class REGISTER_FEC_blk_err_cnt_msb
    Private write_BLK_ERR_CNT_MSB_value
    Private read_BLK_ERR_CNT_MSB_value
    Private flag_BLK_ERR_CNT_MSB

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

    Property Get get_BLK_ERR_CNT_MSB
        get_BLK_ERR_CNT_MSB = read_BLK_ERR_CNT_MSB_value
    End Property

    Property Let set_BLK_ERR_CNT_MSB(aData)
        write_BLK_ERR_CNT_MSB_value = aData
        flag_BLK_ERR_CNT_MSB        = &H1
    End Property

    Property Get read_BLK_ERR_CNT_MSB
        read
        read_BLK_ERR_CNT_MSB = read_BLK_ERR_CNT_MSB_value
    End Property

    Property Let write_BLK_ERR_CNT_MSB(aData)
        set_BLK_ERR_CNT_MSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        BLK_ERR_CNT_MSB_mask = &Hffff
        if data_low > LONG_MAX then
            if BLK_ERR_CNT_MSB_mask = mask then
                read_BLK_ERR_CNT_MSB_value = data_low
            else
                read_BLK_ERR_CNT_MSB_value = (data_low - H8000_0000) and BLK_ERR_CNT_MSB_mask
            end If
        else
            read_BLK_ERR_CNT_MSB_value = data_low and BLK_ERR_CNT_MSB_mask
        end If

    End Sub

    Sub write
        If flag_BLK_ERR_CNT_MSB = &H0 Then read
        If flag_BLK_ERR_CNT_MSB = &H0 Then write_BLK_ERR_CNT_MSB_value = get_BLK_ERR_CNT_MSB

        regValue = leftShift((write_BLK_ERR_CNT_MSB_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        BLK_ERR_CNT_MSB_mask = &Hffff
        if data_low > LONG_MAX then
            if BLK_ERR_CNT_MSB_mask = mask then
                read_BLK_ERR_CNT_MSB_value = data_low
            else
                read_BLK_ERR_CNT_MSB_value = (data_low - H8000_0000) and BLK_ERR_CNT_MSB_mask
            end If
        else
            read_BLK_ERR_CNT_MSB_value = data_low and BLK_ERR_CNT_MSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_BLK_ERR_CNT_MSB_value = &H0
        flag_BLK_ERR_CNT_MSB        = &H0
    End Sub
End Class


'' @REGISTER : FEC_symb_err_cnt_lsb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SYMB_ERR_CNT_LSB                           [15:0]           get_SYMB_ERR_CNT_LSB
''                                                             set_SYMB_ERR_CNT_LSB
''                                                             read_SYMB_ERR_CNT_LSB
''                                                             write_SYMB_ERR_CNT_LSB
''---------------------------------------------------------------------------------
Class REGISTER_FEC_symb_err_cnt_lsb
    Private write_SYMB_ERR_CNT_LSB_value
    Private read_SYMB_ERR_CNT_LSB_value
    Private flag_SYMB_ERR_CNT_LSB

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

    Property Get get_SYMB_ERR_CNT_LSB
        get_SYMB_ERR_CNT_LSB = read_SYMB_ERR_CNT_LSB_value
    End Property

    Property Let set_SYMB_ERR_CNT_LSB(aData)
        write_SYMB_ERR_CNT_LSB_value = aData
        flag_SYMB_ERR_CNT_LSB        = &H1
    End Property

    Property Get read_SYMB_ERR_CNT_LSB
        read
        read_SYMB_ERR_CNT_LSB = read_SYMB_ERR_CNT_LSB_value
    End Property

    Property Let write_SYMB_ERR_CNT_LSB(aData)
        set_SYMB_ERR_CNT_LSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SYMB_ERR_CNT_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if SYMB_ERR_CNT_LSB_mask = mask then
                read_SYMB_ERR_CNT_LSB_value = data_low
            else
                read_SYMB_ERR_CNT_LSB_value = (data_low - H8000_0000) and SYMB_ERR_CNT_LSB_mask
            end If
        else
            read_SYMB_ERR_CNT_LSB_value = data_low and SYMB_ERR_CNT_LSB_mask
        end If

    End Sub

    Sub write
        If flag_SYMB_ERR_CNT_LSB = &H0 Then read
        If flag_SYMB_ERR_CNT_LSB = &H0 Then write_SYMB_ERR_CNT_LSB_value = get_SYMB_ERR_CNT_LSB

        regValue = leftShift((write_SYMB_ERR_CNT_LSB_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SYMB_ERR_CNT_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if SYMB_ERR_CNT_LSB_mask = mask then
                read_SYMB_ERR_CNT_LSB_value = data_low
            else
                read_SYMB_ERR_CNT_LSB_value = (data_low - H8000_0000) and SYMB_ERR_CNT_LSB_mask
            end If
        else
            read_SYMB_ERR_CNT_LSB_value = data_low and SYMB_ERR_CNT_LSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SYMB_ERR_CNT_LSB_value = &H0
        flag_SYMB_ERR_CNT_LSB        = &H0
    End Sub
End Class


'' @REGISTER : FEC_symb_err_cnt_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SYMB_ERR_CNT_MSB                           [15:0]           get_SYMB_ERR_CNT_MSB
''                                                             set_SYMB_ERR_CNT_MSB
''                                                             read_SYMB_ERR_CNT_MSB
''                                                             write_SYMB_ERR_CNT_MSB
''---------------------------------------------------------------------------------
Class REGISTER_FEC_symb_err_cnt_msb
    Private write_SYMB_ERR_CNT_MSB_value
    Private read_SYMB_ERR_CNT_MSB_value
    Private flag_SYMB_ERR_CNT_MSB

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

    Property Get get_SYMB_ERR_CNT_MSB
        get_SYMB_ERR_CNT_MSB = read_SYMB_ERR_CNT_MSB_value
    End Property

    Property Let set_SYMB_ERR_CNT_MSB(aData)
        write_SYMB_ERR_CNT_MSB_value = aData
        flag_SYMB_ERR_CNT_MSB        = &H1
    End Property

    Property Get read_SYMB_ERR_CNT_MSB
        read
        read_SYMB_ERR_CNT_MSB = read_SYMB_ERR_CNT_MSB_value
    End Property

    Property Let write_SYMB_ERR_CNT_MSB(aData)
        set_SYMB_ERR_CNT_MSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SYMB_ERR_CNT_MSB_mask = &Hffff
        if data_low > LONG_MAX then
            if SYMB_ERR_CNT_MSB_mask = mask then
                read_SYMB_ERR_CNT_MSB_value = data_low
            else
                read_SYMB_ERR_CNT_MSB_value = (data_low - H8000_0000) and SYMB_ERR_CNT_MSB_mask
            end If
        else
            read_SYMB_ERR_CNT_MSB_value = data_low and SYMB_ERR_CNT_MSB_mask
        end If

    End Sub

    Sub write
        If flag_SYMB_ERR_CNT_MSB = &H0 Then read
        If flag_SYMB_ERR_CNT_MSB = &H0 Then write_SYMB_ERR_CNT_MSB_value = get_SYMB_ERR_CNT_MSB

        regValue = leftShift((write_SYMB_ERR_CNT_MSB_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SYMB_ERR_CNT_MSB_mask = &Hffff
        if data_low > LONG_MAX then
            if SYMB_ERR_CNT_MSB_mask = mask then
                read_SYMB_ERR_CNT_MSB_value = data_low
            else
                read_SYMB_ERR_CNT_MSB_value = (data_low - H8000_0000) and SYMB_ERR_CNT_MSB_mask
            end If
        else
            read_SYMB_ERR_CNT_MSB_value = data_low and SYMB_ERR_CNT_MSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SYMB_ERR_CNT_MSB_value = &H0
        flag_SYMB_ERR_CNT_MSB        = &H0
    End Sub
End Class


'' @REGISTER : FEC_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SPARE                                      [15:2]           get_SPARE
''                                                             set_SPARE
''                                                             read_SPARE
''                                                             write_SPARE
''---------------------------------------------------------------------------------
'' SOF_SLOW                                   [1:1]            get_SOF_SLOW
''                                                             set_SOF_SLOW
''                                                             read_SOF_SLOW
''                                                             write_SOF_SLOW
''---------------------------------------------------------------------------------
'' SOF_FAST                                   [0:0]            get_SOF_FAST
''                                                             set_SOF_FAST
''                                                             read_SOF_FAST
''                                                             write_SOF_FAST
''---------------------------------------------------------------------------------
Class REGISTER_FEC_status
    Private write_SPARE_value
    Private read_SPARE_value
    Private flag_SPARE
    Private write_SOF_SLOW_value
    Private read_SOF_SLOW_value
    Private flag_SOF_SLOW
    Private write_SOF_FAST_value
    Private read_SOF_FAST_value
    Private flag_SOF_FAST

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

    Property Get get_SPARE
        get_SPARE = read_SPARE_value
    End Property

    Property Let set_SPARE(aData)
        write_SPARE_value = aData
        flag_SPARE        = &H1
    End Property

    Property Get read_SPARE
        read
        read_SPARE = read_SPARE_value
    End Property

    Property Let write_SPARE(aData)
        set_SPARE = aData
        write
    End Property

    Property Get get_SOF_SLOW
        get_SOF_SLOW = read_SOF_SLOW_value
    End Property

    Property Let set_SOF_SLOW(aData)
        write_SOF_SLOW_value = aData
        flag_SOF_SLOW        = &H1
    End Property

    Property Get read_SOF_SLOW
        read
        read_SOF_SLOW = read_SOF_SLOW_value
    End Property

    Property Let write_SOF_SLOW(aData)
        set_SOF_SLOW = aData
        write
    End Property

    Property Get get_SOF_FAST
        get_SOF_FAST = read_SOF_FAST_value
    End Property

    Property Let set_SOF_FAST(aData)
        write_SOF_FAST_value = aData
        flag_SOF_FAST        = &H1
    End Property

    Property Get read_SOF_FAST
        read
        read_SOF_FAST = read_SOF_FAST_value
    End Property

    Property Let write_SOF_FAST(aData)
        set_SOF_FAST = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_SPARE_value = rightShift(data_low, 2) and &H3fff
        read_SOF_SLOW_value = rightShift(data_low, 1) and &H1
        SOF_FAST_mask = &H1
        if data_low > LONG_MAX then
            if SOF_FAST_mask = mask then
                read_SOF_FAST_value = data_low
            else
                read_SOF_FAST_value = (data_low - H8000_0000) and SOF_FAST_mask
            end If
        else
            read_SOF_FAST_value = data_low and SOF_FAST_mask
        end If

    End Sub

    Sub write
        If flag_SPARE = &H0 or flag_SOF_SLOW = &H0 or flag_SOF_FAST = &H0 Then read
        If flag_SPARE = &H0 Then write_SPARE_value = get_SPARE
        If flag_SOF_SLOW = &H0 Then write_SOF_SLOW_value = get_SOF_SLOW
        If flag_SOF_FAST = &H0 Then write_SOF_FAST_value = get_SOF_FAST

        regValue = leftShift((write_SPARE_value and &H3fff), 2) + leftShift((write_SOF_SLOW_value and &H1), 1) + leftShift((write_SOF_FAST_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_SPARE_value = rightShift(data_low, 2) and &H3fff
        read_SOF_SLOW_value = rightShift(data_low, 1) and &H1
        SOF_FAST_mask = &H1
        if data_low > LONG_MAX then
            if SOF_FAST_mask = mask then
                read_SOF_FAST_value = data_low
            else
                read_SOF_FAST_value = (data_low - H8000_0000) and SOF_FAST_mask
            end If
        else
            read_SOF_FAST_value = data_low and SOF_FAST_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SPARE_value = &H0
        flag_SPARE        = &H0
        write_SOF_SLOW_value = &H0
        flag_SOF_SLOW        = &H0
        write_SOF_FAST_value = &H0
        flag_SOF_FAST        = &H0
    End Sub
End Class


'' @REGISTER : FEC_ebc_accum_lsb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' EBC_ACCUM_LSB                              [15:0]           get_EBC_ACCUM_LSB
''                                                             set_EBC_ACCUM_LSB
''                                                             read_EBC_ACCUM_LSB
''                                                             write_EBC_ACCUM_LSB
''---------------------------------------------------------------------------------
Class REGISTER_FEC_ebc_accum_lsb
    Private write_EBC_ACCUM_LSB_value
    Private read_EBC_ACCUM_LSB_value
    Private flag_EBC_ACCUM_LSB

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

    Property Get get_EBC_ACCUM_LSB
        get_EBC_ACCUM_LSB = read_EBC_ACCUM_LSB_value
    End Property

    Property Let set_EBC_ACCUM_LSB(aData)
        write_EBC_ACCUM_LSB_value = aData
        flag_EBC_ACCUM_LSB        = &H1
    End Property

    Property Get read_EBC_ACCUM_LSB
        read
        read_EBC_ACCUM_LSB = read_EBC_ACCUM_LSB_value
    End Property

    Property Let write_EBC_ACCUM_LSB(aData)
        set_EBC_ACCUM_LSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        EBC_ACCUM_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if EBC_ACCUM_LSB_mask = mask then
                read_EBC_ACCUM_LSB_value = data_low
            else
                read_EBC_ACCUM_LSB_value = (data_low - H8000_0000) and EBC_ACCUM_LSB_mask
            end If
        else
            read_EBC_ACCUM_LSB_value = data_low and EBC_ACCUM_LSB_mask
        end If

    End Sub

    Sub write
        If flag_EBC_ACCUM_LSB = &H0 Then read
        If flag_EBC_ACCUM_LSB = &H0 Then write_EBC_ACCUM_LSB_value = get_EBC_ACCUM_LSB

        regValue = leftShift((write_EBC_ACCUM_LSB_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        EBC_ACCUM_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if EBC_ACCUM_LSB_mask = mask then
                read_EBC_ACCUM_LSB_value = data_low
            else
                read_EBC_ACCUM_LSB_value = (data_low - H8000_0000) and EBC_ACCUM_LSB_mask
            end If
        else
            read_EBC_ACCUM_LSB_value = data_low and EBC_ACCUM_LSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_EBC_ACCUM_LSB_value = &H0
        flag_EBC_ACCUM_LSB        = &H0
    End Sub
End Class


'' @REGISTER : FEC_ebc_accum_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' EBC_ACCUM_MSB                              [15:0]           get_EBC_ACCUM_MSB
''                                                             set_EBC_ACCUM_MSB
''                                                             read_EBC_ACCUM_MSB
''                                                             write_EBC_ACCUM_MSB
''---------------------------------------------------------------------------------
Class REGISTER_FEC_ebc_accum_msb
    Private write_EBC_ACCUM_MSB_value
    Private read_EBC_ACCUM_MSB_value
    Private flag_EBC_ACCUM_MSB

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

    Property Get get_EBC_ACCUM_MSB
        get_EBC_ACCUM_MSB = read_EBC_ACCUM_MSB_value
    End Property

    Property Let set_EBC_ACCUM_MSB(aData)
        write_EBC_ACCUM_MSB_value = aData
        flag_EBC_ACCUM_MSB        = &H1
    End Property

    Property Get read_EBC_ACCUM_MSB
        read
        read_EBC_ACCUM_MSB = read_EBC_ACCUM_MSB_value
    End Property

    Property Let write_EBC_ACCUM_MSB(aData)
        set_EBC_ACCUM_MSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        EBC_ACCUM_MSB_mask = &Hffff
        if data_low > LONG_MAX then
            if EBC_ACCUM_MSB_mask = mask then
                read_EBC_ACCUM_MSB_value = data_low
            else
                read_EBC_ACCUM_MSB_value = (data_low - H8000_0000) and EBC_ACCUM_MSB_mask
            end If
        else
            read_EBC_ACCUM_MSB_value = data_low and EBC_ACCUM_MSB_mask
        end If

    End Sub

    Sub write
        If flag_EBC_ACCUM_MSB = &H0 Then read
        If flag_EBC_ACCUM_MSB = &H0 Then write_EBC_ACCUM_MSB_value = get_EBC_ACCUM_MSB

        regValue = leftShift((write_EBC_ACCUM_MSB_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        EBC_ACCUM_MSB_mask = &Hffff
        if data_low > LONG_MAX then
            if EBC_ACCUM_MSB_mask = mask then
                read_EBC_ACCUM_MSB_value = data_low
            else
                read_EBC_ACCUM_MSB_value = (data_low - H8000_0000) and EBC_ACCUM_MSB_mask
            end If
        else
            read_EBC_ACCUM_MSB_value = data_low and EBC_ACCUM_MSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_EBC_ACCUM_MSB_value = &H0
        flag_EBC_ACCUM_MSB        = &H0
    End Sub
End Class


'' @REGISTER : FEC_ebc_accum_lrg_lsb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' EBC_ACCUM_LRG_LSB                          [15:0]           get_EBC_ACCUM_LRG_LSB
''                                                             set_EBC_ACCUM_LRG_LSB
''                                                             read_EBC_ACCUM_LRG_LSB
''                                                             write_EBC_ACCUM_LRG_LSB
''---------------------------------------------------------------------------------
Class REGISTER_FEC_ebc_accum_lrg_lsb
    Private write_EBC_ACCUM_LRG_LSB_value
    Private read_EBC_ACCUM_LRG_LSB_value
    Private flag_EBC_ACCUM_LRG_LSB

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

    Property Get get_EBC_ACCUM_LRG_LSB
        get_EBC_ACCUM_LRG_LSB = read_EBC_ACCUM_LRG_LSB_value
    End Property

    Property Let set_EBC_ACCUM_LRG_LSB(aData)
        write_EBC_ACCUM_LRG_LSB_value = aData
        flag_EBC_ACCUM_LRG_LSB        = &H1
    End Property

    Property Get read_EBC_ACCUM_LRG_LSB
        read
        read_EBC_ACCUM_LRG_LSB = read_EBC_ACCUM_LRG_LSB_value
    End Property

    Property Let write_EBC_ACCUM_LRG_LSB(aData)
        set_EBC_ACCUM_LRG_LSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        EBC_ACCUM_LRG_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if EBC_ACCUM_LRG_LSB_mask = mask then
                read_EBC_ACCUM_LRG_LSB_value = data_low
            else
                read_EBC_ACCUM_LRG_LSB_value = (data_low - H8000_0000) and EBC_ACCUM_LRG_LSB_mask
            end If
        else
            read_EBC_ACCUM_LRG_LSB_value = data_low and EBC_ACCUM_LRG_LSB_mask
        end If

    End Sub

    Sub write
        If flag_EBC_ACCUM_LRG_LSB = &H0 Then read
        If flag_EBC_ACCUM_LRG_LSB = &H0 Then write_EBC_ACCUM_LRG_LSB_value = get_EBC_ACCUM_LRG_LSB

        regValue = leftShift((write_EBC_ACCUM_LRG_LSB_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        EBC_ACCUM_LRG_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if EBC_ACCUM_LRG_LSB_mask = mask then
                read_EBC_ACCUM_LRG_LSB_value = data_low
            else
                read_EBC_ACCUM_LRG_LSB_value = (data_low - H8000_0000) and EBC_ACCUM_LRG_LSB_mask
            end If
        else
            read_EBC_ACCUM_LRG_LSB_value = data_low and EBC_ACCUM_LRG_LSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_EBC_ACCUM_LRG_LSB_value = &H0
        flag_EBC_ACCUM_LRG_LSB        = &H0
    End Sub
End Class


'' @REGISTER : FEC_ebc_accum_lrg_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' EBC_ACCUM_LRG_MSB                          [15:0]           get_EBC_ACCUM_LRG_MSB
''                                                             set_EBC_ACCUM_LRG_MSB
''                                                             read_EBC_ACCUM_LRG_MSB
''                                                             write_EBC_ACCUM_LRG_MSB
''---------------------------------------------------------------------------------
Class REGISTER_FEC_ebc_accum_lrg_msb
    Private write_EBC_ACCUM_LRG_MSB_value
    Private read_EBC_ACCUM_LRG_MSB_value
    Private flag_EBC_ACCUM_LRG_MSB

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

    Property Get get_EBC_ACCUM_LRG_MSB
        get_EBC_ACCUM_LRG_MSB = read_EBC_ACCUM_LRG_MSB_value
    End Property

    Property Let set_EBC_ACCUM_LRG_MSB(aData)
        write_EBC_ACCUM_LRG_MSB_value = aData
        flag_EBC_ACCUM_LRG_MSB        = &H1
    End Property

    Property Get read_EBC_ACCUM_LRG_MSB
        read
        read_EBC_ACCUM_LRG_MSB = read_EBC_ACCUM_LRG_MSB_value
    End Property

    Property Let write_EBC_ACCUM_LRG_MSB(aData)
        set_EBC_ACCUM_LRG_MSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        EBC_ACCUM_LRG_MSB_mask = &Hffff
        if data_low > LONG_MAX then
            if EBC_ACCUM_LRG_MSB_mask = mask then
                read_EBC_ACCUM_LRG_MSB_value = data_low
            else
                read_EBC_ACCUM_LRG_MSB_value = (data_low - H8000_0000) and EBC_ACCUM_LRG_MSB_mask
            end If
        else
            read_EBC_ACCUM_LRG_MSB_value = data_low and EBC_ACCUM_LRG_MSB_mask
        end If

    End Sub

    Sub write
        If flag_EBC_ACCUM_LRG_MSB = &H0 Then read
        If flag_EBC_ACCUM_LRG_MSB = &H0 Then write_EBC_ACCUM_LRG_MSB_value = get_EBC_ACCUM_LRG_MSB

        regValue = leftShift((write_EBC_ACCUM_LRG_MSB_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        EBC_ACCUM_LRG_MSB_mask = &Hffff
        if data_low > LONG_MAX then
            if EBC_ACCUM_LRG_MSB_mask = mask then
                read_EBC_ACCUM_LRG_MSB_value = data_low
            else
                read_EBC_ACCUM_LRG_MSB_value = (data_low - H8000_0000) and EBC_ACCUM_LRG_MSB_mask
            end If
        else
            read_EBC_ACCUM_LRG_MSB_value = data_low and EBC_ACCUM_LRG_MSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_EBC_ACCUM_LRG_MSB_value = &H0
        flag_EBC_ACCUM_LRG_MSB        = &H0
    End Sub
End Class


'' @REGISTER : FEC_config_en
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SPARE_H                                    [15:10]          get_SPARE_H
''                                                             set_SPARE_H
''                                                             read_SPARE_H
''                                                             write_SPARE_H
''---------------------------------------------------------------------------------
'' EDC_CORR_EN                                [9:9]            get_EDC_CORR_EN
''                                                             set_EDC_CORR_EN
''                                                             read_EDC_CORR_EN
''                                                             write_EDC_CORR_EN
''---------------------------------------------------------------------------------
'' OTF_EN                                     [8:8]            get_OTF_EN
''                                                             set_OTF_EN
''                                                             read_OTF_EN
''                                                             write_OTF_EN
''---------------------------------------------------------------------------------
'' CHIEN_EN                                   [7:7]            get_CHIEN_EN
''                                                             set_CHIEN_EN
''                                                             read_CHIEN_EN
''                                                             write_CHIEN_EN
''---------------------------------------------------------------------------------
'' SPARE_L                                    [6:4]            get_SPARE_L
''                                                             set_SPARE_L
''                                                             read_SPARE_L
''                                                             write_SPARE_L
''---------------------------------------------------------------------------------
'' OTF_INIT_EN                                [3:3]            get_OTF_INIT_EN
''                                                             set_OTF_INIT_EN
''                                                             read_OTF_INIT_EN
''                                                             write_OTF_INIT_EN
''---------------------------------------------------------------------------------
'' ECC_CORR_EN                                [2:2]            get_ECC_CORR_EN
''                                                             set_ECC_CORR_EN
''                                                             read_ECC_CORR_EN
''                                                             write_ECC_CORR_EN
''---------------------------------------------------------------------------------
'' RED_CORR_EN                                [1:1]            get_RED_CORR_EN
''                                                             set_RED_CORR_EN
''                                                             read_RED_CORR_EN
''                                                             write_RED_CORR_EN
''---------------------------------------------------------------------------------
'' DATA_CORR_EN                               [0:0]            get_DATA_CORR_EN
''                                                             set_DATA_CORR_EN
''                                                             read_DATA_CORR_EN
''                                                             write_DATA_CORR_EN
''---------------------------------------------------------------------------------
Class REGISTER_FEC_config_en
    Private write_SPARE_H_value
    Private read_SPARE_H_value
    Private flag_SPARE_H
    Private write_EDC_CORR_EN_value
    Private read_EDC_CORR_EN_value
    Private flag_EDC_CORR_EN
    Private write_OTF_EN_value
    Private read_OTF_EN_value
    Private flag_OTF_EN
    Private write_CHIEN_EN_value
    Private read_CHIEN_EN_value
    Private flag_CHIEN_EN
    Private write_SPARE_L_value
    Private read_SPARE_L_value
    Private flag_SPARE_L
    Private write_OTF_INIT_EN_value
    Private read_OTF_INIT_EN_value
    Private flag_OTF_INIT_EN
    Private write_ECC_CORR_EN_value
    Private read_ECC_CORR_EN_value
    Private flag_ECC_CORR_EN
    Private write_RED_CORR_EN_value
    Private read_RED_CORR_EN_value
    Private flag_RED_CORR_EN
    Private write_DATA_CORR_EN_value
    Private read_DATA_CORR_EN_value
    Private flag_DATA_CORR_EN

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

    Property Get get_SPARE_H
        get_SPARE_H = read_SPARE_H_value
    End Property

    Property Let set_SPARE_H(aData)
        write_SPARE_H_value = aData
        flag_SPARE_H        = &H1
    End Property

    Property Get read_SPARE_H
        read
        read_SPARE_H = read_SPARE_H_value
    End Property

    Property Let write_SPARE_H(aData)
        set_SPARE_H = aData
        write
    End Property

    Property Get get_EDC_CORR_EN
        get_EDC_CORR_EN = read_EDC_CORR_EN_value
    End Property

    Property Let set_EDC_CORR_EN(aData)
        write_EDC_CORR_EN_value = aData
        flag_EDC_CORR_EN        = &H1
    End Property

    Property Get read_EDC_CORR_EN
        read
        read_EDC_CORR_EN = read_EDC_CORR_EN_value
    End Property

    Property Let write_EDC_CORR_EN(aData)
        set_EDC_CORR_EN = aData
        write
    End Property

    Property Get get_OTF_EN
        get_OTF_EN = read_OTF_EN_value
    End Property

    Property Let set_OTF_EN(aData)
        write_OTF_EN_value = aData
        flag_OTF_EN        = &H1
    End Property

    Property Get read_OTF_EN
        read
        read_OTF_EN = read_OTF_EN_value
    End Property

    Property Let write_OTF_EN(aData)
        set_OTF_EN = aData
        write
    End Property

    Property Get get_CHIEN_EN
        get_CHIEN_EN = read_CHIEN_EN_value
    End Property

    Property Let set_CHIEN_EN(aData)
        write_CHIEN_EN_value = aData
        flag_CHIEN_EN        = &H1
    End Property

    Property Get read_CHIEN_EN
        read
        read_CHIEN_EN = read_CHIEN_EN_value
    End Property

    Property Let write_CHIEN_EN(aData)
        set_CHIEN_EN = aData
        write
    End Property

    Property Get get_SPARE_L
        get_SPARE_L = read_SPARE_L_value
    End Property

    Property Let set_SPARE_L(aData)
        write_SPARE_L_value = aData
        flag_SPARE_L        = &H1
    End Property

    Property Get read_SPARE_L
        read
        read_SPARE_L = read_SPARE_L_value
    End Property

    Property Let write_SPARE_L(aData)
        set_SPARE_L = aData
        write
    End Property

    Property Get get_OTF_INIT_EN
        get_OTF_INIT_EN = read_OTF_INIT_EN_value
    End Property

    Property Let set_OTF_INIT_EN(aData)
        write_OTF_INIT_EN_value = aData
        flag_OTF_INIT_EN        = &H1
    End Property

    Property Get read_OTF_INIT_EN
        read
        read_OTF_INIT_EN = read_OTF_INIT_EN_value
    End Property

    Property Let write_OTF_INIT_EN(aData)
        set_OTF_INIT_EN = aData
        write
    End Property

    Property Get get_ECC_CORR_EN
        get_ECC_CORR_EN = read_ECC_CORR_EN_value
    End Property

    Property Let set_ECC_CORR_EN(aData)
        write_ECC_CORR_EN_value = aData
        flag_ECC_CORR_EN        = &H1
    End Property

    Property Get read_ECC_CORR_EN
        read
        read_ECC_CORR_EN = read_ECC_CORR_EN_value
    End Property

    Property Let write_ECC_CORR_EN(aData)
        set_ECC_CORR_EN = aData
        write
    End Property

    Property Get get_RED_CORR_EN
        get_RED_CORR_EN = read_RED_CORR_EN_value
    End Property

    Property Let set_RED_CORR_EN(aData)
        write_RED_CORR_EN_value = aData
        flag_RED_CORR_EN        = &H1
    End Property

    Property Get read_RED_CORR_EN
        read
        read_RED_CORR_EN = read_RED_CORR_EN_value
    End Property

    Property Let write_RED_CORR_EN(aData)
        set_RED_CORR_EN = aData
        write
    End Property

    Property Get get_DATA_CORR_EN
        get_DATA_CORR_EN = read_DATA_CORR_EN_value
    End Property

    Property Let set_DATA_CORR_EN(aData)
        write_DATA_CORR_EN_value = aData
        flag_DATA_CORR_EN        = &H1
    End Property

    Property Get read_DATA_CORR_EN
        read
        read_DATA_CORR_EN = read_DATA_CORR_EN_value
    End Property

    Property Let write_DATA_CORR_EN(aData)
        set_DATA_CORR_EN = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_SPARE_H_value = rightShift(data_low, 10) and &H3f
        read_EDC_CORR_EN_value = rightShift(data_low, 9) and &H1
        read_OTF_EN_value = rightShift(data_low, 8) and &H1
        read_CHIEN_EN_value = rightShift(data_low, 7) and &H1
        read_SPARE_L_value = rightShift(data_low, 4) and &H7
        read_OTF_INIT_EN_value = rightShift(data_low, 3) and &H1
        read_ECC_CORR_EN_value = rightShift(data_low, 2) and &H1
        read_RED_CORR_EN_value = rightShift(data_low, 1) and &H1
        DATA_CORR_EN_mask = &H1
        if data_low > LONG_MAX then
            if DATA_CORR_EN_mask = mask then
                read_DATA_CORR_EN_value = data_low
            else
                read_DATA_CORR_EN_value = (data_low - H8000_0000) and DATA_CORR_EN_mask
            end If
        else
            read_DATA_CORR_EN_value = data_low and DATA_CORR_EN_mask
        end If

    End Sub

    Sub write
        If flag_SPARE_H = &H0 or flag_EDC_CORR_EN = &H0 or flag_OTF_EN = &H0 or flag_CHIEN_EN = &H0 or flag_SPARE_L = &H0 or flag_OTF_INIT_EN = &H0 or flag_ECC_CORR_EN = &H0 or flag_RED_CORR_EN = &H0 or flag_DATA_CORR_EN = &H0 Then read
        If flag_SPARE_H = &H0 Then write_SPARE_H_value = get_SPARE_H
        If flag_EDC_CORR_EN = &H0 Then write_EDC_CORR_EN_value = get_EDC_CORR_EN
        If flag_OTF_EN = &H0 Then write_OTF_EN_value = get_OTF_EN
        If flag_CHIEN_EN = &H0 Then write_CHIEN_EN_value = get_CHIEN_EN
        If flag_SPARE_L = &H0 Then write_SPARE_L_value = get_SPARE_L
        If flag_OTF_INIT_EN = &H0 Then write_OTF_INIT_EN_value = get_OTF_INIT_EN
        If flag_ECC_CORR_EN = &H0 Then write_ECC_CORR_EN_value = get_ECC_CORR_EN
        If flag_RED_CORR_EN = &H0 Then write_RED_CORR_EN_value = get_RED_CORR_EN
        If flag_DATA_CORR_EN = &H0 Then write_DATA_CORR_EN_value = get_DATA_CORR_EN

        regValue = leftShift((write_SPARE_H_value and &H3f), 10) + leftShift((write_EDC_CORR_EN_value and &H1), 9) + leftShift((write_OTF_EN_value and &H1), 8) + leftShift((write_CHIEN_EN_value and &H1), 7) + leftShift((write_SPARE_L_value and &H7), 4) + leftShift((write_OTF_INIT_EN_value and &H1), 3) + leftShift((write_ECC_CORR_EN_value and &H1), 2) + leftShift((write_RED_CORR_EN_value and &H1), 1) + leftShift((write_DATA_CORR_EN_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_SPARE_H_value = rightShift(data_low, 10) and &H3f
        read_EDC_CORR_EN_value = rightShift(data_low, 9) and &H1
        read_OTF_EN_value = rightShift(data_low, 8) and &H1
        read_CHIEN_EN_value = rightShift(data_low, 7) and &H1
        read_SPARE_L_value = rightShift(data_low, 4) and &H7
        read_OTF_INIT_EN_value = rightShift(data_low, 3) and &H1
        read_ECC_CORR_EN_value = rightShift(data_low, 2) and &H1
        read_RED_CORR_EN_value = rightShift(data_low, 1) and &H1
        DATA_CORR_EN_mask = &H1
        if data_low > LONG_MAX then
            if DATA_CORR_EN_mask = mask then
                read_DATA_CORR_EN_value = data_low
            else
                read_DATA_CORR_EN_value = (data_low - H8000_0000) and DATA_CORR_EN_mask
            end If
        else
            read_DATA_CORR_EN_value = data_low and DATA_CORR_EN_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SPARE_H_value = &H0
        flag_SPARE_H        = &H0
        write_EDC_CORR_EN_value = &H0
        flag_EDC_CORR_EN        = &H0
        write_OTF_EN_value = &H0
        flag_OTF_EN        = &H0
        write_CHIEN_EN_value = &H0
        flag_CHIEN_EN        = &H0
        write_SPARE_L_value = &H0
        flag_SPARE_L        = &H0
        write_OTF_INIT_EN_value = &H0
        flag_OTF_INIT_EN        = &H0
        write_ECC_CORR_EN_value = &H0
        flag_ECC_CORR_EN        = &H0
        write_RED_CORR_EN_value = &H0
        flag_RED_CORR_EN        = &H0
        write_DATA_CORR_EN_value = &H0
        flag_DATA_CORR_EN        = &H0
    End Sub
End Class


'' @REGISTER : FEC_dec_fifo_sram_ctrl0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SPARE                                      [15:13]          get_SPARE
''                                                             set_SPARE
''                                                             read_SPARE
''                                                             write_SPARE
''---------------------------------------------------------------------------------
'' PDA                                        [12:12]          get_PDA
''                                                             set_PDA
''                                                             read_PDA
''                                                             write_PDA
''---------------------------------------------------------------------------------
'' OVSTB                                      [11:11]          get_OVSTB
''                                                             set_OVSTB
''                                                             read_OVSTB
''                                                             write_OVSTB
''---------------------------------------------------------------------------------
'' ISO                                        [10:10]          get_ISO
''                                                             set_ISO
''                                                             read_ISO
''                                                             write_ISO
''---------------------------------------------------------------------------------
'' POWEROKIN                                  [9:9]            get_POWEROKIN
''                                                             set_POWEROKIN
''                                                             read_POWEROKIN
''                                                             write_POWEROKIN
''---------------------------------------------------------------------------------
'' POWERONIN                                  [8:8]            get_POWERONIN
''                                                             set_POWERONIN
''                                                             read_POWERONIN
''                                                             write_POWERONIN
''---------------------------------------------------------------------------------
'' ECC_MODE                                   [7:7]            get_ECC_MODE
''                                                             set_ECC_MODE
''                                                             read_ECC_MODE
''                                                             write_ECC_MODE
''---------------------------------------------------------------------------------
'' TM                                         [6:0]            get_TM
''                                                             set_TM
''                                                             read_TM
''                                                             write_TM
''---------------------------------------------------------------------------------
Class REGISTER_FEC_dec_fifo_sram_ctrl0
    Private write_SPARE_value
    Private read_SPARE_value
    Private flag_SPARE
    Private write_PDA_value
    Private read_PDA_value
    Private flag_PDA
    Private write_OVSTB_value
    Private read_OVSTB_value
    Private flag_OVSTB
    Private write_ISO_value
    Private read_ISO_value
    Private flag_ISO
    Private write_POWEROKIN_value
    Private read_POWEROKIN_value
    Private flag_POWEROKIN
    Private write_POWERONIN_value
    Private read_POWERONIN_value
    Private flag_POWERONIN
    Private write_ECC_MODE_value
    Private read_ECC_MODE_value
    Private flag_ECC_MODE
    Private write_TM_value
    Private read_TM_value
    Private flag_TM

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

    Property Get get_SPARE
        get_SPARE = read_SPARE_value
    End Property

    Property Let set_SPARE(aData)
        write_SPARE_value = aData
        flag_SPARE        = &H1
    End Property

    Property Get read_SPARE
        read
        read_SPARE = read_SPARE_value
    End Property

    Property Let write_SPARE(aData)
        set_SPARE = aData
        write
    End Property

    Property Get get_PDA
        get_PDA = read_PDA_value
    End Property

    Property Let set_PDA(aData)
        write_PDA_value = aData
        flag_PDA        = &H1
    End Property

    Property Get read_PDA
        read
        read_PDA = read_PDA_value
    End Property

    Property Let write_PDA(aData)
        set_PDA = aData
        write
    End Property

    Property Get get_OVSTB
        get_OVSTB = read_OVSTB_value
    End Property

    Property Let set_OVSTB(aData)
        write_OVSTB_value = aData
        flag_OVSTB        = &H1
    End Property

    Property Get read_OVSTB
        read
        read_OVSTB = read_OVSTB_value
    End Property

    Property Let write_OVSTB(aData)
        set_OVSTB = aData
        write
    End Property

    Property Get get_ISO
        get_ISO = read_ISO_value
    End Property

    Property Let set_ISO(aData)
        write_ISO_value = aData
        flag_ISO        = &H1
    End Property

    Property Get read_ISO
        read
        read_ISO = read_ISO_value
    End Property

    Property Let write_ISO(aData)
        set_ISO = aData
        write
    End Property

    Property Get get_POWEROKIN
        get_POWEROKIN = read_POWEROKIN_value
    End Property

    Property Let set_POWEROKIN(aData)
        write_POWEROKIN_value = aData
        flag_POWEROKIN        = &H1
    End Property

    Property Get read_POWEROKIN
        read
        read_POWEROKIN = read_POWEROKIN_value
    End Property

    Property Let write_POWEROKIN(aData)
        set_POWEROKIN = aData
        write
    End Property

    Property Get get_POWERONIN
        get_POWERONIN = read_POWERONIN_value
    End Property

    Property Let set_POWERONIN(aData)
        write_POWERONIN_value = aData
        flag_POWERONIN        = &H1
    End Property

    Property Get read_POWERONIN
        read
        read_POWERONIN = read_POWERONIN_value
    End Property

    Property Let write_POWERONIN(aData)
        set_POWERONIN = aData
        write
    End Property

    Property Get get_ECC_MODE
        get_ECC_MODE = read_ECC_MODE_value
    End Property

    Property Let set_ECC_MODE(aData)
        write_ECC_MODE_value = aData
        flag_ECC_MODE        = &H1
    End Property

    Property Get read_ECC_MODE
        read
        read_ECC_MODE = read_ECC_MODE_value
    End Property

    Property Let write_ECC_MODE(aData)
        set_ECC_MODE = aData
        write
    End Property

    Property Get get_TM
        get_TM = read_TM_value
    End Property

    Property Let set_TM(aData)
        write_TM_value = aData
        flag_TM        = &H1
    End Property

    Property Get read_TM
        read
        read_TM = read_TM_value
    End Property

    Property Let write_TM(aData)
        set_TM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_SPARE_value = rightShift(data_low, 13) and &H7
        read_PDA_value = rightShift(data_low, 12) and &H1
        read_OVSTB_value = rightShift(data_low, 11) and &H1
        read_ISO_value = rightShift(data_low, 10) and &H1
        read_POWEROKIN_value = rightShift(data_low, 9) and &H1
        read_POWERONIN_value = rightShift(data_low, 8) and &H1
        read_ECC_MODE_value = rightShift(data_low, 7) and &H1
        TM_mask = &H7f
        if data_low > LONG_MAX then
            if TM_mask = mask then
                read_TM_value = data_low
            else
                read_TM_value = (data_low - H8000_0000) and TM_mask
            end If
        else
            read_TM_value = data_low and TM_mask
        end If

    End Sub

    Sub write
        If flag_SPARE = &H0 or flag_PDA = &H0 or flag_OVSTB = &H0 or flag_ISO = &H0 or flag_POWEROKIN = &H0 or flag_POWERONIN = &H0 or flag_ECC_MODE = &H0 or flag_TM = &H0 Then read
        If flag_SPARE = &H0 Then write_SPARE_value = get_SPARE
        If flag_PDA = &H0 Then write_PDA_value = get_PDA
        If flag_OVSTB = &H0 Then write_OVSTB_value = get_OVSTB
        If flag_ISO = &H0 Then write_ISO_value = get_ISO
        If flag_POWEROKIN = &H0 Then write_POWEROKIN_value = get_POWEROKIN
        If flag_POWERONIN = &H0 Then write_POWERONIN_value = get_POWERONIN
        If flag_ECC_MODE = &H0 Then write_ECC_MODE_value = get_ECC_MODE
        If flag_TM = &H0 Then write_TM_value = get_TM

        regValue = leftShift((write_SPARE_value and &H7), 13) + leftShift((write_PDA_value and &H1), 12) + leftShift((write_OVSTB_value and &H1), 11) + leftShift((write_ISO_value and &H1), 10) + leftShift((write_POWEROKIN_value and &H1), 9) + leftShift((write_POWERONIN_value and &H1), 8) + leftShift((write_ECC_MODE_value and &H1), 7) + leftShift((write_TM_value and &H7f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_SPARE_value = rightShift(data_low, 13) and &H7
        read_PDA_value = rightShift(data_low, 12) and &H1
        read_OVSTB_value = rightShift(data_low, 11) and &H1
        read_ISO_value = rightShift(data_low, 10) and &H1
        read_POWEROKIN_value = rightShift(data_low, 9) and &H1
        read_POWERONIN_value = rightShift(data_low, 8) and &H1
        read_ECC_MODE_value = rightShift(data_low, 7) and &H1
        TM_mask = &H7f
        if data_low > LONG_MAX then
            if TM_mask = mask then
                read_TM_value = data_low
            else
                read_TM_value = (data_low - H8000_0000) and TM_mask
            end If
        else
            read_TM_value = data_low and TM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SPARE_value = &H0
        flag_SPARE        = &H0
        write_PDA_value = &H0
        flag_PDA        = &H0
        write_OVSTB_value = &H0
        flag_OVSTB        = &H0
        write_ISO_value = &H0
        flag_ISO        = &H0
        write_POWEROKIN_value = &H0
        flag_POWEROKIN        = &H0
        write_POWERONIN_value = &H0
        flag_POWERONIN        = &H0
        write_ECC_MODE_value = &H0
        flag_ECC_MODE        = &H0
        write_TM_value = &H0
        flag_TM        = &H0
    End Sub
End Class


'' @REGISTER : FEC_dec_fifo_sram_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SPARE                                      [15:4]           get_SPARE
''                                                             set_SPARE
''                                                             read_SPARE
''                                                             write_SPARE
''---------------------------------------------------------------------------------
'' DED_FLAG                                   [3:3]            get_DED_FLAG
''                                                             set_DED_FLAG
''                                                             read_DED_FLAG
''                                                             write_DED_FLAG
''---------------------------------------------------------------------------------
'' SEC_FLAG                                   [2:2]            get_SEC_FLAG
''                                                             set_SEC_FLAG
''                                                             read_SEC_FLAG
''                                                             write_SEC_FLAG
''---------------------------------------------------------------------------------
'' POWEROKOUT                                 [1:1]            get_POWEROKOUT
''                                                             set_POWEROKOUT
''                                                             read_POWEROKOUT
''                                                             write_POWEROKOUT
''---------------------------------------------------------------------------------
'' POWERONOUT                                 [0:0]            get_POWERONOUT
''                                                             set_POWERONOUT
''                                                             read_POWERONOUT
''                                                             write_POWERONOUT
''---------------------------------------------------------------------------------
Class REGISTER_FEC_dec_fifo_sram_status
    Private write_SPARE_value
    Private read_SPARE_value
    Private flag_SPARE
    Private write_DED_FLAG_value
    Private read_DED_FLAG_value
    Private flag_DED_FLAG
    Private write_SEC_FLAG_value
    Private read_SEC_FLAG_value
    Private flag_SEC_FLAG
    Private write_POWEROKOUT_value
    Private read_POWEROKOUT_value
    Private flag_POWEROKOUT
    Private write_POWERONOUT_value
    Private read_POWERONOUT_value
    Private flag_POWERONOUT

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

    Property Get get_SPARE
        get_SPARE = read_SPARE_value
    End Property

    Property Let set_SPARE(aData)
        write_SPARE_value = aData
        flag_SPARE        = &H1
    End Property

    Property Get read_SPARE
        read
        read_SPARE = read_SPARE_value
    End Property

    Property Let write_SPARE(aData)
        set_SPARE = aData
        write
    End Property

    Property Get get_DED_FLAG
        get_DED_FLAG = read_DED_FLAG_value
    End Property

    Property Let set_DED_FLAG(aData)
        write_DED_FLAG_value = aData
        flag_DED_FLAG        = &H1
    End Property

    Property Get read_DED_FLAG
        read
        read_DED_FLAG = read_DED_FLAG_value
    End Property

    Property Let write_DED_FLAG(aData)
        set_DED_FLAG = aData
        write
    End Property

    Property Get get_SEC_FLAG
        get_SEC_FLAG = read_SEC_FLAG_value
    End Property

    Property Let set_SEC_FLAG(aData)
        write_SEC_FLAG_value = aData
        flag_SEC_FLAG        = &H1
    End Property

    Property Get read_SEC_FLAG
        read
        read_SEC_FLAG = read_SEC_FLAG_value
    End Property

    Property Let write_SEC_FLAG(aData)
        set_SEC_FLAG = aData
        write
    End Property

    Property Get get_POWEROKOUT
        get_POWEROKOUT = read_POWEROKOUT_value
    End Property

    Property Let set_POWEROKOUT(aData)
        write_POWEROKOUT_value = aData
        flag_POWEROKOUT        = &H1
    End Property

    Property Get read_POWEROKOUT
        read
        read_POWEROKOUT = read_POWEROKOUT_value
    End Property

    Property Let write_POWEROKOUT(aData)
        set_POWEROKOUT = aData
        write
    End Property

    Property Get get_POWERONOUT
        get_POWERONOUT = read_POWERONOUT_value
    End Property

    Property Let set_POWERONOUT(aData)
        write_POWERONOUT_value = aData
        flag_POWERONOUT        = &H1
    End Property

    Property Get read_POWERONOUT
        read
        read_POWERONOUT = read_POWERONOUT_value
    End Property

    Property Let write_POWERONOUT(aData)
        set_POWERONOUT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_SPARE_value = rightShift(data_low, 4) and &Hfff
        read_DED_FLAG_value = rightShift(data_low, 3) and &H1
        read_SEC_FLAG_value = rightShift(data_low, 2) and &H1
        read_POWEROKOUT_value = rightShift(data_low, 1) and &H1
        POWERONOUT_mask = &H1
        if data_low > LONG_MAX then
            if POWERONOUT_mask = mask then
                read_POWERONOUT_value = data_low
            else
                read_POWERONOUT_value = (data_low - H8000_0000) and POWERONOUT_mask
            end If
        else
            read_POWERONOUT_value = data_low and POWERONOUT_mask
        end If

    End Sub

    Sub write
        If flag_SPARE = &H0 or flag_DED_FLAG = &H0 or flag_SEC_FLAG = &H0 or flag_POWEROKOUT = &H0 or flag_POWERONOUT = &H0 Then read
        If flag_SPARE = &H0 Then write_SPARE_value = get_SPARE
        If flag_DED_FLAG = &H0 Then write_DED_FLAG_value = get_DED_FLAG
        If flag_SEC_FLAG = &H0 Then write_SEC_FLAG_value = get_SEC_FLAG
        If flag_POWEROKOUT = &H0 Then write_POWEROKOUT_value = get_POWEROKOUT
        If flag_POWERONOUT = &H0 Then write_POWERONOUT_value = get_POWERONOUT

        regValue = leftShift((write_SPARE_value and &Hfff), 4) + leftShift((write_DED_FLAG_value and &H1), 3) + leftShift((write_SEC_FLAG_value and &H1), 2) + leftShift((write_POWEROKOUT_value and &H1), 1) + leftShift((write_POWERONOUT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_SPARE_value = rightShift(data_low, 4) and &Hfff
        read_DED_FLAG_value = rightShift(data_low, 3) and &H1
        read_SEC_FLAG_value = rightShift(data_low, 2) and &H1
        read_POWEROKOUT_value = rightShift(data_low, 1) and &H1
        POWERONOUT_mask = &H1
        if data_low > LONG_MAX then
            if POWERONOUT_mask = mask then
                read_POWERONOUT_value = data_low
            else
                read_POWERONOUT_value = (data_low - H8000_0000) and POWERONOUT_mask
            end If
        else
            read_POWERONOUT_value = data_low and POWERONOUT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SPARE_value = &H0
        flag_SPARE        = &H0
        write_DED_FLAG_value = &H0
        flag_DED_FLAG        = &H0
        write_SEC_FLAG_value = &H0
        flag_SEC_FLAG        = &H0
        write_POWEROKOUT_value = &H0
        flag_POWEROKOUT        = &H0
        write_POWERONOUT_value = &H0
        flag_POWERONOUT        = &H0
    End Sub
End Class


'' @REGISTER : FEC_crct_sym_reg
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CRCT_SYM_REG                               [15:0]           get_CRCT_SYM_REG
''                                                             set_CRCT_SYM_REG
''                                                             read_CRCT_SYM_REG
''                                                             write_CRCT_SYM_REG
''---------------------------------------------------------------------------------
Class REGISTER_FEC_crct_sym_reg
    Private write_CRCT_SYM_REG_value
    Private read_CRCT_SYM_REG_value
    Private flag_CRCT_SYM_REG

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H22
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_CRCT_SYM_REG
        get_CRCT_SYM_REG = read_CRCT_SYM_REG_value
    End Property

    Property Let set_CRCT_SYM_REG(aData)
        write_CRCT_SYM_REG_value = aData
        flag_CRCT_SYM_REG        = &H1
    End Property

    Property Get read_CRCT_SYM_REG
        read
        read_CRCT_SYM_REG = read_CRCT_SYM_REG_value
    End Property

    Property Let write_CRCT_SYM_REG(aData)
        set_CRCT_SYM_REG = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CRCT_SYM_REG_mask = &Hffff
        if data_low > LONG_MAX then
            if CRCT_SYM_REG_mask = mask then
                read_CRCT_SYM_REG_value = data_low
            else
                read_CRCT_SYM_REG_value = (data_low - H8000_0000) and CRCT_SYM_REG_mask
            end If
        else
            read_CRCT_SYM_REG_value = data_low and CRCT_SYM_REG_mask
        end If

    End Sub

    Sub write
        If flag_CRCT_SYM_REG = &H0 Then read
        If flag_CRCT_SYM_REG = &H0 Then write_CRCT_SYM_REG_value = get_CRCT_SYM_REG

        regValue = leftShift((write_CRCT_SYM_REG_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        CRCT_SYM_REG_mask = &Hffff
        if data_low > LONG_MAX then
            if CRCT_SYM_REG_mask = mask then
                read_CRCT_SYM_REG_value = data_low
            else
                read_CRCT_SYM_REG_value = (data_low - H8000_0000) and CRCT_SYM_REG_mask
            end If
        else
            read_CRCT_SYM_REG_value = data_low and CRCT_SYM_REG_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CRCT_SYM_REG_value = &H0
        flag_CRCT_SYM_REG        = &H0
    End Sub
End Class


'' @REGISTER : FEC_flb_err_reg
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' FLB_BLK_SIZE                               [15:10]          get_FLB_BLK_SIZE
''                                                             set_FLB_BLK_SIZE
''                                                             read_FLB_BLK_SIZE
''                                                             write_FLB_BLK_SIZE
''---------------------------------------------------------------------------------
'' FLB_ERR_REG                                [9:0]            get_FLB_ERR_REG
''                                                             set_FLB_ERR_REG
''                                                             read_FLB_ERR_REG
''                                                             write_FLB_ERR_REG
''---------------------------------------------------------------------------------
Class REGISTER_FEC_flb_err_reg
    Private write_FLB_BLK_SIZE_value
    Private read_FLB_BLK_SIZE_value
    Private flag_FLB_BLK_SIZE
    Private write_FLB_ERR_REG_value
    Private read_FLB_ERR_REG_value
    Private flag_FLB_ERR_REG

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

    Property Get get_FLB_BLK_SIZE
        get_FLB_BLK_SIZE = read_FLB_BLK_SIZE_value
    End Property

    Property Let set_FLB_BLK_SIZE(aData)
        write_FLB_BLK_SIZE_value = aData
        flag_FLB_BLK_SIZE        = &H1
    End Property

    Property Get read_FLB_BLK_SIZE
        read
        read_FLB_BLK_SIZE = read_FLB_BLK_SIZE_value
    End Property

    Property Let write_FLB_BLK_SIZE(aData)
        set_FLB_BLK_SIZE = aData
        write
    End Property

    Property Get get_FLB_ERR_REG
        get_FLB_ERR_REG = read_FLB_ERR_REG_value
    End Property

    Property Let set_FLB_ERR_REG(aData)
        write_FLB_ERR_REG_value = aData
        flag_FLB_ERR_REG        = &H1
    End Property

    Property Get read_FLB_ERR_REG
        read
        read_FLB_ERR_REG = read_FLB_ERR_REG_value
    End Property

    Property Let write_FLB_ERR_REG(aData)
        set_FLB_ERR_REG = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_FLB_BLK_SIZE_value = rightShift(data_low, 10) and &H3f
        FLB_ERR_REG_mask = &H3ff
        if data_low > LONG_MAX then
            if FLB_ERR_REG_mask = mask then
                read_FLB_ERR_REG_value = data_low
            else
                read_FLB_ERR_REG_value = (data_low - H8000_0000) and FLB_ERR_REG_mask
            end If
        else
            read_FLB_ERR_REG_value = data_low and FLB_ERR_REG_mask
        end If

    End Sub

    Sub write
        If flag_FLB_BLK_SIZE = &H0 or flag_FLB_ERR_REG = &H0 Then read
        If flag_FLB_BLK_SIZE = &H0 Then write_FLB_BLK_SIZE_value = get_FLB_BLK_SIZE
        If flag_FLB_ERR_REG = &H0 Then write_FLB_ERR_REG_value = get_FLB_ERR_REG

        regValue = leftShift((write_FLB_BLK_SIZE_value and &H3f), 10) + leftShift((write_FLB_ERR_REG_value and &H3ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_FLB_BLK_SIZE_value = rightShift(data_low, 10) and &H3f
        FLB_ERR_REG_mask = &H3ff
        if data_low > LONG_MAX then
            if FLB_ERR_REG_mask = mask then
                read_FLB_ERR_REG_value = data_low
            else
                read_FLB_ERR_REG_value = (data_low - H8000_0000) and FLB_ERR_REG_mask
            end If
        else
            read_FLB_ERR_REG_value = data_low and FLB_ERR_REG_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_FLB_BLK_SIZE_value = &H0
        flag_FLB_BLK_SIZE        = &H0
        write_FLB_ERR_REG_value = &H0
        flag_FLB_ERR_REG        = &H0
    End Sub
End Class


'' @REGISTER : FEC_fav_err_reg
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' FAV_ERR_REG                                [9:0]            get_FAV_ERR_REG
''                                                             set_FAV_ERR_REG
''                                                             read_FAV_ERR_REG
''                                                             write_FAV_ERR_REG
''---------------------------------------------------------------------------------
Class REGISTER_FEC_fav_err_reg
    Private write_FAV_ERR_REG_value
    Private read_FAV_ERR_REG_value
    Private flag_FAV_ERR_REG

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H26
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_FAV_ERR_REG
        get_FAV_ERR_REG = read_FAV_ERR_REG_value
    End Property

    Property Let set_FAV_ERR_REG(aData)
        write_FAV_ERR_REG_value = aData
        flag_FAV_ERR_REG        = &H1
    End Property

    Property Get read_FAV_ERR_REG
        read
        read_FAV_ERR_REG = read_FAV_ERR_REG_value
    End Property

    Property Let write_FAV_ERR_REG(aData)
        set_FAV_ERR_REG = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        FAV_ERR_REG_mask = &H3ff
        if data_low > LONG_MAX then
            if FAV_ERR_REG_mask = mask then
                read_FAV_ERR_REG_value = data_low
            else
                read_FAV_ERR_REG_value = (data_low - H8000_0000) and FAV_ERR_REG_mask
            end If
        else
            read_FAV_ERR_REG_value = data_low and FAV_ERR_REG_mask
        end If

    End Sub

    Sub write
        If flag_FAV_ERR_REG = &H0 Then read
        If flag_FAV_ERR_REG = &H0 Then write_FAV_ERR_REG_value = get_FAV_ERR_REG

        regValue = leftShift((write_FAV_ERR_REG_value and &H3ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        FAV_ERR_REG_mask = &H3ff
        if data_low > LONG_MAX then
            if FAV_ERR_REG_mask = mask then
                read_FAV_ERR_REG_value = data_low
            else
                read_FAV_ERR_REG_value = (data_low - H8000_0000) and FAV_ERR_REG_mask
            end If
        else
            read_FAV_ERR_REG_value = data_low and FAV_ERR_REG_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_FAV_ERR_REG_value = &H0
        flag_FAV_ERR_REG        = &H0
    End Sub
End Class


'' @REGISTER : FEC_bber_ctl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' spare_15                                   [15:15]          get_spare_15
''                                                             set_spare_15
''                                                             read_spare_15
''                                                             write_spare_15
''---------------------------------------------------------------------------------
'' bber_detected                              [14:14]          get_bber_detected
''                                                             set_bber_detected
''                                                             read_bber_detected
''                                                             write_bber_detected
''---------------------------------------------------------------------------------
'' bber_status                                [13:13]          get_bber_status
''                                                             set_bber_status
''                                                             read_bber_status
''                                                             write_bber_status
''---------------------------------------------------------------------------------
'' bber_dis                                   [12:12]          get_bber_dis
''                                                             set_bber_dis
''                                                             read_bber_dis
''                                                             write_bber_dis
''---------------------------------------------------------------------------------
'' fec_bber_det_ov                            [11:11]          get_fec_bber_det_ov
''                                                             set_fec_bber_det_ov
''                                                             read_fec_bber_det_ov
''                                                             write_fec_bber_det_ov
''---------------------------------------------------------------------------------
'' fec_bber_det_val                           [10:10]          get_fec_bber_det_val
''                                                             set_fec_bber_det_val
''                                                             read_fec_bber_det_val
''                                                             write_fec_bber_det_val
''---------------------------------------------------------------------------------
'' max_symb_err_ov                            [9:9]            get_max_symb_err_ov
''                                                             set_max_symb_err_ov
''                                                             read_max_symb_err_ov
''                                                             write_max_symb_err_ov
''---------------------------------------------------------------------------------
'' max_symb_err                               [8:4]            get_max_symb_err
''                                                             set_max_symb_err
''                                                             read_max_symb_err
''                                                             write_max_symb_err
''---------------------------------------------------------------------------------
'' max_frm_num_ov                             [3:3]            get_max_frm_num_ov
''                                                             set_max_frm_num_ov
''                                                             read_max_frm_num_ov
''                                                             write_max_frm_num_ov
''---------------------------------------------------------------------------------
'' max_frm_num                                [2:0]            get_max_frm_num
''                                                             set_max_frm_num
''                                                             read_max_frm_num
''                                                             write_max_frm_num
''---------------------------------------------------------------------------------
Class REGISTER_FEC_bber_ctl
    Private write_spare_15_value
    Private read_spare_15_value
    Private flag_spare_15
    Private write_bber_detected_value
    Private read_bber_detected_value
    Private flag_bber_detected
    Private write_bber_status_value
    Private read_bber_status_value
    Private flag_bber_status
    Private write_bber_dis_value
    Private read_bber_dis_value
    Private flag_bber_dis
    Private write_fec_bber_det_ov_value
    Private read_fec_bber_det_ov_value
    Private flag_fec_bber_det_ov
    Private write_fec_bber_det_val_value
    Private read_fec_bber_det_val_value
    Private flag_fec_bber_det_val
    Private write_max_symb_err_ov_value
    Private read_max_symb_err_ov_value
    Private flag_max_symb_err_ov
    Private write_max_symb_err_value
    Private read_max_symb_err_value
    Private flag_max_symb_err
    Private write_max_frm_num_ov_value
    Private read_max_frm_num_ov_value
    Private flag_max_frm_num_ov
    Private write_max_frm_num_value
    Private read_max_frm_num_value
    Private flag_max_frm_num

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

    Property Get get_spare_15
        get_spare_15 = read_spare_15_value
    End Property

    Property Let set_spare_15(aData)
        write_spare_15_value = aData
        flag_spare_15        = &H1
    End Property

    Property Get read_spare_15
        read
        read_spare_15 = read_spare_15_value
    End Property

    Property Let write_spare_15(aData)
        set_spare_15 = aData
        write
    End Property

    Property Get get_bber_detected
        get_bber_detected = read_bber_detected_value
    End Property

    Property Let set_bber_detected(aData)
        write_bber_detected_value = aData
        flag_bber_detected        = &H1
    End Property

    Property Get read_bber_detected
        read
        read_bber_detected = read_bber_detected_value
    End Property

    Property Let write_bber_detected(aData)
        set_bber_detected = aData
        write
    End Property

    Property Get get_bber_status
        get_bber_status = read_bber_status_value
    End Property

    Property Let set_bber_status(aData)
        write_bber_status_value = aData
        flag_bber_status        = &H1
    End Property

    Property Get read_bber_status
        read
        read_bber_status = read_bber_status_value
    End Property

    Property Let write_bber_status(aData)
        set_bber_status = aData
        write
    End Property

    Property Get get_bber_dis
        get_bber_dis = read_bber_dis_value
    End Property

    Property Let set_bber_dis(aData)
        write_bber_dis_value = aData
        flag_bber_dis        = &H1
    End Property

    Property Get read_bber_dis
        read
        read_bber_dis = read_bber_dis_value
    End Property

    Property Let write_bber_dis(aData)
        set_bber_dis = aData
        write
    End Property

    Property Get get_fec_bber_det_ov
        get_fec_bber_det_ov = read_fec_bber_det_ov_value
    End Property

    Property Let set_fec_bber_det_ov(aData)
        write_fec_bber_det_ov_value = aData
        flag_fec_bber_det_ov        = &H1
    End Property

    Property Get read_fec_bber_det_ov
        read
        read_fec_bber_det_ov = read_fec_bber_det_ov_value
    End Property

    Property Let write_fec_bber_det_ov(aData)
        set_fec_bber_det_ov = aData
        write
    End Property

    Property Get get_fec_bber_det_val
        get_fec_bber_det_val = read_fec_bber_det_val_value
    End Property

    Property Let set_fec_bber_det_val(aData)
        write_fec_bber_det_val_value = aData
        flag_fec_bber_det_val        = &H1
    End Property

    Property Get read_fec_bber_det_val
        read
        read_fec_bber_det_val = read_fec_bber_det_val_value
    End Property

    Property Let write_fec_bber_det_val(aData)
        set_fec_bber_det_val = aData
        write
    End Property

    Property Get get_max_symb_err_ov
        get_max_symb_err_ov = read_max_symb_err_ov_value
    End Property

    Property Let set_max_symb_err_ov(aData)
        write_max_symb_err_ov_value = aData
        flag_max_symb_err_ov        = &H1
    End Property

    Property Get read_max_symb_err_ov
        read
        read_max_symb_err_ov = read_max_symb_err_ov_value
    End Property

    Property Let write_max_symb_err_ov(aData)
        set_max_symb_err_ov = aData
        write
    End Property

    Property Get get_max_symb_err
        get_max_symb_err = read_max_symb_err_value
    End Property

    Property Let set_max_symb_err(aData)
        write_max_symb_err_value = aData
        flag_max_symb_err        = &H1
    End Property

    Property Get read_max_symb_err
        read
        read_max_symb_err = read_max_symb_err_value
    End Property

    Property Let write_max_symb_err(aData)
        set_max_symb_err = aData
        write
    End Property

    Property Get get_max_frm_num_ov
        get_max_frm_num_ov = read_max_frm_num_ov_value
    End Property

    Property Let set_max_frm_num_ov(aData)
        write_max_frm_num_ov_value = aData
        flag_max_frm_num_ov        = &H1
    End Property

    Property Get read_max_frm_num_ov
        read
        read_max_frm_num_ov = read_max_frm_num_ov_value
    End Property

    Property Let write_max_frm_num_ov(aData)
        set_max_frm_num_ov = aData
        write
    End Property

    Property Get get_max_frm_num
        get_max_frm_num = read_max_frm_num_value
    End Property

    Property Let set_max_frm_num(aData)
        write_max_frm_num_value = aData
        flag_max_frm_num        = &H1
    End Property

    Property Get read_max_frm_num
        read
        read_max_frm_num = read_max_frm_num_value
    End Property

    Property Let write_max_frm_num(aData)
        set_max_frm_num = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_spare_15_value = rightShift(data_low, 15) and &H1
        read_bber_detected_value = rightShift(data_low, 14) and &H1
        read_bber_status_value = rightShift(data_low, 13) and &H1
        read_bber_dis_value = rightShift(data_low, 12) and &H1
        read_fec_bber_det_ov_value = rightShift(data_low, 11) and &H1
        read_fec_bber_det_val_value = rightShift(data_low, 10) and &H1
        read_max_symb_err_ov_value = rightShift(data_low, 9) and &H1
        read_max_symb_err_value = rightShift(data_low, 4) and &H1f
        read_max_frm_num_ov_value = rightShift(data_low, 3) and &H1
        max_frm_num_mask = &H7
        if data_low > LONG_MAX then
            if max_frm_num_mask = mask then
                read_max_frm_num_value = data_low
            else
                read_max_frm_num_value = (data_low - H8000_0000) and max_frm_num_mask
            end If
        else
            read_max_frm_num_value = data_low and max_frm_num_mask
        end If

    End Sub

    Sub write
        If flag_spare_15 = &H0 or flag_bber_detected = &H0 or flag_bber_status = &H0 or flag_bber_dis = &H0 or flag_fec_bber_det_ov = &H0 or flag_fec_bber_det_val = &H0 or flag_max_symb_err_ov = &H0 or flag_max_symb_err = &H0 or flag_max_frm_num_ov = &H0 or flag_max_frm_num = &H0 Then read
        If flag_spare_15 = &H0 Then write_spare_15_value = get_spare_15
        If flag_bber_detected = &H0 Then write_bber_detected_value = get_bber_detected
        If flag_bber_status = &H0 Then write_bber_status_value = get_bber_status
        If flag_bber_dis = &H0 Then write_bber_dis_value = get_bber_dis
        If flag_fec_bber_det_ov = &H0 Then write_fec_bber_det_ov_value = get_fec_bber_det_ov
        If flag_fec_bber_det_val = &H0 Then write_fec_bber_det_val_value = get_fec_bber_det_val
        If flag_max_symb_err_ov = &H0 Then write_max_symb_err_ov_value = get_max_symb_err_ov
        If flag_max_symb_err = &H0 Then write_max_symb_err_value = get_max_symb_err
        If flag_max_frm_num_ov = &H0 Then write_max_frm_num_ov_value = get_max_frm_num_ov
        If flag_max_frm_num = &H0 Then write_max_frm_num_value = get_max_frm_num

        regValue = leftShift((write_spare_15_value and &H1), 15) + leftShift((write_bber_detected_value and &H1), 14) + leftShift((write_bber_status_value and &H1), 13) + leftShift((write_bber_dis_value and &H1), 12) + leftShift((write_fec_bber_det_ov_value and &H1), 11) + leftShift((write_fec_bber_det_val_value and &H1), 10) + leftShift((write_max_symb_err_ov_value and &H1), 9) + leftShift((write_max_symb_err_value and &H1f), 4) + leftShift((write_max_frm_num_ov_value and &H1), 3) + leftShift((write_max_frm_num_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_spare_15_value = rightShift(data_low, 15) and &H1
        read_bber_detected_value = rightShift(data_low, 14) and &H1
        read_bber_status_value = rightShift(data_low, 13) and &H1
        read_bber_dis_value = rightShift(data_low, 12) and &H1
        read_fec_bber_det_ov_value = rightShift(data_low, 11) and &H1
        read_fec_bber_det_val_value = rightShift(data_low, 10) and &H1
        read_max_symb_err_ov_value = rightShift(data_low, 9) and &H1
        read_max_symb_err_value = rightShift(data_low, 4) and &H1f
        read_max_frm_num_ov_value = rightShift(data_low, 3) and &H1
        max_frm_num_mask = &H7
        if data_low > LONG_MAX then
            if max_frm_num_mask = mask then
                read_max_frm_num_value = data_low
            else
                read_max_frm_num_value = (data_low - H8000_0000) and max_frm_num_mask
            end If
        else
            read_max_frm_num_value = data_low and max_frm_num_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_spare_15_value = &H0
        flag_spare_15        = &H0
        write_bber_detected_value = &H0
        flag_bber_detected        = &H0
        write_bber_status_value = &H0
        flag_bber_status        = &H0
        write_bber_dis_value = &H0
        flag_bber_dis        = &H0
        write_fec_bber_det_ov_value = &H0
        flag_fec_bber_det_ov        = &H0
        write_fec_bber_det_val_value = &H0
        flag_fec_bber_det_val        = &H0
        write_max_symb_err_ov_value = &H0
        flag_max_symb_err_ov        = &H0
        write_max_symb_err_value = &H0
        flag_max_symb_err        = &H0
        write_max_frm_num_ov_value = &H0
        flag_max_frm_num_ov        = &H0
        write_max_frm_num_value = &H0
        flag_max_frm_num        = &H0
    End Sub
End Class


'' @REGISTER : FEC_flb_err_frm
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' FLB_ERR_FRM                                [9:0]            get_FLB_ERR_FRM
''                                                             set_FLB_ERR_FRM
''                                                             read_FLB_ERR_FRM
''                                                             write_FLB_ERR_FRM
''---------------------------------------------------------------------------------
Class REGISTER_FEC_flb_err_frm
    Private write_FLB_ERR_FRM_value
    Private read_FLB_ERR_FRM_value
    Private flag_FLB_ERR_FRM

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_FLB_ERR_FRM
        get_FLB_ERR_FRM = read_FLB_ERR_FRM_value
    End Property

    Property Let set_FLB_ERR_FRM(aData)
        write_FLB_ERR_FRM_value = aData
        flag_FLB_ERR_FRM        = &H1
    End Property

    Property Get read_FLB_ERR_FRM
        read
        read_FLB_ERR_FRM = read_FLB_ERR_FRM_value
    End Property

    Property Let write_FLB_ERR_FRM(aData)
        set_FLB_ERR_FRM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        FLB_ERR_FRM_mask = &H3ff
        if data_low > LONG_MAX then
            if FLB_ERR_FRM_mask = mask then
                read_FLB_ERR_FRM_value = data_low
            else
                read_FLB_ERR_FRM_value = (data_low - H8000_0000) and FLB_ERR_FRM_mask
            end If
        else
            read_FLB_ERR_FRM_value = data_low and FLB_ERR_FRM_mask
        end If

    End Sub

    Sub write
        If flag_FLB_ERR_FRM = &H0 Then read
        If flag_FLB_ERR_FRM = &H0 Then write_FLB_ERR_FRM_value = get_FLB_ERR_FRM

        regValue = leftShift((write_FLB_ERR_FRM_value and &H3ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        FLB_ERR_FRM_mask = &H3ff
        if data_low > LONG_MAX then
            if FLB_ERR_FRM_mask = mask then
                read_FLB_ERR_FRM_value = data_low
            else
                read_FLB_ERR_FRM_value = (data_low - H8000_0000) and FLB_ERR_FRM_mask
            end If
        else
            read_FLB_ERR_FRM_value = data_low and FLB_ERR_FRM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_FLB_ERR_FRM_value = &H0
        flag_FLB_ERR_FRM        = &H0
    End Sub
End Class


'' @REGISTER : FEC_fec_err_frm
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' FLB_ERR_FRM                                [9:0]            get_FLB_ERR_FRM
''                                                             set_FLB_ERR_FRM
''                                                             read_FLB_ERR_FRM
''                                                             write_FLB_ERR_FRM
''---------------------------------------------------------------------------------
Class REGISTER_FEC_fec_err_frm
    Private write_FLB_ERR_FRM_value
    Private read_FLB_ERR_FRM_value
    Private flag_FLB_ERR_FRM

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

    Property Get get_FLB_ERR_FRM
        get_FLB_ERR_FRM = read_FLB_ERR_FRM_value
    End Property

    Property Let set_FLB_ERR_FRM(aData)
        write_FLB_ERR_FRM_value = aData
        flag_FLB_ERR_FRM        = &H1
    End Property

    Property Get read_FLB_ERR_FRM
        read
        read_FLB_ERR_FRM = read_FLB_ERR_FRM_value
    End Property

    Property Let write_FLB_ERR_FRM(aData)
        set_FLB_ERR_FRM = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        FLB_ERR_FRM_mask = &H3ff
        if data_low > LONG_MAX then
            if FLB_ERR_FRM_mask = mask then
                read_FLB_ERR_FRM_value = data_low
            else
                read_FLB_ERR_FRM_value = (data_low - H8000_0000) and FLB_ERR_FRM_mask
            end If
        else
            read_FLB_ERR_FRM_value = data_low and FLB_ERR_FRM_mask
        end If

    End Sub

    Sub write
        If flag_FLB_ERR_FRM = &H0 Then read
        If flag_FLB_ERR_FRM = &H0 Then write_FLB_ERR_FRM_value = get_FLB_ERR_FRM

        regValue = leftShift((write_FLB_ERR_FRM_value and &H3ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        FLB_ERR_FRM_mask = &H3ff
        if data_low > LONG_MAX then
            if FLB_ERR_FRM_mask = mask then
                read_FLB_ERR_FRM_value = data_low
            else
                read_FLB_ERR_FRM_value = (data_low - H8000_0000) and FLB_ERR_FRM_mask
            end If
        else
            read_FLB_ERR_FRM_value = data_low and FLB_ERR_FRM_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_FLB_ERR_FRM_value = &H0
        flag_FLB_ERR_FRM        = &H0
    End Sub
End Class


'' @REGISTER : FEC_flb_err_frm16
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' FLB_ERR_FRM16                              [15:0]           get_FLB_ERR_FRM16
''                                                             set_FLB_ERR_FRM16
''                                                             read_FLB_ERR_FRM16
''                                                             write_FLB_ERR_FRM16
''---------------------------------------------------------------------------------
Class REGISTER_FEC_flb_err_frm16
    Private write_FLB_ERR_FRM16_value
    Private read_FLB_ERR_FRM16_value
    Private flag_FLB_ERR_FRM16

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H2e
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_FLB_ERR_FRM16
        get_FLB_ERR_FRM16 = read_FLB_ERR_FRM16_value
    End Property

    Property Let set_FLB_ERR_FRM16(aData)
        write_FLB_ERR_FRM16_value = aData
        flag_FLB_ERR_FRM16        = &H1
    End Property

    Property Get read_FLB_ERR_FRM16
        read
        read_FLB_ERR_FRM16 = read_FLB_ERR_FRM16_value
    End Property

    Property Let write_FLB_ERR_FRM16(aData)
        set_FLB_ERR_FRM16 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        FLB_ERR_FRM16_mask = &Hffff
        if data_low > LONG_MAX then
            if FLB_ERR_FRM16_mask = mask then
                read_FLB_ERR_FRM16_value = data_low
            else
                read_FLB_ERR_FRM16_value = (data_low - H8000_0000) and FLB_ERR_FRM16_mask
            end If
        else
            read_FLB_ERR_FRM16_value = data_low and FLB_ERR_FRM16_mask
        end If

    End Sub

    Sub write
        If flag_FLB_ERR_FRM16 = &H0 Then read
        If flag_FLB_ERR_FRM16 = &H0 Then write_FLB_ERR_FRM16_value = get_FLB_ERR_FRM16

        regValue = leftShift((write_FLB_ERR_FRM16_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        FLB_ERR_FRM16_mask = &Hffff
        if data_low > LONG_MAX then
            if FLB_ERR_FRM16_mask = mask then
                read_FLB_ERR_FRM16_value = data_low
            else
                read_FLB_ERR_FRM16_value = (data_low - H8000_0000) and FLB_ERR_FRM16_mask
            end If
        else
            read_FLB_ERR_FRM16_value = data_low and FLB_ERR_FRM16_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_FLB_ERR_FRM16_value = &H0
        flag_FLB_ERR_FRM16        = &H0
    End Sub
End Class


'' @REGISTER : FEC_fec_err_frm16
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' FEC_ERR_FRM16                              [15:0]           get_FEC_ERR_FRM16
''                                                             set_FEC_ERR_FRM16
''                                                             read_FEC_ERR_FRM16
''                                                             write_FEC_ERR_FRM16
''---------------------------------------------------------------------------------
Class REGISTER_FEC_fec_err_frm16
    Private write_FEC_ERR_FRM16_value
    Private read_FEC_ERR_FRM16_value
    Private flag_FEC_ERR_FRM16

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

    Property Get get_FEC_ERR_FRM16
        get_FEC_ERR_FRM16 = read_FEC_ERR_FRM16_value
    End Property

    Property Let set_FEC_ERR_FRM16(aData)
        write_FEC_ERR_FRM16_value = aData
        flag_FEC_ERR_FRM16        = &H1
    End Property

    Property Get read_FEC_ERR_FRM16
        read
        read_FEC_ERR_FRM16 = read_FEC_ERR_FRM16_value
    End Property

    Property Let write_FEC_ERR_FRM16(aData)
        set_FEC_ERR_FRM16 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        FEC_ERR_FRM16_mask = &Hffff
        if data_low > LONG_MAX then
            if FEC_ERR_FRM16_mask = mask then
                read_FEC_ERR_FRM16_value = data_low
            else
                read_FEC_ERR_FRM16_value = (data_low - H8000_0000) and FEC_ERR_FRM16_mask
            end If
        else
            read_FEC_ERR_FRM16_value = data_low and FEC_ERR_FRM16_mask
        end If

    End Sub

    Sub write
        If flag_FEC_ERR_FRM16 = &H0 Then read
        If flag_FEC_ERR_FRM16 = &H0 Then write_FEC_ERR_FRM16_value = get_FEC_ERR_FRM16

        regValue = leftShift((write_FEC_ERR_FRM16_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        FEC_ERR_FRM16_mask = &Hffff
        if data_low > LONG_MAX then
            if FEC_ERR_FRM16_mask = mask then
                read_FEC_ERR_FRM16_value = data_low
            else
                read_FEC_ERR_FRM16_value = (data_low - H8000_0000) and FEC_ERR_FRM16_mask
            end If
        else
            read_FEC_ERR_FRM16_value = data_low and FEC_ERR_FRM16_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_FEC_ERR_FRM16_value = &H0
        flag_FEC_ERR_FRM16        = &H0
    End Sub
End Class


'' @REGISTER : FEC_cnt_clr_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' BLK_ERR_DIS                                [5:5]            get_BLK_ERR_DIS
''                                                             set_BLK_ERR_DIS
''                                                             read_BLK_ERR_DIS
''                                                             write_BLK_ERR_DIS
''---------------------------------------------------------------------------------
'' SYMB_ERR_CNT_DIS                           [4:4]            get_SYMB_ERR_CNT_DIS
''                                                             set_SYMB_ERR_CNT_DIS
''                                                             read_SYMB_ERR_CNT_DIS
''                                                             write_SYMB_ERR_CNT_DIS
''---------------------------------------------------------------------------------
'' FEC_ERR_FRM16_DIS                          [3:3]            get_FEC_ERR_FRM16_DIS
''                                                             set_FEC_ERR_FRM16_DIS
''                                                             read_FEC_ERR_FRM16_DIS
''                                                             write_FEC_ERR_FRM16_DIS
''---------------------------------------------------------------------------------
'' FLB_ERR_FRM16_DIS                          [2:2]            get_FLB_ERR_FRM16_DIS
''                                                             set_FLB_ERR_FRM16_DIS
''                                                             read_FLB_ERR_FRM16_DIS
''                                                             write_FLB_ERR_FRM16_DIS
''---------------------------------------------------------------------------------
'' FEC_ERR_FRM_DIS                            [1:1]            get_FEC_ERR_FRM_DIS
''                                                             set_FEC_ERR_FRM_DIS
''                                                             read_FEC_ERR_FRM_DIS
''                                                             write_FEC_ERR_FRM_DIS
''---------------------------------------------------------------------------------
'' FLB_ERR_FRM_DIS                            [0:0]            get_FLB_ERR_FRM_DIS
''                                                             set_FLB_ERR_FRM_DIS
''                                                             read_FLB_ERR_FRM_DIS
''                                                             write_FLB_ERR_FRM_DIS
''---------------------------------------------------------------------------------
Class REGISTER_FEC_cnt_clr_ctrl
    Private write_BLK_ERR_DIS_value
    Private read_BLK_ERR_DIS_value
    Private flag_BLK_ERR_DIS
    Private write_SYMB_ERR_CNT_DIS_value
    Private read_SYMB_ERR_CNT_DIS_value
    Private flag_SYMB_ERR_CNT_DIS
    Private write_FEC_ERR_FRM16_DIS_value
    Private read_FEC_ERR_FRM16_DIS_value
    Private flag_FEC_ERR_FRM16_DIS
    Private write_FLB_ERR_FRM16_DIS_value
    Private read_FLB_ERR_FRM16_DIS_value
    Private flag_FLB_ERR_FRM16_DIS
    Private write_FEC_ERR_FRM_DIS_value
    Private read_FEC_ERR_FRM_DIS_value
    Private flag_FEC_ERR_FRM_DIS
    Private write_FLB_ERR_FRM_DIS_value
    Private read_FLB_ERR_FRM_DIS_value
    Private flag_FLB_ERR_FRM_DIS

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H32
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_BLK_ERR_DIS
        get_BLK_ERR_DIS = read_BLK_ERR_DIS_value
    End Property

    Property Let set_BLK_ERR_DIS(aData)
        write_BLK_ERR_DIS_value = aData
        flag_BLK_ERR_DIS        = &H1
    End Property

    Property Get read_BLK_ERR_DIS
        read
        read_BLK_ERR_DIS = read_BLK_ERR_DIS_value
    End Property

    Property Let write_BLK_ERR_DIS(aData)
        set_BLK_ERR_DIS = aData
        write
    End Property

    Property Get get_SYMB_ERR_CNT_DIS
        get_SYMB_ERR_CNT_DIS = read_SYMB_ERR_CNT_DIS_value
    End Property

    Property Let set_SYMB_ERR_CNT_DIS(aData)
        write_SYMB_ERR_CNT_DIS_value = aData
        flag_SYMB_ERR_CNT_DIS        = &H1
    End Property

    Property Get read_SYMB_ERR_CNT_DIS
        read
        read_SYMB_ERR_CNT_DIS = read_SYMB_ERR_CNT_DIS_value
    End Property

    Property Let write_SYMB_ERR_CNT_DIS(aData)
        set_SYMB_ERR_CNT_DIS = aData
        write
    End Property

    Property Get get_FEC_ERR_FRM16_DIS
        get_FEC_ERR_FRM16_DIS = read_FEC_ERR_FRM16_DIS_value
    End Property

    Property Let set_FEC_ERR_FRM16_DIS(aData)
        write_FEC_ERR_FRM16_DIS_value = aData
        flag_FEC_ERR_FRM16_DIS        = &H1
    End Property

    Property Get read_FEC_ERR_FRM16_DIS
        read
        read_FEC_ERR_FRM16_DIS = read_FEC_ERR_FRM16_DIS_value
    End Property

    Property Let write_FEC_ERR_FRM16_DIS(aData)
        set_FEC_ERR_FRM16_DIS = aData
        write
    End Property

    Property Get get_FLB_ERR_FRM16_DIS
        get_FLB_ERR_FRM16_DIS = read_FLB_ERR_FRM16_DIS_value
    End Property

    Property Let set_FLB_ERR_FRM16_DIS(aData)
        write_FLB_ERR_FRM16_DIS_value = aData
        flag_FLB_ERR_FRM16_DIS        = &H1
    End Property

    Property Get read_FLB_ERR_FRM16_DIS
        read
        read_FLB_ERR_FRM16_DIS = read_FLB_ERR_FRM16_DIS_value
    End Property

    Property Let write_FLB_ERR_FRM16_DIS(aData)
        set_FLB_ERR_FRM16_DIS = aData
        write
    End Property

    Property Get get_FEC_ERR_FRM_DIS
        get_FEC_ERR_FRM_DIS = read_FEC_ERR_FRM_DIS_value
    End Property

    Property Let set_FEC_ERR_FRM_DIS(aData)
        write_FEC_ERR_FRM_DIS_value = aData
        flag_FEC_ERR_FRM_DIS        = &H1
    End Property

    Property Get read_FEC_ERR_FRM_DIS
        read
        read_FEC_ERR_FRM_DIS = read_FEC_ERR_FRM_DIS_value
    End Property

    Property Let write_FEC_ERR_FRM_DIS(aData)
        set_FEC_ERR_FRM_DIS = aData
        write
    End Property

    Property Get get_FLB_ERR_FRM_DIS
        get_FLB_ERR_FRM_DIS = read_FLB_ERR_FRM_DIS_value
    End Property

    Property Let set_FLB_ERR_FRM_DIS(aData)
        write_FLB_ERR_FRM_DIS_value = aData
        flag_FLB_ERR_FRM_DIS        = &H1
    End Property

    Property Get read_FLB_ERR_FRM_DIS
        read
        read_FLB_ERR_FRM_DIS = read_FLB_ERR_FRM_DIS_value
    End Property

    Property Let write_FLB_ERR_FRM_DIS(aData)
        set_FLB_ERR_FRM_DIS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_BLK_ERR_DIS_value = rightShift(data_low, 5) and &H1
        read_SYMB_ERR_CNT_DIS_value = rightShift(data_low, 4) and &H1
        read_FEC_ERR_FRM16_DIS_value = rightShift(data_low, 3) and &H1
        read_FLB_ERR_FRM16_DIS_value = rightShift(data_low, 2) and &H1
        read_FEC_ERR_FRM_DIS_value = rightShift(data_low, 1) and &H1
        FLB_ERR_FRM_DIS_mask = &H1
        if data_low > LONG_MAX then
            if FLB_ERR_FRM_DIS_mask = mask then
                read_FLB_ERR_FRM_DIS_value = data_low
            else
                read_FLB_ERR_FRM_DIS_value = (data_low - H8000_0000) and FLB_ERR_FRM_DIS_mask
            end If
        else
            read_FLB_ERR_FRM_DIS_value = data_low and FLB_ERR_FRM_DIS_mask
        end If

    End Sub

    Sub write
        If flag_BLK_ERR_DIS = &H0 or flag_SYMB_ERR_CNT_DIS = &H0 or flag_FEC_ERR_FRM16_DIS = &H0 or flag_FLB_ERR_FRM16_DIS = &H0 or flag_FEC_ERR_FRM_DIS = &H0 or flag_FLB_ERR_FRM_DIS = &H0 Then read
        If flag_BLK_ERR_DIS = &H0 Then write_BLK_ERR_DIS_value = get_BLK_ERR_DIS
        If flag_SYMB_ERR_CNT_DIS = &H0 Then write_SYMB_ERR_CNT_DIS_value = get_SYMB_ERR_CNT_DIS
        If flag_FEC_ERR_FRM16_DIS = &H0 Then write_FEC_ERR_FRM16_DIS_value = get_FEC_ERR_FRM16_DIS
        If flag_FLB_ERR_FRM16_DIS = &H0 Then write_FLB_ERR_FRM16_DIS_value = get_FLB_ERR_FRM16_DIS
        If flag_FEC_ERR_FRM_DIS = &H0 Then write_FEC_ERR_FRM_DIS_value = get_FEC_ERR_FRM_DIS
        If flag_FLB_ERR_FRM_DIS = &H0 Then write_FLB_ERR_FRM_DIS_value = get_FLB_ERR_FRM_DIS

        regValue = leftShift((write_BLK_ERR_DIS_value and &H1), 5) + leftShift((write_SYMB_ERR_CNT_DIS_value and &H1), 4) + leftShift((write_FEC_ERR_FRM16_DIS_value and &H1), 3) + leftShift((write_FLB_ERR_FRM16_DIS_value and &H1), 2) + leftShift((write_FEC_ERR_FRM_DIS_value and &H1), 1) + leftShift((write_FLB_ERR_FRM_DIS_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_BLK_ERR_DIS_value = rightShift(data_low, 5) and &H1
        read_SYMB_ERR_CNT_DIS_value = rightShift(data_low, 4) and &H1
        read_FEC_ERR_FRM16_DIS_value = rightShift(data_low, 3) and &H1
        read_FLB_ERR_FRM16_DIS_value = rightShift(data_low, 2) and &H1
        read_FEC_ERR_FRM_DIS_value = rightShift(data_low, 1) and &H1
        FLB_ERR_FRM_DIS_mask = &H1
        if data_low > LONG_MAX then
            if FLB_ERR_FRM_DIS_mask = mask then
                read_FLB_ERR_FRM_DIS_value = data_low
            else
                read_FLB_ERR_FRM_DIS_value = (data_low - H8000_0000) and FLB_ERR_FRM_DIS_mask
            end If
        else
            read_FLB_ERR_FRM_DIS_value = data_low and FLB_ERR_FRM_DIS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_BLK_ERR_DIS_value = &H0
        flag_BLK_ERR_DIS        = &H0
        write_SYMB_ERR_CNT_DIS_value = &H0
        flag_SYMB_ERR_CNT_DIS        = &H0
        write_FEC_ERR_FRM16_DIS_value = &H0
        flag_FEC_ERR_FRM16_DIS        = &H0
        write_FLB_ERR_FRM16_DIS_value = &H0
        flag_FLB_ERR_FRM16_DIS        = &H0
        write_FEC_ERR_FRM_DIS_value = &H0
        flag_FEC_ERR_FRM_DIS        = &H0
        write_FLB_ERR_FRM_DIS_value = &H0
        flag_FLB_ERR_FRM_DIS        = &H0
    End Sub
End Class


'' @REGISTER : FEC_fec_end
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' FEC_END                                    [15:0]           get_FEC_END
''                                                             set_FEC_END
''                                                             read_FEC_END
''                                                             write_FEC_END
''---------------------------------------------------------------------------------
Class REGISTER_FEC_fec_end
    Private write_FEC_END_value
    Private read_FEC_END_value
    Private flag_FEC_END

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hfe
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_FEC_END
        get_FEC_END = read_FEC_END_value
    End Property

    Property Let set_FEC_END(aData)
        write_FEC_END_value = aData
        flag_FEC_END        = &H1
    End Property

    Property Get read_FEC_END
        read
        read_FEC_END = read_FEC_END_value
    End Property

    Property Let write_FEC_END(aData)
        set_FEC_END = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        FEC_END_mask = &Hffff
        if data_low > LONG_MAX then
            if FEC_END_mask = mask then
                read_FEC_END_value = data_low
            else
                read_FEC_END_value = (data_low - H8000_0000) and FEC_END_mask
            end If
        else
            read_FEC_END_value = data_low and FEC_END_mask
        end If

    End Sub

    Sub write
        If flag_FEC_END = &H0 Then read
        If flag_FEC_END = &H0 Then write_FEC_END_value = get_FEC_END

        regValue = leftShift((write_FEC_END_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        FEC_END_mask = &Hffff
        if data_low > LONG_MAX then
            if FEC_END_mask = mask then
                read_FEC_END_value = data_low
            else
                read_FEC_END_value = (data_low - H8000_0000) and FEC_END_mask
            end If
        else
            read_FEC_END_value = data_low and FEC_END_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_FEC_END_value = &H0
        flag_FEC_END        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class FEC_INSTANCE

    Public config_0
    Public blk_cnt_period_lsb
    Public blk_cnt_period_msb
    Public blk_cnt_lsb
    Public blk_cnt_msb
    Public blk_err_cnt_lsb
    Public blk_err_cnt_msb
    Public symb_err_cnt_lsb
    Public symb_err_cnt_msb
    Public status
    Public ebc_accum_lsb
    Public ebc_accum_msb
    Public ebc_accum_lrg_lsb
    Public ebc_accum_lrg_msb
    Public config_en
    Public dec_fifo_sram_ctrl0
    Public dec_fifo_sram_status
    Public crct_sym_reg
    Public flb_err_reg
    Public fav_err_reg
    Public bber_ctl
    Public flb_err_frm
    Public fec_err_frm
    Public flb_err_frm16
    Public fec_err_frm16
    Public cnt_clr_ctrl
    Public fec_end


    Public default function Init(aBaseAddr)
        Set config_0 = (New REGISTER_FEC_config_0)(aBaseAddr, 16)
        Set blk_cnt_period_lsb = (New REGISTER_FEC_blk_cnt_period_lsb)(aBaseAddr, 16)
        Set blk_cnt_period_msb = (New REGISTER_FEC_blk_cnt_period_msb)(aBaseAddr, 16)
        Set blk_cnt_lsb = (New REGISTER_FEC_blk_cnt_lsb)(aBaseAddr, 16)
        Set blk_cnt_msb = (New REGISTER_FEC_blk_cnt_msb)(aBaseAddr, 16)
        Set blk_err_cnt_lsb = (New REGISTER_FEC_blk_err_cnt_lsb)(aBaseAddr, 16)
        Set blk_err_cnt_msb = (New REGISTER_FEC_blk_err_cnt_msb)(aBaseAddr, 16)
        Set symb_err_cnt_lsb = (New REGISTER_FEC_symb_err_cnt_lsb)(aBaseAddr, 16)
        Set symb_err_cnt_msb = (New REGISTER_FEC_symb_err_cnt_msb)(aBaseAddr, 16)
        Set status = (New REGISTER_FEC_status)(aBaseAddr, 16)
        Set ebc_accum_lsb = (New REGISTER_FEC_ebc_accum_lsb)(aBaseAddr, 16)
        Set ebc_accum_msb = (New REGISTER_FEC_ebc_accum_msb)(aBaseAddr, 16)
        Set ebc_accum_lrg_lsb = (New REGISTER_FEC_ebc_accum_lrg_lsb)(aBaseAddr, 16)
        Set ebc_accum_lrg_msb = (New REGISTER_FEC_ebc_accum_lrg_msb)(aBaseAddr, 16)
        Set config_en = (New REGISTER_FEC_config_en)(aBaseAddr, 16)
        Set dec_fifo_sram_ctrl0 = (New REGISTER_FEC_dec_fifo_sram_ctrl0)(aBaseAddr, 16)
        Set dec_fifo_sram_status = (New REGISTER_FEC_dec_fifo_sram_status)(aBaseAddr, 16)
        Set crct_sym_reg = (New REGISTER_FEC_crct_sym_reg)(aBaseAddr, 16)
        Set flb_err_reg = (New REGISTER_FEC_flb_err_reg)(aBaseAddr, 16)
        Set fav_err_reg = (New REGISTER_FEC_fav_err_reg)(aBaseAddr, 16)
        Set bber_ctl = (New REGISTER_FEC_bber_ctl)(aBaseAddr, 16)
        Set flb_err_frm = (New REGISTER_FEC_flb_err_frm)(aBaseAddr, 16)
        Set fec_err_frm = (New REGISTER_FEC_fec_err_frm)(aBaseAddr, 16)
        Set flb_err_frm16 = (New REGISTER_FEC_flb_err_frm16)(aBaseAddr, 16)
        Set fec_err_frm16 = (New REGISTER_FEC_fec_err_frm16)(aBaseAddr, 16)
        Set cnt_clr_ctrl = (New REGISTER_FEC_cnt_clr_ctrl)(aBaseAddr, 16)
        Set fec_end = (New REGISTER_FEC_fec_end)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set FEC = CreateObject("System.Collections.ArrayList")
FEC.Add ((New FEC_INSTANCE)(&H49031b00))


