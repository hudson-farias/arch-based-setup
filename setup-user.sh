#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

source "$SCRIPT_DIR/scripts/setup-packages.sh"

install_packages USER packages/user/pacman.txt pacman
ensure_yay
install_packages USER packages/user/aur.txt aur

echo '[+] Dotfiles USER...'
cd dotfiles
stow -t ~ USER --adopt
cd "$SCRIPT_DIR"

STORAGE="$HOME/.config/VSCodium/User/globalStorage/storage.json"
if [ ! -f "$STORAGE" ]; then
  echo '[+] Merging VSCodium profiles manifest...'
  "$HOME/scripts/merge-vscodium-profiles"
fi

echo '[+] ZSH setting...'
if [ ! -d ~/.oh-my-zsh ]; then
  git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-completions" ]; then
  git clone https://github.com/zsh-users/zsh-completions "$ZSH_CUSTOM/plugins/zsh-completions"
fi

echo '[+] Installing asdf plugins...'
. "$HOME/.asdf/asdf.sh"

asdf plugin-add nodejs || true
asdf plugin-add python || true
asdf plugin-add dotnet-core || true

if [ "$SHELL" != "$(which zsh)" ]; then
  chsh -s "$(which zsh)"
fi

echo '[+] USER setup finished'
echo '[+] To start zsh now, run: exec zsh'
