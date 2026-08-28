#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
APP_DIR="/Applications/Chrome (Work).app"

echo "Building Chrome (Work).app..."
mkdir -p "${APP_DIR}/Contents/MacOS"
mkdir -p "${APP_DIR}/Contents/Resources"

cp "${SCRIPT_DIR}/Info.plist" "${APP_DIR}/Contents/Info.plist"
if [ -f "/Applications/Google Chrome.app/Contents/Resources/app.icns" ]; then
    cp "/Applications/Google Chrome.app/Contents/Resources/app.icns" "${APP_DIR}/Contents/Resources/app.icns"
fi

swiftc -O "${SCRIPT_DIR}/main.swift" -o "${APP_DIR}/Contents/MacOS/ChromeWork"

echo "Chrome (Work).app built successfully at ${APP_DIR}."
