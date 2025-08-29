
# Navigation
alias cdd="cd ~/Developer/dubizzle/"
alias cdn="cd ~/Developer/novasoft/"


# LS / File ops
alias ll="ls -alF"
alias la="ls -A"
alias l="ls -CF"

# Neovim
alias astro-nvim='NVIM_APPNAME=astro-nvim nvim'

# brew
alias brew-dump='brew bundle dump --file=~/dotfiles/brew/.Brewfile --force --no-vscode'
alias brew-install='brew bundle --file=~/dotfiles/brew/.Brewfile --force'

# Gitignore generator
gi() { curl -sLw "\n" "https://www.toptal.com/developers/gitignore/api/$@" ; }
