# ------------------------------
# Powerlevel10k Instant Prompt
# Must stay at the very top
# ------------------------------
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ------------------------------
# Homebrew setup (Intel + M1/M2/M3)
# ------------------------------
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"   # Apple Silicon
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"      # Intel
fi

BREW_PREFIX="$(brew --prefix 2>/dev/null)"

# ------------------------------
# Prompt / Theme
# ------------------------------
if [[ -f "$BREW_PREFIX/opt/powerlevel10k/powerlevel10k.zsh-theme" ]]; then
  source "$BREW_PREFIX/opt/powerlevel10k/powerlevel10k.zsh-theme"
fi
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

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

# NVM (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
if [[ -d "$BREW_PREFIX/opt/nvm" ]]; then
  [ -s "$BREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$BREW_PREFIX/opt/nvm/nvm.sh"
  [ -s "$BREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$BREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm"
fi

# ------------------------------
# Aliases
# ------------------------------
[[ -f ~/.aliases.zsh ]] && source ~/.aliases.zsh

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
if [[ -f "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
  source "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi
if [[ -f "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
  source "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi
