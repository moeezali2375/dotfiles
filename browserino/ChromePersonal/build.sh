#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
"${SCRIPT_DIR}/../ChromeProfile/build.sh" "${SCRIPT_DIR}" "Chrome (Personal)" "ChromePersonal"
