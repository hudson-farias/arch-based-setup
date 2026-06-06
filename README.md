# arch-based-setup

Dotfiles e script de bootstrap para Arch Linux.

## Uso

```bash
git clone https://github.com/Hudson-Farias/arch-based-setup.git
cd arch-based-setup
./setup-arch.sh
```

## Dotfiles de usuário (`dotfiles/USER/`)

- `.zshrc` — Oh My Zsh, asdf, syntax highlighting
- `scripts/` — `init-python`, `init-dotnet` e completions zsh
- `.config/VSCodium/User/` — settings, keybindings, snippets e profiles
- `.config/Cursor/User/` — settings

Implantação via GNU Stow (`stow -t ~ USER --adopt`).

## Pacotes (`packages/`)

- `packages/pacman.txt` — pacotes do repositório oficial
- `packages/aur.txt` — pacotes AUR (via yay)
