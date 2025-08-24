
# Navigation
alias cdd="cd ~/Developer/dubizzle/"
alias cdn="cd ~/Developer/novasoft/"


# LS / File ops
alias ll="ls -alF"
alias la="ls -A"
alias l="ls -CF"

# Neovim
alias astro-nvim='NVIM_APPNAME=astro-nvim nvim'

# Gitignore generator
gi() { curl -sLw "\n" "https://www.toptal.com/developers/gitignore/api/$@" ; }
