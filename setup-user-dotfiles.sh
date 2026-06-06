#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ARCH_SETUP="${ARCH_SETUP:-$SCRIPT_DIR}"

echo '[+] Dotfiles USER (stow only, sem merge VSCodium)...'
cd "$ARCH_SETUP/dotfiles"
stow -R -t ~ USER --adopt
cd "$SCRIPT_DIR"

FOLDERS_FILE="$HOME/wallpapers/folders.txt"
if [ ! -f "$FOLDERS_FILE" ]; then
  echo '[+] Criando ~/wallpapers/folders.txt (template)...'
  mkdir -p "$(dirname "$FOLDERS_FILE")"
  cat > "$FOLDERS_FILE" << 'EOF'
# Uma fonte por linha. Linhas com # são ignoradas.
#
# Pinterest (board público ou privado com login no Vivaldi):
# https://www.pinterest.com/usuario/nome-do-board/
#
# Pasta local:
# local:/caminho/absoluto/para/pasta
EOF
fi

echo '[+] USER dotfiles atualizados'
