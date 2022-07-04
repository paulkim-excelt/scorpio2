

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


'' @REGISTER : MACSECSYS_MISC_mspu_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSPU_spare_31_22                           [31:22]          get_MSPU_spare_31_22
''                                                             set_MSPU_spare_31_22
''                                                             read_MSPU_spare_31_22
''                                                             write_MSPU_spare_31_22
''---------------------------------------------------------------------------------
'' MSPU_5_Soft_Reset                          [21:21]          get_MSPU_5_Soft_Reset
''                                                             set_MSPU_5_Soft_Reset
''                                                             read_MSPU_5_Soft_Reset
''                                                             write_MSPU_5_Soft_Reset
''---------------------------------------------------------------------------------
'' MSPU_4_Soft_Reset                          [20:20]          get_MSPU_4_Soft_Reset
''                                                             set_MSPU_4_Soft_Reset
''                                                             read_MSPU_4_Soft_Reset
''                                                             write_MSPU_4_Soft_Reset
''---------------------------------------------------------------------------------
'' MSPU_3_Soft_Reset                          [19:19]          get_MSPU_3_Soft_Reset
''                                                             set_MSPU_3_Soft_Reset
''                                                             read_MSPU_3_Soft_Reset
''                                                             write_MSPU_3_Soft_Reset
''---------------------------------------------------------------------------------
'' MSPU_2_Soft_Reset                          [18:18]          get_MSPU_2_Soft_Reset
''                                                             set_MSPU_2_Soft_Reset
''                                                             read_MSPU_2_Soft_Reset
''                                                             write_MSPU_2_Soft_Reset
''---------------------------------------------------------------------------------
'' MSPU_1_Soft_Reset                          [17:17]          get_MSPU_1_Soft_Reset
''                                                             set_MSPU_1_Soft_Reset
''                                                             read_MSPU_1_Soft_Reset
''                                                             write_MSPU_1_Soft_Reset
''---------------------------------------------------------------------------------
'' MSPU_0_Soft_Reset                          [16:16]          get_MSPU_0_Soft_Reset
''                                                             set_MSPU_0_Soft_Reset
''                                                             read_MSPU_0_Soft_Reset
''                                                             write_MSPU_0_Soft_Reset
''---------------------------------------------------------------------------------
'' MSPU_spare_15_14                           [15:14]          get_MSPU_spare_15_14
''                                                             set_MSPU_spare_15_14
''                                                             read_MSPU_spare_15_14
''                                                             write_MSPU_spare_15_14
''---------------------------------------------------------------------------------
'' MSPU_5_Outbound_Sel                        [13:13]          get_MSPU_5_Outbound_Sel
''                                                             set_MSPU_5_Outbound_Sel
''                                                             read_MSPU_5_Outbound_Sel
''                                                             write_MSPU_5_Outbound_Sel
''---------------------------------------------------------------------------------
'' MSPU_4_Outbound_Sel                        [12:12]          get_MSPU_4_Outbound_Sel
''                                                             set_MSPU_4_Outbound_Sel
''                                                             read_MSPU_4_Outbound_Sel
''                                                             write_MSPU_4_Outbound_Sel
''---------------------------------------------------------------------------------
'' MSPU_3_Outbound_Sel                        [11:11]          get_MSPU_3_Outbound_Sel
''                                                             set_MSPU_3_Outbound_Sel
''                                                             read_MSPU_3_Outbound_Sel
''                                                             write_MSPU_3_Outbound_Sel
''---------------------------------------------------------------------------------
'' MSPU_2_Outbound_Sel                        [10:10]          get_MSPU_2_Outbound_Sel
''                                                             set_MSPU_2_Outbound_Sel
''                                                             read_MSPU_2_Outbound_Sel
''                                                             write_MSPU_2_Outbound_Sel
''---------------------------------------------------------------------------------
'' MSPU_1_Outbound_Sel                        [9:9]            get_MSPU_1_Outbound_Sel
''                                                             set_MSPU_1_Outbound_Sel
''                                                             read_MSPU_1_Outbound_Sel
''                                                             write_MSPU_1_Outbound_Sel
''---------------------------------------------------------------------------------
'' MSPU_0_Outbound_Sel                        [8:8]            get_MSPU_0_Outbound_Sel
''                                                             set_MSPU_0_Outbound_Sel
''                                                             read_MSPU_0_Outbound_Sel
''                                                             write_MSPU_0_Outbound_Sel
''---------------------------------------------------------------------------------
'' MSPU_spare_7_6                             [7:6]            get_MSPU_spare_7_6
''                                                             set_MSPU_spare_7_6
''                                                             read_MSPU_spare_7_6
''                                                             write_MSPU_spare_7_6
''---------------------------------------------------------------------------------
'' MSPU_5_Inbound_Sel                         [5:5]            get_MSPU_5_Inbound_Sel
''                                                             set_MSPU_5_Inbound_Sel
''                                                             read_MSPU_5_Inbound_Sel
''                                                             write_MSPU_5_Inbound_Sel
''---------------------------------------------------------------------------------
'' MSPU_4_Inbound_Sel                         [4:4]            get_MSPU_4_Inbound_Sel
''                                                             set_MSPU_4_Inbound_Sel
''                                                             read_MSPU_4_Inbound_Sel
''                                                             write_MSPU_4_Inbound_Sel
''---------------------------------------------------------------------------------
'' MSPU_3_Inbound_Sel                         [3:3]            get_MSPU_3_Inbound_Sel
''                                                             set_MSPU_3_Inbound_Sel
''                                                             read_MSPU_3_Inbound_Sel
''                                                             write_MSPU_3_Inbound_Sel
''---------------------------------------------------------------------------------
'' MSPU_2_Inbound_Sel                         [2:2]            get_MSPU_2_Inbound_Sel
''                                                             set_MSPU_2_Inbound_Sel
''                                                             read_MSPU_2_Inbound_Sel
''                                                             write_MSPU_2_Inbound_Sel
''---------------------------------------------------------------------------------
'' MSPU_1_Inbound_Sel                         [1:1]            get_MSPU_1_Inbound_Sel
''                                                             set_MSPU_1_Inbound_Sel
''                                                             read_MSPU_1_Inbound_Sel
''                                                             write_MSPU_1_Inbound_Sel
''---------------------------------------------------------------------------------
'' MSPU_0_Inbound_Sel                         [0:0]            get_MSPU_0_Inbound_Sel
''                                                             set_MSPU_0_Inbound_Sel
''                                                             read_MSPU_0_Inbound_Sel
''                                                             write_MSPU_0_Inbound_Sel
''---------------------------------------------------------------------------------
Class REGISTER_MACSECSYS_MISC_mspu_ctrl
    Private write_MSPU_spare_31_22_value
    Private read_MSPU_spare_31_22_value
    Private flag_MSPU_spare_31_22
    Private write_MSPU_5_Soft_Reset_value
    Private read_MSPU_5_Soft_Reset_value
    Private flag_MSPU_5_Soft_Reset
    Private write_MSPU_4_Soft_Reset_value
    Private read_MSPU_4_Soft_Reset_value
    Private flag_MSPU_4_Soft_Reset
    Private write_MSPU_3_Soft_Reset_value
    Private read_MSPU_3_Soft_Reset_value
    Private flag_MSPU_3_Soft_Reset
    Private write_MSPU_2_Soft_Reset_value
    Private read_MSPU_2_Soft_Reset_value
    Private flag_MSPU_2_Soft_Reset
    Private write_MSPU_1_Soft_Reset_value
    Private read_MSPU_1_Soft_Reset_value
    Private flag_MSPU_1_Soft_Reset
    Private write_MSPU_0_Soft_Reset_value
    Private read_MSPU_0_Soft_Reset_value
    Private flag_MSPU_0_Soft_Reset
    Private write_MSPU_spare_15_14_value
    Private read_MSPU_spare_15_14_value
    Private flag_MSPU_spare_15_14
    Private write_MSPU_5_Outbound_Sel_value
    Private read_MSPU_5_Outbound_Sel_value
    Private flag_MSPU_5_Outbound_Sel
    Private write_MSPU_4_Outbound_Sel_value
    Private read_MSPU_4_Outbound_Sel_value
    Private flag_MSPU_4_Outbound_Sel
    Private write_MSPU_3_Outbound_Sel_value
    Private read_MSPU_3_Outbound_Sel_value
    Private flag_MSPU_3_Outbound_Sel
    Private write_MSPU_2_Outbound_Sel_value
    Private read_MSPU_2_Outbound_Sel_value
    Private flag_MSPU_2_Outbound_Sel
    Private write_MSPU_1_Outbound_Sel_value
    Private read_MSPU_1_Outbound_Sel_value
    Private flag_MSPU_1_Outbound_Sel
    Private write_MSPU_0_Outbound_Sel_value
    Private read_MSPU_0_Outbound_Sel_value
    Private flag_MSPU_0_Outbound_Sel
    Private write_MSPU_spare_7_6_value
    Private read_MSPU_spare_7_6_value
    Private flag_MSPU_spare_7_6
    Private write_MSPU_5_Inbound_Sel_value
    Private read_MSPU_5_Inbound_Sel_value
    Private flag_MSPU_5_Inbound_Sel
    Private write_MSPU_4_Inbound_Sel_value
    Private read_MSPU_4_Inbound_Sel_value
    Private flag_MSPU_4_Inbound_Sel
    Private write_MSPU_3_Inbound_Sel_value
    Private read_MSPU_3_Inbound_Sel_value
    Private flag_MSPU_3_Inbound_Sel
    Private write_MSPU_2_Inbound_Sel_value
    Private read_MSPU_2_Inbound_Sel_value
    Private flag_MSPU_2_Inbound_Sel
    Private write_MSPU_1_Inbound_Sel_value
    Private read_MSPU_1_Inbound_Sel_value
    Private flag_MSPU_1_Inbound_Sel
    Private write_MSPU_0_Inbound_Sel_value
    Private read_MSPU_0_Inbound_Sel_value
    Private flag_MSPU_0_Inbound_Sel

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

    Property Get get_MSPU_spare_31_22
        get_MSPU_spare_31_22 = read_MSPU_spare_31_22_value
    End Property

    Property Let set_MSPU_spare_31_22(aData)
        write_MSPU_spare_31_22_value = aData
        flag_MSPU_spare_31_22        = &H1
    End Property

    Property Get read_MSPU_spare_31_22
        read
        read_MSPU_spare_31_22 = read_MSPU_spare_31_22_value
    End Property

    Property Let write_MSPU_spare_31_22(aData)
        set_MSPU_spare_31_22 = aData
        write
    End Property

    Property Get get_MSPU_5_Soft_Reset
        get_MSPU_5_Soft_Reset = read_MSPU_5_Soft_Reset_value
    End Property

    Property Let set_MSPU_5_Soft_Reset(aData)
        write_MSPU_5_Soft_Reset_value = aData
        flag_MSPU_5_Soft_Reset        = &H1
    End Property

    Property Get read_MSPU_5_Soft_Reset
        read
        read_MSPU_5_Soft_Reset = read_MSPU_5_Soft_Reset_value
    End Property

    Property Let write_MSPU_5_Soft_Reset(aData)
        set_MSPU_5_Soft_Reset = aData
        write
    End Property

    Property Get get_MSPU_4_Soft_Reset
        get_MSPU_4_Soft_Reset = read_MSPU_4_Soft_Reset_value
    End Property

    Property Let set_MSPU_4_Soft_Reset(aData)
        write_MSPU_4_Soft_Reset_value = aData
        flag_MSPU_4_Soft_Reset        = &H1
    End Property

    Property Get read_MSPU_4_Soft_Reset
        read
        read_MSPU_4_Soft_Reset = read_MSPU_4_Soft_Reset_value
    End Property

    Property Let write_MSPU_4_Soft_Reset(aData)
        set_MSPU_4_Soft_Reset = aData
        write
    End Property

    Property Get get_MSPU_3_Soft_Reset
        get_MSPU_3_Soft_Reset = read_MSPU_3_Soft_Reset_value
    End Property

    Property Let set_MSPU_3_Soft_Reset(aData)
        write_MSPU_3_Soft_Reset_value = aData
        flag_MSPU_3_Soft_Reset        = &H1
    End Property

    Property Get read_MSPU_3_Soft_Reset
        read
        read_MSPU_3_Soft_Reset = read_MSPU_3_Soft_Reset_value
    End Property

    Property Let write_MSPU_3_Soft_Reset(aData)
        set_MSPU_3_Soft_Reset = aData
        write
    End Property

    Property Get get_MSPU_2_Soft_Reset
        get_MSPU_2_Soft_Reset = read_MSPU_2_Soft_Reset_value
    End Property

    Property Let set_MSPU_2_Soft_Reset(aData)
        write_MSPU_2_Soft_Reset_value = aData
        flag_MSPU_2_Soft_Reset        = &H1
    End Property

    Property Get read_MSPU_2_Soft_Reset
        read
        read_MSPU_2_Soft_Reset = read_MSPU_2_Soft_Reset_value
    End Property

    Property Let write_MSPU_2_Soft_Reset(aData)
        set_MSPU_2_Soft_Reset = aData
        write
    End Property

    Property Get get_MSPU_1_Soft_Reset
        get_MSPU_1_Soft_Reset = read_MSPU_1_Soft_Reset_value
    End Property

    Property Let set_MSPU_1_Soft_Reset(aData)
        write_MSPU_1_Soft_Reset_value = aData
        flag_MSPU_1_Soft_Reset        = &H1
    End Property

    Property Get read_MSPU_1_Soft_Reset
        read
        read_MSPU_1_Soft_Reset = read_MSPU_1_Soft_Reset_value
    End Property

    Property Let write_MSPU_1_Soft_Reset(aData)
        set_MSPU_1_Soft_Reset = aData
        write
    End Property

    Property Get get_MSPU_0_Soft_Reset
        get_MSPU_0_Soft_Reset = read_MSPU_0_Soft_Reset_value
    End Property

    Property Let set_MSPU_0_Soft_Reset(aData)
        write_MSPU_0_Soft_Reset_value = aData
        flag_MSPU_0_Soft_Reset        = &H1
    End Property

    Property Get read_MSPU_0_Soft_Reset
        read
        read_MSPU_0_Soft_Reset = read_MSPU_0_Soft_Reset_value
    End Property

    Property Let write_MSPU_0_Soft_Reset(aData)
        set_MSPU_0_Soft_Reset = aData
        write
    End Property

    Property Get get_MSPU_spare_15_14
        get_MSPU_spare_15_14 = read_MSPU_spare_15_14_value
    End Property

    Property Let set_MSPU_spare_15_14(aData)
        write_MSPU_spare_15_14_value = aData
        flag_MSPU_spare_15_14        = &H1
    End Property

    Property Get read_MSPU_spare_15_14
        read
        read_MSPU_spare_15_14 = read_MSPU_spare_15_14_value
    End Property

    Property Let write_MSPU_spare_15_14(aData)
        set_MSPU_spare_15_14 = aData
        write
    End Property

    Property Get get_MSPU_5_Outbound_Sel
        get_MSPU_5_Outbound_Sel = read_MSPU_5_Outbound_Sel_value
    End Property

    Property Let set_MSPU_5_Outbound_Sel(aData)
        write_MSPU_5_Outbound_Sel_value = aData
        flag_MSPU_5_Outbound_Sel        = &H1
    End Property

    Property Get read_MSPU_5_Outbound_Sel
        read
        read_MSPU_5_Outbound_Sel = read_MSPU_5_Outbound_Sel_value
    End Property

    Property Let write_MSPU_5_Outbound_Sel(aData)
        set_MSPU_5_Outbound_Sel = aData
        write
    End Property

    Property Get get_MSPU_4_Outbound_Sel
        get_MSPU_4_Outbound_Sel = read_MSPU_4_Outbound_Sel_value
    End Property

    Property Let set_MSPU_4_Outbound_Sel(aData)
        write_MSPU_4_Outbound_Sel_value = aData
        flag_MSPU_4_Outbound_Sel        = &H1
    End Property

    Property Get read_MSPU_4_Outbound_Sel
        read
        read_MSPU_4_Outbound_Sel = read_MSPU_4_Outbound_Sel_value
    End Property

    Property Let write_MSPU_4_Outbound_Sel(aData)
        set_MSPU_4_Outbound_Sel = aData
        write
    End Property

    Property Get get_MSPU_3_Outbound_Sel
        get_MSPU_3_Outbound_Sel = read_MSPU_3_Outbound_Sel_value
    End Property

    Property Let set_MSPU_3_Outbound_Sel(aData)
        write_MSPU_3_Outbound_Sel_value = aData
        flag_MSPU_3_Outbound_Sel        = &H1
    End Property

    Property Get read_MSPU_3_Outbound_Sel
        read
        read_MSPU_3_Outbound_Sel = read_MSPU_3_Outbound_Sel_value
    End Property

    Property Let write_MSPU_3_Outbound_Sel(aData)
        set_MSPU_3_Outbound_Sel = aData
        write
    End Property

    Property Get get_MSPU_2_Outbound_Sel
        get_MSPU_2_Outbound_Sel = read_MSPU_2_Outbound_Sel_value
    End Property

    Property Let set_MSPU_2_Outbound_Sel(aData)
        write_MSPU_2_Outbound_Sel_value = aData
        flag_MSPU_2_Outbound_Sel        = &H1
    End Property

    Property Get read_MSPU_2_Outbound_Sel
        read
        read_MSPU_2_Outbound_Sel = read_MSPU_2_Outbound_Sel_value
    End Property

    Property Let write_MSPU_2_Outbound_Sel(aData)
        set_MSPU_2_Outbound_Sel = aData
        write
    End Property

    Property Get get_MSPU_1_Outbound_Sel
        get_MSPU_1_Outbound_Sel = read_MSPU_1_Outbound_Sel_value
    End Property

    Property Let set_MSPU_1_Outbound_Sel(aData)
        write_MSPU_1_Outbound_Sel_value = aData
        flag_MSPU_1_Outbound_Sel        = &H1
    End Property

    Property Get read_MSPU_1_Outbound_Sel
        read
        read_MSPU_1_Outbound_Sel = read_MSPU_1_Outbound_Sel_value
    End Property

    Property Let write_MSPU_1_Outbound_Sel(aData)
        set_MSPU_1_Outbound_Sel = aData
        write
    End Property

    Property Get get_MSPU_0_Outbound_Sel
        get_MSPU_0_Outbound_Sel = read_MSPU_0_Outbound_Sel_value
    End Property

    Property Let set_MSPU_0_Outbound_Sel(aData)
        write_MSPU_0_Outbound_Sel_value = aData
        flag_MSPU_0_Outbound_Sel        = &H1
    End Property

    Property Get read_MSPU_0_Outbound_Sel
        read
        read_MSPU_0_Outbound_Sel = read_MSPU_0_Outbound_Sel_value
    End Property

    Property Let write_MSPU_0_Outbound_Sel(aData)
        set_MSPU_0_Outbound_Sel = aData
        write
    End Property

    Property Get get_MSPU_spare_7_6
        get_MSPU_spare_7_6 = read_MSPU_spare_7_6_value
    End Property

    Property Let set_MSPU_spare_7_6(aData)
        write_MSPU_spare_7_6_value = aData
        flag_MSPU_spare_7_6        = &H1
    End Property

    Property Get read_MSPU_spare_7_6
        read
        read_MSPU_spare_7_6 = read_MSPU_spare_7_6_value
    End Property

    Property Let write_MSPU_spare_7_6(aData)
        set_MSPU_spare_7_6 = aData
        write
    End Property

    Property Get get_MSPU_5_Inbound_Sel
        get_MSPU_5_Inbound_Sel = read_MSPU_5_Inbound_Sel_value
    End Property

    Property Let set_MSPU_5_Inbound_Sel(aData)
        write_MSPU_5_Inbound_Sel_value = aData
        flag_MSPU_5_Inbound_Sel        = &H1
    End Property

    Property Get read_MSPU_5_Inbound_Sel
        read
        read_MSPU_5_Inbound_Sel = read_MSPU_5_Inbound_Sel_value
    End Property

    Property Let write_MSPU_5_Inbound_Sel(aData)
        set_MSPU_5_Inbound_Sel = aData
        write
    End Property

    Property Get get_MSPU_4_Inbound_Sel
        get_MSPU_4_Inbound_Sel = read_MSPU_4_Inbound_Sel_value
    End Property

    Property Let set_MSPU_4_Inbound_Sel(aData)
        write_MSPU_4_Inbound_Sel_value = aData
        flag_MSPU_4_Inbound_Sel        = &H1
    End Property

    Property Get read_MSPU_4_Inbound_Sel
        read
        read_MSPU_4_Inbound_Sel = read_MSPU_4_Inbound_Sel_value
    End Property

    Property Let write_MSPU_4_Inbound_Sel(aData)
        set_MSPU_4_Inbound_Sel = aData
        write
    End Property

    Property Get get_MSPU_3_Inbound_Sel
        get_MSPU_3_Inbound_Sel = read_MSPU_3_Inbound_Sel_value
    End Property

    Property Let set_MSPU_3_Inbound_Sel(aData)
        write_MSPU_3_Inbound_Sel_value = aData
        flag_MSPU_3_Inbound_Sel        = &H1
    End Property

    Property Get read_MSPU_3_Inbound_Sel
        read
        read_MSPU_3_Inbound_Sel = read_MSPU_3_Inbound_Sel_value
    End Property

    Property Let write_MSPU_3_Inbound_Sel(aData)
        set_MSPU_3_Inbound_Sel = aData
        write
    End Property

    Property Get get_MSPU_2_Inbound_Sel
        get_MSPU_2_Inbound_Sel = read_MSPU_2_Inbound_Sel_value
    End Property

    Property Let set_MSPU_2_Inbound_Sel(aData)
        write_MSPU_2_Inbound_Sel_value = aData
        flag_MSPU_2_Inbound_Sel        = &H1
    End Property

    Property Get read_MSPU_2_Inbound_Sel
        read
        read_MSPU_2_Inbound_Sel = read_MSPU_2_Inbound_Sel_value
    End Property

    Property Let write_MSPU_2_Inbound_Sel(aData)
        set_MSPU_2_Inbound_Sel = aData
        write
    End Property

    Property Get get_MSPU_1_Inbound_Sel
        get_MSPU_1_Inbound_Sel = read_MSPU_1_Inbound_Sel_value
    End Property

    Property Let set_MSPU_1_Inbound_Sel(aData)
        write_MSPU_1_Inbound_Sel_value = aData
        flag_MSPU_1_Inbound_Sel        = &H1
    End Property

    Property Get read_MSPU_1_Inbound_Sel
        read
        read_MSPU_1_Inbound_Sel = read_MSPU_1_Inbound_Sel_value
    End Property

    Property Let write_MSPU_1_Inbound_Sel(aData)
        set_MSPU_1_Inbound_Sel = aData
        write
    End Property

    Property Get get_MSPU_0_Inbound_Sel
        get_MSPU_0_Inbound_Sel = read_MSPU_0_Inbound_Sel_value
    End Property

    Property Let set_MSPU_0_Inbound_Sel(aData)
        write_MSPU_0_Inbound_Sel_value = aData
        flag_MSPU_0_Inbound_Sel        = &H1
    End Property

    Property Get read_MSPU_0_Inbound_Sel
        read
        read_MSPU_0_Inbound_Sel = read_MSPU_0_Inbound_Sel_value
    End Property

    Property Let write_MSPU_0_Inbound_Sel(aData)
        set_MSPU_0_Inbound_Sel = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MSPU_spare_31_22_value = rightShift(data_low, 22) and &H3ff
        read_MSPU_5_Soft_Reset_value = rightShift(data_low, 21) and &H1
        read_MSPU_4_Soft_Reset_value = rightShift(data_low, 20) and &H1
        read_MSPU_3_Soft_Reset_value = rightShift(data_low, 19) and &H1
        read_MSPU_2_Soft_Reset_value = rightShift(data_low, 18) and &H1
        read_MSPU_1_Soft_Reset_value = rightShift(data_low, 17) and &H1
        read_MSPU_0_Soft_Reset_value = rightShift(data_low, 16) and &H1
        read_MSPU_spare_15_14_value = rightShift(data_low, 14) and &H3
        read_MSPU_5_Outbound_Sel_value = rightShift(data_low, 13) and &H1
        read_MSPU_4_Outbound_Sel_value = rightShift(data_low, 12) and &H1
        read_MSPU_3_Outbound_Sel_value = rightShift(data_low, 11) and &H1
        read_MSPU_2_Outbound_Sel_value = rightShift(data_low, 10) and &H1
        read_MSPU_1_Outbound_Sel_value = rightShift(data_low, 9) and &H1
        read_MSPU_0_Outbound_Sel_value = rightShift(data_low, 8) and &H1
        read_MSPU_spare_7_6_value = rightShift(data_low, 6) and &H3
        read_MSPU_5_Inbound_Sel_value = rightShift(data_low, 5) and &H1
        read_MSPU_4_Inbound_Sel_value = rightShift(data_low, 4) and &H1
        read_MSPU_3_Inbound_Sel_value = rightShift(data_low, 3) and &H1
        read_MSPU_2_Inbound_Sel_value = rightShift(data_low, 2) and &H1
        read_MSPU_1_Inbound_Sel_value = rightShift(data_low, 1) and &H1
        MSPU_0_Inbound_Sel_mask = &H1
        if data_low > LONG_MAX then
            if MSPU_0_Inbound_Sel_mask = mask then
                read_MSPU_0_Inbound_Sel_value = data_low
            else
                read_MSPU_0_Inbound_Sel_value = (data_low - H8000_0000) and MSPU_0_Inbound_Sel_mask
            end If
        else
            read_MSPU_0_Inbound_Sel_value = data_low and MSPU_0_Inbound_Sel_mask
        end If

    End Sub

    Sub write
        If flag_MSPU_spare_31_22 = &H0 or flag_MSPU_5_Soft_Reset = &H0 or flag_MSPU_4_Soft_Reset = &H0 or flag_MSPU_3_Soft_Reset = &H0 or flag_MSPU_2_Soft_Reset = &H0 or flag_MSPU_1_Soft_Reset = &H0 or flag_MSPU_0_Soft_Reset = &H0 or flag_MSPU_spare_15_14 = &H0 or flag_MSPU_5_Outbound_Sel = &H0 or flag_MSPU_4_Outbound_Sel = &H0 or flag_MSPU_3_Outbound_Sel = &H0 or flag_MSPU_2_Outbound_Sel = &H0 or flag_MSPU_1_Outbound_Sel = &H0 or flag_MSPU_0_Outbound_Sel = &H0 or flag_MSPU_spare_7_6 = &H0 or flag_MSPU_5_Inbound_Sel = &H0 or flag_MSPU_4_Inbound_Sel = &H0 or flag_MSPU_3_Inbound_Sel = &H0 or flag_MSPU_2_Inbound_Sel = &H0 or flag_MSPU_1_Inbound_Sel = &H0 or flag_MSPU_0_Inbound_Sel = &H0 Then read
        If flag_MSPU_spare_31_22 = &H0 Then write_MSPU_spare_31_22_value = get_MSPU_spare_31_22
        If flag_MSPU_5_Soft_Reset = &H0 Then write_MSPU_5_Soft_Reset_value = get_MSPU_5_Soft_Reset
        If flag_MSPU_4_Soft_Reset = &H0 Then write_MSPU_4_Soft_Reset_value = get_MSPU_4_Soft_Reset
        If flag_MSPU_3_Soft_Reset = &H0 Then write_MSPU_3_Soft_Reset_value = get_MSPU_3_Soft_Reset
        If flag_MSPU_2_Soft_Reset = &H0 Then write_MSPU_2_Soft_Reset_value = get_MSPU_2_Soft_Reset
        If flag_MSPU_1_Soft_Reset = &H0 Then write_MSPU_1_Soft_Reset_value = get_MSPU_1_Soft_Reset
        If flag_MSPU_0_Soft_Reset = &H0 Then write_MSPU_0_Soft_Reset_value = get_MSPU_0_Soft_Reset
        If flag_MSPU_spare_15_14 = &H0 Then write_MSPU_spare_15_14_value = get_MSPU_spare_15_14
        If flag_MSPU_5_Outbound_Sel = &H0 Then write_MSPU_5_Outbound_Sel_value = get_MSPU_5_Outbound_Sel
        If flag_MSPU_4_Outbound_Sel = &H0 Then write_MSPU_4_Outbound_Sel_value = get_MSPU_4_Outbound_Sel
        If flag_MSPU_3_Outbound_Sel = &H0 Then write_MSPU_3_Outbound_Sel_value = get_MSPU_3_Outbound_Sel
        If flag_MSPU_2_Outbound_Sel = &H0 Then write_MSPU_2_Outbound_Sel_value = get_MSPU_2_Outbound_Sel
        If flag_MSPU_1_Outbound_Sel = &H0 Then write_MSPU_1_Outbound_Sel_value = get_MSPU_1_Outbound_Sel
        If flag_MSPU_0_Outbound_Sel = &H0 Then write_MSPU_0_Outbound_Sel_value = get_MSPU_0_Outbound_Sel
        If flag_MSPU_spare_7_6 = &H0 Then write_MSPU_spare_7_6_value = get_MSPU_spare_7_6
        If flag_MSPU_5_Inbound_Sel = &H0 Then write_MSPU_5_Inbound_Sel_value = get_MSPU_5_Inbound_Sel
        If flag_MSPU_4_Inbound_Sel = &H0 Then write_MSPU_4_Inbound_Sel_value = get_MSPU_4_Inbound_Sel
        If flag_MSPU_3_Inbound_Sel = &H0 Then write_MSPU_3_Inbound_Sel_value = get_MSPU_3_Inbound_Sel
        If flag_MSPU_2_Inbound_Sel = &H0 Then write_MSPU_2_Inbound_Sel_value = get_MSPU_2_Inbound_Sel
        If flag_MSPU_1_Inbound_Sel = &H0 Then write_MSPU_1_Inbound_Sel_value = get_MSPU_1_Inbound_Sel
        If flag_MSPU_0_Inbound_Sel = &H0 Then write_MSPU_0_Inbound_Sel_value = get_MSPU_0_Inbound_Sel

        regValue = leftShift((write_MSPU_spare_31_22_value and &H3ff), 22) + leftShift((write_MSPU_5_Soft_Reset_value and &H1), 21) + leftShift((write_MSPU_4_Soft_Reset_value and &H1), 20) + leftShift((write_MSPU_3_Soft_Reset_value and &H1), 19) + leftShift((write_MSPU_2_Soft_Reset_value and &H1), 18) + leftShift((write_MSPU_1_Soft_Reset_value and &H1), 17) + leftShift((write_MSPU_0_Soft_Reset_value and &H1), 16) + leftShift((write_MSPU_spare_15_14_value and &H3), 14) + leftShift((write_MSPU_5_Outbound_Sel_value and &H1), 13) + leftShift((write_MSPU_4_Outbound_Sel_value and &H1), 12) + leftShift((write_MSPU_3_Outbound_Sel_value and &H1), 11) + leftShift((write_MSPU_2_Outbound_Sel_value and &H1), 10) + leftShift((write_MSPU_1_Outbound_Sel_value and &H1), 9) + leftShift((write_MSPU_0_Outbound_Sel_value and &H1), 8) + leftShift((write_MSPU_spare_7_6_value and &H3), 6) + leftShift((write_MSPU_5_Inbound_Sel_value and &H1), 5) + leftShift((write_MSPU_4_Inbound_Sel_value and &H1), 4) + leftShift((write_MSPU_3_Inbound_Sel_value and &H1), 3) + leftShift((write_MSPU_2_Inbound_Sel_value and &H1), 2) + leftShift((write_MSPU_1_Inbound_Sel_value and &H1), 1) + leftShift((write_MSPU_0_Inbound_Sel_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MSPU_spare_31_22_value = rightShift(data_low, 22) and &H3ff
        read_MSPU_5_Soft_Reset_value = rightShift(data_low, 21) and &H1
        read_MSPU_4_Soft_Reset_value = rightShift(data_low, 20) and &H1
        read_MSPU_3_Soft_Reset_value = rightShift(data_low, 19) and &H1
        read_MSPU_2_Soft_Reset_value = rightShift(data_low, 18) and &H1
        read_MSPU_1_Soft_Reset_value = rightShift(data_low, 17) and &H1
        read_MSPU_0_Soft_Reset_value = rightShift(data_low, 16) and &H1
        read_MSPU_spare_15_14_value = rightShift(data_low, 14) and &H3
        read_MSPU_5_Outbound_Sel_value = rightShift(data_low, 13) and &H1
        read_MSPU_4_Outbound_Sel_value = rightShift(data_low, 12) and &H1
        read_MSPU_3_Outbound_Sel_value = rightShift(data_low, 11) and &H1
        read_MSPU_2_Outbound_Sel_value = rightShift(data_low, 10) and &H1
        read_MSPU_1_Outbound_Sel_value = rightShift(data_low, 9) and &H1
        read_MSPU_0_Outbound_Sel_value = rightShift(data_low, 8) and &H1
        read_MSPU_spare_7_6_value = rightShift(data_low, 6) and &H3
        read_MSPU_5_Inbound_Sel_value = rightShift(data_low, 5) and &H1
        read_MSPU_4_Inbound_Sel_value = rightShift(data_low, 4) and &H1
        read_MSPU_3_Inbound_Sel_value = rightShift(data_low, 3) and &H1
        read_MSPU_2_Inbound_Sel_value = rightShift(data_low, 2) and &H1
        read_MSPU_1_Inbound_Sel_value = rightShift(data_low, 1) and &H1
        MSPU_0_Inbound_Sel_mask = &H1
        if data_low > LONG_MAX then
            if MSPU_0_Inbound_Sel_mask = mask then
                read_MSPU_0_Inbound_Sel_value = data_low
            else
                read_MSPU_0_Inbound_Sel_value = (data_low - H8000_0000) and MSPU_0_Inbound_Sel_mask
            end If
        else
            read_MSPU_0_Inbound_Sel_value = data_low and MSPU_0_Inbound_Sel_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSPU_spare_31_22_value = &H0
        flag_MSPU_spare_31_22        = &H0
        write_MSPU_5_Soft_Reset_value = &H0
        flag_MSPU_5_Soft_Reset        = &H0
        write_MSPU_4_Soft_Reset_value = &H0
        flag_MSPU_4_Soft_Reset        = &H0
        write_MSPU_3_Soft_Reset_value = &H0
        flag_MSPU_3_Soft_Reset        = &H0
        write_MSPU_2_Soft_Reset_value = &H0
        flag_MSPU_2_Soft_Reset        = &H0
        write_MSPU_1_Soft_Reset_value = &H0
        flag_MSPU_1_Soft_Reset        = &H0
        write_MSPU_0_Soft_Reset_value = &H0
        flag_MSPU_0_Soft_Reset        = &H0
        write_MSPU_spare_15_14_value = &H0
        flag_MSPU_spare_15_14        = &H0
        write_MSPU_5_Outbound_Sel_value = &H0
        flag_MSPU_5_Outbound_Sel        = &H0
        write_MSPU_4_Outbound_Sel_value = &H0
        flag_MSPU_4_Outbound_Sel        = &H0
        write_MSPU_3_Outbound_Sel_value = &H0
        flag_MSPU_3_Outbound_Sel        = &H0
        write_MSPU_2_Outbound_Sel_value = &H0
        flag_MSPU_2_Outbound_Sel        = &H0
        write_MSPU_1_Outbound_Sel_value = &H0
        flag_MSPU_1_Outbound_Sel        = &H0
        write_MSPU_0_Outbound_Sel_value = &H0
        flag_MSPU_0_Outbound_Sel        = &H0
        write_MSPU_spare_7_6_value = &H0
        flag_MSPU_spare_7_6        = &H0
        write_MSPU_5_Inbound_Sel_value = &H0
        flag_MSPU_5_Inbound_Sel        = &H0
        write_MSPU_4_Inbound_Sel_value = &H0
        flag_MSPU_4_Inbound_Sel        = &H0
        write_MSPU_3_Inbound_Sel_value = &H0
        flag_MSPU_3_Inbound_Sel        = &H0
        write_MSPU_2_Inbound_Sel_value = &H0
        flag_MSPU_2_Inbound_Sel        = &H0
        write_MSPU_1_Inbound_Sel_value = &H0
        flag_MSPU_1_Inbound_Sel        = &H0
        write_MSPU_0_Inbound_Sel_value = &H0
        flag_MSPU_0_Inbound_Sel        = &H0
    End Sub
End Class


'' @REGISTER : MACSECSYS_MISC_testmode_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSPU_5_Testmode_Ingress                    [11:11]          get_MSPU_5_Testmode_Ingress
''                                                             set_MSPU_5_Testmode_Ingress
''                                                             read_MSPU_5_Testmode_Ingress
''                                                             write_MSPU_5_Testmode_Ingress
''---------------------------------------------------------------------------------
'' MSPU_5_Testmode_Egress                     [10:10]          get_MSPU_5_Testmode_Egress
''                                                             set_MSPU_5_Testmode_Egress
''                                                             read_MSPU_5_Testmode_Egress
''                                                             write_MSPU_5_Testmode_Egress
''---------------------------------------------------------------------------------
'' MSPU_4_Testmode_Ingress                    [9:9]            get_MSPU_4_Testmode_Ingress
''                                                             set_MSPU_4_Testmode_Ingress
''                                                             read_MSPU_4_Testmode_Ingress
''                                                             write_MSPU_4_Testmode_Ingress
''---------------------------------------------------------------------------------
'' MSPU_4_Testmode_Egress                     [8:8]            get_MSPU_4_Testmode_Egress
''                                                             set_MSPU_4_Testmode_Egress
''                                                             read_MSPU_4_Testmode_Egress
''                                                             write_MSPU_4_Testmode_Egress
''---------------------------------------------------------------------------------
'' MSPU_3_Testmode_Ingress                    [7:7]            get_MSPU_3_Testmode_Ingress
''                                                             set_MSPU_3_Testmode_Ingress
''                                                             read_MSPU_3_Testmode_Ingress
''                                                             write_MSPU_3_Testmode_Ingress
''---------------------------------------------------------------------------------
'' MSPU_3_Testmode_Egress                     [6:6]            get_MSPU_3_Testmode_Egress
''                                                             set_MSPU_3_Testmode_Egress
''                                                             read_MSPU_3_Testmode_Egress
''                                                             write_MSPU_3_Testmode_Egress
''---------------------------------------------------------------------------------
'' MSPU_2_Testmode_Ingress                    [5:5]            get_MSPU_2_Testmode_Ingress
''                                                             set_MSPU_2_Testmode_Ingress
''                                                             read_MSPU_2_Testmode_Ingress
''                                                             write_MSPU_2_Testmode_Ingress
''---------------------------------------------------------------------------------
'' MSPU_2_Testmode_Egress                     [4:4]            get_MSPU_2_Testmode_Egress
''                                                             set_MSPU_2_Testmode_Egress
''                                                             read_MSPU_2_Testmode_Egress
''                                                             write_MSPU_2_Testmode_Egress
''---------------------------------------------------------------------------------
'' MSPU_1_Testmode_Ingress                    [3:3]            get_MSPU_1_Testmode_Ingress
''                                                             set_MSPU_1_Testmode_Ingress
''                                                             read_MSPU_1_Testmode_Ingress
''                                                             write_MSPU_1_Testmode_Ingress
''---------------------------------------------------------------------------------
'' MSPU_1_Testmode_Egress                     [2:2]            get_MSPU_1_Testmode_Egress
''                                                             set_MSPU_1_Testmode_Egress
''                                                             read_MSPU_1_Testmode_Egress
''                                                             write_MSPU_1_Testmode_Egress
''---------------------------------------------------------------------------------
'' MSPU_0_Testmode_Ingress                    [1:1]            get_MSPU_0_Testmode_Ingress
''                                                             set_MSPU_0_Testmode_Ingress
''                                                             read_MSPU_0_Testmode_Ingress
''                                                             write_MSPU_0_Testmode_Ingress
''---------------------------------------------------------------------------------
'' MSPU_0_Testmode_Egress                     [0:0]            get_MSPU_0_Testmode_Egress
''                                                             set_MSPU_0_Testmode_Egress
''                                                             read_MSPU_0_Testmode_Egress
''                                                             write_MSPU_0_Testmode_Egress
''---------------------------------------------------------------------------------
Class REGISTER_MACSECSYS_MISC_testmode_ctrl
    Private write_MSPU_5_Testmode_Ingress_value
    Private read_MSPU_5_Testmode_Ingress_value
    Private flag_MSPU_5_Testmode_Ingress
    Private write_MSPU_5_Testmode_Egress_value
    Private read_MSPU_5_Testmode_Egress_value
    Private flag_MSPU_5_Testmode_Egress
    Private write_MSPU_4_Testmode_Ingress_value
    Private read_MSPU_4_Testmode_Ingress_value
    Private flag_MSPU_4_Testmode_Ingress
    Private write_MSPU_4_Testmode_Egress_value
    Private read_MSPU_4_Testmode_Egress_value
    Private flag_MSPU_4_Testmode_Egress
    Private write_MSPU_3_Testmode_Ingress_value
    Private read_MSPU_3_Testmode_Ingress_value
    Private flag_MSPU_3_Testmode_Ingress
    Private write_MSPU_3_Testmode_Egress_value
    Private read_MSPU_3_Testmode_Egress_value
    Private flag_MSPU_3_Testmode_Egress
    Private write_MSPU_2_Testmode_Ingress_value
    Private read_MSPU_2_Testmode_Ingress_value
    Private flag_MSPU_2_Testmode_Ingress
    Private write_MSPU_2_Testmode_Egress_value
    Private read_MSPU_2_Testmode_Egress_value
    Private flag_MSPU_2_Testmode_Egress
    Private write_MSPU_1_Testmode_Ingress_value
    Private read_MSPU_1_Testmode_Ingress_value
    Private flag_MSPU_1_Testmode_Ingress
    Private write_MSPU_1_Testmode_Egress_value
    Private read_MSPU_1_Testmode_Egress_value
    Private flag_MSPU_1_Testmode_Egress
    Private write_MSPU_0_Testmode_Ingress_value
    Private read_MSPU_0_Testmode_Ingress_value
    Private flag_MSPU_0_Testmode_Ingress
    Private write_MSPU_0_Testmode_Egress_value
    Private read_MSPU_0_Testmode_Egress_value
    Private flag_MSPU_0_Testmode_Egress

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

    Property Get get_MSPU_5_Testmode_Ingress
        get_MSPU_5_Testmode_Ingress = read_MSPU_5_Testmode_Ingress_value
    End Property

    Property Let set_MSPU_5_Testmode_Ingress(aData)
        write_MSPU_5_Testmode_Ingress_value = aData
        flag_MSPU_5_Testmode_Ingress        = &H1
    End Property

    Property Get read_MSPU_5_Testmode_Ingress
        read
        read_MSPU_5_Testmode_Ingress = read_MSPU_5_Testmode_Ingress_value
    End Property

    Property Let write_MSPU_5_Testmode_Ingress(aData)
        set_MSPU_5_Testmode_Ingress = aData
        write
    End Property

    Property Get get_MSPU_5_Testmode_Egress
        get_MSPU_5_Testmode_Egress = read_MSPU_5_Testmode_Egress_value
    End Property

    Property Let set_MSPU_5_Testmode_Egress(aData)
        write_MSPU_5_Testmode_Egress_value = aData
        flag_MSPU_5_Testmode_Egress        = &H1
    End Property

    Property Get read_MSPU_5_Testmode_Egress
        read
        read_MSPU_5_Testmode_Egress = read_MSPU_5_Testmode_Egress_value
    End Property

    Property Let write_MSPU_5_Testmode_Egress(aData)
        set_MSPU_5_Testmode_Egress = aData
        write
    End Property

    Property Get get_MSPU_4_Testmode_Ingress
        get_MSPU_4_Testmode_Ingress = read_MSPU_4_Testmode_Ingress_value
    End Property

    Property Let set_MSPU_4_Testmode_Ingress(aData)
        write_MSPU_4_Testmode_Ingress_value = aData
        flag_MSPU_4_Testmode_Ingress        = &H1
    End Property

    Property Get read_MSPU_4_Testmode_Ingress
        read
        read_MSPU_4_Testmode_Ingress = read_MSPU_4_Testmode_Ingress_value
    End Property

    Property Let write_MSPU_4_Testmode_Ingress(aData)
        set_MSPU_4_Testmode_Ingress = aData
        write
    End Property

    Property Get get_MSPU_4_Testmode_Egress
        get_MSPU_4_Testmode_Egress = read_MSPU_4_Testmode_Egress_value
    End Property

    Property Let set_MSPU_4_Testmode_Egress(aData)
        write_MSPU_4_Testmode_Egress_value = aData
        flag_MSPU_4_Testmode_Egress        = &H1
    End Property

    Property Get read_MSPU_4_Testmode_Egress
        read
        read_MSPU_4_Testmode_Egress = read_MSPU_4_Testmode_Egress_value
    End Property

    Property Let write_MSPU_4_Testmode_Egress(aData)
        set_MSPU_4_Testmode_Egress = aData
        write
    End Property

    Property Get get_MSPU_3_Testmode_Ingress
        get_MSPU_3_Testmode_Ingress = read_MSPU_3_Testmode_Ingress_value
    End Property

    Property Let set_MSPU_3_Testmode_Ingress(aData)
        write_MSPU_3_Testmode_Ingress_value = aData
        flag_MSPU_3_Testmode_Ingress        = &H1
    End Property

    Property Get read_MSPU_3_Testmode_Ingress
        read
        read_MSPU_3_Testmode_Ingress = read_MSPU_3_Testmode_Ingress_value
    End Property

    Property Let write_MSPU_3_Testmode_Ingress(aData)
        set_MSPU_3_Testmode_Ingress = aData
        write
    End Property

    Property Get get_MSPU_3_Testmode_Egress
        get_MSPU_3_Testmode_Egress = read_MSPU_3_Testmode_Egress_value
    End Property

    Property Let set_MSPU_3_Testmode_Egress(aData)
        write_MSPU_3_Testmode_Egress_value = aData
        flag_MSPU_3_Testmode_Egress        = &H1
    End Property

    Property Get read_MSPU_3_Testmode_Egress
        read
        read_MSPU_3_Testmode_Egress = read_MSPU_3_Testmode_Egress_value
    End Property

    Property Let write_MSPU_3_Testmode_Egress(aData)
        set_MSPU_3_Testmode_Egress = aData
        write
    End Property

    Property Get get_MSPU_2_Testmode_Ingress
        get_MSPU_2_Testmode_Ingress = read_MSPU_2_Testmode_Ingress_value
    End Property

    Property Let set_MSPU_2_Testmode_Ingress(aData)
        write_MSPU_2_Testmode_Ingress_value = aData
        flag_MSPU_2_Testmode_Ingress        = &H1
    End Property

    Property Get read_MSPU_2_Testmode_Ingress
        read
        read_MSPU_2_Testmode_Ingress = read_MSPU_2_Testmode_Ingress_value
    End Property

    Property Let write_MSPU_2_Testmode_Ingress(aData)
        set_MSPU_2_Testmode_Ingress = aData
        write
    End Property

    Property Get get_MSPU_2_Testmode_Egress
        get_MSPU_2_Testmode_Egress = read_MSPU_2_Testmode_Egress_value
    End Property

    Property Let set_MSPU_2_Testmode_Egress(aData)
        write_MSPU_2_Testmode_Egress_value = aData
        flag_MSPU_2_Testmode_Egress        = &H1
    End Property

    Property Get read_MSPU_2_Testmode_Egress
        read
        read_MSPU_2_Testmode_Egress = read_MSPU_2_Testmode_Egress_value
    End Property

    Property Let write_MSPU_2_Testmode_Egress(aData)
        set_MSPU_2_Testmode_Egress = aData
        write
    End Property

    Property Get get_MSPU_1_Testmode_Ingress
        get_MSPU_1_Testmode_Ingress = read_MSPU_1_Testmode_Ingress_value
    End Property

    Property Let set_MSPU_1_Testmode_Ingress(aData)
        write_MSPU_1_Testmode_Ingress_value = aData
        flag_MSPU_1_Testmode_Ingress        = &H1
    End Property

    Property Get read_MSPU_1_Testmode_Ingress
        read
        read_MSPU_1_Testmode_Ingress = read_MSPU_1_Testmode_Ingress_value
    End Property

    Property Let write_MSPU_1_Testmode_Ingress(aData)
        set_MSPU_1_Testmode_Ingress = aData
        write
    End Property

    Property Get get_MSPU_1_Testmode_Egress
        get_MSPU_1_Testmode_Egress = read_MSPU_1_Testmode_Egress_value
    End Property

    Property Let set_MSPU_1_Testmode_Egress(aData)
        write_MSPU_1_Testmode_Egress_value = aData
        flag_MSPU_1_Testmode_Egress        = &H1
    End Property

    Property Get read_MSPU_1_Testmode_Egress
        read
        read_MSPU_1_Testmode_Egress = read_MSPU_1_Testmode_Egress_value
    End Property

    Property Let write_MSPU_1_Testmode_Egress(aData)
        set_MSPU_1_Testmode_Egress = aData
        write
    End Property

    Property Get get_MSPU_0_Testmode_Ingress
        get_MSPU_0_Testmode_Ingress = read_MSPU_0_Testmode_Ingress_value
    End Property

    Property Let set_MSPU_0_Testmode_Ingress(aData)
        write_MSPU_0_Testmode_Ingress_value = aData
        flag_MSPU_0_Testmode_Ingress        = &H1
    End Property

    Property Get read_MSPU_0_Testmode_Ingress
        read
        read_MSPU_0_Testmode_Ingress = read_MSPU_0_Testmode_Ingress_value
    End Property

    Property Let write_MSPU_0_Testmode_Ingress(aData)
        set_MSPU_0_Testmode_Ingress = aData
        write
    End Property

    Property Get get_MSPU_0_Testmode_Egress
        get_MSPU_0_Testmode_Egress = read_MSPU_0_Testmode_Egress_value
    End Property

    Property Let set_MSPU_0_Testmode_Egress(aData)
        write_MSPU_0_Testmode_Egress_value = aData
        flag_MSPU_0_Testmode_Egress        = &H1
    End Property

    Property Get read_MSPU_0_Testmode_Egress
        read
        read_MSPU_0_Testmode_Egress = read_MSPU_0_Testmode_Egress_value
    End Property

    Property Let write_MSPU_0_Testmode_Egress(aData)
        set_MSPU_0_Testmode_Egress = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MSPU_5_Testmode_Ingress_value = rightShift(data_low, 11) and &H1
        read_MSPU_5_Testmode_Egress_value = rightShift(data_low, 10) and &H1
        read_MSPU_4_Testmode_Ingress_value = rightShift(data_low, 9) and &H1
        read_MSPU_4_Testmode_Egress_value = rightShift(data_low, 8) and &H1
        read_MSPU_3_Testmode_Ingress_value = rightShift(data_low, 7) and &H1
        read_MSPU_3_Testmode_Egress_value = rightShift(data_low, 6) and &H1
        read_MSPU_2_Testmode_Ingress_value = rightShift(data_low, 5) and &H1
        read_MSPU_2_Testmode_Egress_value = rightShift(data_low, 4) and &H1
        read_MSPU_1_Testmode_Ingress_value = rightShift(data_low, 3) and &H1
        read_MSPU_1_Testmode_Egress_value = rightShift(data_low, 2) and &H1
        read_MSPU_0_Testmode_Ingress_value = rightShift(data_low, 1) and &H1
        MSPU_0_Testmode_Egress_mask = &H1
        if data_low > LONG_MAX then
            if MSPU_0_Testmode_Egress_mask = mask then
                read_MSPU_0_Testmode_Egress_value = data_low
            else
                read_MSPU_0_Testmode_Egress_value = (data_low - H8000_0000) and MSPU_0_Testmode_Egress_mask
            end If
        else
            read_MSPU_0_Testmode_Egress_value = data_low and MSPU_0_Testmode_Egress_mask
        end If

    End Sub

    Sub write
        If flag_MSPU_5_Testmode_Ingress = &H0 or flag_MSPU_5_Testmode_Egress = &H0 or flag_MSPU_4_Testmode_Ingress = &H0 or flag_MSPU_4_Testmode_Egress = &H0 or flag_MSPU_3_Testmode_Ingress = &H0 or flag_MSPU_3_Testmode_Egress = &H0 or flag_MSPU_2_Testmode_Ingress = &H0 or flag_MSPU_2_Testmode_Egress = &H0 or flag_MSPU_1_Testmode_Ingress = &H0 or flag_MSPU_1_Testmode_Egress = &H0 or flag_MSPU_0_Testmode_Ingress = &H0 or flag_MSPU_0_Testmode_Egress = &H0 Then read
        If flag_MSPU_5_Testmode_Ingress = &H0 Then write_MSPU_5_Testmode_Ingress_value = get_MSPU_5_Testmode_Ingress
        If flag_MSPU_5_Testmode_Egress = &H0 Then write_MSPU_5_Testmode_Egress_value = get_MSPU_5_Testmode_Egress
        If flag_MSPU_4_Testmode_Ingress = &H0 Then write_MSPU_4_Testmode_Ingress_value = get_MSPU_4_Testmode_Ingress
        If flag_MSPU_4_Testmode_Egress = &H0 Then write_MSPU_4_Testmode_Egress_value = get_MSPU_4_Testmode_Egress
        If flag_MSPU_3_Testmode_Ingress = &H0 Then write_MSPU_3_Testmode_Ingress_value = get_MSPU_3_Testmode_Ingress
        If flag_MSPU_3_Testmode_Egress = &H0 Then write_MSPU_3_Testmode_Egress_value = get_MSPU_3_Testmode_Egress
        If flag_MSPU_2_Testmode_Ingress = &H0 Then write_MSPU_2_Testmode_Ingress_value = get_MSPU_2_Testmode_Ingress
        If flag_MSPU_2_Testmode_Egress = &H0 Then write_MSPU_2_Testmode_Egress_value = get_MSPU_2_Testmode_Egress
        If flag_MSPU_1_Testmode_Ingress = &H0 Then write_MSPU_1_Testmode_Ingress_value = get_MSPU_1_Testmode_Ingress
        If flag_MSPU_1_Testmode_Egress = &H0 Then write_MSPU_1_Testmode_Egress_value = get_MSPU_1_Testmode_Egress
        If flag_MSPU_0_Testmode_Ingress = &H0 Then write_MSPU_0_Testmode_Ingress_value = get_MSPU_0_Testmode_Ingress
        If flag_MSPU_0_Testmode_Egress = &H0 Then write_MSPU_0_Testmode_Egress_value = get_MSPU_0_Testmode_Egress

        regValue = leftShift((write_MSPU_5_Testmode_Ingress_value and &H1), 11) + leftShift((write_MSPU_5_Testmode_Egress_value and &H1), 10) + leftShift((write_MSPU_4_Testmode_Ingress_value and &H1), 9) + leftShift((write_MSPU_4_Testmode_Egress_value and &H1), 8) + leftShift((write_MSPU_3_Testmode_Ingress_value and &H1), 7) + leftShift((write_MSPU_3_Testmode_Egress_value and &H1), 6) + leftShift((write_MSPU_2_Testmode_Ingress_value and &H1), 5) + leftShift((write_MSPU_2_Testmode_Egress_value and &H1), 4) + leftShift((write_MSPU_1_Testmode_Ingress_value and &H1), 3) + leftShift((write_MSPU_1_Testmode_Egress_value and &H1), 2) + leftShift((write_MSPU_0_Testmode_Ingress_value and &H1), 1) + leftShift((write_MSPU_0_Testmode_Egress_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MSPU_5_Testmode_Ingress_value = rightShift(data_low, 11) and &H1
        read_MSPU_5_Testmode_Egress_value = rightShift(data_low, 10) and &H1
        read_MSPU_4_Testmode_Ingress_value = rightShift(data_low, 9) and &H1
        read_MSPU_4_Testmode_Egress_value = rightShift(data_low, 8) and &H1
        read_MSPU_3_Testmode_Ingress_value = rightShift(data_low, 7) and &H1
        read_MSPU_3_Testmode_Egress_value = rightShift(data_low, 6) and &H1
        read_MSPU_2_Testmode_Ingress_value = rightShift(data_low, 5) and &H1
        read_MSPU_2_Testmode_Egress_value = rightShift(data_low, 4) and &H1
        read_MSPU_1_Testmode_Ingress_value = rightShift(data_low, 3) and &H1
        read_MSPU_1_Testmode_Egress_value = rightShift(data_low, 2) and &H1
        read_MSPU_0_Testmode_Ingress_value = rightShift(data_low, 1) and &H1
        MSPU_0_Testmode_Egress_mask = &H1
        if data_low > LONG_MAX then
            if MSPU_0_Testmode_Egress_mask = mask then
                read_MSPU_0_Testmode_Egress_value = data_low
            else
                read_MSPU_0_Testmode_Egress_value = (data_low - H8000_0000) and MSPU_0_Testmode_Egress_mask
            end If
        else
            read_MSPU_0_Testmode_Egress_value = data_low and MSPU_0_Testmode_Egress_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSPU_5_Testmode_Ingress_value = &H0
        flag_MSPU_5_Testmode_Ingress        = &H0
        write_MSPU_5_Testmode_Egress_value = &H0
        flag_MSPU_5_Testmode_Egress        = &H0
        write_MSPU_4_Testmode_Ingress_value = &H0
        flag_MSPU_4_Testmode_Ingress        = &H0
        write_MSPU_4_Testmode_Egress_value = &H0
        flag_MSPU_4_Testmode_Egress        = &H0
        write_MSPU_3_Testmode_Ingress_value = &H0
        flag_MSPU_3_Testmode_Ingress        = &H0
        write_MSPU_3_Testmode_Egress_value = &H0
        flag_MSPU_3_Testmode_Egress        = &H0
        write_MSPU_2_Testmode_Ingress_value = &H0
        flag_MSPU_2_Testmode_Ingress        = &H0
        write_MSPU_2_Testmode_Egress_value = &H0
        flag_MSPU_2_Testmode_Egress        = &H0
        write_MSPU_1_Testmode_Ingress_value = &H0
        flag_MSPU_1_Testmode_Ingress        = &H0
        write_MSPU_1_Testmode_Egress_value = &H0
        flag_MSPU_1_Testmode_Egress        = &H0
        write_MSPU_0_Testmode_Ingress_value = &H0
        flag_MSPU_0_Testmode_Ingress        = &H0
        write_MSPU_0_Testmode_Egress_value = &H0
        flag_MSPU_0_Testmode_Egress        = &H0
    End Sub
End Class


'' @REGISTER : MACSECSYS_MISC_probesel_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSPU_PROBE_SEL                             [2:0]            get_MSPU_PROBE_SEL
''                                                             set_MSPU_PROBE_SEL
''                                                             read_MSPU_PROBE_SEL
''                                                             write_MSPU_PROBE_SEL
''---------------------------------------------------------------------------------
Class REGISTER_MACSECSYS_MISC_probesel_ctrl
    Private write_MSPU_PROBE_SEL_value
    Private read_MSPU_PROBE_SEL_value
    Private flag_MSPU_PROBE_SEL

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

    Property Get get_MSPU_PROBE_SEL
        get_MSPU_PROBE_SEL = read_MSPU_PROBE_SEL_value
    End Property

    Property Let set_MSPU_PROBE_SEL(aData)
        write_MSPU_PROBE_SEL_value = aData
        flag_MSPU_PROBE_SEL        = &H1
    End Property

    Property Get read_MSPU_PROBE_SEL
        read
        read_MSPU_PROBE_SEL = read_MSPU_PROBE_SEL_value
    End Property

    Property Let write_MSPU_PROBE_SEL(aData)
        set_MSPU_PROBE_SEL = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSPU_PROBE_SEL_mask = &H7
        if data_low > LONG_MAX then
            if MSPU_PROBE_SEL_mask = mask then
                read_MSPU_PROBE_SEL_value = data_low
            else
                read_MSPU_PROBE_SEL_value = (data_low - H8000_0000) and MSPU_PROBE_SEL_mask
            end If
        else
            read_MSPU_PROBE_SEL_value = data_low and MSPU_PROBE_SEL_mask
        end If

    End Sub

    Sub write
        If flag_MSPU_PROBE_SEL = &H0 Then read
        If flag_MSPU_PROBE_SEL = &H0 Then write_MSPU_PROBE_SEL_value = get_MSPU_PROBE_SEL

        regValue = leftShift((write_MSPU_PROBE_SEL_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        MSPU_PROBE_SEL_mask = &H7
        if data_low > LONG_MAX then
            if MSPU_PROBE_SEL_mask = mask then
                read_MSPU_PROBE_SEL_value = data_low
            else
                read_MSPU_PROBE_SEL_value = (data_low - H8000_0000) and MSPU_PROBE_SEL_mask
            end If
        else
            read_MSPU_PROBE_SEL_value = data_low and MSPU_PROBE_SEL_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSPU_PROBE_SEL_value = &H0
        flag_MSPU_PROBE_SEL        = &H0
    End Sub
End Class


'' @REGISTER : MACSECSYS_MISC_interrupt_stat
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSPU_5_Int                                 [5:5]            get_MSPU_5_Int
''                                                             set_MSPU_5_Int
''                                                             read_MSPU_5_Int
''                                                             write_MSPU_5_Int
''---------------------------------------------------------------------------------
'' MSPU_4_Int                                 [4:4]            get_MSPU_4_Int
''                                                             set_MSPU_4_Int
''                                                             read_MSPU_4_Int
''                                                             write_MSPU_4_Int
''---------------------------------------------------------------------------------
'' MSPU_3_Int                                 [3:3]            get_MSPU_3_Int
''                                                             set_MSPU_3_Int
''                                                             read_MSPU_3_Int
''                                                             write_MSPU_3_Int
''---------------------------------------------------------------------------------
'' MSPU_2_Int                                 [2:2]            get_MSPU_2_Int
''                                                             set_MSPU_2_Int
''                                                             read_MSPU_2_Int
''                                                             write_MSPU_2_Int
''---------------------------------------------------------------------------------
'' MSPU_1_Int                                 [1:1]            get_MSPU_1_Int
''                                                             set_MSPU_1_Int
''                                                             read_MSPU_1_Int
''                                                             write_MSPU_1_Int
''---------------------------------------------------------------------------------
'' MSPU_0_Int                                 [0:0]            get_MSPU_0_Int
''                                                             set_MSPU_0_Int
''                                                             read_MSPU_0_Int
''                                                             write_MSPU_0_Int
''---------------------------------------------------------------------------------
Class REGISTER_MACSECSYS_MISC_interrupt_stat
    Private write_MSPU_5_Int_value
    Private read_MSPU_5_Int_value
    Private flag_MSPU_5_Int
    Private write_MSPU_4_Int_value
    Private read_MSPU_4_Int_value
    Private flag_MSPU_4_Int
    Private write_MSPU_3_Int_value
    Private read_MSPU_3_Int_value
    Private flag_MSPU_3_Int
    Private write_MSPU_2_Int_value
    Private read_MSPU_2_Int_value
    Private flag_MSPU_2_Int
    Private write_MSPU_1_Int_value
    Private read_MSPU_1_Int_value
    Private flag_MSPU_1_Int
    Private write_MSPU_0_Int_value
    Private read_MSPU_0_Int_value
    Private flag_MSPU_0_Int

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

    Property Get get_MSPU_5_Int
        get_MSPU_5_Int = read_MSPU_5_Int_value
    End Property

    Property Let set_MSPU_5_Int(aData)
        write_MSPU_5_Int_value = aData
        flag_MSPU_5_Int        = &H1
    End Property

    Property Get read_MSPU_5_Int
        read
        read_MSPU_5_Int = read_MSPU_5_Int_value
    End Property

    Property Let write_MSPU_5_Int(aData)
        set_MSPU_5_Int = aData
        write
    End Property

    Property Get get_MSPU_4_Int
        get_MSPU_4_Int = read_MSPU_4_Int_value
    End Property

    Property Let set_MSPU_4_Int(aData)
        write_MSPU_4_Int_value = aData
        flag_MSPU_4_Int        = &H1
    End Property

    Property Get read_MSPU_4_Int
        read
        read_MSPU_4_Int = read_MSPU_4_Int_value
    End Property

    Property Let write_MSPU_4_Int(aData)
        set_MSPU_4_Int = aData
        write
    End Property

    Property Get get_MSPU_3_Int
        get_MSPU_3_Int = read_MSPU_3_Int_value
    End Property

    Property Let set_MSPU_3_Int(aData)
        write_MSPU_3_Int_value = aData
        flag_MSPU_3_Int        = &H1
    End Property

    Property Get read_MSPU_3_Int
        read
        read_MSPU_3_Int = read_MSPU_3_Int_value
    End Property

    Property Let write_MSPU_3_Int(aData)
        set_MSPU_3_Int = aData
        write
    End Property

    Property Get get_MSPU_2_Int
        get_MSPU_2_Int = read_MSPU_2_Int_value
    End Property

    Property Let set_MSPU_2_Int(aData)
        write_MSPU_2_Int_value = aData
        flag_MSPU_2_Int        = &H1
    End Property

    Property Get read_MSPU_2_Int
        read
        read_MSPU_2_Int = read_MSPU_2_Int_value
    End Property

    Property Let write_MSPU_2_Int(aData)
        set_MSPU_2_Int = aData
        write
    End Property

    Property Get get_MSPU_1_Int
        get_MSPU_1_Int = read_MSPU_1_Int_value
    End Property

    Property Let set_MSPU_1_Int(aData)
        write_MSPU_1_Int_value = aData
        flag_MSPU_1_Int        = &H1
    End Property

    Property Get read_MSPU_1_Int
        read
        read_MSPU_1_Int = read_MSPU_1_Int_value
    End Property

    Property Let write_MSPU_1_Int(aData)
        set_MSPU_1_Int = aData
        write
    End Property

    Property Get get_MSPU_0_Int
        get_MSPU_0_Int = read_MSPU_0_Int_value
    End Property

    Property Let set_MSPU_0_Int(aData)
        write_MSPU_0_Int_value = aData
        flag_MSPU_0_Int        = &H1
    End Property

    Property Get read_MSPU_0_Int
        read
        read_MSPU_0_Int = read_MSPU_0_Int_value
    End Property

    Property Let write_MSPU_0_Int(aData)
        set_MSPU_0_Int = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MSPU_5_Int_value = rightShift(data_low, 5) and &H1
        read_MSPU_4_Int_value = rightShift(data_low, 4) and &H1
        read_MSPU_3_Int_value = rightShift(data_low, 3) and &H1
        read_MSPU_2_Int_value = rightShift(data_low, 2) and &H1
        read_MSPU_1_Int_value = rightShift(data_low, 1) and &H1
        MSPU_0_Int_mask = &H1
        if data_low > LONG_MAX then
            if MSPU_0_Int_mask = mask then
                read_MSPU_0_Int_value = data_low
            else
                read_MSPU_0_Int_value = (data_low - H8000_0000) and MSPU_0_Int_mask
            end If
        else
            read_MSPU_0_Int_value = data_low and MSPU_0_Int_mask
        end If

    End Sub

    Sub write
        If flag_MSPU_5_Int = &H0 or flag_MSPU_4_Int = &H0 or flag_MSPU_3_Int = &H0 or flag_MSPU_2_Int = &H0 or flag_MSPU_1_Int = &H0 or flag_MSPU_0_Int = &H0 Then read
        If flag_MSPU_5_Int = &H0 Then write_MSPU_5_Int_value = get_MSPU_5_Int
        If flag_MSPU_4_Int = &H0 Then write_MSPU_4_Int_value = get_MSPU_4_Int
        If flag_MSPU_3_Int = &H0 Then write_MSPU_3_Int_value = get_MSPU_3_Int
        If flag_MSPU_2_Int = &H0 Then write_MSPU_2_Int_value = get_MSPU_2_Int
        If flag_MSPU_1_Int = &H0 Then write_MSPU_1_Int_value = get_MSPU_1_Int
        If flag_MSPU_0_Int = &H0 Then write_MSPU_0_Int_value = get_MSPU_0_Int

        regValue = leftShift((write_MSPU_5_Int_value and &H1), 5) + leftShift((write_MSPU_4_Int_value and &H1), 4) + leftShift((write_MSPU_3_Int_value and &H1), 3) + leftShift((write_MSPU_2_Int_value and &H1), 2) + leftShift((write_MSPU_1_Int_value and &H1), 1) + leftShift((write_MSPU_0_Int_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MSPU_5_Int_value = rightShift(data_low, 5) and &H1
        read_MSPU_4_Int_value = rightShift(data_low, 4) and &H1
        read_MSPU_3_Int_value = rightShift(data_low, 3) and &H1
        read_MSPU_2_Int_value = rightShift(data_low, 2) and &H1
        read_MSPU_1_Int_value = rightShift(data_low, 1) and &H1
        MSPU_0_Int_mask = &H1
        if data_low > LONG_MAX then
            if MSPU_0_Int_mask = mask then
                read_MSPU_0_Int_value = data_low
            else
                read_MSPU_0_Int_value = (data_low - H8000_0000) and MSPU_0_Int_mask
            end If
        else
            read_MSPU_0_Int_value = data_low and MSPU_0_Int_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSPU_5_Int_value = &H0
        flag_MSPU_5_Int        = &H0
        write_MSPU_4_Int_value = &H0
        flag_MSPU_4_Int        = &H0
        write_MSPU_3_Int_value = &H0
        flag_MSPU_3_Int        = &H0
        write_MSPU_2_Int_value = &H0
        flag_MSPU_2_Int        = &H0
        write_MSPU_1_Int_value = &H0
        flag_MSPU_1_Int        = &H0
        write_MSPU_0_Int_value = &H0
        flag_MSPU_0_Int        = &H0
    End Sub
End Class


'' @REGISTER : MACSECSYS_MISC_interrupt_mask
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSPU_5_IntMask                             [5:5]            get_MSPU_5_IntMask
''                                                             set_MSPU_5_IntMask
''                                                             read_MSPU_5_IntMask
''                                                             write_MSPU_5_IntMask
''---------------------------------------------------------------------------------
'' MSPU_4_IntMask                             [4:4]            get_MSPU_4_IntMask
''                                                             set_MSPU_4_IntMask
''                                                             read_MSPU_4_IntMask
''                                                             write_MSPU_4_IntMask
''---------------------------------------------------------------------------------
'' MSPU_3_IntMask                             [3:3]            get_MSPU_3_IntMask
''                                                             set_MSPU_3_IntMask
''                                                             read_MSPU_3_IntMask
''                                                             write_MSPU_3_IntMask
''---------------------------------------------------------------------------------
'' MSPU_2_IntMask                             [2:2]            get_MSPU_2_IntMask
''                                                             set_MSPU_2_IntMask
''                                                             read_MSPU_2_IntMask
''                                                             write_MSPU_2_IntMask
''---------------------------------------------------------------------------------
'' MSPU_1_IntMask                             [1:1]            get_MSPU_1_IntMask
''                                                             set_MSPU_1_IntMask
''                                                             read_MSPU_1_IntMask
''                                                             write_MSPU_1_IntMask
''---------------------------------------------------------------------------------
'' MSPU_0_IntMask                             [0:0]            get_MSPU_0_IntMask
''                                                             set_MSPU_0_IntMask
''                                                             read_MSPU_0_IntMask
''                                                             write_MSPU_0_IntMask
''---------------------------------------------------------------------------------
Class REGISTER_MACSECSYS_MISC_interrupt_mask
    Private write_MSPU_5_IntMask_value
    Private read_MSPU_5_IntMask_value
    Private flag_MSPU_5_IntMask
    Private write_MSPU_4_IntMask_value
    Private read_MSPU_4_IntMask_value
    Private flag_MSPU_4_IntMask
    Private write_MSPU_3_IntMask_value
    Private read_MSPU_3_IntMask_value
    Private flag_MSPU_3_IntMask
    Private write_MSPU_2_IntMask_value
    Private read_MSPU_2_IntMask_value
    Private flag_MSPU_2_IntMask
    Private write_MSPU_1_IntMask_value
    Private read_MSPU_1_IntMask_value
    Private flag_MSPU_1_IntMask
    Private write_MSPU_0_IntMask_value
    Private read_MSPU_0_IntMask_value
    Private flag_MSPU_0_IntMask

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

    Property Get get_MSPU_5_IntMask
        get_MSPU_5_IntMask = read_MSPU_5_IntMask_value
    End Property

    Property Let set_MSPU_5_IntMask(aData)
        write_MSPU_5_IntMask_value = aData
        flag_MSPU_5_IntMask        = &H1
    End Property

    Property Get read_MSPU_5_IntMask
        read
        read_MSPU_5_IntMask = read_MSPU_5_IntMask_value
    End Property

    Property Let write_MSPU_5_IntMask(aData)
        set_MSPU_5_IntMask = aData
        write
    End Property

    Property Get get_MSPU_4_IntMask
        get_MSPU_4_IntMask = read_MSPU_4_IntMask_value
    End Property

    Property Let set_MSPU_4_IntMask(aData)
        write_MSPU_4_IntMask_value = aData
        flag_MSPU_4_IntMask        = &H1
    End Property

    Property Get read_MSPU_4_IntMask
        read
        read_MSPU_4_IntMask = read_MSPU_4_IntMask_value
    End Property

    Property Let write_MSPU_4_IntMask(aData)
        set_MSPU_4_IntMask = aData
        write
    End Property

    Property Get get_MSPU_3_IntMask
        get_MSPU_3_IntMask = read_MSPU_3_IntMask_value
    End Property

    Property Let set_MSPU_3_IntMask(aData)
        write_MSPU_3_IntMask_value = aData
        flag_MSPU_3_IntMask        = &H1
    End Property

    Property Get read_MSPU_3_IntMask
        read
        read_MSPU_3_IntMask = read_MSPU_3_IntMask_value
    End Property

    Property Let write_MSPU_3_IntMask(aData)
        set_MSPU_3_IntMask = aData
        write
    End Property

    Property Get get_MSPU_2_IntMask
        get_MSPU_2_IntMask = read_MSPU_2_IntMask_value
    End Property

    Property Let set_MSPU_2_IntMask(aData)
        write_MSPU_2_IntMask_value = aData
        flag_MSPU_2_IntMask        = &H1
    End Property

    Property Get read_MSPU_2_IntMask
        read
        read_MSPU_2_IntMask = read_MSPU_2_IntMask_value
    End Property

    Property Let write_MSPU_2_IntMask(aData)
        set_MSPU_2_IntMask = aData
        write
    End Property

    Property Get get_MSPU_1_IntMask
        get_MSPU_1_IntMask = read_MSPU_1_IntMask_value
    End Property

    Property Let set_MSPU_1_IntMask(aData)
        write_MSPU_1_IntMask_value = aData
        flag_MSPU_1_IntMask        = &H1
    End Property

    Property Get read_MSPU_1_IntMask
        read
        read_MSPU_1_IntMask = read_MSPU_1_IntMask_value
    End Property

    Property Let write_MSPU_1_IntMask(aData)
        set_MSPU_1_IntMask = aData
        write
    End Property

    Property Get get_MSPU_0_IntMask
        get_MSPU_0_IntMask = read_MSPU_0_IntMask_value
    End Property

    Property Let set_MSPU_0_IntMask(aData)
        write_MSPU_0_IntMask_value = aData
        flag_MSPU_0_IntMask        = &H1
    End Property

    Property Get read_MSPU_0_IntMask
        read
        read_MSPU_0_IntMask = read_MSPU_0_IntMask_value
    End Property

    Property Let write_MSPU_0_IntMask(aData)
        set_MSPU_0_IntMask = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MSPU_5_IntMask_value = rightShift(data_low, 5) and &H1
        read_MSPU_4_IntMask_value = rightShift(data_low, 4) and &H1
        read_MSPU_3_IntMask_value = rightShift(data_low, 3) and &H1
        read_MSPU_2_IntMask_value = rightShift(data_low, 2) and &H1
        read_MSPU_1_IntMask_value = rightShift(data_low, 1) and &H1
        MSPU_0_IntMask_mask = &H1
        if data_low > LONG_MAX then
            if MSPU_0_IntMask_mask = mask then
                read_MSPU_0_IntMask_value = data_low
            else
                read_MSPU_0_IntMask_value = (data_low - H8000_0000) and MSPU_0_IntMask_mask
            end If
        else
            read_MSPU_0_IntMask_value = data_low and MSPU_0_IntMask_mask
        end If

    End Sub

    Sub write
        If flag_MSPU_5_IntMask = &H0 or flag_MSPU_4_IntMask = &H0 or flag_MSPU_3_IntMask = &H0 or flag_MSPU_2_IntMask = &H0 or flag_MSPU_1_IntMask = &H0 or flag_MSPU_0_IntMask = &H0 Then read
        If flag_MSPU_5_IntMask = &H0 Then write_MSPU_5_IntMask_value = get_MSPU_5_IntMask
        If flag_MSPU_4_IntMask = &H0 Then write_MSPU_4_IntMask_value = get_MSPU_4_IntMask
        If flag_MSPU_3_IntMask = &H0 Then write_MSPU_3_IntMask_value = get_MSPU_3_IntMask
        If flag_MSPU_2_IntMask = &H0 Then write_MSPU_2_IntMask_value = get_MSPU_2_IntMask
        If flag_MSPU_1_IntMask = &H0 Then write_MSPU_1_IntMask_value = get_MSPU_1_IntMask
        If flag_MSPU_0_IntMask = &H0 Then write_MSPU_0_IntMask_value = get_MSPU_0_IntMask

        regValue = leftShift((write_MSPU_5_IntMask_value and &H1), 5) + leftShift((write_MSPU_4_IntMask_value and &H1), 4) + leftShift((write_MSPU_3_IntMask_value and &H1), 3) + leftShift((write_MSPU_2_IntMask_value and &H1), 2) + leftShift((write_MSPU_1_IntMask_value and &H1), 1) + leftShift((write_MSPU_0_IntMask_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MSPU_5_IntMask_value = rightShift(data_low, 5) and &H1
        read_MSPU_4_IntMask_value = rightShift(data_low, 4) and &H1
        read_MSPU_3_IntMask_value = rightShift(data_low, 3) and &H1
        read_MSPU_2_IntMask_value = rightShift(data_low, 2) and &H1
        read_MSPU_1_IntMask_value = rightShift(data_low, 1) and &H1
        MSPU_0_IntMask_mask = &H1
        if data_low > LONG_MAX then
            if MSPU_0_IntMask_mask = mask then
                read_MSPU_0_IntMask_value = data_low
            else
                read_MSPU_0_IntMask_value = (data_low - H8000_0000) and MSPU_0_IntMask_mask
            end If
        else
            read_MSPU_0_IntMask_value = data_low and MSPU_0_IntMask_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSPU_5_IntMask_value = &H0
        flag_MSPU_5_IntMask        = &H0
        write_MSPU_4_IntMask_value = &H0
        flag_MSPU_4_IntMask        = &H0
        write_MSPU_3_IntMask_value = &H0
        flag_MSPU_3_IntMask        = &H0
        write_MSPU_2_IntMask_value = &H0
        flag_MSPU_2_IntMask        = &H0
        write_MSPU_1_IntMask_value = &H0
        flag_MSPU_1_IntMask        = &H0
        write_MSPU_0_IntMask_value = &H0
        flag_MSPU_0_IntMask        = &H0
    End Sub
End Class


'' @REGISTER : MACSECSYS_MISC_pktinflight_stat
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MSPU_5_PktInFlight_egress                  [13:13]          get_MSPU_5_PktInFlight_egress
''                                                             set_MSPU_5_PktInFlight_egress
''                                                             read_MSPU_5_PktInFlight_egress
''                                                             write_MSPU_5_PktInFlight_egress
''---------------------------------------------------------------------------------
'' MSPU_4_PktInFlight_egress                  [12:12]          get_MSPU_4_PktInFlight_egress
''                                                             set_MSPU_4_PktInFlight_egress
''                                                             read_MSPU_4_PktInFlight_egress
''                                                             write_MSPU_4_PktInFlight_egress
''---------------------------------------------------------------------------------
'' MSPU_3_PktInFlight_egress                  [11:11]          get_MSPU_3_PktInFlight_egress
''                                                             set_MSPU_3_PktInFlight_egress
''                                                             read_MSPU_3_PktInFlight_egress
''                                                             write_MSPU_3_PktInFlight_egress
''---------------------------------------------------------------------------------
'' MSPU_2_PktInFlight_egress                  [10:10]          get_MSPU_2_PktInFlight_egress
''                                                             set_MSPU_2_PktInFlight_egress
''                                                             read_MSPU_2_PktInFlight_egress
''                                                             write_MSPU_2_PktInFlight_egress
''---------------------------------------------------------------------------------
'' MSPU_1_PktInFlight_egress                  [9:9]            get_MSPU_1_PktInFlight_egress
''                                                             set_MSPU_1_PktInFlight_egress
''                                                             read_MSPU_1_PktInFlight_egress
''                                                             write_MSPU_1_PktInFlight_egress
''---------------------------------------------------------------------------------
'' MSPU_0_PktInFlight_egress                  [8:8]            get_MSPU_0_PktInFlight_egress
''                                                             set_MSPU_0_PktInFlight_egress
''                                                             read_MSPU_0_PktInFlight_egress
''                                                             write_MSPU_0_PktInFlight_egress
''---------------------------------------------------------------------------------
'' MSPU_5_PktInFlight_ingress                 [5:5]            get_MSPU_5_PktInFlight_ingress
''                                                             set_MSPU_5_PktInFlight_ingress
''                                                             read_MSPU_5_PktInFlight_ingress
''                                                             write_MSPU_5_PktInFlight_ingress
''---------------------------------------------------------------------------------
'' MSPU_4_PktInFlight_ingress                 [4:4]            get_MSPU_4_PktInFlight_ingress
''                                                             set_MSPU_4_PktInFlight_ingress
''                                                             read_MSPU_4_PktInFlight_ingress
''                                                             write_MSPU_4_PktInFlight_ingress
''---------------------------------------------------------------------------------
'' MSPU_3_PktInFlight_ingress                 [3:3]            get_MSPU_3_PktInFlight_ingress
''                                                             set_MSPU_3_PktInFlight_ingress
''                                                             read_MSPU_3_PktInFlight_ingress
''                                                             write_MSPU_3_PktInFlight_ingress
''---------------------------------------------------------------------------------
'' MSPU_2_PktInFlight_ingress                 [2:2]            get_MSPU_2_PktInFlight_ingress
''                                                             set_MSPU_2_PktInFlight_ingress
''                                                             read_MSPU_2_PktInFlight_ingress
''                                                             write_MSPU_2_PktInFlight_ingress
''---------------------------------------------------------------------------------
'' MSPU_1_PktInFlight_ingress                 [1:1]            get_MSPU_1_PktInFlight_ingress
''                                                             set_MSPU_1_PktInFlight_ingress
''                                                             read_MSPU_1_PktInFlight_ingress
''                                                             write_MSPU_1_PktInFlight_ingress
''---------------------------------------------------------------------------------
'' MSPU_0_PktInFlight_ingress                 [0:0]            get_MSPU_0_PktInFlight_ingress
''                                                             set_MSPU_0_PktInFlight_ingress
''                                                             read_MSPU_0_PktInFlight_ingress
''                                                             write_MSPU_0_PktInFlight_ingress
''---------------------------------------------------------------------------------
Class REGISTER_MACSECSYS_MISC_pktinflight_stat
    Private write_MSPU_5_PktInFlight_egress_value
    Private read_MSPU_5_PktInFlight_egress_value
    Private flag_MSPU_5_PktInFlight_egress
    Private write_MSPU_4_PktInFlight_egress_value
    Private read_MSPU_4_PktInFlight_egress_value
    Private flag_MSPU_4_PktInFlight_egress
    Private write_MSPU_3_PktInFlight_egress_value
    Private read_MSPU_3_PktInFlight_egress_value
    Private flag_MSPU_3_PktInFlight_egress
    Private write_MSPU_2_PktInFlight_egress_value
    Private read_MSPU_2_PktInFlight_egress_value
    Private flag_MSPU_2_PktInFlight_egress
    Private write_MSPU_1_PktInFlight_egress_value
    Private read_MSPU_1_PktInFlight_egress_value
    Private flag_MSPU_1_PktInFlight_egress
    Private write_MSPU_0_PktInFlight_egress_value
    Private read_MSPU_0_PktInFlight_egress_value
    Private flag_MSPU_0_PktInFlight_egress
    Private write_MSPU_5_PktInFlight_ingress_value
    Private read_MSPU_5_PktInFlight_ingress_value
    Private flag_MSPU_5_PktInFlight_ingress
    Private write_MSPU_4_PktInFlight_ingress_value
    Private read_MSPU_4_PktInFlight_ingress_value
    Private flag_MSPU_4_PktInFlight_ingress
    Private write_MSPU_3_PktInFlight_ingress_value
    Private read_MSPU_3_PktInFlight_ingress_value
    Private flag_MSPU_3_PktInFlight_ingress
    Private write_MSPU_2_PktInFlight_ingress_value
    Private read_MSPU_2_PktInFlight_ingress_value
    Private flag_MSPU_2_PktInFlight_ingress
    Private write_MSPU_1_PktInFlight_ingress_value
    Private read_MSPU_1_PktInFlight_ingress_value
    Private flag_MSPU_1_PktInFlight_ingress
    Private write_MSPU_0_PktInFlight_ingress_value
    Private read_MSPU_0_PktInFlight_ingress_value
    Private flag_MSPU_0_PktInFlight_ingress

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

    Property Get get_MSPU_5_PktInFlight_egress
        get_MSPU_5_PktInFlight_egress = read_MSPU_5_PktInFlight_egress_value
    End Property

    Property Let set_MSPU_5_PktInFlight_egress(aData)
        write_MSPU_5_PktInFlight_egress_value = aData
        flag_MSPU_5_PktInFlight_egress        = &H1
    End Property

    Property Get read_MSPU_5_PktInFlight_egress
        read
        read_MSPU_5_PktInFlight_egress = read_MSPU_5_PktInFlight_egress_value
    End Property

    Property Let write_MSPU_5_PktInFlight_egress(aData)
        set_MSPU_5_PktInFlight_egress = aData
        write
    End Property

    Property Get get_MSPU_4_PktInFlight_egress
        get_MSPU_4_PktInFlight_egress = read_MSPU_4_PktInFlight_egress_value
    End Property

    Property Let set_MSPU_4_PktInFlight_egress(aData)
        write_MSPU_4_PktInFlight_egress_value = aData
        flag_MSPU_4_PktInFlight_egress        = &H1
    End Property

    Property Get read_MSPU_4_PktInFlight_egress
        read
        read_MSPU_4_PktInFlight_egress = read_MSPU_4_PktInFlight_egress_value
    End Property

    Property Let write_MSPU_4_PktInFlight_egress(aData)
        set_MSPU_4_PktInFlight_egress = aData
        write
    End Property

    Property Get get_MSPU_3_PktInFlight_egress
        get_MSPU_3_PktInFlight_egress = read_MSPU_3_PktInFlight_egress_value
    End Property

    Property Let set_MSPU_3_PktInFlight_egress(aData)
        write_MSPU_3_PktInFlight_egress_value = aData
        flag_MSPU_3_PktInFlight_egress        = &H1
    End Property

    Property Get read_MSPU_3_PktInFlight_egress
        read
        read_MSPU_3_PktInFlight_egress = read_MSPU_3_PktInFlight_egress_value
    End Property

    Property Let write_MSPU_3_PktInFlight_egress(aData)
        set_MSPU_3_PktInFlight_egress = aData
        write
    End Property

    Property Get get_MSPU_2_PktInFlight_egress
        get_MSPU_2_PktInFlight_egress = read_MSPU_2_PktInFlight_egress_value
    End Property

    Property Let set_MSPU_2_PktInFlight_egress(aData)
        write_MSPU_2_PktInFlight_egress_value = aData
        flag_MSPU_2_PktInFlight_egress        = &H1
    End Property

    Property Get read_MSPU_2_PktInFlight_egress
        read
        read_MSPU_2_PktInFlight_egress = read_MSPU_2_PktInFlight_egress_value
    End Property

    Property Let write_MSPU_2_PktInFlight_egress(aData)
        set_MSPU_2_PktInFlight_egress = aData
        write
    End Property

    Property Get get_MSPU_1_PktInFlight_egress
        get_MSPU_1_PktInFlight_egress = read_MSPU_1_PktInFlight_egress_value
    End Property

    Property Let set_MSPU_1_PktInFlight_egress(aData)
        write_MSPU_1_PktInFlight_egress_value = aData
        flag_MSPU_1_PktInFlight_egress        = &H1
    End Property

    Property Get read_MSPU_1_PktInFlight_egress
        read
        read_MSPU_1_PktInFlight_egress = read_MSPU_1_PktInFlight_egress_value
    End Property

    Property Let write_MSPU_1_PktInFlight_egress(aData)
        set_MSPU_1_PktInFlight_egress = aData
        write
    End Property

    Property Get get_MSPU_0_PktInFlight_egress
        get_MSPU_0_PktInFlight_egress = read_MSPU_0_PktInFlight_egress_value
    End Property

    Property Let set_MSPU_0_PktInFlight_egress(aData)
        write_MSPU_0_PktInFlight_egress_value = aData
        flag_MSPU_0_PktInFlight_egress        = &H1
    End Property

    Property Get read_MSPU_0_PktInFlight_egress
        read
        read_MSPU_0_PktInFlight_egress = read_MSPU_0_PktInFlight_egress_value
    End Property

    Property Let write_MSPU_0_PktInFlight_egress(aData)
        set_MSPU_0_PktInFlight_egress = aData
        write
    End Property

    Property Get get_MSPU_5_PktInFlight_ingress
        get_MSPU_5_PktInFlight_ingress = read_MSPU_5_PktInFlight_ingress_value
    End Property

    Property Let set_MSPU_5_PktInFlight_ingress(aData)
        write_MSPU_5_PktInFlight_ingress_value = aData
        flag_MSPU_5_PktInFlight_ingress        = &H1
    End Property

    Property Get read_MSPU_5_PktInFlight_ingress
        read
        read_MSPU_5_PktInFlight_ingress = read_MSPU_5_PktInFlight_ingress_value
    End Property

    Property Let write_MSPU_5_PktInFlight_ingress(aData)
        set_MSPU_5_PktInFlight_ingress = aData
        write
    End Property

    Property Get get_MSPU_4_PktInFlight_ingress
        get_MSPU_4_PktInFlight_ingress = read_MSPU_4_PktInFlight_ingress_value
    End Property

    Property Let set_MSPU_4_PktInFlight_ingress(aData)
        write_MSPU_4_PktInFlight_ingress_value = aData
        flag_MSPU_4_PktInFlight_ingress        = &H1
    End Property

    Property Get read_MSPU_4_PktInFlight_ingress
        read
        read_MSPU_4_PktInFlight_ingress = read_MSPU_4_PktInFlight_ingress_value
    End Property

    Property Let write_MSPU_4_PktInFlight_ingress(aData)
        set_MSPU_4_PktInFlight_ingress = aData
        write
    End Property

    Property Get get_MSPU_3_PktInFlight_ingress
        get_MSPU_3_PktInFlight_ingress = read_MSPU_3_PktInFlight_ingress_value
    End Property

    Property Let set_MSPU_3_PktInFlight_ingress(aData)
        write_MSPU_3_PktInFlight_ingress_value = aData
        flag_MSPU_3_PktInFlight_ingress        = &H1
    End Property

    Property Get read_MSPU_3_PktInFlight_ingress
        read
        read_MSPU_3_PktInFlight_ingress = read_MSPU_3_PktInFlight_ingress_value
    End Property

    Property Let write_MSPU_3_PktInFlight_ingress(aData)
        set_MSPU_3_PktInFlight_ingress = aData
        write
    End Property

    Property Get get_MSPU_2_PktInFlight_ingress
        get_MSPU_2_PktInFlight_ingress = read_MSPU_2_PktInFlight_ingress_value
    End Property

    Property Let set_MSPU_2_PktInFlight_ingress(aData)
        write_MSPU_2_PktInFlight_ingress_value = aData
        flag_MSPU_2_PktInFlight_ingress        = &H1
    End Property

    Property Get read_MSPU_2_PktInFlight_ingress
        read
        read_MSPU_2_PktInFlight_ingress = read_MSPU_2_PktInFlight_ingress_value
    End Property

    Property Let write_MSPU_2_PktInFlight_ingress(aData)
        set_MSPU_2_PktInFlight_ingress = aData
        write
    End Property

    Property Get get_MSPU_1_PktInFlight_ingress
        get_MSPU_1_PktInFlight_ingress = read_MSPU_1_PktInFlight_ingress_value
    End Property

    Property Let set_MSPU_1_PktInFlight_ingress(aData)
        write_MSPU_1_PktInFlight_ingress_value = aData
        flag_MSPU_1_PktInFlight_ingress        = &H1
    End Property

    Property Get read_MSPU_1_PktInFlight_ingress
        read
        read_MSPU_1_PktInFlight_ingress = read_MSPU_1_PktInFlight_ingress_value
    End Property

    Property Let write_MSPU_1_PktInFlight_ingress(aData)
        set_MSPU_1_PktInFlight_ingress = aData
        write
    End Property

    Property Get get_MSPU_0_PktInFlight_ingress
        get_MSPU_0_PktInFlight_ingress = read_MSPU_0_PktInFlight_ingress_value
    End Property

    Property Let set_MSPU_0_PktInFlight_ingress(aData)
        write_MSPU_0_PktInFlight_ingress_value = aData
        flag_MSPU_0_PktInFlight_ingress        = &H1
    End Property

    Property Get read_MSPU_0_PktInFlight_ingress
        read
        read_MSPU_0_PktInFlight_ingress = read_MSPU_0_PktInFlight_ingress_value
    End Property

    Property Let write_MSPU_0_PktInFlight_ingress(aData)
        set_MSPU_0_PktInFlight_ingress = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MSPU_5_PktInFlight_egress_value = rightShift(data_low, 13) and &H1
        read_MSPU_4_PktInFlight_egress_value = rightShift(data_low, 12) and &H1
        read_MSPU_3_PktInFlight_egress_value = rightShift(data_low, 11) and &H1
        read_MSPU_2_PktInFlight_egress_value = rightShift(data_low, 10) and &H1
        read_MSPU_1_PktInFlight_egress_value = rightShift(data_low, 9) and &H1
        read_MSPU_0_PktInFlight_egress_value = rightShift(data_low, 8) and &H1
        read_MSPU_5_PktInFlight_ingress_value = rightShift(data_low, 5) and &H1
        read_MSPU_4_PktInFlight_ingress_value = rightShift(data_low, 4) and &H1
        read_MSPU_3_PktInFlight_ingress_value = rightShift(data_low, 3) and &H1
        read_MSPU_2_PktInFlight_ingress_value = rightShift(data_low, 2) and &H1
        read_MSPU_1_PktInFlight_ingress_value = rightShift(data_low, 1) and &H1
        MSPU_0_PktInFlight_ingress_mask = &H1
        if data_low > LONG_MAX then
            if MSPU_0_PktInFlight_ingress_mask = mask then
                read_MSPU_0_PktInFlight_ingress_value = data_low
            else
                read_MSPU_0_PktInFlight_ingress_value = (data_low - H8000_0000) and MSPU_0_PktInFlight_ingress_mask
            end If
        else
            read_MSPU_0_PktInFlight_ingress_value = data_low and MSPU_0_PktInFlight_ingress_mask
        end If

    End Sub

    Sub write
        If flag_MSPU_5_PktInFlight_egress = &H0 or flag_MSPU_4_PktInFlight_egress = &H0 or flag_MSPU_3_PktInFlight_egress = &H0 or flag_MSPU_2_PktInFlight_egress = &H0 or flag_MSPU_1_PktInFlight_egress = &H0 or flag_MSPU_0_PktInFlight_egress = &H0 or flag_MSPU_5_PktInFlight_ingress = &H0 or flag_MSPU_4_PktInFlight_ingress = &H0 or flag_MSPU_3_PktInFlight_ingress = &H0 or flag_MSPU_2_PktInFlight_ingress = &H0 or flag_MSPU_1_PktInFlight_ingress = &H0 or flag_MSPU_0_PktInFlight_ingress = &H0 Then read
        If flag_MSPU_5_PktInFlight_egress = &H0 Then write_MSPU_5_PktInFlight_egress_value = get_MSPU_5_PktInFlight_egress
        If flag_MSPU_4_PktInFlight_egress = &H0 Then write_MSPU_4_PktInFlight_egress_value = get_MSPU_4_PktInFlight_egress
        If flag_MSPU_3_PktInFlight_egress = &H0 Then write_MSPU_3_PktInFlight_egress_value = get_MSPU_3_PktInFlight_egress
        If flag_MSPU_2_PktInFlight_egress = &H0 Then write_MSPU_2_PktInFlight_egress_value = get_MSPU_2_PktInFlight_egress
        If flag_MSPU_1_PktInFlight_egress = &H0 Then write_MSPU_1_PktInFlight_egress_value = get_MSPU_1_PktInFlight_egress
        If flag_MSPU_0_PktInFlight_egress = &H0 Then write_MSPU_0_PktInFlight_egress_value = get_MSPU_0_PktInFlight_egress
        If flag_MSPU_5_PktInFlight_ingress = &H0 Then write_MSPU_5_PktInFlight_ingress_value = get_MSPU_5_PktInFlight_ingress
        If flag_MSPU_4_PktInFlight_ingress = &H0 Then write_MSPU_4_PktInFlight_ingress_value = get_MSPU_4_PktInFlight_ingress
        If flag_MSPU_3_PktInFlight_ingress = &H0 Then write_MSPU_3_PktInFlight_ingress_value = get_MSPU_3_PktInFlight_ingress
        If flag_MSPU_2_PktInFlight_ingress = &H0 Then write_MSPU_2_PktInFlight_ingress_value = get_MSPU_2_PktInFlight_ingress
        If flag_MSPU_1_PktInFlight_ingress = &H0 Then write_MSPU_1_PktInFlight_ingress_value = get_MSPU_1_PktInFlight_ingress
        If flag_MSPU_0_PktInFlight_ingress = &H0 Then write_MSPU_0_PktInFlight_ingress_value = get_MSPU_0_PktInFlight_ingress

        regValue = leftShift((write_MSPU_5_PktInFlight_egress_value and &H1), 13) + leftShift((write_MSPU_4_PktInFlight_egress_value and &H1), 12) + leftShift((write_MSPU_3_PktInFlight_egress_value and &H1), 11) + leftShift((write_MSPU_2_PktInFlight_egress_value and &H1), 10) + leftShift((write_MSPU_1_PktInFlight_egress_value and &H1), 9) + leftShift((write_MSPU_0_PktInFlight_egress_value and &H1), 8) + leftShift((write_MSPU_5_PktInFlight_ingress_value and &H1), 5) + leftShift((write_MSPU_4_PktInFlight_ingress_value and &H1), 4) + leftShift((write_MSPU_3_PktInFlight_ingress_value and &H1), 3) + leftShift((write_MSPU_2_PktInFlight_ingress_value and &H1), 2) + leftShift((write_MSPU_1_PktInFlight_ingress_value and &H1), 1) + leftShift((write_MSPU_0_PktInFlight_ingress_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MSPU_5_PktInFlight_egress_value = rightShift(data_low, 13) and &H1
        read_MSPU_4_PktInFlight_egress_value = rightShift(data_low, 12) and &H1
        read_MSPU_3_PktInFlight_egress_value = rightShift(data_low, 11) and &H1
        read_MSPU_2_PktInFlight_egress_value = rightShift(data_low, 10) and &H1
        read_MSPU_1_PktInFlight_egress_value = rightShift(data_low, 9) and &H1
        read_MSPU_0_PktInFlight_egress_value = rightShift(data_low, 8) and &H1
        read_MSPU_5_PktInFlight_ingress_value = rightShift(data_low, 5) and &H1
        read_MSPU_4_PktInFlight_ingress_value = rightShift(data_low, 4) and &H1
        read_MSPU_3_PktInFlight_ingress_value = rightShift(data_low, 3) and &H1
        read_MSPU_2_PktInFlight_ingress_value = rightShift(data_low, 2) and &H1
        read_MSPU_1_PktInFlight_ingress_value = rightShift(data_low, 1) and &H1
        MSPU_0_PktInFlight_ingress_mask = &H1
        if data_low > LONG_MAX then
            if MSPU_0_PktInFlight_ingress_mask = mask then
                read_MSPU_0_PktInFlight_ingress_value = data_low
            else
                read_MSPU_0_PktInFlight_ingress_value = (data_low - H8000_0000) and MSPU_0_PktInFlight_ingress_mask
            end If
        else
            read_MSPU_0_PktInFlight_ingress_value = data_low and MSPU_0_PktInFlight_ingress_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MSPU_5_PktInFlight_egress_value = &H0
        flag_MSPU_5_PktInFlight_egress        = &H0
        write_MSPU_4_PktInFlight_egress_value = &H0
        flag_MSPU_4_PktInFlight_egress        = &H0
        write_MSPU_3_PktInFlight_egress_value = &H0
        flag_MSPU_3_PktInFlight_egress        = &H0
        write_MSPU_2_PktInFlight_egress_value = &H0
        flag_MSPU_2_PktInFlight_egress        = &H0
        write_MSPU_1_PktInFlight_egress_value = &H0
        flag_MSPU_1_PktInFlight_egress        = &H0
        write_MSPU_0_PktInFlight_egress_value = &H0
        flag_MSPU_0_PktInFlight_egress        = &H0
        write_MSPU_5_PktInFlight_ingress_value = &H0
        flag_MSPU_5_PktInFlight_ingress        = &H0
        write_MSPU_4_PktInFlight_ingress_value = &H0
        flag_MSPU_4_PktInFlight_ingress        = &H0
        write_MSPU_3_PktInFlight_ingress_value = &H0
        flag_MSPU_3_PktInFlight_ingress        = &H0
        write_MSPU_2_PktInFlight_ingress_value = &H0
        flag_MSPU_2_PktInFlight_ingress        = &H0
        write_MSPU_1_PktInFlight_ingress_value = &H0
        flag_MSPU_1_PktInFlight_ingress        = &H0
        write_MSPU_0_PktInFlight_ingress_value = &H0
        flag_MSPU_0_PktInFlight_ingress        = &H0
    End Sub
End Class


'' @REGISTER : MACSECSYS_MISC_spare_reg
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Spare_Reg                                  [31:0]           get_Spare_Reg
''                                                             set_Spare_Reg
''                                                             read_Spare_Reg
''                                                             write_Spare_Reg
''---------------------------------------------------------------------------------
Class REGISTER_MACSECSYS_MISC_spare_reg
    Private write_Spare_Reg_value
    Private read_Spare_Reg_value
    Private flag_Spare_Reg

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hfc
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_Spare_Reg
        get_Spare_Reg = read_Spare_Reg_value
    End Property

    Property Let set_Spare_Reg(aData)
        write_Spare_Reg_value = aData
        flag_Spare_Reg        = &H1
    End Property

    Property Get read_Spare_Reg
        read
        read_Spare_Reg = read_Spare_Reg_value
    End Property

    Property Let write_Spare_Reg(aData)
        set_Spare_Reg = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Spare_Reg_mask = &Hffffffff
        if data_low > LONG_MAX then
            if Spare_Reg_mask = mask then
                read_Spare_Reg_value = data_low
            else
                read_Spare_Reg_value = (data_low - H8000_0000) and Spare_Reg_mask
            end If
        else
            read_Spare_Reg_value = data_low and Spare_Reg_mask
        end If

    End Sub

    Sub write
        If flag_Spare_Reg = &H0 Then read
        If flag_Spare_Reg = &H0 Then write_Spare_Reg_value = get_Spare_Reg

        regValue = leftShift(write_Spare_Reg_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Spare_Reg_mask = &Hffffffff
        if data_low > LONG_MAX then
            if Spare_Reg_mask = mask then
                read_Spare_Reg_value = data_low
            else
                read_Spare_Reg_value = (data_low - H8000_0000) and Spare_Reg_mask
            end If
        else
            read_Spare_Reg_value = data_low and Spare_Reg_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Spare_Reg_value = &H0
        flag_Spare_Reg        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class MACSECSYS_MISC_INSTANCE

    Public mspu_ctrl
    Public testmode_ctrl
    Public probesel_ctrl
    Public interrupt_stat
    Public interrupt_mask
    Public pktinflight_stat
    Public spare_reg


    Public default function Init(aBaseAddr)
        Set mspu_ctrl = (New REGISTER_MACSECSYS_MISC_mspu_ctrl)(aBaseAddr, 32)
        Set testmode_ctrl = (New REGISTER_MACSECSYS_MISC_testmode_ctrl)(aBaseAddr, 32)
        Set probesel_ctrl = (New REGISTER_MACSECSYS_MISC_probesel_ctrl)(aBaseAddr, 32)
        Set interrupt_stat = (New REGISTER_MACSECSYS_MISC_interrupt_stat)(aBaseAddr, 32)
        Set interrupt_mask = (New REGISTER_MACSECSYS_MISC_interrupt_mask)(aBaseAddr, 32)
        Set pktinflight_stat = (New REGISTER_MACSECSYS_MISC_pktinflight_stat)(aBaseAddr, 32)
        Set spare_reg = (New REGISTER_MACSECSYS_MISC_spare_reg)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set MACSECSYS_MISC = CreateObject("System.Collections.ArrayList")
MACSECSYS_MISC.Add ((New MACSECSYS_MISC_INSTANCE)(&H4dff0000))


