ZSH_DISABLE_COMPFIX=true

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell" # See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
plugins=(git zsh-autosuggestions zsh-completions asdf)

fpath=(~/scripts/completions ~/.zsh/completions $fpath)

export PATH="$HOME/scripts:$PATH"

source $ZSH/oh-my-zsh.sh

if [ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

. "$HOME/.asdf/asdf.sh"

autoload -Uz compinit
compinit

export PATH=$PATH:/opt/rocm/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/rocm/lib
