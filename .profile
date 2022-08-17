# Profile file. Runs on login. Environmental variables are set here.

# Adds `~/.local/bin` to $PATH
export PATH="$PATH:$(du "$HOME/.local/bin/" | cut -f2 | tr '\n' ':' | sed 's/:*$//')"
export PATH="$PATH:$HOME/.emacs.d/bin/"
export PATH="$PATH:/opt/context/tex/texmf-linux-64/bin"
export PATH="$PATH:/opt/texlive/2021/bin/x86_64-linux/"
export MANPATH="$MANPATH:/opt/texlive/2021/texmf-dist/doc/man/"
export INFOPATH="$INFOPATH:/opt/texlive/2021/texmf-dist/doc/info/"

# Default programs
export EDITOR="nvim"
export TERMINAL="kitty"
export BROWSER="qutebrowser"
export READER="evince"
export FILE="thunar"

# ~/ clean-up
export ZDOTDIR="$HOME/.config/zsh"
export PASSWORD_STORE_DIR="$HOME/.local/share/password-store"
export RUSTUP_HOME="\$HOME/.local/rustup"
export CARGO_HOME="\$HOME/.local/cargo"
export OPAMROOT="\$HOME/.local/opam"

# Other program settings
export FZF_DEFAULT_OPTS="--layout=reverse --height 40%"
export LESS=-R

# colorful man pages
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

[ ! -f ~/.config/shortcutrc ] && shortcuts >/dev/null 2>&1

export NO_AT_BRIDGE=1

# Source Proglangs
. "$CARGO_HOME/env"
eval $(opam config env)

