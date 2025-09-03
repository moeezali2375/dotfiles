# ------------------------------
# Powerlevel10k Instant Prompt
# Must stay at the very top of the file.
# ------------------------------
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ------------------------------
# Homebrew Setup (Cross-Platform for Intel & Apple Silicon)
# This block detects the correct Homebrew path and sets up the shell.
# The 'brew shellenv' command also exports $HOMEBREW_PREFIX, which we use later.
# ------------------------------
if [[ -x /opt/homebrew/bin/brew ]]; then
  # Path for Apple Silicon (M1, M2, M3, etc.)
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  # Path for Intel Macs
  eval "$(/usr/local/bin/brew shellenv)"
fi

# ------------------------------
# Environment Setup
# ------------------------------

# Zsh History Configuration
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# NVM (Node Version Manager)
# Loads NVM from the Homebrew-managed location.
export NVM_DIR="$HOME/.nvm"
if [[ -d "$HOMEBREW_PREFIX/opt/nvm" ]]; then
  [ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh"
  [ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm"
fi

# pyenv
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# ------------------------------
# Aliases
# ------------------------------
# Source custom aliases from a separate file.
[[ -f ~/.aliases.zsh ]] && source ~/.aliases.zsh

# ------------------------------
# Keybindings
# ------------------------------
bindkey -v # Use vi mode
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward
bindkey -M vicmd 'k' up-line-or-search
bindkey -M vicmd 'j' down-line-or-search


# ------------------------------
# Prompt / Theme
# ------------------------------
# Load Powerlevel10k theme if it exists.
if [[ -f "$HOMEBREW_PREFIX/share/powerlevel10k/powerlevel10k.zsh-theme" ]]; then
  source "$HOMEBREW_PREFIX/share/powerlevel10k/powerlevel10k.zsh-theme"
fi
# Load personal Powerlevel10k configuration.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh


# ------------------------------
# Plugins (must be last!)
# Loads plugins from their Homebrew-managed locations.
# ------------------------------
# Make sure you've installed it with: brew install zsh-vi-mode
if [[ -f "$HOMEBREW_PREFIX/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh" ]]; then
  source "$HOMEBREW_PREFIX/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh"
fi

if [[ -f "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
  source "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi
if [[ -f "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
  source "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi
