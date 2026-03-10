#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Dev Layout: Visual Check
# @raycast.mode silent
# @raycast.packageName Window Management

# Optional parameters:
# @raycast.icon 🎨

# @raycast.description Browser 35% | IDE 40% | Terminal 25%

osascript <<'END'
-- Firefox: Find main window on Samsung (x >= 0 and width > 500)
if application "Firefox" is running then
    tell application "Firefox"
        repeat with w in every window
            set b to bounds of w
            set x1 to item 1 of b
            set x2 to item 3 of b
            set winWidth to x2 - x1
            if x1 >= 0 and winWidth > 500 then
                set bounds of w to {0, 25, 1792, 1440}
                exit repeat
            end if
        end repeat
    end tell
end if

-- PhpStorm: Use System Events
if application "PhpStorm" is running then
    tell application "System Events"
        tell process "phpstorm"
            set position of window 1 to {1792, 25}
            set size of window 1 to {2048, 1415}
        end tell
    end tell
end if

-- iTerm
if application "iTerm" is running then
    tell application "iTerm"
        set bounds of window 1 to {3840, 25, 5120, 1440}
    end tell
end if

-- Ghostty: Use System Events (no AppleScript dictionary)
if application "Ghostty" is running then
    tell application "System Events"
        tell process "Ghostty"
            set position of window 1 to {3840, 25}
            set size of window 1 to {1280, 1415}
        end tell
    end tell
end if
END

echo "Visual Check layout applied"
