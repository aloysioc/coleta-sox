On Error Resume Next

strComputer = "."

Dim NomeComputador,ScriptDomain, ScriptUser

Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\CIMV2") 
Set colItems = objWMIService.ExecQuery("SELECT * FROM Win32_ComputerSystem",,48)

For Each objItem In colItems
NomeComputador = objItem.caption        
next

Wscript.Echo ("Maquina: " & NomeComputador)

Set objNetwork = CreateObject("Wscript.Network")
Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\CIMV2")
Set colItems = objWMIService.ExecQuery("SELECT * FROM Win32_ComputerSystem")
For Each objItem In colItems
	tmpCurrentUser = objItem.UserName
Next

If IsNull(tmpCurrentUser) Then
   	ScriptDomain = objNetwork.UserDomain
	ScriptUser = objNetwork.UserName
	
Else
	tmpCurrentUser = Split(tmpCurrentUser,"\")
	ScriptDomain = tmpCurrentUser(0)
	ScriptUser = tmpCurrentUser(1)
End if

Wscript.Echo ("Dominio: " & ScriptDomain)
Wscript.Echo


Set colGroups = GetObject("WinNT://" & strComputer & "")
colGroups.Filter = Array("group")
For Each objGroup In colGroups
    Wscript.Echo "[" & objGroup.Name & "]"
    For Each objUser in objGroup.Members
        Wscript.Echo vbTab & "   " & objUser.Name & ";" & objUser.class & ";" & objuser.AdsPath
    Next
   Wscript.Echo
Next



