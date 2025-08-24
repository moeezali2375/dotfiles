# ------------------------------
# Powerlevel10k Instant Prompt
# Must stay at the very top
# ------------------------------
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ------------------------------
# Environment Setup
# ------------------------------

# History
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# Paths
export NVM_DIR="$HOME/.nvm"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$HOME/go/bin:$HOME/.local/share/nvim/mason/bin:$PATH"

# Extra PATHs (macOS Postgres, Cryptex, etc.)
PATH=/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH

# NVM + Pyenv
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# ------------------------------
# Aliases
# ------------------------------
[[ -f ~/.aliases.zsh ]] && source ~/.aliases.zsh

# ------------------------------
# Prompt / Theme
# ------------------------------
source /usr/local/share/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# ------------------------------
# Keybindings
# ------------------------------
bindkey -v
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward
bindkey -M vicmd 'k' up-line-or-search
bindkey -M vicmd 'j' down-line-or-search

# ------------------------------
# Plugins (must be last!)
# ------------------------------
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
