# Thaw Configuration

This directory contains the configuration for [Thaw](https://github.com/stonerl/Thaw) (macOS menu bar manager).

## Commands

- **Export/Dump current config**:
  ```zsh
  thaw-dump
  ```
  Exports current `com.stonerl.Thaw` preferences to `thaw/com.stonerl.Thaw.plist` in XML format.

- **Import/Load config**:
  ```zsh
  thaw-load
  ```
  Loads `thaw/com.stonerl.Thaw.plist` into macOS `defaults` and restarts Thaw.
