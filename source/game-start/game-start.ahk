#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
;SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; game-start gets 3 parameters
; param #1: full path with game name (but note this can have spaces and turn into multiple params)
; param #2: rom name
; param #3: game title

; logic if params is 3, then we're good
; parse the first param to get platform and use the 2nd to last param to get the rom name

Global PixelcadeLogPath ; if this is not here, the function won't work
Global console
Global game
Global gameTitle
Global oWhr
Global LoggingINI

;*************************************************
 ;change these in c:\users\username\PixelcadeRetroBat\pixelcade-settings.ini 
 ; 0 = off and 1 = on
LoggingINI := 0 
Game_Start_TextINI := 0
DISPLAYHIGHSCORES=yes
NUMBERHIGHSCORES=3  ;number of high scores to scroll, choose 1 for example to only show the top score
CYCLEMODE=yes ;cycle mode means we continually cycle between the game marquee and scrolling high scores. If set to no, then high scores will scroll only once on game launch and then display the game marquee
NUMBER_MARQUEE_LOOPS=1 ;for cycle mode, the number of times the animated marquee will loop before scrolling the high score text, this has no effect if it's a still image game marquee
HI2TXT_JAR=${INSTALLPATH}pixelcade/hi2txt/hi2txt.jar ;hi2txt.jar AND hi2txt.zip must be in this folder, the Pixelcade installer puts them here by default
HI2TXT_DATA=${INSTALLPATH}pixelcade/hi2txt/hi2txt.zip
;*************************************************

EnvGet, hdrive, Homedrive
EnvGet, hpath, Homepath
PixelcadeRetroBatFolder := hdrive hpath "\RetroBatPixelcade"
FileCreateDir, %PixelcadeRetroBatFolder% ;only creates if it doesn't already exist in c:\users\username\RetroBatPixelcade
PixelcadeLogPath := PixelcadeRetroBatFolder . "\pixelcade-log.log"
PixelcadeSettingsPath := PixelcadeRetroBatFolder . "\pixelcade-settings.ini"
if FileExist(PixelcadeSettingsPath) {
	IniRead, LoggingINI, %PixelcadeSettingsPath%, PIXELCADE SETTINGS, LOGGING
	IniRead, Game_Start_TextINI, %PixelcadeSettingsPath%, PIXELCADE SETTINGS, GAME_START_TEXT
}	

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
	if LoggingINI
			WriteLog("No Command Line Args, exiting...")
	ExitApp
}

length:=args.length()

; c:\retrobat\roms\arcade\1942.zip
; c:\retroat\roms\atari2600\3D
; so get the string before the last backslash

if (length > 2) {  ; do we have enough args
	ConsoleFullString:=args[1]
	StringReplace, ConsoleFullStringMod, ConsoleFullString, /, \, All ; had to add this because we're getting c:/retrobat/roms/ vs. c:\retrobat\roms
	StringSplit, pathArray, ConsoleFullStringMod, \
	i2 := pathArray0 - 1
	console := pathArray%i2% ;second to last in the path
	game := args[length-1] ; rom name is the second to last in the args array but we need to strip out event code from here
	gameTitle := args[length] ; game title is the last item in the args array
	;RetroBatDir := pathArray[1] ;decided not to use this and use home folders instead
	
	if Game_Start_TextINI {
		 url := "http://127.0.0.1:8080/text?t=Now Playing" . gameTitle . "&loop=1&game=" . game . "&system=" console . "&event=GameStart"
		 sendRESTCall(url)
		 url := "http://127.0.0.1:8080/arcade/stream/" . console . "/" . game . "?loop=99999&event=GameStart"
		 sendRESTCall(url)
	}
	else {
		url := "http://127.0.0.1:8080/arcade/stream/" . console . "/" . game . "?event=GameStart"
		sendRESTCall(url)
	}
	
}
else 
{
	if LoggingINI
			WriteLog("Command Line Args is less than 3, exiting...")
	ExitApp
}

WriteLog(msg) {
	FileDelete, %PixelcadeLogPath%
	FileAppend, % A_NowUTC ": " msg "`n", %PixelcadeLogPath%
}

sendRESTCall(url) {
	try {
			oWhr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
			;msgbox, %url%
			oWhr.Open("GET", url, false)
			oWhr.Send()
			if LoggingINI
				WriteLog("Successful API Call: " url)
		} catch e {
			if LoggingINI
				WriteLog("Failed API Call: " url)
		}
}



