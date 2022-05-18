[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source "$HOME/workspace/dotfiles/dotfiles.sh"

if [[ -e "/Applications/Visual Studio Code.app/Contents/Resources/app/bin" ]]; then
  export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
fi

echo -e "\n. $(brew --prefix asdf)/libexec/asdf.sh" >> ${ZDOTDIR:-~}/.zshrc

# Aliases

# how to set up and track your config files easily
# https://www.atlassian.com/git/tutorials/dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

. /usr/local/opt/asdf/libexec/asdf.sh

. /usr/local/opt/asdf/libexec/asdf.sh

. /usr/local/opt/asdf/libexec/asdf.sh

. /usr/local/opt/asdf/libexec/asdf.sh

. /usr/local/opt/asdf/libexec/asdf.sh

. /usr/local/opt/asdf/libexec/asdf.sh
PATH="$PATH:/usr/local/opt/imagemagick@6/bin"
PATH="/opt/homebrew/opt/libpq/bin:$PATH"

. /usr/local/opt/asdf/libexec/asdf.sh

. /usr/local/opt/asdf/libexec/asdf.sh

. /usr/local/opt/asdf/libexec/asdf.sh
