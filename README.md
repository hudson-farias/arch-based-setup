# arch-based-setup

Dotfiles e script de bootstrap para Arch Linux.

## Uso

```bash
git clone https://github.com/Hudson-Farias/arch-based-setup.git
cd arch-based-setup
./setup-arch.sh          # completo (root + user)
./setup-root.sh          # só sistema (pacotes ROOT + stow -t /)
./setup-user.sh          # só usuário (pacotes USER + stow -t ~)
```

## Dotfiles de usuário (`dotfiles/USER/`)

- `.zshrc` — Oh My Zsh, asdf, syntax highlighting
- `scripts/` — `init-python`, `init-dotnet`, `sync-wallpapers` e completions zsh
- `wallpapers/` — diretório para config local (`folders.txt`, criado no setup)
- `.config/VSCodium/User/` — settings, keybindings, snippets e profiles
- `.config/Cursor/User/` — settings

Implantação via GNU Stow (`stow -t ~ USER --adopt`).

## Dotfiles de sistema (`dotfiles/ROOT/`)

- `etc/pacman.conf` — config do pacman
- `etc/sddm.conf.d/theme.conf` — tema SDDM lain-wired
- `usr/share/` — temas KDE (Sweet, Breeze Chameleon Dark, etc.)

Implantação via GNU Stow (`sudo stow -t / ROOT --adopt`) — vale para **qualquer usuário**.

## Pacotes (`packages/`)

Separados por escopo — **ROOT** (sistema, qualquer usuário) e **USER** (por usuário):

```
packages/
├── root/   pacman.txt + aur.txt   → dotfiles/ROOT (stow -t /)
└── user/   pacman.txt + aur.txt   → dotfiles/USER (stow -t ~)
```

Um pacote por linha; linhas com `#` são ignoradas.

## Wallpapers

O `setup-user.sh` cria `~/wallpapers/folders.txt` (template) na primeira instalação — arquivo local, não versionado.

1. Edite `~/wallpapers/folders.txt` (Pinterest ou `local:/caminho`)
2. Rode `sync-wallpapers` — baixa em `/tmp/wallpapers-sync`, substitui `~/.local/share/wallpapers/<slug>/`
3. Pins removidos somem após sync (pasta destino é trocada inteira)

Depende de `gallery-dl` (AUR). Boards privados usam cookies do Vivaldi.
