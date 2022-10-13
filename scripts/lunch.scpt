#!/usr/bin/env osascript

on status()
	tell application "Slack"
		activate
		tell application "System Events"
			delay 0.5
			keystroke "Y" using command down
			delay 0.5
			key code 48 using shift down
			key code 36
			delay 0.1
			keystroke "fork_and_knife"
			delay 0.5
			key code 36
			key code 48
			keystroke "Out for food"
			key code 36
		end tell
	end tell
end status

# set slack status to Lunch
status()

# Lock screen
tell application "System Events" to keystroke "q" using {control down, command down}