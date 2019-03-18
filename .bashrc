PATH="$PATH:/usr/local/bin:$HOME/bin:$HOME/.rvm/bin"

PS1='\u@\h:\w\$ '

# https://unix.stackexchange.com/questions/18212/bash-history-ignoredups-and-erasedups-setting-conflict-with-common-history
HISTCONTROL=ignoreboth
shopt -s histappend
export HISTSIZE=
export HISTFILESIZE=
export PROMPT_COMMAND='history -a'

VISUAL='emacsclient'
EDITOR='emacsclient'

TERM=xterm

alias jf="$HOME/jingle/Jingle/tools/run/jfind"
jfg () {
    OLDPWD=$(pwd)
    cd ~/jingle/Jingle
    export PATTERN="$1"
    shift
    FILES=$( tools/run/jfind $PATTERN )
    if [ -z "$FILES" ]
    then
        echo 'No match.'
        return
    fi
    grep -Hni $* $PATTERN $( echo $FILES )
    cd "$OLDPWD"
}

if [ `uname` == "Linux" ]
then
    alias ls='LC_COLLATE=C ls --color=yes -F'
else
    alias ls='ls -FG'
    alias ec='/Applications/Emacs.app/Contents/MacOS/bin/emacsclient -n'
    alias eq='/Applications/Emacs.app/Contents/MacOS/bin/emacsclient -tty -q'
fi
    
alias k91='kill -9 %1'

export ORACLE_HOME=$HOME/opt/instantclient_12_1
export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:$ORACLE_HOME
export PYTHONIOENCODING='utf-8'

[ -e .bashrc.local ] && source .bashrc.local

[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh
