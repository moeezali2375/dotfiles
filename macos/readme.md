# macOS System Preferences

This directory contains scripts and configurations for macOS system preferences and settings.

## Files

- `set-defaults.sh`: Shell script applying customized system defaults (Dock, Finder, Keyboard & CapsLock mapping, WindowManager, Trackpad, Screenshots with Device Name prefix, Clock).

## Commands

- **Apply system preferences**:
  ```zsh
  macos-apply
  ```
  Runs `~/dotfiles/macos/set-defaults.sh` and reloads affected services.
