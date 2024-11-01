F6::
toggle := !toggle

; Editable Variables
; Custom Amount
global CurrentSkillPoints := 0
global DesiredSkillPoints := 999
global skillPointsPerEvent := 10

global CurrentSuperWheelspins := 0

; Race Event
global raceEventStartupDuration := 6500
global raceEventAccelerationTime := 2000
global raceEventDuration := 32000
global raceEventScoreboardDuration := 1000
global raceEventRestart := 6000

; Travelling to Festival
global raceExitDuration := 12000
global travelToFestivalDuration := 15000

; Buying Super Wheelspins
global mainMenuScreenTransition := 1200
global subMenuScreenTransition := 650

global carCollectionEnterDuration := 2000
global carCollectionScrollIteration := 13

global myCarsEnterAnimation := 9500

global masteryBuyDelay := 1375

; Fixed Variables
global carCollectionPeelCheck := 0
global delayVeryShort := 100
global delayShort := 250
global delayMedium := 500
global delayDefault := 750
global delayLong := 1000

; Top of script
InitialWarning()
MsgBox, Run Finished. Super WheelSpins: %CurrentSuperWheelspins%

InitialWarning() {
    MsgBox, 4, First Check, Is the game windowed and placed to the right half of the screen?
    IfMsgBox Yes 
        {
        MsgBox, 4, Second Check, Is the game inside the event?
        IfMsgBox Yes 
            {
            MsgBox, 4, Final Check, The script will now execute. Do not move your mouse too much!
            IfMsgBox Yes 
                {
                ToolTip, 3...
                Sleep 1000
                ToolTip, 2...
                Sleep 1000
                ToolTip, 1...
                Sleep 1000

                FocusWindow()
                InitialEvent()

                loop {
                    if (CurrentSkillPoints >= DesiredSkillPoints) {
                       ToolTip, Skill Points maxed out (Skill Points: %CurrentSkillPoints%)
                        Sleep, shortDelay
                        break
                    } else {
                        Event()

                    }
                }

                LeaveRace()
                TravelToFestival()


                loop {
                    if (CurrentSkillPoints <= 9) {
                        MsgBox, Done!
                        break
                    } else {
                        Garage()
                        CarCollectPeel()
                        MyCars()
                        MyCars_Peel()
                        Upgrades()
                        CarMastery()
                    }
                }
            } else {
                MsgBox, Aborting...
                Reload
            }
        } else {
            MsgBox, Aborting...
            Reload
        }
    } else {
        MsgBox, Aborting...
        Reload
    }
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
    CurrentSkillPoints += SkillPointsPerEvent                                                     ; Increment skill points by 10
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

LeaveRace(){
    ToolTip, Exiting Race Event...
    Send, {Right}
    Sleep, delayShort
    Send, {Down}
    Sleep, delayShort
    Send, {Down}
    Sleep, delayShort
    Send, {Enter}
    Sleep, delayShort
    Send, {Enter}
    ToolTip, Waiting on loading screen...
    Sleep, raceExitDuration
}

TravelToFestival(){
    FocusWindow()
    Send, {Esc}
    Sleep, mainMenuScreenTransition
    ToolTip, moving cursor to Cars...
    MouseMove, 480, 355                         ; Mouse on Cars
    Sleep, delayLong
    Click
    Sleep, delayLong
    ToolTip, moving cursor to Buy & Sell Cars...
    MouseMove, 480, 530                         ; Mouse on Buy & Sell Cars
    Click
    Sleep, delayLong
    ToolTip, Waiting on loading screen... 
    Send, {Enter}
    Sleep, travelToFestivalDuration
}

Garage(){
    FocusWindow()
    ToolTip, moving cursor to garage...
    MouseMove, 485, 355                         ; Mouse on garage
    Sleep, delayVeryShort
    Click
    MouseMove, 485, 375, 7
    Sleep, delayShort
    ToolTip, Placing cursor in neutral position...
    MouseMove, 485, 200
    Sleep, delayVeryShort
    MouseMove, 225, 200
    Sleep, delayVeryShort
}

CarCollectPeel(){
    FocusWindow()
    ToolTip, selecting Car Collection...
    Send, {Right}
    Sleep, delayMedium
    Send, {Enter}
    Sleep, carCollectionEnterDuration
    if (carCollectionPeelCheck = 0){
        FocusWindow()
        ToolTip, Jumping to Manufacturer...
        Send, {Backspace}
        Sleep, delayShort
        ToolTip, Selecting Peel...
        MouseMove, 750, 540
        loop {
            if (carCollectionScrollIteration != 0){
                Send, {WheelDown Down}
                Sleep, delayVeryShort
                carCollectionScrollIteration -= 1
            }
            else {
                break
                carCollectionScrollIteration = 5
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
    MouseMove, 225, 660                                 ; Position may vary
    Sleep, delayShort
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
    Sleep, myCarsEnterAnimation
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

F7::Reload
