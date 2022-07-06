#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
;SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; system-selected gets 1 parameters
; param #1: console name ex. atari2600

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

if (length > 0) {  ; do we have one argument
	console := args[1]
	url := "http://127.0.0.1:8080/console/stream/" . console . "?event=FEScroll"
	sendRESTCall(url)
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