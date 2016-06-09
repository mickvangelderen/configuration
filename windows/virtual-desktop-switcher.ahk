; Shoutout to https://github.com/pmb6tz/windows-desktop-switcher for showing me how to do this.

activateVirtualDesktop(target_desktop_index)
{
    ; OutputDebug, attempting to activate Virtual Desktop %target_desktop_index%.

    ; Desktops are 1-indexed.
    if (target_desktop_index < 1)
    {
        MsgBox, 48, Failed to activate Virtual Desktop %target_desktop_index%, Expected target Virtual Desktop index to be at least 1 but got %target_desktop_index%.
        Return
    }

    ; Find the right session number. As far as i've seen there is only a single key at a time inside the SessionInfo key.
    current_session := 1
    Loop, Reg, HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\SessionInfo, K
    {
        current_session := A_LoopRegName
    }

    ; Read the current desktop identifier and compute its length.
    RegRead, current_desktop_id, HKEY_CURRENT_USER, SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\SessionInfo\%current_session%\VirtualDesktops, CurrentVirtualDesktop
    ; OutputDebug, current_desktop_id: %current_desktop_id%
    desktop_id_length := Strlen(current_desktop_id)
    ; OutputDebug, desktop_id_length: %desktop_id_length%

    ; Read the concatenated identifiers of all desktops and compute its length.
    RegRead, desktop_id_list, HKEY_CURRENT_USER, SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VirtualDesktops, VirtualDesktopIDs
    ; OutputDebug, desktop_id_list: %desktop_id_list%
    desktop_id_list_length := Strlen(desktop_id_list)
    ; OutputDebug, desktop_id_list_length: %desktop_id_list_length%

    ; Compute the number of desktops.
    desktop_count := Floor(desktop_id_list_length/desktop_id_length)
    ; OutputDebug, desktop_count: %desktop_count%

    ; Loop through the desktop identifiers until we find the current desktop identifier.
    current_desktop_index := -1
    Loop % desktop_count
    {
        if (SubStr(desktop_id_list,  (A_Index - 1)*desktop_id_length + 1, desktop_id_length) == current_desktop_id)
        {
            current_desktop_index := A_Index
            break
        }
    }
    ; OutputDebug, current_desktop_index: %current_desktop_index%

    ; Stop if we failed to find the current_desktop_index.
    if (current_desktop_index == -1)
    {
        MsgBox, 48, Failed to activate Virtual Desktop %target_desktop_index%, Could not determine the active virtual desktop index.
        Return
    }

    if (target_desktop_index > desktop_count)
    {
        ; create desktops.
        count := target_desktop_index - desktop_count
        ; OutputDebug, Create a Virtual Desktop %count% times.
        Loop % count
            addVirtualDesktop()
    }
    else if (target_desktop_index > current_desktop_index)
    {
        ; move to right.
        count := target_desktop_index - current_desktop_index
        ; OutputDebug, Move to right Virtual Desktop %count% times.
        Loop % count
            activateRightVirtualDesktop()
    }
    else if (target_desktop_index < current_desktop_index)
    {
        ; move to left.
        count := current_desktop_index - target_desktop_index
        ; OutputDebug, Move to left Virtual Desktop %count% times.
        Loop % count
            activateLeftVirtualDesktop()
    }
}

activateRightVirtualDesktop()
{
    Send ^#{Right}
}

activateLeftVirtualDesktop()
{
    Send ^#{Left}
}

addVirtualDesktop()
{
    Send, ^#d
}

; Not currently in use.
; removeVirtualDesktop()
; {
;     Send, ^#{F4}
; }

; Define key bindings here.
#j::activateVirtualDesktop(1)
#k::activateVirtualDesktop(2)
#l::activateVirtualDesktop(3)
#SC027::activateVirtualDesktop(4)
