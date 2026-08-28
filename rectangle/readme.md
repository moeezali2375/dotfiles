# Rectangle Configuration

This directory contains the configuration for [Rectangle](https://github.com/rxhanson/Rectangle) (macOS window management app).

## Commands

- **Export/Dump current config**:
  ```zsh
  rectangle-dump
  ```
  Exports current `com.knollsoft.Rectangle` preferences to `rectangle/com.knollsoft.Rectangle.plist` in XML format.

- **Import/Load config**:
  ```zsh
  rectangle-load
  ```
  Loads `rectangle/com.knollsoft.Rectangle.plist` into macOS `defaults` and restarts Rectangle.
