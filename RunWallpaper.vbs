Set WshShell = CreateObject("WScript.Shell")
WshShell.Run "powershell.exe -ExecutionPolicy Bypass -File C:\Path\To\change_wallpaper.ps1", 0, False
