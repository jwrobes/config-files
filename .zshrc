[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source "$HOME/workspace/dotfiles/dotfiles.sh"
export PATH=/opt/homebrew/opt/python@3.9/libexec/bin:$PATH


if [[ -e "/Applications/Visual Studio Code.app/Contents/Resources/app/bin" ]]; then
  export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
fi

# Aliases

# how to set up and track your config files easily
# https://www.atlassian.com/git/tutorials/dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

PATH="$PATH:/usr/local/opt/imagemagick@6/bin"
PATH="/opt/homebrew/opt/libpq/bin:$PATH"

. /usr/local/opt/asdf/libexec/asdf.sh

. /opt/homebrew/opt/asdf/libexec/asdf.sh
export PATH="$PATH:$(brew --prefix)/imagemagick@6/bin"
export PATH="$(brew --prefix)/opt/libpq/bin:$PATH"
