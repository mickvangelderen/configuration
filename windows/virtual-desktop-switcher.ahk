; Shoutout to https://github.com/pmb6tz/windows-desktop-switcher for this desktop switching technique.

; Ensure only one virtual desktop switch is running at a time.
activateVirtualDesktop(target_desktop_index)
{
    static locked := false
    if (locked)
        return
    locked := true
    try
    {
        result := activateVirtualDesktopConcurrent(target_desktop_index)
        locked := false
        return result
    }
    catch error
    {
        locked := false
        throw error
    }
}

; Switch to a specific desktop.
activateVirtualDesktopConcurrent(target_desktop_index)
{
    ; OutputDebug, attempting to activate Virtual Desktop %target_desktop_index%.

    ; Desktops are 1-indexed.
    if (target_desktop_index < 1)
    {
        MsgBox, 48, Failed to activate Virtual Desktop %target_desktop_index%, Expected target Virtual Desktop index to be at least 1 but got %target_desktop_index%.
        return
    }

    ; Find the right session number. As far as i've seen there is only a single key at a time inside the SessionInfo key.
    current_session := 1
    Loop, Reg, HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\SessionInfo, K
    {
        current_session := A_LoopRegName
    }

    ; Read the concatenated identifiers of all desktops and compute its length.
    RegRead, desktop_id_list, HKEY_CURRENT_USER, SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VirtualDesktops, VirtualDesktopIDs
    ; OutputDebug, desktop_id_list: %desktop_id_list%
    desktop_id_list_length := Strlen(desktop_id_list)
    ; OutputDebug, desktop_id_list_length: %desktop_id_list_length%

    try
    {
        ; Read the current desktop identifier and compute its length.
        RegRead, current_desktop_id, HKEY_CURRENT_USER, SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\SessionInfo\%current_session%\VirtualDesktops, CurrentVirtualDesktop
        ; OutputDebug, current_desktop_id: %current_desktop_id%
        desktop_id_length := Strlen(current_desktop_id)
        ; OutputDebug, desktop_id_length: %desktop_id_length%
    }
    catch error
    {
        ; Sometimes the curring desktop identifier is not yet set in the registry. Assume its length is 32.
        desktop_id_length := 16
        current_desktop_id := SubStr(desktop_id_list, 1, desktop_id_length)
    }

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
        return
    }

    if (target_desktop_index > desktop_count)
    {
        ; create desktops.
        count := target_desktop_index - desktop_count
        ; OutputDebug, Create a Virtual Desktop %count% times.
        addVirtualDesktop()
        Loop % count - 1 {
            Sleep, 50
            addVirtualDesktop()
        }
    }
    else if (target_desktop_index > current_desktop_index)
    {
        ; move to right.
        count := target_desktop_index - current_desktop_index
        ; OutputDebug, Move to right Virtual Desktop %count% times.
        activateRightVirtualDesktop()
        Loop % count - 1 {
            Sleep, 50
            activateRightVirtualDesktop()
        }
    }
    else if (target_desktop_index < current_desktop_index)
    {
        ; move to left.
        count := current_desktop_index - target_desktop_index
        ; OutputDebug, Move to left Virtual Desktop %count% times.
        activateLeftVirtualDesktop()
        Loop % count - 1 {
            Sleep, 50
            activateLeftVirtualDesktop()
        }
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

; Define key bindings here.
#j::activateVirtualDesktop(1)
#k::activateVirtualDesktop(2)
#l::activateVirtualDesktop(3)
#SC027::activateVirtualDesktop(4)
