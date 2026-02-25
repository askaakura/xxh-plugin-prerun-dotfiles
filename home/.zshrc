export PATH="$HOME/.local/bin:$HOME/bin:/usr/local/bin:$PATH"

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="amuse"

plugins=(
    alias-finder
    aws
    colored-man-pages
    colorize
    docker
    git
)

source "$ZSH/oh-my-zsh.sh"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(fzf --zsh)"
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

if command -v atuin &> /dev/null; then
    eval "$(atuin init zsh)"
fi

eval "$(zoxide init zsh)"

eval "$(starship init zsh)"

export MANPAGER="bat -plman"

alias k="kubectl"
alias j='jq -C'
alias gfa="git fetch --all"
alias gfp="gfa && ggpull"
alias dcoker="docker"
alias dokcer="docker"

alias bathelp='bat --plain --language=help'
help() {
    "$@" --help 2>&1 | bathelp
}

function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

if command -v eza &> /dev/null; then
    alias ls='eza --icons --group-directories-first'
    alias ll='eza -lh --icons --group-directories-first'
    alias la='eza -a --icons --group-directories-first'
    alias tree='eza --tree --icons'
fi

if [[ -n "$XXH_HOME" ]]; then
    mkdir -p $HOME_REAL/.config
    # Link Neovim
    [ ! -L "$HOME_REAL/.config/nvim" ] && ln -s "$HOME/.config/nvim" "$HOME_REAL/.config/nvim" 2>/dev/null
    # Link Yazi
    [ ! -L "$HOME_REAL/.config/yazi" ] && ln -s "$HOME/.config/yazi" "$HOME_REAL/.config/yazi" 2>/dev/null
fi

zstyle ':omz:plugins:alias-finder' autoload yes
zstyle ':omz:plugins:alias-finder' longer yes
zstyle ':omz:plugins:alias-finder' exact yes

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

autoload -Uz compinit && compinit
