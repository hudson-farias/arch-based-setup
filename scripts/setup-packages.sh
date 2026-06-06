install_packages() {
  local label=$1 file=$2 manager=$3
  local -a packages
  mapfile -t packages < <(grep -vE '^\s*(#|$)' "$file")
  (( ${#packages[@]} )) || return 0
  echo "[+] Installing ${label} ${manager} packages..."
  if [ "$manager" = pacman ]; then
    sudo pacman -S --noconfirm "${packages[@]}"
  else
    yay -S --noconfirm "${packages[@]}"
  fi
}

ensure_yay() {
  if command -v yay >/dev/null; then
    return 0
  fi
  echo '[+] Installing yay (AUR helper)...'
  cd /tmp
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si --noconfirm
  cd "$SCRIPT_DIR"
}
