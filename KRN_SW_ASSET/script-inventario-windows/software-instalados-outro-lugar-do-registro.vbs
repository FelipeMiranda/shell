strHost = WScript.Arguments(0)
Const HKLM = &H80000002
Set objReg = GetObject("winmgmts://" & strHost & "/root/default:StdRegProv")
Const strBaseKey = "Software\Microsoft\Windows\CurrentVersion\Uninstall\"
objReg.EnumKey HKLM, strBaseKey, arrSubKeys
 
For Each strSubKey In arrSubKeys
    intRet = objReg.GetStringValue(HKLM, strBaseKey & strSubKey, "DisplayName", strValue)
    If intRet <> 0 Then
        intRet = objReg.GetStringValue(HKLM, strBaseKey & strSubKey, "QuietDisplayName", strValue)
    End If
    If (strValue <> "") and (intRet = 0) Then
        WScript.Echo strValue
    End If
Next