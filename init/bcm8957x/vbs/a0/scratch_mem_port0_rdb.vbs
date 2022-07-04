

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


'' @REGISTER : SCRATCH_MEM_PORT0_start_addr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' StartAddr                                  [63:0]           get_StartAddr
''                                                             set_StartAddr
''                                                             read_StartAddr
''                                                             write_StartAddr
''---------------------------------------------------------------------------------
Class REGISTER_SCRATCH_MEM_PORT0_start_addr
    Private write_StartAddr_value
    Private read_StartAddr_value
    Private flag_StartAddr

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

    Property Get get_StartAddr
        get_StartAddr = read_StartAddr_value
    End Property

    Property Let set_StartAddr(aData)
        write_StartAddr_value = aData
        flag_StartAddr        = &H1
    End Property

    Property Get read_StartAddr
        read
        read_StartAddr = read_StartAddr_value
    End Property

    Property Let write_StartAddr(aData)
        set_StartAddr = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        StartAddr_mask = &HffffffffffffffffL
        if data_low > LONG_MAX then
            if StartAddr_mask = mask then
                read_StartAddr_value = data_low
            else
                read_StartAddr_value = (data_low - H8000_0000) and StartAddr_mask
            end If
        else
            read_StartAddr_value = data_low and StartAddr_mask
        end If

    End Sub

    Sub write
        If flag_StartAddr = &H0 Then read
        If flag_StartAddr = &H0 Then write_StartAddr_value = get_StartAddr

        regValue = leftShift(write_StartAddr_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        StartAddr_mask = &HffffffffffffffffL
        if data_low > LONG_MAX then
            if StartAddr_mask = mask then
                read_StartAddr_value = data_low
            else
                read_StartAddr_value = (data_low - H8000_0000) and StartAddr_mask
            end If
        else
            read_StartAddr_value = data_low and StartAddr_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_StartAddr_value = &H0
        flag_StartAddr        = &H0
    End Sub
End Class


'' @REGISTER : SCRATCH_MEM_PORT0_end_addr
'' @API      : data
''           : read
''           : write
''           : get_
''---------------------------------------------------------------------------------
'' @FIELDS                                    @RANGE           @API
''---------------------------------------------------------------------------------
'' EndAddr                                    [63:0]           get_EndAddr
''                                                             set_EndAddr
''                                                             read_EndAddr
''                                                             write_EndAddr
''---------------------------------------------------------------------------------
Class REGISTER_SCRATCH_MEM_PORT0_end_addr
    Private write_EndAddr_value
    Private read_EndAddr_value
    Private flag_EndAddr

    Private offset
    Private address
    Private regSize
    Private regWidth
    Private regData
    Private mask

    Sub Class_Initialize
        offset = &H9ff8
    End Sub

    Public default function Init(aRegsetAddr, aSize)
        regSize  = aSize
        address  = aRegsetAddr + offset
        If regSize = 64 Then regWidth = 7 Else If regSize = 32 Then regWidth = 3 Else If regSize = 16 Then regWidth = 1 Else regWidth = 0
        If regSize = 8 Then mask = &Hff Else If regSize = 16 Then mask = &Hffff Else mask = &Hffffffff
        clear_all_fields
        Set Init = Me
    end function

    Property Get get_EndAddr
        get_EndAddr = read_EndAddr_value
    End Property

    Property Let set_EndAddr(aData)
        write_EndAddr_value = aData
        flag_EndAddr        = &H1
    End Property

    Property Get read_EndAddr
        read
        read_EndAddr = read_EndAddr_value
    End Property

    Property Let write_EndAddr(aData)
        set_EndAddr = aData
        write
    End Property

    Property Get get_
        get_ = regData
    End Property

    Sub read
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        EndAddr_mask = &HffffffffffffffffL
        if data_low > LONG_MAX then
            if EndAddr_mask = mask then
                read_EndAddr_value = data_low
            else
                read_EndAddr_value = (data_low - H8000_0000) and EndAddr_mask
            end If
        else
            read_EndAddr_value = data_low and EndAddr_mask
        end If

    End Sub

    Sub write
        If flag_EndAddr = &H0 Then read
        If flag_EndAddr = &H0 Then write_EndAddr_value = get_EndAddr

        regValue = leftShift(write_EndAddr_value, 0)
        RegWrite regWidth, address, regValue
        clear_all_fields
    End Sub


    Property Get data
        data_low = RegRead(regWidth, address)
        data_low = Sys.bitand(data_low, mask)
        regData  = data_low
        EndAddr_mask = &HffffffffffffffffL
        if data_low > LONG_MAX then
            if EndAddr_mask = mask then
                read_EndAddr_value = data_low
            else
                read_EndAddr_value = (data_low - H8000_0000) and EndAddr_mask
            end If
        else
            read_EndAddr_value = data_low and EndAddr_mask
        end If

        data = data_low
    End Property

    Property Let data(aValue)
        RegWrite regWidth, address, aValue
        clear_all_fields
    End Property

    Sub clear_all_fields
        write_EndAddr_value = &H0
        flag_EndAddr        = &H0
    End Sub
End Class




'***********************************

' Regset Instance

'***********************************

Class SCRATCH_MEM_PORT0_INSTANCE

    Public start_addr
    Public end_addr


    Public default function Init(aBaseAddr)
        Set start_addr = (New REGISTER_SCRATCH_MEM_PORT0_start_addr)(aBaseAddr, 64)
        Set end_addr = (New REGISTER_SCRATCH_MEM_PORT0_end_addr)(aBaseAddr, 64)

        Set Init = Me
    end function

End Class


'***********************************

' Regsets

'***********************************


Set SCRATCH_MEM_PORT0 = CreateObject("System.Collections.ArrayList")
SCRATCH_MEM_PORT0.Add ((New SCRATCH_MEM_PORT0_INSTANCE)(&H64000000))


