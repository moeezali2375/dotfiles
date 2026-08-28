# Stats Configuration

This directory contains the configuration for [Stats](https://github.com/exelban/stats) (macOS system monitor in your menu bar).

## Commands

- **Export/Dump current config**:
  ```zsh
  stats-dump
  ```
  Exports current `eu.exelban.Stats` preferences to `stats/eu.exelban.Stats.plist` in XML format.

- **Import/Load config**:
  ```zsh
  stats-load
  ```
  Loads `stats/eu.exelban.Stats.plist` into macOS `defaults` and restarts Stats.
