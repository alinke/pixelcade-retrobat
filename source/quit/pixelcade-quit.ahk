#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
;SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

ExitMessageINI := Thanks for Playing

EnvGet, hdrive, Homedrive
EnvGet, hpath, Homepath
PixelcadeRetroBatFolder := hdrive hpath "\pixelcade"
PixelcadeSettingsPath := PixelcadeRetroBatFolder . "\pixelcade-settings.ini"

if FileExist(PixelcadeSettingsPath) {
	IniRead, ExitMessageINI, %PixelcadeSettingsPath%, PIXELCADE SETTINGS, EXIT_MESSAGE
}

url := "http://127.0.0.1:8080/text?t=" . ExitMessageINI 
sendRESTCall(url)
	
sendRESTCall(url) {
	try {
			oWhr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
			;msgbox, %url%
			oWhr.Open("GET", url, false)
			oWhr.Send()
		} catch e {
	
		}
}



