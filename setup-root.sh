#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

source "$SCRIPT_DIR/scripts/setup-packages.sh"

install_packages ROOT packages/root/pacman.txt pacman
ensure_yay
install_packages ROOT packages/root/aur.txt aur

echo '[+] Dotfiles ROOT (sistema)...'
cd dotfiles
sudo stow -t / ROOT --adopt
cd "$SCRIPT_DIR"

echo '[+] ROOT setup finished'
