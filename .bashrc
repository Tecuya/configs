PATH="$PATH:/usr/local/bin:$HOME/.local/bin:$HOME/bin:$HOME/.rvm/bin"

PS1='\u@\h:\w\$ '

# https://unix.stackexchange.com/questions/18212/bash-history-ignoredups-and-erasedups-setting-conflict-with-common-history
HISTCONTROL=ignoreboth
shopt -s histappend
export HISTSIZE=
export HISTFILESIZE=

TERM=xterm

if [ `uname` == "Linux" ]
then
    alias ls='LC_COLLATE=C ls --color=yes -F'
else
    alias ls='ls -FG'
    alias ec='/Applications/Emacs.app/Contents/MacOS/bin-x86_64-10_14/emacsclient -c -nw'
fi

alias k91='kill -9 %1'
alias ec='emacsclient -c'
alias iv='instavid'

[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

source $HOME/.bashrc.local
export PROMPT_COMMAND='history -a'
