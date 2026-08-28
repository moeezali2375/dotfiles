# Browserino Configuration

This directory contains the configuration for [Browserino](https://github.com/AlexStrNik/Browserino) (macOS browser selector and URL routing app).

## Rules & Routing

- **ClickUp Deep Linking**: Any link containing `clickup` (such as `https://app.clickup.com/t/3692463/86exuzjbb` or inbox redirection links) is routed through `ClickUpRouter.app` (`browserino/ClickUpRouter/`), which converts the web URL into a `clickup://` native deep link to open the exact task directly in ClickUp.
- **Bayut / Dubizzle Work Links**: Any link containing `bayutuae` (such as `https://github.com/bayutuae/...`) automatically opens in the Google Chrome Work profile (`Profile 1` - `moeez.ali@dubizzlelabs.com`) via `Chrome (Work).app` (`browserino/ChromeWork/`).

## Browser Picker & Shortcuts

When opening unrouted links, Browserino prompts you to pick a browser:
- `G` / Click **Google Chrome**: Opens in the default/personal profile (`moeezali2375@gmail.com`).
- `W` / Click **Chrome (Work)**: Opens in the work profile (`moeez.ali@dubizzlelabs.com`).
- `S` / Click **Safari**: Opens in Safari.

## Commands

- **Export/Dump current config**:
  ```zsh
  browserino-dump
  ```
  *(Alias: `browser-reno-dump`)*
  Exports current `xyz.alexstrnik.Browserino` preferences to `browserino/xyz.alexstrnik.Browserino.plist` in XML format.

- **Import/Load config**:
  ```zsh
  browserino-load
  ```
  *(Alias: `browser-reno-load`)*
  Loads `browserino/xyz.alexstrnik.Browserino.plist` into macOS `defaults` and restarts Browserino.
