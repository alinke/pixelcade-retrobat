# pixelcade-retrobat
Source code and scripts for the Pixelcade Arcade Marquee integration with the RetroBat Arcade Front End.

## Installation Instructions

1. Install the Pixelcade Software for Windows on your Windows arcade machine https://pixelcade.org/download-pc/

2. Grab the Pixelcade for RetroBat .EXEs from here (this step will eventually be automated in #1)
https://github.com/alinke/pixelcade-retrobat/tree/main/scripts

and copy to and ensure to keep this exact folder structure

C:\RetroBat\emulationstation\.emulationstation\scripts\game-start\pixelcade-game-start.exe
C:\RetroBat\emulationstation\.emulationstation\scripts\game-selected\pixelcade-game-selected.exe
C:\RetroBat\emulationstation\.emulationstation\scripts\system-selected\pixelcade-system-selected.exe
C:\RetroBat\emulationstation\.emulationstation\scripts\game-selected\pixelcade-quit.exe

If you are on RetroBat V4, Pixelcade will update when you launch a game. For RetroBat V5, Pixelcade will update when scrolling through games and consoles in EmulationStation and when launching a game.

## Customizing

After the first game launch, a configuration file called pixelcade-settings.ini will be created in c:\users\<your windows username>\RetroBatPixelcade\pixelcade-settings.ini. You can change the settings as noted below to customize Pixelcade's behavior.

; Pixelcade for RetroBat Config File

[PIXELCADE SETTINGS]

; if set to 1, pixelcade-log.log will be written to c:\users\your username\RetroBatPixelcade\pixelcade-log.log. Note that only Game Start events will write to this log file. Game and console scrolling (game-selected and system-selected) will not write to this log file.
; this log file will be over-written on each game start call and will not append

LOGGING=0

; if set to 1, "Now Playing < Game Title >" will scroll before the game marquee is displayed upon a game launch. If set to 0, just the game marquee will be displayed with no scrolling text

GAME_START_TEXT=1

;cycle mode means continually cycle between the game marquee and now playing text. If set to no, then the now playing text will only display on game launch and then display the game marquee. Cycle mode is not applicable if GAME_START_TEXT=0

CYCLEMODE=0

; If GAME_START_TEXT=1, you can change the "Now Playing" default scrolling text to something else

NOW_PLAYING_TEXT=Now Playing

;if in cycle mode, the number of times an animated marquee will loop before cycling back to scrolling text. This has no effect if it's a still image / non-animated game marquee

NUMBER_MARQUEE_LOOPS=1

;Scroll this text when EmulationStation quits, you can customize to whatever you'd like to say here

EXIT_MESSAGE=Thanks for Playing
