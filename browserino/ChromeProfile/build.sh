#!/usr/bin/env bash
# Builds a Chrome profile launcher app from the shared main.swift.
# Usage: build.sh <dir-with-Info.plist> <App Name> <ExecutableName>
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLIST_DIR="$1"
APP_NAME="$2"
EXECUTABLE="$3"
APP_DIR="/Applications/${APP_NAME}.app"
CHROME_ICON="/Applications/Google Chrome.app/Contents/Resources/app.icns"

echo "Building ${APP_NAME}.app..."
mkdir -p "${APP_DIR}/Contents/MacOS"
mkdir -p "${APP_DIR}/Contents/Resources"

cp "${PLIST_DIR}/Info.plist" "${APP_DIR}/Contents/Info.plist"
if [ -f "${CHROME_ICON}" ]; then
    cp "${CHROME_ICON}" "${APP_DIR}/Contents/Resources/app.icns"
fi

swiftc -O "${SCRIPT_DIR}/main.swift" -o "${APP_DIR}/Contents/MacOS/${EXECUTABLE}"
codesign --force --sign - "${APP_DIR}"

# Re-register so LaunchServices / Browserino pick up plist changes.
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -f "${APP_DIR}"

echo "${APP_NAME}.app built successfully at ${APP_DIR}."
