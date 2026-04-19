; ---------- Main Settings ----------
steamExe := ResolveSteamExe()
workshopId   := "3240880604"  ; Map ID

cs2WindowWaitSeconds := 120
postWindowSettleMs   := 15000
startHotkeyToSend    := "{F5}"

closeConsoleDelayMs := 3000
mapStartDelayMs     := 8000     ; Start nagrywania
benchmarkDurationMs := 102000   ; 100s test + 2s for file save

; ---------- Helper uprawnień ----------
EnsureAdminAndRerun() {
    if !A_IsAdmin {
        try {
            Run('*RunAs "' A_AhkPath '" "' A_ScriptFullPath '"')
        } catch as e {
            MsgBox "Failed to request elevation:`n" e.Message, "Error", "Iconx"
        }
        ExitApp
    }
}

; ---------- Helper błędów i logów ----------
ErrBox(txt) {
    MsgBox txt, "Error", "Iconx"
    ExitApp
}

Log(msg) {
    ;
}

; ---------- Wyszukiwanie Steama ----------
ResolveSteamExe() {
    exe := SteamExeFromRegistry()
    if exe
        return exe

    defaultExe := A_Is64bitOS
        ? "C:\Program Files (x86)\Steam\steam.exe"
        : "C:\Program Files\Steam\steam.exe"
    return FileExist(defaultExe) ? defaultExe : ""
}

SteamExeFromRegistry() {
    regCandidates := [
        ["HKCU\Software\Valve\Steam", "SteamExe"],
        ["HKCU\Software\Valve\Steam", "SteamPath"],
        ["HKLM\SOFTWARE\WOW6432Node\Valve\Steam", "InstallPath"],
        ["HKLM\SOFTWARE\Valve\Steam", "InstallPath"]
    ]

    for pair in regCandidates {
        try {
            val := RegRead(pair[1], pair[2])
            exe := NormalizeSteamPathToExe(val)
            if exe && FileExist(exe)
                return exe
        }
    }
    return ""
}

NormalizeSteamPathToExe(val) {
    if !val
        return ""
    val := Trim(val, ' "' . "`t`r`n")
    val := StrReplace(val, "/", "\")
    val := RTrim(val, "\")

    if InStr(StrLower(val), "steam.exe")
        return val
    return val "\steam.exe"
}

; ---------- Funkcja pisania w konsoli ----------
TypeInConsole(cmd) {
    WinActivate "Counter-Strike 2"
    WinWaitActive("Counter-Strike 2",, 2)
    Sleep 120
    Send "{Text}" cmd
    Sleep 80
    Send "{Enter}"
}

; ==========================================================
; MAIN SCRIPT LOGIC
; ==========================================================

; 1) Launch CS2
if !FileExist(steamExe)
    ErrBox("Steam not found at:`n" steamExe)
Run('"' steamExe '" -applaunch 730 +con_enable 1 -console +toggleconsole')

; 2) Wait for CS2 window & settle
if !WinWait("Counter-Strike 2", , cs2WindowWaitSeconds) {
    MsgBox "Couldn't detect the CS2 window within ~" cs2WindowWaitSeconds " seconds.", "Notice"
    ExitApp
}
Sleep postWindowSettleMs

; 3) Run workshop map
TypeInConsole("map_workshop " workshopId)
Sleep closeConsoleDelayMs
Send "{Escape}" ; close console

; 4) Start capture after map loads
Sleep mapStartDelayMs
SoundBeep 1500, 150
Sleep 100
SoundBeep 2000, 150
Send startHotkeyToSend

; 5) Wait then quit CS2
Sleep benchmarkDurationMs
TypeInConsole("quit")