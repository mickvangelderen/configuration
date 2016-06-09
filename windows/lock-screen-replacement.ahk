/*
I wanted to use WIN + L as a hotkey. This meant disabling the entire locking
system of Windows. The script below temporarily re-enables locking the
workstation, locks the workstation and then disables locking again.
*/

PAUSE::
	RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Policies\System, DisableLockWorkstation, 0
	DllCall("LockWorkStation")
	Sleep, 1000
	RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Policies\System, DisableLockWorkstation, 1
	Return
