#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
APP_DIR="/Applications/ClickUpRouter.app"

echo "Building ClickUpRouter.app..."
mkdir -p "${APP_DIR}/Contents/MacOS"
mkdir -p "${APP_DIR}/Contents/Resources"

cp "${SCRIPT_DIR}/Info.plist" "${APP_DIR}/Contents/Info.plist"
swiftc -O "${SCRIPT_DIR}/main.swift" -o "${APP_DIR}/Contents/MacOS/ClickUpRouter"

echo "ClickUpRouter.app built successfully at ${APP_DIR}."
