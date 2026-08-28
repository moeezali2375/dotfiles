# Shortcat Configuration

This directory contains the configuration for [Shortcat](https://shortcat.app) (keyboard-driven macOS UI navigation).

## Commands

- **Export/Dump current config**:
  ```zsh
  shortcat-dump
  ```
  Exports current `com.sproutcube.Shortcat` preferences to `shortcat/com.sproutcube.Shortcat.plist` in XML format.

- **Import/Load config**:
  ```zsh
  shortcat-load
  ```
  Loads `shortcat/com.sproutcube.Shortcat.plist` into macOS `defaults` and restarts Shortcat.
