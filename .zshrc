# PATH
export PATH=$HOME/bin:/usr/local/bin:$PATH

if [ -d $HOME/dotfiles ]; then
  export DOTFILES=$HOME/dotfiles
else
  if [ -d $HOME/prateek-dotfiles ]; then
    export DOTFILES=$HOME/prateek-dotfiles
  else
    export DOTFILES=$HOME
  fi
fi

# prompt stolen from http://pthree.org/2009/03/28/add-vim-editing-mode-to-your-zsh-prompt/
. $DOTFILES/.zsh/.prompt

## Vim inner word key bindings
. $DOTFILES/.zsh/opp.zsh/opp.zsh
. $DOTFILES/.zsh/opp.zsh/opp/*.zsh

# git-aliases
. $DOTFILES/.zsh/.git_aliases

# hub alias
eval "$(hub alias -s)"

# source zsh file completions
fpath=($HOME/.zsh/func /usr/local/share/zsh/site-functions $fpath)
typeset -U fpath

# ipython
alias ip='ipython qtconsole --pylab=inline'
alias ipn="ipython notebook $HOME/trash/notebooks"
export PYTHONPATH=/usr/local/lib/python2.7/site-packages:

# enable color support of ls and also add handy aliases
## colorize ls
if [ -x /usr/local/bin/gdircolors ]  && [ -s $HOME/.dir_colors ]; then
  eval `gdircolors $HOME/.dir_colors`
  alias ls='gls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

if [ -x /usr/bin/dircolors ]; then
    test -r $HOME/dircolors && eval "$(dircolors -b $HOME/dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

## colorize completions
zstyle ':completion:*' list-colors ''
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# aliases
alias quit='exit'
alias vimd='vim -d'
alias psef='ps -ef | grep -i '

# bindings
bindkey -v # Vim bindings for zsh
# zsh key timeout
export KEYTIMEOUT=1

# need to start using caps instead of jj
bindkey -Mviins 'ii' vi-cmd-mode # jj map to esc

# History options
HISTFILE=$HOME/.zhistory       # enable history saving on shell exit
setopt APPEND_HISTORY          # append rather than overwrite history file.
HISTSIZE=10000                  # lines of history to maintain memory
SAVEHIST=100000                  # lines of history to maintain in history file.
setopt HIST_EXPIRE_DUPS_FIRST  # allow dups, but expire old ones when I hit HISTSIZE
setopt EXTENDED_HISTORY        # save timestamp and runtime information

# Maven repo setup
# from http://coe4bd.github.io/HadoopHowTo/hadoopMaven/hadoopMaven.html
export M2_REPO=$HOME/.m2/repository

# create new mr maven job
# stolen from github.com/patrickangeles/cdh-maven-archetype
# mvn archetype:generate -DarchetypeCatalog=http://repository.cloudera.com/archetype-catalog.xml

# zsh completion -- needs to be after autojump!
autoload -U compinit && compinit

zstyle ':completion:*' menu select
setopt correctall
compctl -g '*(/)' rmdir dircmp j
compctl -g '*(-/)' cd chdir dirs pushd j
compinit

# one tab for completion
setopt nolistambiguous

# convenient stuff
autoload zmv
setopt autocd
setopt extendedglob

# colorized man
man() {
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
}

# tmux color
alias tmux="TERM=screen-256color-bce tmux -2"

# stackoverflow in commandline
alias h='howdoi --color'

# http://www.drbunsen.org/the-text-triumvirate/#tmux
bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward
bindkey '^P' history-search-backward
bindkey '^N' history-search-forward

# syntax highlight
# LESSPIPE=`which src-hilite-lesspipe.sh`
# export LESSOPEN="| ${LESSPIPE} %s"
# export LESS='-R'
