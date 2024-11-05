;Script by NzhRmr
;v0.2 - Unfinished
msg_Reload()

F6::
toggle := !toggle

;====================================================================
; Modes =============================================================
;====================================================================
; Off = 0, On = 1
global mode_Race := 1
global mode_Festival := 0                ; Automatically sets to 1 if both mode_Race and mode_Garage is 1!
global mode_Garage := 0
global mode_Eventlab := 0

;====================================================================
; Currency ==========================================================
;====================================================================
global skillPoints_Current := 310
global skillPoints_Wanted := 400
global skillPoints_PerEvent := 10
global skillPoints_PeelMinimum := 9
global superWheelSpins_Current := 199

;====================================================================
; General | Keyboard ================================================
;====================================================================

;====================================================================
; General | Mouse ===================================================
;====================================================================
global mouse_Sleep := 150
global mouse_SleepMedium := 500
global mouse_SleepLong := 750

global mouse_RdtMoveSpeed := 10

global mouse_NeutralX := 225
global mouse_NeutralY:= 200



;====================================================================
; Main Menu =========================================================
;====================================================================
global mainMenu_Open := 1700
global mainMenu_Move := 1000
global mainMenu_SubMenuOpen := 1700
global mainMenu_SubMove := 500

global mouse_mainMenuCarsX := 480
global mouse_mainMenuCarsY := 355

;====================================================================
; Race ==============================================================
;====================================================================
global race_StartY := 430
global race_StartupDuration := 6500
global race_AccelerationTime := 2000
global race_Duration := 32000
global race_ScoreboardDuration := 2000
global race_Restart := 6000
global race_RestartOpen := 650              ;was 750
global race_LeaveMove := 250
global race_Out := 12000

;====================================================================
; Festival ==========================================================
;====================================================================
;global mouse_mainMenuBuyX :=
global mouse_mainMenuBuyY := 530

global festival_TravelDuration := 15000

;====================================================================
; Garage ============================================================
;====================================================================
;global festivalMenu_Open := festival_TravelDuration
global festivalMenu_Move := 700
global garageMenu_Move := 500

global mouse_FestivalMenuGarageX := 485
global mouse_FestivalMenuGarageY := 355                    
global mouse_FestivalMenuGarageLeaveY := mouse_NeutralY      

global mouse_GarageMenuMyCarsY := 390       

;====================================================================
; Fixed =============================================================
;====================================================================
global toolTip_Top := "Skill Points: " skillPoints_Current "`nSkill Points Wanted per Loop: " skillPoints_Wanted "`nSuper WheelSpins: " superWheelSpins_Current
;global countdown_Duration := 3 ;this doesnt work somehow
;global delayVeryShort := 100
;global delayShort := 250
;global delayMedium := 500
;global delayDefault := 750
;global delayLong := 1000

;====================================================================
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;====================================================================

; Top of script
mainScript()

; Functions
mainScript(){
    msg_Bugs()
    validation_Main()
    msg_Checking()
    focusWindow()
    move_Neutral()
    countdownStart()   
    
    if(mode_Race = 1){
        race_Initial()
        loop {
            if (SkillPoints_Current >= SkillPoints_Wanted) {
                    ToolTip, Skill Points maxed out (Skill Points: %CurrentSkillPoints%)
                    Sleep, shortDelay
                    break
                } else {
                    race_Main()
                    race_Restart()
                }
        }
        race_Leave()
    } else {

    }

    if (mode_Festival = 1){
        festival_Main()
    }


    if (mode_Garage = 1){
        loop {
            if (skillPoints_Current < skillPoints_PeelMinimum){
                break
            }
            else{
                garage_Reset()
                ;CarCollectPeel()
                ;MyCars()
                ;MyCars_Peel()
                ;Upgrades()
                ;CarMastery()
            }
        }
    }
    else {
        MsgBox, Skipping Super Wheelspin Script!
        Sleep, skipMsgDelay
    }

    msg_Results()
    ToolTip, Script reloaded if I disappear!
    Sleep, 1000
    Reload
}

;====================================================================
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;====================================================================

;====================================================================
; Mesages ===========================================================
;====================================================================
msg_Options(){
    if (ifMsgBox = Yes){
        return
    } else {
        MsgBox, Aborting...
        Reload
    }
}

msg_Reload(){
    MsgBox, 48, Script is Opened/Reloaded!,This window will automatically close in 1 second.`n`nPress F6 to enable the script.`nPress F7 to disable/reload the script., 1
}

msg_Checking(){
    MsgBox, 4, WARNING! Please check the following:, 
    (
   
    1. The game is windowed and placed to the right half of the screen.
    2. The game is inside the race event.

    Press the [ENTER] key or Yes to start. Do not move your mouse after starting!

    )
    msg_Options()
}

msg_Bugs(){
    MsgBox, 4, WARNING! Please check the following:, 
    (
   
    Script Bugs:
    1. The script may open another instance when reloading. Please check hidden
    icons / icon tray and close duplicate instances.
    2. Setting skillPoints_Wanted greater than 999 is allowed but may increase
    runtime.

    )
    msg_Options()
}

msg_ValidationFestival(){
    MsgBox, ,Validation Notice, mode_Race and mode_Garage are both set to 1. Setting mode_Festival to 1.
}

msg_Results(){
    MsgBox,1,Script Disabled!, 
    (

    Finished!
    Total Skill Points: %SkillPoints_Current%
    )
}

toolTip_Main() {
    global skillPoints_Wanted, skillPoints_Current, superWheelSpins_Current
    return "Total Skill Points per race loop: "skillPoints_Wanted "`n`n Current total skill points: "skillPoints_Current  "`nCurrent total super wheelSpins: "superWheelSpins_Current "`n`n"
}

;====================================================================
; Validation ========================================================
;====================================================================
validation_Main(){
    validation_Festival()
}

validation_Festival(){
    if (mode_Race = 1 && mode_Garage = 1){
        mode_Festival = 1
        msg_ValidationFestival()
    }
}

;====================================================================
countdownStart() {
    Loop, 3 {
        ToolTip, % toolTip_Main() (3 - A_Index + 1) "..."
        Sleep, 1000
    }
    ToolTip
}

focusWindow() {
    WinActivate, ahk_exe ForzaHorizon5.exe
}

;====================================================================
; General | Mouse ===================================================
;====================================================================
move_Neutral(){
    ToolTip, % toolTip_Main() "Placing cursor on the neutral position..."
    MouseMove, mouse_NeutralX, mouse_NeutralY
    Sleep, mouse_Sleep
}

;====================================================================
; Race ==============================================================
;====================================================================
race_Initial(){
    focusWindow()
    move_Neutral()
    ToolTip, % toolTip_Main() "Placing cursor in neutral position..."
    Sleep, mouse_Sleep

    MouseMove, mouse_NeutralX, race_StartY, mouse_RdtMoveSpeed
    ToolTip, % toolTip_Main() "Placing cursor on Start Race Event..."
    Sleep, mouse_Sleep

    MouseMove, mouse_NeutralX, mouse_NeutralY
    ToolTip, % toolTip_Main() "Placing cursor in neutral position..."
    Sleep, mouse_Sleep
}

race_Main() {
    focusWindow()
    ToolTip, % toolTip_Main() "Starting Race Event"
    Send, {Enter}                                                                           ; Starting the event
    Sleep, race_StartupDuration                                                             ; Initial event animation
    ToolTip, % toolTip_Main() "Accelerating..."
    Send, {w down}                                                                          ; Throttle
    Sleep, race_AccelerationTime                                                            ; Throttle hold time
    Send, {w up}                                                                            ; Throttle released
    ToolTip, % toolTip_Main() "Waiting for event to finish... "
    Sleep, race_Duration - race_AccelerationTime                                            ; Event duration
    SkillPoints_Current += skillPoints_PerEvent                                               ; Increment skill points by 10
    ToolTip, % toolTip_Main() "Waiting for scoreboard"
    Sleep, race_ScoreboardDuration                                                          ; scoreboard animation
}

race_Restart(){
    ToolTip, % toolTip_Main() "Restarting race..."
    focusWindow()
    Send, {x}                                                                               ; restart event
    Sleep, race_RestartOpen
    ToolTip, % toolTip_Main() "Confirming..."
    focusWindow()
    Send, {Enter}                                                                           ; restart confirm
    ToolTip, % toolTip_Main() "Waiting on loading screen..."
    Sleep, race_Restart                                                                 ; restart duration
}

race_Leave(){
    ToolTip, Exiting Race Event...
    Send, {Right}
    Sleep, race_LeaveMove
    Send, {Down}
    Sleep, race_LeaveMove
    Send, {Down}
    Sleep, race_LeaveMove
    Send, {Enter}
    Sleep, race_LeaveMove
    Send, {Enter}
    ToolTip, % toolTip_Main() "Waiting on loading screen..."
    Sleep, race_Out
}

;====================================================================
; Festival ==========================================================
;====================================================================
festival_Main(){
    focusWindow()
    ToolTip, % toolTip_Main() "Opening Main Menu..."
    Send, {Esc}
    Sleep, mainMenu_Open
    ToolTip, % toolTip_Main() "Moving cursor to Cars..."
    MouseMove, mouse_mainMenuCarsX, mouse_mainMenuCarsY                     ; Mouse on Cars
    Sleep, mouse_Sleep
    ToolTip, % toolTip_Main() "Clicking..."
    Click
    Sleep, mainMenu_Move
    ToolTip, % toolTip_Main() "Moving cursor to Buy & Sell Cars..."
    MouseMove, mouse_mainMenuCarsX, mouse_mainMenuBuyY                      ; Mouse on Buy & Sell Cars
    ToolTip, % toolTip_Main() "Clicking..."
    Sleep, mainMenu_Move
    Click
    Sleep, mainMenu_SubMenuOpen
    ToolTip, % toolTip_Main() "Confirming..."
    Send, {Enter}
    move_Neutral()
    ToolTip, Waiting on loading screen... 
    Sleep, festival_TravelDuration
}
;====================================================================
; Garage ============================================================
;====================================================================
garage_Reset(){
    ToolTip, % toolTip_Main() "Attempting to set main menu to Garage..."
    MouseMove, mouse_FestivalMenuGarageX, mouse_FestivalMenuGarageY
    Sleep, mouse_Sleep
    Click
    Sleep, garageMenu_Move

    ToolTip, % toolTip_Main() "Attempting to set Garage sub menu to My Cars..."
    MouseMove, mouse_FestivalMenuGarageX, mouse_GarageMenuMyCarsY, mouse_RdtMoveSpeed
    Sleep, mouse_Sleep

    MouseMove, mouse_FestivalMenuGarageX, mouse_FestivalMenuGarageLeaveY
    Sleep, mouse_Sleep

    move_Neutral()
}

/*
CarCollectPeel(){
    FocusWindow()
    ToolTip, selecting Car Collection...
    Send, {Right}
    Sleep, delayMedium
    Send, {Enter}
    Sleep, col_Open
    if (carCollectionPeelCheck = 0){
        FocusWindow()
        ToolTip, Jumping to Manufacturer...
        Send, {Backspace}
        Sleep, delayShort
        ToolTip, Selecting Peel...
        MouseMove, 750, 540
        loop {
            if (col_SortTridenScroll != 0){
                Send, {WheelDown Down}
                Sleep, delayVeryShort
                col_SortTridenScroll -= 1
            }
            else {
                break
                col_SortTridenScroll = 5
            }
        } 
        Sleep, delayMedium
        Send, {Enter}
        MouseMove, 225, 200
        ToolTip, Placing cursor in neutral position...
        Sleep, delayShort
        carCollectionPeelCheck += 1
    }
    ToolTip, Navigating to Trident...
    Send, {Right}
    Sleep, delayDefault
    ToolTip, Purchasing...
    Send, {y}
    Sleep, subMenuScreenTransition
    ToolTip, Confirming...
    send, {Enter}
    Sleep, delayLong
    ToolTip, Exiting Car Collection...
    send, {Esc}
    Sleep, mainMenuscreenTransition
}

MyCars(){
    FocusWindow()
    ToolTip, Selecting My Cars...
    Send, {Left}
    Sleep, delayMedium
    ToolTip, Entering My Cars...
    Send, {Enter}
    Sleep, mainMenuscreenTransition
}

MyCars_Peel(){
    FocusWindow()
    ToolTip, Jumping to Manufacturer...
    Send, {Backspace}
    Sleep, delayShort
    ToolTip, Moving cursor to Peel...
    MouseMove, col_SortPeelX, col_SortPeelY                                 ; Position may vary
    Sleep, delayShort
    Sleep, 100000
    Send, {Enter}
    ToolTip, Placing cursor in neutral position...
    MouseMove, 225, 200
    ToolTip, Deleting old Trident...
    Sleep, delayDefault
    Send, {Enter}
    MouseMove, 485, 625
    Sleep, delayShort
    MouseMove, 485, 600, 7
    Sleep, delayMedium
    Send, {Enter}
    MouseMove, 225, 200
    Sleep, delayLong
    Send, {Enter}
    Sleep, delayLong

    ToolTip, Selecting new Trident...
    Send, {Right}
    Sleep, delayDefault
    Send, {Enter}
    Sleep, delayLong
    Send, {Enter}
    ToolTip, Waiting on animation...
    Sleep, my_EnterCarAnimation
    ToolTip, Exiting My Cars...
    Send, {Esc}
    Sleep, mainMenuScreenTransition
}

Upgrades(){
    FocusWindow()
    ToolTip, Entering Upgrades & Tuning
    Send, {Left}
    Sleep, delayMedium
    Send, {Enter}
    Sleep, mainMenuScreenTransition
    ToolTip, Entering Car Mastery
    Send, {Right}
    Sleep, delayShort
    Send, {Right}
    Sleep, delayShort
    Send, {Down}
    Sleep, delayShort
    Send, {Enter}
    Sleep, mainMenuScreenTransition
}

CarMastery(){
    FocusWindow()
    ToolTip, SP: %CurrentSkillPoints%`nSWS: %CurrentSuperWheelspins%`nBuying item 1...
    Send, {Enter}
    CurrentSkillPoints -= 1
    ToolTip, SP: %CurrentSkillPoints%`nSWS: %CurrentSuperWheelspins%`nBuying item 1...
    Sleep, masteryBuyDelay
    Send, {Right}
    Sleep, delayShort
    ToolTip, SP: %CurrentSkillPoints%`nSWS: %CurrentSuperWheelspins%`nBuying item 2...
    Send, {Enter}
    CurrentSkillPoints -= 1
    ToolTip, SP: %CurrentSkillPoints%`nSWS: %CurrentSuperWheelspins%`nBuying item 2...
    Sleep, masteryBuyDelay
    Send, {Right}
    Sleep, delayShort
    ToolTip, SP: %CurrentSkillPoints%`nSWS: %CurrentSuperWheelspins%`nBuying item 3...
    Send, {Enter}
    CurrentSkillPoints -= 1
    ToolTip, SP: %CurrentSkillPoints%`nSWS: %CurrentSuperWheelspins%`nBuying item 3...
    Sleep, masteryBuyDelay
    Send, {Up}
    Sleep, delayShort
    ToolTip, SP: %CurrentSkillPoints%`nSWS: %CurrentSuperWheelspins%`nBuying item 4...
    Send, {Enter}
    CurrentSkillPoints -= 3
    ToolTip, SP: %CurrentSkillPoints%`nSWS: %CurrentSuperWheelspins%`nBuying item 4...
    Sleep, masteryBuyDelay
    Send, {Right}
    Sleep, delayShort
    ToolTip, SP: %CurrentSkillPoints%`nSWS: %CurrentSuperWheelspins%`nBuying item 5...
    Send, {Enter}
    CurrentSkillPoints -= 3
    ToolTip, SP: %CurrentSkillPoints%`nSWS: %CurrentSuperWheelspins%`nBuying item 5...
    Sleep, masteryBuyDelay
    CurrentSuperWheelspins += 1
    Send, {Right}
    Sleep, shortDelay
    ToolTip, Returning to Main Menu...
    Send, {Esc}
    Sleep, mainMenuScreenTransition
    Send, {Esc}
    Sleep, mainMenuScreenTransition
}
*/

;====================================================================
; EventLab ==========================================================
;====================================================================




F7::Reload
