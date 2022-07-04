

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


'' @REGISTER : MMI_mmi_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' byp                                        [10:10]          get_byp
''                                                             set_byp
''                                                             read_byp
''                                                             write_byp
''---------------------------------------------------------------------------------
'' ext                                        [9:9]            get_ext
''                                                             set_ext
''                                                             read_ext
''                                                             write_ext
''---------------------------------------------------------------------------------
'' bsy                                        [8:8]            get_bsy
''                                                             set_bsy
''                                                             read_bsy
''                                                             write_bsy
''---------------------------------------------------------------------------------
'' pre                                        [7:7]            get_pre
''                                                             set_pre
''                                                             read_pre
''                                                             write_pre
''---------------------------------------------------------------------------------
'' mdcdiv                                     [6:0]            get_mdcdiv
''                                                             set_mdcdiv
''                                                             read_mdcdiv
''                                                             write_mdcdiv
''---------------------------------------------------------------------------------
Class REGISTER_MMI_mmi_ctrl
    Private write_byp_value
    Private read_byp_value
    Private flag_byp
    Private write_ext_value
    Private read_ext_value
    Private flag_ext
    Private write_bsy_value
    Private read_bsy_value
    Private flag_bsy
    Private write_pre_value
    Private read_pre_value
    Private flag_pre
    Private write_mdcdiv_value
    Private read_mdcdiv_value
    Private flag_mdcdiv

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

    Property Get get_byp
        get_byp = read_byp_value
    End Property

    Property Let set_byp(aData)
        write_byp_value = aData
        flag_byp        = &H1
    End Property

    Property Get read_byp
        read
        read_byp = read_byp_value
    End Property

    Property Let write_byp(aData)
        set_byp = aData
        write
    End Property

    Property Get get_ext
        get_ext = read_ext_value
    End Property

    Property Let set_ext(aData)
        write_ext_value = aData
        flag_ext        = &H1
    End Property

    Property Get read_ext
        read
        read_ext = read_ext_value
    End Property

    Property Let write_ext(aData)
        set_ext = aData
        write
    End Property

    Property Get get_bsy
        get_bsy = read_bsy_value
    End Property

    Property Let set_bsy(aData)
        write_bsy_value = aData
        flag_bsy        = &H1
    End Property

    Property Get read_bsy
        read
        read_bsy = read_bsy_value
    End Property

    Property Let write_bsy(aData)
        set_bsy = aData
        write
    End Property

    Property Get get_pre
        get_pre = read_pre_value
    End Property

    Property Let set_pre(aData)
        write_pre_value = aData
        flag_pre        = &H1
    End Property

    Property Get read_pre
        read
        read_pre = read_pre_value
    End Property

    Property Let write_pre(aData)
        set_pre = aData
        write
    End Property

    Property Get get_mdcdiv
        get_mdcdiv = read_mdcdiv_value
    End Property

    Property Let set_mdcdiv(aData)
        write_mdcdiv_value = aData
        flag_mdcdiv        = &H1
    End Property

    Property Get read_mdcdiv
        read
        read_mdcdiv = read_mdcdiv_value
    End Property

    Property Let write_mdcdiv(aData)
        set_mdcdiv = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_byp_value = rightShift(data_low, 10) and &H1
        read_ext_value = rightShift(data_low, 9) and &H1
        read_bsy_value = rightShift(data_low, 8) and &H1
        read_pre_value = rightShift(data_low, 7) and &H1
        mdcdiv_mask = &H7f
        if data_low > LONG_MAX then
            if mdcdiv_mask = mask then
                read_mdcdiv_value = data_low
            else
                read_mdcdiv_value = (data_low - H8000_0000) and mdcdiv_mask
            end If
        else
            read_mdcdiv_value = data_low and mdcdiv_mask
        end If

    End Sub

    Sub write
        If flag_byp = &H0 or flag_ext = &H0 or flag_bsy = &H0 or flag_pre = &H0 or flag_mdcdiv = &H0 Then read
        If flag_byp = &H0 Then write_byp_value = get_byp
        If flag_ext = &H0 Then write_ext_value = get_ext
        If flag_bsy = &H0 Then write_bsy_value = get_bsy
        If flag_pre = &H0 Then write_pre_value = get_pre
        If flag_mdcdiv = &H0 Then write_mdcdiv_value = get_mdcdiv

        regValue = leftShift((write_byp_value and &H1), 10) + leftShift((write_ext_value and &H1), 9) + leftShift((write_bsy_value and &H1), 8) + leftShift((write_pre_value and &H1), 7) + leftShift((write_mdcdiv_value and &H7f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_byp_value = rightShift(data_low, 10) and &H1
        read_ext_value = rightShift(data_low, 9) and &H1
        read_bsy_value = rightShift(data_low, 8) and &H1
        read_pre_value = rightShift(data_low, 7) and &H1
        mdcdiv_mask = &H7f
        if data_low > LONG_MAX then
            if mdcdiv_mask = mask then
                read_mdcdiv_value = data_low
            else
                read_mdcdiv_value = (data_low - H8000_0000) and mdcdiv_mask
            end If
        else
            read_mdcdiv_value = data_low and mdcdiv_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_byp_value = &H0
        flag_byp        = &H0
        write_ext_value = &H0
        flag_ext        = &H0
        write_bsy_value = &H0
        flag_bsy        = &H0
        write_pre_value = &H0
        flag_pre        = &H0
        write_mdcdiv_value = &H0
        flag_mdcdiv        = &H0
    End Sub
End Class


'' @REGISTER : MMI_mmi_cmd
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' sb                                         [31:30]          get_sb
''                                                             set_sb
''                                                             read_sb
''                                                             write_sb
''---------------------------------------------------------------------------------
'' op                                         [29:28]          get_op
''                                                             set_op
''                                                             read_op
''                                                             write_op
''---------------------------------------------------------------------------------
'' pa                                         [27:23]          get_pa
''                                                             set_pa
''                                                             read_pa
''                                                             write_pa
''---------------------------------------------------------------------------------
'' ra                                         [22:18]          get_ra
''                                                             set_ra
''                                                             read_ra
''                                                             write_ra
''---------------------------------------------------------------------------------
'' ta                                         [17:16]          get_ta
''                                                             set_ta
''                                                             read_ta
''                                                             write_ta
''---------------------------------------------------------------------------------
'' mdata                                      [15:0]           get_mdata
''                                                             set_mdata
''                                                             read_mdata
''                                                             write_mdata
''---------------------------------------------------------------------------------
Class REGISTER_MMI_mmi_cmd
    Private write_sb_value
    Private read_sb_value
    Private flag_sb
    Private write_op_value
    Private read_op_value
    Private flag_op
    Private write_pa_value
    Private read_pa_value
    Private flag_pa
    Private write_ra_value
    Private read_ra_value
    Private flag_ra
    Private write_ta_value
    Private read_ta_value
    Private flag_ta
    Private write_mdata_value
    Private read_mdata_value
    Private flag_mdata

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

    Property Get get_sb
        get_sb = read_sb_value
    End Property

    Property Let set_sb(aData)
        write_sb_value = aData
        flag_sb        = &H1
    End Property

    Property Get read_sb
        read
        read_sb = read_sb_value
    End Property

    Property Let write_sb(aData)
        set_sb = aData
        write
    End Property

    Property Get get_op
        get_op = read_op_value
    End Property

    Property Let set_op(aData)
        write_op_value = aData
        flag_op        = &H1
    End Property

    Property Get read_op
        read
        read_op = read_op_value
    End Property

    Property Let write_op(aData)
        set_op = aData
        write
    End Property

    Property Get get_pa
        get_pa = read_pa_value
    End Property

    Property Let set_pa(aData)
        write_pa_value = aData
        flag_pa        = &H1
    End Property

    Property Get read_pa
        read
        read_pa = read_pa_value
    End Property

    Property Let write_pa(aData)
        set_pa = aData
        write
    End Property

    Property Get get_ra
        get_ra = read_ra_value
    End Property

    Property Let set_ra(aData)
        write_ra_value = aData
        flag_ra        = &H1
    End Property

    Property Get read_ra
        read
        read_ra = read_ra_value
    End Property

    Property Let write_ra(aData)
        set_ra = aData
        write
    End Property

    Property Get get_ta
        get_ta = read_ta_value
    End Property

    Property Let set_ta(aData)
        write_ta_value = aData
        flag_ta        = &H1
    End Property

    Property Get read_ta
        read
        read_ta = read_ta_value
    End Property

    Property Let write_ta(aData)
        set_ta = aData
        write
    End Property

    Property Get get_mdata
        get_mdata = read_mdata_value
    End Property

    Property Let set_mdata(aData)
        write_mdata_value = aData
        flag_mdata        = &H1
    End Property

    Property Get read_mdata
        read
        read_mdata = read_mdata_value
    End Property

    Property Let write_mdata(aData)
        set_mdata = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_sb_value = rightShift(data_low, 30) and &H3
        read_op_value = rightShift(data_low, 28) and &H3
        read_pa_value = rightShift(data_low, 23) and &H1f
        read_ra_value = rightShift(data_low, 18) and &H1f
        read_ta_value = rightShift(data_low, 16) and &H3
        mdata_mask = &Hffff
        if data_low > LONG_MAX then
            if mdata_mask = mask then
                read_mdata_value = data_low
            else
                read_mdata_value = (data_low - H8000_0000) and mdata_mask
            end If
        else
            read_mdata_value = data_low and mdata_mask
        end If

    End Sub

    Sub write
        If flag_sb = &H0 or flag_op = &H0 or flag_pa = &H0 or flag_ra = &H0 or flag_ta = &H0 or flag_mdata = &H0 Then read
        If flag_sb = &H0 Then write_sb_value = get_sb
        If flag_op = &H0 Then write_op_value = get_op
        If flag_pa = &H0 Then write_pa_value = get_pa
        If flag_ra = &H0 Then write_ra_value = get_ra
        If flag_ta = &H0 Then write_ta_value = get_ta
        If flag_mdata = &H0 Then write_mdata_value = get_mdata

        regValue = leftShift((write_sb_value and &H3), 30) + leftShift((write_op_value and &H3), 28) + leftShift((write_pa_value and &H1f), 23) + leftShift((write_ra_value and &H1f), 18) + leftShift((write_ta_value and &H3), 16) + leftShift((write_mdata_value and &Hffff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_sb_value = rightShift(data_low, 30) and &H3
        read_op_value = rightShift(data_low, 28) and &H3
        read_pa_value = rightShift(data_low, 23) and &H1f
        read_ra_value = rightShift(data_low, 18) and &H1f
        read_ta_value = rightShift(data_low, 16) and &H3
        mdata_mask = &Hffff
        if data_low > LONG_MAX then
            if mdata_mask = mask then
                read_mdata_value = data_low
            else
                read_mdata_value = (data_low - H8000_0000) and mdata_mask
            end If
        else
            read_mdata_value = data_low and mdata_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_sb_value = &H0
        flag_sb        = &H0
        write_op_value = &H0
        flag_op        = &H0
        write_pa_value = &H0
        flag_pa        = &H0
        write_ra_value = &H0
        flag_ra        = &H0
        write_ta_value = &H0
        flag_ta        = &H0
        write_mdata_value = &H0
        flag_mdata        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class MMI_INSTANCE

    Public mmi_ctrl
    Public mmi_cmd


    Public default function Init(aBaseAddr)
        Set mmi_ctrl = (New REGISTER_MMI_mmi_ctrl)(aBaseAddr, 32)
        Set mmi_cmd = (New REGISTER_MMI_mmi_cmd)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set MMI = CreateObject("System.Collections.ArrayList")
MMI.Add ((New MMI_INSTANCE)(&H4014d000))
MMI.Add ((New MMI_INSTANCE)(&H4014d400))
MMI.Add ((New MMI_INSTANCE)(&H4014d800))


