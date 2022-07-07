# Pixelcade Marquee Integration with RetroBat
Source code and scripts for the Pixelcade Arcade Marquee integration with the RetroBat Arcade Front End. Pixelcade is a line of LED and LCD based active marquees for arcade machines http://pixelcade.org. RetroBat is a Windows based arcade front end https://www.retrobat.ovh/

## Installation Instructions

Install the Pixelcade Software for Windows on your Windows arcade machine https://pixelcade.org/download-pc/

Towards the end of the installation, the Arcade Front End Wizard will appear, choose RetroBat:

![Pixelcade for RetroBat Install 1](https://creativeartsandtechnology.com/wp-content/uploads/2022/07/installer1-e1657220929273.jpg)

The Pixelcade installer will detect your RetroBat installation path, confirm or correct:

![Pixelcade for RetroBat Install 2](https://creativeartsandtechnology.com/wp-content/uploads/2022/07/installer2-e1657220959970.jpg)

![Pixelcade for RetroBat Install 3](https://creativeartsandtechnology.com/wp-content/uploads/2022/07/installer4-e1657221024111.jpg)

The Pixelcade for RetroBat scripts will automatically be copied to these folders. If you ever remove Pixelcade, then just delete these files.

* C:\RetroBat\emulationstation\.emulationstation\scripts\game-start\pixelcade-game-start.exe
* C:\RetroBat\emulationstation\.emulationstation\scripts\game-selected\pixelcade-game-selected.exe
* C:\RetroBat\emulationstation\.emulationstation\scripts\system-selected\pixelcade-system-selected.exe
* C:\RetroBat\emulationstation\.emulationstation\scripts\game-selected\pixelcade-quit.exe

![Pixelcade for RetroBat Install 4](https://creativeartsandtechnology.com/wp-content/uploads/2022/07/installer5-e1657221045815.jpg)

* For RetroBat V4.x, Pixelcade will update when you launch a game.
* For RetroBat V5.x or above, Pixelcade will update when scrolling through games and consoles in EmulationStation and when launching a game.

Ensure that the Pixelcade Listener is running before launching RetroBat and note that if the Pixelcade Listener is not running, EmulationStation will be slower as the Pixelcade Scripts will be making API calls to the Pixelcade Listener which will time out and slow down performance. 

## Customizing

After the first game launch, a configuration file called pixelcade-settings.ini will be created in c:\users\<your windows username>\RetroBatPixelcade\pixelcade-settings.ini. You can change the settings as noted below to customize Pixelcade's behavior.

You can further customize by modifying the source code of the scripts which are written in Auto Hot Key and then using the Pixelcade API http://pixelcade.org/api to add additional functionality

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
