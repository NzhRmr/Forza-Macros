;v2 - Skill Point Only Ver. Cleaned

MsgBox, 48, Script is Opened/Reloaded!,This window will automatically close in 1 second.`n`nPress F6 to enable the script.`nPress F7 to disable/reload the script., 1

F6::
toggle := !toggle

; Editable Variables
; Custom Amount
global CurrentSkillPoints := 27
global DesiredSkillPoints := 999
global skillPointsPerEvent := 10

; Race Event
global raceEventStartupDuration := 6500
global raceEventAccelerationTime := 2000
global raceEventDuration := 32000
global raceEventScoreboardDuration := 1000
global raceEventRestart := 6000

; Fixed Variables DO NOT EDIT
global delayVeryShort := 100
global delayShort := 250
global delayMedium := 500
global delayDefault := 750
global delayLong := 1000

; Top of script
MainScript()

; Functions
MainScript(){
    Msg_Checking()
    StartCountdown()
    FocusWindow()
    InitialEvent()

    loop{
        if (CurrentSkillPoints >= DesiredSkillPoints) {
                ToolTip, Skill Points maxed out (Skill Points: %CurrentSkillPoints%)
                Sleep, shortDelay
                break
            } else {
                Event()
            }
    }

    Results()
    ToolTip, Script reloaded if I disappear!
    Reload
}

Msg_Checking(){
    MsgBox, 4, WARNING! Please check the following:, 
    (
   
    This program is for farming Skill Points ONLY
    1. The game is windowed and placed to the right half of the screen.
    2. The game is inside the race event.

    Press the [ENTER] key or Yes to start. Do not move your mouse too much!

    )
    IfMsgBox Yes
        return
    else
        MsgBox, Aborting...
        Reload
}

StartCountdown() {
    Loop, 4 {
        ToolTip, % (5 - A_Index) . "..."
        Sleep 1000
    }
    ToolTip
}

FocusWindow() {
    WinActivate, ahk_exe ForzaHorizon5.exe
}

InitialEvent(){
    FocusWindow()
    MouseMove, 225, 200
    ToolTip, Skill Points: %CurrentSkillPoints%`n`nPlacing cursor in neutral position...
    Sleep, delayShort

    MouseMove, 225, 450
    ToolTip, Skill Points: %CurrentSkillPoints%`n`nPlacing cursor on "Start Race Event"...
    Sleep, delayShort

    MouseMove, 225, 200
    ToolTip, Skill Points: %CurrentSkillPoints%`n`nPlacing cursor in neutral position...
    Sleep, delayShort
}

Event() {
    FocusWindow()
    ToolTip, Skill Points: %CurrentSkillPoints%`n`nStarting Race Event
    Send, {Enter}                                                                           ; Starting the event
    Sleep, raceEventStartupDuration                                                         ; Initial event animation
    ToolTip, Skill Points: %CurrentSkillPoints%`n`nAccelerating...
    Send, {w down}                                                                          ; Throttle
    Sleep, raceEventAccelerationTime                                                        ; Throttle hold time
    Send, {w up}                                                                            ; Throttle released
    ToolTip, Skill Points: %CurrentSkillPoints%`n`nWaiting for event to finish... 
    Sleep, raceEventDuration - raceEventAccelerationTime                                    ; Event duration
    CurrentSkillPoints += SkillPointsPerEvent                                               ; Increment skill points by 10
    ToolTip, Skill Points: %CurrentSkillPoints%`n`nWaiting for scoreboard
    Sleep, raceEventScoreboardDuration                                                      ; scoreboard animation
    RestartRace()
}

RestartRace(){
    ToolTip, Skill Points: %CurrentSkillPoints%`n`nRestarting race...
    FocusWindow()
    Send, {x}                                                                               ; restart event
    Sleep, delayDefault
    ToolTip, Skill Points: %CurrentSkillPoints%`n`nConfirming...
    FocusWindow()
    Send, {Enter}                                                                           ; restart confirm
    ToolTip, Skill Points: %CurrentSkillPoints%`n`nWaiting on loading screen...
    Sleep, raceEventRestart                                                                 ; restart duration
}

Results(){
    MsgBox,1,Script Disabled!, 
    (

    Finished!
    Total Skill Points: %CurrentSkillPoints%

    )
}

F7::Reload