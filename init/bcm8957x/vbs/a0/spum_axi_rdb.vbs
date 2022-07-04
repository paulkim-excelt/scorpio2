

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


'' @REGISTER : SPUM_AXI_axi_react
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' reaction                                   [1:0]            get_reaction
''                                                             set_reaction
''                                                             read_reaction
''                                                             write_reaction
''---------------------------------------------------------------------------------
Class REGISTER_SPUM_AXI_axi_react
    Private write_reaction_value
    Private read_reaction_value
    Private flag_reaction

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

    Property Get get_reaction
        get_reaction = read_reaction_value
    End Property

    Property Let set_reaction(aData)
        write_reaction_value = aData
        flag_reaction        = &H1
    End Property

    Property Get read_reaction
        read
        read_reaction = read_reaction_value
    End Property

    Property Let write_reaction(aData)
        set_reaction = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        reaction_mask = &H3
        if data_low > LONG_MAX then
            if reaction_mask = mask then
                read_reaction_value = data_low
            else
                read_reaction_value = (data_low - H8000_0000) and reaction_mask
            end If
        else
            read_reaction_value = data_low and reaction_mask
        end If

    End Sub

    Sub write
        If flag_reaction = &H0 Then read
        If flag_reaction = &H0 Then write_reaction_value = get_reaction

        regValue = leftShift((write_reaction_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        reaction_mask = &H3
        if data_low > LONG_MAX then
            if reaction_mask = mask then
                read_reaction_value = data_low
            else
                read_reaction_value = (data_low - H8000_0000) and reaction_mask
            end If
        else
            read_reaction_value = data_low and reaction_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_reaction_value = &H0
        flag_reaction        = &H0
    End Sub
End Class


'' @REGISTER : SPUM_AXI_int_stat
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pkt_err_int                                [2:2]            get_pkt_err_int
''                                                             set_pkt_err_int
''                                                             read_pkt_err_int
''                                                             write_pkt_err_int
''---------------------------------------------------------------------------------
'' key_cache_err_int                          [1:1]            get_key_cache_err_int
''                                                             set_key_cache_err_int
''                                                             read_key_cache_err_int
''                                                             write_key_cache_err_int
''---------------------------------------------------------------------------------
'' access_vio_int                             [0:0]            get_access_vio_int
''                                                             set_access_vio_int
''                                                             read_access_vio_int
''                                                             write_access_vio_int
''---------------------------------------------------------------------------------
Class REGISTER_SPUM_AXI_int_stat
    Private write_pkt_err_int_value
    Private read_pkt_err_int_value
    Private flag_pkt_err_int
    Private write_key_cache_err_int_value
    Private read_key_cache_err_int_value
    Private flag_key_cache_err_int
    Private write_access_vio_int_value
    Private read_access_vio_int_value
    Private flag_access_vio_int

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

    Property Get get_pkt_err_int
        get_pkt_err_int = read_pkt_err_int_value
    End Property

    Property Let set_pkt_err_int(aData)
        write_pkt_err_int_value = aData
        flag_pkt_err_int        = &H1
    End Property

    Property Get read_pkt_err_int
        read
        read_pkt_err_int = read_pkt_err_int_value
    End Property

    Property Let write_pkt_err_int(aData)
        set_pkt_err_int = aData
        write
    End Property

    Property Get get_key_cache_err_int
        get_key_cache_err_int = read_key_cache_err_int_value
    End Property

    Property Let set_key_cache_err_int(aData)
        write_key_cache_err_int_value = aData
        flag_key_cache_err_int        = &H1
    End Property

    Property Get read_key_cache_err_int
        read
        read_key_cache_err_int = read_key_cache_err_int_value
    End Property

    Property Let write_key_cache_err_int(aData)
        set_key_cache_err_int = aData
        write
    End Property

    Property Get get_access_vio_int
        get_access_vio_int = read_access_vio_int_value
    End Property

    Property Let set_access_vio_int(aData)
        write_access_vio_int_value = aData
        flag_access_vio_int        = &H1
    End Property

    Property Get read_access_vio_int
        read
        read_access_vio_int = read_access_vio_int_value
    End Property

    Property Let write_access_vio_int(aData)
        set_access_vio_int = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_pkt_err_int_value = rightShift(data_low, 2) and &H1
        read_key_cache_err_int_value = rightShift(data_low, 1) and &H1
        access_vio_int_mask = &H1
        if data_low > LONG_MAX then
            if access_vio_int_mask = mask then
                read_access_vio_int_value = data_low
            else
                read_access_vio_int_value = (data_low - H8000_0000) and access_vio_int_mask
            end If
        else
            read_access_vio_int_value = data_low and access_vio_int_mask
        end If

    End Sub

    Sub write
        If flag_pkt_err_int = &H0 or flag_key_cache_err_int = &H0 or flag_access_vio_int = &H0 Then read
        If flag_pkt_err_int = &H0 Then write_pkt_err_int_value = get_pkt_err_int
        If flag_key_cache_err_int = &H0 Then write_key_cache_err_int_value = get_key_cache_err_int
        If flag_access_vio_int = &H0 Then write_access_vio_int_value = get_access_vio_int

        regValue = leftShift((write_pkt_err_int_value and &H1), 2) + leftShift((write_key_cache_err_int_value and &H1), 1) + leftShift((write_access_vio_int_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_pkt_err_int_value = rightShift(data_low, 2) and &H1
        read_key_cache_err_int_value = rightShift(data_low, 1) and &H1
        access_vio_int_mask = &H1
        if data_low > LONG_MAX then
            if access_vio_int_mask = mask then
                read_access_vio_int_value = data_low
            else
                read_access_vio_int_value = (data_low - H8000_0000) and access_vio_int_mask
            end If
        else
            read_access_vio_int_value = data_low and access_vio_int_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pkt_err_int_value = &H0
        flag_pkt_err_int        = &H0
        write_key_cache_err_int_value = &H0
        flag_key_cache_err_int        = &H0
        write_access_vio_int_value = &H0
        flag_access_vio_int        = &H0
    End Sub
End Class


'' @REGISTER : SPUM_AXI_int_mask
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pkt_err_int_mask                           [2:2]            get_pkt_err_int_mask
''                                                             set_pkt_err_int_mask
''                                                             read_pkt_err_int_mask
''                                                             write_pkt_err_int_mask
''---------------------------------------------------------------------------------
'' key_cache_erro_int_mask                    [1:1]            get_key_cache_erro_int_mask
''                                                             set_key_cache_erro_int_mask
''                                                             read_key_cache_erro_int_mask
''                                                             write_key_cache_erro_int_mask
''---------------------------------------------------------------------------------
'' access_vio_int_mask                        [0:0]            get_access_vio_int_mask
''                                                             set_access_vio_int_mask
''                                                             read_access_vio_int_mask
''                                                             write_access_vio_int_mask
''---------------------------------------------------------------------------------
Class REGISTER_SPUM_AXI_int_mask
    Private write_pkt_err_int_mask_value
    Private read_pkt_err_int_mask_value
    Private flag_pkt_err_int_mask
    Private write_key_cache_erro_int_mask_value
    Private read_key_cache_erro_int_mask_value
    Private flag_key_cache_erro_int_mask
    Private write_access_vio_int_mask_value
    Private read_access_vio_int_mask_value
    Private flag_access_vio_int_mask

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

    Property Get get_pkt_err_int_mask
        get_pkt_err_int_mask = read_pkt_err_int_mask_value
    End Property

    Property Let set_pkt_err_int_mask(aData)
        write_pkt_err_int_mask_value = aData
        flag_pkt_err_int_mask        = &H1
    End Property

    Property Get read_pkt_err_int_mask
        read
        read_pkt_err_int_mask = read_pkt_err_int_mask_value
    End Property

    Property Let write_pkt_err_int_mask(aData)
        set_pkt_err_int_mask = aData
        write
    End Property

    Property Get get_key_cache_erro_int_mask
        get_key_cache_erro_int_mask = read_key_cache_erro_int_mask_value
    End Property

    Property Let set_key_cache_erro_int_mask(aData)
        write_key_cache_erro_int_mask_value = aData
        flag_key_cache_erro_int_mask        = &H1
    End Property

    Property Get read_key_cache_erro_int_mask
        read
        read_key_cache_erro_int_mask = read_key_cache_erro_int_mask_value
    End Property

    Property Let write_key_cache_erro_int_mask(aData)
        set_key_cache_erro_int_mask = aData
        write
    End Property

    Property Get get_access_vio_int_mask
        get_access_vio_int_mask = read_access_vio_int_mask_value
    End Property

    Property Let set_access_vio_int_mask(aData)
        write_access_vio_int_mask_value = aData
        flag_access_vio_int_mask        = &H1
    End Property

    Property Get read_access_vio_int_mask
        read
        read_access_vio_int_mask = read_access_vio_int_mask_value
    End Property

    Property Let write_access_vio_int_mask(aData)
        set_access_vio_int_mask = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_pkt_err_int_mask_value = rightShift(data_low, 2) and &H1
        read_key_cache_erro_int_mask_value = rightShift(data_low, 1) and &H1
        access_vio_int_mask_mask = &H1
        if data_low > LONG_MAX then
            if access_vio_int_mask_mask = mask then
                read_access_vio_int_mask_value = data_low
            else
                read_access_vio_int_mask_value = (data_low - H8000_0000) and access_vio_int_mask_mask
            end If
        else
            read_access_vio_int_mask_value = data_low and access_vio_int_mask_mask
        end If

    End Sub

    Sub write
        If flag_pkt_err_int_mask = &H0 or flag_key_cache_erro_int_mask = &H0 or flag_access_vio_int_mask = &H0 Then read
        If flag_pkt_err_int_mask = &H0 Then write_pkt_err_int_mask_value = get_pkt_err_int_mask
        If flag_key_cache_erro_int_mask = &H0 Then write_key_cache_erro_int_mask_value = get_key_cache_erro_int_mask
        If flag_access_vio_int_mask = &H0 Then write_access_vio_int_mask_value = get_access_vio_int_mask

        regValue = leftShift((write_pkt_err_int_mask_value and &H1), 2) + leftShift((write_key_cache_erro_int_mask_value and &H1), 1) + leftShift((write_access_vio_int_mask_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_pkt_err_int_mask_value = rightShift(data_low, 2) and &H1
        read_key_cache_erro_int_mask_value = rightShift(data_low, 1) and &H1
        access_vio_int_mask_mask = &H1
        if data_low > LONG_MAX then
            if access_vio_int_mask_mask = mask then
                read_access_vio_int_mask_value = data_low
            else
                read_access_vio_int_mask_value = (data_low - H8000_0000) and access_vio_int_mask_mask
            end If
        else
            read_access_vio_int_mask_value = data_low and access_vio_int_mask_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pkt_err_int_mask_value = &H0
        flag_pkt_err_int_mask        = &H0
        write_key_cache_erro_int_mask_value = &H0
        flag_key_cache_erro_int_mask        = &H0
        write_access_vio_int_mask_value = &H0
        flag_access_vio_int_mask        = &H0
    End Sub
End Class


'' @REGISTER : SPUM_AXI_vio_addr_stat
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' vio_addr_status                            [31:0]           get_vio_addr_status
''                                                             set_vio_addr_status
''                                                             read_vio_addr_status
''                                                             write_vio_addr_status
''---------------------------------------------------------------------------------
Class REGISTER_SPUM_AXI_vio_addr_stat
    Private write_vio_addr_status_value
    Private read_vio_addr_status_value
    Private flag_vio_addr_status

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

    Property Get get_vio_addr_status
        get_vio_addr_status = read_vio_addr_status_value
    End Property

    Property Let set_vio_addr_status(aData)
        write_vio_addr_status_value = aData
        flag_vio_addr_status        = &H1
    End Property

    Property Get read_vio_addr_status
        read
        read_vio_addr_status = read_vio_addr_status_value
    End Property

    Property Let write_vio_addr_status(aData)
        set_vio_addr_status = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vio_addr_status_mask = &Hffffffff
        if data_low > LONG_MAX then
            if vio_addr_status_mask = mask then
                read_vio_addr_status_value = data_low
            else
                read_vio_addr_status_value = (data_low - H8000_0000) and vio_addr_status_mask
            end If
        else
            read_vio_addr_status_value = data_low and vio_addr_status_mask
        end If

    End Sub

    Sub write
        If flag_vio_addr_status = &H0 Then read
        If flag_vio_addr_status = &H0 Then write_vio_addr_status_value = get_vio_addr_status

        regValue = leftShift(write_vio_addr_status_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        vio_addr_status_mask = &Hffffffff
        if data_low > LONG_MAX then
            if vio_addr_status_mask = mask then
                read_vio_addr_status_value = data_low
            else
                read_vio_addr_status_value = (data_low - H8000_0000) and vio_addr_status_mask
            end If
        else
            read_vio_addr_status_value = data_low and vio_addr_status_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_vio_addr_status_value = &H0
        flag_vio_addr_status        = &H0
    End Sub
End Class


'' @REGISTER : SPUM_AXI_vio_ctl_stat
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Int_overrun                                [31:31]          get_Int_overrun
''                                                             set_Int_overrun
''                                                             read_Int_overrun
''                                                             write_Int_overrun
''---------------------------------------------------------------------------------
'' Int_set                                    [30:30]          get_Int_set
''                                                             set_Int_set
''                                                             read_Int_set
''                                                             write_Int_set
''---------------------------------------------------------------------------------
'' id                                         [17:2]           get_id
''                                                             set_id
''                                                             read_id
''                                                             write_id
''---------------------------------------------------------------------------------
'' secure                                     [1:1]            get_secure
''                                                             set_secure
''                                                             read_secure
''                                                             write_secure
''---------------------------------------------------------------------------------
'' rd_wr                                      [0:0]            get_rd_wr
''                                                             set_rd_wr
''                                                             read_rd_wr
''                                                             write_rd_wr
''---------------------------------------------------------------------------------
Class REGISTER_SPUM_AXI_vio_ctl_stat
    Private write_Int_overrun_value
    Private read_Int_overrun_value
    Private flag_Int_overrun
    Private write_Int_set_value
    Private read_Int_set_value
    Private flag_Int_set
    Private write_id_value
    Private read_id_value
    Private flag_id
    Private write_secure_value
    Private read_secure_value
    Private flag_secure
    Private write_rd_wr_value
    Private read_rd_wr_value
    Private flag_rd_wr

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

    Property Get get_Int_overrun
        get_Int_overrun = read_Int_overrun_value
    End Property

    Property Let set_Int_overrun(aData)
        write_Int_overrun_value = aData
        flag_Int_overrun        = &H1
    End Property

    Property Get read_Int_overrun
        read
        read_Int_overrun = read_Int_overrun_value
    End Property

    Property Let write_Int_overrun(aData)
        set_Int_overrun = aData
        write
    End Property

    Property Get get_Int_set
        get_Int_set = read_Int_set_value
    End Property

    Property Let set_Int_set(aData)
        write_Int_set_value = aData
        flag_Int_set        = &H1
    End Property

    Property Get read_Int_set
        read
        read_Int_set = read_Int_set_value
    End Property

    Property Let write_Int_set(aData)
        set_Int_set = aData
        write
    End Property

    Property Get get_id
        get_id = read_id_value
    End Property

    Property Let set_id(aData)
        write_id_value = aData
        flag_id        = &H1
    End Property

    Property Get read_id
        read
        read_id = read_id_value
    End Property

    Property Let write_id(aData)
        set_id = aData
        write
    End Property

    Property Get get_secure
        get_secure = read_secure_value
    End Property

    Property Let set_secure(aData)
        write_secure_value = aData
        flag_secure        = &H1
    End Property

    Property Get read_secure
        read
        read_secure = read_secure_value
    End Property

    Property Let write_secure(aData)
        set_secure = aData
        write
    End Property

    Property Get get_rd_wr
        get_rd_wr = read_rd_wr_value
    End Property

    Property Let set_rd_wr(aData)
        write_rd_wr_value = aData
        flag_rd_wr        = &H1
    End Property

    Property Get read_rd_wr
        read
        read_rd_wr = read_rd_wr_value
    End Property

    Property Let write_rd_wr(aData)
        set_rd_wr = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Int_overrun_value = rightShift(data_low, 31) and &H1
        read_Int_set_value = rightShift(data_low, 30) and &H1
        read_id_value = rightShift(data_low, 2) and &Hffff
        read_secure_value = rightShift(data_low, 1) and &H1
        rd_wr_mask = &H1
        if data_low > LONG_MAX then
            if rd_wr_mask = mask then
                read_rd_wr_value = data_low
            else
                read_rd_wr_value = (data_low - H8000_0000) and rd_wr_mask
            end If
        else
            read_rd_wr_value = data_low and rd_wr_mask
        end If

    End Sub

    Sub write
        If flag_Int_overrun = &H0 or flag_Int_set = &H0 or flag_id = &H0 or flag_secure = &H0 or flag_rd_wr = &H0 Then read
        If flag_Int_overrun = &H0 Then write_Int_overrun_value = get_Int_overrun
        If flag_Int_set = &H0 Then write_Int_set_value = get_Int_set
        If flag_id = &H0 Then write_id_value = get_id
        If flag_secure = &H0 Then write_secure_value = get_secure
        If flag_rd_wr = &H0 Then write_rd_wr_value = get_rd_wr

        regValue = leftShift((write_Int_overrun_value and &H1), 31) + leftShift((write_Int_set_value and &H1), 30) + leftShift((write_id_value and &Hffff), 2) + leftShift((write_secure_value and &H1), 1) + leftShift((write_rd_wr_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Int_overrun_value = rightShift(data_low, 31) and &H1
        read_Int_set_value = rightShift(data_low, 30) and &H1
        read_id_value = rightShift(data_low, 2) and &Hffff
        read_secure_value = rightShift(data_low, 1) and &H1
        rd_wr_mask = &H1
        if data_low > LONG_MAX then
            if rd_wr_mask = mask then
                read_rd_wr_value = data_low
            else
                read_rd_wr_value = (data_low - H8000_0000) and rd_wr_mask
            end If
        else
            read_rd_wr_value = data_low and rd_wr_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Int_overrun_value = &H0
        flag_Int_overrun        = &H0
        write_Int_set_value = &H0
        flag_Int_set        = &H0
        write_id_value = &H0
        flag_id        = &H0
        write_secure_value = &H0
        flag_secure        = &H0
        write_rd_wr_value = &H0
        flag_rd_wr        = &H0
    End Sub
End Class


'' @REGISTER : SPUM_AXI_axi_access
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' access                                     [1:0]            get_access
''                                                             set_access
''                                                             read_access
''                                                             write_access
''---------------------------------------------------------------------------------
Class REGISTER_SPUM_AXI_axi_access
    Private write_access_value
    Private read_access_value
    Private flag_access

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

    Property Get get_access
        get_access = read_access_value
    End Property

    Property Let set_access(aData)
        write_access_value = aData
        flag_access        = &H1
    End Property

    Property Get read_access
        read
        read_access = read_access_value
    End Property

    Property Let write_access(aData)
        set_access = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        access_mask = &H3
        if data_low > LONG_MAX then
            if access_mask = mask then
                read_access_value = data_low
            else
                read_access_value = (data_low - H8000_0000) and access_mask
            end If
        else
            read_access_value = data_low and access_mask
        end If

    End Sub

    Sub write
        If flag_access = &H0 Then read
        If flag_access = &H0 Then write_access_value = get_access

        regValue = leftShift((write_access_value and &H3), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        access_mask = &H3
        if data_low > LONG_MAX then
            if access_mask = mask then
                read_access_value = data_low
            else
                read_access_value = (data_low - H8000_0000) and access_mask
            end If
        else
            read_access_value = data_low and access_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_access_value = &H0
        flag_access        = &H0
    End Sub
End Class


'' @REGISTER : SPUM_AXI_axi_dbg0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' MHSH_LD_FSM_STATE                          [31:17]          get_MHSH_LD_FSM_STATE
''                                                             set_MHSH_LD_FSM_STATE
''                                                             read_MHSH_LD_FSM_STATE
''                                                             write_MHSH_LD_FSM_STATE
''---------------------------------------------------------------------------------
'' AUM_FSM_STATE                              [16:9]           get_AUM_FSM_STATE
''                                                             set_AUM_FSM_STATE
''                                                             read_AUM_FSM_STATE
''                                                             write_AUM_FSM_STATE
''---------------------------------------------------------------------------------
'' CRM_FSM_STATE                              [8:0]            get_CRM_FSM_STATE
''                                                             set_CRM_FSM_STATE
''                                                             read_CRM_FSM_STATE
''                                                             write_CRM_FSM_STATE
''---------------------------------------------------------------------------------
Class REGISTER_SPUM_AXI_axi_dbg0
    Private write_MHSH_LD_FSM_STATE_value
    Private read_MHSH_LD_FSM_STATE_value
    Private flag_MHSH_LD_FSM_STATE
    Private write_AUM_FSM_STATE_value
    Private read_AUM_FSM_STATE_value
    Private flag_AUM_FSM_STATE
    Private write_CRM_FSM_STATE_value
    Private read_CRM_FSM_STATE_value
    Private flag_CRM_FSM_STATE

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

    Property Get get_MHSH_LD_FSM_STATE
        get_MHSH_LD_FSM_STATE = read_MHSH_LD_FSM_STATE_value
    End Property

    Property Let set_MHSH_LD_FSM_STATE(aData)
        write_MHSH_LD_FSM_STATE_value = aData
        flag_MHSH_LD_FSM_STATE        = &H1
    End Property

    Property Get read_MHSH_LD_FSM_STATE
        read
        read_MHSH_LD_FSM_STATE = read_MHSH_LD_FSM_STATE_value
    End Property

    Property Let write_MHSH_LD_FSM_STATE(aData)
        set_MHSH_LD_FSM_STATE = aData
        write
    End Property

    Property Get get_AUM_FSM_STATE
        get_AUM_FSM_STATE = read_AUM_FSM_STATE_value
    End Property

    Property Let set_AUM_FSM_STATE(aData)
        write_AUM_FSM_STATE_value = aData
        flag_AUM_FSM_STATE        = &H1
    End Property

    Property Get read_AUM_FSM_STATE
        read
        read_AUM_FSM_STATE = read_AUM_FSM_STATE_value
    End Property

    Property Let write_AUM_FSM_STATE(aData)
        set_AUM_FSM_STATE = aData
        write
    End Property

    Property Get get_CRM_FSM_STATE
        get_CRM_FSM_STATE = read_CRM_FSM_STATE_value
    End Property

    Property Let set_CRM_FSM_STATE(aData)
        write_CRM_FSM_STATE_value = aData
        flag_CRM_FSM_STATE        = &H1
    End Property

    Property Get read_CRM_FSM_STATE
        read
        read_CRM_FSM_STATE = read_CRM_FSM_STATE_value
    End Property

    Property Let write_CRM_FSM_STATE(aData)
        set_CRM_FSM_STATE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MHSH_LD_FSM_STATE_value = rightShift(data_low, 17) and &H7fff
        read_AUM_FSM_STATE_value = rightShift(data_low, 9) and &Hff
        CRM_FSM_STATE_mask = &H1ff
        if data_low > LONG_MAX then
            if CRM_FSM_STATE_mask = mask then
                read_CRM_FSM_STATE_value = data_low
            else
                read_CRM_FSM_STATE_value = (data_low - H8000_0000) and CRM_FSM_STATE_mask
            end If
        else
            read_CRM_FSM_STATE_value = data_low and CRM_FSM_STATE_mask
        end If

    End Sub

    Sub write
        If flag_MHSH_LD_FSM_STATE = &H0 or flag_AUM_FSM_STATE = &H0 or flag_CRM_FSM_STATE = &H0 Then read
        If flag_MHSH_LD_FSM_STATE = &H0 Then write_MHSH_LD_FSM_STATE_value = get_MHSH_LD_FSM_STATE
        If flag_AUM_FSM_STATE = &H0 Then write_AUM_FSM_STATE_value = get_AUM_FSM_STATE
        If flag_CRM_FSM_STATE = &H0 Then write_CRM_FSM_STATE_value = get_CRM_FSM_STATE

        regValue = leftShift((write_MHSH_LD_FSM_STATE_value and &H7fff), 17) + leftShift((write_AUM_FSM_STATE_value and &Hff), 9) + leftShift((write_CRM_FSM_STATE_value and &H1ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_MHSH_LD_FSM_STATE_value = rightShift(data_low, 17) and &H7fff
        read_AUM_FSM_STATE_value = rightShift(data_low, 9) and &Hff
        CRM_FSM_STATE_mask = &H1ff
        if data_low > LONG_MAX then
            if CRM_FSM_STATE_mask = mask then
                read_CRM_FSM_STATE_value = data_low
            else
                read_CRM_FSM_STATE_value = (data_low - H8000_0000) and CRM_FSM_STATE_mask
            end If
        else
            read_CRM_FSM_STATE_value = data_low and CRM_FSM_STATE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_MHSH_LD_FSM_STATE_value = &H0
        flag_MHSH_LD_FSM_STATE        = &H0
        write_AUM_FSM_STATE_value = &H0
        flag_AUM_FSM_STATE        = &H0
        write_CRM_FSM_STATE_value = &H0
        flag_CRM_FSM_STATE        = &H0
    End Sub
End Class


'' @REGISTER : SPUM_AXI_axi_dbg1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CRP_FSM_STATE                              [20:11]          get_CRP_FSM_STATE
''                                                             set_CRP_FSM_STATE
''                                                             read_CRP_FSM_STATE
''                                                             write_CRP_FSM_STATE
''---------------------------------------------------------------------------------
'' AUP_FSM_STATE                              [10:0]           get_AUP_FSM_STATE
''                                                             set_AUP_FSM_STATE
''                                                             read_AUP_FSM_STATE
''                                                             write_AUP_FSM_STATE
''---------------------------------------------------------------------------------
Class REGISTER_SPUM_AXI_axi_dbg1
    Private write_CRP_FSM_STATE_value
    Private read_CRP_FSM_STATE_value
    Private flag_CRP_FSM_STATE
    Private write_AUP_FSM_STATE_value
    Private read_AUP_FSM_STATE_value
    Private flag_AUP_FSM_STATE

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

    Property Get get_CRP_FSM_STATE
        get_CRP_FSM_STATE = read_CRP_FSM_STATE_value
    End Property

    Property Let set_CRP_FSM_STATE(aData)
        write_CRP_FSM_STATE_value = aData
        flag_CRP_FSM_STATE        = &H1
    End Property

    Property Get read_CRP_FSM_STATE
        read
        read_CRP_FSM_STATE = read_CRP_FSM_STATE_value
    End Property

    Property Let write_CRP_FSM_STATE(aData)
        set_CRP_FSM_STATE = aData
        write
    End Property

    Property Get get_AUP_FSM_STATE
        get_AUP_FSM_STATE = read_AUP_FSM_STATE_value
    End Property

    Property Let set_AUP_FSM_STATE(aData)
        write_AUP_FSM_STATE_value = aData
        flag_AUP_FSM_STATE        = &H1
    End Property

    Property Get read_AUP_FSM_STATE
        read
        read_AUP_FSM_STATE = read_AUP_FSM_STATE_value
    End Property

    Property Let write_AUP_FSM_STATE(aData)
        set_AUP_FSM_STATE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CRP_FSM_STATE_value = rightShift(data_low, 11) and &H3ff
        AUP_FSM_STATE_mask = &H7ff
        if data_low > LONG_MAX then
            if AUP_FSM_STATE_mask = mask then
                read_AUP_FSM_STATE_value = data_low
            else
                read_AUP_FSM_STATE_value = (data_low - H8000_0000) and AUP_FSM_STATE_mask
            end If
        else
            read_AUP_FSM_STATE_value = data_low and AUP_FSM_STATE_mask
        end If

    End Sub

    Sub write
        If flag_CRP_FSM_STATE = &H0 or flag_AUP_FSM_STATE = &H0 Then read
        If flag_CRP_FSM_STATE = &H0 Then write_CRP_FSM_STATE_value = get_CRP_FSM_STATE
        If flag_AUP_FSM_STATE = &H0 Then write_AUP_FSM_STATE_value = get_AUP_FSM_STATE

        regValue = leftShift((write_CRP_FSM_STATE_value and &H3ff), 11) + leftShift((write_AUP_FSM_STATE_value and &H7ff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CRP_FSM_STATE_value = rightShift(data_low, 11) and &H3ff
        AUP_FSM_STATE_mask = &H7ff
        if data_low > LONG_MAX then
            if AUP_FSM_STATE_mask = mask then
                read_AUP_FSM_STATE_value = data_low
            else
                read_AUP_FSM_STATE_value = (data_low - H8000_0000) and AUP_FSM_STATE_mask
            end If
        else
            read_AUP_FSM_STATE_value = data_low and AUP_FSM_STATE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CRP_FSM_STATE_value = &H0
        flag_CRP_FSM_STATE        = &H0
        write_AUP_FSM_STATE_value = &H0
        flag_AUP_FSM_STATE        = &H0
    End Sub
End Class


'' @REGISTER : SPUM_AXI_dma_ctl
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' out_extflow                                [1:1]            get_out_extflow
''                                                             set_out_extflow
''                                                             read_out_extflow
''                                                             write_out_extflow
''---------------------------------------------------------------------------------
'' In_extflow                                 [0:0]            get_In_extflow
''                                                             set_In_extflow
''                                                             read_In_extflow
''                                                             write_In_extflow
''---------------------------------------------------------------------------------
Class REGISTER_SPUM_AXI_dma_ctl
    Private write_out_extflow_value
    Private read_out_extflow_value
    Private flag_out_extflow
    Private write_In_extflow_value
    Private read_In_extflow_value
    Private flag_In_extflow

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

    Property Get get_out_extflow
        get_out_extflow = read_out_extflow_value
    End Property

    Property Let set_out_extflow(aData)
        write_out_extflow_value = aData
        flag_out_extflow        = &H1
    End Property

    Property Get read_out_extflow
        read
        read_out_extflow = read_out_extflow_value
    End Property

    Property Let write_out_extflow(aData)
        set_out_extflow = aData
        write
    End Property

    Property Get get_In_extflow
        get_In_extflow = read_In_extflow_value
    End Property

    Property Let set_In_extflow(aData)
        write_In_extflow_value = aData
        flag_In_extflow        = &H1
    End Property

    Property Get read_In_extflow
        read
        read_In_extflow = read_In_extflow_value
    End Property

    Property Let write_In_extflow(aData)
        set_In_extflow = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_out_extflow_value = rightShift(data_low, 1) and &H1
        In_extflow_mask = &H1
        if data_low > LONG_MAX then
            if In_extflow_mask = mask then
                read_In_extflow_value = data_low
            else
                read_In_extflow_value = (data_low - H8000_0000) and In_extflow_mask
            end If
        else
            read_In_extflow_value = data_low and In_extflow_mask
        end If

    End Sub

    Sub write
        If flag_out_extflow = &H0 or flag_In_extflow = &H0 Then read
        If flag_out_extflow = &H0 Then write_out_extflow_value = get_out_extflow
        If flag_In_extflow = &H0 Then write_In_extflow_value = get_In_extflow

        regValue = leftShift((write_out_extflow_value and &H1), 1) + leftShift((write_In_extflow_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_out_extflow_value = rightShift(data_low, 1) and &H1
        In_extflow_mask = &H1
        if data_low > LONG_MAX then
            if In_extflow_mask = mask then
                read_In_extflow_value = data_low
            else
                read_In_extflow_value = (data_low - H8000_0000) and In_extflow_mask
            end If
        else
            read_In_extflow_value = data_low and In_extflow_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_out_extflow_value = &H0
        flag_out_extflow        = &H0
        write_In_extflow_value = &H0
        flag_In_extflow        = &H0
    End Sub
End Class


'' @REGISTER : SPUM_AXI_dma_stat
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' pkt_clear                                  [3:3]            get_pkt_clear
''                                                             set_pkt_clear
''                                                             read_pkt_clear
''                                                             write_pkt_clear
''---------------------------------------------------------------------------------
'' pkt_done                                   [2:2]            get_pkt_done
''                                                             set_pkt_done
''                                                             read_pkt_done
''                                                             write_pkt_done
''---------------------------------------------------------------------------------
'' pkt_busy                                   [1:1]            get_pkt_busy
''                                                             set_pkt_busy
''                                                             read_pkt_busy
''                                                             write_pkt_busy
''---------------------------------------------------------------------------------
'' pkt_start                                  [0:0]            get_pkt_start
''                                                             set_pkt_start
''                                                             read_pkt_start
''                                                             write_pkt_start
''---------------------------------------------------------------------------------
Class REGISTER_SPUM_AXI_dma_stat
    Private write_pkt_clear_value
    Private read_pkt_clear_value
    Private flag_pkt_clear
    Private write_pkt_done_value
    Private read_pkt_done_value
    Private flag_pkt_done
    Private write_pkt_busy_value
    Private read_pkt_busy_value
    Private flag_pkt_busy
    Private write_pkt_start_value
    Private read_pkt_start_value
    Private flag_pkt_start

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

    Property Get get_pkt_clear
        get_pkt_clear = read_pkt_clear_value
    End Property

    Property Let set_pkt_clear(aData)
        write_pkt_clear_value = aData
        flag_pkt_clear        = &H1
    End Property

    Property Get read_pkt_clear
        read
        read_pkt_clear = read_pkt_clear_value
    End Property

    Property Let write_pkt_clear(aData)
        set_pkt_clear = aData
        write
    End Property

    Property Get get_pkt_done
        get_pkt_done = read_pkt_done_value
    End Property

    Property Let set_pkt_done(aData)
        write_pkt_done_value = aData
        flag_pkt_done        = &H1
    End Property

    Property Get read_pkt_done
        read
        read_pkt_done = read_pkt_done_value
    End Property

    Property Let write_pkt_done(aData)
        set_pkt_done = aData
        write
    End Property

    Property Get get_pkt_busy
        get_pkt_busy = read_pkt_busy_value
    End Property

    Property Let set_pkt_busy(aData)
        write_pkt_busy_value = aData
        flag_pkt_busy        = &H1
    End Property

    Property Get read_pkt_busy
        read
        read_pkt_busy = read_pkt_busy_value
    End Property

    Property Let write_pkt_busy(aData)
        set_pkt_busy = aData
        write
    End Property

    Property Get get_pkt_start
        get_pkt_start = read_pkt_start_value
    End Property

    Property Let set_pkt_start(aData)
        write_pkt_start_value = aData
        flag_pkt_start        = &H1
    End Property

    Property Get read_pkt_start
        read
        read_pkt_start = read_pkt_start_value
    End Property

    Property Let write_pkt_start(aData)
        set_pkt_start = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_pkt_clear_value = rightShift(data_low, 3) and &H1
        read_pkt_done_value = rightShift(data_low, 2) and &H1
        read_pkt_busy_value = rightShift(data_low, 1) and &H1
        pkt_start_mask = &H1
        if data_low > LONG_MAX then
            if pkt_start_mask = mask then
                read_pkt_start_value = data_low
            else
                read_pkt_start_value = (data_low - H8000_0000) and pkt_start_mask
            end If
        else
            read_pkt_start_value = data_low and pkt_start_mask
        end If

    End Sub

    Sub write
        If flag_pkt_clear = &H0 or flag_pkt_done = &H0 or flag_pkt_busy = &H0 or flag_pkt_start = &H0 Then read
        If flag_pkt_clear = &H0 Then write_pkt_clear_value = get_pkt_clear
        If flag_pkt_done = &H0 Then write_pkt_done_value = get_pkt_done
        If flag_pkt_busy = &H0 Then write_pkt_busy_value = get_pkt_busy
        If flag_pkt_start = &H0 Then write_pkt_start_value = get_pkt_start

        regValue = leftShift((write_pkt_clear_value and &H1), 3) + leftShift((write_pkt_done_value and &H1), 2) + leftShift((write_pkt_busy_value and &H1), 1) + leftShift((write_pkt_start_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_pkt_clear_value = rightShift(data_low, 3) and &H1
        read_pkt_done_value = rightShift(data_low, 2) and &H1
        read_pkt_busy_value = rightShift(data_low, 1) and &H1
        pkt_start_mask = &H1
        if data_low > LONG_MAX then
            if pkt_start_mask = mask then
                read_pkt_start_value = data_low
            else
                read_pkt_start_value = (data_low - H8000_0000) and pkt_start_mask
            end If
        else
            read_pkt_start_value = data_low and pkt_start_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_pkt_clear_value = &H0
        flag_pkt_clear        = &H0
        write_pkt_done_value = &H0
        flag_pkt_done        = &H0
        write_pkt_busy_value = &H0
        flag_pkt_busy        = &H0
        write_pkt_start_value = &H0
        flag_pkt_start        = &H0
    End Sub
End Class


'' @REGISTER : SPUM_AXI_in_dma_size
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' iflow_pktsize                              [31:0]           get_iflow_pktsize
''                                                             set_iflow_pktsize
''                                                             read_iflow_pktsize
''                                                             write_iflow_pktsize
''---------------------------------------------------------------------------------
Class REGISTER_SPUM_AXI_in_dma_size
    Private write_iflow_pktsize_value
    Private read_iflow_pktsize_value
    Private flag_iflow_pktsize

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

    Property Get get_iflow_pktsize
        get_iflow_pktsize = read_iflow_pktsize_value
    End Property

    Property Let set_iflow_pktsize(aData)
        write_iflow_pktsize_value = aData
        flag_iflow_pktsize        = &H1
    End Property

    Property Get read_iflow_pktsize
        read
        read_iflow_pktsize = read_iflow_pktsize_value
    End Property

    Property Let write_iflow_pktsize(aData)
        set_iflow_pktsize = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        iflow_pktsize_mask = &Hffffffff
        if data_low > LONG_MAX then
            if iflow_pktsize_mask = mask then
                read_iflow_pktsize_value = data_low
            else
                read_iflow_pktsize_value = (data_low - H8000_0000) and iflow_pktsize_mask
            end If
        else
            read_iflow_pktsize_value = data_low and iflow_pktsize_mask
        end If

    End Sub

    Sub write
        If flag_iflow_pktsize = &H0 Then read
        If flag_iflow_pktsize = &H0 Then write_iflow_pktsize_value = get_iflow_pktsize

        regValue = leftShift(write_iflow_pktsize_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        iflow_pktsize_mask = &Hffffffff
        if data_low > LONG_MAX then
            if iflow_pktsize_mask = mask then
                read_iflow_pktsize_value = data_low
            else
                read_iflow_pktsize_value = (data_low - H8000_0000) and iflow_pktsize_mask
            end If
        else
            read_iflow_pktsize_value = data_low and iflow_pktsize_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_iflow_pktsize_value = &H0
        flag_iflow_pktsize        = &H0
    End Sub
End Class


'' @REGISTER : SPUM_AXI_out_dma_size
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' oflow_pktsize                              [31:0]           get_oflow_pktsize
''                                                             set_oflow_pktsize
''                                                             read_oflow_pktsize
''                                                             write_oflow_pktsize
''---------------------------------------------------------------------------------
Class REGISTER_SPUM_AXI_out_dma_size
    Private write_oflow_pktsize_value
    Private read_oflow_pktsize_value
    Private flag_oflow_pktsize

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

    Property Get get_oflow_pktsize
        get_oflow_pktsize = read_oflow_pktsize_value
    End Property

    Property Let set_oflow_pktsize(aData)
        write_oflow_pktsize_value = aData
        flag_oflow_pktsize        = &H1
    End Property

    Property Get read_oflow_pktsize
        read
        read_oflow_pktsize = read_oflow_pktsize_value
    End Property

    Property Let write_oflow_pktsize(aData)
        set_oflow_pktsize = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        oflow_pktsize_mask = &Hffffffff
        if data_low > LONG_MAX then
            if oflow_pktsize_mask = mask then
                read_oflow_pktsize_value = data_low
            else
                read_oflow_pktsize_value = (data_low - H8000_0000) and oflow_pktsize_mask
            end If
        else
            read_oflow_pktsize_value = data_low and oflow_pktsize_mask
        end If

    End Sub

    Sub write
        If flag_oflow_pktsize = &H0 Then read
        If flag_oflow_pktsize = &H0 Then write_oflow_pktsize_value = get_oflow_pktsize

        regValue = leftShift(write_oflow_pktsize_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        oflow_pktsize_mask = &Hffffffff
        if data_low > LONG_MAX then
            if oflow_pktsize_mask = mask then
                read_oflow_pktsize_value = data_low
            else
                read_oflow_pktsize_value = (data_low - H8000_0000) and oflow_pktsize_mask
            end If
        else
            read_oflow_pktsize_value = data_low and oflow_pktsize_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_oflow_pktsize_value = &H0
        flag_oflow_pktsize        = &H0
    End Sub
End Class


'' @REGISTER : SPUM_AXI_fifo_stat
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ofifo_lvl                                  [22:17]          get_ofifo_lvl
''                                                             set_ofifo_lvl
''                                                             read_ofifo_lvl
''                                                             write_ofifo_lvl
''---------------------------------------------------------------------------------
'' ofifo_rdy                                  [16:16]          get_ofifo_rdy
''                                                             set_ofifo_rdy
''                                                             read_ofifo_rdy
''                                                             write_ofifo_rdy
''---------------------------------------------------------------------------------
'' ififo_space                                [6:1]            get_ififo_space
''                                                             set_ififo_space
''                                                             read_ififo_space
''                                                             write_ififo_space
''---------------------------------------------------------------------------------
'' ififo_rdy                                  [0:0]            get_ififo_rdy
''                                                             set_ififo_rdy
''                                                             read_ififo_rdy
''                                                             write_ififo_rdy
''---------------------------------------------------------------------------------
Class REGISTER_SPUM_AXI_fifo_stat
    Private write_ofifo_lvl_value
    Private read_ofifo_lvl_value
    Private flag_ofifo_lvl
    Private write_ofifo_rdy_value
    Private read_ofifo_rdy_value
    Private flag_ofifo_rdy
    Private write_ififo_space_value
    Private read_ififo_space_value
    Private flag_ififo_space
    Private write_ififo_rdy_value
    Private read_ififo_rdy_value
    Private flag_ififo_rdy

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

    Property Get get_ofifo_lvl
        get_ofifo_lvl = read_ofifo_lvl_value
    End Property

    Property Let set_ofifo_lvl(aData)
        write_ofifo_lvl_value = aData
        flag_ofifo_lvl        = &H1
    End Property

    Property Get read_ofifo_lvl
        read
        read_ofifo_lvl = read_ofifo_lvl_value
    End Property

    Property Let write_ofifo_lvl(aData)
        set_ofifo_lvl = aData
        write
    End Property

    Property Get get_ofifo_rdy
        get_ofifo_rdy = read_ofifo_rdy_value
    End Property

    Property Let set_ofifo_rdy(aData)
        write_ofifo_rdy_value = aData
        flag_ofifo_rdy        = &H1
    End Property

    Property Get read_ofifo_rdy
        read
        read_ofifo_rdy = read_ofifo_rdy_value
    End Property

    Property Let write_ofifo_rdy(aData)
        set_ofifo_rdy = aData
        write
    End Property

    Property Get get_ififo_space
        get_ififo_space = read_ififo_space_value
    End Property

    Property Let set_ififo_space(aData)
        write_ififo_space_value = aData
        flag_ififo_space        = &H1
    End Property

    Property Get read_ififo_space
        read
        read_ififo_space = read_ififo_space_value
    End Property

    Property Let write_ififo_space(aData)
        set_ififo_space = aData
        write
    End Property

    Property Get get_ififo_rdy
        get_ififo_rdy = read_ififo_rdy_value
    End Property

    Property Let set_ififo_rdy(aData)
        write_ififo_rdy_value = aData
        flag_ififo_rdy        = &H1
    End Property

    Property Get read_ififo_rdy
        read
        read_ififo_rdy = read_ififo_rdy_value
    End Property

    Property Let write_ififo_rdy(aData)
        set_ififo_rdy = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ofifo_lvl_value = rightShift(data_low, 17) and &H3f
        read_ofifo_rdy_value = rightShift(data_low, 16) and &H1
        read_ififo_space_value = rightShift(data_low, 1) and &H3f
        ififo_rdy_mask = &H1
        if data_low > LONG_MAX then
            if ififo_rdy_mask = mask then
                read_ififo_rdy_value = data_low
            else
                read_ififo_rdy_value = (data_low - H8000_0000) and ififo_rdy_mask
            end If
        else
            read_ififo_rdy_value = data_low and ififo_rdy_mask
        end If

    End Sub

    Sub write
        If flag_ofifo_lvl = &H0 or flag_ofifo_rdy = &H0 or flag_ififo_space = &H0 or flag_ififo_rdy = &H0 Then read
        If flag_ofifo_lvl = &H0 Then write_ofifo_lvl_value = get_ofifo_lvl
        If flag_ofifo_rdy = &H0 Then write_ofifo_rdy_value = get_ofifo_rdy
        If flag_ififo_space = &H0 Then write_ififo_space_value = get_ififo_space
        If flag_ififo_rdy = &H0 Then write_ififo_rdy_value = get_ififo_rdy

        regValue = leftShift((write_ofifo_lvl_value and &H3f), 17) + leftShift((write_ofifo_rdy_value and &H1), 16) + leftShift((write_ififo_space_value and &H3f), 1) + leftShift((write_ififo_rdy_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_ofifo_lvl_value = rightShift(data_low, 17) and &H3f
        read_ofifo_rdy_value = rightShift(data_low, 16) and &H1
        read_ififo_space_value = rightShift(data_low, 1) and &H3f
        ififo_rdy_mask = &H1
        if data_low > LONG_MAX then
            if ififo_rdy_mask = mask then
                read_ififo_rdy_value = data_low
            else
                read_ififo_rdy_value = (data_low - H8000_0000) and ififo_rdy_mask
            end If
        else
            read_ififo_rdy_value = data_low and ififo_rdy_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ofifo_lvl_value = &H0
        flag_ofifo_lvl        = &H0
        write_ofifo_rdy_value = &H0
        flag_ofifo_rdy        = &H0
        write_ififo_space_value = &H0
        flag_ififo_space        = &H0
        write_ififo_rdy_value = &H0
        flag_ififo_rdy        = &H0
    End Sub
End Class


'' @REGISTER : SPUM_AXI_fifo_in
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' spm_fifo_in                                [31:0]           get_spm_fifo_in
''                                                             set_spm_fifo_in
''                                                             read_spm_fifo_in
''                                                             write_spm_fifo_in
''---------------------------------------------------------------------------------
Class REGISTER_SPUM_AXI_fifo_in
    Private write_spm_fifo_in_value
    Private read_spm_fifo_in_value
    Private flag_spm_fifo_in

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

    Property Get get_spm_fifo_in
        get_spm_fifo_in = read_spm_fifo_in_value
    End Property

    Property Let set_spm_fifo_in(aData)
        write_spm_fifo_in_value = aData
        flag_spm_fifo_in        = &H1
    End Property

    Property Get read_spm_fifo_in
        read
        read_spm_fifo_in = read_spm_fifo_in_value
    End Property

    Property Let write_spm_fifo_in(aData)
        set_spm_fifo_in = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spm_fifo_in_mask = &Hffffffff
        if data_low > LONG_MAX then
            if spm_fifo_in_mask = mask then
                read_spm_fifo_in_value = data_low
            else
                read_spm_fifo_in_value = (data_low - H8000_0000) and spm_fifo_in_mask
            end If
        else
            read_spm_fifo_in_value = data_low and spm_fifo_in_mask
        end If

    End Sub

    Sub write
        If flag_spm_fifo_in = &H0 Then read
        If flag_spm_fifo_in = &H0 Then write_spm_fifo_in_value = get_spm_fifo_in

        regValue = leftShift(write_spm_fifo_in_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spm_fifo_in_mask = &Hffffffff
        if data_low > LONG_MAX then
            if spm_fifo_in_mask = mask then
                read_spm_fifo_in_value = data_low
            else
                read_spm_fifo_in_value = (data_low - H8000_0000) and spm_fifo_in_mask
            end If
        else
            read_spm_fifo_in_value = data_low and spm_fifo_in_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_spm_fifo_in_value = &H0
        flag_spm_fifo_in        = &H0
    End Sub
End Class


'' @REGISTER : SPUM_AXI_fifo_out
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' spm_fifo_out                               [31:0]           get_spm_fifo_out
''                                                             set_spm_fifo_out
''                                                             read_spm_fifo_out
''                                                             write_spm_fifo_out
''---------------------------------------------------------------------------------
Class REGISTER_SPUM_AXI_fifo_out
    Private write_spm_fifo_out_value
    Private read_spm_fifo_out_value
    Private flag_spm_fifo_out

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

    Property Get get_spm_fifo_out
        get_spm_fifo_out = read_spm_fifo_out_value
    End Property

    Property Let set_spm_fifo_out(aData)
        write_spm_fifo_out_value = aData
        flag_spm_fifo_out        = &H1
    End Property

    Property Get read_spm_fifo_out
        read
        read_spm_fifo_out = read_spm_fifo_out_value
    End Property

    Property Let write_spm_fifo_out(aData)
        set_spm_fifo_out = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spm_fifo_out_mask = &Hffffffff
        if data_low > LONG_MAX then
            if spm_fifo_out_mask = mask then
                read_spm_fifo_out_value = data_low
            else
                read_spm_fifo_out_value = (data_low - H8000_0000) and spm_fifo_out_mask
            end If
        else
            read_spm_fifo_out_value = data_low and spm_fifo_out_mask
        end If

    End Sub

    Sub write
        If flag_spm_fifo_out = &H0 Then read
        If flag_spm_fifo_out = &H0 Then write_spm_fifo_out_value = get_spm_fifo_out

        regValue = leftShift(write_spm_fifo_out_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        spm_fifo_out_mask = &Hffffffff
        if data_low > LONG_MAX then
            if spm_fifo_out_mask = mask then
                read_spm_fifo_out_value = data_low
            else
                read_spm_fifo_out_value = (data_low - H8000_0000) and spm_fifo_out_mask
            end If
        else
            read_spm_fifo_out_value = data_low and spm_fifo_out_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_spm_fifo_out_value = &H0
        flag_spm_fifo_out        = &H0
    End Sub
End Class


'' @REGISTER : SPUM_AXI_axi_dbg2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PA_FSM_STATE                               [29:20]          get_PA_FSM_STATE
''                                                             set_PA_FSM_STATE
''                                                             read_PA_FSM_STATE
''                                                             write_PA_FSM_STATE
''---------------------------------------------------------------------------------
'' PP_FSM_STATE                               [19:11]          get_PP_FSM_STATE
''                                                             set_PP_FSM_STATE
''                                                             read_PP_FSM_STATE
''                                                             write_PP_FSM_STATE
''---------------------------------------------------------------------------------
'' XB_FSM_STATE                               [10:6]           get_XB_FSM_STATE
''                                                             set_XB_FSM_STATE
''                                                             read_XB_FSM_STATE
''                                                             write_XB_FSM_STATE
''---------------------------------------------------------------------------------
'' KEK_FSM_STATE                              [5:3]            get_KEK_FSM_STATE
''                                                             set_KEK_FSM_STATE
''                                                             read_KEK_FSM_STATE
''                                                             write_KEK_FSM_STATE
''---------------------------------------------------------------------------------
'' KEY_MEM_FSM_STATE                          [2:0]            get_KEY_MEM_FSM_STATE
''                                                             set_KEY_MEM_FSM_STATE
''                                                             read_KEY_MEM_FSM_STATE
''                                                             write_KEY_MEM_FSM_STATE
''---------------------------------------------------------------------------------
Class REGISTER_SPUM_AXI_axi_dbg2
    Private write_PA_FSM_STATE_value
    Private read_PA_FSM_STATE_value
    Private flag_PA_FSM_STATE
    Private write_PP_FSM_STATE_value
    Private read_PP_FSM_STATE_value
    Private flag_PP_FSM_STATE
    Private write_XB_FSM_STATE_value
    Private read_XB_FSM_STATE_value
    Private flag_XB_FSM_STATE
    Private write_KEK_FSM_STATE_value
    Private read_KEK_FSM_STATE_value
    Private flag_KEK_FSM_STATE
    Private write_KEY_MEM_FSM_STATE_value
    Private read_KEY_MEM_FSM_STATE_value
    Private flag_KEY_MEM_FSM_STATE

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

    Property Get get_PA_FSM_STATE
        get_PA_FSM_STATE = read_PA_FSM_STATE_value
    End Property

    Property Let set_PA_FSM_STATE(aData)
        write_PA_FSM_STATE_value = aData
        flag_PA_FSM_STATE        = &H1
    End Property

    Property Get read_PA_FSM_STATE
        read
        read_PA_FSM_STATE = read_PA_FSM_STATE_value
    End Property

    Property Let write_PA_FSM_STATE(aData)
        set_PA_FSM_STATE = aData
        write
    End Property

    Property Get get_PP_FSM_STATE
        get_PP_FSM_STATE = read_PP_FSM_STATE_value
    End Property

    Property Let set_PP_FSM_STATE(aData)
        write_PP_FSM_STATE_value = aData
        flag_PP_FSM_STATE        = &H1
    End Property

    Property Get read_PP_FSM_STATE
        read
        read_PP_FSM_STATE = read_PP_FSM_STATE_value
    End Property

    Property Let write_PP_FSM_STATE(aData)
        set_PP_FSM_STATE = aData
        write
    End Property

    Property Get get_XB_FSM_STATE
        get_XB_FSM_STATE = read_XB_FSM_STATE_value
    End Property

    Property Let set_XB_FSM_STATE(aData)
        write_XB_FSM_STATE_value = aData
        flag_XB_FSM_STATE        = &H1
    End Property

    Property Get read_XB_FSM_STATE
        read
        read_XB_FSM_STATE = read_XB_FSM_STATE_value
    End Property

    Property Let write_XB_FSM_STATE(aData)
        set_XB_FSM_STATE = aData
        write
    End Property

    Property Get get_KEK_FSM_STATE
        get_KEK_FSM_STATE = read_KEK_FSM_STATE_value
    End Property

    Property Let set_KEK_FSM_STATE(aData)
        write_KEK_FSM_STATE_value = aData
        flag_KEK_FSM_STATE        = &H1
    End Property

    Property Get read_KEK_FSM_STATE
        read
        read_KEK_FSM_STATE = read_KEK_FSM_STATE_value
    End Property

    Property Let write_KEK_FSM_STATE(aData)
        set_KEK_FSM_STATE = aData
        write
    End Property

    Property Get get_KEY_MEM_FSM_STATE
        get_KEY_MEM_FSM_STATE = read_KEY_MEM_FSM_STATE_value
    End Property

    Property Let set_KEY_MEM_FSM_STATE(aData)
        write_KEY_MEM_FSM_STATE_value = aData
        flag_KEY_MEM_FSM_STATE        = &H1
    End Property

    Property Get read_KEY_MEM_FSM_STATE
        read
        read_KEY_MEM_FSM_STATE = read_KEY_MEM_FSM_STATE_value
    End Property

    Property Let write_KEY_MEM_FSM_STATE(aData)
        set_KEY_MEM_FSM_STATE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PA_FSM_STATE_value = rightShift(data_low, 20) and &H3ff
        read_PP_FSM_STATE_value = rightShift(data_low, 11) and &H1ff
        read_XB_FSM_STATE_value = rightShift(data_low, 6) and &H1f
        read_KEK_FSM_STATE_value = rightShift(data_low, 3) and &H7
        KEY_MEM_FSM_STATE_mask = &H7
        if data_low > LONG_MAX then
            if KEY_MEM_FSM_STATE_mask = mask then
                read_KEY_MEM_FSM_STATE_value = data_low
            else
                read_KEY_MEM_FSM_STATE_value = (data_low - H8000_0000) and KEY_MEM_FSM_STATE_mask
            end If
        else
            read_KEY_MEM_FSM_STATE_value = data_low and KEY_MEM_FSM_STATE_mask
        end If

    End Sub

    Sub write
        If flag_PA_FSM_STATE = &H0 or flag_PP_FSM_STATE = &H0 or flag_XB_FSM_STATE = &H0 or flag_KEK_FSM_STATE = &H0 or flag_KEY_MEM_FSM_STATE = &H0 Then read
        If flag_PA_FSM_STATE = &H0 Then write_PA_FSM_STATE_value = get_PA_FSM_STATE
        If flag_PP_FSM_STATE = &H0 Then write_PP_FSM_STATE_value = get_PP_FSM_STATE
        If flag_XB_FSM_STATE = &H0 Then write_XB_FSM_STATE_value = get_XB_FSM_STATE
        If flag_KEK_FSM_STATE = &H0 Then write_KEK_FSM_STATE_value = get_KEK_FSM_STATE
        If flag_KEY_MEM_FSM_STATE = &H0 Then write_KEY_MEM_FSM_STATE_value = get_KEY_MEM_FSM_STATE

        regValue = leftShift((write_PA_FSM_STATE_value and &H3ff), 20) + leftShift((write_PP_FSM_STATE_value and &H1ff), 11) + leftShift((write_XB_FSM_STATE_value and &H1f), 6) + leftShift((write_KEK_FSM_STATE_value and &H7), 3) + leftShift((write_KEY_MEM_FSM_STATE_value and &H7), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_PA_FSM_STATE_value = rightShift(data_low, 20) and &H3ff
        read_PP_FSM_STATE_value = rightShift(data_low, 11) and &H1ff
        read_XB_FSM_STATE_value = rightShift(data_low, 6) and &H1f
        read_KEK_FSM_STATE_value = rightShift(data_low, 3) and &H7
        KEY_MEM_FSM_STATE_mask = &H7
        if data_low > LONG_MAX then
            if KEY_MEM_FSM_STATE_mask = mask then
                read_KEY_MEM_FSM_STATE_value = data_low
            else
                read_KEY_MEM_FSM_STATE_value = (data_low - H8000_0000) and KEY_MEM_FSM_STATE_mask
            end If
        else
            read_KEY_MEM_FSM_STATE_value = data_low and KEY_MEM_FSM_STATE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PA_FSM_STATE_value = &H0
        flag_PA_FSM_STATE        = &H0
        write_PP_FSM_STATE_value = &H0
        flag_PP_FSM_STATE        = &H0
        write_XB_FSM_STATE_value = &H0
        flag_XB_FSM_STATE        = &H0
        write_KEK_FSM_STATE_value = &H0
        flag_KEK_FSM_STATE        = &H0
        write_KEY_MEM_FSM_STATE_value = &H0
        flag_KEY_MEM_FSM_STATE        = &H0
    End Sub
End Class


'' @REGISTER : SPUM_AXI_axi_dbg3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RC4_FSM_STATE                              [31:21]          get_RC4_FSM_STATE
''                                                             set_RC4_FSM_STATE
''                                                             read_RC4_FSM_STATE
''                                                             write_RC4_FSM_STATE
''---------------------------------------------------------------------------------
'' EAES_CMD_FSM_STATE                         [20:18]          get_EAES_CMD_FSM_STATE
''                                                             set_EAES_CMD_FSM_STATE
''                                                             read_EAES_CMD_FSM_STATE
''                                                             write_EAES_CMD_FSM_STATE
''---------------------------------------------------------------------------------
'' EAES_RND_FSM_STATE                         [17:7]           get_EAES_RND_FSM_STATE
''                                                             set_EAES_RND_FSM_STATE
''                                                             read_EAES_RND_FSM_STATE
''                                                             write_EAES_RND_FSM_STATE
''---------------------------------------------------------------------------------
'' EAES_KEY_FSM_STATE                         [6:0]            get_EAES_KEY_FSM_STATE
''                                                             set_EAES_KEY_FSM_STATE
''                                                             read_EAES_KEY_FSM_STATE
''                                                             write_EAES_KEY_FSM_STATE
''---------------------------------------------------------------------------------
Class REGISTER_SPUM_AXI_axi_dbg3
    Private write_RC4_FSM_STATE_value
    Private read_RC4_FSM_STATE_value
    Private flag_RC4_FSM_STATE
    Private write_EAES_CMD_FSM_STATE_value
    Private read_EAES_CMD_FSM_STATE_value
    Private flag_EAES_CMD_FSM_STATE
    Private write_EAES_RND_FSM_STATE_value
    Private read_EAES_RND_FSM_STATE_value
    Private flag_EAES_RND_FSM_STATE
    Private write_EAES_KEY_FSM_STATE_value
    Private read_EAES_KEY_FSM_STATE_value
    Private flag_EAES_KEY_FSM_STATE

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

    Property Get get_RC4_FSM_STATE
        get_RC4_FSM_STATE = read_RC4_FSM_STATE_value
    End Property

    Property Let set_RC4_FSM_STATE(aData)
        write_RC4_FSM_STATE_value = aData
        flag_RC4_FSM_STATE        = &H1
    End Property

    Property Get read_RC4_FSM_STATE
        read
        read_RC4_FSM_STATE = read_RC4_FSM_STATE_value
    End Property

    Property Let write_RC4_FSM_STATE(aData)
        set_RC4_FSM_STATE = aData
        write
    End Property

    Property Get get_EAES_CMD_FSM_STATE
        get_EAES_CMD_FSM_STATE = read_EAES_CMD_FSM_STATE_value
    End Property

    Property Let set_EAES_CMD_FSM_STATE(aData)
        write_EAES_CMD_FSM_STATE_value = aData
        flag_EAES_CMD_FSM_STATE        = &H1
    End Property

    Property Get read_EAES_CMD_FSM_STATE
        read
        read_EAES_CMD_FSM_STATE = read_EAES_CMD_FSM_STATE_value
    End Property

    Property Let write_EAES_CMD_FSM_STATE(aData)
        set_EAES_CMD_FSM_STATE = aData
        write
    End Property

    Property Get get_EAES_RND_FSM_STATE
        get_EAES_RND_FSM_STATE = read_EAES_RND_FSM_STATE_value
    End Property

    Property Let set_EAES_RND_FSM_STATE(aData)
        write_EAES_RND_FSM_STATE_value = aData
        flag_EAES_RND_FSM_STATE        = &H1
    End Property

    Property Get read_EAES_RND_FSM_STATE
        read
        read_EAES_RND_FSM_STATE = read_EAES_RND_FSM_STATE_value
    End Property

    Property Let write_EAES_RND_FSM_STATE(aData)
        set_EAES_RND_FSM_STATE = aData
        write
    End Property

    Property Get get_EAES_KEY_FSM_STATE
        get_EAES_KEY_FSM_STATE = read_EAES_KEY_FSM_STATE_value
    End Property

    Property Let set_EAES_KEY_FSM_STATE(aData)
        write_EAES_KEY_FSM_STATE_value = aData
        flag_EAES_KEY_FSM_STATE        = &H1
    End Property

    Property Get read_EAES_KEY_FSM_STATE
        read
        read_EAES_KEY_FSM_STATE = read_EAES_KEY_FSM_STATE_value
    End Property

    Property Let write_EAES_KEY_FSM_STATE(aData)
        set_EAES_KEY_FSM_STATE = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RC4_FSM_STATE_value = rightShift(data_low, 21) and &H7ff
        read_EAES_CMD_FSM_STATE_value = rightShift(data_low, 18) and &H7
        read_EAES_RND_FSM_STATE_value = rightShift(data_low, 7) and &H7ff
        EAES_KEY_FSM_STATE_mask = &H7f
        if data_low > LONG_MAX then
            if EAES_KEY_FSM_STATE_mask = mask then
                read_EAES_KEY_FSM_STATE_value = data_low
            else
                read_EAES_KEY_FSM_STATE_value = (data_low - H8000_0000) and EAES_KEY_FSM_STATE_mask
            end If
        else
            read_EAES_KEY_FSM_STATE_value = data_low and EAES_KEY_FSM_STATE_mask
        end If

    End Sub

    Sub write
        If flag_RC4_FSM_STATE = &H0 or flag_EAES_CMD_FSM_STATE = &H0 or flag_EAES_RND_FSM_STATE = &H0 or flag_EAES_KEY_FSM_STATE = &H0 Then read
        If flag_RC4_FSM_STATE = &H0 Then write_RC4_FSM_STATE_value = get_RC4_FSM_STATE
        If flag_EAES_CMD_FSM_STATE = &H0 Then write_EAES_CMD_FSM_STATE_value = get_EAES_CMD_FSM_STATE
        If flag_EAES_RND_FSM_STATE = &H0 Then write_EAES_RND_FSM_STATE_value = get_EAES_RND_FSM_STATE
        If flag_EAES_KEY_FSM_STATE = &H0 Then write_EAES_KEY_FSM_STATE_value = get_EAES_KEY_FSM_STATE

        regValue = leftShift((write_RC4_FSM_STATE_value and &H7ff), 21) + leftShift((write_EAES_CMD_FSM_STATE_value and &H7), 18) + leftShift((write_EAES_RND_FSM_STATE_value and &H7ff), 7) + leftShift((write_EAES_KEY_FSM_STATE_value and &H7f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RC4_FSM_STATE_value = rightShift(data_low, 21) and &H7ff
        read_EAES_CMD_FSM_STATE_value = rightShift(data_low, 18) and &H7
        read_EAES_RND_FSM_STATE_value = rightShift(data_low, 7) and &H7ff
        EAES_KEY_FSM_STATE_mask = &H7f
        if data_low > LONG_MAX then
            if EAES_KEY_FSM_STATE_mask = mask then
                read_EAES_KEY_FSM_STATE_value = data_low
            else
                read_EAES_KEY_FSM_STATE_value = (data_low - H8000_0000) and EAES_KEY_FSM_STATE_mask
            end If
        else
            read_EAES_KEY_FSM_STATE_value = data_low and EAES_KEY_FSM_STATE_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RC4_FSM_STATE_value = &H0
        flag_RC4_FSM_STATE        = &H0
        write_EAES_CMD_FSM_STATE_value = &H0
        flag_EAES_CMD_FSM_STATE        = &H0
        write_EAES_RND_FSM_STATE_value = &H0
        flag_EAES_RND_FSM_STATE        = &H0
        write_EAES_KEY_FSM_STATE_value = &H0
        flag_EAES_KEY_FSM_STATE        = &H0
    End Sub
End Class


'' @REGISTER : SPUM_AXI_axi_dbg4
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' IN_FIFO_WATERMARK                          [21:15]          get_IN_FIFO_WATERMARK
''                                                             set_IN_FIFO_WATERMARK
''                                                             read_IN_FIFO_WATERMARK
''                                                             write_IN_FIFO_WATERMARK
''---------------------------------------------------------------------------------
'' OUT_FIFO_WATERMARK                         [14:8]           get_OUT_FIFO_WATERMARK
''                                                             set_OUT_FIFO_WATERMARK
''                                                             read_OUT_FIFO_WATERMARK
''                                                             write_OUT_FIFO_WATERMARK
''---------------------------------------------------------------------------------
'' PA_FIFO_WATERMARK                          [7:0]            get_PA_FIFO_WATERMARK
''                                                             set_PA_FIFO_WATERMARK
''                                                             read_PA_FIFO_WATERMARK
''                                                             write_PA_FIFO_WATERMARK
''---------------------------------------------------------------------------------
Class REGISTER_SPUM_AXI_axi_dbg4
    Private write_IN_FIFO_WATERMARK_value
    Private read_IN_FIFO_WATERMARK_value
    Private flag_IN_FIFO_WATERMARK
    Private write_OUT_FIFO_WATERMARK_value
    Private read_OUT_FIFO_WATERMARK_value
    Private flag_OUT_FIFO_WATERMARK
    Private write_PA_FIFO_WATERMARK_value
    Private read_PA_FIFO_WATERMARK_value
    Private flag_PA_FIFO_WATERMARK

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

    Property Get get_IN_FIFO_WATERMARK
        get_IN_FIFO_WATERMARK = read_IN_FIFO_WATERMARK_value
    End Property

    Property Let set_IN_FIFO_WATERMARK(aData)
        write_IN_FIFO_WATERMARK_value = aData
        flag_IN_FIFO_WATERMARK        = &H1
    End Property

    Property Get read_IN_FIFO_WATERMARK
        read
        read_IN_FIFO_WATERMARK = read_IN_FIFO_WATERMARK_value
    End Property

    Property Let write_IN_FIFO_WATERMARK(aData)
        set_IN_FIFO_WATERMARK = aData
        write
    End Property

    Property Get get_OUT_FIFO_WATERMARK
        get_OUT_FIFO_WATERMARK = read_OUT_FIFO_WATERMARK_value
    End Property

    Property Let set_OUT_FIFO_WATERMARK(aData)
        write_OUT_FIFO_WATERMARK_value = aData
        flag_OUT_FIFO_WATERMARK        = &H1
    End Property

    Property Get read_OUT_FIFO_WATERMARK
        read
        read_OUT_FIFO_WATERMARK = read_OUT_FIFO_WATERMARK_value
    End Property

    Property Let write_OUT_FIFO_WATERMARK(aData)
        set_OUT_FIFO_WATERMARK = aData
        write
    End Property

    Property Get get_PA_FIFO_WATERMARK
        get_PA_FIFO_WATERMARK = read_PA_FIFO_WATERMARK_value
    End Property

    Property Let set_PA_FIFO_WATERMARK(aData)
        write_PA_FIFO_WATERMARK_value = aData
        flag_PA_FIFO_WATERMARK        = &H1
    End Property

    Property Get read_PA_FIFO_WATERMARK
        read
        read_PA_FIFO_WATERMARK = read_PA_FIFO_WATERMARK_value
    End Property

    Property Let write_PA_FIFO_WATERMARK(aData)
        set_PA_FIFO_WATERMARK = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_IN_FIFO_WATERMARK_value = rightShift(data_low, 15) and &H7f
        read_OUT_FIFO_WATERMARK_value = rightShift(data_low, 8) and &H7f
        PA_FIFO_WATERMARK_mask = &Hff
        if data_low > LONG_MAX then
            if PA_FIFO_WATERMARK_mask = mask then
                read_PA_FIFO_WATERMARK_value = data_low
            else
                read_PA_FIFO_WATERMARK_value = (data_low - H8000_0000) and PA_FIFO_WATERMARK_mask
            end If
        else
            read_PA_FIFO_WATERMARK_value = data_low and PA_FIFO_WATERMARK_mask
        end If

    End Sub

    Sub write
        If flag_IN_FIFO_WATERMARK = &H0 or flag_OUT_FIFO_WATERMARK = &H0 or flag_PA_FIFO_WATERMARK = &H0 Then read
        If flag_IN_FIFO_WATERMARK = &H0 Then write_IN_FIFO_WATERMARK_value = get_IN_FIFO_WATERMARK
        If flag_OUT_FIFO_WATERMARK = &H0 Then write_OUT_FIFO_WATERMARK_value = get_OUT_FIFO_WATERMARK
        If flag_PA_FIFO_WATERMARK = &H0 Then write_PA_FIFO_WATERMARK_value = get_PA_FIFO_WATERMARK

        regValue = leftShift((write_IN_FIFO_WATERMARK_value and &H7f), 15) + leftShift((write_OUT_FIFO_WATERMARK_value and &H7f), 8) + leftShift((write_PA_FIFO_WATERMARK_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_IN_FIFO_WATERMARK_value = rightShift(data_low, 15) and &H7f
        read_OUT_FIFO_WATERMARK_value = rightShift(data_low, 8) and &H7f
        PA_FIFO_WATERMARK_mask = &Hff
        if data_low > LONG_MAX then
            if PA_FIFO_WATERMARK_mask = mask then
                read_PA_FIFO_WATERMARK_value = data_low
            else
                read_PA_FIFO_WATERMARK_value = (data_low - H8000_0000) and PA_FIFO_WATERMARK_mask
            end If
        else
            read_PA_FIFO_WATERMARK_value = data_low and PA_FIFO_WATERMARK_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_IN_FIFO_WATERMARK_value = &H0
        flag_IN_FIFO_WATERMARK        = &H0
        write_OUT_FIFO_WATERMARK_value = &H0
        flag_OUT_FIFO_WATERMARK        = &H0
        write_PA_FIFO_WATERMARK_value = &H0
        flag_PA_FIFO_WATERMARK        = &H0
    End Sub
End Class


'' @REGISTER : SPUM_AXI_axi_dbg5
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' CR_BPS_FIFO_WATERMARK                      [13:7]           get_CR_BPS_FIFO_WATERMARK
''                                                             set_CR_BPS_FIFO_WATERMARK
''                                                             read_CR_BPS_FIFO_WATERMARK
''                                                             write_CR_BPS_FIFO_WATERMARK
''---------------------------------------------------------------------------------
'' AU_BPS_FIFO_WATERMARK                      [6:0]            get_AU_BPS_FIFO_WATERMARK
''                                                             set_AU_BPS_FIFO_WATERMARK
''                                                             read_AU_BPS_FIFO_WATERMARK
''                                                             write_AU_BPS_FIFO_WATERMARK
''---------------------------------------------------------------------------------
Class REGISTER_SPUM_AXI_axi_dbg5
    Private write_CR_BPS_FIFO_WATERMARK_value
    Private read_CR_BPS_FIFO_WATERMARK_value
    Private flag_CR_BPS_FIFO_WATERMARK
    Private write_AU_BPS_FIFO_WATERMARK_value
    Private read_AU_BPS_FIFO_WATERMARK_value
    Private flag_AU_BPS_FIFO_WATERMARK

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

    Property Get get_CR_BPS_FIFO_WATERMARK
        get_CR_BPS_FIFO_WATERMARK = read_CR_BPS_FIFO_WATERMARK_value
    End Property

    Property Let set_CR_BPS_FIFO_WATERMARK(aData)
        write_CR_BPS_FIFO_WATERMARK_value = aData
        flag_CR_BPS_FIFO_WATERMARK        = &H1
    End Property

    Property Get read_CR_BPS_FIFO_WATERMARK
        read
        read_CR_BPS_FIFO_WATERMARK = read_CR_BPS_FIFO_WATERMARK_value
    End Property

    Property Let write_CR_BPS_FIFO_WATERMARK(aData)
        set_CR_BPS_FIFO_WATERMARK = aData
        write
    End Property

    Property Get get_AU_BPS_FIFO_WATERMARK
        get_AU_BPS_FIFO_WATERMARK = read_AU_BPS_FIFO_WATERMARK_value
    End Property

    Property Let set_AU_BPS_FIFO_WATERMARK(aData)
        write_AU_BPS_FIFO_WATERMARK_value = aData
        flag_AU_BPS_FIFO_WATERMARK        = &H1
    End Property

    Property Get read_AU_BPS_FIFO_WATERMARK
        read
        read_AU_BPS_FIFO_WATERMARK = read_AU_BPS_FIFO_WATERMARK_value
    End Property

    Property Let write_AU_BPS_FIFO_WATERMARK(aData)
        set_AU_BPS_FIFO_WATERMARK = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CR_BPS_FIFO_WATERMARK_value = rightShift(data_low, 7) and &H7f
        AU_BPS_FIFO_WATERMARK_mask = &H7f
        if data_low > LONG_MAX then
            if AU_BPS_FIFO_WATERMARK_mask = mask then
                read_AU_BPS_FIFO_WATERMARK_value = data_low
            else
                read_AU_BPS_FIFO_WATERMARK_value = (data_low - H8000_0000) and AU_BPS_FIFO_WATERMARK_mask
            end If
        else
            read_AU_BPS_FIFO_WATERMARK_value = data_low and AU_BPS_FIFO_WATERMARK_mask
        end If

    End Sub

    Sub write
        If flag_CR_BPS_FIFO_WATERMARK = &H0 or flag_AU_BPS_FIFO_WATERMARK = &H0 Then read
        If flag_CR_BPS_FIFO_WATERMARK = &H0 Then write_CR_BPS_FIFO_WATERMARK_value = get_CR_BPS_FIFO_WATERMARK
        If flag_AU_BPS_FIFO_WATERMARK = &H0 Then write_AU_BPS_FIFO_WATERMARK_value = get_AU_BPS_FIFO_WATERMARK

        regValue = leftShift((write_CR_BPS_FIFO_WATERMARK_value and &H7f), 7) + leftShift((write_AU_BPS_FIFO_WATERMARK_value and &H7f), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_CR_BPS_FIFO_WATERMARK_value = rightShift(data_low, 7) and &H7f
        AU_BPS_FIFO_WATERMARK_mask = &H7f
        if data_low > LONG_MAX then
            if AU_BPS_FIFO_WATERMARK_mask = mask then
                read_AU_BPS_FIFO_WATERMARK_value = data_low
            else
                read_AU_BPS_FIFO_WATERMARK_value = (data_low - H8000_0000) and AU_BPS_FIFO_WATERMARK_mask
            end If
        else
            read_AU_BPS_FIFO_WATERMARK_value = data_low and AU_BPS_FIFO_WATERMARK_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_CR_BPS_FIFO_WATERMARK_value = &H0
        flag_CR_BPS_FIFO_WATERMARK        = &H0
        write_AU_BPS_FIFO_WATERMARK_value = &H0
        flag_AU_BPS_FIFO_WATERMARK        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class SPUM_AXI_INSTANCE

    Public axi_react
    Public int_stat
    Public int_mask
    Public vio_addr_stat
    Public vio_ctl_stat
    Public axi_access
    Public axi_dbg0
    Public axi_dbg1
    Public dma_ctl
    Public dma_stat
    Public in_dma_size
    Public out_dma_size
    Public fifo_stat
    Public fifo_in
    Public fifo_out
    Public axi_dbg2
    Public axi_dbg3
    Public axi_dbg4
    Public axi_dbg5


    Public default function Init(aBaseAddr)
        Set axi_react = (New REGISTER_SPUM_AXI_axi_react)(aBaseAddr, 32)
        Set int_stat = (New REGISTER_SPUM_AXI_int_stat)(aBaseAddr, 32)
        Set int_mask = (New REGISTER_SPUM_AXI_int_mask)(aBaseAddr, 32)
        Set vio_addr_stat = (New REGISTER_SPUM_AXI_vio_addr_stat)(aBaseAddr, 32)
        Set vio_ctl_stat = (New REGISTER_SPUM_AXI_vio_ctl_stat)(aBaseAddr, 32)
        Set axi_access = (New REGISTER_SPUM_AXI_axi_access)(aBaseAddr, 32)
        Set axi_dbg0 = (New REGISTER_SPUM_AXI_axi_dbg0)(aBaseAddr, 32)
        Set axi_dbg1 = (New REGISTER_SPUM_AXI_axi_dbg1)(aBaseAddr, 32)
        Set dma_ctl = (New REGISTER_SPUM_AXI_dma_ctl)(aBaseAddr, 32)
        Set dma_stat = (New REGISTER_SPUM_AXI_dma_stat)(aBaseAddr, 32)
        Set in_dma_size = (New REGISTER_SPUM_AXI_in_dma_size)(aBaseAddr, 32)
        Set out_dma_size = (New REGISTER_SPUM_AXI_out_dma_size)(aBaseAddr, 32)
        Set fifo_stat = (New REGISTER_SPUM_AXI_fifo_stat)(aBaseAddr, 32)
        Set fifo_in = (New REGISTER_SPUM_AXI_fifo_in)(aBaseAddr, 32)
        Set fifo_out = (New REGISTER_SPUM_AXI_fifo_out)(aBaseAddr, 32)
        Set axi_dbg2 = (New REGISTER_SPUM_AXI_axi_dbg2)(aBaseAddr, 32)
        Set axi_dbg3 = (New REGISTER_SPUM_AXI_axi_dbg3)(aBaseAddr, 32)
        Set axi_dbg4 = (New REGISTER_SPUM_AXI_axi_dbg4)(aBaseAddr, 32)
        Set axi_dbg5 = (New REGISTER_SPUM_AXI_axi_dbg5)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set SPUM_AXI = CreateObject("System.Collections.ArrayList")
SPUM_AXI.Add ((New SPUM_AXI_INSTANCE)(&H4c021000))


