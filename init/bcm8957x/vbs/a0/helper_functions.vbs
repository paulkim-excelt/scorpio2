

ACC_TYPE   = 2
LONG_MAX   = &H7fffffff
H8000_0000 = 2147483648

Function leftShift(a, b)
    leftShift =  (a * (2 ^ b))
End Function

Function rightShift(a, b)
    If b = 0 Then
       ret = a
    ElseIf a > LONG_MAX Then
        ret = (2 ^ (31 - b)) + rightShift(a - H8000_0000, b)
    Else
        ret = (a \ (2 ^ b))
    End IF
    rightShift = ret
End Function

Sub RegWrite(aWidth, aAddress, aData)
    App.OrionWrite ACC_TYPE, aWidth, aAddress, &H00000000, aData
    if aAddress > LONG_MAX then addr = aAddress else addr = "&H" & Hex(aAddress)
    if aData > LONG_MAX then data = aData else data = "&H" & Hex(aData)
    sys.output "App.OrionWrite " & ACC_TYPE & ", " & aWidth &", " & addr & ", &H00000000, " & data

End Sub

Function RegRead(aWidth, aAddress)
    App.OrionRead ACC_TYPE, aWidth, aAddress, data_high, data_low
    if aAddress > LONG_MAX then addr = aAddress else addr = "&H" & Hex(aAddress)
    sys.output "App.OrionRead " & ACC_TYPE & ", " & aWidth &", " & addr & ", data_high, data_low"
    RegRead = data_low
End Function
