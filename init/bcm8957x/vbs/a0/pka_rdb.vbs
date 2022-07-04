

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


'' @REGISTER : PKA_ctrl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' unknop                                     [31:31]          get_unknop
''                                                             set_unknop
''                                                             read_unknop
''                                                             write_unknop
''---------------------------------------------------------------------------------
'' invsrc0                                    [30:30]          get_invsrc0
''                                                             set_invsrc0
''                                                             read_invsrc0
''                                                             write_invsrc0
''---------------------------------------------------------------------------------
'' invsrc1                                    [29:29]          get_invsrc1
''                                                             set_invsrc1
''                                                             read_invsrc1
''                                                             write_invsrc1
''---------------------------------------------------------------------------------
'' invsrc2                                    [28:28]          get_invsrc2
''                                                             set_invsrc2
''                                                             read_invsrc2
''                                                             write_invsrc2
''---------------------------------------------------------------------------------
'' camfull                                    [27:27]          get_camfull
''                                                             set_camfull
''                                                             read_camfull
''                                                             write_camfull
''---------------------------------------------------------------------------------
'' div0                                       [26:26]          get_div0
''                                                             set_div0
''                                                             read_div0
''                                                             write_div0
''---------------------------------------------------------------------------------
'' opqof                                      [25:25]          get_opqof
''                                                             set_opqof
''                                                             read_opqof
''                                                             write_opqof
''---------------------------------------------------------------------------------
'' opcidx                                     [24:20]          get_opcidx
''                                                             set_opcidx
''                                                             read_opcidx
''                                                             write_opcidx
''---------------------------------------------------------------------------------
'' esc                                        [19:16]          get_esc
''                                                             set_esc
''                                                             read_esc
''                                                             write_esc
''---------------------------------------------------------------------------------
'' endsel                                     [13:13]          get_endsel
''                                                             set_endsel
''                                                             read_endsel
''                                                             write_endsel
''---------------------------------------------------------------------------------
'' memclr                                     [12:12]          get_memclr
''                                                             set_memclr
''                                                             read_memclr
''                                                             write_memclr
''---------------------------------------------------------------------------------
'' opqfull                                    [10:10]          get_opqfull
''                                                             set_opqfull
''                                                             read_opqfull
''                                                             write_opqfull
''---------------------------------------------------------------------------------
'' prim_sel_fail                              [9:9]            get_prim_sel_fail
''                                                             set_prim_sel_fail
''                                                             read_prim_sel_fail
''                                                             write_prim_sel_fail
''---------------------------------------------------------------------------------
'' lcopc                                      [8:8]            get_lcopc
''                                                             set_lcopc
''                                                             read_lcopc
''                                                             write_lcopc
''---------------------------------------------------------------------------------
'' pkarst                                     [7:7]            get_pkarst
''                                                             set_pkarst
''                                                             read_pkarst
''                                                             write_pkarst
''---------------------------------------------------------------------------------
'' pkacmderr                                  [3:3]            get_pkacmderr
''                                                             set_pkacmderr
''                                                             read_pkacmderr
''                                                             write_pkacmderr
''---------------------------------------------------------------------------------
'' pkabusy                                    [2:2]            get_pkabusy
''                                                             set_pkabusy
''                                                             read_pkabusy
''                                                             write_pkabusy
''---------------------------------------------------------------------------------
'' pkacmddone                                 [1:1]            get_pkacmddone
''                                                             set_pkacmddone
''                                                             read_pkacmddone
''                                                             write_pkacmddone
''---------------------------------------------------------------------------------
'' pkaen                                      [0:0]            get_pkaen
''                                                             set_pkaen
''                                                             read_pkaen
''                                                             write_pkaen
''---------------------------------------------------------------------------------
Class REGISTER_PKA_ctrl
    Private write_unknop_value
    Private read_unknop_value
    Private flag_unknop
    Private write_invsrc0_value
    Private read_invsrc0_value
    Private flag_invsrc0
    Private write_invsrc1_value
    Private read_invsrc1_value
    Private flag_invsrc1
    Private write_invsrc2_value
    Private read_invsrc2_value
    Private flag_invsrc2
    Private write_camfull_value
    Private read_camfull_value
    Private flag_camfull
    Private write_div0_value
    Private read_div0_value
    Private flag_div0
    Private write_opqof_value
    Private read_opqof_value
    Private flag_opqof
    Private write_opcidx_value
    Private read_opcidx_value
    Private flag_opcidx
    Private write_esc_value
    Private read_esc_value
    Private flag_esc
    Private write_endsel_value
    Private read_endsel_value
    Private flag_endsel
    Private write_memclr_value
    Private read_memclr_value
    Private flag_memclr
    Private write_opqfull_value
    Private read_opqfull_value
    Private flag_opqfull
    Private write_prim_sel_fail_value
    Private read_prim_sel_fail_value
    Private flag_prim_sel_fail
    Private write_lcopc_value
    Private read_lcopc_value
    Private flag_lcopc
    Private write_pkarst_value
    Private read_pkarst_value
    Private flag_pkarst
    Private write_pkacmderr_value
    Private read_pkacmderr_value
    Private flag_pkacmderr
    Private write_pkabusy_value
    Private read_pkabusy_value
    Private flag_pkabusy
    Private write_pkacmddone_value
    Private read_pkacmddone_value
    Private flag_pkacmddone
    Private write_pkaen_value
    Private read_pkaen_value
    Private flag_pkaen

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

    Property Get get_unknop
        get_unknop = read_unknop_value
    End Property

    Property Let set_unknop(aData)
        write_unknop_value = aData
        flag_unknop        = &H1
    End Property

    Property Get read_unknop
        read
        read_unknop = read_unknop_value
    End Property

    Property Let write_unknop(aData)
        set_unknop = aData
        write
    End Property

    Property Get get_invsrc0
        get_invsrc0 = read_invsrc0_value
    End Property

    Property Let set_invsrc0(aData)
        write_invsrc0_value = aData
        flag_invsrc0        = &H1
    End Property

    Property Get read_invsrc0
        read
        read_invsrc0 = read_invsrc0_value
    End Property

    Property Let write_invsrc0(aData)
        set_invsrc0 = aData
        write
    End Property

    Property Get get_invsrc1
        get_invsrc1 = read_invsrc1_value
    End Property

    Property Let set_invsrc1(aData)
        write_invsrc1_value = aData
        flag_invsrc1        = &H1
    End Property

    Property Get read_invsrc1
        read
        read_invsrc1 = read_invsrc1_value
    End Property

    Property Let write_invsrc1(aData)
        set_invsrc1 = aData
        write
    End Property

    Property Get get_invsrc2
        get_invsrc2 = read_invsrc2_value
    End Property

    Property Let set_invsrc2(aData)
        write_invsrc2_value = aData
        flag_invsrc2        = &H1
    End Property

    Property Get read_invsrc2
        read
        read_invsrc2 = read_invsrc2_value
    End Property

    Property Let write_invsrc2(aData)
        set_invsrc2 = aData
        write
    End Property

    Property Get get_camfull
        get_camfull = read_camfull_value
    End Property

    Property Let set_camfull(aData)
        write_camfull_value = aData
        flag_camfull        = &H1
    End Property

    Property Get read_camfull
        read
        read_camfull = read_camfull_value
    End Property

    Property Let write_camfull(aData)
        set_camfull = aData
        write
    End Property

    Property Get get_div0
        get_div0 = read_div0_value
    End Property

    Property Let set_div0(aData)
        write_div0_value = aData
        flag_div0        = &H1
    End Property

    Property Get read_div0
        read
        read_div0 = read_div0_value
    End Property

    Property Let write_div0(aData)
        set_div0 = aData
        write
    End Property

    Property Get get_opqof
        get_opqof = read_opqof_value
    End Property

    Property Let set_opqof(aData)
        write_opqof_value = aData
        flag_opqof        = &H1
    End Property

    Property Get read_opqof
        read
        read_opqof = read_opqof_value
    End Property

    Property Let write_opqof(aData)
        set_opqof = aData
        write
    End Property

    Property Get get_opcidx
        get_opcidx = read_opcidx_value
    End Property

    Property Let set_opcidx(aData)
        write_opcidx_value = aData
        flag_opcidx        = &H1
    End Property

    Property Get read_opcidx
        read
        read_opcidx = read_opcidx_value
    End Property

    Property Let write_opcidx(aData)
        set_opcidx = aData
        write
    End Property

    Property Get get_esc
        get_esc = read_esc_value
    End Property

    Property Let set_esc(aData)
        write_esc_value = aData
        flag_esc        = &H1
    End Property

    Property Get read_esc
        read
        read_esc = read_esc_value
    End Property

    Property Let write_esc(aData)
        set_esc = aData
        write
    End Property

    Property Get get_endsel
        get_endsel = read_endsel_value
    End Property

    Property Let set_endsel(aData)
        write_endsel_value = aData
        flag_endsel        = &H1
    End Property

    Property Get read_endsel
        read
        read_endsel = read_endsel_value
    End Property

    Property Let write_endsel(aData)
        set_endsel = aData
        write
    End Property

    Property Get get_memclr
        get_memclr = read_memclr_value
    End Property

    Property Let set_memclr(aData)
        write_memclr_value = aData
        flag_memclr        = &H1
    End Property

    Property Get read_memclr
        read
        read_memclr = read_memclr_value
    End Property

    Property Let write_memclr(aData)
        set_memclr = aData
        write
    End Property

    Property Get get_opqfull
        get_opqfull = read_opqfull_value
    End Property

    Property Let set_opqfull(aData)
        write_opqfull_value = aData
        flag_opqfull        = &H1
    End Property

    Property Get read_opqfull
        read
        read_opqfull = read_opqfull_value
    End Property

    Property Let write_opqfull(aData)
        set_opqfull = aData
        write
    End Property

    Property Get get_prim_sel_fail
        get_prim_sel_fail = read_prim_sel_fail_value
    End Property

    Property Let set_prim_sel_fail(aData)
        write_prim_sel_fail_value = aData
        flag_prim_sel_fail        = &H1
    End Property

    Property Get read_prim_sel_fail
        read
        read_prim_sel_fail = read_prim_sel_fail_value
    End Property

    Property Let write_prim_sel_fail(aData)
        set_prim_sel_fail = aData
        write
    End Property

    Property Get get_lcopc
        get_lcopc = read_lcopc_value
    End Property

    Property Let set_lcopc(aData)
        write_lcopc_value = aData
        flag_lcopc        = &H1
    End Property

    Property Get read_lcopc
        read
        read_lcopc = read_lcopc_value
    End Property

    Property Let write_lcopc(aData)
        set_lcopc = aData
        write
    End Property

    Property Get get_pkarst
        get_pkarst = read_pkarst_value
    End Property

    Property Let set_pkarst(aData)
        write_pkarst_value = aData
        flag_pkarst        = &H1
    End Property

    Property Get read_pkarst
        read
        read_pkarst = read_pkarst_value
    End Property

    Property Let write_pkarst(aData)
        set_pkarst = aData
        write
    End Property

    Property Get get_pkacmderr
        get_pkacmderr = read_pkacmderr_value
    End Property

    Property Let set_pkacmderr(aData)
        write_pkacmderr_value = aData
        flag_pkacmderr        = &H1
    End Property

    Property Get read_pkacmderr
        read
        read_pkacmderr = read_pkacmderr_value
    End Property

    Property Let write_pkacmderr(aData)
        set_pkacmderr = aData
        write
    End Property

    Property Get get_pkabusy
        get_pkabusy = read_pkabusy_value
    End Property

    Property Let set_pkabusy(aData)
        write_pkabusy_value = aData
        flag_pkabusy        = &H1
    End Property

    Property Get read_pkabusy
        read
        read_pkabusy = read_pkabusy_value
    End Property

    Property Let write_pkabusy(aData)
        set_pkabusy = aData
        write
    End Property

    Property Get get_pkacmddone
        get_pkacmddone = read_pkacmddone_value
    End Property

    Property Let set_pkacmddone(aData)
        write_pkacmddone_value = aData
        flag_pkacmddone        = &H1
    End Property

    Property Get read_pkacmddone
        read
        read_pkacmddone = read_pkacmddone_value
    End Property

    Property Let write_pkacmddone(aData)
        set_pkacmddone = aData
        write
    End Property

    Property Get get_pkaen
        get_pkaen = read_pkaen_value
    End Property

    Property Let set_pkaen(aData)
        write_pkaen_value = aData
        flag_pkaen        = &H1
    End Property

    Property Get read_pkaen
        read
        read_pkaen = read_pkaen_value
    End Property

    Property Let write_pkaen(aData)
        set_pkaen = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_unknop_value = rightShift(data_low, 31) and &H1
        read_invsrc0_value = rightShift(data_low, 30) and &H1
        read_invsrc1_value = rightShift(data_low, 29) and &H1
        read_invsrc2_value = rightShift(data_low, 28) and &H1
        read_camfull_value = rightShift(data_low, 27) and &H1
        read_div0_value = rightShift(data_low, 26) and &H1
        read_opqof_value = rightShift(data_low, 25) and &H1
        read_opcidx_value = rightShift(data_low, 20) and &H1f
        read_esc_value = rightShift(data_low, 16) and &Hf
        read_endsel_value = rightShift(data_low, 13) and &H1
        read_memclr_value = rightShift(data_low, 12) and &H1
        read_opqfull_value = rightShift(data_low, 10) and &H1
        read_prim_sel_fail_value = rightShift(data_low, 9) and &H1
        read_lcopc_value = rightShift(data_low, 8) and &H1
        read_pkarst_value = rightShift(data_low, 7) and &H1
        read_pkacmderr_value = rightShift(data_low, 3) and &H1
        read_pkabusy_value = rightShift(data_low, 2) and &H1
        read_pkacmddone_value = rightShift(data_low, 1) and &H1
        pkaen_mask = &H1
        if data_low > LONG_MAX then
            if pkaen_mask = mask then
                read_pkaen_value = data_low
            else
                read_pkaen_value = (data_low - H8000_0000) and pkaen_mask
            end If
        else
            read_pkaen_value = data_low and pkaen_mask
        end If

    End Sub

    Sub write
        If flag_unknop = &H0 or flag_invsrc0 = &H0 or flag_invsrc1 = &H0 or flag_invsrc2 = &H0 or flag_camfull = &H0 or flag_div0 = &H0 or flag_opqof = &H0 or flag_opcidx = &H0 or flag_esc = &H0 or flag_endsel = &H0 or flag_memclr = &H0 or flag_opqfull = &H0 or flag_prim_sel_fail = &H0 or flag_lcopc = &H0 or flag_pkarst = &H0 or flag_pkacmderr = &H0 or flag_pkabusy = &H0 or flag_pkacmddone = &H0 or flag_pkaen = &H0 Then read
        If flag_unknop = &H0 Then write_unknop_value = get_unknop
        If flag_invsrc0 = &H0 Then write_invsrc0_value = get_invsrc0
        If flag_invsrc1 = &H0 Then write_invsrc1_value = get_invsrc1
        If flag_invsrc2 = &H0 Then write_invsrc2_value = get_invsrc2
        If flag_camfull = &H0 Then write_camfull_value = get_camfull
        If flag_div0 = &H0 Then write_div0_value = get_div0
        If flag_opqof = &H0 Then write_opqof_value = get_opqof
        If flag_opcidx = &H0 Then write_opcidx_value = get_opcidx
        If flag_esc = &H0 Then write_esc_value = get_esc
        If flag_endsel = &H0 Then write_endsel_value = get_endsel
        If flag_memclr = &H0 Then write_memclr_value = get_memclr
        If flag_opqfull = &H0 Then write_opqfull_value = get_opqfull
        If flag_prim_sel_fail = &H0 Then write_prim_sel_fail_value = get_prim_sel_fail
        If flag_lcopc = &H0 Then write_lcopc_value = get_lcopc
        If flag_pkarst = &H0 Then write_pkarst_value = get_pkarst
        If flag_pkacmderr = &H0 Then write_pkacmderr_value = get_pkacmderr
        If flag_pkabusy = &H0 Then write_pkabusy_value = get_pkabusy
        If flag_pkacmddone = &H0 Then write_pkacmddone_value = get_pkacmddone
        If flag_pkaen = &H0 Then write_pkaen_value = get_pkaen

        regValue = leftShift((write_unknop_value and &H1), 31) + leftShift((write_invsrc0_value and &H1), 30) + leftShift((write_invsrc1_value and &H1), 29) + leftShift((write_invsrc2_value and &H1), 28) + leftShift((write_camfull_value and &H1), 27) + leftShift((write_div0_value and &H1), 26) + leftShift((write_opqof_value and &H1), 25) + leftShift((write_opcidx_value and &H1f), 20) + leftShift((write_esc_value and &Hf), 16) + leftShift((write_endsel_value and &H1), 13) + leftShift((write_memclr_value and &H1), 12) + leftShift((write_opqfull_value and &H1), 10) + leftShift((write_prim_sel_fail_value and &H1), 9) + leftShift((write_lcopc_value and &H1), 8) + leftShift((write_pkarst_value and &H1), 7) + leftShift((write_pkacmderr_value and &H1), 3) + leftShift((write_pkabusy_value and &H1), 2) + leftShift((write_pkacmddone_value and &H1), 1) + leftShift((write_pkaen_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_unknop_value = rightShift(data_low, 31) and &H1
        read_invsrc0_value = rightShift(data_low, 30) and &H1
        read_invsrc1_value = rightShift(data_low, 29) and &H1
        read_invsrc2_value = rightShift(data_low, 28) and &H1
        read_camfull_value = rightShift(data_low, 27) and &H1
        read_div0_value = rightShift(data_low, 26) and &H1
        read_opqof_value = rightShift(data_low, 25) and &H1
        read_opcidx_value = rightShift(data_low, 20) and &H1f
        read_esc_value = rightShift(data_low, 16) and &Hf
        read_endsel_value = rightShift(data_low, 13) and &H1
        read_memclr_value = rightShift(data_low, 12) and &H1
        read_opqfull_value = rightShift(data_low, 10) and &H1
        read_prim_sel_fail_value = rightShift(data_low, 9) and &H1
        read_lcopc_value = rightShift(data_low, 8) and &H1
        read_pkarst_value = rightShift(data_low, 7) and &H1
        read_pkacmderr_value = rightShift(data_low, 3) and &H1
        read_pkabusy_value = rightShift(data_low, 2) and &H1
        read_pkacmddone_value = rightShift(data_low, 1) and &H1
        pkaen_mask = &H1
        if data_low > LONG_MAX then
            if pkaen_mask = mask then
                read_pkaen_value = data_low
            else
                read_pkaen_value = (data_low - H8000_0000) and pkaen_mask
            end If
        else
            read_pkaen_value = data_low and pkaen_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_unknop_value = &H0
        flag_unknop        = &H0
        write_invsrc0_value = &H0
        flag_invsrc0        = &H0
        write_invsrc1_value = &H0
        flag_invsrc1        = &H0
        write_invsrc2_value = &H0
        flag_invsrc2        = &H0
        write_camfull_value = &H0
        flag_camfull        = &H0
        write_div0_value = &H0
        flag_div0        = &H0
        write_opqof_value = &H0
        flag_opqof        = &H0
        write_opcidx_value = &H0
        flag_opcidx        = &H0
        write_esc_value = &H0
        flag_esc        = &H0
        write_endsel_value = &H0
        flag_endsel        = &H0
        write_memclr_value = &H0
        flag_memclr        = &H0
        write_opqfull_value = &H0
        flag_opqfull        = &H0
        write_prim_sel_fail_value = &H0
        flag_prim_sel_fail        = &H0
        write_lcopc_value = &H0
        flag_lcopc        = &H0
        write_pkarst_value = &H0
        flag_pkarst        = &H0
        write_pkacmderr_value = &H0
        flag_pkacmderr        = &H0
        write_pkabusy_value = &H0
        flag_pkabusy        = &H0
        write_pkacmddone_value = &H0
        flag_pkacmddone        = &H0
        write_pkaen_value = &H0
        flag_pkaen        = &H0
    End Sub
End Class


'' @REGISTER : PKA_din
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pkaidat                                    [31:0]           get_pkaidat
''                                                             set_pkaidat
''                                                             read_pkaidat
''                                                             write_pkaidat
''---------------------------------------------------------------------------------
Class REGISTER_PKA_din
    Private write_pkaidat_value
    Private read_pkaidat_value
    Private flag_pkaidat

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

    Property Get get_pkaidat
        get_pkaidat = read_pkaidat_value
    End Property

    Property Let set_pkaidat(aData)
        write_pkaidat_value = aData
        flag_pkaidat        = &H1
    End Property

    Property Get read_pkaidat
        read
        read_pkaidat = read_pkaidat_value
    End Property

    Property Let write_pkaidat(aData)
        set_pkaidat = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pkaidat_mask = &Hffffffff
        if data_low > LONG_MAX then
            if pkaidat_mask = mask then
                read_pkaidat_value = data_low
            else
                read_pkaidat_value = (data_low - H8000_0000) and pkaidat_mask
            end If
        else
            read_pkaidat_value = data_low and pkaidat_mask
        end If

    End Sub

    Sub write
        If flag_pkaidat = &H0 Then read
        If flag_pkaidat = &H0 Then write_pkaidat_value = get_pkaidat

        regValue = leftShift(write_pkaidat_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pkaidat_mask = &Hffffffff
        if data_low > LONG_MAX then
            if pkaidat_mask = mask then
                read_pkaidat_value = data_low
            else
                read_pkaidat_value = (data_low - H8000_0000) and pkaidat_mask
            end If
        else
            read_pkaidat_value = data_low and pkaidat_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pkaidat_value = &H0
        flag_pkaidat        = &H0
    End Sub
End Class


'' @REGISTER : PKA_dout
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pkaodat                                    [31:0]           get_pkaodat
''                                                             set_pkaodat
''                                                             read_pkaodat
''                                                             write_pkaodat
''---------------------------------------------------------------------------------
Class REGISTER_PKA_dout
    Private write_pkaodat_value
    Private read_pkaodat_value
    Private flag_pkaodat

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

    Property Get get_pkaodat
        get_pkaodat = read_pkaodat_value
    End Property

    Property Let set_pkaodat(aData)
        write_pkaodat_value = aData
        flag_pkaodat        = &H1
    End Property

    Property Get read_pkaodat
        read
        read_pkaodat = read_pkaodat_value
    End Property

    Property Let write_pkaodat(aData)
        set_pkaodat = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pkaodat_mask = &Hffffffff
        if data_low > LONG_MAX then
            if pkaodat_mask = mask then
                read_pkaodat_value = data_low
            else
                read_pkaodat_value = (data_low - H8000_0000) and pkaodat_mask
            end If
        else
            read_pkaodat_value = data_low and pkaodat_mask
        end If

    End Sub

    Sub write
        If flag_pkaodat = &H0 Then read
        If flag_pkaodat = &H0 Then write_pkaodat_value = get_pkaodat

        regValue = leftShift(write_pkaodat_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        pkaodat_mask = &Hffffffff
        if data_low > LONG_MAX then
            if pkaodat_mask = mask then
                read_pkaodat_value = data_low
            else
                read_pkaodat_value = (data_low - H8000_0000) and pkaodat_mask
            end If
        else
            read_pkaodat_value = data_low and pkaodat_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pkaodat_value = &H0
        flag_pkaodat        = &H0
    End Sub
End Class


'' @REGISTER : PKA_acc
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pkalck                                     [31:31]          get_pkalck
''                                                             set_pkalck
''                                                             read_pkalck
''                                                             write_pkalck
''---------------------------------------------------------------------------------
'' lck                                        [15:15]          get_lck
''                                                             set_lck
''                                                             read_lck
''                                                             write_lck
''---------------------------------------------------------------------------------
Class REGISTER_PKA_acc
    Private write_pkalck_value
    Private read_pkalck_value
    Private flag_pkalck
    Private write_lck_value
    Private read_lck_value
    Private flag_lck

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

    Property Get get_pkalck
        get_pkalck = read_pkalck_value
    End Property

    Property Let set_pkalck(aData)
        write_pkalck_value = aData
        flag_pkalck        = &H1
    End Property

    Property Get read_pkalck
        read
        read_pkalck = read_pkalck_value
    End Property

    Property Let write_pkalck(aData)
        set_pkalck = aData
        write
    End Property

    Property Get get_lck
        get_lck = read_lck_value
    End Property

    Property Let set_lck(aData)
        write_lck_value = aData
        flag_lck        = &H1
    End Property

    Property Get read_lck
        read
        read_lck = read_lck_value
    End Property

    Property Let write_lck(aData)
        set_lck = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_pkalck_value = rightShift(data_low, 31) and &H1
        read_lck_value = rightShift(data_low, 15) and &H1

    End Sub

    Sub write
        If flag_pkalck = &H0 or flag_lck = &H0 Then read
        If flag_pkalck = &H0 Then write_pkalck_value = get_pkalck
        If flag_lck = &H0 Then write_lck_value = get_lck

        regValue = leftShift((write_pkalck_value and &H1), 31) + leftShift((write_lck_value and &H1), 15)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_pkalck_value = rightShift(data_low, 31) and &H1
        read_lck_value = rightShift(data_low, 15) and &H1

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pkalck_value = &H0
        flag_pkalck        = &H0
        write_lck_value = &H0
        flag_lck        = &H0
    End Sub
End Class


'' @REGISTER : PKA_lfsr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' rndseed                                    [31:0]           get_rndseed
''                                                             set_rndseed
''                                                             read_rndseed
''                                                             write_rndseed
''---------------------------------------------------------------------------------
Class REGISTER_PKA_lfsr
    Private write_rndseed_value
    Private read_rndseed_value
    Private flag_rndseed

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

    Property Get get_rndseed
        get_rndseed = read_rndseed_value
    End Property

    Property Let set_rndseed(aData)
        write_rndseed_value = aData
        flag_rndseed        = &H1
    End Property

    Property Get read_rndseed
        read
        read_rndseed = read_rndseed_value
    End Property

    Property Let write_rndseed(aData)
        set_rndseed = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rndseed_mask = &Hffffffff
        if data_low > LONG_MAX then
            if rndseed_mask = mask then
                read_rndseed_value = data_low
            else
                read_rndseed_value = (data_low - H8000_0000) and rndseed_mask
            end If
        else
            read_rndseed_value = data_low and rndseed_mask
        end If

    End Sub

    Sub write
        If flag_rndseed = &H0 Then read
        If flag_rndseed = &H0 Then write_rndseed_value = get_rndseed

        regValue = leftShift(write_rndseed_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        rndseed_mask = &Hffffffff
        if data_low > LONG_MAX then
            if rndseed_mask = mask then
                read_rndseed_value = data_low
            else
                read_rndseed_value = (data_low - H8000_0000) and rndseed_mask
            end If
        else
            read_rndseed_value = data_low and rndseed_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_rndseed_value = &H0
        flag_rndseed        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class PKA_INSTANCE

    Public ctrl
    Public din
    Public dout
    Public acc
    Public lfsr


    Public default function Init(aBaseAddr)
        Set ctrl = (New REGISTER_PKA_ctrl)(aBaseAddr, 32)
        Set din = (New REGISTER_PKA_din)(aBaseAddr, 32)
        Set dout = (New REGISTER_PKA_dout)(aBaseAddr, 32)
        Set acc = (New REGISTER_PKA_acc)(aBaseAddr, 32)
        Set lfsr = (New REGISTER_PKA_lfsr)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set PKA = CreateObject("System.Collections.ArrayList")
PKA.Add ((New PKA_INSTANCE)(&H4c010000))


