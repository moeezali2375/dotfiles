-- Sets the AirPods listening mode by clicking it in the menu bar Sound menu.
-- Usage: osascript set-mode.applescript "Off" | "Transparency" | "Adaptive" | "Noise Cancellation"
--
-- macOS 27 has no public API or Shortcuts action for this on the Mac, so this drives the
-- Sound menu via Accessibility. The mode toggles carry no labels, so they are matched by
-- position: the first section under the connected AirPods lists the modes in this order.
property modeOrder : {"Off", "Transparency", "Adaptive", "Noise Cancellation"}

on run argv
	if (count of argv) is 0 then error "usage: set-mode.applescript <" & my joinList(modeOrder, " | ") & ">"
	set modeName to item 1 of argv
	set modeIndex to my indexOf(modeName, modeOrder)
	if modeIndex is 0 then error "unknown mode: " & modeName

	my openSoundMenu()
	try
		set toggle_ to my modeToggle(modeIndex)
		tell application "System Events" to click toggle_
		delay 0.1
		my closeMenu()
	on error errorMessage
		my closeMenu()
		display notification errorMessage with title "AirPods"
		error errorMessage
	end try
end run

on openSoundMenu()
	tell application "System Events" to tell process "MenuBarAgent"
		repeat with menuGroup in (every group of menu bar 1)
			repeat with menuItem in (every menu bar item of menuGroup)
				if (value of attribute "AXIdentifier" of menuItem) is "com.apple.menuextra.sound" then
					click menuItem
					return
				end if
			end repeat
		end repeat
	end tell
	error "Sound menu bar item not found"
end openSoundMenu

-- Returns the toggle for the given mode, expanding the AirPods section if needed.
on modeToggle(modeIndex)
	tell application "System Events" to tell process "ControlCenter"
		repeat 20 times
			if (count of windows) > 0 then exit repeat
			delay 0.05
		end repeat
		set deviceList to scroll area 1 of group 1 of window 1

		set disclosure to missing value
		repeat with e in (every UI element of deviceList)
			if role of e is "AXDisclosureTriangle" then
				set disclosure to contents of e
				exit repeat
			end if
		end repeat
		if disclosure is missing value then error "No connected AirPods in the Sound menu"
		if (value of disclosure) is 0 then
			click disclosure
			delay 0.3
		end if

		-- The first heading after the disclosure triangle is "Listening Mode".
		set elements_ to every UI element of deviceList
		set passedDisclosure to false
		repeat with i from 1 to count of elements_
			set e to item i of elements_
			if role of e is "AXDisclosureTriangle" then set passedDisclosure to true
			if passedDisclosure and role of e is "AXHeading" then
				set toggle_ to item (i + modeIndex) of elements_
				if role of toggle_ is not "AXCheckBox" then error "Listening mode \"" & item modeIndex of modeOrder & "\" not available"
				return toggle_
			end if
		end repeat
	end tell
	error "Listening Mode section not found"
end modeToggle

on closeMenu()
	tell application "System Events" to key code 53 -- Escape
end closeMenu

on indexOf(needle, haystack)
	repeat with i from 1 to count of haystack
		if (item i of haystack) is needle then return i
	end repeat
	return 0
end indexOf

on joinList(theList, delimiter)
	set AppleScript's text item delimiters to delimiter
	set joined to theList as text
	set AppleScript's text item delimiters to ""
	return joined
end joinList
