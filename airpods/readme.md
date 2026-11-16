# AirPods Listening Mode Hotkeys

Global keyboard shortcuts that jump the connected AirPods straight to a listening mode (Off, Transparency, Adaptive, Noise Cancellation).

## How it works

macOS 27 has no working API for this on the Mac: the private `IOBluetoothDevice.listeningMode` setter is a no-op, and the Shortcuts **Set Noise Control Mode** action is iOS-only. So `set-mode.applescript` opens the menu bar **Sound** menu, clicks the requested mode under the AirPods, and closes the menu (~0.7s, the menu flashes briefly).

The mode toggles carry no accessibility labels, so they are matched by position in the order the menu shows them: Off, Transparency, Adaptive, Noise Cancellation. If Apple reorders the menu, update `modeOrder` in the script.

```zsh
osascript ~/dotfiles/airpods/set-mode.applescript "Noise Cancellation"
osascript ~/dotfiles/airpods/set-mode.applescript "Transparency"
osascript ~/dotfiles/airpods/set-mode.applescript "Off"
osascript ~/dotfiles/airpods/set-mode.applescript "Adaptive"
```

If no AirPods are connected or a mode is unavailable, it shows a notification and exits non-zero.

## Keyboard Shortcuts (one-time setup)

Create one shortcut per mode in the **Shortcuts** app:

1. New shortcut, e.g. **AirPods: Noise Cancellation**.
2. Add a **Run Shell Script** action: `osascript ~/dotfiles/airpods/set-mode.applescript "Noise Cancellation"`.
3. Shortcut details (ⓘ) → **Add Keyboard Shortcut**.
4. Repeat for the other modes.

| Shortcut | Mode | Suggested hotkey |
|---|---|---|
| AirPods: Noise Cancellation | `"Noise Cancellation"` | `⌃⌥⌘N` |
| AirPods: Transparency | `"Transparency"` | `⌃⌥⌘T` |
| AirPods: Off | `"Off"` | `⌃⌥⌘O` |

On first run, grant **Shortcuts** Accessibility access in System Settings → Privacy & Security → Accessibility (needed to click the menu).
