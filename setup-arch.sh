#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo '[+] Updating pacman...'
sudo pacman -Syu --noconfirm

echo '[+] Installing pacman packages...'
grep -vE '^\s*(#|$)' packages/pacman.txt | xargs -r sudo pacman -S --noconfirm --

echo '[+] Installing yay (AUR helper)...'
if ! command -v yay >/dev/null; then
  cd /tmp
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si --noconfirm
  cd "$SCRIPT_DIR"
fi

echo '[+] Installing AUR packages...'
grep -vE '^\s*(#|$)' packages/aur.txt | xargs -r yay -S --noconfirm --

echo '[+] Dotfiles setting...'
cd dotfiles
sudo stow -t / ROOT --adopt
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

echo '[+] Setup finished'
if [ "$SHELL" != "$(which zsh)" ]; then
  chsh -s "$(which zsh)"
fi
echo '[+] To start zsh now, run: exec zsh'
