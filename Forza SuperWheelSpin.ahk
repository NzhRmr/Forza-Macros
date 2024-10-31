#MaxThreadsperHotkey 2
;#If WinActive(ahk_exe ForzaHorizon5.exe)

; Variables
global varScreenTransition := 1500
global varCarAnimation := 8150
global varMastery_BuyAnimation := 730
global varMastery_MouseSleep := 0
global varMastery_ShortSleep := 100

F6::
toggle := !toggle

StartingProcedure()

loop
{
	if toggle {
		; Start Loop
        BuyingCar()
        SwitchingCar()
        DeleteOldPeel()
        SelectNewPeel()
        EnterUpgrades()
        BuySkills()
        Sleep, 100
		}
	else {
		; End Loop
		ToolTip
		break
		}
}
return

StartingProcedure(){
    MsgBox, At least 1 Peel is needed in the inventory!
    ToolTip, Starting Macro. Hit F7 to abort
    Sleep, 3000
    MouseMove, 712, 447
    Sleep, 500
    MouseMove, 712, 200
    Sleep, 150
}


BuyingCar(){
    ToolTip, Entering Car Collection
    Send {Enter}
    Sleep varScreenTransition

    ToolTip, Selecting Peel Trident
    Send {Right}
    Sleep 750

    ToolTip, Buying...
    Send {y}
    Sleep 750
    Send {Enter}
    Sleep 750

    ToolTip, Exiting "Car Collection"
    Send {Esc}
    Sleep varScreenTransition
}

SwitchingCar(){
    ToolTip, Entering "My Cars"
    Send {Left}
    Sleep 500

    Send {Enter}
    Sleep 850

    ToolTip, Selecting Peel   
    Send {Backspace}
    Sleep 500
    
    ;Note: If new brands added this step and other similar steps need to be modified
    Send {Up}
    Sleep 175
    Send {Up}
    Sleep 175
    Send {Up}
    Sleep 175
    Send {Right}
    Sleep 200

    Sleep 150

    Send {Enter}
    Sleep 1200
}

DeleteOldPeel(){
    ToolTip, Selecting Old Peel
    Send {Enter}
    Sleep 450

    ToolTip, Deleting Old Peel
    Send {Down}
    Sleep 175
    Send {Down}
    Sleep 175
    Send {Down}
    Sleep 175
    Send {Down}
    Sleep 175
    Send {Enter}
    Sleep 400

    Send {Enter}
    ToolTip, Deleted!
    Sleep 1300
}

SelectNewPeel() {
    ToolTip, Selecting New Peel
    Send {Right}
    Sleep 300
    Send {Enter}
    Sleep 450

    Send {Enter}
    ToolTip, Waiting for animation to end
    Sleep varCarAnimation

    ToolTip, Exiting Car
    Send {Esc}
    Sleep 1350
}

EnterUpgrades(){
    Send {Left}
    ToolTip, Navigating "Upgrades & Tuning"
    Sleep 500
    ToolTip, Entering "Upgrades & Tuning"
    Send {Enter}
    Sleep 1200

    Send {Right}
    ToolTip, Navigating to "Car Mastery"
    Sleep 175
    Send {Right}
    Sleep 175
    Send {Down}
    Sleep 175


}

BuySkills(){
    Send {Enter}
    ToolTip, Entering "Car Mastery"
    Sleep varScreenTransition

    MouseMove 180, 570
    ToolTip, Buying "Bubble Top" (XP)
    Sleep varMastery_MouseSleep
    Click
    Sleep varMastery_BuyAnimation

    MouseMove 220, 640
    Sleep varMastery_ShortSleep
    MouseMove 240, 570
    ToolTip, Buying "Timeless Design"
    Sleep varMastery_MouseSleep
    Click
    Sleep varMastery_BuyAnimation

    MouseMove 270, 640
    Sleep varMastery_ShortSleep
    MouseMove 300, 570
    ToolTip, Buying "Radio Not Included"
    Sleep varMastery_MouseSleep
    Click
    Sleep varMastery_BuyAnimation

    MouseMove 250, 510
    Sleep varMastery_ShortSleep
    MouseMove 300, 510
    ToolTip, Buying "A Car for Ants?"
    Sleep varMastery_MouseSleep
    Click
    Sleep varMastery_BuyAnimation

    MouseMove 350, 450
    Sleep varMastery_ShortSleep
    MouseMove 360, 510
    ToolTip, Navigating to "Whats Not to Like?" (Super Wheelspin)
    Sleep varMastery_MouseSleep
    Click
    Sleep varMastery_BuyAnimation

    ToolTip Reseting mouse position...
    MouseMove, 712, 200
    Sleep 100

    ToolTip, Exiting...
    Send {Esc}
    Sleep 1000
    Send {Esc}
    Sleep 1000

    Send {Right}
    ToolTip, Navigating to "Car Collection"
    Sleep 300
    Send {Right}
    Sleep 300
}

F7::
reload