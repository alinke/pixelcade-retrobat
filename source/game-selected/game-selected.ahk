#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
;SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; game-start gets 3 parameters
; param #1: console name ex. atari2600
; param #2: full puth with rom name and extension ex. c:\RetroBat\roms\atari2600\3D Tic-Tac-Toe (USA).aes
; param #3: game title ex. 3D Tic-Tac-Toe (USA)

; logic if params is 3, then we're good
; parse the first param to get platform and use the 2nd to last param to get the rom name

;known issue, if pixelcade is not connected, this slows things down a lot so perhaps check for pixelcade first? to do 

;Get Arguments as an array
if 0 > 0
{
	argc=%0%
	args:=[]
	Loop, %argc% {
		args.Insert(%A_Index%)
		;MsgBox, % args[A_Index] ; print the command line params
		}
}
else
{
	; if got no arguments
	ExitApp
}

length:=args.length()

; c:\retrobat\roms\arcade\1942.zip
; c:\retroat\roms\atari2600\3D
; so get the string before the last backslash



if (length > 2) {  ; do we have enough args, need at least 3
	GameFullPath:=args[2]
	StringReplace, GameFullPathMod, GameFullPath, /, \, All ; had to add this because we're getting c:/retrobat/roms/ vs. c:\retrobat\roms
	SplitPath, GameFullPathMod, , , , game, 
	
	;console is easy
	console := args[1]
	
	; now let's get the current game on pixelcade and if it's the same, let's not make the duplicate REST call, ES will actually call it twice if we didn't do this and that would interrupt up the Pixelcade Q
	;currentgame retursn this mame%88games&event=GameStart or mame%pacman
	url := "http://127.0.0.1:8080/currentgame"
	PREVIOUSGAMESELECTED := getRESTCallValue(url)
	StringSplit, currentGameArray, PREVIOUSGAMESELECTED,`% ;escaping the % delimeter
	PREVIOUSGAMESELECTED := currentGameArray2 
	
	if ("" . PREVIOUSGAMESELECTED != game) {
		url := "http://127.0.0.1:8080/arcade/stream/" . console . "/" . game . "?event=FEScroll"
		sendRESTCall(url)
	}	
	else {
		ExitApp ;it's the same game already so exit out and don't make any calls
	}
	
}
else 
{
	ExitApp
}


sendRESTCall(url) {

	try {
			oWhr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
			;msgbox, %url%
			oWhr.Open("GET", url, false)
			oWhr.Send()
			
		} catch e {
			
		}
}

getRESTCallValue(url) {

	try {
			oWhr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
			;msgbox, %url%
			oWhr.Open("GET", url, false)
			oWhr.Send()
			Return oWhr.ResponseText
			
		} catch e {
			
		}
}



