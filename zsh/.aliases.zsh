
# Navigation
alias cddo="cd ~/dotfiles/"
alias cdd="cd ~/Developer/dubizzle/"
alias cdn="cd ~/Developer/novasoft/"


# LS / File ops
alias ll="ls -alF"
alias la="ls -A"
alias l="ls -CF"
alias c="clear"

# Neovim
alias astro-nvim='NVIM_APPNAME=astro-nvim nvim'

# brew
alias brew-dump='brew bundle dump --file=~/dotfiles/brew/.Brewfile --force --no-vscode'
alias brew-install='brew bundle --file=~/dotfiles/brew/.Brewfile --force'

# Gitignore generator
gi() { curl -sLw "\n" "https://www.toptal.com/developers/gitignore/api/$@" ; }

#AWS
alias aws="ssh -i ~/.keys/Moeez-Ali-V3.pem ubuntu@ec2-16-171-138-184.eu-north-1.compute.amazonaws.com"
alias aws4="ssh -i ~/.keys/Moeez-Ali-V4.pem ubuntu@ec2-13-51-200-194.eu-north-1.compute.amazonaws.com"

