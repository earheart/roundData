Dim objNetwork, strDomain, strUser, objUser, objGroup, strGroupMemberships
' Get the domain and username from the WScript.Network object
Set objNetwork = CreateObject("WScript.Network")
strDomain = objNetwork.UserDomain
strUser = objNetwork.UserName
' Instanciate the user object from the data above
Set objUser = GetObject("WinNT://" & strDomain & "/" & strUser)
' Instanciate the user object from the data above
Set objUser = GetObject("WinNT://" & strDomain & "/" & strUser)

' Run through the users groups and put them in the string
For Each objGroup In objUser.Groups
    strGroupMemberships = strGroupMemberships & "|" & objGroup.Name & "|"
Next

' rename existing bookmark
dim FileDateTime, UserBookmarksFolder, UserBookmarksFileNow, UserBookmarksFileRename, OrgBookmarksFile, fso
FileDateTime  = Year(Now) & Month(Now) & Day(Now) & "_" & Hour(Now) & Minute(Now) & Second(Now)
UserBookmarksFolder = "D:\Users\" & strUser & "\AppData\Local\Visokio\"
UserBookmarksFileNow  = UserBookmarksFolder & "bookmarks.xml"
UserBookmarksFileRename = UserBookmarksFolder & "bookmarks_" & FileDateTime & ".XML"
OrgBookmarksFile = "C:\roundData\Shared\Bookmarks\rC.xml"
Set fso = CreateObject("Scripting.FileSystemObject")

' copies exisiting bookmark file and names it with a timestamp
fso.CopyFile UserBookmarksFileNow, UserBookmarksFileRename

' deletes existing bookmark file (since it is about to be replaced)
if InStr(strGroupMemberships, "rC") then fso.deletefile UserBookmarksFileNow

' copies org bookmark file into directory
if InStr(strGroupMemberships, "rC") then fso.CopyFile OrgBookmarksFile, UserBookmarksFileNow