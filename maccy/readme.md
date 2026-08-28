# Maccy Configuration

This directory contains the configuration for [Maccy](https://github.com/p0deje/Maccy) (macOS clipboard manager).

## Commands

- **Export/Dump current config**:
  ```zsh
  maccy-dump
  ```
  Exports current `org.p0deje.Maccy` preferences to `maccy/org.p0deje.Maccy.plist` in XML format.

- **Import/Load config**:
  ```zsh
  maccy-load
  ```
  Loads `maccy/org.p0deje.Maccy.plist` into macOS `defaults` and restarts Maccy.
