
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
alias brew-dump='brew bundle dump --file=~/dotfiles/brew/Brewfile --force --no-vscode'
alias brew-install='brew bundle --file=~/dotfiles/brew/Brewfile --force'

# stats
alias stats-dump='defaults export eu.exelban.Stats ~/dotfiles/stats/eu.exelban.Stats.plist && plutil -convert xml1 ~/dotfiles/stats/eu.exelban.Stats.plist'
alias stats-load='defaults import eu.exelban.Stats ~/dotfiles/stats/eu.exelban.Stats.plist && killall Stats 2>/dev/null; open -a Stats'

# rectangle
alias rectangle-dump='defaults export com.knollsoft.Rectangle ~/dotfiles/rectangle/com.knollsoft.Rectangle.plist && plutil -convert xml1 ~/dotfiles/rectangle/com.knollsoft.Rectangle.plist'
alias rectangle-load='defaults import com.knollsoft.Rectangle ~/dotfiles/rectangle/com.knollsoft.Rectangle.plist && killall Rectangle 2>/dev/null; open -a Rectangle'

# browserino
alias browserino-dump='defaults export xyz.alexstrnik.Browserino ~/dotfiles/browserino/xyz.alexstrnik.Browserino.plist && plutil -convert xml1 ~/dotfiles/browserino/xyz.alexstrnik.Browserino.plist'
alias browserino-load='[ -d /Applications/ClickUpRouter.app ] || ~/dotfiles/browserino/ClickUpRouter/build.sh; [ -d "/Applications/Chrome (Work).app" ] || ~/dotfiles/browserino/ChromeWork/build.sh; defaults import xyz.alexstrnik.Browserino ~/dotfiles/browserino/xyz.alexstrnik.Browserino.plist && killall Browserino 2>/dev/null; open -a Browserino'

# maccy
alias maccy-dump='defaults export org.p0deje.Maccy ~/dotfiles/maccy/org.p0deje.Maccy.plist && plutil -convert xml1 ~/dotfiles/maccy/org.p0deje.Maccy.plist'
alias maccy-load='defaults import org.p0deje.Maccy ~/dotfiles/maccy/org.p0deje.Maccy.plist && killall Maccy 2>/dev/null; open -a Maccy'

# thaw
alias thaw-dump='defaults export com.stonerl.Thaw ~/dotfiles/thaw/com.stonerl.Thaw.plist && plutil -convert xml1 ~/dotfiles/thaw/com.stonerl.Thaw.plist'
alias thaw-load='defaults import com.stonerl.Thaw ~/dotfiles/thaw/com.stonerl.Thaw.plist && killall Thaw 2>/dev/null; open -a Thaw'

# shortcat
alias shortcat-dump='defaults export com.sproutcube.Shortcat ~/dotfiles/shortcat/com.sproutcube.Shortcat.plist && plutil -convert xml1 ~/dotfiles/shortcat/com.sproutcube.Shortcat.plist'
alias shortcat-load='defaults import com.sproutcube.Shortcat ~/dotfiles/shortcat/com.sproutcube.Shortcat.plist && killall Shortcat 2>/dev/null; open -a Shortcat'


# Gitignore generator
gi() { curl -sLw "\n" "https://www.toptal.com/developers/gitignore/api/$@" ; }

#git
alias gs='git status'


