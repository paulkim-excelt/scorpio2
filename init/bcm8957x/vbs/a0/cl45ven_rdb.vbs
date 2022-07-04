

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


'' @REGISTER : CL45VEN_force_link
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' FORCE_LINK_MODE                            [15:15]          get_FORCE_LINK_MODE
''                                                             set_FORCE_LINK_MODE
''                                                             read_FORCE_LINK_MODE
''                                                             write_FORCE_LINK_MODE
''---------------------------------------------------------------------------------
'' CHNG_10GBASET_AN_CTRL_BEHAV                [14:14]          get_CHNG_10GBASET_AN_CTRL_BEHAV
''                                                             set_CHNG_10GBASET_AN_CTRL_BEHAV
''                                                             read_CHNG_10GBASET_AN_CTRL_BEHAV
''                                                             write_CHNG_10GBASET_AN_CTRL_BEHAV
''---------------------------------------------------------------------------------
'' CHNG_BIT13_MCTRL_RD_BEHAV                  [13:13]          get_CHNG_BIT13_MCTRL_RD_BEHAV
''                                                             set_CHNG_BIT13_MCTRL_RD_BEHAV
''                                                             read_CHNG_BIT13_MCTRL_RD_BEHAV
''                                                             write_CHNG_BIT13_MCTRL_RD_BEHAV
''---------------------------------------------------------------------------------
'' AN_FLP_BTB_TMR_MODE                        [12:12]          get_AN_FLP_BTB_TMR_MODE
''                                                             set_AN_FLP_BTB_TMR_MODE
''                                                             read_AN_FLP_BTB_TMR_MODE
''                                                             write_AN_FLP_BTB_TMR_MODE
''---------------------------------------------------------------------------------
'' SWP_UFORMATED_CODE_FLDS                    [11:11]          get_SWP_UFORMATED_CODE_FLDS
''                                                             set_SWP_UFORMATED_CODE_FLDS
''                                                             read_SWP_UFORMATED_CODE_FLDS
''                                                             write_SWP_UFORMATED_CODE_FLDS
''---------------------------------------------------------------------------------
'' BREAK_LINK_TIMER_MODE                      [10:10]          get_BREAK_LINK_TIMER_MODE
''                                                             set_BREAK_LINK_TIMER_MODE
''                                                             read_BREAK_LINK_TIMER_MODE
''                                                             write_BREAK_LINK_TIMER_MODE
''---------------------------------------------------------------------------------
'' PREAMBLE_IGNORE                            [9:9]            get_PREAMBLE_IGNORE
''                                                             set_PREAMBLE_IGNORE
''                                                             read_PREAMBLE_IGNORE
''                                                             write_PREAMBLE_IGNORE
''---------------------------------------------------------------------------------
'' FORCE_LNK_10GBASET_FDX                     [8:8]            get_FORCE_LNK_10GBASET_FDX
''                                                             set_FORCE_LNK_10GBASET_FDX
''                                                             read_FORCE_LNK_10GBASET_FDX
''                                                             write_FORCE_LNK_10GBASET_FDX
''---------------------------------------------------------------------------------
'' FORCE_LNK_1000BASET_FDX_HDX                [7:7]            get_FORCE_LNK_1000BASET_FDX_HDX
''                                                             set_FORCE_LNK_1000BASET_FDX_HDX
''                                                             read_FORCE_LNK_1000BASET_FDX_HDX
''                                                             write_FORCE_LNK_1000BASET_FDX_HDX
''---------------------------------------------------------------------------------
'' IGNORE_ACK2                                [6:6]            get_IGNORE_ACK2
''                                                             set_IGNORE_ACK2
''                                                             read_IGNORE_ACK2
''                                                             write_IGNORE_ACK2
''---------------------------------------------------------------------------------
'' LNK_FORCE_100BASET_OK                      [5:5]            get_LNK_FORCE_100BASET_OK
''                                                             set_LNK_FORCE_100BASET_OK
''                                                             read_LNK_FORCE_100BASET_OK
''                                                             write_LNK_FORCE_100BASET_OK
''---------------------------------------------------------------------------------
'' LNK_FORCE_100BASET_RDY                     [4:4]            get_LNK_FORCE_100BASET_RDY
''                                                             set_LNK_FORCE_100BASET_RDY
''                                                             read_LNK_FORCE_100BASET_RDY
''                                                             write_LNK_FORCE_100BASET_RDY
''---------------------------------------------------------------------------------
'' DIS_REG7P0_BIT13_AUTO_UPDATE               [3:3]            get_DIS_REG7P0_BIT13_AUTO_UPDATE
''                                                             set_DIS_REG7P0_BIT13_AUTO_UPDATE
''                                                             read_DIS_REG7P0_BIT13_AUTO_UPDATE
''                                                             write_DIS_REG7P0_BIT13_AUTO_UPDATE
''---------------------------------------------------------------------------------
'' LNK_FORCE_10BASET_OK                       [2:2]            get_LNK_FORCE_10BASET_OK
''                                                             set_LNK_FORCE_10BASET_OK
''                                                             read_LNK_FORCE_10BASET_OK
''                                                             write_LNK_FORCE_10BASET_OK
''---------------------------------------------------------------------------------
'' LNK_FORCE_10BASET_RDY                      [1:1]            get_LNK_FORCE_10BASET_RDY
''                                                             set_LNK_FORCE_10BASET_RDY
''                                                             read_LNK_FORCE_10BASET_RDY
''                                                             write_LNK_FORCE_10BASET_RDY
''---------------------------------------------------------------------------------
'' LAST_PG_TO_EN                              [0:0]            get_LAST_PG_TO_EN
''                                                             set_LAST_PG_TO_EN
''                                                             read_LAST_PG_TO_EN
''                                                             write_LAST_PG_TO_EN
''---------------------------------------------------------------------------------
Class REGISTER_CL45VEN_force_link
    Private write_FORCE_LINK_MODE_value
    Private read_FORCE_LINK_MODE_value
    Private flag_FORCE_LINK_MODE
    Private write_CHNG_10GBASET_AN_CTRL_BEHAV_value
    Private read_CHNG_10GBASET_AN_CTRL_BEHAV_value
    Private flag_CHNG_10GBASET_AN_CTRL_BEHAV
    Private write_CHNG_BIT13_MCTRL_RD_BEHAV_value
    Private read_CHNG_BIT13_MCTRL_RD_BEHAV_value
    Private flag_CHNG_BIT13_MCTRL_RD_BEHAV
    Private write_AN_FLP_BTB_TMR_MODE_value
    Private read_AN_FLP_BTB_TMR_MODE_value
    Private flag_AN_FLP_BTB_TMR_MODE
    Private write_SWP_UFORMATED_CODE_FLDS_value
    Private read_SWP_UFORMATED_CODE_FLDS_value
    Private flag_SWP_UFORMATED_CODE_FLDS
    Private write_BREAK_LINK_TIMER_MODE_value
    Private read_BREAK_LINK_TIMER_MODE_value
    Private flag_BREAK_LINK_TIMER_MODE
    Private write_PREAMBLE_IGNORE_value
    Private read_PREAMBLE_IGNORE_value
    Private flag_PREAMBLE_IGNORE
    Private write_FORCE_LNK_10GBASET_FDX_value
    Private read_FORCE_LNK_10GBASET_FDX_value
    Private flag_FORCE_LNK_10GBASET_FDX
    Private write_FORCE_LNK_1000BASET_FDX_HDX_value
    Private read_FORCE_LNK_1000BASET_FDX_HDX_value
    Private flag_FORCE_LNK_1000BASET_FDX_HDX
    Private write_IGNORE_ACK2_value
    Private read_IGNORE_ACK2_value
    Private flag_IGNORE_ACK2
    Private write_LNK_FORCE_100BASET_OK_value
    Private read_LNK_FORCE_100BASET_OK_value
    Private flag_LNK_FORCE_100BASET_OK
    Private write_LNK_FORCE_100BASET_RDY_value
    Private read_LNK_FORCE_100BASET_RDY_value
    Private flag_LNK_FORCE_100BASET_RDY
    Private write_DIS_REG7P0_BIT13_AUTO_UPDATE_value
    Private read_DIS_REG7P0_BIT13_AUTO_UPDATE_value
    Private flag_DIS_REG7P0_BIT13_AUTO_UPDATE
    Private write_LNK_FORCE_10BASET_OK_value
    Private read_LNK_FORCE_10BASET_OK_value
    Private flag_LNK_FORCE_10BASET_OK
    Private write_LNK_FORCE_10BASET_RDY_value
    Private read_LNK_FORCE_10BASET_RDY_value
    Private flag_LNK_FORCE_10BASET_RDY
    Private write_LAST_PG_TO_EN_value
    Private read_LAST_PG_TO_EN_value
    Private flag_LAST_PG_TO_EN

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

    Property Get get_FORCE_LINK_MODE
        get_FORCE_LINK_MODE = read_FORCE_LINK_MODE_value
    End Property

    Property Let set_FORCE_LINK_MODE(aData)
        write_FORCE_LINK_MODE_value = aData
        flag_FORCE_LINK_MODE        = &H1
    End Property

    Property Get read_FORCE_LINK_MODE
        read
        read_FORCE_LINK_MODE = read_FORCE_LINK_MODE_value
    End Property

    Property Let write_FORCE_LINK_MODE(aData)
        set_FORCE_LINK_MODE = aData
        write
    End Property

    Property Get get_CHNG_10GBASET_AN_CTRL_BEHAV
        get_CHNG_10GBASET_AN_CTRL_BEHAV = read_CHNG_10GBASET_AN_CTRL_BEHAV_value
    End Property

    Property Let set_CHNG_10GBASET_AN_CTRL_BEHAV(aData)
        write_CHNG_10GBASET_AN_CTRL_BEHAV_value = aData
        flag_CHNG_10GBASET_AN_CTRL_BEHAV        = &H1
    End Property

    Property Get read_CHNG_10GBASET_AN_CTRL_BEHAV
        read
        read_CHNG_10GBASET_AN_CTRL_BEHAV = read_CHNG_10GBASET_AN_CTRL_BEHAV_value
    End Property

    Property Let write_CHNG_10GBASET_AN_CTRL_BEHAV(aData)
        set_CHNG_10GBASET_AN_CTRL_BEHAV = aData
        write
    End Property

    Property Get get_CHNG_BIT13_MCTRL_RD_BEHAV
        get_CHNG_BIT13_MCTRL_RD_BEHAV = read_CHNG_BIT13_MCTRL_RD_BEHAV_value
    End Property

    Property Let set_CHNG_BIT13_MCTRL_RD_BEHAV(aData)
        write_CHNG_BIT13_MCTRL_RD_BEHAV_value = aData
        flag_CHNG_BIT13_MCTRL_RD_BEHAV        = &H1
    End Property

    Property Get read_CHNG_BIT13_MCTRL_RD_BEHAV
        read
        read_CHNG_BIT13_MCTRL_RD_BEHAV = read_CHNG_BIT13_MCTRL_RD_BEHAV_value
    End Property

    Property Let write_CHNG_BIT13_MCTRL_RD_BEHAV(aData)
        set_CHNG_BIT13_MCTRL_RD_BEHAV = aData
        write
    End Property

    Property Get get_AN_FLP_BTB_TMR_MODE
        get_AN_FLP_BTB_TMR_MODE = read_AN_FLP_BTB_TMR_MODE_value
    End Property

    Property Let set_AN_FLP_BTB_TMR_MODE(aData)
        write_AN_FLP_BTB_TMR_MODE_value = aData
        flag_AN_FLP_BTB_TMR_MODE        = &H1
    End Property

    Property Get read_AN_FLP_BTB_TMR_MODE
        read
        read_AN_FLP_BTB_TMR_MODE = read_AN_FLP_BTB_TMR_MODE_value
    End Property

    Property Let write_AN_FLP_BTB_TMR_MODE(aData)
        set_AN_FLP_BTB_TMR_MODE = aData
        write
    End Property

    Property Get get_SWP_UFORMATED_CODE_FLDS
        get_SWP_UFORMATED_CODE_FLDS = read_SWP_UFORMATED_CODE_FLDS_value
    End Property

    Property Let set_SWP_UFORMATED_CODE_FLDS(aData)
        write_SWP_UFORMATED_CODE_FLDS_value = aData
        flag_SWP_UFORMATED_CODE_FLDS        = &H1
    End Property

    Property Get read_SWP_UFORMATED_CODE_FLDS
        read
        read_SWP_UFORMATED_CODE_FLDS = read_SWP_UFORMATED_CODE_FLDS_value
    End Property

    Property Let write_SWP_UFORMATED_CODE_FLDS(aData)
        set_SWP_UFORMATED_CODE_FLDS = aData
        write
    End Property

    Property Get get_BREAK_LINK_TIMER_MODE
        get_BREAK_LINK_TIMER_MODE = read_BREAK_LINK_TIMER_MODE_value
    End Property

    Property Let set_BREAK_LINK_TIMER_MODE(aData)
        write_BREAK_LINK_TIMER_MODE_value = aData
        flag_BREAK_LINK_TIMER_MODE        = &H1
    End Property

    Property Get read_BREAK_LINK_TIMER_MODE
        read
        read_BREAK_LINK_TIMER_MODE = read_BREAK_LINK_TIMER_MODE_value
    End Property

    Property Let write_BREAK_LINK_TIMER_MODE(aData)
        set_BREAK_LINK_TIMER_MODE = aData
        write
    End Property

    Property Get get_PREAMBLE_IGNORE
        get_PREAMBLE_IGNORE = read_PREAMBLE_IGNORE_value
    End Property

    Property Let set_PREAMBLE_IGNORE(aData)
        write_PREAMBLE_IGNORE_value = aData
        flag_PREAMBLE_IGNORE        = &H1
    End Property

    Property Get read_PREAMBLE_IGNORE
        read
        read_PREAMBLE_IGNORE = read_PREAMBLE_IGNORE_value
    End Property

    Property Let write_PREAMBLE_IGNORE(aData)
        set_PREAMBLE_IGNORE = aData
        write
    End Property

    Property Get get_FORCE_LNK_10GBASET_FDX
        get_FORCE_LNK_10GBASET_FDX = read_FORCE_LNK_10GBASET_FDX_value
    End Property

    Property Let set_FORCE_LNK_10GBASET_FDX(aData)
        write_FORCE_LNK_10GBASET_FDX_value = aData
        flag_FORCE_LNK_10GBASET_FDX        = &H1
    End Property

    Property Get read_FORCE_LNK_10GBASET_FDX
        read
        read_FORCE_LNK_10GBASET_FDX = read_FORCE_LNK_10GBASET_FDX_value
    End Property

    Property Let write_FORCE_LNK_10GBASET_FDX(aData)
        set_FORCE_LNK_10GBASET_FDX = aData
        write
    End Property

    Property Get get_FORCE_LNK_1000BASET_FDX_HDX
        get_FORCE_LNK_1000BASET_FDX_HDX = read_FORCE_LNK_1000BASET_FDX_HDX_value
    End Property

    Property Let set_FORCE_LNK_1000BASET_FDX_HDX(aData)
        write_FORCE_LNK_1000BASET_FDX_HDX_value = aData
        flag_FORCE_LNK_1000BASET_FDX_HDX        = &H1
    End Property

    Property Get read_FORCE_LNK_1000BASET_FDX_HDX
        read
        read_FORCE_LNK_1000BASET_FDX_HDX = read_FORCE_LNK_1000BASET_FDX_HDX_value
    End Property

    Property Let write_FORCE_LNK_1000BASET_FDX_HDX(aData)
        set_FORCE_LNK_1000BASET_FDX_HDX = aData
        write
    End Property

    Property Get get_IGNORE_ACK2
        get_IGNORE_ACK2 = read_IGNORE_ACK2_value
    End Property

    Property Let set_IGNORE_ACK2(aData)
        write_IGNORE_ACK2_value = aData
        flag_IGNORE_ACK2        = &H1
    End Property

    Property Get read_IGNORE_ACK2
        read
        read_IGNORE_ACK2 = read_IGNORE_ACK2_value
    End Property

    Property Let write_IGNORE_ACK2(aData)
        set_IGNORE_ACK2 = aData
        write
    End Property

    Property Get get_LNK_FORCE_100BASET_OK
        get_LNK_FORCE_100BASET_OK = read_LNK_FORCE_100BASET_OK_value
    End Property

    Property Let set_LNK_FORCE_100BASET_OK(aData)
        write_LNK_FORCE_100BASET_OK_value = aData
        flag_LNK_FORCE_100BASET_OK        = &H1
    End Property

    Property Get read_LNK_FORCE_100BASET_OK
        read
        read_LNK_FORCE_100BASET_OK = read_LNK_FORCE_100BASET_OK_value
    End Property

    Property Let write_LNK_FORCE_100BASET_OK(aData)
        set_LNK_FORCE_100BASET_OK = aData
        write
    End Property

    Property Get get_LNK_FORCE_100BASET_RDY
        get_LNK_FORCE_100BASET_RDY = read_LNK_FORCE_100BASET_RDY_value
    End Property

    Property Let set_LNK_FORCE_100BASET_RDY(aData)
        write_LNK_FORCE_100BASET_RDY_value = aData
        flag_LNK_FORCE_100BASET_RDY        = &H1
    End Property

    Property Get read_LNK_FORCE_100BASET_RDY
        read
        read_LNK_FORCE_100BASET_RDY = read_LNK_FORCE_100BASET_RDY_value
    End Property

    Property Let write_LNK_FORCE_100BASET_RDY(aData)
        set_LNK_FORCE_100BASET_RDY = aData
        write
    End Property

    Property Get get_DIS_REG7P0_BIT13_AUTO_UPDATE
        get_DIS_REG7P0_BIT13_AUTO_UPDATE = read_DIS_REG7P0_BIT13_AUTO_UPDATE_value
    End Property

    Property Let set_DIS_REG7P0_BIT13_AUTO_UPDATE(aData)
        write_DIS_REG7P0_BIT13_AUTO_UPDATE_value = aData
        flag_DIS_REG7P0_BIT13_AUTO_UPDATE        = &H1
    End Property

    Property Get read_DIS_REG7P0_BIT13_AUTO_UPDATE
        read
        read_DIS_REG7P0_BIT13_AUTO_UPDATE = read_DIS_REG7P0_BIT13_AUTO_UPDATE_value
    End Property

    Property Let write_DIS_REG7P0_BIT13_AUTO_UPDATE(aData)
        set_DIS_REG7P0_BIT13_AUTO_UPDATE = aData
        write
    End Property

    Property Get get_LNK_FORCE_10BASET_OK
        get_LNK_FORCE_10BASET_OK = read_LNK_FORCE_10BASET_OK_value
    End Property

    Property Let set_LNK_FORCE_10BASET_OK(aData)
        write_LNK_FORCE_10BASET_OK_value = aData
        flag_LNK_FORCE_10BASET_OK        = &H1
    End Property

    Property Get read_LNK_FORCE_10BASET_OK
        read
        read_LNK_FORCE_10BASET_OK = read_LNK_FORCE_10BASET_OK_value
    End Property

    Property Let write_LNK_FORCE_10BASET_OK(aData)
        set_LNK_FORCE_10BASET_OK = aData
        write
    End Property

    Property Get get_LNK_FORCE_10BASET_RDY
        get_LNK_FORCE_10BASET_RDY = read_LNK_FORCE_10BASET_RDY_value
    End Property

    Property Let set_LNK_FORCE_10BASET_RDY(aData)
        write_LNK_FORCE_10BASET_RDY_value = aData
        flag_LNK_FORCE_10BASET_RDY        = &H1
    End Property

    Property Get read_LNK_FORCE_10BASET_RDY
        read
        read_LNK_FORCE_10BASET_RDY = read_LNK_FORCE_10BASET_RDY_value
    End Property

    Property Let write_LNK_FORCE_10BASET_RDY(aData)
        set_LNK_FORCE_10BASET_RDY = aData
        write
    End Property

    Property Get get_LAST_PG_TO_EN
        get_LAST_PG_TO_EN = read_LAST_PG_TO_EN_value
    End Property

    Property Let set_LAST_PG_TO_EN(aData)
        write_LAST_PG_TO_EN_value = aData
        flag_LAST_PG_TO_EN        = &H1
    End Property

    Property Get read_LAST_PG_TO_EN
        read
        read_LAST_PG_TO_EN = read_LAST_PG_TO_EN_value
    End Property

    Property Let write_LAST_PG_TO_EN(aData)
        set_LAST_PG_TO_EN = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_FORCE_LINK_MODE_value = rightShift(data_low, 15) and &H1
        read_CHNG_10GBASET_AN_CTRL_BEHAV_value = rightShift(data_low, 14) and &H1
        read_CHNG_BIT13_MCTRL_RD_BEHAV_value = rightShift(data_low, 13) and &H1
        read_AN_FLP_BTB_TMR_MODE_value = rightShift(data_low, 12) and &H1
        read_SWP_UFORMATED_CODE_FLDS_value = rightShift(data_low, 11) and &H1
        read_BREAK_LINK_TIMER_MODE_value = rightShift(data_low, 10) and &H1
        read_PREAMBLE_IGNORE_value = rightShift(data_low, 9) and &H1
        read_FORCE_LNK_10GBASET_FDX_value = rightShift(data_low, 8) and &H1
        read_FORCE_LNK_1000BASET_FDX_HDX_value = rightShift(data_low, 7) and &H1
        read_IGNORE_ACK2_value = rightShift(data_low, 6) and &H1
        read_LNK_FORCE_100BASET_OK_value = rightShift(data_low, 5) and &H1
        read_LNK_FORCE_100BASET_RDY_value = rightShift(data_low, 4) and &H1
        read_DIS_REG7P0_BIT13_AUTO_UPDATE_value = rightShift(data_low, 3) and &H1
        read_LNK_FORCE_10BASET_OK_value = rightShift(data_low, 2) and &H1
        read_LNK_FORCE_10BASET_RDY_value = rightShift(data_low, 1) and &H1
        LAST_PG_TO_EN_mask = &H1
        if data_low > LONG_MAX then
            if LAST_PG_TO_EN_mask = mask then
                read_LAST_PG_TO_EN_value = data_low
            else
                read_LAST_PG_TO_EN_value = (data_low - H8000_0000) and LAST_PG_TO_EN_mask
            end If
        else
            read_LAST_PG_TO_EN_value = data_low and LAST_PG_TO_EN_mask
        end If

    End Sub

    Sub write
        If flag_FORCE_LINK_MODE = &H0 or flag_CHNG_10GBASET_AN_CTRL_BEHAV = &H0 or flag_CHNG_BIT13_MCTRL_RD_BEHAV = &H0 or flag_AN_FLP_BTB_TMR_MODE = &H0 or flag_SWP_UFORMATED_CODE_FLDS = &H0 or flag_BREAK_LINK_TIMER_MODE = &H0 or flag_PREAMBLE_IGNORE = &H0 or flag_FORCE_LNK_10GBASET_FDX = &H0 or flag_FORCE_LNK_1000BASET_FDX_HDX = &H0 or flag_IGNORE_ACK2 = &H0 or flag_LNK_FORCE_100BASET_OK = &H0 or flag_LNK_FORCE_100BASET_RDY = &H0 or flag_DIS_REG7P0_BIT13_AUTO_UPDATE = &H0 or flag_LNK_FORCE_10BASET_OK = &H0 or flag_LNK_FORCE_10BASET_RDY = &H0 or flag_LAST_PG_TO_EN = &H0 Then read
        If flag_FORCE_LINK_MODE = &H0 Then write_FORCE_LINK_MODE_value = get_FORCE_LINK_MODE
        If flag_CHNG_10GBASET_AN_CTRL_BEHAV = &H0 Then write_CHNG_10GBASET_AN_CTRL_BEHAV_value = get_CHNG_10GBASET_AN_CTRL_BEHAV
        If flag_CHNG_BIT13_MCTRL_RD_BEHAV = &H0 Then write_CHNG_BIT13_MCTRL_RD_BEHAV_value = get_CHNG_BIT13_MCTRL_RD_BEHAV
        If flag_AN_FLP_BTB_TMR_MODE = &H0 Then write_AN_FLP_BTB_TMR_MODE_value = get_AN_FLP_BTB_TMR_MODE
        If flag_SWP_UFORMATED_CODE_FLDS = &H0 Then write_SWP_UFORMATED_CODE_FLDS_value = get_SWP_UFORMATED_CODE_FLDS
        If flag_BREAK_LINK_TIMER_MODE = &H0 Then write_BREAK_LINK_TIMER_MODE_value = get_BREAK_LINK_TIMER_MODE
        If flag_PREAMBLE_IGNORE = &H0 Then write_PREAMBLE_IGNORE_value = get_PREAMBLE_IGNORE
        If flag_FORCE_LNK_10GBASET_FDX = &H0 Then write_FORCE_LNK_10GBASET_FDX_value = get_FORCE_LNK_10GBASET_FDX
        If flag_FORCE_LNK_1000BASET_FDX_HDX = &H0 Then write_FORCE_LNK_1000BASET_FDX_HDX_value = get_FORCE_LNK_1000BASET_FDX_HDX
        If flag_IGNORE_ACK2 = &H0 Then write_IGNORE_ACK2_value = get_IGNORE_ACK2
        If flag_LNK_FORCE_100BASET_OK = &H0 Then write_LNK_FORCE_100BASET_OK_value = get_LNK_FORCE_100BASET_OK
        If flag_LNK_FORCE_100BASET_RDY = &H0 Then write_LNK_FORCE_100BASET_RDY_value = get_LNK_FORCE_100BASET_RDY
        If flag_DIS_REG7P0_BIT13_AUTO_UPDATE = &H0 Then write_DIS_REG7P0_BIT13_AUTO_UPDATE_value = get_DIS_REG7P0_BIT13_AUTO_UPDATE
        If flag_LNK_FORCE_10BASET_OK = &H0 Then write_LNK_FORCE_10BASET_OK_value = get_LNK_FORCE_10BASET_OK
        If flag_LNK_FORCE_10BASET_RDY = &H0 Then write_LNK_FORCE_10BASET_RDY_value = get_LNK_FORCE_10BASET_RDY
        If flag_LAST_PG_TO_EN = &H0 Then write_LAST_PG_TO_EN_value = get_LAST_PG_TO_EN

        regValue = leftShift((write_FORCE_LINK_MODE_value and &H1), 15) + leftShift((write_CHNG_10GBASET_AN_CTRL_BEHAV_value and &H1), 14) + leftShift((write_CHNG_BIT13_MCTRL_RD_BEHAV_value and &H1), 13) + leftShift((write_AN_FLP_BTB_TMR_MODE_value and &H1), 12) + leftShift((write_SWP_UFORMATED_CODE_FLDS_value and &H1), 11) + leftShift((write_BREAK_LINK_TIMER_MODE_value and &H1), 10) + leftShift((write_PREAMBLE_IGNORE_value and &H1), 9) + leftShift((write_FORCE_LNK_10GBASET_FDX_value and &H1), 8) + leftShift((write_FORCE_LNK_1000BASET_FDX_HDX_value and &H1), 7) + leftShift((write_IGNORE_ACK2_value and &H1), 6) + leftShift((write_LNK_FORCE_100BASET_OK_value and &H1), 5) + leftShift((write_LNK_FORCE_100BASET_RDY_value and &H1), 4) + leftShift((write_DIS_REG7P0_BIT13_AUTO_UPDATE_value and &H1), 3) + leftShift((write_LNK_FORCE_10BASET_OK_value and &H1), 2) + leftShift((write_LNK_FORCE_10BASET_RDY_value and &H1), 1) + leftShift((write_LAST_PG_TO_EN_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_FORCE_LINK_MODE_value = rightShift(data_low, 15) and &H1
        read_CHNG_10GBASET_AN_CTRL_BEHAV_value = rightShift(data_low, 14) and &H1
        read_CHNG_BIT13_MCTRL_RD_BEHAV_value = rightShift(data_low, 13) and &H1
        read_AN_FLP_BTB_TMR_MODE_value = rightShift(data_low, 12) and &H1
        read_SWP_UFORMATED_CODE_FLDS_value = rightShift(data_low, 11) and &H1
        read_BREAK_LINK_TIMER_MODE_value = rightShift(data_low, 10) and &H1
        read_PREAMBLE_IGNORE_value = rightShift(data_low, 9) and &H1
        read_FORCE_LNK_10GBASET_FDX_value = rightShift(data_low, 8) and &H1
        read_FORCE_LNK_1000BASET_FDX_HDX_value = rightShift(data_low, 7) and &H1
        read_IGNORE_ACK2_value = rightShift(data_low, 6) and &H1
        read_LNK_FORCE_100BASET_OK_value = rightShift(data_low, 5) and &H1
        read_LNK_FORCE_100BASET_RDY_value = rightShift(data_low, 4) and &H1
        read_DIS_REG7P0_BIT13_AUTO_UPDATE_value = rightShift(data_low, 3) and &H1
        read_LNK_FORCE_10BASET_OK_value = rightShift(data_low, 2) and &H1
        read_LNK_FORCE_10BASET_RDY_value = rightShift(data_low, 1) and &H1
        LAST_PG_TO_EN_mask = &H1
        if data_low > LONG_MAX then
            if LAST_PG_TO_EN_mask = mask then
                read_LAST_PG_TO_EN_value = data_low
            else
                read_LAST_PG_TO_EN_value = (data_low - H8000_0000) and LAST_PG_TO_EN_mask
            end If
        else
            read_LAST_PG_TO_EN_value = data_low and LAST_PG_TO_EN_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_FORCE_LINK_MODE_value = &H0
        flag_FORCE_LINK_MODE        = &H0
        write_CHNG_10GBASET_AN_CTRL_BEHAV_value = &H0
        flag_CHNG_10GBASET_AN_CTRL_BEHAV        = &H0
        write_CHNG_BIT13_MCTRL_RD_BEHAV_value = &H0
        flag_CHNG_BIT13_MCTRL_RD_BEHAV        = &H0
        write_AN_FLP_BTB_TMR_MODE_value = &H0
        flag_AN_FLP_BTB_TMR_MODE        = &H0
        write_SWP_UFORMATED_CODE_FLDS_value = &H0
        flag_SWP_UFORMATED_CODE_FLDS        = &H0
        write_BREAK_LINK_TIMER_MODE_value = &H0
        flag_BREAK_LINK_TIMER_MODE        = &H0
        write_PREAMBLE_IGNORE_value = &H0
        flag_PREAMBLE_IGNORE        = &H0
        write_FORCE_LNK_10GBASET_FDX_value = &H0
        flag_FORCE_LNK_10GBASET_FDX        = &H0
        write_FORCE_LNK_1000BASET_FDX_HDX_value = &H0
        flag_FORCE_LNK_1000BASET_FDX_HDX        = &H0
        write_IGNORE_ACK2_value = &H0
        flag_IGNORE_ACK2        = &H0
        write_LNK_FORCE_100BASET_OK_value = &H0
        flag_LNK_FORCE_100BASET_OK        = &H0
        write_LNK_FORCE_100BASET_RDY_value = &H0
        flag_LNK_FORCE_100BASET_RDY        = &H0
        write_DIS_REG7P0_BIT13_AUTO_UPDATE_value = &H0
        flag_DIS_REG7P0_BIT13_AUTO_UPDATE        = &H0
        write_LNK_FORCE_10BASET_OK_value = &H0
        flag_LNK_FORCE_10BASET_OK        = &H0
        write_LNK_FORCE_10BASET_RDY_value = &H0
        flag_LNK_FORCE_10BASET_RDY        = &H0
        write_LAST_PG_TO_EN_value = &H0
        flag_LAST_PG_TO_EN        = &H0
    End Sub
End Class


'' @REGISTER : CL45VEN_selective_reset
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DSP_RESET                                  [15:15]          get_DSP_RESET
''                                                             set_DSP_RESET
''                                                             read_DSP_RESET
''                                                             write_DSP_RESET
''---------------------------------------------------------------------------------
'' SM_DSP_RESET                               [14:14]          get_SM_DSP_RESET
''                                                             set_SM_DSP_RESET
''                                                             read_SM_DSP_RESET
''                                                             write_SM_DSP_RESET
''---------------------------------------------------------------------------------
'' CHANGE_REG_0x1D_BEHAVIOR                   [13:13]          get_CHANGE_REG_0x1D_BEHAVIOR
''                                                             set_CHANGE_REG_0x1D_BEHAVIOR
''                                                             read_CHANGE_REG_0x1D_BEHAVIOR
''                                                             write_CHANGE_REG_0x1D_BEHAVIOR
''---------------------------------------------------------------------------------
'' DIG100_RESET                               [7:7]            get_DIG100_RESET
''                                                             set_DIG100_RESET
''                                                             read_DIG100_RESET
''                                                             write_DIG100_RESET
''---------------------------------------------------------------------------------
'' FLP_RAMP_TIMER                             [6:1]            get_FLP_RAMP_TIMER
''                                                             set_FLP_RAMP_TIMER
''                                                             read_FLP_RAMP_TIMER
''                                                             write_FLP_RAMP_TIMER
''---------------------------------------------------------------------------------
'' AP10525ED                                  [0:0]            get_AP10525ED
''                                                             set_AP10525ED
''                                                             read_AP10525ED
''                                                             write_AP10525ED
''---------------------------------------------------------------------------------
Class REGISTER_CL45VEN_selective_reset
    Private write_DSP_RESET_value
    Private read_DSP_RESET_value
    Private flag_DSP_RESET
    Private write_SM_DSP_RESET_value
    Private read_SM_DSP_RESET_value
    Private flag_SM_DSP_RESET
    Private write_CHANGE_REG_0x1D_BEHAVIOR_value
    Private read_CHANGE_REG_0x1D_BEHAVIOR_value
    Private flag_CHANGE_REG_0x1D_BEHAVIOR
    Private write_DIG100_RESET_value
    Private read_DIG100_RESET_value
    Private flag_DIG100_RESET
    Private write_FLP_RAMP_TIMER_value
    Private read_FLP_RAMP_TIMER_value
    Private flag_FLP_RAMP_TIMER
    Private write_AP10525ED_value
    Private read_AP10525ED_value
    Private flag_AP10525ED

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

    Property Get get_DSP_RESET
        get_DSP_RESET = read_DSP_RESET_value
    End Property

    Property Let set_DSP_RESET(aData)
        write_DSP_RESET_value = aData
        flag_DSP_RESET        = &H1
    End Property

    Property Get read_DSP_RESET
        read
        read_DSP_RESET = read_DSP_RESET_value
    End Property

    Property Let write_DSP_RESET(aData)
        set_DSP_RESET = aData
        write
    End Property

    Property Get get_SM_DSP_RESET
        get_SM_DSP_RESET = read_SM_DSP_RESET_value
    End Property

    Property Let set_SM_DSP_RESET(aData)
        write_SM_DSP_RESET_value = aData
        flag_SM_DSP_RESET        = &H1
    End Property

    Property Get read_SM_DSP_RESET
        read
        read_SM_DSP_RESET = read_SM_DSP_RESET_value
    End Property

    Property Let write_SM_DSP_RESET(aData)
        set_SM_DSP_RESET = aData
        write
    End Property

    Property Get get_CHANGE_REG_0x1D_BEHAVIOR
        get_CHANGE_REG_0x1D_BEHAVIOR = read_CHANGE_REG_0x1D_BEHAVIOR_value
    End Property

    Property Let set_CHANGE_REG_0x1D_BEHAVIOR(aData)
        write_CHANGE_REG_0x1D_BEHAVIOR_value = aData
        flag_CHANGE_REG_0x1D_BEHAVIOR        = &H1
    End Property

    Property Get read_CHANGE_REG_0x1D_BEHAVIOR
        read
        read_CHANGE_REG_0x1D_BEHAVIOR = read_CHANGE_REG_0x1D_BEHAVIOR_value
    End Property

    Property Let write_CHANGE_REG_0x1D_BEHAVIOR(aData)
        set_CHANGE_REG_0x1D_BEHAVIOR = aData
        write
    End Property

    Property Get get_DIG100_RESET
        get_DIG100_RESET = read_DIG100_RESET_value
    End Property

    Property Let set_DIG100_RESET(aData)
        write_DIG100_RESET_value = aData
        flag_DIG100_RESET        = &H1
    End Property

    Property Get read_DIG100_RESET
        read
        read_DIG100_RESET = read_DIG100_RESET_value
    End Property

    Property Let write_DIG100_RESET(aData)
        set_DIG100_RESET = aData
        write
    End Property

    Property Get get_FLP_RAMP_TIMER
        get_FLP_RAMP_TIMER = read_FLP_RAMP_TIMER_value
    End Property

    Property Let set_FLP_RAMP_TIMER(aData)
        write_FLP_RAMP_TIMER_value = aData
        flag_FLP_RAMP_TIMER        = &H1
    End Property

    Property Get read_FLP_RAMP_TIMER
        read
        read_FLP_RAMP_TIMER = read_FLP_RAMP_TIMER_value
    End Property

    Property Let write_FLP_RAMP_TIMER(aData)
        set_FLP_RAMP_TIMER = aData
        write
    End Property

    Property Get get_AP10525ED
        get_AP10525ED = read_AP10525ED_value
    End Property

    Property Let set_AP10525ED(aData)
        write_AP10525ED_value = aData
        flag_AP10525ED        = &H1
    End Property

    Property Get read_AP10525ED
        read
        read_AP10525ED = read_AP10525ED_value
    End Property

    Property Let write_AP10525ED(aData)
        set_AP10525ED = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_DSP_RESET_value = rightShift(data_low, 15) and &H1
        read_SM_DSP_RESET_value = rightShift(data_low, 14) and &H1
        read_CHANGE_REG_0x1D_BEHAVIOR_value = rightShift(data_low, 13) and &H1
        read_DIG100_RESET_value = rightShift(data_low, 7) and &H1
        read_FLP_RAMP_TIMER_value = rightShift(data_low, 1) and &H3f
        AP10525ED_mask = &H1
        if data_low > LONG_MAX then
            if AP10525ED_mask = mask then
                read_AP10525ED_value = data_low
            else
                read_AP10525ED_value = (data_low - H8000_0000) and AP10525ED_mask
            end If
        else
            read_AP10525ED_value = data_low and AP10525ED_mask
        end If

    End Sub

    Sub write
        If flag_DSP_RESET = &H0 or flag_SM_DSP_RESET = &H0 or flag_CHANGE_REG_0x1D_BEHAVIOR = &H0 or flag_DIG100_RESET = &H0 or flag_FLP_RAMP_TIMER = &H0 or flag_AP10525ED = &H0 Then read
        If flag_DSP_RESET = &H0 Then write_DSP_RESET_value = get_DSP_RESET
        If flag_SM_DSP_RESET = &H0 Then write_SM_DSP_RESET_value = get_SM_DSP_RESET
        If flag_CHANGE_REG_0x1D_BEHAVIOR = &H0 Then write_CHANGE_REG_0x1D_BEHAVIOR_value = get_CHANGE_REG_0x1D_BEHAVIOR
        If flag_DIG100_RESET = &H0 Then write_DIG100_RESET_value = get_DIG100_RESET
        If flag_FLP_RAMP_TIMER = &H0 Then write_FLP_RAMP_TIMER_value = get_FLP_RAMP_TIMER
        If flag_AP10525ED = &H0 Then write_AP10525ED_value = get_AP10525ED

        regValue = leftShift((write_DSP_RESET_value and &H1), 15) + leftShift((write_SM_DSP_RESET_value and &H1), 14) + leftShift((write_CHANGE_REG_0x1D_BEHAVIOR_value and &H1), 13) + leftShift((write_DIG100_RESET_value and &H1), 7) + leftShift((write_FLP_RAMP_TIMER_value and &H3f), 1) + leftShift((write_AP10525ED_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_DSP_RESET_value = rightShift(data_low, 15) and &H1
        read_SM_DSP_RESET_value = rightShift(data_low, 14) and &H1
        read_CHANGE_REG_0x1D_BEHAVIOR_value = rightShift(data_low, 13) and &H1
        read_DIG100_RESET_value = rightShift(data_low, 7) and &H1
        read_FLP_RAMP_TIMER_value = rightShift(data_low, 1) and &H3f
        AP10525ED_mask = &H1
        if data_low > LONG_MAX then
            if AP10525ED_mask = mask then
                read_AP10525ED_value = data_low
            else
                read_AP10525ED_value = (data_low - H8000_0000) and AP10525ED_mask
            end If
        else
            read_AP10525ED_value = data_low and AP10525ED_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DSP_RESET_value = &H0
        flag_DSP_RESET        = &H0
        write_SM_DSP_RESET_value = &H0
        flag_SM_DSP_RESET        = &H0
        write_CHANGE_REG_0x1D_BEHAVIOR_value = &H0
        flag_CHANGE_REG_0x1D_BEHAVIOR        = &H0
        write_DIG100_RESET_value = &H0
        flag_DIG100_RESET        = &H0
        write_FLP_RAMP_TIMER_value = &H0
        flag_FLP_RAMP_TIMER        = &H0
        write_AP10525ED_value = &H0
        flag_AP10525ED        = &H0
    End Sub
End Class


'' @REGISTER : CL45VEN_test_fsm_ext_nxt_pgs
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' XNP_XMTR_STATE                             [14:12]          get_XNP_XMTR_STATE
''                                                             set_XNP_XMTR_STATE
''                                                             read_XNP_XMTR_STATE
''                                                             write_XNP_XMTR_STATE
''---------------------------------------------------------------------------------
'' XNP_RCVR_STATE                             [10:8]           get_XNP_RCVR_STATE
''                                                             set_XNP_RCVR_STATE
''                                                             read_XNP_RCVR_STATE
''                                                             write_XNP_RCVR_STATE
''---------------------------------------------------------------------------------
'' ARB_STATE                                  [7:4]            get_ARB_STATE
''                                                             set_ARB_STATE
''                                                             read_ARB_STATE
''                                                             write_ARB_STATE
''---------------------------------------------------------------------------------
'' HCD_STATE                                  [3:0]            get_HCD_STATE
''                                                             set_HCD_STATE
''                                                             read_HCD_STATE
''                                                             write_HCD_STATE
''---------------------------------------------------------------------------------
Class REGISTER_CL45VEN_test_fsm_ext_nxt_pgs
    Private write_XNP_XMTR_STATE_value
    Private read_XNP_XMTR_STATE_value
    Private flag_XNP_XMTR_STATE
    Private write_XNP_RCVR_STATE_value
    Private read_XNP_RCVR_STATE_value
    Private flag_XNP_RCVR_STATE
    Private write_ARB_STATE_value
    Private read_ARB_STATE_value
    Private flag_ARB_STATE
    Private write_HCD_STATE_value
    Private read_HCD_STATE_value
    Private flag_HCD_STATE

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

    Property Get get_XNP_XMTR_STATE
        get_XNP_XMTR_STATE = read_XNP_XMTR_STATE_value
    End Property

    Property Let set_XNP_XMTR_STATE(aData)
        write_XNP_XMTR_STATE_value = aData
        flag_XNP_XMTR_STATE        = &H1
    End Property

    Property Get read_XNP_XMTR_STATE
        read
        read_XNP_XMTR_STATE = read_XNP_XMTR_STATE_value
    End Property

    Property Let write_XNP_XMTR_STATE(aData)
        set_XNP_XMTR_STATE = aData
        write
    End Property

    Property Get get_XNP_RCVR_STATE
        get_XNP_RCVR_STATE = read_XNP_RCVR_STATE_value
    End Property

    Property Let set_XNP_RCVR_STATE(aData)
        write_XNP_RCVR_STATE_value = aData
        flag_XNP_RCVR_STATE        = &H1
    End Property

    Property Get read_XNP_RCVR_STATE
        read
        read_XNP_RCVR_STATE = read_XNP_RCVR_STATE_value
    End Property

    Property Let write_XNP_RCVR_STATE(aData)
        set_XNP_RCVR_STATE = aData
        write
    End Property

    Property Get get_ARB_STATE
        get_ARB_STATE = read_ARB_STATE_value
    End Property

    Property Let set_ARB_STATE(aData)
        write_ARB_STATE_value = aData
        flag_ARB_STATE        = &H1
    End Property

    Property Get read_ARB_STATE
        read
        read_ARB_STATE = read_ARB_STATE_value
    End Property

    Property Let write_ARB_STATE(aData)
        set_ARB_STATE = aData
        write
    End Property

    Property Get get_HCD_STATE
        get_HCD_STATE = read_HCD_STATE_value
    End Property

    Property Let set_HCD_STATE(aData)
        write_HCD_STATE_value = aData
        flag_HCD_STATE        = &H1
    End Property

    Property Get read_HCD_STATE
        read
        read_HCD_STATE = read_HCD_STATE_value
    End Property

    Property Let write_HCD_STATE(aData)
        set_HCD_STATE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_XNP_XMTR_STATE_value = rightShift(data_low, 12) and &H7
        read_XNP_RCVR_STATE_value = rightShift(data_low, 8) and &H7
        read_ARB_STATE_value = rightShift(data_low, 4) and &Hf
        HCD_STATE_mask = &Hf
        if data_low > LONG_MAX then
            if HCD_STATE_mask = mask then
                read_HCD_STATE_value = data_low
            else
                read_HCD_STATE_value = (data_low - H8000_0000) and HCD_STATE_mask
            end If
        else
            read_HCD_STATE_value = data_low and HCD_STATE_mask
        end If

    End Sub

    Sub write
        If flag_XNP_XMTR_STATE = &H0 or flag_XNP_RCVR_STATE = &H0 or flag_ARB_STATE = &H0 or flag_HCD_STATE = &H0 Then read
        If flag_XNP_XMTR_STATE = &H0 Then write_XNP_XMTR_STATE_value = get_XNP_XMTR_STATE
        If flag_XNP_RCVR_STATE = &H0 Then write_XNP_RCVR_STATE_value = get_XNP_RCVR_STATE
        If flag_ARB_STATE = &H0 Then write_ARB_STATE_value = get_ARB_STATE
        If flag_HCD_STATE = &H0 Then write_HCD_STATE_value = get_HCD_STATE

        regValue = leftShift((write_XNP_XMTR_STATE_value and &H7), 12) + leftShift((write_XNP_RCVR_STATE_value and &H7), 8) + leftShift((write_ARB_STATE_value and &Hf), 4) + leftShift((write_HCD_STATE_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_XNP_XMTR_STATE_value = rightShift(data_low, 12) and &H7
        read_XNP_RCVR_STATE_value = rightShift(data_low, 8) and &H7
        read_ARB_STATE_value = rightShift(data_low, 4) and &Hf
        HCD_STATE_mask = &Hf
        if data_low > LONG_MAX then
            if HCD_STATE_mask = mask then
                read_HCD_STATE_value = data_low
            else
                read_HCD_STATE_value = (data_low - H8000_0000) and HCD_STATE_mask
            end If
        else
            read_HCD_STATE_value = data_low and HCD_STATE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_XNP_XMTR_STATE_value = &H0
        flag_XNP_XMTR_STATE        = &H0
        write_XNP_RCVR_STATE_value = &H0
        flag_XNP_RCVR_STATE        = &H0
        write_ARB_STATE_value = &H0
        flag_ARB_STATE        = &H0
        write_HCD_STATE_value = &H0
        flag_HCD_STATE        = &H0
    End Sub
End Class


'' @REGISTER : CL45VEN_test_fsm_nxt_pgs
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' NP_XMTR_STATE                              [9:5]            get_NP_XMTR_STATE
''                                                             set_NP_XMTR_STATE
''                                                             read_NP_XMTR_STATE
''                                                             write_NP_XMTR_STATE
''---------------------------------------------------------------------------------
'' NP_RCVR_STATE                              [3:0]            get_NP_RCVR_STATE
''                                                             set_NP_RCVR_STATE
''                                                             read_NP_RCVR_STATE
''                                                             write_NP_RCVR_STATE
''---------------------------------------------------------------------------------
Class REGISTER_CL45VEN_test_fsm_nxt_pgs
    Private write_NP_XMTR_STATE_value
    Private read_NP_XMTR_STATE_value
    Private flag_NP_XMTR_STATE
    Private write_NP_RCVR_STATE_value
    Private read_NP_RCVR_STATE_value
    Private flag_NP_RCVR_STATE

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

    Property Get get_NP_XMTR_STATE
        get_NP_XMTR_STATE = read_NP_XMTR_STATE_value
    End Property

    Property Let set_NP_XMTR_STATE(aData)
        write_NP_XMTR_STATE_value = aData
        flag_NP_XMTR_STATE        = &H1
    End Property

    Property Get read_NP_XMTR_STATE
        read
        read_NP_XMTR_STATE = read_NP_XMTR_STATE_value
    End Property

    Property Let write_NP_XMTR_STATE(aData)
        set_NP_XMTR_STATE = aData
        write
    End Property

    Property Get get_NP_RCVR_STATE
        get_NP_RCVR_STATE = read_NP_RCVR_STATE_value
    End Property

    Property Let set_NP_RCVR_STATE(aData)
        write_NP_RCVR_STATE_value = aData
        flag_NP_RCVR_STATE        = &H1
    End Property

    Property Get read_NP_RCVR_STATE
        read
        read_NP_RCVR_STATE = read_NP_RCVR_STATE_value
    End Property

    Property Let write_NP_RCVR_STATE(aData)
        set_NP_RCVR_STATE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_NP_XMTR_STATE_value = rightShift(data_low, 5) and &H1f
        NP_RCVR_STATE_mask = &Hf
        if data_low > LONG_MAX then
            if NP_RCVR_STATE_mask = mask then
                read_NP_RCVR_STATE_value = data_low
            else
                read_NP_RCVR_STATE_value = (data_low - H8000_0000) and NP_RCVR_STATE_mask
            end If
        else
            read_NP_RCVR_STATE_value = data_low and NP_RCVR_STATE_mask
        end If

    End Sub

    Sub write
        If flag_NP_XMTR_STATE = &H0 or flag_NP_RCVR_STATE = &H0 Then read
        If flag_NP_XMTR_STATE = &H0 Then write_NP_XMTR_STATE_value = get_NP_XMTR_STATE
        If flag_NP_RCVR_STATE = &H0 Then write_NP_RCVR_STATE_value = get_NP_RCVR_STATE

        regValue = leftShift((write_NP_XMTR_STATE_value and &H1f), 5) + leftShift((write_NP_RCVR_STATE_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_NP_XMTR_STATE_value = rightShift(data_low, 5) and &H1f
        NP_RCVR_STATE_mask = &Hf
        if data_low > LONG_MAX then
            if NP_RCVR_STATE_mask = mask then
                read_NP_RCVR_STATE_value = data_low
            else
                read_NP_RCVR_STATE_value = (data_low - H8000_0000) and NP_RCVR_STATE_mask
            end If
        else
            read_NP_RCVR_STATE_value = data_low and NP_RCVR_STATE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_NP_XMTR_STATE_value = &H0
        flag_NP_XMTR_STATE        = &H0
        write_NP_RCVR_STATE_value = &H0
        flag_NP_RCVR_STATE        = &H0
    End Sub
End Class


'' @REGISTER : CL45VEN_wirespeed_stat
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MASK_10G                                   [13:13]          get_MASK_10G
''                                                             set_MASK_10G
''                                                             read_MASK_10G
''                                                             write_MASK_10G
''---------------------------------------------------------------------------------
'' MASK_5G                                    [12:12]          get_MASK_5G
''                                                             set_MASK_5G
''                                                             read_MASK_5G
''                                                             write_MASK_5G
''---------------------------------------------------------------------------------
'' MASK_2P5G                                  [11:11]          get_MASK_2P5G
''                                                             set_MASK_2P5G
''                                                             read_MASK_2P5G
''                                                             write_MASK_2P5G
''---------------------------------------------------------------------------------
'' MASK_1000T                                 [10:10]          get_MASK_1000T
''                                                             set_MASK_1000T
''                                                             read_MASK_1000T
''                                                             write_MASK_1000T
''---------------------------------------------------------------------------------
'' MASK_100TX                                 [9:9]            get_MASK_100TX
''                                                             set_MASK_100TX
''                                                             read_MASK_100TX
''                                                             write_MASK_100TX
''---------------------------------------------------------------------------------
'' WIRESPEED_DOWNGRADE                        [8:8]            get_WIRESPEED_DOWNGRADE
''                                                             set_WIRESPEED_DOWNGRADE
''                                                             read_WIRESPEED_DOWNGRADE
''                                                             write_WIRESPEED_DOWNGRADE
''---------------------------------------------------------------------------------
'' WIRESPEED_FSM_STATE                        [6:4]            get_WIRESPEED_FSM_STATE
''                                                             set_WIRESPEED_FSM_STATE
''                                                             read_WIRESPEED_FSM_STATE
''                                                             write_WIRESPEED_FSM_STATE
''---------------------------------------------------------------------------------
'' WIRESPEED_COUNTER                          [3:0]            get_WIRESPEED_COUNTER
''                                                             set_WIRESPEED_COUNTER
''                                                             read_WIRESPEED_COUNTER
''                                                             write_WIRESPEED_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_CL45VEN_wirespeed_stat
    Private write_MASK_10G_value
    Private read_MASK_10G_value
    Private flag_MASK_10G
    Private write_MASK_5G_value
    Private read_MASK_5G_value
    Private flag_MASK_5G
    Private write_MASK_2P5G_value
    Private read_MASK_2P5G_value
    Private flag_MASK_2P5G
    Private write_MASK_1000T_value
    Private read_MASK_1000T_value
    Private flag_MASK_1000T
    Private write_MASK_100TX_value
    Private read_MASK_100TX_value
    Private flag_MASK_100TX
    Private write_WIRESPEED_DOWNGRADE_value
    Private read_WIRESPEED_DOWNGRADE_value
    Private flag_WIRESPEED_DOWNGRADE
    Private write_WIRESPEED_FSM_STATE_value
    Private read_WIRESPEED_FSM_STATE_value
    Private flag_WIRESPEED_FSM_STATE
    Private write_WIRESPEED_COUNTER_value
    Private read_WIRESPEED_COUNTER_value
    Private flag_WIRESPEED_COUNTER

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

    Property Get get_MASK_10G
        get_MASK_10G = read_MASK_10G_value
    End Property

    Property Let set_MASK_10G(aData)
        write_MASK_10G_value = aData
        flag_MASK_10G        = &H1
    End Property

    Property Get read_MASK_10G
        read
        read_MASK_10G = read_MASK_10G_value
    End Property

    Property Let write_MASK_10G(aData)
        set_MASK_10G = aData
        write
    End Property

    Property Get get_MASK_5G
        get_MASK_5G = read_MASK_5G_value
    End Property

    Property Let set_MASK_5G(aData)
        write_MASK_5G_value = aData
        flag_MASK_5G        = &H1
    End Property

    Property Get read_MASK_5G
        read
        read_MASK_5G = read_MASK_5G_value
    End Property

    Property Let write_MASK_5G(aData)
        set_MASK_5G = aData
        write
    End Property

    Property Get get_MASK_2P5G
        get_MASK_2P5G = read_MASK_2P5G_value
    End Property

    Property Let set_MASK_2P5G(aData)
        write_MASK_2P5G_value = aData
        flag_MASK_2P5G        = &H1
    End Property

    Property Get read_MASK_2P5G
        read
        read_MASK_2P5G = read_MASK_2P5G_value
    End Property

    Property Let write_MASK_2P5G(aData)
        set_MASK_2P5G = aData
        write
    End Property

    Property Get get_MASK_1000T
        get_MASK_1000T = read_MASK_1000T_value
    End Property

    Property Let set_MASK_1000T(aData)
        write_MASK_1000T_value = aData
        flag_MASK_1000T        = &H1
    End Property

    Property Get read_MASK_1000T
        read
        read_MASK_1000T = read_MASK_1000T_value
    End Property

    Property Let write_MASK_1000T(aData)
        set_MASK_1000T = aData
        write
    End Property

    Property Get get_MASK_100TX
        get_MASK_100TX = read_MASK_100TX_value
    End Property

    Property Let set_MASK_100TX(aData)
        write_MASK_100TX_value = aData
        flag_MASK_100TX        = &H1
    End Property

    Property Get read_MASK_100TX
        read
        read_MASK_100TX = read_MASK_100TX_value
    End Property

    Property Let write_MASK_100TX(aData)
        set_MASK_100TX = aData
        write
    End Property

    Property Get get_WIRESPEED_DOWNGRADE
        get_WIRESPEED_DOWNGRADE = read_WIRESPEED_DOWNGRADE_value
    End Property

    Property Let set_WIRESPEED_DOWNGRADE(aData)
        write_WIRESPEED_DOWNGRADE_value = aData
        flag_WIRESPEED_DOWNGRADE        = &H1
    End Property

    Property Get read_WIRESPEED_DOWNGRADE
        read
        read_WIRESPEED_DOWNGRADE = read_WIRESPEED_DOWNGRADE_value
    End Property

    Property Let write_WIRESPEED_DOWNGRADE(aData)
        set_WIRESPEED_DOWNGRADE = aData
        write
    End Property

    Property Get get_WIRESPEED_FSM_STATE
        get_WIRESPEED_FSM_STATE = read_WIRESPEED_FSM_STATE_value
    End Property

    Property Let set_WIRESPEED_FSM_STATE(aData)
        write_WIRESPEED_FSM_STATE_value = aData
        flag_WIRESPEED_FSM_STATE        = &H1
    End Property

    Property Get read_WIRESPEED_FSM_STATE
        read
        read_WIRESPEED_FSM_STATE = read_WIRESPEED_FSM_STATE_value
    End Property

    Property Let write_WIRESPEED_FSM_STATE(aData)
        set_WIRESPEED_FSM_STATE = aData
        write
    End Property

    Property Get get_WIRESPEED_COUNTER
        get_WIRESPEED_COUNTER = read_WIRESPEED_COUNTER_value
    End Property

    Property Let set_WIRESPEED_COUNTER(aData)
        write_WIRESPEED_COUNTER_value = aData
        flag_WIRESPEED_COUNTER        = &H1
    End Property

    Property Get read_WIRESPEED_COUNTER
        read
        read_WIRESPEED_COUNTER = read_WIRESPEED_COUNTER_value
    End Property

    Property Let write_WIRESPEED_COUNTER(aData)
        set_WIRESPEED_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MASK_10G_value = rightShift(data_low, 13) and &H1
        read_MASK_5G_value = rightShift(data_low, 12) and &H1
        read_MASK_2P5G_value = rightShift(data_low, 11) and &H1
        read_MASK_1000T_value = rightShift(data_low, 10) and &H1
        read_MASK_100TX_value = rightShift(data_low, 9) and &H1
        read_WIRESPEED_DOWNGRADE_value = rightShift(data_low, 8) and &H1
        read_WIRESPEED_FSM_STATE_value = rightShift(data_low, 4) and &H7
        WIRESPEED_COUNTER_mask = &Hf
        if data_low > LONG_MAX then
            if WIRESPEED_COUNTER_mask = mask then
                read_WIRESPEED_COUNTER_value = data_low
            else
                read_WIRESPEED_COUNTER_value = (data_low - H8000_0000) and WIRESPEED_COUNTER_mask
            end If
        else
            read_WIRESPEED_COUNTER_value = data_low and WIRESPEED_COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_MASK_10G = &H0 or flag_MASK_5G = &H0 or flag_MASK_2P5G = &H0 or flag_MASK_1000T = &H0 or flag_MASK_100TX = &H0 or flag_WIRESPEED_DOWNGRADE = &H0 or flag_WIRESPEED_FSM_STATE = &H0 or flag_WIRESPEED_COUNTER = &H0 Then read
        If flag_MASK_10G = &H0 Then write_MASK_10G_value = get_MASK_10G
        If flag_MASK_5G = &H0 Then write_MASK_5G_value = get_MASK_5G
        If flag_MASK_2P5G = &H0 Then write_MASK_2P5G_value = get_MASK_2P5G
        If flag_MASK_1000T = &H0 Then write_MASK_1000T_value = get_MASK_1000T
        If flag_MASK_100TX = &H0 Then write_MASK_100TX_value = get_MASK_100TX
        If flag_WIRESPEED_DOWNGRADE = &H0 Then write_WIRESPEED_DOWNGRADE_value = get_WIRESPEED_DOWNGRADE
        If flag_WIRESPEED_FSM_STATE = &H0 Then write_WIRESPEED_FSM_STATE_value = get_WIRESPEED_FSM_STATE
        If flag_WIRESPEED_COUNTER = &H0 Then write_WIRESPEED_COUNTER_value = get_WIRESPEED_COUNTER

        regValue = leftShift((write_MASK_10G_value and &H1), 13) + leftShift((write_MASK_5G_value and &H1), 12) + leftShift((write_MASK_2P5G_value and &H1), 11) + leftShift((write_MASK_1000T_value and &H1), 10) + leftShift((write_MASK_100TX_value and &H1), 9) + leftShift((write_WIRESPEED_DOWNGRADE_value and &H1), 8) + leftShift((write_WIRESPEED_FSM_STATE_value and &H7), 4) + leftShift((write_WIRESPEED_COUNTER_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MASK_10G_value = rightShift(data_low, 13) and &H1
        read_MASK_5G_value = rightShift(data_low, 12) and &H1
        read_MASK_2P5G_value = rightShift(data_low, 11) and &H1
        read_MASK_1000T_value = rightShift(data_low, 10) and &H1
        read_MASK_100TX_value = rightShift(data_low, 9) and &H1
        read_WIRESPEED_DOWNGRADE_value = rightShift(data_low, 8) and &H1
        read_WIRESPEED_FSM_STATE_value = rightShift(data_low, 4) and &H7
        WIRESPEED_COUNTER_mask = &Hf
        if data_low > LONG_MAX then
            if WIRESPEED_COUNTER_mask = mask then
                read_WIRESPEED_COUNTER_value = data_low
            else
                read_WIRESPEED_COUNTER_value = (data_low - H8000_0000) and WIRESPEED_COUNTER_mask
            end If
        else
            read_WIRESPEED_COUNTER_value = data_low and WIRESPEED_COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MASK_10G_value = &H0
        flag_MASK_10G        = &H0
        write_MASK_5G_value = &H0
        flag_MASK_5G        = &H0
        write_MASK_2P5G_value = &H0
        flag_MASK_2P5G        = &H0
        write_MASK_1000T_value = &H0
        flag_MASK_1000T        = &H0
        write_MASK_100TX_value = &H0
        flag_MASK_100TX        = &H0
        write_WIRESPEED_DOWNGRADE_value = &H0
        flag_WIRESPEED_DOWNGRADE        = &H0
        write_WIRESPEED_FSM_STATE_value = &H0
        flag_WIRESPEED_FSM_STATE        = &H0
        write_WIRESPEED_COUNTER_value = &H0
        flag_WIRESPEED_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : CL45VEN_an_man_test
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LP_PG_TO_CAPTURE                           [11:8]           get_LP_PG_TO_CAPTURE
''                                                             set_LP_PG_TO_CAPTURE
''                                                             read_LP_PG_TO_CAPTURE
''                                                             write_LP_PG_TO_CAPTURE
''---------------------------------------------------------------------------------
'' LNK_PARTNR_NXT_PG_TEST_MODE                [2:2]            get_LNK_PARTNR_NXT_PG_TEST_MODE
''                                                             set_LNK_PARTNR_NXT_PG_TEST_MODE
''                                                             read_LNK_PARTNR_NXT_PG_TEST_MODE
''                                                             write_LNK_PARTNR_NXT_PG_TEST_MODE
''---------------------------------------------------------------------------------
'' MAN_TEST_EN_SEED                           [1:1]            get_MAN_TEST_EN_SEED
''                                                             set_MAN_TEST_EN_SEED
''                                                             read_MAN_TEST_EN_SEED
''                                                             write_MAN_TEST_EN_SEED
''---------------------------------------------------------------------------------
'' MAN_TEST_EN                                [0:0]            get_MAN_TEST_EN
''                                                             set_MAN_TEST_EN
''                                                             read_MAN_TEST_EN
''                                                             write_MAN_TEST_EN
''---------------------------------------------------------------------------------
Class REGISTER_CL45VEN_an_man_test
    Private write_LP_PG_TO_CAPTURE_value
    Private read_LP_PG_TO_CAPTURE_value
    Private flag_LP_PG_TO_CAPTURE
    Private write_LNK_PARTNR_NXT_PG_TEST_MODE_value
    Private read_LNK_PARTNR_NXT_PG_TEST_MODE_value
    Private flag_LNK_PARTNR_NXT_PG_TEST_MODE
    Private write_MAN_TEST_EN_SEED_value
    Private read_MAN_TEST_EN_SEED_value
    Private flag_MAN_TEST_EN_SEED
    Private write_MAN_TEST_EN_value
    Private read_MAN_TEST_EN_value
    Private flag_MAN_TEST_EN

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

    Property Get get_LP_PG_TO_CAPTURE
        get_LP_PG_TO_CAPTURE = read_LP_PG_TO_CAPTURE_value
    End Property

    Property Let set_LP_PG_TO_CAPTURE(aData)
        write_LP_PG_TO_CAPTURE_value = aData
        flag_LP_PG_TO_CAPTURE        = &H1
    End Property

    Property Get read_LP_PG_TO_CAPTURE
        read
        read_LP_PG_TO_CAPTURE = read_LP_PG_TO_CAPTURE_value
    End Property

    Property Let write_LP_PG_TO_CAPTURE(aData)
        set_LP_PG_TO_CAPTURE = aData
        write
    End Property

    Property Get get_LNK_PARTNR_NXT_PG_TEST_MODE
        get_LNK_PARTNR_NXT_PG_TEST_MODE = read_LNK_PARTNR_NXT_PG_TEST_MODE_value
    End Property

    Property Let set_LNK_PARTNR_NXT_PG_TEST_MODE(aData)
        write_LNK_PARTNR_NXT_PG_TEST_MODE_value = aData
        flag_LNK_PARTNR_NXT_PG_TEST_MODE        = &H1
    End Property

    Property Get read_LNK_PARTNR_NXT_PG_TEST_MODE
        read
        read_LNK_PARTNR_NXT_PG_TEST_MODE = read_LNK_PARTNR_NXT_PG_TEST_MODE_value
    End Property

    Property Let write_LNK_PARTNR_NXT_PG_TEST_MODE(aData)
        set_LNK_PARTNR_NXT_PG_TEST_MODE = aData
        write
    End Property

    Property Get get_MAN_TEST_EN_SEED
        get_MAN_TEST_EN_SEED = read_MAN_TEST_EN_SEED_value
    End Property

    Property Let set_MAN_TEST_EN_SEED(aData)
        write_MAN_TEST_EN_SEED_value = aData
        flag_MAN_TEST_EN_SEED        = &H1
    End Property

    Property Get read_MAN_TEST_EN_SEED
        read
        read_MAN_TEST_EN_SEED = read_MAN_TEST_EN_SEED_value
    End Property

    Property Let write_MAN_TEST_EN_SEED(aData)
        set_MAN_TEST_EN_SEED = aData
        write
    End Property

    Property Get get_MAN_TEST_EN
        get_MAN_TEST_EN = read_MAN_TEST_EN_value
    End Property

    Property Let set_MAN_TEST_EN(aData)
        write_MAN_TEST_EN_value = aData
        flag_MAN_TEST_EN        = &H1
    End Property

    Property Get read_MAN_TEST_EN
        read
        read_MAN_TEST_EN = read_MAN_TEST_EN_value
    End Property

    Property Let write_MAN_TEST_EN(aData)
        set_MAN_TEST_EN = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LP_PG_TO_CAPTURE_value = rightShift(data_low, 8) and &Hf
        read_LNK_PARTNR_NXT_PG_TEST_MODE_value = rightShift(data_low, 2) and &H1
        read_MAN_TEST_EN_SEED_value = rightShift(data_low, 1) and &H1
        MAN_TEST_EN_mask = &H1
        if data_low > LONG_MAX then
            if MAN_TEST_EN_mask = mask then
                read_MAN_TEST_EN_value = data_low
            else
                read_MAN_TEST_EN_value = (data_low - H8000_0000) and MAN_TEST_EN_mask
            end If
        else
            read_MAN_TEST_EN_value = data_low and MAN_TEST_EN_mask
        end If

    End Sub

    Sub write
        If flag_LP_PG_TO_CAPTURE = &H0 or flag_LNK_PARTNR_NXT_PG_TEST_MODE = &H0 or flag_MAN_TEST_EN_SEED = &H0 or flag_MAN_TEST_EN = &H0 Then read
        If flag_LP_PG_TO_CAPTURE = &H0 Then write_LP_PG_TO_CAPTURE_value = get_LP_PG_TO_CAPTURE
        If flag_LNK_PARTNR_NXT_PG_TEST_MODE = &H0 Then write_LNK_PARTNR_NXT_PG_TEST_MODE_value = get_LNK_PARTNR_NXT_PG_TEST_MODE
        If flag_MAN_TEST_EN_SEED = &H0 Then write_MAN_TEST_EN_SEED_value = get_MAN_TEST_EN_SEED
        If flag_MAN_TEST_EN = &H0 Then write_MAN_TEST_EN_value = get_MAN_TEST_EN

        regValue = leftShift((write_LP_PG_TO_CAPTURE_value and &Hf), 8) + leftShift((write_LNK_PARTNR_NXT_PG_TEST_MODE_value and &H1), 2) + leftShift((write_MAN_TEST_EN_SEED_value and &H1), 1) + leftShift((write_MAN_TEST_EN_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LP_PG_TO_CAPTURE_value = rightShift(data_low, 8) and &Hf
        read_LNK_PARTNR_NXT_PG_TEST_MODE_value = rightShift(data_low, 2) and &H1
        read_MAN_TEST_EN_SEED_value = rightShift(data_low, 1) and &H1
        MAN_TEST_EN_mask = &H1
        if data_low > LONG_MAX then
            if MAN_TEST_EN_mask = mask then
                read_MAN_TEST_EN_value = data_low
            else
                read_MAN_TEST_EN_value = (data_low - H8000_0000) and MAN_TEST_EN_mask
            end If
        else
            read_MAN_TEST_EN_value = data_low and MAN_TEST_EN_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LP_PG_TO_CAPTURE_value = &H0
        flag_LP_PG_TO_CAPTURE        = &H0
        write_LNK_PARTNR_NXT_PG_TEST_MODE_value = &H0
        flag_LNK_PARTNR_NXT_PG_TEST_MODE        = &H0
        write_MAN_TEST_EN_SEED_value = &H0
        flag_MAN_TEST_EN_SEED        = &H0
        write_MAN_TEST_EN_value = &H0
        flag_MAN_TEST_EN        = &H0
    End Sub
End Class


'' @REGISTER : CL45VEN_an_man_lnk_partnr_abi_a
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MAN_LP_1000TX_HDX                          [15:15]          get_MAN_LP_1000TX_HDX
''                                                             set_MAN_LP_1000TX_HDX
''                                                             read_MAN_LP_1000TX_HDX
''                                                             write_MAN_LP_1000TX_HDX
''---------------------------------------------------------------------------------
'' MAN_LP_1000TX_FDX                          [14:14]          get_MAN_LP_1000TX_FDX
''                                                             set_MAN_LP_1000TX_FDX
''                                                             read_MAN_LP_1000TX_FDX
''                                                             write_MAN_LP_1000TX_FDX
''---------------------------------------------------------------------------------
'' MAN_LP_PORT_TYPE                           [13:13]          get_MAN_LP_PORT_TYPE
''                                                             set_MAN_LP_PORT_TYPE
''                                                             read_MAN_LP_PORT_TYPE
''                                                             write_MAN_LP_PORT_TYPE
''---------------------------------------------------------------------------------
'' MAN_LP_MS_CONFIG_VALUE                     [12:12]          get_MAN_LP_MS_CONFIG_VALUE
''                                                             set_MAN_LP_MS_CONFIG_VALUE
''                                                             read_MAN_LP_MS_CONFIG_VALUE
''                                                             write_MAN_LP_MS_CONFIG_VALUE
''---------------------------------------------------------------------------------
'' MAN_LP_MS_MANUAL_CONFIG_EN                 [11:11]          get_MAN_LP_MS_MANUAL_CONFIG_EN
''                                                             set_MAN_LP_MS_MANUAL_CONFIG_EN
''                                                             read_MAN_LP_MS_MANUAL_CONFIG_EN
''                                                             write_MAN_LP_MS_MANUAL_CONFIG_EN
''---------------------------------------------------------------------------------
'' MAN_LP_SEED                                [10:0]           get_MAN_LP_SEED
''                                                             set_MAN_LP_SEED
''                                                             read_MAN_LP_SEED
''                                                             write_MAN_LP_SEED
''---------------------------------------------------------------------------------
Class REGISTER_CL45VEN_an_man_lnk_partnr_abi_a
    Private write_MAN_LP_1000TX_HDX_value
    Private read_MAN_LP_1000TX_HDX_value
    Private flag_MAN_LP_1000TX_HDX
    Private write_MAN_LP_1000TX_FDX_value
    Private read_MAN_LP_1000TX_FDX_value
    Private flag_MAN_LP_1000TX_FDX
    Private write_MAN_LP_PORT_TYPE_value
    Private read_MAN_LP_PORT_TYPE_value
    Private flag_MAN_LP_PORT_TYPE
    Private write_MAN_LP_MS_CONFIG_VALUE_value
    Private read_MAN_LP_MS_CONFIG_VALUE_value
    Private flag_MAN_LP_MS_CONFIG_VALUE
    Private write_MAN_LP_MS_MANUAL_CONFIG_EN_value
    Private read_MAN_LP_MS_MANUAL_CONFIG_EN_value
    Private flag_MAN_LP_MS_MANUAL_CONFIG_EN
    Private write_MAN_LP_SEED_value
    Private read_MAN_LP_SEED_value
    Private flag_MAN_LP_SEED

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

    Property Get get_MAN_LP_1000TX_HDX
        get_MAN_LP_1000TX_HDX = read_MAN_LP_1000TX_HDX_value
    End Property

    Property Let set_MAN_LP_1000TX_HDX(aData)
        write_MAN_LP_1000TX_HDX_value = aData
        flag_MAN_LP_1000TX_HDX        = &H1
    End Property

    Property Get read_MAN_LP_1000TX_HDX
        read
        read_MAN_LP_1000TX_HDX = read_MAN_LP_1000TX_HDX_value
    End Property

    Property Let write_MAN_LP_1000TX_HDX(aData)
        set_MAN_LP_1000TX_HDX = aData
        write
    End Property

    Property Get get_MAN_LP_1000TX_FDX
        get_MAN_LP_1000TX_FDX = read_MAN_LP_1000TX_FDX_value
    End Property

    Property Let set_MAN_LP_1000TX_FDX(aData)
        write_MAN_LP_1000TX_FDX_value = aData
        flag_MAN_LP_1000TX_FDX        = &H1
    End Property

    Property Get read_MAN_LP_1000TX_FDX
        read
        read_MAN_LP_1000TX_FDX = read_MAN_LP_1000TX_FDX_value
    End Property

    Property Let write_MAN_LP_1000TX_FDX(aData)
        set_MAN_LP_1000TX_FDX = aData
        write
    End Property

    Property Get get_MAN_LP_PORT_TYPE
        get_MAN_LP_PORT_TYPE = read_MAN_LP_PORT_TYPE_value
    End Property

    Property Let set_MAN_LP_PORT_TYPE(aData)
        write_MAN_LP_PORT_TYPE_value = aData
        flag_MAN_LP_PORT_TYPE        = &H1
    End Property

    Property Get read_MAN_LP_PORT_TYPE
        read
        read_MAN_LP_PORT_TYPE = read_MAN_LP_PORT_TYPE_value
    End Property

    Property Let write_MAN_LP_PORT_TYPE(aData)
        set_MAN_LP_PORT_TYPE = aData
        write
    End Property

    Property Get get_MAN_LP_MS_CONFIG_VALUE
        get_MAN_LP_MS_CONFIG_VALUE = read_MAN_LP_MS_CONFIG_VALUE_value
    End Property

    Property Let set_MAN_LP_MS_CONFIG_VALUE(aData)
        write_MAN_LP_MS_CONFIG_VALUE_value = aData
        flag_MAN_LP_MS_CONFIG_VALUE        = &H1
    End Property

    Property Get read_MAN_LP_MS_CONFIG_VALUE
        read
        read_MAN_LP_MS_CONFIG_VALUE = read_MAN_LP_MS_CONFIG_VALUE_value
    End Property

    Property Let write_MAN_LP_MS_CONFIG_VALUE(aData)
        set_MAN_LP_MS_CONFIG_VALUE = aData
        write
    End Property

    Property Get get_MAN_LP_MS_MANUAL_CONFIG_EN
        get_MAN_LP_MS_MANUAL_CONFIG_EN = read_MAN_LP_MS_MANUAL_CONFIG_EN_value
    End Property

    Property Let set_MAN_LP_MS_MANUAL_CONFIG_EN(aData)
        write_MAN_LP_MS_MANUAL_CONFIG_EN_value = aData
        flag_MAN_LP_MS_MANUAL_CONFIG_EN        = &H1
    End Property

    Property Get read_MAN_LP_MS_MANUAL_CONFIG_EN
        read
        read_MAN_LP_MS_MANUAL_CONFIG_EN = read_MAN_LP_MS_MANUAL_CONFIG_EN_value
    End Property

    Property Let write_MAN_LP_MS_MANUAL_CONFIG_EN(aData)
        set_MAN_LP_MS_MANUAL_CONFIG_EN = aData
        write
    End Property

    Property Get get_MAN_LP_SEED
        get_MAN_LP_SEED = read_MAN_LP_SEED_value
    End Property

    Property Let set_MAN_LP_SEED(aData)
        write_MAN_LP_SEED_value = aData
        flag_MAN_LP_SEED        = &H1
    End Property

    Property Get read_MAN_LP_SEED
        read
        read_MAN_LP_SEED = read_MAN_LP_SEED_value
    End Property

    Property Let write_MAN_LP_SEED(aData)
        set_MAN_LP_SEED = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MAN_LP_1000TX_HDX_value = rightShift(data_low, 15) and &H1
        read_MAN_LP_1000TX_FDX_value = rightShift(data_low, 14) and &H1
        read_MAN_LP_PORT_TYPE_value = rightShift(data_low, 13) and &H1
        read_MAN_LP_MS_CONFIG_VALUE_value = rightShift(data_low, 12) and &H1
        read_MAN_LP_MS_MANUAL_CONFIG_EN_value = rightShift(data_low, 11) and &H1
        MAN_LP_SEED_mask = &H7ff
        if data_low > LONG_MAX then
            if MAN_LP_SEED_mask = mask then
                read_MAN_LP_SEED_value = data_low
            else
                read_MAN_LP_SEED_value = (data_low - H8000_0000) and MAN_LP_SEED_mask
            end If
        else
            read_MAN_LP_SEED_value = data_low and MAN_LP_SEED_mask
        end If

    End Sub

    Sub write
        If flag_MAN_LP_1000TX_HDX = &H0 or flag_MAN_LP_1000TX_FDX = &H0 or flag_MAN_LP_PORT_TYPE = &H0 or flag_MAN_LP_MS_CONFIG_VALUE = &H0 or flag_MAN_LP_MS_MANUAL_CONFIG_EN = &H0 or flag_MAN_LP_SEED = &H0 Then read
        If flag_MAN_LP_1000TX_HDX = &H0 Then write_MAN_LP_1000TX_HDX_value = get_MAN_LP_1000TX_HDX
        If flag_MAN_LP_1000TX_FDX = &H0 Then write_MAN_LP_1000TX_FDX_value = get_MAN_LP_1000TX_FDX
        If flag_MAN_LP_PORT_TYPE = &H0 Then write_MAN_LP_PORT_TYPE_value = get_MAN_LP_PORT_TYPE
        If flag_MAN_LP_MS_CONFIG_VALUE = &H0 Then write_MAN_LP_MS_CONFIG_VALUE_value = get_MAN_LP_MS_CONFIG_VALUE
        If flag_MAN_LP_MS_MANUAL_CONFIG_EN = &H0 Then write_MAN_LP_MS_MANUAL_CONFIG_EN_value = get_MAN_LP_MS_MANUAL_CONFIG_EN
        If flag_MAN_LP_SEED = &H0 Then write_MAN_LP_SEED_value = get_MAN_LP_SEED

        regValue = leftShift((write_MAN_LP_1000TX_HDX_value and &H1), 15) + leftShift((write_MAN_LP_1000TX_FDX_value and &H1), 14) + leftShift((write_MAN_LP_PORT_TYPE_value and &H1), 13) + leftShift((write_MAN_LP_MS_CONFIG_VALUE_value and &H1), 12) + leftShift((write_MAN_LP_MS_MANUAL_CONFIG_EN_value and &H1), 11) + leftShift((write_MAN_LP_SEED_value and &H7ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MAN_LP_1000TX_HDX_value = rightShift(data_low, 15) and &H1
        read_MAN_LP_1000TX_FDX_value = rightShift(data_low, 14) and &H1
        read_MAN_LP_PORT_TYPE_value = rightShift(data_low, 13) and &H1
        read_MAN_LP_MS_CONFIG_VALUE_value = rightShift(data_low, 12) and &H1
        read_MAN_LP_MS_MANUAL_CONFIG_EN_value = rightShift(data_low, 11) and &H1
        MAN_LP_SEED_mask = &H7ff
        if data_low > LONG_MAX then
            if MAN_LP_SEED_mask = mask then
                read_MAN_LP_SEED_value = data_low
            else
                read_MAN_LP_SEED_value = (data_low - H8000_0000) and MAN_LP_SEED_mask
            end If
        else
            read_MAN_LP_SEED_value = data_low and MAN_LP_SEED_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MAN_LP_1000TX_HDX_value = &H0
        flag_MAN_LP_1000TX_HDX        = &H0
        write_MAN_LP_1000TX_FDX_value = &H0
        flag_MAN_LP_1000TX_FDX        = &H0
        write_MAN_LP_PORT_TYPE_value = &H0
        flag_MAN_LP_PORT_TYPE        = &H0
        write_MAN_LP_MS_CONFIG_VALUE_value = &H0
        flag_MAN_LP_MS_CONFIG_VALUE        = &H0
        write_MAN_LP_MS_MANUAL_CONFIG_EN_value = &H0
        flag_MAN_LP_MS_MANUAL_CONFIG_EN        = &H0
        write_MAN_LP_SEED_value = &H0
        flag_MAN_LP_SEED        = &H0
    End Sub
End Class


'' @REGISTER : CL45VEN_an_man_lnk_partnr_abi_b
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MAN_TEST_EN_FOR_2P5G_5G                    [15:15]          get_MAN_TEST_EN_FOR_2P5G_5G
''                                                             set_MAN_TEST_EN_FOR_2P5G_5G
''                                                             read_MAN_TEST_EN_FOR_2P5G_5G
''                                                             write_MAN_TEST_EN_FOR_2P5G_5G
''---------------------------------------------------------------------------------
'' MAN_LP_2P5G_EEE_CAPABILITY                 [10:10]          get_MAN_LP_2P5G_EEE_CAPABILITY
''                                                             set_MAN_LP_2P5G_EEE_CAPABILITY
''                                                             read_MAN_LP_2P5G_EEE_CAPABILITY
''                                                             write_MAN_LP_2P5G_EEE_CAPABILITY
''---------------------------------------------------------------------------------
'' MAN_LP_5G_EEE_CAPABILITY                   [9:9]            get_MAN_LP_5G_EEE_CAPABILITY
''                                                             set_MAN_LP_5G_EEE_CAPABILITY
''                                                             read_MAN_LP_5G_EEE_CAPABILITY
''                                                             write_MAN_LP_5G_EEE_CAPABILITY
''---------------------------------------------------------------------------------
'' MAN_LP_2P5G_CAPABILITY                     [8:8]            get_MAN_LP_2P5G_CAPABILITY
''                                                             set_MAN_LP_2P5G_CAPABILITY
''                                                             read_MAN_LP_2P5G_CAPABILITY
''                                                             write_MAN_LP_2P5G_CAPABILITY
''---------------------------------------------------------------------------------
'' MAN_LP_5G_CAPABILITY                       [7:7]            get_MAN_LP_5G_CAPABILITY
''                                                             set_MAN_LP_5G_CAPABILITY
''                                                             read_MAN_LP_5G_CAPABILITY
''                                                             write_MAN_LP_5G_CAPABILITY
''---------------------------------------------------------------------------------
'' MAN_LP_FAST_RETRAIN_2P5G                   [6:6]            get_MAN_LP_FAST_RETRAIN_2P5G
''                                                             set_MAN_LP_FAST_RETRAIN_2P5G
''                                                             read_MAN_LP_FAST_RETRAIN_2P5G
''                                                             write_MAN_LP_FAST_RETRAIN_2P5G
''---------------------------------------------------------------------------------
'' MAN_LP_FAST_RETRAIN_5G                     [5:5]            get_MAN_LP_FAST_RETRAIN_5G
''                                                             set_MAN_LP_FAST_RETRAIN_5G
''                                                             read_MAN_LP_FAST_RETRAIN_5G
''                                                             write_MAN_LP_FAST_RETRAIN_5G
''---------------------------------------------------------------------------------
'' MAN_LP_FAST_RETRAIN_10G                    [4:4]            get_MAN_LP_FAST_RETRAIN_10G
''                                                             set_MAN_LP_FAST_RETRAIN_10G
''                                                             read_MAN_LP_FAST_RETRAIN_10G
''                                                             write_MAN_LP_FAST_RETRAIN_10G
''---------------------------------------------------------------------------------
'' MAN_LP_PMA_TRAINING_RESET_REQ              [3:3]            get_MAN_LP_PMA_TRAINING_RESET_REQ
''                                                             set_MAN_LP_PMA_TRAINING_RESET_REQ
''                                                             read_MAN_LP_PMA_TRAINING_RESET_REQ
''                                                             write_MAN_LP_PMA_TRAINING_RESET_REQ
''---------------------------------------------------------------------------------
'' MAN_LP_PHY_SHORT_REACH_MODE                [2:2]            get_MAN_LP_PHY_SHORT_REACH_MODE
''                                                             set_MAN_LP_PHY_SHORT_REACH_MODE
''                                                             read_MAN_LP_PHY_SHORT_REACH_MODE
''                                                             write_MAN_LP_PHY_SHORT_REACH_MODE
''---------------------------------------------------------------------------------
'' MAN_LP_LOOP_TIMING_ABILITY                 [1:1]            get_MAN_LP_LOOP_TIMING_ABILITY
''                                                             set_MAN_LP_LOOP_TIMING_ABILITY
''                                                             read_MAN_LP_LOOP_TIMING_ABILITY
''                                                             write_MAN_LP_LOOP_TIMING_ABILITY
''---------------------------------------------------------------------------------
'' MAN_LP_10GBASET_CAPABILITY                 [0:0]            get_MAN_LP_10GBASET_CAPABILITY
''                                                             set_MAN_LP_10GBASET_CAPABILITY
''                                                             read_MAN_LP_10GBASET_CAPABILITY
''                                                             write_MAN_LP_10GBASET_CAPABILITY
''---------------------------------------------------------------------------------
Class REGISTER_CL45VEN_an_man_lnk_partnr_abi_b
    Private write_MAN_TEST_EN_FOR_2P5G_5G_value
    Private read_MAN_TEST_EN_FOR_2P5G_5G_value
    Private flag_MAN_TEST_EN_FOR_2P5G_5G
    Private write_MAN_LP_2P5G_EEE_CAPABILITY_value
    Private read_MAN_LP_2P5G_EEE_CAPABILITY_value
    Private flag_MAN_LP_2P5G_EEE_CAPABILITY
    Private write_MAN_LP_5G_EEE_CAPABILITY_value
    Private read_MAN_LP_5G_EEE_CAPABILITY_value
    Private flag_MAN_LP_5G_EEE_CAPABILITY
    Private write_MAN_LP_2P5G_CAPABILITY_value
    Private read_MAN_LP_2P5G_CAPABILITY_value
    Private flag_MAN_LP_2P5G_CAPABILITY
    Private write_MAN_LP_5G_CAPABILITY_value
    Private read_MAN_LP_5G_CAPABILITY_value
    Private flag_MAN_LP_5G_CAPABILITY
    Private write_MAN_LP_FAST_RETRAIN_2P5G_value
    Private read_MAN_LP_FAST_RETRAIN_2P5G_value
    Private flag_MAN_LP_FAST_RETRAIN_2P5G
    Private write_MAN_LP_FAST_RETRAIN_5G_value
    Private read_MAN_LP_FAST_RETRAIN_5G_value
    Private flag_MAN_LP_FAST_RETRAIN_5G
    Private write_MAN_LP_FAST_RETRAIN_10G_value
    Private read_MAN_LP_FAST_RETRAIN_10G_value
    Private flag_MAN_LP_FAST_RETRAIN_10G
    Private write_MAN_LP_PMA_TRAINING_RESET_REQ_value
    Private read_MAN_LP_PMA_TRAINING_RESET_REQ_value
    Private flag_MAN_LP_PMA_TRAINING_RESET_REQ
    Private write_MAN_LP_PHY_SHORT_REACH_MODE_value
    Private read_MAN_LP_PHY_SHORT_REACH_MODE_value
    Private flag_MAN_LP_PHY_SHORT_REACH_MODE
    Private write_MAN_LP_LOOP_TIMING_ABILITY_value
    Private read_MAN_LP_LOOP_TIMING_ABILITY_value
    Private flag_MAN_LP_LOOP_TIMING_ABILITY
    Private write_MAN_LP_10GBASET_CAPABILITY_value
    Private read_MAN_LP_10GBASET_CAPABILITY_value
    Private flag_MAN_LP_10GBASET_CAPABILITY

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H36
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MAN_TEST_EN_FOR_2P5G_5G
        get_MAN_TEST_EN_FOR_2P5G_5G = read_MAN_TEST_EN_FOR_2P5G_5G_value
    End Property

    Property Let set_MAN_TEST_EN_FOR_2P5G_5G(aData)
        write_MAN_TEST_EN_FOR_2P5G_5G_value = aData
        flag_MAN_TEST_EN_FOR_2P5G_5G        = &H1
    End Property

    Property Get read_MAN_TEST_EN_FOR_2P5G_5G
        read
        read_MAN_TEST_EN_FOR_2P5G_5G = read_MAN_TEST_EN_FOR_2P5G_5G_value
    End Property

    Property Let write_MAN_TEST_EN_FOR_2P5G_5G(aData)
        set_MAN_TEST_EN_FOR_2P5G_5G = aData
        write
    End Property

    Property Get get_MAN_LP_2P5G_EEE_CAPABILITY
        get_MAN_LP_2P5G_EEE_CAPABILITY = read_MAN_LP_2P5G_EEE_CAPABILITY_value
    End Property

    Property Let set_MAN_LP_2P5G_EEE_CAPABILITY(aData)
        write_MAN_LP_2P5G_EEE_CAPABILITY_value = aData
        flag_MAN_LP_2P5G_EEE_CAPABILITY        = &H1
    End Property

    Property Get read_MAN_LP_2P5G_EEE_CAPABILITY
        read
        read_MAN_LP_2P5G_EEE_CAPABILITY = read_MAN_LP_2P5G_EEE_CAPABILITY_value
    End Property

    Property Let write_MAN_LP_2P5G_EEE_CAPABILITY(aData)
        set_MAN_LP_2P5G_EEE_CAPABILITY = aData
        write
    End Property

    Property Get get_MAN_LP_5G_EEE_CAPABILITY
        get_MAN_LP_5G_EEE_CAPABILITY = read_MAN_LP_5G_EEE_CAPABILITY_value
    End Property

    Property Let set_MAN_LP_5G_EEE_CAPABILITY(aData)
        write_MAN_LP_5G_EEE_CAPABILITY_value = aData
        flag_MAN_LP_5G_EEE_CAPABILITY        = &H1
    End Property

    Property Get read_MAN_LP_5G_EEE_CAPABILITY
        read
        read_MAN_LP_5G_EEE_CAPABILITY = read_MAN_LP_5G_EEE_CAPABILITY_value
    End Property

    Property Let write_MAN_LP_5G_EEE_CAPABILITY(aData)
        set_MAN_LP_5G_EEE_CAPABILITY = aData
        write
    End Property

    Property Get get_MAN_LP_2P5G_CAPABILITY
        get_MAN_LP_2P5G_CAPABILITY = read_MAN_LP_2P5G_CAPABILITY_value
    End Property

    Property Let set_MAN_LP_2P5G_CAPABILITY(aData)
        write_MAN_LP_2P5G_CAPABILITY_value = aData
        flag_MAN_LP_2P5G_CAPABILITY        = &H1
    End Property

    Property Get read_MAN_LP_2P5G_CAPABILITY
        read
        read_MAN_LP_2P5G_CAPABILITY = read_MAN_LP_2P5G_CAPABILITY_value
    End Property

    Property Let write_MAN_LP_2P5G_CAPABILITY(aData)
        set_MAN_LP_2P5G_CAPABILITY = aData
        write
    End Property

    Property Get get_MAN_LP_5G_CAPABILITY
        get_MAN_LP_5G_CAPABILITY = read_MAN_LP_5G_CAPABILITY_value
    End Property

    Property Let set_MAN_LP_5G_CAPABILITY(aData)
        write_MAN_LP_5G_CAPABILITY_value = aData
        flag_MAN_LP_5G_CAPABILITY        = &H1
    End Property

    Property Get read_MAN_LP_5G_CAPABILITY
        read
        read_MAN_LP_5G_CAPABILITY = read_MAN_LP_5G_CAPABILITY_value
    End Property

    Property Let write_MAN_LP_5G_CAPABILITY(aData)
        set_MAN_LP_5G_CAPABILITY = aData
        write
    End Property

    Property Get get_MAN_LP_FAST_RETRAIN_2P5G
        get_MAN_LP_FAST_RETRAIN_2P5G = read_MAN_LP_FAST_RETRAIN_2P5G_value
    End Property

    Property Let set_MAN_LP_FAST_RETRAIN_2P5G(aData)
        write_MAN_LP_FAST_RETRAIN_2P5G_value = aData
        flag_MAN_LP_FAST_RETRAIN_2P5G        = &H1
    End Property

    Property Get read_MAN_LP_FAST_RETRAIN_2P5G
        read
        read_MAN_LP_FAST_RETRAIN_2P5G = read_MAN_LP_FAST_RETRAIN_2P5G_value
    End Property

    Property Let write_MAN_LP_FAST_RETRAIN_2P5G(aData)
        set_MAN_LP_FAST_RETRAIN_2P5G = aData
        write
    End Property

    Property Get get_MAN_LP_FAST_RETRAIN_5G
        get_MAN_LP_FAST_RETRAIN_5G = read_MAN_LP_FAST_RETRAIN_5G_value
    End Property

    Property Let set_MAN_LP_FAST_RETRAIN_5G(aData)
        write_MAN_LP_FAST_RETRAIN_5G_value = aData
        flag_MAN_LP_FAST_RETRAIN_5G        = &H1
    End Property

    Property Get read_MAN_LP_FAST_RETRAIN_5G
        read
        read_MAN_LP_FAST_RETRAIN_5G = read_MAN_LP_FAST_RETRAIN_5G_value
    End Property

    Property Let write_MAN_LP_FAST_RETRAIN_5G(aData)
        set_MAN_LP_FAST_RETRAIN_5G = aData
        write
    End Property

    Property Get get_MAN_LP_FAST_RETRAIN_10G
        get_MAN_LP_FAST_RETRAIN_10G = read_MAN_LP_FAST_RETRAIN_10G_value
    End Property

    Property Let set_MAN_LP_FAST_RETRAIN_10G(aData)
        write_MAN_LP_FAST_RETRAIN_10G_value = aData
        flag_MAN_LP_FAST_RETRAIN_10G        = &H1
    End Property

    Property Get read_MAN_LP_FAST_RETRAIN_10G
        read
        read_MAN_LP_FAST_RETRAIN_10G = read_MAN_LP_FAST_RETRAIN_10G_value
    End Property

    Property Let write_MAN_LP_FAST_RETRAIN_10G(aData)
        set_MAN_LP_FAST_RETRAIN_10G = aData
        write
    End Property

    Property Get get_MAN_LP_PMA_TRAINING_RESET_REQ
        get_MAN_LP_PMA_TRAINING_RESET_REQ = read_MAN_LP_PMA_TRAINING_RESET_REQ_value
    End Property

    Property Let set_MAN_LP_PMA_TRAINING_RESET_REQ(aData)
        write_MAN_LP_PMA_TRAINING_RESET_REQ_value = aData
        flag_MAN_LP_PMA_TRAINING_RESET_REQ        = &H1
    End Property

    Property Get read_MAN_LP_PMA_TRAINING_RESET_REQ
        read
        read_MAN_LP_PMA_TRAINING_RESET_REQ = read_MAN_LP_PMA_TRAINING_RESET_REQ_value
    End Property

    Property Let write_MAN_LP_PMA_TRAINING_RESET_REQ(aData)
        set_MAN_LP_PMA_TRAINING_RESET_REQ = aData
        write
    End Property

    Property Get get_MAN_LP_PHY_SHORT_REACH_MODE
        get_MAN_LP_PHY_SHORT_REACH_MODE = read_MAN_LP_PHY_SHORT_REACH_MODE_value
    End Property

    Property Let set_MAN_LP_PHY_SHORT_REACH_MODE(aData)
        write_MAN_LP_PHY_SHORT_REACH_MODE_value = aData
        flag_MAN_LP_PHY_SHORT_REACH_MODE        = &H1
    End Property

    Property Get read_MAN_LP_PHY_SHORT_REACH_MODE
        read
        read_MAN_LP_PHY_SHORT_REACH_MODE = read_MAN_LP_PHY_SHORT_REACH_MODE_value
    End Property

    Property Let write_MAN_LP_PHY_SHORT_REACH_MODE(aData)
        set_MAN_LP_PHY_SHORT_REACH_MODE = aData
        write
    End Property

    Property Get get_MAN_LP_LOOP_TIMING_ABILITY
        get_MAN_LP_LOOP_TIMING_ABILITY = read_MAN_LP_LOOP_TIMING_ABILITY_value
    End Property

    Property Let set_MAN_LP_LOOP_TIMING_ABILITY(aData)
        write_MAN_LP_LOOP_TIMING_ABILITY_value = aData
        flag_MAN_LP_LOOP_TIMING_ABILITY        = &H1
    End Property

    Property Get read_MAN_LP_LOOP_TIMING_ABILITY
        read
        read_MAN_LP_LOOP_TIMING_ABILITY = read_MAN_LP_LOOP_TIMING_ABILITY_value
    End Property

    Property Let write_MAN_LP_LOOP_TIMING_ABILITY(aData)
        set_MAN_LP_LOOP_TIMING_ABILITY = aData
        write
    End Property

    Property Get get_MAN_LP_10GBASET_CAPABILITY
        get_MAN_LP_10GBASET_CAPABILITY = read_MAN_LP_10GBASET_CAPABILITY_value
    End Property

    Property Let set_MAN_LP_10GBASET_CAPABILITY(aData)
        write_MAN_LP_10GBASET_CAPABILITY_value = aData
        flag_MAN_LP_10GBASET_CAPABILITY        = &H1
    End Property

    Property Get read_MAN_LP_10GBASET_CAPABILITY
        read
        read_MAN_LP_10GBASET_CAPABILITY = read_MAN_LP_10GBASET_CAPABILITY_value
    End Property

    Property Let write_MAN_LP_10GBASET_CAPABILITY(aData)
        set_MAN_LP_10GBASET_CAPABILITY = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MAN_TEST_EN_FOR_2P5G_5G_value = rightShift(data_low, 15) and &H1
        read_MAN_LP_2P5G_EEE_CAPABILITY_value = rightShift(data_low, 10) and &H1
        read_MAN_LP_5G_EEE_CAPABILITY_value = rightShift(data_low, 9) and &H1
        read_MAN_LP_2P5G_CAPABILITY_value = rightShift(data_low, 8) and &H1
        read_MAN_LP_5G_CAPABILITY_value = rightShift(data_low, 7) and &H1
        read_MAN_LP_FAST_RETRAIN_2P5G_value = rightShift(data_low, 6) and &H1
        read_MAN_LP_FAST_RETRAIN_5G_value = rightShift(data_low, 5) and &H1
        read_MAN_LP_FAST_RETRAIN_10G_value = rightShift(data_low, 4) and &H1
        read_MAN_LP_PMA_TRAINING_RESET_REQ_value = rightShift(data_low, 3) and &H1
        read_MAN_LP_PHY_SHORT_REACH_MODE_value = rightShift(data_low, 2) and &H1
        read_MAN_LP_LOOP_TIMING_ABILITY_value = rightShift(data_low, 1) and &H1
        MAN_LP_10GBASET_CAPABILITY_mask = &H1
        if data_low > LONG_MAX then
            if MAN_LP_10GBASET_CAPABILITY_mask = mask then
                read_MAN_LP_10GBASET_CAPABILITY_value = data_low
            else
                read_MAN_LP_10GBASET_CAPABILITY_value = (data_low - H8000_0000) and MAN_LP_10GBASET_CAPABILITY_mask
            end If
        else
            read_MAN_LP_10GBASET_CAPABILITY_value = data_low and MAN_LP_10GBASET_CAPABILITY_mask
        end If

    End Sub

    Sub write
        If flag_MAN_TEST_EN_FOR_2P5G_5G = &H0 or flag_MAN_LP_2P5G_EEE_CAPABILITY = &H0 or flag_MAN_LP_5G_EEE_CAPABILITY = &H0 or flag_MAN_LP_2P5G_CAPABILITY = &H0 or flag_MAN_LP_5G_CAPABILITY = &H0 or flag_MAN_LP_FAST_RETRAIN_2P5G = &H0 or flag_MAN_LP_FAST_RETRAIN_5G = &H0 or flag_MAN_LP_FAST_RETRAIN_10G = &H0 or flag_MAN_LP_PMA_TRAINING_RESET_REQ = &H0 or flag_MAN_LP_PHY_SHORT_REACH_MODE = &H0 or flag_MAN_LP_LOOP_TIMING_ABILITY = &H0 or flag_MAN_LP_10GBASET_CAPABILITY = &H0 Then read
        If flag_MAN_TEST_EN_FOR_2P5G_5G = &H0 Then write_MAN_TEST_EN_FOR_2P5G_5G_value = get_MAN_TEST_EN_FOR_2P5G_5G
        If flag_MAN_LP_2P5G_EEE_CAPABILITY = &H0 Then write_MAN_LP_2P5G_EEE_CAPABILITY_value = get_MAN_LP_2P5G_EEE_CAPABILITY
        If flag_MAN_LP_5G_EEE_CAPABILITY = &H0 Then write_MAN_LP_5G_EEE_CAPABILITY_value = get_MAN_LP_5G_EEE_CAPABILITY
        If flag_MAN_LP_2P5G_CAPABILITY = &H0 Then write_MAN_LP_2P5G_CAPABILITY_value = get_MAN_LP_2P5G_CAPABILITY
        If flag_MAN_LP_5G_CAPABILITY = &H0 Then write_MAN_LP_5G_CAPABILITY_value = get_MAN_LP_5G_CAPABILITY
        If flag_MAN_LP_FAST_RETRAIN_2P5G = &H0 Then write_MAN_LP_FAST_RETRAIN_2P5G_value = get_MAN_LP_FAST_RETRAIN_2P5G
        If flag_MAN_LP_FAST_RETRAIN_5G = &H0 Then write_MAN_LP_FAST_RETRAIN_5G_value = get_MAN_LP_FAST_RETRAIN_5G
        If flag_MAN_LP_FAST_RETRAIN_10G = &H0 Then write_MAN_LP_FAST_RETRAIN_10G_value = get_MAN_LP_FAST_RETRAIN_10G
        If flag_MAN_LP_PMA_TRAINING_RESET_REQ = &H0 Then write_MAN_LP_PMA_TRAINING_RESET_REQ_value = get_MAN_LP_PMA_TRAINING_RESET_REQ
        If flag_MAN_LP_PHY_SHORT_REACH_MODE = &H0 Then write_MAN_LP_PHY_SHORT_REACH_MODE_value = get_MAN_LP_PHY_SHORT_REACH_MODE
        If flag_MAN_LP_LOOP_TIMING_ABILITY = &H0 Then write_MAN_LP_LOOP_TIMING_ABILITY_value = get_MAN_LP_LOOP_TIMING_ABILITY
        If flag_MAN_LP_10GBASET_CAPABILITY = &H0 Then write_MAN_LP_10GBASET_CAPABILITY_value = get_MAN_LP_10GBASET_CAPABILITY

        regValue = leftShift((write_MAN_TEST_EN_FOR_2P5G_5G_value and &H1), 15) + leftShift((write_MAN_LP_2P5G_EEE_CAPABILITY_value and &H1), 10) + leftShift((write_MAN_LP_5G_EEE_CAPABILITY_value and &H1), 9) + leftShift((write_MAN_LP_2P5G_CAPABILITY_value and &H1), 8) + leftShift((write_MAN_LP_5G_CAPABILITY_value and &H1), 7) + leftShift((write_MAN_LP_FAST_RETRAIN_2P5G_value and &H1), 6) + leftShift((write_MAN_LP_FAST_RETRAIN_5G_value and &H1), 5) + leftShift((write_MAN_LP_FAST_RETRAIN_10G_value and &H1), 4) + leftShift((write_MAN_LP_PMA_TRAINING_RESET_REQ_value and &H1), 3) + leftShift((write_MAN_LP_PHY_SHORT_REACH_MODE_value and &H1), 2) + leftShift((write_MAN_LP_LOOP_TIMING_ABILITY_value and &H1), 1) + leftShift((write_MAN_LP_10GBASET_CAPABILITY_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MAN_TEST_EN_FOR_2P5G_5G_value = rightShift(data_low, 15) and &H1
        read_MAN_LP_2P5G_EEE_CAPABILITY_value = rightShift(data_low, 10) and &H1
        read_MAN_LP_5G_EEE_CAPABILITY_value = rightShift(data_low, 9) and &H1
        read_MAN_LP_2P5G_CAPABILITY_value = rightShift(data_low, 8) and &H1
        read_MAN_LP_5G_CAPABILITY_value = rightShift(data_low, 7) and &H1
        read_MAN_LP_FAST_RETRAIN_2P5G_value = rightShift(data_low, 6) and &H1
        read_MAN_LP_FAST_RETRAIN_5G_value = rightShift(data_low, 5) and &H1
        read_MAN_LP_FAST_RETRAIN_10G_value = rightShift(data_low, 4) and &H1
        read_MAN_LP_PMA_TRAINING_RESET_REQ_value = rightShift(data_low, 3) and &H1
        read_MAN_LP_PHY_SHORT_REACH_MODE_value = rightShift(data_low, 2) and &H1
        read_MAN_LP_LOOP_TIMING_ABILITY_value = rightShift(data_low, 1) and &H1
        MAN_LP_10GBASET_CAPABILITY_mask = &H1
        if data_low > LONG_MAX then
            if MAN_LP_10GBASET_CAPABILITY_mask = mask then
                read_MAN_LP_10GBASET_CAPABILITY_value = data_low
            else
                read_MAN_LP_10GBASET_CAPABILITY_value = (data_low - H8000_0000) and MAN_LP_10GBASET_CAPABILITY_mask
            end If
        else
            read_MAN_LP_10GBASET_CAPABILITY_value = data_low and MAN_LP_10GBASET_CAPABILITY_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MAN_TEST_EN_FOR_2P5G_5G_value = &H0
        flag_MAN_TEST_EN_FOR_2P5G_5G        = &H0
        write_MAN_LP_2P5G_EEE_CAPABILITY_value = &H0
        flag_MAN_LP_2P5G_EEE_CAPABILITY        = &H0
        write_MAN_LP_5G_EEE_CAPABILITY_value = &H0
        flag_MAN_LP_5G_EEE_CAPABILITY        = &H0
        write_MAN_LP_2P5G_CAPABILITY_value = &H0
        flag_MAN_LP_2P5G_CAPABILITY        = &H0
        write_MAN_LP_5G_CAPABILITY_value = &H0
        flag_MAN_LP_5G_CAPABILITY        = &H0
        write_MAN_LP_FAST_RETRAIN_2P5G_value = &H0
        flag_MAN_LP_FAST_RETRAIN_2P5G        = &H0
        write_MAN_LP_FAST_RETRAIN_5G_value = &H0
        flag_MAN_LP_FAST_RETRAIN_5G        = &H0
        write_MAN_LP_FAST_RETRAIN_10G_value = &H0
        flag_MAN_LP_FAST_RETRAIN_10G        = &H0
        write_MAN_LP_PMA_TRAINING_RESET_REQ_value = &H0
        flag_MAN_LP_PMA_TRAINING_RESET_REQ        = &H0
        write_MAN_LP_PHY_SHORT_REACH_MODE_value = &H0
        flag_MAN_LP_PHY_SHORT_REACH_MODE        = &H0
        write_MAN_LP_LOOP_TIMING_ABILITY_value = &H0
        flag_MAN_LP_LOOP_TIMING_ABILITY        = &H0
        write_MAN_LP_10GBASET_CAPABILITY_value = &H0
        flag_MAN_LP_10GBASET_CAPABILITY        = &H0
    End Sub
End Class


'' @REGISTER : CL45VEN_lnk_partnr_nxt_pg_a
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LP_NP_A                                    [15:0]           get_LP_NP_A
''                                                             set_LP_NP_A
''                                                             read_LP_NP_A
''                                                             write_LP_NP_A
''---------------------------------------------------------------------------------
Class REGISTER_CL45VEN_lnk_partnr_nxt_pg_a
    Private write_LP_NP_A_value
    Private read_LP_NP_A_value
    Private flag_LP_NP_A

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

    Property Get get_LP_NP_A
        get_LP_NP_A = read_LP_NP_A_value
    End Property

    Property Let set_LP_NP_A(aData)
        write_LP_NP_A_value = aData
        flag_LP_NP_A        = &H1
    End Property

    Property Get read_LP_NP_A
        read
        read_LP_NP_A = read_LP_NP_A_value
    End Property

    Property Let write_LP_NP_A(aData)
        set_LP_NP_A = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LP_NP_A_mask = &Hffff
        if data_low > LONG_MAX then
            if LP_NP_A_mask = mask then
                read_LP_NP_A_value = data_low
            else
                read_LP_NP_A_value = (data_low - H8000_0000) and LP_NP_A_mask
            end If
        else
            read_LP_NP_A_value = data_low and LP_NP_A_mask
        end If

    End Sub

    Sub write
        If flag_LP_NP_A = &H0 Then read
        If flag_LP_NP_A = &H0 Then write_LP_NP_A_value = get_LP_NP_A

        regValue = leftShift((write_LP_NP_A_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LP_NP_A_mask = &Hffff
        if data_low > LONG_MAX then
            if LP_NP_A_mask = mask then
                read_LP_NP_A_value = data_low
            else
                read_LP_NP_A_value = (data_low - H8000_0000) and LP_NP_A_mask
            end If
        else
            read_LP_NP_A_value = data_low and LP_NP_A_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LP_NP_A_value = &H0
        flag_LP_NP_A        = &H0
    End Sub
End Class


'' @REGISTER : CL45VEN_lnk_partnr_nxt_pg_b
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LP_NP_B                                    [15:0]           get_LP_NP_B
''                                                             set_LP_NP_B
''                                                             read_LP_NP_B
''                                                             write_LP_NP_B
''---------------------------------------------------------------------------------
Class REGISTER_CL45VEN_lnk_partnr_nxt_pg_b
    Private write_LP_NP_B_value
    Private read_LP_NP_B_value
    Private flag_LP_NP_B

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_LP_NP_B
        get_LP_NP_B = read_LP_NP_B_value
    End Property

    Property Let set_LP_NP_B(aData)
        write_LP_NP_B_value = aData
        flag_LP_NP_B        = &H1
    End Property

    Property Get read_LP_NP_B
        read
        read_LP_NP_B = read_LP_NP_B_value
    End Property

    Property Let write_LP_NP_B(aData)
        set_LP_NP_B = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LP_NP_B_mask = &Hffff
        if data_low > LONG_MAX then
            if LP_NP_B_mask = mask then
                read_LP_NP_B_value = data_low
            else
                read_LP_NP_B_value = (data_low - H8000_0000) and LP_NP_B_mask
            end If
        else
            read_LP_NP_B_value = data_low and LP_NP_B_mask
        end If

    End Sub

    Sub write
        If flag_LP_NP_B = &H0 Then read
        If flag_LP_NP_B = &H0 Then write_LP_NP_B_value = get_LP_NP_B

        regValue = leftShift((write_LP_NP_B_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LP_NP_B_mask = &Hffff
        if data_low > LONG_MAX then
            if LP_NP_B_mask = mask then
                read_LP_NP_B_value = data_low
            else
                read_LP_NP_B_value = (data_low - H8000_0000) and LP_NP_B_mask
            end If
        else
            read_LP_NP_B_value = data_low and LP_NP_B_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LP_NP_B_value = &H0
        flag_LP_NP_B        = &H0
    End Sub
End Class


'' @REGISTER : CL45VEN_lnk_partnr_nxt_pg_c
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LP_NP_C                                    [15:0]           get_LP_NP_C
''                                                             set_LP_NP_C
''                                                             read_LP_NP_C
''                                                             write_LP_NP_C
''---------------------------------------------------------------------------------
Class REGISTER_CL45VEN_lnk_partnr_nxt_pg_c
    Private write_LP_NP_C_value
    Private read_LP_NP_C_value
    Private flag_LP_NP_C

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

    Property Get get_LP_NP_C
        get_LP_NP_C = read_LP_NP_C_value
    End Property

    Property Let set_LP_NP_C(aData)
        write_LP_NP_C_value = aData
        flag_LP_NP_C        = &H1
    End Property

    Property Get read_LP_NP_C
        read
        read_LP_NP_C = read_LP_NP_C_value
    End Property

    Property Let write_LP_NP_C(aData)
        set_LP_NP_C = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LP_NP_C_mask = &Hffff
        if data_low > LONG_MAX then
            if LP_NP_C_mask = mask then
                read_LP_NP_C_value = data_low
            else
                read_LP_NP_C_value = (data_low - H8000_0000) and LP_NP_C_mask
            end If
        else
            read_LP_NP_C_value = data_low and LP_NP_C_mask
        end If

    End Sub

    Sub write
        If flag_LP_NP_C = &H0 Then read
        If flag_LP_NP_C = &H0 Then write_LP_NP_C_value = get_LP_NP_C

        regValue = leftShift((write_LP_NP_C_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LP_NP_C_mask = &Hffff
        if data_low > LONG_MAX then
            if LP_NP_C_mask = mask then
                read_LP_NP_C_value = data_low
            else
                read_LP_NP_C_value = (data_low - H8000_0000) and LP_NP_C_mask
            end If
        else
            read_LP_NP_C_value = data_low and LP_NP_C_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LP_NP_C_value = &H0
        flag_LP_NP_C        = &H0
    End Sub
End Class


'' @REGISTER : CL45VEN_lnk_partnr_nxt_pg_d
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LP_NP_D                                    [15:0]           get_LP_NP_D
''                                                             set_LP_NP_D
''                                                             read_LP_NP_D
''                                                             write_LP_NP_D
''---------------------------------------------------------------------------------
Class REGISTER_CL45VEN_lnk_partnr_nxt_pg_d
    Private write_LP_NP_D_value
    Private read_LP_NP_D_value
    Private flag_LP_NP_D

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H3e
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_LP_NP_D
        get_LP_NP_D = read_LP_NP_D_value
    End Property

    Property Let set_LP_NP_D(aData)
        write_LP_NP_D_value = aData
        flag_LP_NP_D        = &H1
    End Property

    Property Get read_LP_NP_D
        read
        read_LP_NP_D = read_LP_NP_D_value
    End Property

    Property Let write_LP_NP_D(aData)
        set_LP_NP_D = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LP_NP_D_mask = &Hffff
        if data_low > LONG_MAX then
            if LP_NP_D_mask = mask then
                read_LP_NP_D_value = data_low
            else
                read_LP_NP_D_value = (data_low - H8000_0000) and LP_NP_D_mask
            end If
        else
            read_LP_NP_D_value = data_low and LP_NP_D_mask
        end If

    End Sub

    Sub write
        If flag_LP_NP_D = &H0 Then read
        If flag_LP_NP_D = &H0 Then write_LP_NP_D_value = get_LP_NP_D

        regValue = leftShift((write_LP_NP_D_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LP_NP_D_mask = &Hffff
        if data_low > LONG_MAX then
            if LP_NP_D_mask = mask then
                read_LP_NP_D_value = data_low
            else
                read_LP_NP_D_value = (data_low - H8000_0000) and LP_NP_D_mask
            end If
        else
            read_LP_NP_D_value = data_low and LP_NP_D_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LP_NP_D_value = &H0
        flag_LP_NP_D        = &H0
    End Sub
End Class


'' @REGISTER : CL45VEN_lnk_partnr_nxt_pg_e
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LP_NP_E                                    [15:0]           get_LP_NP_E
''                                                             set_LP_NP_E
''                                                             read_LP_NP_E
''                                                             write_LP_NP_E
''---------------------------------------------------------------------------------
Class REGISTER_CL45VEN_lnk_partnr_nxt_pg_e
    Private write_LP_NP_E_value
    Private read_LP_NP_E_value
    Private flag_LP_NP_E

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

    Property Get get_LP_NP_E
        get_LP_NP_E = read_LP_NP_E_value
    End Property

    Property Let set_LP_NP_E(aData)
        write_LP_NP_E_value = aData
        flag_LP_NP_E        = &H1
    End Property

    Property Get read_LP_NP_E
        read
        read_LP_NP_E = read_LP_NP_E_value
    End Property

    Property Let write_LP_NP_E(aData)
        set_LP_NP_E = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LP_NP_E_mask = &Hffff
        if data_low > LONG_MAX then
            if LP_NP_E_mask = mask then
                read_LP_NP_E_value = data_low
            else
                read_LP_NP_E_value = (data_low - H8000_0000) and LP_NP_E_mask
            end If
        else
            read_LP_NP_E_value = data_low and LP_NP_E_mask
        end If

    End Sub

    Sub write
        If flag_LP_NP_E = &H0 Then read
        If flag_LP_NP_E = &H0 Then write_LP_NP_E_value = get_LP_NP_E

        regValue = leftShift((write_LP_NP_E_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LP_NP_E_mask = &Hffff
        if data_low > LONG_MAX then
            if LP_NP_E_mask = mask then
                read_LP_NP_E_value = data_low
            else
                read_LP_NP_E_value = (data_low - H8000_0000) and LP_NP_E_mask
            end If
        else
            read_LP_NP_E_value = data_low and LP_NP_E_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LP_NP_E_value = &H0
        flag_LP_NP_E        = &H0
    End Sub
End Class


'' @REGISTER : CL45VEN_lnk_partnr_nxt_pg_f
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LP_NP_F                                    [15:0]           get_LP_NP_F
''                                                             set_LP_NP_F
''                                                             read_LP_NP_F
''                                                             write_LP_NP_F
''---------------------------------------------------------------------------------
Class REGISTER_CL45VEN_lnk_partnr_nxt_pg_f
    Private write_LP_NP_F_value
    Private read_LP_NP_F_value
    Private flag_LP_NP_F

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H42
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_LP_NP_F
        get_LP_NP_F = read_LP_NP_F_value
    End Property

    Property Let set_LP_NP_F(aData)
        write_LP_NP_F_value = aData
        flag_LP_NP_F        = &H1
    End Property

    Property Get read_LP_NP_F
        read
        read_LP_NP_F = read_LP_NP_F_value
    End Property

    Property Let write_LP_NP_F(aData)
        set_LP_NP_F = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LP_NP_F_mask = &Hffff
        if data_low > LONG_MAX then
            if LP_NP_F_mask = mask then
                read_LP_NP_F_value = data_low
            else
                read_LP_NP_F_value = (data_low - H8000_0000) and LP_NP_F_mask
            end If
        else
            read_LP_NP_F_value = data_low and LP_NP_F_mask
        end If

    End Sub

    Sub write
        If flag_LP_NP_F = &H0 Then read
        If flag_LP_NP_F = &H0 Then write_LP_NP_F_value = get_LP_NP_F

        regValue = leftShift((write_LP_NP_F_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LP_NP_F_mask = &Hffff
        if data_low > LONG_MAX then
            if LP_NP_F_mask = mask then
                read_LP_NP_F_value = data_low
            else
                read_LP_NP_F_value = (data_low - H8000_0000) and LP_NP_F_mask
            end If
        else
            read_LP_NP_F_value = data_low and LP_NP_F_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LP_NP_F_value = &H0
        flag_LP_NP_F        = &H0
    End Sub
End Class


'' @REGISTER : CL45VEN_epon_ctrl_reg
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' EPON_MODE                                  [9:9]            get_EPON_MODE
''                                                             set_EPON_MODE
''                                                             read_EPON_MODE
''                                                             write_EPON_MODE
''---------------------------------------------------------------------------------
'' EOC_PACKET_NORM                            [8:8]            get_EOC_PACKET_NORM
''                                                             set_EOC_PACKET_NORM
''                                                             read_EOC_PACKET_NORM
''                                                             write_EOC_PACKET_NORM
''---------------------------------------------------------------------------------
'' EPON_MODE_CRCCHECK                         [7:7]            get_EPON_MODE_CRCCHECK
''                                                             set_EPON_MODE_CRCCHECK
''                                                             read_EPON_MODE_CRCCHECK
''                                                             write_EPON_MODE_CRCCHECK
''---------------------------------------------------------------------------------
'' TX_EN_EXTEND                               [6:6]            get_TX_EN_EXTEND
''                                                             set_TX_EN_EXTEND
''                                                             read_TX_EN_EXTEND
''                                                             write_TX_EN_EXTEND
''---------------------------------------------------------------------------------
'' EOC_MODE_POLARITY                          [5:5]            get_EOC_MODE_POLARITY
''                                                             set_EOC_MODE_POLARITY
''                                                             read_EOC_MODE_POLARITY
''                                                             write_EOC_MODE_POLARITY
''---------------------------------------------------------------------------------
'' EOC_MODE_POL_CORR                          [4:4]            get_EOC_MODE_POL_CORR
''                                                             set_EOC_MODE_POL_CORR
''                                                             read_EOC_MODE_POL_CORR
''                                                             write_EOC_MODE_POL_CORR
''---------------------------------------------------------------------------------
'' EOC_SPEED_DET_THLD                         [3:0]            get_EOC_SPEED_DET_THLD
''                                                             set_EOC_SPEED_DET_THLD
''                                                             read_EOC_SPEED_DET_THLD
''                                                             write_EOC_SPEED_DET_THLD
''---------------------------------------------------------------------------------
Class REGISTER_CL45VEN_epon_ctrl_reg
    Private write_EPON_MODE_value
    Private read_EPON_MODE_value
    Private flag_EPON_MODE
    Private write_EOC_PACKET_NORM_value
    Private read_EOC_PACKET_NORM_value
    Private flag_EOC_PACKET_NORM
    Private write_EPON_MODE_CRCCHECK_value
    Private read_EPON_MODE_CRCCHECK_value
    Private flag_EPON_MODE_CRCCHECK
    Private write_TX_EN_EXTEND_value
    Private read_TX_EN_EXTEND_value
    Private flag_TX_EN_EXTEND
    Private write_EOC_MODE_POLARITY_value
    Private read_EOC_MODE_POLARITY_value
    Private flag_EOC_MODE_POLARITY
    Private write_EOC_MODE_POL_CORR_value
    Private read_EOC_MODE_POL_CORR_value
    Private flag_EOC_MODE_POL_CORR
    Private write_EOC_SPEED_DET_THLD_value
    Private read_EOC_SPEED_DET_THLD_value
    Private flag_EOC_SPEED_DET_THLD

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H46
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_EPON_MODE
        get_EPON_MODE = read_EPON_MODE_value
    End Property

    Property Let set_EPON_MODE(aData)
        write_EPON_MODE_value = aData
        flag_EPON_MODE        = &H1
    End Property

    Property Get read_EPON_MODE
        read
        read_EPON_MODE = read_EPON_MODE_value
    End Property

    Property Let write_EPON_MODE(aData)
        set_EPON_MODE = aData
        write
    End Property

    Property Get get_EOC_PACKET_NORM
        get_EOC_PACKET_NORM = read_EOC_PACKET_NORM_value
    End Property

    Property Let set_EOC_PACKET_NORM(aData)
        write_EOC_PACKET_NORM_value = aData
        flag_EOC_PACKET_NORM        = &H1
    End Property

    Property Get read_EOC_PACKET_NORM
        read
        read_EOC_PACKET_NORM = read_EOC_PACKET_NORM_value
    End Property

    Property Let write_EOC_PACKET_NORM(aData)
        set_EOC_PACKET_NORM = aData
        write
    End Property

    Property Get get_EPON_MODE_CRCCHECK
        get_EPON_MODE_CRCCHECK = read_EPON_MODE_CRCCHECK_value
    End Property

    Property Let set_EPON_MODE_CRCCHECK(aData)
        write_EPON_MODE_CRCCHECK_value = aData
        flag_EPON_MODE_CRCCHECK        = &H1
    End Property

    Property Get read_EPON_MODE_CRCCHECK
        read
        read_EPON_MODE_CRCCHECK = read_EPON_MODE_CRCCHECK_value
    End Property

    Property Let write_EPON_MODE_CRCCHECK(aData)
        set_EPON_MODE_CRCCHECK = aData
        write
    End Property

    Property Get get_TX_EN_EXTEND
        get_TX_EN_EXTEND = read_TX_EN_EXTEND_value
    End Property

    Property Let set_TX_EN_EXTEND(aData)
        write_TX_EN_EXTEND_value = aData
        flag_TX_EN_EXTEND        = &H1
    End Property

    Property Get read_TX_EN_EXTEND
        read
        read_TX_EN_EXTEND = read_TX_EN_EXTEND_value
    End Property

    Property Let write_TX_EN_EXTEND(aData)
        set_TX_EN_EXTEND = aData
        write
    End Property

    Property Get get_EOC_MODE_POLARITY
        get_EOC_MODE_POLARITY = read_EOC_MODE_POLARITY_value
    End Property

    Property Let set_EOC_MODE_POLARITY(aData)
        write_EOC_MODE_POLARITY_value = aData
        flag_EOC_MODE_POLARITY        = &H1
    End Property

    Property Get read_EOC_MODE_POLARITY
        read
        read_EOC_MODE_POLARITY = read_EOC_MODE_POLARITY_value
    End Property

    Property Let write_EOC_MODE_POLARITY(aData)
        set_EOC_MODE_POLARITY = aData
        write
    End Property

    Property Get get_EOC_MODE_POL_CORR
        get_EOC_MODE_POL_CORR = read_EOC_MODE_POL_CORR_value
    End Property

    Property Let set_EOC_MODE_POL_CORR(aData)
        write_EOC_MODE_POL_CORR_value = aData
        flag_EOC_MODE_POL_CORR        = &H1
    End Property

    Property Get read_EOC_MODE_POL_CORR
        read
        read_EOC_MODE_POL_CORR = read_EOC_MODE_POL_CORR_value
    End Property

    Property Let write_EOC_MODE_POL_CORR(aData)
        set_EOC_MODE_POL_CORR = aData
        write
    End Property

    Property Get get_EOC_SPEED_DET_THLD
        get_EOC_SPEED_DET_THLD = read_EOC_SPEED_DET_THLD_value
    End Property

    Property Let set_EOC_SPEED_DET_THLD(aData)
        write_EOC_SPEED_DET_THLD_value = aData
        flag_EOC_SPEED_DET_THLD        = &H1
    End Property

    Property Get read_EOC_SPEED_DET_THLD
        read
        read_EOC_SPEED_DET_THLD = read_EOC_SPEED_DET_THLD_value
    End Property

    Property Let write_EOC_SPEED_DET_THLD(aData)
        set_EOC_SPEED_DET_THLD = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_EPON_MODE_value = rightShift(data_low, 9) and &H1
        read_EOC_PACKET_NORM_value = rightShift(data_low, 8) and &H1
        read_EPON_MODE_CRCCHECK_value = rightShift(data_low, 7) and &H1
        read_TX_EN_EXTEND_value = rightShift(data_low, 6) and &H1
        read_EOC_MODE_POLARITY_value = rightShift(data_low, 5) and &H1
        read_EOC_MODE_POL_CORR_value = rightShift(data_low, 4) and &H1
        EOC_SPEED_DET_THLD_mask = &Hf
        if data_low > LONG_MAX then
            if EOC_SPEED_DET_THLD_mask = mask then
                read_EOC_SPEED_DET_THLD_value = data_low
            else
                read_EOC_SPEED_DET_THLD_value = (data_low - H8000_0000) and EOC_SPEED_DET_THLD_mask
            end If
        else
            read_EOC_SPEED_DET_THLD_value = data_low and EOC_SPEED_DET_THLD_mask
        end If

    End Sub

    Sub write
        If flag_EPON_MODE = &H0 or flag_EOC_PACKET_NORM = &H0 or flag_EPON_MODE_CRCCHECK = &H0 or flag_TX_EN_EXTEND = &H0 or flag_EOC_MODE_POLARITY = &H0 or flag_EOC_MODE_POL_CORR = &H0 or flag_EOC_SPEED_DET_THLD = &H0 Then read
        If flag_EPON_MODE = &H0 Then write_EPON_MODE_value = get_EPON_MODE
        If flag_EOC_PACKET_NORM = &H0 Then write_EOC_PACKET_NORM_value = get_EOC_PACKET_NORM
        If flag_EPON_MODE_CRCCHECK = &H0 Then write_EPON_MODE_CRCCHECK_value = get_EPON_MODE_CRCCHECK
        If flag_TX_EN_EXTEND = &H0 Then write_TX_EN_EXTEND_value = get_TX_EN_EXTEND
        If flag_EOC_MODE_POLARITY = &H0 Then write_EOC_MODE_POLARITY_value = get_EOC_MODE_POLARITY
        If flag_EOC_MODE_POL_CORR = &H0 Then write_EOC_MODE_POL_CORR_value = get_EOC_MODE_POL_CORR
        If flag_EOC_SPEED_DET_THLD = &H0 Then write_EOC_SPEED_DET_THLD_value = get_EOC_SPEED_DET_THLD

        regValue = leftShift((write_EPON_MODE_value and &H1), 9) + leftShift((write_EOC_PACKET_NORM_value and &H1), 8) + leftShift((write_EPON_MODE_CRCCHECK_value and &H1), 7) + leftShift((write_TX_EN_EXTEND_value and &H1), 6) + leftShift((write_EOC_MODE_POLARITY_value and &H1), 5) + leftShift((write_EOC_MODE_POL_CORR_value and &H1), 4) + leftShift((write_EOC_SPEED_DET_THLD_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_EPON_MODE_value = rightShift(data_low, 9) and &H1
        read_EOC_PACKET_NORM_value = rightShift(data_low, 8) and &H1
        read_EPON_MODE_CRCCHECK_value = rightShift(data_low, 7) and &H1
        read_TX_EN_EXTEND_value = rightShift(data_low, 6) and &H1
        read_EOC_MODE_POLARITY_value = rightShift(data_low, 5) and &H1
        read_EOC_MODE_POL_CORR_value = rightShift(data_low, 4) and &H1
        EOC_SPEED_DET_THLD_mask = &Hf
        if data_low > LONG_MAX then
            if EOC_SPEED_DET_THLD_mask = mask then
                read_EOC_SPEED_DET_THLD_value = data_low
            else
                read_EOC_SPEED_DET_THLD_value = (data_low - H8000_0000) and EOC_SPEED_DET_THLD_mask
            end If
        else
            read_EOC_SPEED_DET_THLD_value = data_low and EOC_SPEED_DET_THLD_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_EPON_MODE_value = &H0
        flag_EPON_MODE        = &H0
        write_EOC_PACKET_NORM_value = &H0
        flag_EOC_PACKET_NORM        = &H0
        write_EPON_MODE_CRCCHECK_value = &H0
        flag_EPON_MODE_CRCCHECK        = &H0
        write_TX_EN_EXTEND_value = &H0
        flag_TX_EN_EXTEND        = &H0
        write_EOC_MODE_POLARITY_value = &H0
        flag_EOC_MODE_POLARITY        = &H0
        write_EOC_MODE_POL_CORR_value = &H0
        flag_EOC_MODE_POL_CORR        = &H0
        write_EOC_SPEED_DET_THLD_value = &H0
        flag_EOC_SPEED_DET_THLD        = &H0
    End Sub
End Class


'' @REGISTER : CL45VEN_eee_test_ctrl_a
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ENABLE_LINK_STATUS_CHECK_ST                [13:13]          get_ENABLE_LINK_STATUS_CHECK_ST
''                                                             set_ENABLE_LINK_STATUS_CHECK_ST
''                                                             read_ENABLE_LINK_STATUS_CHECK_ST
''                                                             write_ENABLE_LINK_STATUS_CHECK_ST
''---------------------------------------------------------------------------------
'' NP_HW                                      [12:12]          get_NP_HW
''                                                             set_NP_HW
''                                                             read_NP_HW
''                                                             write_NP_HW
''---------------------------------------------------------------------------------
'' MSG_11XNP_RX_EN                            [11:11]          get_MSG_11XNP_RX_EN
''                                                             set_MSG_11XNP_RX_EN
''                                                             read_MSG_11XNP_RX_EN
''                                                             write_MSG_11XNP_RX_EN
''---------------------------------------------------------------------------------
'' MSG_11XNP_TX_EN                            [10:10]          get_MSG_11XNP_TX_EN
''                                                             set_MSG_11XNP_TX_EN
''                                                             read_MSG_11XNP_TX_EN
''                                                             write_MSG_11XNP_TX_EN
''---------------------------------------------------------------------------------
'' MSG_10_RX_EN                               [9:9]            get_MSG_10_RX_EN
''                                                             set_MSG_10_RX_EN
''                                                             read_MSG_10_RX_EN
''                                                             write_MSG_10_RX_EN
''---------------------------------------------------------------------------------
'' MSG_10_TX_EN                               [8:8]            get_MSG_10_TX_EN
''                                                             set_MSG_10_TX_EN
''                                                             read_MSG_10_TX_EN
''                                                             write_MSG_10_TX_EN
''---------------------------------------------------------------------------------
'' LPI_GPCS_TEST_BUS_EN                       [7:7]            get_LPI_GPCS_TEST_BUS_EN
''                                                             set_LPI_GPCS_TEST_BUS_EN
''                                                             read_LPI_GPCS_TEST_BUS_EN
''                                                             write_LPI_GPCS_TEST_BUS_EN
''---------------------------------------------------------------------------------
'' MACSEC_PK_MODE                             [6:6]            get_MACSEC_PK_MODE
''                                                             set_MACSEC_PK_MODE
''                                                             read_MACSEC_PK_MODE
''                                                             write_MACSEC_PK_MODE
''---------------------------------------------------------------------------------
'' MSG_9XNP_RX_EN                             [4:4]            get_MSG_9XNP_RX_EN
''                                                             set_MSG_9XNP_RX_EN
''                                                             read_MSG_9XNP_RX_EN
''                                                             write_MSG_9XNP_RX_EN
''---------------------------------------------------------------------------------
'' MSG_9XNP_TX_EN                             [3:3]            get_MSG_9XNP_TX_EN
''                                                             set_MSG_9XNP_TX_EN
''                                                             read_MSG_9XNP_TX_EN
''                                                             write_MSG_9XNP_TX_EN
''---------------------------------------------------------------------------------
'' WCFR760761                                 [2:2]            get_WCFR760761
''                                                             set_WCFR760761
''                                                             read_WCFR760761
''                                                             write_WCFR760761
''---------------------------------------------------------------------------------
'' OVERRIDE_LP_M11                            [1:1]            get_OVERRIDE_LP_M11
''                                                             set_OVERRIDE_LP_M11
''                                                             read_OVERRIDE_LP_M11
''                                                             write_OVERRIDE_LP_M11
''---------------------------------------------------------------------------------
'' OVERRIDE_LD_M11                            [0:0]            get_OVERRIDE_LD_M11
''                                                             set_OVERRIDE_LD_M11
''                                                             read_OVERRIDE_LD_M11
''                                                             write_OVERRIDE_LD_M11
''---------------------------------------------------------------------------------
Class REGISTER_CL45VEN_eee_test_ctrl_a
    Private write_ENABLE_LINK_STATUS_CHECK_ST_value
    Private read_ENABLE_LINK_STATUS_CHECK_ST_value
    Private flag_ENABLE_LINK_STATUS_CHECK_ST
    Private write_NP_HW_value
    Private read_NP_HW_value
    Private flag_NP_HW
    Private write_MSG_11XNP_RX_EN_value
    Private read_MSG_11XNP_RX_EN_value
    Private flag_MSG_11XNP_RX_EN
    Private write_MSG_11XNP_TX_EN_value
    Private read_MSG_11XNP_TX_EN_value
    Private flag_MSG_11XNP_TX_EN
    Private write_MSG_10_RX_EN_value
    Private read_MSG_10_RX_EN_value
    Private flag_MSG_10_RX_EN
    Private write_MSG_10_TX_EN_value
    Private read_MSG_10_TX_EN_value
    Private flag_MSG_10_TX_EN
    Private write_LPI_GPCS_TEST_BUS_EN_value
    Private read_LPI_GPCS_TEST_BUS_EN_value
    Private flag_LPI_GPCS_TEST_BUS_EN
    Private write_MACSEC_PK_MODE_value
    Private read_MACSEC_PK_MODE_value
    Private flag_MACSEC_PK_MODE
    Private write_MSG_9XNP_RX_EN_value
    Private read_MSG_9XNP_RX_EN_value
    Private flag_MSG_9XNP_RX_EN
    Private write_MSG_9XNP_TX_EN_value
    Private read_MSG_9XNP_TX_EN_value
    Private flag_MSG_9XNP_TX_EN
    Private write_WCFR760761_value
    Private read_WCFR760761_value
    Private flag_WCFR760761
    Private write_OVERRIDE_LP_M11_value
    Private read_OVERRIDE_LP_M11_value
    Private flag_OVERRIDE_LP_M11
    Private write_OVERRIDE_LD_M11_value
    Private read_OVERRIDE_LD_M11_value
    Private flag_OVERRIDE_LD_M11

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

    Property Get get_ENABLE_LINK_STATUS_CHECK_ST
        get_ENABLE_LINK_STATUS_CHECK_ST = read_ENABLE_LINK_STATUS_CHECK_ST_value
    End Property

    Property Let set_ENABLE_LINK_STATUS_CHECK_ST(aData)
        write_ENABLE_LINK_STATUS_CHECK_ST_value = aData
        flag_ENABLE_LINK_STATUS_CHECK_ST        = &H1
    End Property

    Property Get read_ENABLE_LINK_STATUS_CHECK_ST
        read
        read_ENABLE_LINK_STATUS_CHECK_ST = read_ENABLE_LINK_STATUS_CHECK_ST_value
    End Property

    Property Let write_ENABLE_LINK_STATUS_CHECK_ST(aData)
        set_ENABLE_LINK_STATUS_CHECK_ST = aData
        write
    End Property

    Property Get get_NP_HW
        get_NP_HW = read_NP_HW_value
    End Property

    Property Let set_NP_HW(aData)
        write_NP_HW_value = aData
        flag_NP_HW        = &H1
    End Property

    Property Get read_NP_HW
        read
        read_NP_HW = read_NP_HW_value
    End Property

    Property Let write_NP_HW(aData)
        set_NP_HW = aData
        write
    End Property

    Property Get get_MSG_11XNP_RX_EN
        get_MSG_11XNP_RX_EN = read_MSG_11XNP_RX_EN_value
    End Property

    Property Let set_MSG_11XNP_RX_EN(aData)
        write_MSG_11XNP_RX_EN_value = aData
        flag_MSG_11XNP_RX_EN        = &H1
    End Property

    Property Get read_MSG_11XNP_RX_EN
        read
        read_MSG_11XNP_RX_EN = read_MSG_11XNP_RX_EN_value
    End Property

    Property Let write_MSG_11XNP_RX_EN(aData)
        set_MSG_11XNP_RX_EN = aData
        write
    End Property

    Property Get get_MSG_11XNP_TX_EN
        get_MSG_11XNP_TX_EN = read_MSG_11XNP_TX_EN_value
    End Property

    Property Let set_MSG_11XNP_TX_EN(aData)
        write_MSG_11XNP_TX_EN_value = aData
        flag_MSG_11XNP_TX_EN        = &H1
    End Property

    Property Get read_MSG_11XNP_TX_EN
        read
        read_MSG_11XNP_TX_EN = read_MSG_11XNP_TX_EN_value
    End Property

    Property Let write_MSG_11XNP_TX_EN(aData)
        set_MSG_11XNP_TX_EN = aData
        write
    End Property

    Property Get get_MSG_10_RX_EN
        get_MSG_10_RX_EN = read_MSG_10_RX_EN_value
    End Property

    Property Let set_MSG_10_RX_EN(aData)
        write_MSG_10_RX_EN_value = aData
        flag_MSG_10_RX_EN        = &H1
    End Property

    Property Get read_MSG_10_RX_EN
        read
        read_MSG_10_RX_EN = read_MSG_10_RX_EN_value
    End Property

    Property Let write_MSG_10_RX_EN(aData)
        set_MSG_10_RX_EN = aData
        write
    End Property

    Property Get get_MSG_10_TX_EN
        get_MSG_10_TX_EN = read_MSG_10_TX_EN_value
    End Property

    Property Let set_MSG_10_TX_EN(aData)
        write_MSG_10_TX_EN_value = aData
        flag_MSG_10_TX_EN        = &H1
    End Property

    Property Get read_MSG_10_TX_EN
        read
        read_MSG_10_TX_EN = read_MSG_10_TX_EN_value
    End Property

    Property Let write_MSG_10_TX_EN(aData)
        set_MSG_10_TX_EN = aData
        write
    End Property

    Property Get get_LPI_GPCS_TEST_BUS_EN
        get_LPI_GPCS_TEST_BUS_EN = read_LPI_GPCS_TEST_BUS_EN_value
    End Property

    Property Let set_LPI_GPCS_TEST_BUS_EN(aData)
        write_LPI_GPCS_TEST_BUS_EN_value = aData
        flag_LPI_GPCS_TEST_BUS_EN        = &H1
    End Property

    Property Get read_LPI_GPCS_TEST_BUS_EN
        read
        read_LPI_GPCS_TEST_BUS_EN = read_LPI_GPCS_TEST_BUS_EN_value
    End Property

    Property Let write_LPI_GPCS_TEST_BUS_EN(aData)
        set_LPI_GPCS_TEST_BUS_EN = aData
        write
    End Property

    Property Get get_MACSEC_PK_MODE
        get_MACSEC_PK_MODE = read_MACSEC_PK_MODE_value
    End Property

    Property Let set_MACSEC_PK_MODE(aData)
        write_MACSEC_PK_MODE_value = aData
        flag_MACSEC_PK_MODE        = &H1
    End Property

    Property Get read_MACSEC_PK_MODE
        read
        read_MACSEC_PK_MODE = read_MACSEC_PK_MODE_value
    End Property

    Property Let write_MACSEC_PK_MODE(aData)
        set_MACSEC_PK_MODE = aData
        write
    End Property

    Property Get get_MSG_9XNP_RX_EN
        get_MSG_9XNP_RX_EN = read_MSG_9XNP_RX_EN_value
    End Property

    Property Let set_MSG_9XNP_RX_EN(aData)
        write_MSG_9XNP_RX_EN_value = aData
        flag_MSG_9XNP_RX_EN        = &H1
    End Property

    Property Get read_MSG_9XNP_RX_EN
        read
        read_MSG_9XNP_RX_EN = read_MSG_9XNP_RX_EN_value
    End Property

    Property Let write_MSG_9XNP_RX_EN(aData)
        set_MSG_9XNP_RX_EN = aData
        write
    End Property

    Property Get get_MSG_9XNP_TX_EN
        get_MSG_9XNP_TX_EN = read_MSG_9XNP_TX_EN_value
    End Property

    Property Let set_MSG_9XNP_TX_EN(aData)
        write_MSG_9XNP_TX_EN_value = aData
        flag_MSG_9XNP_TX_EN        = &H1
    End Property

    Property Get read_MSG_9XNP_TX_EN
        read
        read_MSG_9XNP_TX_EN = read_MSG_9XNP_TX_EN_value
    End Property

    Property Let write_MSG_9XNP_TX_EN(aData)
        set_MSG_9XNP_TX_EN = aData
        write
    End Property

    Property Get get_WCFR760761
        get_WCFR760761 = read_WCFR760761_value
    End Property

    Property Let set_WCFR760761(aData)
        write_WCFR760761_value = aData
        flag_WCFR760761        = &H1
    End Property

    Property Get read_WCFR760761
        read
        read_WCFR760761 = read_WCFR760761_value
    End Property

    Property Let write_WCFR760761(aData)
        set_WCFR760761 = aData
        write
    End Property

    Property Get get_OVERRIDE_LP_M11
        get_OVERRIDE_LP_M11 = read_OVERRIDE_LP_M11_value
    End Property

    Property Let set_OVERRIDE_LP_M11(aData)
        write_OVERRIDE_LP_M11_value = aData
        flag_OVERRIDE_LP_M11        = &H1
    End Property

    Property Get read_OVERRIDE_LP_M11
        read
        read_OVERRIDE_LP_M11 = read_OVERRIDE_LP_M11_value
    End Property

    Property Let write_OVERRIDE_LP_M11(aData)
        set_OVERRIDE_LP_M11 = aData
        write
    End Property

    Property Get get_OVERRIDE_LD_M11
        get_OVERRIDE_LD_M11 = read_OVERRIDE_LD_M11_value
    End Property

    Property Let set_OVERRIDE_LD_M11(aData)
        write_OVERRIDE_LD_M11_value = aData
        flag_OVERRIDE_LD_M11        = &H1
    End Property

    Property Get read_OVERRIDE_LD_M11
        read
        read_OVERRIDE_LD_M11 = read_OVERRIDE_LD_M11_value
    End Property

    Property Let write_OVERRIDE_LD_M11(aData)
        set_OVERRIDE_LD_M11 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ENABLE_LINK_STATUS_CHECK_ST_value = rightShift(data_low, 13) and &H1
        read_NP_HW_value = rightShift(data_low, 12) and &H1
        read_MSG_11XNP_RX_EN_value = rightShift(data_low, 11) and &H1
        read_MSG_11XNP_TX_EN_value = rightShift(data_low, 10) and &H1
        read_MSG_10_RX_EN_value = rightShift(data_low, 9) and &H1
        read_MSG_10_TX_EN_value = rightShift(data_low, 8) and &H1
        read_LPI_GPCS_TEST_BUS_EN_value = rightShift(data_low, 7) and &H1
        read_MACSEC_PK_MODE_value = rightShift(data_low, 6) and &H1
        read_MSG_9XNP_RX_EN_value = rightShift(data_low, 4) and &H1
        read_MSG_9XNP_TX_EN_value = rightShift(data_low, 3) and &H1
        read_WCFR760761_value = rightShift(data_low, 2) and &H1
        read_OVERRIDE_LP_M11_value = rightShift(data_low, 1) and &H1
        OVERRIDE_LD_M11_mask = &H1
        if data_low > LONG_MAX then
            if OVERRIDE_LD_M11_mask = mask then
                read_OVERRIDE_LD_M11_value = data_low
            else
                read_OVERRIDE_LD_M11_value = (data_low - H8000_0000) and OVERRIDE_LD_M11_mask
            end If
        else
            read_OVERRIDE_LD_M11_value = data_low and OVERRIDE_LD_M11_mask
        end If

    End Sub

    Sub write
        If flag_ENABLE_LINK_STATUS_CHECK_ST = &H0 or flag_NP_HW = &H0 or flag_MSG_11XNP_RX_EN = &H0 or flag_MSG_11XNP_TX_EN = &H0 or flag_MSG_10_RX_EN = &H0 or flag_MSG_10_TX_EN = &H0 or flag_LPI_GPCS_TEST_BUS_EN = &H0 or flag_MACSEC_PK_MODE = &H0 or flag_MSG_9XNP_RX_EN = &H0 or flag_MSG_9XNP_TX_EN = &H0 or flag_WCFR760761 = &H0 or flag_OVERRIDE_LP_M11 = &H0 or flag_OVERRIDE_LD_M11 = &H0 Then read
        If flag_ENABLE_LINK_STATUS_CHECK_ST = &H0 Then write_ENABLE_LINK_STATUS_CHECK_ST_value = get_ENABLE_LINK_STATUS_CHECK_ST
        If flag_NP_HW = &H0 Then write_NP_HW_value = get_NP_HW
        If flag_MSG_11XNP_RX_EN = &H0 Then write_MSG_11XNP_RX_EN_value = get_MSG_11XNP_RX_EN
        If flag_MSG_11XNP_TX_EN = &H0 Then write_MSG_11XNP_TX_EN_value = get_MSG_11XNP_TX_EN
        If flag_MSG_10_RX_EN = &H0 Then write_MSG_10_RX_EN_value = get_MSG_10_RX_EN
        If flag_MSG_10_TX_EN = &H0 Then write_MSG_10_TX_EN_value = get_MSG_10_TX_EN
        If flag_LPI_GPCS_TEST_BUS_EN = &H0 Then write_LPI_GPCS_TEST_BUS_EN_value = get_LPI_GPCS_TEST_BUS_EN
        If flag_MACSEC_PK_MODE = &H0 Then write_MACSEC_PK_MODE_value = get_MACSEC_PK_MODE
        If flag_MSG_9XNP_RX_EN = &H0 Then write_MSG_9XNP_RX_EN_value = get_MSG_9XNP_RX_EN
        If flag_MSG_9XNP_TX_EN = &H0 Then write_MSG_9XNP_TX_EN_value = get_MSG_9XNP_TX_EN
        If flag_WCFR760761 = &H0 Then write_WCFR760761_value = get_WCFR760761
        If flag_OVERRIDE_LP_M11 = &H0 Then write_OVERRIDE_LP_M11_value = get_OVERRIDE_LP_M11
        If flag_OVERRIDE_LD_M11 = &H0 Then write_OVERRIDE_LD_M11_value = get_OVERRIDE_LD_M11

        regValue = leftShift((write_ENABLE_LINK_STATUS_CHECK_ST_value and &H1), 13) + leftShift((write_NP_HW_value and &H1), 12) + leftShift((write_MSG_11XNP_RX_EN_value and &H1), 11) + leftShift((write_MSG_11XNP_TX_EN_value and &H1), 10) + leftShift((write_MSG_10_RX_EN_value and &H1), 9) + leftShift((write_MSG_10_TX_EN_value and &H1), 8) + leftShift((write_LPI_GPCS_TEST_BUS_EN_value and &H1), 7) + leftShift((write_MACSEC_PK_MODE_value and &H1), 6) + leftShift((write_MSG_9XNP_RX_EN_value and &H1), 4) + leftShift((write_MSG_9XNP_TX_EN_value and &H1), 3) + leftShift((write_WCFR760761_value and &H1), 2) + leftShift((write_OVERRIDE_LP_M11_value and &H1), 1) + leftShift((write_OVERRIDE_LD_M11_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ENABLE_LINK_STATUS_CHECK_ST_value = rightShift(data_low, 13) and &H1
        read_NP_HW_value = rightShift(data_low, 12) and &H1
        read_MSG_11XNP_RX_EN_value = rightShift(data_low, 11) and &H1
        read_MSG_11XNP_TX_EN_value = rightShift(data_low, 10) and &H1
        read_MSG_10_RX_EN_value = rightShift(data_low, 9) and &H1
        read_MSG_10_TX_EN_value = rightShift(data_low, 8) and &H1
        read_LPI_GPCS_TEST_BUS_EN_value = rightShift(data_low, 7) and &H1
        read_MACSEC_PK_MODE_value = rightShift(data_low, 6) and &H1
        read_MSG_9XNP_RX_EN_value = rightShift(data_low, 4) and &H1
        read_MSG_9XNP_TX_EN_value = rightShift(data_low, 3) and &H1
        read_WCFR760761_value = rightShift(data_low, 2) and &H1
        read_OVERRIDE_LP_M11_value = rightShift(data_low, 1) and &H1
        OVERRIDE_LD_M11_mask = &H1
        if data_low > LONG_MAX then
            if OVERRIDE_LD_M11_mask = mask then
                read_OVERRIDE_LD_M11_value = data_low
            else
                read_OVERRIDE_LD_M11_value = (data_low - H8000_0000) and OVERRIDE_LD_M11_mask
            end If
        else
            read_OVERRIDE_LD_M11_value = data_low and OVERRIDE_LD_M11_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ENABLE_LINK_STATUS_CHECK_ST_value = &H0
        flag_ENABLE_LINK_STATUS_CHECK_ST        = &H0
        write_NP_HW_value = &H0
        flag_NP_HW        = &H0
        write_MSG_11XNP_RX_EN_value = &H0
        flag_MSG_11XNP_RX_EN        = &H0
        write_MSG_11XNP_TX_EN_value = &H0
        flag_MSG_11XNP_TX_EN        = &H0
        write_MSG_10_RX_EN_value = &H0
        flag_MSG_10_RX_EN        = &H0
        write_MSG_10_TX_EN_value = &H0
        flag_MSG_10_TX_EN        = &H0
        write_LPI_GPCS_TEST_BUS_EN_value = &H0
        flag_LPI_GPCS_TEST_BUS_EN        = &H0
        write_MACSEC_PK_MODE_value = &H0
        flag_MACSEC_PK_MODE        = &H0
        write_MSG_9XNP_RX_EN_value = &H0
        flag_MSG_9XNP_RX_EN        = &H0
        write_MSG_9XNP_TX_EN_value = &H0
        flag_MSG_9XNP_TX_EN        = &H0
        write_WCFR760761_value = &H0
        flag_WCFR760761        = &H0
        write_OVERRIDE_LP_M11_value = &H0
        flag_OVERRIDE_LP_M11        = &H0
        write_OVERRIDE_LD_M11_value = &H0
        flag_OVERRIDE_LD_M11        = &H0
    End Sub
End Class


'' @REGISTER : CL45VEN_eee_test_ctrl_b
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LPI_FEATURE_EN                             [15:15]          get_LPI_FEATURE_EN
''                                                             set_LPI_FEATURE_EN
''                                                             read_LPI_FEATURE_EN
''                                                             write_LPI_FEATURE_EN
''---------------------------------------------------------------------------------
'' LPI_FEATURE_EN_DIG1000X                    [14:14]          get_LPI_FEATURE_EN_DIG1000X
''                                                             set_LPI_FEATURE_EN_DIG1000X
''                                                             read_LPI_FEATURE_EN_DIG1000X
''                                                             write_LPI_FEATURE_EN_DIG1000X
''---------------------------------------------------------------------------------
'' ETMFLQ                                     [13:13]          get_ETMFLQ
''                                                             set_ETMFLQ
''                                                             read_ETMFLQ
''                                                             write_ETMFLQ
''---------------------------------------------------------------------------------
'' EN_TEST_MODE_FOR_REG_3_20                  [12:12]          get_EN_TEST_MODE_FOR_REG_3_20
''                                                             set_EN_TEST_MODE_FOR_REG_3_20
''                                                             read_EN_TEST_MODE_FOR_REG_3_20
''                                                             write_EN_TEST_MODE_FOR_REG_3_20
''---------------------------------------------------------------------------------
'' EN_10BASE_TE_RES                           [11:11]          get_EN_10BASE_TE_RES
''                                                             set_EN_10BASE_TE_RES
''                                                             read_EN_10BASE_TE_RES
''                                                             write_EN_10BASE_TE_RES
''---------------------------------------------------------------------------------
'' EN_10BASE_TE_10BASE_T_RES                  [10:10]          get_EN_10BASE_TE_10BASE_T_RES
''                                                             set_EN_10BASE_TE_10BASE_T_RES
''                                                             read_EN_10BASE_TE_10BASE_T_RES
''                                                             write_EN_10BASE_TE_10BASE_T_RES
''---------------------------------------------------------------------------------
'' DET_SEND_Z                                 [9:9]            get_DET_SEND_Z
''                                                             set_DET_SEND_Z
''                                                             read_DET_SEND_Z
''                                                             write_DET_SEND_Z
''---------------------------------------------------------------------------------
'' EN_DET_SEND_Z_OVERRIDE                     [8:8]            get_EN_DET_SEND_Z_OVERRIDE
''                                                             set_EN_DET_SEND_Z_OVERRIDE
''                                                             read_EN_DET_SEND_Z_OVERRIDE
''                                                             write_EN_DET_SEND_Z_OVERRIDE
''---------------------------------------------------------------------------------
'' REM_UPD_DONE_TEST                          [7:7]            get_REM_UPD_DONE_TEST
''                                                             set_REM_UPD_DONE_TEST
''                                                             read_REM_UPD_DONE_TEST
''                                                             write_REM_UPD_DONE_TEST
''---------------------------------------------------------------------------------
'' REM_LPI_REQ_TEST                           [6:6]            get_REM_LPI_REQ_TEST
''                                                             set_REM_LPI_REQ_TEST
''                                                             read_REM_LPI_REQ_TEST
''                                                             write_REM_LPI_REQ_TEST
''---------------------------------------------------------------------------------
'' LOC_UPD_DONE_TEST                          [5:5]            get_LOC_UPD_DONE_TEST
''                                                             set_LOC_UPD_DONE_TEST
''                                                             read_LOC_UPD_DONE_TEST
''                                                             write_LOC_UPD_DONE_TEST
''---------------------------------------------------------------------------------
'' LOC_LPI_REQ_TEST                           [4:4]            get_LOC_LPI_REQ_TEST
''                                                             set_LOC_LPI_REQ_TEST
''                                                             read_LOC_LPI_REQ_TEST
''                                                             write_LOC_LPI_REQ_TEST
''---------------------------------------------------------------------------------
'' EN_REM_UPD_DONE_OVERRIDE                   [3:3]            get_EN_REM_UPD_DONE_OVERRIDE
''                                                             set_EN_REM_UPD_DONE_OVERRIDE
''                                                             read_EN_REM_UPD_DONE_OVERRIDE
''                                                             write_EN_REM_UPD_DONE_OVERRIDE
''---------------------------------------------------------------------------------
'' EN_REM_LPI_REQ_OVERRIDE                    [2:2]            get_EN_REM_LPI_REQ_OVERRIDE
''                                                             set_EN_REM_LPI_REQ_OVERRIDE
''                                                             read_EN_REM_LPI_REQ_OVERRIDE
''                                                             write_EN_REM_LPI_REQ_OVERRIDE
''---------------------------------------------------------------------------------
'' EN_LOC_UPD_DONE_OVERRIDE                   [1:1]            get_EN_LOC_UPD_DONE_OVERRIDE
''                                                             set_EN_LOC_UPD_DONE_OVERRIDE
''                                                             read_EN_LOC_UPD_DONE_OVERRIDE
''                                                             write_EN_LOC_UPD_DONE_OVERRIDE
''---------------------------------------------------------------------------------
'' EN_LOC_LPI_REQ_OVERRIDE                    [0:0]            get_EN_LOC_LPI_REQ_OVERRIDE
''                                                             set_EN_LOC_LPI_REQ_OVERRIDE
''                                                             read_EN_LOC_LPI_REQ_OVERRIDE
''                                                             write_EN_LOC_LPI_REQ_OVERRIDE
''---------------------------------------------------------------------------------
Class REGISTER_CL45VEN_eee_test_ctrl_b
    Private write_LPI_FEATURE_EN_value
    Private read_LPI_FEATURE_EN_value
    Private flag_LPI_FEATURE_EN
    Private write_LPI_FEATURE_EN_DIG1000X_value
    Private read_LPI_FEATURE_EN_DIG1000X_value
    Private flag_LPI_FEATURE_EN_DIG1000X
    Private write_ETMFLQ_value
    Private read_ETMFLQ_value
    Private flag_ETMFLQ
    Private write_EN_TEST_MODE_FOR_REG_3_20_value
    Private read_EN_TEST_MODE_FOR_REG_3_20_value
    Private flag_EN_TEST_MODE_FOR_REG_3_20
    Private write_EN_10BASE_TE_RES_value
    Private read_EN_10BASE_TE_RES_value
    Private flag_EN_10BASE_TE_RES
    Private write_EN_10BASE_TE_10BASE_T_RES_value
    Private read_EN_10BASE_TE_10BASE_T_RES_value
    Private flag_EN_10BASE_TE_10BASE_T_RES
    Private write_DET_SEND_Z_value
    Private read_DET_SEND_Z_value
    Private flag_DET_SEND_Z
    Private write_EN_DET_SEND_Z_OVERRIDE_value
    Private read_EN_DET_SEND_Z_OVERRIDE_value
    Private flag_EN_DET_SEND_Z_OVERRIDE
    Private write_REM_UPD_DONE_TEST_value
    Private read_REM_UPD_DONE_TEST_value
    Private flag_REM_UPD_DONE_TEST
    Private write_REM_LPI_REQ_TEST_value
    Private read_REM_LPI_REQ_TEST_value
    Private flag_REM_LPI_REQ_TEST
    Private write_LOC_UPD_DONE_TEST_value
    Private read_LOC_UPD_DONE_TEST_value
    Private flag_LOC_UPD_DONE_TEST
    Private write_LOC_LPI_REQ_TEST_value
    Private read_LOC_LPI_REQ_TEST_value
    Private flag_LOC_LPI_REQ_TEST
    Private write_EN_REM_UPD_DONE_OVERRIDE_value
    Private read_EN_REM_UPD_DONE_OVERRIDE_value
    Private flag_EN_REM_UPD_DONE_OVERRIDE
    Private write_EN_REM_LPI_REQ_OVERRIDE_value
    Private read_EN_REM_LPI_REQ_OVERRIDE_value
    Private flag_EN_REM_LPI_REQ_OVERRIDE
    Private write_EN_LOC_UPD_DONE_OVERRIDE_value
    Private read_EN_LOC_UPD_DONE_OVERRIDE_value
    Private flag_EN_LOC_UPD_DONE_OVERRIDE
    Private write_EN_LOC_LPI_REQ_OVERRIDE_value
    Private read_EN_LOC_LPI_REQ_OVERRIDE_value
    Private flag_EN_LOC_LPI_REQ_OVERRIDE

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H62
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_LPI_FEATURE_EN
        get_LPI_FEATURE_EN = read_LPI_FEATURE_EN_value
    End Property

    Property Let set_LPI_FEATURE_EN(aData)
        write_LPI_FEATURE_EN_value = aData
        flag_LPI_FEATURE_EN        = &H1
    End Property

    Property Get read_LPI_FEATURE_EN
        read
        read_LPI_FEATURE_EN = read_LPI_FEATURE_EN_value
    End Property

    Property Let write_LPI_FEATURE_EN(aData)
        set_LPI_FEATURE_EN = aData
        write
    End Property

    Property Get get_LPI_FEATURE_EN_DIG1000X
        get_LPI_FEATURE_EN_DIG1000X = read_LPI_FEATURE_EN_DIG1000X_value
    End Property

    Property Let set_LPI_FEATURE_EN_DIG1000X(aData)
        write_LPI_FEATURE_EN_DIG1000X_value = aData
        flag_LPI_FEATURE_EN_DIG1000X        = &H1
    End Property

    Property Get read_LPI_FEATURE_EN_DIG1000X
        read
        read_LPI_FEATURE_EN_DIG1000X = read_LPI_FEATURE_EN_DIG1000X_value
    End Property

    Property Let write_LPI_FEATURE_EN_DIG1000X(aData)
        set_LPI_FEATURE_EN_DIG1000X = aData
        write
    End Property

    Property Get get_ETMFLQ
        get_ETMFLQ = read_ETMFLQ_value
    End Property

    Property Let set_ETMFLQ(aData)
        write_ETMFLQ_value = aData
        flag_ETMFLQ        = &H1
    End Property

    Property Get read_ETMFLQ
        read
        read_ETMFLQ = read_ETMFLQ_value
    End Property

    Property Let write_ETMFLQ(aData)
        set_ETMFLQ = aData
        write
    End Property

    Property Get get_EN_TEST_MODE_FOR_REG_3_20
        get_EN_TEST_MODE_FOR_REG_3_20 = read_EN_TEST_MODE_FOR_REG_3_20_value
    End Property

    Property Let set_EN_TEST_MODE_FOR_REG_3_20(aData)
        write_EN_TEST_MODE_FOR_REG_3_20_value = aData
        flag_EN_TEST_MODE_FOR_REG_3_20        = &H1
    End Property

    Property Get read_EN_TEST_MODE_FOR_REG_3_20
        read
        read_EN_TEST_MODE_FOR_REG_3_20 = read_EN_TEST_MODE_FOR_REG_3_20_value
    End Property

    Property Let write_EN_TEST_MODE_FOR_REG_3_20(aData)
        set_EN_TEST_MODE_FOR_REG_3_20 = aData
        write
    End Property

    Property Get get_EN_10BASE_TE_RES
        get_EN_10BASE_TE_RES = read_EN_10BASE_TE_RES_value
    End Property

    Property Let set_EN_10BASE_TE_RES(aData)
        write_EN_10BASE_TE_RES_value = aData
        flag_EN_10BASE_TE_RES        = &H1
    End Property

    Property Get read_EN_10BASE_TE_RES
        read
        read_EN_10BASE_TE_RES = read_EN_10BASE_TE_RES_value
    End Property

    Property Let write_EN_10BASE_TE_RES(aData)
        set_EN_10BASE_TE_RES = aData
        write
    End Property

    Property Get get_EN_10BASE_TE_10BASE_T_RES
        get_EN_10BASE_TE_10BASE_T_RES = read_EN_10BASE_TE_10BASE_T_RES_value
    End Property

    Property Let set_EN_10BASE_TE_10BASE_T_RES(aData)
        write_EN_10BASE_TE_10BASE_T_RES_value = aData
        flag_EN_10BASE_TE_10BASE_T_RES        = &H1
    End Property

    Property Get read_EN_10BASE_TE_10BASE_T_RES
        read
        read_EN_10BASE_TE_10BASE_T_RES = read_EN_10BASE_TE_10BASE_T_RES_value
    End Property

    Property Let write_EN_10BASE_TE_10BASE_T_RES(aData)
        set_EN_10BASE_TE_10BASE_T_RES = aData
        write
    End Property

    Property Get get_DET_SEND_Z
        get_DET_SEND_Z = read_DET_SEND_Z_value
    End Property

    Property Let set_DET_SEND_Z(aData)
        write_DET_SEND_Z_value = aData
        flag_DET_SEND_Z        = &H1
    End Property

    Property Get read_DET_SEND_Z
        read
        read_DET_SEND_Z = read_DET_SEND_Z_value
    End Property

    Property Let write_DET_SEND_Z(aData)
        set_DET_SEND_Z = aData
        write
    End Property

    Property Get get_EN_DET_SEND_Z_OVERRIDE
        get_EN_DET_SEND_Z_OVERRIDE = read_EN_DET_SEND_Z_OVERRIDE_value
    End Property

    Property Let set_EN_DET_SEND_Z_OVERRIDE(aData)
        write_EN_DET_SEND_Z_OVERRIDE_value = aData
        flag_EN_DET_SEND_Z_OVERRIDE        = &H1
    End Property

    Property Get read_EN_DET_SEND_Z_OVERRIDE
        read
        read_EN_DET_SEND_Z_OVERRIDE = read_EN_DET_SEND_Z_OVERRIDE_value
    End Property

    Property Let write_EN_DET_SEND_Z_OVERRIDE(aData)
        set_EN_DET_SEND_Z_OVERRIDE = aData
        write
    End Property

    Property Get get_REM_UPD_DONE_TEST
        get_REM_UPD_DONE_TEST = read_REM_UPD_DONE_TEST_value
    End Property

    Property Let set_REM_UPD_DONE_TEST(aData)
        write_REM_UPD_DONE_TEST_value = aData
        flag_REM_UPD_DONE_TEST        = &H1
    End Property

    Property Get read_REM_UPD_DONE_TEST
        read
        read_REM_UPD_DONE_TEST = read_REM_UPD_DONE_TEST_value
    End Property

    Property Let write_REM_UPD_DONE_TEST(aData)
        set_REM_UPD_DONE_TEST = aData
        write
    End Property

    Property Get get_REM_LPI_REQ_TEST
        get_REM_LPI_REQ_TEST = read_REM_LPI_REQ_TEST_value
    End Property

    Property Let set_REM_LPI_REQ_TEST(aData)
        write_REM_LPI_REQ_TEST_value = aData
        flag_REM_LPI_REQ_TEST        = &H1
    End Property

    Property Get read_REM_LPI_REQ_TEST
        read
        read_REM_LPI_REQ_TEST = read_REM_LPI_REQ_TEST_value
    End Property

    Property Let write_REM_LPI_REQ_TEST(aData)
        set_REM_LPI_REQ_TEST = aData
        write
    End Property

    Property Get get_LOC_UPD_DONE_TEST
        get_LOC_UPD_DONE_TEST = read_LOC_UPD_DONE_TEST_value
    End Property

    Property Let set_LOC_UPD_DONE_TEST(aData)
        write_LOC_UPD_DONE_TEST_value = aData
        flag_LOC_UPD_DONE_TEST        = &H1
    End Property

    Property Get read_LOC_UPD_DONE_TEST
        read
        read_LOC_UPD_DONE_TEST = read_LOC_UPD_DONE_TEST_value
    End Property

    Property Let write_LOC_UPD_DONE_TEST(aData)
        set_LOC_UPD_DONE_TEST = aData
        write
    End Property

    Property Get get_LOC_LPI_REQ_TEST
        get_LOC_LPI_REQ_TEST = read_LOC_LPI_REQ_TEST_value
    End Property

    Property Let set_LOC_LPI_REQ_TEST(aData)
        write_LOC_LPI_REQ_TEST_value = aData
        flag_LOC_LPI_REQ_TEST        = &H1
    End Property

    Property Get read_LOC_LPI_REQ_TEST
        read
        read_LOC_LPI_REQ_TEST = read_LOC_LPI_REQ_TEST_value
    End Property

    Property Let write_LOC_LPI_REQ_TEST(aData)
        set_LOC_LPI_REQ_TEST = aData
        write
    End Property

    Property Get get_EN_REM_UPD_DONE_OVERRIDE
        get_EN_REM_UPD_DONE_OVERRIDE = read_EN_REM_UPD_DONE_OVERRIDE_value
    End Property

    Property Let set_EN_REM_UPD_DONE_OVERRIDE(aData)
        write_EN_REM_UPD_DONE_OVERRIDE_value = aData
        flag_EN_REM_UPD_DONE_OVERRIDE        = &H1
    End Property

    Property Get read_EN_REM_UPD_DONE_OVERRIDE
        read
        read_EN_REM_UPD_DONE_OVERRIDE = read_EN_REM_UPD_DONE_OVERRIDE_value
    End Property

    Property Let write_EN_REM_UPD_DONE_OVERRIDE(aData)
        set_EN_REM_UPD_DONE_OVERRIDE = aData
        write
    End Property

    Property Get get_EN_REM_LPI_REQ_OVERRIDE
        get_EN_REM_LPI_REQ_OVERRIDE = read_EN_REM_LPI_REQ_OVERRIDE_value
    End Property

    Property Let set_EN_REM_LPI_REQ_OVERRIDE(aData)
        write_EN_REM_LPI_REQ_OVERRIDE_value = aData
        flag_EN_REM_LPI_REQ_OVERRIDE        = &H1
    End Property

    Property Get read_EN_REM_LPI_REQ_OVERRIDE
        read
        read_EN_REM_LPI_REQ_OVERRIDE = read_EN_REM_LPI_REQ_OVERRIDE_value
    End Property

    Property Let write_EN_REM_LPI_REQ_OVERRIDE(aData)
        set_EN_REM_LPI_REQ_OVERRIDE = aData
        write
    End Property

    Property Get get_EN_LOC_UPD_DONE_OVERRIDE
        get_EN_LOC_UPD_DONE_OVERRIDE = read_EN_LOC_UPD_DONE_OVERRIDE_value
    End Property

    Property Let set_EN_LOC_UPD_DONE_OVERRIDE(aData)
        write_EN_LOC_UPD_DONE_OVERRIDE_value = aData
        flag_EN_LOC_UPD_DONE_OVERRIDE        = &H1
    End Property

    Property Get read_EN_LOC_UPD_DONE_OVERRIDE
        read
        read_EN_LOC_UPD_DONE_OVERRIDE = read_EN_LOC_UPD_DONE_OVERRIDE_value
    End Property

    Property Let write_EN_LOC_UPD_DONE_OVERRIDE(aData)
        set_EN_LOC_UPD_DONE_OVERRIDE = aData
        write
    End Property

    Property Get get_EN_LOC_LPI_REQ_OVERRIDE
        get_EN_LOC_LPI_REQ_OVERRIDE = read_EN_LOC_LPI_REQ_OVERRIDE_value
    End Property

    Property Let set_EN_LOC_LPI_REQ_OVERRIDE(aData)
        write_EN_LOC_LPI_REQ_OVERRIDE_value = aData
        flag_EN_LOC_LPI_REQ_OVERRIDE        = &H1
    End Property

    Property Get read_EN_LOC_LPI_REQ_OVERRIDE
        read
        read_EN_LOC_LPI_REQ_OVERRIDE = read_EN_LOC_LPI_REQ_OVERRIDE_value
    End Property

    Property Let write_EN_LOC_LPI_REQ_OVERRIDE(aData)
        set_EN_LOC_LPI_REQ_OVERRIDE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LPI_FEATURE_EN_value = rightShift(data_low, 15) and &H1
        read_LPI_FEATURE_EN_DIG1000X_value = rightShift(data_low, 14) and &H1
        read_ETMFLQ_value = rightShift(data_low, 13) and &H1
        read_EN_TEST_MODE_FOR_REG_3_20_value = rightShift(data_low, 12) and &H1
        read_EN_10BASE_TE_RES_value = rightShift(data_low, 11) and &H1
        read_EN_10BASE_TE_10BASE_T_RES_value = rightShift(data_low, 10) and &H1
        read_DET_SEND_Z_value = rightShift(data_low, 9) and &H1
        read_EN_DET_SEND_Z_OVERRIDE_value = rightShift(data_low, 8) and &H1
        read_REM_UPD_DONE_TEST_value = rightShift(data_low, 7) and &H1
        read_REM_LPI_REQ_TEST_value = rightShift(data_low, 6) and &H1
        read_LOC_UPD_DONE_TEST_value = rightShift(data_low, 5) and &H1
        read_LOC_LPI_REQ_TEST_value = rightShift(data_low, 4) and &H1
        read_EN_REM_UPD_DONE_OVERRIDE_value = rightShift(data_low, 3) and &H1
        read_EN_REM_LPI_REQ_OVERRIDE_value = rightShift(data_low, 2) and &H1
        read_EN_LOC_UPD_DONE_OVERRIDE_value = rightShift(data_low, 1) and &H1
        EN_LOC_LPI_REQ_OVERRIDE_mask = &H1
        if data_low > LONG_MAX then
            if EN_LOC_LPI_REQ_OVERRIDE_mask = mask then
                read_EN_LOC_LPI_REQ_OVERRIDE_value = data_low
            else
                read_EN_LOC_LPI_REQ_OVERRIDE_value = (data_low - H8000_0000) and EN_LOC_LPI_REQ_OVERRIDE_mask
            end If
        else
            read_EN_LOC_LPI_REQ_OVERRIDE_value = data_low and EN_LOC_LPI_REQ_OVERRIDE_mask
        end If

    End Sub

    Sub write
        If flag_LPI_FEATURE_EN = &H0 or flag_LPI_FEATURE_EN_DIG1000X = &H0 or flag_ETMFLQ = &H0 or flag_EN_TEST_MODE_FOR_REG_3_20 = &H0 or flag_EN_10BASE_TE_RES = &H0 or flag_EN_10BASE_TE_10BASE_T_RES = &H0 or flag_DET_SEND_Z = &H0 or flag_EN_DET_SEND_Z_OVERRIDE = &H0 or flag_REM_UPD_DONE_TEST = &H0 or flag_REM_LPI_REQ_TEST = &H0 or flag_LOC_UPD_DONE_TEST = &H0 or flag_LOC_LPI_REQ_TEST = &H0 or flag_EN_REM_UPD_DONE_OVERRIDE = &H0 or flag_EN_REM_LPI_REQ_OVERRIDE = &H0 or flag_EN_LOC_UPD_DONE_OVERRIDE = &H0 or flag_EN_LOC_LPI_REQ_OVERRIDE = &H0 Then read
        If flag_LPI_FEATURE_EN = &H0 Then write_LPI_FEATURE_EN_value = get_LPI_FEATURE_EN
        If flag_LPI_FEATURE_EN_DIG1000X = &H0 Then write_LPI_FEATURE_EN_DIG1000X_value = get_LPI_FEATURE_EN_DIG1000X
        If flag_ETMFLQ = &H0 Then write_ETMFLQ_value = get_ETMFLQ
        If flag_EN_TEST_MODE_FOR_REG_3_20 = &H0 Then write_EN_TEST_MODE_FOR_REG_3_20_value = get_EN_TEST_MODE_FOR_REG_3_20
        If flag_EN_10BASE_TE_RES = &H0 Then write_EN_10BASE_TE_RES_value = get_EN_10BASE_TE_RES
        If flag_EN_10BASE_TE_10BASE_T_RES = &H0 Then write_EN_10BASE_TE_10BASE_T_RES_value = get_EN_10BASE_TE_10BASE_T_RES
        If flag_DET_SEND_Z = &H0 Then write_DET_SEND_Z_value = get_DET_SEND_Z
        If flag_EN_DET_SEND_Z_OVERRIDE = &H0 Then write_EN_DET_SEND_Z_OVERRIDE_value = get_EN_DET_SEND_Z_OVERRIDE
        If flag_REM_UPD_DONE_TEST = &H0 Then write_REM_UPD_DONE_TEST_value = get_REM_UPD_DONE_TEST
        If flag_REM_LPI_REQ_TEST = &H0 Then write_REM_LPI_REQ_TEST_value = get_REM_LPI_REQ_TEST
        If flag_LOC_UPD_DONE_TEST = &H0 Then write_LOC_UPD_DONE_TEST_value = get_LOC_UPD_DONE_TEST
        If flag_LOC_LPI_REQ_TEST = &H0 Then write_LOC_LPI_REQ_TEST_value = get_LOC_LPI_REQ_TEST
        If flag_EN_REM_UPD_DONE_OVERRIDE = &H0 Then write_EN_REM_UPD_DONE_OVERRIDE_value = get_EN_REM_UPD_DONE_OVERRIDE
        If flag_EN_REM_LPI_REQ_OVERRIDE = &H0 Then write_EN_REM_LPI_REQ_OVERRIDE_value = get_EN_REM_LPI_REQ_OVERRIDE
        If flag_EN_LOC_UPD_DONE_OVERRIDE = &H0 Then write_EN_LOC_UPD_DONE_OVERRIDE_value = get_EN_LOC_UPD_DONE_OVERRIDE
        If flag_EN_LOC_LPI_REQ_OVERRIDE = &H0 Then write_EN_LOC_LPI_REQ_OVERRIDE_value = get_EN_LOC_LPI_REQ_OVERRIDE

        regValue = leftShift((write_LPI_FEATURE_EN_value and &H1), 15) + leftShift((write_LPI_FEATURE_EN_DIG1000X_value and &H1), 14) + leftShift((write_ETMFLQ_value and &H1), 13) + leftShift((write_EN_TEST_MODE_FOR_REG_3_20_value and &H1), 12) + leftShift((write_EN_10BASE_TE_RES_value and &H1), 11) + leftShift((write_EN_10BASE_TE_10BASE_T_RES_value and &H1), 10) + leftShift((write_DET_SEND_Z_value and &H1), 9) + leftShift((write_EN_DET_SEND_Z_OVERRIDE_value and &H1), 8) + leftShift((write_REM_UPD_DONE_TEST_value and &H1), 7) + leftShift((write_REM_LPI_REQ_TEST_value and &H1), 6) + leftShift((write_LOC_UPD_DONE_TEST_value and &H1), 5) + leftShift((write_LOC_LPI_REQ_TEST_value and &H1), 4) + leftShift((write_EN_REM_UPD_DONE_OVERRIDE_value and &H1), 3) + leftShift((write_EN_REM_LPI_REQ_OVERRIDE_value and &H1), 2) + leftShift((write_EN_LOC_UPD_DONE_OVERRIDE_value and &H1), 1) + leftShift((write_EN_LOC_LPI_REQ_OVERRIDE_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LPI_FEATURE_EN_value = rightShift(data_low, 15) and &H1
        read_LPI_FEATURE_EN_DIG1000X_value = rightShift(data_low, 14) and &H1
        read_ETMFLQ_value = rightShift(data_low, 13) and &H1
        read_EN_TEST_MODE_FOR_REG_3_20_value = rightShift(data_low, 12) and &H1
        read_EN_10BASE_TE_RES_value = rightShift(data_low, 11) and &H1
        read_EN_10BASE_TE_10BASE_T_RES_value = rightShift(data_low, 10) and &H1
        read_DET_SEND_Z_value = rightShift(data_low, 9) and &H1
        read_EN_DET_SEND_Z_OVERRIDE_value = rightShift(data_low, 8) and &H1
        read_REM_UPD_DONE_TEST_value = rightShift(data_low, 7) and &H1
        read_REM_LPI_REQ_TEST_value = rightShift(data_low, 6) and &H1
        read_LOC_UPD_DONE_TEST_value = rightShift(data_low, 5) and &H1
        read_LOC_LPI_REQ_TEST_value = rightShift(data_low, 4) and &H1
        read_EN_REM_UPD_DONE_OVERRIDE_value = rightShift(data_low, 3) and &H1
        read_EN_REM_LPI_REQ_OVERRIDE_value = rightShift(data_low, 2) and &H1
        read_EN_LOC_UPD_DONE_OVERRIDE_value = rightShift(data_low, 1) and &H1
        EN_LOC_LPI_REQ_OVERRIDE_mask = &H1
        if data_low > LONG_MAX then
            if EN_LOC_LPI_REQ_OVERRIDE_mask = mask then
                read_EN_LOC_LPI_REQ_OVERRIDE_value = data_low
            else
                read_EN_LOC_LPI_REQ_OVERRIDE_value = (data_low - H8000_0000) and EN_LOC_LPI_REQ_OVERRIDE_mask
            end If
        else
            read_EN_LOC_LPI_REQ_OVERRIDE_value = data_low and EN_LOC_LPI_REQ_OVERRIDE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LPI_FEATURE_EN_value = &H0
        flag_LPI_FEATURE_EN        = &H0
        write_LPI_FEATURE_EN_DIG1000X_value = &H0
        flag_LPI_FEATURE_EN_DIG1000X        = &H0
        write_ETMFLQ_value = &H0
        flag_ETMFLQ        = &H0
        write_EN_TEST_MODE_FOR_REG_3_20_value = &H0
        flag_EN_TEST_MODE_FOR_REG_3_20        = &H0
        write_EN_10BASE_TE_RES_value = &H0
        flag_EN_10BASE_TE_RES        = &H0
        write_EN_10BASE_TE_10BASE_T_RES_value = &H0
        flag_EN_10BASE_TE_10BASE_T_RES        = &H0
        write_DET_SEND_Z_value = &H0
        flag_DET_SEND_Z        = &H0
        write_EN_DET_SEND_Z_OVERRIDE_value = &H0
        flag_EN_DET_SEND_Z_OVERRIDE        = &H0
        write_REM_UPD_DONE_TEST_value = &H0
        flag_REM_UPD_DONE_TEST        = &H0
        write_REM_LPI_REQ_TEST_value = &H0
        flag_REM_LPI_REQ_TEST        = &H0
        write_LOC_UPD_DONE_TEST_value = &H0
        flag_LOC_UPD_DONE_TEST        = &H0
        write_LOC_LPI_REQ_TEST_value = &H0
        flag_LOC_LPI_REQ_TEST        = &H0
        write_EN_REM_UPD_DONE_OVERRIDE_value = &H0
        flag_EN_REM_UPD_DONE_OVERRIDE        = &H0
        write_EN_REM_LPI_REQ_OVERRIDE_value = &H0
        flag_EN_REM_LPI_REQ_OVERRIDE        = &H0
        write_EN_LOC_UPD_DONE_OVERRIDE_value = &H0
        flag_EN_LOC_UPD_DONE_OVERRIDE        = &H0
        write_EN_LOC_LPI_REQ_OVERRIDE_value = &H0
        flag_EN_LOC_LPI_REQ_OVERRIDE        = &H0
    End Sub
End Class


'' @REGISTER : CL45VEN_eee_test_ctrl_c
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_6_XNP_RX_EN                            [15:15]          get_MSG_6_XNP_RX_EN
''                                                             set_MSG_6_XNP_RX_EN
''                                                             read_MSG_6_XNP_RX_EN
''                                                             write_MSG_6_XNP_RX_EN
''---------------------------------------------------------------------------------
'' MSG_6_XNP_TX_EN                            [14:14]          get_MSG_6_XNP_TX_EN
''                                                             set_MSG_6_XNP_TX_EN
''                                                             read_MSG_6_XNP_TX_EN
''                                                             write_MSG_6_XNP_TX_EN
''---------------------------------------------------------------------------------
'' MSG_6_RX_EN                                [13:13]          get_MSG_6_RX_EN
''                                                             set_MSG_6_RX_EN
''                                                             read_MSG_6_RX_EN
''                                                             write_MSG_6_RX_EN
''---------------------------------------------------------------------------------
'' MSG_6_TX_EN                                [12:12]          get_MSG_6_TX_EN
''                                                             set_MSG_6_TX_EN
''                                                             read_MSG_6_TX_EN
''                                                             write_MSG_6_TX_EN
''---------------------------------------------------------------------------------
'' MSG_5_XNP_RX_EN                            [11:11]          get_MSG_5_XNP_RX_EN
''                                                             set_MSG_5_XNP_RX_EN
''                                                             read_MSG_5_XNP_RX_EN
''                                                             write_MSG_5_XNP_RX_EN
''---------------------------------------------------------------------------------
'' MSG_5_XNP_TX_EN                            [10:10]          get_MSG_5_XNP_TX_EN
''                                                             set_MSG_5_XNP_TX_EN
''                                                             read_MSG_5_XNP_TX_EN
''                                                             write_MSG_5_XNP_TX_EN
''---------------------------------------------------------------------------------
'' MSG_5_RX_EN                                [9:9]            get_MSG_5_RX_EN
''                                                             set_MSG_5_RX_EN
''                                                             read_MSG_5_RX_EN
''                                                             write_MSG_5_RX_EN
''---------------------------------------------------------------------------------
'' MSG_5_TX_EN                                [8:8]            get_MSG_5_TX_EN
''                                                             set_MSG_5_TX_EN
''                                                             read_MSG_5_TX_EN
''                                                             write_MSG_5_TX_EN
''---------------------------------------------------------------------------------
'' MESSAGE_5_RX_EN_2P5G_5G                    [1:1]            get_MESSAGE_5_RX_EN_2P5G_5G
''                                                             set_MESSAGE_5_RX_EN_2P5G_5G
''                                                             read_MESSAGE_5_RX_EN_2P5G_5G
''                                                             write_MESSAGE_5_RX_EN_2P5G_5G
''---------------------------------------------------------------------------------
'' MESSAGE_5_TX_EN_2P5G_5G                    [0:0]            get_MESSAGE_5_TX_EN_2P5G_5G
''                                                             set_MESSAGE_5_TX_EN_2P5G_5G
''                                                             read_MESSAGE_5_TX_EN_2P5G_5G
''                                                             write_MESSAGE_5_TX_EN_2P5G_5G
''---------------------------------------------------------------------------------
Class REGISTER_CL45VEN_eee_test_ctrl_c
    Private write_MSG_6_XNP_RX_EN_value
    Private read_MSG_6_XNP_RX_EN_value
    Private flag_MSG_6_XNP_RX_EN
    Private write_MSG_6_XNP_TX_EN_value
    Private read_MSG_6_XNP_TX_EN_value
    Private flag_MSG_6_XNP_TX_EN
    Private write_MSG_6_RX_EN_value
    Private read_MSG_6_RX_EN_value
    Private flag_MSG_6_RX_EN
    Private write_MSG_6_TX_EN_value
    Private read_MSG_6_TX_EN_value
    Private flag_MSG_6_TX_EN
    Private write_MSG_5_XNP_RX_EN_value
    Private read_MSG_5_XNP_RX_EN_value
    Private flag_MSG_5_XNP_RX_EN
    Private write_MSG_5_XNP_TX_EN_value
    Private read_MSG_5_XNP_TX_EN_value
    Private flag_MSG_5_XNP_TX_EN
    Private write_MSG_5_RX_EN_value
    Private read_MSG_5_RX_EN_value
    Private flag_MSG_5_RX_EN
    Private write_MSG_5_TX_EN_value
    Private read_MSG_5_TX_EN_value
    Private flag_MSG_5_TX_EN
    Private write_MESSAGE_5_RX_EN_2P5G_5G_value
    Private read_MESSAGE_5_RX_EN_2P5G_5G_value
    Private flag_MESSAGE_5_RX_EN_2P5G_5G
    Private write_MESSAGE_5_TX_EN_2P5G_5G_value
    Private read_MESSAGE_5_TX_EN_2P5G_5G_value
    Private flag_MESSAGE_5_TX_EN_2P5G_5G

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

    Property Get get_MSG_6_XNP_RX_EN
        get_MSG_6_XNP_RX_EN = read_MSG_6_XNP_RX_EN_value
    End Property

    Property Let set_MSG_6_XNP_RX_EN(aData)
        write_MSG_6_XNP_RX_EN_value = aData
        flag_MSG_6_XNP_RX_EN        = &H1
    End Property

    Property Get read_MSG_6_XNP_RX_EN
        read
        read_MSG_6_XNP_RX_EN = read_MSG_6_XNP_RX_EN_value
    End Property

    Property Let write_MSG_6_XNP_RX_EN(aData)
        set_MSG_6_XNP_RX_EN = aData
        write
    End Property

    Property Get get_MSG_6_XNP_TX_EN
        get_MSG_6_XNP_TX_EN = read_MSG_6_XNP_TX_EN_value
    End Property

    Property Let set_MSG_6_XNP_TX_EN(aData)
        write_MSG_6_XNP_TX_EN_value = aData
        flag_MSG_6_XNP_TX_EN        = &H1
    End Property

    Property Get read_MSG_6_XNP_TX_EN
        read
        read_MSG_6_XNP_TX_EN = read_MSG_6_XNP_TX_EN_value
    End Property

    Property Let write_MSG_6_XNP_TX_EN(aData)
        set_MSG_6_XNP_TX_EN = aData
        write
    End Property

    Property Get get_MSG_6_RX_EN
        get_MSG_6_RX_EN = read_MSG_6_RX_EN_value
    End Property

    Property Let set_MSG_6_RX_EN(aData)
        write_MSG_6_RX_EN_value = aData
        flag_MSG_6_RX_EN        = &H1
    End Property

    Property Get read_MSG_6_RX_EN
        read
        read_MSG_6_RX_EN = read_MSG_6_RX_EN_value
    End Property

    Property Let write_MSG_6_RX_EN(aData)
        set_MSG_6_RX_EN = aData
        write
    End Property

    Property Get get_MSG_6_TX_EN
        get_MSG_6_TX_EN = read_MSG_6_TX_EN_value
    End Property

    Property Let set_MSG_6_TX_EN(aData)
        write_MSG_6_TX_EN_value = aData
        flag_MSG_6_TX_EN        = &H1
    End Property

    Property Get read_MSG_6_TX_EN
        read
        read_MSG_6_TX_EN = read_MSG_6_TX_EN_value
    End Property

    Property Let write_MSG_6_TX_EN(aData)
        set_MSG_6_TX_EN = aData
        write
    End Property

    Property Get get_MSG_5_XNP_RX_EN
        get_MSG_5_XNP_RX_EN = read_MSG_5_XNP_RX_EN_value
    End Property

    Property Let set_MSG_5_XNP_RX_EN(aData)
        write_MSG_5_XNP_RX_EN_value = aData
        flag_MSG_5_XNP_RX_EN        = &H1
    End Property

    Property Get read_MSG_5_XNP_RX_EN
        read
        read_MSG_5_XNP_RX_EN = read_MSG_5_XNP_RX_EN_value
    End Property

    Property Let write_MSG_5_XNP_RX_EN(aData)
        set_MSG_5_XNP_RX_EN = aData
        write
    End Property

    Property Get get_MSG_5_XNP_TX_EN
        get_MSG_5_XNP_TX_EN = read_MSG_5_XNP_TX_EN_value
    End Property

    Property Let set_MSG_5_XNP_TX_EN(aData)
        write_MSG_5_XNP_TX_EN_value = aData
        flag_MSG_5_XNP_TX_EN        = &H1
    End Property

    Property Get read_MSG_5_XNP_TX_EN
        read
        read_MSG_5_XNP_TX_EN = read_MSG_5_XNP_TX_EN_value
    End Property

    Property Let write_MSG_5_XNP_TX_EN(aData)
        set_MSG_5_XNP_TX_EN = aData
        write
    End Property

    Property Get get_MSG_5_RX_EN
        get_MSG_5_RX_EN = read_MSG_5_RX_EN_value
    End Property

    Property Let set_MSG_5_RX_EN(aData)
        write_MSG_5_RX_EN_value = aData
        flag_MSG_5_RX_EN        = &H1
    End Property

    Property Get read_MSG_5_RX_EN
        read
        read_MSG_5_RX_EN = read_MSG_5_RX_EN_value
    End Property

    Property Let write_MSG_5_RX_EN(aData)
        set_MSG_5_RX_EN = aData
        write
    End Property

    Property Get get_MSG_5_TX_EN
        get_MSG_5_TX_EN = read_MSG_5_TX_EN_value
    End Property

    Property Let set_MSG_5_TX_EN(aData)
        write_MSG_5_TX_EN_value = aData
        flag_MSG_5_TX_EN        = &H1
    End Property

    Property Get read_MSG_5_TX_EN
        read
        read_MSG_5_TX_EN = read_MSG_5_TX_EN_value
    End Property

    Property Let write_MSG_5_TX_EN(aData)
        set_MSG_5_TX_EN = aData
        write
    End Property

    Property Get get_MESSAGE_5_RX_EN_2P5G_5G
        get_MESSAGE_5_RX_EN_2P5G_5G = read_MESSAGE_5_RX_EN_2P5G_5G_value
    End Property

    Property Let set_MESSAGE_5_RX_EN_2P5G_5G(aData)
        write_MESSAGE_5_RX_EN_2P5G_5G_value = aData
        flag_MESSAGE_5_RX_EN_2P5G_5G        = &H1
    End Property

    Property Get read_MESSAGE_5_RX_EN_2P5G_5G
        read
        read_MESSAGE_5_RX_EN_2P5G_5G = read_MESSAGE_5_RX_EN_2P5G_5G_value
    End Property

    Property Let write_MESSAGE_5_RX_EN_2P5G_5G(aData)
        set_MESSAGE_5_RX_EN_2P5G_5G = aData
        write
    End Property

    Property Get get_MESSAGE_5_TX_EN_2P5G_5G
        get_MESSAGE_5_TX_EN_2P5G_5G = read_MESSAGE_5_TX_EN_2P5G_5G_value
    End Property

    Property Let set_MESSAGE_5_TX_EN_2P5G_5G(aData)
        write_MESSAGE_5_TX_EN_2P5G_5G_value = aData
        flag_MESSAGE_5_TX_EN_2P5G_5G        = &H1
    End Property

    Property Get read_MESSAGE_5_TX_EN_2P5G_5G
        read
        read_MESSAGE_5_TX_EN_2P5G_5G = read_MESSAGE_5_TX_EN_2P5G_5G_value
    End Property

    Property Let write_MESSAGE_5_TX_EN_2P5G_5G(aData)
        set_MESSAGE_5_TX_EN_2P5G_5G = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MSG_6_XNP_RX_EN_value = rightShift(data_low, 15) and &H1
        read_MSG_6_XNP_TX_EN_value = rightShift(data_low, 14) and &H1
        read_MSG_6_RX_EN_value = rightShift(data_low, 13) and &H1
        read_MSG_6_TX_EN_value = rightShift(data_low, 12) and &H1
        read_MSG_5_XNP_RX_EN_value = rightShift(data_low, 11) and &H1
        read_MSG_5_XNP_TX_EN_value = rightShift(data_low, 10) and &H1
        read_MSG_5_RX_EN_value = rightShift(data_low, 9) and &H1
        read_MSG_5_TX_EN_value = rightShift(data_low, 8) and &H1
        read_MESSAGE_5_RX_EN_2P5G_5G_value = rightShift(data_low, 1) and &H1
        MESSAGE_5_TX_EN_2P5G_5G_mask = &H1
        if data_low > LONG_MAX then
            if MESSAGE_5_TX_EN_2P5G_5G_mask = mask then
                read_MESSAGE_5_TX_EN_2P5G_5G_value = data_low
            else
                read_MESSAGE_5_TX_EN_2P5G_5G_value = (data_low - H8000_0000) and MESSAGE_5_TX_EN_2P5G_5G_mask
            end If
        else
            read_MESSAGE_5_TX_EN_2P5G_5G_value = data_low and MESSAGE_5_TX_EN_2P5G_5G_mask
        end If

    End Sub

    Sub write
        If flag_MSG_6_XNP_RX_EN = &H0 or flag_MSG_6_XNP_TX_EN = &H0 or flag_MSG_6_RX_EN = &H0 or flag_MSG_6_TX_EN = &H0 or flag_MSG_5_XNP_RX_EN = &H0 or flag_MSG_5_XNP_TX_EN = &H0 or flag_MSG_5_RX_EN = &H0 or flag_MSG_5_TX_EN = &H0 or flag_MESSAGE_5_RX_EN_2P5G_5G = &H0 or flag_MESSAGE_5_TX_EN_2P5G_5G = &H0 Then read
        If flag_MSG_6_XNP_RX_EN = &H0 Then write_MSG_6_XNP_RX_EN_value = get_MSG_6_XNP_RX_EN
        If flag_MSG_6_XNP_TX_EN = &H0 Then write_MSG_6_XNP_TX_EN_value = get_MSG_6_XNP_TX_EN
        If flag_MSG_6_RX_EN = &H0 Then write_MSG_6_RX_EN_value = get_MSG_6_RX_EN
        If flag_MSG_6_TX_EN = &H0 Then write_MSG_6_TX_EN_value = get_MSG_6_TX_EN
        If flag_MSG_5_XNP_RX_EN = &H0 Then write_MSG_5_XNP_RX_EN_value = get_MSG_5_XNP_RX_EN
        If flag_MSG_5_XNP_TX_EN = &H0 Then write_MSG_5_XNP_TX_EN_value = get_MSG_5_XNP_TX_EN
        If flag_MSG_5_RX_EN = &H0 Then write_MSG_5_RX_EN_value = get_MSG_5_RX_EN
        If flag_MSG_5_TX_EN = &H0 Then write_MSG_5_TX_EN_value = get_MSG_5_TX_EN
        If flag_MESSAGE_5_RX_EN_2P5G_5G = &H0 Then write_MESSAGE_5_RX_EN_2P5G_5G_value = get_MESSAGE_5_RX_EN_2P5G_5G
        If flag_MESSAGE_5_TX_EN_2P5G_5G = &H0 Then write_MESSAGE_5_TX_EN_2P5G_5G_value = get_MESSAGE_5_TX_EN_2P5G_5G

        regValue = leftShift((write_MSG_6_XNP_RX_EN_value and &H1), 15) + leftShift((write_MSG_6_XNP_TX_EN_value and &H1), 14) + leftShift((write_MSG_6_RX_EN_value and &H1), 13) + leftShift((write_MSG_6_TX_EN_value and &H1), 12) + leftShift((write_MSG_5_XNP_RX_EN_value and &H1), 11) + leftShift((write_MSG_5_XNP_TX_EN_value and &H1), 10) + leftShift((write_MSG_5_RX_EN_value and &H1), 9) + leftShift((write_MSG_5_TX_EN_value and &H1), 8) + leftShift((write_MESSAGE_5_RX_EN_2P5G_5G_value and &H1), 1) + leftShift((write_MESSAGE_5_TX_EN_2P5G_5G_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MSG_6_XNP_RX_EN_value = rightShift(data_low, 15) and &H1
        read_MSG_6_XNP_TX_EN_value = rightShift(data_low, 14) and &H1
        read_MSG_6_RX_EN_value = rightShift(data_low, 13) and &H1
        read_MSG_6_TX_EN_value = rightShift(data_low, 12) and &H1
        read_MSG_5_XNP_RX_EN_value = rightShift(data_low, 11) and &H1
        read_MSG_5_XNP_TX_EN_value = rightShift(data_low, 10) and &H1
        read_MSG_5_RX_EN_value = rightShift(data_low, 9) and &H1
        read_MSG_5_TX_EN_value = rightShift(data_low, 8) and &H1
        read_MESSAGE_5_RX_EN_2P5G_5G_value = rightShift(data_low, 1) and &H1
        MESSAGE_5_TX_EN_2P5G_5G_mask = &H1
        if data_low > LONG_MAX then
            if MESSAGE_5_TX_EN_2P5G_5G_mask = mask then
                read_MESSAGE_5_TX_EN_2P5G_5G_value = data_low
            else
                read_MESSAGE_5_TX_EN_2P5G_5G_value = (data_low - H8000_0000) and MESSAGE_5_TX_EN_2P5G_5G_mask
            end If
        else
            read_MESSAGE_5_TX_EN_2P5G_5G_value = data_low and MESSAGE_5_TX_EN_2P5G_5G_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_6_XNP_RX_EN_value = &H0
        flag_MSG_6_XNP_RX_EN        = &H0
        write_MSG_6_XNP_TX_EN_value = &H0
        flag_MSG_6_XNP_TX_EN        = &H0
        write_MSG_6_RX_EN_value = &H0
        flag_MSG_6_RX_EN        = &H0
        write_MSG_6_TX_EN_value = &H0
        flag_MSG_6_TX_EN        = &H0
        write_MSG_5_XNP_RX_EN_value = &H0
        flag_MSG_5_XNP_RX_EN        = &H0
        write_MSG_5_XNP_TX_EN_value = &H0
        flag_MSG_5_XNP_TX_EN        = &H0
        write_MSG_5_RX_EN_value = &H0
        flag_MSG_5_RX_EN        = &H0
        write_MSG_5_TX_EN_value = &H0
        flag_MSG_5_TX_EN        = &H0
        write_MESSAGE_5_RX_EN_2P5G_5G_value = &H0
        flag_MESSAGE_5_RX_EN_2P5G_5G        = &H0
        write_MESSAGE_5_TX_EN_2P5G_5G_value = &H0
        flag_MESSAGE_5_TX_EN_2P5G_5G        = &H0
    End Sub
End Class


'' @REGISTER : CL45VEN_eee_spare_1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SPARE                                      [15:0]           get_SPARE
''                                                             set_SPARE
''                                                             read_SPARE
''                                                             write_SPARE
''---------------------------------------------------------------------------------
Class REGISTER_CL45VEN_eee_spare_1
    Private write_SPARE_value
    Private read_SPARE_value
    Private flag_SPARE

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H76
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

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SPARE_mask = &Hffff
        if data_low > LONG_MAX then
            if SPARE_mask = mask then
                read_SPARE_value = data_low
            else
                read_SPARE_value = (data_low - H8000_0000) and SPARE_mask
            end If
        else
            read_SPARE_value = data_low and SPARE_mask
        end If

    End Sub

    Sub write
        If flag_SPARE = &H0 Then read
        If flag_SPARE = &H0 Then write_SPARE_value = get_SPARE

        regValue = leftShift((write_SPARE_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SPARE_mask = &Hffff
        if data_low > LONG_MAX then
            if SPARE_mask = mask then
                read_SPARE_value = data_low
            else
                read_SPARE_value = (data_low - H8000_0000) and SPARE_mask
            end If
        else
            read_SPARE_value = data_low and SPARE_mask
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
    End Sub
End Class


'' @REGISTER : CL45VEN_eee_spare_2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SPARE                                      [15:0]           get_SPARE
''                                                             set_SPARE
''                                                             read_SPARE
''                                                             write_SPARE
''---------------------------------------------------------------------------------
Class REGISTER_CL45VEN_eee_spare_2
    Private write_SPARE_value
    Private read_SPARE_value
    Private flag_SPARE

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

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SPARE_mask = &Hffff
        if data_low > LONG_MAX then
            if SPARE_mask = mask then
                read_SPARE_value = data_low
            else
                read_SPARE_value = (data_low - H8000_0000) and SPARE_mask
            end If
        else
            read_SPARE_value = data_low and SPARE_mask
        end If

    End Sub

    Sub write
        If flag_SPARE = &H0 Then read
        If flag_SPARE = &H0 Then write_SPARE_value = get_SPARE

        regValue = leftShift((write_SPARE_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SPARE_mask = &Hffff
        if data_low > LONG_MAX then
            if SPARE_mask = mask then
                read_SPARE_value = data_low
            else
                read_SPARE_value = (data_low - H8000_0000) and SPARE_mask
            end If
        else
            read_SPARE_value = data_low and SPARE_mask
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
    End Sub
End Class


'' @REGISTER : CL45VEN_eee_control
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LPI_FEATURE_EN                             [15:15]          get_LPI_FEATURE_EN
''                                                             set_LPI_FEATURE_EN
''                                                             read_LPI_FEATURE_EN
''                                                             write_LPI_FEATURE_EN
''---------------------------------------------------------------------------------
'' LPI_FEATURE_EN_DIG1000X                    [14:14]          get_LPI_FEATURE_EN_DIG1000X
''                                                             set_LPI_FEATURE_EN_DIG1000X
''                                                             read_LPI_FEATURE_EN_DIG1000X
''                                                             write_LPI_FEATURE_EN_DIG1000X
''---------------------------------------------------------------------------------
'' LPI_RES_IN_FORCE_MODE_EN                   [13:13]          get_LPI_RES_IN_FORCE_MODE_EN
''                                                             set_LPI_RES_IN_FORCE_MODE_EN
''                                                             read_LPI_RES_IN_FORCE_MODE_EN
''                                                             write_LPI_RES_IN_FORCE_MODE_EN
''---------------------------------------------------------------------------------
'' SPARE                                      [12:3]           get_SPARE
''                                                             set_SPARE
''                                                             read_SPARE
''                                                             write_SPARE
''---------------------------------------------------------------------------------
'' LPI_LINKUP_DISABLE                         [2:2]            get_LPI_LINKUP_DISABLE
''                                                             set_LPI_LINKUP_DISABLE
''                                                             read_LPI_LINKUP_DISABLE
''                                                             write_LPI_LINKUP_DISABLE
''---------------------------------------------------------------------------------
'' EEE_DOWNGRADE_ENABLE                       [1:1]            get_EEE_DOWNGRADE_ENABLE
''                                                             set_EEE_DOWNGRADE_ENABLE
''                                                             read_EEE_DOWNGRADE_ENABLE
''                                                             write_EEE_DOWNGRADE_ENABLE
''---------------------------------------------------------------------------------
'' LPI_100TX_BRCM_LINK                        [0:0]            get_LPI_100TX_BRCM_LINK
''                                                             set_LPI_100TX_BRCM_LINK
''                                                             read_LPI_100TX_BRCM_LINK
''                                                             write_LPI_100TX_BRCM_LINK
''---------------------------------------------------------------------------------
Class REGISTER_CL45VEN_eee_control
    Private write_LPI_FEATURE_EN_value
    Private read_LPI_FEATURE_EN_value
    Private flag_LPI_FEATURE_EN
    Private write_LPI_FEATURE_EN_DIG1000X_value
    Private read_LPI_FEATURE_EN_DIG1000X_value
    Private flag_LPI_FEATURE_EN_DIG1000X
    Private write_LPI_RES_IN_FORCE_MODE_EN_value
    Private read_LPI_RES_IN_FORCE_MODE_EN_value
    Private flag_LPI_RES_IN_FORCE_MODE_EN
    Private write_SPARE_value
    Private read_SPARE_value
    Private flag_SPARE
    Private write_LPI_LINKUP_DISABLE_value
    Private read_LPI_LINKUP_DISABLE_value
    Private flag_LPI_LINKUP_DISABLE
    Private write_EEE_DOWNGRADE_ENABLE_value
    Private read_EEE_DOWNGRADE_ENABLE_value
    Private flag_EEE_DOWNGRADE_ENABLE
    Private write_LPI_100TX_BRCM_LINK_value
    Private read_LPI_100TX_BRCM_LINK_value
    Private flag_LPI_100TX_BRCM_LINK

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_LPI_FEATURE_EN
        get_LPI_FEATURE_EN = read_LPI_FEATURE_EN_value
    End Property

    Property Let set_LPI_FEATURE_EN(aData)
        write_LPI_FEATURE_EN_value = aData
        flag_LPI_FEATURE_EN        = &H1
    End Property

    Property Get read_LPI_FEATURE_EN
        read
        read_LPI_FEATURE_EN = read_LPI_FEATURE_EN_value
    End Property

    Property Let write_LPI_FEATURE_EN(aData)
        set_LPI_FEATURE_EN = aData
        write
    End Property

    Property Get get_LPI_FEATURE_EN_DIG1000X
        get_LPI_FEATURE_EN_DIG1000X = read_LPI_FEATURE_EN_DIG1000X_value
    End Property

    Property Let set_LPI_FEATURE_EN_DIG1000X(aData)
        write_LPI_FEATURE_EN_DIG1000X_value = aData
        flag_LPI_FEATURE_EN_DIG1000X        = &H1
    End Property

    Property Get read_LPI_FEATURE_EN_DIG1000X
        read
        read_LPI_FEATURE_EN_DIG1000X = read_LPI_FEATURE_EN_DIG1000X_value
    End Property

    Property Let write_LPI_FEATURE_EN_DIG1000X(aData)
        set_LPI_FEATURE_EN_DIG1000X = aData
        write
    End Property

    Property Get get_LPI_RES_IN_FORCE_MODE_EN
        get_LPI_RES_IN_FORCE_MODE_EN = read_LPI_RES_IN_FORCE_MODE_EN_value
    End Property

    Property Let set_LPI_RES_IN_FORCE_MODE_EN(aData)
        write_LPI_RES_IN_FORCE_MODE_EN_value = aData
        flag_LPI_RES_IN_FORCE_MODE_EN        = &H1
    End Property

    Property Get read_LPI_RES_IN_FORCE_MODE_EN
        read
        read_LPI_RES_IN_FORCE_MODE_EN = read_LPI_RES_IN_FORCE_MODE_EN_value
    End Property

    Property Let write_LPI_RES_IN_FORCE_MODE_EN(aData)
        set_LPI_RES_IN_FORCE_MODE_EN = aData
        write
    End Property

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

    Property Get get_LPI_LINKUP_DISABLE
        get_LPI_LINKUP_DISABLE = read_LPI_LINKUP_DISABLE_value
    End Property

    Property Let set_LPI_LINKUP_DISABLE(aData)
        write_LPI_LINKUP_DISABLE_value = aData
        flag_LPI_LINKUP_DISABLE        = &H1
    End Property

    Property Get read_LPI_LINKUP_DISABLE
        read
        read_LPI_LINKUP_DISABLE = read_LPI_LINKUP_DISABLE_value
    End Property

    Property Let write_LPI_LINKUP_DISABLE(aData)
        set_LPI_LINKUP_DISABLE = aData
        write
    End Property

    Property Get get_EEE_DOWNGRADE_ENABLE
        get_EEE_DOWNGRADE_ENABLE = read_EEE_DOWNGRADE_ENABLE_value
    End Property

    Property Let set_EEE_DOWNGRADE_ENABLE(aData)
        write_EEE_DOWNGRADE_ENABLE_value = aData
        flag_EEE_DOWNGRADE_ENABLE        = &H1
    End Property

    Property Get read_EEE_DOWNGRADE_ENABLE
        read
        read_EEE_DOWNGRADE_ENABLE = read_EEE_DOWNGRADE_ENABLE_value
    End Property

    Property Let write_EEE_DOWNGRADE_ENABLE(aData)
        set_EEE_DOWNGRADE_ENABLE = aData
        write
    End Property

    Property Get get_LPI_100TX_BRCM_LINK
        get_LPI_100TX_BRCM_LINK = read_LPI_100TX_BRCM_LINK_value
    End Property

    Property Let set_LPI_100TX_BRCM_LINK(aData)
        write_LPI_100TX_BRCM_LINK_value = aData
        flag_LPI_100TX_BRCM_LINK        = &H1
    End Property

    Property Get read_LPI_100TX_BRCM_LINK
        read
        read_LPI_100TX_BRCM_LINK = read_LPI_100TX_BRCM_LINK_value
    End Property

    Property Let write_LPI_100TX_BRCM_LINK(aData)
        set_LPI_100TX_BRCM_LINK = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LPI_FEATURE_EN_value = rightShift(data_low, 15) and &H1
        read_LPI_FEATURE_EN_DIG1000X_value = rightShift(data_low, 14) and &H1
        read_LPI_RES_IN_FORCE_MODE_EN_value = rightShift(data_low, 13) and &H1
        read_SPARE_value = rightShift(data_low, 3) and &H3ff
        read_LPI_LINKUP_DISABLE_value = rightShift(data_low, 2) and &H1
        read_EEE_DOWNGRADE_ENABLE_value = rightShift(data_low, 1) and &H1
        LPI_100TX_BRCM_LINK_mask = &H1
        if data_low > LONG_MAX then
            if LPI_100TX_BRCM_LINK_mask = mask then
                read_LPI_100TX_BRCM_LINK_value = data_low
            else
                read_LPI_100TX_BRCM_LINK_value = (data_low - H8000_0000) and LPI_100TX_BRCM_LINK_mask
            end If
        else
            read_LPI_100TX_BRCM_LINK_value = data_low and LPI_100TX_BRCM_LINK_mask
        end If

    End Sub

    Sub write
        If flag_LPI_FEATURE_EN = &H0 or flag_LPI_FEATURE_EN_DIG1000X = &H0 or flag_LPI_RES_IN_FORCE_MODE_EN = &H0 or flag_SPARE = &H0 or flag_LPI_LINKUP_DISABLE = &H0 or flag_EEE_DOWNGRADE_ENABLE = &H0 or flag_LPI_100TX_BRCM_LINK = &H0 Then read
        If flag_LPI_FEATURE_EN = &H0 Then write_LPI_FEATURE_EN_value = get_LPI_FEATURE_EN
        If flag_LPI_FEATURE_EN_DIG1000X = &H0 Then write_LPI_FEATURE_EN_DIG1000X_value = get_LPI_FEATURE_EN_DIG1000X
        If flag_LPI_RES_IN_FORCE_MODE_EN = &H0 Then write_LPI_RES_IN_FORCE_MODE_EN_value = get_LPI_RES_IN_FORCE_MODE_EN
        If flag_SPARE = &H0 Then write_SPARE_value = get_SPARE
        If flag_LPI_LINKUP_DISABLE = &H0 Then write_LPI_LINKUP_DISABLE_value = get_LPI_LINKUP_DISABLE
        If flag_EEE_DOWNGRADE_ENABLE = &H0 Then write_EEE_DOWNGRADE_ENABLE_value = get_EEE_DOWNGRADE_ENABLE
        If flag_LPI_100TX_BRCM_LINK = &H0 Then write_LPI_100TX_BRCM_LINK_value = get_LPI_100TX_BRCM_LINK

        regValue = leftShift((write_LPI_FEATURE_EN_value and &H1), 15) + leftShift((write_LPI_FEATURE_EN_DIG1000X_value and &H1), 14) + leftShift((write_LPI_RES_IN_FORCE_MODE_EN_value and &H1), 13) + leftShift((write_SPARE_value and &H3ff), 3) + leftShift((write_LPI_LINKUP_DISABLE_value and &H1), 2) + leftShift((write_EEE_DOWNGRADE_ENABLE_value and &H1), 1) + leftShift((write_LPI_100TX_BRCM_LINK_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LPI_FEATURE_EN_value = rightShift(data_low, 15) and &H1
        read_LPI_FEATURE_EN_DIG1000X_value = rightShift(data_low, 14) and &H1
        read_LPI_RES_IN_FORCE_MODE_EN_value = rightShift(data_low, 13) and &H1
        read_SPARE_value = rightShift(data_low, 3) and &H3ff
        read_LPI_LINKUP_DISABLE_value = rightShift(data_low, 2) and &H1
        read_EEE_DOWNGRADE_ENABLE_value = rightShift(data_low, 1) and &H1
        LPI_100TX_BRCM_LINK_mask = &H1
        if data_low > LONG_MAX then
            if LPI_100TX_BRCM_LINK_mask = mask then
                read_LPI_100TX_BRCM_LINK_value = data_low
            else
                read_LPI_100TX_BRCM_LINK_value = (data_low - H8000_0000) and LPI_100TX_BRCM_LINK_mask
            end If
        else
            read_LPI_100TX_BRCM_LINK_value = data_low and LPI_100TX_BRCM_LINK_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LPI_FEATURE_EN_value = &H0
        flag_LPI_FEATURE_EN        = &H0
        write_LPI_FEATURE_EN_DIG1000X_value = &H0
        flag_LPI_FEATURE_EN_DIG1000X        = &H0
        write_LPI_RES_IN_FORCE_MODE_EN_value = &H0
        flag_LPI_RES_IN_FORCE_MODE_EN        = &H0
        write_SPARE_value = &H0
        flag_SPARE        = &H0
        write_LPI_LINKUP_DISABLE_value = &H0
        flag_LPI_LINKUP_DISABLE        = &H0
        write_EEE_DOWNGRADE_ENABLE_value = &H0
        flag_EEE_DOWNGRADE_ENABLE        = &H0
        write_LPI_100TX_BRCM_LINK_value = &H0
        flag_LPI_100TX_BRCM_LINK        = &H0
    End Sub
End Class


'' @REGISTER : CL45VEN_eee_res_stat
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MASK_10G_EEE                               [11:11]          get_MASK_10G_EEE
''                                                             set_MASK_10G_EEE
''                                                             read_MASK_10G_EEE
''                                                             write_MASK_10G_EEE
''---------------------------------------------------------------------------------
'' MASK_5G_EEE                                [10:10]          get_MASK_5G_EEE
''                                                             set_MASK_5G_EEE
''                                                             read_MASK_5G_EEE
''                                                             write_MASK_5G_EEE
''---------------------------------------------------------------------------------
'' MASK_2P5G_EEE                              [9:9]            get_MASK_2P5G_EEE
''                                                             set_MASK_2P5G_EEE
''                                                             read_MASK_2P5G_EEE
''                                                             write_MASK_2P5G_EEE
''---------------------------------------------------------------------------------
'' MASK_1000T_EEE                             [8:8]            get_MASK_1000T_EEE
''                                                             set_MASK_1000T_EEE
''                                                             read_MASK_1000T_EEE
''                                                             write_MASK_1000T_EEE
''---------------------------------------------------------------------------------
'' MASK_100TX_EEE                             [7:7]            get_MASK_100TX_EEE
''                                                             set_MASK_100TX_EEE
''                                                             read_MASK_100TX_EEE
''                                                             write_MASK_100TX_EEE
''---------------------------------------------------------------------------------
'' MASK_10T_EEE                               [6:6]            get_MASK_10T_EEE
''                                                             set_MASK_10T_EEE
''                                                             read_MASK_10T_EEE
''                                                             write_MASK_10T_EEE
''---------------------------------------------------------------------------------
'' EEE_10G_RES                                [5:5]            get_EEE_10G_RES
''                                                             set_EEE_10G_RES
''                                                             read_EEE_10G_RES
''                                                             write_EEE_10G_RES
''---------------------------------------------------------------------------------
'' EEE_5G_RES                                 [4:4]            get_EEE_5G_RES
''                                                             set_EEE_5G_RES
''                                                             read_EEE_5G_RES
''                                                             write_EEE_5G_RES
''---------------------------------------------------------------------------------
'' EEE_2p5G_RES                               [3:3]            get_EEE_2p5G_RES
''                                                             set_EEE_2p5G_RES
''                                                             read_EEE_2p5G_RES
''                                                             write_EEE_2p5G_RES
''---------------------------------------------------------------------------------
'' EEE_1000T_RES                              [2:2]            get_EEE_1000T_RES
''                                                             set_EEE_1000T_RES
''                                                             read_EEE_1000T_RES
''                                                             write_EEE_1000T_RES
''---------------------------------------------------------------------------------
'' EEE_100TX_RES                              [1:1]            get_EEE_100TX_RES
''                                                             set_EEE_100TX_RES
''                                                             read_EEE_100TX_RES
''                                                             write_EEE_100TX_RES
''---------------------------------------------------------------------------------
'' EEE_10BASE_TE_RES                          [0:0]            get_EEE_10BASE_TE_RES
''                                                             set_EEE_10BASE_TE_RES
''                                                             read_EEE_10BASE_TE_RES
''                                                             write_EEE_10BASE_TE_RES
''---------------------------------------------------------------------------------
Class REGISTER_CL45VEN_eee_res_stat
    Private write_MASK_10G_EEE_value
    Private read_MASK_10G_EEE_value
    Private flag_MASK_10G_EEE
    Private write_MASK_5G_EEE_value
    Private read_MASK_5G_EEE_value
    Private flag_MASK_5G_EEE
    Private write_MASK_2P5G_EEE_value
    Private read_MASK_2P5G_EEE_value
    Private flag_MASK_2P5G_EEE
    Private write_MASK_1000T_EEE_value
    Private read_MASK_1000T_EEE_value
    Private flag_MASK_1000T_EEE
    Private write_MASK_100TX_EEE_value
    Private read_MASK_100TX_EEE_value
    Private flag_MASK_100TX_EEE
    Private write_MASK_10T_EEE_value
    Private read_MASK_10T_EEE_value
    Private flag_MASK_10T_EEE
    Private write_EEE_10G_RES_value
    Private read_EEE_10G_RES_value
    Private flag_EEE_10G_RES
    Private write_EEE_5G_RES_value
    Private read_EEE_5G_RES_value
    Private flag_EEE_5G_RES
    Private write_EEE_2p5G_RES_value
    Private read_EEE_2p5G_RES_value
    Private flag_EEE_2p5G_RES
    Private write_EEE_1000T_RES_value
    Private read_EEE_1000T_RES_value
    Private flag_EEE_1000T_RES
    Private write_EEE_100TX_RES_value
    Private read_EEE_100TX_RES_value
    Private flag_EEE_100TX_RES
    Private write_EEE_10BASE_TE_RES_value
    Private read_EEE_10BASE_TE_RES_value
    Private flag_EEE_10BASE_TE_RES

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

    Property Get get_MASK_10G_EEE
        get_MASK_10G_EEE = read_MASK_10G_EEE_value
    End Property

    Property Let set_MASK_10G_EEE(aData)
        write_MASK_10G_EEE_value = aData
        flag_MASK_10G_EEE        = &H1
    End Property

    Property Get read_MASK_10G_EEE
        read
        read_MASK_10G_EEE = read_MASK_10G_EEE_value
    End Property

    Property Let write_MASK_10G_EEE(aData)
        set_MASK_10G_EEE = aData
        write
    End Property

    Property Get get_MASK_5G_EEE
        get_MASK_5G_EEE = read_MASK_5G_EEE_value
    End Property

    Property Let set_MASK_5G_EEE(aData)
        write_MASK_5G_EEE_value = aData
        flag_MASK_5G_EEE        = &H1
    End Property

    Property Get read_MASK_5G_EEE
        read
        read_MASK_5G_EEE = read_MASK_5G_EEE_value
    End Property

    Property Let write_MASK_5G_EEE(aData)
        set_MASK_5G_EEE = aData
        write
    End Property

    Property Get get_MASK_2P5G_EEE
        get_MASK_2P5G_EEE = read_MASK_2P5G_EEE_value
    End Property

    Property Let set_MASK_2P5G_EEE(aData)
        write_MASK_2P5G_EEE_value = aData
        flag_MASK_2P5G_EEE        = &H1
    End Property

    Property Get read_MASK_2P5G_EEE
        read
        read_MASK_2P5G_EEE = read_MASK_2P5G_EEE_value
    End Property

    Property Let write_MASK_2P5G_EEE(aData)
        set_MASK_2P5G_EEE = aData
        write
    End Property

    Property Get get_MASK_1000T_EEE
        get_MASK_1000T_EEE = read_MASK_1000T_EEE_value
    End Property

    Property Let set_MASK_1000T_EEE(aData)
        write_MASK_1000T_EEE_value = aData
        flag_MASK_1000T_EEE        = &H1
    End Property

    Property Get read_MASK_1000T_EEE
        read
        read_MASK_1000T_EEE = read_MASK_1000T_EEE_value
    End Property

    Property Let write_MASK_1000T_EEE(aData)
        set_MASK_1000T_EEE = aData
        write
    End Property

    Property Get get_MASK_100TX_EEE
        get_MASK_100TX_EEE = read_MASK_100TX_EEE_value
    End Property

    Property Let set_MASK_100TX_EEE(aData)
        write_MASK_100TX_EEE_value = aData
        flag_MASK_100TX_EEE        = &H1
    End Property

    Property Get read_MASK_100TX_EEE
        read
        read_MASK_100TX_EEE = read_MASK_100TX_EEE_value
    End Property

    Property Let write_MASK_100TX_EEE(aData)
        set_MASK_100TX_EEE = aData
        write
    End Property

    Property Get get_MASK_10T_EEE
        get_MASK_10T_EEE = read_MASK_10T_EEE_value
    End Property

    Property Let set_MASK_10T_EEE(aData)
        write_MASK_10T_EEE_value = aData
        flag_MASK_10T_EEE        = &H1
    End Property

    Property Get read_MASK_10T_EEE
        read
        read_MASK_10T_EEE = read_MASK_10T_EEE_value
    End Property

    Property Let write_MASK_10T_EEE(aData)
        set_MASK_10T_EEE = aData
        write
    End Property

    Property Get get_EEE_10G_RES
        get_EEE_10G_RES = read_EEE_10G_RES_value
    End Property

    Property Let set_EEE_10G_RES(aData)
        write_EEE_10G_RES_value = aData
        flag_EEE_10G_RES        = &H1
    End Property

    Property Get read_EEE_10G_RES
        read
        read_EEE_10G_RES = read_EEE_10G_RES_value
    End Property

    Property Let write_EEE_10G_RES(aData)
        set_EEE_10G_RES = aData
        write
    End Property

    Property Get get_EEE_5G_RES
        get_EEE_5G_RES = read_EEE_5G_RES_value
    End Property

    Property Let set_EEE_5G_RES(aData)
        write_EEE_5G_RES_value = aData
        flag_EEE_5G_RES        = &H1
    End Property

    Property Get read_EEE_5G_RES
        read
        read_EEE_5G_RES = read_EEE_5G_RES_value
    End Property

    Property Let write_EEE_5G_RES(aData)
        set_EEE_5G_RES = aData
        write
    End Property

    Property Get get_EEE_2p5G_RES
        get_EEE_2p5G_RES = read_EEE_2p5G_RES_value
    End Property

    Property Let set_EEE_2p5G_RES(aData)
        write_EEE_2p5G_RES_value = aData
        flag_EEE_2p5G_RES        = &H1
    End Property

    Property Get read_EEE_2p5G_RES
        read
        read_EEE_2p5G_RES = read_EEE_2p5G_RES_value
    End Property

    Property Let write_EEE_2p5G_RES(aData)
        set_EEE_2p5G_RES = aData
        write
    End Property

    Property Get get_EEE_1000T_RES
        get_EEE_1000T_RES = read_EEE_1000T_RES_value
    End Property

    Property Let set_EEE_1000T_RES(aData)
        write_EEE_1000T_RES_value = aData
        flag_EEE_1000T_RES        = &H1
    End Property

    Property Get read_EEE_1000T_RES
        read
        read_EEE_1000T_RES = read_EEE_1000T_RES_value
    End Property

    Property Let write_EEE_1000T_RES(aData)
        set_EEE_1000T_RES = aData
        write
    End Property

    Property Get get_EEE_100TX_RES
        get_EEE_100TX_RES = read_EEE_100TX_RES_value
    End Property

    Property Let set_EEE_100TX_RES(aData)
        write_EEE_100TX_RES_value = aData
        flag_EEE_100TX_RES        = &H1
    End Property

    Property Get read_EEE_100TX_RES
        read
        read_EEE_100TX_RES = read_EEE_100TX_RES_value
    End Property

    Property Let write_EEE_100TX_RES(aData)
        set_EEE_100TX_RES = aData
        write
    End Property

    Property Get get_EEE_10BASE_TE_RES
        get_EEE_10BASE_TE_RES = read_EEE_10BASE_TE_RES_value
    End Property

    Property Let set_EEE_10BASE_TE_RES(aData)
        write_EEE_10BASE_TE_RES_value = aData
        flag_EEE_10BASE_TE_RES        = &H1
    End Property

    Property Get read_EEE_10BASE_TE_RES
        read
        read_EEE_10BASE_TE_RES = read_EEE_10BASE_TE_RES_value
    End Property

    Property Let write_EEE_10BASE_TE_RES(aData)
        set_EEE_10BASE_TE_RES = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MASK_10G_EEE_value = rightShift(data_low, 11) and &H1
        read_MASK_5G_EEE_value = rightShift(data_low, 10) and &H1
        read_MASK_2P5G_EEE_value = rightShift(data_low, 9) and &H1
        read_MASK_1000T_EEE_value = rightShift(data_low, 8) and &H1
        read_MASK_100TX_EEE_value = rightShift(data_low, 7) and &H1
        read_MASK_10T_EEE_value = rightShift(data_low, 6) and &H1
        read_EEE_10G_RES_value = rightShift(data_low, 5) and &H1
        read_EEE_5G_RES_value = rightShift(data_low, 4) and &H1
        read_EEE_2p5G_RES_value = rightShift(data_low, 3) and &H1
        read_EEE_1000T_RES_value = rightShift(data_low, 2) and &H1
        read_EEE_100TX_RES_value = rightShift(data_low, 1) and &H1
        EEE_10BASE_TE_RES_mask = &H1
        if data_low > LONG_MAX then
            if EEE_10BASE_TE_RES_mask = mask then
                read_EEE_10BASE_TE_RES_value = data_low
            else
                read_EEE_10BASE_TE_RES_value = (data_low - H8000_0000) and EEE_10BASE_TE_RES_mask
            end If
        else
            read_EEE_10BASE_TE_RES_value = data_low and EEE_10BASE_TE_RES_mask
        end If

    End Sub

    Sub write
        If flag_MASK_10G_EEE = &H0 or flag_MASK_5G_EEE = &H0 or flag_MASK_2P5G_EEE = &H0 or flag_MASK_1000T_EEE = &H0 or flag_MASK_100TX_EEE = &H0 or flag_MASK_10T_EEE = &H0 or flag_EEE_10G_RES = &H0 or flag_EEE_5G_RES = &H0 or flag_EEE_2p5G_RES = &H0 or flag_EEE_1000T_RES = &H0 or flag_EEE_100TX_RES = &H0 or flag_EEE_10BASE_TE_RES = &H0 Then read
        If flag_MASK_10G_EEE = &H0 Then write_MASK_10G_EEE_value = get_MASK_10G_EEE
        If flag_MASK_5G_EEE = &H0 Then write_MASK_5G_EEE_value = get_MASK_5G_EEE
        If flag_MASK_2P5G_EEE = &H0 Then write_MASK_2P5G_EEE_value = get_MASK_2P5G_EEE
        If flag_MASK_1000T_EEE = &H0 Then write_MASK_1000T_EEE_value = get_MASK_1000T_EEE
        If flag_MASK_100TX_EEE = &H0 Then write_MASK_100TX_EEE_value = get_MASK_100TX_EEE
        If flag_MASK_10T_EEE = &H0 Then write_MASK_10T_EEE_value = get_MASK_10T_EEE
        If flag_EEE_10G_RES = &H0 Then write_EEE_10G_RES_value = get_EEE_10G_RES
        If flag_EEE_5G_RES = &H0 Then write_EEE_5G_RES_value = get_EEE_5G_RES
        If flag_EEE_2p5G_RES = &H0 Then write_EEE_2p5G_RES_value = get_EEE_2p5G_RES
        If flag_EEE_1000T_RES = &H0 Then write_EEE_1000T_RES_value = get_EEE_1000T_RES
        If flag_EEE_100TX_RES = &H0 Then write_EEE_100TX_RES_value = get_EEE_100TX_RES
        If flag_EEE_10BASE_TE_RES = &H0 Then write_EEE_10BASE_TE_RES_value = get_EEE_10BASE_TE_RES

        regValue = leftShift((write_MASK_10G_EEE_value and &H1), 11) + leftShift((write_MASK_5G_EEE_value and &H1), 10) + leftShift((write_MASK_2P5G_EEE_value and &H1), 9) + leftShift((write_MASK_1000T_EEE_value and &H1), 8) + leftShift((write_MASK_100TX_EEE_value and &H1), 7) + leftShift((write_MASK_10T_EEE_value and &H1), 6) + leftShift((write_EEE_10G_RES_value and &H1), 5) + leftShift((write_EEE_5G_RES_value and &H1), 4) + leftShift((write_EEE_2p5G_RES_value and &H1), 3) + leftShift((write_EEE_1000T_RES_value and &H1), 2) + leftShift((write_EEE_100TX_RES_value and &H1), 1) + leftShift((write_EEE_10BASE_TE_RES_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MASK_10G_EEE_value = rightShift(data_low, 11) and &H1
        read_MASK_5G_EEE_value = rightShift(data_low, 10) and &H1
        read_MASK_2P5G_EEE_value = rightShift(data_low, 9) and &H1
        read_MASK_1000T_EEE_value = rightShift(data_low, 8) and &H1
        read_MASK_100TX_EEE_value = rightShift(data_low, 7) and &H1
        read_MASK_10T_EEE_value = rightShift(data_low, 6) and &H1
        read_EEE_10G_RES_value = rightShift(data_low, 5) and &H1
        read_EEE_5G_RES_value = rightShift(data_low, 4) and &H1
        read_EEE_2p5G_RES_value = rightShift(data_low, 3) and &H1
        read_EEE_1000T_RES_value = rightShift(data_low, 2) and &H1
        read_EEE_100TX_RES_value = rightShift(data_low, 1) and &H1
        EEE_10BASE_TE_RES_mask = &H1
        if data_low > LONG_MAX then
            if EEE_10BASE_TE_RES_mask = mask then
                read_EEE_10BASE_TE_RES_value = data_low
            else
                read_EEE_10BASE_TE_RES_value = (data_low - H8000_0000) and EEE_10BASE_TE_RES_mask
            end If
        else
            read_EEE_10BASE_TE_RES_value = data_low and EEE_10BASE_TE_RES_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MASK_10G_EEE_value = &H0
        flag_MASK_10G_EEE        = &H0
        write_MASK_5G_EEE_value = &H0
        flag_MASK_5G_EEE        = &H0
        write_MASK_2P5G_EEE_value = &H0
        flag_MASK_2P5G_EEE        = &H0
        write_MASK_1000T_EEE_value = &H0
        flag_MASK_1000T_EEE        = &H0
        write_MASK_100TX_EEE_value = &H0
        flag_MASK_100TX_EEE        = &H0
        write_MASK_10T_EEE_value = &H0
        flag_MASK_10T_EEE        = &H0
        write_EEE_10G_RES_value = &H0
        flag_EEE_10G_RES        = &H0
        write_EEE_5G_RES_value = &H0
        flag_EEE_5G_RES        = &H0
        write_EEE_2p5G_RES_value = &H0
        flag_EEE_2p5G_RES        = &H0
        write_EEE_1000T_RES_value = &H0
        flag_EEE_1000T_RES        = &H0
        write_EEE_100TX_RES_value = &H0
        flag_EEE_100TX_RES        = &H0
        write_EEE_10BASE_TE_RES_value = &H0
        flag_EEE_10BASE_TE_RES        = &H0
    End Sub
End Class


'' @REGISTER : CL45VEN_lpi_mode_cntr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LPI_MODE_COUNTER                           [15:0]           get_LPI_MODE_COUNTER
''                                                             set_LPI_MODE_COUNTER
''                                                             read_LPI_MODE_COUNTER
''                                                             write_LPI_MODE_COUNTER
''---------------------------------------------------------------------------------
Class REGISTER_CL45VEN_lpi_mode_cntr
    Private write_LPI_MODE_COUNTER_value
    Private read_LPI_MODE_COUNTER_value
    Private flag_LPI_MODE_COUNTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H7e
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_LPI_MODE_COUNTER
        get_LPI_MODE_COUNTER = read_LPI_MODE_COUNTER_value
    End Property

    Property Let set_LPI_MODE_COUNTER(aData)
        write_LPI_MODE_COUNTER_value = aData
        flag_LPI_MODE_COUNTER        = &H1
    End Property

    Property Get read_LPI_MODE_COUNTER
        read
        read_LPI_MODE_COUNTER = read_LPI_MODE_COUNTER_value
    End Property

    Property Let write_LPI_MODE_COUNTER(aData)
        set_LPI_MODE_COUNTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LPI_MODE_COUNTER_mask = &Hffff
        if data_low > LONG_MAX then
            if LPI_MODE_COUNTER_mask = mask then
                read_LPI_MODE_COUNTER_value = data_low
            else
                read_LPI_MODE_COUNTER_value = (data_low - H8000_0000) and LPI_MODE_COUNTER_mask
            end If
        else
            read_LPI_MODE_COUNTER_value = data_low and LPI_MODE_COUNTER_mask
        end If

    End Sub

    Sub write
        If flag_LPI_MODE_COUNTER = &H0 Then read
        If flag_LPI_MODE_COUNTER = &H0 Then write_LPI_MODE_COUNTER_value = get_LPI_MODE_COUNTER

        regValue = leftShift((write_LPI_MODE_COUNTER_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        LPI_MODE_COUNTER_mask = &Hffff
        if data_low > LONG_MAX then
            if LPI_MODE_COUNTER_mask = mask then
                read_LPI_MODE_COUNTER_value = data_low
            else
                read_LPI_MODE_COUNTER_value = (data_low - H8000_0000) and LPI_MODE_COUNTER_mask
            end If
        else
            read_LPI_MODE_COUNTER_value = data_low and LPI_MODE_COUNTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LPI_MODE_COUNTER_value = &H0
        flag_LPI_MODE_COUNTER        = &H0
    End Sub
End Class


'' @REGISTER : CL45VEN_loc_dev_msg_5_a
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' BITS_10_0_OF_LOC_DEV_MSG_5                 [10:0]           get_BITS_10_0_OF_LOC_DEV_MSG_5
''                                                             set_BITS_10_0_OF_LOC_DEV_MSG_5
''                                                             read_BITS_10_0_OF_LOC_DEV_MSG_5
''                                                             write_BITS_10_0_OF_LOC_DEV_MSG_5
''---------------------------------------------------------------------------------
Class REGISTER_CL45VEN_loc_dev_msg_5_a
    Private write_BITS_10_0_OF_LOC_DEV_MSG_5_value
    Private read_BITS_10_0_OF_LOC_DEV_MSG_5_value
    Private flag_BITS_10_0_OF_LOC_DEV_MSG_5

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

    Property Get get_BITS_10_0_OF_LOC_DEV_MSG_5
        get_BITS_10_0_OF_LOC_DEV_MSG_5 = read_BITS_10_0_OF_LOC_DEV_MSG_5_value
    End Property

    Property Let set_BITS_10_0_OF_LOC_DEV_MSG_5(aData)
        write_BITS_10_0_OF_LOC_DEV_MSG_5_value = aData
        flag_BITS_10_0_OF_LOC_DEV_MSG_5        = &H1
    End Property

    Property Get read_BITS_10_0_OF_LOC_DEV_MSG_5
        read
        read_BITS_10_0_OF_LOC_DEV_MSG_5 = read_BITS_10_0_OF_LOC_DEV_MSG_5_value
    End Property

    Property Let write_BITS_10_0_OF_LOC_DEV_MSG_5(aData)
        set_BITS_10_0_OF_LOC_DEV_MSG_5 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        BITS_10_0_OF_LOC_DEV_MSG_5_mask = &H7ff
        if data_low > LONG_MAX then
            if BITS_10_0_OF_LOC_DEV_MSG_5_mask = mask then
                read_BITS_10_0_OF_LOC_DEV_MSG_5_value = data_low
            else
                read_BITS_10_0_OF_LOC_DEV_MSG_5_value = (data_low - H8000_0000) and BITS_10_0_OF_LOC_DEV_MSG_5_mask
            end If
        else
            read_BITS_10_0_OF_LOC_DEV_MSG_5_value = data_low and BITS_10_0_OF_LOC_DEV_MSG_5_mask
        end If

    End Sub

    Sub write
        If flag_BITS_10_0_OF_LOC_DEV_MSG_5 = &H0 Then read
        If flag_BITS_10_0_OF_LOC_DEV_MSG_5 = &H0 Then write_BITS_10_0_OF_LOC_DEV_MSG_5_value = get_BITS_10_0_OF_LOC_DEV_MSG_5

        regValue = leftShift((write_BITS_10_0_OF_LOC_DEV_MSG_5_value and &H7ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        BITS_10_0_OF_LOC_DEV_MSG_5_mask = &H7ff
        if data_low > LONG_MAX then
            if BITS_10_0_OF_LOC_DEV_MSG_5_mask = mask then
                read_BITS_10_0_OF_LOC_DEV_MSG_5_value = data_low
            else
                read_BITS_10_0_OF_LOC_DEV_MSG_5_value = (data_low - H8000_0000) and BITS_10_0_OF_LOC_DEV_MSG_5_mask
            end If
        else
            read_BITS_10_0_OF_LOC_DEV_MSG_5_value = data_low and BITS_10_0_OF_LOC_DEV_MSG_5_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_BITS_10_0_OF_LOC_DEV_MSG_5_value = &H0
        flag_BITS_10_0_OF_LOC_DEV_MSG_5        = &H0
    End Sub
End Class


'' @REGISTER : CL45VEN_loc_dev_msg_5_b
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' BITS_21_11_OF_LOC_DEV_MSG_5                [10:0]           get_BITS_21_11_OF_LOC_DEV_MSG_5
''                                                             set_BITS_21_11_OF_LOC_DEV_MSG_5
''                                                             read_BITS_21_11_OF_LOC_DEV_MSG_5
''                                                             write_BITS_21_11_OF_LOC_DEV_MSG_5
''---------------------------------------------------------------------------------
Class REGISTER_CL45VEN_loc_dev_msg_5_b
    Private write_BITS_21_11_OF_LOC_DEV_MSG_5_value
    Private read_BITS_21_11_OF_LOC_DEV_MSG_5_value
    Private flag_BITS_21_11_OF_LOC_DEV_MSG_5

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H82
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_BITS_21_11_OF_LOC_DEV_MSG_5
        get_BITS_21_11_OF_LOC_DEV_MSG_5 = read_BITS_21_11_OF_LOC_DEV_MSG_5_value
    End Property

    Property Let set_BITS_21_11_OF_LOC_DEV_MSG_5(aData)
        write_BITS_21_11_OF_LOC_DEV_MSG_5_value = aData
        flag_BITS_21_11_OF_LOC_DEV_MSG_5        = &H1
    End Property

    Property Get read_BITS_21_11_OF_LOC_DEV_MSG_5
        read
        read_BITS_21_11_OF_LOC_DEV_MSG_5 = read_BITS_21_11_OF_LOC_DEV_MSG_5_value
    End Property

    Property Let write_BITS_21_11_OF_LOC_DEV_MSG_5(aData)
        set_BITS_21_11_OF_LOC_DEV_MSG_5 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        BITS_21_11_OF_LOC_DEV_MSG_5_mask = &H7ff
        if data_low > LONG_MAX then
            if BITS_21_11_OF_LOC_DEV_MSG_5_mask = mask then
                read_BITS_21_11_OF_LOC_DEV_MSG_5_value = data_low
            else
                read_BITS_21_11_OF_LOC_DEV_MSG_5_value = (data_low - H8000_0000) and BITS_21_11_OF_LOC_DEV_MSG_5_mask
            end If
        else
            read_BITS_21_11_OF_LOC_DEV_MSG_5_value = data_low and BITS_21_11_OF_LOC_DEV_MSG_5_mask
        end If

    End Sub

    Sub write
        If flag_BITS_21_11_OF_LOC_DEV_MSG_5 = &H0 Then read
        If flag_BITS_21_11_OF_LOC_DEV_MSG_5 = &H0 Then write_BITS_21_11_OF_LOC_DEV_MSG_5_value = get_BITS_21_11_OF_LOC_DEV_MSG_5

        regValue = leftShift((write_BITS_21_11_OF_LOC_DEV_MSG_5_value and &H7ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        BITS_21_11_OF_LOC_DEV_MSG_5_mask = &H7ff
        if data_low > LONG_MAX then
            if BITS_21_11_OF_LOC_DEV_MSG_5_mask = mask then
                read_BITS_21_11_OF_LOC_DEV_MSG_5_value = data_low
            else
                read_BITS_21_11_OF_LOC_DEV_MSG_5_value = (data_low - H8000_0000) and BITS_21_11_OF_LOC_DEV_MSG_5_mask
            end If
        else
            read_BITS_21_11_OF_LOC_DEV_MSG_5_value = data_low and BITS_21_11_OF_LOC_DEV_MSG_5_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_BITS_21_11_OF_LOC_DEV_MSG_5_value = &H0
        flag_BITS_21_11_OF_LOC_DEV_MSG_5        = &H0
    End Sub
End Class


'' @REGISTER : CL45VEN_loc_dev_msg_5_c
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' BITS_32_22_OF_LOC_DEV_MSG_5                [10:0]           get_BITS_32_22_OF_LOC_DEV_MSG_5
''                                                             set_BITS_32_22_OF_LOC_DEV_MSG_5
''                                                             read_BITS_32_22_OF_LOC_DEV_MSG_5
''                                                             write_BITS_32_22_OF_LOC_DEV_MSG_5
''---------------------------------------------------------------------------------
Class REGISTER_CL45VEN_loc_dev_msg_5_c
    Private write_BITS_32_22_OF_LOC_DEV_MSG_5_value
    Private read_BITS_32_22_OF_LOC_DEV_MSG_5_value
    Private flag_BITS_32_22_OF_LOC_DEV_MSG_5

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

    Property Get get_BITS_32_22_OF_LOC_DEV_MSG_5
        get_BITS_32_22_OF_LOC_DEV_MSG_5 = read_BITS_32_22_OF_LOC_DEV_MSG_5_value
    End Property

    Property Let set_BITS_32_22_OF_LOC_DEV_MSG_5(aData)
        write_BITS_32_22_OF_LOC_DEV_MSG_5_value = aData
        flag_BITS_32_22_OF_LOC_DEV_MSG_5        = &H1
    End Property

    Property Get read_BITS_32_22_OF_LOC_DEV_MSG_5
        read
        read_BITS_32_22_OF_LOC_DEV_MSG_5 = read_BITS_32_22_OF_LOC_DEV_MSG_5_value
    End Property

    Property Let write_BITS_32_22_OF_LOC_DEV_MSG_5(aData)
        set_BITS_32_22_OF_LOC_DEV_MSG_5 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        BITS_32_22_OF_LOC_DEV_MSG_5_mask = &H7ff
        if data_low > LONG_MAX then
            if BITS_32_22_OF_LOC_DEV_MSG_5_mask = mask then
                read_BITS_32_22_OF_LOC_DEV_MSG_5_value = data_low
            else
                read_BITS_32_22_OF_LOC_DEV_MSG_5_value = (data_low - H8000_0000) and BITS_32_22_OF_LOC_DEV_MSG_5_mask
            end If
        else
            read_BITS_32_22_OF_LOC_DEV_MSG_5_value = data_low and BITS_32_22_OF_LOC_DEV_MSG_5_mask
        end If

    End Sub

    Sub write
        If flag_BITS_32_22_OF_LOC_DEV_MSG_5 = &H0 Then read
        If flag_BITS_32_22_OF_LOC_DEV_MSG_5 = &H0 Then write_BITS_32_22_OF_LOC_DEV_MSG_5_value = get_BITS_32_22_OF_LOC_DEV_MSG_5

        regValue = leftShift((write_BITS_32_22_OF_LOC_DEV_MSG_5_value and &H7ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        BITS_32_22_OF_LOC_DEV_MSG_5_mask = &H7ff
        if data_low > LONG_MAX then
            if BITS_32_22_OF_LOC_DEV_MSG_5_mask = mask then
                read_BITS_32_22_OF_LOC_DEV_MSG_5_value = data_low
            else
                read_BITS_32_22_OF_LOC_DEV_MSG_5_value = (data_low - H8000_0000) and BITS_32_22_OF_LOC_DEV_MSG_5_mask
            end If
        else
            read_BITS_32_22_OF_LOC_DEV_MSG_5_value = data_low and BITS_32_22_OF_LOC_DEV_MSG_5_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_BITS_32_22_OF_LOC_DEV_MSG_5_value = &H0
        flag_BITS_32_22_OF_LOC_DEV_MSG_5        = &H0
    End Sub
End Class


'' @REGISTER : CL45VEN_loc_dev_msg_5_d
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' BITS_43_33_OF_LOC_DEV_MSG_5                [10:0]           get_BITS_43_33_OF_LOC_DEV_MSG_5
''                                                             set_BITS_43_33_OF_LOC_DEV_MSG_5
''                                                             read_BITS_43_33_OF_LOC_DEV_MSG_5
''                                                             write_BITS_43_33_OF_LOC_DEV_MSG_5
''---------------------------------------------------------------------------------
Class REGISTER_CL45VEN_loc_dev_msg_5_d
    Private write_BITS_43_33_OF_LOC_DEV_MSG_5_value
    Private read_BITS_43_33_OF_LOC_DEV_MSG_5_value
    Private flag_BITS_43_33_OF_LOC_DEV_MSG_5

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H86
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_BITS_43_33_OF_LOC_DEV_MSG_5
        get_BITS_43_33_OF_LOC_DEV_MSG_5 = read_BITS_43_33_OF_LOC_DEV_MSG_5_value
    End Property

    Property Let set_BITS_43_33_OF_LOC_DEV_MSG_5(aData)
        write_BITS_43_33_OF_LOC_DEV_MSG_5_value = aData
        flag_BITS_43_33_OF_LOC_DEV_MSG_5        = &H1
    End Property

    Property Get read_BITS_43_33_OF_LOC_DEV_MSG_5
        read
        read_BITS_43_33_OF_LOC_DEV_MSG_5 = read_BITS_43_33_OF_LOC_DEV_MSG_5_value
    End Property

    Property Let write_BITS_43_33_OF_LOC_DEV_MSG_5(aData)
        set_BITS_43_33_OF_LOC_DEV_MSG_5 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        BITS_43_33_OF_LOC_DEV_MSG_5_mask = &H7ff
        if data_low > LONG_MAX then
            if BITS_43_33_OF_LOC_DEV_MSG_5_mask = mask then
                read_BITS_43_33_OF_LOC_DEV_MSG_5_value = data_low
            else
                read_BITS_43_33_OF_LOC_DEV_MSG_5_value = (data_low - H8000_0000) and BITS_43_33_OF_LOC_DEV_MSG_5_mask
            end If
        else
            read_BITS_43_33_OF_LOC_DEV_MSG_5_value = data_low and BITS_43_33_OF_LOC_DEV_MSG_5_mask
        end If

    End Sub

    Sub write
        If flag_BITS_43_33_OF_LOC_DEV_MSG_5 = &H0 Then read
        If flag_BITS_43_33_OF_LOC_DEV_MSG_5 = &H0 Then write_BITS_43_33_OF_LOC_DEV_MSG_5_value = get_BITS_43_33_OF_LOC_DEV_MSG_5

        regValue = leftShift((write_BITS_43_33_OF_LOC_DEV_MSG_5_value and &H7ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        BITS_43_33_OF_LOC_DEV_MSG_5_mask = &H7ff
        if data_low > LONG_MAX then
            if BITS_43_33_OF_LOC_DEV_MSG_5_mask = mask then
                read_BITS_43_33_OF_LOC_DEV_MSG_5_value = data_low
            else
                read_BITS_43_33_OF_LOC_DEV_MSG_5_value = (data_low - H8000_0000) and BITS_43_33_OF_LOC_DEV_MSG_5_mask
            end If
        else
            read_BITS_43_33_OF_LOC_DEV_MSG_5_value = data_low and BITS_43_33_OF_LOC_DEV_MSG_5_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_BITS_43_33_OF_LOC_DEV_MSG_5_value = &H0
        flag_BITS_43_33_OF_LOC_DEV_MSG_5        = &H0
    End Sub
End Class


'' @REGISTER : CL45VEN_lnk_partnr_msg_5_a
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_5_OUI_MATCH                            [15:15]          get_MSG_5_OUI_MATCH
''                                                             set_MSG_5_OUI_MATCH
''                                                             read_MSG_5_OUI_MATCH
''                                                             write_MSG_5_OUI_MATCH
''---------------------------------------------------------------------------------
'' BITS_10_0_OF_LNK_PARTNR_MSG_5              [10:0]           get_BITS_10_0_OF_LNK_PARTNR_MSG_5
''                                                             set_BITS_10_0_OF_LNK_PARTNR_MSG_5
''                                                             read_BITS_10_0_OF_LNK_PARTNR_MSG_5
''                                                             write_BITS_10_0_OF_LNK_PARTNR_MSG_5
''---------------------------------------------------------------------------------
Class REGISTER_CL45VEN_lnk_partnr_msg_5_a
    Private write_MSG_5_OUI_MATCH_value
    Private read_MSG_5_OUI_MATCH_value
    Private flag_MSG_5_OUI_MATCH
    Private write_BITS_10_0_OF_LNK_PARTNR_MSG_5_value
    Private read_BITS_10_0_OF_LNK_PARTNR_MSG_5_value
    Private flag_BITS_10_0_OF_LNK_PARTNR_MSG_5

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

    Property Get get_MSG_5_OUI_MATCH
        get_MSG_5_OUI_MATCH = read_MSG_5_OUI_MATCH_value
    End Property

    Property Let set_MSG_5_OUI_MATCH(aData)
        write_MSG_5_OUI_MATCH_value = aData
        flag_MSG_5_OUI_MATCH        = &H1
    End Property

    Property Get read_MSG_5_OUI_MATCH
        read
        read_MSG_5_OUI_MATCH = read_MSG_5_OUI_MATCH_value
    End Property

    Property Let write_MSG_5_OUI_MATCH(aData)
        set_MSG_5_OUI_MATCH = aData
        write
    End Property

    Property Get get_BITS_10_0_OF_LNK_PARTNR_MSG_5
        get_BITS_10_0_OF_LNK_PARTNR_MSG_5 = read_BITS_10_0_OF_LNK_PARTNR_MSG_5_value
    End Property

    Property Let set_BITS_10_0_OF_LNK_PARTNR_MSG_5(aData)
        write_BITS_10_0_OF_LNK_PARTNR_MSG_5_value = aData
        flag_BITS_10_0_OF_LNK_PARTNR_MSG_5        = &H1
    End Property

    Property Get read_BITS_10_0_OF_LNK_PARTNR_MSG_5
        read
        read_BITS_10_0_OF_LNK_PARTNR_MSG_5 = read_BITS_10_0_OF_LNK_PARTNR_MSG_5_value
    End Property

    Property Let write_BITS_10_0_OF_LNK_PARTNR_MSG_5(aData)
        set_BITS_10_0_OF_LNK_PARTNR_MSG_5 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MSG_5_OUI_MATCH_value = rightShift(data_low, 15) and &H1
        BITS_10_0_OF_LNK_PARTNR_MSG_5_mask = &H7ff
        if data_low > LONG_MAX then
            if BITS_10_0_OF_LNK_PARTNR_MSG_5_mask = mask then
                read_BITS_10_0_OF_LNK_PARTNR_MSG_5_value = data_low
            else
                read_BITS_10_0_OF_LNK_PARTNR_MSG_5_value = (data_low - H8000_0000) and BITS_10_0_OF_LNK_PARTNR_MSG_5_mask
            end If
        else
            read_BITS_10_0_OF_LNK_PARTNR_MSG_5_value = data_low and BITS_10_0_OF_LNK_PARTNR_MSG_5_mask
        end If

    End Sub

    Sub write
        If flag_MSG_5_OUI_MATCH = &H0 or flag_BITS_10_0_OF_LNK_PARTNR_MSG_5 = &H0 Then read
        If flag_MSG_5_OUI_MATCH = &H0 Then write_MSG_5_OUI_MATCH_value = get_MSG_5_OUI_MATCH
        If flag_BITS_10_0_OF_LNK_PARTNR_MSG_5 = &H0 Then write_BITS_10_0_OF_LNK_PARTNR_MSG_5_value = get_BITS_10_0_OF_LNK_PARTNR_MSG_5

        regValue = leftShift((write_MSG_5_OUI_MATCH_value and &H1), 15) + leftShift((write_BITS_10_0_OF_LNK_PARTNR_MSG_5_value and &H7ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MSG_5_OUI_MATCH_value = rightShift(data_low, 15) and &H1
        BITS_10_0_OF_LNK_PARTNR_MSG_5_mask = &H7ff
        if data_low > LONG_MAX then
            if BITS_10_0_OF_LNK_PARTNR_MSG_5_mask = mask then
                read_BITS_10_0_OF_LNK_PARTNR_MSG_5_value = data_low
            else
                read_BITS_10_0_OF_LNK_PARTNR_MSG_5_value = (data_low - H8000_0000) and BITS_10_0_OF_LNK_PARTNR_MSG_5_mask
            end If
        else
            read_BITS_10_0_OF_LNK_PARTNR_MSG_5_value = data_low and BITS_10_0_OF_LNK_PARTNR_MSG_5_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_5_OUI_MATCH_value = &H0
        flag_MSG_5_OUI_MATCH        = &H0
        write_BITS_10_0_OF_LNK_PARTNR_MSG_5_value = &H0
        flag_BITS_10_0_OF_LNK_PARTNR_MSG_5        = &H0
    End Sub
End Class


'' @REGISTER : CL45VEN_lnk_partnr_msg_5_b
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' BITS_21_11_OF_LNK_PARTNR_MSG_5             [10:0]           get_BITS_21_11_OF_LNK_PARTNR_MSG_5
''                                                             set_BITS_21_11_OF_LNK_PARTNR_MSG_5
''                                                             read_BITS_21_11_OF_LNK_PARTNR_MSG_5
''                                                             write_BITS_21_11_OF_LNK_PARTNR_MSG_5
''---------------------------------------------------------------------------------
Class REGISTER_CL45VEN_lnk_partnr_msg_5_b
    Private write_BITS_21_11_OF_LNK_PARTNR_MSG_5_value
    Private read_BITS_21_11_OF_LNK_PARTNR_MSG_5_value
    Private flag_BITS_21_11_OF_LNK_PARTNR_MSG_5

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H8a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_BITS_21_11_OF_LNK_PARTNR_MSG_5
        get_BITS_21_11_OF_LNK_PARTNR_MSG_5 = read_BITS_21_11_OF_LNK_PARTNR_MSG_5_value
    End Property

    Property Let set_BITS_21_11_OF_LNK_PARTNR_MSG_5(aData)
        write_BITS_21_11_OF_LNK_PARTNR_MSG_5_value = aData
        flag_BITS_21_11_OF_LNK_PARTNR_MSG_5        = &H1
    End Property

    Property Get read_BITS_21_11_OF_LNK_PARTNR_MSG_5
        read
        read_BITS_21_11_OF_LNK_PARTNR_MSG_5 = read_BITS_21_11_OF_LNK_PARTNR_MSG_5_value
    End Property

    Property Let write_BITS_21_11_OF_LNK_PARTNR_MSG_5(aData)
        set_BITS_21_11_OF_LNK_PARTNR_MSG_5 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        BITS_21_11_OF_LNK_PARTNR_MSG_5_mask = &H7ff
        if data_low > LONG_MAX then
            if BITS_21_11_OF_LNK_PARTNR_MSG_5_mask = mask then
                read_BITS_21_11_OF_LNK_PARTNR_MSG_5_value = data_low
            else
                read_BITS_21_11_OF_LNK_PARTNR_MSG_5_value = (data_low - H8000_0000) and BITS_21_11_OF_LNK_PARTNR_MSG_5_mask
            end If
        else
            read_BITS_21_11_OF_LNK_PARTNR_MSG_5_value = data_low and BITS_21_11_OF_LNK_PARTNR_MSG_5_mask
        end If

    End Sub

    Sub write
        If flag_BITS_21_11_OF_LNK_PARTNR_MSG_5 = &H0 Then read
        If flag_BITS_21_11_OF_LNK_PARTNR_MSG_5 = &H0 Then write_BITS_21_11_OF_LNK_PARTNR_MSG_5_value = get_BITS_21_11_OF_LNK_PARTNR_MSG_5

        regValue = leftShift((write_BITS_21_11_OF_LNK_PARTNR_MSG_5_value and &H7ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        BITS_21_11_OF_LNK_PARTNR_MSG_5_mask = &H7ff
        if data_low > LONG_MAX then
            if BITS_21_11_OF_LNK_PARTNR_MSG_5_mask = mask then
                read_BITS_21_11_OF_LNK_PARTNR_MSG_5_value = data_low
            else
                read_BITS_21_11_OF_LNK_PARTNR_MSG_5_value = (data_low - H8000_0000) and BITS_21_11_OF_LNK_PARTNR_MSG_5_mask
            end If
        else
            read_BITS_21_11_OF_LNK_PARTNR_MSG_5_value = data_low and BITS_21_11_OF_LNK_PARTNR_MSG_5_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_BITS_21_11_OF_LNK_PARTNR_MSG_5_value = &H0
        flag_BITS_21_11_OF_LNK_PARTNR_MSG_5        = &H0
    End Sub
End Class


'' @REGISTER : CL45VEN_lnk_partnr_msg_5_c
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' BITS_32_22_OF_LNK_PARTNR_MSG_5             [10:0]           get_BITS_32_22_OF_LNK_PARTNR_MSG_5
''                                                             set_BITS_32_22_OF_LNK_PARTNR_MSG_5
''                                                             read_BITS_32_22_OF_LNK_PARTNR_MSG_5
''                                                             write_BITS_32_22_OF_LNK_PARTNR_MSG_5
''---------------------------------------------------------------------------------
Class REGISTER_CL45VEN_lnk_partnr_msg_5_c
    Private write_BITS_32_22_OF_LNK_PARTNR_MSG_5_value
    Private read_BITS_32_22_OF_LNK_PARTNR_MSG_5_value
    Private flag_BITS_32_22_OF_LNK_PARTNR_MSG_5

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

    Property Get get_BITS_32_22_OF_LNK_PARTNR_MSG_5
        get_BITS_32_22_OF_LNK_PARTNR_MSG_5 = read_BITS_32_22_OF_LNK_PARTNR_MSG_5_value
    End Property

    Property Let set_BITS_32_22_OF_LNK_PARTNR_MSG_5(aData)
        write_BITS_32_22_OF_LNK_PARTNR_MSG_5_value = aData
        flag_BITS_32_22_OF_LNK_PARTNR_MSG_5        = &H1
    End Property

    Property Get read_BITS_32_22_OF_LNK_PARTNR_MSG_5
        read
        read_BITS_32_22_OF_LNK_PARTNR_MSG_5 = read_BITS_32_22_OF_LNK_PARTNR_MSG_5_value
    End Property

    Property Let write_BITS_32_22_OF_LNK_PARTNR_MSG_5(aData)
        set_BITS_32_22_OF_LNK_PARTNR_MSG_5 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        BITS_32_22_OF_LNK_PARTNR_MSG_5_mask = &H7ff
        if data_low > LONG_MAX then
            if BITS_32_22_OF_LNK_PARTNR_MSG_5_mask = mask then
                read_BITS_32_22_OF_LNK_PARTNR_MSG_5_value = data_low
            else
                read_BITS_32_22_OF_LNK_PARTNR_MSG_5_value = (data_low - H8000_0000) and BITS_32_22_OF_LNK_PARTNR_MSG_5_mask
            end If
        else
            read_BITS_32_22_OF_LNK_PARTNR_MSG_5_value = data_low and BITS_32_22_OF_LNK_PARTNR_MSG_5_mask
        end If

    End Sub

    Sub write
        If flag_BITS_32_22_OF_LNK_PARTNR_MSG_5 = &H0 Then read
        If flag_BITS_32_22_OF_LNK_PARTNR_MSG_5 = &H0 Then write_BITS_32_22_OF_LNK_PARTNR_MSG_5_value = get_BITS_32_22_OF_LNK_PARTNR_MSG_5

        regValue = leftShift((write_BITS_32_22_OF_LNK_PARTNR_MSG_5_value and &H7ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        BITS_32_22_OF_LNK_PARTNR_MSG_5_mask = &H7ff
        if data_low > LONG_MAX then
            if BITS_32_22_OF_LNK_PARTNR_MSG_5_mask = mask then
                read_BITS_32_22_OF_LNK_PARTNR_MSG_5_value = data_low
            else
                read_BITS_32_22_OF_LNK_PARTNR_MSG_5_value = (data_low - H8000_0000) and BITS_32_22_OF_LNK_PARTNR_MSG_5_mask
            end If
        else
            read_BITS_32_22_OF_LNK_PARTNR_MSG_5_value = data_low and BITS_32_22_OF_LNK_PARTNR_MSG_5_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_BITS_32_22_OF_LNK_PARTNR_MSG_5_value = &H0
        flag_BITS_32_22_OF_LNK_PARTNR_MSG_5        = &H0
    End Sub
End Class


'' @REGISTER : CL45VEN_lnk_partnr_msg_5_d
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' BITS_43_33_OF_LNK_PARTNR_MSG_5             [10:0]           get_BITS_43_33_OF_LNK_PARTNR_MSG_5
''                                                             set_BITS_43_33_OF_LNK_PARTNR_MSG_5
''                                                             read_BITS_43_33_OF_LNK_PARTNR_MSG_5
''                                                             write_BITS_43_33_OF_LNK_PARTNR_MSG_5
''---------------------------------------------------------------------------------
Class REGISTER_CL45VEN_lnk_partnr_msg_5_d
    Private write_BITS_43_33_OF_LNK_PARTNR_MSG_5_value
    Private read_BITS_43_33_OF_LNK_PARTNR_MSG_5_value
    Private flag_BITS_43_33_OF_LNK_PARTNR_MSG_5

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H8e
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_BITS_43_33_OF_LNK_PARTNR_MSG_5
        get_BITS_43_33_OF_LNK_PARTNR_MSG_5 = read_BITS_43_33_OF_LNK_PARTNR_MSG_5_value
    End Property

    Property Let set_BITS_43_33_OF_LNK_PARTNR_MSG_5(aData)
        write_BITS_43_33_OF_LNK_PARTNR_MSG_5_value = aData
        flag_BITS_43_33_OF_LNK_PARTNR_MSG_5        = &H1
    End Property

    Property Get read_BITS_43_33_OF_LNK_PARTNR_MSG_5
        read
        read_BITS_43_33_OF_LNK_PARTNR_MSG_5 = read_BITS_43_33_OF_LNK_PARTNR_MSG_5_value
    End Property

    Property Let write_BITS_43_33_OF_LNK_PARTNR_MSG_5(aData)
        set_BITS_43_33_OF_LNK_PARTNR_MSG_5 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        BITS_43_33_OF_LNK_PARTNR_MSG_5_mask = &H7ff
        if data_low > LONG_MAX then
            if BITS_43_33_OF_LNK_PARTNR_MSG_5_mask = mask then
                read_BITS_43_33_OF_LNK_PARTNR_MSG_5_value = data_low
            else
                read_BITS_43_33_OF_LNK_PARTNR_MSG_5_value = (data_low - H8000_0000) and BITS_43_33_OF_LNK_PARTNR_MSG_5_mask
            end If
        else
            read_BITS_43_33_OF_LNK_PARTNR_MSG_5_value = data_low and BITS_43_33_OF_LNK_PARTNR_MSG_5_mask
        end If

    End Sub

    Sub write
        If flag_BITS_43_33_OF_LNK_PARTNR_MSG_5 = &H0 Then read
        If flag_BITS_43_33_OF_LNK_PARTNR_MSG_5 = &H0 Then write_BITS_43_33_OF_LNK_PARTNR_MSG_5_value = get_BITS_43_33_OF_LNK_PARTNR_MSG_5

        regValue = leftShift((write_BITS_43_33_OF_LNK_PARTNR_MSG_5_value and &H7ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        BITS_43_33_OF_LNK_PARTNR_MSG_5_mask = &H7ff
        if data_low > LONG_MAX then
            if BITS_43_33_OF_LNK_PARTNR_MSG_5_mask = mask then
                read_BITS_43_33_OF_LNK_PARTNR_MSG_5_value = data_low
            else
                read_BITS_43_33_OF_LNK_PARTNR_MSG_5_value = (data_low - H8000_0000) and BITS_43_33_OF_LNK_PARTNR_MSG_5_mask
            end If
        else
            read_BITS_43_33_OF_LNK_PARTNR_MSG_5_value = data_low and BITS_43_33_OF_LNK_PARTNR_MSG_5_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_BITS_43_33_OF_LNK_PARTNR_MSG_5_value = &H0
        flag_BITS_43_33_OF_LNK_PARTNR_MSG_5        = &H0
    End Sub
End Class


'' @REGISTER : CL45VEN_loc_dev_msg_6_a
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' BITS_10_0_OF_LOC_DEV_MSG_6                 [10:0]           get_BITS_10_0_OF_LOC_DEV_MSG_6
''                                                             set_BITS_10_0_OF_LOC_DEV_MSG_6
''                                                             read_BITS_10_0_OF_LOC_DEV_MSG_6
''                                                             write_BITS_10_0_OF_LOC_DEV_MSG_6
''---------------------------------------------------------------------------------
Class REGISTER_CL45VEN_loc_dev_msg_6_a
    Private write_BITS_10_0_OF_LOC_DEV_MSG_6_value
    Private read_BITS_10_0_OF_LOC_DEV_MSG_6_value
    Private flag_BITS_10_0_OF_LOC_DEV_MSG_6

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

    Property Get get_BITS_10_0_OF_LOC_DEV_MSG_6
        get_BITS_10_0_OF_LOC_DEV_MSG_6 = read_BITS_10_0_OF_LOC_DEV_MSG_6_value
    End Property

    Property Let set_BITS_10_0_OF_LOC_DEV_MSG_6(aData)
        write_BITS_10_0_OF_LOC_DEV_MSG_6_value = aData
        flag_BITS_10_0_OF_LOC_DEV_MSG_6        = &H1
    End Property

    Property Get read_BITS_10_0_OF_LOC_DEV_MSG_6
        read
        read_BITS_10_0_OF_LOC_DEV_MSG_6 = read_BITS_10_0_OF_LOC_DEV_MSG_6_value
    End Property

    Property Let write_BITS_10_0_OF_LOC_DEV_MSG_6(aData)
        set_BITS_10_0_OF_LOC_DEV_MSG_6 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        BITS_10_0_OF_LOC_DEV_MSG_6_mask = &H7ff
        if data_low > LONG_MAX then
            if BITS_10_0_OF_LOC_DEV_MSG_6_mask = mask then
                read_BITS_10_0_OF_LOC_DEV_MSG_6_value = data_low
            else
                read_BITS_10_0_OF_LOC_DEV_MSG_6_value = (data_low - H8000_0000) and BITS_10_0_OF_LOC_DEV_MSG_6_mask
            end If
        else
            read_BITS_10_0_OF_LOC_DEV_MSG_6_value = data_low and BITS_10_0_OF_LOC_DEV_MSG_6_mask
        end If

    End Sub

    Sub write
        If flag_BITS_10_0_OF_LOC_DEV_MSG_6 = &H0 Then read
        If flag_BITS_10_0_OF_LOC_DEV_MSG_6 = &H0 Then write_BITS_10_0_OF_LOC_DEV_MSG_6_value = get_BITS_10_0_OF_LOC_DEV_MSG_6

        regValue = leftShift((write_BITS_10_0_OF_LOC_DEV_MSG_6_value and &H7ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        BITS_10_0_OF_LOC_DEV_MSG_6_mask = &H7ff
        if data_low > LONG_MAX then
            if BITS_10_0_OF_LOC_DEV_MSG_6_mask = mask then
                read_BITS_10_0_OF_LOC_DEV_MSG_6_value = data_low
            else
                read_BITS_10_0_OF_LOC_DEV_MSG_6_value = (data_low - H8000_0000) and BITS_10_0_OF_LOC_DEV_MSG_6_mask
            end If
        else
            read_BITS_10_0_OF_LOC_DEV_MSG_6_value = data_low and BITS_10_0_OF_LOC_DEV_MSG_6_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_BITS_10_0_OF_LOC_DEV_MSG_6_value = &H0
        flag_BITS_10_0_OF_LOC_DEV_MSG_6        = &H0
    End Sub
End Class


'' @REGISTER : CL45VEN_loc_dev_msg_6_b
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' BITS_21_11_OF_LOC_DEV_MSG_6                [10:0]           get_BITS_21_11_OF_LOC_DEV_MSG_6
''                                                             set_BITS_21_11_OF_LOC_DEV_MSG_6
''                                                             read_BITS_21_11_OF_LOC_DEV_MSG_6
''                                                             write_BITS_21_11_OF_LOC_DEV_MSG_6
''---------------------------------------------------------------------------------
Class REGISTER_CL45VEN_loc_dev_msg_6_b
    Private write_BITS_21_11_OF_LOC_DEV_MSG_6_value
    Private read_BITS_21_11_OF_LOC_DEV_MSG_6_value
    Private flag_BITS_21_11_OF_LOC_DEV_MSG_6

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H92
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_BITS_21_11_OF_LOC_DEV_MSG_6
        get_BITS_21_11_OF_LOC_DEV_MSG_6 = read_BITS_21_11_OF_LOC_DEV_MSG_6_value
    End Property

    Property Let set_BITS_21_11_OF_LOC_DEV_MSG_6(aData)
        write_BITS_21_11_OF_LOC_DEV_MSG_6_value = aData
        flag_BITS_21_11_OF_LOC_DEV_MSG_6        = &H1
    End Property

    Property Get read_BITS_21_11_OF_LOC_DEV_MSG_6
        read
        read_BITS_21_11_OF_LOC_DEV_MSG_6 = read_BITS_21_11_OF_LOC_DEV_MSG_6_value
    End Property

    Property Let write_BITS_21_11_OF_LOC_DEV_MSG_6(aData)
        set_BITS_21_11_OF_LOC_DEV_MSG_6 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        BITS_21_11_OF_LOC_DEV_MSG_6_mask = &H7ff
        if data_low > LONG_MAX then
            if BITS_21_11_OF_LOC_DEV_MSG_6_mask = mask then
                read_BITS_21_11_OF_LOC_DEV_MSG_6_value = data_low
            else
                read_BITS_21_11_OF_LOC_DEV_MSG_6_value = (data_low - H8000_0000) and BITS_21_11_OF_LOC_DEV_MSG_6_mask
            end If
        else
            read_BITS_21_11_OF_LOC_DEV_MSG_6_value = data_low and BITS_21_11_OF_LOC_DEV_MSG_6_mask
        end If

    End Sub

    Sub write
        If flag_BITS_21_11_OF_LOC_DEV_MSG_6 = &H0 Then read
        If flag_BITS_21_11_OF_LOC_DEV_MSG_6 = &H0 Then write_BITS_21_11_OF_LOC_DEV_MSG_6_value = get_BITS_21_11_OF_LOC_DEV_MSG_6

        regValue = leftShift((write_BITS_21_11_OF_LOC_DEV_MSG_6_value and &H7ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        BITS_21_11_OF_LOC_DEV_MSG_6_mask = &H7ff
        if data_low > LONG_MAX then
            if BITS_21_11_OF_LOC_DEV_MSG_6_mask = mask then
                read_BITS_21_11_OF_LOC_DEV_MSG_6_value = data_low
            else
                read_BITS_21_11_OF_LOC_DEV_MSG_6_value = (data_low - H8000_0000) and BITS_21_11_OF_LOC_DEV_MSG_6_mask
            end If
        else
            read_BITS_21_11_OF_LOC_DEV_MSG_6_value = data_low and BITS_21_11_OF_LOC_DEV_MSG_6_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_BITS_21_11_OF_LOC_DEV_MSG_6_value = &H0
        flag_BITS_21_11_OF_LOC_DEV_MSG_6        = &H0
    End Sub
End Class


'' @REGISTER : CL45VEN_loc_dev_msg_6_c
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' BITS_32_22_OF_LOC_DEV_MSG_6                [10:0]           get_BITS_32_22_OF_LOC_DEV_MSG_6
''                                                             set_BITS_32_22_OF_LOC_DEV_MSG_6
''                                                             read_BITS_32_22_OF_LOC_DEV_MSG_6
''                                                             write_BITS_32_22_OF_LOC_DEV_MSG_6
''---------------------------------------------------------------------------------
Class REGISTER_CL45VEN_loc_dev_msg_6_c
    Private write_BITS_32_22_OF_LOC_DEV_MSG_6_value
    Private read_BITS_32_22_OF_LOC_DEV_MSG_6_value
    Private flag_BITS_32_22_OF_LOC_DEV_MSG_6

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

    Property Get get_BITS_32_22_OF_LOC_DEV_MSG_6
        get_BITS_32_22_OF_LOC_DEV_MSG_6 = read_BITS_32_22_OF_LOC_DEV_MSG_6_value
    End Property

    Property Let set_BITS_32_22_OF_LOC_DEV_MSG_6(aData)
        write_BITS_32_22_OF_LOC_DEV_MSG_6_value = aData
        flag_BITS_32_22_OF_LOC_DEV_MSG_6        = &H1
    End Property

    Property Get read_BITS_32_22_OF_LOC_DEV_MSG_6
        read
        read_BITS_32_22_OF_LOC_DEV_MSG_6 = read_BITS_32_22_OF_LOC_DEV_MSG_6_value
    End Property

    Property Let write_BITS_32_22_OF_LOC_DEV_MSG_6(aData)
        set_BITS_32_22_OF_LOC_DEV_MSG_6 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        BITS_32_22_OF_LOC_DEV_MSG_6_mask = &H7ff
        if data_low > LONG_MAX then
            if BITS_32_22_OF_LOC_DEV_MSG_6_mask = mask then
                read_BITS_32_22_OF_LOC_DEV_MSG_6_value = data_low
            else
                read_BITS_32_22_OF_LOC_DEV_MSG_6_value = (data_low - H8000_0000) and BITS_32_22_OF_LOC_DEV_MSG_6_mask
            end If
        else
            read_BITS_32_22_OF_LOC_DEV_MSG_6_value = data_low and BITS_32_22_OF_LOC_DEV_MSG_6_mask
        end If

    End Sub

    Sub write
        If flag_BITS_32_22_OF_LOC_DEV_MSG_6 = &H0 Then read
        If flag_BITS_32_22_OF_LOC_DEV_MSG_6 = &H0 Then write_BITS_32_22_OF_LOC_DEV_MSG_6_value = get_BITS_32_22_OF_LOC_DEV_MSG_6

        regValue = leftShift((write_BITS_32_22_OF_LOC_DEV_MSG_6_value and &H7ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        BITS_32_22_OF_LOC_DEV_MSG_6_mask = &H7ff
        if data_low > LONG_MAX then
            if BITS_32_22_OF_LOC_DEV_MSG_6_mask = mask then
                read_BITS_32_22_OF_LOC_DEV_MSG_6_value = data_low
            else
                read_BITS_32_22_OF_LOC_DEV_MSG_6_value = (data_low - H8000_0000) and BITS_32_22_OF_LOC_DEV_MSG_6_mask
            end If
        else
            read_BITS_32_22_OF_LOC_DEV_MSG_6_value = data_low and BITS_32_22_OF_LOC_DEV_MSG_6_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_BITS_32_22_OF_LOC_DEV_MSG_6_value = &H0
        flag_BITS_32_22_OF_LOC_DEV_MSG_6        = &H0
    End Sub
End Class


'' @REGISTER : CL45VEN_loc_dev_msg_6_d
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' BITS_43_33_OF_LOC_DEV_MSG_6                [10:0]           get_BITS_43_33_OF_LOC_DEV_MSG_6
''                                                             set_BITS_43_33_OF_LOC_DEV_MSG_6
''                                                             read_BITS_43_33_OF_LOC_DEV_MSG_6
''                                                             write_BITS_43_33_OF_LOC_DEV_MSG_6
''---------------------------------------------------------------------------------
Class REGISTER_CL45VEN_loc_dev_msg_6_d
    Private write_BITS_43_33_OF_LOC_DEV_MSG_6_value
    Private read_BITS_43_33_OF_LOC_DEV_MSG_6_value
    Private flag_BITS_43_33_OF_LOC_DEV_MSG_6

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H96
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_BITS_43_33_OF_LOC_DEV_MSG_6
        get_BITS_43_33_OF_LOC_DEV_MSG_6 = read_BITS_43_33_OF_LOC_DEV_MSG_6_value
    End Property

    Property Let set_BITS_43_33_OF_LOC_DEV_MSG_6(aData)
        write_BITS_43_33_OF_LOC_DEV_MSG_6_value = aData
        flag_BITS_43_33_OF_LOC_DEV_MSG_6        = &H1
    End Property

    Property Get read_BITS_43_33_OF_LOC_DEV_MSG_6
        read
        read_BITS_43_33_OF_LOC_DEV_MSG_6 = read_BITS_43_33_OF_LOC_DEV_MSG_6_value
    End Property

    Property Let write_BITS_43_33_OF_LOC_DEV_MSG_6(aData)
        set_BITS_43_33_OF_LOC_DEV_MSG_6 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        BITS_43_33_OF_LOC_DEV_MSG_6_mask = &H7ff
        if data_low > LONG_MAX then
            if BITS_43_33_OF_LOC_DEV_MSG_6_mask = mask then
                read_BITS_43_33_OF_LOC_DEV_MSG_6_value = data_low
            else
                read_BITS_43_33_OF_LOC_DEV_MSG_6_value = (data_low - H8000_0000) and BITS_43_33_OF_LOC_DEV_MSG_6_mask
            end If
        else
            read_BITS_43_33_OF_LOC_DEV_MSG_6_value = data_low and BITS_43_33_OF_LOC_DEV_MSG_6_mask
        end If

    End Sub

    Sub write
        If flag_BITS_43_33_OF_LOC_DEV_MSG_6 = &H0 Then read
        If flag_BITS_43_33_OF_LOC_DEV_MSG_6 = &H0 Then write_BITS_43_33_OF_LOC_DEV_MSG_6_value = get_BITS_43_33_OF_LOC_DEV_MSG_6

        regValue = leftShift((write_BITS_43_33_OF_LOC_DEV_MSG_6_value and &H7ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        BITS_43_33_OF_LOC_DEV_MSG_6_mask = &H7ff
        if data_low > LONG_MAX then
            if BITS_43_33_OF_LOC_DEV_MSG_6_mask = mask then
                read_BITS_43_33_OF_LOC_DEV_MSG_6_value = data_low
            else
                read_BITS_43_33_OF_LOC_DEV_MSG_6_value = (data_low - H8000_0000) and BITS_43_33_OF_LOC_DEV_MSG_6_mask
            end If
        else
            read_BITS_43_33_OF_LOC_DEV_MSG_6_value = data_low and BITS_43_33_OF_LOC_DEV_MSG_6_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_BITS_43_33_OF_LOC_DEV_MSG_6_value = &H0
        flag_BITS_43_33_OF_LOC_DEV_MSG_6        = &H0
    End Sub
End Class


'' @REGISTER : CL45VEN_lnk_partnr_msg_6_a
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_6_OUI_MATCH                            [15:15]          get_MSG_6_OUI_MATCH
''                                                             set_MSG_6_OUI_MATCH
''                                                             read_MSG_6_OUI_MATCH
''                                                             write_MSG_6_OUI_MATCH
''---------------------------------------------------------------------------------
'' MSG_6_MODEL_MATCH                          [14:14]          get_MSG_6_MODEL_MATCH
''                                                             set_MSG_6_MODEL_MATCH
''                                                             read_MSG_6_MODEL_MATCH
''                                                             write_MSG_6_MODEL_MATCH
''---------------------------------------------------------------------------------
'' MSG_6_REV_MATCH                            [13:13]          get_MSG_6_REV_MATCH
''                                                             set_MSG_6_REV_MATCH
''                                                             read_MSG_6_REV_MATCH
''                                                             write_MSG_6_REV_MATCH
''---------------------------------------------------------------------------------
'' BITS_10_0_OF_LNK_PARTNR_MSG_6              [10:0]           get_BITS_10_0_OF_LNK_PARTNR_MSG_6
''                                                             set_BITS_10_0_OF_LNK_PARTNR_MSG_6
''                                                             read_BITS_10_0_OF_LNK_PARTNR_MSG_6
''                                                             write_BITS_10_0_OF_LNK_PARTNR_MSG_6
''---------------------------------------------------------------------------------
Class REGISTER_CL45VEN_lnk_partnr_msg_6_a
    Private write_MSG_6_OUI_MATCH_value
    Private read_MSG_6_OUI_MATCH_value
    Private flag_MSG_6_OUI_MATCH
    Private write_MSG_6_MODEL_MATCH_value
    Private read_MSG_6_MODEL_MATCH_value
    Private flag_MSG_6_MODEL_MATCH
    Private write_MSG_6_REV_MATCH_value
    Private read_MSG_6_REV_MATCH_value
    Private flag_MSG_6_REV_MATCH
    Private write_BITS_10_0_OF_LNK_PARTNR_MSG_6_value
    Private read_BITS_10_0_OF_LNK_PARTNR_MSG_6_value
    Private flag_BITS_10_0_OF_LNK_PARTNR_MSG_6

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

    Property Get get_MSG_6_OUI_MATCH
        get_MSG_6_OUI_MATCH = read_MSG_6_OUI_MATCH_value
    End Property

    Property Let set_MSG_6_OUI_MATCH(aData)
        write_MSG_6_OUI_MATCH_value = aData
        flag_MSG_6_OUI_MATCH        = &H1
    End Property

    Property Get read_MSG_6_OUI_MATCH
        read
        read_MSG_6_OUI_MATCH = read_MSG_6_OUI_MATCH_value
    End Property

    Property Let write_MSG_6_OUI_MATCH(aData)
        set_MSG_6_OUI_MATCH = aData
        write
    End Property

    Property Get get_MSG_6_MODEL_MATCH
        get_MSG_6_MODEL_MATCH = read_MSG_6_MODEL_MATCH_value
    End Property

    Property Let set_MSG_6_MODEL_MATCH(aData)
        write_MSG_6_MODEL_MATCH_value = aData
        flag_MSG_6_MODEL_MATCH        = &H1
    End Property

    Property Get read_MSG_6_MODEL_MATCH
        read
        read_MSG_6_MODEL_MATCH = read_MSG_6_MODEL_MATCH_value
    End Property

    Property Let write_MSG_6_MODEL_MATCH(aData)
        set_MSG_6_MODEL_MATCH = aData
        write
    End Property

    Property Get get_MSG_6_REV_MATCH
        get_MSG_6_REV_MATCH = read_MSG_6_REV_MATCH_value
    End Property

    Property Let set_MSG_6_REV_MATCH(aData)
        write_MSG_6_REV_MATCH_value = aData
        flag_MSG_6_REV_MATCH        = &H1
    End Property

    Property Get read_MSG_6_REV_MATCH
        read
        read_MSG_6_REV_MATCH = read_MSG_6_REV_MATCH_value
    End Property

    Property Let write_MSG_6_REV_MATCH(aData)
        set_MSG_6_REV_MATCH = aData
        write
    End Property

    Property Get get_BITS_10_0_OF_LNK_PARTNR_MSG_6
        get_BITS_10_0_OF_LNK_PARTNR_MSG_6 = read_BITS_10_0_OF_LNK_PARTNR_MSG_6_value
    End Property

    Property Let set_BITS_10_0_OF_LNK_PARTNR_MSG_6(aData)
        write_BITS_10_0_OF_LNK_PARTNR_MSG_6_value = aData
        flag_BITS_10_0_OF_LNK_PARTNR_MSG_6        = &H1
    End Property

    Property Get read_BITS_10_0_OF_LNK_PARTNR_MSG_6
        read
        read_BITS_10_0_OF_LNK_PARTNR_MSG_6 = read_BITS_10_0_OF_LNK_PARTNR_MSG_6_value
    End Property

    Property Let write_BITS_10_0_OF_LNK_PARTNR_MSG_6(aData)
        set_BITS_10_0_OF_LNK_PARTNR_MSG_6 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MSG_6_OUI_MATCH_value = rightShift(data_low, 15) and &H1
        read_MSG_6_MODEL_MATCH_value = rightShift(data_low, 14) and &H1
        read_MSG_6_REV_MATCH_value = rightShift(data_low, 13) and &H1
        BITS_10_0_OF_LNK_PARTNR_MSG_6_mask = &H7ff
        if data_low > LONG_MAX then
            if BITS_10_0_OF_LNK_PARTNR_MSG_6_mask = mask then
                read_BITS_10_0_OF_LNK_PARTNR_MSG_6_value = data_low
            else
                read_BITS_10_0_OF_LNK_PARTNR_MSG_6_value = (data_low - H8000_0000) and BITS_10_0_OF_LNK_PARTNR_MSG_6_mask
            end If
        else
            read_BITS_10_0_OF_LNK_PARTNR_MSG_6_value = data_low and BITS_10_0_OF_LNK_PARTNR_MSG_6_mask
        end If

    End Sub

    Sub write
        If flag_MSG_6_OUI_MATCH = &H0 or flag_MSG_6_MODEL_MATCH = &H0 or flag_MSG_6_REV_MATCH = &H0 or flag_BITS_10_0_OF_LNK_PARTNR_MSG_6 = &H0 Then read
        If flag_MSG_6_OUI_MATCH = &H0 Then write_MSG_6_OUI_MATCH_value = get_MSG_6_OUI_MATCH
        If flag_MSG_6_MODEL_MATCH = &H0 Then write_MSG_6_MODEL_MATCH_value = get_MSG_6_MODEL_MATCH
        If flag_MSG_6_REV_MATCH = &H0 Then write_MSG_6_REV_MATCH_value = get_MSG_6_REV_MATCH
        If flag_BITS_10_0_OF_LNK_PARTNR_MSG_6 = &H0 Then write_BITS_10_0_OF_LNK_PARTNR_MSG_6_value = get_BITS_10_0_OF_LNK_PARTNR_MSG_6

        regValue = leftShift((write_MSG_6_OUI_MATCH_value and &H1), 15) + leftShift((write_MSG_6_MODEL_MATCH_value and &H1), 14) + leftShift((write_MSG_6_REV_MATCH_value and &H1), 13) + leftShift((write_BITS_10_0_OF_LNK_PARTNR_MSG_6_value and &H7ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MSG_6_OUI_MATCH_value = rightShift(data_low, 15) and &H1
        read_MSG_6_MODEL_MATCH_value = rightShift(data_low, 14) and &H1
        read_MSG_6_REV_MATCH_value = rightShift(data_low, 13) and &H1
        BITS_10_0_OF_LNK_PARTNR_MSG_6_mask = &H7ff
        if data_low > LONG_MAX then
            if BITS_10_0_OF_LNK_PARTNR_MSG_6_mask = mask then
                read_BITS_10_0_OF_LNK_PARTNR_MSG_6_value = data_low
            else
                read_BITS_10_0_OF_LNK_PARTNR_MSG_6_value = (data_low - H8000_0000) and BITS_10_0_OF_LNK_PARTNR_MSG_6_mask
            end If
        else
            read_BITS_10_0_OF_LNK_PARTNR_MSG_6_value = data_low and BITS_10_0_OF_LNK_PARTNR_MSG_6_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_6_OUI_MATCH_value = &H0
        flag_MSG_6_OUI_MATCH        = &H0
        write_MSG_6_MODEL_MATCH_value = &H0
        flag_MSG_6_MODEL_MATCH        = &H0
        write_MSG_6_REV_MATCH_value = &H0
        flag_MSG_6_REV_MATCH        = &H0
        write_BITS_10_0_OF_LNK_PARTNR_MSG_6_value = &H0
        flag_BITS_10_0_OF_LNK_PARTNR_MSG_6        = &H0
    End Sub
End Class


'' @REGISTER : CL45VEN_lnk_partnr_msg_6_b
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' BITS_21_11_OF_LNK_PARTNR_MSG_6             [10:0]           get_BITS_21_11_OF_LNK_PARTNR_MSG_6
''                                                             set_BITS_21_11_OF_LNK_PARTNR_MSG_6
''                                                             read_BITS_21_11_OF_LNK_PARTNR_MSG_6
''                                                             write_BITS_21_11_OF_LNK_PARTNR_MSG_6
''---------------------------------------------------------------------------------
Class REGISTER_CL45VEN_lnk_partnr_msg_6_b
    Private write_BITS_21_11_OF_LNK_PARTNR_MSG_6_value
    Private read_BITS_21_11_OF_LNK_PARTNR_MSG_6_value
    Private flag_BITS_21_11_OF_LNK_PARTNR_MSG_6

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H9a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_BITS_21_11_OF_LNK_PARTNR_MSG_6
        get_BITS_21_11_OF_LNK_PARTNR_MSG_6 = read_BITS_21_11_OF_LNK_PARTNR_MSG_6_value
    End Property

    Property Let set_BITS_21_11_OF_LNK_PARTNR_MSG_6(aData)
        write_BITS_21_11_OF_LNK_PARTNR_MSG_6_value = aData
        flag_BITS_21_11_OF_LNK_PARTNR_MSG_6        = &H1
    End Property

    Property Get read_BITS_21_11_OF_LNK_PARTNR_MSG_6
        read
        read_BITS_21_11_OF_LNK_PARTNR_MSG_6 = read_BITS_21_11_OF_LNK_PARTNR_MSG_6_value
    End Property

    Property Let write_BITS_21_11_OF_LNK_PARTNR_MSG_6(aData)
        set_BITS_21_11_OF_LNK_PARTNR_MSG_6 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        BITS_21_11_OF_LNK_PARTNR_MSG_6_mask = &H7ff
        if data_low > LONG_MAX then
            if BITS_21_11_OF_LNK_PARTNR_MSG_6_mask = mask then
                read_BITS_21_11_OF_LNK_PARTNR_MSG_6_value = data_low
            else
                read_BITS_21_11_OF_LNK_PARTNR_MSG_6_value = (data_low - H8000_0000) and BITS_21_11_OF_LNK_PARTNR_MSG_6_mask
            end If
        else
            read_BITS_21_11_OF_LNK_PARTNR_MSG_6_value = data_low and BITS_21_11_OF_LNK_PARTNR_MSG_6_mask
        end If

    End Sub

    Sub write
        If flag_BITS_21_11_OF_LNK_PARTNR_MSG_6 = &H0 Then read
        If flag_BITS_21_11_OF_LNK_PARTNR_MSG_6 = &H0 Then write_BITS_21_11_OF_LNK_PARTNR_MSG_6_value = get_BITS_21_11_OF_LNK_PARTNR_MSG_6

        regValue = leftShift((write_BITS_21_11_OF_LNK_PARTNR_MSG_6_value and &H7ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        BITS_21_11_OF_LNK_PARTNR_MSG_6_mask = &H7ff
        if data_low > LONG_MAX then
            if BITS_21_11_OF_LNK_PARTNR_MSG_6_mask = mask then
                read_BITS_21_11_OF_LNK_PARTNR_MSG_6_value = data_low
            else
                read_BITS_21_11_OF_LNK_PARTNR_MSG_6_value = (data_low - H8000_0000) and BITS_21_11_OF_LNK_PARTNR_MSG_6_mask
            end If
        else
            read_BITS_21_11_OF_LNK_PARTNR_MSG_6_value = data_low and BITS_21_11_OF_LNK_PARTNR_MSG_6_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_BITS_21_11_OF_LNK_PARTNR_MSG_6_value = &H0
        flag_BITS_21_11_OF_LNK_PARTNR_MSG_6        = &H0
    End Sub
End Class


'' @REGISTER : CL45VEN_lnk_partnr_msg_6_c
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' BITS_32_22_OF_LNK_PARTNR_MSG_6             [10:0]           get_BITS_32_22_OF_LNK_PARTNR_MSG_6
''                                                             set_BITS_32_22_OF_LNK_PARTNR_MSG_6
''                                                             read_BITS_32_22_OF_LNK_PARTNR_MSG_6
''                                                             write_BITS_32_22_OF_LNK_PARTNR_MSG_6
''---------------------------------------------------------------------------------
Class REGISTER_CL45VEN_lnk_partnr_msg_6_c
    Private write_BITS_32_22_OF_LNK_PARTNR_MSG_6_value
    Private read_BITS_32_22_OF_LNK_PARTNR_MSG_6_value
    Private flag_BITS_32_22_OF_LNK_PARTNR_MSG_6

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

    Property Get get_BITS_32_22_OF_LNK_PARTNR_MSG_6
        get_BITS_32_22_OF_LNK_PARTNR_MSG_6 = read_BITS_32_22_OF_LNK_PARTNR_MSG_6_value
    End Property

    Property Let set_BITS_32_22_OF_LNK_PARTNR_MSG_6(aData)
        write_BITS_32_22_OF_LNK_PARTNR_MSG_6_value = aData
        flag_BITS_32_22_OF_LNK_PARTNR_MSG_6        = &H1
    End Property

    Property Get read_BITS_32_22_OF_LNK_PARTNR_MSG_6
        read
        read_BITS_32_22_OF_LNK_PARTNR_MSG_6 = read_BITS_32_22_OF_LNK_PARTNR_MSG_6_value
    End Property

    Property Let write_BITS_32_22_OF_LNK_PARTNR_MSG_6(aData)
        set_BITS_32_22_OF_LNK_PARTNR_MSG_6 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        BITS_32_22_OF_LNK_PARTNR_MSG_6_mask = &H7ff
        if data_low > LONG_MAX then
            if BITS_32_22_OF_LNK_PARTNR_MSG_6_mask = mask then
                read_BITS_32_22_OF_LNK_PARTNR_MSG_6_value = data_low
            else
                read_BITS_32_22_OF_LNK_PARTNR_MSG_6_value = (data_low - H8000_0000) and BITS_32_22_OF_LNK_PARTNR_MSG_6_mask
            end If
        else
            read_BITS_32_22_OF_LNK_PARTNR_MSG_6_value = data_low and BITS_32_22_OF_LNK_PARTNR_MSG_6_mask
        end If

    End Sub

    Sub write
        If flag_BITS_32_22_OF_LNK_PARTNR_MSG_6 = &H0 Then read
        If flag_BITS_32_22_OF_LNK_PARTNR_MSG_6 = &H0 Then write_BITS_32_22_OF_LNK_PARTNR_MSG_6_value = get_BITS_32_22_OF_LNK_PARTNR_MSG_6

        regValue = leftShift((write_BITS_32_22_OF_LNK_PARTNR_MSG_6_value and &H7ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        BITS_32_22_OF_LNK_PARTNR_MSG_6_mask = &H7ff
        if data_low > LONG_MAX then
            if BITS_32_22_OF_LNK_PARTNR_MSG_6_mask = mask then
                read_BITS_32_22_OF_LNK_PARTNR_MSG_6_value = data_low
            else
                read_BITS_32_22_OF_LNK_PARTNR_MSG_6_value = (data_low - H8000_0000) and BITS_32_22_OF_LNK_PARTNR_MSG_6_mask
            end If
        else
            read_BITS_32_22_OF_LNK_PARTNR_MSG_6_value = data_low and BITS_32_22_OF_LNK_PARTNR_MSG_6_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_BITS_32_22_OF_LNK_PARTNR_MSG_6_value = &H0
        flag_BITS_32_22_OF_LNK_PARTNR_MSG_6        = &H0
    End Sub
End Class


'' @REGISTER : CL45VEN_lnk_partnr_msg_6_d
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' BITS_43_33_OF_LNK_PARTNR_MSG_6             [10:0]           get_BITS_43_33_OF_LNK_PARTNR_MSG_6
''                                                             set_BITS_43_33_OF_LNK_PARTNR_MSG_6
''                                                             read_BITS_43_33_OF_LNK_PARTNR_MSG_6
''                                                             write_BITS_43_33_OF_LNK_PARTNR_MSG_6
''---------------------------------------------------------------------------------
Class REGISTER_CL45VEN_lnk_partnr_msg_6_d
    Private write_BITS_43_33_OF_LNK_PARTNR_MSG_6_value
    Private read_BITS_43_33_OF_LNK_PARTNR_MSG_6_value
    Private flag_BITS_43_33_OF_LNK_PARTNR_MSG_6

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H9e
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_BITS_43_33_OF_LNK_PARTNR_MSG_6
        get_BITS_43_33_OF_LNK_PARTNR_MSG_6 = read_BITS_43_33_OF_LNK_PARTNR_MSG_6_value
    End Property

    Property Let set_BITS_43_33_OF_LNK_PARTNR_MSG_6(aData)
        write_BITS_43_33_OF_LNK_PARTNR_MSG_6_value = aData
        flag_BITS_43_33_OF_LNK_PARTNR_MSG_6        = &H1
    End Property

    Property Get read_BITS_43_33_OF_LNK_PARTNR_MSG_6
        read
        read_BITS_43_33_OF_LNK_PARTNR_MSG_6 = read_BITS_43_33_OF_LNK_PARTNR_MSG_6_value
    End Property

    Property Let write_BITS_43_33_OF_LNK_PARTNR_MSG_6(aData)
        set_BITS_43_33_OF_LNK_PARTNR_MSG_6 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        BITS_43_33_OF_LNK_PARTNR_MSG_6_mask = &H7ff
        if data_low > LONG_MAX then
            if BITS_43_33_OF_LNK_PARTNR_MSG_6_mask = mask then
                read_BITS_43_33_OF_LNK_PARTNR_MSG_6_value = data_low
            else
                read_BITS_43_33_OF_LNK_PARTNR_MSG_6_value = (data_low - H8000_0000) and BITS_43_33_OF_LNK_PARTNR_MSG_6_mask
            end If
        else
            read_BITS_43_33_OF_LNK_PARTNR_MSG_6_value = data_low and BITS_43_33_OF_LNK_PARTNR_MSG_6_mask
        end If

    End Sub

    Sub write
        If flag_BITS_43_33_OF_LNK_PARTNR_MSG_6 = &H0 Then read
        If flag_BITS_43_33_OF_LNK_PARTNR_MSG_6 = &H0 Then write_BITS_43_33_OF_LNK_PARTNR_MSG_6_value = get_BITS_43_33_OF_LNK_PARTNR_MSG_6

        regValue = leftShift((write_BITS_43_33_OF_LNK_PARTNR_MSG_6_value and &H7ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        BITS_43_33_OF_LNK_PARTNR_MSG_6_mask = &H7ff
        if data_low > LONG_MAX then
            if BITS_43_33_OF_LNK_PARTNR_MSG_6_mask = mask then
                read_BITS_43_33_OF_LNK_PARTNR_MSG_6_value = data_low
            else
                read_BITS_43_33_OF_LNK_PARTNR_MSG_6_value = (data_low - H8000_0000) and BITS_43_33_OF_LNK_PARTNR_MSG_6_mask
            end If
        else
            read_BITS_43_33_OF_LNK_PARTNR_MSG_6_value = data_low and BITS_43_33_OF_LNK_PARTNR_MSG_6_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_BITS_43_33_OF_LNK_PARTNR_MSG_6_value = &H0
        flag_BITS_43_33_OF_LNK_PARTNR_MSG_6        = &H0
    End Sub
End Class


'' @REGISTER : CL45VEN_an_msg_9_selector
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_9_5G_SELECTOR                          [15:11]          get_MSG_9_5G_SELECTOR
''                                                             set_MSG_9_5G_SELECTOR
''                                                             read_MSG_9_5G_SELECTOR
''                                                             write_MSG_9_5G_SELECTOR
''---------------------------------------------------------------------------------
'' MSG_9_2P5G_SELECTOR                        [10:6]           get_MSG_9_2P5G_SELECTOR
''                                                             set_MSG_9_2P5G_SELECTOR
''                                                             read_MSG_9_2P5G_SELECTOR
''                                                             write_MSG_9_2P5G_SELECTOR
''---------------------------------------------------------------------------------
'' MSG_9_CODE                                 [5:0]            get_MSG_9_CODE
''                                                             set_MSG_9_CODE
''                                                             read_MSG_9_CODE
''                                                             write_MSG_9_CODE
''---------------------------------------------------------------------------------
Class REGISTER_CL45VEN_an_msg_9_selector
    Private write_MSG_9_5G_SELECTOR_value
    Private read_MSG_9_5G_SELECTOR_value
    Private flag_MSG_9_5G_SELECTOR
    Private write_MSG_9_2P5G_SELECTOR_value
    Private read_MSG_9_2P5G_SELECTOR_value
    Private flag_MSG_9_2P5G_SELECTOR
    Private write_MSG_9_CODE_value
    Private read_MSG_9_CODE_value
    Private flag_MSG_9_CODE

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

    Property Get get_MSG_9_5G_SELECTOR
        get_MSG_9_5G_SELECTOR = read_MSG_9_5G_SELECTOR_value
    End Property

    Property Let set_MSG_9_5G_SELECTOR(aData)
        write_MSG_9_5G_SELECTOR_value = aData
        flag_MSG_9_5G_SELECTOR        = &H1
    End Property

    Property Get read_MSG_9_5G_SELECTOR
        read
        read_MSG_9_5G_SELECTOR = read_MSG_9_5G_SELECTOR_value
    End Property

    Property Let write_MSG_9_5G_SELECTOR(aData)
        set_MSG_9_5G_SELECTOR = aData
        write
    End Property

    Property Get get_MSG_9_2P5G_SELECTOR
        get_MSG_9_2P5G_SELECTOR = read_MSG_9_2P5G_SELECTOR_value
    End Property

    Property Let set_MSG_9_2P5G_SELECTOR(aData)
        write_MSG_9_2P5G_SELECTOR_value = aData
        flag_MSG_9_2P5G_SELECTOR        = &H1
    End Property

    Property Get read_MSG_9_2P5G_SELECTOR
        read
        read_MSG_9_2P5G_SELECTOR = read_MSG_9_2P5G_SELECTOR_value
    End Property

    Property Let write_MSG_9_2P5G_SELECTOR(aData)
        set_MSG_9_2P5G_SELECTOR = aData
        write
    End Property

    Property Get get_MSG_9_CODE
        get_MSG_9_CODE = read_MSG_9_CODE_value
    End Property

    Property Let set_MSG_9_CODE(aData)
        write_MSG_9_CODE_value = aData
        flag_MSG_9_CODE        = &H1
    End Property

    Property Get read_MSG_9_CODE
        read
        read_MSG_9_CODE = read_MSG_9_CODE_value
    End Property

    Property Let write_MSG_9_CODE(aData)
        set_MSG_9_CODE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MSG_9_5G_SELECTOR_value = rightShift(data_low, 11) and &H1f
        read_MSG_9_2P5G_SELECTOR_value = rightShift(data_low, 6) and &H1f
        MSG_9_CODE_mask = &H3f
        if data_low > LONG_MAX then
            if MSG_9_CODE_mask = mask then
                read_MSG_9_CODE_value = data_low
            else
                read_MSG_9_CODE_value = (data_low - H8000_0000) and MSG_9_CODE_mask
            end If
        else
            read_MSG_9_CODE_value = data_low and MSG_9_CODE_mask
        end If

    End Sub

    Sub write
        If flag_MSG_9_5G_SELECTOR = &H0 or flag_MSG_9_2P5G_SELECTOR = &H0 or flag_MSG_9_CODE = &H0 Then read
        If flag_MSG_9_5G_SELECTOR = &H0 Then write_MSG_9_5G_SELECTOR_value = get_MSG_9_5G_SELECTOR
        If flag_MSG_9_2P5G_SELECTOR = &H0 Then write_MSG_9_2P5G_SELECTOR_value = get_MSG_9_2P5G_SELECTOR
        If flag_MSG_9_CODE = &H0 Then write_MSG_9_CODE_value = get_MSG_9_CODE

        regValue = leftShift((write_MSG_9_5G_SELECTOR_value and &H1f), 11) + leftShift((write_MSG_9_2P5G_SELECTOR_value and &H1f), 6) + leftShift((write_MSG_9_CODE_value and &H3f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MSG_9_5G_SELECTOR_value = rightShift(data_low, 11) and &H1f
        read_MSG_9_2P5G_SELECTOR_value = rightShift(data_low, 6) and &H1f
        MSG_9_CODE_mask = &H3f
        if data_low > LONG_MAX then
            if MSG_9_CODE_mask = mask then
                read_MSG_9_CODE_value = data_low
            else
                read_MSG_9_CODE_value = (data_low - H8000_0000) and MSG_9_CODE_mask
            end If
        else
            read_MSG_9_CODE_value = data_low and MSG_9_CODE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_9_5G_SELECTOR_value = &H0
        flag_MSG_9_5G_SELECTOR        = &H0
        write_MSG_9_2P5G_SELECTOR_value = &H0
        flag_MSG_9_2P5G_SELECTOR        = &H0
        write_MSG_9_CODE_value = &H0
        flag_MSG_9_CODE        = &H0
    End Sub
End Class


'' @REGISTER : CL45VEN_an_msg_11_selector
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ECL2A5AF10AM9                              [14:14]          get_ECL2A5AF10AM9
''                                                             set_ECL2A5AF10AM9
''                                                             read_ECL2A5AF10AM9
''                                                             write_ECL2A5AF10AM9
''---------------------------------------------------------------------------------
'' ECL2A5AF10AM5                              [13:13]          get_ECL2A5AF10AM5
''                                                             set_ECL2A5AF10AM5
''                                                             read_ECL2A5AF10AM5
''                                                             write_ECL2A5AF10AM5
''---------------------------------------------------------------------------------
'' SETTINGS_FOR_MC11_UP1                      [12:6]           get_SETTINGS_FOR_MC11_UP1
''                                                             set_SETTINGS_FOR_MC11_UP1
''                                                             read_SETTINGS_FOR_MC11_UP1
''                                                             write_SETTINGS_FOR_MC11_UP1
''---------------------------------------------------------------------------------
'' MSG_11_CODE                                [5:0]            get_MSG_11_CODE
''                                                             set_MSG_11_CODE
''                                                             read_MSG_11_CODE
''                                                             write_MSG_11_CODE
''---------------------------------------------------------------------------------
Class REGISTER_CL45VEN_an_msg_11_selector
    Private write_ECL2A5AF10AM9_value
    Private read_ECL2A5AF10AM9_value
    Private flag_ECL2A5AF10AM9
    Private write_ECL2A5AF10AM5_value
    Private read_ECL2A5AF10AM5_value
    Private flag_ECL2A5AF10AM5
    Private write_SETTINGS_FOR_MC11_UP1_value
    Private read_SETTINGS_FOR_MC11_UP1_value
    Private flag_SETTINGS_FOR_MC11_UP1
    Private write_MSG_11_CODE_value
    Private read_MSG_11_CODE_value
    Private flag_MSG_11_CODE

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Ha2
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ECL2A5AF10AM9
        get_ECL2A5AF10AM9 = read_ECL2A5AF10AM9_value
    End Property

    Property Let set_ECL2A5AF10AM9(aData)
        write_ECL2A5AF10AM9_value = aData
        flag_ECL2A5AF10AM9        = &H1
    End Property

    Property Get read_ECL2A5AF10AM9
        read
        read_ECL2A5AF10AM9 = read_ECL2A5AF10AM9_value
    End Property

    Property Let write_ECL2A5AF10AM9(aData)
        set_ECL2A5AF10AM9 = aData
        write
    End Property

    Property Get get_ECL2A5AF10AM5
        get_ECL2A5AF10AM5 = read_ECL2A5AF10AM5_value
    End Property

    Property Let set_ECL2A5AF10AM5(aData)
        write_ECL2A5AF10AM5_value = aData
        flag_ECL2A5AF10AM5        = &H1
    End Property

    Property Get read_ECL2A5AF10AM5
        read
        read_ECL2A5AF10AM5 = read_ECL2A5AF10AM5_value
    End Property

    Property Let write_ECL2A5AF10AM5(aData)
        set_ECL2A5AF10AM5 = aData
        write
    End Property

    Property Get get_SETTINGS_FOR_MC11_UP1
        get_SETTINGS_FOR_MC11_UP1 = read_SETTINGS_FOR_MC11_UP1_value
    End Property

    Property Let set_SETTINGS_FOR_MC11_UP1(aData)
        write_SETTINGS_FOR_MC11_UP1_value = aData
        flag_SETTINGS_FOR_MC11_UP1        = &H1
    End Property

    Property Get read_SETTINGS_FOR_MC11_UP1
        read
        read_SETTINGS_FOR_MC11_UP1 = read_SETTINGS_FOR_MC11_UP1_value
    End Property

    Property Let write_SETTINGS_FOR_MC11_UP1(aData)
        set_SETTINGS_FOR_MC11_UP1 = aData
        write
    End Property

    Property Get get_MSG_11_CODE
        get_MSG_11_CODE = read_MSG_11_CODE_value
    End Property

    Property Let set_MSG_11_CODE(aData)
        write_MSG_11_CODE_value = aData
        flag_MSG_11_CODE        = &H1
    End Property

    Property Get read_MSG_11_CODE
        read
        read_MSG_11_CODE = read_MSG_11_CODE_value
    End Property

    Property Let write_MSG_11_CODE(aData)
        set_MSG_11_CODE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ECL2A5AF10AM9_value = rightShift(data_low, 14) and &H1
        read_ECL2A5AF10AM5_value = rightShift(data_low, 13) and &H1
        read_SETTINGS_FOR_MC11_UP1_value = rightShift(data_low, 6) and &H7f
        MSG_11_CODE_mask = &H3f
        if data_low > LONG_MAX then
            if MSG_11_CODE_mask = mask then
                read_MSG_11_CODE_value = data_low
            else
                read_MSG_11_CODE_value = (data_low - H8000_0000) and MSG_11_CODE_mask
            end If
        else
            read_MSG_11_CODE_value = data_low and MSG_11_CODE_mask
        end If

    End Sub

    Sub write
        If flag_ECL2A5AF10AM9 = &H0 or flag_ECL2A5AF10AM5 = &H0 or flag_SETTINGS_FOR_MC11_UP1 = &H0 or flag_MSG_11_CODE = &H0 Then read
        If flag_ECL2A5AF10AM9 = &H0 Then write_ECL2A5AF10AM9_value = get_ECL2A5AF10AM9
        If flag_ECL2A5AF10AM5 = &H0 Then write_ECL2A5AF10AM5_value = get_ECL2A5AF10AM5
        If flag_SETTINGS_FOR_MC11_UP1 = &H0 Then write_SETTINGS_FOR_MC11_UP1_value = get_SETTINGS_FOR_MC11_UP1
        If flag_MSG_11_CODE = &H0 Then write_MSG_11_CODE_value = get_MSG_11_CODE

        regValue = leftShift((write_ECL2A5AF10AM9_value and &H1), 14) + leftShift((write_ECL2A5AF10AM5_value and &H1), 13) + leftShift((write_SETTINGS_FOR_MC11_UP1_value and &H7f), 6) + leftShift((write_MSG_11_CODE_value and &H3f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ECL2A5AF10AM9_value = rightShift(data_low, 14) and &H1
        read_ECL2A5AF10AM5_value = rightShift(data_low, 13) and &H1
        read_SETTINGS_FOR_MC11_UP1_value = rightShift(data_low, 6) and &H7f
        MSG_11_CODE_mask = &H3f
        if data_low > LONG_MAX then
            if MSG_11_CODE_mask = mask then
                read_MSG_11_CODE_value = data_low
            else
                read_MSG_11_CODE_value = (data_low - H8000_0000) and MSG_11_CODE_mask
            end If
        else
            read_MSG_11_CODE_value = data_low and MSG_11_CODE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ECL2A5AF10AM9_value = &H0
        flag_ECL2A5AF10AM9        = &H0
        write_ECL2A5AF10AM5_value = &H0
        flag_ECL2A5AF10AM5        = &H0
        write_SETTINGS_FOR_MC11_UP1_value = &H0
        flag_SETTINGS_FOR_MC11_UP1        = &H0
        write_MSG_11_CODE_value = &H0
        flag_MSG_11_CODE        = &H0
    End Sub
End Class


'' @REGISTER : CL45VEN_an_msg_11_set_value_lsb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_11_SET_VALUE_LSB                       [15:0]           get_MSG_11_SET_VALUE_LSB
''                                                             set_MSG_11_SET_VALUE_LSB
''                                                             read_MSG_11_SET_VALUE_LSB
''                                                             write_MSG_11_SET_VALUE_LSB
''---------------------------------------------------------------------------------
Class REGISTER_CL45VEN_an_msg_11_set_value_lsb
    Private write_MSG_11_SET_VALUE_LSB_value
    Private read_MSG_11_SET_VALUE_LSB_value
    Private flag_MSG_11_SET_VALUE_LSB

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

    Property Get get_MSG_11_SET_VALUE_LSB
        get_MSG_11_SET_VALUE_LSB = read_MSG_11_SET_VALUE_LSB_value
    End Property

    Property Let set_MSG_11_SET_VALUE_LSB(aData)
        write_MSG_11_SET_VALUE_LSB_value = aData
        flag_MSG_11_SET_VALUE_LSB        = &H1
    End Property

    Property Get read_MSG_11_SET_VALUE_LSB
        read
        read_MSG_11_SET_VALUE_LSB = read_MSG_11_SET_VALUE_LSB_value
    End Property

    Property Let write_MSG_11_SET_VALUE_LSB(aData)
        set_MSG_11_SET_VALUE_LSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_11_SET_VALUE_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if MSG_11_SET_VALUE_LSB_mask = mask then
                read_MSG_11_SET_VALUE_LSB_value = data_low
            else
                read_MSG_11_SET_VALUE_LSB_value = (data_low - H8000_0000) and MSG_11_SET_VALUE_LSB_mask
            end If
        else
            read_MSG_11_SET_VALUE_LSB_value = data_low and MSG_11_SET_VALUE_LSB_mask
        end If

    End Sub

    Sub write
        If flag_MSG_11_SET_VALUE_LSB = &H0 Then read
        If flag_MSG_11_SET_VALUE_LSB = &H0 Then write_MSG_11_SET_VALUE_LSB_value = get_MSG_11_SET_VALUE_LSB

        regValue = leftShift((write_MSG_11_SET_VALUE_LSB_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_11_SET_VALUE_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if MSG_11_SET_VALUE_LSB_mask = mask then
                read_MSG_11_SET_VALUE_LSB_value = data_low
            else
                read_MSG_11_SET_VALUE_LSB_value = (data_low - H8000_0000) and MSG_11_SET_VALUE_LSB_mask
            end If
        else
            read_MSG_11_SET_VALUE_LSB_value = data_low and MSG_11_SET_VALUE_LSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_11_SET_VALUE_LSB_value = &H0
        flag_MSG_11_SET_VALUE_LSB        = &H0
    End Sub
End Class


'' @REGISTER : CL45VEN_an_msg_11_set_value_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_11_SET_VALUE_MSB                       [15:0]           get_MSG_11_SET_VALUE_MSB
''                                                             set_MSG_11_SET_VALUE_MSB
''                                                             read_MSG_11_SET_VALUE_MSB
''                                                             write_MSG_11_SET_VALUE_MSB
''---------------------------------------------------------------------------------
Class REGISTER_CL45VEN_an_msg_11_set_value_msb
    Private write_MSG_11_SET_VALUE_MSB_value
    Private read_MSG_11_SET_VALUE_MSB_value
    Private flag_MSG_11_SET_VALUE_MSB

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Ha6
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_11_SET_VALUE_MSB
        get_MSG_11_SET_VALUE_MSB = read_MSG_11_SET_VALUE_MSB_value
    End Property

    Property Let set_MSG_11_SET_VALUE_MSB(aData)
        write_MSG_11_SET_VALUE_MSB_value = aData
        flag_MSG_11_SET_VALUE_MSB        = &H1
    End Property

    Property Get read_MSG_11_SET_VALUE_MSB
        read
        read_MSG_11_SET_VALUE_MSB = read_MSG_11_SET_VALUE_MSB_value
    End Property

    Property Let write_MSG_11_SET_VALUE_MSB(aData)
        set_MSG_11_SET_VALUE_MSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_11_SET_VALUE_MSB_mask = &Hffff
        if data_low > LONG_MAX then
            if MSG_11_SET_VALUE_MSB_mask = mask then
                read_MSG_11_SET_VALUE_MSB_value = data_low
            else
                read_MSG_11_SET_VALUE_MSB_value = (data_low - H8000_0000) and MSG_11_SET_VALUE_MSB_mask
            end If
        else
            read_MSG_11_SET_VALUE_MSB_value = data_low and MSG_11_SET_VALUE_MSB_mask
        end If

    End Sub

    Sub write
        If flag_MSG_11_SET_VALUE_MSB = &H0 Then read
        If flag_MSG_11_SET_VALUE_MSB = &H0 Then write_MSG_11_SET_VALUE_MSB_value = get_MSG_11_SET_VALUE_MSB

        regValue = leftShift((write_MSG_11_SET_VALUE_MSB_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_11_SET_VALUE_MSB_mask = &Hffff
        if data_low > LONG_MAX then
            if MSG_11_SET_VALUE_MSB_mask = mask then
                read_MSG_11_SET_VALUE_MSB_value = data_low
            else
                read_MSG_11_SET_VALUE_MSB_value = (data_low - H8000_0000) and MSG_11_SET_VALUE_MSB_mask
            end If
        else
            read_MSG_11_SET_VALUE_MSB_value = data_low and MSG_11_SET_VALUE_MSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_11_SET_VALUE_MSB_value = &H0
        flag_MSG_11_SET_VALUE_MSB        = &H0
    End Sub
End Class


'' @REGISTER : CL45VEN_an_msg_11_compare_fields_lsb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_11_COMPARE_FIELDS_LSB                  [15:0]           get_MSG_11_COMPARE_FIELDS_LSB
''                                                             set_MSG_11_COMPARE_FIELDS_LSB
''                                                             read_MSG_11_COMPARE_FIELDS_LSB
''                                                             write_MSG_11_COMPARE_FIELDS_LSB
''---------------------------------------------------------------------------------
Class REGISTER_CL45VEN_an_msg_11_compare_fields_lsb
    Private write_MSG_11_COMPARE_FIELDS_LSB_value
    Private read_MSG_11_COMPARE_FIELDS_LSB_value
    Private flag_MSG_11_COMPARE_FIELDS_LSB

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

    Property Get get_MSG_11_COMPARE_FIELDS_LSB
        get_MSG_11_COMPARE_FIELDS_LSB = read_MSG_11_COMPARE_FIELDS_LSB_value
    End Property

    Property Let set_MSG_11_COMPARE_FIELDS_LSB(aData)
        write_MSG_11_COMPARE_FIELDS_LSB_value = aData
        flag_MSG_11_COMPARE_FIELDS_LSB        = &H1
    End Property

    Property Get read_MSG_11_COMPARE_FIELDS_LSB
        read
        read_MSG_11_COMPARE_FIELDS_LSB = read_MSG_11_COMPARE_FIELDS_LSB_value
    End Property

    Property Let write_MSG_11_COMPARE_FIELDS_LSB(aData)
        set_MSG_11_COMPARE_FIELDS_LSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_11_COMPARE_FIELDS_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if MSG_11_COMPARE_FIELDS_LSB_mask = mask then
                read_MSG_11_COMPARE_FIELDS_LSB_value = data_low
            else
                read_MSG_11_COMPARE_FIELDS_LSB_value = (data_low - H8000_0000) and MSG_11_COMPARE_FIELDS_LSB_mask
            end If
        else
            read_MSG_11_COMPARE_FIELDS_LSB_value = data_low and MSG_11_COMPARE_FIELDS_LSB_mask
        end If

    End Sub

    Sub write
        If flag_MSG_11_COMPARE_FIELDS_LSB = &H0 Then read
        If flag_MSG_11_COMPARE_FIELDS_LSB = &H0 Then write_MSG_11_COMPARE_FIELDS_LSB_value = get_MSG_11_COMPARE_FIELDS_LSB

        regValue = leftShift((write_MSG_11_COMPARE_FIELDS_LSB_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_11_COMPARE_FIELDS_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if MSG_11_COMPARE_FIELDS_LSB_mask = mask then
                read_MSG_11_COMPARE_FIELDS_LSB_value = data_low
            else
                read_MSG_11_COMPARE_FIELDS_LSB_value = (data_low - H8000_0000) and MSG_11_COMPARE_FIELDS_LSB_mask
            end If
        else
            read_MSG_11_COMPARE_FIELDS_LSB_value = data_low and MSG_11_COMPARE_FIELDS_LSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_11_COMPARE_FIELDS_LSB_value = &H0
        flag_MSG_11_COMPARE_FIELDS_LSB        = &H0
    End Sub
End Class


'' @REGISTER : CL45VEN_an_msg_11_compare_fields_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSG_11_COMPARE_FIELDS_MSB                  [15:0]           get_MSG_11_COMPARE_FIELDS_MSB
''                                                             set_MSG_11_COMPARE_FIELDS_MSB
''                                                             read_MSG_11_COMPARE_FIELDS_MSB
''                                                             write_MSG_11_COMPARE_FIELDS_MSB
''---------------------------------------------------------------------------------
Class REGISTER_CL45VEN_an_msg_11_compare_fields_msb
    Private write_MSG_11_COMPARE_FIELDS_MSB_value
    Private read_MSG_11_COMPARE_FIELDS_MSB_value
    Private flag_MSG_11_COMPARE_FIELDS_MSB

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Haa
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_MSG_11_COMPARE_FIELDS_MSB
        get_MSG_11_COMPARE_FIELDS_MSB = read_MSG_11_COMPARE_FIELDS_MSB_value
    End Property

    Property Let set_MSG_11_COMPARE_FIELDS_MSB(aData)
        write_MSG_11_COMPARE_FIELDS_MSB_value = aData
        flag_MSG_11_COMPARE_FIELDS_MSB        = &H1
    End Property

    Property Get read_MSG_11_COMPARE_FIELDS_MSB
        read
        read_MSG_11_COMPARE_FIELDS_MSB = read_MSG_11_COMPARE_FIELDS_MSB_value
    End Property

    Property Let write_MSG_11_COMPARE_FIELDS_MSB(aData)
        set_MSG_11_COMPARE_FIELDS_MSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_11_COMPARE_FIELDS_MSB_mask = &Hffff
        if data_low > LONG_MAX then
            if MSG_11_COMPARE_FIELDS_MSB_mask = mask then
                read_MSG_11_COMPARE_FIELDS_MSB_value = data_low
            else
                read_MSG_11_COMPARE_FIELDS_MSB_value = (data_low - H8000_0000) and MSG_11_COMPARE_FIELDS_MSB_mask
            end If
        else
            read_MSG_11_COMPARE_FIELDS_MSB_value = data_low and MSG_11_COMPARE_FIELDS_MSB_mask
        end If

    End Sub

    Sub write
        If flag_MSG_11_COMPARE_FIELDS_MSB = &H0 Then read
        If flag_MSG_11_COMPARE_FIELDS_MSB = &H0 Then write_MSG_11_COMPARE_FIELDS_MSB_value = get_MSG_11_COMPARE_FIELDS_MSB

        regValue = leftShift((write_MSG_11_COMPARE_FIELDS_MSB_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSG_11_COMPARE_FIELDS_MSB_mask = &Hffff
        if data_low > LONG_MAX then
            if MSG_11_COMPARE_FIELDS_MSB_mask = mask then
                read_MSG_11_COMPARE_FIELDS_MSB_value = data_low
            else
                read_MSG_11_COMPARE_FIELDS_MSB_value = (data_low - H8000_0000) and MSG_11_COMPARE_FIELDS_MSB_mask
            end If
        else
            read_MSG_11_COMPARE_FIELDS_MSB_value = data_low and MSG_11_COMPARE_FIELDS_MSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSG_11_COMPARE_FIELDS_MSB_value = &H0
        flag_MSG_11_COMPARE_FIELDS_MSB        = &H0
    End Sub
End Class


'' @REGISTER : CL45VEN_link_fail_inhibit_timer_values_for_multispeed
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LFITVF10                                   [15:10]          get_LFITVF10
''                                                             set_LFITVF10
''                                                             read_LFITVF10
''                                                             write_LFITVF10
''---------------------------------------------------------------------------------
'' LFITVF5                                    [9:5]            get_LFITVF5
''                                                             set_LFITVF5
''                                                             read_LFITVF5
''                                                             write_LFITVF5
''---------------------------------------------------------------------------------
'' LFITVF25                                   [4:0]            get_LFITVF25
''                                                             set_LFITVF25
''                                                             read_LFITVF25
''                                                             write_LFITVF25
''---------------------------------------------------------------------------------
Class REGISTER_CL45VEN_link_fail_inhibit_timer_values_for_multispeed
    Private write_LFITVF10_value
    Private read_LFITVF10_value
    Private flag_LFITVF10
    Private write_LFITVF5_value
    Private read_LFITVF5_value
    Private flag_LFITVF5
    Private write_LFITVF25_value
    Private read_LFITVF25_value
    Private flag_LFITVF25

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

    Property Get get_LFITVF10
        get_LFITVF10 = read_LFITVF10_value
    End Property

    Property Let set_LFITVF10(aData)
        write_LFITVF10_value = aData
        flag_LFITVF10        = &H1
    End Property

    Property Get read_LFITVF10
        read
        read_LFITVF10 = read_LFITVF10_value
    End Property

    Property Let write_LFITVF10(aData)
        set_LFITVF10 = aData
        write
    End Property

    Property Get get_LFITVF5
        get_LFITVF5 = read_LFITVF5_value
    End Property

    Property Let set_LFITVF5(aData)
        write_LFITVF5_value = aData
        flag_LFITVF5        = &H1
    End Property

    Property Get read_LFITVF5
        read
        read_LFITVF5 = read_LFITVF5_value
    End Property

    Property Let write_LFITVF5(aData)
        set_LFITVF5 = aData
        write
    End Property

    Property Get get_LFITVF25
        get_LFITVF25 = read_LFITVF25_value
    End Property

    Property Let set_LFITVF25(aData)
        write_LFITVF25_value = aData
        flag_LFITVF25        = &H1
    End Property

    Property Get read_LFITVF25
        read
        read_LFITVF25 = read_LFITVF25_value
    End Property

    Property Let write_LFITVF25(aData)
        set_LFITVF25 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LFITVF10_value = rightShift(data_low, 10) and &H3f
        read_LFITVF5_value = rightShift(data_low, 5) and &H1f
        LFITVF25_mask = &H1f
        if data_low > LONG_MAX then
            if LFITVF25_mask = mask then
                read_LFITVF25_value = data_low
            else
                read_LFITVF25_value = (data_low - H8000_0000) and LFITVF25_mask
            end If
        else
            read_LFITVF25_value = data_low and LFITVF25_mask
        end If

    End Sub

    Sub write
        If flag_LFITVF10 = &H0 or flag_LFITVF5 = &H0 or flag_LFITVF25 = &H0 Then read
        If flag_LFITVF10 = &H0 Then write_LFITVF10_value = get_LFITVF10
        If flag_LFITVF5 = &H0 Then write_LFITVF5_value = get_LFITVF5
        If flag_LFITVF25 = &H0 Then write_LFITVF25_value = get_LFITVF25

        regValue = leftShift((write_LFITVF10_value and &H3f), 10) + leftShift((write_LFITVF5_value and &H1f), 5) + leftShift((write_LFITVF25_value and &H1f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LFITVF10_value = rightShift(data_low, 10) and &H3f
        read_LFITVF5_value = rightShift(data_low, 5) and &H1f
        LFITVF25_mask = &H1f
        if data_low > LONG_MAX then
            if LFITVF25_mask = mask then
                read_LFITVF25_value = data_low
            else
                read_LFITVF25_value = (data_low - H8000_0000) and LFITVF25_mask
            end If
        else
            read_LFITVF25_value = data_low and LFITVF25_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LFITVF10_value = &H0
        flag_LFITVF10        = &H0
        write_LFITVF5_value = &H0
        flag_LFITVF5        = &H0
        write_LFITVF25_value = &H0
        flag_LFITVF25        = &H0
    End Sub
End Class


'' @REGISTER : CL45VEN_hcd_override_from_firmware
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' HCD_OVERRIDE_ENABLE                        [15:15]          get_HCD_OVERRIDE_ENABLE
''                                                             set_HCD_OVERRIDE_ENABLE
''                                                             read_HCD_OVERRIDE_ENABLE
''                                                             write_HCD_OVERRIDE_ENABLE
''---------------------------------------------------------------------------------
'' HCD_OVERRIDE_MASK                          [14:14]          get_HCD_OVERRIDE_MASK
''                                                             set_HCD_OVERRIDE_MASK
''                                                             read_HCD_OVERRIDE_MASK
''                                                             write_HCD_OVERRIDE_MASK
''---------------------------------------------------------------------------------
'' HCD_OVERRIDE_TRIGGER_INDICATION            [13:13]          get_HCD_OVERRIDE_TRIGGER_INDICATION
''                                                             set_HCD_OVERRIDE_TRIGGER_INDICATION
''                                                             read_HCD_OVERRIDE_TRIGGER_INDICATION
''                                                             write_HCD_OVERRIDE_TRIGGER_INDICATION
''---------------------------------------------------------------------------------
'' BRAKE_LINK_TIMER_VALUES                    [12:8]           get_BRAKE_LINK_TIMER_VALUES
''                                                             set_BRAKE_LINK_TIMER_VALUES
''                                                             read_BRAKE_LINK_TIMER_VALUES
''                                                             write_BRAKE_LINK_TIMER_VALUES
''---------------------------------------------------------------------------------
'' BRAKE_LINK_TIMER_SLOW_DOWN                 [7:7]            get_BRAKE_LINK_TIMER_SLOW_DOWN
''                                                             set_BRAKE_LINK_TIMER_SLOW_DOWN
''                                                             read_BRAKE_LINK_TIMER_SLOW_DOWN
''                                                             write_BRAKE_LINK_TIMER_SLOW_DOWN
''---------------------------------------------------------------------------------
'' HCD_OVERRIDE_VALUE                         [3:0]            get_HCD_OVERRIDE_VALUE
''                                                             set_HCD_OVERRIDE_VALUE
''                                                             read_HCD_OVERRIDE_VALUE
''                                                             write_HCD_OVERRIDE_VALUE
''---------------------------------------------------------------------------------
Class REGISTER_CL45VEN_hcd_override_from_firmware
    Private write_HCD_OVERRIDE_ENABLE_value
    Private read_HCD_OVERRIDE_ENABLE_value
    Private flag_HCD_OVERRIDE_ENABLE
    Private write_HCD_OVERRIDE_MASK_value
    Private read_HCD_OVERRIDE_MASK_value
    Private flag_HCD_OVERRIDE_MASK
    Private write_HCD_OVERRIDE_TRIGGER_INDICATION_value
    Private read_HCD_OVERRIDE_TRIGGER_INDICATION_value
    Private flag_HCD_OVERRIDE_TRIGGER_INDICATION
    Private write_BRAKE_LINK_TIMER_VALUES_value
    Private read_BRAKE_LINK_TIMER_VALUES_value
    Private flag_BRAKE_LINK_TIMER_VALUES
    Private write_BRAKE_LINK_TIMER_SLOW_DOWN_value
    Private read_BRAKE_LINK_TIMER_SLOW_DOWN_value
    Private flag_BRAKE_LINK_TIMER_SLOW_DOWN
    Private write_HCD_OVERRIDE_VALUE_value
    Private read_HCD_OVERRIDE_VALUE_value
    Private flag_HCD_OVERRIDE_VALUE

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hae
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_HCD_OVERRIDE_ENABLE
        get_HCD_OVERRIDE_ENABLE = read_HCD_OVERRIDE_ENABLE_value
    End Property

    Property Let set_HCD_OVERRIDE_ENABLE(aData)
        write_HCD_OVERRIDE_ENABLE_value = aData
        flag_HCD_OVERRIDE_ENABLE        = &H1
    End Property

    Property Get read_HCD_OVERRIDE_ENABLE
        read
        read_HCD_OVERRIDE_ENABLE = read_HCD_OVERRIDE_ENABLE_value
    End Property

    Property Let write_HCD_OVERRIDE_ENABLE(aData)
        set_HCD_OVERRIDE_ENABLE = aData
        write
    End Property

    Property Get get_HCD_OVERRIDE_MASK
        get_HCD_OVERRIDE_MASK = read_HCD_OVERRIDE_MASK_value
    End Property

    Property Let set_HCD_OVERRIDE_MASK(aData)
        write_HCD_OVERRIDE_MASK_value = aData
        flag_HCD_OVERRIDE_MASK        = &H1
    End Property

    Property Get read_HCD_OVERRIDE_MASK
        read
        read_HCD_OVERRIDE_MASK = read_HCD_OVERRIDE_MASK_value
    End Property

    Property Let write_HCD_OVERRIDE_MASK(aData)
        set_HCD_OVERRIDE_MASK = aData
        write
    End Property

    Property Get get_HCD_OVERRIDE_TRIGGER_INDICATION
        get_HCD_OVERRIDE_TRIGGER_INDICATION = read_HCD_OVERRIDE_TRIGGER_INDICATION_value
    End Property

    Property Let set_HCD_OVERRIDE_TRIGGER_INDICATION(aData)
        write_HCD_OVERRIDE_TRIGGER_INDICATION_value = aData
        flag_HCD_OVERRIDE_TRIGGER_INDICATION        = &H1
    End Property

    Property Get read_HCD_OVERRIDE_TRIGGER_INDICATION
        read
        read_HCD_OVERRIDE_TRIGGER_INDICATION = read_HCD_OVERRIDE_TRIGGER_INDICATION_value
    End Property

    Property Let write_HCD_OVERRIDE_TRIGGER_INDICATION(aData)
        set_HCD_OVERRIDE_TRIGGER_INDICATION = aData
        write
    End Property

    Property Get get_BRAKE_LINK_TIMER_VALUES
        get_BRAKE_LINK_TIMER_VALUES = read_BRAKE_LINK_TIMER_VALUES_value
    End Property

    Property Let set_BRAKE_LINK_TIMER_VALUES(aData)
        write_BRAKE_LINK_TIMER_VALUES_value = aData
        flag_BRAKE_LINK_TIMER_VALUES        = &H1
    End Property

    Property Get read_BRAKE_LINK_TIMER_VALUES
        read
        read_BRAKE_LINK_TIMER_VALUES = read_BRAKE_LINK_TIMER_VALUES_value
    End Property

    Property Let write_BRAKE_LINK_TIMER_VALUES(aData)
        set_BRAKE_LINK_TIMER_VALUES = aData
        write
    End Property

    Property Get get_BRAKE_LINK_TIMER_SLOW_DOWN
        get_BRAKE_LINK_TIMER_SLOW_DOWN = read_BRAKE_LINK_TIMER_SLOW_DOWN_value
    End Property

    Property Let set_BRAKE_LINK_TIMER_SLOW_DOWN(aData)
        write_BRAKE_LINK_TIMER_SLOW_DOWN_value = aData
        flag_BRAKE_LINK_TIMER_SLOW_DOWN        = &H1
    End Property

    Property Get read_BRAKE_LINK_TIMER_SLOW_DOWN
        read
        read_BRAKE_LINK_TIMER_SLOW_DOWN = read_BRAKE_LINK_TIMER_SLOW_DOWN_value
    End Property

    Property Let write_BRAKE_LINK_TIMER_SLOW_DOWN(aData)
        set_BRAKE_LINK_TIMER_SLOW_DOWN = aData
        write
    End Property

    Property Get get_HCD_OVERRIDE_VALUE
        get_HCD_OVERRIDE_VALUE = read_HCD_OVERRIDE_VALUE_value
    End Property

    Property Let set_HCD_OVERRIDE_VALUE(aData)
        write_HCD_OVERRIDE_VALUE_value = aData
        flag_HCD_OVERRIDE_VALUE        = &H1
    End Property

    Property Get read_HCD_OVERRIDE_VALUE
        read
        read_HCD_OVERRIDE_VALUE = read_HCD_OVERRIDE_VALUE_value
    End Property

    Property Let write_HCD_OVERRIDE_VALUE(aData)
        set_HCD_OVERRIDE_VALUE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_HCD_OVERRIDE_ENABLE_value = rightShift(data_low, 15) and &H1
        read_HCD_OVERRIDE_MASK_value = rightShift(data_low, 14) and &H1
        read_HCD_OVERRIDE_TRIGGER_INDICATION_value = rightShift(data_low, 13) and &H1
        read_BRAKE_LINK_TIMER_VALUES_value = rightShift(data_low, 8) and &H1f
        read_BRAKE_LINK_TIMER_SLOW_DOWN_value = rightShift(data_low, 7) and &H1
        HCD_OVERRIDE_VALUE_mask = &Hf
        if data_low > LONG_MAX then
            if HCD_OVERRIDE_VALUE_mask = mask then
                read_HCD_OVERRIDE_VALUE_value = data_low
            else
                read_HCD_OVERRIDE_VALUE_value = (data_low - H8000_0000) and HCD_OVERRIDE_VALUE_mask
            end If
        else
            read_HCD_OVERRIDE_VALUE_value = data_low and HCD_OVERRIDE_VALUE_mask
        end If

    End Sub

    Sub write
        If flag_HCD_OVERRIDE_ENABLE = &H0 or flag_HCD_OVERRIDE_MASK = &H0 or flag_HCD_OVERRIDE_TRIGGER_INDICATION = &H0 or flag_BRAKE_LINK_TIMER_VALUES = &H0 or flag_BRAKE_LINK_TIMER_SLOW_DOWN = &H0 or flag_HCD_OVERRIDE_VALUE = &H0 Then read
        If flag_HCD_OVERRIDE_ENABLE = &H0 Then write_HCD_OVERRIDE_ENABLE_value = get_HCD_OVERRIDE_ENABLE
        If flag_HCD_OVERRIDE_MASK = &H0 Then write_HCD_OVERRIDE_MASK_value = get_HCD_OVERRIDE_MASK
        If flag_HCD_OVERRIDE_TRIGGER_INDICATION = &H0 Then write_HCD_OVERRIDE_TRIGGER_INDICATION_value = get_HCD_OVERRIDE_TRIGGER_INDICATION
        If flag_BRAKE_LINK_TIMER_VALUES = &H0 Then write_BRAKE_LINK_TIMER_VALUES_value = get_BRAKE_LINK_TIMER_VALUES
        If flag_BRAKE_LINK_TIMER_SLOW_DOWN = &H0 Then write_BRAKE_LINK_TIMER_SLOW_DOWN_value = get_BRAKE_LINK_TIMER_SLOW_DOWN
        If flag_HCD_OVERRIDE_VALUE = &H0 Then write_HCD_OVERRIDE_VALUE_value = get_HCD_OVERRIDE_VALUE

        regValue = leftShift((write_HCD_OVERRIDE_ENABLE_value and &H1), 15) + leftShift((write_HCD_OVERRIDE_MASK_value and &H1), 14) + leftShift((write_HCD_OVERRIDE_TRIGGER_INDICATION_value and &H1), 13) + leftShift((write_BRAKE_LINK_TIMER_VALUES_value and &H1f), 8) + leftShift((write_BRAKE_LINK_TIMER_SLOW_DOWN_value and &H1), 7) + leftShift((write_HCD_OVERRIDE_VALUE_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_HCD_OVERRIDE_ENABLE_value = rightShift(data_low, 15) and &H1
        read_HCD_OVERRIDE_MASK_value = rightShift(data_low, 14) and &H1
        read_HCD_OVERRIDE_TRIGGER_INDICATION_value = rightShift(data_low, 13) and &H1
        read_BRAKE_LINK_TIMER_VALUES_value = rightShift(data_low, 8) and &H1f
        read_BRAKE_LINK_TIMER_SLOW_DOWN_value = rightShift(data_low, 7) and &H1
        HCD_OVERRIDE_VALUE_mask = &Hf
        if data_low > LONG_MAX then
            if HCD_OVERRIDE_VALUE_mask = mask then
                read_HCD_OVERRIDE_VALUE_value = data_low
            else
                read_HCD_OVERRIDE_VALUE_value = (data_low - H8000_0000) and HCD_OVERRIDE_VALUE_mask
            end If
        else
            read_HCD_OVERRIDE_VALUE_value = data_low and HCD_OVERRIDE_VALUE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_HCD_OVERRIDE_ENABLE_value = &H0
        flag_HCD_OVERRIDE_ENABLE        = &H0
        write_HCD_OVERRIDE_MASK_value = &H0
        flag_HCD_OVERRIDE_MASK        = &H0
        write_HCD_OVERRIDE_TRIGGER_INDICATION_value = &H0
        flag_HCD_OVERRIDE_TRIGGER_INDICATION        = &H0
        write_BRAKE_LINK_TIMER_VALUES_value = &H0
        flag_BRAKE_LINK_TIMER_VALUES        = &H0
        write_BRAKE_LINK_TIMER_SLOW_DOWN_value = &H0
        flag_BRAKE_LINK_TIMER_SLOW_DOWN        = &H0
        write_HCD_OVERRIDE_VALUE_value = &H0
        flag_HCD_OVERRIDE_VALUE        = &H0
    End Sub
End Class


'' @REGISTER : CL45VEN_wirespeed_override_from_firmware
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' WIRESPEED_DOWN_SHIFT_TIMER_ENABLE          [15:15]          get_WIRESPEED_DOWN_SHIFT_TIMER_ENABLE
''                                                             set_WIRESPEED_DOWN_SHIFT_TIMER_ENABLE
''                                                             read_WIRESPEED_DOWN_SHIFT_TIMER_ENABLE
''                                                             write_WIRESPEED_DOWN_SHIFT_TIMER_ENABLE
''---------------------------------------------------------------------------------
'' WIRESPEED_MASK_10G_EEE                     [13:13]          get_WIRESPEED_MASK_10G_EEE
''                                                             set_WIRESPEED_MASK_10G_EEE
''                                                             read_WIRESPEED_MASK_10G_EEE
''                                                             write_WIRESPEED_MASK_10G_EEE
''---------------------------------------------------------------------------------
'' WIRESPEED_MASK_5G_EEE                      [12:12]          get_WIRESPEED_MASK_5G_EEE
''                                                             set_WIRESPEED_MASK_5G_EEE
''                                                             read_WIRESPEED_MASK_5G_EEE
''                                                             write_WIRESPEED_MASK_5G_EEE
''---------------------------------------------------------------------------------
'' WIRESPEED_MASK_2P5G_EEE                    [11:11]          get_WIRESPEED_MASK_2P5G_EEE
''                                                             set_WIRESPEED_MASK_2P5G_EEE
''                                                             read_WIRESPEED_MASK_2P5G_EEE
''                                                             write_WIRESPEED_MASK_2P5G_EEE
''---------------------------------------------------------------------------------
'' WIRESPEED_MASK_1G_EEE                      [10:10]          get_WIRESPEED_MASK_1G_EEE
''                                                             set_WIRESPEED_MASK_1G_EEE
''                                                             read_WIRESPEED_MASK_1G_EEE
''                                                             write_WIRESPEED_MASK_1G_EEE
''---------------------------------------------------------------------------------
'' WIRESPEED_MASK_100TX_EEE                   [9:9]            get_WIRESPEED_MASK_100TX_EEE
''                                                             set_WIRESPEED_MASK_100TX_EEE
''                                                             read_WIRESPEED_MASK_100TX_EEE
''                                                             write_WIRESPEED_MASK_100TX_EEE
''---------------------------------------------------------------------------------
'' WIRESPEED_MASK_10BASET_EEE                 [8:8]            get_WIRESPEED_MASK_10BASET_EEE
''                                                             set_WIRESPEED_MASK_10BASET_EEE
''                                                             read_WIRESPEED_MASK_10BASET_EEE
''                                                             write_WIRESPEED_MASK_10BASET_EEE
''---------------------------------------------------------------------------------
'' WIRESPEED_MASK_10G                         [5:5]            get_WIRESPEED_MASK_10G
''                                                             set_WIRESPEED_MASK_10G
''                                                             read_WIRESPEED_MASK_10G
''                                                             write_WIRESPEED_MASK_10G
''---------------------------------------------------------------------------------
'' WIRESPEED_MASK_5G                          [4:4]            get_WIRESPEED_MASK_5G
''                                                             set_WIRESPEED_MASK_5G
''                                                             read_WIRESPEED_MASK_5G
''                                                             write_WIRESPEED_MASK_5G
''---------------------------------------------------------------------------------
'' WIRESPEED_MASK_2P5G                        [3:3]            get_WIRESPEED_MASK_2P5G
''                                                             set_WIRESPEED_MASK_2P5G
''                                                             read_WIRESPEED_MASK_2P5G
''                                                             write_WIRESPEED_MASK_2P5G
''---------------------------------------------------------------------------------
'' WIRESPEED_MASK_1G                          [2:2]            get_WIRESPEED_MASK_1G
''                                                             set_WIRESPEED_MASK_1G
''                                                             read_WIRESPEED_MASK_1G
''                                                             write_WIRESPEED_MASK_1G
''---------------------------------------------------------------------------------
'' WIRESPEED_MASK_100TX                       [1:1]            get_WIRESPEED_MASK_100TX
''                                                             set_WIRESPEED_MASK_100TX
''                                                             read_WIRESPEED_MASK_100TX
''                                                             write_WIRESPEED_MASK_100TX
''---------------------------------------------------------------------------------
'' WIRESPEED_OVERRIDE_ENABLE                  [0:0]            get_WIRESPEED_OVERRIDE_ENABLE
''                                                             set_WIRESPEED_OVERRIDE_ENABLE
''                                                             read_WIRESPEED_OVERRIDE_ENABLE
''                                                             write_WIRESPEED_OVERRIDE_ENABLE
''---------------------------------------------------------------------------------
Class REGISTER_CL45VEN_wirespeed_override_from_firmware
    Private write_WIRESPEED_DOWN_SHIFT_TIMER_ENABLE_value
    Private read_WIRESPEED_DOWN_SHIFT_TIMER_ENABLE_value
    Private flag_WIRESPEED_DOWN_SHIFT_TIMER_ENABLE
    Private write_WIRESPEED_MASK_10G_EEE_value
    Private read_WIRESPEED_MASK_10G_EEE_value
    Private flag_WIRESPEED_MASK_10G_EEE
    Private write_WIRESPEED_MASK_5G_EEE_value
    Private read_WIRESPEED_MASK_5G_EEE_value
    Private flag_WIRESPEED_MASK_5G_EEE
    Private write_WIRESPEED_MASK_2P5G_EEE_value
    Private read_WIRESPEED_MASK_2P5G_EEE_value
    Private flag_WIRESPEED_MASK_2P5G_EEE
    Private write_WIRESPEED_MASK_1G_EEE_value
    Private read_WIRESPEED_MASK_1G_EEE_value
    Private flag_WIRESPEED_MASK_1G_EEE
    Private write_WIRESPEED_MASK_100TX_EEE_value
    Private read_WIRESPEED_MASK_100TX_EEE_value
    Private flag_WIRESPEED_MASK_100TX_EEE
    Private write_WIRESPEED_MASK_10BASET_EEE_value
    Private read_WIRESPEED_MASK_10BASET_EEE_value
    Private flag_WIRESPEED_MASK_10BASET_EEE
    Private write_WIRESPEED_MASK_10G_value
    Private read_WIRESPEED_MASK_10G_value
    Private flag_WIRESPEED_MASK_10G
    Private write_WIRESPEED_MASK_5G_value
    Private read_WIRESPEED_MASK_5G_value
    Private flag_WIRESPEED_MASK_5G
    Private write_WIRESPEED_MASK_2P5G_value
    Private read_WIRESPEED_MASK_2P5G_value
    Private flag_WIRESPEED_MASK_2P5G
    Private write_WIRESPEED_MASK_1G_value
    Private read_WIRESPEED_MASK_1G_value
    Private flag_WIRESPEED_MASK_1G
    Private write_WIRESPEED_MASK_100TX_value
    Private read_WIRESPEED_MASK_100TX_value
    Private flag_WIRESPEED_MASK_100TX
    Private write_WIRESPEED_OVERRIDE_ENABLE_value
    Private read_WIRESPEED_OVERRIDE_ENABLE_value
    Private flag_WIRESPEED_OVERRIDE_ENABLE

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

    Property Get get_WIRESPEED_DOWN_SHIFT_TIMER_ENABLE
        get_WIRESPEED_DOWN_SHIFT_TIMER_ENABLE = read_WIRESPEED_DOWN_SHIFT_TIMER_ENABLE_value
    End Property

    Property Let set_WIRESPEED_DOWN_SHIFT_TIMER_ENABLE(aData)
        write_WIRESPEED_DOWN_SHIFT_TIMER_ENABLE_value = aData
        flag_WIRESPEED_DOWN_SHIFT_TIMER_ENABLE        = &H1
    End Property

    Property Get read_WIRESPEED_DOWN_SHIFT_TIMER_ENABLE
        read
        read_WIRESPEED_DOWN_SHIFT_TIMER_ENABLE = read_WIRESPEED_DOWN_SHIFT_TIMER_ENABLE_value
    End Property

    Property Let write_WIRESPEED_DOWN_SHIFT_TIMER_ENABLE(aData)
        set_WIRESPEED_DOWN_SHIFT_TIMER_ENABLE = aData
        write
    End Property

    Property Get get_WIRESPEED_MASK_10G_EEE
        get_WIRESPEED_MASK_10G_EEE = read_WIRESPEED_MASK_10G_EEE_value
    End Property

    Property Let set_WIRESPEED_MASK_10G_EEE(aData)
        write_WIRESPEED_MASK_10G_EEE_value = aData
        flag_WIRESPEED_MASK_10G_EEE        = &H1
    End Property

    Property Get read_WIRESPEED_MASK_10G_EEE
        read
        read_WIRESPEED_MASK_10G_EEE = read_WIRESPEED_MASK_10G_EEE_value
    End Property

    Property Let write_WIRESPEED_MASK_10G_EEE(aData)
        set_WIRESPEED_MASK_10G_EEE = aData
        write
    End Property

    Property Get get_WIRESPEED_MASK_5G_EEE
        get_WIRESPEED_MASK_5G_EEE = read_WIRESPEED_MASK_5G_EEE_value
    End Property

    Property Let set_WIRESPEED_MASK_5G_EEE(aData)
        write_WIRESPEED_MASK_5G_EEE_value = aData
        flag_WIRESPEED_MASK_5G_EEE        = &H1
    End Property

    Property Get read_WIRESPEED_MASK_5G_EEE
        read
        read_WIRESPEED_MASK_5G_EEE = read_WIRESPEED_MASK_5G_EEE_value
    End Property

    Property Let write_WIRESPEED_MASK_5G_EEE(aData)
        set_WIRESPEED_MASK_5G_EEE = aData
        write
    End Property

    Property Get get_WIRESPEED_MASK_2P5G_EEE
        get_WIRESPEED_MASK_2P5G_EEE = read_WIRESPEED_MASK_2P5G_EEE_value
    End Property

    Property Let set_WIRESPEED_MASK_2P5G_EEE(aData)
        write_WIRESPEED_MASK_2P5G_EEE_value = aData
        flag_WIRESPEED_MASK_2P5G_EEE        = &H1
    End Property

    Property Get read_WIRESPEED_MASK_2P5G_EEE
        read
        read_WIRESPEED_MASK_2P5G_EEE = read_WIRESPEED_MASK_2P5G_EEE_value
    End Property

    Property Let write_WIRESPEED_MASK_2P5G_EEE(aData)
        set_WIRESPEED_MASK_2P5G_EEE = aData
        write
    End Property

    Property Get get_WIRESPEED_MASK_1G_EEE
        get_WIRESPEED_MASK_1G_EEE = read_WIRESPEED_MASK_1G_EEE_value
    End Property

    Property Let set_WIRESPEED_MASK_1G_EEE(aData)
        write_WIRESPEED_MASK_1G_EEE_value = aData
        flag_WIRESPEED_MASK_1G_EEE        = &H1
    End Property

    Property Get read_WIRESPEED_MASK_1G_EEE
        read
        read_WIRESPEED_MASK_1G_EEE = read_WIRESPEED_MASK_1G_EEE_value
    End Property

    Property Let write_WIRESPEED_MASK_1G_EEE(aData)
        set_WIRESPEED_MASK_1G_EEE = aData
        write
    End Property

    Property Get get_WIRESPEED_MASK_100TX_EEE
        get_WIRESPEED_MASK_100TX_EEE = read_WIRESPEED_MASK_100TX_EEE_value
    End Property

    Property Let set_WIRESPEED_MASK_100TX_EEE(aData)
        write_WIRESPEED_MASK_100TX_EEE_value = aData
        flag_WIRESPEED_MASK_100TX_EEE        = &H1
    End Property

    Property Get read_WIRESPEED_MASK_100TX_EEE
        read
        read_WIRESPEED_MASK_100TX_EEE = read_WIRESPEED_MASK_100TX_EEE_value
    End Property

    Property Let write_WIRESPEED_MASK_100TX_EEE(aData)
        set_WIRESPEED_MASK_100TX_EEE = aData
        write
    End Property

    Property Get get_WIRESPEED_MASK_10BASET_EEE
        get_WIRESPEED_MASK_10BASET_EEE = read_WIRESPEED_MASK_10BASET_EEE_value
    End Property

    Property Let set_WIRESPEED_MASK_10BASET_EEE(aData)
        write_WIRESPEED_MASK_10BASET_EEE_value = aData
        flag_WIRESPEED_MASK_10BASET_EEE        = &H1
    End Property

    Property Get read_WIRESPEED_MASK_10BASET_EEE
        read
        read_WIRESPEED_MASK_10BASET_EEE = read_WIRESPEED_MASK_10BASET_EEE_value
    End Property

    Property Let write_WIRESPEED_MASK_10BASET_EEE(aData)
        set_WIRESPEED_MASK_10BASET_EEE = aData
        write
    End Property

    Property Get get_WIRESPEED_MASK_10G
        get_WIRESPEED_MASK_10G = read_WIRESPEED_MASK_10G_value
    End Property

    Property Let set_WIRESPEED_MASK_10G(aData)
        write_WIRESPEED_MASK_10G_value = aData
        flag_WIRESPEED_MASK_10G        = &H1
    End Property

    Property Get read_WIRESPEED_MASK_10G
        read
        read_WIRESPEED_MASK_10G = read_WIRESPEED_MASK_10G_value
    End Property

    Property Let write_WIRESPEED_MASK_10G(aData)
        set_WIRESPEED_MASK_10G = aData
        write
    End Property

    Property Get get_WIRESPEED_MASK_5G
        get_WIRESPEED_MASK_5G = read_WIRESPEED_MASK_5G_value
    End Property

    Property Let set_WIRESPEED_MASK_5G(aData)
        write_WIRESPEED_MASK_5G_value = aData
        flag_WIRESPEED_MASK_5G        = &H1
    End Property

    Property Get read_WIRESPEED_MASK_5G
        read
        read_WIRESPEED_MASK_5G = read_WIRESPEED_MASK_5G_value
    End Property

    Property Let write_WIRESPEED_MASK_5G(aData)
        set_WIRESPEED_MASK_5G = aData
        write
    End Property

    Property Get get_WIRESPEED_MASK_2P5G
        get_WIRESPEED_MASK_2P5G = read_WIRESPEED_MASK_2P5G_value
    End Property

    Property Let set_WIRESPEED_MASK_2P5G(aData)
        write_WIRESPEED_MASK_2P5G_value = aData
        flag_WIRESPEED_MASK_2P5G        = &H1
    End Property

    Property Get read_WIRESPEED_MASK_2P5G
        read
        read_WIRESPEED_MASK_2P5G = read_WIRESPEED_MASK_2P5G_value
    End Property

    Property Let write_WIRESPEED_MASK_2P5G(aData)
        set_WIRESPEED_MASK_2P5G = aData
        write
    End Property

    Property Get get_WIRESPEED_MASK_1G
        get_WIRESPEED_MASK_1G = read_WIRESPEED_MASK_1G_value
    End Property

    Property Let set_WIRESPEED_MASK_1G(aData)
        write_WIRESPEED_MASK_1G_value = aData
        flag_WIRESPEED_MASK_1G        = &H1
    End Property

    Property Get read_WIRESPEED_MASK_1G
        read
        read_WIRESPEED_MASK_1G = read_WIRESPEED_MASK_1G_value
    End Property

    Property Let write_WIRESPEED_MASK_1G(aData)
        set_WIRESPEED_MASK_1G = aData
        write
    End Property

    Property Get get_WIRESPEED_MASK_100TX
        get_WIRESPEED_MASK_100TX = read_WIRESPEED_MASK_100TX_value
    End Property

    Property Let set_WIRESPEED_MASK_100TX(aData)
        write_WIRESPEED_MASK_100TX_value = aData
        flag_WIRESPEED_MASK_100TX        = &H1
    End Property

    Property Get read_WIRESPEED_MASK_100TX
        read
        read_WIRESPEED_MASK_100TX = read_WIRESPEED_MASK_100TX_value
    End Property

    Property Let write_WIRESPEED_MASK_100TX(aData)
        set_WIRESPEED_MASK_100TX = aData
        write
    End Property

    Property Get get_WIRESPEED_OVERRIDE_ENABLE
        get_WIRESPEED_OVERRIDE_ENABLE = read_WIRESPEED_OVERRIDE_ENABLE_value
    End Property

    Property Let set_WIRESPEED_OVERRIDE_ENABLE(aData)
        write_WIRESPEED_OVERRIDE_ENABLE_value = aData
        flag_WIRESPEED_OVERRIDE_ENABLE        = &H1
    End Property

    Property Get read_WIRESPEED_OVERRIDE_ENABLE
        read
        read_WIRESPEED_OVERRIDE_ENABLE = read_WIRESPEED_OVERRIDE_ENABLE_value
    End Property

    Property Let write_WIRESPEED_OVERRIDE_ENABLE(aData)
        set_WIRESPEED_OVERRIDE_ENABLE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_WIRESPEED_DOWN_SHIFT_TIMER_ENABLE_value = rightShift(data_low, 15) and &H1
        read_WIRESPEED_MASK_10G_EEE_value = rightShift(data_low, 13) and &H1
        read_WIRESPEED_MASK_5G_EEE_value = rightShift(data_low, 12) and &H1
        read_WIRESPEED_MASK_2P5G_EEE_value = rightShift(data_low, 11) and &H1
        read_WIRESPEED_MASK_1G_EEE_value = rightShift(data_low, 10) and &H1
        read_WIRESPEED_MASK_100TX_EEE_value = rightShift(data_low, 9) and &H1
        read_WIRESPEED_MASK_10BASET_EEE_value = rightShift(data_low, 8) and &H1
        read_WIRESPEED_MASK_10G_value = rightShift(data_low, 5) and &H1
        read_WIRESPEED_MASK_5G_value = rightShift(data_low, 4) and &H1
        read_WIRESPEED_MASK_2P5G_value = rightShift(data_low, 3) and &H1
        read_WIRESPEED_MASK_1G_value = rightShift(data_low, 2) and &H1
        read_WIRESPEED_MASK_100TX_value = rightShift(data_low, 1) and &H1
        WIRESPEED_OVERRIDE_ENABLE_mask = &H1
        if data_low > LONG_MAX then
            if WIRESPEED_OVERRIDE_ENABLE_mask = mask then
                read_WIRESPEED_OVERRIDE_ENABLE_value = data_low
            else
                read_WIRESPEED_OVERRIDE_ENABLE_value = (data_low - H8000_0000) and WIRESPEED_OVERRIDE_ENABLE_mask
            end If
        else
            read_WIRESPEED_OVERRIDE_ENABLE_value = data_low and WIRESPEED_OVERRIDE_ENABLE_mask
        end If

    End Sub

    Sub write
        If flag_WIRESPEED_DOWN_SHIFT_TIMER_ENABLE = &H0 or flag_WIRESPEED_MASK_10G_EEE = &H0 or flag_WIRESPEED_MASK_5G_EEE = &H0 or flag_WIRESPEED_MASK_2P5G_EEE = &H0 or flag_WIRESPEED_MASK_1G_EEE = &H0 or flag_WIRESPEED_MASK_100TX_EEE = &H0 or flag_WIRESPEED_MASK_10BASET_EEE = &H0 or flag_WIRESPEED_MASK_10G = &H0 or flag_WIRESPEED_MASK_5G = &H0 or flag_WIRESPEED_MASK_2P5G = &H0 or flag_WIRESPEED_MASK_1G = &H0 or flag_WIRESPEED_MASK_100TX = &H0 or flag_WIRESPEED_OVERRIDE_ENABLE = &H0 Then read
        If flag_WIRESPEED_DOWN_SHIFT_TIMER_ENABLE = &H0 Then write_WIRESPEED_DOWN_SHIFT_TIMER_ENABLE_value = get_WIRESPEED_DOWN_SHIFT_TIMER_ENABLE
        If flag_WIRESPEED_MASK_10G_EEE = &H0 Then write_WIRESPEED_MASK_10G_EEE_value = get_WIRESPEED_MASK_10G_EEE
        If flag_WIRESPEED_MASK_5G_EEE = &H0 Then write_WIRESPEED_MASK_5G_EEE_value = get_WIRESPEED_MASK_5G_EEE
        If flag_WIRESPEED_MASK_2P5G_EEE = &H0 Then write_WIRESPEED_MASK_2P5G_EEE_value = get_WIRESPEED_MASK_2P5G_EEE
        If flag_WIRESPEED_MASK_1G_EEE = &H0 Then write_WIRESPEED_MASK_1G_EEE_value = get_WIRESPEED_MASK_1G_EEE
        If flag_WIRESPEED_MASK_100TX_EEE = &H0 Then write_WIRESPEED_MASK_100TX_EEE_value = get_WIRESPEED_MASK_100TX_EEE
        If flag_WIRESPEED_MASK_10BASET_EEE = &H0 Then write_WIRESPEED_MASK_10BASET_EEE_value = get_WIRESPEED_MASK_10BASET_EEE
        If flag_WIRESPEED_MASK_10G = &H0 Then write_WIRESPEED_MASK_10G_value = get_WIRESPEED_MASK_10G
        If flag_WIRESPEED_MASK_5G = &H0 Then write_WIRESPEED_MASK_5G_value = get_WIRESPEED_MASK_5G
        If flag_WIRESPEED_MASK_2P5G = &H0 Then write_WIRESPEED_MASK_2P5G_value = get_WIRESPEED_MASK_2P5G
        If flag_WIRESPEED_MASK_1G = &H0 Then write_WIRESPEED_MASK_1G_value = get_WIRESPEED_MASK_1G
        If flag_WIRESPEED_MASK_100TX = &H0 Then write_WIRESPEED_MASK_100TX_value = get_WIRESPEED_MASK_100TX
        If flag_WIRESPEED_OVERRIDE_ENABLE = &H0 Then write_WIRESPEED_OVERRIDE_ENABLE_value = get_WIRESPEED_OVERRIDE_ENABLE

        regValue = leftShift((write_WIRESPEED_DOWN_SHIFT_TIMER_ENABLE_value and &H1), 15) + leftShift((write_WIRESPEED_MASK_10G_EEE_value and &H1), 13) + leftShift((write_WIRESPEED_MASK_5G_EEE_value and &H1), 12) + leftShift((write_WIRESPEED_MASK_2P5G_EEE_value and &H1), 11) + leftShift((write_WIRESPEED_MASK_1G_EEE_value and &H1), 10) + leftShift((write_WIRESPEED_MASK_100TX_EEE_value and &H1), 9) + leftShift((write_WIRESPEED_MASK_10BASET_EEE_value and &H1), 8) + leftShift((write_WIRESPEED_MASK_10G_value and &H1), 5) + leftShift((write_WIRESPEED_MASK_5G_value and &H1), 4) + leftShift((write_WIRESPEED_MASK_2P5G_value and &H1), 3) + leftShift((write_WIRESPEED_MASK_1G_value and &H1), 2) + leftShift((write_WIRESPEED_MASK_100TX_value and &H1), 1) + leftShift((write_WIRESPEED_OVERRIDE_ENABLE_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_WIRESPEED_DOWN_SHIFT_TIMER_ENABLE_value = rightShift(data_low, 15) and &H1
        read_WIRESPEED_MASK_10G_EEE_value = rightShift(data_low, 13) and &H1
        read_WIRESPEED_MASK_5G_EEE_value = rightShift(data_low, 12) and &H1
        read_WIRESPEED_MASK_2P5G_EEE_value = rightShift(data_low, 11) and &H1
        read_WIRESPEED_MASK_1G_EEE_value = rightShift(data_low, 10) and &H1
        read_WIRESPEED_MASK_100TX_EEE_value = rightShift(data_low, 9) and &H1
        read_WIRESPEED_MASK_10BASET_EEE_value = rightShift(data_low, 8) and &H1
        read_WIRESPEED_MASK_10G_value = rightShift(data_low, 5) and &H1
        read_WIRESPEED_MASK_5G_value = rightShift(data_low, 4) and &H1
        read_WIRESPEED_MASK_2P5G_value = rightShift(data_low, 3) and &H1
        read_WIRESPEED_MASK_1G_value = rightShift(data_low, 2) and &H1
        read_WIRESPEED_MASK_100TX_value = rightShift(data_low, 1) and &H1
        WIRESPEED_OVERRIDE_ENABLE_mask = &H1
        if data_low > LONG_MAX then
            if WIRESPEED_OVERRIDE_ENABLE_mask = mask then
                read_WIRESPEED_OVERRIDE_ENABLE_value = data_low
            else
                read_WIRESPEED_OVERRIDE_ENABLE_value = (data_low - H8000_0000) and WIRESPEED_OVERRIDE_ENABLE_mask
            end If
        else
            read_WIRESPEED_OVERRIDE_ENABLE_value = data_low and WIRESPEED_OVERRIDE_ENABLE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_WIRESPEED_DOWN_SHIFT_TIMER_ENABLE_value = &H0
        flag_WIRESPEED_DOWN_SHIFT_TIMER_ENABLE        = &H0
        write_WIRESPEED_MASK_10G_EEE_value = &H0
        flag_WIRESPEED_MASK_10G_EEE        = &H0
        write_WIRESPEED_MASK_5G_EEE_value = &H0
        flag_WIRESPEED_MASK_5G_EEE        = &H0
        write_WIRESPEED_MASK_2P5G_EEE_value = &H0
        flag_WIRESPEED_MASK_2P5G_EEE        = &H0
        write_WIRESPEED_MASK_1G_EEE_value = &H0
        flag_WIRESPEED_MASK_1G_EEE        = &H0
        write_WIRESPEED_MASK_100TX_EEE_value = &H0
        flag_WIRESPEED_MASK_100TX_EEE        = &H0
        write_WIRESPEED_MASK_10BASET_EEE_value = &H0
        flag_WIRESPEED_MASK_10BASET_EEE        = &H0
        write_WIRESPEED_MASK_10G_value = &H0
        flag_WIRESPEED_MASK_10G        = &H0
        write_WIRESPEED_MASK_5G_value = &H0
        flag_WIRESPEED_MASK_5G        = &H0
        write_WIRESPEED_MASK_2P5G_value = &H0
        flag_WIRESPEED_MASK_2P5G        = &H0
        write_WIRESPEED_MASK_1G_value = &H0
        flag_WIRESPEED_MASK_1G        = &H0
        write_WIRESPEED_MASK_100TX_value = &H0
        flag_WIRESPEED_MASK_100TX        = &H0
        write_WIRESPEED_OVERRIDE_ENABLE_value = &H0
        flag_WIRESPEED_OVERRIDE_ENABLE        = &H0
    End Sub
End Class


'' @REGISTER : CL45VEN_shadow_for_7_65_register
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SHADOW_7_65_REGISTER                       [15:0]           get_SHADOW_7_65_REGISTER
''                                                             set_SHADOW_7_65_REGISTER
''                                                             read_SHADOW_7_65_REGISTER
''                                                             write_SHADOW_7_65_REGISTER
''---------------------------------------------------------------------------------
Class REGISTER_CL45VEN_shadow_for_7_65_register
    Private write_SHADOW_7_65_REGISTER_value
    Private read_SHADOW_7_65_REGISTER_value
    Private flag_SHADOW_7_65_REGISTER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hb2
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SHADOW_7_65_REGISTER
        get_SHADOW_7_65_REGISTER = read_SHADOW_7_65_REGISTER_value
    End Property

    Property Let set_SHADOW_7_65_REGISTER(aData)
        write_SHADOW_7_65_REGISTER_value = aData
        flag_SHADOW_7_65_REGISTER        = &H1
    End Property

    Property Get read_SHADOW_7_65_REGISTER
        read
        read_SHADOW_7_65_REGISTER = read_SHADOW_7_65_REGISTER_value
    End Property

    Property Let write_SHADOW_7_65_REGISTER(aData)
        set_SHADOW_7_65_REGISTER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SHADOW_7_65_REGISTER_mask = &Hffff
        if data_low > LONG_MAX then
            if SHADOW_7_65_REGISTER_mask = mask then
                read_SHADOW_7_65_REGISTER_value = data_low
            else
                read_SHADOW_7_65_REGISTER_value = (data_low - H8000_0000) and SHADOW_7_65_REGISTER_mask
            end If
        else
            read_SHADOW_7_65_REGISTER_value = data_low and SHADOW_7_65_REGISTER_mask
        end If

    End Sub

    Sub write
        If flag_SHADOW_7_65_REGISTER = &H0 Then read
        If flag_SHADOW_7_65_REGISTER = &H0 Then write_SHADOW_7_65_REGISTER_value = get_SHADOW_7_65_REGISTER

        regValue = leftShift((write_SHADOW_7_65_REGISTER_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        SHADOW_7_65_REGISTER_mask = &Hffff
        if data_low > LONG_MAX then
            if SHADOW_7_65_REGISTER_mask = mask then
                read_SHADOW_7_65_REGISTER_value = data_low
            else
                read_SHADOW_7_65_REGISTER_value = (data_low - H8000_0000) and SHADOW_7_65_REGISTER_mask
            end If
        else
            read_SHADOW_7_65_REGISTER_value = data_low and SHADOW_7_65_REGISTER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SHADOW_7_65_REGISTER_value = &H0
        flag_SHADOW_7_65_REGISTER        = &H0
    End Sub
End Class


'' @REGISTER : CL45VEN_autoneg_test_reg0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' AUTONEG_WIRESPEED_ENABLE                   [15:15]          get_AUTONEG_WIRESPEED_ENABLE
''                                                             set_AUTONEG_WIRESPEED_ENABLE
''                                                             read_AUTONEG_WIRESPEED_ENABLE
''                                                             write_AUTONEG_WIRESPEED_ENABLE
''---------------------------------------------------------------------------------
'' AUTONEG_TEST_REG0_BIT_14                   [14:14]          get_AUTONEG_TEST_REG0_BIT_14
''                                                             set_AUTONEG_TEST_REG0_BIT_14
''                                                             read_AUTONEG_TEST_REG0_BIT_14
''                                                             write_AUTONEG_TEST_REG0_BIT_14
''---------------------------------------------------------------------------------
'' ADIDIACA                                   [13:13]          get_ADIDIACA
''                                                             set_ADIDIACA
''                                                             read_ADIDIACA
''                                                             write_ADIDIACA
''---------------------------------------------------------------------------------
'' AUTONEG_LINK_FAIL_INHIBIT_DONE_FORCE       [12:12]          get_AUTONEG_LINK_FAIL_INHIBIT_DONE_FORCE
''                                                             set_AUTONEG_LINK_FAIL_INHIBIT_DONE_FORCE
''                                                             read_AUTONEG_LINK_FAIL_INHIBIT_DONE_FORCE
''                                                             write_AUTONEG_LINK_FAIL_INHIBIT_DONE_FORCE
''---------------------------------------------------------------------------------
'' AUTONEG_MESSAGE_5_ENABLE                   [11:11]          get_AUTONEG_MESSAGE_5_ENABLE
''                                                             set_AUTONEG_MESSAGE_5_ENABLE
''                                                             read_AUTONEG_MESSAGE_5_ENABLE
''                                                             write_AUTONEG_MESSAGE_5_ENABLE
''---------------------------------------------------------------------------------
'' AUTONEG_DISABLE_RX_WORD_COUNTER_ARB        [10:10]          get_AUTONEG_DISABLE_RX_WORD_COUNTER_ARB
''                                                             set_AUTONEG_DISABLE_RX_WORD_COUNTER_ARB
''                                                             read_AUTONEG_DISABLE_RX_WORD_COUNTER_ARB
''                                                             write_AUTONEG_DISABLE_RX_WORD_COUNTER_ARB
''---------------------------------------------------------------------------------
'' AUTONEG_BREAK_LINK_TIMER_MULTIPLIER        [9:8]            get_AUTONEG_BREAK_LINK_TIMER_MULTIPLIER
''                                                             set_AUTONEG_BREAK_LINK_TIMER_MULTIPLIER
''                                                             read_AUTONEG_BREAK_LINK_TIMER_MULTIPLIER
''                                                             write_AUTONEG_BREAK_LINK_TIMER_MULTIPLIER
''---------------------------------------------------------------------------------
'' ALFITM                                     [7:4]            get_ALFITM
''                                                             set_ALFITM
''                                                             read_ALFITM
''                                                             write_ALFITM
''---------------------------------------------------------------------------------
'' ALFITF                                     [3:3]            get_ALFITF
''                                                             set_ALFITF
''                                                             read_ALFITF
''                                                             write_ALFITF
''---------------------------------------------------------------------------------
'' AUTONEG_WIRESPEED_ATTEMPT_NUMBER           [2:0]            get_AUTONEG_WIRESPEED_ATTEMPT_NUMBER
''                                                             set_AUTONEG_WIRESPEED_ATTEMPT_NUMBER
''                                                             read_AUTONEG_WIRESPEED_ATTEMPT_NUMBER
''                                                             write_AUTONEG_WIRESPEED_ATTEMPT_NUMBER
''---------------------------------------------------------------------------------
Class REGISTER_CL45VEN_autoneg_test_reg0
    Private write_AUTONEG_WIRESPEED_ENABLE_value
    Private read_AUTONEG_WIRESPEED_ENABLE_value
    Private flag_AUTONEG_WIRESPEED_ENABLE
    Private write_AUTONEG_TEST_REG0_BIT_14_value
    Private read_AUTONEG_TEST_REG0_BIT_14_value
    Private flag_AUTONEG_TEST_REG0_BIT_14
    Private write_ADIDIACA_value
    Private read_ADIDIACA_value
    Private flag_ADIDIACA
    Private write_AUTONEG_LINK_FAIL_INHIBIT_DONE_FORCE_value
    Private read_AUTONEG_LINK_FAIL_INHIBIT_DONE_FORCE_value
    Private flag_AUTONEG_LINK_FAIL_INHIBIT_DONE_FORCE
    Private write_AUTONEG_MESSAGE_5_ENABLE_value
    Private read_AUTONEG_MESSAGE_5_ENABLE_value
    Private flag_AUTONEG_MESSAGE_5_ENABLE
    Private write_AUTONEG_DISABLE_RX_WORD_COUNTER_ARB_value
    Private read_AUTONEG_DISABLE_RX_WORD_COUNTER_ARB_value
    Private flag_AUTONEG_DISABLE_RX_WORD_COUNTER_ARB
    Private write_AUTONEG_BREAK_LINK_TIMER_MULTIPLIER_value
    Private read_AUTONEG_BREAK_LINK_TIMER_MULTIPLIER_value
    Private flag_AUTONEG_BREAK_LINK_TIMER_MULTIPLIER
    Private write_ALFITM_value
    Private read_ALFITM_value
    Private flag_ALFITM
    Private write_ALFITF_value
    Private read_ALFITF_value
    Private flag_ALFITF
    Private write_AUTONEG_WIRESPEED_ATTEMPT_NUMBER_value
    Private read_AUTONEG_WIRESPEED_ATTEMPT_NUMBER_value
    Private flag_AUTONEG_WIRESPEED_ATTEMPT_NUMBER

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

    Property Get get_AUTONEG_WIRESPEED_ENABLE
        get_AUTONEG_WIRESPEED_ENABLE = read_AUTONEG_WIRESPEED_ENABLE_value
    End Property

    Property Let set_AUTONEG_WIRESPEED_ENABLE(aData)
        write_AUTONEG_WIRESPEED_ENABLE_value = aData
        flag_AUTONEG_WIRESPEED_ENABLE        = &H1
    End Property

    Property Get read_AUTONEG_WIRESPEED_ENABLE
        read
        read_AUTONEG_WIRESPEED_ENABLE = read_AUTONEG_WIRESPEED_ENABLE_value
    End Property

    Property Let write_AUTONEG_WIRESPEED_ENABLE(aData)
        set_AUTONEG_WIRESPEED_ENABLE = aData
        write
    End Property

    Property Get get_AUTONEG_TEST_REG0_BIT_14
        get_AUTONEG_TEST_REG0_BIT_14 = read_AUTONEG_TEST_REG0_BIT_14_value
    End Property

    Property Let set_AUTONEG_TEST_REG0_BIT_14(aData)
        write_AUTONEG_TEST_REG0_BIT_14_value = aData
        flag_AUTONEG_TEST_REG0_BIT_14        = &H1
    End Property

    Property Get read_AUTONEG_TEST_REG0_BIT_14
        read
        read_AUTONEG_TEST_REG0_BIT_14 = read_AUTONEG_TEST_REG0_BIT_14_value
    End Property

    Property Let write_AUTONEG_TEST_REG0_BIT_14(aData)
        set_AUTONEG_TEST_REG0_BIT_14 = aData
        write
    End Property

    Property Get get_ADIDIACA
        get_ADIDIACA = read_ADIDIACA_value
    End Property

    Property Let set_ADIDIACA(aData)
        write_ADIDIACA_value = aData
        flag_ADIDIACA        = &H1
    End Property

    Property Get read_ADIDIACA
        read
        read_ADIDIACA = read_ADIDIACA_value
    End Property

    Property Let write_ADIDIACA(aData)
        set_ADIDIACA = aData
        write
    End Property

    Property Get get_AUTONEG_LINK_FAIL_INHIBIT_DONE_FORCE
        get_AUTONEG_LINK_FAIL_INHIBIT_DONE_FORCE = read_AUTONEG_LINK_FAIL_INHIBIT_DONE_FORCE_value
    End Property

    Property Let set_AUTONEG_LINK_FAIL_INHIBIT_DONE_FORCE(aData)
        write_AUTONEG_LINK_FAIL_INHIBIT_DONE_FORCE_value = aData
        flag_AUTONEG_LINK_FAIL_INHIBIT_DONE_FORCE        = &H1
    End Property

    Property Get read_AUTONEG_LINK_FAIL_INHIBIT_DONE_FORCE
        read
        read_AUTONEG_LINK_FAIL_INHIBIT_DONE_FORCE = read_AUTONEG_LINK_FAIL_INHIBIT_DONE_FORCE_value
    End Property

    Property Let write_AUTONEG_LINK_FAIL_INHIBIT_DONE_FORCE(aData)
        set_AUTONEG_LINK_FAIL_INHIBIT_DONE_FORCE = aData
        write
    End Property

    Property Get get_AUTONEG_MESSAGE_5_ENABLE
        get_AUTONEG_MESSAGE_5_ENABLE = read_AUTONEG_MESSAGE_5_ENABLE_value
    End Property

    Property Let set_AUTONEG_MESSAGE_5_ENABLE(aData)
        write_AUTONEG_MESSAGE_5_ENABLE_value = aData
        flag_AUTONEG_MESSAGE_5_ENABLE        = &H1
    End Property

    Property Get read_AUTONEG_MESSAGE_5_ENABLE
        read
        read_AUTONEG_MESSAGE_5_ENABLE = read_AUTONEG_MESSAGE_5_ENABLE_value
    End Property

    Property Let write_AUTONEG_MESSAGE_5_ENABLE(aData)
        set_AUTONEG_MESSAGE_5_ENABLE = aData
        write
    End Property

    Property Get get_AUTONEG_DISABLE_RX_WORD_COUNTER_ARB
        get_AUTONEG_DISABLE_RX_WORD_COUNTER_ARB = read_AUTONEG_DISABLE_RX_WORD_COUNTER_ARB_value
    End Property

    Property Let set_AUTONEG_DISABLE_RX_WORD_COUNTER_ARB(aData)
        write_AUTONEG_DISABLE_RX_WORD_COUNTER_ARB_value = aData
        flag_AUTONEG_DISABLE_RX_WORD_COUNTER_ARB        = &H1
    End Property

    Property Get read_AUTONEG_DISABLE_RX_WORD_COUNTER_ARB
        read
        read_AUTONEG_DISABLE_RX_WORD_COUNTER_ARB = read_AUTONEG_DISABLE_RX_WORD_COUNTER_ARB_value
    End Property

    Property Let write_AUTONEG_DISABLE_RX_WORD_COUNTER_ARB(aData)
        set_AUTONEG_DISABLE_RX_WORD_COUNTER_ARB = aData
        write
    End Property

    Property Get get_AUTONEG_BREAK_LINK_TIMER_MULTIPLIER
        get_AUTONEG_BREAK_LINK_TIMER_MULTIPLIER = read_AUTONEG_BREAK_LINK_TIMER_MULTIPLIER_value
    End Property

    Property Let set_AUTONEG_BREAK_LINK_TIMER_MULTIPLIER(aData)
        write_AUTONEG_BREAK_LINK_TIMER_MULTIPLIER_value = aData
        flag_AUTONEG_BREAK_LINK_TIMER_MULTIPLIER        = &H1
    End Property

    Property Get read_AUTONEG_BREAK_LINK_TIMER_MULTIPLIER
        read
        read_AUTONEG_BREAK_LINK_TIMER_MULTIPLIER = read_AUTONEG_BREAK_LINK_TIMER_MULTIPLIER_value
    End Property

    Property Let write_AUTONEG_BREAK_LINK_TIMER_MULTIPLIER(aData)
        set_AUTONEG_BREAK_LINK_TIMER_MULTIPLIER = aData
        write
    End Property

    Property Get get_ALFITM
        get_ALFITM = read_ALFITM_value
    End Property

    Property Let set_ALFITM(aData)
        write_ALFITM_value = aData
        flag_ALFITM        = &H1
    End Property

    Property Get read_ALFITM
        read
        read_ALFITM = read_ALFITM_value
    End Property

    Property Let write_ALFITM(aData)
        set_ALFITM = aData
        write
    End Property

    Property Get get_ALFITF
        get_ALFITF = read_ALFITF_value
    End Property

    Property Let set_ALFITF(aData)
        write_ALFITF_value = aData
        flag_ALFITF        = &H1
    End Property

    Property Get read_ALFITF
        read
        read_ALFITF = read_ALFITF_value
    End Property

    Property Let write_ALFITF(aData)
        set_ALFITF = aData
        write
    End Property

    Property Get get_AUTONEG_WIRESPEED_ATTEMPT_NUMBER
        get_AUTONEG_WIRESPEED_ATTEMPT_NUMBER = read_AUTONEG_WIRESPEED_ATTEMPT_NUMBER_value
    End Property

    Property Let set_AUTONEG_WIRESPEED_ATTEMPT_NUMBER(aData)
        write_AUTONEG_WIRESPEED_ATTEMPT_NUMBER_value = aData
        flag_AUTONEG_WIRESPEED_ATTEMPT_NUMBER        = &H1
    End Property

    Property Get read_AUTONEG_WIRESPEED_ATTEMPT_NUMBER
        read
        read_AUTONEG_WIRESPEED_ATTEMPT_NUMBER = read_AUTONEG_WIRESPEED_ATTEMPT_NUMBER_value
    End Property

    Property Let write_AUTONEG_WIRESPEED_ATTEMPT_NUMBER(aData)
        set_AUTONEG_WIRESPEED_ATTEMPT_NUMBER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_AUTONEG_WIRESPEED_ENABLE_value = rightShift(data_low, 15) and &H1
        read_AUTONEG_TEST_REG0_BIT_14_value = rightShift(data_low, 14) and &H1
        read_ADIDIACA_value = rightShift(data_low, 13) and &H1
        read_AUTONEG_LINK_FAIL_INHIBIT_DONE_FORCE_value = rightShift(data_low, 12) and &H1
        read_AUTONEG_MESSAGE_5_ENABLE_value = rightShift(data_low, 11) and &H1
        read_AUTONEG_DISABLE_RX_WORD_COUNTER_ARB_value = rightShift(data_low, 10) and &H1
        read_AUTONEG_BREAK_LINK_TIMER_MULTIPLIER_value = rightShift(data_low, 8) and &H3
        read_ALFITM_value = rightShift(data_low, 4) and &Hf
        read_ALFITF_value = rightShift(data_low, 3) and &H1
        AUTONEG_WIRESPEED_ATTEMPT_NUMBER_mask = &H7
        if data_low > LONG_MAX then
            if AUTONEG_WIRESPEED_ATTEMPT_NUMBER_mask = mask then
                read_AUTONEG_WIRESPEED_ATTEMPT_NUMBER_value = data_low
            else
                read_AUTONEG_WIRESPEED_ATTEMPT_NUMBER_value = (data_low - H8000_0000) and AUTONEG_WIRESPEED_ATTEMPT_NUMBER_mask
            end If
        else
            read_AUTONEG_WIRESPEED_ATTEMPT_NUMBER_value = data_low and AUTONEG_WIRESPEED_ATTEMPT_NUMBER_mask
        end If

    End Sub

    Sub write
        If flag_AUTONEG_WIRESPEED_ENABLE = &H0 or flag_AUTONEG_TEST_REG0_BIT_14 = &H0 or flag_ADIDIACA = &H0 or flag_AUTONEG_LINK_FAIL_INHIBIT_DONE_FORCE = &H0 or flag_AUTONEG_MESSAGE_5_ENABLE = &H0 or flag_AUTONEG_DISABLE_RX_WORD_COUNTER_ARB = &H0 or flag_AUTONEG_BREAK_LINK_TIMER_MULTIPLIER = &H0 or flag_ALFITM = &H0 or flag_ALFITF = &H0 or flag_AUTONEG_WIRESPEED_ATTEMPT_NUMBER = &H0 Then read
        If flag_AUTONEG_WIRESPEED_ENABLE = &H0 Then write_AUTONEG_WIRESPEED_ENABLE_value = get_AUTONEG_WIRESPEED_ENABLE
        If flag_AUTONEG_TEST_REG0_BIT_14 = &H0 Then write_AUTONEG_TEST_REG0_BIT_14_value = get_AUTONEG_TEST_REG0_BIT_14
        If flag_ADIDIACA = &H0 Then write_ADIDIACA_value = get_ADIDIACA
        If flag_AUTONEG_LINK_FAIL_INHIBIT_DONE_FORCE = &H0 Then write_AUTONEG_LINK_FAIL_INHIBIT_DONE_FORCE_value = get_AUTONEG_LINK_FAIL_INHIBIT_DONE_FORCE
        If flag_AUTONEG_MESSAGE_5_ENABLE = &H0 Then write_AUTONEG_MESSAGE_5_ENABLE_value = get_AUTONEG_MESSAGE_5_ENABLE
        If flag_AUTONEG_DISABLE_RX_WORD_COUNTER_ARB = &H0 Then write_AUTONEG_DISABLE_RX_WORD_COUNTER_ARB_value = get_AUTONEG_DISABLE_RX_WORD_COUNTER_ARB
        If flag_AUTONEG_BREAK_LINK_TIMER_MULTIPLIER = &H0 Then write_AUTONEG_BREAK_LINK_TIMER_MULTIPLIER_value = get_AUTONEG_BREAK_LINK_TIMER_MULTIPLIER
        If flag_ALFITM = &H0 Then write_ALFITM_value = get_ALFITM
        If flag_ALFITF = &H0 Then write_ALFITF_value = get_ALFITF
        If flag_AUTONEG_WIRESPEED_ATTEMPT_NUMBER = &H0 Then write_AUTONEG_WIRESPEED_ATTEMPT_NUMBER_value = get_AUTONEG_WIRESPEED_ATTEMPT_NUMBER

        regValue = leftShift((write_AUTONEG_WIRESPEED_ENABLE_value and &H1), 15) + leftShift((write_AUTONEG_TEST_REG0_BIT_14_value and &H1), 14) + leftShift((write_ADIDIACA_value and &H1), 13) + leftShift((write_AUTONEG_LINK_FAIL_INHIBIT_DONE_FORCE_value and &H1), 12) + leftShift((write_AUTONEG_MESSAGE_5_ENABLE_value and &H1), 11) + leftShift((write_AUTONEG_DISABLE_RX_WORD_COUNTER_ARB_value and &H1), 10) + leftShift((write_AUTONEG_BREAK_LINK_TIMER_MULTIPLIER_value and &H3), 8) + leftShift((write_ALFITM_value and &Hf), 4) + leftShift((write_ALFITF_value and &H1), 3) + leftShift((write_AUTONEG_WIRESPEED_ATTEMPT_NUMBER_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_AUTONEG_WIRESPEED_ENABLE_value = rightShift(data_low, 15) and &H1
        read_AUTONEG_TEST_REG0_BIT_14_value = rightShift(data_low, 14) and &H1
        read_ADIDIACA_value = rightShift(data_low, 13) and &H1
        read_AUTONEG_LINK_FAIL_INHIBIT_DONE_FORCE_value = rightShift(data_low, 12) and &H1
        read_AUTONEG_MESSAGE_5_ENABLE_value = rightShift(data_low, 11) and &H1
        read_AUTONEG_DISABLE_RX_WORD_COUNTER_ARB_value = rightShift(data_low, 10) and &H1
        read_AUTONEG_BREAK_LINK_TIMER_MULTIPLIER_value = rightShift(data_low, 8) and &H3
        read_ALFITM_value = rightShift(data_low, 4) and &Hf
        read_ALFITF_value = rightShift(data_low, 3) and &H1
        AUTONEG_WIRESPEED_ATTEMPT_NUMBER_mask = &H7
        if data_low > LONG_MAX then
            if AUTONEG_WIRESPEED_ATTEMPT_NUMBER_mask = mask then
                read_AUTONEG_WIRESPEED_ATTEMPT_NUMBER_value = data_low
            else
                read_AUTONEG_WIRESPEED_ATTEMPT_NUMBER_value = (data_low - H8000_0000) and AUTONEG_WIRESPEED_ATTEMPT_NUMBER_mask
            end If
        else
            read_AUTONEG_WIRESPEED_ATTEMPT_NUMBER_value = data_low and AUTONEG_WIRESPEED_ATTEMPT_NUMBER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_AUTONEG_WIRESPEED_ENABLE_value = &H0
        flag_AUTONEG_WIRESPEED_ENABLE        = &H0
        write_AUTONEG_TEST_REG0_BIT_14_value = &H0
        flag_AUTONEG_TEST_REG0_BIT_14        = &H0
        write_ADIDIACA_value = &H0
        flag_ADIDIACA        = &H0
        write_AUTONEG_LINK_FAIL_INHIBIT_DONE_FORCE_value = &H0
        flag_AUTONEG_LINK_FAIL_INHIBIT_DONE_FORCE        = &H0
        write_AUTONEG_MESSAGE_5_ENABLE_value = &H0
        flag_AUTONEG_MESSAGE_5_ENABLE        = &H0
        write_AUTONEG_DISABLE_RX_WORD_COUNTER_ARB_value = &H0
        flag_AUTONEG_DISABLE_RX_WORD_COUNTER_ARB        = &H0
        write_AUTONEG_BREAK_LINK_TIMER_MULTIPLIER_value = &H0
        flag_AUTONEG_BREAK_LINK_TIMER_MULTIPLIER        = &H0
        write_ALFITM_value = &H0
        flag_ALFITM        = &H0
        write_ALFITF_value = &H0
        flag_ALFITF        = &H0
        write_AUTONEG_WIRESPEED_ATTEMPT_NUMBER_value = &H0
        flag_AUTONEG_WIRESPEED_ATTEMPT_NUMBER        = &H0
    End Sub
End Class


'' @REGISTER : CL45VEN_autoneg_test_reg1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' AUTONEG_FORCE_RESOLUTION                   [15:15]          get_AUTONEG_FORCE_RESOLUTION
''                                                             set_AUTONEG_FORCE_RESOLUTION
''                                                             read_AUTONEG_FORCE_RESOLUTION
''                                                             write_AUTONEG_FORCE_RESOLUTION
''---------------------------------------------------------------------------------
'' AUTONEG_FORCE_MASTER_SLAVE                 [14:14]          get_AUTONEG_FORCE_MASTER_SLAVE
''                                                             set_AUTONEG_FORCE_MASTER_SLAVE
''                                                             read_AUTONEG_FORCE_MASTER_SLAVE
''                                                             write_AUTONEG_FORCE_MASTER_SLAVE
''---------------------------------------------------------------------------------
'' AUTONEG_FORCE_CONFIGURATION_FAULT          [13:13]          get_AUTONEG_FORCE_CONFIGURATION_FAULT
''                                                             set_AUTONEG_FORCE_CONFIGURATION_FAULT
''                                                             read_AUTONEG_FORCE_CONFIGURATION_FAULT
''                                                             write_AUTONEG_FORCE_CONFIGURATION_FAULT
''---------------------------------------------------------------------------------
'' AUTONEG_FORCE_LINK_CONTROL_1000T1          [12:12]          get_AUTONEG_FORCE_LINK_CONTROL_1000T1
''                                                             set_AUTONEG_FORCE_LINK_CONTROL_1000T1
''                                                             read_AUTONEG_FORCE_LINK_CONTROL_1000T1
''                                                             write_AUTONEG_FORCE_LINK_CONTROL_1000T1
''---------------------------------------------------------------------------------
'' AUTONEG_FORCE_LINK_CONTROL_100T1           [11:11]          get_AUTONEG_FORCE_LINK_CONTROL_100T1
''                                                             set_AUTONEG_FORCE_LINK_CONTROL_100T1
''                                                             read_AUTONEG_FORCE_LINK_CONTROL_100T1
''                                                             write_AUTONEG_FORCE_LINK_CONTROL_100T1
''---------------------------------------------------------------------------------
'' OVERRIDE_MS_RESOLUTION_FAULT               [10:10]          get_OVERRIDE_MS_RESOLUTION_FAULT
''                                                             set_OVERRIDE_MS_RESOLUTION_FAULT
''                                                             read_OVERRIDE_MS_RESOLUTION_FAULT
''                                                             write_OVERRIDE_MS_RESOLUTION_FAULT
''---------------------------------------------------------------------------------
'' OVERRIDE_RANDOM_POLARITY_VALUE             [9:9]            get_OVERRIDE_RANDOM_POLARITY_VALUE
''                                                             set_OVERRIDE_RANDOM_POLARITY_VALUE
''                                                             read_OVERRIDE_RANDOM_POLARITY_VALUE
''                                                             write_OVERRIDE_RANDOM_POLARITY_VALUE
''---------------------------------------------------------------------------------
'' OVERRIDE_RANDOM_POLARITY                   [8:8]            get_OVERRIDE_RANDOM_POLARITY
''                                                             set_OVERRIDE_RANDOM_POLARITY
''                                                             read_OVERRIDE_RANDOM_POLARITY
''                                                             write_OVERRIDE_RANDOM_POLARITY
''---------------------------------------------------------------------------------
'' OVERRIDE_RANDOM_SEED_VALUE                 [7:4]            get_OVERRIDE_RANDOM_SEED_VALUE
''                                                             set_OVERRIDE_RANDOM_SEED_VALUE
''                                                             read_OVERRIDE_RANDOM_SEED_VALUE
''                                                             write_OVERRIDE_RANDOM_SEED_VALUE
''---------------------------------------------------------------------------------
'' OVERRIDE_RANDOM_SEED                       [3:3]            get_OVERRIDE_RANDOM_SEED
''                                                             set_OVERRIDE_RANDOM_SEED
''                                                             read_OVERRIDE_RANDOM_SEED
''                                                             write_OVERRIDE_RANDOM_SEED
''---------------------------------------------------------------------------------
'' ACCELERATE_LEGACY_TIMER                    [2:2]            get_ACCELERATE_LEGACY_TIMER
''                                                             set_ACCELERATE_LEGACY_TIMER
''                                                             read_ACCELERATE_LEGACY_TIMER
''                                                             write_ACCELERATE_LEGACY_TIMER
''---------------------------------------------------------------------------------
'' ACCELERATE_LINK_FAIL_INHIBIT_TIMER         [1:1]            get_ACCELERATE_LINK_FAIL_INHIBIT_TIMER
''                                                             set_ACCELERATE_LINK_FAIL_INHIBIT_TIMER
''                                                             read_ACCELERATE_LINK_FAIL_INHIBIT_TIMER
''                                                             write_ACCELERATE_LINK_FAIL_INHIBIT_TIMER
''---------------------------------------------------------------------------------
'' ACCELERATE_BREAK_LINK_TIMER                [0:0]            get_ACCELERATE_BREAK_LINK_TIMER
''                                                             set_ACCELERATE_BREAK_LINK_TIMER
''                                                             read_ACCELERATE_BREAK_LINK_TIMER
''                                                             write_ACCELERATE_BREAK_LINK_TIMER
''---------------------------------------------------------------------------------
Class REGISTER_CL45VEN_autoneg_test_reg1
    Private write_AUTONEG_FORCE_RESOLUTION_value
    Private read_AUTONEG_FORCE_RESOLUTION_value
    Private flag_AUTONEG_FORCE_RESOLUTION
    Private write_AUTONEG_FORCE_MASTER_SLAVE_value
    Private read_AUTONEG_FORCE_MASTER_SLAVE_value
    Private flag_AUTONEG_FORCE_MASTER_SLAVE
    Private write_AUTONEG_FORCE_CONFIGURATION_FAULT_value
    Private read_AUTONEG_FORCE_CONFIGURATION_FAULT_value
    Private flag_AUTONEG_FORCE_CONFIGURATION_FAULT
    Private write_AUTONEG_FORCE_LINK_CONTROL_1000T1_value
    Private read_AUTONEG_FORCE_LINK_CONTROL_1000T1_value
    Private flag_AUTONEG_FORCE_LINK_CONTROL_1000T1
    Private write_AUTONEG_FORCE_LINK_CONTROL_100T1_value
    Private read_AUTONEG_FORCE_LINK_CONTROL_100T1_value
    Private flag_AUTONEG_FORCE_LINK_CONTROL_100T1
    Private write_OVERRIDE_MS_RESOLUTION_FAULT_value
    Private read_OVERRIDE_MS_RESOLUTION_FAULT_value
    Private flag_OVERRIDE_MS_RESOLUTION_FAULT
    Private write_OVERRIDE_RANDOM_POLARITY_VALUE_value
    Private read_OVERRIDE_RANDOM_POLARITY_VALUE_value
    Private flag_OVERRIDE_RANDOM_POLARITY_VALUE
    Private write_OVERRIDE_RANDOM_POLARITY_value
    Private read_OVERRIDE_RANDOM_POLARITY_value
    Private flag_OVERRIDE_RANDOM_POLARITY
    Private write_OVERRIDE_RANDOM_SEED_VALUE_value
    Private read_OVERRIDE_RANDOM_SEED_VALUE_value
    Private flag_OVERRIDE_RANDOM_SEED_VALUE
    Private write_OVERRIDE_RANDOM_SEED_value
    Private read_OVERRIDE_RANDOM_SEED_value
    Private flag_OVERRIDE_RANDOM_SEED
    Private write_ACCELERATE_LEGACY_TIMER_value
    Private read_ACCELERATE_LEGACY_TIMER_value
    Private flag_ACCELERATE_LEGACY_TIMER
    Private write_ACCELERATE_LINK_FAIL_INHIBIT_TIMER_value
    Private read_ACCELERATE_LINK_FAIL_INHIBIT_TIMER_value
    Private flag_ACCELERATE_LINK_FAIL_INHIBIT_TIMER
    Private write_ACCELERATE_BREAK_LINK_TIMER_value
    Private read_ACCELERATE_BREAK_LINK_TIMER_value
    Private flag_ACCELERATE_BREAK_LINK_TIMER

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H102
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_AUTONEG_FORCE_RESOLUTION
        get_AUTONEG_FORCE_RESOLUTION = read_AUTONEG_FORCE_RESOLUTION_value
    End Property

    Property Let set_AUTONEG_FORCE_RESOLUTION(aData)
        write_AUTONEG_FORCE_RESOLUTION_value = aData
        flag_AUTONEG_FORCE_RESOLUTION        = &H1
    End Property

    Property Get read_AUTONEG_FORCE_RESOLUTION
        read
        read_AUTONEG_FORCE_RESOLUTION = read_AUTONEG_FORCE_RESOLUTION_value
    End Property

    Property Let write_AUTONEG_FORCE_RESOLUTION(aData)
        set_AUTONEG_FORCE_RESOLUTION = aData
        write
    End Property

    Property Get get_AUTONEG_FORCE_MASTER_SLAVE
        get_AUTONEG_FORCE_MASTER_SLAVE = read_AUTONEG_FORCE_MASTER_SLAVE_value
    End Property

    Property Let set_AUTONEG_FORCE_MASTER_SLAVE(aData)
        write_AUTONEG_FORCE_MASTER_SLAVE_value = aData
        flag_AUTONEG_FORCE_MASTER_SLAVE        = &H1
    End Property

    Property Get read_AUTONEG_FORCE_MASTER_SLAVE
        read
        read_AUTONEG_FORCE_MASTER_SLAVE = read_AUTONEG_FORCE_MASTER_SLAVE_value
    End Property

    Property Let write_AUTONEG_FORCE_MASTER_SLAVE(aData)
        set_AUTONEG_FORCE_MASTER_SLAVE = aData
        write
    End Property

    Property Get get_AUTONEG_FORCE_CONFIGURATION_FAULT
        get_AUTONEG_FORCE_CONFIGURATION_FAULT = read_AUTONEG_FORCE_CONFIGURATION_FAULT_value
    End Property

    Property Let set_AUTONEG_FORCE_CONFIGURATION_FAULT(aData)
        write_AUTONEG_FORCE_CONFIGURATION_FAULT_value = aData
        flag_AUTONEG_FORCE_CONFIGURATION_FAULT        = &H1
    End Property

    Property Get read_AUTONEG_FORCE_CONFIGURATION_FAULT
        read
        read_AUTONEG_FORCE_CONFIGURATION_FAULT = read_AUTONEG_FORCE_CONFIGURATION_FAULT_value
    End Property

    Property Let write_AUTONEG_FORCE_CONFIGURATION_FAULT(aData)
        set_AUTONEG_FORCE_CONFIGURATION_FAULT = aData
        write
    End Property

    Property Get get_AUTONEG_FORCE_LINK_CONTROL_1000T1
        get_AUTONEG_FORCE_LINK_CONTROL_1000T1 = read_AUTONEG_FORCE_LINK_CONTROL_1000T1_value
    End Property

    Property Let set_AUTONEG_FORCE_LINK_CONTROL_1000T1(aData)
        write_AUTONEG_FORCE_LINK_CONTROL_1000T1_value = aData
        flag_AUTONEG_FORCE_LINK_CONTROL_1000T1        = &H1
    End Property

    Property Get read_AUTONEG_FORCE_LINK_CONTROL_1000T1
        read
        read_AUTONEG_FORCE_LINK_CONTROL_1000T1 = read_AUTONEG_FORCE_LINK_CONTROL_1000T1_value
    End Property

    Property Let write_AUTONEG_FORCE_LINK_CONTROL_1000T1(aData)
        set_AUTONEG_FORCE_LINK_CONTROL_1000T1 = aData
        write
    End Property

    Property Get get_AUTONEG_FORCE_LINK_CONTROL_100T1
        get_AUTONEG_FORCE_LINK_CONTROL_100T1 = read_AUTONEG_FORCE_LINK_CONTROL_100T1_value
    End Property

    Property Let set_AUTONEG_FORCE_LINK_CONTROL_100T1(aData)
        write_AUTONEG_FORCE_LINK_CONTROL_100T1_value = aData
        flag_AUTONEG_FORCE_LINK_CONTROL_100T1        = &H1
    End Property

    Property Get read_AUTONEG_FORCE_LINK_CONTROL_100T1
        read
        read_AUTONEG_FORCE_LINK_CONTROL_100T1 = read_AUTONEG_FORCE_LINK_CONTROL_100T1_value
    End Property

    Property Let write_AUTONEG_FORCE_LINK_CONTROL_100T1(aData)
        set_AUTONEG_FORCE_LINK_CONTROL_100T1 = aData
        write
    End Property

    Property Get get_OVERRIDE_MS_RESOLUTION_FAULT
        get_OVERRIDE_MS_RESOLUTION_FAULT = read_OVERRIDE_MS_RESOLUTION_FAULT_value
    End Property

    Property Let set_OVERRIDE_MS_RESOLUTION_FAULT(aData)
        write_OVERRIDE_MS_RESOLUTION_FAULT_value = aData
        flag_OVERRIDE_MS_RESOLUTION_FAULT        = &H1
    End Property

    Property Get read_OVERRIDE_MS_RESOLUTION_FAULT
        read
        read_OVERRIDE_MS_RESOLUTION_FAULT = read_OVERRIDE_MS_RESOLUTION_FAULT_value
    End Property

    Property Let write_OVERRIDE_MS_RESOLUTION_FAULT(aData)
        set_OVERRIDE_MS_RESOLUTION_FAULT = aData
        write
    End Property

    Property Get get_OVERRIDE_RANDOM_POLARITY_VALUE
        get_OVERRIDE_RANDOM_POLARITY_VALUE = read_OVERRIDE_RANDOM_POLARITY_VALUE_value
    End Property

    Property Let set_OVERRIDE_RANDOM_POLARITY_VALUE(aData)
        write_OVERRIDE_RANDOM_POLARITY_VALUE_value = aData
        flag_OVERRIDE_RANDOM_POLARITY_VALUE        = &H1
    End Property

    Property Get read_OVERRIDE_RANDOM_POLARITY_VALUE
        read
        read_OVERRIDE_RANDOM_POLARITY_VALUE = read_OVERRIDE_RANDOM_POLARITY_VALUE_value
    End Property

    Property Let write_OVERRIDE_RANDOM_POLARITY_VALUE(aData)
        set_OVERRIDE_RANDOM_POLARITY_VALUE = aData
        write
    End Property

    Property Get get_OVERRIDE_RANDOM_POLARITY
        get_OVERRIDE_RANDOM_POLARITY = read_OVERRIDE_RANDOM_POLARITY_value
    End Property

    Property Let set_OVERRIDE_RANDOM_POLARITY(aData)
        write_OVERRIDE_RANDOM_POLARITY_value = aData
        flag_OVERRIDE_RANDOM_POLARITY        = &H1
    End Property

    Property Get read_OVERRIDE_RANDOM_POLARITY
        read
        read_OVERRIDE_RANDOM_POLARITY = read_OVERRIDE_RANDOM_POLARITY_value
    End Property

    Property Let write_OVERRIDE_RANDOM_POLARITY(aData)
        set_OVERRIDE_RANDOM_POLARITY = aData
        write
    End Property

    Property Get get_OVERRIDE_RANDOM_SEED_VALUE
        get_OVERRIDE_RANDOM_SEED_VALUE = read_OVERRIDE_RANDOM_SEED_VALUE_value
    End Property

    Property Let set_OVERRIDE_RANDOM_SEED_VALUE(aData)
        write_OVERRIDE_RANDOM_SEED_VALUE_value = aData
        flag_OVERRIDE_RANDOM_SEED_VALUE        = &H1
    End Property

    Property Get read_OVERRIDE_RANDOM_SEED_VALUE
        read
        read_OVERRIDE_RANDOM_SEED_VALUE = read_OVERRIDE_RANDOM_SEED_VALUE_value
    End Property

    Property Let write_OVERRIDE_RANDOM_SEED_VALUE(aData)
        set_OVERRIDE_RANDOM_SEED_VALUE = aData
        write
    End Property

    Property Get get_OVERRIDE_RANDOM_SEED
        get_OVERRIDE_RANDOM_SEED = read_OVERRIDE_RANDOM_SEED_value
    End Property

    Property Let set_OVERRIDE_RANDOM_SEED(aData)
        write_OVERRIDE_RANDOM_SEED_value = aData
        flag_OVERRIDE_RANDOM_SEED        = &H1
    End Property

    Property Get read_OVERRIDE_RANDOM_SEED
        read
        read_OVERRIDE_RANDOM_SEED = read_OVERRIDE_RANDOM_SEED_value
    End Property

    Property Let write_OVERRIDE_RANDOM_SEED(aData)
        set_OVERRIDE_RANDOM_SEED = aData
        write
    End Property

    Property Get get_ACCELERATE_LEGACY_TIMER
        get_ACCELERATE_LEGACY_TIMER = read_ACCELERATE_LEGACY_TIMER_value
    End Property

    Property Let set_ACCELERATE_LEGACY_TIMER(aData)
        write_ACCELERATE_LEGACY_TIMER_value = aData
        flag_ACCELERATE_LEGACY_TIMER        = &H1
    End Property

    Property Get read_ACCELERATE_LEGACY_TIMER
        read
        read_ACCELERATE_LEGACY_TIMER = read_ACCELERATE_LEGACY_TIMER_value
    End Property

    Property Let write_ACCELERATE_LEGACY_TIMER(aData)
        set_ACCELERATE_LEGACY_TIMER = aData
        write
    End Property

    Property Get get_ACCELERATE_LINK_FAIL_INHIBIT_TIMER
        get_ACCELERATE_LINK_FAIL_INHIBIT_TIMER = read_ACCELERATE_LINK_FAIL_INHIBIT_TIMER_value
    End Property

    Property Let set_ACCELERATE_LINK_FAIL_INHIBIT_TIMER(aData)
        write_ACCELERATE_LINK_FAIL_INHIBIT_TIMER_value = aData
        flag_ACCELERATE_LINK_FAIL_INHIBIT_TIMER        = &H1
    End Property

    Property Get read_ACCELERATE_LINK_FAIL_INHIBIT_TIMER
        read
        read_ACCELERATE_LINK_FAIL_INHIBIT_TIMER = read_ACCELERATE_LINK_FAIL_INHIBIT_TIMER_value
    End Property

    Property Let write_ACCELERATE_LINK_FAIL_INHIBIT_TIMER(aData)
        set_ACCELERATE_LINK_FAIL_INHIBIT_TIMER = aData
        write
    End Property

    Property Get get_ACCELERATE_BREAK_LINK_TIMER
        get_ACCELERATE_BREAK_LINK_TIMER = read_ACCELERATE_BREAK_LINK_TIMER_value
    End Property

    Property Let set_ACCELERATE_BREAK_LINK_TIMER(aData)
        write_ACCELERATE_BREAK_LINK_TIMER_value = aData
        flag_ACCELERATE_BREAK_LINK_TIMER        = &H1
    End Property

    Property Get read_ACCELERATE_BREAK_LINK_TIMER
        read
        read_ACCELERATE_BREAK_LINK_TIMER = read_ACCELERATE_BREAK_LINK_TIMER_value
    End Property

    Property Let write_ACCELERATE_BREAK_LINK_TIMER(aData)
        set_ACCELERATE_BREAK_LINK_TIMER = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_AUTONEG_FORCE_RESOLUTION_value = rightShift(data_low, 15) and &H1
        read_AUTONEG_FORCE_MASTER_SLAVE_value = rightShift(data_low, 14) and &H1
        read_AUTONEG_FORCE_CONFIGURATION_FAULT_value = rightShift(data_low, 13) and &H1
        read_AUTONEG_FORCE_LINK_CONTROL_1000T1_value = rightShift(data_low, 12) and &H1
        read_AUTONEG_FORCE_LINK_CONTROL_100T1_value = rightShift(data_low, 11) and &H1
        read_OVERRIDE_MS_RESOLUTION_FAULT_value = rightShift(data_low, 10) and &H1
        read_OVERRIDE_RANDOM_POLARITY_VALUE_value = rightShift(data_low, 9) and &H1
        read_OVERRIDE_RANDOM_POLARITY_value = rightShift(data_low, 8) and &H1
        read_OVERRIDE_RANDOM_SEED_VALUE_value = rightShift(data_low, 4) and &Hf
        read_OVERRIDE_RANDOM_SEED_value = rightShift(data_low, 3) and &H1
        read_ACCELERATE_LEGACY_TIMER_value = rightShift(data_low, 2) and &H1
        read_ACCELERATE_LINK_FAIL_INHIBIT_TIMER_value = rightShift(data_low, 1) and &H1
        ACCELERATE_BREAK_LINK_TIMER_mask = &H1
        if data_low > LONG_MAX then
            if ACCELERATE_BREAK_LINK_TIMER_mask = mask then
                read_ACCELERATE_BREAK_LINK_TIMER_value = data_low
            else
                read_ACCELERATE_BREAK_LINK_TIMER_value = (data_low - H8000_0000) and ACCELERATE_BREAK_LINK_TIMER_mask
            end If
        else
            read_ACCELERATE_BREAK_LINK_TIMER_value = data_low and ACCELERATE_BREAK_LINK_TIMER_mask
        end If

    End Sub

    Sub write
        If flag_AUTONEG_FORCE_RESOLUTION = &H0 or flag_AUTONEG_FORCE_MASTER_SLAVE = &H0 or flag_AUTONEG_FORCE_CONFIGURATION_FAULT = &H0 or flag_AUTONEG_FORCE_LINK_CONTROL_1000T1 = &H0 or flag_AUTONEG_FORCE_LINK_CONTROL_100T1 = &H0 or flag_OVERRIDE_MS_RESOLUTION_FAULT = &H0 or flag_OVERRIDE_RANDOM_POLARITY_VALUE = &H0 or flag_OVERRIDE_RANDOM_POLARITY = &H0 or flag_OVERRIDE_RANDOM_SEED_VALUE = &H0 or flag_OVERRIDE_RANDOM_SEED = &H0 or flag_ACCELERATE_LEGACY_TIMER = &H0 or flag_ACCELERATE_LINK_FAIL_INHIBIT_TIMER = &H0 or flag_ACCELERATE_BREAK_LINK_TIMER = &H0 Then read
        If flag_AUTONEG_FORCE_RESOLUTION = &H0 Then write_AUTONEG_FORCE_RESOLUTION_value = get_AUTONEG_FORCE_RESOLUTION
        If flag_AUTONEG_FORCE_MASTER_SLAVE = &H0 Then write_AUTONEG_FORCE_MASTER_SLAVE_value = get_AUTONEG_FORCE_MASTER_SLAVE
        If flag_AUTONEG_FORCE_CONFIGURATION_FAULT = &H0 Then write_AUTONEG_FORCE_CONFIGURATION_FAULT_value = get_AUTONEG_FORCE_CONFIGURATION_FAULT
        If flag_AUTONEG_FORCE_LINK_CONTROL_1000T1 = &H0 Then write_AUTONEG_FORCE_LINK_CONTROL_1000T1_value = get_AUTONEG_FORCE_LINK_CONTROL_1000T1
        If flag_AUTONEG_FORCE_LINK_CONTROL_100T1 = &H0 Then write_AUTONEG_FORCE_LINK_CONTROL_100T1_value = get_AUTONEG_FORCE_LINK_CONTROL_100T1
        If flag_OVERRIDE_MS_RESOLUTION_FAULT = &H0 Then write_OVERRIDE_MS_RESOLUTION_FAULT_value = get_OVERRIDE_MS_RESOLUTION_FAULT
        If flag_OVERRIDE_RANDOM_POLARITY_VALUE = &H0 Then write_OVERRIDE_RANDOM_POLARITY_VALUE_value = get_OVERRIDE_RANDOM_POLARITY_VALUE
        If flag_OVERRIDE_RANDOM_POLARITY = &H0 Then write_OVERRIDE_RANDOM_POLARITY_value = get_OVERRIDE_RANDOM_POLARITY
        If flag_OVERRIDE_RANDOM_SEED_VALUE = &H0 Then write_OVERRIDE_RANDOM_SEED_VALUE_value = get_OVERRIDE_RANDOM_SEED_VALUE
        If flag_OVERRIDE_RANDOM_SEED = &H0 Then write_OVERRIDE_RANDOM_SEED_value = get_OVERRIDE_RANDOM_SEED
        If flag_ACCELERATE_LEGACY_TIMER = &H0 Then write_ACCELERATE_LEGACY_TIMER_value = get_ACCELERATE_LEGACY_TIMER
        If flag_ACCELERATE_LINK_FAIL_INHIBIT_TIMER = &H0 Then write_ACCELERATE_LINK_FAIL_INHIBIT_TIMER_value = get_ACCELERATE_LINK_FAIL_INHIBIT_TIMER
        If flag_ACCELERATE_BREAK_LINK_TIMER = &H0 Then write_ACCELERATE_BREAK_LINK_TIMER_value = get_ACCELERATE_BREAK_LINK_TIMER

        regValue = leftShift((write_AUTONEG_FORCE_RESOLUTION_value and &H1), 15) + leftShift((write_AUTONEG_FORCE_MASTER_SLAVE_value and &H1), 14) + leftShift((write_AUTONEG_FORCE_CONFIGURATION_FAULT_value and &H1), 13) + leftShift((write_AUTONEG_FORCE_LINK_CONTROL_1000T1_value and &H1), 12) + leftShift((write_AUTONEG_FORCE_LINK_CONTROL_100T1_value and &H1), 11) + leftShift((write_OVERRIDE_MS_RESOLUTION_FAULT_value and &H1), 10) + leftShift((write_OVERRIDE_RANDOM_POLARITY_VALUE_value and &H1), 9) + leftShift((write_OVERRIDE_RANDOM_POLARITY_value and &H1), 8) + leftShift((write_OVERRIDE_RANDOM_SEED_VALUE_value and &Hf), 4) + leftShift((write_OVERRIDE_RANDOM_SEED_value and &H1), 3) + leftShift((write_ACCELERATE_LEGACY_TIMER_value and &H1), 2) + leftShift((write_ACCELERATE_LINK_FAIL_INHIBIT_TIMER_value and &H1), 1) + leftShift((write_ACCELERATE_BREAK_LINK_TIMER_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_AUTONEG_FORCE_RESOLUTION_value = rightShift(data_low, 15) and &H1
        read_AUTONEG_FORCE_MASTER_SLAVE_value = rightShift(data_low, 14) and &H1
        read_AUTONEG_FORCE_CONFIGURATION_FAULT_value = rightShift(data_low, 13) and &H1
        read_AUTONEG_FORCE_LINK_CONTROL_1000T1_value = rightShift(data_low, 12) and &H1
        read_AUTONEG_FORCE_LINK_CONTROL_100T1_value = rightShift(data_low, 11) and &H1
        read_OVERRIDE_MS_RESOLUTION_FAULT_value = rightShift(data_low, 10) and &H1
        read_OVERRIDE_RANDOM_POLARITY_VALUE_value = rightShift(data_low, 9) and &H1
        read_OVERRIDE_RANDOM_POLARITY_value = rightShift(data_low, 8) and &H1
        read_OVERRIDE_RANDOM_SEED_VALUE_value = rightShift(data_low, 4) and &Hf
        read_OVERRIDE_RANDOM_SEED_value = rightShift(data_low, 3) and &H1
        read_ACCELERATE_LEGACY_TIMER_value = rightShift(data_low, 2) and &H1
        read_ACCELERATE_LINK_FAIL_INHIBIT_TIMER_value = rightShift(data_low, 1) and &H1
        ACCELERATE_BREAK_LINK_TIMER_mask = &H1
        if data_low > LONG_MAX then
            if ACCELERATE_BREAK_LINK_TIMER_mask = mask then
                read_ACCELERATE_BREAK_LINK_TIMER_value = data_low
            else
                read_ACCELERATE_BREAK_LINK_TIMER_value = (data_low - H8000_0000) and ACCELERATE_BREAK_LINK_TIMER_mask
            end If
        else
            read_ACCELERATE_BREAK_LINK_TIMER_value = data_low and ACCELERATE_BREAK_LINK_TIMER_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_AUTONEG_FORCE_RESOLUTION_value = &H0
        flag_AUTONEG_FORCE_RESOLUTION        = &H0
        write_AUTONEG_FORCE_MASTER_SLAVE_value = &H0
        flag_AUTONEG_FORCE_MASTER_SLAVE        = &H0
        write_AUTONEG_FORCE_CONFIGURATION_FAULT_value = &H0
        flag_AUTONEG_FORCE_CONFIGURATION_FAULT        = &H0
        write_AUTONEG_FORCE_LINK_CONTROL_1000T1_value = &H0
        flag_AUTONEG_FORCE_LINK_CONTROL_1000T1        = &H0
        write_AUTONEG_FORCE_LINK_CONTROL_100T1_value = &H0
        flag_AUTONEG_FORCE_LINK_CONTROL_100T1        = &H0
        write_OVERRIDE_MS_RESOLUTION_FAULT_value = &H0
        flag_OVERRIDE_MS_RESOLUTION_FAULT        = &H0
        write_OVERRIDE_RANDOM_POLARITY_VALUE_value = &H0
        flag_OVERRIDE_RANDOM_POLARITY_VALUE        = &H0
        write_OVERRIDE_RANDOM_POLARITY_value = &H0
        flag_OVERRIDE_RANDOM_POLARITY        = &H0
        write_OVERRIDE_RANDOM_SEED_VALUE_value = &H0
        flag_OVERRIDE_RANDOM_SEED_VALUE        = &H0
        write_OVERRIDE_RANDOM_SEED_value = &H0
        flag_OVERRIDE_RANDOM_SEED        = &H0
        write_ACCELERATE_LEGACY_TIMER_value = &H0
        flag_ACCELERATE_LEGACY_TIMER        = &H0
        write_ACCELERATE_LINK_FAIL_INHIBIT_TIMER_value = &H0
        flag_ACCELERATE_LINK_FAIL_INHIBIT_TIMER        = &H0
        write_ACCELERATE_BREAK_LINK_TIMER_value = &H0
        flag_ACCELERATE_BREAK_LINK_TIMER        = &H0
    End Sub
End Class


'' @REGISTER : CL45VEN_autoneg_test_reg2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MR_AUTONEG_COMPLETE                        [15:15]          get_MR_AUTONEG_COMPLETE
''                                                             set_MR_AUTONEG_COMPLETE
''                                                             read_MR_AUTONEG_COMPLETE
''                                                             write_MR_AUTONEG_COMPLETE
''---------------------------------------------------------------------------------
'' AUTONEG_WIRESPEED_COUNT                    [14:12]          get_AUTONEG_WIRESPEED_COUNT
''                                                             set_AUTONEG_WIRESPEED_COUNT
''                                                             read_AUTONEG_WIRESPEED_COUNT
''                                                             write_AUTONEG_WIRESPEED_COUNT
''---------------------------------------------------------------------------------
'' AUTONEG_WIRESPEED_DOWNGRADE                [11:11]          get_AUTONEG_WIRESPEED_DOWNGRADE
''                                                             set_AUTONEG_WIRESPEED_DOWNGRADE
''                                                             read_AUTONEG_WIRESPEED_DOWNGRADE
''                                                             write_AUTONEG_WIRESPEED_DOWNGRADE
''---------------------------------------------------------------------------------
'' AUTONEG_LINK_GOOD_CHECK                    [10:10]          get_AUTONEG_LINK_GOOD_CHECK
''                                                             set_AUTONEG_LINK_GOOD_CHECK
''                                                             read_AUTONEG_LINK_GOOD_CHECK
''                                                             write_AUTONEG_LINK_GOOD_CHECK
''---------------------------------------------------------------------------------
'' CONFIGURATION_FAULT                        [9:9]            get_CONFIGURATION_FAULT
''                                                             set_CONFIGURATION_FAULT
''                                                             read_CONFIGURATION_FAULT
''                                                             write_CONFIGURATION_FAULT
''---------------------------------------------------------------------------------
'' MASTER_SLAVE                               [8:8]            get_MASTER_SLAVE
''                                                             set_MASTER_SLAVE
''                                                             read_MASTER_SLAVE
''                                                             write_MASTER_SLAVE
''---------------------------------------------------------------------------------
'' ASMCS1                                     [7:4]            get_ASMCS1
''                                                             set_ASMCS1
''                                                             read_ASMCS1
''                                                             write_ASMCS1
''---------------------------------------------------------------------------------
'' HIGHEST_COMMON_DENOMINATOR                 [3:0]            get_HIGHEST_COMMON_DENOMINATOR
''                                                             set_HIGHEST_COMMON_DENOMINATOR
''                                                             read_HIGHEST_COMMON_DENOMINATOR
''                                                             write_HIGHEST_COMMON_DENOMINATOR
''---------------------------------------------------------------------------------
Class REGISTER_CL45VEN_autoneg_test_reg2
    Private write_MR_AUTONEG_COMPLETE_value
    Private read_MR_AUTONEG_COMPLETE_value
    Private flag_MR_AUTONEG_COMPLETE
    Private write_AUTONEG_WIRESPEED_COUNT_value
    Private read_AUTONEG_WIRESPEED_COUNT_value
    Private flag_AUTONEG_WIRESPEED_COUNT
    Private write_AUTONEG_WIRESPEED_DOWNGRADE_value
    Private read_AUTONEG_WIRESPEED_DOWNGRADE_value
    Private flag_AUTONEG_WIRESPEED_DOWNGRADE
    Private write_AUTONEG_LINK_GOOD_CHECK_value
    Private read_AUTONEG_LINK_GOOD_CHECK_value
    Private flag_AUTONEG_LINK_GOOD_CHECK
    Private write_CONFIGURATION_FAULT_value
    Private read_CONFIGURATION_FAULT_value
    Private flag_CONFIGURATION_FAULT
    Private write_MASTER_SLAVE_value
    Private read_MASTER_SLAVE_value
    Private flag_MASTER_SLAVE
    Private write_ASMCS1_value
    Private read_ASMCS1_value
    Private flag_ASMCS1
    Private write_HIGHEST_COMMON_DENOMINATOR_value
    Private read_HIGHEST_COMMON_DENOMINATOR_value
    Private flag_HIGHEST_COMMON_DENOMINATOR

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

    Property Get get_MR_AUTONEG_COMPLETE
        get_MR_AUTONEG_COMPLETE = read_MR_AUTONEG_COMPLETE_value
    End Property

    Property Let set_MR_AUTONEG_COMPLETE(aData)
        write_MR_AUTONEG_COMPLETE_value = aData
        flag_MR_AUTONEG_COMPLETE        = &H1
    End Property

    Property Get read_MR_AUTONEG_COMPLETE
        read
        read_MR_AUTONEG_COMPLETE = read_MR_AUTONEG_COMPLETE_value
    End Property

    Property Let write_MR_AUTONEG_COMPLETE(aData)
        set_MR_AUTONEG_COMPLETE = aData
        write
    End Property

    Property Get get_AUTONEG_WIRESPEED_COUNT
        get_AUTONEG_WIRESPEED_COUNT = read_AUTONEG_WIRESPEED_COUNT_value
    End Property

    Property Let set_AUTONEG_WIRESPEED_COUNT(aData)
        write_AUTONEG_WIRESPEED_COUNT_value = aData
        flag_AUTONEG_WIRESPEED_COUNT        = &H1
    End Property

    Property Get read_AUTONEG_WIRESPEED_COUNT
        read
        read_AUTONEG_WIRESPEED_COUNT = read_AUTONEG_WIRESPEED_COUNT_value
    End Property

    Property Let write_AUTONEG_WIRESPEED_COUNT(aData)
        set_AUTONEG_WIRESPEED_COUNT = aData
        write
    End Property

    Property Get get_AUTONEG_WIRESPEED_DOWNGRADE
        get_AUTONEG_WIRESPEED_DOWNGRADE = read_AUTONEG_WIRESPEED_DOWNGRADE_value
    End Property

    Property Let set_AUTONEG_WIRESPEED_DOWNGRADE(aData)
        write_AUTONEG_WIRESPEED_DOWNGRADE_value = aData
        flag_AUTONEG_WIRESPEED_DOWNGRADE        = &H1
    End Property

    Property Get read_AUTONEG_WIRESPEED_DOWNGRADE
        read
        read_AUTONEG_WIRESPEED_DOWNGRADE = read_AUTONEG_WIRESPEED_DOWNGRADE_value
    End Property

    Property Let write_AUTONEG_WIRESPEED_DOWNGRADE(aData)
        set_AUTONEG_WIRESPEED_DOWNGRADE = aData
        write
    End Property

    Property Get get_AUTONEG_LINK_GOOD_CHECK
        get_AUTONEG_LINK_GOOD_CHECK = read_AUTONEG_LINK_GOOD_CHECK_value
    End Property

    Property Let set_AUTONEG_LINK_GOOD_CHECK(aData)
        write_AUTONEG_LINK_GOOD_CHECK_value = aData
        flag_AUTONEG_LINK_GOOD_CHECK        = &H1
    End Property

    Property Get read_AUTONEG_LINK_GOOD_CHECK
        read
        read_AUTONEG_LINK_GOOD_CHECK = read_AUTONEG_LINK_GOOD_CHECK_value
    End Property

    Property Let write_AUTONEG_LINK_GOOD_CHECK(aData)
        set_AUTONEG_LINK_GOOD_CHECK = aData
        write
    End Property

    Property Get get_CONFIGURATION_FAULT
        get_CONFIGURATION_FAULT = read_CONFIGURATION_FAULT_value
    End Property

    Property Let set_CONFIGURATION_FAULT(aData)
        write_CONFIGURATION_FAULT_value = aData
        flag_CONFIGURATION_FAULT        = &H1
    End Property

    Property Get read_CONFIGURATION_FAULT
        read
        read_CONFIGURATION_FAULT = read_CONFIGURATION_FAULT_value
    End Property

    Property Let write_CONFIGURATION_FAULT(aData)
        set_CONFIGURATION_FAULT = aData
        write
    End Property

    Property Get get_MASTER_SLAVE
        get_MASTER_SLAVE = read_MASTER_SLAVE_value
    End Property

    Property Let set_MASTER_SLAVE(aData)
        write_MASTER_SLAVE_value = aData
        flag_MASTER_SLAVE        = &H1
    End Property

    Property Get read_MASTER_SLAVE
        read
        read_MASTER_SLAVE = read_MASTER_SLAVE_value
    End Property

    Property Let write_MASTER_SLAVE(aData)
        set_MASTER_SLAVE = aData
        write
    End Property

    Property Get get_ASMCS1
        get_ASMCS1 = read_ASMCS1_value
    End Property

    Property Let set_ASMCS1(aData)
        write_ASMCS1_value = aData
        flag_ASMCS1        = &H1
    End Property

    Property Get read_ASMCS1
        read
        read_ASMCS1 = read_ASMCS1_value
    End Property

    Property Let write_ASMCS1(aData)
        set_ASMCS1 = aData
        write
    End Property

    Property Get get_HIGHEST_COMMON_DENOMINATOR
        get_HIGHEST_COMMON_DENOMINATOR = read_HIGHEST_COMMON_DENOMINATOR_value
    End Property

    Property Let set_HIGHEST_COMMON_DENOMINATOR(aData)
        write_HIGHEST_COMMON_DENOMINATOR_value = aData
        flag_HIGHEST_COMMON_DENOMINATOR        = &H1
    End Property

    Property Get read_HIGHEST_COMMON_DENOMINATOR
        read
        read_HIGHEST_COMMON_DENOMINATOR = read_HIGHEST_COMMON_DENOMINATOR_value
    End Property

    Property Let write_HIGHEST_COMMON_DENOMINATOR(aData)
        set_HIGHEST_COMMON_DENOMINATOR = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MR_AUTONEG_COMPLETE_value = rightShift(data_low, 15) and &H1
        read_AUTONEG_WIRESPEED_COUNT_value = rightShift(data_low, 12) and &H7
        read_AUTONEG_WIRESPEED_DOWNGRADE_value = rightShift(data_low, 11) and &H1
        read_AUTONEG_LINK_GOOD_CHECK_value = rightShift(data_low, 10) and &H1
        read_CONFIGURATION_FAULT_value = rightShift(data_low, 9) and &H1
        read_MASTER_SLAVE_value = rightShift(data_low, 8) and &H1
        read_ASMCS1_value = rightShift(data_low, 4) and &Hf
        HIGHEST_COMMON_DENOMINATOR_mask = &Hf
        if data_low > LONG_MAX then
            if HIGHEST_COMMON_DENOMINATOR_mask = mask then
                read_HIGHEST_COMMON_DENOMINATOR_value = data_low
            else
                read_HIGHEST_COMMON_DENOMINATOR_value = (data_low - H8000_0000) and HIGHEST_COMMON_DENOMINATOR_mask
            end If
        else
            read_HIGHEST_COMMON_DENOMINATOR_value = data_low and HIGHEST_COMMON_DENOMINATOR_mask
        end If

    End Sub

    Sub write
        If flag_MR_AUTONEG_COMPLETE = &H0 or flag_AUTONEG_WIRESPEED_COUNT = &H0 or flag_AUTONEG_WIRESPEED_DOWNGRADE = &H0 or flag_AUTONEG_LINK_GOOD_CHECK = &H0 or flag_CONFIGURATION_FAULT = &H0 or flag_MASTER_SLAVE = &H0 or flag_ASMCS1 = &H0 or flag_HIGHEST_COMMON_DENOMINATOR = &H0 Then read
        If flag_MR_AUTONEG_COMPLETE = &H0 Then write_MR_AUTONEG_COMPLETE_value = get_MR_AUTONEG_COMPLETE
        If flag_AUTONEG_WIRESPEED_COUNT = &H0 Then write_AUTONEG_WIRESPEED_COUNT_value = get_AUTONEG_WIRESPEED_COUNT
        If flag_AUTONEG_WIRESPEED_DOWNGRADE = &H0 Then write_AUTONEG_WIRESPEED_DOWNGRADE_value = get_AUTONEG_WIRESPEED_DOWNGRADE
        If flag_AUTONEG_LINK_GOOD_CHECK = &H0 Then write_AUTONEG_LINK_GOOD_CHECK_value = get_AUTONEG_LINK_GOOD_CHECK
        If flag_CONFIGURATION_FAULT = &H0 Then write_CONFIGURATION_FAULT_value = get_CONFIGURATION_FAULT
        If flag_MASTER_SLAVE = &H0 Then write_MASTER_SLAVE_value = get_MASTER_SLAVE
        If flag_ASMCS1 = &H0 Then write_ASMCS1_value = get_ASMCS1
        If flag_HIGHEST_COMMON_DENOMINATOR = &H0 Then write_HIGHEST_COMMON_DENOMINATOR_value = get_HIGHEST_COMMON_DENOMINATOR

        regValue = leftShift((write_MR_AUTONEG_COMPLETE_value and &H1), 15) + leftShift((write_AUTONEG_WIRESPEED_COUNT_value and &H7), 12) + leftShift((write_AUTONEG_WIRESPEED_DOWNGRADE_value and &H1), 11) + leftShift((write_AUTONEG_LINK_GOOD_CHECK_value and &H1), 10) + leftShift((write_CONFIGURATION_FAULT_value and &H1), 9) + leftShift((write_MASTER_SLAVE_value and &H1), 8) + leftShift((write_ASMCS1_value and &Hf), 4) + leftShift((write_HIGHEST_COMMON_DENOMINATOR_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MR_AUTONEG_COMPLETE_value = rightShift(data_low, 15) and &H1
        read_AUTONEG_WIRESPEED_COUNT_value = rightShift(data_low, 12) and &H7
        read_AUTONEG_WIRESPEED_DOWNGRADE_value = rightShift(data_low, 11) and &H1
        read_AUTONEG_LINK_GOOD_CHECK_value = rightShift(data_low, 10) and &H1
        read_CONFIGURATION_FAULT_value = rightShift(data_low, 9) and &H1
        read_MASTER_SLAVE_value = rightShift(data_low, 8) and &H1
        read_ASMCS1_value = rightShift(data_low, 4) and &Hf
        HIGHEST_COMMON_DENOMINATOR_mask = &Hf
        if data_low > LONG_MAX then
            if HIGHEST_COMMON_DENOMINATOR_mask = mask then
                read_HIGHEST_COMMON_DENOMINATOR_value = data_low
            else
                read_HIGHEST_COMMON_DENOMINATOR_value = (data_low - H8000_0000) and HIGHEST_COMMON_DENOMINATOR_mask
            end If
        else
            read_HIGHEST_COMMON_DENOMINATOR_value = data_low and HIGHEST_COMMON_DENOMINATOR_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MR_AUTONEG_COMPLETE_value = &H0
        flag_MR_AUTONEG_COMPLETE        = &H0
        write_AUTONEG_WIRESPEED_COUNT_value = &H0
        flag_AUTONEG_WIRESPEED_COUNT        = &H0
        write_AUTONEG_WIRESPEED_DOWNGRADE_value = &H0
        flag_AUTONEG_WIRESPEED_DOWNGRADE        = &H0
        write_AUTONEG_LINK_GOOD_CHECK_value = &H0
        flag_AUTONEG_LINK_GOOD_CHECK        = &H0
        write_CONFIGURATION_FAULT_value = &H0
        flag_CONFIGURATION_FAULT        = &H0
        write_MASTER_SLAVE_value = &H0
        flag_MASTER_SLAVE        = &H0
        write_ASMCS1_value = &H0
        flag_ASMCS1        = &H0
        write_HIGHEST_COMMON_DENOMINATOR_value = &H0
        flag_HIGHEST_COMMON_DENOMINATOR        = &H0
    End Sub
End Class


'' @REGISTER : CL45VEN_autoneg_test_reg3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DETECT_LEGACY_100T1                        [15:15]          get_DETECT_LEGACY_100T1
''                                                             set_DETECT_LEGACY_100T1
''                                                             read_DETECT_LEGACY_100T1
''                                                             write_DETECT_LEGACY_100T1
''---------------------------------------------------------------------------------
'' DETECT_TRANSITION                          [14:14]          get_DETECT_TRANSITION
''                                                             set_DETECT_TRANSITION
''                                                             read_DETECT_TRANSITION
''                                                             write_DETECT_TRANSITION
''---------------------------------------------------------------------------------
'' DETECT_MV_END                              [13:13]          get_DETECT_MV_END
''                                                             set_DETECT_MV_END
''                                                             read_DETECT_MV_END
''                                                             write_DETECT_MV_END
''---------------------------------------------------------------------------------
'' DETECT_MV_START                            [12:12]          get_DETECT_MV_START
''                                                             set_DETECT_MV_START
''                                                             read_DETECT_MV_START
''                                                             write_DETECT_MV_START
''---------------------------------------------------------------------------------
'' DETECT_POLARITY                            [11:11]          get_DETECT_POLARITY
''                                                             set_DETECT_POLARITY
''                                                             read_DETECT_POLARITY
''                                                             write_DETECT_POLARITY
''---------------------------------------------------------------------------------
'' RX_STATE_MACHINE_CURRENT_STATE             [10:8]           get_RX_STATE_MACHINE_CURRENT_STATE
''                                                             set_RX_STATE_MACHINE_CURRENT_STATE
''                                                             read_RX_STATE_MACHINE_CURRENT_STATE
''                                                             write_RX_STATE_MACHINE_CURRENT_STATE
''---------------------------------------------------------------------------------
'' LP_AUTONEG_ABLE                            [7:7]            get_LP_AUTONEG_ABLE
''                                                             set_LP_AUTONEG_ABLE
''                                                             read_LP_AUTONEG_ABLE
''                                                             write_LP_AUTONEG_ABLE
''---------------------------------------------------------------------------------
'' TX_STATE_MACHINE_CURRENT_STATE             [6:4]            get_TX_STATE_MACHINE_CURRENT_STATE
''                                                             set_TX_STATE_MACHINE_CURRENT_STATE
''                                                             read_TX_STATE_MACHINE_CURRENT_STATE
''                                                             write_TX_STATE_MACHINE_CURRENT_STATE
''---------------------------------------------------------------------------------
'' HDX_STATE_MACHINE_CURRENT_STATE            [3:0]            get_HDX_STATE_MACHINE_CURRENT_STATE
''                                                             set_HDX_STATE_MACHINE_CURRENT_STATE
''                                                             read_HDX_STATE_MACHINE_CURRENT_STATE
''                                                             write_HDX_STATE_MACHINE_CURRENT_STATE
''---------------------------------------------------------------------------------
Class REGISTER_CL45VEN_autoneg_test_reg3
    Private write_DETECT_LEGACY_100T1_value
    Private read_DETECT_LEGACY_100T1_value
    Private flag_DETECT_LEGACY_100T1
    Private write_DETECT_TRANSITION_value
    Private read_DETECT_TRANSITION_value
    Private flag_DETECT_TRANSITION
    Private write_DETECT_MV_END_value
    Private read_DETECT_MV_END_value
    Private flag_DETECT_MV_END
    Private write_DETECT_MV_START_value
    Private read_DETECT_MV_START_value
    Private flag_DETECT_MV_START
    Private write_DETECT_POLARITY_value
    Private read_DETECT_POLARITY_value
    Private flag_DETECT_POLARITY
    Private write_RX_STATE_MACHINE_CURRENT_STATE_value
    Private read_RX_STATE_MACHINE_CURRENT_STATE_value
    Private flag_RX_STATE_MACHINE_CURRENT_STATE
    Private write_LP_AUTONEG_ABLE_value
    Private read_LP_AUTONEG_ABLE_value
    Private flag_LP_AUTONEG_ABLE
    Private write_TX_STATE_MACHINE_CURRENT_STATE_value
    Private read_TX_STATE_MACHINE_CURRENT_STATE_value
    Private flag_TX_STATE_MACHINE_CURRENT_STATE
    Private write_HDX_STATE_MACHINE_CURRENT_STATE_value
    Private read_HDX_STATE_MACHINE_CURRENT_STATE_value
    Private flag_HDX_STATE_MACHINE_CURRENT_STATE

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H106
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_DETECT_LEGACY_100T1
        get_DETECT_LEGACY_100T1 = read_DETECT_LEGACY_100T1_value
    End Property

    Property Let set_DETECT_LEGACY_100T1(aData)
        write_DETECT_LEGACY_100T1_value = aData
        flag_DETECT_LEGACY_100T1        = &H1
    End Property

    Property Get read_DETECT_LEGACY_100T1
        read
        read_DETECT_LEGACY_100T1 = read_DETECT_LEGACY_100T1_value
    End Property

    Property Let write_DETECT_LEGACY_100T1(aData)
        set_DETECT_LEGACY_100T1 = aData
        write
    End Property

    Property Get get_DETECT_TRANSITION
        get_DETECT_TRANSITION = read_DETECT_TRANSITION_value
    End Property

    Property Let set_DETECT_TRANSITION(aData)
        write_DETECT_TRANSITION_value = aData
        flag_DETECT_TRANSITION        = &H1
    End Property

    Property Get read_DETECT_TRANSITION
        read
        read_DETECT_TRANSITION = read_DETECT_TRANSITION_value
    End Property

    Property Let write_DETECT_TRANSITION(aData)
        set_DETECT_TRANSITION = aData
        write
    End Property

    Property Get get_DETECT_MV_END
        get_DETECT_MV_END = read_DETECT_MV_END_value
    End Property

    Property Let set_DETECT_MV_END(aData)
        write_DETECT_MV_END_value = aData
        flag_DETECT_MV_END        = &H1
    End Property

    Property Get read_DETECT_MV_END
        read
        read_DETECT_MV_END = read_DETECT_MV_END_value
    End Property

    Property Let write_DETECT_MV_END(aData)
        set_DETECT_MV_END = aData
        write
    End Property

    Property Get get_DETECT_MV_START
        get_DETECT_MV_START = read_DETECT_MV_START_value
    End Property

    Property Let set_DETECT_MV_START(aData)
        write_DETECT_MV_START_value = aData
        flag_DETECT_MV_START        = &H1
    End Property

    Property Get read_DETECT_MV_START
        read
        read_DETECT_MV_START = read_DETECT_MV_START_value
    End Property

    Property Let write_DETECT_MV_START(aData)
        set_DETECT_MV_START = aData
        write
    End Property

    Property Get get_DETECT_POLARITY
        get_DETECT_POLARITY = read_DETECT_POLARITY_value
    End Property

    Property Let set_DETECT_POLARITY(aData)
        write_DETECT_POLARITY_value = aData
        flag_DETECT_POLARITY        = &H1
    End Property

    Property Get read_DETECT_POLARITY
        read
        read_DETECT_POLARITY = read_DETECT_POLARITY_value
    End Property

    Property Let write_DETECT_POLARITY(aData)
        set_DETECT_POLARITY = aData
        write
    End Property

    Property Get get_RX_STATE_MACHINE_CURRENT_STATE
        get_RX_STATE_MACHINE_CURRENT_STATE = read_RX_STATE_MACHINE_CURRENT_STATE_value
    End Property

    Property Let set_RX_STATE_MACHINE_CURRENT_STATE(aData)
        write_RX_STATE_MACHINE_CURRENT_STATE_value = aData
        flag_RX_STATE_MACHINE_CURRENT_STATE        = &H1
    End Property

    Property Get read_RX_STATE_MACHINE_CURRENT_STATE
        read
        read_RX_STATE_MACHINE_CURRENT_STATE = read_RX_STATE_MACHINE_CURRENT_STATE_value
    End Property

    Property Let write_RX_STATE_MACHINE_CURRENT_STATE(aData)
        set_RX_STATE_MACHINE_CURRENT_STATE = aData
        write
    End Property

    Property Get get_LP_AUTONEG_ABLE
        get_LP_AUTONEG_ABLE = read_LP_AUTONEG_ABLE_value
    End Property

    Property Let set_LP_AUTONEG_ABLE(aData)
        write_LP_AUTONEG_ABLE_value = aData
        flag_LP_AUTONEG_ABLE        = &H1
    End Property

    Property Get read_LP_AUTONEG_ABLE
        read
        read_LP_AUTONEG_ABLE = read_LP_AUTONEG_ABLE_value
    End Property

    Property Let write_LP_AUTONEG_ABLE(aData)
        set_LP_AUTONEG_ABLE = aData
        write
    End Property

    Property Get get_TX_STATE_MACHINE_CURRENT_STATE
        get_TX_STATE_MACHINE_CURRENT_STATE = read_TX_STATE_MACHINE_CURRENT_STATE_value
    End Property

    Property Let set_TX_STATE_MACHINE_CURRENT_STATE(aData)
        write_TX_STATE_MACHINE_CURRENT_STATE_value = aData
        flag_TX_STATE_MACHINE_CURRENT_STATE        = &H1
    End Property

    Property Get read_TX_STATE_MACHINE_CURRENT_STATE
        read
        read_TX_STATE_MACHINE_CURRENT_STATE = read_TX_STATE_MACHINE_CURRENT_STATE_value
    End Property

    Property Let write_TX_STATE_MACHINE_CURRENT_STATE(aData)
        set_TX_STATE_MACHINE_CURRENT_STATE = aData
        write
    End Property

    Property Get get_HDX_STATE_MACHINE_CURRENT_STATE
        get_HDX_STATE_MACHINE_CURRENT_STATE = read_HDX_STATE_MACHINE_CURRENT_STATE_value
    End Property

    Property Let set_HDX_STATE_MACHINE_CURRENT_STATE(aData)
        write_HDX_STATE_MACHINE_CURRENT_STATE_value = aData
        flag_HDX_STATE_MACHINE_CURRENT_STATE        = &H1
    End Property

    Property Get read_HDX_STATE_MACHINE_CURRENT_STATE
        read
        read_HDX_STATE_MACHINE_CURRENT_STATE = read_HDX_STATE_MACHINE_CURRENT_STATE_value
    End Property

    Property Let write_HDX_STATE_MACHINE_CURRENT_STATE(aData)
        set_HDX_STATE_MACHINE_CURRENT_STATE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_DETECT_LEGACY_100T1_value = rightShift(data_low, 15) and &H1
        read_DETECT_TRANSITION_value = rightShift(data_low, 14) and &H1
        read_DETECT_MV_END_value = rightShift(data_low, 13) and &H1
        read_DETECT_MV_START_value = rightShift(data_low, 12) and &H1
        read_DETECT_POLARITY_value = rightShift(data_low, 11) and &H1
        read_RX_STATE_MACHINE_CURRENT_STATE_value = rightShift(data_low, 8) and &H7
        read_LP_AUTONEG_ABLE_value = rightShift(data_low, 7) and &H1
        read_TX_STATE_MACHINE_CURRENT_STATE_value = rightShift(data_low, 4) and &H7
        HDX_STATE_MACHINE_CURRENT_STATE_mask = &Hf
        if data_low > LONG_MAX then
            if HDX_STATE_MACHINE_CURRENT_STATE_mask = mask then
                read_HDX_STATE_MACHINE_CURRENT_STATE_value = data_low
            else
                read_HDX_STATE_MACHINE_CURRENT_STATE_value = (data_low - H8000_0000) and HDX_STATE_MACHINE_CURRENT_STATE_mask
            end If
        else
            read_HDX_STATE_MACHINE_CURRENT_STATE_value = data_low and HDX_STATE_MACHINE_CURRENT_STATE_mask
        end If

    End Sub

    Sub write
        If flag_DETECT_LEGACY_100T1 = &H0 or flag_DETECT_TRANSITION = &H0 or flag_DETECT_MV_END = &H0 or flag_DETECT_MV_START = &H0 or flag_DETECT_POLARITY = &H0 or flag_RX_STATE_MACHINE_CURRENT_STATE = &H0 or flag_LP_AUTONEG_ABLE = &H0 or flag_TX_STATE_MACHINE_CURRENT_STATE = &H0 or flag_HDX_STATE_MACHINE_CURRENT_STATE = &H0 Then read
        If flag_DETECT_LEGACY_100T1 = &H0 Then write_DETECT_LEGACY_100T1_value = get_DETECT_LEGACY_100T1
        If flag_DETECT_TRANSITION = &H0 Then write_DETECT_TRANSITION_value = get_DETECT_TRANSITION
        If flag_DETECT_MV_END = &H0 Then write_DETECT_MV_END_value = get_DETECT_MV_END
        If flag_DETECT_MV_START = &H0 Then write_DETECT_MV_START_value = get_DETECT_MV_START
        If flag_DETECT_POLARITY = &H0 Then write_DETECT_POLARITY_value = get_DETECT_POLARITY
        If flag_RX_STATE_MACHINE_CURRENT_STATE = &H0 Then write_RX_STATE_MACHINE_CURRENT_STATE_value = get_RX_STATE_MACHINE_CURRENT_STATE
        If flag_LP_AUTONEG_ABLE = &H0 Then write_LP_AUTONEG_ABLE_value = get_LP_AUTONEG_ABLE
        If flag_TX_STATE_MACHINE_CURRENT_STATE = &H0 Then write_TX_STATE_MACHINE_CURRENT_STATE_value = get_TX_STATE_MACHINE_CURRENT_STATE
        If flag_HDX_STATE_MACHINE_CURRENT_STATE = &H0 Then write_HDX_STATE_MACHINE_CURRENT_STATE_value = get_HDX_STATE_MACHINE_CURRENT_STATE

        regValue = leftShift((write_DETECT_LEGACY_100T1_value and &H1), 15) + leftShift((write_DETECT_TRANSITION_value and &H1), 14) + leftShift((write_DETECT_MV_END_value and &H1), 13) + leftShift((write_DETECT_MV_START_value and &H1), 12) + leftShift((write_DETECT_POLARITY_value and &H1), 11) + leftShift((write_RX_STATE_MACHINE_CURRENT_STATE_value and &H7), 8) + leftShift((write_LP_AUTONEG_ABLE_value and &H1), 7) + leftShift((write_TX_STATE_MACHINE_CURRENT_STATE_value and &H7), 4) + leftShift((write_HDX_STATE_MACHINE_CURRENT_STATE_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_DETECT_LEGACY_100T1_value = rightShift(data_low, 15) and &H1
        read_DETECT_TRANSITION_value = rightShift(data_low, 14) and &H1
        read_DETECT_MV_END_value = rightShift(data_low, 13) and &H1
        read_DETECT_MV_START_value = rightShift(data_low, 12) and &H1
        read_DETECT_POLARITY_value = rightShift(data_low, 11) and &H1
        read_RX_STATE_MACHINE_CURRENT_STATE_value = rightShift(data_low, 8) and &H7
        read_LP_AUTONEG_ABLE_value = rightShift(data_low, 7) and &H1
        read_TX_STATE_MACHINE_CURRENT_STATE_value = rightShift(data_low, 4) and &H7
        HDX_STATE_MACHINE_CURRENT_STATE_mask = &Hf
        if data_low > LONG_MAX then
            if HDX_STATE_MACHINE_CURRENT_STATE_mask = mask then
                read_HDX_STATE_MACHINE_CURRENT_STATE_value = data_low
            else
                read_HDX_STATE_MACHINE_CURRENT_STATE_value = (data_low - H8000_0000) and HDX_STATE_MACHINE_CURRENT_STATE_mask
            end If
        else
            read_HDX_STATE_MACHINE_CURRENT_STATE_value = data_low and HDX_STATE_MACHINE_CURRENT_STATE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DETECT_LEGACY_100T1_value = &H0
        flag_DETECT_LEGACY_100T1        = &H0
        write_DETECT_TRANSITION_value = &H0
        flag_DETECT_TRANSITION        = &H0
        write_DETECT_MV_END_value = &H0
        flag_DETECT_MV_END        = &H0
        write_DETECT_MV_START_value = &H0
        flag_DETECT_MV_START        = &H0
        write_DETECT_POLARITY_value = &H0
        flag_DETECT_POLARITY        = &H0
        write_RX_STATE_MACHINE_CURRENT_STATE_value = &H0
        flag_RX_STATE_MACHINE_CURRENT_STATE        = &H0
        write_LP_AUTONEG_ABLE_value = &H0
        flag_LP_AUTONEG_ABLE        = &H0
        write_TX_STATE_MACHINE_CURRENT_STATE_value = &H0
        flag_TX_STATE_MACHINE_CURRENT_STATE        = &H0
        write_HDX_STATE_MACHINE_CURRENT_STATE_value = &H0
        flag_HDX_STATE_MACHINE_CURRENT_STATE        = &H0
    End Sub
End Class


'' @REGISTER : CL45VEN_autoneg_test_reg4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' AUTONEG_TEST_MANCHESTER_DECODING_MODE      [15:15]          get_AUTONEG_TEST_MANCHESTER_DECODING_MODE
''                                                             set_AUTONEG_TEST_MANCHESTER_DECODING_MODE
''                                                             read_AUTONEG_TEST_MANCHESTER_DECODING_MODE
''                                                             write_AUTONEG_TEST_MANCHESTER_DECODING_MODE
''---------------------------------------------------------------------------------
'' LEGACY_100T1_DETECT_MS_EN_TOGGLE           [14:14]          get_LEGACY_100T1_DETECT_MS_EN_TOGGLE
''                                                             set_LEGACY_100T1_DETECT_MS_EN_TOGGLE
''                                                             read_LEGACY_100T1_DETECT_MS_EN_TOGGLE
''                                                             write_LEGACY_100T1_DETECT_MS_EN_TOGGLE
''---------------------------------------------------------------------------------
'' LEGACY_100T1_DETECT_MS_VAL                 [13:13]          get_LEGACY_100T1_DETECT_MS_VAL
''                                                             set_LEGACY_100T1_DETECT_MS_VAL
''                                                             read_LEGACY_100T1_DETECT_MS_VAL
''                                                             write_LEGACY_100T1_DETECT_MS_VAL
''---------------------------------------------------------------------------------
'' LEGACY_100T1_DETECTOR_VALUE                [12:12]          get_LEGACY_100T1_DETECTOR_VALUE
''                                                             set_LEGACY_100T1_DETECTOR_VALUE
''                                                             read_LEGACY_100T1_DETECTOR_VALUE
''                                                             write_LEGACY_100T1_DETECTOR_VALUE
''---------------------------------------------------------------------------------
'' LEGACY_100T1_DETECT_ENABLE                 [11:11]          get_LEGACY_100T1_DETECT_ENABLE
''                                                             set_LEGACY_100T1_DETECT_ENABLE
''                                                             read_LEGACY_100T1_DETECT_ENABLE
''                                                             write_LEGACY_100T1_DETECT_ENABLE
''---------------------------------------------------------------------------------
'' AUTONEG_HPF_POLE_SEL                       [10:9]           get_AUTONEG_HPF_POLE_SEL
''                                                             set_AUTONEG_HPF_POLE_SEL
''                                                             read_AUTONEG_HPF_POLE_SEL
''                                                             write_AUTONEG_HPF_POLE_SEL
''---------------------------------------------------------------------------------
'' LEGACY_100T1_TIMER_MS_EN_TOGGLE            [8:8]            get_LEGACY_100T1_TIMER_MS_EN_TOGGLE
''                                                             set_LEGACY_100T1_TIMER_MS_EN_TOGGLE
''                                                             read_LEGACY_100T1_TIMER_MS_EN_TOGGLE
''                                                             write_LEGACY_100T1_TIMER_MS_EN_TOGGLE
''---------------------------------------------------------------------------------
'' LEGACY_100T1_TIMER_MS_VAL                  [7:7]            get_LEGACY_100T1_TIMER_MS_VAL
''                                                             set_LEGACY_100T1_TIMER_MS_VAL
''                                                             read_LEGACY_100T1_TIMER_MS_VAL
''                                                             write_LEGACY_100T1_TIMER_MS_VAL
''---------------------------------------------------------------------------------
'' LEGACY_100T1_TIMER_ENABLE                  [6:6]            get_LEGACY_100T1_TIMER_ENABLE
''                                                             set_LEGACY_100T1_TIMER_ENABLE
''                                                             read_LEGACY_100T1_TIMER_ENABLE
''                                                             write_LEGACY_100T1_TIMER_ENABLE
''---------------------------------------------------------------------------------
'' DETECT_MV_END_COEFFICIENT                  [5:3]            get_DETECT_MV_END_COEFFICIENT
''                                                             set_DETECT_MV_END_COEFFICIENT
''                                                             read_DETECT_MV_END_COEFFICIENT
''                                                             write_DETECT_MV_END_COEFFICIENT
''---------------------------------------------------------------------------------
'' DETECT_MV_TRANSITION_COEFFICIENT           [2:0]            get_DETECT_MV_TRANSITION_COEFFICIENT
''                                                             set_DETECT_MV_TRANSITION_COEFFICIENT
''                                                             read_DETECT_MV_TRANSITION_COEFFICIENT
''                                                             write_DETECT_MV_TRANSITION_COEFFICIENT
''---------------------------------------------------------------------------------
Class REGISTER_CL45VEN_autoneg_test_reg4
    Private write_AUTONEG_TEST_MANCHESTER_DECODING_MODE_value
    Private read_AUTONEG_TEST_MANCHESTER_DECODING_MODE_value
    Private flag_AUTONEG_TEST_MANCHESTER_DECODING_MODE
    Private write_LEGACY_100T1_DETECT_MS_EN_TOGGLE_value
    Private read_LEGACY_100T1_DETECT_MS_EN_TOGGLE_value
    Private flag_LEGACY_100T1_DETECT_MS_EN_TOGGLE
    Private write_LEGACY_100T1_DETECT_MS_VAL_value
    Private read_LEGACY_100T1_DETECT_MS_VAL_value
    Private flag_LEGACY_100T1_DETECT_MS_VAL
    Private write_LEGACY_100T1_DETECTOR_VALUE_value
    Private read_LEGACY_100T1_DETECTOR_VALUE_value
    Private flag_LEGACY_100T1_DETECTOR_VALUE
    Private write_LEGACY_100T1_DETECT_ENABLE_value
    Private read_LEGACY_100T1_DETECT_ENABLE_value
    Private flag_LEGACY_100T1_DETECT_ENABLE
    Private write_AUTONEG_HPF_POLE_SEL_value
    Private read_AUTONEG_HPF_POLE_SEL_value
    Private flag_AUTONEG_HPF_POLE_SEL
    Private write_LEGACY_100T1_TIMER_MS_EN_TOGGLE_value
    Private read_LEGACY_100T1_TIMER_MS_EN_TOGGLE_value
    Private flag_LEGACY_100T1_TIMER_MS_EN_TOGGLE
    Private write_LEGACY_100T1_TIMER_MS_VAL_value
    Private read_LEGACY_100T1_TIMER_MS_VAL_value
    Private flag_LEGACY_100T1_TIMER_MS_VAL
    Private write_LEGACY_100T1_TIMER_ENABLE_value
    Private read_LEGACY_100T1_TIMER_ENABLE_value
    Private flag_LEGACY_100T1_TIMER_ENABLE
    Private write_DETECT_MV_END_COEFFICIENT_value
    Private read_DETECT_MV_END_COEFFICIENT_value
    Private flag_DETECT_MV_END_COEFFICIENT
    Private write_DETECT_MV_TRANSITION_COEFFICIENT_value
    Private read_DETECT_MV_TRANSITION_COEFFICIENT_value
    Private flag_DETECT_MV_TRANSITION_COEFFICIENT

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

    Property Get get_AUTONEG_TEST_MANCHESTER_DECODING_MODE
        get_AUTONEG_TEST_MANCHESTER_DECODING_MODE = read_AUTONEG_TEST_MANCHESTER_DECODING_MODE_value
    End Property

    Property Let set_AUTONEG_TEST_MANCHESTER_DECODING_MODE(aData)
        write_AUTONEG_TEST_MANCHESTER_DECODING_MODE_value = aData
        flag_AUTONEG_TEST_MANCHESTER_DECODING_MODE        = &H1
    End Property

    Property Get read_AUTONEG_TEST_MANCHESTER_DECODING_MODE
        read
        read_AUTONEG_TEST_MANCHESTER_DECODING_MODE = read_AUTONEG_TEST_MANCHESTER_DECODING_MODE_value
    End Property

    Property Let write_AUTONEG_TEST_MANCHESTER_DECODING_MODE(aData)
        set_AUTONEG_TEST_MANCHESTER_DECODING_MODE = aData
        write
    End Property

    Property Get get_LEGACY_100T1_DETECT_MS_EN_TOGGLE
        get_LEGACY_100T1_DETECT_MS_EN_TOGGLE = read_LEGACY_100T1_DETECT_MS_EN_TOGGLE_value
    End Property

    Property Let set_LEGACY_100T1_DETECT_MS_EN_TOGGLE(aData)
        write_LEGACY_100T1_DETECT_MS_EN_TOGGLE_value = aData
        flag_LEGACY_100T1_DETECT_MS_EN_TOGGLE        = &H1
    End Property

    Property Get read_LEGACY_100T1_DETECT_MS_EN_TOGGLE
        read
        read_LEGACY_100T1_DETECT_MS_EN_TOGGLE = read_LEGACY_100T1_DETECT_MS_EN_TOGGLE_value
    End Property

    Property Let write_LEGACY_100T1_DETECT_MS_EN_TOGGLE(aData)
        set_LEGACY_100T1_DETECT_MS_EN_TOGGLE = aData
        write
    End Property

    Property Get get_LEGACY_100T1_DETECT_MS_VAL
        get_LEGACY_100T1_DETECT_MS_VAL = read_LEGACY_100T1_DETECT_MS_VAL_value
    End Property

    Property Let set_LEGACY_100T1_DETECT_MS_VAL(aData)
        write_LEGACY_100T1_DETECT_MS_VAL_value = aData
        flag_LEGACY_100T1_DETECT_MS_VAL        = &H1
    End Property

    Property Get read_LEGACY_100T1_DETECT_MS_VAL
        read
        read_LEGACY_100T1_DETECT_MS_VAL = read_LEGACY_100T1_DETECT_MS_VAL_value
    End Property

    Property Let write_LEGACY_100T1_DETECT_MS_VAL(aData)
        set_LEGACY_100T1_DETECT_MS_VAL = aData
        write
    End Property

    Property Get get_LEGACY_100T1_DETECTOR_VALUE
        get_LEGACY_100T1_DETECTOR_VALUE = read_LEGACY_100T1_DETECTOR_VALUE_value
    End Property

    Property Let set_LEGACY_100T1_DETECTOR_VALUE(aData)
        write_LEGACY_100T1_DETECTOR_VALUE_value = aData
        flag_LEGACY_100T1_DETECTOR_VALUE        = &H1
    End Property

    Property Get read_LEGACY_100T1_DETECTOR_VALUE
        read
        read_LEGACY_100T1_DETECTOR_VALUE = read_LEGACY_100T1_DETECTOR_VALUE_value
    End Property

    Property Let write_LEGACY_100T1_DETECTOR_VALUE(aData)
        set_LEGACY_100T1_DETECTOR_VALUE = aData
        write
    End Property

    Property Get get_LEGACY_100T1_DETECT_ENABLE
        get_LEGACY_100T1_DETECT_ENABLE = read_LEGACY_100T1_DETECT_ENABLE_value
    End Property

    Property Let set_LEGACY_100T1_DETECT_ENABLE(aData)
        write_LEGACY_100T1_DETECT_ENABLE_value = aData
        flag_LEGACY_100T1_DETECT_ENABLE        = &H1
    End Property

    Property Get read_LEGACY_100T1_DETECT_ENABLE
        read
        read_LEGACY_100T1_DETECT_ENABLE = read_LEGACY_100T1_DETECT_ENABLE_value
    End Property

    Property Let write_LEGACY_100T1_DETECT_ENABLE(aData)
        set_LEGACY_100T1_DETECT_ENABLE = aData
        write
    End Property

    Property Get get_AUTONEG_HPF_POLE_SEL
        get_AUTONEG_HPF_POLE_SEL = read_AUTONEG_HPF_POLE_SEL_value
    End Property

    Property Let set_AUTONEG_HPF_POLE_SEL(aData)
        write_AUTONEG_HPF_POLE_SEL_value = aData
        flag_AUTONEG_HPF_POLE_SEL        = &H1
    End Property

    Property Get read_AUTONEG_HPF_POLE_SEL
        read
        read_AUTONEG_HPF_POLE_SEL = read_AUTONEG_HPF_POLE_SEL_value
    End Property

    Property Let write_AUTONEG_HPF_POLE_SEL(aData)
        set_AUTONEG_HPF_POLE_SEL = aData
        write
    End Property

    Property Get get_LEGACY_100T1_TIMER_MS_EN_TOGGLE
        get_LEGACY_100T1_TIMER_MS_EN_TOGGLE = read_LEGACY_100T1_TIMER_MS_EN_TOGGLE_value
    End Property

    Property Let set_LEGACY_100T1_TIMER_MS_EN_TOGGLE(aData)
        write_LEGACY_100T1_TIMER_MS_EN_TOGGLE_value = aData
        flag_LEGACY_100T1_TIMER_MS_EN_TOGGLE        = &H1
    End Property

    Property Get read_LEGACY_100T1_TIMER_MS_EN_TOGGLE
        read
        read_LEGACY_100T1_TIMER_MS_EN_TOGGLE = read_LEGACY_100T1_TIMER_MS_EN_TOGGLE_value
    End Property

    Property Let write_LEGACY_100T1_TIMER_MS_EN_TOGGLE(aData)
        set_LEGACY_100T1_TIMER_MS_EN_TOGGLE = aData
        write
    End Property

    Property Get get_LEGACY_100T1_TIMER_MS_VAL
        get_LEGACY_100T1_TIMER_MS_VAL = read_LEGACY_100T1_TIMER_MS_VAL_value
    End Property

    Property Let set_LEGACY_100T1_TIMER_MS_VAL(aData)
        write_LEGACY_100T1_TIMER_MS_VAL_value = aData
        flag_LEGACY_100T1_TIMER_MS_VAL        = &H1
    End Property

    Property Get read_LEGACY_100T1_TIMER_MS_VAL
        read
        read_LEGACY_100T1_TIMER_MS_VAL = read_LEGACY_100T1_TIMER_MS_VAL_value
    End Property

    Property Let write_LEGACY_100T1_TIMER_MS_VAL(aData)
        set_LEGACY_100T1_TIMER_MS_VAL = aData
        write
    End Property

    Property Get get_LEGACY_100T1_TIMER_ENABLE
        get_LEGACY_100T1_TIMER_ENABLE = read_LEGACY_100T1_TIMER_ENABLE_value
    End Property

    Property Let set_LEGACY_100T1_TIMER_ENABLE(aData)
        write_LEGACY_100T1_TIMER_ENABLE_value = aData
        flag_LEGACY_100T1_TIMER_ENABLE        = &H1
    End Property

    Property Get read_LEGACY_100T1_TIMER_ENABLE
        read
        read_LEGACY_100T1_TIMER_ENABLE = read_LEGACY_100T1_TIMER_ENABLE_value
    End Property

    Property Let write_LEGACY_100T1_TIMER_ENABLE(aData)
        set_LEGACY_100T1_TIMER_ENABLE = aData
        write
    End Property

    Property Get get_DETECT_MV_END_COEFFICIENT
        get_DETECT_MV_END_COEFFICIENT = read_DETECT_MV_END_COEFFICIENT_value
    End Property

    Property Let set_DETECT_MV_END_COEFFICIENT(aData)
        write_DETECT_MV_END_COEFFICIENT_value = aData
        flag_DETECT_MV_END_COEFFICIENT        = &H1
    End Property

    Property Get read_DETECT_MV_END_COEFFICIENT
        read
        read_DETECT_MV_END_COEFFICIENT = read_DETECT_MV_END_COEFFICIENT_value
    End Property

    Property Let write_DETECT_MV_END_COEFFICIENT(aData)
        set_DETECT_MV_END_COEFFICIENT = aData
        write
    End Property

    Property Get get_DETECT_MV_TRANSITION_COEFFICIENT
        get_DETECT_MV_TRANSITION_COEFFICIENT = read_DETECT_MV_TRANSITION_COEFFICIENT_value
    End Property

    Property Let set_DETECT_MV_TRANSITION_COEFFICIENT(aData)
        write_DETECT_MV_TRANSITION_COEFFICIENT_value = aData
        flag_DETECT_MV_TRANSITION_COEFFICIENT        = &H1
    End Property

    Property Get read_DETECT_MV_TRANSITION_COEFFICIENT
        read
        read_DETECT_MV_TRANSITION_COEFFICIENT = read_DETECT_MV_TRANSITION_COEFFICIENT_value
    End Property

    Property Let write_DETECT_MV_TRANSITION_COEFFICIENT(aData)
        set_DETECT_MV_TRANSITION_COEFFICIENT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_AUTONEG_TEST_MANCHESTER_DECODING_MODE_value = rightShift(data_low, 15) and &H1
        read_LEGACY_100T1_DETECT_MS_EN_TOGGLE_value = rightShift(data_low, 14) and &H1
        read_LEGACY_100T1_DETECT_MS_VAL_value = rightShift(data_low, 13) and &H1
        read_LEGACY_100T1_DETECTOR_VALUE_value = rightShift(data_low, 12) and &H1
        read_LEGACY_100T1_DETECT_ENABLE_value = rightShift(data_low, 11) and &H1
        read_AUTONEG_HPF_POLE_SEL_value = rightShift(data_low, 9) and &H3
        read_LEGACY_100T1_TIMER_MS_EN_TOGGLE_value = rightShift(data_low, 8) and &H1
        read_LEGACY_100T1_TIMER_MS_VAL_value = rightShift(data_low, 7) and &H1
        read_LEGACY_100T1_TIMER_ENABLE_value = rightShift(data_low, 6) and &H1
        read_DETECT_MV_END_COEFFICIENT_value = rightShift(data_low, 3) and &H7
        DETECT_MV_TRANSITION_COEFFICIENT_mask = &H7
        if data_low > LONG_MAX then
            if DETECT_MV_TRANSITION_COEFFICIENT_mask = mask then
                read_DETECT_MV_TRANSITION_COEFFICIENT_value = data_low
            else
                read_DETECT_MV_TRANSITION_COEFFICIENT_value = (data_low - H8000_0000) and DETECT_MV_TRANSITION_COEFFICIENT_mask
            end If
        else
            read_DETECT_MV_TRANSITION_COEFFICIENT_value = data_low and DETECT_MV_TRANSITION_COEFFICIENT_mask
        end If

    End Sub

    Sub write
        If flag_AUTONEG_TEST_MANCHESTER_DECODING_MODE = &H0 or flag_LEGACY_100T1_DETECT_MS_EN_TOGGLE = &H0 or flag_LEGACY_100T1_DETECT_MS_VAL = &H0 or flag_LEGACY_100T1_DETECTOR_VALUE = &H0 or flag_LEGACY_100T1_DETECT_ENABLE = &H0 or flag_AUTONEG_HPF_POLE_SEL = &H0 or flag_LEGACY_100T1_TIMER_MS_EN_TOGGLE = &H0 or flag_LEGACY_100T1_TIMER_MS_VAL = &H0 or flag_LEGACY_100T1_TIMER_ENABLE = &H0 or flag_DETECT_MV_END_COEFFICIENT = &H0 or flag_DETECT_MV_TRANSITION_COEFFICIENT = &H0 Then read
        If flag_AUTONEG_TEST_MANCHESTER_DECODING_MODE = &H0 Then write_AUTONEG_TEST_MANCHESTER_DECODING_MODE_value = get_AUTONEG_TEST_MANCHESTER_DECODING_MODE
        If flag_LEGACY_100T1_DETECT_MS_EN_TOGGLE = &H0 Then write_LEGACY_100T1_DETECT_MS_EN_TOGGLE_value = get_LEGACY_100T1_DETECT_MS_EN_TOGGLE
        If flag_LEGACY_100T1_DETECT_MS_VAL = &H0 Then write_LEGACY_100T1_DETECT_MS_VAL_value = get_LEGACY_100T1_DETECT_MS_VAL
        If flag_LEGACY_100T1_DETECTOR_VALUE = &H0 Then write_LEGACY_100T1_DETECTOR_VALUE_value = get_LEGACY_100T1_DETECTOR_VALUE
        If flag_LEGACY_100T1_DETECT_ENABLE = &H0 Then write_LEGACY_100T1_DETECT_ENABLE_value = get_LEGACY_100T1_DETECT_ENABLE
        If flag_AUTONEG_HPF_POLE_SEL = &H0 Then write_AUTONEG_HPF_POLE_SEL_value = get_AUTONEG_HPF_POLE_SEL
        If flag_LEGACY_100T1_TIMER_MS_EN_TOGGLE = &H0 Then write_LEGACY_100T1_TIMER_MS_EN_TOGGLE_value = get_LEGACY_100T1_TIMER_MS_EN_TOGGLE
        If flag_LEGACY_100T1_TIMER_MS_VAL = &H0 Then write_LEGACY_100T1_TIMER_MS_VAL_value = get_LEGACY_100T1_TIMER_MS_VAL
        If flag_LEGACY_100T1_TIMER_ENABLE = &H0 Then write_LEGACY_100T1_TIMER_ENABLE_value = get_LEGACY_100T1_TIMER_ENABLE
        If flag_DETECT_MV_END_COEFFICIENT = &H0 Then write_DETECT_MV_END_COEFFICIENT_value = get_DETECT_MV_END_COEFFICIENT
        If flag_DETECT_MV_TRANSITION_COEFFICIENT = &H0 Then write_DETECT_MV_TRANSITION_COEFFICIENT_value = get_DETECT_MV_TRANSITION_COEFFICIENT

        regValue = leftShift((write_AUTONEG_TEST_MANCHESTER_DECODING_MODE_value and &H1), 15) + leftShift((write_LEGACY_100T1_DETECT_MS_EN_TOGGLE_value and &H1), 14) + leftShift((write_LEGACY_100T1_DETECT_MS_VAL_value and &H1), 13) + leftShift((write_LEGACY_100T1_DETECTOR_VALUE_value and &H1), 12) + leftShift((write_LEGACY_100T1_DETECT_ENABLE_value and &H1), 11) + leftShift((write_AUTONEG_HPF_POLE_SEL_value and &H3), 9) + leftShift((write_LEGACY_100T1_TIMER_MS_EN_TOGGLE_value and &H1), 8) + leftShift((write_LEGACY_100T1_TIMER_MS_VAL_value and &H1), 7) + leftShift((write_LEGACY_100T1_TIMER_ENABLE_value and &H1), 6) + leftShift((write_DETECT_MV_END_COEFFICIENT_value and &H7), 3) + leftShift((write_DETECT_MV_TRANSITION_COEFFICIENT_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_AUTONEG_TEST_MANCHESTER_DECODING_MODE_value = rightShift(data_low, 15) and &H1
        read_LEGACY_100T1_DETECT_MS_EN_TOGGLE_value = rightShift(data_low, 14) and &H1
        read_LEGACY_100T1_DETECT_MS_VAL_value = rightShift(data_low, 13) and &H1
        read_LEGACY_100T1_DETECTOR_VALUE_value = rightShift(data_low, 12) and &H1
        read_LEGACY_100T1_DETECT_ENABLE_value = rightShift(data_low, 11) and &H1
        read_AUTONEG_HPF_POLE_SEL_value = rightShift(data_low, 9) and &H3
        read_LEGACY_100T1_TIMER_MS_EN_TOGGLE_value = rightShift(data_low, 8) and &H1
        read_LEGACY_100T1_TIMER_MS_VAL_value = rightShift(data_low, 7) and &H1
        read_LEGACY_100T1_TIMER_ENABLE_value = rightShift(data_low, 6) and &H1
        read_DETECT_MV_END_COEFFICIENT_value = rightShift(data_low, 3) and &H7
        DETECT_MV_TRANSITION_COEFFICIENT_mask = &H7
        if data_low > LONG_MAX then
            if DETECT_MV_TRANSITION_COEFFICIENT_mask = mask then
                read_DETECT_MV_TRANSITION_COEFFICIENT_value = data_low
            else
                read_DETECT_MV_TRANSITION_COEFFICIENT_value = (data_low - H8000_0000) and DETECT_MV_TRANSITION_COEFFICIENT_mask
            end If
        else
            read_DETECT_MV_TRANSITION_COEFFICIENT_value = data_low and DETECT_MV_TRANSITION_COEFFICIENT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_AUTONEG_TEST_MANCHESTER_DECODING_MODE_value = &H0
        flag_AUTONEG_TEST_MANCHESTER_DECODING_MODE        = &H0
        write_LEGACY_100T1_DETECT_MS_EN_TOGGLE_value = &H0
        flag_LEGACY_100T1_DETECT_MS_EN_TOGGLE        = &H0
        write_LEGACY_100T1_DETECT_MS_VAL_value = &H0
        flag_LEGACY_100T1_DETECT_MS_VAL        = &H0
        write_LEGACY_100T1_DETECTOR_VALUE_value = &H0
        flag_LEGACY_100T1_DETECTOR_VALUE        = &H0
        write_LEGACY_100T1_DETECT_ENABLE_value = &H0
        flag_LEGACY_100T1_DETECT_ENABLE        = &H0
        write_AUTONEG_HPF_POLE_SEL_value = &H0
        flag_AUTONEG_HPF_POLE_SEL        = &H0
        write_LEGACY_100T1_TIMER_MS_EN_TOGGLE_value = &H0
        flag_LEGACY_100T1_TIMER_MS_EN_TOGGLE        = &H0
        write_LEGACY_100T1_TIMER_MS_VAL_value = &H0
        flag_LEGACY_100T1_TIMER_MS_VAL        = &H0
        write_LEGACY_100T1_TIMER_ENABLE_value = &H0
        flag_LEGACY_100T1_TIMER_ENABLE        = &H0
        write_DETECT_MV_END_COEFFICIENT_value = &H0
        flag_DETECT_MV_END_COEFFICIENT        = &H0
        write_DETECT_MV_TRANSITION_COEFFICIENT_value = &H0
        flag_DETECT_MV_TRANSITION_COEFFICIENT        = &H0
    End Sub
End Class


'' @REGISTER : CL45VEN_autoneg_test_reg5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' LEGACY_100T1_DETECT_THRESHOLD_VALUE        [15:5]           get_LEGACY_100T1_DETECT_THRESHOLD_VALUE
''                                                             set_LEGACY_100T1_DETECT_THRESHOLD_VALUE
''                                                             read_LEGACY_100T1_DETECT_THRESHOLD_VALUE
''                                                             write_LEGACY_100T1_DETECT_THRESHOLD_VALUE
''---------------------------------------------------------------------------------
'' DETECT_MV_START_COEFFICIENT                [4:0]            get_DETECT_MV_START_COEFFICIENT
''                                                             set_DETECT_MV_START_COEFFICIENT
''                                                             read_DETECT_MV_START_COEFFICIENT
''                                                             write_DETECT_MV_START_COEFFICIENT
''---------------------------------------------------------------------------------
Class REGISTER_CL45VEN_autoneg_test_reg5
    Private write_LEGACY_100T1_DETECT_THRESHOLD_VALUE_value
    Private read_LEGACY_100T1_DETECT_THRESHOLD_VALUE_value
    Private flag_LEGACY_100T1_DETECT_THRESHOLD_VALUE
    Private write_DETECT_MV_START_COEFFICIENT_value
    Private read_DETECT_MV_START_COEFFICIENT_value
    Private flag_DETECT_MV_START_COEFFICIENT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H10a
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_LEGACY_100T1_DETECT_THRESHOLD_VALUE
        get_LEGACY_100T1_DETECT_THRESHOLD_VALUE = read_LEGACY_100T1_DETECT_THRESHOLD_VALUE_value
    End Property

    Property Let set_LEGACY_100T1_DETECT_THRESHOLD_VALUE(aData)
        write_LEGACY_100T1_DETECT_THRESHOLD_VALUE_value = aData
        flag_LEGACY_100T1_DETECT_THRESHOLD_VALUE        = &H1
    End Property

    Property Get read_LEGACY_100T1_DETECT_THRESHOLD_VALUE
        read
        read_LEGACY_100T1_DETECT_THRESHOLD_VALUE = read_LEGACY_100T1_DETECT_THRESHOLD_VALUE_value
    End Property

    Property Let write_LEGACY_100T1_DETECT_THRESHOLD_VALUE(aData)
        set_LEGACY_100T1_DETECT_THRESHOLD_VALUE = aData
        write
    End Property

    Property Get get_DETECT_MV_START_COEFFICIENT
        get_DETECT_MV_START_COEFFICIENT = read_DETECT_MV_START_COEFFICIENT_value
    End Property

    Property Let set_DETECT_MV_START_COEFFICIENT(aData)
        write_DETECT_MV_START_COEFFICIENT_value = aData
        flag_DETECT_MV_START_COEFFICIENT        = &H1
    End Property

    Property Get read_DETECT_MV_START_COEFFICIENT
        read
        read_DETECT_MV_START_COEFFICIENT = read_DETECT_MV_START_COEFFICIENT_value
    End Property

    Property Let write_DETECT_MV_START_COEFFICIENT(aData)
        set_DETECT_MV_START_COEFFICIENT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LEGACY_100T1_DETECT_THRESHOLD_VALUE_value = rightShift(data_low, 5) and &H7ff
        DETECT_MV_START_COEFFICIENT_mask = &H1f
        if data_low > LONG_MAX then
            if DETECT_MV_START_COEFFICIENT_mask = mask then
                read_DETECT_MV_START_COEFFICIENT_value = data_low
            else
                read_DETECT_MV_START_COEFFICIENT_value = (data_low - H8000_0000) and DETECT_MV_START_COEFFICIENT_mask
            end If
        else
            read_DETECT_MV_START_COEFFICIENT_value = data_low and DETECT_MV_START_COEFFICIENT_mask
        end If

    End Sub

    Sub write
        If flag_LEGACY_100T1_DETECT_THRESHOLD_VALUE = &H0 or flag_DETECT_MV_START_COEFFICIENT = &H0 Then read
        If flag_LEGACY_100T1_DETECT_THRESHOLD_VALUE = &H0 Then write_LEGACY_100T1_DETECT_THRESHOLD_VALUE_value = get_LEGACY_100T1_DETECT_THRESHOLD_VALUE
        If flag_DETECT_MV_START_COEFFICIENT = &H0 Then write_DETECT_MV_START_COEFFICIENT_value = get_DETECT_MV_START_COEFFICIENT

        regValue = leftShift((write_LEGACY_100T1_DETECT_THRESHOLD_VALUE_value and &H7ff), 5) + leftShift((write_DETECT_MV_START_COEFFICIENT_value and &H1f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_LEGACY_100T1_DETECT_THRESHOLD_VALUE_value = rightShift(data_low, 5) and &H7ff
        DETECT_MV_START_COEFFICIENT_mask = &H1f
        if data_low > LONG_MAX then
            if DETECT_MV_START_COEFFICIENT_mask = mask then
                read_DETECT_MV_START_COEFFICIENT_value = data_low
            else
                read_DETECT_MV_START_COEFFICIENT_value = (data_low - H8000_0000) and DETECT_MV_START_COEFFICIENT_mask
            end If
        else
            read_DETECT_MV_START_COEFFICIENT_value = data_low and DETECT_MV_START_COEFFICIENT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_LEGACY_100T1_DETECT_THRESHOLD_VALUE_value = &H0
        flag_LEGACY_100T1_DETECT_THRESHOLD_VALUE        = &H0
        write_DETECT_MV_START_COEFFICIENT_value = &H0
        flag_DETECT_MV_START_COEFFICIENT        = &H0
    End Sub
End Class


'' @REGISTER : CL45VEN_autoneg_test_reg6
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DISABLE_SUM_ABS_PREV_CHECK                 [15:15]          get_DISABLE_SUM_ABS_PREV_CHECK
''                                                             set_DISABLE_SUM_ABS_PREV_CHECK
''                                                             read_DISABLE_SUM_ABS_PREV_CHECK
''                                                             write_DISABLE_SUM_ABS_PREV_CHECK
''---------------------------------------------------------------------------------
'' MANUAL_DETECT_MV_START_THRESHOLD           [14:0]           get_MANUAL_DETECT_MV_START_THRESHOLD
''                                                             set_MANUAL_DETECT_MV_START_THRESHOLD
''                                                             read_MANUAL_DETECT_MV_START_THRESHOLD
''                                                             write_MANUAL_DETECT_MV_START_THRESHOLD
''---------------------------------------------------------------------------------
Class REGISTER_CL45VEN_autoneg_test_reg6
    Private write_DISABLE_SUM_ABS_PREV_CHECK_value
    Private read_DISABLE_SUM_ABS_PREV_CHECK_value
    Private flag_DISABLE_SUM_ABS_PREV_CHECK
    Private write_MANUAL_DETECT_MV_START_THRESHOLD_value
    Private read_MANUAL_DETECT_MV_START_THRESHOLD_value
    Private flag_MANUAL_DETECT_MV_START_THRESHOLD

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

    Property Get get_DISABLE_SUM_ABS_PREV_CHECK
        get_DISABLE_SUM_ABS_PREV_CHECK = read_DISABLE_SUM_ABS_PREV_CHECK_value
    End Property

    Property Let set_DISABLE_SUM_ABS_PREV_CHECK(aData)
        write_DISABLE_SUM_ABS_PREV_CHECK_value = aData
        flag_DISABLE_SUM_ABS_PREV_CHECK        = &H1
    End Property

    Property Get read_DISABLE_SUM_ABS_PREV_CHECK
        read
        read_DISABLE_SUM_ABS_PREV_CHECK = read_DISABLE_SUM_ABS_PREV_CHECK_value
    End Property

    Property Let write_DISABLE_SUM_ABS_PREV_CHECK(aData)
        set_DISABLE_SUM_ABS_PREV_CHECK = aData
        write
    End Property

    Property Get get_MANUAL_DETECT_MV_START_THRESHOLD
        get_MANUAL_DETECT_MV_START_THRESHOLD = read_MANUAL_DETECT_MV_START_THRESHOLD_value
    End Property

    Property Let set_MANUAL_DETECT_MV_START_THRESHOLD(aData)
        write_MANUAL_DETECT_MV_START_THRESHOLD_value = aData
        flag_MANUAL_DETECT_MV_START_THRESHOLD        = &H1
    End Property

    Property Get read_MANUAL_DETECT_MV_START_THRESHOLD
        read
        read_MANUAL_DETECT_MV_START_THRESHOLD = read_MANUAL_DETECT_MV_START_THRESHOLD_value
    End Property

    Property Let write_MANUAL_DETECT_MV_START_THRESHOLD(aData)
        set_MANUAL_DETECT_MV_START_THRESHOLD = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_DISABLE_SUM_ABS_PREV_CHECK_value = rightShift(data_low, 15) and &H1
        MANUAL_DETECT_MV_START_THRESHOLD_mask = &H7fff
        if data_low > LONG_MAX then
            if MANUAL_DETECT_MV_START_THRESHOLD_mask = mask then
                read_MANUAL_DETECT_MV_START_THRESHOLD_value = data_low
            else
                read_MANUAL_DETECT_MV_START_THRESHOLD_value = (data_low - H8000_0000) and MANUAL_DETECT_MV_START_THRESHOLD_mask
            end If
        else
            read_MANUAL_DETECT_MV_START_THRESHOLD_value = data_low and MANUAL_DETECT_MV_START_THRESHOLD_mask
        end If

    End Sub

    Sub write
        If flag_DISABLE_SUM_ABS_PREV_CHECK = &H0 or flag_MANUAL_DETECT_MV_START_THRESHOLD = &H0 Then read
        If flag_DISABLE_SUM_ABS_PREV_CHECK = &H0 Then write_DISABLE_SUM_ABS_PREV_CHECK_value = get_DISABLE_SUM_ABS_PREV_CHECK
        If flag_MANUAL_DETECT_MV_START_THRESHOLD = &H0 Then write_MANUAL_DETECT_MV_START_THRESHOLD_value = get_MANUAL_DETECT_MV_START_THRESHOLD

        regValue = leftShift((write_DISABLE_SUM_ABS_PREV_CHECK_value and &H1), 15) + leftShift((write_MANUAL_DETECT_MV_START_THRESHOLD_value and &H7fff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_DISABLE_SUM_ABS_PREV_CHECK_value = rightShift(data_low, 15) and &H1
        MANUAL_DETECT_MV_START_THRESHOLD_mask = &H7fff
        if data_low > LONG_MAX then
            if MANUAL_DETECT_MV_START_THRESHOLD_mask = mask then
                read_MANUAL_DETECT_MV_START_THRESHOLD_value = data_low
            else
                read_MANUAL_DETECT_MV_START_THRESHOLD_value = (data_low - H8000_0000) and MANUAL_DETECT_MV_START_THRESHOLD_mask
            end If
        else
            read_MANUAL_DETECT_MV_START_THRESHOLD_value = data_low and MANUAL_DETECT_MV_START_THRESHOLD_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DISABLE_SUM_ABS_PREV_CHECK_value = &H0
        flag_DISABLE_SUM_ABS_PREV_CHECK        = &H0
        write_MANUAL_DETECT_MV_START_THRESHOLD_value = &H0
        flag_MANUAL_DETECT_MV_START_THRESHOLD        = &H0
    End Sub
End Class


'' @REGISTER : CL45VEN_autoneg_test_reg7
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' DETECT_MV_START_MINIMUM_THRESHOLD          [15:10]          get_DETECT_MV_START_MINIMUM_THRESHOLD
''                                                             set_DETECT_MV_START_MINIMUM_THRESHOLD
''                                                             read_DETECT_MV_START_MINIMUM_THRESHOLD
''                                                             write_DETECT_MV_START_MINIMUM_THRESHOLD
''---------------------------------------------------------------------------------
'' MANUAL_DETECT_MV_TRANSITION_THRESHOLD      [9:0]            get_MANUAL_DETECT_MV_TRANSITION_THRESHOLD
''                                                             set_MANUAL_DETECT_MV_TRANSITION_THRESHOLD
''                                                             read_MANUAL_DETECT_MV_TRANSITION_THRESHOLD
''                                                             write_MANUAL_DETECT_MV_TRANSITION_THRESHOLD
''---------------------------------------------------------------------------------
Class REGISTER_CL45VEN_autoneg_test_reg7
    Private write_DETECT_MV_START_MINIMUM_THRESHOLD_value
    Private read_DETECT_MV_START_MINIMUM_THRESHOLD_value
    Private flag_DETECT_MV_START_MINIMUM_THRESHOLD
    Private write_MANUAL_DETECT_MV_TRANSITION_THRESHOLD_value
    Private read_MANUAL_DETECT_MV_TRANSITION_THRESHOLD_value
    Private flag_MANUAL_DETECT_MV_TRANSITION_THRESHOLD

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H10e
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_DETECT_MV_START_MINIMUM_THRESHOLD
        get_DETECT_MV_START_MINIMUM_THRESHOLD = read_DETECT_MV_START_MINIMUM_THRESHOLD_value
    End Property

    Property Let set_DETECT_MV_START_MINIMUM_THRESHOLD(aData)
        write_DETECT_MV_START_MINIMUM_THRESHOLD_value = aData
        flag_DETECT_MV_START_MINIMUM_THRESHOLD        = &H1
    End Property

    Property Get read_DETECT_MV_START_MINIMUM_THRESHOLD
        read
        read_DETECT_MV_START_MINIMUM_THRESHOLD = read_DETECT_MV_START_MINIMUM_THRESHOLD_value
    End Property

    Property Let write_DETECT_MV_START_MINIMUM_THRESHOLD(aData)
        set_DETECT_MV_START_MINIMUM_THRESHOLD = aData
        write
    End Property

    Property Get get_MANUAL_DETECT_MV_TRANSITION_THRESHOLD
        get_MANUAL_DETECT_MV_TRANSITION_THRESHOLD = read_MANUAL_DETECT_MV_TRANSITION_THRESHOLD_value
    End Property

    Property Let set_MANUAL_DETECT_MV_TRANSITION_THRESHOLD(aData)
        write_MANUAL_DETECT_MV_TRANSITION_THRESHOLD_value = aData
        flag_MANUAL_DETECT_MV_TRANSITION_THRESHOLD        = &H1
    End Property

    Property Get read_MANUAL_DETECT_MV_TRANSITION_THRESHOLD
        read
        read_MANUAL_DETECT_MV_TRANSITION_THRESHOLD = read_MANUAL_DETECT_MV_TRANSITION_THRESHOLD_value
    End Property

    Property Let write_MANUAL_DETECT_MV_TRANSITION_THRESHOLD(aData)
        set_MANUAL_DETECT_MV_TRANSITION_THRESHOLD = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_DETECT_MV_START_MINIMUM_THRESHOLD_value = rightShift(data_low, 10) and &H3f
        MANUAL_DETECT_MV_TRANSITION_THRESHOLD_mask = &H3ff
        if data_low > LONG_MAX then
            if MANUAL_DETECT_MV_TRANSITION_THRESHOLD_mask = mask then
                read_MANUAL_DETECT_MV_TRANSITION_THRESHOLD_value = data_low
            else
                read_MANUAL_DETECT_MV_TRANSITION_THRESHOLD_value = (data_low - H8000_0000) and MANUAL_DETECT_MV_TRANSITION_THRESHOLD_mask
            end If
        else
            read_MANUAL_DETECT_MV_TRANSITION_THRESHOLD_value = data_low and MANUAL_DETECT_MV_TRANSITION_THRESHOLD_mask
        end If

    End Sub

    Sub write
        If flag_DETECT_MV_START_MINIMUM_THRESHOLD = &H0 or flag_MANUAL_DETECT_MV_TRANSITION_THRESHOLD = &H0 Then read
        If flag_DETECT_MV_START_MINIMUM_THRESHOLD = &H0 Then write_DETECT_MV_START_MINIMUM_THRESHOLD_value = get_DETECT_MV_START_MINIMUM_THRESHOLD
        If flag_MANUAL_DETECT_MV_TRANSITION_THRESHOLD = &H0 Then write_MANUAL_DETECT_MV_TRANSITION_THRESHOLD_value = get_MANUAL_DETECT_MV_TRANSITION_THRESHOLD

        regValue = leftShift((write_DETECT_MV_START_MINIMUM_THRESHOLD_value and &H3f), 10) + leftShift((write_MANUAL_DETECT_MV_TRANSITION_THRESHOLD_value and &H3ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_DETECT_MV_START_MINIMUM_THRESHOLD_value = rightShift(data_low, 10) and &H3f
        MANUAL_DETECT_MV_TRANSITION_THRESHOLD_mask = &H3ff
        if data_low > LONG_MAX then
            if MANUAL_DETECT_MV_TRANSITION_THRESHOLD_mask = mask then
                read_MANUAL_DETECT_MV_TRANSITION_THRESHOLD_value = data_low
            else
                read_MANUAL_DETECT_MV_TRANSITION_THRESHOLD_value = (data_low - H8000_0000) and MANUAL_DETECT_MV_TRANSITION_THRESHOLD_mask
            end If
        else
            read_MANUAL_DETECT_MV_TRANSITION_THRESHOLD_value = data_low and MANUAL_DETECT_MV_TRANSITION_THRESHOLD_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_DETECT_MV_START_MINIMUM_THRESHOLD_value = &H0
        flag_DETECT_MV_START_MINIMUM_THRESHOLD        = &H0
        write_MANUAL_DETECT_MV_TRANSITION_THRESHOLD_value = &H0
        flag_MANUAL_DETECT_MV_TRANSITION_THRESHOLD        = &H0
    End Sub
End Class


'' @REGISTER : CL45VEN_autoneg_test_reg8
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' AUTONEG_PGA_VALUE                          [15:10]          get_AUTONEG_PGA_VALUE
''                                                             set_AUTONEG_PGA_VALUE
''                                                             read_AUTONEG_PGA_VALUE
''                                                             write_AUTONEG_PGA_VALUE
''---------------------------------------------------------------------------------
'' MANUAL_DETECT_MV_END_THRESHOLD             [9:0]            get_MANUAL_DETECT_MV_END_THRESHOLD
''                                                             set_MANUAL_DETECT_MV_END_THRESHOLD
''                                                             read_MANUAL_DETECT_MV_END_THRESHOLD
''                                                             write_MANUAL_DETECT_MV_END_THRESHOLD
''---------------------------------------------------------------------------------
Class REGISTER_CL45VEN_autoneg_test_reg8
    Private write_AUTONEG_PGA_VALUE_value
    Private read_AUTONEG_PGA_VALUE_value
    Private flag_AUTONEG_PGA_VALUE
    Private write_MANUAL_DETECT_MV_END_THRESHOLD_value
    Private read_MANUAL_DETECT_MV_END_THRESHOLD_value
    Private flag_MANUAL_DETECT_MV_END_THRESHOLD

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

    Property Get get_AUTONEG_PGA_VALUE
        get_AUTONEG_PGA_VALUE = read_AUTONEG_PGA_VALUE_value
    End Property

    Property Let set_AUTONEG_PGA_VALUE(aData)
        write_AUTONEG_PGA_VALUE_value = aData
        flag_AUTONEG_PGA_VALUE        = &H1
    End Property

    Property Get read_AUTONEG_PGA_VALUE
        read
        read_AUTONEG_PGA_VALUE = read_AUTONEG_PGA_VALUE_value
    End Property

    Property Let write_AUTONEG_PGA_VALUE(aData)
        set_AUTONEG_PGA_VALUE = aData
        write
    End Property

    Property Get get_MANUAL_DETECT_MV_END_THRESHOLD
        get_MANUAL_DETECT_MV_END_THRESHOLD = read_MANUAL_DETECT_MV_END_THRESHOLD_value
    End Property

    Property Let set_MANUAL_DETECT_MV_END_THRESHOLD(aData)
        write_MANUAL_DETECT_MV_END_THRESHOLD_value = aData
        flag_MANUAL_DETECT_MV_END_THRESHOLD        = &H1
    End Property

    Property Get read_MANUAL_DETECT_MV_END_THRESHOLD
        read
        read_MANUAL_DETECT_MV_END_THRESHOLD = read_MANUAL_DETECT_MV_END_THRESHOLD_value
    End Property

    Property Let write_MANUAL_DETECT_MV_END_THRESHOLD(aData)
        set_MANUAL_DETECT_MV_END_THRESHOLD = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_AUTONEG_PGA_VALUE_value = rightShift(data_low, 10) and &H3f
        MANUAL_DETECT_MV_END_THRESHOLD_mask = &H3ff
        if data_low > LONG_MAX then
            if MANUAL_DETECT_MV_END_THRESHOLD_mask = mask then
                read_MANUAL_DETECT_MV_END_THRESHOLD_value = data_low
            else
                read_MANUAL_DETECT_MV_END_THRESHOLD_value = (data_low - H8000_0000) and MANUAL_DETECT_MV_END_THRESHOLD_mask
            end If
        else
            read_MANUAL_DETECT_MV_END_THRESHOLD_value = data_low and MANUAL_DETECT_MV_END_THRESHOLD_mask
        end If

    End Sub

    Sub write
        If flag_AUTONEG_PGA_VALUE = &H0 or flag_MANUAL_DETECT_MV_END_THRESHOLD = &H0 Then read
        If flag_AUTONEG_PGA_VALUE = &H0 Then write_AUTONEG_PGA_VALUE_value = get_AUTONEG_PGA_VALUE
        If flag_MANUAL_DETECT_MV_END_THRESHOLD = &H0 Then write_MANUAL_DETECT_MV_END_THRESHOLD_value = get_MANUAL_DETECT_MV_END_THRESHOLD

        regValue = leftShift((write_AUTONEG_PGA_VALUE_value and &H3f), 10) + leftShift((write_MANUAL_DETECT_MV_END_THRESHOLD_value and &H3ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_AUTONEG_PGA_VALUE_value = rightShift(data_low, 10) and &H3f
        MANUAL_DETECT_MV_END_THRESHOLD_mask = &H3ff
        if data_low > LONG_MAX then
            if MANUAL_DETECT_MV_END_THRESHOLD_mask = mask then
                read_MANUAL_DETECT_MV_END_THRESHOLD_value = data_low
            else
                read_MANUAL_DETECT_MV_END_THRESHOLD_value = (data_low - H8000_0000) and MANUAL_DETECT_MV_END_THRESHOLD_mask
            end If
        else
            read_MANUAL_DETECT_MV_END_THRESHOLD_value = data_low and MANUAL_DETECT_MV_END_THRESHOLD_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_AUTONEG_PGA_VALUE_value = &H0
        flag_AUTONEG_PGA_VALUE        = &H0
        write_MANUAL_DETECT_MV_END_THRESHOLD_value = &H0
        flag_MANUAL_DETECT_MV_END_THRESHOLD        = &H0
    End Sub
End Class


'' @REGISTER : CL45VEN_autoneg_test_reg9
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SPARE_BITS_TEST_REG9                       [15:1]           get_SPARE_BITS_TEST_REG9
''                                                             set_SPARE_BITS_TEST_REG9
''                                                             read_SPARE_BITS_TEST_REG9
''                                                             write_SPARE_BITS_TEST_REG9
''---------------------------------------------------------------------------------
'' TC10_RESOLUTION                            [0:0]            get_TC10_RESOLUTION
''                                                             set_TC10_RESOLUTION
''                                                             read_TC10_RESOLUTION
''                                                             write_TC10_RESOLUTION
''---------------------------------------------------------------------------------
Class REGISTER_CL45VEN_autoneg_test_reg9
    Private write_SPARE_BITS_TEST_REG9_value
    Private read_SPARE_BITS_TEST_REG9_value
    Private flag_SPARE_BITS_TEST_REG9
    Private write_TC10_RESOLUTION_value
    Private read_TC10_RESOLUTION_value
    Private flag_TC10_RESOLUTION

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H112
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SPARE_BITS_TEST_REG9
        get_SPARE_BITS_TEST_REG9 = read_SPARE_BITS_TEST_REG9_value
    End Property

    Property Let set_SPARE_BITS_TEST_REG9(aData)
        write_SPARE_BITS_TEST_REG9_value = aData
        flag_SPARE_BITS_TEST_REG9        = &H1
    End Property

    Property Get read_SPARE_BITS_TEST_REG9
        read
        read_SPARE_BITS_TEST_REG9 = read_SPARE_BITS_TEST_REG9_value
    End Property

    Property Let write_SPARE_BITS_TEST_REG9(aData)
        set_SPARE_BITS_TEST_REG9 = aData
        write
    End Property

    Property Get get_TC10_RESOLUTION
        get_TC10_RESOLUTION = read_TC10_RESOLUTION_value
    End Property

    Property Let set_TC10_RESOLUTION(aData)
        write_TC10_RESOLUTION_value = aData
        flag_TC10_RESOLUTION        = &H1
    End Property

    Property Get read_TC10_RESOLUTION
        read
        read_TC10_RESOLUTION = read_TC10_RESOLUTION_value
    End Property

    Property Let write_TC10_RESOLUTION(aData)
        set_TC10_RESOLUTION = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_SPARE_BITS_TEST_REG9_value = rightShift(data_low, 1) and &H7fff
        TC10_RESOLUTION_mask = &H1
        if data_low > LONG_MAX then
            if TC10_RESOLUTION_mask = mask then
                read_TC10_RESOLUTION_value = data_low
            else
                read_TC10_RESOLUTION_value = (data_low - H8000_0000) and TC10_RESOLUTION_mask
            end If
        else
            read_TC10_RESOLUTION_value = data_low and TC10_RESOLUTION_mask
        end If

    End Sub

    Sub write
        If flag_SPARE_BITS_TEST_REG9 = &H0 or flag_TC10_RESOLUTION = &H0 Then read
        If flag_SPARE_BITS_TEST_REG9 = &H0 Then write_SPARE_BITS_TEST_REG9_value = get_SPARE_BITS_TEST_REG9
        If flag_TC10_RESOLUTION = &H0 Then write_TC10_RESOLUTION_value = get_TC10_RESOLUTION

        regValue = leftShift((write_SPARE_BITS_TEST_REG9_value and &H7fff), 1) + leftShift((write_TC10_RESOLUTION_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_SPARE_BITS_TEST_REG9_value = rightShift(data_low, 1) and &H7fff
        TC10_RESOLUTION_mask = &H1
        if data_low > LONG_MAX then
            if TC10_RESOLUTION_mask = mask then
                read_TC10_RESOLUTION_value = data_low
            else
                read_TC10_RESOLUTION_value = (data_low - H8000_0000) and TC10_RESOLUTION_mask
            end If
        else
            read_TC10_RESOLUTION_value = data_low and TC10_RESOLUTION_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SPARE_BITS_TEST_REG9_value = &H0
        flag_SPARE_BITS_TEST_REG9        = &H0
        write_TC10_RESOLUTION_value = &H0
        flag_TC10_RESOLUTION        = &H0
    End Sub
End Class


'' @REGISTER : CL45VEN_autoneg_interrupt_status_reg
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' AISRSB1512                                 [15:12]          get_AISRSB1512
''                                                             set_AISRSB1512
''                                                             read_AISRSB1512
''                                                             write_AISRSB1512
''---------------------------------------------------------------------------------
'' AWDIS                                      [11:11]          get_AWDIS
''                                                             set_AWDIS
''                                                             read_AWDIS
''                                                             write_AWDIS
''---------------------------------------------------------------------------------
'' ALGCIS                                     [10:10]          get_ALGCIS
''                                                             set_ALGCIS
''                                                             read_ALGCIS
''                                                             write_ALGCIS
''---------------------------------------------------------------------------------
'' MR_AUTONEG_RESTARTED_INTERRUPT_STATUS      [9:9]            get_MR_AUTONEG_RESTARTED_INTERRUPT_STATUS
''                                                             set_MR_AUTONEG_RESTARTED_INTERRUPT_STATUS
''                                                             read_MR_AUTONEG_RESTARTED_INTERRUPT_STATUS
''                                                             write_MR_AUTONEG_RESTARTED_INTERRUPT_STATUS
''---------------------------------------------------------------------------------
'' AISRSB8                                    [8:8]            get_AISRSB8
''                                                             set_AISRSB8
''                                                             read_AISRSB8
''                                                             write_AISRSB8
''---------------------------------------------------------------------------------
'' CONFIGURATION_FAULT_INTERRUPT_STATUS       [7:7]            get_CONFIGURATION_FAULT_INTERRUPT_STATUS
''                                                             set_CONFIGURATION_FAULT_INTERRUPT_STATUS
''                                                             read_CONFIGURATION_FAULT_INTERRUPT_STATUS
''                                                             write_CONFIGURATION_FAULT_INTERRUPT_STATUS
''---------------------------------------------------------------------------------
'' MR_PAGE_RX_INTERRUPT_STATUS                [6:6]            get_MR_PAGE_RX_INTERRUPT_STATUS
''                                                             set_MR_PAGE_RX_INTERRUPT_STATUS
''                                                             read_MR_PAGE_RX_INTERRUPT_STATUS
''                                                             write_MR_PAGE_RX_INTERRUPT_STATUS
''---------------------------------------------------------------------------------
'' MR_AUTONEG_COMPLETE_INTERRUPT_STATUS       [5:5]            get_MR_AUTONEG_COMPLETE_INTERRUPT_STATUS
''                                                             set_MR_AUTONEG_COMPLETE_INTERRUPT_STATUS
''                                                             read_MR_AUTONEG_COMPLETE_INTERRUPT_STATUS
''                                                             write_MR_AUTONEG_COMPLETE_INTERRUPT_STATUS
''---------------------------------------------------------------------------------
'' REMOTE_FAULT_INTERRUPT_STATUS              [4:4]            get_REMOTE_FAULT_INTERRUPT_STATUS
''                                                             set_REMOTE_FAULT_INTERRUPT_STATUS
''                                                             read_REMOTE_FAULT_INTERRUPT_STATUS
''                                                             write_REMOTE_FAULT_INTERRUPT_STATUS
''---------------------------------------------------------------------------------
'' AISRSB3                                    [3:3]            get_AISRSB3
''                                                             set_AISRSB3
''                                                             read_AISRSB3
''                                                             write_AISRSB3
''---------------------------------------------------------------------------------
'' AISRSB2                                    [2:2]            get_AISRSB2
''                                                             set_AISRSB2
''                                                             read_AISRSB2
''                                                             write_AISRSB2
''---------------------------------------------------------------------------------
'' RLSUIS                                     [1:1]            get_RLSUIS
''                                                             set_RLSUIS
''                                                             read_RLSUIS
''                                                             write_RLSUIS
''---------------------------------------------------------------------------------
'' RLSDIS                                     [0:0]            get_RLSDIS
''                                                             set_RLSDIS
''                                                             read_RLSDIS
''                                                             write_RLSDIS
''---------------------------------------------------------------------------------
Class REGISTER_CL45VEN_autoneg_interrupt_status_reg
    Private write_AISRSB1512_value
    Private read_AISRSB1512_value
    Private flag_AISRSB1512
    Private write_AWDIS_value
    Private read_AWDIS_value
    Private flag_AWDIS
    Private write_ALGCIS_value
    Private read_ALGCIS_value
    Private flag_ALGCIS
    Private write_MR_AUTONEG_RESTARTED_INTERRUPT_STATUS_value
    Private read_MR_AUTONEG_RESTARTED_INTERRUPT_STATUS_value
    Private flag_MR_AUTONEG_RESTARTED_INTERRUPT_STATUS
    Private write_AISRSB8_value
    Private read_AISRSB8_value
    Private flag_AISRSB8
    Private write_CONFIGURATION_FAULT_INTERRUPT_STATUS_value
    Private read_CONFIGURATION_FAULT_INTERRUPT_STATUS_value
    Private flag_CONFIGURATION_FAULT_INTERRUPT_STATUS
    Private write_MR_PAGE_RX_INTERRUPT_STATUS_value
    Private read_MR_PAGE_RX_INTERRUPT_STATUS_value
    Private flag_MR_PAGE_RX_INTERRUPT_STATUS
    Private write_MR_AUTONEG_COMPLETE_INTERRUPT_STATUS_value
    Private read_MR_AUTONEG_COMPLETE_INTERRUPT_STATUS_value
    Private flag_MR_AUTONEG_COMPLETE_INTERRUPT_STATUS
    Private write_REMOTE_FAULT_INTERRUPT_STATUS_value
    Private read_REMOTE_FAULT_INTERRUPT_STATUS_value
    Private flag_REMOTE_FAULT_INTERRUPT_STATUS
    Private write_AISRSB3_value
    Private read_AISRSB3_value
    Private flag_AISRSB3
    Private write_AISRSB2_value
    Private read_AISRSB2_value
    Private flag_AISRSB2
    Private write_RLSUIS_value
    Private read_RLSUIS_value
    Private flag_RLSUIS
    Private write_RLSDIS_value
    Private read_RLSDIS_value
    Private flag_RLSDIS

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

    Property Get get_AISRSB1512
        get_AISRSB1512 = read_AISRSB1512_value
    End Property

    Property Let set_AISRSB1512(aData)
        write_AISRSB1512_value = aData
        flag_AISRSB1512        = &H1
    End Property

    Property Get read_AISRSB1512
        read
        read_AISRSB1512 = read_AISRSB1512_value
    End Property

    Property Let write_AISRSB1512(aData)
        set_AISRSB1512 = aData
        write
    End Property

    Property Get get_AWDIS
        get_AWDIS = read_AWDIS_value
    End Property

    Property Let set_AWDIS(aData)
        write_AWDIS_value = aData
        flag_AWDIS        = &H1
    End Property

    Property Get read_AWDIS
        read
        read_AWDIS = read_AWDIS_value
    End Property

    Property Let write_AWDIS(aData)
        set_AWDIS = aData
        write
    End Property

    Property Get get_ALGCIS
        get_ALGCIS = read_ALGCIS_value
    End Property

    Property Let set_ALGCIS(aData)
        write_ALGCIS_value = aData
        flag_ALGCIS        = &H1
    End Property

    Property Get read_ALGCIS
        read
        read_ALGCIS = read_ALGCIS_value
    End Property

    Property Let write_ALGCIS(aData)
        set_ALGCIS = aData
        write
    End Property

    Property Get get_MR_AUTONEG_RESTARTED_INTERRUPT_STATUS
        get_MR_AUTONEG_RESTARTED_INTERRUPT_STATUS = read_MR_AUTONEG_RESTARTED_INTERRUPT_STATUS_value
    End Property

    Property Let set_MR_AUTONEG_RESTARTED_INTERRUPT_STATUS(aData)
        write_MR_AUTONEG_RESTARTED_INTERRUPT_STATUS_value = aData
        flag_MR_AUTONEG_RESTARTED_INTERRUPT_STATUS        = &H1
    End Property

    Property Get read_MR_AUTONEG_RESTARTED_INTERRUPT_STATUS
        read
        read_MR_AUTONEG_RESTARTED_INTERRUPT_STATUS = read_MR_AUTONEG_RESTARTED_INTERRUPT_STATUS_value
    End Property

    Property Let write_MR_AUTONEG_RESTARTED_INTERRUPT_STATUS(aData)
        set_MR_AUTONEG_RESTARTED_INTERRUPT_STATUS = aData
        write
    End Property

    Property Get get_AISRSB8
        get_AISRSB8 = read_AISRSB8_value
    End Property

    Property Let set_AISRSB8(aData)
        write_AISRSB8_value = aData
        flag_AISRSB8        = &H1
    End Property

    Property Get read_AISRSB8
        read
        read_AISRSB8 = read_AISRSB8_value
    End Property

    Property Let write_AISRSB8(aData)
        set_AISRSB8 = aData
        write
    End Property

    Property Get get_CONFIGURATION_FAULT_INTERRUPT_STATUS
        get_CONFIGURATION_FAULT_INTERRUPT_STATUS = read_CONFIGURATION_FAULT_INTERRUPT_STATUS_value
    End Property

    Property Let set_CONFIGURATION_FAULT_INTERRUPT_STATUS(aData)
        write_CONFIGURATION_FAULT_INTERRUPT_STATUS_value = aData
        flag_CONFIGURATION_FAULT_INTERRUPT_STATUS        = &H1
    End Property

    Property Get read_CONFIGURATION_FAULT_INTERRUPT_STATUS
        read
        read_CONFIGURATION_FAULT_INTERRUPT_STATUS = read_CONFIGURATION_FAULT_INTERRUPT_STATUS_value
    End Property

    Property Let write_CONFIGURATION_FAULT_INTERRUPT_STATUS(aData)
        set_CONFIGURATION_FAULT_INTERRUPT_STATUS = aData
        write
    End Property

    Property Get get_MR_PAGE_RX_INTERRUPT_STATUS
        get_MR_PAGE_RX_INTERRUPT_STATUS = read_MR_PAGE_RX_INTERRUPT_STATUS_value
    End Property

    Property Let set_MR_PAGE_RX_INTERRUPT_STATUS(aData)
        write_MR_PAGE_RX_INTERRUPT_STATUS_value = aData
        flag_MR_PAGE_RX_INTERRUPT_STATUS        = &H1
    End Property

    Property Get read_MR_PAGE_RX_INTERRUPT_STATUS
        read
        read_MR_PAGE_RX_INTERRUPT_STATUS = read_MR_PAGE_RX_INTERRUPT_STATUS_value
    End Property

    Property Let write_MR_PAGE_RX_INTERRUPT_STATUS(aData)
        set_MR_PAGE_RX_INTERRUPT_STATUS = aData
        write
    End Property

    Property Get get_MR_AUTONEG_COMPLETE_INTERRUPT_STATUS
        get_MR_AUTONEG_COMPLETE_INTERRUPT_STATUS = read_MR_AUTONEG_COMPLETE_INTERRUPT_STATUS_value
    End Property

    Property Let set_MR_AUTONEG_COMPLETE_INTERRUPT_STATUS(aData)
        write_MR_AUTONEG_COMPLETE_INTERRUPT_STATUS_value = aData
        flag_MR_AUTONEG_COMPLETE_INTERRUPT_STATUS        = &H1
    End Property

    Property Get read_MR_AUTONEG_COMPLETE_INTERRUPT_STATUS
        read
        read_MR_AUTONEG_COMPLETE_INTERRUPT_STATUS = read_MR_AUTONEG_COMPLETE_INTERRUPT_STATUS_value
    End Property

    Property Let write_MR_AUTONEG_COMPLETE_INTERRUPT_STATUS(aData)
        set_MR_AUTONEG_COMPLETE_INTERRUPT_STATUS = aData
        write
    End Property

    Property Get get_REMOTE_FAULT_INTERRUPT_STATUS
        get_REMOTE_FAULT_INTERRUPT_STATUS = read_REMOTE_FAULT_INTERRUPT_STATUS_value
    End Property

    Property Let set_REMOTE_FAULT_INTERRUPT_STATUS(aData)
        write_REMOTE_FAULT_INTERRUPT_STATUS_value = aData
        flag_REMOTE_FAULT_INTERRUPT_STATUS        = &H1
    End Property

    Property Get read_REMOTE_FAULT_INTERRUPT_STATUS
        read
        read_REMOTE_FAULT_INTERRUPT_STATUS = read_REMOTE_FAULT_INTERRUPT_STATUS_value
    End Property

    Property Let write_REMOTE_FAULT_INTERRUPT_STATUS(aData)
        set_REMOTE_FAULT_INTERRUPT_STATUS = aData
        write
    End Property

    Property Get get_AISRSB3
        get_AISRSB3 = read_AISRSB3_value
    End Property

    Property Let set_AISRSB3(aData)
        write_AISRSB3_value = aData
        flag_AISRSB3        = &H1
    End Property

    Property Get read_AISRSB3
        read
        read_AISRSB3 = read_AISRSB3_value
    End Property

    Property Let write_AISRSB3(aData)
        set_AISRSB3 = aData
        write
    End Property

    Property Get get_AISRSB2
        get_AISRSB2 = read_AISRSB2_value
    End Property

    Property Let set_AISRSB2(aData)
        write_AISRSB2_value = aData
        flag_AISRSB2        = &H1
    End Property

    Property Get read_AISRSB2
        read
        read_AISRSB2 = read_AISRSB2_value
    End Property

    Property Let write_AISRSB2(aData)
        set_AISRSB2 = aData
        write
    End Property

    Property Get get_RLSUIS
        get_RLSUIS = read_RLSUIS_value
    End Property

    Property Let set_RLSUIS(aData)
        write_RLSUIS_value = aData
        flag_RLSUIS        = &H1
    End Property

    Property Get read_RLSUIS
        read
        read_RLSUIS = read_RLSUIS_value
    End Property

    Property Let write_RLSUIS(aData)
        set_RLSUIS = aData
        write
    End Property

    Property Get get_RLSDIS
        get_RLSDIS = read_RLSDIS_value
    End Property

    Property Let set_RLSDIS(aData)
        write_RLSDIS_value = aData
        flag_RLSDIS        = &H1
    End Property

    Property Get read_RLSDIS
        read
        read_RLSDIS = read_RLSDIS_value
    End Property

    Property Let write_RLSDIS(aData)
        set_RLSDIS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_AISRSB1512_value = rightShift(data_low, 12) and &Hf
        read_AWDIS_value = rightShift(data_low, 11) and &H1
        read_ALGCIS_value = rightShift(data_low, 10) and &H1
        read_MR_AUTONEG_RESTARTED_INTERRUPT_STATUS_value = rightShift(data_low, 9) and &H1
        read_AISRSB8_value = rightShift(data_low, 8) and &H1
        read_CONFIGURATION_FAULT_INTERRUPT_STATUS_value = rightShift(data_low, 7) and &H1
        read_MR_PAGE_RX_INTERRUPT_STATUS_value = rightShift(data_low, 6) and &H1
        read_MR_AUTONEG_COMPLETE_INTERRUPT_STATUS_value = rightShift(data_low, 5) and &H1
        read_REMOTE_FAULT_INTERRUPT_STATUS_value = rightShift(data_low, 4) and &H1
        read_AISRSB3_value = rightShift(data_low, 3) and &H1
        read_AISRSB2_value = rightShift(data_low, 2) and &H1
        read_RLSUIS_value = rightShift(data_low, 1) and &H1
        RLSDIS_mask = &H1
        if data_low > LONG_MAX then
            if RLSDIS_mask = mask then
                read_RLSDIS_value = data_low
            else
                read_RLSDIS_value = (data_low - H8000_0000) and RLSDIS_mask
            end If
        else
            read_RLSDIS_value = data_low and RLSDIS_mask
        end If

    End Sub

    Sub write
        If flag_AISRSB1512 = &H0 or flag_AWDIS = &H0 or flag_ALGCIS = &H0 or flag_MR_AUTONEG_RESTARTED_INTERRUPT_STATUS = &H0 or flag_AISRSB8 = &H0 or flag_CONFIGURATION_FAULT_INTERRUPT_STATUS = &H0 or flag_MR_PAGE_RX_INTERRUPT_STATUS = &H0 or flag_MR_AUTONEG_COMPLETE_INTERRUPT_STATUS = &H0 or flag_REMOTE_FAULT_INTERRUPT_STATUS = &H0 or flag_AISRSB3 = &H0 or flag_AISRSB2 = &H0 or flag_RLSUIS = &H0 or flag_RLSDIS = &H0 Then read
        If flag_AISRSB1512 = &H0 Then write_AISRSB1512_value = get_AISRSB1512
        If flag_AWDIS = &H0 Then write_AWDIS_value = get_AWDIS
        If flag_ALGCIS = &H0 Then write_ALGCIS_value = get_ALGCIS
        If flag_MR_AUTONEG_RESTARTED_INTERRUPT_STATUS = &H0 Then write_MR_AUTONEG_RESTARTED_INTERRUPT_STATUS_value = get_MR_AUTONEG_RESTARTED_INTERRUPT_STATUS
        If flag_AISRSB8 = &H0 Then write_AISRSB8_value = get_AISRSB8
        If flag_CONFIGURATION_FAULT_INTERRUPT_STATUS = &H0 Then write_CONFIGURATION_FAULT_INTERRUPT_STATUS_value = get_CONFIGURATION_FAULT_INTERRUPT_STATUS
        If flag_MR_PAGE_RX_INTERRUPT_STATUS = &H0 Then write_MR_PAGE_RX_INTERRUPT_STATUS_value = get_MR_PAGE_RX_INTERRUPT_STATUS
        If flag_MR_AUTONEG_COMPLETE_INTERRUPT_STATUS = &H0 Then write_MR_AUTONEG_COMPLETE_INTERRUPT_STATUS_value = get_MR_AUTONEG_COMPLETE_INTERRUPT_STATUS
        If flag_REMOTE_FAULT_INTERRUPT_STATUS = &H0 Then write_REMOTE_FAULT_INTERRUPT_STATUS_value = get_REMOTE_FAULT_INTERRUPT_STATUS
        If flag_AISRSB3 = &H0 Then write_AISRSB3_value = get_AISRSB3
        If flag_AISRSB2 = &H0 Then write_AISRSB2_value = get_AISRSB2
        If flag_RLSUIS = &H0 Then write_RLSUIS_value = get_RLSUIS
        If flag_RLSDIS = &H0 Then write_RLSDIS_value = get_RLSDIS

        regValue = leftShift((write_AISRSB1512_value and &Hf), 12) + leftShift((write_AWDIS_value and &H1), 11) + leftShift((write_ALGCIS_value and &H1), 10) + leftShift((write_MR_AUTONEG_RESTARTED_INTERRUPT_STATUS_value and &H1), 9) + leftShift((write_AISRSB8_value and &H1), 8) + leftShift((write_CONFIGURATION_FAULT_INTERRUPT_STATUS_value and &H1), 7) + leftShift((write_MR_PAGE_RX_INTERRUPT_STATUS_value and &H1), 6) + leftShift((write_MR_AUTONEG_COMPLETE_INTERRUPT_STATUS_value and &H1), 5) + leftShift((write_REMOTE_FAULT_INTERRUPT_STATUS_value and &H1), 4) + leftShift((write_AISRSB3_value and &H1), 3) + leftShift((write_AISRSB2_value and &H1), 2) + leftShift((write_RLSUIS_value and &H1), 1) + leftShift((write_RLSDIS_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_AISRSB1512_value = rightShift(data_low, 12) and &Hf
        read_AWDIS_value = rightShift(data_low, 11) and &H1
        read_ALGCIS_value = rightShift(data_low, 10) and &H1
        read_MR_AUTONEG_RESTARTED_INTERRUPT_STATUS_value = rightShift(data_low, 9) and &H1
        read_AISRSB8_value = rightShift(data_low, 8) and &H1
        read_CONFIGURATION_FAULT_INTERRUPT_STATUS_value = rightShift(data_low, 7) and &H1
        read_MR_PAGE_RX_INTERRUPT_STATUS_value = rightShift(data_low, 6) and &H1
        read_MR_AUTONEG_COMPLETE_INTERRUPT_STATUS_value = rightShift(data_low, 5) and &H1
        read_REMOTE_FAULT_INTERRUPT_STATUS_value = rightShift(data_low, 4) and &H1
        read_AISRSB3_value = rightShift(data_low, 3) and &H1
        read_AISRSB2_value = rightShift(data_low, 2) and &H1
        read_RLSUIS_value = rightShift(data_low, 1) and &H1
        RLSDIS_mask = &H1
        if data_low > LONG_MAX then
            if RLSDIS_mask = mask then
                read_RLSDIS_value = data_low
            else
                read_RLSDIS_value = (data_low - H8000_0000) and RLSDIS_mask
            end If
        else
            read_RLSDIS_value = data_low and RLSDIS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_AISRSB1512_value = &H0
        flag_AISRSB1512        = &H0
        write_AWDIS_value = &H0
        flag_AWDIS        = &H0
        write_ALGCIS_value = &H0
        flag_ALGCIS        = &H0
        write_MR_AUTONEG_RESTARTED_INTERRUPT_STATUS_value = &H0
        flag_MR_AUTONEG_RESTARTED_INTERRUPT_STATUS        = &H0
        write_AISRSB8_value = &H0
        flag_AISRSB8        = &H0
        write_CONFIGURATION_FAULT_INTERRUPT_STATUS_value = &H0
        flag_CONFIGURATION_FAULT_INTERRUPT_STATUS        = &H0
        write_MR_PAGE_RX_INTERRUPT_STATUS_value = &H0
        flag_MR_PAGE_RX_INTERRUPT_STATUS        = &H0
        write_MR_AUTONEG_COMPLETE_INTERRUPT_STATUS_value = &H0
        flag_MR_AUTONEG_COMPLETE_INTERRUPT_STATUS        = &H0
        write_REMOTE_FAULT_INTERRUPT_STATUS_value = &H0
        flag_REMOTE_FAULT_INTERRUPT_STATUS        = &H0
        write_AISRSB3_value = &H0
        flag_AISRSB3        = &H0
        write_AISRSB2_value = &H0
        flag_AISRSB2        = &H0
        write_RLSUIS_value = &H0
        flag_RLSUIS        = &H0
        write_RLSDIS_value = &H0
        flag_RLSDIS        = &H0
    End Sub
End Class


'' @REGISTER : CL45VEN_autoneg_interrupt_enable_reg
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' AIERSB1512                                 [15:12]          get_AIERSB1512
''                                                             set_AIERSB1512
''                                                             read_AIERSB1512
''                                                             write_AIERSB1512
''---------------------------------------------------------------------------------
'' AWDIE                                      [11:11]          get_AWDIE
''                                                             set_AWDIE
''                                                             read_AWDIE
''                                                             write_AWDIE
''---------------------------------------------------------------------------------
'' ALGCIE                                     [10:10]          get_ALGCIE
''                                                             set_ALGCIE
''                                                             read_ALGCIE
''                                                             write_ALGCIE
''---------------------------------------------------------------------------------
'' MR_AUTONEG_RESTARTED_INTERRUPT_ENABLE      [9:9]            get_MR_AUTONEG_RESTARTED_INTERRUPT_ENABLE
''                                                             set_MR_AUTONEG_RESTARTED_INTERRUPT_ENABLE
''                                                             read_MR_AUTONEG_RESTARTED_INTERRUPT_ENABLE
''                                                             write_MR_AUTONEG_RESTARTED_INTERRUPT_ENABLE
''---------------------------------------------------------------------------------
'' AIERSB8                                    [8:8]            get_AIERSB8
''                                                             set_AIERSB8
''                                                             read_AIERSB8
''                                                             write_AIERSB8
''---------------------------------------------------------------------------------
'' CONFIGURATION_FAULT_INTERRUPT_ENABLE       [7:7]            get_CONFIGURATION_FAULT_INTERRUPT_ENABLE
''                                                             set_CONFIGURATION_FAULT_INTERRUPT_ENABLE
''                                                             read_CONFIGURATION_FAULT_INTERRUPT_ENABLE
''                                                             write_CONFIGURATION_FAULT_INTERRUPT_ENABLE
''---------------------------------------------------------------------------------
'' MR_PAGE_RX_INTERRUPT_ENABLE                [6:6]            get_MR_PAGE_RX_INTERRUPT_ENABLE
''                                                             set_MR_PAGE_RX_INTERRUPT_ENABLE
''                                                             read_MR_PAGE_RX_INTERRUPT_ENABLE
''                                                             write_MR_PAGE_RX_INTERRUPT_ENABLE
''---------------------------------------------------------------------------------
'' MR_AUTONEG_COMPLETE_INTERRUPT_ENABLE       [5:5]            get_MR_AUTONEG_COMPLETE_INTERRUPT_ENABLE
''                                                             set_MR_AUTONEG_COMPLETE_INTERRUPT_ENABLE
''                                                             read_MR_AUTONEG_COMPLETE_INTERRUPT_ENABLE
''                                                             write_MR_AUTONEG_COMPLETE_INTERRUPT_ENABLE
''---------------------------------------------------------------------------------
'' REMOTE_FAULT_INTERRUPT_ENABLE              [4:4]            get_REMOTE_FAULT_INTERRUPT_ENABLE
''                                                             set_REMOTE_FAULT_INTERRUPT_ENABLE
''                                                             read_REMOTE_FAULT_INTERRUPT_ENABLE
''                                                             write_REMOTE_FAULT_INTERRUPT_ENABLE
''---------------------------------------------------------------------------------
'' AIERSB3                                    [3:3]            get_AIERSB3
''                                                             set_AIERSB3
''                                                             read_AIERSB3
''                                                             write_AIERSB3
''---------------------------------------------------------------------------------
'' AIERSB2                                    [2:2]            get_AIERSB2
''                                                             set_AIERSB2
''                                                             read_AIERSB2
''                                                             write_AIERSB2
''---------------------------------------------------------------------------------
'' RLSUIE                                     [1:1]            get_RLSUIE
''                                                             set_RLSUIE
''                                                             read_RLSUIE
''                                                             write_RLSUIE
''---------------------------------------------------------------------------------
'' RLSDIE                                     [0:0]            get_RLSDIE
''                                                             set_RLSDIE
''                                                             read_RLSDIE
''                                                             write_RLSDIE
''---------------------------------------------------------------------------------
Class REGISTER_CL45VEN_autoneg_interrupt_enable_reg
    Private write_AIERSB1512_value
    Private read_AIERSB1512_value
    Private flag_AIERSB1512
    Private write_AWDIE_value
    Private read_AWDIE_value
    Private flag_AWDIE
    Private write_ALGCIE_value
    Private read_ALGCIE_value
    Private flag_ALGCIE
    Private write_MR_AUTONEG_RESTARTED_INTERRUPT_ENABLE_value
    Private read_MR_AUTONEG_RESTARTED_INTERRUPT_ENABLE_value
    Private flag_MR_AUTONEG_RESTARTED_INTERRUPT_ENABLE
    Private write_AIERSB8_value
    Private read_AIERSB8_value
    Private flag_AIERSB8
    Private write_CONFIGURATION_FAULT_INTERRUPT_ENABLE_value
    Private read_CONFIGURATION_FAULT_INTERRUPT_ENABLE_value
    Private flag_CONFIGURATION_FAULT_INTERRUPT_ENABLE
    Private write_MR_PAGE_RX_INTERRUPT_ENABLE_value
    Private read_MR_PAGE_RX_INTERRUPT_ENABLE_value
    Private flag_MR_PAGE_RX_INTERRUPT_ENABLE
    Private write_MR_AUTONEG_COMPLETE_INTERRUPT_ENABLE_value
    Private read_MR_AUTONEG_COMPLETE_INTERRUPT_ENABLE_value
    Private flag_MR_AUTONEG_COMPLETE_INTERRUPT_ENABLE
    Private write_REMOTE_FAULT_INTERRUPT_ENABLE_value
    Private read_REMOTE_FAULT_INTERRUPT_ENABLE_value
    Private flag_REMOTE_FAULT_INTERRUPT_ENABLE
    Private write_AIERSB3_value
    Private read_AIERSB3_value
    Private flag_AIERSB3
    Private write_AIERSB2_value
    Private read_AIERSB2_value
    Private flag_AIERSB2
    Private write_RLSUIE_value
    Private read_RLSUIE_value
    Private flag_RLSUIE
    Private write_RLSDIE_value
    Private read_RLSDIE_value
    Private flag_RLSDIE

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H122
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_AIERSB1512
        get_AIERSB1512 = read_AIERSB1512_value
    End Property

    Property Let set_AIERSB1512(aData)
        write_AIERSB1512_value = aData
        flag_AIERSB1512        = &H1
    End Property

    Property Get read_AIERSB1512
        read
        read_AIERSB1512 = read_AIERSB1512_value
    End Property

    Property Let write_AIERSB1512(aData)
        set_AIERSB1512 = aData
        write
    End Property

    Property Get get_AWDIE
        get_AWDIE = read_AWDIE_value
    End Property

    Property Let set_AWDIE(aData)
        write_AWDIE_value = aData
        flag_AWDIE        = &H1
    End Property

    Property Get read_AWDIE
        read
        read_AWDIE = read_AWDIE_value
    End Property

    Property Let write_AWDIE(aData)
        set_AWDIE = aData
        write
    End Property

    Property Get get_ALGCIE
        get_ALGCIE = read_ALGCIE_value
    End Property

    Property Let set_ALGCIE(aData)
        write_ALGCIE_value = aData
        flag_ALGCIE        = &H1
    End Property

    Property Get read_ALGCIE
        read
        read_ALGCIE = read_ALGCIE_value
    End Property

    Property Let write_ALGCIE(aData)
        set_ALGCIE = aData
        write
    End Property

    Property Get get_MR_AUTONEG_RESTARTED_INTERRUPT_ENABLE
        get_MR_AUTONEG_RESTARTED_INTERRUPT_ENABLE = read_MR_AUTONEG_RESTARTED_INTERRUPT_ENABLE_value
    End Property

    Property Let set_MR_AUTONEG_RESTARTED_INTERRUPT_ENABLE(aData)
        write_MR_AUTONEG_RESTARTED_INTERRUPT_ENABLE_value = aData
        flag_MR_AUTONEG_RESTARTED_INTERRUPT_ENABLE        = &H1
    End Property

    Property Get read_MR_AUTONEG_RESTARTED_INTERRUPT_ENABLE
        read
        read_MR_AUTONEG_RESTARTED_INTERRUPT_ENABLE = read_MR_AUTONEG_RESTARTED_INTERRUPT_ENABLE_value
    End Property

    Property Let write_MR_AUTONEG_RESTARTED_INTERRUPT_ENABLE(aData)
        set_MR_AUTONEG_RESTARTED_INTERRUPT_ENABLE = aData
        write
    End Property

    Property Get get_AIERSB8
        get_AIERSB8 = read_AIERSB8_value
    End Property

    Property Let set_AIERSB8(aData)
        write_AIERSB8_value = aData
        flag_AIERSB8        = &H1
    End Property

    Property Get read_AIERSB8
        read
        read_AIERSB8 = read_AIERSB8_value
    End Property

    Property Let write_AIERSB8(aData)
        set_AIERSB8 = aData
        write
    End Property

    Property Get get_CONFIGURATION_FAULT_INTERRUPT_ENABLE
        get_CONFIGURATION_FAULT_INTERRUPT_ENABLE = read_CONFIGURATION_FAULT_INTERRUPT_ENABLE_value
    End Property

    Property Let set_CONFIGURATION_FAULT_INTERRUPT_ENABLE(aData)
        write_CONFIGURATION_FAULT_INTERRUPT_ENABLE_value = aData
        flag_CONFIGURATION_FAULT_INTERRUPT_ENABLE        = &H1
    End Property

    Property Get read_CONFIGURATION_FAULT_INTERRUPT_ENABLE
        read
        read_CONFIGURATION_FAULT_INTERRUPT_ENABLE = read_CONFIGURATION_FAULT_INTERRUPT_ENABLE_value
    End Property

    Property Let write_CONFIGURATION_FAULT_INTERRUPT_ENABLE(aData)
        set_CONFIGURATION_FAULT_INTERRUPT_ENABLE = aData
        write
    End Property

    Property Get get_MR_PAGE_RX_INTERRUPT_ENABLE
        get_MR_PAGE_RX_INTERRUPT_ENABLE = read_MR_PAGE_RX_INTERRUPT_ENABLE_value
    End Property

    Property Let set_MR_PAGE_RX_INTERRUPT_ENABLE(aData)
        write_MR_PAGE_RX_INTERRUPT_ENABLE_value = aData
        flag_MR_PAGE_RX_INTERRUPT_ENABLE        = &H1
    End Property

    Property Get read_MR_PAGE_RX_INTERRUPT_ENABLE
        read
        read_MR_PAGE_RX_INTERRUPT_ENABLE = read_MR_PAGE_RX_INTERRUPT_ENABLE_value
    End Property

    Property Let write_MR_PAGE_RX_INTERRUPT_ENABLE(aData)
        set_MR_PAGE_RX_INTERRUPT_ENABLE = aData
        write
    End Property

    Property Get get_MR_AUTONEG_COMPLETE_INTERRUPT_ENABLE
        get_MR_AUTONEG_COMPLETE_INTERRUPT_ENABLE = read_MR_AUTONEG_COMPLETE_INTERRUPT_ENABLE_value
    End Property

    Property Let set_MR_AUTONEG_COMPLETE_INTERRUPT_ENABLE(aData)
        write_MR_AUTONEG_COMPLETE_INTERRUPT_ENABLE_value = aData
        flag_MR_AUTONEG_COMPLETE_INTERRUPT_ENABLE        = &H1
    End Property

    Property Get read_MR_AUTONEG_COMPLETE_INTERRUPT_ENABLE
        read
        read_MR_AUTONEG_COMPLETE_INTERRUPT_ENABLE = read_MR_AUTONEG_COMPLETE_INTERRUPT_ENABLE_value
    End Property

    Property Let write_MR_AUTONEG_COMPLETE_INTERRUPT_ENABLE(aData)
        set_MR_AUTONEG_COMPLETE_INTERRUPT_ENABLE = aData
        write
    End Property

    Property Get get_REMOTE_FAULT_INTERRUPT_ENABLE
        get_REMOTE_FAULT_INTERRUPT_ENABLE = read_REMOTE_FAULT_INTERRUPT_ENABLE_value
    End Property

    Property Let set_REMOTE_FAULT_INTERRUPT_ENABLE(aData)
        write_REMOTE_FAULT_INTERRUPT_ENABLE_value = aData
        flag_REMOTE_FAULT_INTERRUPT_ENABLE        = &H1
    End Property

    Property Get read_REMOTE_FAULT_INTERRUPT_ENABLE
        read
        read_REMOTE_FAULT_INTERRUPT_ENABLE = read_REMOTE_FAULT_INTERRUPT_ENABLE_value
    End Property

    Property Let write_REMOTE_FAULT_INTERRUPT_ENABLE(aData)
        set_REMOTE_FAULT_INTERRUPT_ENABLE = aData
        write
    End Property

    Property Get get_AIERSB3
        get_AIERSB3 = read_AIERSB3_value
    End Property

    Property Let set_AIERSB3(aData)
        write_AIERSB3_value = aData
        flag_AIERSB3        = &H1
    End Property

    Property Get read_AIERSB3
        read
        read_AIERSB3 = read_AIERSB3_value
    End Property

    Property Let write_AIERSB3(aData)
        set_AIERSB3 = aData
        write
    End Property

    Property Get get_AIERSB2
        get_AIERSB2 = read_AIERSB2_value
    End Property

    Property Let set_AIERSB2(aData)
        write_AIERSB2_value = aData
        flag_AIERSB2        = &H1
    End Property

    Property Get read_AIERSB2
        read
        read_AIERSB2 = read_AIERSB2_value
    End Property

    Property Let write_AIERSB2(aData)
        set_AIERSB2 = aData
        write
    End Property

    Property Get get_RLSUIE
        get_RLSUIE = read_RLSUIE_value
    End Property

    Property Let set_RLSUIE(aData)
        write_RLSUIE_value = aData
        flag_RLSUIE        = &H1
    End Property

    Property Get read_RLSUIE
        read
        read_RLSUIE = read_RLSUIE_value
    End Property

    Property Let write_RLSUIE(aData)
        set_RLSUIE = aData
        write
    End Property

    Property Get get_RLSDIE
        get_RLSDIE = read_RLSDIE_value
    End Property

    Property Let set_RLSDIE(aData)
        write_RLSDIE_value = aData
        flag_RLSDIE        = &H1
    End Property

    Property Get read_RLSDIE
        read
        read_RLSDIE = read_RLSDIE_value
    End Property

    Property Let write_RLSDIE(aData)
        set_RLSDIE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_AIERSB1512_value = rightShift(data_low, 12) and &Hf
        read_AWDIE_value = rightShift(data_low, 11) and &H1
        read_ALGCIE_value = rightShift(data_low, 10) and &H1
        read_MR_AUTONEG_RESTARTED_INTERRUPT_ENABLE_value = rightShift(data_low, 9) and &H1
        read_AIERSB8_value = rightShift(data_low, 8) and &H1
        read_CONFIGURATION_FAULT_INTERRUPT_ENABLE_value = rightShift(data_low, 7) and &H1
        read_MR_PAGE_RX_INTERRUPT_ENABLE_value = rightShift(data_low, 6) and &H1
        read_MR_AUTONEG_COMPLETE_INTERRUPT_ENABLE_value = rightShift(data_low, 5) and &H1
        read_REMOTE_FAULT_INTERRUPT_ENABLE_value = rightShift(data_low, 4) and &H1
        read_AIERSB3_value = rightShift(data_low, 3) and &H1
        read_AIERSB2_value = rightShift(data_low, 2) and &H1
        read_RLSUIE_value = rightShift(data_low, 1) and &H1
        RLSDIE_mask = &H1
        if data_low > LONG_MAX then
            if RLSDIE_mask = mask then
                read_RLSDIE_value = data_low
            else
                read_RLSDIE_value = (data_low - H8000_0000) and RLSDIE_mask
            end If
        else
            read_RLSDIE_value = data_low and RLSDIE_mask
        end If

    End Sub

    Sub write
        If flag_AIERSB1512 = &H0 or flag_AWDIE = &H0 or flag_ALGCIE = &H0 or flag_MR_AUTONEG_RESTARTED_INTERRUPT_ENABLE = &H0 or flag_AIERSB8 = &H0 or flag_CONFIGURATION_FAULT_INTERRUPT_ENABLE = &H0 or flag_MR_PAGE_RX_INTERRUPT_ENABLE = &H0 or flag_MR_AUTONEG_COMPLETE_INTERRUPT_ENABLE = &H0 or flag_REMOTE_FAULT_INTERRUPT_ENABLE = &H0 or flag_AIERSB3 = &H0 or flag_AIERSB2 = &H0 or flag_RLSUIE = &H0 or flag_RLSDIE = &H0 Then read
        If flag_AIERSB1512 = &H0 Then write_AIERSB1512_value = get_AIERSB1512
        If flag_AWDIE = &H0 Then write_AWDIE_value = get_AWDIE
        If flag_ALGCIE = &H0 Then write_ALGCIE_value = get_ALGCIE
        If flag_MR_AUTONEG_RESTARTED_INTERRUPT_ENABLE = &H0 Then write_MR_AUTONEG_RESTARTED_INTERRUPT_ENABLE_value = get_MR_AUTONEG_RESTARTED_INTERRUPT_ENABLE
        If flag_AIERSB8 = &H0 Then write_AIERSB8_value = get_AIERSB8
        If flag_CONFIGURATION_FAULT_INTERRUPT_ENABLE = &H0 Then write_CONFIGURATION_FAULT_INTERRUPT_ENABLE_value = get_CONFIGURATION_FAULT_INTERRUPT_ENABLE
        If flag_MR_PAGE_RX_INTERRUPT_ENABLE = &H0 Then write_MR_PAGE_RX_INTERRUPT_ENABLE_value = get_MR_PAGE_RX_INTERRUPT_ENABLE
        If flag_MR_AUTONEG_COMPLETE_INTERRUPT_ENABLE = &H0 Then write_MR_AUTONEG_COMPLETE_INTERRUPT_ENABLE_value = get_MR_AUTONEG_COMPLETE_INTERRUPT_ENABLE
        If flag_REMOTE_FAULT_INTERRUPT_ENABLE = &H0 Then write_REMOTE_FAULT_INTERRUPT_ENABLE_value = get_REMOTE_FAULT_INTERRUPT_ENABLE
        If flag_AIERSB3 = &H0 Then write_AIERSB3_value = get_AIERSB3
        If flag_AIERSB2 = &H0 Then write_AIERSB2_value = get_AIERSB2
        If flag_RLSUIE = &H0 Then write_RLSUIE_value = get_RLSUIE
        If flag_RLSDIE = &H0 Then write_RLSDIE_value = get_RLSDIE

        regValue = leftShift((write_AIERSB1512_value and &Hf), 12) + leftShift((write_AWDIE_value and &H1), 11) + leftShift((write_ALGCIE_value and &H1), 10) + leftShift((write_MR_AUTONEG_RESTARTED_INTERRUPT_ENABLE_value and &H1), 9) + leftShift((write_AIERSB8_value and &H1), 8) + leftShift((write_CONFIGURATION_FAULT_INTERRUPT_ENABLE_value and &H1), 7) + leftShift((write_MR_PAGE_RX_INTERRUPT_ENABLE_value and &H1), 6) + leftShift((write_MR_AUTONEG_COMPLETE_INTERRUPT_ENABLE_value and &H1), 5) + leftShift((write_REMOTE_FAULT_INTERRUPT_ENABLE_value and &H1), 4) + leftShift((write_AIERSB3_value and &H1), 3) + leftShift((write_AIERSB2_value and &H1), 2) + leftShift((write_RLSUIE_value and &H1), 1) + leftShift((write_RLSDIE_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_AIERSB1512_value = rightShift(data_low, 12) and &Hf
        read_AWDIE_value = rightShift(data_low, 11) and &H1
        read_ALGCIE_value = rightShift(data_low, 10) and &H1
        read_MR_AUTONEG_RESTARTED_INTERRUPT_ENABLE_value = rightShift(data_low, 9) and &H1
        read_AIERSB8_value = rightShift(data_low, 8) and &H1
        read_CONFIGURATION_FAULT_INTERRUPT_ENABLE_value = rightShift(data_low, 7) and &H1
        read_MR_PAGE_RX_INTERRUPT_ENABLE_value = rightShift(data_low, 6) and &H1
        read_MR_AUTONEG_COMPLETE_INTERRUPT_ENABLE_value = rightShift(data_low, 5) and &H1
        read_REMOTE_FAULT_INTERRUPT_ENABLE_value = rightShift(data_low, 4) and &H1
        read_AIERSB3_value = rightShift(data_low, 3) and &H1
        read_AIERSB2_value = rightShift(data_low, 2) and &H1
        read_RLSUIE_value = rightShift(data_low, 1) and &H1
        RLSDIE_mask = &H1
        if data_low > LONG_MAX then
            if RLSDIE_mask = mask then
                read_RLSDIE_value = data_low
            else
                read_RLSDIE_value = (data_low - H8000_0000) and RLSDIE_mask
            end If
        else
            read_RLSDIE_value = data_low and RLSDIE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_AIERSB1512_value = &H0
        flag_AIERSB1512        = &H0
        write_AWDIE_value = &H0
        flag_AWDIE        = &H0
        write_ALGCIE_value = &H0
        flag_ALGCIE        = &H0
        write_MR_AUTONEG_RESTARTED_INTERRUPT_ENABLE_value = &H0
        flag_MR_AUTONEG_RESTARTED_INTERRUPT_ENABLE        = &H0
        write_AIERSB8_value = &H0
        flag_AIERSB8        = &H0
        write_CONFIGURATION_FAULT_INTERRUPT_ENABLE_value = &H0
        flag_CONFIGURATION_FAULT_INTERRUPT_ENABLE        = &H0
        write_MR_PAGE_RX_INTERRUPT_ENABLE_value = &H0
        flag_MR_PAGE_RX_INTERRUPT_ENABLE        = &H0
        write_MR_AUTONEG_COMPLETE_INTERRUPT_ENABLE_value = &H0
        flag_MR_AUTONEG_COMPLETE_INTERRUPT_ENABLE        = &H0
        write_REMOTE_FAULT_INTERRUPT_ENABLE_value = &H0
        flag_REMOTE_FAULT_INTERRUPT_ENABLE        = &H0
        write_AIERSB3_value = &H0
        flag_AIERSB3        = &H0
        write_AIERSB2_value = &H0
        flag_AIERSB2        = &H0
        write_RLSUIE_value = &H0
        flag_RLSUIE        = &H0
        write_RLSDIE_value = &H0
        flag_RLSDIE        = &H0
    End Sub
End Class


'' @REGISTER : CL45VEN_freeze_counter_lsb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' FREEZE_COUNTER_LSB                         [15:0]           get_FREEZE_COUNTER_LSB
''                                                             set_FREEZE_COUNTER_LSB
''                                                             read_FREEZE_COUNTER_LSB
''                                                             write_FREEZE_COUNTER_LSB
''---------------------------------------------------------------------------------
Class REGISTER_CL45VEN_freeze_counter_lsb
    Private write_FREEZE_COUNTER_LSB_value
    Private read_FREEZE_COUNTER_LSB_value
    Private flag_FREEZE_COUNTER_LSB

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H140
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_FREEZE_COUNTER_LSB
        get_FREEZE_COUNTER_LSB = read_FREEZE_COUNTER_LSB_value
    End Property

    Property Let set_FREEZE_COUNTER_LSB(aData)
        write_FREEZE_COUNTER_LSB_value = aData
        flag_FREEZE_COUNTER_LSB        = &H1
    End Property

    Property Get read_FREEZE_COUNTER_LSB
        read
        read_FREEZE_COUNTER_LSB = read_FREEZE_COUNTER_LSB_value
    End Property

    Property Let write_FREEZE_COUNTER_LSB(aData)
        set_FREEZE_COUNTER_LSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        FREEZE_COUNTER_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if FREEZE_COUNTER_LSB_mask = mask then
                read_FREEZE_COUNTER_LSB_value = data_low
            else
                read_FREEZE_COUNTER_LSB_value = (data_low - H8000_0000) and FREEZE_COUNTER_LSB_mask
            end If
        else
            read_FREEZE_COUNTER_LSB_value = data_low and FREEZE_COUNTER_LSB_mask
        end If

    End Sub

    Sub write
        If flag_FREEZE_COUNTER_LSB = &H0 Then read
        If flag_FREEZE_COUNTER_LSB = &H0 Then write_FREEZE_COUNTER_LSB_value = get_FREEZE_COUNTER_LSB

        regValue = leftShift((write_FREEZE_COUNTER_LSB_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        FREEZE_COUNTER_LSB_mask = &Hffff
        if data_low > LONG_MAX then
            if FREEZE_COUNTER_LSB_mask = mask then
                read_FREEZE_COUNTER_LSB_value = data_low
            else
                read_FREEZE_COUNTER_LSB_value = (data_low - H8000_0000) and FREEZE_COUNTER_LSB_mask
            end If
        else
            read_FREEZE_COUNTER_LSB_value = data_low and FREEZE_COUNTER_LSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_FREEZE_COUNTER_LSB_value = &H0
        flag_FREEZE_COUNTER_LSB        = &H0
    End Sub
End Class


'' @REGISTER : CL45VEN_freeze_counter_msb
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' FREEZE_COUNTER_MSB                         [15:0]           get_FREEZE_COUNTER_MSB
''                                                             set_FREEZE_COUNTER_MSB
''                                                             read_FREEZE_COUNTER_MSB
''                                                             write_FREEZE_COUNTER_MSB
''---------------------------------------------------------------------------------
Class REGISTER_CL45VEN_freeze_counter_msb
    Private write_FREEZE_COUNTER_MSB_value
    Private read_FREEZE_COUNTER_MSB_value
    Private flag_FREEZE_COUNTER_MSB

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H142
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_FREEZE_COUNTER_MSB
        get_FREEZE_COUNTER_MSB = read_FREEZE_COUNTER_MSB_value
    End Property

    Property Let set_FREEZE_COUNTER_MSB(aData)
        write_FREEZE_COUNTER_MSB_value = aData
        flag_FREEZE_COUNTER_MSB        = &H1
    End Property

    Property Get read_FREEZE_COUNTER_MSB
        read
        read_FREEZE_COUNTER_MSB = read_FREEZE_COUNTER_MSB_value
    End Property

    Property Let write_FREEZE_COUNTER_MSB(aData)
        set_FREEZE_COUNTER_MSB = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        FREEZE_COUNTER_MSB_mask = &Hffff
        if data_low > LONG_MAX then
            if FREEZE_COUNTER_MSB_mask = mask then
                read_FREEZE_COUNTER_MSB_value = data_low
            else
                read_FREEZE_COUNTER_MSB_value = (data_low - H8000_0000) and FREEZE_COUNTER_MSB_mask
            end If
        else
            read_FREEZE_COUNTER_MSB_value = data_low and FREEZE_COUNTER_MSB_mask
        end If

    End Sub

    Sub write
        If flag_FREEZE_COUNTER_MSB = &H0 Then read
        If flag_FREEZE_COUNTER_MSB = &H0 Then write_FREEZE_COUNTER_MSB_value = get_FREEZE_COUNTER_MSB

        regValue = leftShift((write_FREEZE_COUNTER_MSB_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        FREEZE_COUNTER_MSB_mask = &Hffff
        if data_low > LONG_MAX then
            if FREEZE_COUNTER_MSB_mask = mask then
                read_FREEZE_COUNTER_MSB_value = data_low
            else
                read_FREEZE_COUNTER_MSB_value = (data_low - H8000_0000) and FREEZE_COUNTER_MSB_mask
            end If
        else
            read_FREEZE_COUNTER_MSB_value = data_low and FREEZE_COUNTER_MSB_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_FREEZE_COUNTER_MSB_value = &H0
        flag_FREEZE_COUNTER_MSB        = &H0
    End Sub
End Class


'' @REGISTER : CL45VEN_freeze_type
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' FREEZE_TYPE                                [2:0]            get_FREEZE_TYPE
''                                                             set_FREEZE_TYPE
''                                                             read_FREEZE_TYPE
''                                                             write_FREEZE_TYPE
''---------------------------------------------------------------------------------
Class REGISTER_CL45VEN_freeze_type
    Private write_FREEZE_TYPE_value
    Private read_FREEZE_TYPE_value
    Private flag_FREEZE_TYPE

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H144
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_FREEZE_TYPE
        get_FREEZE_TYPE = read_FREEZE_TYPE_value
    End Property

    Property Let set_FREEZE_TYPE(aData)
        write_FREEZE_TYPE_value = aData
        flag_FREEZE_TYPE        = &H1
    End Property

    Property Get read_FREEZE_TYPE
        read
        read_FREEZE_TYPE = read_FREEZE_TYPE_value
    End Property

    Property Let write_FREEZE_TYPE(aData)
        set_FREEZE_TYPE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        FREEZE_TYPE_mask = &H7
        if data_low > LONG_MAX then
            if FREEZE_TYPE_mask = mask then
                read_FREEZE_TYPE_value = data_low
            else
                read_FREEZE_TYPE_value = (data_low - H8000_0000) and FREEZE_TYPE_mask
            end If
        else
            read_FREEZE_TYPE_value = data_low and FREEZE_TYPE_mask
        end If

    End Sub

    Sub write
        If flag_FREEZE_TYPE = &H0 Then read
        If flag_FREEZE_TYPE = &H0 Then write_FREEZE_TYPE_value = get_FREEZE_TYPE

        regValue = leftShift((write_FREEZE_TYPE_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        FREEZE_TYPE_mask = &H7
        if data_low > LONG_MAX then
            if FREEZE_TYPE_mask = mask then
                read_FREEZE_TYPE_value = data_low
            else
                read_FREEZE_TYPE_value = (data_low - H8000_0000) and FREEZE_TYPE_mask
            end If
        else
            read_FREEZE_TYPE_value = data_low and FREEZE_TYPE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_FREEZE_TYPE_value = &H0
        flag_FREEZE_TYPE        = &H0
    End Sub
End Class


'' @REGISTER : CL45VEN_tc10_tpout_select
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TC10_TPOUT_SELECT                          [0:0]            get_TC10_TPOUT_SELECT
''                                                             set_TC10_TPOUT_SELECT
''                                                             read_TC10_TPOUT_SELECT
''                                                             write_TC10_TPOUT_SELECT
''---------------------------------------------------------------------------------
Class REGISTER_CL45VEN_tc10_tpout_select
    Private write_TC10_TPOUT_SELECT_value
    Private read_TC10_TPOUT_SELECT_value
    Private flag_TC10_TPOUT_SELECT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1fa
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_TC10_TPOUT_SELECT
        get_TC10_TPOUT_SELECT = read_TC10_TPOUT_SELECT_value
    End Property

    Property Let set_TC10_TPOUT_SELECT(aData)
        write_TC10_TPOUT_SELECT_value = aData
        flag_TC10_TPOUT_SELECT        = &H1
    End Property

    Property Get read_TC10_TPOUT_SELECT
        read
        read_TC10_TPOUT_SELECT = read_TC10_TPOUT_SELECT_value
    End Property

    Property Let write_TC10_TPOUT_SELECT(aData)
        set_TC10_TPOUT_SELECT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TC10_TPOUT_SELECT_mask = &H1
        if data_low > LONG_MAX then
            if TC10_TPOUT_SELECT_mask = mask then
                read_TC10_TPOUT_SELECT_value = data_low
            else
                read_TC10_TPOUT_SELECT_value = (data_low - H8000_0000) and TC10_TPOUT_SELECT_mask
            end If
        else
            read_TC10_TPOUT_SELECT_value = data_low and TC10_TPOUT_SELECT_mask
        end If

    End Sub

    Sub write
        If flag_TC10_TPOUT_SELECT = &H0 Then read
        If flag_TC10_TPOUT_SELECT = &H0 Then write_TC10_TPOUT_SELECT_value = get_TC10_TPOUT_SELECT

        regValue = leftShift((write_TC10_TPOUT_SELECT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        TC10_TPOUT_SELECT_mask = &H1
        if data_low > LONG_MAX then
            if TC10_TPOUT_SELECT_mask = mask then
                read_TC10_TPOUT_SELECT_value = data_low
            else
                read_TC10_TPOUT_SELECT_value = (data_low - H8000_0000) and TC10_TPOUT_SELECT_mask
            end If
        else
            read_TC10_TPOUT_SELECT_value = data_low and TC10_TPOUT_SELECT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TC10_TPOUT_SELECT_value = &H0
        flag_TC10_TPOUT_SELECT        = &H0
    End Sub
End Class


'' @REGISTER : CL45VEN_tc10_status
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' SLP_WUP_STATE                              [10:8]           get_SLP_WUP_STATE
''                                                             set_SLP_WUP_STATE
''                                                             read_SLP_WUP_STATE
''                                                             write_SLP_WUP_STATE
''---------------------------------------------------------------------------------
'' WAKEUP_FAIL_STAT                           [7:7]            get_WAKEUP_FAIL_STAT
''                                                             set_WAKEUP_FAIL_STAT
''                                                             read_WAKEUP_FAIL_STAT
''                                                             write_WAKEUP_FAIL_STAT
''---------------------------------------------------------------------------------
'' LOC_WAKEUP_STAT                            [6:6]            get_LOC_WAKEUP_STAT
''                                                             set_LOC_WAKEUP_STAT
''                                                             read_LOC_WAKEUP_STAT
''                                                             write_LOC_WAKEUP_STAT
''---------------------------------------------------------------------------------
'' WAKEUP_STAT                                [5:5]            get_WAKEUP_STAT
''                                                             set_WAKEUP_STAT
''                                                             read_WAKEUP_STAT
''                                                             write_WAKEUP_STAT
''---------------------------------------------------------------------------------
'' INHIBIT_REAL_STAT                          [4:4]            get_INHIBIT_REAL_STAT
''                                                             set_INHIBIT_REAL_STAT
''                                                             read_INHIBIT_REAL_STAT
''                                                             write_INHIBIT_REAL_STAT
''---------------------------------------------------------------------------------
'' INHIBIT_STAT                               [3:3]            get_INHIBIT_STAT
''                                                             set_INHIBIT_STAT
''                                                             read_INHIBIT_STAT
''                                                             write_INHIBIT_STAT
''---------------------------------------------------------------------------------
'' SLEEP_STAT                                 [2:2]            get_SLEEP_STAT
''                                                             set_SLEEP_STAT
''                                                             read_SLEEP_STAT
''                                                             write_SLEEP_STAT
''---------------------------------------------------------------------------------
'' SLEEP_FAIL_STAT                            [1:1]            get_SLEEP_FAIL_STAT
''                                                             set_SLEEP_FAIL_STAT
''                                                             read_SLEEP_FAIL_STAT
''                                                             write_SLEEP_FAIL_STAT
''---------------------------------------------------------------------------------
'' AFE_WAKEUP_STAT                            [0:0]            get_AFE_WAKEUP_STAT
''                                                             set_AFE_WAKEUP_STAT
''                                                             read_AFE_WAKEUP_STAT
''                                                             write_AFE_WAKEUP_STAT
''---------------------------------------------------------------------------------
Class REGISTER_CL45VEN_tc10_status
    Private write_SLP_WUP_STATE_value
    Private read_SLP_WUP_STATE_value
    Private flag_SLP_WUP_STATE
    Private write_WAKEUP_FAIL_STAT_value
    Private read_WAKEUP_FAIL_STAT_value
    Private flag_WAKEUP_FAIL_STAT
    Private write_LOC_WAKEUP_STAT_value
    Private read_LOC_WAKEUP_STAT_value
    Private flag_LOC_WAKEUP_STAT
    Private write_WAKEUP_STAT_value
    Private read_WAKEUP_STAT_value
    Private flag_WAKEUP_STAT
    Private write_INHIBIT_REAL_STAT_value
    Private read_INHIBIT_REAL_STAT_value
    Private flag_INHIBIT_REAL_STAT
    Private write_INHIBIT_STAT_value
    Private read_INHIBIT_STAT_value
    Private flag_INHIBIT_STAT
    Private write_SLEEP_STAT_value
    Private read_SLEEP_STAT_value
    Private flag_SLEEP_STAT
    Private write_SLEEP_FAIL_STAT_value
    Private read_SLEEP_FAIL_STAT_value
    Private flag_SLEEP_FAIL_STAT
    Private write_AFE_WAKEUP_STAT_value
    Private read_AFE_WAKEUP_STAT_value
    Private flag_AFE_WAKEUP_STAT

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1fc
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_SLP_WUP_STATE
        get_SLP_WUP_STATE = read_SLP_WUP_STATE_value
    End Property

    Property Let set_SLP_WUP_STATE(aData)
        write_SLP_WUP_STATE_value = aData
        flag_SLP_WUP_STATE        = &H1
    End Property

    Property Get read_SLP_WUP_STATE
        read
        read_SLP_WUP_STATE = read_SLP_WUP_STATE_value
    End Property

    Property Let write_SLP_WUP_STATE(aData)
        set_SLP_WUP_STATE = aData
        write
    End Property

    Property Get get_WAKEUP_FAIL_STAT
        get_WAKEUP_FAIL_STAT = read_WAKEUP_FAIL_STAT_value
    End Property

    Property Let set_WAKEUP_FAIL_STAT(aData)
        write_WAKEUP_FAIL_STAT_value = aData
        flag_WAKEUP_FAIL_STAT        = &H1
    End Property

    Property Get read_WAKEUP_FAIL_STAT
        read
        read_WAKEUP_FAIL_STAT = read_WAKEUP_FAIL_STAT_value
    End Property

    Property Let write_WAKEUP_FAIL_STAT(aData)
        set_WAKEUP_FAIL_STAT = aData
        write
    End Property

    Property Get get_LOC_WAKEUP_STAT
        get_LOC_WAKEUP_STAT = read_LOC_WAKEUP_STAT_value
    End Property

    Property Let set_LOC_WAKEUP_STAT(aData)
        write_LOC_WAKEUP_STAT_value = aData
        flag_LOC_WAKEUP_STAT        = &H1
    End Property

    Property Get read_LOC_WAKEUP_STAT
        read
        read_LOC_WAKEUP_STAT = read_LOC_WAKEUP_STAT_value
    End Property

    Property Let write_LOC_WAKEUP_STAT(aData)
        set_LOC_WAKEUP_STAT = aData
        write
    End Property

    Property Get get_WAKEUP_STAT
        get_WAKEUP_STAT = read_WAKEUP_STAT_value
    End Property

    Property Let set_WAKEUP_STAT(aData)
        write_WAKEUP_STAT_value = aData
        flag_WAKEUP_STAT        = &H1
    End Property

    Property Get read_WAKEUP_STAT
        read
        read_WAKEUP_STAT = read_WAKEUP_STAT_value
    End Property

    Property Let write_WAKEUP_STAT(aData)
        set_WAKEUP_STAT = aData
        write
    End Property

    Property Get get_INHIBIT_REAL_STAT
        get_INHIBIT_REAL_STAT = read_INHIBIT_REAL_STAT_value
    End Property

    Property Let set_INHIBIT_REAL_STAT(aData)
        write_INHIBIT_REAL_STAT_value = aData
        flag_INHIBIT_REAL_STAT        = &H1
    End Property

    Property Get read_INHIBIT_REAL_STAT
        read
        read_INHIBIT_REAL_STAT = read_INHIBIT_REAL_STAT_value
    End Property

    Property Let write_INHIBIT_REAL_STAT(aData)
        set_INHIBIT_REAL_STAT = aData
        write
    End Property

    Property Get get_INHIBIT_STAT
        get_INHIBIT_STAT = read_INHIBIT_STAT_value
    End Property

    Property Let set_INHIBIT_STAT(aData)
        write_INHIBIT_STAT_value = aData
        flag_INHIBIT_STAT        = &H1
    End Property

    Property Get read_INHIBIT_STAT
        read
        read_INHIBIT_STAT = read_INHIBIT_STAT_value
    End Property

    Property Let write_INHIBIT_STAT(aData)
        set_INHIBIT_STAT = aData
        write
    End Property

    Property Get get_SLEEP_STAT
        get_SLEEP_STAT = read_SLEEP_STAT_value
    End Property

    Property Let set_SLEEP_STAT(aData)
        write_SLEEP_STAT_value = aData
        flag_SLEEP_STAT        = &H1
    End Property

    Property Get read_SLEEP_STAT
        read
        read_SLEEP_STAT = read_SLEEP_STAT_value
    End Property

    Property Let write_SLEEP_STAT(aData)
        set_SLEEP_STAT = aData
        write
    End Property

    Property Get get_SLEEP_FAIL_STAT
        get_SLEEP_FAIL_STAT = read_SLEEP_FAIL_STAT_value
    End Property

    Property Let set_SLEEP_FAIL_STAT(aData)
        write_SLEEP_FAIL_STAT_value = aData
        flag_SLEEP_FAIL_STAT        = &H1
    End Property

    Property Get read_SLEEP_FAIL_STAT
        read
        read_SLEEP_FAIL_STAT = read_SLEEP_FAIL_STAT_value
    End Property

    Property Let write_SLEEP_FAIL_STAT(aData)
        set_SLEEP_FAIL_STAT = aData
        write
    End Property

    Property Get get_AFE_WAKEUP_STAT
        get_AFE_WAKEUP_STAT = read_AFE_WAKEUP_STAT_value
    End Property

    Property Let set_AFE_WAKEUP_STAT(aData)
        write_AFE_WAKEUP_STAT_value = aData
        flag_AFE_WAKEUP_STAT        = &H1
    End Property

    Property Get read_AFE_WAKEUP_STAT
        read
        read_AFE_WAKEUP_STAT = read_AFE_WAKEUP_STAT_value
    End Property

    Property Let write_AFE_WAKEUP_STAT(aData)
        set_AFE_WAKEUP_STAT = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_SLP_WUP_STATE_value = rightShift(data_low, 8) and &H7
        read_WAKEUP_FAIL_STAT_value = rightShift(data_low, 7) and &H1
        read_LOC_WAKEUP_STAT_value = rightShift(data_low, 6) and &H1
        read_WAKEUP_STAT_value = rightShift(data_low, 5) and &H1
        read_INHIBIT_REAL_STAT_value = rightShift(data_low, 4) and &H1
        read_INHIBIT_STAT_value = rightShift(data_low, 3) and &H1
        read_SLEEP_STAT_value = rightShift(data_low, 2) and &H1
        read_SLEEP_FAIL_STAT_value = rightShift(data_low, 1) and &H1
        AFE_WAKEUP_STAT_mask = &H1
        if data_low > LONG_MAX then
            if AFE_WAKEUP_STAT_mask = mask then
                read_AFE_WAKEUP_STAT_value = data_low
            else
                read_AFE_WAKEUP_STAT_value = (data_low - H8000_0000) and AFE_WAKEUP_STAT_mask
            end If
        else
            read_AFE_WAKEUP_STAT_value = data_low and AFE_WAKEUP_STAT_mask
        end If

    End Sub

    Sub write
        If flag_SLP_WUP_STATE = &H0 or flag_WAKEUP_FAIL_STAT = &H0 or flag_LOC_WAKEUP_STAT = &H0 or flag_WAKEUP_STAT = &H0 or flag_INHIBIT_REAL_STAT = &H0 or flag_INHIBIT_STAT = &H0 or flag_SLEEP_STAT = &H0 or flag_SLEEP_FAIL_STAT = &H0 or flag_AFE_WAKEUP_STAT = &H0 Then read
        If flag_SLP_WUP_STATE = &H0 Then write_SLP_WUP_STATE_value = get_SLP_WUP_STATE
        If flag_WAKEUP_FAIL_STAT = &H0 Then write_WAKEUP_FAIL_STAT_value = get_WAKEUP_FAIL_STAT
        If flag_LOC_WAKEUP_STAT = &H0 Then write_LOC_WAKEUP_STAT_value = get_LOC_WAKEUP_STAT
        If flag_WAKEUP_STAT = &H0 Then write_WAKEUP_STAT_value = get_WAKEUP_STAT
        If flag_INHIBIT_REAL_STAT = &H0 Then write_INHIBIT_REAL_STAT_value = get_INHIBIT_REAL_STAT
        If flag_INHIBIT_STAT = &H0 Then write_INHIBIT_STAT_value = get_INHIBIT_STAT
        If flag_SLEEP_STAT = &H0 Then write_SLEEP_STAT_value = get_SLEEP_STAT
        If flag_SLEEP_FAIL_STAT = &H0 Then write_SLEEP_FAIL_STAT_value = get_SLEEP_FAIL_STAT
        If flag_AFE_WAKEUP_STAT = &H0 Then write_AFE_WAKEUP_STAT_value = get_AFE_WAKEUP_STAT

        regValue = leftShift((write_SLP_WUP_STATE_value and &H7), 8) + leftShift((write_WAKEUP_FAIL_STAT_value and &H1), 7) + leftShift((write_LOC_WAKEUP_STAT_value and &H1), 6) + leftShift((write_WAKEUP_STAT_value and &H1), 5) + leftShift((write_INHIBIT_REAL_STAT_value and &H1), 4) + leftShift((write_INHIBIT_STAT_value and &H1), 3) + leftShift((write_SLEEP_STAT_value and &H1), 2) + leftShift((write_SLEEP_FAIL_STAT_value and &H1), 1) + leftShift((write_AFE_WAKEUP_STAT_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_SLP_WUP_STATE_value = rightShift(data_low, 8) and &H7
        read_WAKEUP_FAIL_STAT_value = rightShift(data_low, 7) and &H1
        read_LOC_WAKEUP_STAT_value = rightShift(data_low, 6) and &H1
        read_WAKEUP_STAT_value = rightShift(data_low, 5) and &H1
        read_INHIBIT_REAL_STAT_value = rightShift(data_low, 4) and &H1
        read_INHIBIT_STAT_value = rightShift(data_low, 3) and &H1
        read_SLEEP_STAT_value = rightShift(data_low, 2) and &H1
        read_SLEEP_FAIL_STAT_value = rightShift(data_low, 1) and &H1
        AFE_WAKEUP_STAT_mask = &H1
        if data_low > LONG_MAX then
            if AFE_WAKEUP_STAT_mask = mask then
                read_AFE_WAKEUP_STAT_value = data_low
            else
                read_AFE_WAKEUP_STAT_value = (data_low - H8000_0000) and AFE_WAKEUP_STAT_mask
            end If
        else
            read_AFE_WAKEUP_STAT_value = data_low and AFE_WAKEUP_STAT_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_SLP_WUP_STATE_value = &H0
        flag_SLP_WUP_STATE        = &H0
        write_WAKEUP_FAIL_STAT_value = &H0
        flag_WAKEUP_FAIL_STAT        = &H0
        write_LOC_WAKEUP_STAT_value = &H0
        flag_LOC_WAKEUP_STAT        = &H0
        write_WAKEUP_STAT_value = &H0
        flag_WAKEUP_STAT        = &H0
        write_INHIBIT_REAL_STAT_value = &H0
        flag_INHIBIT_REAL_STAT        = &H0
        write_INHIBIT_STAT_value = &H0
        flag_INHIBIT_STAT        = &H0
        write_SLEEP_STAT_value = &H0
        flag_SLEEP_STAT        = &H0
        write_SLEEP_FAIL_STAT_value = &H0
        flag_SLEEP_FAIL_STAT        = &H0
        write_AFE_WAKEUP_STAT_value = &H0
        flag_AFE_WAKEUP_STAT        = &H0
    End Sub
End Class


'' @REGISTER : CL45VEN_tc10_control
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' TC10_SLEEP_CAP_DISABLE                     [15:15]          get_TC10_SLEEP_CAP_DISABLE
''                                                             set_TC10_SLEEP_CAP_DISABLE
''                                                             read_TC10_SLEEP_CAP_DISABLE
''                                                             write_TC10_SLEEP_CAP_DISABLE
''---------------------------------------------------------------------------------
'' STRAP_GO2STNDBY                            [14:14]          get_STRAP_GO2STNDBY
''                                                             set_STRAP_GO2STNDBY
''                                                             read_STRAP_GO2STNDBY
''                                                             write_STRAP_GO2STNDBY
''---------------------------------------------------------------------------------
'' Reserved                                   [13:12]          get_Reserved
''                                                             set_Reserved
''                                                             read_Reserved
''                                                             write_Reserved
''---------------------------------------------------------------------------------
'' TC10_FSM_DISABLE                           [11:11]          get_TC10_FSM_DISABLE
''                                                             set_TC10_FSM_DISABLE
''                                                             read_TC10_FSM_DISABLE
''                                                             write_TC10_FSM_DISABLE
''---------------------------------------------------------------------------------
'' TC10_INTR_EN                               [10:10]          get_TC10_INTR_EN
''                                                             set_TC10_INTR_EN
''                                                             read_TC10_INTR_EN
''                                                             write_TC10_INTR_EN
''---------------------------------------------------------------------------------
'' TC10_INTR_MASK                             [9:4]            get_TC10_INTR_MASK
''                                                             set_TC10_INTR_MASK
''                                                             read_TC10_INTR_MASK
''                                                             write_TC10_INTR_MASK
''---------------------------------------------------------------------------------
'' WAKEUP_REQ                                 [3:3]            get_WAKEUP_REQ
''                                                             set_WAKEUP_REQ
''                                                             read_WAKEUP_REQ
''                                                             write_WAKEUP_REQ
''---------------------------------------------------------------------------------
'' SLEEPABORT_REQ                             [2:2]            get_SLEEPABORT_REQ
''                                                             set_SLEEPABORT_REQ
''                                                             read_SLEEPABORT_REQ
''                                                             write_SLEEPABORT_REQ
''---------------------------------------------------------------------------------
'' SLEEP_REQ                                  [1:1]            get_SLEEP_REQ
''                                                             set_SLEEP_REQ
''                                                             read_SLEEP_REQ
''                                                             write_SLEEP_REQ
''---------------------------------------------------------------------------------
'' GO2SLEEP_AUTO                              [0:0]            get_GO2SLEEP_AUTO
''                                                             set_GO2SLEEP_AUTO
''                                                             read_GO2SLEEP_AUTO
''                                                             write_GO2SLEEP_AUTO
''---------------------------------------------------------------------------------
Class REGISTER_CL45VEN_tc10_control
    Private write_TC10_SLEEP_CAP_DISABLE_value
    Private read_TC10_SLEEP_CAP_DISABLE_value
    Private flag_TC10_SLEEP_CAP_DISABLE
    Private write_STRAP_GO2STNDBY_value
    Private read_STRAP_GO2STNDBY_value
    Private flag_STRAP_GO2STNDBY
    Private write_Reserved_value
    Private read_Reserved_value
    Private flag_Reserved
    Private write_TC10_FSM_DISABLE_value
    Private read_TC10_FSM_DISABLE_value
    Private flag_TC10_FSM_DISABLE
    Private write_TC10_INTR_EN_value
    Private read_TC10_INTR_EN_value
    Private flag_TC10_INTR_EN
    Private write_TC10_INTR_MASK_value
    Private read_TC10_INTR_MASK_value
    Private flag_TC10_INTR_MASK
    Private write_WAKEUP_REQ_value
    Private read_WAKEUP_REQ_value
    Private flag_WAKEUP_REQ
    Private write_SLEEPABORT_REQ_value
    Private read_SLEEPABORT_REQ_value
    Private flag_SLEEPABORT_REQ
    Private write_SLEEP_REQ_value
    Private read_SLEEP_REQ_value
    Private flag_SLEEP_REQ
    Private write_GO2SLEEP_AUTO_value
    Private read_GO2SLEEP_AUTO_value
    Private flag_GO2SLEEP_AUTO

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H1fe
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_TC10_SLEEP_CAP_DISABLE
        get_TC10_SLEEP_CAP_DISABLE = read_TC10_SLEEP_CAP_DISABLE_value
    End Property

    Property Let set_TC10_SLEEP_CAP_DISABLE(aData)
        write_TC10_SLEEP_CAP_DISABLE_value = aData
        flag_TC10_SLEEP_CAP_DISABLE        = &H1
    End Property

    Property Get read_TC10_SLEEP_CAP_DISABLE
        read
        read_TC10_SLEEP_CAP_DISABLE = read_TC10_SLEEP_CAP_DISABLE_value
    End Property

    Property Let write_TC10_SLEEP_CAP_DISABLE(aData)
        set_TC10_SLEEP_CAP_DISABLE = aData
        write
    End Property

    Property Get get_STRAP_GO2STNDBY
        get_STRAP_GO2STNDBY = read_STRAP_GO2STNDBY_value
    End Property

    Property Let set_STRAP_GO2STNDBY(aData)
        write_STRAP_GO2STNDBY_value = aData
        flag_STRAP_GO2STNDBY        = &H1
    End Property

    Property Get read_STRAP_GO2STNDBY
        read
        read_STRAP_GO2STNDBY = read_STRAP_GO2STNDBY_value
    End Property

    Property Let write_STRAP_GO2STNDBY(aData)
        set_STRAP_GO2STNDBY = aData
        write
    End Property

    Property Get get_Reserved
        get_Reserved = read_Reserved_value
    End Property

    Property Let set_Reserved(aData)
        write_Reserved_value = aData
        flag_Reserved        = &H1
    End Property

    Property Get read_Reserved
        read
        read_Reserved = read_Reserved_value
    End Property

    Property Let write_Reserved(aData)
        set_Reserved = aData
        write
    End Property

    Property Get get_TC10_FSM_DISABLE
        get_TC10_FSM_DISABLE = read_TC10_FSM_DISABLE_value
    End Property

    Property Let set_TC10_FSM_DISABLE(aData)
        write_TC10_FSM_DISABLE_value = aData
        flag_TC10_FSM_DISABLE        = &H1
    End Property

    Property Get read_TC10_FSM_DISABLE
        read
        read_TC10_FSM_DISABLE = read_TC10_FSM_DISABLE_value
    End Property

    Property Let write_TC10_FSM_DISABLE(aData)
        set_TC10_FSM_DISABLE = aData
        write
    End Property

    Property Get get_TC10_INTR_EN
        get_TC10_INTR_EN = read_TC10_INTR_EN_value
    End Property

    Property Let set_TC10_INTR_EN(aData)
        write_TC10_INTR_EN_value = aData
        flag_TC10_INTR_EN        = &H1
    End Property

    Property Get read_TC10_INTR_EN
        read
        read_TC10_INTR_EN = read_TC10_INTR_EN_value
    End Property

    Property Let write_TC10_INTR_EN(aData)
        set_TC10_INTR_EN = aData
        write
    End Property

    Property Get get_TC10_INTR_MASK
        get_TC10_INTR_MASK = read_TC10_INTR_MASK_value
    End Property

    Property Let set_TC10_INTR_MASK(aData)
        write_TC10_INTR_MASK_value = aData
        flag_TC10_INTR_MASK        = &H1
    End Property

    Property Get read_TC10_INTR_MASK
        read
        read_TC10_INTR_MASK = read_TC10_INTR_MASK_value
    End Property

    Property Let write_TC10_INTR_MASK(aData)
        set_TC10_INTR_MASK = aData
        write
    End Property

    Property Get get_WAKEUP_REQ
        get_WAKEUP_REQ = read_WAKEUP_REQ_value
    End Property

    Property Let set_WAKEUP_REQ(aData)
        write_WAKEUP_REQ_value = aData
        flag_WAKEUP_REQ        = &H1
    End Property

    Property Get read_WAKEUP_REQ
        read
        read_WAKEUP_REQ = read_WAKEUP_REQ_value
    End Property

    Property Let write_WAKEUP_REQ(aData)
        set_WAKEUP_REQ = aData
        write
    End Property

    Property Get get_SLEEPABORT_REQ
        get_SLEEPABORT_REQ = read_SLEEPABORT_REQ_value
    End Property

    Property Let set_SLEEPABORT_REQ(aData)
        write_SLEEPABORT_REQ_value = aData
        flag_SLEEPABORT_REQ        = &H1
    End Property

    Property Get read_SLEEPABORT_REQ
        read
        read_SLEEPABORT_REQ = read_SLEEPABORT_REQ_value
    End Property

    Property Let write_SLEEPABORT_REQ(aData)
        set_SLEEPABORT_REQ = aData
        write
    End Property

    Property Get get_SLEEP_REQ
        get_SLEEP_REQ = read_SLEEP_REQ_value
    End Property

    Property Let set_SLEEP_REQ(aData)
        write_SLEEP_REQ_value = aData
        flag_SLEEP_REQ        = &H1
    End Property

    Property Get read_SLEEP_REQ
        read
        read_SLEEP_REQ = read_SLEEP_REQ_value
    End Property

    Property Let write_SLEEP_REQ(aData)
        set_SLEEP_REQ = aData
        write
    End Property

    Property Get get_GO2SLEEP_AUTO
        get_GO2SLEEP_AUTO = read_GO2SLEEP_AUTO_value
    End Property

    Property Let set_GO2SLEEP_AUTO(aData)
        write_GO2SLEEP_AUTO_value = aData
        flag_GO2SLEEP_AUTO        = &H1
    End Property

    Property Get read_GO2SLEEP_AUTO
        read
        read_GO2SLEEP_AUTO = read_GO2SLEEP_AUTO_value
    End Property

    Property Let write_GO2SLEEP_AUTO(aData)
        set_GO2SLEEP_AUTO = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TC10_SLEEP_CAP_DISABLE_value = rightShift(data_low, 15) and &H1
        read_STRAP_GO2STNDBY_value = rightShift(data_low, 14) and &H1
        read_Reserved_value = rightShift(data_low, 12) and &H3
        read_TC10_FSM_DISABLE_value = rightShift(data_low, 11) and &H1
        read_TC10_INTR_EN_value = rightShift(data_low, 10) and &H1
        read_TC10_INTR_MASK_value = rightShift(data_low, 4) and &H3f
        read_WAKEUP_REQ_value = rightShift(data_low, 3) and &H1
        read_SLEEPABORT_REQ_value = rightShift(data_low, 2) and &H1
        read_SLEEP_REQ_value = rightShift(data_low, 1) and &H1
        GO2SLEEP_AUTO_mask = &H1
        if data_low > LONG_MAX then
            if GO2SLEEP_AUTO_mask = mask then
                read_GO2SLEEP_AUTO_value = data_low
            else
                read_GO2SLEEP_AUTO_value = (data_low - H8000_0000) and GO2SLEEP_AUTO_mask
            end If
        else
            read_GO2SLEEP_AUTO_value = data_low and GO2SLEEP_AUTO_mask
        end If

    End Sub

    Sub write
        If flag_TC10_SLEEP_CAP_DISABLE = &H0 or flag_STRAP_GO2STNDBY = &H0 or flag_Reserved = &H0 or flag_TC10_FSM_DISABLE = &H0 or flag_TC10_INTR_EN = &H0 or flag_TC10_INTR_MASK = &H0 or flag_WAKEUP_REQ = &H0 or flag_SLEEPABORT_REQ = &H0 or flag_SLEEP_REQ = &H0 or flag_GO2SLEEP_AUTO = &H0 Then read
        If flag_TC10_SLEEP_CAP_DISABLE = &H0 Then write_TC10_SLEEP_CAP_DISABLE_value = get_TC10_SLEEP_CAP_DISABLE
        If flag_STRAP_GO2STNDBY = &H0 Then write_STRAP_GO2STNDBY_value = get_STRAP_GO2STNDBY
        If flag_Reserved = &H0 Then write_Reserved_value = get_Reserved
        If flag_TC10_FSM_DISABLE = &H0 Then write_TC10_FSM_DISABLE_value = get_TC10_FSM_DISABLE
        If flag_TC10_INTR_EN = &H0 Then write_TC10_INTR_EN_value = get_TC10_INTR_EN
        If flag_TC10_INTR_MASK = &H0 Then write_TC10_INTR_MASK_value = get_TC10_INTR_MASK
        If flag_WAKEUP_REQ = &H0 Then write_WAKEUP_REQ_value = get_WAKEUP_REQ
        If flag_SLEEPABORT_REQ = &H0 Then write_SLEEPABORT_REQ_value = get_SLEEPABORT_REQ
        If flag_SLEEP_REQ = &H0 Then write_SLEEP_REQ_value = get_SLEEP_REQ
        If flag_GO2SLEEP_AUTO = &H0 Then write_GO2SLEEP_AUTO_value = get_GO2SLEEP_AUTO

        regValue = leftShift((write_TC10_SLEEP_CAP_DISABLE_value and &H1), 15) + leftShift((write_STRAP_GO2STNDBY_value and &H1), 14) + leftShift((write_Reserved_value and &H3), 12) + leftShift((write_TC10_FSM_DISABLE_value and &H1), 11) + leftShift((write_TC10_INTR_EN_value and &H1), 10) + leftShift((write_TC10_INTR_MASK_value and &H3f), 4) + leftShift((write_WAKEUP_REQ_value and &H1), 3) + leftShift((write_SLEEPABORT_REQ_value and &H1), 2) + leftShift((write_SLEEP_REQ_value and &H1), 1) + leftShift((write_GO2SLEEP_AUTO_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_TC10_SLEEP_CAP_DISABLE_value = rightShift(data_low, 15) and &H1
        read_STRAP_GO2STNDBY_value = rightShift(data_low, 14) and &H1
        read_Reserved_value = rightShift(data_low, 12) and &H3
        read_TC10_FSM_DISABLE_value = rightShift(data_low, 11) and &H1
        read_TC10_INTR_EN_value = rightShift(data_low, 10) and &H1
        read_TC10_INTR_MASK_value = rightShift(data_low, 4) and &H3f
        read_WAKEUP_REQ_value = rightShift(data_low, 3) and &H1
        read_SLEEPABORT_REQ_value = rightShift(data_low, 2) and &H1
        read_SLEEP_REQ_value = rightShift(data_low, 1) and &H1
        GO2SLEEP_AUTO_mask = &H1
        if data_low > LONG_MAX then
            if GO2SLEEP_AUTO_mask = mask then
                read_GO2SLEEP_AUTO_value = data_low
            else
                read_GO2SLEEP_AUTO_value = (data_low - H8000_0000) and GO2SLEEP_AUTO_mask
            end If
        else
            read_GO2SLEEP_AUTO_value = data_low and GO2SLEEP_AUTO_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_TC10_SLEEP_CAP_DISABLE_value = &H0
        flag_TC10_SLEEP_CAP_DISABLE        = &H0
        write_STRAP_GO2STNDBY_value = &H0
        flag_STRAP_GO2STNDBY        = &H0
        write_Reserved_value = &H0
        flag_Reserved        = &H0
        write_TC10_FSM_DISABLE_value = &H0
        flag_TC10_FSM_DISABLE        = &H0
        write_TC10_INTR_EN_value = &H0
        flag_TC10_INTR_EN        = &H0
        write_TC10_INTR_MASK_value = &H0
        flag_TC10_INTR_MASK        = &H0
        write_WAKEUP_REQ_value = &H0
        flag_WAKEUP_REQ        = &H0
        write_SLEEPABORT_REQ_value = &H0
        flag_SLEEPABORT_REQ        = &H0
        write_SLEEP_REQ_value = &H0
        flag_SLEEP_REQ        = &H0
        write_GO2SLEEP_AUTO_value = &H0
        flag_GO2SLEEP_AUTO        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class CL45VEN_INSTANCE

    Public force_link
    Public selective_reset
    Public test_fsm_ext_nxt_pgs
    Public test_fsm_nxt_pgs
    Public wirespeed_stat
    Public an_man_test
    Public an_man_lnk_partnr_abi_a
    Public an_man_lnk_partnr_abi_b
    Public lnk_partnr_nxt_pg_a
    Public lnk_partnr_nxt_pg_b
    Public lnk_partnr_nxt_pg_c
    Public lnk_partnr_nxt_pg_d
    Public lnk_partnr_nxt_pg_e
    Public lnk_partnr_nxt_pg_f
    Public epon_ctrl_reg
    Public eee_test_ctrl_a
    Public eee_test_ctrl_b
    Public eee_test_ctrl_c
    Public eee_spare_1
    Public eee_spare_2
    Public eee_control
    Public eee_res_stat
    Public lpi_mode_cntr
    Public loc_dev_msg_5_a
    Public loc_dev_msg_5_b
    Public loc_dev_msg_5_c
    Public loc_dev_msg_5_d
    Public lnk_partnr_msg_5_a
    Public lnk_partnr_msg_5_b
    Public lnk_partnr_msg_5_c
    Public lnk_partnr_msg_5_d
    Public loc_dev_msg_6_a
    Public loc_dev_msg_6_b
    Public loc_dev_msg_6_c
    Public loc_dev_msg_6_d
    Public lnk_partnr_msg_6_a
    Public lnk_partnr_msg_6_b
    Public lnk_partnr_msg_6_c
    Public lnk_partnr_msg_6_d
    Public an_msg_9_selector
    Public an_msg_11_selector
    Public an_msg_11_set_value_lsb
    Public an_msg_11_set_value_msb
    Public an_msg_11_compare_fields_lsb
    Public an_msg_11_compare_fields_msb
    Public link_fail_inhibit_timer_values_for_multispeed
    Public hcd_override_from_firmware
    Public wirespeed_override_from_firmware
    Public shadow_for_7_65_register
    Public autoneg_test_reg0
    Public autoneg_test_reg1
    Public autoneg_test_reg2
    Public autoneg_test_reg3
    Public autoneg_test_reg4
    Public autoneg_test_reg5
    Public autoneg_test_reg6
    Public autoneg_test_reg7
    Public autoneg_test_reg8
    Public autoneg_test_reg9
    Public autoneg_interrupt_status_reg
    Public autoneg_interrupt_enable_reg
    Public freeze_counter_lsb
    Public freeze_counter_msb
    Public freeze_type
    Public tc10_tpout_select
    Public tc10_status
    Public tc10_control


    Public default function Init(aBaseAddr)
        Set force_link = (New REGISTER_CL45VEN_force_link)(aBaseAddr, 16)
        Set selective_reset = (New REGISTER_CL45VEN_selective_reset)(aBaseAddr, 16)
        Set test_fsm_ext_nxt_pgs = (New REGISTER_CL45VEN_test_fsm_ext_nxt_pgs)(aBaseAddr, 16)
        Set test_fsm_nxt_pgs = (New REGISTER_CL45VEN_test_fsm_nxt_pgs)(aBaseAddr, 16)
        Set wirespeed_stat = (New REGISTER_CL45VEN_wirespeed_stat)(aBaseAddr, 16)
        Set an_man_test = (New REGISTER_CL45VEN_an_man_test)(aBaseAddr, 16)
        Set an_man_lnk_partnr_abi_a = (New REGISTER_CL45VEN_an_man_lnk_partnr_abi_a)(aBaseAddr, 16)
        Set an_man_lnk_partnr_abi_b = (New REGISTER_CL45VEN_an_man_lnk_partnr_abi_b)(aBaseAddr, 16)
        Set lnk_partnr_nxt_pg_a = (New REGISTER_CL45VEN_lnk_partnr_nxt_pg_a)(aBaseAddr, 16)
        Set lnk_partnr_nxt_pg_b = (New REGISTER_CL45VEN_lnk_partnr_nxt_pg_b)(aBaseAddr, 16)
        Set lnk_partnr_nxt_pg_c = (New REGISTER_CL45VEN_lnk_partnr_nxt_pg_c)(aBaseAddr, 16)
        Set lnk_partnr_nxt_pg_d = (New REGISTER_CL45VEN_lnk_partnr_nxt_pg_d)(aBaseAddr, 16)
        Set lnk_partnr_nxt_pg_e = (New REGISTER_CL45VEN_lnk_partnr_nxt_pg_e)(aBaseAddr, 16)
        Set lnk_partnr_nxt_pg_f = (New REGISTER_CL45VEN_lnk_partnr_nxt_pg_f)(aBaseAddr, 16)
        Set epon_ctrl_reg = (New REGISTER_CL45VEN_epon_ctrl_reg)(aBaseAddr, 16)
        Set eee_test_ctrl_a = (New REGISTER_CL45VEN_eee_test_ctrl_a)(aBaseAddr, 16)
        Set eee_test_ctrl_b = (New REGISTER_CL45VEN_eee_test_ctrl_b)(aBaseAddr, 16)
        Set eee_test_ctrl_c = (New REGISTER_CL45VEN_eee_test_ctrl_c)(aBaseAddr, 16)
        Set eee_spare_1 = (New REGISTER_CL45VEN_eee_spare_1)(aBaseAddr, 16)
        Set eee_spare_2 = (New REGISTER_CL45VEN_eee_spare_2)(aBaseAddr, 16)
        Set eee_control = (New REGISTER_CL45VEN_eee_control)(aBaseAddr, 16)
        Set eee_res_stat = (New REGISTER_CL45VEN_eee_res_stat)(aBaseAddr, 16)
        Set lpi_mode_cntr = (New REGISTER_CL45VEN_lpi_mode_cntr)(aBaseAddr, 16)
        Set loc_dev_msg_5_a = (New REGISTER_CL45VEN_loc_dev_msg_5_a)(aBaseAddr, 16)
        Set loc_dev_msg_5_b = (New REGISTER_CL45VEN_loc_dev_msg_5_b)(aBaseAddr, 16)
        Set loc_dev_msg_5_c = (New REGISTER_CL45VEN_loc_dev_msg_5_c)(aBaseAddr, 16)
        Set loc_dev_msg_5_d = (New REGISTER_CL45VEN_loc_dev_msg_5_d)(aBaseAddr, 16)
        Set lnk_partnr_msg_5_a = (New REGISTER_CL45VEN_lnk_partnr_msg_5_a)(aBaseAddr, 16)
        Set lnk_partnr_msg_5_b = (New REGISTER_CL45VEN_lnk_partnr_msg_5_b)(aBaseAddr, 16)
        Set lnk_partnr_msg_5_c = (New REGISTER_CL45VEN_lnk_partnr_msg_5_c)(aBaseAddr, 16)
        Set lnk_partnr_msg_5_d = (New REGISTER_CL45VEN_lnk_partnr_msg_5_d)(aBaseAddr, 16)
        Set loc_dev_msg_6_a = (New REGISTER_CL45VEN_loc_dev_msg_6_a)(aBaseAddr, 16)
        Set loc_dev_msg_6_b = (New REGISTER_CL45VEN_loc_dev_msg_6_b)(aBaseAddr, 16)
        Set loc_dev_msg_6_c = (New REGISTER_CL45VEN_loc_dev_msg_6_c)(aBaseAddr, 16)
        Set loc_dev_msg_6_d = (New REGISTER_CL45VEN_loc_dev_msg_6_d)(aBaseAddr, 16)
        Set lnk_partnr_msg_6_a = (New REGISTER_CL45VEN_lnk_partnr_msg_6_a)(aBaseAddr, 16)
        Set lnk_partnr_msg_6_b = (New REGISTER_CL45VEN_lnk_partnr_msg_6_b)(aBaseAddr, 16)
        Set lnk_partnr_msg_6_c = (New REGISTER_CL45VEN_lnk_partnr_msg_6_c)(aBaseAddr, 16)
        Set lnk_partnr_msg_6_d = (New REGISTER_CL45VEN_lnk_partnr_msg_6_d)(aBaseAddr, 16)
        Set an_msg_9_selector = (New REGISTER_CL45VEN_an_msg_9_selector)(aBaseAddr, 16)
        Set an_msg_11_selector = (New REGISTER_CL45VEN_an_msg_11_selector)(aBaseAddr, 16)
        Set an_msg_11_set_value_lsb = (New REGISTER_CL45VEN_an_msg_11_set_value_lsb)(aBaseAddr, 16)
        Set an_msg_11_set_value_msb = (New REGISTER_CL45VEN_an_msg_11_set_value_msb)(aBaseAddr, 16)
        Set an_msg_11_compare_fields_lsb = (New REGISTER_CL45VEN_an_msg_11_compare_fields_lsb)(aBaseAddr, 16)
        Set an_msg_11_compare_fields_msb = (New REGISTER_CL45VEN_an_msg_11_compare_fields_msb)(aBaseAddr, 16)
        Set link_fail_inhibit_timer_values_for_multispeed = (New REGISTER_CL45VEN_link_fail_inhibit_timer_values_for_multispeed)(aBaseAddr, 16)
        Set hcd_override_from_firmware = (New REGISTER_CL45VEN_hcd_override_from_firmware)(aBaseAddr, 16)
        Set wirespeed_override_from_firmware = (New REGISTER_CL45VEN_wirespeed_override_from_firmware)(aBaseAddr, 16)
        Set shadow_for_7_65_register = (New REGISTER_CL45VEN_shadow_for_7_65_register)(aBaseAddr, 16)
        Set autoneg_test_reg0 = (New REGISTER_CL45VEN_autoneg_test_reg0)(aBaseAddr, 16)
        Set autoneg_test_reg1 = (New REGISTER_CL45VEN_autoneg_test_reg1)(aBaseAddr, 16)
        Set autoneg_test_reg2 = (New REGISTER_CL45VEN_autoneg_test_reg2)(aBaseAddr, 16)
        Set autoneg_test_reg3 = (New REGISTER_CL45VEN_autoneg_test_reg3)(aBaseAddr, 16)
        Set autoneg_test_reg4 = (New REGISTER_CL45VEN_autoneg_test_reg4)(aBaseAddr, 16)
        Set autoneg_test_reg5 = (New REGISTER_CL45VEN_autoneg_test_reg5)(aBaseAddr, 16)
        Set autoneg_test_reg6 = (New REGISTER_CL45VEN_autoneg_test_reg6)(aBaseAddr, 16)
        Set autoneg_test_reg7 = (New REGISTER_CL45VEN_autoneg_test_reg7)(aBaseAddr, 16)
        Set autoneg_test_reg8 = (New REGISTER_CL45VEN_autoneg_test_reg8)(aBaseAddr, 16)
        Set autoneg_test_reg9 = (New REGISTER_CL45VEN_autoneg_test_reg9)(aBaseAddr, 16)
        Set autoneg_interrupt_status_reg = (New REGISTER_CL45VEN_autoneg_interrupt_status_reg)(aBaseAddr, 16)
        Set autoneg_interrupt_enable_reg = (New REGISTER_CL45VEN_autoneg_interrupt_enable_reg)(aBaseAddr, 16)
        Set freeze_counter_lsb = (New REGISTER_CL45VEN_freeze_counter_lsb)(aBaseAddr, 16)
        Set freeze_counter_msb = (New REGISTER_CL45VEN_freeze_counter_msb)(aBaseAddr, 16)
        Set freeze_type = (New REGISTER_CL45VEN_freeze_type)(aBaseAddr, 16)
        Set tc10_tpout_select = (New REGISTER_CL45VEN_tc10_tpout_select)(aBaseAddr, 16)
        Set tc10_status = (New REGISTER_CL45VEN_tc10_status)(aBaseAddr, 16)
        Set tc10_control = (New REGISTER_CL45VEN_tc10_control)(aBaseAddr, 16)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set CL45VEN = CreateObject("System.Collections.ArrayList")
CL45VEN.Add ((New CL45VEN_INSTANCE)(&H4a4f0000))
CL45VEN.Add ((New CL45VEN_INSTANCE)(&H494f0000))
CL45VEN.Add ((New CL45VEN_INSTANCE)(&H498f0000))
CL45VEN.Add ((New CL45VEN_INSTANCE)(&H49cf0000))
CL45VEN.Add ((New CL45VEN_INSTANCE)(&H4a0f0000))


