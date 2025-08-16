[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
#source "$HOME/workspace/dotfiles/dotfiles.sh"
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

#. /usr/local/opt/asdf/libexec/asdf.sh

#. /opt/homebrew/opt/asdf/libexec/asdf.sh
export PATH="$PATH:$(brew --prefix)/imagemagick@6/bin"
export PATH="$(brew --prefix)/opt/libpq/bin:$PATH"

# Git branch function
git_branch() {
    local branch
    if git rev-parse --git-dir > /dev/null 2>&1; then
        branch=$(git symbolic-ref --short HEAD 2>/dev/null || git describe --tags --exact-match 2>/dev/null || git rev-parse --short HEAD 2>/dev/null || echo "unknown")
        if [[ -n $branch ]]; then
            echo " %{$fg[yellow]%}($branch)%{$reset_color%}"
        fi
    fi
}

# Enhanced prompt with git branch and better path display
autoload -U colors && colors
setopt PROMPT_SUBST
PS1='%{$fg[green]%}%n%{$reset_color%}@%{$fg[blue]%}%m%{$reset_color%} %{$fg[cyan]%}%~%{$reset_color%}$(git_branch) %{$fg[white]%}$%{$reset_color%} '

# Load private environment variables (not tracked in git)
if [ -f ~/.env.local ]; then
    source ~/.env.local
fi


. /opt/homebrew/opt/asdf/libexec/asdf.sh
