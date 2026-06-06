#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo '[+] Updating pacman...'
sudo pacman -Syu --noconfirm

"$SCRIPT_DIR/setup-root.sh"
"$SCRIPT_DIR/setup-user.sh"

echo '[+] Setup finished'
