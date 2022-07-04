

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


'' @REGISTER : WDT_wdogload
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' WdogLoad                                   [31:0]           get_WdogLoad
''                                                             set_WdogLoad
''                                                             read_WdogLoad
''                                                             write_WdogLoad
''---------------------------------------------------------------------------------
Class REGISTER_WDT_wdogload
    Private write_WdogLoad_value
    Private read_WdogLoad_value
    Private flag_WdogLoad

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

    Property Get get_WdogLoad
        get_WdogLoad = read_WdogLoad_value
    End Property

    Property Let set_WdogLoad(aData)
        write_WdogLoad_value = aData
        flag_WdogLoad        = &H1
    End Property

    Property Get read_WdogLoad
        read
        read_WdogLoad = read_WdogLoad_value
    End Property

    Property Let write_WdogLoad(aData)
        set_WdogLoad = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        WdogLoad_mask = &Hffffffff
        if data_low > LONG_MAX then
            if WdogLoad_mask = mask then
                read_WdogLoad_value = data_low
            else
                read_WdogLoad_value = (data_low - H8000_0000) and WdogLoad_mask
            end If
        else
            read_WdogLoad_value = data_low and WdogLoad_mask
        end If

    End Sub

    Sub write
        If flag_WdogLoad = &H0 Then read
        If flag_WdogLoad = &H0 Then write_WdogLoad_value = get_WdogLoad

        regValue = leftShift(write_WdogLoad_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        WdogLoad_mask = &Hffffffff
        if data_low > LONG_MAX then
            if WdogLoad_mask = mask then
                read_WdogLoad_value = data_low
            else
                read_WdogLoad_value = (data_low - H8000_0000) and WdogLoad_mask
            end If
        else
            read_WdogLoad_value = data_low and WdogLoad_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_WdogLoad_value = &H0
        flag_WdogLoad        = &H0
    End Sub
End Class


'' @REGISTER : WDT_wdogvalue
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' WdogValue                                  [31:0]           get_WdogValue
''                                                             set_WdogValue
''                                                             read_WdogValue
''                                                             write_WdogValue
''---------------------------------------------------------------------------------
Class REGISTER_WDT_wdogvalue
    Private write_WdogValue_value
    Private read_WdogValue_value
    Private flag_WdogValue

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

    Property Get get_WdogValue
        get_WdogValue = read_WdogValue_value
    End Property

    Property Let set_WdogValue(aData)
        write_WdogValue_value = aData
        flag_WdogValue        = &H1
    End Property

    Property Get read_WdogValue
        read
        read_WdogValue = read_WdogValue_value
    End Property

    Property Let write_WdogValue(aData)
        set_WdogValue = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        WdogValue_mask = &Hffffffff
        if data_low > LONG_MAX then
            if WdogValue_mask = mask then
                read_WdogValue_value = data_low
            else
                read_WdogValue_value = (data_low - H8000_0000) and WdogValue_mask
            end If
        else
            read_WdogValue_value = data_low and WdogValue_mask
        end If

    End Sub

    Sub write
        If flag_WdogValue = &H0 Then read
        If flag_WdogValue = &H0 Then write_WdogValue_value = get_WdogValue

        regValue = leftShift(write_WdogValue_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        WdogValue_mask = &Hffffffff
        if data_low > LONG_MAX then
            if WdogValue_mask = mask then
                read_WdogValue_value = data_low
            else
                read_WdogValue_value = (data_low - H8000_0000) and WdogValue_mask
            end If
        else
            read_WdogValue_value = data_low and WdogValue_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_WdogValue_value = &H0
        flag_WdogValue        = &H0
    End Sub
End Class


'' @REGISTER : WDT_wdogcontrol
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' RESEN                                      [1:1]            get_RESEN
''                                                             set_RESEN
''                                                             read_RESEN
''                                                             write_RESEN
''---------------------------------------------------------------------------------
'' INTEN                                      [0:0]            get_INTEN
''                                                             set_INTEN
''                                                             read_INTEN
''                                                             write_INTEN
''---------------------------------------------------------------------------------
Class REGISTER_WDT_wdogcontrol
    Private write_RESEN_value
    Private read_RESEN_value
    Private flag_RESEN
    Private write_INTEN_value
    Private read_INTEN_value
    Private flag_INTEN

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

    Property Get get_RESEN
        get_RESEN = read_RESEN_value
    End Property

    Property Let set_RESEN(aData)
        write_RESEN_value = aData
        flag_RESEN        = &H1
    End Property

    Property Get read_RESEN
        read
        read_RESEN = read_RESEN_value
    End Property

    Property Let write_RESEN(aData)
        set_RESEN = aData
        write
    End Property

    Property Get get_INTEN
        get_INTEN = read_INTEN_value
    End Property

    Property Let set_INTEN(aData)
        write_INTEN_value = aData
        flag_INTEN        = &H1
    End Property

    Property Get read_INTEN
        read
        read_INTEN = read_INTEN_value
    End Property

    Property Let write_INTEN(aData)
        set_INTEN = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RESEN_value = rightShift(data_low, 1) and &H1
        INTEN_mask = &H1
        if data_low > LONG_MAX then
            if INTEN_mask = mask then
                read_INTEN_value = data_low
            else
                read_INTEN_value = (data_low - H8000_0000) and INTEN_mask
            end If
        else
            read_INTEN_value = data_low and INTEN_mask
        end If

    End Sub

    Sub write
        If flag_RESEN = &H0 or flag_INTEN = &H0 Then read
        If flag_RESEN = &H0 Then write_RESEN_value = get_RESEN
        If flag_INTEN = &H0 Then write_INTEN_value = get_INTEN

        regValue = leftShift((write_RESEN_value and &H1), 1) + leftShift((write_INTEN_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_RESEN_value = rightShift(data_low, 1) and &H1
        INTEN_mask = &H1
        if data_low > LONG_MAX then
            if INTEN_mask = mask then
                read_INTEN_value = data_low
            else
                read_INTEN_value = (data_low - H8000_0000) and INTEN_mask
            end If
        else
            read_INTEN_value = data_low and INTEN_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_RESEN_value = &H0
        flag_RESEN        = &H0
        write_INTEN_value = &H0
        flag_INTEN        = &H0
    End Sub
End Class


'' @REGISTER : WDT_wdogintclr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' WdogIntClr                                 [0:0]            get_WdogIntClr
''                                                             set_WdogIntClr
''                                                             read_WdogIntClr
''                                                             write_WdogIntClr
''---------------------------------------------------------------------------------
Class REGISTER_WDT_wdogintclr
    Private write_WdogIntClr_value
    Private read_WdogIntClr_value
    Private flag_WdogIntClr

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

    Property Get get_WdogIntClr
        get_WdogIntClr = read_WdogIntClr_value
    End Property

    Property Let set_WdogIntClr(aData)
        write_WdogIntClr_value = aData
        flag_WdogIntClr        = &H1
    End Property

    Property Get read_WdogIntClr
        read
        read_WdogIntClr = read_WdogIntClr_value
    End Property

    Property Let write_WdogIntClr(aData)
        set_WdogIntClr = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        WdogIntClr_mask = &H1
        if data_low > LONG_MAX then
            if WdogIntClr_mask = mask then
                read_WdogIntClr_value = data_low
            else
                read_WdogIntClr_value = (data_low - H8000_0000) and WdogIntClr_mask
            end If
        else
            read_WdogIntClr_value = data_low and WdogIntClr_mask
        end If

    End Sub

    Sub write
        If flag_WdogIntClr = &H0 Then read
        If flag_WdogIntClr = &H0 Then write_WdogIntClr_value = get_WdogIntClr

        regValue = leftShift((write_WdogIntClr_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        WdogIntClr_mask = &H1
        if data_low > LONG_MAX then
            if WdogIntClr_mask = mask then
                read_WdogIntClr_value = data_low
            else
                read_WdogIntClr_value = (data_low - H8000_0000) and WdogIntClr_mask
            end If
        else
            read_WdogIntClr_value = data_low and WdogIntClr_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_WdogIntClr_value = &H0
        flag_WdogIntClr        = &H0
    End Sub
End Class


'' @REGISTER : WDT_wdogris
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' WDOGRIS                                    [0:0]            get_WDOGRIS
''                                                             set_WDOGRIS
''                                                             read_WDOGRIS
''                                                             write_WDOGRIS
''---------------------------------------------------------------------------------
Class REGISTER_WDT_wdogris
    Private write_WDOGRIS_value
    Private read_WDOGRIS_value
    Private flag_WDOGRIS

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

    Property Get get_WDOGRIS
        get_WDOGRIS = read_WDOGRIS_value
    End Property

    Property Let set_WDOGRIS(aData)
        write_WDOGRIS_value = aData
        flag_WDOGRIS        = &H1
    End Property

    Property Get read_WDOGRIS
        read
        read_WDOGRIS = read_WDOGRIS_value
    End Property

    Property Let write_WDOGRIS(aData)
        set_WDOGRIS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        WDOGRIS_mask = &H1
        if data_low > LONG_MAX then
            if WDOGRIS_mask = mask then
                read_WDOGRIS_value = data_low
            else
                read_WDOGRIS_value = (data_low - H8000_0000) and WDOGRIS_mask
            end If
        else
            read_WDOGRIS_value = data_low and WDOGRIS_mask
        end If

    End Sub

    Sub write
        If flag_WDOGRIS = &H0 Then read
        If flag_WDOGRIS = &H0 Then write_WDOGRIS_value = get_WDOGRIS

        regValue = leftShift((write_WDOGRIS_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        WDOGRIS_mask = &H1
        if data_low > LONG_MAX then
            if WDOGRIS_mask = mask then
                read_WDOGRIS_value = data_low
            else
                read_WDOGRIS_value = (data_low - H8000_0000) and WDOGRIS_mask
            end If
        else
            read_WDOGRIS_value = data_low and WDOGRIS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_WDOGRIS_value = &H0
        flag_WDOGRIS        = &H0
    End Sub
End Class


'' @REGISTER : WDT_wdogmis
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' WDOGMIS                                    [0:0]            get_WDOGMIS
''                                                             set_WDOGMIS
''                                                             read_WDOGMIS
''                                                             write_WDOGMIS
''---------------------------------------------------------------------------------
Class REGISTER_WDT_wdogmis
    Private write_WDOGMIS_value
    Private read_WDOGMIS_value
    Private flag_WDOGMIS

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

    Property Get get_WDOGMIS
        get_WDOGMIS = read_WDOGMIS_value
    End Property

    Property Let set_WDOGMIS(aData)
        write_WDOGMIS_value = aData
        flag_WDOGMIS        = &H1
    End Property

    Property Get read_WDOGMIS
        read
        read_WDOGMIS = read_WDOGMIS_value
    End Property

    Property Let write_WDOGMIS(aData)
        set_WDOGMIS = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        WDOGMIS_mask = &H1
        if data_low > LONG_MAX then
            if WDOGMIS_mask = mask then
                read_WDOGMIS_value = data_low
            else
                read_WDOGMIS_value = (data_low - H8000_0000) and WDOGMIS_mask
            end If
        else
            read_WDOGMIS_value = data_low and WDOGMIS_mask
        end If

    End Sub

    Sub write
        If flag_WDOGMIS = &H0 Then read
        If flag_WDOGMIS = &H0 Then write_WDOGMIS_value = get_WDOGMIS

        regValue = leftShift((write_WDOGMIS_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        WDOGMIS_mask = &H1
        if data_low > LONG_MAX then
            if WDOGMIS_mask = mask then
                read_WDOGMIS_value = data_low
            else
                read_WDOGMIS_value = (data_low - H8000_0000) and WDOGMIS_mask
            end If
        else
            read_WDOGMIS_value = data_low and WDOGMIS_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_WDOGMIS_value = &H0
        flag_WDOGMIS        = &H0
    End Sub
End Class


'' @REGISTER : WDT_wdoglock
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' WDOGLOCK                                   [31:0]           get_WDOGLOCK
''                                                             set_WDOGLOCK
''                                                             read_WDOGLOCK
''                                                             write_WDOGLOCK
''---------------------------------------------------------------------------------
Class REGISTER_WDT_wdoglock
    Private write_WDOGLOCK_value
    Private read_WDOGLOCK_value
    Private flag_WDOGLOCK

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hc00
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_WDOGLOCK
        get_WDOGLOCK = read_WDOGLOCK_value
    End Property

    Property Let set_WDOGLOCK(aData)
        write_WDOGLOCK_value = aData
        flag_WDOGLOCK        = &H1
    End Property

    Property Get read_WDOGLOCK
        read
        read_WDOGLOCK = read_WDOGLOCK_value
    End Property

    Property Let write_WDOGLOCK(aData)
        set_WDOGLOCK = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        WDOGLOCK_mask = &Hffffffff
        if data_low > LONG_MAX then
            if WDOGLOCK_mask = mask then
                read_WDOGLOCK_value = data_low
            else
                read_WDOGLOCK_value = (data_low - H8000_0000) and WDOGLOCK_mask
            end If
        else
            read_WDOGLOCK_value = data_low and WDOGLOCK_mask
        end If

    End Sub

    Sub write
        If flag_WDOGLOCK = &H0 Then read
        If flag_WDOGLOCK = &H0 Then write_WDOGLOCK_value = get_WDOGLOCK

        regValue = leftShift(write_WDOGLOCK_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        WDOGLOCK_mask = &Hffffffff
        if data_low > LONG_MAX then
            if WDOGLOCK_mask = mask then
                read_WDOGLOCK_value = data_low
            else
                read_WDOGLOCK_value = (data_low - H8000_0000) and WDOGLOCK_mask
            end If
        else
            read_WDOGLOCK_value = data_low and WDOGLOCK_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_WDOGLOCK_value = &H0
        flag_WDOGLOCK        = &H0
    End Sub
End Class


'' @REGISTER : WDT_wdogitcr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' ITEN                                       [0:0]            get_ITEN
''                                                             set_ITEN
''                                                             read_ITEN
''                                                             write_ITEN
''---------------------------------------------------------------------------------
Class REGISTER_WDT_wdogitcr
    Private write_ITEN_value
    Private read_ITEN_value
    Private flag_ITEN

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hf00
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_ITEN
        get_ITEN = read_ITEN_value
    End Property

    Property Let set_ITEN(aData)
        write_ITEN_value = aData
        flag_ITEN        = &H1
    End Property

    Property Get read_ITEN
        read
        read_ITEN = read_ITEN_value
    End Property

    Property Let write_ITEN(aData)
        set_ITEN = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ITEN_mask = &H1
        if data_low > LONG_MAX then
            if ITEN_mask = mask then
                read_ITEN_value = data_low
            else
                read_ITEN_value = (data_low - H8000_0000) and ITEN_mask
            end If
        else
            read_ITEN_value = data_low and ITEN_mask
        end If

    End Sub

    Sub write
        If flag_ITEN = &H0 Then read
        If flag_ITEN = &H0 Then write_ITEN_value = get_ITEN

        regValue = leftShift((write_ITEN_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        ITEN_mask = &H1
        if data_low > LONG_MAX then
            if ITEN_mask = mask then
                read_ITEN_value = data_low
            else
                read_ITEN_value = (data_low - H8000_0000) and ITEN_mask
            end If
        else
            read_ITEN_value = data_low and ITEN_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_ITEN_value = &H0
        flag_ITEN        = &H0
    End Sub
End Class


'' @REGISTER : WDT_wdogitop
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' WDOGINT                                    [1:1]            get_WDOGINT
''                                                             set_WDOGINT
''                                                             read_WDOGINT
''                                                             write_WDOGINT
''---------------------------------------------------------------------------------
'' WDOGRES                                    [0:0]            get_WDOGRES
''                                                             set_WDOGRES
''                                                             read_WDOGRES
''                                                             write_WDOGRES
''---------------------------------------------------------------------------------
Class REGISTER_WDT_wdogitop
    Private write_WDOGINT_value
    Private read_WDOGINT_value
    Private flag_WDOGINT
    Private write_WDOGRES_value
    Private read_WDOGRES_value
    Private flag_WDOGRES

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hf04
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_WDOGINT
        get_WDOGINT = read_WDOGINT_value
    End Property

    Property Let set_WDOGINT(aData)
        write_WDOGINT_value = aData
        flag_WDOGINT        = &H1
    End Property

    Property Get read_WDOGINT
        read
        read_WDOGINT = read_WDOGINT_value
    End Property

    Property Let write_WDOGINT(aData)
        set_WDOGINT = aData
        write
    End Property

    Property Get get_WDOGRES
        get_WDOGRES = read_WDOGRES_value
    End Property

    Property Let set_WDOGRES(aData)
        write_WDOGRES_value = aData
        flag_WDOGRES        = &H1
    End Property

    Property Get read_WDOGRES
        read
        read_WDOGRES = read_WDOGRES_value
    End Property

    Property Let write_WDOGRES(aData)
        set_WDOGRES = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_WDOGINT_value = rightShift(data_low, 1) and &H1
        WDOGRES_mask = &H1
        if data_low > LONG_MAX then
            if WDOGRES_mask = mask then
                read_WDOGRES_value = data_low
            else
                read_WDOGRES_value = (data_low - H8000_0000) and WDOGRES_mask
            end If
        else
            read_WDOGRES_value = data_low and WDOGRES_mask
        end If

    End Sub

    Sub write
        If flag_WDOGINT = &H0 or flag_WDOGRES = &H0 Then read
        If flag_WDOGINT = &H0 Then write_WDOGINT_value = get_WDOGINT
        If flag_WDOGRES = &H0 Then write_WDOGRES_value = get_WDOGRES

        regValue = leftShift((write_WDOGINT_value and &H1), 1) + leftShift((write_WDOGRES_value and &H1), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_WDOGINT_value = rightShift(data_low, 1) and &H1
        WDOGRES_mask = &H1
        if data_low > LONG_MAX then
            if WDOGRES_mask = mask then
                read_WDOGRES_value = data_low
            else
                read_WDOGRES_value = (data_low - H8000_0000) and WDOGRES_mask
            end If
        else
            read_WDOGRES_value = data_low and WDOGRES_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_WDOGINT_value = &H0
        flag_WDOGINT        = &H0
        write_WDOGRES_value = &H0
        flag_WDOGRES        = &H0
    End Sub
End Class


'' @REGISTER : WDT_wdogperiphid0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' PartNumber0                                [7:0]            get_PartNumber0
''                                                             set_PartNumber0
''                                                             read_PartNumber0
''                                                             write_PartNumber0
''---------------------------------------------------------------------------------
Class REGISTER_WDT_wdogperiphid0
    Private write_PartNumber0_value
    Private read_PartNumber0_value
    Private flag_PartNumber0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hfe0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_PartNumber0
        get_PartNumber0 = read_PartNumber0_value
    End Property

    Property Let set_PartNumber0(aData)
        write_PartNumber0_value = aData
        flag_PartNumber0        = &H1
    End Property

    Property Get read_PartNumber0
        read
        read_PartNumber0 = read_PartNumber0_value
    End Property

    Property Let write_PartNumber0(aData)
        set_PartNumber0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PartNumber0_mask = &Hff
        if data_low > LONG_MAX then
            if PartNumber0_mask = mask then
                read_PartNumber0_value = data_low
            else
                read_PartNumber0_value = (data_low - H8000_0000) and PartNumber0_mask
            end If
        else
            read_PartNumber0_value = data_low and PartNumber0_mask
        end If

    End Sub

    Sub write
        If flag_PartNumber0 = &H0 Then read
        If flag_PartNumber0 = &H0 Then write_PartNumber0_value = get_PartNumber0

        regValue = leftShift((write_PartNumber0_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        PartNumber0_mask = &Hff
        if data_low > LONG_MAX then
            if PartNumber0_mask = mask then
                read_PartNumber0_value = data_low
            else
                read_PartNumber0_value = (data_low - H8000_0000) and PartNumber0_mask
            end If
        else
            read_PartNumber0_value = data_low and PartNumber0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_PartNumber0_value = &H0
        flag_PartNumber0        = &H0
    End Sub
End Class


'' @REGISTER : WDT_wdogperiphid1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Designer0                                  [7:4]            get_Designer0
''                                                             set_Designer0
''                                                             read_Designer0
''                                                             write_Designer0
''---------------------------------------------------------------------------------
'' PartNumber1                                [3:0]            get_PartNumber1
''                                                             set_PartNumber1
''                                                             read_PartNumber1
''                                                             write_PartNumber1
''---------------------------------------------------------------------------------
Class REGISTER_WDT_wdogperiphid1
    Private write_Designer0_value
    Private read_Designer0_value
    Private flag_Designer0
    Private write_PartNumber1_value
    Private read_PartNumber1_value
    Private flag_PartNumber1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hfe4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_Designer0
        get_Designer0 = read_Designer0_value
    End Property

    Property Let set_Designer0(aData)
        write_Designer0_value = aData
        flag_Designer0        = &H1
    End Property

    Property Get read_Designer0
        read
        read_Designer0 = read_Designer0_value
    End Property

    Property Let write_Designer0(aData)
        set_Designer0 = aData
        write
    End Property

    Property Get get_PartNumber1
        get_PartNumber1 = read_PartNumber1_value
    End Property

    Property Let set_PartNumber1(aData)
        write_PartNumber1_value = aData
        flag_PartNumber1        = &H1
    End Property

    Property Get read_PartNumber1
        read
        read_PartNumber1 = read_PartNumber1_value
    End Property

    Property Let write_PartNumber1(aData)
        set_PartNumber1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Designer0_value = rightShift(data_low, 4) and &Hf
        PartNumber1_mask = &Hf
        if data_low > LONG_MAX then
            if PartNumber1_mask = mask then
                read_PartNumber1_value = data_low
            else
                read_PartNumber1_value = (data_low - H8000_0000) and PartNumber1_mask
            end If
        else
            read_PartNumber1_value = data_low and PartNumber1_mask
        end If

    End Sub

    Sub write
        If flag_Designer0 = &H0 or flag_PartNumber1 = &H0 Then read
        If flag_Designer0 = &H0 Then write_Designer0_value = get_Designer0
        If flag_PartNumber1 = &H0 Then write_PartNumber1_value = get_PartNumber1

        regValue = leftShift((write_Designer0_value and &Hf), 4) + leftShift((write_PartNumber1_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Designer0_value = rightShift(data_low, 4) and &Hf
        PartNumber1_mask = &Hf
        if data_low > LONG_MAX then
            if PartNumber1_mask = mask then
                read_PartNumber1_value = data_low
            else
                read_PartNumber1_value = (data_low - H8000_0000) and PartNumber1_mask
            end If
        else
            read_PartNumber1_value = data_low and PartNumber1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Designer0_value = &H0
        flag_Designer0        = &H0
        write_PartNumber1_value = &H0
        flag_PartNumber1        = &H0
    End Sub
End Class


'' @REGISTER : WDT_wdogperiphid2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Revision                                   [7:4]            get_Revision
''                                                             set_Revision
''                                                             read_Revision
''                                                             write_Revision
''---------------------------------------------------------------------------------
'' Designer1                                  [3:0]            get_Designer1
''                                                             set_Designer1
''                                                             read_Designer1
''                                                             write_Designer1
''---------------------------------------------------------------------------------
Class REGISTER_WDT_wdogperiphid2
    Private write_Revision_value
    Private read_Revision_value
    Private flag_Revision
    Private write_Designer1_value
    Private read_Designer1_value
    Private flag_Designer1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hfe8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_Revision
        get_Revision = read_Revision_value
    End Property

    Property Let set_Revision(aData)
        write_Revision_value = aData
        flag_Revision        = &H1
    End Property

    Property Get read_Revision
        read
        read_Revision = read_Revision_value
    End Property

    Property Let write_Revision(aData)
        set_Revision = aData
        write
    End Property

    Property Get get_Designer1
        get_Designer1 = read_Designer1_value
    End Property

    Property Let set_Designer1(aData)
        write_Designer1_value = aData
        flag_Designer1        = &H1
    End Property

    Property Get read_Designer1
        read
        read_Designer1 = read_Designer1_value
    End Property

    Property Let write_Designer1(aData)
        set_Designer1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Revision_value = rightShift(data_low, 4) and &Hf
        Designer1_mask = &Hf
        if data_low > LONG_MAX then
            if Designer1_mask = mask then
                read_Designer1_value = data_low
            else
                read_Designer1_value = (data_low - H8000_0000) and Designer1_mask
            end If
        else
            read_Designer1_value = data_low and Designer1_mask
        end If

    End Sub

    Sub write
        If flag_Revision = &H0 or flag_Designer1 = &H0 Then read
        If flag_Revision = &H0 Then write_Revision_value = get_Revision
        If flag_Designer1 = &H0 Then write_Designer1_value = get_Designer1

        regValue = leftShift((write_Revision_value and &Hf), 4) + leftShift((write_Designer1_value and &Hf), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        read_Revision_value = rightShift(data_low, 4) and &Hf
        Designer1_mask = &Hf
        if data_low > LONG_MAX then
            if Designer1_mask = mask then
                read_Designer1_value = data_low
            else
                read_Designer1_value = (data_low - H8000_0000) and Designer1_mask
            end If
        else
            read_Designer1_value = data_low and Designer1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Revision_value = &H0
        flag_Revision        = &H0
        write_Designer1_value = &H0
        flag_Designer1        = &H0
    End Sub
End Class


'' @REGISTER : WDT_wdogperiphid3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' Configuration                              [7:0]            get_Configuration
''                                                             set_Configuration
''                                                             read_Configuration
''                                                             write_Configuration
''---------------------------------------------------------------------------------
Class REGISTER_WDT_wdogperiphid3
    Private write_Configuration_value
    Private read_Configuration_value
    Private flag_Configuration

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hfec
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_Configuration
        get_Configuration = read_Configuration_value
    End Property

    Property Let set_Configuration(aData)
        write_Configuration_value = aData
        flag_Configuration        = &H1
    End Property

    Property Get read_Configuration
        read
        read_Configuration = read_Configuration_value
    End Property

    Property Let write_Configuration(aData)
        set_Configuration = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Configuration_mask = &Hff
        if data_low > LONG_MAX then
            if Configuration_mask = mask then
                read_Configuration_value = data_low
            else
                read_Configuration_value = (data_low - H8000_0000) and Configuration_mask
            end If
        else
            read_Configuration_value = data_low and Configuration_mask
        end If

    End Sub

    Sub write
        If flag_Configuration = &H0 Then read
        If flag_Configuration = &H0 Then write_Configuration_value = get_Configuration

        regValue = leftShift((write_Configuration_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        Configuration_mask = &Hff
        if data_low > LONG_MAX then
            if Configuration_mask = mask then
                read_Configuration_value = data_low
            else
                read_Configuration_value = (data_low - H8000_0000) and Configuration_mask
            end If
        else
            read_Configuration_value = data_low and Configuration_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_Configuration_value = &H0
        flag_Configuration        = &H0
    End Sub
End Class


'' @REGISTER : WDT_wdogpcellid0
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' WdogPCellID0                               [7:0]            get_WdogPCellID0
''                                                             set_WdogPCellID0
''                                                             read_WdogPCellID0
''                                                             write_WdogPCellID0
''---------------------------------------------------------------------------------
Class REGISTER_WDT_wdogpcellid0
    Private write_WdogPCellID0_value
    Private read_WdogPCellID0_value
    Private flag_WdogPCellID0

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hff0
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_WdogPCellID0
        get_WdogPCellID0 = read_WdogPCellID0_value
    End Property

    Property Let set_WdogPCellID0(aData)
        write_WdogPCellID0_value = aData
        flag_WdogPCellID0        = &H1
    End Property

    Property Get read_WdogPCellID0
        read
        read_WdogPCellID0 = read_WdogPCellID0_value
    End Property

    Property Let write_WdogPCellID0(aData)
        set_WdogPCellID0 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        WdogPCellID0_mask = &Hff
        if data_low > LONG_MAX then
            if WdogPCellID0_mask = mask then
                read_WdogPCellID0_value = data_low
            else
                read_WdogPCellID0_value = (data_low - H8000_0000) and WdogPCellID0_mask
            end If
        else
            read_WdogPCellID0_value = data_low and WdogPCellID0_mask
        end If

    End Sub

    Sub write
        If flag_WdogPCellID0 = &H0 Then read
        If flag_WdogPCellID0 = &H0 Then write_WdogPCellID0_value = get_WdogPCellID0

        regValue = leftShift((write_WdogPCellID0_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        WdogPCellID0_mask = &Hff
        if data_low > LONG_MAX then
            if WdogPCellID0_mask = mask then
                read_WdogPCellID0_value = data_low
            else
                read_WdogPCellID0_value = (data_low - H8000_0000) and WdogPCellID0_mask
            end If
        else
            read_WdogPCellID0_value = data_low and WdogPCellID0_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_WdogPCellID0_value = &H0
        flag_WdogPCellID0        = &H0
    End Sub
End Class


'' @REGISTER : WDT_wdogpcellid1
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' WdogPCellID1                               [7:0]            get_WdogPCellID1
''                                                             set_WdogPCellID1
''                                                             read_WdogPCellID1
''                                                             write_WdogPCellID1
''---------------------------------------------------------------------------------
Class REGISTER_WDT_wdogpcellid1
    Private write_WdogPCellID1_value
    Private read_WdogPCellID1_value
    Private flag_WdogPCellID1

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hff4
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_WdogPCellID1
        get_WdogPCellID1 = read_WdogPCellID1_value
    End Property

    Property Let set_WdogPCellID1(aData)
        write_WdogPCellID1_value = aData
        flag_WdogPCellID1        = &H1
    End Property

    Property Get read_WdogPCellID1
        read
        read_WdogPCellID1 = read_WdogPCellID1_value
    End Property

    Property Let write_WdogPCellID1(aData)
        set_WdogPCellID1 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        WdogPCellID1_mask = &Hff
        if data_low > LONG_MAX then
            if WdogPCellID1_mask = mask then
                read_WdogPCellID1_value = data_low
            else
                read_WdogPCellID1_value = (data_low - H8000_0000) and WdogPCellID1_mask
            end If
        else
            read_WdogPCellID1_value = data_low and WdogPCellID1_mask
        end If

    End Sub

    Sub write
        If flag_WdogPCellID1 = &H0 Then read
        If flag_WdogPCellID1 = &H0 Then write_WdogPCellID1_value = get_WdogPCellID1

        regValue = leftShift((write_WdogPCellID1_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        WdogPCellID1_mask = &Hff
        if data_low > LONG_MAX then
            if WdogPCellID1_mask = mask then
                read_WdogPCellID1_value = data_low
            else
                read_WdogPCellID1_value = (data_low - H8000_0000) and WdogPCellID1_mask
            end If
        else
            read_WdogPCellID1_value = data_low and WdogPCellID1_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_WdogPCellID1_value = &H0
        flag_WdogPCellID1        = &H0
    End Sub
End Class


'' @REGISTER : WDT_wdogpcellid2
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' WdogPCellID2                               [7:0]            get_WdogPCellID2
''                                                             set_WdogPCellID2
''                                                             read_WdogPCellID2
''                                                             write_WdogPCellID2
''---------------------------------------------------------------------------------
Class REGISTER_WDT_wdogpcellid2
    Private write_WdogPCellID2_value
    Private read_WdogPCellID2_value
    Private flag_WdogPCellID2

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hff8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_WdogPCellID2
        get_WdogPCellID2 = read_WdogPCellID2_value
    End Property

    Property Let set_WdogPCellID2(aData)
        write_WdogPCellID2_value = aData
        flag_WdogPCellID2        = &H1
    End Property

    Property Get read_WdogPCellID2
        read
        read_WdogPCellID2 = read_WdogPCellID2_value
    End Property

    Property Let write_WdogPCellID2(aData)
        set_WdogPCellID2 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        WdogPCellID2_mask = &Hff
        if data_low > LONG_MAX then
            if WdogPCellID2_mask = mask then
                read_WdogPCellID2_value = data_low
            else
                read_WdogPCellID2_value = (data_low - H8000_0000) and WdogPCellID2_mask
            end If
        else
            read_WdogPCellID2_value = data_low and WdogPCellID2_mask
        end If

    End Sub

    Sub write
        If flag_WdogPCellID2 = &H0 Then read
        If flag_WdogPCellID2 = &H0 Then write_WdogPCellID2_value = get_WdogPCellID2

        regValue = leftShift((write_WdogPCellID2_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        WdogPCellID2_mask = &Hff
        if data_low > LONG_MAX then
            if WdogPCellID2_mask = mask then
                read_WdogPCellID2_value = data_low
            else
                read_WdogPCellID2_value = (data_low - H8000_0000) and WdogPCellID2_mask
            end If
        else
            read_WdogPCellID2_value = data_low and WdogPCellID2_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_WdogPCellID2_value = &H0
        flag_WdogPCellID2        = &H0
    End Sub
End Class


'' @REGISTER : WDT_wdogpcellid3
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' WdogPCellID3                               [7:0]            get_WdogPCellID3
''                                                             set_WdogPCellID3
''                                                             read_WdogPCellID3
''                                                             write_WdogPCellID3
''---------------------------------------------------------------------------------
Class REGISTER_WDT_wdogpcellid3
    Private write_WdogPCellID3_value
    Private read_WdogPCellID3_value
    Private flag_WdogPCellID3

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &Hffc
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_WdogPCellID3
        get_WdogPCellID3 = read_WdogPCellID3_value
    End Property

    Property Let set_WdogPCellID3(aData)
        write_WdogPCellID3_value = aData
        flag_WdogPCellID3        = &H1
    End Property

    Property Get read_WdogPCellID3
        read
        read_WdogPCellID3 = read_WdogPCellID3_value
    End Property

    Property Let write_WdogPCellID3(aData)
        set_WdogPCellID3 = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        WdogPCellID3_mask = &Hff
        if data_low > LONG_MAX then
            if WdogPCellID3_mask = mask then
                read_WdogPCellID3_value = data_low
            else
                read_WdogPCellID3_value = (data_low - H8000_0000) and WdogPCellID3_mask
            end If
        else
            read_WdogPCellID3_value = data_low and WdogPCellID3_mask
        end If

    End Sub

    Sub write
        If flag_WdogPCellID3 = &H0 Then read
        If flag_WdogPCellID3 = &H0 Then write_WdogPCellID3_value = get_WdogPCellID3

        regValue = leftShift((write_WdogPCellID3_value and &Hff), 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        WdogPCellID3_mask = &Hff
        if data_low > LONG_MAX then
            if WdogPCellID3_mask = mask then
                read_WdogPCellID3_value = data_low
            else
                read_WdogPCellID3_value = (data_low - H8000_0000) and WdogPCellID3_mask
            end If
        else
            read_WdogPCellID3_value = data_low and WdogPCellID3_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_WdogPCellID3_value = &H0
        flag_WdogPCellID3        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class WDT_INSTANCE

    Public wdogload
    Public wdogvalue
    Public wdogcontrol
    Public wdogintclr
    Public wdogris
    Public wdogmis
    Public wdoglock
    Public wdogitcr
    Public wdogitop
    Public wdogperiphid0
    Public wdogperiphid1
    Public wdogperiphid2
    Public wdogperiphid3
    Public wdogpcellid0
    Public wdogpcellid1
    Public wdogpcellid2
    Public wdogpcellid3


    Public default function Init(aBaseAddr)
        Set wdogload = (New REGISTER_WDT_wdogload)(aBaseAddr, 32)
        Set wdogvalue = (New REGISTER_WDT_wdogvalue)(aBaseAddr, 32)
        Set wdogcontrol = (New REGISTER_WDT_wdogcontrol)(aBaseAddr, 32)
        Set wdogintclr = (New REGISTER_WDT_wdogintclr)(aBaseAddr, 32)
        Set wdogris = (New REGISTER_WDT_wdogris)(aBaseAddr, 32)
        Set wdogmis = (New REGISTER_WDT_wdogmis)(aBaseAddr, 32)
        Set wdoglock = (New REGISTER_WDT_wdoglock)(aBaseAddr, 32)
        Set wdogitcr = (New REGISTER_WDT_wdogitcr)(aBaseAddr, 32)
        Set wdogitop = (New REGISTER_WDT_wdogitop)(aBaseAddr, 32)
        Set wdogperiphid0 = (New REGISTER_WDT_wdogperiphid0)(aBaseAddr, 32)
        Set wdogperiphid1 = (New REGISTER_WDT_wdogperiphid1)(aBaseAddr, 32)
        Set wdogperiphid2 = (New REGISTER_WDT_wdogperiphid2)(aBaseAddr, 32)
        Set wdogperiphid3 = (New REGISTER_WDT_wdogperiphid3)(aBaseAddr, 32)
        Set wdogpcellid0 = (New REGISTER_WDT_wdogpcellid0)(aBaseAddr, 32)
        Set wdogpcellid1 = (New REGISTER_WDT_wdogpcellid1)(aBaseAddr, 32)
        Set wdogpcellid2 = (New REGISTER_WDT_wdogpcellid2)(aBaseAddr, 32)
        Set wdogpcellid3 = (New REGISTER_WDT_wdogpcellid3)(aBaseAddr, 32)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set WDT = CreateObject("System.Collections.ArrayList")
WDT.Add ((New WDT_INSTANCE)(&H40145000))
WDT.Add ((New WDT_INSTANCE)(&H4c015000))


